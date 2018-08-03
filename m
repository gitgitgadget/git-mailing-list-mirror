Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E721F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbeHDAWa (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:22:30 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:51522 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbeHDAW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:22:29 -0400
Received: by mail-it0-f73.google.com with SMTP id q5-v6so6588936ith.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Y3Z/oEFx2BJ+JXVgUhkVZ5jxKNUM+aw7YcKcz98TF1c=;
        b=HUMra8KmLmSNjjYlK6MWR03NLUcPWIooUQfS54x06fVCGeC+WUmJXUp8iHkSMXeddR
         /MmJIByuBuBHXT/ypwPxxgv/XXOMku0V1f0wEUgoJ/OmixbszdbULVtGogUcPYY3EEC1
         ackHkESf1deKiIx3FphAIVFNlWSyNvUxffepDhtJaVowtDHpR7ZyLRJJZl5IBdMbbsSX
         GNHauH0aEO6BGJBV79FnoxJgkOTJsd56Opdo7NfgWrYuHnl+sFTgEyaLFuXXTcT7V8ag
         1NSWYXZ6yAZ1dKJ3APGSmCLpJDT1FCI51hLrKmzpyjviK6nrLIPFArooPoKP5MLT4SWj
         Al7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Y3Z/oEFx2BJ+JXVgUhkVZ5jxKNUM+aw7YcKcz98TF1c=;
        b=pKY1fK2/XSX/gEBEBv0PY0NJIbYwwsaQ+n7ZUp4XwnwcfjToMaVEUoC0s5KIU5zkla
         Jfu7RMwhKXsnSxf5eFaC76A7uiIpgE3JzhlYDvl1Ke5RRy6Y/Rbc7M218ov039cCTPN5
         yZFpUpYLdz+/dLGv/CCCQ1AEzgEPS9v8WgA4RPy25hSvH1UvZtJinJv4iMV1lxAyax+M
         Wr1M1SpKItLOtij0+RY8H3BKM2wrj6zSEhP2A75+Rf5oFRoQaIiE/Xpo554p6ReWREPI
         /d+rR1uSMqF9AocGu0r/59wgK6C7hpPMvxaSOy7ulWia10tk2jx+zOdWCWVEYefwcu2W
         zpag==
X-Gm-Message-State: AOUpUlE9lkYxqCTElc/CI1Iw/b8vsKv6+SIWQwedduRNLri4PhRF3mNW
        vr1qWImHu1yuekZ96amANCk0iGaBdo8SywMlfs4trHXrOBhIRHSwVneWic8r2jhzIZKyN7oh1c9
        k3JQjP8JUn26U8VhX6wlgsPrwQktejoU3Vwh1prKsYS0FjrRVVJ4Rcf8Np1jd
X-Google-Smtp-Source: AA+uWPwjvkD8iqj1s2ToK7B72A1s/1WKD+1Jqu5a9n+zbnNH8gya5CREzaKgNNRjFlB0dfkyg+uSON19BkO/
MIME-Version: 1.0
X-Received: by 2002:a6b:7407:: with SMTP id s7-v6mr3654910iog.78.1533335056294;
 Fri, 03 Aug 2018 15:24:16 -0700 (PDT)
Date:   Fri,  3 Aug 2018 15:23:21 -0700
In-Reply-To: <20180803222322.261813-1-sbeller@google.com>
Message-Id: <20180803222322.261813-7-sbeller@google.com>
References: <20180803222322.261813-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 6/7] submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e98317508c0 (submodule: ensure core.worktree is set after update,
2018-06-18) was overly aggressive in calling connect_work_tree_and_git_dir
as that ensures both the 'core.worktree' configuration is set as well as
setting up correct gitlink file pointing at the git directory.

We do not need to check for the gitlink in this part of the cmd_update
in git-submodule.sh, as the initial call to update-clone will have ensured
that. So we can reduce the work to only (check and potentially) set the
'core.worktree' setting.

While at it move the check from shell to C as that proves to be useful in
a follow up patch, as we do not need the 'name' in shell now.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 64 +++++++++++++++++++++++--------------
 git-submodule.sh            |  7 ++--
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8b1088ab58a..e7635d5d9ab 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1964,6 +1964,45 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+{
+	const struct submodule *sub;
+	const char *path;
+	char *cw;
+	struct repository subrepo;
+
+	if (argc != 2)
+		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
+
+	path = argv[1];
+
+	sub = submodule_from_path(the_repository, &null_oid, path);
+	if (!sub)
+		BUG("We could get the submodule handle before?");
+
+	if (repo_submodule_init(&subrepo, the_repository, path))
+		die(_("could not get a repository handle for submodule '%s'"), path);
+
+	if (!repo_config_get_string(&subrepo, "core.worktree", &cw)) {
+		char *cfg_file, *abs_path;
+		const char *rel_path;
+		struct strbuf sb = STRBUF_INIT;
+
+		cfg_file = xstrfmt("%s/config", subrepo.gitdir);
+
+		abs_path = absolute_pathdup(path);
+		rel_path = relative_path(abs_path, subrepo.gitdir, &sb);
+
+		git_config_set_in_file(cfg_file, "core.worktree", rel_path);
+
+		free(cfg_file);
+		free(abs_path);
+		strbuf_release(&sb);
+	}
+
+	return 0;
+}
+
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -2029,29 +2068,6 @@ static int check_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int connect_gitdir_workingtree(int argc, const char **argv, const char *prefix)
-{
-	struct strbuf sb = STRBUF_INIT;
-	const char *name, *path;
-	char *sm_gitdir;
-
-	if (argc != 3)
-		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
-
-	name = argv[1];
-	path = argv[2];
-
-	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
-	sm_gitdir = absolute_pathdup(sb.buf);
-
-	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
-
-	strbuf_release(&sb);
-	free(sm_gitdir);
-
-	return 0;
-}
-
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2065,7 +2081,7 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"update-clone", update_clone, 0},
-	{"connect-gitdir-workingtree", connect_gitdir_workingtree, 0},
+	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 8caaf274e25..19d010eac06 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -535,6 +535,8 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
 
+		git submodule--helper ensure-core-worktree "$sm_path"
+
 		name=$(git submodule--helper name "$sm_path") || exit
 		if ! test -z "$update"
 		then
@@ -577,11 +579,6 @@ cmd_update()
 			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
-		if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
-		then
-			git submodule--helper connect-gitdir-workingtree "$name" "$sm_path"
-		fi
-
 		if test "$subsha1" != "$sha1" || test -n "$force"
 		then
 			subforce=$force
-- 
2.18.0.132.g195c49a2227

