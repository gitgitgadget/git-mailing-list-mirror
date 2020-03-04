Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B11C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 07:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E8D2073D
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 07:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGr5/QCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgCDHAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:00:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52091 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgCDHAD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 02:00:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id a132so652402wme.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 23:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kSeti1EOsfZHHXjYPWUdACkUJTpaX1Dm73BDbuvGYJQ=;
        b=KGr5/QCpB1imwDnzWBp8FEI5wd3oDqRlZFE0UBclkj9h/QRheYpXd/INZoJdUaGLIm
         qfV/rR3hWHFgd6XXn2VRSWbtu9WC+CX8RinEIkoGe5mduoCnaXtsOsqGtmvX9P0wuayQ
         MXAxvXmxpqUZWGK1pb0Cu8GNVHj5OA8c/qY5AXtPM4QOmXLD1FSQcABdGftfQzz0hh9z
         xojNU6dYBWIG7ivCOLNuPamgOFMMoRZttJJj0326ru30rkv2Pa5XH+EFb5sR0QSbgatn
         0nKDRl4ZAK9hKFkLTfbefyKifrocBwYiIrJcZ/xHIPt6PZbtohKnf6v4F1YOVLIxlfmP
         YyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kSeti1EOsfZHHXjYPWUdACkUJTpaX1Dm73BDbuvGYJQ=;
        b=bzrjCxjRy87QtYXGuFnlU2r27HbuVrAsYFTBjyi2nrlc/4YotF80h/Eq0bpdbcEK/N
         bwjcTWMqCiv/AFJqFK0gt+UfDP8Jy7HUYynrD3K2tnIvcsmNVQL81S+uCsS2cJzDq1Zf
         ha+kh1hPZRg2Io2rXDfpEOrbrhfVRCO65jHaaftNVG9YvUf1RLdUbvn82SWzu+PSG/9x
         EeqViGt6omd0zzCN/WgcdUpZ+o6UlBh1YyYIyV3Vjb3uud263YYA+qhtqmylttofHP0H
         g0B+8Lnjavk+ZyB7qcYUOxH7lZrj8qRyo/WKUBh3ijxU23ir91MuNoM0907PDMzRsjlL
         CIbw==
X-Gm-Message-State: ANhLgQ3Sjf/RComOOBqrcTxraqIasFZ7pzxzt0MSfO/LQFdua4N0qncM
        gW/Cp3Ij442h4frRSRU6bf2dg/CP
X-Google-Smtp-Source: ADFU+vvdoVIFFW5Lp+7Ty40r0gh3mpaIcrLZd3NuCrLZdkV93lJgs8N/X3lIYGQUalgleNNz2hw55g==
X-Received: by 2002:a1c:156:: with SMTP id 83mr2005454wmb.151.1583305201421;
        Tue, 03 Mar 2020 23:00:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16sm37548954wru.68.2020.03.03.23.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 23:00:00 -0800 (PST)
Message-Id: <pull.570.git.1583305200143.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Mar 2020 07:00:00 +0000
Subject: [PATCH] t2402: test worktree path when called in .git directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

The bug which reports an extra `/.git/.` in worktree path when called in
'.git' directory already has been fixed. But unfortunately, the regression
test to ensure this behavior has been forgotten.
Here is that test.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
    t2402: test worktree path when called in .git directory
    
    Regression test to ensure that the bug (i.e. extra /.git/. in worktree
    path when called in '.git' directory) has been fixed correctly.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-570%2Fharry-hov%2Fverify-get_main_worktree-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-570/harry-hov/verify-get_main_worktree-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/570

 t/t2402-worktree-list.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index bb6fb9b12cb..ef397386dc7 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -151,4 +151,10 @@ test_expect_success 'linked worktrees are sorted' '
 	test_cmp expected sorted/main/actual
 '
 
+test_expect_success 'worktree path when called in .git directory' '
+	git worktree list> list1 &&
+	git -C .git worktree list> list2 &&
+	test_cmp list1 list2
+'
+
 test_done

base-commit: 4ef346482d6d5748861c1aa9d56712e847369b40
-- 
gitgitgadget
