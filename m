Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3828C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B38D610E5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhJ1Sdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhJ1Sds (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:33:48 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D6AC061745
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:21 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id nv1-20020a17090b1b4100b001a04861d474so3750356pjb.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yeaFnwYPSV2ktOrGS5VHYnqJVzUhpAO17V/BsDi/u2A=;
        b=HPzra/gl87d3qrHwuw13V9G5QAjzMOsV5nFDAOWUjeDC/pmE9Os1f7Zeu/EHSiQrrU
         rrKX+NeM1YoAevygB1ozCypwHDWKisV+XBnl7WFemj6HYoQEJGVaIZBCLmDNzwG6qKWe
         fHQuWfLhTwW1/lLCcwM6vXBTAPOt4nUSzLYEXXR1MCjQ203iHXYdZLHSis+fzR83MfU8
         nc6za8HtZtGt5FjnNB2az41c3EVoTQJ4HgnI72E6MSp5wAylyJc3qOuA1I9RP4bLYQSR
         IMUiT67YkcmUuf/lp1f20TIG+vebQZ8GXWv2JeifluaBaPFx+v/4yM45zko34diKEo0G
         MMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yeaFnwYPSV2ktOrGS5VHYnqJVzUhpAO17V/BsDi/u2A=;
        b=KkCbEhUMb4ytBvJecDMe9+E8GSp+Vm0KbfZAhLMa/bCgu92yADiUmNdtY7RElUr/8K
         rDEpUQuC/XZEFz1TkxfrL8K48IcLbhxSyp/LiaYpHfUY+C2hX38D34YJU+erqXrmCWTa
         i4ftCWnfju+V1odV9YG94qi3iVKpzeqzM4YP93yJGUWgaEf4tTVm62A6oS6BCT0gLsdw
         DBFRxtOWQeo5uMKmsoKImy6LXHM4lQq2F+FhM8l4OcIceVl7+33hY08vzJ4P0wcReSAE
         hhT/eVObvnxPSm8RGQ0XbXtRfJ7iCg+xkQfkRmuMHY4xZfLPJS0yDs2/TwF0sUOVTTCQ
         UMQw==
X-Gm-Message-State: AOAM532hxb9I/XMsZ6JkDXQurV5FmSvATCJQCGt4qWi8yKE6mCToJui+
        R1WqblwstDgEQhOQAl7O9DDdzpLTq3mTWbT2Hc9n5dPE/oANuYaP1naPtt94dpZKQ+1JSfiSsGn
        d3AfH2RcpjHiPqjFRj+FFv+PZ5M6DH2DxEpnzl5Q5i2t/7kiuQqlRdWMVqRpSnmM=
X-Google-Smtp-Source: ABdhPJwnGraNSr0TdcUklkWrCJTUwYU6/L+KU2P6hiAcsq8h97JxSES7/3mlbbK6eACmwb2275oIXPvBqIAx3w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:9a91:b0:138:efd5:7302 with SMTP
 id w17-20020a1709029a9100b00138efd57302mr5253438plp.35.1635445880536; Thu, 28
 Oct 2021 11:31:20 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:31:01 -0700
In-Reply-To: <20211028183101.41013-1-chooglen@google.com>
Message-Id: <20211028183101.41013-7-chooglen@google.com>
Mime-Version: 1.0
References: <20211019224339.61881-1-chooglen@google.com> <20211028183101.41013-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 6/6] remote: add struct repository parameter to external functions
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finish plumbing remote_state by adding a struct repository
parameter to repo_* functions. This removes all references to
the_repository->remote_state in remote.c - explicit references in the
function bodies and implicit references via calls to non-repo_*
functions. However, certain functions still use the_repository to parse
oids.

Where a non-static function has the option to call either the static
"remotes_*" variant or the non-static "repo_*" variant, use "remotes_*"
in order to be consistent with the static functions. A desirable
side-effect of this is that it minimizes the number of calls to
read_config().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 85 ++++++++++++++++++++++++++++----------------------------
 remote.h | 80 ++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 109 insertions(+), 56 deletions(-)

diff --git a/remote.c b/remote.c
index 2b5166dee0..f7d9a47faa 100644
--- a/remote.c
+++ b/remote.c
@@ -549,13 +549,13 @@ static const char *remotes_remote_for_branch(struct remote_state *remote_state,
 	return "origin";
 }
 
-const char *remote_for_branch(struct branch *branch, int *explicit)
+const char *repo_remote_for_branch(struct repository *repo, struct branch *branch, int *explicit)
 {
-	read_config(the_repository);
-	die_on_missing_branch(the_repository, branch);
+	read_config(repo);
+	die_on_missing_branch(repo, branch);
 
-	return remotes_remote_for_branch(the_repository->remote_state, branch,
-					 explicit);
+	return remotes_remote_for_branch(repo->remote_state, branch,
+					     explicit);
 }
 
 static const char *
@@ -575,22 +575,22 @@ remotes_pushremote_for_branch(struct remote_state *remote_state,
 	return remotes_remote_for_branch(remote_state, branch, explicit);
 }
 
-const char *pushremote_for_branch(struct branch *branch, int *explicit)
+const char *repo_pushremote_for_branch(struct repository *repo, struct branch *branch, int *explicit)
 {
-	read_config(the_repository);
-	die_on_missing_branch(the_repository, branch);
+	read_config(repo);
+	die_on_missing_branch(repo, branch);
 
-	return remotes_pushremote_for_branch(the_repository->remote_state,
+	return remotes_pushremote_for_branch(repo->remote_state,
 					     branch, explicit);
 }
 
 static struct remote *remotes_remote_get(struct remote_state *remote_state,
 					 const char *name);
 
-const char *remote_ref_for_branch(struct branch *branch, int for_push)
+const char *repo_remote_ref_for_branch(struct repository *repo, struct branch *branch, int for_push)
 {
-	read_config(the_repository);
-	die_on_missing_branch(the_repository, branch);
+	read_config(repo);
+	die_on_missing_branch(repo, branch);
 
 	if (branch) {
 		if (!for_push) {
@@ -600,10 +600,10 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 		} else {
 			const char *dst,
 				*remote_name = remotes_pushremote_for_branch(
-					the_repository->remote_state, branch,
+					repo->remote_state, branch,
 					NULL);
 			struct remote *remote = remotes_remote_get(
-				the_repository->remote_state, remote_name);
+				repo->remote_state, remote_name);
 
 			if (remote && remote->push.nr &&
 			    (dst = apply_refspecs(&remote->push,
@@ -650,10 +650,10 @@ remotes_remote_get(struct remote_state *remote_state, const char *name)
 				    remotes_remote_for_branch);
 }
 
-struct remote *remote_get(const char *name)
+struct remote *repo_remote_get(struct repository *repo, const char *name)
 {
-	read_config(the_repository);
-	return remotes_remote_get(the_repository->remote_state, name);
+	read_config(repo);
+	return remotes_remote_get(repo->remote_state, name);
 }
 
 static inline struct remote *
@@ -663,10 +663,10 @@ remotes_pushremote_get(struct remote_state *remote_state, const char *name)
 				    remotes_pushremote_for_branch);
 }
 
-struct remote *pushremote_get(const char *name)
+struct remote *repo_pushremote_get(struct repository *repo, const char *name)
 {
-	read_config(the_repository);
-	return remotes_pushremote_get(the_repository->remote_state, name);
+	read_config(repo);
+	return remotes_pushremote_get(repo->remote_state, name);
 }
 
 int remote_is_configured(struct remote *remote, int in_repo)
@@ -678,14 +678,14 @@ int remote_is_configured(struct remote *remote, int in_repo)
 	return !!remote->origin;
 }
 
-int for_each_remote(each_remote_fn fn, void *priv)
+int repo_for_each_remote(struct repository *repo, each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
-	read_config(the_repository);
-	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
+	read_config(repo);
+	for (i = 0; i < repo->remote_state->remotes_nr && !result;
 	     i++) {
 		struct remote *remote =
-			the_repository->remote_state->remotes[i];
+			repo->remote_state->remotes[i];
 		if (!remote)
 			continue;
 		result = fn(remote, priv);
@@ -1790,17 +1790,16 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
 	}
 }
 
-struct branch *branch_get(const char *name)
+struct branch *repo_branch_get(struct repository *repo, const char *name)
 {
 	struct branch *ret;
 
-	read_config(the_repository);
+	read_config(repo);
 	if (!name || !*name || !strcmp(name, "HEAD"))
-		ret = the_repository->remote_state->current_branch;
+		ret = repo->remote_state->current_branch;
 	else
-		ret = make_branch(the_repository->remote_state, name,
-				  strlen(name));
-	set_merge(the_repository->remote_state, ret);
+		ret = make_branch(repo->remote_state, name, strlen(name));
+	set_merge(repo->remote_state, ret);
 	return ret;
 }
 
@@ -1934,17 +1933,17 @@ static const char *branch_get_push_1(struct remote_state *remote_state,
 	BUG("unhandled push situation");
 }
 
-const char *branch_get_push(struct branch *branch, struct strbuf *err)
+const char *repo_branch_get_push(struct repository *repo, struct branch *branch, struct strbuf *err)
 {
-	read_config(the_repository);
-	die_on_missing_branch(the_repository, branch);
+	read_config(repo);
+	die_on_missing_branch(repo, branch);
 
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
 
 	if (!branch->push_tracking_ref)
 		branch->push_tracking_ref = branch_get_push_1(
-			the_repository->remote_state, branch, err);
+			repo->remote_state, branch, err);
 	return branch->push_tracking_ref;
 }
 
@@ -2197,15 +2196,16 @@ static int stat_branch_pair(const char *branch_name, const char *base,
  * upstream defined, or ref does not exist).  Returns 0 if the commits are
  * identical.  Returns 1 if commits are different.
  */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **tracking_name, int for_push,
-		       enum ahead_behind_flags abf)
+int repo_stat_tracking_info(struct repository *repo, struct branch *branch,
+			    int *num_ours, int *num_theirs,
+			    const char **tracking_name, int for_push,
+			    enum ahead_behind_flags abf)
 {
 	const char *base;
 
 	/* Cannot stat unless we are marked to build on top of somebody else. */
-	base = for_push ? branch_get_push(branch, NULL) :
-		branch_get_upstream(branch, NULL);
+	base = for_push ? repo_branch_get_push(repo, branch, NULL) :
+				branch_get_upstream(branch, NULL);
 	if (tracking_name)
 		*tracking_name = base;
 	if (!base)
@@ -2217,15 +2217,16 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 /*
  * Return true when there is anything to report, otherwise false.
  */
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf)
+int repo_format_tracking_info(struct repository *repo, struct branch *branch,
+			      struct strbuf *sb, enum ahead_behind_flags abf)
 {
 	int ours, theirs, sti;
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
 
-	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
+	sti = repo_stat_tracking_info(repo, branch, &ours, &theirs, &full_base,
+				      0, abf);
 	if (sti < 0) {
 		if (!full_base)
 			return 0;
diff --git a/remote.h b/remote.h
index b205830ac3..9b06afd285 100644
--- a/remote.h
+++ b/remote.h
@@ -120,15 +120,28 @@ struct remote {
  * remote_get(NULL) will return the default remote, given the current branch
  * and configuration.
  */
-struct remote *remote_get(const char *name);
-
-struct remote *pushremote_get(const char *name);
+struct remote *repo_remote_get(struct repository *repo, const char *name);
+static inline struct remote *remote_get(const char *name)
+{
+	return repo_remote_get(the_repository, name);
+}
+
+struct remote *repo_pushremote_get(struct repository *repo, const char *name);
+static inline struct remote *pushremote_get(const char *name)
+{
+	return repo_pushremote_get(the_repository, name);
+}
 int remote_is_configured(struct remote *remote, int in_repo);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 
 /* iterate through struct remotes */
-int for_each_remote(each_remote_fn fn, void *priv);
+int repo_for_each_remote(struct repository *repo, each_remote_fn fn,
+			 void *priv);
+static inline int for_each_remote(each_remote_fn fn, void *priv)
+{
+	return repo_for_each_remote(the_repository, fn, priv);
+}
 
 int remote_has_url(struct remote *remote, const char *url);
 
@@ -324,10 +337,29 @@ struct branch {
 	const char *push_tracking_ref;
 };
 
-struct branch *branch_get(const char *name);
-const char *remote_for_branch(struct branch *branch, int *explicit);
-const char *pushremote_for_branch(struct branch *branch, int *explicit);
-const char *remote_ref_for_branch(struct branch *branch, int for_push);
+struct branch *repo_branch_get(struct repository *repo, const char *name);
+static inline struct branch *branch_get(const char *name)
+{
+	return repo_branch_get(the_repository, name);
+}
+
+const char *repo_remote_for_branch(struct repository *repo, struct branch *branch, int *explicit);
+static inline const char *remote_for_branch(struct branch *branch, int *explicit)
+{
+	return repo_remote_for_branch(the_repository, branch, explicit);
+}
+
+const char *repo_pushremote_for_branch(struct repository *repo, struct branch *branch, int *explicit);
+static inline const char *pushremote_for_branch(struct branch *branch, int *explicit)
+{
+	return repo_pushremote_for_branch(the_repository, branch, explicit);
+}
+
+const char *repo_remote_ref_for_branch(struct repository *repo, struct branch *branch, int for_push);
+static inline const char *remote_ref_for_branch(struct branch *branch, int for_push)
+{
+	return repo_remote_ref_for_branch(the_repository, branch, for_push);
+}
 
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
@@ -351,7 +383,11 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err);
  *
  * The return value and `err` conventions match those of `branch_get_upstream`.
  */
-const char *branch_get_push(struct branch *branch, struct strbuf *err);
+const char *repo_branch_get_push(struct repository *repo, struct branch *branch, struct strbuf *err);
+static inline const char *branch_get_push(struct branch *branch, struct strbuf *err)
+{
+	return repo_branch_get_push(the_repository, branch, err);
+}
 
 /* Flags to match_refs. */
 enum match_refs_flags {
@@ -370,11 +406,27 @@ enum ahead_behind_flags {
 };
 
 /* Reporting of tracking info */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name, int for_push,
-		       enum ahead_behind_flags abf);
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf);
+int repo_stat_tracking_info(struct repository *repo, struct branch *branch,
+			    int *num_ours, int *num_theirs,
+			    const char **upstream_name, int for_push,
+			    enum ahead_behind_flags abf);
+static inline int stat_tracking_info(struct branch *branch, int *num_ours,
+				     int *num_theirs,
+				     const char **upstream_name, int for_push,
+				     enum ahead_behind_flags abf)
+{
+	return repo_stat_tracking_info(the_repository, branch, num_ours,
+				       num_theirs, upstream_name, for_push,
+				       abf);
+}
+
+int repo_format_tracking_info(struct repository *repo, struct branch *branch,
+			      struct strbuf *sb, enum ahead_behind_flags abf);
+static inline int format_tracking_info(struct branch *branch, struct strbuf *sb,
+				       enum ahead_behind_flags abf)
+{
+	return repo_format_tracking_info(the_repository, branch, sb, abf);
+}
 
 struct ref *get_local_heads(void);
 /*
-- 
2.33.GIT

