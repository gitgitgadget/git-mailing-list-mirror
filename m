Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09444C94
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747879; cv=none; b=Dx4M+MV78pS0mIxy6YMM+u4X4NlIsC9IUGbTMzIsF7wm1q7L38j4azaW6VGqTCFRi7wW8+U/T2s8TxykgppTSi7dR7cz0u7MWEKGewXUlKA1r1lTgulQewwSb6LpVs5xXV+e+5VwMAIQWUyQRue+u/HRD5gkiZL82tYH8S1JWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747879; c=relaxed/simple;
	bh=ZzNl9I6KwkeVYITRw9ZfHz39gQXx57bis8gBWWEwhjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GdieBvWFVvPYntCCz1VAfDHJ5d9ueIJq3elR5aR4xkLe9EQZdPAMZCJ93mEdCtfpVQoqeyPZ0wmHCuVqPt2becstdRW0pJ0653qah+gybseRDQKcOuSM0gQhRwxKjHmyG/6Zo/eW7nIQgU0FtBUcZp4TCtBCoNB0V1lZPiaxazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLazrMZR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLazrMZR"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e116c697904so2239934276.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723747877; x=1724352677; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3mfszOwnSROtAsU9Oi95vkETqXQCVNM3QhwhhpOmLWQ=;
        b=WLazrMZRy3hdfhOJo+dvU2GLPfkl+aE1jUtpGJifwqW7ftn3dH3tarLI/MM7rWsq+e
         mD7Ev7/RyAHPfJxpoq9MHhwsxLxrnJrCN8WUOSPqUzk9iJ5c7lUHyIoPthk3LBOxihNm
         AsxP6d/B2HLXzBuSr8nMZ2MrEBIM+dKQ/oLu1qOIbSKjcciJ0VlfS62GXszlJLnZAFbg
         ah1NGmgvBJ6+k8t4XZFUxFY/I38Kuzay61bvidB7IoWBCpfbNDMCZYg6UeLkqeChz0tn
         z8OYB2Hyde3S54OO2h/MGI2T5KJd8GygVhzCs2TFv4o1HOiXtR1KTo6qseZ/KErd0NLt
         xHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747877; x=1724352677;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mfszOwnSROtAsU9Oi95vkETqXQCVNM3QhwhhpOmLWQ=;
        b=Nml7kL3+cvJa+2rq9uqG48ciGJDB8EAJI4ulx/ceoTzVAVryNOP64EKDKVfqP6mKRL
         w5m4p6cumgUoyygpizYoIPumq87Vdk27AMdWyAyOXWW4mNyWv1Zvc8I9xpdfOLM48wdE
         B9Sy0CFZv+qaCMuBet06r8NeR59EtLKuutrksWcEYJnD75sKXWtIUBr9SX9kRvAe6q/g
         tl8iYl44anr10ryArBxmbKEUglhNXtCTC6gNskn/TMjom7fskn/auYhAfMLIO5mXv21u
         +rwfPBWj2bggeyDmxIbZhml8Y8ykAFXDReb8VRLRgxZhFLpOPAvETibdmK+e5ewuav6/
         /O8A==
X-Gm-Message-State: AOJu0Yxja4qRQ7X78zq7aV6mf4S+tbcTpEu+KH6bTLgwu6hTu+bMI2Tx
	rJxaDONtapJaL1hO6QdWdnFB2VyzUJjF7Vks5zh/ySKDx4FiOVL2HvRiGkwKkFhyAWhtKSUDfyq
	+o3OorBFTMAlrom3OkfJm+5xboHk8xN5pqV0CXyN6SCRPRwGLqaipCjDl0axUgJ+S357uPEPWK6
	klmUukvYuYUvzuXWehyZgXugPpNpMH4h1XkpiIxaU=
X-Google-Smtp-Source: AGHT+IF/gbf+DYjYLCx5H8yRPve9prw78Xc31mY90B4HVX4JE8YVbBJ8Vefke1ES0qS+sYwRWD1fQFcw3bSg+w==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:d4b3:f740:176c:e447])
 (user=steadmon job=sendgmr) by 2002:a05:6902:208:b0:e0e:4e5d:c414 with SMTP
 id 3f1490d57ef6-e1180f9f5cbmr19548276.10.1723747876936; Thu, 15 Aug 2024
 11:51:16 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:51:12 -0700
In-Reply-To: <cover.1723747832.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723747832.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <c0481f85f8166e520c387f9e9157b142b93d933c.1723747832.git.steadmon@google.com>
Subject: [PATCH 1/2] fetch: add top-level trace2 regions
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

At $DAYJOB we experienced some slow fetch operations and needed some
additional data to help diagnose the issue.

Add top-level trace2 regions for the various modes of operation of
`git-fetch`. None of these regions are in recursive code, so any
enclosed trace messages should only see their nesting level increase by
one.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/fetch.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 693f02b958..950cd79baa 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2353,9 +2353,14 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (!max_jobs)
 		max_jobs = online_cpus();
 
-	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
-	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
-		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
+	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri)) {
+		int result = 0;
+		trace2_region_enter("fetch", "fetch-bundle-uri", the_repository);
+		result = fetch_bundle_uri(the_repository, bundle_uri, NULL);
+		trace2_region_leave("fetch", "fetch-bundle-uri", the_repository);
+		if (result)
+			warning(_("failed to fetch bundles from '%s'"), bundle_uri);
+	}
 
 	if (all < 0) {
 		/*
@@ -2407,6 +2412,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		struct oidset_iter iter;
 		const struct object_id *oid;
 
+		trace2_region_enter("fetch", "negotiate-only", the_repository);
 		if (!remote)
 			die(_("must supply remote when using --negotiate-only"));
 		gtransport = prepare_transport(remote, 1);
@@ -2415,6 +2421,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		} else {
 			warning(_("protocol does not support --negotiate-only, exiting"));
 			result = 1;
+			trace2_region_leave("fetch", "negotiate-only", the_repository);
 			goto cleanup;
 		}
 		if (server_options.nr)
@@ -2425,11 +2432,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		while ((oid = oidset_iter_next(&iter)))
 			printf("%s\n", oid_to_hex(oid));
 		oidset_clear(&acked_commits);
+		trace2_region_leave("fetch", "negotiate-only", the_repository);
 	} else if (remote) {
-		if (filter_options.choice || repo_has_promisor_remote(the_repository))
+		if (filter_options.choice || repo_has_promisor_remote(the_repository)) {
+			trace2_region_enter("fetch", "setup-partial", the_repository);
 			fetch_one_setup_partial(remote);
+			trace2_region_leave("fetch", "setup-partial", the_repository);
+		}
+		trace2_region_enter("fetch", "fetch-one", the_repository);
 		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
 				   &config);
+		trace2_region_leave("fetch", "fetch-one", the_repository);
 	} else {
 		int max_children = max_jobs;
 
@@ -2449,7 +2462,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			max_children = config.parallel;
 
 		/* TODO should this also die if we have a previous partial-clone? */
+		trace2_region_enter("fetch", "fetch-multiple", the_repository);
 		result = fetch_multiple(&list, max_children, &config);
+		trace2_region_leave("fetch", "fetch-multiple", the_repository);
 	}
 
 	/*
@@ -2471,6 +2486,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			max_children = config.parallel;
 
 		add_options_to_argv(&options, &config);
+		trace2_region_enter_printf("fetch", "recurse-submodule", the_repository, "%s", submodule_prefix);
 		result = fetch_submodules(the_repository,
 					  &options,
 					  submodule_prefix,
@@ -2478,6 +2494,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 					  recurse_submodules_default,
 					  verbosity < 0,
 					  max_children);
+		trace2_region_leave_printf("fetch", "recurse-submodule", the_repository, "%s", submodule_prefix);
 		strvec_clear(&options);
 	}
 
@@ -2501,9 +2518,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		if (progress)
 			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
+		trace2_region_enter("fetch", "write-commit-graph", the_repository);
 		write_commit_graph_reachable(the_repository->objects->odb,
 					     commit_graph_flags,
 					     NULL);
+		trace2_region_leave("fetch", "write-commit-graph", the_repository);
 	}
 
 	if (enable_auto_gc) {
-- 
2.46.0.184.g6999bdac58-goog

