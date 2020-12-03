Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF57C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2908D206F6
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgLCP0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgLCP0j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 10:26:39 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A65C061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 07:25:53 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id x16so4025951ejj.7
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 07:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=34GzWasZrvFvGpYOrj7Pq673j8chZqB6uYv411jpsZQ=;
        b=VJ1NxGHMwiMiamlp7wF4vm0nO0UCSTZNnYZwy8XcMgY8FEG6se/cRc6JigKGGlQmq3
         z2ymyp+7lGxiifnAWo2d3tJrhjIACg0b9VSiFKx6OeIfFoEdMjaTe/Rh5EMD7DCqxmfJ
         Y2teqD+fXCIPElLFgmFglktI4HupfcmiE3O3sXzxjNINl6PPuSIw9AJHcgy/eeHSDg7D
         APKMYnyQaciyKVd+TWtUcvVSX+8pYHFOlu55br20/IBwcTd5VT93MN1lpeN/10ETx58I
         gBqhRUcLvAlNqTkwgpxjApD40+YHcnjcx1wzzzuP1d68ElduZZf3ygSmDgmQ1W/BDXO7
         UJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=34GzWasZrvFvGpYOrj7Pq673j8chZqB6uYv411jpsZQ=;
        b=EGKXqFc/IzlRARD8hgzDAkZ7Mx+ARqX8LfMlyDwZdVMl8BdvOh7xj7ScU27+YR4Jei
         PKqv7JqyYOPwO8Ko/EkjXziyJAlBPkzSpgmLKNu+kDgr8vAKlsre7/JN+hRdXv6cO89B
         fdY9dvA8Xt6MIANfbOo5aXE1MdPs/lSST7TRmcfQEQ5rIkZPRPi1p7wIPobqQlOI7rOC
         +89pu2iteHitBRtjcJ4MmtvGiZnmKvl/JxUy62b6Z8xq3qHFMdSLvDjor5+Kg28G1Lqp
         VclZNbutXnk76stPmwN9WSZYD1S1kiqq2iYHyCAqb5Qvqc9o8gmuQgxEbSy3Z7PdDRms
         HWmw==
X-Gm-Message-State: AOAM530vtNrnBCP8o3xWMCRxkjdQG4OpCuRWj4HElbnt78FCZ3AxHwSp
        fWvGuOiWuS5dh1cp0Ex4O8Lwm4clE/Q5CrKZIMQ=
X-Google-Smtp-Source: ABdhPJyM9qRFifUooGLx1ucc2YDr4/7CYRQTGNvWH52PVOcu34YIhPksn/nQOxfTXhszUM+2Sm4HkOYb2VreOCQuXDM=
X-Received: by 2002:a17:906:d72:: with SMTP id s18mr3039211ejh.110.1607009152109;
 Thu, 03 Dec 2020 07:25:52 -0800 (PST)
MIME-Version: 1.0
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
 <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com> <xmqqzh2vkdu8.fsf@gitster.c.googlers.com>
 <04968f5c-c8bd-c57e-d646-7c9f7691e1a8@nokia.com>
In-Reply-To: <04968f5c-c8bd-c57e-d646-7c9f7691e1a8@nokia.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Date:   Thu, 3 Dec 2020 10:25:40 -0500
Message-ID: <CADtb9DxTgEWfOF7jDGGt3eQSCaaqeiyJfS4V-e0SyPenE2SXWA@mail.gmail.com>
Subject: Re: BUG in fetching non-checked out submodule
To:     =?UTF-8?Q?Peter_K=C3=A4stle?= <peter.kaestle@nokia.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Peter,

Le jeu. 3 d=C3=A9c. 2020, =C3=A0 02 h 54, Peter K=C3=A4stle <peter.kaestle@=
nokia.com> a =C3=A9crit :
>
> Hi,
>
> On 03.12.20 00:06, Junio C Hamano wrote:
> > Philippe Blain <levraiphilippeblain@gmail.com> writes:
> >
> >> Thanks for bisecting it. That commit wanted to fix a different bug
> >> related to nested submodules, and the route taken was simply
> >> reverting an earlier commit (a62387b (submodule.c: fetch in
> >> submodules git directory instead of in worktree, 2018-11-28).
> >>
> >> As you discovered, it breaks other scenarios.
> >>
> >>>
> >>> $ git version
> >>> git version 2.29.2.435.g72ffeb997e
> >>>
> >>> $ git config --get submodule.recurse
> >>> true
> >
> > I think the current situation is probably worse.
> >
> > As a short-term fix, we should revert 1b7ac4e6d4 until we can come
> > up with a real fix, probably.
>
> Junio: This is why I originally intended to commit the test case for the
> testsuite separated from the revert and wanted to start a discussion
> about the actual real fix for the issue:
> https://public-inbox.org/git/1604413399-63090-1-git-send-email-peter.kaes=
tle@nokia.com/
>
> My proposal would be to revert 1b7ac4e6d4 and isolate the test case
> "test_expect_success 'setup nested submodule fetch test' '" make it
> "test_expect_failure" and apply it instead, until we come up with a real
> solution.


I think I have the real solution. I did some debugging and I think it
is quite easy:
In 'get_next_submodule', 'get_submodule_repo_for(spf->r, task->sub)'
fails to get a repo pointer for the submodule repository, since it is
not initialized. That
is normal. Then we go in the "else" branch, and hit this code:

/*
* An empty directory is normal,
* the submodule is not initialized
*/
if (S_ISGITLINK(ce->ce_mode) &&
!is_empty_dir(ce->name)) {

'is_empty_dir' receives ce->name, but the current working directory is the
Git directory of 'middle', so clearly is_empty_dir returns false, as

/path/to/git/t/trash
directory.t5526-fetch-submodules/B/.git/modules/middle/inner

is a non-existent path. The path that we should send is the worktree
of inner, ie.
the concatenation of spf->r->worktree and ce->name. This would give

/path/to/git/t/trash directory.t5526-fetch-submodules/B/middle/inner,

which is an empty directory since the inner submodule is not initialized,
and we would not get the "Could not access submodule inner" error
that you wanted to solve.


Cheers,

Philippe.
