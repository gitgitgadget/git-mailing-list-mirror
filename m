Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B19AC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B742076E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 16:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9C/YB9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbgFWQQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgFWQQP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 12:16:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0954C061573;
        Tue, 23 Jun 2020 09:16:14 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l63so2061316oih.13;
        Tue, 23 Jun 2020 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C6zRBd638da/3Puon0/mPbz+ZaserpAdoN60zWcOdLI=;
        b=q9C/YB9xTNbi+bUSIqxvhX2J9LG6GOkMQDm2VwP8GJuPHssugJJEnTrXF14R/INoZm
         iQ3QQg0wqJoIaDQyOOD1zmAkdyvzdQOTkpEqUo1eToIrWFs218PHZY70QZpcx+QrFdMK
         jAtWK64XxxLGBW3F3rH1BvCX5JgmKQHoHxZyIOSX0oMlLlrJNn6nEtv5BZj+Cbp2560/
         zlaRxu3as1JLgaOJ+na3a+VHQ2XrYJk6y9bdNMIwF4Ix5TAm0p1uZCHFpGD5xwxXIS6v
         ykFuyNpN+nJpjTNyGim8dGKr9squI6WXic/xGGxLACODlOQop6inLVWvexoI711WdhwQ
         PmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6zRBd638da/3Puon0/mPbz+ZaserpAdoN60zWcOdLI=;
        b=Rz/7gBS48BPOcrbwwtDNugeM3F7x8GM08u67sp57Ig/wA3qwk8nRq1gRZ44ErE4zGp
         USaW7P1rG9jvKPwpYBG6/yXWWgGd3SeEu0peASB6T66jsCEiOhSv4u0VsJdN03l1bBjb
         Y6Q6HBB+X1lAv0ycKBZrHZvOo2kpUTdGUqCeIgRloyL67smcJsAbIKIAaHs9B1PvWYZh
         HxE5UvHBwv5FmkTMeEC6JNIQEdlOyTBI8w3t4lm01Uy+FX6O9q3sfAct8c9wphV8TEKk
         AJ8OxEmdEnGRgggrXjUoGv732tBDHCs24HMI40Vb/NvPKidV8NF1Fp9HFnp11KxinfPL
         +qpg==
X-Gm-Message-State: AOAM532G/FZsBk0EElqrUlvCGmPmB2rjdA4AHhJNjTJS1W9iFEc8bo1e
        Zu98ttM6Qx7G/AFC/nnQTuCUosX0BToVWGoPmLzm4fCluTw=
X-Google-Smtp-Source: ABdhPJzPGRoNQwYV7prpiLP4l6woYoYftSSNf32Kxl7WYaM4Qub1H/LpMosSXlZwcAOlEq6NpTl/ZwSS1zQ0t3F6Uy0=
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr16344641oic.31.1592928973611;
 Tue, 23 Jun 2020 09:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzh9mu4my.fsf@gitster.c.googlers.com> <CABPp-BF+xvzroi5QU8zPp-7KoSS16v1CsM43vWx1WO5NjyU0BQ@mail.gmail.com>
In-Reply-To: <CABPp-BF+xvzroi5QU8zPp-7KoSS16v1CsM43vWx1WO5NjyU0BQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Jun 2020 09:16:02 -0700
Message-ID: <CABPp-BFo=SRkMezdD_FvM92-bgdeBzfExpjtjYiEvg0UM1rWQQ@mail.gmail.com>
Subject: [ANNOUNCE] git-filter-repo v2.27.1
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jun 1, 2020 at 10:08 AM Elijah Newren <newren@gmail.com> wrote:
>
> The latest release of git-filter-repo, v2.27.0, is also now available.
> It is comprised of 26 non-merge commits since v2.26.0, including two
> changes from new contributors.

I missed sending out this email earlier, but v2.27.1 of
git-filter-repo was released a week and a half ago.  v2.27.0
accidentally broke the most prominent example in the README.md file;
v2.27.1 fixes that bug /and/ makes sure that example is actually in
the testsuite to prevent a repeat.

The public repo of filter-repo is at

    https://github.com/newren/git-filter-repo

The tarballs can be found at:

    https://github.com/newren/git-filter-repo/releases

git-filter-repo can also be installed via a variety of package managers
across Windows, Mac OS, or Linux (and maybe others)[1].

[1] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md

----------------------------------------------------------------

git-filter-repo 2.27.1 Release Notes
====================================

(Note: Additional information is available for many release notes at
    https://github.com/newren/git-filter-repo/issues/<NUMBER>)

* Fixes:
  * fix "extract subdirectory for merging into a monorepo" example (#110)
  * add tests to make sure we don't break that example again
  * avoid applying --replace-text to binary files

* Documentation:
  * simplify manual installation using git's --man-path and --html-path (#107)
  * make discovery of code formatting and linting examples easier (#99)
  * many wording clarifications

* contrib scripts:
  * avoid applying --replace-text to binary files in bfg-ish
  * new simple barebones example
  * default replacement text is now a variable to allow overriding

Changes since v2.27.0 are as follows:

Elijah Newren (13):
      converting-from-bfg-repo-cleaner.md: add a small clarification
      converting-from-filter-branch.md: add a small clarification
      filter-repo: avoid applying --replace-text to binary files
      filter-repo: make default replacement text a variable
      contrib: new simple no-op-example
      contrib, docs: make discovery of code formatting and linting easier
      Contributing.md: add a small clarification about line coverage
      contrib: avoid applying --replace-text to binary files in bfg-ish
      git-filter-repo.txt: briefly explain steps for pushing to original url
      Revert "filter-repo: fix ugly bug with mixing path filtering and renaming"
      filter-repo: clarify interactions between path filtering and path renaming
      git-filter-repo.txt: discourage use of random clone flags
      INSTALL.md: simplify manual installation instructions
