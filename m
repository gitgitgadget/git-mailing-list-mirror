Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD029B78F
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180012; cv=none; b=FBouqWRreuwMM066Sxk3aB33c97YVyeQw238yr7WpkYKUK3nVIdR/Vznd9poAuMFipDnRphhICO7fl2AMMrxfIDSX2PWqz3SdvGvnowP3Q+6YYpQ6CdZ2lvr9Z9PPu5jJ3rsGVcFgC6Gvtd1zywjeKNSluETpT2kZG//0XlKACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180012; c=relaxed/simple;
	bh=lhPhw0LpvC5QUkkSniT7rwvFmgFrsWBsdTAQqbL6UNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCHWhiRKfjSIgvBF08r/ZS2IhIla+iiHWWWCo0HUFhjqd6SVfXqDt6Nqz/3yo6ID2c9A20iKZC6yT3bo1AQ1lCy2t/rXOcDueuJyK9yw5ZD6kWiwtCJYh2rJevxfHiRWNoECKavj6FYSz+5MGBH7uAwksRPoPsHnni1eoWHY42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=epQOdG+/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnkAIUGv; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="epQOdG+/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnkAIUGv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F3871D00109;
	Thu, 16 Jul 2026 01:33:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 01:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784180010;
	 x=1784266410; bh=wk+x/Bir3ZUnqlFGiHiTmBAAHed5JhJ9eXeIvkoo0kk=; b=
	epQOdG+/EHRAVMdw1PaE5swMsYZBcWGIAdVHrHziWB8C1snd7kRaFRkmpmAoWmmn
	I9pIk2Hi6mVhooF2HZ22l0nlqakNB74ogXSr5lIXGHMJFGjDfmg9UuzjD+/HuiKI
	YzLrFzRA/eC2g5QBAhPTJuHy7MXRPqcx3jFv1j2aluI7M5Xg2jsRbEXUxe9Tg7E9
	YjrJ1DIBPQNea4zozZQMsHXo4Xtd30igP4fSfblNKqiZAIi7IsVZu8rKqrUNK9c3
	Ai81b5A8lk8PRYhFUINO7MhdQf0Mm1YgAUomH2ZOQGcSCHbvJ91mQrbct5LBqfxI
	v0JPRzhUkTu/D/+xKq8d4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784180010; x=
	1784266410; bh=wk+x/Bir3ZUnqlFGiHiTmBAAHed5JhJ9eXeIvkoo0kk=; b=J
	nkAIUGv2CLomPaGBCOxBLuoFtaK3enK+badsLkeNzQH+p/AQw8yRrmRd+90B5EJY
	kikoMj9pfsukcVzpAUpO3/AhXdufnRoYtWRKIxxIb8oU0Gcc9/80iEqaLmdRh6wE
	ck4Owk4flokv8mmgP3dzC4zYdDNDITA2dr8k+SUAxtg+EZOdgb9ZsGp0muQ1roqH
	KSgS84osKfbhxz5PCEZjiNvgSLZ4sFf2F8JlpcIsJYRVYL4qvUSXXxE/U9755dsQ
	R2uEGM9Z2i8xDyjMJjx0KPEMBndvtlmfPoOOF47cm7eCzJ+f7p2g8uac2bgxh40m
	lL40Ciyr4L1wKKNPh8eWw==
X-ME-Sender: <xms:Km1YanKdeAwHgq9poMvroc0O3MYa1cVbhTbKMAPTkZSdsmMrEwQHdQ>
    <xme:Km1YailtuV8l9eGRC9icU5S96YrI4pEvbFrOvggF6igB3sDS7COSoEjOrWz3X8AcQ
    4ftmVxcvdUBi_lz-nBBYqeGhH4DxvBSWQxtT8Wi_N3lNmbBq-8W>
X-ME-Received: <xmr:Km1YatFYUL7YPYBCDWwrl9oXBrlL2DIoWt3PI1VV8Ub6U8pu3YdzPX7-tZy1yp5AhYlj1ud4Tf0qsCCrkr0JRlyDBnu_1SIUa2w9-lfm>
X-ME-Proxy-Cause: dmFkZTE3sd9Rgq0aRyFtptZUq81EFixIPvqz3pxNdSCnN20LGThertVtMVbre27mftpmEH
    qGs+EpopQa2hsq1ogJehRFK/z5tOf9MQPhGL0+9xQ9ejaxOniWyxLQkI1zFZ6RSnjjvvJf
    L1NdgMe137p63bb/fu7hdzzHAIDzMSB5Wwnt3+iFZyE8bMuRZlWaA/5BCJ1a1ayI5QuR8P
    D8sp9u17MkpxUCCq5pJuwtzLCi0Bb6TEpRusMhhPMKUeiiEi4ErvBD0vBiFniU/3WdI9F2
    898u8vaP4WMsA7FyLLF5BfnREOORK9tSe+kpbdjyzGV6ZTqZ2c5Qnzzdbw7ZNn9bhG8mCO
    1ZwPHEdKFgZFUi/ypqC2V1ps6mruJaMhk/qOONJZMWCGybp3nHztq7DFYAY9Ip2y62q2Mc
    s/HLk5ZU7Ko36T/UJUfsnYBg6WPr+eGM2N4DDKkU3CQVq/a1/6/HO1bfTv88HIvPOTd7YN
    DuLnvPpP9Javn6bu9GaCQedlgFnLrnv9XNRgG+0K+D0jRsdx5Y6zgfElu9iDkN1yo6j01i
    krNeoRJYM4ayW/nndgdvAuRvWz3JbD/Ab8gM/tCYYgBj0dezoHz44T6V5otv7+tvep7JRU
    YTiNg6nCF/J9YskhXjjGJRYGy5ecCk28bxRDl9z+r1vZGdKwPt/WyKsxNMyg
X-ME-Proxy: <xmx:Km1YaqEaeD-6SOUpuyVyiSk7-wJQDO-Qn8o36Gz8zxdBCXItIAhXQw>
    <xmx:Km1YaiN43YKuryp4VeYLOCUcfST7OLFXE61Qj4C7_549uOTaQ3zq-A>
    <xmx:Km1YahEaEdeDWAIRyZvMPwtKnteQNqt9SG4LO6gYdWt71Pt70cVVqQ>
    <xmx:Km1YahNpMiOQq-nymF4Nat_7kyGIKwz2s-sBtxVq5OtBQlJF199a3A>
    <xmx:Km1YajP71PtZ6H76TsZTOA1_lTSywQrJEIYR4REK_-dhGiXXnat8DDiz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 01:33:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5242040 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 05:33:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 07:33:07 +0200
Subject: [PATCH v3 6/6] refs: remove remaining uses of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-refs-wo-the-repository-v3-6-db0a804e0224@pks.im>
References: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
In-Reply-To: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
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

