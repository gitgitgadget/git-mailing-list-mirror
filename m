Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A87C61DA0
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjAYEE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjAYEEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:13 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB04AA40
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso375242wmn.5
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ7NILSD4/Y/i4ydLhrXOqJ6DVvf6Azb/dVXvgpy4t0=;
        b=GXJ3QWlVBGaTeWBj2aU3unywJaqoWqGNcKkyXBet/P4WPq1wOL5Fkw+o2FgifhM001
         1qILme+YB11AZ2Vp2trVKmXCKnoWViyioma3g5OUYXFrTbTY+a2uCJNPgF6obW9100YA
         9QjNv4kKAIwMZ1QL2oMqMMUpeV05GwYv1Ebm1mjAtKnTjSSabagXdCM4vWm1xrQ/UQLe
         m2sGYv7zMpE7BR8xLnFalEkKI51yHE2yAyzJ7AXHiYTFLbnwcWZrc84xW0Iqo+koizfK
         tvnGpchtBi0SMi0IKzJEAMlyqp7dXWTw7AwCXNJw/mL2fnbjgNV+E1V4O+ALf46XZX5f
         EEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJ7NILSD4/Y/i4ydLhrXOqJ6DVvf6Azb/dVXvgpy4t0=;
        b=J1AIYvwX3AyQOjVDNJNkb2MGJ+LBoSaU47sPowlHRa8wDKqqVx664reZpN9jhkKoMR
         yAM1bwtCyAbEGZpv1LxDJDAk0eLGKxRY2MgYyb4BjroeiMKeeOf527CUBiNYwaFFE5KW
         knOn7nmcim7aHS9RASVtNA/yrXjfUQbgzvqKjWwWbxoTl7oEV+siZIWYE3aVvv5IcjD+
         CrKCrfATeB1xla1LZ2mPj5KLuyDLjm2GZsZYCf2Mpun/hAXYN9b8ef/M+/YO4kGvDe3y
         sKdBMNVYAGe0ohCwnOdpt0jKLO6Uoj9jzuMpYVY3cP03DveSfaiSttqu9jbcLG4FTTh2
         h1Iw==
X-Gm-Message-State: AFqh2kqMpOHBCLqSvU8zB0cEBqdWynNwijGKIgOnz/erhOVQxMiESs8g
        XZc4O5GH5yNJPuJL2hjNoQFKqoAELSE=
X-Google-Smtp-Source: AMrXdXuESSsEdZuuJsKNjfQvsnEmo1pzZjgHhw0g0cruLx0/794sAIGQMQS8tffkqGrr5eBE8EkGUA==
X-Received: by 2002:a05:600c:3b84:b0:3da:fd7c:98b3 with SMTP id n4-20020a05600c3b8400b003dafd7c98b3mr29836744wms.25.1674619446738;
        Tue, 24 Jan 2023 20:04:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc350000000b003d9aa76dc6asm736294wmj.0.2023.01.24.20.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:04:06 -0800 (PST)
Message-Id: <328f5a1d534dca2998785d1fad555e3645bc2c81.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:54 +0000
Subject: [PATCH v5 10/10] rebase: provide better error message for apply
 options vs. merge config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When config which selects the merge backend (currently,
rebase.autosquash=true or rebase.updateRefs=true) conflicts with other
options on the command line (such as --whitespace=fix), make the error
message specifically call out the config option and specify how to
override that config option on the command line.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           |  2 +-
 builtin/rebase.c                       | 27 ++++++++++++++++++++------
 t/t3422-rebase-incompatible-options.sh | 24 +++++++++++++++++++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 99aadac28ef..9a295bcee45 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -648,7 +648,7 @@ are incompatible with the following options:
  * --merge
  * --strategy
  * --strategy-option
- * --[no-]autosquash
+ * --autosquash
  * --rebase-merges
  * --interactive
  * --exec
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ad5ebecbbdb..7171be40eeb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -122,6 +122,8 @@ struct rebase_options {
 	int reapply_cherry_picks;
 	int fork_point;
 	int update_refs;
+	int config_autosquash;
+	int config_update_refs;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -136,6 +138,10 @@ struct rebase_options {
 		.fork_point = -1,			\
 		.reapply_cherry_picks = -1,             \
 		.allow_empty_message = 1,               \
+		.autosquash = -1,                       \
+		.config_autosquash = -1,                \
+		.update_refs = -1,                      \
+		.config_update_refs = -1,               \
 	}
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -778,7 +784,7 @@ static int rebase_config(const char *var, const char *value, void *data)
 	}
 
 	if (!strcmp(var, "rebase.autosquash")) {
-		opts->autosquash = git_config_bool(var, value);
+		opts->config_autosquash = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -795,7 +801,7 @@ static int rebase_config(const char *var, const char *value, void *data)
 	}
 
 	if (!strcmp(var, "rebase.updaterefs")) {
-		opts->update_refs = git_config_bool(var, value);
+		opts->config_update_refs = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -1366,7 +1372,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
 	    (options.action != ACTION_NONE) ||
 	    (options.exec.nr > 0) ||
-	    options.autosquash) {
+	    (options.autosquash == -1 && options.config_autosquash == 1) ||
+	    options.autosquash == 1) {
 		allow_preemptive_ff = 0;
 	}
 	if (options.committer_date_is_author_date || options.ignore_date)
@@ -1499,20 +1506,28 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (strcmp(options.git_am_opts.v[i], "-q"))
 				break;
 
-		if (i >= 0) {
+		if (i >= 0 || options.type == REBASE_APPLY) {
 			if (is_merge(&options))
 				die(_("apply options and merge options "
 					  "cannot be used together"));
+			else if (options.autosquash == -1 && options.config_autosquash == 1)
+				die(_("apply options are incompatible with rebase.autosquash.  Consider adding --no-autosquash"));
+			else if (options.update_refs == -1 && options.config_update_refs == 1)
+				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
 			else
 				options.type = REBASE_APPLY;
 		}
 	}
 
-	if (options.update_refs)
+	if (options.update_refs == 1)
 		imply_merge(&options, "--update-refs");
+	options.update_refs = (options.update_refs >= 0) ? options.update_refs :
+			     ((options.config_update_refs >= 0) ? options.config_update_refs : 0);
 
-	if (options.autosquash)
+	if (options.autosquash == 1)
 		imply_merge(&options, "--autosquash");
+	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
+			     ((options.config_autosquash >= 0) ? options.config_autosquash : 0);
 
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 6a17b571ec7..4711b37a288 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -94,6 +94,30 @@ test_rebase_am_only () {
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --root A
 	"
+
+	test_expect_success "$opt incompatible with rebase.autosquash" "
+		git checkout B^0 &&
+		test_must_fail git -c rebase.autosquash=true rebase $opt A 2>err &&
+		grep -e --no-autosquash err
+	"
+
+	test_expect_success "$opt incompatible with rebase.updateRefs" "
+		git checkout B^0 &&
+		test_must_fail git -c rebase.updateRefs=true rebase $opt A 2>err &&
+		grep -e --no-update-refs err
+	"
+
+	test_expect_success "$opt okay with overridden rebase.autosquash" "
+		test_when_finished \"git reset --hard B^0\" &&
+		git checkout B^0 &&
+		git -c rebase.autosquash=true rebase --no-autosquash $opt A
+	"
+
+	test_expect_success "$opt okay with overridden rebase.updateRefs" "
+		test_when_finished \"git reset --hard B^0\" &&
+		git checkout B^0 &&
+		git -c rebase.updateRefs=true rebase --no-update-refs $opt A
+	"
 }
 
 # Check options which imply --apply
-- 
gitgitgadget
