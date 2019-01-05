Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6CC81F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 01:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAEBJS (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 20:09:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51786 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfAEBJS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 20:09:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so2581359wmj.1
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 17:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6C+5xi+QLlEv7wydjb7DYfllihed/cK0pcnDFZys+fE=;
        b=t7c65p9k/IMiee23FapezXR8dX8KabwhRzDnLR07Ac1v0/64EdWZNcn+YMnN2GEs4+
         3+c6+/Pm64CHUHIjG8bjS8YSQ6R3em3x1QsCZnAvXiSzku7RfsqUkZr+8iT8ijA+hE7C
         ErMmpXJ3T0Nv7iY6tQ7Dz2yVCcf7LlD1hUNxrdJWkYkdNd4tyYtSObWTBCfm8XJspEaf
         XEj7nZ6pvP5Q6Ay0MTuKWyhOtMESVkFOcyN0PZ6Odyu6Y0prlOgNIstzXIJ6oR3cfZTV
         w6tWMQ5isXcunswLmAzY2cihL0aozg/wUAjxHMl8OjTV5ynPKSOnaJY2QPjajEW5A6pX
         /qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6C+5xi+QLlEv7wydjb7DYfllihed/cK0pcnDFZys+fE=;
        b=QUJI3VrYT1MlgTP6IeEq4Fa/zU6v+7NUpuTycxXWJbUv488aq6l2lTEkvBoxaL8A5T
         8btCtSOv1nNcUvgS0lmWQbfWkVGz1RwyQRkxkKqQXdcQbgcsNt43Z656GwMNt/EOFKj7
         mitADNspCGT+gFlhCicB5z5atwB2/kpmM7QzAnbAUVhHdGTuzf/eFTiLZQaZYb3wLHOH
         i8wlkYDCKHwhAheQwJwURtHSaBfDeuLqBgHLv0cmslQ9UdjOOe/0+iraOMBm2HE0i1+U
         rhDQBU9wNcmQo1TN7brW5TILxxViQ5AG24aicQ1v71pKGBrUTmwL46xor/CJeGi63O/P
         RwrQ==
X-Gm-Message-State: AJcUukfh0NhBiBUDMFFnJ9Fqh9TKefR0Z+XnZSY5lXB91rtdLUfDWvXK
        L4t5DIGG1FcM4RgUe550vi4=
X-Google-Smtp-Source: ALg8bN5zUeo9l7+cIIVuq4vtLWIZ5QoLpkIcwtTaUKVSbDTwGguGRN8Y9/4S/bYwf/DnP70C4X6r0w==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr2910927wmu.52.1546650555486;
        Fri, 04 Jan 2019 17:09:15 -0800 (PST)
Received: from localhost.localdomain (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id c15sm1851353wml.27.2019.01.04.17.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 17:09:14 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 2/8] test-lib: extract Bash version check for '-x' tracing
Date:   Sat,  5 Jan 2019 02:08:53 +0100
Message-Id: <20190105010859.11031-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20190105010859.11031-1-szeder.dev@gmail.com>
References: <20181230191629.3232-1-szeder.dev@gmail.com>
 <20190105010859.11031-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of our test scripts, 't1510-repo-setup.sh' [1], still can't be
reliably run with '-x' tracing enabled, unless it's executed with a
Bash version supporting BASH_XTRACEFD (since v4.1).  We have a lengthy
condition to check the version of the shell running the test script,
and disable tracing if it's not executed with a suitable Bash version
[2].

Move this check out from the option parsing loop, so other options can
imply '-x' by setting 'trace=t', without missing this Bash version
check.

[1] 5827506928 (t1510-repo-setup: mark as untraceable with '-x',
    2018-02-24)
[2] 5fc98e79fc (t: add means to disable '-x' tracing for individual
    test scripts, 2018-02-24)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4c3744cce4..1f02e2e25b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -317,24 +317,7 @@ do
 		GIT_TEST_CHAIN_LINT=0
 		shift ;;
 	-x)
-		# Some test scripts can't be reliably traced  with '-x',
-		# unless the test is run with a Bash version supporting
-		# BASH_XTRACEFD (introduced in Bash v4.1).  Check whether
-		# this test is marked as such, and ignore '-x' if it
-		# isn't executed with a suitable Bash version.
-		if test -z "$test_untraceable" || {
-		     test -n "$BASH_VERSION" && eval '
-		       test ${BASH_VERSINFO[0]} -gt 4 || {
-			 test ${BASH_VERSINFO[0]} -eq 4 &&
-			 test ${BASH_VERSINFO[1]} -ge 1
-		       }
-		     '
-		   }
-		then
-			trace=t
-		else
-			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
-		fi
+		trace=t
 		shift ;;
 	-V|--verbose-log)
 		verbose_log=t
@@ -353,6 +336,24 @@ then
 	test -z "$verbose_log" && verbose=t
 fi
 
+if test -n "$trace" && test -n "$test_untraceable"
+then
+	# '-x' tracing requested, but this test script can't be reliably
+	# traced, unless it is run with a Bash version supporting
+	# BASH_XTRACEFD (introduced in Bash v4.1).
+	if test -n "$BASH_VERSION" && eval '
+	     test ${BASH_VERSINFO[0]} -gt 4 || {
+	       test ${BASH_VERSINFO[0]} -eq 4 &&
+	       test ${BASH_VERSINFO[1]} -ge 1
+	     }
+	   '
+	then
+		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
+	else
+		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
+		trace=
+	fi
+fi
 if test -n "$trace" && test -z "$verbose_log"
 then
 	verbose=t
-- 
2.20.1.151.gec613c4b75

