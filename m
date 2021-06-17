Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2247BC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE944608FC
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFQRPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhFQRPl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 13:15:41 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAF8C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:13:32 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so2578396qkf.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FP14PzBmaijxsgz7jsoEwQZI00PgyioXjq7JZoiyMhI=;
        b=ce3Whd9djqnswt38Q6qRgbJCNP8EQmln0e/FqH5whsT/pcLzXdXOCY840HHl8zNjZ4
         IFW4U3OsfNgoPkhacJ/b+Tx4oSBPfkLZtAPo9f3ZtDgqe2JA5wQZGbzsBvdoz7O03Xj1
         HJVyoxStxA6gEZRWC6cFPlCWa8DxZqcu8cLs1mh2MQ7LlooFijnnJHbYW5FVsbaXhZS5
         MpNlGu1N19GUQK2CXVD1YuVLgmvjM0zcGnp/ptpcIijJMlEmX+vPNrxJRsh9KrqKvCxV
         KihlTjsVi6wmDconuiZ6Xc/SaqS4uf2KCMrDx35idjkjLViwAofjLzoQVciAHMoqs0wp
         ksSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FP14PzBmaijxsgz7jsoEwQZI00PgyioXjq7JZoiyMhI=;
        b=uHIyglen43obxapaIb+tRWbER/mhb2ests4TTceaQPc+GZeV1igJmY03dfRlwZn2wS
         4PDKA2HhpcjW7uHNe5uS+r2ZXue8+7sMyQqPg6o4v6AOVQr2cX+toldfpE7BaMnJD+B1
         IZXetRHcMQwlXk0ur+4YOhvsRAIR6NiFwCv6SBzOZN3OOL4a0aPK07cUZDM6oDnGeeLY
         m+NhmIpKfwKvFnkeEcaoVX7umHeQW7XsjnJz9SwnibgT0w761wdHECEi4fxjavkYwg/7
         ldb+HCERznuJdIMY+uywhqtjoZgK13SqpyUqDK0PGtwqWoOjK1mnAVPdAYELWRgcZy8e
         NXMQ==
X-Gm-Message-State: AOAM5321VDt/o3jEFy4U4B0PpD3VmsZdZF+ocUnqsGH2HQIdTVsCp1fE
        Ur0INhea7p5XbfTwmm+rnn7nYky2FlYpW4KQLCBJYJzo9UwzQMk/PYSDitadVxXGQC0xpepnnA8
        I12nNGOtTmoOouG6Rdgm7SU8iEKOhnEH7uTpYXbhKozwQxdt85R3hD7eHr2erVdnBUy3WXbW56w
        D/
X-Google-Smtp-Source: ABdhPJwvXUTmFcakmaF9MczCp386nQbOL4+U0PuAqsk2Url5rcMhmwsGmOYTP8odpizKkM1GCBcj0jOCoxAsxYyasjNj
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:824f:: with SMTP id
 d15mr8145723ybn.96.1623950011816; Thu, 17 Jun 2021 10:13:31 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:13:22 -0700
In-Reply-To: <cover.1623949899.git.jonathantanmy@google.com>
Message-Id: <0bd009597ddccddba15e1e30bf0965c5d492fd44.1623949899.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623949899.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v4 1/5] repository: move global r_f_p_c to repo struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move repository_format_partial_clone, which is currently a global
variable, into struct repository. (Full support for per-repository
partial clone config will be done in a subsequent commit - this is split
into its own commit because of the extent of the changes needed.)

The new repo-specific variable cannot be set in
check_repository_format_gently() (as is currently), because that
function does not know which repo it is operating on (or even whether
the value is important); therefore this responsibility is delegated to
the outermost caller that knows. Of all the outermost callers that know
(found by looking at all functions that call clear_repository_format()),
I looked at those that either read from the main Git directory or write
into a struct repository. These callers have been modified accordingly
(write to the_repository in the former case and write to the given
struct repository in the latter case).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 promisor-remote.c | 13 +++----------
 promisor-remote.h |  6 ------
 repository.c      |  4 ++++
 repository.h      |  3 +++
 setup.c           | 17 +++++++++++++----
 5 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index da3f2ca261..d24081dc21 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -5,13 +5,6 @@
 #include "transport.h"
 #include "strvec.h"
 
-static char *repository_format_partial_clone;
-
-void set_repository_format_partial_clone(char *partial_clone)
-{
-	repository_format_partial_clone = xstrdup_or_null(partial_clone);
-}
-
 static int fetch_objects(const char *remote_name,
 			 const struct object_id *oids,
 			 int oid_nr)
@@ -145,15 +138,15 @@ static void promisor_remote_init(void)
 
 	git_config(promisor_remote_config, NULL);
 
-	if (repository_format_partial_clone) {
+	if (the_repository->repository_format_partial_clone) {
 		struct promisor_remote *o, *previous;
 
-		o = promisor_remote_lookup(repository_format_partial_clone,
+		o = promisor_remote_lookup(the_repository->repository_format_partial_clone,
 					   &previous);
 		if (o)
 			promisor_remote_move_to_tail(o, previous);
 		else
-			promisor_remote_new(repository_format_partial_clone);
+			promisor_remote_new(the_repository->repository_format_partial_clone);
 	}
 }
 
diff --git a/promisor-remote.h b/promisor-remote.h
index c7a14063c5..687210ab87 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -32,10 +32,4 @@ int promisor_remote_get_direct(struct repository *repo,
 			       const struct object_id *oids,
 			       int oid_nr);
 
-/*
- * This should be used only once from setup.c to set the value we got
- * from the extensions.partialclone config option.
- */
-void set_repository_format_partial_clone(char *partial_clone);
-
 #endif /* PROMISOR_REMOTE_H */
diff --git a/repository.c b/repository.c
index 448cd557d4..057a4748a0 100644
--- a/repository.c
+++ b/repository.c
@@ -172,6 +172,10 @@ int repo_init(struct repository *repo,
 
 	repo_set_hash_algo(repo, format.hash_algo);
 
+	/* take ownership of format.partial_clone */
+	repo->repository_format_partial_clone = format.partial_clone;
+	format.partial_clone = NULL;
+
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/repository.h b/repository.h
index a45f7520fd..6fb16ed336 100644
--- a/repository.h
+++ b/repository.h
@@ -139,6 +139,9 @@ struct repository {
 	/* True if commit-graph has been disabled within this process. */
 	int commit_graph_disabled;
 
+	/* Configurations related to promisor remotes. */
+	char *repository_format_partial_clone;
+
 	/* Configurations */
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
diff --git a/setup.c b/setup.c
index ead2f80cd8..eb9367ca5c 100644
--- a/setup.c
+++ b/setup.c
@@ -468,8 +468,6 @@ static enum extension_result handle_extension_v0(const char *var,
 			data->precious_objects = git_config_bool(var, value);
 			return EXTENSION_OK;
 		} else if (!strcmp(ext, "partialclone")) {
-			if (!value)
-				return config_error_nonbool(var);
 			data->partial_clone = xstrdup(value);
 			return EXTENSION_OK;
 		} else if (!strcmp(ext, "worktreeconfig")) {
@@ -566,7 +564,6 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	}
 
 	repository_format_precious_objects = candidate->precious_objects;
-	set_repository_format_partial_clone(candidate->partial_clone);
 	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 	string_list_clear(&candidate->v1_only_extensions, 0);
@@ -1197,6 +1194,11 @@ int discover_git_directory(struct strbuf *commondir,
 		return -1;
 	}
 
+	/* take ownership of candidate.partial_clone */
+	the_repository->repository_format_partial_clone =
+		candidate.partial_clone;
+	candidate.partial_clone = NULL;
+
 	clear_repository_format(&candidate);
 	return 0;
 }
@@ -1304,8 +1306,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env(gitdir);
 		}
-		if (startup_info->have_repository)
+		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			/* take ownership of repo_fmt.partial_clone */
+			the_repository->repository_format_partial_clone =
+				repo_fmt.partial_clone;
+			repo_fmt.partial_clone = NULL;
+		}
 	}
 	/*
 	 * Since precompose_string_if_needed() needs to look at
@@ -1390,6 +1397,8 @@ void check_repository_format(struct repository_format *fmt)
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
+	the_repository->repository_format_partial_clone =
+		xstrdup_or_null(fmt->partial_clone);
 	clear_repository_format(&repo_fmt);
 }
 
-- 
2.32.0.272.g935e593368-goog

