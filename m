Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD73C2781
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101199; cv=none; b=eW+nW5G3tON6UFXXIoT1FM9Hf4vkxejnh9Tt+1fEatcE0MwhoJXd/g/NRGCvVLr+Bki8FJTLtspEPdyA6K5EiBFtfFzeZQXUst20z/TH1We464PRWWcfhJgCDwcldwFvKcLzQ39kxTbEfxZ0sOX7QCnrP0HBvjhbRbyIDcl5Ii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101199; c=relaxed/simple;
	bh=lhPhw0LpvC5QUkkSniT7rwvFmgFrsWBsdTAQqbL6UNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JO8v9VvgUg/cYGs8YC6fKrSeNks4B5jfNZavV41FLytj7/Z53FPKuns8YRpUwnOPGMJgT1jjWrrm8mbPEgnl1p1PnCC8L1vCR5S6uBTkYTPAjLK+00Nzkq99ZfNd8+zEtpOmkv4g72SKRgiDtwX0c2SJ6N0fOZAezz+A/8DfAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gmqf5iAT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jp6SAlZz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gmqf5iAT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jp6SAlZz"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EAD1F7A0149;
	Wed, 15 Jul 2026 03:39:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 03:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784101196;
	 x=1784187596; bh=wk+x/Bir3ZUnqlFGiHiTmBAAHed5JhJ9eXeIvkoo0kk=; b=
	Gmqf5iATA9Ed6iHpWtyj61r5v+iM5lMEZBk+Zy4xtHfH9admMMUYeTyscruMEdnF
	N9yGVGDE2KD5PkaFv9sjf05N3CTTzzl/4z9YodikZyiosX7Axi2Y++EQA/qhBCR5
	DoSLdPKILiJvY2B6shYFKqrLS0Zzj6yBrFNB4BdDtpETBR7ESjbdO1vHh0JgrkhP
	q7D3LVszO7HEj3TA/HlRg7OhzE+RIqHjCxHEE8TjcNxBUhdifDriL5yAy2jxgMxp
	gyUfo7Tcn7hsNNKVkRyzRBsu/KF7oYVB75C5Lhl1hd+0SF1h8w/pV8v8IPd+QqFl
	Dw7zCDOTbB5cJpzeuOI8Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784101196; x=
	1784187596; bh=wk+x/Bir3ZUnqlFGiHiTmBAAHed5JhJ9eXeIvkoo0kk=; b=j
	p6SAlZzkEPxN1zQ76c2czGaEsglWTCOJCB+euGYVPhuuoXaVzVD7BMFZ9eWVfIjU
	XK4KNzBSWoGLkvJR3cbqEK/iUCIb4W8a8vdeNaqAWFVW69sM6oGlC4BiJyVJh2tc
	6wGMjsExpM4KSHf6T2OWEgdychGuZeqGBs7aUMRCF6FaR7wBH1o9rvOJ+C9TM4ph
	LVxfZg303p0dfqyL2StpiRDiaAT12Pm0i21mL3JcKwhc7YY917oDMvrefeapie/t
	6KHkE2a/asAHlKp1npsqT+yCBNHnR27dsG3+a8ynnmzmK2CiuxppQbm/9gBLTAYF
	k3zpFAqst1ehsi93w+MMQ==
X-ME-Sender: <xms:TDlXagudY2cfk8EaEMJ5T0UNhcXgQPY9HErPPTQcmkK4JiTKxv3qFQ>
    <xme:TDlXajdfOa14nT0GLIkijhzxPd3DrDxRrDKoqfuXc9RiNylHYHhxau5nN5yP5LbSf
    VgokpHcjBXpX5bZ_SBljQvnZm2QNY8ywxeI3PwROo7vIkZNR6C76w>
X-ME-Received: <xmr:TDlXapbq9fldnMa7DeXw4OeD7EmZaH_mqsKYf_BxUCoL4eaobKRJSu2pCCgraE7tB6L8RFBW-JHGlD7YgBsuKZg2PRyvLC-frqTxh1n06Yk>
X-ME-Proxy-Cause: dmFkZTGK3e1xq10g9H+eaI8Qca7IIpa67ANoiOnlBVJnvZo9C1IvtIQiKmonJXHo0c02+G
    5ZqJdeFCWDuNinkqdf9LW+S5rFn/XO0RZb2l4qfJXhxtO/kNxi+MhlQ7Zsr/7hc5EwzrBa
    jZjUayygEG8Bfp9r8u4BA7lQrdE5+2R9wKDRb02dCwg9U4zY3tnxdNdUNBbauIbxmAWco5
    fP//QiR8VIQ1qcx9jsqkMD1IiR0ygxr+NwzVjNVjOtMOrEhKmX7K1H49k3Y0eBfkAGep+X
    OM5JZzWWukbyXy2Ez3SAgW2ZLfjX/RhhSFgM8/c5+aevfNfgNdFSMJ5+O1JeinxMWvOaeY
    R7npwVdxsTjrTZVOABhELS6jorL+/zRcCltEP7/agjvneqUMfy6ob+PrHA3CG7yGjGnP2M
    OFm+0nAy+N7omOMRess/aMlFI3F4V6rNwaFqtvZLBCZeF+he/Y/dkiPoHjGPT9BmotVNE0
    JRTas0NlGNVj2Q/jhDMbMkfkG07QoLpAXziIv/tdkG+MB6GiOZFMJN2+oArs96p2SE2iWU
    ovbT9ONZ3s7UMOkDUeZX3EodLGhBaBXscIyjbPRehMlbMO064kiISNIaA10+JfOeT2Bmpg
    WtZQB265+B8azDIcA4CdvN7PMcLPvpNM9GWctNzEmK5imJ4NJSbzQbntNOjw
X-ME-Proxy: <xmx:TDlXauXumdwUYDhDvTTcb-vrBoaYdU5y7CA5mC4Pwc1DSiqOmEhClQ>
    <xmx:TDlXajjzDvXQ7WIUcgO1c_kOtvP_wD-GqtQc5l_4P1JEQj-xp2oNPg>
    <xmx:TDlXakXKGSsoI2hjne5V_mMJNy6RWkMFTGy2R6_A_zCJ29SUwQO5lg>
    <xmx:TDlXaiPQ5a5_5UnVZUwFfoxoipG5Mezc1GL4azKPqg9YcUcDPZU1VQ>
    <xmx:TDlXasEM-5hpPRpikTwN3ynDnJ07LHTyNsjQJJFxS9bqWUzyJS0BJjyQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 03:39:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71639f72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 07:39:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 09:39:40 +0200
Subject: [PATCH v2 7/7] refs: remove remaining uses of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-refs-wo-the-repository-v2-7-d00d364f5a3e@pks.im>
References: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
In-Reply-To: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

There are still a couple of callsites that use `the_repository`. Convert
these to instead use a repository injected by the caller. This allows us
to remove `USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c                   |  2 +-
 builtin/branch.c           | 14 +++++++++-----
 builtin/check-ref-format.c |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/merge.c            |  2 +-
 builtin/worktree.c         |  8 ++++----
 refs.c                     | 23 +++++++++--------------
 refs.h                     |  5 +++--
 8 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/branch.c b/branch.c
index b2ac403b19..4f38905bad 100644
--- a/branch.c
+++ b/branch.c
@@ -372,7 +372,7 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
  */
 int validate_branchname(const char *name, struct strbuf *ref)
 {
-	if (check_branch_ref(ref, name)) {
+	if (check_branch_ref(the_repository, ref, name)) {
 		int code = die_message(_("'%s' is not a valid branch name"), name);
 		advise_if_enabled(ADVICE_REF_SYNTAX,
 				  _("See 'git help check-ref-format'"));
diff --git a/builtin/branch.c b/builtin/branch.c
index c8fddf7f94..be26ec0750 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -259,7 +259,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *target = NULL;
 		int flags = 0;
 
-		copy_branchname(&bname, argv[i], allowed_interpret);
+		copy_branchname(the_repository, &bname,
+				argv[i], allowed_interpret);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
 
@@ -581,7 +582,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	int recovery = 0, oldref_usage = 0;
 	struct worktree **worktrees = get_worktrees(the_repository);
 
-	if (check_branch_ref(&oldref, oldname)) {
+	if (check_branch_ref(the_repository, &oldref, oldname)) {
 		/*
 		 * Bad name --- this could be an attempt to rename a
 		 * ref that we used to allow to be created by accident.
@@ -898,7 +899,8 @@ int cmd_branch(int argc,
 				die(_("cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1) {
-			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(the_repository, &buf, argv[0],
+					INTERPRET_BRANCH_LOCAL);
 			branch_name = buf.buf;
 		} else {
 			die(_("cannot edit description of more than one branch"));
@@ -941,7 +943,8 @@ int cmd_branch(int argc,
 		if (!argc)
 			branch = branch_get(NULL);
 		else if (argc == 1) {
-			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(the_repository, &buf, argv[0],
+					INTERPRET_BRANCH_LOCAL);
 			branch = branch_get(buf.buf);
 		} else
 			die(_("too many arguments to set new upstream"));
@@ -971,7 +974,8 @@ int cmd_branch(int argc,
 		if (!argc)
 			branch = branch_get(NULL);
 		else if (argc == 1) {
-			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(the_repository, &buf, argv[0],
+					INTERPRET_BRANCH_LOCAL);
 			branch = branch_get(buf.buf);
 		} else
 			die(_("too many arguments to unset upstream"));
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index e42b0444ea..fd1c9c0e0c 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -45,7 +45,7 @@ static int check_ref_format_branch(const char *arg)
 	int nongit;
 
 	setup_git_directory_gently(the_repository, &nongit);
-	if (check_branch_ref(&sb, arg) ||
+	if (check_branch_ref(the_repository, &sb, arg) ||
 	    !skip_prefix(sb.buf, "refs/heads/", &name))
 		die("'%s' is not a valid branch name", arg);
 	printf("%s\n", name);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index aee84ca897..55e3a89a85 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -805,7 +805,7 @@ static void setup_branch_path(struct branch_info *branch)
 			   &branch->oid, &branch->refname, 0))
 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
 
-	copy_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
+	copy_branchname(the_repository, &buf, branch->name, INTERPRET_BRANCH_LOCAL);
 	if (strcmp(buf.buf, branch->name)) {
 		free(branch->name);
 		branch->name = xstrdup(buf.buf);
diff --git a/builtin/merge.c b/builtin/merge.c
index 5b46a596f0..58d1b7bb07 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -553,7 +553,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	char *found_ref = NULL;
 	int len, early;
 
-	copy_branchname(&bname, remote, 0);
+	copy_branchname(the_repository, &bname, remote, 0);
 	remote = bname.buf;
 
 	oidclr(&branch_head, the_repository->hash_algo);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0689b3d3e0..6397e149a8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -481,7 +481,7 @@ static int add_worktree(const char *path, const char *refname,
 	worktrees = NULL;
 
 	/* is 'refname' a branch or commit? */
-	if (!opts->detach && !check_branch_ref(&symref, refname) &&
+	if (!opts->detach && !check_branch_ref(the_repository, &symref, refname) &&
 	    refs_ref_exists(get_main_ref_store(the_repository), symref.buf)) {
 		is_branch = 1;
 		if (!opts->force)
@@ -650,7 +650,7 @@ static void print_preparing_worktree_line(int detach,
 		fprintf_ln(stderr, _("Preparing worktree (new branch '%s')"), new_branch);
 	} else {
 		struct strbuf s = STRBUF_INIT;
-		if (!detach && !check_branch_ref(&s, branch) &&
+		if (!detach && !check_branch_ref(the_repository, &s, branch) &&
 		    refs_ref_exists(get_main_ref_store(the_repository), s.buf))
 			fprintf_ln(stderr, _("Preparing worktree (checking out '%s')"),
 				  branch);
@@ -772,7 +772,7 @@ static char *dwim_branch(const char *path, char **new_branch)
 	char *branchname = xstrndup(s, n);
 	struct strbuf ref = STRBUF_INIT;
 
-	branch_exists = !check_branch_ref(&ref, branchname) &&
+	branch_exists = !check_branch_ref(the_repository, &ref, branchname) &&
 			refs_ref_exists(get_main_ref_store(the_repository),
 					ref.buf);
 	strbuf_release(&ref);
@@ -869,7 +869,7 @@ static int add(int ac, const char **av, const char *prefix,
 		new_branch = new_branch_force;
 
 		if (!opts.force &&
-		    !check_branch_ref(&symref, new_branch) &&
+		    !check_branch_ref(the_repository, &symref, new_branch) &&
 		    refs_ref_exists(get_main_ref_store(the_repository), symref.buf))
 			die_if_checked_out(symref.buf, 0);
 		strbuf_release(&symref);
diff --git a/refs.c b/refs.c
index d9957a266c..92d5df5b71 100644
--- a/refs.c
+++ b/refs.c
@@ -2,8 +2,6 @@
  * The backend-independent part of the reference module.
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
@@ -744,14 +742,15 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
-void copy_branchname(struct strbuf *sb, const char *name,
+void copy_branchname(struct repository *repo,
+		     struct strbuf *sb, const char *name,
 		     enum interpret_branch_kind allowed)
 {
 	int len = strlen(name);
 	struct interpret_branch_name_options options = {
 		.allowed = allowed
 	};
-	int used = repo_interpret_branch_name(the_repository, name, len, sb,
+	int used = repo_interpret_branch_name(repo, name, len, sb,
 					      &options);
 
 	if (used < 0)
@@ -759,10 +758,10 @@ void copy_branchname(struct strbuf *sb, const char *name,
 	strbuf_add(sb, name + used, len - used);
 }
 
-int check_branch_ref(struct strbuf *sb, const char *name)
+int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name)
 {
 	if (startup_info->have_repository)
-		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
+		copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
 	else
 		strbuf_addstr(sb, name);
 
@@ -3326,9 +3325,9 @@ static int move_files(const char *from_path, const char *to_path, struct strbuf
 	return ret;
 }
 
-static int has_worktrees(void)
+static int has_worktrees(struct repository *repo)
 {
-	struct worktree **worktrees = get_worktrees(the_repository);
+	struct worktree **worktrees = get_worktrees(repo);
 	int ret = 0;
 	size_t i;
 
@@ -3373,12 +3372,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 * Worktrees complicate the migration because every worktree has a
 	 * separate ref storage. While it should be feasible to implement, this
 	 * is pushed out to a future iteration.
-	 *
-	 * TODO: we should really be passing the caller-provided repository to
-	 * `has_worktrees()`, but our worktree subsystem doesn't yet support
-	 * that.
 	 */
-	if (has_worktrees()) {
+	if (has_worktrees(repo)) {
 		strbuf_addstr(errbuf, "migrating repositories with worktrees is not supported yet");
 		ret = -1;
 		goto done;
@@ -3503,7 +3498,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 * repository format so that clients will use the new ref store.
 	 * We also need to swap out the repository's main ref store.
 	 */
-	initialize_repository_version(the_repository, hash_algo_by_ptr(repo->hash_algo), format, 1);
+	initialize_repository_version(repo, hash_algo_by_ptr(repo->hash_algo), format, 1);
 
 	/*
 	 * Unset the old ref store and release it. `get_main_ref_store()` will
diff --git a/refs.h b/refs.h
index a381022c77..9979446d15 100644
--- a/refs.h
+++ b/refs.h
@@ -234,7 +234,8 @@ char *repo_default_branch_name(struct repository *r, int quiet);
  * If "allowed" is non-zero, restrict the set of allowed expansions. See
  * repo_interpret_branch_name() for details.
  */
-void copy_branchname(struct strbuf *sb, const char *name,
+void copy_branchname(struct repository *repo,
+		     struct strbuf *sb, const char *name,
 		     enum interpret_branch_kind allowed);
 
 /*
@@ -243,7 +244,7 @@ void copy_branchname(struct strbuf *sb, const char *name,
  *
  * The return value is "0" if the result is valid, and "-1" otherwise.
  */
-int check_branch_ref(struct strbuf *sb, const char *name);
+int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name);
 
 /*
  * Similar for a tag name in refs/tags/.

-- 
2.55.0.313.g8d093f411d.dirty

