Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A4020A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 22:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeLIW4p (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 17:56:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53552 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLIW4o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 17:56:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so9078490wmi.3
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 14:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=USn+hnCJ+X2q2+pljz8WoY6P1doTKBr++LjTVFxek70=;
        b=SOE0NyeNfyom/1V+1FupdTf5y4djeRzyHe88XGvmgyN7RapPztHaBRpaFBPxrm3Amc
         wcP/jvYR390YOp9JZJgW47Ip0HyrA7LSYEbtaTBZhI8KTR1YNJamwE2xXB0XcU6JFyIB
         2qhn86QdYvtzhA9Kk6Xyj5/2IsVNJFqY/83mtBwb+vTp6BMGSM+9TNtXTFKQalp8jNro
         6rMKFGkXqxDET7whcqdwm2+Y3404Ep8VThs2+1CwYBm2szBEW5EX2bIHcIJ8lM2PClQ6
         bsFZUzmUZz0ubW5ZsRX5Q9l/9G9ZgjAneBBgnF86eQbfhKO84OzEuOzAXrPuLQIsjjY9
         USlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=USn+hnCJ+X2q2+pljz8WoY6P1doTKBr++LjTVFxek70=;
        b=hrtd68nLtmPHaEfQbI3rmflfMBIlz++od3JwF/sUCVfR9gEJTTuXAowmPdoNQA889P
         vIAcshVyhvECW+CVh23Qy/CtLiHcSXdG8ImZvTMnuS6x7JGuGhAlYSyl+gUIIjr5f8Zg
         uHPbwnygZ3xGYHtcFeHkLc5nqDYRD1nSgaqkaHqjuLwMKqlSXJ/f7/EA/Pe/dnP1maeT
         gr2DHvnC5chzhaRZU9JkwzZF208q6pnPuLP3/X+zr16lW80IfsgVfkBhwSlH3+SswN7N
         H9gwLTHt/oNQLJC9RikriiM5G+dLn9J4FfiqFrVGgx2fLKp6D7yi09Lur2d1DQ1DqOU9
         ANyA==
X-Gm-Message-State: AA+aEWa7HwBJo+CjcG9D1zAgikADBzMOqQHx9OQHg2BbKaN1VskH3KrI
        SX/tPrsN5UuS1A99PyDUmQqxzEjl
X-Google-Smtp-Source: AFSGD/WIq5ppNvJJm8YAF5wZVFn2yEUD7YkDD9rSX22uQvHLTxW/S+dHnHvw1AFv+oBrkt+d/tcvMg==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr2338202wmg.78.1544396201259;
        Sun, 09 Dec 2018 14:56:41 -0800 (PST)
Received: from localhost.localdomain (x4db97970.dyn.telefonica.de. [77.185.121.112])
        by smtp.gmail.com with ESMTPSA id w6sm12581807wme.46.2018.12.09.14.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 14:56:40 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 4/7] test-lib: set $TRASH_DIRECTORY earlier
Date:   Sun,  9 Dec 2018 23:56:25 +0100
Message-Id: <20181209225628.22216-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
In-Reply-To: <20181209225628.22216-1-szeder.dev@gmail.com>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A later patch in this series will need to know the path to the trash
directory early in 'test-lib.sh', but $TRASH_DIRECTORY is set much
later.  Furthermore, the path to the trash directory depends on the
'--root=<path>' option, which, too, is parsed too late.

Move parsing '--root=...' to the early option parsing loop, and set
$TRASH_DIRECTORY where the other test-specific path variables are set.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 09c77cbd1b..ea1cd34013 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -85,6 +85,8 @@ do
 		valgrind=${opt#--*=} ;;
 	--valgrind-only=*)
 		valgrind_only=${opt#--*=} ;;
+	--root=*)
+		root=${opt#--*=} ;;
 	*)
 		# Other options will be handled later.
 	esac
@@ -93,6 +95,12 @@ done
 TEST_NAME="$(basename "$0" .sh)"
 TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
 TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME"
+TRASH_DIRECTORY="trash directory.$TEST_NAME"
+test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
+case "$TRASH_DIRECTORY" in
+/*) ;; # absolute path is good
+ *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
+esac
 
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
@@ -318,9 +326,6 @@ do
 		with_dashes=t; shift ;;
 	--no-color)
 		color=; shift ;;
-	--root=*)
-		root=${1#--*=}
-		shift ;;
 	--chain-lint)
 		GIT_TEST_CHAIN_LINT=1
 		shift ;;
@@ -351,7 +356,8 @@ do
 	-V|--verbose-log|\
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind|\
 	--valgrind=*|\
-	--valgrind-only=*)
+	--valgrind-only=*|\
+	--root=*)
 		shift ;; # These options were handled already.
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
@@ -1040,12 +1046,6 @@ then
 fi
 
 # Test repository
-TRASH_DIRECTORY="trash directory.$TEST_NAME"
-test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
-case "$TRASH_DIRECTORY" in
-/*) ;; # absolute path is good
- *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
-esac
 rm -fr "$TRASH_DIRECTORY" || {
 	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
-- 
2.20.0.rc2.156.g5a9fd2ce9c

