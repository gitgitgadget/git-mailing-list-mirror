Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53C2C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiG0XOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiG0XNz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:13:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9F64D4C6
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l4so82696wrm.13
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MxrZwK2IO/lfHzmu3Mgjck9SJ+jxnQ7/NsPXIxvVSqk=;
        b=SBHYzozUJ+StD5RGsouW5/WdHmNvgwnmcn9+26UXSDllFjrOV3kXmyzGzQXZy7ckFN
         8HuZrAp+IkLFEnqQ+Y5+LCU4AHJhpeHu3oh5waGzVurTDbJGvdLDNd3KhCLr7i9I/jD6
         TVw7SgafVQpvUPP9MrO4mLjO57qrWByj5MUdpa1d6nkHl/Y0506taQosr/anvWyXYzmD
         cc3Mda5tPpOkk79BKtJVXo9+ElK2uDfYvnwhrr5FWItM6Kyl1QPKQWbZSXejY/1ISWn1
         C1yizNud0oV5MudhY0WfEoh9VnwPxgSJyA44RPpEWUGQUnOJPjjDW7WnnRG5R3fusYa2
         JOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MxrZwK2IO/lfHzmu3Mgjck9SJ+jxnQ7/NsPXIxvVSqk=;
        b=L5UyOsHgdOHg5X7TDMvjwJdMPcKvMMJ0s3W8IP/vi76hNVUsbzg4RQaYdd64AS/g1C
         SKFgIlsvNN2LRfxXjhJsCXJph3NHCfV5ZGtzEoQVkpIGF7PqKbrrg4crD79KO3DH4O0O
         bQmyyzFyw8+NyV/cJ6GuVAly0NT5hDv2i15S9V1JSZNAuqscq4QwsmQOmzc/r8LTidPz
         5KYfVZLGIAK0tBg2VEW4JH3k0rA9NE7obAJslSrLmyYJ5Kipo2D1FgMaq1zEpYjxt3Rg
         CzMuYar0wNo9p1Qxey0QlZ4lyvzAJKkGuV+Z/qeHhmRJB/1u5JLPyvL1Q1PVJUWMbC0m
         fIUA==
X-Gm-Message-State: AJIora9cV48I6wbozihp1BxGQWeNF+gdjZ5FC02p54Kyjetrm302X2zo
        I6KWP2JRwS09pM5IkzWRm0qDw1mTBj0fVQ==
X-Google-Smtp-Source: AGRyM1uR9Asz1q85W8Ld93hQJmYoCr26aJkBnI7B1u3DOFNLubIvQ/Ck7e6IBEu9SsLM2Tzg4AB8KA==
X-Received: by 2002:a5d:4345:0:b0:21a:3b82:ad57 with SMTP id u5-20020a5d4345000000b0021a3b82ad57mr16105483wrr.176.1658963631544;
        Wed, 27 Jul 2022 16:13:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:13:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/15] test-lib: fix GIT_EXIT_OK logic errors, use BAIL_OUT
Date:   Thu, 28 Jul 2022 01:13:31 +0200
Message-Id: <patch-v3-03.15-385d5c52d5a-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
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
2.37.1.1127.g4ecf1c08f67

