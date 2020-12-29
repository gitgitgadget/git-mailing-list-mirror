Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C70BC433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 00:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6812122227
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 00:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgL2ApW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 19:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgL2ApW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 19:45:22 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49B1C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 16:44:41 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a109so10660396otc.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 16:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmrGRz8Lk9ug2yrsMRbL56A3VtZhevN32AeTbqGgy+M=;
        b=sAQKPeStgEuqy4ru4Yj+T+RUyysS5xYAnzeZgZWVEPjjVQEVbkfF232K07c4wyDOqT
         nZg2Y7UFv6KtDyW7SsexVVEiBUPCkvs2KtgnlZHyBHB5tQeqk6qEgXk5iCKJGCdxHskl
         JwU+0uI0SSTM5snma4dsSACAKNDhvKmrSBu1Y7ZduqMaJUIl/hVBQxDI8NBeL3db3Cgb
         t+r0whic+9xHS2Oo1TkGoSuqGQRonqX3kTsosQpuhN4y0xq/7Ao3T1E66wQYdjAIaUYp
         8V0T6BKEX7/vlBV8HBMuAM0vOD6fSthiRG1pNdaUUGDZBcLgjP5agNgbGha/4MrO23M8
         xSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmrGRz8Lk9ug2yrsMRbL56A3VtZhevN32AeTbqGgy+M=;
        b=RmNh/OxyLZClQO5CnFGWUAze1xtTcU1voIsNWmvS5Rfl44KJJgxEL56E0S30yIeimd
         MIKwDhwrWB+oGO5VYDeRaFuWfMk39Mzr5DgkdCu3u1znugFAYEvxBksabG+ZktNkgc37
         +9SxCpwNMz0eJrfRhM75rcYTx4MFYFB3UDAvQH/cfQxaEpgfurZXT/gVTGLrvaBfD/Pv
         47w9M/BgIvZlN5/0B5L/K3VMW/jEvJ621g5+i3Nn4s39NDhkHxEF4rq2OpxVaIeL8d9Y
         n5q6vGcBlWtsu+bl1vvWQigaSvWHX9yZGGYQK4iVDIiAaBN2FmAUqfcosMMUCisP0eBy
         4rew==
X-Gm-Message-State: AOAM533/7jvOi3QYmdCisgS95zTNKCDsCDoPLAveLSV14frOIwQ0BbHh
        ukGelCu8dqOpHUCSly2H+vLtSm2leNVQ2zQBjXI=
X-Google-Smtp-Source: ABdhPJyGw+8tCfKpPq78WiNr2+zjFJnlsfVaA1vQxx1n+7h1kbMaFM5GjggLCDRut2Xv7TNoC1jx52EvU6o7xkg4WDU=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr34604117otr.345.1609202680952;
 Mon, 28 Dec 2020 16:44:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 28 Dec 2020 16:44:29 -0800
Message-ID: <CABPp-BFpgTEuAkNTc2y6mzwJivEw5YAn1deAgScR9ATwaX9+3w@mail.gmail.com>
Subject: Re: [PATCH 00/10] merge-ort: add more handling of basic conflict types
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Dec 17, 2020 at 9:51 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series depends on en/merge-ort-2 (it does not depend on en/merge-ort-3
> or en/merge-ort-recursive).
>
> This series adds handling of additional basic conflict types (directory/file

I submitted this about a week and a half ago, and figured you might
not have picked it up for 'seen' because of the -rc freeze and focus
on the release.  With 2.30.0 released now, would it be easier for you
if I resent the series (with no changes) or is it easier to just pick
this series up as it is?

Thanks,
Elijah

> conflicts, three-way content merging, very basic submodule divergence
> reconciliation, and different filetypes). This series drops the number of
> test failures under GIT_TEST_MERGE_ALGORITHM=ort by 211 (from 1448 to 1237).
>
> Further, if en/merge-tests, en/merge-ort-3, en/merge-ort-recursive, and this
> series are all merged down (in any order), then collectively they drop the
> number of test failure under GIT_TEST_MERGE_ALGORITHM=ort from 1448 down to
> 60.
>
> Elijah Newren (10):
>   merge-ort: handle D/F conflict where directory disappears due to merge
>   merge-ort: handle directory/file conflicts that remain
>   merge-ort: implement unique_path() helper
>   merge-ort: handle book-keeping around two- and three-way content merge
>   merge-ort: flesh out implementation of handle_content_merge()
>   merge-ort: copy and adapt merge_3way() from merge-recursive.c
>   merge-ort: copy and adapt merge_submodule() from merge-recursive.c
>   merge-ort: implement format_commit()
>   merge-ort: copy find_first_merges() implementation from
>     merge-recursive.c
>   merge-ort: add handling for different types of files at same path
>
>  merge-ort.c | 671 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 653 insertions(+), 18 deletions(-)
>
>
> base-commit: c5a6f65527aa3b6f5d7cf25437a88d8727ab0646
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-815%2Fnewren%2Fort-conflict-handling-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-815/newren/ort-conflict-handling-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/815
> --
> gitgitgadget
