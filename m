Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596A9C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D9061241
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhKKRTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhKKRTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 12:19:44 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44709C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:16:55 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id i25-20020a631319000000b002cce0a43e94so3608887pgl.0
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cHhF/imx5Iz2HAxmTjajtv/SrIsEpTaAryPLncRONkk=;
        b=L92nOj1dsBJ24kags9sDhIpxH0hFrqi+9Xw86gJiF0UBR6qG+YR+IbRafJuPCbwMEa
         5ZrNT852qtBiF19tWMtEuBiskPX7wY4s0cDN5N3x+S5MzouOEgu9w+71iB7t848Z1bhB
         QBZySAppFeUgqMk/wXqwIDp1XVNaqMGVMcjZeTj3rFdcztZ2ZG7yjEr2jB37bkQX6oyh
         65nKBw0/yES/RKGbmiyz4fhszjbegKkggxtzc5oKRsVlk0aNthvyf8M6CgtKy5Q+JKh1
         gNlTA+jvs+/vmnRmLnkKh21i3TEnOL9e7vs0drUq0LommQhgUSlRTjv01TMg7cFLdgRM
         tS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cHhF/imx5Iz2HAxmTjajtv/SrIsEpTaAryPLncRONkk=;
        b=Q1YCuuyYDDvszLCszXno5xDkcOmw+PXn1Eb6EwVG6hmFvqrfj4Q0T0VzsxTfc7uK9X
         10rcF9f7AvRMAjkVWoMLelCkmtwRYzY5YafOiljQFkufo8IFmZDcLvAK5l0Y0kz92k1t
         Rnty5GDJjHrxwCmjJDWDNNOhKmjiRMDlMtwKtDA6rxE9Nhf8DfkLNP1Yu/NAVjC0isQE
         9fkcpDo2ijlHfZIs7GWDmGx628jkRBgVnjYR1BdBfDVASG47isJS6BP4rhgLxstpS9SK
         0FF2BVDcWenDk7auE9aOISQsBW6f258BEqzVYG6PWzOcXuPkFXKPVuh0PyfV5tVItj5g
         sR8A==
X-Gm-Message-State: AOAM532o8x1OJ3jjsig+fCAg3QTbsbxAZlVPZyJNe1Rq3jun4kzFKYf7
        +4r2mkRNBQa5ssi4rmxRpy5lInjBiJaU0gTQ1w7Wzw8p781i/6EfNoxWKbZ2TiLOVnC3FS5FGJv
        +lyr0VPiJe2G1zMVi44VqMnkyGY07w30QCyuFkDCAruBzvHJwKDbtNJ9f7+piqtk=
X-Google-Smtp-Source: ABdhPJzY4o+4P8NdoomX6fdIjy8u8LoSH7bIvGoQ1VKHVf+a76xKMvJ8cpEJ1VkgedtuVZNMObIKWrfN02UsdQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:b49:b0:49f:c8e0:51ff with SMTP
 id p9-20020a056a000b4900b0049fc8e051ffmr7904497pfo.36.1636651014703; Thu, 11
 Nov 2021 09:16:54 -0800 (PST)
Date:   Thu, 11 Nov 2021 09:16:43 -0800
In-Reply-To: <20211111171643.13805-1-chooglen@google.com>
Message-Id: <20211111171643.13805-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211111171643.13805-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v1 3/3] branch: remove implicit the_repository from create_branch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

create_branch() takes a struct repository parameter, which implies that
it behaves as expected when called on any repository. However, this is
not true because it depends on functions that ultimately use
the_repository.

Remove all implicit references to the_repository in create_branch().
This is achieved by replacing a function with a variant that accepts
struct repository or struct ref_store (typically named repo_* or
refs_*). For functions defined in branch.c, add a struct repository
parameter where necessary.

validate_new_branchname() still has an implicit reference to
the_repository via is_bare_repository(), which uses environment.c's
global state. Instead of pretending that we can tell if an arbitrary
repository is bare, validate_new_branchname() will simply die if r !=
the_repository. This shortcoming will only show itself if the user works
across multiple repositories in-process and some of them are bare -
which is probably rare in practice.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c           | 69 +++++++++++++++++++++++++++++++---------------
 branch.h           |  9 ++++--
 builtin/branch.c   |  5 ++--
 builtin/checkout.c |  7 +++--
 4 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/branch.c b/branch.c
index 5cc105ff8d..688da607cd 100644
--- a/branch.c
+++ b/branch.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "remote.h"
+#include "repository.h"
 #include "sequencer.h"
 #include "commit.h"
 #include "worktree.h"
@@ -55,7 +56,9 @@ N_("\n"
 "the remote tracking information by invoking\n"
 "\"git branch --set-upstream-to=%s%s%s\".");
 
-int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
+int repo_install_branch_config(struct repository *r, int flag,
+			       const char *local, const char *origin,
+			       const char *remote)
 {
 	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
@@ -70,18 +73,18 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
+	if (repo_config_set_gently(r, key.buf, origin ? origin : ".") < 0)
 		goto out_err;
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	if (git_config_set_gently(key.buf, remote) < 0)
+	if (repo_config_set_gently(r, key.buf, remote) < 0)
 		goto out_err;
 
 	if (rebasing) {
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
-		if (git_config_set_gently(key.buf, "true") < 0)
+		if (repo_config_set_gently(r, key.buf, "true") < 0)
 			goto out_err;
 	}
 	strbuf_release(&key);
@@ -126,6 +129,13 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	return -1;
 }
 
+int install_branch_config(int flag, const char *local, const char *origin,
+			  const char *remote)
+{
+	return repo_install_branch_config(the_repository, flag, local, origin,
+					  remote);
+}
+
 static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 {
 	struct strbuf key = STRBUF_INIT;
@@ -164,8 +174,9 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
  * config.
  */
-static void setup_tracking(const char *new_ref, const char *orig_ref,
-			   enum branch_track track, int quiet)
+static void setup_tracking(struct repository *r, const char *new_ref,
+			   const char *orig_ref, enum branch_track track,
+			   int quiet)
 {
 	struct tracking tracking;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
@@ -173,7 +184,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	if (track != BRANCH_TRACK_INHERIT) {
-		for_each_remote(find_tracked_branch, &tracking);
+		repo_for_each_remote(r, find_tracked_branch, &tracking);
 	} else if (inherit_tracking(&tracking, orig_ref))
 		return;
 
@@ -191,8 +202,9 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		die(_("Not tracking: ambiguous information for ref %s"),
 		    orig_ref);
 
-	if (install_branch_config(config_flags, new_ref, tracking.remote,
-			      tracking.src ? tracking.src : orig_ref) < 0)
+	if (repo_install_branch_config(
+		    r, config_flags, new_ref, tracking.remote,
+		    tracking.src ? tracking.src : orig_ref) < 0)
 		exit(-1);
 
 	free(tracking.src);
@@ -218,12 +230,13 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_branchname(const char *name, struct strbuf *ref)
+int validate_branchname(struct repository *r, const char *name,
+			struct strbuf *ref)
 {
 	if (strbuf_check_branch_ref(ref, name))
 		die(_("'%s' is not a valid branch name."), name);
 
-	return ref_exists(ref->buf);
+	return refs_ref_exists(get_main_ref_store(r), ref->buf);
 }
 
 /*
@@ -232,19 +245,31 @@ int validate_branchname(const char *name, struct strbuf *ref)
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force)
+int validate_new_branchname(struct repository *r, const char *name,
+			    struct strbuf *ref, int force)
 {
 	const char *head;
+	int ignore_errno;
 
-	if (!validate_branchname(name, ref))
+	if (!validate_branchname(r, name, ref))
 		return 0;
 
 	if (!force)
 		die(_("A branch named '%s' already exists."),
 		    ref->buf + strlen("refs/heads/"));
 
-	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
+	head = refs_resolve_ref_unsafe(get_main_ref_store(r), "HEAD", 0, NULL,
+				       NULL, &ignore_errno);
+
+	/*
+	 * If we would move the repository head, allow the move only if
+	 * the repository is bare.
+	 *
+	 * NEEDSWORK because we don't have an easy way to check if a
+	 * non-the_repository is bare, fail if r is not the_repository.
+	 */
+	if (head && !strcmp(head, ref->buf) &&
+	    (r != the_repository || !is_bare_repository()))
 		die(_("Cannot force update the current branch."));
 
 	return 1;
@@ -294,9 +319,9 @@ void create_branch(struct repository *r,
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
-	    ? validate_branchname(name, &ref)
-	    : validate_new_branchname(name, &ref, force)) {
+	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok) ?
+			  validate_branchname(r, name, &ref) :
+			  validate_new_branchname(r, name, &ref, force)) {
 		if (!force)
 			dont_change_ref = 1;
 		else
@@ -304,7 +329,7 @@ void create_branch(struct repository *r,
 	}
 
 	real_ref = NULL;
-	if (get_oid_mb(start_name, &oid)) {
+	if (repo_get_oid_mb(r, start_name, &oid)) {
 		if (explicit_tracking) {
 			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
 				error(_(upstream_missing), start_name);
@@ -316,7 +341,7 @@ void create_branch(struct repository *r,
 		die(_("Not a valid object name: '%s'."), start_name);
 	}
 
-	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref, 0)) {
+	switch (repo_dwim_ref(r, start_name, strlen(start_name), &oid, &real_ref, 0)) {
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
@@ -354,7 +379,7 @@ void create_branch(struct repository *r,
 		else
 			msg = xstrfmt("branch: Created from %s", start_name);
 
-		transaction = ref_transaction_begin(&err);
+		transaction = ref_store_transaction_begin(get_main_ref_store(r), &err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, ref.buf,
 					   &oid, forcing ? NULL : null_oid(),
@@ -367,7 +392,7 @@ void create_branch(struct repository *r,
 	}
 
 	if (real_ref && track)
-		setup_tracking(ref.buf + 11, real_ref, track, quiet);
+		setup_tracking(r, ref.buf + 11, real_ref, track, quiet);
 
 	strbuf_release(&ref);
 	free(real_ref);
diff --git a/branch.h b/branch.h
index 6484bda8a2..0177528304 100644
--- a/branch.h
+++ b/branch.h
@@ -51,7 +51,8 @@ void create_branch(struct repository *r,
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_branchname(const char *name, struct strbuf *ref);
+int validate_branchname(struct repository *r, const char *name,
+			struct strbuf *ref);
 
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise.
@@ -59,7 +60,8 @@ int validate_branchname(const char *name, struct strbuf *ref);
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force);
+int validate_new_branchname(struct repository *r, const char *name,
+			    struct strbuf *ref, int force);
 
 /*
  * Remove information about the merge state on the current
@@ -79,6 +81,9 @@ void remove_branch_state(struct repository *r, int verbose);
  * Returns 0 on success.
  */
 #define BRANCH_CONFIG_VERBOSE 01
+int repo_install_branch_config(struct repository *r, int flag,
+			       const char *local, const char *origin,
+			       const char *remote);
 int install_branch_config(int flag, const char *local, const char *origin, const char *remote);
 
 /*
diff --git a/builtin/branch.c b/builtin/branch.c
index 1fb4b57ca9..46fe7cb634 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -531,9 +531,10 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
 	 */
 	if (!strcmp(oldname, newname))
-		validate_branchname(newname, &newref);
+		validate_branchname(the_repository, newname, &newref);
 	else
-		validate_new_branchname(newname, &newref, force);
+		validate_new_branchname(the_repository, newname, &newref,
+					force);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2b9501520c..c98ba384dd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1762,10 +1762,11 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		struct strbuf buf = STRBUF_INIT;
 
 		if (opts->new_branch_force)
-			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
+			opts->branch_exists = validate_branchname(
+				the_repository, opts->new_branch, &buf);
 		else
-			opts->branch_exists =
-				validate_new_branchname(opts->new_branch, &buf, 0);
+			opts->branch_exists = validate_new_branchname(
+				the_repository, opts->new_branch, &buf, 0);
 		strbuf_release(&buf);
 	}
 
-- 
2.33.GIT

