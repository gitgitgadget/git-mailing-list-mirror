Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83585C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiGSVFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbiGSVFi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:05:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F6445066
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so23420606wrq.7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35i/objSbLTxVrfBhMzBkAWZc5dl2/zkePPBgmTlLlw=;
        b=IEzK/oobP9knDgbiA1TLGOh1rCvPNQQH12+B//zXyEdZiMjlhaXyIeAkHThAzEZqRU
         MotD4uci4mCbJQACXhnqnUkrGa6wHjgHAG2zw/NlZIBxXLfmbf9x9tW1USnewI7eV5Kc
         zB2+n5f6Gb2KuD/lSe/Nx2HT6x+lCueED4f/RGzgypjw6mxDe2D29pDz00aynF3z/ZqS
         YbHRE0o7lkVuh2492W/tUOa43BPEbkF9XrjT4mTYlxpqMCgYTi2vr9WRaqDa3H1BMhcj
         ULaC/ACZA1I2lTBqqhAOJlT1/m3wtX0TKE2wru9suK9+N6nhz2MlUuYbqZ2rlx+FRYN8
         l1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35i/objSbLTxVrfBhMzBkAWZc5dl2/zkePPBgmTlLlw=;
        b=aJczE1kVosrToLohZfdR4gZ+U/pSR0R0kXASRwqwpV4Ag6CqjFwPE+u0mC6k5xDqYp
         qNA03DUmHhgQ0UAjf7zsoufNRAAFUdIE59XxWA3o7Se555OGNGK3OqdGadBCxxb7QZnH
         ewGVukTexbppcxoPlvpXm4f5+wZQM51/hyTrlbDHgHD8dndHFCQDef0N/a8JU68jXhjM
         FUWgnEu7EgpstjKMGh1ucE05CzgnwDynaIYWPjqk5S2VyI3O1Qbk/GxcTxE2ko+gkGhZ
         o+s73eQT+m4xpuZdyJV4GVqagpQR0ioGpvR3UQAZ2bTYxh70inhpIeNylrIQHlN0uslA
         qK9w==
X-Gm-Message-State: AJIora+KJCS71zTH82BnRyP4OF23uBx7K0YWhy6viOk9MYeFNmuAe9L7
        a9W0VYnlKZ/+LqRPKnFAOF3oSSeghdVWDg==
X-Google-Smtp-Source: AGRyM1tuHEP7H4XFEAn+XtGzaofXsD9KM69sCF4CN3NmMsc7GRcqSZf1pwNolwJriBqIzlg78HK9yA==
X-Received: by 2002:adf:f602:0:b0:21d:6662:f9e4 with SMTP id t2-20020adff602000000b0021d6662f9e4mr29544900wrp.353.1658264735700;
        Tue, 19 Jul 2022 14:05:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c461800b003a050a391e8sm75091wmo.38.2022.07.19.14.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:05:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] test-lib.sh: fix GIT_EXIT_OK logic errors, use BAIL_OUT
Date:   Tue, 19 Jul 2022 23:05:17 +0200
Message-Id: <patch-03.10-e57e7ca898e-20220719T205710Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1063.gd87c5b8cc23
In-Reply-To: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change various "exit 1" checks that happened after our "die" handler
had been set up to use BAIL_OUT instead. See 234383cd401 (test-lib.sh:
use "Bail out!" syntax on bad SANITIZE=leak use, 2021-10-14) for the
benefits of the BAIL_OUT function.

The previous use of "error" here was not a logic error, but the "exit"
without "GIT_EXIT_OK" would emit the "FATAL: Unexpected exit with code
$code" message on top of the error we wanted to emit.

Since we'd also like to stop "prove" in its tracks here, the right
thing to do is to emit a "Bail out!" message.

Let's also move the "GIT_EXIT_OK=t" assignments to just above the
"exit [01]" in "test_done". It's not OK if we exit in
e.g. finalize_test_output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c8c84ef9b14..118720493bb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1173,8 +1173,6 @@ test_done () {
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
-	GIT_EXIT_OK=t
-
 	finalize_test_output
 
 	if test -z "$HARNESS_ACTIVE"
@@ -1246,6 +1244,7 @@ test_done () {
 		fi
 		test_at_end_hook_
 
+		GIT_EXIT_OK=t
 		exit 0 ;;
 
 	*)
@@ -1255,6 +1254,7 @@ test_done () {
 			say "1..$test_count"
 		fi
 
+		GIT_EXIT_OK=t
 		exit 1 ;;
 
 	esac
@@ -1387,14 +1387,12 @@ fi
 GITPERLLIB="$GIT_BUILD_DIR"/perl/build/lib
 export GITPERLLIB
 test -d "$GIT_BUILD_DIR"/templates/blt || {
-	error "You haven't built things yet, have you?"
+	BAIL_OUT "You haven't built things yet, have you?"
 }
 
 if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool$X
 then
-	echo >&2 'You need to build test-tool:'
-	echo >&2 'Run "make t/helper/test-tool" in the source (toplevel) directory'
-	exit 1
+	BAIL_OUT 'You need to build test-tool; Run "make t/helper/test-tool" in the source (toplevel) directory'
 fi
 
 # Are we running this test at all?
@@ -1448,9 +1446,7 @@ remove_trash_directory () {
 
 # Test repository
 remove_trash_directory "$TRASH_DIRECTORY" || {
-	GIT_EXIT_OK=t
-	echo >&5 "FATAL: Cannot prepare test area"
-	exit 1
+	BAIL_OUT 'cannot prepare test area'
 }
 
 remove_trash=t
@@ -1466,7 +1462,7 @@ fi
 
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
-cd -P "$TRASH_DIRECTORY" || exit 1
+cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
 
 start_test_output "$0"
 
-- 
2.37.1.1062.g385eac7fccf

