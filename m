Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03C7C433FE
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350933AbiBHIlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350807AbiBHIkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:42 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD71C03FED3
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:37 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p16-20020a170902a41000b0014992c5d56bso7057798plq.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=S1Qr+GtSpYazLEW45ksWTcj9eCLvgX9jDR2tEB1H8BY=;
        b=NFqI0NXQpP59JZ4zMT+vKk2j+8DXpBwdLGP7o5x0xDnbyExvoRazno5ak/kguT5u7y
         7v3OPR7UrNEGU/xC8q03Y/Nz0TP69hIlrkL7a+cHyAewsBs3zy4ObdDQK7wPzGBdj6Gs
         pHKyYopmmT86psKSMNzRFkmcytEN6Sex6TvT1d3WYjqjwyL9ow2cMnQaj40zUEt1P6Pp
         Z0G04b9AlZhRFAyp4EE3csR68yb4zpyPTdDg8bryW9LvqWCJHkMWlQaDVXtjDbfc/qv3
         LpQzRDUulsNYtpBTY/rGDuBOdIxWFAOklZPvJQ89i68+pX2nGdngxHubW7za8yTFzsHu
         87Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=S1Qr+GtSpYazLEW45ksWTcj9eCLvgX9jDR2tEB1H8BY=;
        b=FhxLfbBmpiVyIEW79xFCmZhe+zIz6v03VLYn3InRRkrCgNLRl3cFLsJC/52IMUIiLJ
         i0pjfaZ7K6i3RSyW3b3tvSOjPaPxcxaEnVD/r+CVGAzSboC6476u2fEp6h8doisCPGes
         +dDV2YKKKCzSpRGdkdRUqKk2mZirDb2WHa/R3lrg2DiartqIqBuqbhGsEq1mXAmPZxo9
         Pr4E22vl1PmPPj+nxC1tLCzONXm3R6Xala5c8ygSAgET+zTyIUaiYXhjTmjq29HiPWRw
         8yFbH0kJP4bda8hXWAVib5HQuWCklFYqojiQNQ5ldZZQaFjulSR3sasQVCtIbiIpTuWq
         yiIg==
X-Gm-Message-State: AOAM533jCnjK/jzv7aNbx/QMT60vOCF8+ixxz9l3Ca0GblfQIyqbDt15
        D06N7421SFcC4ELRurJVo1W4//evQ4sKNrCov8SwpQUOrrZfvRi/OSAGEw7aZYKdAPsPRabaR4g
        f99TGPl9wzBTVgb5Y28PPN0ipULQDarhogGd55Kf0u/j5NhHGsgl7EFE9fTFSeLQ=
X-Google-Smtp-Source: ABdhPJyy9XpZ66lh3lDYA+szDyYwraBv5p1wvroFUo+jvj2X+3eYqDNaZ8m1QJXDZETwXE77SjTDQ0m1ocL4RQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1513:: with SMTP id
 q19mr3363249pfu.12.1644309636594; Tue, 08 Feb 2022 00:40:36 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:52 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-17-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 16/16] submodule: move core cmd_update() logic to C
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

This patch completes the conversion past the flag parsing of
`submodule update` by introducing a helper subcommand called
`submodule--helper update`. The behaviour of `submodule update` should
remain the same after this patch.

We add more fields to the `struct update_data` that are required by
`struct submodule_update_clone` to be able to perform a clone, when that
is needed to be done.

Recursing on a submodule is done by calling a subprocess that launches
`submodule--helper update`, with a modified `--recursive-prefix` and
`--prefix` parameter.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 360 ++++++++++++++++++++++--------------
 git-submodule.sh            | 102 +---------
 2 files changed, 227 insertions(+), 235 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0ab8f9d49f..5085b28a2d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1977,7 +1977,6 @@ struct submodule_update_clone {
 	const char *prefix;
 	int single_branch;
=20
-	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
 	int update_clone_nr; int update_clone_alloc;
=20
@@ -1989,7 +1988,6 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
=20
 	int max_jobs;
-	unsigned int init;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT { \
 	.list =3D MODULE_LIST_INIT, \
@@ -2001,6 +1999,7 @@ struct submodule_update_clone {
 }
=20
 struct update_data {
+	const char *prefix;
 	const char *recursive_prefix;
 	const char *sm_path;
 	const char *displaypath;
@@ -2008,14 +2007,54 @@ struct update_data {
 	struct object_id suboid;
 	struct submodule_update_strategy update_strategy;
 	int depth;
+	int recommend_shallow;
+	int single_branch;
+	int max_jobs;
+	unsigned int init;
 	unsigned int force;
 	unsigned int quiet;
 	unsigned int nofetch;
 	unsigned int just_cloned;
 	unsigned int remote;
+	unsigned int recursive;
+	unsigned int progress;
+	unsigned int dissociate;
+	unsigned int require_init;
+	unsigned warn_if_uninitialized ;
+	struct string_list references;
+	struct module_list list;
 };
 #define UPDATE_DATA_INIT { \
+	.list =3D MODULE_LIST_INIT, \
 	.update_strategy =3D SUBMODULE_UPDATE_STRATEGY_INIT, \
+	.recommend_shallow =3D -1, \
+	.references =3D STRING_LIST_INIT_DUP, \
+	.single_branch =3D -1, \
+	.max_jobs =3D 1, \
+}
+
+static void update_clone_from_update_data(struct submodule_update_clone *s=
uc,
+					  struct update_data *update_data)
+{
+	suc->prefix =3D update_data->prefix;
+	suc->recursive_prefix =3D update_data->recursive_prefix;
+	suc->max_jobs =3D update_data->max_jobs;
+	suc->progress =3D update_data->progress;
+	suc->quiet =3D update_data->quiet;
+	suc->dissociate =3D update_data->dissociate;
+	suc->require_init =3D update_data->require_init;
+	suc->single_branch =3D update_data->single_branch;
+	suc->warn_if_uninitialized =3D update_data->warn_if_uninitialized;
+	suc->list =3D update_data->list;
+	suc->update =3D update_data->update_strategy;
+	suc->recommend_shallow =3D update_data->recommend_shallow;
+	if (update_data->depth)
+		suc->depth =3D xstrfmt("--depth=3D%d", update_data->depth);
+	if (update_data->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &update_data->references)
+			string_list_append(&suc->references, item->string);
+	}
 }
=20
 static void next_submodule_warn_missing(struct submodule_update_clone *suc=
,
@@ -2316,8 +2355,15 @@ static int run_update_command(struct update_data *ud=
, int subforce)
 	struct child_process cp =3D CHILD_PROCESS_INIT;
 	char *oid =3D oid_to_hex(&ud->oid);
 	int must_die_on_failure =3D 0;
+	struct submodule_update_strategy strategy =3D SUBMODULE_UPDATE_STRATEGY_I=
NIT;
+
+	if (ud->update_strategy.type =3D=3D SM_UPDATE_UNSPECIFIED || ud->just_clo=
ned)
+		determine_submodule_update_strategy(the_repository, ud->just_cloned,
+						    ud->sm_path, NULL, &strategy);
+	else
+		strategy =3D ud->update_strategy;
=20
-	switch (ud->update_strategy.type) {
+	switch (strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		cp.git_cmd =3D 1;
 		strvec_pushl(&cp.args, "checkout", "-q", NULL);
@@ -2340,55 +2386,54 @@ static int run_update_command(struct update_data *u=
d, int subforce)
 		break;
 	case SM_UPDATE_COMMAND:
 		cp.use_shell =3D 1;
-		strvec_push(&cp.args, ud->update_strategy.command);
+		strvec_push(&cp.args, strategy.command);
 		must_die_on_failure =3D 1;
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&ud->update_strategy));
+		    submodule_strategy_to_string(&strategy));
 	}
 	strvec_push(&cp.args, oid);
=20
 	cp.dir =3D xstrdup(ud->sm_path);
 	prepare_submodule_repo_env(&cp.env_array);
 	if (run_command(&cp)) {
-		switch (ud->update_strategy.type) {
+		switch (strategy.type) {
 		case SM_UPDATE_CHECKOUT:
-			printf(_("Unable to checkout '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
+				    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_REBASE:
-			printf(_("Unable to rebase '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			if (!must_die_on_failure)
+				break;
+			die(_("Unable to rebase '%s' in submodule path '%s'"),
+			    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_MERGE:
-			printf(_("Unable to merge '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			if (!must_die_on_failure)
+				break;
+			die(_("Unable to merge '%s' in submodule path '%s'"),
+			    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_COMMAND:
-			printf(_("Execution of '%s %s' failed in submodule path '%s'"),
-			       ud->update_strategy.command, oid, ud->displaypath);
+			if (!must_die_on_failure)
+				break;
+			die(_("Execution of '%s %s' failed in submodule path '%s'"),
+			    strategy.command, oid, ud->displaypath);
 			break;
 		default:
 			BUG("unexpected update strategy type: %s",
-			    submodule_strategy_to_string(&ud->update_strategy));
+			    submodule_strategy_to_string(&strategy));
 		}
-		/*
-		 * NEEDSWORK: We are currently printing to stdout with error
-		 * return so that the shell caller handles the error output
-		 * properly. Once we start handling the error messages within
-		 * C, we should use die() instead.
-		 */
-		if (must_die_on_failure)
-			return 2;
-		/*
-		 * This signifies to the caller in shell that the command
-		 * failed without dying
-		 */
+
+		/* the command failed, but update must continue */
 		return 1;
 	}
=20
-	switch (ud->update_strategy.type) {
+	if (ud->quiet)
+		return 0;
+
+	switch (strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		printf(_("Submodule path '%s': checked out '%s'\n"),
 		       ud->displaypath, oid);
@@ -2403,17 +2448,17 @@ static int run_update_command(struct update_data *u=
d, int subforce)
 		break;
 	case SM_UPDATE_COMMAND:
 		printf(_("Submodule path '%s': '%s %s'\n"),
-		       ud->displaypath, ud->update_strategy.command, oid);
+		       ud->displaypath, strategy.command, oid);
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&ud->update_strategy));
+		    submodule_strategy_to_string(&strategy));
 	}
=20
 	return 0;
 }
=20
-static int do_run_update_procedure(struct update_data *ud)
+static int run_update_procedure(struct update_data *ud)
 {
 	int subforce =3D is_null_oid(&ud->suboid) || ud->force;
=20
@@ -2443,89 +2488,6 @@ static int do_run_update_procedure(struct update_dat=
a *ud)
 	return run_update_command(ud, subforce);
 }
=20
-static void update_submodule(struct update_clone_data *ucd)
-{
-	fprintf(stdout, "dummy %s %d\t%s\n",
-		oid_to_hex(&ucd->oid),
-		ucd->just_cloned,
-		ucd->sub->path);
-}
-
-/*
- * NEEDSWORK: Use a forward declaration to avoid moving
- * run_update_procedure() (which will be removed soon).
- */
-static int update_submodule2(struct update_data *update_data);
-static int run_update_procedure(int argc, const char **argv, const char *p=
refix)
-{
-	char *prefixed_path, *update =3D NULL;
-	struct update_data opt =3D UPDATE_DATA_INIT;
-
-	struct option options[] =3D {
-		OPT__QUIET(&opt.quiet,
-			   N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&opt.force, N_("force checkout updates"),
-			   0),
-		OPT_BOOL('N', "no-fetch", &opt.nofetch,
-			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &opt.just_cloned,
-			 N_("overrides update mode in case the repository is a fresh clone")),
-		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "update", &update,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix, N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
-			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_BOOL(0, "remote", &opt.remote,
-			 N_("use SHA-1 of submodule's remote tracking branch")),
-		OPT_END()
-	};
-
-	const char *const usage[] =3D {
-		N_("git submodule--helper run-update-procedure [<options>] <path>"),
-		NULL
-	};
-
-	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
-
-	if (argc !=3D 1)
-		usage_with_options(usage, options);
-
-	opt.sm_path =3D argv[0];
-
-	if (opt.recursive_prefix)
-		prefixed_path =3D xstrfmt("%s%s", opt.recursive_prefix, opt.sm_path);
-	else
-		prefixed_path =3D xstrdup(opt.sm_path);
-
-	opt.displaypath =3D get_submodule_displaypath(prefixed_path, prefix);
-
-	determine_submodule_update_strategy(the_repository, opt.just_cloned,
-					    opt.sm_path, update,
-					    &opt.update_strategy);
-
-	free(prefixed_path);
-	return update_submodule2(&opt);
-}
-
-static int resolve_relative_path(int argc, const char **argv, const char *=
prefix)
-{
-	struct strbuf sb =3D STRBUF_INIT;
-	if (argc !=3D 3)
-		die("submodule--helper relative-path takes exactly 2 arguments, got %d",=
 argc);
-
-	printf("%s", relative_path(argv[1], argv[2], &sb));
-	strbuf_release(&sb);
-	return 0;
-}
-
 static const char *remote_submodule_branch(const char *path)
 {
 	const struct submodule *sub;
@@ -2868,11 +2830,66 @@ static int module_set_branch(int argc, const char *=
*argv, const char *prefix)
 	return !!ret;
 }
=20
-/* NEEDSWORK: this is a temporary name until we delete update_submodule() =
*/
-static int update_submodule2(struct update_data *update_data)
+static void update_data_to_args(struct update_data *update_data, struct st=
rvec *args)
+{
+	const char *update =3D submodule_strategy_to_string(&update_data->update_=
strategy);
+
+	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
+	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
+	if (update_data->prefix)
+		strvec_pushl(args, "--prefix", update_data->prefix, NULL);
+	if (update_data->recursive_prefix)
+		strvec_pushl(args, "--recursive-prefix",
+			     update_data->recursive_prefix, NULL);
+	if (update_data->quiet)
+		strvec_push(args, "--quiet");
+	if (update_data->force)
+		strvec_push(args, "--force");
+	if (update_data->init)
+		strvec_push(args, "--init");
+	if (update_data->remote)
+		strvec_push(args, "--remote");
+	if (update_data->nofetch)
+		strvec_push(args, "--no-fetch");
+	if (update_data->dissociate)
+		strvec_push(args, "--dissociate");
+	if (update_data->progress)
+		strvec_push(args, "--progress");
+	if (update_data->require_init)
+		strvec_push(args, "--require-init");
+	if (update_data->depth)
+		strvec_pushf(args, "--depth=3D%d", update_data->depth);
+	if (update)
+		strvec_pushl(args, "--update", update, NULL);
+	if (update_data->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &update_data->references)
+			strvec_pushl(args, "--reference", item->string, NULL);
+	}
+	if (update_data->recommend_shallow =3D=3D 0)
+		strvec_push(args, "--no-recommend-shallow");
+	else if (update_data->recommend_shallow =3D=3D 1)
+		strvec_push(args, "--recommend-shallow");
+	if (update_data->single_branch >=3D 0)
+		strvec_push(args, "--single-branch");
+}
+
+static int update_submodule(struct update_data *update_data)
 {
+	char *prefixed_path;
+
 	ensure_core_worktree(update_data->sm_path);
=20
+	if (update_data->recursive_prefix)
+		prefixed_path =3D xstrfmt("%s%s", update_data->recursive_prefix,
+					update_data->sm_path);
+	else
+		prefixed_path =3D xstrdup(update_data->sm_path);
+
+	update_data->displaypath =3D get_submodule_displaypath(prefixed_path,
+							     update_data->prefix);
+	free(prefixed_path);
+
 	/* NEEDSWORK: fix the style issues e.g. braces */
 	if (update_data->just_cloned) {
 		oidcpy(&update_data->suboid, null_oid());
@@ -2902,18 +2919,55 @@ static int update_submodule2(struct update_data *up=
date_data)
 	}
=20
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force=
)
-		return do_run_update_procedure(update_data);
+		if (run_update_procedure(update_data))
+			return 1;
=20
-	return 3;
+	if (update_data->recursive) {
+		struct child_process cp =3D CHILD_PROCESS_INIT;
+		struct update_data next =3D *update_data;
+		int res;
+
+		if (update_data->recursive_prefix)
+			prefixed_path =3D xstrfmt("%s%s/", update_data->recursive_prefix,
+						update_data->sm_path);
+		else
+			prefixed_path =3D xstrfmt("%s/", update_data->sm_path);
+
+		next.recursive_prefix =3D get_submodule_displaypath(prefixed_path,
+								  update_data->prefix);
+		next.prefix =3D NULL;
+		oidcpy(&next.oid, null_oid());
+		oidcpy(&next.suboid, null_oid());
+
+		cp.dir =3D update_data->sm_path;
+		cp.git_cmd =3D 1;
+		prepare_submodule_repo_env(&cp.env_array);
+		update_data_to_args(&next, &cp.args);
+
+		/* die() if child process die()'d */
+		res =3D run_command(&cp);
+		if (!res)
+			return 0;
+		die_message(_("Failed to recurse into submodule path '%s'"),
+			    update_data->displaypath);
+		if (res =3D=3D 128)
+			exit(res);
+		else if (res)
+			return 1;
+	}
+
+	return 0;
 }
=20
-static int update_submodules(struct submodule_update_clone *suc)
+static int update_submodules(struct update_data *update_data)
 {
-	int i;
+	int i, res =3D 0;
+	struct submodule_update_clone suc =3D SUBMODULE_UPDATE_CLONE_INIT;
=20
-	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
+	update_clone_from_update_data(&suc, update_data);
+	run_processes_parallel_tr2(suc.max_jobs, update_clone_get_next_task,
 				   update_clone_start_failure,
-				   update_clone_task_finished, suc, "submodule",
+				   update_clone_task_finished, &suc, "submodule",
 				   "parallel/update");
=20
 	/*
@@ -2924,25 +2978,45 @@ static int update_submodules(struct submodule_updat=
e_clone *suc)
 	 *   checkout involve more straightforward sequential I/O.
 	 * - the listener can avoid doing any work if fetching failed.
 	 */
-	if (suc->quickstop)
-		return 1;
+	if (suc.quickstop) {
+		res =3D 1;
+		goto cleanup;
+	}
=20
-	for (i =3D 0; i < suc->update_clone_nr; i++)
-		update_submodule(&suc->update_clone[i]);
+	for (i =3D 0; i < suc.update_clone_nr; i++) {
+		struct update_clone_data ucd =3D suc.update_clone[i];
=20
-	return 0;
+		oidcpy(&update_data->oid, &ucd.oid);
+		update_data->just_cloned =3D ucd.just_cloned;
+		update_data->sm_path =3D ucd.sub->path;
+
+		if (update_submodule(update_data))
+			res =3D 1;
+	}
+
+cleanup:
+	string_list_clear(&update_data->references, 0);
+	return res;
 }
=20
-static int update_clone(int argc, const char **argv, const char *prefix)
+static int module_update(int argc, const char **argv, const char *prefix)
 {
 	const char *update =3D NULL;
 	struct pathspec pathspec;
-	struct submodule_update_clone opt =3D SUBMODULE_UPDATE_CLONE_INIT;
+	struct update_data opt =3D UPDATE_DATA_INIT;
=20
+	/* NEEDSWORK: update names and strings */
 	struct option module_update_clone_options[] =3D {
+		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
 		OPT_BOOL(0, "init", &opt.init,
 			 N_("initialize uninitialized submodules before update")),
-		OPT_STRING(0, "prefix", &prefix,
+		OPT_BOOL(0, "remote", &opt.remote,
+			 N_("use SHA-1 of submodule's remote tracking branch")),
+		OPT_BOOL(0, "recursive", &opt.recursive,
+			 N_("traverse submodules recursively")),
+		OPT_BOOL('N', "no-fetch", &opt.nofetch,
+			 N_("don't fetch new objects from the remote site")),
+		OPT_STRING(0, "prefix", &opt.prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
 		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
@@ -2953,21 +3027,21 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
-			   N_("reference repository")),
+				N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
-			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &opt.depth, "<depth>",
-			   N_("create a shallow clone truncated to the "
-			      "specified number of revisions")),
+			 N_("use --reference only while cloning")),
+		OPT_INTEGER(0, "depth", &opt.depth,
+			    N_("create a shallow clone truncated to the "
+			       "specified number of revisions")),
 		OPT_INTEGER('j', "jobs", &opt.max_jobs,
 			    N_("parallel jobs")),
 		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
-			    N_("whether the initial clone should follow the shallow recommendat=
ion")),
+			 N_("whether the initial clone should follow the shallow recommendation=
")),
 		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
 		OPT_BOOL(0, "progress", &opt.progress,
-			    N_("force cloning progress")),
+			 N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &opt.require_init,
-			   N_("disallow cloning into non-empty directory")),
+			 N_("disallow cloning into non-empty directory")),
 		OPT_BOOL(0, "single-branch", &opt.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
 		OPT_END()
@@ -2977,16 +3051,18 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path>...]")=
,
 		NULL
 	};
-	opt.prefix =3D prefix;
=20
 	update_clone_config_from_gitmodules(&opt.max_jobs);
 	git_config(git_update_clone_config, &opt.max_jobs);
=20
 	argc =3D parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
+	oidcpy(&opt.oid, null_oid());
+	oidcpy(&opt.suboid, null_oid());
=20
 	if (update)
-		if (parse_submodule_update_strategy(update, &opt.update) < 0)
+		if (parse_submodule_update_strategy(update,
+						    &opt.update_strategy) < 0)
 			die(_("bad value for update parameter"));
=20
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
@@ -3408,9 +3484,7 @@ static struct cmd_struct commands[] =3D {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
-	{"update-clone", update_clone, 0},
-	{"run-update-procedure", run_update_procedure, 0},
-	{"relative-path", resolve_relative_path, 0},
+	{"update", module_update, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 3ccf2388bf..bcd8b92aab 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -347,108 +347,26 @@ cmd_update()
 		shift
 	done
=20
-	{
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update-clone \
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} sub=
module--helper update \
 		${GIT_QUIET:+--quiet} \
-		${progress:+"--progress"} \
+		${force:+--force} \
+		${progress:+--progress} \
+		${dissociate:+--dissociate} \
+		${remote:+--remote} \
+		${recursive:+--recursive} \
 		${init:+--init} \
+		${require_init:+--require-init} \
+		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
-		${dissociate:+"--dissociate"} \
-		${depth:+--depth "$depth"} \
-		${require_init:+--require-init} \
+		${depth:+"$depth"} \
 		$single_branch \
 		$recommend_shallow \
 		$jobs \
 		-- \
-		"$@" || echo "#unmatched" $?
-	} | {
-	err=3D
-	while read -r quickabort sha1 just_cloned sm_path
-	do
-		die_if_unmatched "$quickabort" "$sha1"
-
-		displaypath=3D$(git submodule--helper relative-path "$prefix$sm_path" "$=
wt_prefix")
-
-		if test $just_cloned -eq 0
-		then
-			just_cloned=3D
-		fi
-
-		out=3D$(git submodule--helper run-update-procedure \
-			  ${wt_prefix:+--prefix "$wt_prefix"} \
-			  ${GIT_QUIET:+--quiet} \
-			  ${force:+--force} \
-			  ${just_cloned:+--just-cloned} \
-			  ${nofetch:+--no-fetch} \
-			  ${depth:+"$depth"} \
-			  ${update:+--update "$update"} \
-			  ${prefix:+--recursive-prefix "$prefix"} \
-			  ${sha1:+--oid "$sha1"} \
-			  ${remote:+--remote} \
-			  "--" \
-			  "$sm_path")
-
-		# exit codes for run-update-procedure:
-		# 0: update was successful, say command output
-		# 1: update procedure failed, but should not die
-		# 2 or 128: subcommand died during execution
-		# 3: no update procedure was run
-		res=3D"$?"
-		case $res in
-		0)
-			say "$out"
-			;;
-		1)
-			err=3D"${err};fatal: $out"
-			continue
-			;;
-		2|128)
-			die_with_status $res "fatal: $out"
-			;;
-		esac
-
-		if test -n "$recursive"
-		then
-			(
-				prefix=3D$(git submodule--helper relative-path "$prefix$sm_path/" "$wt=
_prefix")
-				wt_prefix=3D
-				sanitize_submodule_env
-				cd "$sm_path" &&
-				eval cmd_update
-			)
-			res=3D$?
-			if test $res -gt 0
-			then
-				die_msg=3D"fatal: $(eval_gettext "Failed to recurse into submodule pat=
h '\$displaypath'")"
-				if test $res -ne 2
-				then
-					err=3D"${err};$die_msg"
-					continue
-				else
-					die_with_status $res "$die_msg"
-				fi
-			fi
-		fi
-	done
-
-	if test -n "$err"
-	then
-		OIFS=3D$IFS
-		IFS=3D';'
-		for e in $err
-		do
-			if test -n "$e"
-			then
-				echo >&2 "$e"
-			fi
-		done
-		IFS=3D$OIFS
-		exit 1
-	fi
-	}
+		"$@"
 }
=20
 #
--=20
2.33.GIT

