Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7125F2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 16:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbdCRQnT (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 12:43:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36520 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdCRQnT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 12:43:19 -0400
Received: by mail-wr0-f196.google.com with SMTP id l37so12958066wrc.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGMLUKwqEqHRftZavBCFUV8qN+27mirIWvQN7Kiri/Q=;
        b=iQYNCB1DmJR+n8tdOP3euGUnLIa2thSeemIFjxASKrRGjwVix4QJVQFgJVbnRmn+pq
         W4HBg9dqWVqpxxXXGGf6KyZgUHgyTIE+Pm/SAabJWeODAceRj+Qv/rcLz8uPc+w9oCwo
         jLmRN79PjSqgV5JJWHjstsCIfYoZ7G8raNcOYi8gWyb8sgBNyheTpV8L+TGp3d/MlS1X
         zKGChsViWa4PK1y0got97sLzR4TVw/BIYyzLt+B+61eFZofwhCwh7E13ztwLy/2GTPFq
         UfJcuYmvQqDQcTNcEdDPQIOh6PzxA6CzF/M+4p+6vIllFXJaGSHlSDUyM9MMTUIPDYSF
         O7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGMLUKwqEqHRftZavBCFUV8qN+27mirIWvQN7Kiri/Q=;
        b=Il4NZB1BlttO7LjzKu77mFzFxvLuJfpufGo9GOUgznLK/DHH4GJfRlZ4wpvcDf4NP7
         Yev6+ZQrWL/OcV0Kmn126Og6Q7TjAfLwnzdN76zkOLXCkfI4BDmYTgDIpDwbR+bC9/jr
         vxcEIj5bfi/D4G94FkN9/C/C8VLC85gCLbZ1Wh+4D7Go581LMtrfZroC/1H7wlPIHeqV
         dWpXahtcloxewFEflRuP0LBWQav7Zc1AWUfCUiVeO4fJHpZIGfZ9DHopSvZp80M6thIX
         uiAsJ907CJErcP7Gre4nH/7CTpSXdpsxveJwwr/lyqqT0TcLrE/UpUaOrTfumWvRXyZm
         ZPNQ==
X-Gm-Message-State: AFeK/H3qEBesQTKMkKgOfTKIraFaqiNXTg2JQnp8PfDamq5Km3of0FPOxXFRoAYroLKuag==
X-Received: by 10.223.142.201 with SMTP id q67mr16577089wrb.182.1489853657150;
        Sat, 18 Mar 2017 09:14:17 -0700 (PDT)
Received: from localhost.localdomain (x590e29c6.dyn.telefonica.de. [89.14.41.198])
        by smtp.gmail.com with ESMTPSA id s17sm14111267wrc.25.2017.03.18.09.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 09:14:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 2/2] tests: make the 'test_pause' helper work in non-verbose mode
Date:   Sat, 18 Mar 2017 17:14:00 +0100
Message-Id: <20170318161400.19753-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.0.377.g15f6ffe90
In-Reply-To: <20170318161400.19753-1-szeder.dev@gmail.com>
References: <CAM0VKj=k8kygEPpfX+-n0ODd70A8PEYAviKosvc0D34jT02N5w@mail.gmail.com>
 <20170318161400.19753-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the 'test_pause' helper function invokes the shell mid-test, it
explicitly redirects the shell's stdout and stderr to file descriptors
3 and 4, which are the stdout and stderr of the tests (i.e. where they
would be connected anyway without those redirections).  These file
descriptors are only attached to the terminal in verbose mode, hence
the restriction of 'test_pause' to work only with '-v'.

Redirect the shell's stdout and stderr to the test environment's
original stdout and stderr, allowing it to work properly even in
non-verbose mode, and the restriction can be lifted.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4a50a6104..5ee124332 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -136,17 +136,12 @@ test_tick () {
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }
 
-# Stop execution and start a shell. This is useful for debugging tests and
-# only makes sense together with "-v".
+# Stop execution and start a shell. This is useful for debugging tests.
 #
 # Be sure to remove all invocations of this command before submitting.
 
 test_pause () {
-	if test "$verbose" = t; then
-		"$SHELL_PATH" <&6 >&3 2>&4
-	else
-		error >&5 "test_pause requires --verbose"
-	fi
+	"$SHELL_PATH" <&6 >&5 2>&7
 }
 
 # Wrap git in gdb. Adding this to a command can make it easier to
-- 
2.12.0.377.g15f6ffe90

