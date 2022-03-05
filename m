Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08928C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiCEAQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiCEAPz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:15:55 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86D2244A16
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:15:06 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id n8-20020a654508000000b003783b1e9834so5329210pgq.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T/Iz4J+V1wAzPoe3joFAEsv2MKAKPMbyTHFpG6YlcAo=;
        b=qCurjJHqG7FV9Mtg4sCvXlPVWV4XjXM2mYNhvcLeA1Y0MTCuqaTcB4D9Q1fuOVEFfb
         lfuYPhATv5GFyO/jP9IFYRmGkt3/RszT5McL5uJ0NkLKiGp31VARepoX6Gq6kQsb4You
         EnF59otBErsyyBL1U7D1wXaaAOTQFauiOrGr1vehiG6sz6rc0h9RE6UqJXgBjZtUk9cl
         WKxAvhZkt1uGM73nV3rpeHKNNYUHl3t63EPUDjog9VJE27c6qW2mNYusP9xyBXZ5eBnu
         eJ1hKtNAU8Xj8FKAwg3nbcckJZlAwnOrO65xX2fVh0fdp2tAhw4LOG7g+m2mJL1hggih
         xbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T/Iz4J+V1wAzPoe3joFAEsv2MKAKPMbyTHFpG6YlcAo=;
        b=IU0f/NhsFLOzZDSV6VpxgrUCYUc4pOd9hvQt4Ig7E12iK3TzE1foUD5N4aQjXHx0Ci
         fnkhhCkpd6TSwUK9du4SjUTp9TdfwwCbbrhoz6ikw5r5AEtukoEqykTpc2s2Tp9+zc/l
         v7Zf2TMAuzHgbcJ06q8mdklOdYX0uL6scgrR4RpbV/wSBB4D3wIxPzi5bUmZShEaaHDA
         LrYgb9RgHv08agA8epTN2nkVAfbTSkIPXLAXfSChnP9IWM3BLXXgdTuRriYjSXofCeL/
         jeLce8rCXSwANzXgE9EDIer4QlkCiIhbDLWuPWnXaKvZT2/46c0prB6QWyYja9VfUnKg
         tIfw==
X-Gm-Message-State: AOAM531xeMcRbNXLDnwRaEQ7pnHq+ZpqElUnz0UGrt6XYcthpy9HupIk
        JU6KNX+cuTq1bVsI/INIHsombyR8NOcrpJfHeANSdN8n6kxUijKNa+/mS+DtstBoVK5qzzuY30S
        vqGlQ23hnjBu/omXrRNJ8Bso5Cc9sRibHbpYHumiyfUKrmN5LdZVwgd5qycFCeWc=
X-Google-Smtp-Source: ABdhPJzVCdS6sco0yjRFUVWbLeVzlpR5Ur3MrGjGT9Glk0MqXrcx2oAePqXrq4LKVPENrOAs9eCnuSYBOoA8oQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:890:b0:4f6:686e:a8a9 with SMTP
 id q16-20020a056a00089000b004f6686ea8a9mr986762pfj.83.1646439306165; Fri, 04
 Mar 2022 16:15:06 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:55 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 07/13] submodule--helper run-update-procedure: learn --remote
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach run-update-procedure to handle --remote instead of parsing
--remote in git-submodule.sh. As a result, "git submodule--helper
[print-default-remote|remote-branch]" have no more callers, so remove
them.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 56 +++++++++++++++----------------------
 git-submodule.sh            | 30 +-------------------
 2 files changed, 23 insertions(+), 63 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3832dccae5..f673f7ebbf 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -72,21 +72,6 @@ static char *get_default_remote(void)
 	return repo_get_default_remote(the_repository);
 }
 
-static int print_default_remote(int argc, const char **argv, const char *prefix)
-{
-	char *remote;
-
-	if (argc != 1)
-		die(_("submodule--helper print-default-remote takes no arguments"));
-
-	remote = get_default_remote();
-	if (remote)
-		printf("%s\n", remote);
-
-	free(remote);
-	return 0;
-}
-
 static int starts_with_dot_slash(const char *str)
 {
 	return str[0] == '.' && is_dir_sep(str[1]);
@@ -2027,6 +2012,7 @@ struct update_data {
 	unsigned int quiet;
 	unsigned int nofetch;
 	unsigned int just_cloned;
+	unsigned int remote;
 };
 #define UPDATE_DATA_INIT { .update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT }
 
@@ -2603,6 +2589,8 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
 			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
+		OPT_BOOL(0, "remote", &update_data.remote,
+			 N_("use SHA-1 of submodule's remote tracking branch")),
 		OPT_END()
 	};
 
@@ -2682,23 +2670,6 @@ static const char *remote_submodule_branch(const char *path)
 	return branch;
 }
 
-static int resolve_remote_submodule_branch(int argc, const char **argv,
-		const char *prefix)
-{
-	const char *ret;
-	struct strbuf sb = STRBUF_INIT;
-	if (argc != 2)
-		die("submodule--helper remote-branch takes exactly one arguments, got %d", argc);
-
-	ret = remote_submodule_branch(argv[1]);
-	if (!ret)
-		die("submodule %s doesn't exist", argv[1]);
-
-	printf("%s", ret);
-	strbuf_release(&sb);
-	return 0;
-}
-
 static int push_check(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
@@ -3040,6 +3011,25 @@ static int update_submodule2(struct update_data *update_data)
 		die(_("Unable to find current revision in submodule path '%s'"),
 			update_data->displaypath);
 
+	if (update_data->remote) {
+		char *remote_name = get_default_remote_submodule(update_data->sm_path);
+		const char *branch = remote_submodule_branch(update_data->sm_path);
+		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
+
+		if (!update_data->nofetch) {
+			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
+					      0, NULL))
+				die(_("Unable to fetch in submodule path '%s'"),
+				    update_data->sm_path);
+		}
+
+		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
+			die(_("Unable to find %s revision in submodule path '%s'"),
+			    remote_ref, update_data->sm_path);
+
+		free(remote_ref);
+	}
+
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
 		return do_run_update_procedure(update_data);
 
@@ -3439,11 +3429,9 @@ static struct cmd_struct commands[] = {
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
-	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 32a09302ab..882bf097d5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -247,20 +247,6 @@ cmd_deinit()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
-# usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
-# Because arguments are positional, use an empty string to omit <depth>
-# but include <sha1>.
-fetch_in_submodule () (
-	sanitize_submodule_env &&
-	cd "$1" &&
-	if test $# -eq 3
-	then
-		echo "$3" | git fetch ${GIT_QUIET:+--quiet} --stdin ${2:+"$2"}
-	else
-		git fetch ${GIT_QUIET:+--quiet} ${2:+"$2"}
-	fi
-)
-
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -411,21 +397,6 @@ cmd_update()
 			just_cloned=
 		fi
 
-		if test -n "$remote"
-		then
-			branch=$(git submodule--helper remote-branch "$sm_path")
-			if test -z "$nofetch"
-			then
-				# Fetch remote before determining tracking $sha1
-				fetch_in_submodule "$sm_path" $depth ||
-				die "fatal: $(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
-			fi
-			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
-			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
-		fi
-
 		out=$(git submodule--helper run-update-procedure \
 			  ${wt_prefix:+--prefix "$wt_prefix"} \
 			  ${GIT_QUIET:+--quiet} \
@@ -436,6 +407,7 @@ cmd_update()
 			  ${update:+--update "$update"} \
 			  ${prefix:+--recursive-prefix "$prefix"} \
 			  ${sha1:+--oid "$sha1"} \
+			  ${remote:+--remote} \
 			  "--" \
 			  "$sm_path")
 
-- 
2.33.GIT

