Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC420C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850E82072E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBf3vKGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgCWNJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:09:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38634 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbgCWNJy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 09:09:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id e5so6119889edq.5
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MTMJUc1kBM5Z01613d0t4EUoyglDpLqH2dva4eqmWaw=;
        b=YBf3vKGZLATosC2zy0X3lYoA9MbDulSk6vUf1Qh9tAReEC+QNwquy8VSgLX6ael96Q
         Ms0pK1EICkBTMPRzI8a1iEF0iGOTOlX92Dd7Qh34fzVxruTD3tIrwJbBWpwYXX2dr+dY
         0CEOed6TnV9Pd/Emv9Gv4QSG3/rn14EAgG5piZ++oQKSbuZNoSlDg03mZGxgBK2ryLvb
         /YhjFSKGMJtKA67xyK39TaZ2wE+L/B6frSqKtG7O32WM21LkD0V67osZ/wQk32WR2ZOz
         Skve8OVSpHrKP2jxq2b06wVACtKqysjg0VlTT/0WITJ6CZDb7TabDeFOwJ2srQJoJgQG
         fGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MTMJUc1kBM5Z01613d0t4EUoyglDpLqH2dva4eqmWaw=;
        b=VHFa0lIbv6I2WOG0XK8ZZCIQpjdUcH2iS8e7DxnQXPo3NXSq0KHgZePt+k5Tqn6Yut
         /DhoSd2x6TaaPpMSiU48j+EpPGbmi3yTFCOYW2vA4lMPONnWytGxooDBRrqq6kGrGTaa
         lnnyNuaGulZekCXdU2evRHXSngBv4fX1+GBaRa+osfsm/9BrcO0LkK6Q4LHjoSwJoE9V
         ROlGjRoTWDUT00rAvq6yoLgdCGJRbaqF5aOysmbp7Bq9NQ6IROtvPWxq8Gb43+6TQ1K+
         Vn6EpZmDC20GGWelkVwxa+qrQUHd6vQV0UO53RsAmPY6KPQ8nMfh1ht/F0cMZ2Ev3hmI
         AZNA==
X-Gm-Message-State: ANhLgQ2HPX/YymFQYG5yqHtcY6lqPfkUzesQDOP1MOkQcDD4F2PvVbEd
        UOyzNGVWJrnhhuCWsqh3t7GA7ZYj
X-Google-Smtp-Source: ADFU+vuD2B9EYg5Z6Q9jZkLsrn353Ap3+4ne5sKluIP1axxpzNpMxuG4Yol/fjn5XA1XtLiudWAm1g==
X-Received: by 2002:a05:6402:2057:: with SMTP id bc23mr6800567edb.5.1584968991829;
        Mon, 23 Mar 2020 06:09:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm291372edq.2.2020.03.23.06.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 06:09:51 -0700 (PDT)
Message-Id: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Mar 2020 13:09:48 +0000
Subject: [PATCH 0/2] Enable GPG in the Windows part of the CI/PR builds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While debugging the breakages introduced by hi/gpg-prefer-check-signature, I
noticed that the GPG prereq was not available on Windows, even if Git for
Windows' SDK comes with a fully functional GPG2.

The fix was easy, but finding out what was going on was not, so for good
measure, the fix is accompanied by a second patch that will hopefully make
future investigations into GPG-related problems much, much easier.

Johannes Schindelin (2):
  tests(gpg): allow the gpg-agent to start on Windows
  tests(gpg): increase verbosity to allow debugging

 t/lib-gpg.sh | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)


base-commit: 30e9940356dc67959877f4b2417da33ebdefbb79
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-728%2Fdscho%2Fci-windows-gpg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-728/dscho/ci-windows-gpg-v1
Pull-Request: https://github.com/git/git/pull/728
-- 
gitgitgadget
