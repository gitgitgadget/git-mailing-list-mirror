Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E923ED5B2
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585795; cv=none; b=g7vE3EyuqjYVS+LrBlrAA2qUEXeQ7Xmf9I5Ro/kV6BYwVIuugpDAm5bpAuT3rDJv6u0Zd5k/S0HBFPfE7xhg5NFT83jiTfFPDw25C9rcsVCe3vuzDhJAl3XGjbReuQKPEKYU5+AI5duznv0yPy1tI4XJLwrJqjkfr/3AFuEHMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585795; c=relaxed/simple;
	bh=S/YrVUFvvI4nF0ks9YOWfH2S5OXxEF6MLBfh0OHEtmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ay+uGAAiLQjNeRVij9j/myXC+rDymhmW2cO55gRpw2CizEvwd7RFrRGqTVB/CeyhRYKqOKPGVXtvuDf74SRxA9Tuwt/KA9SPSlvHkpbgmLTJ7CsTqienuij3462AKHOl4QYNTWaZ5hGWaVYgZP7JlB3B85tycGH8/KhkmZ/zIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cXU7DXSj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEQjvGE3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cXU7DXSj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEQjvGE3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7560D7A0148
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:29:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 04:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783585793;
	 x=1783672193; bh=C5pLgdH2hKdMaXe9Ar2OJ5BK09In1x7mlOq3ue4YMyo=; b=
	cXU7DXSjG/hGLj28Koi1GhKYa2oRMOwY/wCe8IS31cdVhSXImZTm+DP5F7Zyz6aK
	RuKTqXNXNgKI6QKUgGNkfxEDpnIkXTRXRJ46mxQVyFCsea2Bj05GZZtW1UIVtodz
	jBL8wEgMQLEwsrJ7aOXJj9S3LPWeHjqBNbO+5awJRH2jCBeIz2cOaSQZCtkqKGOu
	WNHTowysF1zNavVgWOnBGcPE2la+pKR0iaLBm+me9175u3KoZ7GWPS3mgd9lro7V
	DuX+N0ArVtln4pu8o++7HVbwzWJTEVa8M8knfJ2nFt+GqWh1b1upVVSe7TjOiTLU
	YqyM2Ecod7xfgwyqaddtvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783585793; x=
	1783672193; bh=C5pLgdH2hKdMaXe9Ar2OJ5BK09In1x7mlOq3ue4YMyo=; b=U
	EQjvGE3ObMmPLKFmf5lxKPSs/mW5hi5w01zRM539g/gfWwR4l8y4XTlb38Mt4RMn
	qpH0lejaCY3aFGwBccRAqYnveWeOoqXRJ8iXD9jscYK5qtONMorqKpK2kHtLpDNb
	cbcHq8LZi/q8cnybZ4PJUx8/vLgVYzUx5CACwyAmfZGUCYyho3szy0jnLPCg2dOq
	bEd8Yw5n4SKDsgVvX95crVK0haoaM5zuEI9mM7AeXTJ8nngGcoSop6xnXnO9knJg
	hdZxk3v9KghrFvQEXnaNEXGdowpPLKGeRD5mQt1RcL/Q/IiX2Cw9jOAc1qCsKKGA
	O2KkOSCsx5susveUoH6dQ==
X-ME-Sender: <xms:AVxPaqVsZLlVj0nEEaA5mfwNqJpe9fMLGpkQuKIIoPm1B7Z6R0Zg9A>
    <xme:AVxPatiUGg66G8c9f47w8L2cFwzL-rvEBGmUGch255zjkP9qskIlFp0U5LZGm9lx1
    5ZQ3Fefkv7AubiirFWlMRFDRZBaJ3isK-HMc9-6ivnutVtMlEtunw>
X-ME-Received: <xmr:AVxPakDbTeaqxIuwmbQ2oZavkeaSqZAdqrvn-6VpUo_ncat92jdY4YewHDVYxTaAMx7GwsJ8VhONqYPpGw_ViMIAFExgYIPPb7UFju4DUA>
X-ME-Proxy-Cause: dmFkZTG0KSrVQrMerlpl69jNs503QS7WCYNXlJZX7bgXqFIFuwSflj3Wy3kcnrEj3Meeo6
    RASWfb1B5FMJ/3ZIBzD0Hq2dcMUslsCfXnyjsq6FgtPBqp/IAB7DBjel9+UgXXwFBKyF1g
    66s02lJxrILdZyCoatwx81OcDowT5yBU3s+0MyQEzjF5JVbaW/wZumVCoDdncw3sRzw7Kz
    0EpWsPSVCSz6ZGVBabQ/+bEf+9slNUgr6Ht3cF7vIvEDV2gi9r1IWMsqaOjsA4mOEfXY8o
    Mcno1leo9vI8O9zlRLYc4ZDs7xJ0FFq+9NmuEZYnI4yyM2R9naSS2gI0SJt/92cN/to0pU
    M5wn8PHZe0jWWLYhQE1bWN3HjbWycyP93MQUilK5VfVIkTdtO5kG5ZBDIdaFweI2PI8p+d
    j6/ltbBIVXyYTWbXcvudNI36pzCtPMeXb+83o33u02yp8GuIfATTq1KMiZikNWNwpkOwUG
    GjJF1O2pY8CW9Pszu+RcnLb2eBnVF0oEsSQsvW8rFw+/jnGmQYF/Eb1zbAgyU1Zo7QZ9Gc
    RCZbq9vZ1ZpJAvFMC4Ifn9x7L9zEa6w1/2t1Az1AG209UdlfTyyf0A9IgC1REGcihpBoUO
    WNHZY3xD3LSJy2armhiNxQpBrbOT6XWe9uj46p0GNY+PoL0nEZuhxULj+j2Q
X-ME-Proxy: <xmx:AVxPamdblwnwAVaqgjdwsM3xNlLa9JsiNqE9771WCM1HShPL4nwf3A>
    <xmx:AVxPakdqqUcYOm-n1hIxnSJG8fXHJe9ARUgJH4RRwlX5LgtsEgd4Jw>
    <xmx:AVxPaij3vAW8vb_21JcEGnSbnZ71NTOFsMjwNY85G_DaLAcXtj7Wsw>
    <xmx:AVxPaoQ1Ys8Km56h3XWwKytVoByuWZk3qaPk0GDjpst0FD6DJtYisg>
    <xmx:AVxPaplSxQoCmAc2gGLbpXQxXVq3Q5RMM8MVJ1VI-37C2i5BBsaCwjXm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:29:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0035df58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:29:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:29:18 +0200
Subject: [PATCH 7/7] refs: remove remaining uses of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-refs-wo-the-repository-v1-7-1ad6f27529c9@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
In-Reply-To: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.55.0.175.ge4962bd3d5.dirty

