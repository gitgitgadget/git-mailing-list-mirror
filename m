Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F9B2095B
	for <e@80x24.org>; Mon, 20 Mar 2017 12:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754216AbdCTMbU (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 08:31:20 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:34717 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbdCTMbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 08:31:18 -0400
Received: by mail-ot0-f180.google.com with SMTP id o24so130628721otb.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yx6obwpHNjwlnTn+zJ1NvEEw2/LjYn0ZQBreyCduxLk=;
        b=k45ajg+rPq/naLCS2DNywd8ipauEinFiwwpfW5+fGRMilvVNKaz9Di4jdjos3fddnM
         rOrjgmVvv42+qcVLUBo+XnAJKQrTGXorTzTfzpUEOXPZXtxCpm+RhObFEkW5P0DYeMEk
         A/H7LKYbL8xfgbbqr9KJJiE85BEWXhhGLAFI0k/t4Z+TPzYdGvprnACGPNgrIGAUxBec
         qJ+cXkWnopkUVoAbL3qpebe0Ns7VrEwMD+DdAcMUwNW8BZh7FF9zYnSuA3Xp5AiIbCl5
         aDvwPweJV0NUCoQsTtJgB75WtNrRFUH+6TpVwfWuQ90vJWGp+DPOjW+WRxWOEyoKPcXm
         QdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yx6obwpHNjwlnTn+zJ1NvEEw2/LjYn0ZQBreyCduxLk=;
        b=kOOK1bGLPSjVpjBa1O2WtTQ91JZHyDM/LcWYLvXbiZ1a0o9NBNhAhuI5HNg5hN/6cN
         8XLKgYpccoyyfR0dyxiFW8yCrlKGYy77HiNmOFi3knE1U9eM4r7Qce6bzXZQC/wpl3iR
         BeRtTbbrfkDLqPYjsWEWCAh+rgnNZID4JWrd8kn2DR6Z3tnqD9R2Hfq3DcXFYMeJ0Udu
         sOPNzdLfIvBSwvD/SqaQjo8Prs9Yw6ptL1lh4eLC/03jWWUjziDaqA2smGXhPIc/vY0O
         DReRaN/gtQjRJbQ1F1PS5fOa1eOpIoSpyFOl9EiIvmVb02K6Ii2TSToNpAUPZItuFy9w
         mwig==
X-Gm-Message-State: AFeK/H1Fq9JBE2Kss5tUc4FzvgCMW6JTYCASwgGPNb+LKUdK8jyU154b/m0EbHBB8+rV6HWEAW+V1YQtcnKQXQ==
X-Received: by 10.157.46.137 with SMTP id w9mr15935035ota.225.1490011345691;
 Mon, 20 Mar 2017 05:02:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Mar 2017 05:01:55 -0700 (PDT)
In-Reply-To: <b841a674-7b2b-420d-7faa-e5b836fb534e@alum.mit.edu>
References: <20170216120302.5302-1-pclouds@gmail.com> <20170318100206.5980-1-pclouds@gmail.com>
 <20170318100206.5980-3-pclouds@gmail.com> <b841a674-7b2b-420d-7faa-e5b836fb534e@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Mar 2017 19:01:55 +0700
Message-ID: <CACsJy8B85TH0DOViEmfh8mOz_u7rVotKJa-HYk6TJ81kvV4xPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] refs: introduce get_worktree_ref_store()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 1:59 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I guess I can hold my nose and accept storing worktree and submodule
> `ref_store`s together in a single hashmap

Release your nose, I'll add a new hashmap :) But while we're here,
what are your thoughts about moving submodule-specific to submodule.c?
That includes the hashmap, get_submodule_ref_store() and all other
submodule stuff, to submodule.c where submodule-specific stuff stays.
The same for worktree stuff, to worktree.c. That keeps refs.c to core
refs business. And the hashmap can be used for more than just refs.
For example, submodule has configs, and worktree also has bunch of
other stuff that I would like to just cache and not readdir() and
parse every time.
-- 
Duy
