Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C94C2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A92420828
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKbl5coE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfLZRmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:42:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34768 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfLZRme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 12:42:34 -0500
Received: by mail-ed1-f67.google.com with SMTP id l8so23250535edw.1
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 09:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=4X0nhEAvLw4tIUk8iPBsGGzJJHPTlJw0YpFakWN/mK4=;
        b=rKbl5coEYMEoomvDM5+Epka7XTfyeS4BPPlN1Dbh0seiBhVcwFlyKJfztpfbSckwEF
         r3Vmqv3lWs+ZbGsoahIJUIvstclmyKeTEOrbttAux6zNfMcTZWoKtwtO+Lks4ZWuiLa2
         93EYw+QyPK91jID6cu98eZaT52y+2+nqa60K6K/BclRTkswbXW+THVrgn0QruEWcPccx
         86X++4as5OwlWSCn0D2OdbGWoEW0/n99DTuJrytPrO4Ex46wAEPq45B1t34fnymUH0tw
         0IsUQs28goMgIi7XeNGNfFUqPFiY7hbPRajDe+po/hZILdfbuFRuf/rlzoWSwUkPDbE2
         yV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4X0nhEAvLw4tIUk8iPBsGGzJJHPTlJw0YpFakWN/mK4=;
        b=bTRSY0Rq4E8LyBY2cuk2gp4l2CwbHRDhiVjGYsx7LZBbxjNp+n2WcMKnAqG2vcaGp6
         IL3sUTu7hoomyqHEwkZ1sRm96FfnmnLK9CGpJho+GM2gXmyQhq3KVd9NWcJeiQnhtmO1
         wWxS3NkAv/iqXldNqCY/venXQ5cEBYLKkQt23y0hXYYfpw+4o7ZQaJqj9ZhZhbdhDa06
         2lmWCgnocStOkgGOJOKEmvwmLRhNuksaF+VVXAX+SioWuT/VK774gl20GBeR4LvPtRh5
         rbQHDqsNOrNjuIE7juLl/ikuynk1PISBtsjZwgyUJ69oO94PzNXX87m69Oaz17Gy0Md+
         j7XA==
X-Gm-Message-State: APjAAAXe6ntDJH5bsiachKeHCKfK+IQXCHn36fvRU2SddsO3ij8UtVHq
        64GgMlrfWfoHPdqYVjLYikedf8xV
X-Google-Smtp-Source: APXvYqxHbsJphNKPsQb61gK12CRed1gfNfCOV5HcUypdOt5mHWDhse//mjD0GqIK+wzNhPw2dRAGxQ==
X-Received: by 2002:aa7:cf83:: with SMTP id z3mr51806464edx.166.1577382152959;
        Thu, 26 Dec 2019 09:42:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10sm1685989ejn.16.2019.12.26.09.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 09:42:32 -0800 (PST)
Message-Id: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 17:42:30 +0000
Subject: [PATCH 0/1] Disallow writing, but not fetching commits with file names containing
 backslashes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of Git for Windows, v2.24.1(2). cloning a repository that contained a
file with a backslash in its name some time in the past, the command will 
succeed but at the same time print errors like this:

    error: filename in tree entry contains backslash: '\'

A corresponding git fetch will also show those errors, but fail.

The reason is that v2.24.1 is much more strict about backslashes in tree
entries than earlier versions. The intention was actually to prevent 
checking out such files, though: if there was a mistake in a repository long 
ago that has been fixed long since, there is actually no reason why we
should require the history to be rewritten.

This fixes https://github.com/git-for-windows/git/issues/2435.

The idea of this patch is to stop complaining about tree entries, and focus
instead on the index: whenever a file is added to the index, we do not want
any backslashes in the file name on Windows.

As before, this check is only performed on Windows, and only under 
core.protectNTFS. On other platforms, even if core.protectNTFS is turned on,
the backslash is not a directory separator, therefore the Operating System's
syscalls will (should?) refuse to create files on NTFS with backslashes in
their file name.

I would appreciate reviews with a particular eye on keeping users safe: I am
not 100% certain that all relevant file writes go through the index (I think 
that they all go through the index, but I might have well missed a corner
case).

Johannes Schindelin (1):
  mingw: only test index entries for backslashes, not tree entries

 read-cache.c               | 5 +++++
 t/t7415-submodule-names.sh | 7 ++++---
 tree-walk.c                | 6 ------
 3 files changed, 9 insertions(+), 9 deletions(-)


base-commit: 12029dc57db23baef008e77db1909367599210ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-682%2Fdscho%2Fmingw-only-error-on-backslash-in-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-682/dscho/mingw-only-error-on-backslash-in-index-v1
Pull-Request: https://github.com/git/git/pull/682
-- 
gitgitgadget
