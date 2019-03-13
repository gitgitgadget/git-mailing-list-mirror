Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8E120248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCMMYr (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35547 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCMMYr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id y15so1662557wma.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cCi0vticgSBKBzlF9Y7obcxyVl82nePm735W1qMOag=;
        b=kUk/YIM3txkhDdQ2g9M+Z2mI1KGLC9T6u+r6mVv1v2NTZzA3335YQXqdfbv1jhXbZW
         xSZHlA8yVgUqoySr8qYUntg6Y33AVBlcmofWOSF5PjEimsoZBT8jkkt8TrQGAL8PpL3Q
         f+St2eZmewzf1reRJVeOfzQ6ZyAILGgg7EsKoay+7rskcNWhAMR1XQnS/SGteosl9eQh
         FNTcDb1JvCZb3Hwq2CYjc59YFNkjfKP/4SXuYWBt6vNEge70h4ybxckgw9epDeQMzM0t
         fPpzrkLHxf0u/tAmWhcAteoETu+0domSlXVIIG1hauhT8hzOvoBLsebL46gyOYx9AW7H
         zsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cCi0vticgSBKBzlF9Y7obcxyVl82nePm735W1qMOag=;
        b=QD/LqMwd3cwOM+K/OPDkxhiW/Xf3kqCjRoOMjc6b8re7wlpF1YdsD2akLyIc2ZyJBg
         /kZHKnhWqr7L9ttfypdVDuKK8Ia5wFvH1CBStXaVZuSywPHw8FwPKjV7G979nZ8fAbhd
         vKinrsTGHdMDbTIotc+STSfy5eMDFzZzufybWGpJJ34LuPusvQnK1dQjEFI5xef/ZhdN
         mCRVWunnIjjZjokB/vi3uRqJ5VtIjjhcPoKESo82kCs0UX7p++VExMQdGkvFBYdYo+it
         oRfjrARDz9b/ZW3Dq1p1iZ4Fa7U88v7P7/kmUPgMKkboStnvF+ecSKemK2ywjFq2/lSh
         toYQ==
X-Gm-Message-State: APjAAAVCK8eXRwD3gbz3J3J2dXaBR7/+JxruYS9/c3RRn80hKqN8dnrU
        FVZO+ZxJ1V04/6Hm6s+T6W6B76ST
X-Google-Smtp-Source: APXvYqxGzyZ1kzDqsuEc7WGUQMJ1jRjyNZePjnt9W07lBXC2DGGsXvyR/7/egmsx4i4Ct3wh+w7HYA==
X-Received: by 2002:a05:600c:224f:: with SMTP id a15mr1239293wmm.2.1552479884378;
        Wed, 13 Mar 2019 05:24:44 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:43 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 04/11] git-daemon: use 'test_atexit` to stop 'git-daemon'
Date:   Wed, 13 Mar 2019 13:24:12 +0100
Message-Id: <20190313122419.2210-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.499.g4d310c7a8e.dirty
In-Reply-To: <20190313122419.2210-1-szeder.dev@gmail.com>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Use 'test_atexit' to run cleanup commands to stop 'git-daemon' at the
end of the test script or upon interrupt or failure, as it is shorter,
simpler, and more robust than registering such cleanup commands in the
trap on EXIT in the test scripts.

Note that in 't5570-git-daemon.sh' the daemon is stopped and then
re-started in the middle of the test script; take care that the
cleanup functions to stop the daemon are only registered once.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/interop/i5500-git-daemon.sh |  1 -
 t/lib-git-daemon.sh           | 14 +++++++++-----
 t/t5570-git-daemon.sh         |  1 -
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/interop/i5500-git-daemon.sh b/t/interop/i5500-git-daemon.sh
index 1daf69420b..4d22e42f84 100755
--- a/t/interop/i5500-git-daemon.sh
+++ b/t/interop/i5500-git-daemon.sh
@@ -37,5 +37,4 @@ test_expect_success "fetch with $VERSION_B" '
 	test_cmp expect actual
 '
 
-stop_git_daemon
 test_done
diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 6dab8766e7..7b3407134e 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -13,7 +13,6 @@
 #
 #	test_expect_success ...
 #
-#	stop_git_daemon
 #	test_done
 
 test_tristate GIT_TEST_GIT_DAEMON
@@ -36,6 +35,7 @@ GIT_DAEMON_DOCUMENT_ROOT_PATH="$PWD"/repo
 GIT_DAEMON_HOST_PORT=127.0.0.1:$LIB_GIT_DAEMON_PORT
 GIT_DAEMON_URL=git://$GIT_DAEMON_HOST_PORT
 
+registered_stop_git_daemon_atexit_handler=
 start_git_daemon() {
 	if test -n "$GIT_DAEMON_PID"
 	then
@@ -44,7 +44,13 @@ start_git_daemon() {
 
 	mkdir -p "$GIT_DAEMON_DOCUMENT_ROOT_PATH"
 
-	trap 'code=$?; stop_git_daemon; (exit $code); die' EXIT
+	# One of the test scripts stops and then re-starts 'git daemon'.
+	# Don't register and then run the same atexit handlers several times.
+	if test -z "$registered_stop_git_daemon_atexit_handler"
+	then
+		test_atexit 'stop_git_daemon'
+		registered_stop_git_daemon_atexit_handler=AlreadyDone
+	fi
 
 	say >&3 "Starting git daemon ..."
 	mkfifo git_daemon_output
@@ -66,7 +72,7 @@ start_git_daemon() {
 	then
 		kill "$GIT_DAEMON_PID"
 		wait "$GIT_DAEMON_PID"
-		trap 'die' EXIT
+		unset GIT_DAEMON_PID
 		test_skip_or_die $GIT_TEST_GIT_DAEMON \
 			"git daemon failed to start"
 	fi
@@ -78,8 +84,6 @@ stop_git_daemon() {
 		return
 	fi
 
-	trap 'die' EXIT
-
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
 	kill "$GIT_DAEMON_PID"
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 58ee787685..00fc612cac 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -198,5 +198,4 @@ test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
 	test_cmp expect actual
 '
 
-stop_git_daemon
 test_done
-- 
2.21.0.499.g4d310c7a8e.dirty

