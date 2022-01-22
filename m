Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5745C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 18:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiAVSgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 13:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbiAVSf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 13:35:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4220C061401
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 10:35:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s18so5934854wrv.7
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 10:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=GmdRpvBz1XQEaQ/Ok30KtN/n17H0Td/yUpCS7K+Rxco=;
        b=SIgroYyxtoRu0bXmrRoQZK71yVGBjl1aZJ3Zh05dPfwapZdcTUXXTjPDYdaDc85BqR
         KMyrENfuJmdwlTOWsoy4/aUL3hsci/p/cjiFlhwCngMZ5Yq8y1/1gToO1yrc1lirJn40
         5tKxPb7JYk0tRKo7yL3RTg5uOJE2dsYndGZcIEmFQwi2yY/DNbNkEKE4EQ2rppIBhHvz
         een4Smv/1sXQnDulnsftx4NYrG4rk/iSGTls2PaQoXz9dEYKQuol9NbEvF5lTBpODEBf
         KVTLYJyF6RxDRBNPL25LKRTKu0aQg+TMieZZvfheTOMb4LnCWAZIqruSjGsVqEs2wf5I
         iZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=GmdRpvBz1XQEaQ/Ok30KtN/n17H0Td/yUpCS7K+Rxco=;
        b=rVEXUHS6EAHf9ViGNpROU00wHVwQbv4NChY4jZSXZiGgOIdisFA/J/HuT2VghLjwHZ
         Rl3LvZi4lrwg7AcQEKHFMDikfbevj2uHShzz/0KyjDbUuyJvaa7yzuWErJzUxSRBGjU+
         9a43U12K+EZJlyn1ajY094/GA2JM/UUVlHbwPJx8zuu7r4b8vOilCe+vIf07vC8DsRzd
         6vWYUVvXa8TDPOZ31MEvZw3Ho+xJ4ZQyPfDpQkAuTHP6Qp+oiln9hZT71PBPiHeGofu3
         82TdqqK+cipJwo/PgsPBFzfIDZMYk5u/ZPsnU8ueZhR6lAkEAoP5KpHn5oSd51YXZEMd
         hPaQ==
X-Gm-Message-State: AOAM532evni6Kcux4+ZQQZvpb7yg1uRW29mgdz0ze/+yQLgS1Su2jzPN
        cxpuzR5zTCv69uiIsadffiexDqpwi6o=
X-Google-Smtp-Source: ABdhPJwSSYuYx3Hkwu1TG7sDLfG6lV5Fjla8Dzptu66d5EBA9VCx8ZIoAVb3t3KCVF9dHC8dEcaXdQ==
X-Received: by 2002:a05:6000:16cd:: with SMTP id h13mr8289087wrf.206.1642876557088;
        Sat, 22 Jan 2022 10:35:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13sm5704839wrv.94.2022.01.22.10.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 10:35:56 -0800 (PST)
Message-Id: <ca48e82a6b4a2581c815f796a303d411c27a0283.1642876553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 18:35:51 +0000
Subject: [PATCH 2/4] i18n: factorize "invalid value" messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Use the same message when an invalid value is passed to a command line
option or a configuration variable.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/am.c           | 7 ++++---
 builtin/blame.c        | 6 +++---
 builtin/fetch.c        | 4 ++--
 builtin/pack-objects.c | 2 +-
 builtin/pull.c         | 6 +++---
 builtin/push.c         | 2 +-
 builtin/send-pack.c    | 2 +-
 diff-merges.c          | 2 +-
 gpg-interface.c        | 4 ++--
 ls-refs.c              | 2 +-
 parallel-checkout.c    | 3 ++-
 sequencer.c            | 2 +-
 setup.c                | 2 +-
 submodule-config.c     | 2 +-
 t/t4150-am.sh          | 2 +-
 15 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index b6be1f1cb11..ba1dacbc034 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -199,7 +199,7 @@ static int am_option_parse_empty(const struct option *opt,
 	else if (!strcmp(arg, "keep"))
 		*opt_value = KEEP_EMPTY_COMMIT;
 	else
-		return error(_("Invalid value for --empty: %s"), arg);
+		return error(_("invalid value for '%s': '%s'"), "--empty", arg);
 
 	return 0;
 }
@@ -2239,7 +2239,7 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 	 * when you add new options
 	 */
 	else
-		return error(_("Invalid value for --patch-format: %s"), arg);
+		return error(_("invalid value for '%s': '%s'"), "--patch-format", arg);
 	return 0;
 }
 
@@ -2282,7 +2282,8 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 				break;
 		}
 		if (new_value >= ARRAY_SIZE(valid_modes))
-			return error(_("Invalid value for --show-current-patch: %s"), arg);
+			return error(_("invalid value for '%s': '%s'"),
+						 "--show-current-patch", arg);
 	}
 
 	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
diff --git a/builtin/blame.c b/builtin/blame.c
index 7fafeac4081..ca821420d68 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -721,8 +721,8 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "color.blame.repeatedlines")) {
 		if (color_parse_mem(value, strlen(value), repeated_meta_color))
-			warning(_("invalid color '%s' in color.blame.repeatedLines"),
-				value);
+			warning(_("invalid value for '%s': '%s'"),
+					"color.blame.repeatedLines", value);
 		return 0;
 	}
 	if (!strcmp(var, "color.blame.highlightrecent")) {
@@ -739,7 +739,7 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 			coloring_mode &= ~(OUTPUT_COLOR_LINE |
 					    OUTPUT_SHOW_AGE_WITH_COLOR);
 		} else {
-			warning(_("invalid value for blame.coloring"));
+			warning(_("invalid value for '%s': '%s'"), "blame.coloring", value);
 			return 0;
 		}
 	}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index eaab8056bf9..19ec48f3330 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -758,8 +758,8 @@ static void prepare_format_display(struct ref *ref_map)
 	else if (!strcasecmp(format, "compact"))
 		compact_format = 1;
 	else
-		die(_("configuration fetch.output contains invalid value %s"),
-		    format);
+		die(_("invalid value for '%s': '%s'"),
+			  "fetch.output", format);
 
 	for (rm = ref_map; rm; rm = rm->next) {
 		if (rm->status == REF_STATUS_REJECT_SHALLOW ||
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba2006f2212..192c3ca305e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3504,7 +3504,7 @@ static int option_parse_missing_action(const struct option *opt,
 		return 0;
 	}
 
-	die(_("invalid value for --missing"));
+	die(_("invalid value for '%s': '%s'"), "--missing", arg);
 	return 0;
 }
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 100cbf9fb85..e54a0ccadc6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -42,9 +42,9 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return v;
 
 	if (fatal)
-		die(_("Invalid value for %s: %s"), key, value);
+		die(_("invalid value for '%s': '%s'"), key, value);
 	else
-		error(_("Invalid value for %s: %s"), key, value);
+		error(_("invalid value for '%s': '%s'"), key, value);
 
 	return REBASE_INVALID;
 }
@@ -318,7 +318,7 @@ static const char *config_get_ff(void)
 	if (!strcmp(value, "only"))
 		return "--ff-only";
 
-	die(_("Invalid value for pull.ff: %s"), value);
+	die(_("invalid value for '%s': '%s'"), "pull.ff", value);
 }
 
 /**
diff --git a/builtin/push.c b/builtin/push.c
index 359db90321c..cad997965a7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -486,7 +486,7 @@ static int git_push_config(const char *k, const char *v, void *cb)
 				if (value && !strcasecmp(value, "if-asked"))
 					set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_IF_ASKED);
 				else
-					return error("Invalid value for '%s'", k);
+					return error(_("invalid value for '%s'"), k);
 			}
 		}
 	} else if (!strcmp(k, "push.recursesubmodules")) {
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 69c432ef1a6..64962be0168 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -145,7 +145,7 @@ static int send_pack_config(const char *k, const char *v, void *cb)
 				if (value && !strcasecmp(value, "if-asked"))
 					args.push_cert = SEND_PACK_PUSH_CERT_IF_ASKED;
 				else
-					return error("Invalid value for '%s'", k);
+					return error(_("invalid value for '%s'"), k);
 			}
 		}
 	}
diff --git a/diff-merges.c b/diff-merges.c
index 5060ccd890b..cd6c102a0d5 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -67,7 +67,7 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 	diff_merges_setup_func_t func = func_by_opt(optarg);
 
 	if (!func)
-		die(_("unknown value for --diff-merges: %s"), optarg);
+		die(_("invalid value for '%s': '%s'"), "--diff-merges", optarg);
 
 	func(revs);
 
diff --git a/gpg-interface.c b/gpg-interface.c
index b52eb0e2e04..04d751a16a8 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -702,7 +702,7 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		fmt = get_format_by_name(value);
 		if (!fmt)
-			return error("unsupported value for %s: %s",
+			return error("invalid value for '%s': '%s'",
 				     var, value);
 		use_format = fmt;
 		return 0;
@@ -717,7 +717,7 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		free(trust);
 
 		if (ret)
-			return error("unsupported value for %s: %s", var,
+			return error("invalid value for '%s': '%s'", var,
 				     value);
 		return 0;
 	}
diff --git a/ls-refs.c b/ls-refs.c
index 54078323dcb..ae09dd59478 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -34,7 +34,7 @@ static void ensure_config_read(void)
 		} else if (!strcmp(str, "ignore")) {
 			/* do nothing */
 		} else {
-			die(_("invalid value '%s' for lsrefs.unborn"), str);
+			die(_("invalid value for '%s': '%s'"), "lsrefs.unborn", str);
 		}
 	}
 	config_read = 1;
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 8dd7e7bad40..237c02f1d81 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -39,7 +39,8 @@ void get_parallel_checkout_configs(int *num_workers, int *threshold)
 
 	if (env_workers && *env_workers) {
 		if (strtol_i(env_workers, 10, num_workers)) {
-			die("invalid value for GIT_TEST_CHECKOUT_WORKERS: '%s'",
+			die(_("invalid value for '%s': '%s'"),
+				"GIT_TEST_CHECKOUT_WORKERS",
 			    env_workers);
 		}
 		if (*num_workers < 1)
diff --git a/sequencer.c b/sequencer.c
index 6abd72160cc..9b985e8648d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2806,7 +2806,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		return error(_("invalid key: %s"), key);
 
 	if (!error_flag)
-		return error(_("invalid value for %s: %s"), key, value);
+		return error(_("invalid value for '%s': '%s'"), key, value);
 
 	return 0;
 }
diff --git a/setup.c b/setup.c
index af3b8c09abe..fe74092a022 100644
--- a/setup.c
+++ b/setup.c
@@ -559,7 +559,7 @@ static enum extension_result handle_extension(const char *var,
 			return config_error_nonbool(var);
 		format = hash_algo_by_name(value);
 		if (format == GIT_HASH_UNKNOWN)
-			return error("invalid value for 'extensions.objectformat'");
+			return error(_("invalid value for '%s': '%s'"), "extensions.objectformat", value);
 		data->hash_algo = format;
 		return EXTENSION_OK;
 	}
diff --git a/submodule-config.c b/submodule-config.c
index f95344028b5..fb95a026f48 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -496,7 +496,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		else if (parse_submodule_update_strategy(value,
 			 &submodule->update_strategy) < 0 ||
 			 submodule->update_strategy.type == SM_UPDATE_COMMAND)
-			die(_("invalid value for %s"), var);
+			die(_("invalid value for '%s'"), var);
 	} else if (!strcmp(item.buf, "shallow")) {
 		if (!me->overwrite && submodule->recommend_shallow != -1)
 			warn_multiple_config(me->treeish_name, submodule->name,
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 6caff0ca397..159fae8d016 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1169,7 +1169,7 @@ test_expect_success 'invalid when passing the --empty option alone' '
 	test_when_finished "git am --abort || :" &&
 	git checkout empty-commit^ &&
 	test_must_fail git am --empty empty-commit.patch 2>err &&
-	echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
+	echo "error: invalid value for '\''--empty'\'': '\''empty-commit.patch'\''" >expected &&
 	test_cmp expected err
 '
 
-- 
gitgitgadget

