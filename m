Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925B22689C
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218211; cv=none; b=Hs4EwyvOHWh+VSVeNqLGDf2kPXc0u6eT9pHKy02h35fn/RrXZJ+Hp+IkhxPpamsFkRrHbi+Miw5pDaDhJUdNKghU4QeEw9RIG4MGaCaWATSWIs6A7qZXQjJrwHzHY2mNYw+CJB9biLEuDo2LRS16r32LmWL/FabAOxnnATmUnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218211; c=relaxed/simple;
	bh=4uelkCUoo5aNoJ2LbiEsm3aMB8t9u/eNtDe4NtwKczY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heXAFJxoOyAVSUhu7DyfWuHzb05GIlaRvqMkAC8UHoZMQQAYnPqpUOoZTHJS0Ibjbcg3webEgtWqES+aRg1bNYsE4JCFH4n45HK/w7RRtBdr44XBELrNEU+znL+BrbUWr1Ni4uq3UcGYnA/r6LqdJAsiv5ocQVvIqvZKzjNY3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7tn5Lq3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7tn5Lq3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso933894b3a.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 05:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775218209; x=1775823009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUFUUDIh9FLZDCDlsEmRrFxF5rrFn0jW3FVavCMoNhA=;
        b=Z7tn5Lq33UL/D9/AFZYyPIuBnc/gHzqrFHKwjDLxq8XT0kvSXPg+4vSnSUivAj+dBV
         opnNLW8UrTTsGsTHSjwlzk4lLT4tuuTGDOTarESfjlCOQ9bxEO//q31mWJK2qSvGxPHK
         q3TIeZvGUKZAkg4dOFGpkcqTLkAJ40ym+cSP6wV/qmwV37yHvSB/dDaPUgseKYHGLu5C
         ot3JTOhhiTcporHi9Nqb67iLypLSnM6T3N/5uXD572xLGQXEqadIRXNLEzm7b5EWQ7nc
         xewhVwjT34I5LERIFqJUnAo1TZeDg0uGmQh+MXiOlwmPHKLXCZI9nXRyw9IYomIIP4uc
         WGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775218209; x=1775823009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PUFUUDIh9FLZDCDlsEmRrFxF5rrFn0jW3FVavCMoNhA=;
        b=a6bdFXmSZjaHJudbQua0QsGygnU6Xz3JPWNTiX4L+hBPPD38f49CNrUmyhA54VHeAV
         LvYcGfTFKmObspnSv1q59bkwualDYR2SAPG254vBml7687zBRdTCd7oWfO9fWs7vC9Av
         WUU/EAmcLTZSHYHeRTZqppAXGOlBGujn49O9bR46cK1VFiNtcApt4iI0gzr5NflGsx5x
         Qkqf6nKaIvD8oN1lWB0G/tV1OHlI12SDO/MjbPV2ti/RxfSiAWYDhiLBgOQCYXG+VlNg
         NDn7tM+Z5jJ6fFWVsHINiDerJgqCAy8PXsQB+nLHD7Oz5fWRjwU/azQqgTvo/Camas+O
         Rv3A==
X-Gm-Message-State: AOJu0YxZZejh2GZkIAXvlCboDBvCuH47oP/9DZKhCv20acHebZ+v+BFA
	SC75yJf0ENT+1ZtqAE5+clRDKFYpnmOWqyE5CCOiLCFK9BrmLPG6Qw4gMq5Dkg==
X-Gm-Gg: ATEYQzyTycK0kntYSRJAdANEaa4yMV7bpRmRwr7mobv4s+ufckBSYBW1dPfJN6ObWJw
	YfsDFIEgGOZ+vvkiMtGsSX5loP6UBFTxX1zWqHo5gupbgayOnL2wFDnoA1LgJ89CYKhIX5l7EZA
	XEjWNsny9eU6lsdF2f3yzIyCm5PMQ5U1kw6rKdCQW7cn+/EmqFSYxvs4aAfoCWAMv3ZBoNnSMaS
	wiCGypomL4L2SkVKvTWiNBXZj5RjAW+1HWJuZVR1x4dG0jfGlLqK/rc4h12iqBVwclyRD1TMXL4
	ybqU5Uu/3zZAiSVvJf9XS7LxB25ect9x9hgIeTprsE7spoqgs3Owt9QnrvLpl2LZchHxpsQYX7M
	JT3t7ZoY2iuzlcwv1qHHKPg1LEhi3S3kI8s0uy2fadizkYw2wJOXWkYKE5779lKPYH8EFSCP7Jy
	PVcqMY0Ov/2XVthTwJnVmBn/pAnxEXAcNUzwdGLIoAeN4=
X-Received: by 2002:a05:6a00:9297:b0:829:6f39:fc39 with SMTP id d2e1a72fcca58-82d00236f27mr5908469b3a.12.1775218208775;
        Fri, 03 Apr 2026 05:10:08 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:1cd6:212e:a788:cbbb:a39d:2c2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41b8dsm5390775b3a.34.2026.04.03.05.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:10:08 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	a3205153416@gmail.com,
	bkkaracay@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v4 0/3] refs: reduce reliance on global state
Date: Fri,  3 Apr 2026 17:38:57 +0530
Message-ID: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the effort to reduce reliance on the_repository
global state by making repository context explicit across the refs
subsystem. The patches focus on passing struct repository through various
ref helpers and backends, and replacing uses of global state such as
the_repository and the_hash_algo with the appropriate repository instance.

Patch 1/3: Updating get_files_ref_lock_timeout_ms() to take a repository
and propagating it through files-backend, including callback paths.

Patch 2/3:Replacing uses of the_hash_algo in refs.c with the hash
algorithm from the appropriate repository.

Patch 3/3:Removing remaining uses of the_repository in reftable-backend.c
where a repository instance is already available.

Shreyansh Paliwal (3):
  refs: add struct repository parameter in
    get_files_ref_lock_timeout_ms()
  refs: remove the_hash_algo global state
  refs/reftable-backend: drop uses of the_repository

 refs.c                  | 17 +++++++++--------
 refs/files-backend.c    | 19 +++++++++++++------
 refs/refs-internal.h    |  2 +-
 refs/reftable-backend.c |  6 +++---
 4 files changed, 26 insertions(+), 18 deletions(-)

---
Changes in v4:
 - Dropped patches 1/5 and 5/5, as they require further refactoring and
   discussion. I will send them separately as a follow-up.

Changes in v3:
 - Fixed an import
 - better readability in patch 3/5

Changes in v2:
 - Made struct repository the first argument in function parameters.

Range-diff against v3:
2:  f7a9ea4204 = 1:  11c134b3f5 refs: add struct repository parameter in get_files_ref_lock_timeout_ms()
1:  5844440b73 ! 2:  d144e879ad refs: add struct repository parameter to branchname helpers
    @@ Metadata
     Author: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>

      ## Commit message ##
    -    refs: add struct repository parameter to branchname helpers
    +    refs: remove the_hash_algo global state

    -    copy_branchname() in refs.c relies on the_repository when calling
    -    repo_interpret_branch_name(), introducing an implicit dependency on global
    -    state. Add a struct repository parameter and use it instead.
    -
    -    Update check_branch_ref() to take a repository parameter as well, since it
    -    calls copy_branchname(). Propagate this change to higher-level helpers
    -    validate_branchname() and validate_new_branchname(), which also lack access
    -    to a repository instance. Most callers of these helpers reside in builtin
    -    code and already operate on the_repository, so pass it explicitly at those
    -    call sites (builtin/checkout and builtin/worktree) otherwise pass struct
    -    repository where available.
    -
    -    This makes branch name handling explicitly repository-aware and aligns with
    -    ongoing efforts to remove reliance on global state. This change builds on
    -    top of jw/object-name-bitset-to-enum (2026-03-18), which introduced the
    -    enum interpret_branch_kind parameter to copy_branchname().
    +    refs.c uses the_hash_algo in multiple places, relying on global state for
    +    the object hash algorithm. Replace these uses with the appropriate
    +    repository-specific hash_algo. In transaction-related functions
    +    (ref_transaction_create, ref_transaction_delete, migrate_one_ref, and
    +    transaction_hook_feed_stdin), use transaction->ref_store->repo->hash_algo.
    +    In other cases, such as repo_get_submodule_ref_store(), use
    +    repo->hash_algo.

         Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>

    - ## branch.c ##
    -@@ branch.c: int read_branch_desc(struct strbuf *buf, const char *branch_name)
    -  * Return 1 if the named branch already exists; return 0 otherwise.
    -  * Fill ref with the full refname for the branch.
    -  */
    --int validate_branchname(const char *name, struct strbuf *ref)
    -+int validate_branchname(struct repository *repo, const char *name, struct strbuf *ref)
    - {
    --	if (check_branch_ref(ref, name)) {
    -+	if (check_branch_ref(repo, ref, name)) {
    - 		int code = die_message(_("'%s' is not a valid branch name"), name);
    - 		advise_if_enabled(ADVICE_REF_SYNTAX,
    - 				  _("See 'git help check-ref-format'"));
    - 		exit(code);
    + ## refs.c ##
    +@@ refs.c: int ref_transaction_create(struct ref_transaction *transaction,
    + 		return 1;
      	}
    -
    --	return refs_ref_exists(get_main_ref_store(the_repository), ref->buf);
    -+	return refs_ref_exists(get_main_ref_store(repo), ref->buf);
    + 	return ref_transaction_update(transaction, refname, new_oid,
    +-				      null_oid(the_hash_algo), new_target, NULL, flags,
    ++				      null_oid(transaction->ref_store->repo->hash_algo), new_target, NULL, flags,
    + 				      msg, err);
      }

    - static int initialized_checked_out_branches;
    -@@ branch.c: const char *branch_checked_out(const char *refname)
    -  * Return 1 if the named branch already exists; return 0 otherwise.
    -  * Fill ref with the full refname for the branch.
    -  */
    --int validate_new_branchname(const char *name, struct strbuf *ref, int force)
    -+int validate_new_branchname(struct repository *repo, const char *name,
    -+			    struct strbuf *ref, int force)
    - {
    - 	const char *path;
    --	if (!validate_branchname(name, ref))
    -+	if (!validate_branchname(repo, name, ref))
    - 		return 0;
    -
    - 	if (!force)
    -@@ branch.c: void create_branch(struct repository *r,
    - 		BUG("'clobber_head_ok' can only be used with 'force'");
    -
    - 	if (clobber_head_ok ?
    --			  validate_branchname(name, &ref) :
    --			  validate_new_branchname(name, &ref, force)) {
    -+			  validate_branchname(r, name, &ref) :
    -+			  validate_new_branchname(r, name, &ref, force)) {
    - 		forcing = 1;
    +@@ refs.c: int ref_transaction_delete(struct ref_transaction *transaction,
    + 	if (old_target && !(flags & REF_NO_DEREF))
    + 		BUG("delete cannot operate on symrefs with deref mode");
    + 	return ref_transaction_update(transaction, refname,
    +-				      null_oid(the_hash_algo), old_oid,
    ++				      null_oid(transaction->ref_store->repo->hash_algo), old_oid,
    + 				      NULL, old_target, flags,
    + 				      msg, err);
    + }
    +@@ refs.c: struct ref_store *repo_get_submodule_ref_store(struct repository *repo,
    + 	subrepo = xmalloc(sizeof(*subrepo));
    +
    + 	if (repo_submodule_init(subrepo, repo, submodule,
    +-				null_oid(the_hash_algo))) {
    ++				null_oid(repo->hash_algo))) {
    + 		free(subrepo);
    + 		goto done;
      	}
    -
    -
    - ## branch.h ##
    -@@ branch.h: const char *branch_checked_out(const char *refname);
    -  * Return 1 if the named branch already exists; return 0 otherwise.
    -  * Fill ref with the full refname for the branch.
    -  */
    --int validate_branchname(const char *name, struct strbuf *ref);
    -+int validate_branchname(struct repository *repo, const char *name, struct strbuf *ref);
    -
    - /*
    -  * Check if a branch 'name' can be created as a new branch; die otherwise.
    -@@ branch.h: int validate_branchname(const char *name, struct strbuf *ref);
    -  * Return 1 if the named branch already exists; return 0 otherwise.
    -  * Fill ref with the full refname for the branch.
    -  */
    --int validate_new_branchname(const char *name, struct strbuf *ref, int force);
    -+int validate_new_branchname(struct repository *repo, const char *name,
    -+			    struct strbuf *ref, int force);
    -
    - /*
    -  * Remove information about the merge state on the current
    -
    - ## builtin/branch.c ##
    -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
    - 		char *target = NULL;
    - 		int flags = 0;
    -
    --		copy_branchname(&bname, argv[i], allowed_interpret);
    -+		copy_branchname(the_repository, &bname, argv[i], allowed_interpret);
    - 		free(name);
    - 		name = mkpathdup(fmt, bname.buf);
    -
    -@@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
    - 	int recovery = 0, oldref_usage = 0;
    - 	struct worktree **worktrees = get_worktrees();
    -
    --	if (check_branch_ref(&oldref, oldname)) {
    -+	if (check_branch_ref(the_repository, &oldref, oldname)) {
    - 		/*
    - 		 * Bad name --- this could be an attempt to rename a
    - 		 * ref that we used to allow to be created by accident.
    -@@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
    - 	 * cause the worktree to become inconsistent with HEAD, so allow it.
    - 	 */
    - 	if (!strcmp(oldname, newname))
    --		validate_branchname(newname, &newref);
    -+		validate_branchname(the_repository, newname, &newref);
    +@@ refs.c: static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
    + 	strbuf_reset(buf);
    +
    + 	if (!(update->flags & REF_HAVE_OLD))
    +-		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
    ++		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction->ref_store->repo->hash_algo)));
    + 	else if (update->old_target)
    + 		strbuf_addf(buf, "ref:%s ", update->old_target);
      	else
    --		validate_new_branchname(newname, &newref, force);
    -+		validate_new_branchname(the_repository, newname, &newref, force);
    -
    - 	reject_rebase_or_bisect_branch(worktrees, oldref.buf);
    + 		strbuf_addf(buf, "%s ", oid_to_hex(&update->old_oid));

    -@@ builtin/branch.c: int cmd_branch(int argc,
    - 				die(_("cannot give description to detached HEAD"));
    - 			branch_name = head;
    - 		} else if (argc == 1) {
    --			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
    -+			copy_branchname(the_repository, &buf, argv[0], INTERPRET_BRANCH_LOCAL);
    - 			branch_name = buf.buf;
    - 		} else {
    - 			die(_("cannot edit description of more than one branch"));
    -@@ builtin/branch.c: int cmd_branch(int argc,
    - 		if (!argc)
    - 			branch = branch_get(NULL);
    - 		else if (argc == 1) {
    --			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
    -+			copy_branchname(the_repository, &buf, argv[0], INTERPRET_BRANCH_LOCAL);
    - 			branch = branch_get(buf.buf);
    - 		} else
    - 			die(_("too many arguments to set new upstream"));
    -@@ builtin/branch.c: int cmd_branch(int argc,
    - 		if (!argc)
    - 			branch = branch_get(NULL);
    - 		else if (argc == 1) {
    --			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
    -+			copy_branchname(the_repository, &buf, argv[0], INTERPRET_BRANCH_LOCAL);
    - 			branch = branch_get(buf.buf);
    - 		} else
    - 			die(_("too many arguments to unset upstream"));
    -
    - ## builtin/check-ref-format.c ##
    -@@
    - /*
    -  * GIT - The information manager from hell
    -  */
    -+#define USE_THE_REPOSITORY_VARIABLE
    - #include "builtin.h"
    - #include "refs.h"
    - #include "setup.h"
    -@@ builtin/check-ref-format.c: static int check_ref_format_branch(const char *arg)
    - 	int nongit;
    -
    - 	setup_git_directory_gently(&nongit);
    --	if (check_branch_ref(&sb, arg) ||
    -+	if (check_branch_ref(the_repository, &sb, arg) ||
    - 	    !skip_prefix(sb.buf, "refs/heads/", &name))
    - 		die("'%s' is not a valid branch name", arg);
    - 	printf("%s\n", name);
    -
    - ## builtin/checkout.c ##
    -@@ builtin/checkout.c: static void setup_branch_path(struct branch_info *branch)
    - 			   &branch->oid, &branch->refname, 0))
    - 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
    -
    --	copy_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
    -+	copy_branchname(the_repository, &buf, branch->name, INTERPRET_BRANCH_LOCAL);
    - 	if (strcmp(buf.buf, branch->name)) {
    - 		free(branch->name);
    - 		branch->name = xstrdup(buf.buf);
    -@@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
    - 		struct strbuf buf = STRBUF_INIT;
    -
    - 		if (opts->new_branch_force)
    --			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
    -+			opts->branch_exists = validate_branchname(the_repository, opts->new_branch, &buf);
    - 		else
    - 			opts->branch_exists =
    --				validate_new_branchname(opts->new_branch, &buf, 0);
    -+				validate_new_branchname(the_repository, opts->new_branch, &buf, 0);
    - 		strbuf_release(&buf);
    - 	}
    -
    -
    - ## builtin/merge.c ##
    -@@ builtin/merge.c: static void merge_name(const char *remote, struct strbuf *msg)
    - 	char *found_ref = NULL;
    - 	int len, early;
    -
    --	copy_branchname(&bname, remote, 0);
    -+	copy_branchname(the_repository, &bname, remote, 0);
    - 	remote = bname.buf;
    -
    - 	oidclr(&branch_head, the_repository->hash_algo);
    -
    - ## builtin/worktree.c ##
    -@@ builtin/worktree.c: static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
    - 	struct strbuf symref = STRBUF_INIT;
    - 	struct child_process cp = CHILD_PROCESS_INIT;
    -
    --	validate_new_branchname(ref, &symref, 0);
    -+	validate_new_branchname(the_repository, ref, &symref, 0);
    - 	strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
    - 	if (opts->quiet)
    - 		strvec_push(&cp.args, "--quiet");
    -@@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
    - 	worktrees = NULL;
    -
    - 	/* is 'refname' a branch or commit? */
    --	if (!opts->detach && !check_branch_ref(&symref, refname) &&
    -+	if (!opts->detach && !check_branch_ref(the_repository, &symref, refname) &&
    - 	    refs_ref_exists(get_main_ref_store(the_repository), symref.buf)) {
    - 		is_branch = 1;
    - 		if (!opts->force)
    -@@ builtin/worktree.c: static void print_preparing_worktree_line(int detach,
    - 		fprintf_ln(stderr, _("Preparing worktree (new branch '%s')"), new_branch);
    - 	} else {
    - 		struct strbuf s = STRBUF_INIT;
    --		if (!detach && !check_branch_ref(&s, branch) &&
    -+		if (!detach && !check_branch_ref(the_repository, &s, branch) &&
    - 		    refs_ref_exists(get_main_ref_store(the_repository), s.buf))
    - 			fprintf_ln(stderr, _("Preparing worktree (checking out '%s')"),
    - 				  branch);
    -@@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch)
    - 	char *branchname = xstrndup(s, n);
    - 	struct strbuf ref = STRBUF_INIT;
    -
    --	branch_exists = !check_branch_ref(&ref, branchname) &&
    -+	branch_exists = !check_branch_ref(the_repository, &ref, branchname) &&
    - 			refs_ref_exists(get_main_ref_store(the_repository),
    - 					ref.buf);
    - 	strbuf_release(&ref);
    -@@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
    - 		new_branch = new_branch_force;
    -
    - 		if (!opts.force &&
    --		    !check_branch_ref(&symref, new_branch) &&
    -+		    !check_branch_ref(the_repository, &symref, new_branch) &&
    - 		    refs_ref_exists(get_main_ref_store(the_repository), symref.buf))
    - 			die_if_checked_out(symref.buf, 0);
    - 		strbuf_release(&symref);
    -
    - ## refs.c ##
    -@@ refs.c: static char *substitute_branch_name(struct repository *r,
    - 	return NULL;
    - }
    -
    --void copy_branchname(struct strbuf *sb, const char *name,
    -+void copy_branchname(struct repository *repo, struct strbuf *sb, const char *name,
    - 		     enum interpret_branch_kind allowed)
    - {
    - 	int len = strlen(name);
    - 	struct interpret_branch_name_options options = {
    - 		.allowed = allowed
    - 	};
    --	int used = repo_interpret_branch_name(the_repository, name, len, sb,
    -+	int used = repo_interpret_branch_name(repo, name, len, sb,
    - 					      &options);
    -
    - 	if (used < 0)
    -@@ refs.c: void copy_branchname(struct strbuf *sb, const char *name,
    - 	strbuf_add(sb, name + used, len - used);
    - }
    -
    --int check_branch_ref(struct strbuf *sb, const char *name)
    -+int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name)
    - {
    - 	if (startup_info->have_repository)
    --		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
    -+		copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
    + 	if (!(update->flags & REF_HAVE_NEW))
    +-		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
    ++		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction->ref_store->repo->hash_algo)));
    + 	else if (update->new_target)
    + 		strbuf_addf(buf, "ref:%s ", update->new_target);
      	else
    - 		strbuf_addstr(sb, name);
    -
    -
    - ## refs.h ##
    -@@ refs.h: char *repo_default_branch_name(struct repository *r, int quiet);
    -  * If "allowed" is non-zero, restrict the set of allowed expansions. See
    -  * repo_interpret_branch_name() for details.
    -  */
    --void copy_branchname(struct strbuf *sb, const char *name,
    -+void copy_branchname(struct repository *repo, struct strbuf *sb, const char *name,
    - 		     enum interpret_branch_kind allowed);
    -
    - /*
    -@@ refs.h: void copy_branchname(struct strbuf *sb, const char *name,
    -  *
    -  * The return value is "0" if the result is valid, and "-1" otherwise.
    -  */
    --int check_branch_ref(struct strbuf *sb, const char *name);
    -+int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name);
    -
    - /*
    -  * Similar for a tag name in refs/tags/.
    +@@ refs.c: struct migration_data {
    + static int migrate_one_ref(const struct reference *ref, void *cb_data)
    + {
    + 	struct migration_data *data = cb_data;
    ++	const struct git_hash_algo *hash_algo = data->transaction->ref_store->repo->hash_algo;
    + 	struct strbuf symref_target = STRBUF_INIT;
    + 	int ret;
    +
    +@@ refs.c: static int migrate_one_ref(const struct reference *ref, void *cb_data)
    + 		if (ret < 0)
    + 			goto done;
    +
    +-		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(the_hash_algo),
    ++		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(hash_algo),
    + 					     symref_target.buf, NULL,
    + 					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
    + 		if (ret < 0)
3:  00dba1a96a < -:  ---------- refs: remove the_hash_algo global state
4:  5653c418e1 = 3:  76c14eb320 refs/reftable-backend: drop uses of the_repository
5:  18c1c67083 < -:  ---------- refs/packed-backend: use ref_store->repo instead of the_repository
--
2.53.0

