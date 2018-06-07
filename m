Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8653D1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 07:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbeFGHlv (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 03:41:51 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33035 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeFGHlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 03:41:50 -0400
Received: by mail-ua0-f193.google.com with SMTP id m21-v6so5862657uan.0
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RTWw6AkCU45Z0Kr0ahT/DpTwJGEgNIfmTjsOewAWlT0=;
        b=P4h5y4+whkzsuI8MVRMoA4LF7pOzEs5Gd3uPGnJ/fdTRC2oKCtryt5P6Wy8uH6Atxg
         OZb2yjPNTKVl5ooWkO/xfbXhn3NWekyHslVzkh4wMx+C2S9tqa1ZFWKy6+B90eq8VLWc
         JctL9QcfPrAednF5BTn5b3NUAgSNT6DvJEA/SOJbFuimZMb+GwvJ13Fc9jcujoOn3AIx
         isKcULz7nkmXctjzXyiLm8nM7mI36tWORC7/1AOqmwSJG+NJkXgFcV5P8YqYeo2mTonJ
         5hehksuQNPwvv0+6s/3oiDes8bdASWfmILlFaWLzi8O4M+jD9d7sQqAXTApqBkefmte6
         vfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RTWw6AkCU45Z0Kr0ahT/DpTwJGEgNIfmTjsOewAWlT0=;
        b=Zr9JdIbDSWVUvttTYMMOYRvQ5g4S+2B6YVCg5+3tUbM1hglUvlQhWl9ly5j5x0PD3O
         ifDzwSSlyjbmV+WrxptyI37eOsEEhp/4A6+NcJr79hu4z0B8X7P4n8kWQ6s89shFnL35
         rfolMXQL/2kqPr8Jb/AocrzMthyb2KufZQVLOCi1psrar2L4xDL61m1UDpkDY9jn1qfb
         5GiWTXXify3imIYUs3ISnkr3RHtQDBoMHCrvLYE+qom1Vpl2O2t31REjrIgPq1Bfwt+q
         5azscuDJP0bDsPTDKfVEYOY/6/bnJstHKGOBfbYc6Pl50vkznAVzUjQ8MNzZXeuBpfN/
         5afg==
X-Gm-Message-State: APt69E19v73XGJCzf3/2+Qfuv2DEhwrctg7TcjY5AWtO+nlHgal62PrX
        McAlFNB4xEGu6CZsdmmVzgT291TIVqwApZbZ767waw==
X-Google-Smtp-Source: ADUXVKLmw8PCg1i1RPHT8hsivDQ8FKvdSoWnAnCRFxRbMhQWiqMGr+hVrhJlEb5UItQ9M3qPuwFT3q4ACwfF9nmISyo=
X-Received: by 2002:ab0:4c82:: with SMTP id y2-v6mr519734uaf.94.1528357309730;
 Thu, 07 Jun 2018 00:41:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 00:41:49 -0700 (PDT)
In-Reply-To: <20180606165016.3285-5-pclouds@gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
 <20180606165016.3285-5-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Jun 2018 00:41:49 -0700
Message-ID: <CABPp-BFzOkX_uSyiVH-S8mqxeOin0xcYR-EzXUtvcdN7dGhidQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/23] unpack-tress: convert clear_ce_flags* to avoid the_index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject line: unpack-trees rather than unpack-tress.



On Wed, Jun 6, 2018 at 9:49 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> Prior to fba92be8f7, this code implicitly (and incorrectly) assumes
> the_index when running the exclude machinery. fba92be8f7 helps show
> this problem clearer because unpack-trees operation is supposed to
> work on whatever index the caller specifies... not specifically
> the_index.
>
> Update the code to use "istate" argument that's originally from
> mark_new_skip_worktree(). From the call sites, both in unpack_trees(),
> you can see that this function works on two separate indexes:
> o->src_index and o->result. The second mark_new_skip_worktree() so far
> has incorecctly applied exclude rules on o->src_index instead of
> o->result. It's unclear what is the consequences of this, but it's
> definitely wrong.
>
> [1] fba92be8f7 (dir: convert is_excluded_from_list to take an index -
>     2017-05-05)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

A somewhat curious finding: when I was rebuilding and re-testing all
23 patches, I got a failure on this patch in test 31 of
t7063-status-untracked-cache.sh. I did not get any test failures with
any of the other patches.  However, after re-running that test or the
whole suite half a dozen times with just up to this patch applied, I
was not able to trigger the failure again.  Is there a rare race in
that testcase?  I certainly don't see anything in this patch that
appears problematic, and the fact that I couldn't readily reproduce
suggests it could well have been there before any of these patches.

Everything else in the patch looks fine to me.
