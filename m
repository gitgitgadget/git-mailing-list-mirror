Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31226C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F006A20718
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4fDCvtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfL3SiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:38:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44768 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfL3SiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 13:38:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id bx28so33462081edb.11
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 10:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=4ATWVl/B4F/v5Ngn0R4Ie4ncRizUaOE53KMNKTVL4X8=;
        b=t4fDCvtA/wxblaVODCEZnsFHRcxwawQxj5mmjp7B2KbGqZtKu83s3oqjUDqK4ESzKX
         wThynyDiAtW2zbJYnW/usv+jb+Ox99DB40yTei7HUvJOjEHf1ktYiz2JF1ZNbpvVdDeJ
         auvFtlcCCr8qB3HuVm12ILDfxKrCQT1W9BdovvgLJ2/x+smFXm0IWsZvXx+ew9BN/vR3
         RndPjOP9fRQWAtOaRm3GNOP7YPJkTgILG4QWDlaxOaaG+kAFj8HjwUfghfmCPdVOtI1e
         CH7pvdwNmu/2+KtbNhNqz1KB2YJgFiJIeXhHrpTCmJc1EWihGcTsjKYCe1Ld+YvEZyH4
         M/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4ATWVl/B4F/v5Ngn0R4Ie4ncRizUaOE53KMNKTVL4X8=;
        b=s3QGHv7DEwJeXMlF5BEUa8dmPFV2Ds+YDZwbbE4qeaSYJcHHrXROiBfC00BVjDRFMh
         ckYk7VmQbH+PmNQLLI3KDFchmaABAWlxw48a+uoZUjhgvbXvN9H3L3TO2xP1vDhMQ3J4
         nMYjblZrXM5fgZq5eF6PsvZKr4yT2q4XE2j9s+Kp92nE4M2Jey7bT+8t3vslxPqPKNdp
         RYzzDQq24WULBut3xUJcGeflhz579jonLQaNBAeNY5AJStzHUN+yJDVfi7L2YaFAJk4f
         t0179tfaVV2FsZ6oif6T3ICdLm+kUelhQ7Q3Q8F9a+dZlMAg2RiilNq5TtRSXiL74NYe
         TPKQ==
X-Gm-Message-State: APjAAAU4H3kjZErIKanjLEi+KD3u4gcCBGo0EBTKYBxvxwOqacvSMLtz
        custfZG9rfcQBwYKOnIHS3f7Whxp
X-Google-Smtp-Source: APXvYqzrFVdJYabrQl4VFT7YWa89BqeIGj3N7nCnPQKe9SApCSaSIzXbT8t9eW/HOHzIZSZiN6+Exg==
X-Received: by 2002:a50:d69a:: with SMTP id r26mr74374350edi.148.1577731094347;
        Mon, 30 Dec 2019 10:38:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm5466519edm.82.2019.12.30.10.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 10:38:13 -0800 (PST)
Message-Id: <pull.504.git.1577731093.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 18:38:11 +0000
Subject: [PATCH 0/2] checkout: don't revert file on ambiguous tracking branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an improved version of [1]; I tried to clarify the commit message.
CC'ing authors of previous commits mentioned in my commit message.

[1] https://public-inbox.org/git/pull.477.git.1574848137.gitgitgadget@gmail.com/T/#u

Alexandr Miloslavskiy (2):
  parse_branchname_arg(): extract part as new function
  checkout: don't revert file on ambiguous tracking branches

 builtin/checkout.c       | 71 ++++++++++++++++++++++------------------
 t/t2024-checkout-dwim.sh | 28 ++++++++++++++--
 2 files changed, 65 insertions(+), 34 deletions(-)


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-504%2FSyntevoAlex%2F%230207(git)_2c_prevent_ambiguous_checkout-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-504/SyntevoAlex/#0207(git)_2c_prevent_ambiguous_checkout-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/504
-- 
gitgitgadget
