Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E641514E4
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724363875; cv=none; b=bWcMd8Z25rJ3UPAMObIFeVxI5NSU/HpumfYiduxRFbCFwNHp95w7fLAMl0hJQQ2ijEIqs9TdcuLGHCkVQL0vaMqJSZcNho98SmR8jZPljJm3qoRtB+T+lNc8lzuJxEzVuTDeeCw9UZx+5tgSYAMkN8/gIg4erF1Yl7WRZUwV9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724363875; c=relaxed/simple;
	bh=iwPW7BMmuQW5n9Xl8Qu2r8Es2k+XR1sWU7ryv8Sr0RA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PqCaZGOxnV9gv9OH8n8FG/HEtzC2ohEqNsZg6q2crLyejb5fccjfCZFD3PMUuXJC2bqT2abfLnfs0+AxKNRtQGwiTABeJbjrNCQdsQjygWAZ9+fkrnxrq59BhYwDZJ4ipH55QPSQVLSPk9bvFbGnE0eHnGkwjRXO3pcwxtWpxhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9C4jLCj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9C4jLCj"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b38bd44424so23947477b3.0
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724363873; x=1724968673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+Z24jjw16+/t/V7SNBDOEUvuaImj+68r5+hs1G665Q=;
        b=k9C4jLCjk7GFyaj8G+PBrrMTzp/VR8Kyf0MPat9642rmbYLKGwzkqqOCEvu2qnE7CZ
         AWOLKSGIR3E6V11jbd8tB5vEBN2WQMiD99N2JdlTj+tjQu6Nqn28PdDfCEmrAbwxPLNd
         zNHlhFeK/U0TxUpzXnHSBiOMPZ4yIQ11ar1Fu435WtIos4KBnZ7TUu6KElphGC8NKBdk
         F/J7SL5wwG48UBE/arXIjX9kCSM+ezymNhUXd2IJPK8Jq7T4Qk4bYcbKgrv2csxFpes7
         5zsRgMOzfeKBfVVgjGEWB/d2gSDtnHMc3KhG+F2v7TQhzFCGnIg5Kt1zl158f3VmmCo/
         GjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724363873; x=1724968673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+Z24jjw16+/t/V7SNBDOEUvuaImj+68r5+hs1G665Q=;
        b=HQKWa54um1Y4zNvYTP3d6t+HMi448bYoAobt+TNDx1B11hpOuEk3DKttsl6yMl7I1S
         q7C31dtGLadsGAH6cxR+38H2fNdOjxbjoKhlquktjkCPVzddiCpEab09BJ9UyGXUk4R8
         4UaCMFHhw520prmxOoUo6X8XpSjgWQENZx5BE/K273CcivseSTOs+RV39bTEeJekb+YF
         JvkUseJ6gGOkA7/30+m7JanpTecY74mJ1x4jqpuFUjFi9xBVSq2nvzAIlQSwFEBFvfmD
         Ew6zw+WgSJbAmEM/1xyF31l2cwcpC+dt3gD1Lzj8mNVmoUOhpaKnChGVTxs7hZ+vqsmf
         66HA==
X-Gm-Message-State: AOJu0Yzg5qNSZCNEILsHlnQf2C85K1b2M6Hl/MC1T8YYJ7n2AGmmMTWx
	UADTxuHcYkAL6FDbD8zx0gluo5qTZUPb4uHdiw8Ma1JqgwoXp7fxt0IRk8ig6wFUJ9/6rqNSO6W
	BhgzUJs4flwViHtv3kKxZ5mkzp07TS2QMS0iUs6mi2B/2qg7BdYFc0FzJcCWnH7AbvwxrAHJUn/
	oFP55ehMWsWsvEeV7pf8eNbceR2Mkxi8v18hZGE+0=
X-Google-Smtp-Source: AGHT+IFcnSiWWXehPdiwLlWL7DkmWVNlY5XEoZaCGX9Jme9p2nCUWkFDb5uHhiWWv/usNbo/3Lg7GE8s79YBmA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:9ba9:7ac3:74ce:2b8f])
 (user=steadmon job=sendgmr) by 2002:a05:690c:3010:b0:69b:2f8e:4d1a with SMTP
 id 00721157ae682-6c629345858mr38707b3.9.1724363873106; Thu, 22 Aug 2024
 14:57:53 -0700 (PDT)
Date: Thu, 22 Aug 2024 14:57:46 -0700
In-Reply-To: <cover.1724363615.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723747832.git.steadmon@google.com> <cover.1724363615.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <acaa72cad30172f707a8706a7e0fd0131ea4b6fc.1724363615.git.steadmon@google.com>
Subject: [PATCH v2 2/3] fetch: add top-level trace2 regions
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

At $DAYJOB we experienced some slow fetch operations and needed some
additional data to help diagnose the issue.

Add top-level trace2 regions for the various modes of operation of
`git-fetch`. None of these regions are in recursive code, so any
enclosed trace messages should only see their nesting level increase by
one.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/fetch.c | 16 +++++++++++++++-
 bundle-uri.c    |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 693f02b958..9e20a41d2a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2407,6 +2407,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		struct oidset_iter iter;
 		const struct object_id *oid;
 
+		trace2_region_enter("fetch", "negotiate-only", the_repository);
 		if (!remote)
 			die(_("must supply remote when using --negotiate-only"));
 		gtransport = prepare_transport(remote, 1);
@@ -2415,6 +2416,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		} else {
 			warning(_("protocol does not support --negotiate-only, exiting"));
 			result = 1;
+			trace2_region_leave("fetch", "negotiate-only", the_repository);
 			goto cleanup;
 		}
 		if (server_options.nr)
@@ -2425,11 +2427,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
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
 
@@ -2449,7 +2457,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			max_children = config.parallel;
 
 		/* TODO should this also die if we have a previous partial-clone? */
+		trace2_region_enter("fetch", "fetch-multiple", the_repository);
 		result = fetch_multiple(&list, max_children, &config);
+		trace2_region_leave("fetch", "fetch-multiple", the_repository);
 	}
 
 	/*
@@ -2471,6 +2481,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			max_children = config.parallel;
 
 		add_options_to_argv(&options, &config);
+		trace2_region_enter_printf("fetch", "recurse-submodule", the_repository, "%s", submodule_prefix);
 		result = fetch_submodules(the_repository,
 					  &options,
 					  submodule_prefix,
@@ -2478,6 +2489,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 					  recurse_submodules_default,
 					  verbosity < 0,
 					  max_children);
+		trace2_region_leave_printf("fetch", "recurse-submodule", the_repository, "%s", submodule_prefix);
 		strvec_clear(&options);
 	}
 
@@ -2501,9 +2513,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		if (progress)
 			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
+		trace2_region_enter("fetch", "write-commit-graph", the_repository);
 		write_commit_graph_reachable(the_repository->objects->odb,
 					     commit_graph_flags,
 					     NULL);
+		trace2_region_leave("fetch", "write-commit-graph", the_repository);
 	}
 
 	if (enable_auto_gc) {
diff --git a/bundle-uri.c b/bundle-uri.c
index 1e0ee156ba..dc0c96955b 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -13,6 +13,7 @@
 #include "config.h"
 #include "fetch-pack.h"
 #include "remote.h"
+#include "trace2.h"
 
 static struct {
 	enum bundle_list_heuristic heuristic;
@@ -799,6 +800,8 @@ int fetch_bundle_uri(struct repository *r, const char *uri,
 		.id = xstrdup(""),
 	};
 
+	trace2_region_enter("fetch", "fetch-bundle-uri", the_repository);
+
 	init_bundle_list(&list);
 
 	/*
@@ -824,6 +827,7 @@ int fetch_bundle_uri(struct repository *r, const char *uri,
 	for_all_bundles_in_list(&list, unlink_bundle, NULL);
 	clear_bundle_list(&list);
 	clear_remote_bundle_info(&bundle, NULL);
+	trace2_region_leave("fetch", "fetch-bundle-uri", the_repository);
 	return result;
 }
 
-- 
2.46.0.295.g3b9ea8a38a-goog

