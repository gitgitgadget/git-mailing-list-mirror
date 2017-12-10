Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945B41F407
	for <e@80x24.org>; Sun, 10 Dec 2017 21:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbdLJVUf (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 16:20:35 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36512 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbdLJVUe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 16:20:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id b76so10936427wmg.1
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 13:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4/X8B9Vk9jhvwoAJLgP1JlvI9aEmJBvSj7h8FupPEso=;
        b=rPdFEVeKmWJ1Oij0KttWvdqo4U/D+xlf5noGoRHe71h5l3QHUZK5Mxn09pIUcCQa8e
         Zx9olsKCdhDBxgRqKrRcRwpXd+UFKDgZcO4h+rlb8lB1Vz91rgcD4x/Z0j1rYDhCmhvj
         mFSdPCIttXRqUjQ2+dQVgCk2zMLYgppLVizWi0VSp7t+k293+jh/OiiYFRDn0lapGsJf
         L3E9AtK2AW67j6IK+zjMWLk7HD+YEH/9W27ZX10Qvk3WCEEZ0Lr4OdkWKSxvxUL3bqU/
         3mCh2nRIf7zWFl4wKGLiEb/3Kb4cnIvBEv/AVWl8e6FXDgo6LGAswGkzqZhdJ6Cc9OMV
         lvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4/X8B9Vk9jhvwoAJLgP1JlvI9aEmJBvSj7h8FupPEso=;
        b=I05qLVT9KlTgZmOEcTVWHi8ldMStSPBUgrhokSexUzEcgel7i6t0828JRR++ivv+eq
         CemtUn3Nl9H99kVYrwCMpl/Ax0qXM98duIHJdFtbtLxIlqy1VHAPWo4Wbf/IShxgkI13
         c4Blj7YIkHulXxxq+I7b6nxMJ152li0MijobEiaYV3bhESxq9dwwlDbZpQBHSRx+00J6
         C6WZpZA64+yF/6HnSa2wam5mlkBEsAU5jJjbD24NUphW9AU5otK0pmXwDH7PrLpAqrW6
         YTablg9Bmn7RA7oGjfMxPD0meazz53ve+qhDF6zogCqoFWvZwDAQHRGHBdKRZHZFYJwZ
         0r6Q==
X-Gm-Message-State: AKGB3mIvU7zHX1Q+1hYQBPBHqZYT5G8y8j3cyw8GY+Uil9slBLRR7074
        avk51BiQfS87M14G0IRT8q6Ke+iL
X-Google-Smtp-Source: AGs4zMYRxzUoHTD2jJXV9tezv5frgHVJ12Iah3aeFweoB/waD/Sa6X764ufG6rCDoCsNrcujGFXa4Q==
X-Received: by 10.28.69.136 with SMTP id l8mr8425363wmi.19.1512940832816;
        Sun, 10 Dec 2017 13:20:32 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 67sm1976566wmq.38.2017.12.10.13.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Dec 2017 13:20:32 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/3] fixes for split index mode
Date:   Sun, 10 Dec 2017 21:21:59 +0000
Message-Id: <20171210212202.28231-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On the current master branch, 95ec6b1b33 ("RelNotes: the eighth
batch", 2017-12-06) , the test suite fails a few tests when
GIT_TEST_SPLIT_INDEX is set:

Test Summary Report
-------------------
t3007-ls-files-recurse-submodules.sh             (Wstat: 256 Tests: 21 Failed: 13)
  Failed tests:  2-14
  Non-zero exit status: 1
t7009-filter-branch-null-sha1.sh                 (Wstat: 256 Tests: 6 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
t5304-prune.sh                                   (Wstat: 256 Tests: 25 Failed: 3)
  Failed tests:  23-25
  Non-zero exit status: 1
t7814-grep-recurse-submodules.sh                 (Wstat: 256 Tests: 22 Failed: 13)
  Failed tests:  2-3, 5-10, 12-15, 22
  Non-zero exit status: 1

This series fixes these and makes travis run the test suite with
GIT_TEST_SPLIT_INDEX to avoid similar breakages in the future.

Thomas Gummerer (3):
  repository: fix repo_read_index with submodules
  prune: fix pruning with multiple worktrees and split index
  travis: run tests with GIT_TEST_SPLIT_INDEX

 .travis.yml  |  2 +-
 cache.h      |  1 +
 read-cache.c | 19 +++++++++++++++++--
 repository.c | 13 ++++++++++++-
 repository.h |  2 ++
 revision.c   | 13 ++++++++-----
 6 files changed, 41 insertions(+), 9 deletions(-)

-- 
2.15.1.504.g5279b80103

