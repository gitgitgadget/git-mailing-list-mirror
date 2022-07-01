Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727FCC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiGAKnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiGAKnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E61133
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s1so2590903wra.9
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1eePcBYu3uxbrSiX+ddDLtuX4fHnpa/D3V3RjiKveI=;
        b=iswS2dv21S9DvK0TS/YVyiiboGNp3RH4ThnIw5K3ReFBwWy34ZrJXdLPIUUuNglla4
         Fl+hAm/JXwal4qb97GKCRTxD8AHFSqrTnntjZ9UTWg0AqyMLBu7gnsC3YE5p/4of1bWh
         3lqLzjBO/vjpHabJUbEKZBkSLXixJczPmDrl+rLCyn1VEsHv8oSXepRrHZ287qFwtmig
         HM+TOg0s/+JEqPcHLFLN0SZe9vg1GaqpeMZbexcu7jNX6B2fGhqwqk6A4W9T7xugzSmL
         XxXzVA4B1NmNBwMPON2pjkR11vKWOCVo3vB3s/bJ5fE6jguUnjV3vbWrX6BIBnb8nHG1
         Q0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1eePcBYu3uxbrSiX+ddDLtuX4fHnpa/D3V3RjiKveI=;
        b=g57pC8mxaV1esc4/eIgCARgSwUIR/dg2yX/0gwacHktB9D1VXFluGNt/MteIzpKAfa
         wJqLnI/IlZRByIcdPw3ALFQeRQJb/RuN7HBLVGwkNayzoe1gpTV9KJa2h3N8x81UzvaM
         REqbXCxKbMrDfeOC6KbzphGDcYbAi4ZhV/O3GHUc4KbCXYoYk+pO+1s9B7ecKa0pxQhg
         3C8DN2aWKEWY9xHm91sVQP05fZtSc5ddVLLWOxw+a/FCZrws9ML6g/+qhbpQGD5LKzv8
         MGxdyFlfvkizFKgmYutymT03blFsY/F+5V2WW8unMeI+h+wh9cDwdfOQtRDwBgFBlNH2
         hcKA==
X-Gm-Message-State: AJIora8t3QbBtvZhy7PpdY9BgUIm+nU3b3Rf04oa75FsCF1zXEnP1GM+
        6dQfLXf8P6R+tEJVVMXOUt7yoxROSpYnfw==
X-Google-Smtp-Source: AGRyM1slufma5X9vHZ0/MYT5YjHQToI5efiTMMcOOLU4oHwHYhEah5Pxoe6bPbHOIrJjTxmW/13i5g==
X-Received: by 2002:a05:6000:601:b0:21b:8d2c:8afc with SMTP id bn1-20020a056000060100b0021b8d2c8afcmr12814401wrb.458.1656672193199;
        Fri, 01 Jul 2022 03:43:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/11] pull: fix a "struct oid_array" memory leak
Date:   Fri,  1 Jul 2022 12:43:00 +0200
Message-Id: <patch-v2-11.11-5666104943f-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in 44c175c7a46 (pull: error on no merge
candidates, 2015-06-18). As a result we can mark several tests as
passing with SANITIZE=leak using "TEST_PASSES_SANITIZE_LEAK=true".

Removing the "int ret = 0" assignment added here in a6d7eb2c7a6 (pull:
optionally rebase submodules (remote submodule changes only),
2017-06-23) is not a logic error, it could always have been left
uninitialized (as "int ret"), now that we'll use the "ret" from the
upper scope we can drop the assignment in the "opt_rebase" branch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pull.c               | 16 ++++++++++------
 t/t5524-pull-msg.sh          |  1 +
 t/t6417-merge-ours-theirs.sh |  1 +
 t/t9101-git-svn-props.sh     |  1 -
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 01155ba67b2..403a24d7ca6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -990,6 +990,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	int rebase_unspecified = 0;
 	int can_ff;
 	int divergent;
+	int ret;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -1100,7 +1101,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (is_null_oid(&orig_head)) {
 		if (merge_heads.nr > 1)
 			die(_("Cannot merge multiple branches into empty head."));
-		return pull_into_void(merge_heads.oid, &curr_head);
+		ret = pull_into_void(merge_heads.oid, &curr_head);
+		goto cleanup;
 	}
 	if (merge_heads.nr > 1) {
 		if (opt_rebase)
@@ -1125,8 +1127,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	}
 
 	if (opt_rebase) {
-		int ret = 0;
-
 		struct object_id newbase;
 		struct object_id upstream;
 		get_rebase_newbase_and_upstream(&newbase, &upstream, &curr_head,
@@ -1149,12 +1149,16 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
 			ret = rebase_submodules();
 
-		return ret;
+		goto cleanup;
 	} else {
-		int ret = run_merge();
+		ret = run_merge();
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
 			ret = update_submodules();
-		return ret;
+		goto cleanup;
 	}
+
+cleanup:
+	oid_array_clear(&merge_heads);
+	return ret;
 }
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index b2be3605f5a..56716e29ddf 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -2,6 +2,7 @@
 
 test_description='git pull message generation'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 dollar='$Dollar'
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index 62d1406119e..482b73a998f 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -4,6 +4,7 @@ test_description='Merge-recursive ours and theirs variants'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index d043e80fc34..52046e60d51 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn property tests'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 mkdir import
-- 
2.37.0.900.g4d0de1cceb2

