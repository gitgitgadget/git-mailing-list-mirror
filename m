Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB71A6811
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457335; cv=none; b=AnQ1mopjmNWX6nUg2v/ZipYPXsgm39u3Ith47xOnyyqEDWFoMs9nNi7QL+aE4yP0koFpJLYXEg48KWb09iD/XLi+y4HJfAa9wRR93+olb/20nGEj7yEoJ6FeQj/LZ0Oq5yVdr1x6JA6xWNb0+myiqtscCGbj+9h8gtWcdrfdexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457335; c=relaxed/simple;
	bh=z9XkWrJgJCt6qXJMSYkQq85u1mGWjyaZPwLtowU8dKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPqOnK8VLSavbl1ItW8UmvUCoSScUB6GyHranF1mkyINtvEMKro48u2KQ/DRhP0revOCy+ib1ylh7ELRzseIUuETNu9aRKqLokmLZnAdpRMS05sNTNwAStcr7TH+SzuoLTt1OJEZ6I9ZM688oGeJ+Ke5cMYbYc6Fmd4dlb8IEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQ0aaa8g; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ0aaa8g"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b07069e2efso103285ad.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774457332; x=1775062132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vtss34o92dvgNZ6V/UMXfQUzRE9oWBgWrq8RogbkwyU=;
        b=OQ0aaa8gH8y/U18xkVzsrV6Y7GuJ2Iyfcj06yiU9XLL/CIw2TD1rkTmLTYzuJdVes8
         iFjGM8VEk+jYYkevDh4LYItEkdX3LvdpyLzezxzjqU6hGKNTyVgoNvrwTftbYPYFU+cr
         lTzc0+jSw2QNpHjk2ROuT6DNL/PSaBuFoj5dlgtYpH/Qg5VESNlYCTwMP1916900TlLi
         QxvVoUOkLJRPkdSDLqBYeZbw9mN1OtYt6snl//BYLNnBs2g03pj6980Cy1Mmb2dWXc/Q
         EJwJk9ehCXdBIDf/eiRzuJXsGalPFMdceTfefZ/kHZze3m2DP0XIs/y6etvaXh8hWkaN
         0mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774457332; x=1775062132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vtss34o92dvgNZ6V/UMXfQUzRE9oWBgWrq8RogbkwyU=;
        b=R2jkhGWZ0lxBLDdAQtYbObRKFn/1RIA/Kpk9SMZgTBxw14FsMZx/t1qKoRbQo9AMDo
         pyBdwu70IB+Si0zsRL2PxaCCP4SqrmJbc7SE6AOd8+Oto3h+hW+9vrOdHO+diVgw/OcC
         gUXWGReuHI3sl+BsPRVX7Bmp4GtIAxYVw4nf3sKfcLb+22JRGKzL4lAzgOLVh3Nas1m1
         KocgD41bUMsZw3WOLuwXNiJDHULjSUpfnJUhVvlLIkE/GVqf894804C7g4BrzQtaHZp8
         e3hgleTByAshESKjs+1jQTiXVs/PDp7skma+6Ls9v8yUBIEGoIiqNna1OB63lDedXp9I
         hWvg==
X-Gm-Message-State: AOJu0YyfU5tGG/YRhxc2Y0QkcPPiXSWATGgwLNopoW0xqNM1d59GErp2
	pCIEAD5kNRMOLXNf9N/03HEWzLMcHegx+8lI2xiSKgh8XCTeOqTgduVPM2BAwQ==
X-Gm-Gg: ATEYQzyfSdAbU04zCIG+8PnynHbomBNeLxMo1TOjO7PLpT21Du6H+AwDYJOnorhWaix
	t+okL+nn+So6uKneNzmCleFZ7ybnLRNuOKTGhfTD2UjOqK1OW1Y+ZKzIjTRSEl6bNKummVFbAkh
	35SI+V3FtOGsUL0FCQTdiq/nc7T7LfzXb2yob0CSEkO7qGvZ99WPAZVsUzWmUJYkJr8F+YcocGy
	7iUS5N+BcAB4CJEt/BVVSKUW+HQfgkSuVSF58Cd3A4HSPdJ9z3cdA0m8Nb4hJ+hBh6LZHrq+82x
	AUFW6rCkdewD6p1/hjIM9ZuowKj6VDLE7TD3emcLIVDFc9hokoAKYlrTQmFJZC2jicOfvhIEY0/
	DvTRlye4It3FllSG7DNBc/hxNGr0E3Q1gP+pVfdoMeycq6lc7JDYsx7gVOo9NC6yjl0laS2bK72
	XsSD9Hz+/YZNkVjyCrAUp5uaHitVUxLaUg//LReCMHo40=
X-Received: by 2002:a17:902:dac8:b0:2b0:6e12:bb21 with SMTP id d9443c01a7336-2b0b0ad2436mr46018435ad.41.1774457332287;
        Wed, 25 Mar 2026 09:48:52 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6f26:76cd:bafb:15d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm3901275ad.2.2026.03.25.09.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:48:51 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 1/5] refs: make branchname helpers repository aware
Date: Wed, 25 Mar 2026 22:14:18 +0530
Message-ID: <20260325164833.1216577-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copy_branchname() in refs.c relies on the_repository when calling
repo_interpret_branch_name(), introducing an implicit dependency on global
state. Add a struct repository parameter and use it instead.

Update check_branch_ref() to take a repository parameter as well, since it
calls copy_branchname(). Propagate this change to higher-level helpers
validate_branchname() and validate_new_branchname(), which also lack access
to a repository instance. Most callers of these helpers reside in builtin
code and already operate on the_repository, so pass it explicitly at those
call sites (builtin/checkout and builtin/worktree) otherwise pass struct
repository where available.

This makes branch name handling explicitly repository-aware and aligns with
ongoing efforts to remove reliance on global state. This change builds on
top of jw/object-name-bitset-to-enum (2026-03-18), which introduced the
enum interpret_branch_kind parameter to copy_branchname().

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 branch.c                   | 15 ++++++++-------
 branch.h                   |  5 +++--
 builtin/branch.c           | 14 +++++++-------
 builtin/check-ref-format.c |  3 ++-
 builtin/checkout.c         |  6 +++---
 builtin/merge.c            |  2 +-
 builtin/worktree.c         | 10 +++++-----
 refs.c                     |  9 +++++----
 refs.h                     |  5 +++--
 9 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..65189823c3 100644
--- a/branch.c
+++ b/branch.c
@@ -370,16 +370,16 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_branchname(const char *name, struct strbuf *ref)
+int validate_branchname(const char *name, struct strbuf *ref, struct repository *repo)
 {
-	if (check_branch_ref(ref, name)) {
+	if (check_branch_ref(ref, name, repo)) {
 		int code = die_message(_("'%s' is not a valid branch name"), name);
 		advise_if_enabled(ADVICE_REF_SYNTAX,
 				  _("See 'git help check-ref-format'"));
 		exit(code);
 	}
 
-	return refs_ref_exists(get_main_ref_store(the_repository), ref->buf);
+	return refs_ref_exists(get_main_ref_store(repo), ref->buf);
 }
 
 static int initialized_checked_out_branches;
@@ -468,10 +468,11 @@ const char *branch_checked_out(const char *refname)
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force)
+int validate_new_branchname(const char *name, struct strbuf *ref, int force,
+			    struct repository *repo)
 {
 	const char *path;
-	if (!validate_branchname(name, ref))
+	if (!validate_branchname(name, ref, repo))
 		return 0;
 
 	if (!force)
@@ -613,8 +614,8 @@ void create_branch(struct repository *r,
 		BUG("'clobber_head_ok' can only be used with 'force'");
 
 	if (clobber_head_ok ?
-			  validate_branchname(name, &ref) :
-			  validate_new_branchname(name, &ref, force)) {
+			  validate_branchname(name, &ref, r) :
+			  validate_new_branchname(name, &ref, force, r)) {
 		forcing = 1;
 	}
 
diff --git a/branch.h b/branch.h
index 3dc6e2a0ff..3aa53eb243 100644
--- a/branch.h
+++ b/branch.h
@@ -111,7 +111,7 @@ const char *branch_checked_out(const char *refname);
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_branchname(const char *name, struct strbuf *ref);
+int validate_branchname(const char *name, struct strbuf *ref, struct repository *repo);
 
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise.
@@ -119,7 +119,8 @@ int validate_branchname(const char *name, struct strbuf *ref);
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force);
+int validate_new_branchname(const char *name, struct strbuf *ref, int force,
+			    struct repository *repo);
 
 /*
  * Remove information about the merge state on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..9c86b9f525 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -259,7 +259,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *target = NULL;
 		int flags = 0;
 
-		copy_branchname(&bname, argv[i], allowed_interpret);
+		copy_branchname(&bname, argv[i], allowed_interpret, the_repository);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
 
@@ -581,7 +581,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	int recovery = 0, oldref_usage = 0;
 	struct worktree **worktrees = get_worktrees();
 
-	if (check_branch_ref(&oldref, oldname)) {
+	if (check_branch_ref(&oldref, oldname, the_repository)) {
 		/*
 		 * Bad name --- this could be an attempt to rename a
 		 * ref that we used to allow to be created by accident.
@@ -619,9 +619,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
 	 */
 	if (!strcmp(oldname, newname))
-		validate_branchname(newname, &newref);
+		validate_branchname(newname, &newref, the_repository);
 	else
-		validate_new_branchname(newname, &newref, force);
+		validate_new_branchname(newname, &newref, force, the_repository);
 
 	reject_rebase_or_bisect_branch(worktrees, oldref.buf);
 
@@ -898,7 +898,7 @@ int cmd_branch(int argc,
 				die(_("cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1) {
-			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL, the_repository);
 			branch_name = buf.buf;
 		} else {
 			die(_("cannot edit description of more than one branch"));
@@ -941,7 +941,7 @@ int cmd_branch(int argc,
 		if (!argc)
 			branch = branch_get(NULL);
 		else if (argc == 1) {
-			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL, the_repository);
 			branch = branch_get(buf.buf);
 		} else
 			die(_("too many arguments to set new upstream"));
@@ -971,7 +971,7 @@ int cmd_branch(int argc,
 		if (!argc)
 			branch = branch_get(NULL);
 		else if (argc == 1) {
-			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL, the_repository);
 			branch = branch_get(buf.buf);
 		} else
 			die(_("too many arguments to unset upstream"));
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 5d80afeec0..8222a289c9 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "setup.h"
 #include "strbuf.h"
+#include "repository.c"
 
 static const char builtin_check_ref_format_usage[] =
 "git check-ref-format [--normalize] [<options>] <refname>\n"
@@ -42,7 +43,7 @@ static int check_ref_format_branch(const char *arg)
 	int nongit;
 
 	setup_git_directory_gently(&nongit);
-	if (check_branch_ref(&sb, arg) ||
+	if (check_branch_ref(&sb, arg, the_repository) ||
 	    !skip_prefix(sb.buf, "refs/heads/", &name))
 		die("'%s' is not a valid branch name", arg);
 	printf("%s\n", name);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..7570a5664f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -743,7 +743,7 @@ static void setup_branch_path(struct branch_info *branch)
 			   &branch->oid, &branch->refname, 0))
 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
 
-	copy_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
+	copy_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL, the_repository);
 	if (strcmp(buf.buf, branch->name)) {
 		free(branch->name);
 		branch->name = xstrdup(buf.buf);
@@ -2014,10 +2014,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		struct strbuf buf = STRBUF_INIT;
 
 		if (opts->new_branch_force)
-			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
+			opts->branch_exists = validate_branchname(opts->new_branch, &buf, the_repository);
 		else
 			opts->branch_exists =
-				validate_new_branchname(opts->new_branch, &buf, 0);
+				validate_new_branchname(opts->new_branch, &buf, 0, the_repository);
 		strbuf_release(&buf);
 	}
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 2cbce56f8d..854490afef 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -552,7 +552,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	char *found_ref = NULL;
 	int len, early;
 
-	copy_branchname(&bname, remote, 0);
+	copy_branchname(&bname, remote, 0, the_repository);
 	remote = bname.buf;
 
 	oidclr(&branch_head, the_repository->hash_algo);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4035b1cb06..6ec2f02bf0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -415,7 +415,7 @@ static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
 	struct strbuf symref = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 
-	validate_new_branchname(ref, &symref, 0);
+	validate_new_branchname(ref, &symref, 0, the_repository);
 	strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
 	if (opts->quiet)
 		strvec_push(&cp.args, "--quiet");
@@ -481,7 +481,7 @@ static int add_worktree(const char *path, const char *refname,
 	worktrees = NULL;
 
 	/* is 'refname' a branch or commit? */
-	if (!opts->detach && !check_branch_ref(&symref, refname) &&
+	if (!opts->detach && !check_branch_ref(&symref, refname, the_repository) &&
 	    refs_ref_exists(get_main_ref_store(the_repository), symref.buf)) {
 		is_branch = 1;
 		if (!opts->force)
@@ -649,7 +649,7 @@ static void print_preparing_worktree_line(int detach,
 		fprintf_ln(stderr, _("Preparing worktree (new branch '%s')"), new_branch);
 	} else {
 		struct strbuf s = STRBUF_INIT;
-		if (!detach && !check_branch_ref(&s, branch) &&
+		if (!detach && !check_branch_ref(&s, branch, the_repository) &&
 		    refs_ref_exists(get_main_ref_store(the_repository), s.buf))
 			fprintf_ln(stderr, _("Preparing worktree (checking out '%s')"),
 				  branch);
@@ -788,7 +788,7 @@ static char *dwim_branch(const char *path, char **new_branch)
 	char *branchname = xstrndup(s, n);
 	struct strbuf ref = STRBUF_INIT;
 
-	branch_exists = !check_branch_ref(&ref, branchname) &&
+	branch_exists = !check_branch_ref(&ref, branchname, the_repository) &&
 			refs_ref_exists(get_main_ref_store(the_repository),
 					ref.buf);
 	strbuf_release(&ref);
@@ -885,7 +885,7 @@ static int add(int ac, const char **av, const char *prefix,
 		new_branch = new_branch_force;
 
 		if (!opts.force &&
-		    !check_branch_ref(&symref, new_branch) &&
+		    !check_branch_ref(&symref, new_branch, the_repository) &&
 		    refs_ref_exists(get_main_ref_store(the_repository), symref.buf))
 			die_if_checked_out(symref.buf, 0);
 		strbuf_release(&symref);
diff --git a/refs.c b/refs.c
index 685a0c247b..840965519e 100644
--- a/refs.c
+++ b/refs.c
@@ -744,13 +744,14 @@ static char *substitute_branch_name(struct repository *r,
 }
 
 void copy_branchname(struct strbuf *sb, const char *name,
-		     enum interpret_branch_kind allowed)
+		     enum interpret_branch_kind allowed,
+		     struct repository *repo)
 {
 	int len = strlen(name);
 	struct interpret_branch_name_options options = {
 		.allowed = allowed
 	};
-	int used = repo_interpret_branch_name(the_repository, name, len, sb,
+	int used = repo_interpret_branch_name(repo, name, len, sb,
 					      &options);
 
 	if (used < 0)
@@ -758,10 +759,10 @@ void copy_branchname(struct strbuf *sb, const char *name,
 	strbuf_add(sb, name + used, len - used);
 }
 
-int check_branch_ref(struct strbuf *sb, const char *name)
+int check_branch_ref(struct strbuf *sb, const char *name, struct repository *repo)
 {
 	if (startup_info->have_repository)
-		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
+		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL, repo);
 	else
 		strbuf_addstr(sb, name);
 
diff --git a/refs.h b/refs.h
index d65de6ab5f..72b8ea609a 100644
--- a/refs.h
+++ b/refs.h
@@ -226,7 +226,8 @@ char *repo_default_branch_name(struct repository *r, int quiet);
  * repo_interpret_branch_name() for details.
  */
 void copy_branchname(struct strbuf *sb, const char *name,
-		     enum interpret_branch_kind allowed);
+		     enum interpret_branch_kind allowed,
+		     struct repository *repo);
 
 /*
  * Like copy_branchname() above, but confirm that the result is
@@ -234,7 +235,7 @@ void copy_branchname(struct strbuf *sb, const char *name,
  *
  * The return value is "0" if the result is valid, and "-1" otherwise.
  */
-int check_branch_ref(struct strbuf *sb, const char *name);
+int check_branch_ref(struct strbuf *sb, const char *name, struct repository *repo);
 
 /*
  * Similar for a tag name in refs/tags/.
-- 
2.53.0

