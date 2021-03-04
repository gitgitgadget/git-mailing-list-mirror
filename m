Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49E0C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 07:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E2D64EFC
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 07:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhCDHzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 02:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbhCDHzM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 02:55:12 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EFFC061574
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 23:54:32 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id z22so6368309oop.0
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 23:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iEfX+qHbX2QmnYYvIC72m6mktZ2s+UFYxzBv64rXDA=;
        b=P3IjL9EFg9n5h6LN8H4v24it6MGyi3ULf/TcrLeMqlaVhTSo1BVI1zOsZuTmxaZL4Z
         wbYSla+hXoPdloRpC0iKfOq99EfyZM1Mw36Q2a50CQrUetpuYCaibQeaVB7FZEgtVM6B
         EBdfbYSxoGV7PeoW4WDCNuAjusX7EcXquX30PW+yUGNSWInK2jlJiMVlaQx7udNO1X8D
         ejF75EtDLqCy+EBnq77Uu/ij4IABvRaQHdJXmCGLWU2JsAguBweTB2ne5P8muxHDjOIJ
         WEKuTBwUVahE6JWONWFgaQdD3slccBml+5qlQ6cYtA2DK+8L0UCRONxVVWJioVmMyNFF
         LckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iEfX+qHbX2QmnYYvIC72m6mktZ2s+UFYxzBv64rXDA=;
        b=g63rm8+lDUyblDRx6kCEl8+EGESQZUmx46oJP8e/Mqe4mfYnyNMLciCcGepkxsnFiR
         fBCVIyqVpk25tgz/vP5sm4XC09sUMm6RW96TQERdSFHleCRe8JiJNp1g9z0LCSXcgT27
         pyH1cTVhGMtpokHSYAdlQS8/Woa+EaUDRTx3Gbb/TabDjZU6ByL27eVSmtAitH9ZAq20
         zSI1CCjcdtxm6IAuMi0RlxgXR7xQj29ZKBhhVYGVq2XGeWFf9I63582Yz9vvQXKzpidv
         gpf0+VEuPWqHbdY/bxeSTn1GlVUalOOqwZX+xL5VkFcVpT1C42o18jaMfSxUGjkGbAPN
         zgQA==
X-Gm-Message-State: AOAM531mw+gKLPJ0AyP5y1iIJM8IlmFmWS8COFIiolMzdn/kobHdLtFW
        FLiWKuoi25xuIzi0g/Z2Ue5SrEJ1TPGTxZyV0J8=
X-Google-Smtp-Source: ABdhPJwZ3fmjZiGOJGAbUoZdtPZwlGG2Exh6G3w3aDOdMwMKoyaLZUJdm8eibXRPpun0LvpCrZlIkBIIyX6uPmsn3WI=
X-Received: by 2002:a4a:94a7:: with SMTP id k36mr2370157ooi.45.1614844471236;
 Wed, 03 Mar 2021 23:54:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 3 Mar 2021 23:54:20 -0800
Message-ID: <CABPp-BEv1BN66A1jJ+P+HThyFSwM9mFevd-uj9FWbnWyMtsCNQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Optimization batch 9: avoid detecting irrelevant renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Feb 27, 2021 at 7:58 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series depends textually on ort-perf-batch-8, but semantically it's
> almost completely unrelated and can be reviewed without any familiarity with
> any of the previous patch series.
>
> === Basic Optimization idea ===
>
> The basic idea here is that if side A of history:
>
>  * only modifies/adds/deletes a few files
>  * adds new files to few if any of the directories that side B deleted or
>    renamed
>
> then when we do rename detection on side B we can avoid even looking at most
> (and perhaps even all) paths that side B deleted. Since commits being
> rebased or cherry-picked tend to only modify a few files, this optimization
> tends to be particularly effective for rebases and cherry-picks.

After thinking it over a bit more, there's a much better way to put
this summary:

    We only need expensive rename detection on the subset of files
changed on *both* sides (for the most part).

This is because:

1. The primary reason for rename detection in merges is enabling
three-way content merges
2. The purpose of three-way content merges is reconciling changes when
*both* sides of history modified some file
3. If a file was only modified by the side that renamed the file, then
detecting the rename is irrelevant; we'll get the same answer without
knowing about the rename.
4. (Well...there are rare cases where we need the rename for reasons
other than three-way content merges.  Patch 5 explains those.)
