Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0049C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiBJJ3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbiBJJ3U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:20 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3B0D98
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:21 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id z12-20020a17090a1fcc00b001b63e477f9fso3562704pjz.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r/KojfLz2J5XeB+gTn2pB7l9rfA/WZU4hc79VKle4yc=;
        b=kSE3SxoKqByXjnjA254Pd+/t/7STxwfhK6R1VeEd3FpuycaBzQiPu9PGW0vOEcuFy4
         zhksIXdVaQv+If/0jPPJW/nIK/eAg+BTByBQrn8VeKp7HSaKpa1krqjmDmUoXQXIVmV8
         iY/nIgI3T8hIr0Uv7cuB/5wFxnQrLpQ9OTkeK1x5AucAE4wCUKmwH88k/hQpiEghNBEe
         PhiNIL0+fH7xZtG5SXCpYCmX8+SK4pHcYUq1bxHb0XO7AuzmS0JJpdnSvXkzF73BvSNy
         POC4DVrRCHqI/p4MMIMRPlowPEdifSeEpZBMR0fSR1a5mvi8yMSuG2s42EllfqqSQs7w
         qocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r/KojfLz2J5XeB+gTn2pB7l9rfA/WZU4hc79VKle4yc=;
        b=YGzaNxRMyuTNrNdyWEZcln/IqskSIDVY0iGCf3vT0jy2VZWJRrBfyCY6q0mZTt4eoh
         WODXm/JXQ77wLcFI7P3k+vYjB8C1eAeU+MqBC3aO65OMXyKEGuTMM3Bjtvdjt2vMUFbf
         TsdSkVXMq17GZobj929gXpGhohO+HIHWZBUhysdqvEHsOcMYtU14xHTqEH8WKLBjcPPQ
         oSDp7cya176RI3aB/iK6/WdZga5G7vX2meq5oMlT04v+1L3aXAZKDDllG76hSoPFpTKq
         LwojpXdpZtIPK+Zjo8Km7yn5ihMOWZ9yFVXmGc07a7SznYW5jIuUWFdP7j6xRc8LlY8W
         YDqA==
X-Gm-Message-State: AOAM532wkPsfVifqGDMn8aJJYDm3VjbLnMw3tOgCPCqxD5vbFMZpoo6k
        CRNkB2CuqFmx8mVvuMYPUHf+M9Fu97OC80wQaLn4CYbjMR0CsxQUp9W53Pv14kugnJFEE+UrpeW
        ftM1BkFEkOMpDyQOAq8G51o7uMGWuRkM3FEp79ilZvqnJr6y3N1lC2uisk2P5Zqc=
X-Google-Smtp-Source: ABdhPJwvpd5sDsbkDi1sHkVEqmohuvbinJgbwtaCV26mtp/1c3wI8So3BVYf8d+hL+Me1+3HnrqVW5gLCjmMNg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e40f:: with SMTP id
 hv15mr318874pjb.1.1644485360183; Thu, 10 Feb 2022 01:29:20 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:28 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-16-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 15/20] submodule--helper: move functions around
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
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will change the internals of several functions and
arrange them in a more logical manner. Move these functions to their
final positions so that the diff is smaller.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 228 ++++++++++++++++++------------------
 1 file changed, 114 insertions(+), 114 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5635f0c48b..0ab8f9d49f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2451,120 +2451,6 @@ static void update_submodule(struct update_clone_data *ucd)
 		ucd->sub->path);
 }
 
-static int update_submodules(struct submodule_update_clone *suc)
-{
-	int i;
-
-	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure,
-				   update_clone_task_finished, suc, "submodule",
-				   "parallel/update");
-
-	/*
-	 * We saved the output and put it out all at once now.
-	 * That means:
-	 * - the listener does not have to interleave their (checkout)
-	 *   work with our fetching.  The writes involved in a
-	 *   checkout involve more straightforward sequential I/O.
-	 * - the listener can avoid doing any work if fetching failed.
-	 */
-	if (suc->quickstop)
-		return 1;
-
-	for (i = 0; i < suc->update_clone_nr; i++)
-		update_submodule(&suc->update_clone[i]);
-
-	return 0;
-}
-
-static int update_clone(int argc, const char **argv, const char *prefix)
-{
-	const char *update = NULL;
-	struct pathspec pathspec;
-	struct submodule_update_clone opt = SUBMODULE_UPDATE_CLONE_INIT;
-
-	struct option module_update_clone_options[] = {
-		OPT_BOOL(0, "init", &opt.init,
-			 N_("initialize uninitialized submodules before update")),
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
-			   N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_STRING(0, "update", &update,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
-			   N_("reference repository")),
-		OPT_BOOL(0, "dissociate", &opt.dissociate,
-			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &opt.depth, "<depth>",
-			   N_("create a shallow clone truncated to the "
-			      "specified number of revisions")),
-		OPT_INTEGER('j', "jobs", &opt.max_jobs,
-			    N_("parallel jobs")),
-		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
-			    N_("whether the initial clone should follow the shallow recommendation")),
-		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
-		OPT_BOOL(0, "progress", &opt.progress,
-			    N_("force cloning progress")),
-		OPT_BOOL(0, "require-init", &opt.require_init,
-			   N_("disallow cloning into non-empty directory")),
-		OPT_BOOL(0, "single-branch", &opt.single_branch,
-			 N_("clone only one branch, HEAD or --branch")),
-		OPT_END()
-	};
-
-	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
-		NULL
-	};
-	opt.prefix = prefix;
-
-	update_clone_config_from_gitmodules(&opt.max_jobs);
-	git_config(git_update_clone_config, &opt.max_jobs);
-
-	argc = parse_options(argc, argv, prefix, module_update_clone_options,
-			     git_submodule_helper_usage, 0);
-
-	if (update)
-		if (parse_submodule_update_strategy(update, &opt.update) < 0)
-			die(_("bad value for update parameter"));
-
-	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
-		return 1;
-
-	if (pathspec.nr)
-		opt.warn_if_uninitialized = 1;
-
-	if (opt.init) {
-		struct module_list list = MODULE_LIST_INIT;
-		struct init_cb info = INIT_CB_INIT;
-
-		if (module_list_compute(argc, argv, opt.prefix,
-					&pathspec, &list) < 0)
-			return 1;
-
-		/*
-		 * If there are no path args and submodule.active is set then,
-		 * by default, only initialize 'active' modules.
-		 */
-		if (!argc && git_config_get_value_multi("submodule.active"))
-			module_list_active(&list);
-
-		info.prefix = opt.prefix;
-		info.superprefix = opt.recursive_prefix;
-		if (opt.quiet)
-			info.flags |= OPT_QUIET;
-
-		for_each_listed_submodule(&list, init_submodule_cb, &info);
-	}
-
-	return update_submodules(&opt);
-}
-
 /*
  * NEEDSWORK: Use a forward declaration to avoid moving
  * run_update_procedure() (which will be removed soon).
@@ -3021,6 +2907,120 @@ static int update_submodule2(struct update_data *update_data)
 	return 3;
 }
 
+static int update_submodules(struct submodule_update_clone *suc)
+{
+	int i;
+
+	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
+				   update_clone_start_failure,
+				   update_clone_task_finished, suc, "submodule",
+				   "parallel/update");
+
+	/*
+	 * We saved the output and put it out all at once now.
+	 * That means:
+	 * - the listener does not have to interleave their (checkout)
+	 *   work with our fetching.  The writes involved in a
+	 *   checkout involve more straightforward sequential I/O.
+	 * - the listener can avoid doing any work if fetching failed.
+	 */
+	if (suc->quickstop)
+		return 1;
+
+	for (i = 0; i < suc->update_clone_nr; i++)
+		update_submodule(&suc->update_clone[i]);
+
+	return 0;
+}
+
+static int update_clone(int argc, const char **argv, const char *prefix)
+{
+	const char *update = NULL;
+	struct pathspec pathspec;
+	struct submodule_update_clone opt = SUBMODULE_UPDATE_CLONE_INIT;
+
+	struct option module_update_clone_options[] = {
+		OPT_BOOL(0, "init", &opt.init,
+			 N_("initialize uninitialized submodules before update")),
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
+		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
+			   N_("path"),
+			   N_("path into the working tree, across nested "
+			      "submodule boundaries")),
+		OPT_STRING(0, "update", &update,
+			   N_("string"),
+			   N_("rebase, merge, checkout or none")),
+		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
+			   N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &opt.dissociate,
+			   N_("use --reference only while cloning")),
+		OPT_STRING(0, "depth", &opt.depth, "<depth>",
+			   N_("create a shallow clone truncated to the "
+			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &opt.max_jobs,
+			    N_("parallel jobs")),
+		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
+			    N_("whether the initial clone should follow the shallow recommendation")),
+		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
+		OPT_BOOL(0, "progress", &opt.progress,
+			    N_("force cloning progress")),
+		OPT_BOOL(0, "require-init", &opt.require_init,
+			   N_("disallow cloning into non-empty directory")),
+		OPT_BOOL(0, "single-branch", &opt.single_branch,
+			 N_("clone only one branch, HEAD or --branch")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+	opt.prefix = prefix;
+
+	update_clone_config_from_gitmodules(&opt.max_jobs);
+	git_config(git_update_clone_config, &opt.max_jobs);
+
+	argc = parse_options(argc, argv, prefix, module_update_clone_options,
+			     git_submodule_helper_usage, 0);
+
+	if (update)
+		if (parse_submodule_update_strategy(update, &opt.update) < 0)
+			die(_("bad value for update parameter"));
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
+		return 1;
+
+	if (pathspec.nr)
+		opt.warn_if_uninitialized = 1;
+
+	if (opt.init) {
+		struct module_list list = MODULE_LIST_INIT;
+		struct init_cb info = INIT_CB_INIT;
+
+		if (module_list_compute(argc, argv, opt.prefix,
+					&pathspec, &list) < 0)
+			return 1;
+
+		/*
+		 * If there are no path args and submodule.active is set then,
+		 * by default, only initialize 'active' modules.
+		 */
+		if (!argc && git_config_get_value_multi("submodule.active"))
+			module_list_active(&list);
+
+		info.prefix = opt.prefix;
+		info.superprefix = opt.recursive_prefix;
+		if (opt.quiet)
+			info.flags |= OPT_QUIET;
+
+		for_each_listed_submodule(&list, init_submodule_cb, &info);
+	}
+
+	return update_submodules(&opt);
+}
+
 struct add_data {
 	const char *prefix;
 	const char *branch;
-- 
2.33.GIT

