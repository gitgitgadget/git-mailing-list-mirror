Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9ABC61D9D
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAVGNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAVGMw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:12:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F004C18A94
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:50 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso6381314wms.3
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKvywFic2idymqZrC+B70vV/Ye3CoIxnWj1qKI+swdE=;
        b=aTZlO/l1i/xqh1EfYjoAkS8DTK53Jv+ngTz3jNZ4LchoAUXt3bLD2FLJ3XbgRDIBye
         Ra1pCWpJ0B36M77WvmZBfwHxuazf2KQ3l3P1TPeQxvwXICuUN00rGfBSSsbIVID8deEz
         fO7ITwYFIIkqQzzm0A1miJv6hIVpDCQZAEd2vvVXazfvWsmvG+P3kLaxg4RThLdYQA+6
         1G80teHNXU5TEvfhvvL4Fqn5IQ6FGQpBtcQfVBNojdz5wqxHtZOi2zVEAyPl06qkFxBv
         FAaSfjM3fTVPkJ+vaCZz0EApELBMWpvKtPd5nD9JuAJGjRFu6YS2OFt7bsfP7UHWkYWm
         pvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKvywFic2idymqZrC+B70vV/Ye3CoIxnWj1qKI+swdE=;
        b=3yQdGATnO72mLprNzJhiX4PLFfNfs67/Zt1YWtym644w9cA8ELmAGWWwj0eNVljnQS
         7eiAT48LLScfYh33/SwQWEptY79k49AYZV3mItfOaxdrYTxVHfcF0jp8axdsRrwLzvo1
         S4YueTEdCtPT/kH0H5RgobryRcP7Ff+cL27SNYqK3bQkaMGpMmsiQj/SiRzD5HSp7mA2
         7rZL3cJNZ/dBwHDX26WqA9T4itDbGYamj6cJOVIlmoYN5HASH726TT3Yv+BgOrSLed4B
         hZOpjR3+Zeig7bBLkcT9RHx/03pniPjAGay/+xciMDT+PCzWAEyyvX565mKQOqcqTLim
         o5Zg==
X-Gm-Message-State: AFqh2koK0rh88IA7Qsy3W8N3ZPTr1h/nscVqvrbywCHJ2Bhp39A5JGjs
        /50BbcfhSzZy4Q1JmUNPS7k83oGRoog=
X-Google-Smtp-Source: AMrXdXs0+uEJgIWFTNF87SrGGKt1ItsauJ0MPPw3c8LrVrcDh28wtOoulEL1+FK+myvMXBIJHtJU6w==
X-Received: by 2002:a05:600c:348f:b0:3db:742:cfe9 with SMTP id a15-20020a05600c348f00b003db0742cfe9mr19616921wmq.34.1674367969276;
        Sat, 21 Jan 2023 22:12:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18-20020adf8b92000000b002365730eae8sm1750581wra.55.2023.01.21.22.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 22:12:49 -0800 (PST)
Message-Id: <5cb00e5103bd701a90ea3f5b3532fa184b6e6ae9.1674367961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
        <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 06:12:40 +0000
Subject: [PATCH v4 9/9] rebase: provide better error message for apply options
 vs. merge config
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
index 9f794f5bdcc..c357f6c3d5c 100644
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
index 2358605b254..dd7e2c788f5 100644
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
 
@@ -1393,7 +1399,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
 	    (options.action != ACTION_NONE) ||
 	    (options.exec.nr > 0) ||
-	    options.autosquash) {
+	    (options.autosquash == -1 && options.config_autosquash == 1) ||
+	    options.autosquash == 1) {
 		allow_preemptive_ff = 0;
 	}
 	if (options.committer_date_is_author_date || options.ignore_date)
@@ -1504,20 +1511,28 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
