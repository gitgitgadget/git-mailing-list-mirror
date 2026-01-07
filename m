Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFB328631
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804370; cv=none; b=mBvwX+gMfIYyET8rirGC9BSEEZp0sZcQqdw8WieXKN5WmdgoJd3379WbA8ASEulV3L7Lo1LyTqXTF6RMWp0+3IOmPy23iSoHY7WZHsf7KJ/9mRTTnabhHtz79xI9MoMIiCZmPZBXzqfEBva7ysFLD+xKe238LiUv9GuHvDqEj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804370; c=relaxed/simple;
	bh=8VaAD8ON6/njt71OD5bckVLZZMT9sUuGXFXubMvQacs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aT5hYiS+C+GOyIPPR+gaiLvIzdxREl9r5PrGy/hgTzEk8jBwtZAT3JTdREibgbzu3m1YekIq6viK0i/BlSsUfURRuRA7XjOnuJj/XQmky3+89kiWyLnohJPlVWmT08ABSiZkFgBQ0pcjmL0dnfFuE3sZLJSNn76msL5K71jKlwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2bcy/UP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2bcy/UP"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2ea2b9631so247561685a.3
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767804358; x=1768409158; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OERXVoXecbs0iA6SnncHdDQVbemBKQMF/U/9KA5Eot4=;
        b=U2bcy/UPLhrFvICGWddc45lUff7IJ+QBw59hBDnzAel0kGPA+aR/3gjnQl77PdgnHU
         uRFFnm3ej69cTLJoH4Nj4ep0rHi+Ulgud34lH24Fvy+G8fONLYLUij+gE4tiorP5/7qe
         LQl2N3kmwLOduQT7S58TpTiv3obv1zfQaGZ9C/lJM5dY7Ga6ZFk4GFJC6j6zHG3jKp6+
         E5DPnqpFUoAYVElILUxKgNrg7vNEzjtfik5IPEQ4gAG8shJHnyBXdT0gUuLjzeX74N69
         XRSwNpcVRnZeYL/GiNMtf3xI5/kXuP8t0vkdZD/OweOt0bDflGzJTESqPidi/8wtj80R
         CTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767804358; x=1768409158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OERXVoXecbs0iA6SnncHdDQVbemBKQMF/U/9KA5Eot4=;
        b=aSpn886VkoQPyKBEaZmvtpqrvn7jxMRPZayw/amTEcZFaxGI+hjM8a3Mh6a95Ptwfn
         aRpDk8VMf0EeR21ytr8Rr1c7WPOZn06YidlUt5M5XMoKVbn1D7beWDo94VpUXcF77w5F
         owalpqhVfxCSe8gwFTh4XaIlADIK3PczGDTbhdrTDdpOIvJPyjXRRrjkopH8G7134Yo4
         +NRMIU7U1HmZh+JEyDFggNAsCO9kU0JrF1W2QBvodiyZFZwigQJPLSgjUYnrYVAuOmX4
         ZXFLinJ+xHXw/tMzrxlXwN9/vysWEVPltoCUIYOlmD4rT1muifWdAx2MywBT/+V3yjwM
         /J3g==
X-Gm-Message-State: AOJu0Yw11au7FgbJyvqSKX0T4cK2MKYRTZHbDW/htACTdFMWQumD7Qr0
	15dGnxpcRh+uhINzdC2JXx/TjPzMok9OfyO77UyLW5UmiX16V6fMhLeNCIaHDw==
X-Gm-Gg: AY/fxX75G1EzdSwPpLxt0k5G7/2f83wHeXTuhNR9qA21f+Sg9JCTvoHkcXv0wZT7yc/
	XS+xx7vCKHT3VW3mhTI5e8aOdQRp8XRq3CIYb/rNjN87eezjBXeRf51LozznVEggb7JokCUP372
	EzPjDBrG+PqrclBjkMw0M7/Ka1REJpdPlMJCWC8u2cz6jpkF+cqOnEDGLwCgyNlDkaC7IxkWTNE
	v8nV9yjySLk7l22g3zLLGmnEZFjMC+AGGmE+50bLu5SNARK4TEN23KUTaIoE/wel43SoWekE4Dg
	3Ogs099AC1sY5F2zToErglc6TuD74UlT/7XcfFWWsbsuKFhP3XxL8tkdNu1mcuRFtPpG4kLvLU8
	fIfzUxgo5UJPjxk6ZH1rkX0LJRYTNjbu2PL1Z49PlJdgDSu0uinmOWhcC+lQ0wouwbybwoYbzWb
	EBXhgqPFesU7CwDyBE+eg3xkc=
X-Google-Smtp-Source: AGHT+IGiqHSPjyr+g478lHi3FC7kuHyi09VVdPPEMIDQH+A9pNud1zB15fQWVXIQZy2IexsHVgKERw==
X-Received: by 2002:a05:620a:28cd:b0:8b2:dd7b:cc89 with SMTP id af79cd13be357-8c389368b1fmr380876985a.11.1767804357358;
        Wed, 07 Jan 2026 08:45:57 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b917dsm423128085a.17.2026.01.07.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:45:56 -0800 (PST)
Message-Id: <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com>
In-Reply-To: <pull.2011.v3.git.1766579053136.gitgitgadget@gmail.com>
References: <pull.2011.v3.git.1766579053136.gitgitgadget@gmail.com>
From: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Jan 2026 16:45:55 +0000
Subject: [PATCH v4] lockfile: add PID file for debugging stale locks
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    "Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Paulo Casaretto <pcasaretto@gmail.com>,
    Paulo Casaretto <pcasaretto@gmail.com>

From: Paulo Casaretto <pcasaretto@gmail.com>

When a lock file is held, it can be helpful to know which process owns
it, especially when debugging stale locks left behind by crashed
processes. Add an optional feature that creates a companion PID file
alongside each lock file, containing the PID of the lock holder.

For a lock file "foo.lock", the PID file is named "foo~pid.lock". The
tilde character is forbidden in refnames and allowed in Windows
filenames, which guarantees no collision with the refs namespace
(e.g., refs "foo" and "foo~pid" cannot both exist). The file contains
a single line in the format "pid <value>" followed by a newline.

The PID file is created when a lock is acquired (if enabled), and
automatically cleaned up when the lock is released (via commit or
rollback). The file is registered as a tempfile so it gets cleaned up
by signal and atexit handlers if the process terminates abnormally.

When a lock conflict occurs, the code checks for an existing PID file
and, if found, uses kill(pid, 0) to determine if the process is still
running. This allows providing context-aware error messages:

  Lock is held by process 12345. Wait for it to finish, or remove
  the lock file to continue.

Or for a stale lock:

  Lock was held by process 12345, which is no longer running.
  Remove the stale lock file to continue.

The feature is controlled via core.lockfilePid configuration (boolean).
Defaults to false. When enabled, PID files are created for all lock
operations.

Existing PID files are always read when displaying lock errors,
regardless of the core.lockfilePid setting. This ensures helpful
diagnostics even when the feature was previously enabled and later
disabled.

Signed-off-by: Paulo Casaretto <pcasaretto@gmail.com>
---
    lockfile: add holder info file for debugging stale locks
    
    Changes in v4:
    
     * Simplified core.lockfilePid from per-component configuration to a
       simple boolean (true/false), as suggested by Jeff and Patrick. The
       per-subsystem granularity added complexity without a clear use case -
       if someone wants PID files for debugging, they likely want them
       everywhere.
     * Removed the enum lockfile_pid_component and all LOCKFILE_PID_*
       constants
     * Removed the component parameter from hold_lock_file_for_update*()
       functions, restoring their original signatures
     * Simplified config parsing to use git_config_bool() instead of the
       fsync-style component parser
     * Fixed error handling in create_lock_pid_file() to unlink the file on
       write failure, as noted by Junio
     * Clarified documentation to describe the file format directly ("pid "
       followed by a newline) rather than referencing "Git object headers"
     * Updated tests and documentation to reflect the boolean config

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2011%2Fpcasaretto%2Fpid-holder-file-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2011/pcasaretto/pid-holder-file-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2011

Range-diff vs v3:

 1:  29e5903b21 ! 1:  c26bc77e30 lockfile: add PID file for debugging stale locks
     @@ Commit message
          For a lock file "foo.lock", the PID file is named "foo~pid.lock". The
          tilde character is forbidden in refnames and allowed in Windows
          filenames, which guarantees no collision with the refs namespace
     -    (e.g., refs "foo" and "foo~pid" cannot both exist). The file uses a
     -    simple key-value format ("pid <value>") following the same pattern as
     -    Git object headers, making it extensible for future metadata.
     +    (e.g., refs "foo" and "foo~pid" cannot both exist). The file contains
     +    a single line in the format "pid <value>" followed by a newline.
      
          The PID file is created when a lock is acquired (if enabled), and
          automatically cleaned up when the lock is released (via commit or
     @@ Commit message
            Lock was held by process 12345, which is no longer running.
            Remove the stale lock file to continue.
      
     -    The feature is controlled via core.lockfilePid configuration, which
     -    accepts per-component values similar to core.fsync:
     -
     -      - none: Disable for all components (default)
     -      - all: Enable for all components
     -      - index, config, refs, commit-graph, midx, shallow, gc, other:
     -        Enable for specific components
     -
     -    Multiple components can be combined with commas:
     -
     -      git config core.lockfilePid index,config
     -
     -    Each lock file call site specifies which component it belongs to,
     -    allowing users fine-grained control over which locks create PID files.
     +    The feature is controlled via core.lockfilePid configuration (boolean).
     +    Defaults to false. When enabled, PID files are created for all lock
     +    operations.
      
          Existing PID files are always read when displaying lock errors,
          regardless of the core.lockfilePid setting. This ensures helpful
     @@ Documentation/config/core.adoc: confusion unless you know what you are doing (e.
       repository's usual working tree).
       
      +core.lockfilePid::
     -+	A comma-separated list of components for which Git should create
     -+	a PID file alongside the lock file. When a lock acquisition fails
     -+	and a PID file exists, Git can provide additional diagnostic
     -+	information about the process holding the lock, including whether
     -+	it is still running.
     -++
     -+This feature is disabled by default. You can enable it for specific
     -+components or use `all` to enable for all components.
     ++	If true, Git will create a PID file alongside lock files. When a
     ++	lock acquisition fails and a PID file exists, Git can provide
     ++	additional diagnostic information about the process holding the
     ++	lock, including whether it is still running. Defaults to `false`.
      ++
     -+* `none` disables PID file creation for all components.
     -+* `index` creates PID files for index lock operations.
     -+* `config` creates PID files for config file lock operations.
     -+* `refs` creates PID files for reference lock operations.
     -+* `commit-graph` creates PID files for commit-graph lock operations.
     -+* `midx` creates PID files for multi-pack-index lock operations.
     -+* `shallow` creates PID files for shallow file lock operations.
     -+* `gc` creates PID files for garbage collection lock operations.
     -+* `other` creates PID files for other miscellaneous lock operations.
     -+* `all` enables PID file creation for all components.
     -++
     -+The PID file is named by inserting `.pid` before the `.lock` suffix.
     ++The PID file is named by inserting `~pid` before the `.lock` suffix.
      +For example, if the lock file is `index.lock`, the PID file will be
     -+`index.pid.lock`. The file contains `pid <value>` on a single line,
     -+following the same key-value format used by Git object headers.
     ++`index~pid.lock`. The file contains a single line in the format
     ++`pid <value>` followed by a newline.
      +
       core.logAllRefUpdates::
       	Enable the reflog. Updates to a ref <ref> is logged to the file
       	"`$GIT_DIR/logs/<ref>`", by appending the new and old
      
     - ## apply.c ##
     -@@ apply.c: static int build_fake_ancestor(struct apply_state *state, struct patch *list)
     - 		}
     - 	}
     - 
     --	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR);
     -+	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR,
     -+				  LOCKFILE_PID_OTHER);
     - 	res = write_locked_index(&result, &lock, COMMIT_LOCK);
     - 	discard_index(&result);
     - 
     -@@ apply.c: static int apply_patch(struct apply_state *state,
     - 		if (state->index_file)
     - 			hold_lock_file_for_update(&state->lock_file,
     - 						  state->index_file,
     --						  LOCK_DIE_ON_ERROR);
     -+						  LOCK_DIE_ON_ERROR,
     -+						  LOCKFILE_PID_INDEX);
     - 		else
     - 			repo_hold_locked_index(state->repo, &state->lock_file,
     - 					       LOCK_DIE_ON_ERROR);
     -
       ## builtin/commit.c ##
      @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
     + 
       	path = repo_git_path(the_repository, "next-index-%"PRIuMAX,
       			     (uintmax_t) getpid());
     - 	hold_lock_file_for_update(&false_lock, path,
     +-	hold_lock_file_for_update(&false_lock, path,
      -				  LOCK_DIE_ON_ERROR);
     -+				  LOCK_DIE_ON_ERROR, LOCKFILE_PID_OTHER);
     ++	hold_lock_file_for_update(&false_lock, path, LOCK_DIE_ON_ERROR);
       
       	create_base_index(current_head);
       	add_remove_files(&partial);
      
     - ## builtin/credential-store.c ##
     -@@ builtin/credential-store.c: static void rewrite_credential_file(const char *fn, struct credential *c,
     - 	int timeout_ms = 1000;
     - 
     - 	repo_config_get_int(the_repository, "credentialstore.locktimeoutms", &timeout_ms);
     --	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
     -+	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms,
     -+					      LOCKFILE_PID_CONFIG) < 0)
     - 		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
     - 	if (extra)
     - 		print_line(extra);
     -
     - ## builtin/difftool.c ##
     -@@ builtin/difftool.c: static int run_dir_diff(struct repository *repo,
     - 			struct lock_file lock = LOCK_INIT;
     - 			strbuf_reset(&buf);
     - 			strbuf_addf(&buf, "%s/wtindex", tmpdir.buf);
     --			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
     -+			if (hold_lock_file_for_update(&lock, buf.buf, 0,
     -+					      LOCKFILE_PID_OTHER) < 0 ||
     - 			    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
     - 				ret = error("could not write %s", buf.buf);
     - 				goto finish;
     -
     - ## builtin/fast-import.c ##
     -@@ builtin/fast-import.c: static void dump_marks(void)
     - 		return;
     - 	}
     - 
     --	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) {
     -+	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0,
     -+				      LOCKFILE_PID_OTHER) < 0) {
     - 		failure |= error_errno(_("unable to write marks file %s"),
     - 				       export_marks_file);
     - 		return;
     -
       ## builtin/gc.c ##
      @@ builtin/gc.c: static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
     + 		xsnprintf(my_host, sizeof(my_host), "unknown");
       
       	pidfile_path = repo_git_path(the_repository, "gc.pid");
     - 	fd = hold_lock_file_for_update(&lock, pidfile_path,
     +-	fd = hold_lock_file_for_update(&lock, pidfile_path,
      -				       LOCK_DIE_ON_ERROR);
     -+				       LOCK_DIE_ON_ERROR, LOCKFILE_PID_GC);
     ++	fd = hold_lock_file_for_update(&lock, pidfile_path, LOCK_DIE_ON_ERROR);
       	if (!force) {
       		static char locking_host[HOST_NAME_MAX + 1];
       		static char *scan_fmt;
      @@ builtin/gc.c: int cmd_gc(int argc,
     + 
       	if (daemonized) {
       		char *path = repo_git_path(the_repository, "gc.log");
     - 		hold_lock_file_for_update(&log_lock, path,
     +-		hold_lock_file_for_update(&log_lock, path,
      -					  LOCK_DIE_ON_ERROR);
     -+					  LOCK_DIE_ON_ERROR, LOCKFILE_PID_GC);
     ++		hold_lock_file_for_update(&log_lock, path, LOCK_DIE_ON_ERROR);
       		dup2(get_lock_file_fd(&log_lock), 2);
       		atexit(process_log_file_at_exit);
       		free(path);
     -@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts,
     - 	struct repository *r = the_repository;
     - 	char *lock_path = xstrfmt("%s/maintenance", r->objects->sources->path);
     - 
     --	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
     -+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF,
     -+				      LOCKFILE_PID_GC) < 0) {
     - 		/*
     - 		 * Another maintenance command is running.
     - 		 *
     -@@ builtin/gc.c: static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
     - 		lock_file_timeout_ms = 150;
     - 
     - 	fd = hold_lock_file_for_update_timeout(&lk, filename, LOCK_DIE_ON_ERROR,
     --					       lock_file_timeout_ms);
     -+					       lock_file_timeout_ms,
     -+					       LOCKFILE_PID_GC);
     - 
     - 	/*
     - 	 * Does this file already exist? With the intended contents? Is it
     -@@ builtin/gc.c: static int update_background_schedule(const struct maintenance_start_opts *opts,
     - 	struct lock_file lk;
     - 	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->sources->path);
     - 
     --	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
     -+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF,
     -+				      LOCKFILE_PID_GC) < 0) {
     - 		if (errno == EEXIST)
     - 			error(_("unable to create '%s.lock': %s.\n\n"
     - 			    "Another scheduled git-maintenance(1) process seems to be running in this\n"
     -
     - ## builtin/sparse-checkout.c ##
     -@@ builtin/sparse-checkout.c: static int write_patterns_and_update(struct repository *repo,
     - 	if (safe_create_leading_directories(repo, sparse_filename))
     - 		die(_("failed to create directory for sparse-checkout file"));
     - 
     --	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
     -+	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR,
     -+				  LOCKFILE_PID_OTHER);
     - 
     - 	result = update_working_directory(repo, pl);
     - 	if (result) {
     -
     - ## bundle.c ##
     -@@ bundle.c: int create_bundle(struct repository *r, const char *path,
     - 		bundle_fd = 1;
     - 	else
     - 		bundle_fd = hold_lock_file_for_update(&lock, path,
     --						      LOCK_DIE_ON_ERROR);
     -+						      LOCK_DIE_ON_ERROR,
     -+						      LOCKFILE_PID_OTHER);
     - 
     - 	if (version == -1)
     - 		version = min_version;
     -
     - ## cache-tree.c ##
     -@@ cache-tree.c: int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
     - 	struct lock_file lock_file = LOCK_INIT;
     - 	int ret;
     - 
     --	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
     -+	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR,
     -+				  LOCKFILE_PID_INDEX);
     - 
     - 	entries = read_index_from(index_state, index_path,
     - 				  repo_get_git_dir(the_repository));
     -
     - ## commit-graph.c ##
     -@@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     - 		char *lock_name = get_commit_graph_chain_filename(ctx->odb_source);
     - 
     - 		hold_lock_file_for_update_mode(&lk, lock_name,
     --					       LOCK_DIE_ON_ERROR, 0444);
     -+					       LOCK_DIE_ON_ERROR, 0444,
     -+					       LOCKFILE_PID_COMMIT_GRAPH);
     - 		free(lock_name);
     - 
     - 		graph_layer = mks_tempfile_m(ctx->graph_name, 0444);
     -@@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     - 			   get_tempfile_fd(graph_layer), get_tempfile_path(graph_layer));
     - 	} else {
     - 		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
     --					       LOCK_DIE_ON_ERROR, 0444);
     -+					       LOCK_DIE_ON_ERROR, 0444,
     -+					       LOCKFILE_PID_COMMIT_GRAPH);
     - 		f = hashfd(ctx->r->hash_algo,
     - 			   get_lock_file_fd(&lk), get_lock_file_path(&lk));
     - 	}
      
       ## compat/mingw.c ##
      @@ compat/mingw.c: int mingw_kill(pid_t pid, int sig)
     @@ compat/mingw.c: int mingw_kill(pid_t pid, int sig)
       
       	errno = EINVAL;
      
     - ## config.c ##
     -@@ config.c: int repo_config_set_multivar_in_file_gently(struct repository *r,
     - 	 * The lock serves a purpose in addition to locking: the new
     - 	 * contents of .git/config will be written into it.
     - 	 */
     --	fd = hold_lock_file_for_update(&lock, config_filename, 0);
     -+	fd = hold_lock_file_for_update(&lock, config_filename, 0,
     -+				       LOCKFILE_PID_CONFIG);
     - 	if (fd < 0) {
     - 		error_errno(_("could not lock config file %s"), config_filename);
     - 		ret = CONFIG_NO_LOCK;
     -@@ config.c: static int repo_config_copy_or_rename_section_in_file(
     - 	if (!config_filename)
     - 		config_filename = filename_buf = repo_git_path(r, "config");
     - 
     --	out_fd = hold_lock_file_for_update(&lock, config_filename, 0);
     -+	out_fd = hold_lock_file_for_update(&lock, config_filename, 0,
     -+					   LOCKFILE_PID_CONFIG);
     - 	if (out_fd < 0) {
     - 		ret = error(_("could not lock config file %s"), config_filename);
     - 		goto out;
     -
       ## environment.c ##
      @@
       #include "gettext.h"
     @@ environment.c
       #include "mailmap.h"
       #include "object-name.h"
       #include "repository.h"
     -@@ environment.c: next_name:
     - 	return (current & ~negative) | positive;
     - }
     - 
     -+static const struct lockfile_pid_component_name {
     -+	const char *name;
     -+	enum lockfile_pid_component component_bits;
     -+} lockfile_pid_component_names[] = {
     -+	{ "index", LOCKFILE_PID_INDEX },
     -+	{ "config", LOCKFILE_PID_CONFIG },
     -+	{ "refs", LOCKFILE_PID_REFS },
     -+	{ "commit-graph", LOCKFILE_PID_COMMIT_GRAPH },
     -+	{ "midx", LOCKFILE_PID_MIDX },
     -+	{ "shallow", LOCKFILE_PID_SHALLOW },
     -+	{ "gc", LOCKFILE_PID_GC },
     -+	{ "other", LOCKFILE_PID_OTHER },
     -+	{ "all", LOCKFILE_PID_ALL },
     -+};
     -+
     -+static enum lockfile_pid_component parse_lockfile_pid_components(const char *var,
     -+								 const char *string)
     -+{
     -+	enum lockfile_pid_component current = LOCKFILE_PID_DEFAULT;
     -+	enum lockfile_pid_component positive = 0, negative = 0;
     -+
     -+	while (string) {
     -+		size_t len;
     -+		const char *ep;
     -+		int negated = 0;
     -+		int found = 0;
     -+
     -+		string = string + strspn(string, ", \t\n\r");
     -+		ep = strchrnul(string, ',');
     -+		len = ep - string;
     -+		if (len == 4 && !strncmp(string, "none", 4)) {
     -+			current = LOCKFILE_PID_NONE;
     -+			goto next_name;
     -+		}
     -+
     -+		if (*string == '-') {
     -+			negated = 1;
     -+			string++;
     -+			len--;
     -+			if (!len)
     -+				warning(_("invalid value for variable %s"), var);
     -+		}
     -+
     -+		if (!len)
     -+			break;
     -+
     -+		for (size_t i = 0; i < ARRAY_SIZE(lockfile_pid_component_names); ++i) {
     -+			const struct lockfile_pid_component_name *n = &lockfile_pid_component_names[i];
     -+
     -+			if (strncmp(n->name, string, len) || strlen(n->name) != len)
     -+				continue;
     -+
     -+			found = 1;
     -+			if (negated)
     -+				negative |= n->component_bits;
     -+			else
     -+				positive |= n->component_bits;
     -+		}
     -+
     -+		if (!found) {
     -+			char *component = xstrndup(string, len);
     -+			warning(_("ignoring unknown core.lockfilePid component '%s'"), component);
     -+			free(component);
     -+		}
     -+
     -+next_name:
     -+		string = ep;
     -+	}
     -+
     -+	return (current & ~negative) | positive;
     -+}
     -+
     - static int git_default_core_config(const char *var, const char *value,
     - 				   const struct config_context *ctx, void *cb)
     - {
      @@ environment.c: static int git_default_core_config(const char *var, const char *value,
       		return 0;
       	}
       
      +	if (!strcmp(var, "core.lockfilepid")) {
     -+		if (!value)
     -+			return config_error_nonbool(var);
     -+		lockfile_pid_components = parse_lockfile_pid_components(var, value);
     ++		lockfile_pid_enabled = git_config_bool(var, value);
      +		return 0;
      +	}
      +
     @@ lockfile.c: static void resolve_symlink(struct strbuf *path)
      + */
      +
      +/* Global config variable, initialized from core.lockfilePid */
     -+enum lockfile_pid_component lockfile_pid_components = LOCKFILE_PID_DEFAULT;
     ++int lockfile_pid_enabled;
      +
      +/*
      + * Path generation helpers.
     @@ lockfile.c: static void resolve_symlink(struct strbuf *path)
      +	strbuf_addstr(out, LOCK_SUFFIX);
      +}
      +
     -+static struct tempfile *create_lock_pid_file(const char *pid_path, int mode,
     -+					     enum lockfile_pid_component component)
     ++static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
      +{
      +	struct strbuf content = STRBUF_INIT;
      +	struct tempfile *pid_tempfile = NULL;
      +	int fd = -1;
      +
     -+	if (!(lockfile_pid_components & component))
     ++	if (!lockfile_pid_enabled)
      +		goto out;
      +
      +	fd = open(pid_path, O_WRONLY | O_CREAT | O_EXCL, mode);
     @@ lockfile.c: static void resolve_symlink(struct strbuf *path)
      +	strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
      +	if (write_in_full(fd, content.buf, content.len) < 0) {
      +		warning_errno(_("could not write lock pid file '%s'"), pid_path);
     ++		close(fd);
     ++		fd = -1;
     ++		unlink(pid_path);
      +		goto out;
      +	}
      +
     @@ lockfile.c: static void resolve_symlink(struct strbuf *path)
      +
       /* Make sure errno contains a meaningful value on error */
       static int lock_file(struct lock_file *lk, const char *path, int flags,
     --		     int mode)
     -+		     int mode, enum lockfile_pid_component component)
     + 		     int mode)
       {
      -	struct strbuf filename = STRBUF_INIT;
      +	struct strbuf base_path = STRBUF_INIT;
     @@ lockfile.c: static void resolve_symlink(struct strbuf *path)
      +
      +	lk->tempfile = create_tempfile_mode(lock_path.buf, mode);
      +	if (lk->tempfile)
     -+		lk->pid_tempfile = create_lock_pid_file(pid_path.buf, mode,
     -+							component);
     ++		lk->pid_tempfile = create_lock_pid_file(pid_path.buf, mode);
       
      -	strbuf_addstr(&filename, LOCK_SUFFIX);
      -	lk->tempfile = create_tempfile_mode(filename.buf, mode);
     @@ lockfile.c: static void resolve_symlink(struct strbuf *path)
       	return lk->tempfile ? lk->tempfile->fd : -1;
       }
       
     -@@ lockfile.c: static int lock_file(struct lock_file *lk, const char *path, int flags,
     -  * exactly once. If timeout_ms is -1, try indefinitely.
     -  */
     - static int lock_file_timeout(struct lock_file *lk, const char *path,
     --			     int flags, long timeout_ms, int mode)
     -+			     int flags, long timeout_ms, int mode,
     -+			     enum lockfile_pid_component component)
     - {
     - 	int n = 1;
     - 	int multiplier = 1;
     -@@ lockfile.c: static int lock_file_timeout(struct lock_file *lk, const char *path,
     - 	static int random_initialized = 0;
     - 
     - 	if (timeout_ms == 0)
     --		return lock_file(lk, path, flags, mode);
     -+		return lock_file(lk, path, flags, mode, component);
     - 
     - 	if (!random_initialized) {
     - 		srand((unsigned int)getpid());
     -@@ lockfile.c: static int lock_file_timeout(struct lock_file *lk, const char *path,
     - 		long backoff_ms, wait_ms;
     - 		int fd;
     - 
     --		fd = lock_file(lk, path, flags, mode);
     -+		fd = lock_file(lk, path, flags, mode, component);
     - 
     - 		if (fd >= 0)
     - 			return fd; /* success */
      @@ lockfile.c: static int lock_file_timeout(struct lock_file *lk, const char *path,
       void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
       {
     @@ lockfile.c: static int lock_file_timeout(struct lock_file *lk, const char *path,
      +
      +		/*
      +		 * Try to read PID file unconditionally - it may exist if
     -+		 * core.lockfilePid was enabled for this component.
     ++		 * core.lockfilePid was enabled.
      +		 */
      +		if (!read_lock_pid(pid_path.buf, &pid)) {
      +			if (kill((pid_t)pid, 0) == 0 || errno == EPERM)
     @@ lockfile.c: static int lock_file_timeout(struct lock_file *lk, const char *path,
       }
       
       NORETURN void unable_to_lock_die(const char *path, int err)
     -@@ lockfile.c: NORETURN void unable_to_lock_die(const char *path, int err)
     - /* This should return a meaningful errno on failure */
     - int hold_lock_file_for_update_timeout_mode(struct lock_file *lk,
     - 					   const char *path, int flags,
     --					   long timeout_ms, int mode)
     -+					   long timeout_ms, int mode,
     -+					   enum lockfile_pid_component component)
     - {
     --	int fd = lock_file_timeout(lk, path, flags, timeout_ms, mode);
     -+	int fd = lock_file_timeout(lk, path, flags, timeout_ms, mode, component);
     - 	if (fd < 0) {
     - 		if (flags & LOCK_DIE_ON_ERROR)
     - 			unable_to_lock_die(path, errno);
      @@ lockfile.c: int commit_lock_file(struct lock_file *lk)
       {
       	char *result_path = get_locked_file_path(lk);
     @@ lockfile.h: struct lock_file {
      +#define LOCK_PID_MAXLEN 32
      +
      +/*
     -+ * Per-component lock PID file configuration, following core.fsync pattern.
     -+ * Each component can be individually enabled via core.lockfilePid config.
     -+ */
     -+enum lockfile_pid_component {
     -+	LOCKFILE_PID_NONE = 0,
     -+	LOCKFILE_PID_INDEX = 1 << 0, /* .git/index.lock */
     -+	LOCKFILE_PID_CONFIG = 1 << 1, /* .git/config.lock */
     -+	LOCKFILE_PID_REFS = 1 << 2, /* refs locks */
     -+	LOCKFILE_PID_COMMIT_GRAPH = 1 << 3, /* commit-graph.lock */
     -+	LOCKFILE_PID_MIDX = 1 << 4, /* multi-pack-index.lock */
     -+	LOCKFILE_PID_SHALLOW = 1 << 5, /* shallow file */
     -+	LOCKFILE_PID_GC = 1 << 6, /* gc locks */
     -+	LOCKFILE_PID_OTHER = 1 << 7, /* other locks */
     -+};
     -+
     -+#define LOCKFILE_PID_ALL (LOCKFILE_PID_INDEX | LOCKFILE_PID_CONFIG |      \
     -+			  LOCKFILE_PID_REFS | LOCKFILE_PID_COMMIT_GRAPH | \
     -+			  LOCKFILE_PID_MIDX | LOCKFILE_PID_SHALLOW |      \
     -+			  LOCKFILE_PID_GC | LOCKFILE_PID_OTHER)
     -+#define LOCKFILE_PID_DEFAULT LOCKFILE_PID_NONE
     -+
     -+/*
     -+ * Bitmask indicating which components should create PID files.
     -+ * Configured via core.lockfilePid.
     ++ * Whether to create PID files alongside lock files.
     ++ * Configured via core.lockfilePid (boolean).
      + */
     -+extern enum lockfile_pid_component lockfile_pid_components;
     ++extern int lockfile_pid_enabled;
       
       /*
        * Flags
      @@ lockfile.h: struct lock_file {
     -  * timeout_ms milliseconds. If timeout_ms is 0, try exactly once; if
     -  * timeout_ms is -1, retry indefinitely. The flags argument, error
        * handling, and mode are described above.
     -+ *
     -+ * The `component` argument specifies which lock PID component this lock
     -+ * belongs to, for selective PID file creation via core.lockfilePid config.
        */
       int hold_lock_file_for_update_timeout_mode(
      -		struct lock_file *lk, const char *path,
      -		int flags, long timeout_ms, int mode);
      +	struct lock_file *lk, const char *path,
     -+	int flags, long timeout_ms, int mode,
     -+	enum lockfile_pid_component component);
     ++	int flags, long timeout_ms, int mode);
       
       static inline int hold_lock_file_for_update_timeout(
      -		struct lock_file *lk, const char *path,
      -		int flags, long timeout_ms)
      +	struct lock_file *lk, const char *path,
     -+	int flags, long timeout_ms,
     -+	enum lockfile_pid_component component)
     ++	int flags, long timeout_ms)
       {
       	return hold_lock_file_for_update_timeout_mode(lk, path, flags,
     --						      timeout_ms, 0666);
     -+						      timeout_ms, 0666,
     -+						      component);
     - }
     - 
     - /*
     + 						      timeout_ms, 0666);
      @@ lockfile.h: static inline int hold_lock_file_for_update_timeout(
        * argument and error handling are described above.
        */
       static inline int hold_lock_file_for_update(
      -		struct lock_file *lk, const char *path,
      -		int flags)
     -+	struct lock_file *lk, const char *path,
     -+	int flags, enum lockfile_pid_component component)
     ++	struct lock_file *lk, const char *path, int flags)
       {
     --	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
     -+	return hold_lock_file_for_update_timeout(lk, path, flags, 0, component);
     + 	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
       }
       
       static inline int hold_lock_file_for_update_mode(
      -		struct lock_file *lk, const char *path,
      -		int flags, int mode)
      +	struct lock_file *lk, const char *path,
     -+	int flags, int mode, enum lockfile_pid_component component)
     ++	int flags, int mode)
       {
     --	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode);
     -+	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode,
     -+						      component);
     + 	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode);
       }
     - 
     - /*
      @@ lockfile.h: static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
       
       /*
     @@ lockfile.h: static inline int commit_lock_file_to(struct lock_file *lk, const ch
       
       #endif /* LOCKFILE_H */
      
     - ## loose.c ##
     -@@ loose.c: int repo_write_loose_object_map(struct repository *repo)
     - 		return 0;
     - 
     - 	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
     --	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
     -+	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1,
     -+					       LOCKFILE_PID_OTHER);
     - 	iter = kh_begin(map);
     - 	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
     - 		goto errout;
     -@@ loose.c: static int write_one_object(struct odb_source *source,
     - 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
     - 
     - 	strbuf_addf(&path, "%s/loose-object-idx", source->path);
     --	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
     -+	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1,
     -+					  LOCKFILE_PID_OTHER);
     - 
     - 	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
     - 	if (fd < 0)
     -
     - ## midx-write.c ##
     -@@ midx-write.c: static int write_midx_internal(struct odb_source *source,
     - 		struct strbuf lock_name = STRBUF_INIT;
     - 
     - 		get_midx_chain_filename(source, &lock_name);
     --		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
     -+		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR,
     -+					  LOCKFILE_PID_MIDX);
     - 		strbuf_release(&lock_name);
     - 
     - 		incr = mks_tempfile_m(midx_name.buf, 0444);
     -@@ midx-write.c: static int write_midx_internal(struct odb_source *source,
     - 		f = hashfd(r->hash_algo, get_tempfile_fd(incr),
     - 			   get_tempfile_path(incr));
     - 	} else {
     --		hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR);
     -+		hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR,
     -+					  LOCKFILE_PID_MIDX);
     - 		f = hashfd(r->hash_algo, get_lock_file_fd(&lk),
     - 			   get_lock_file_path(&lk));
     - 	}
     -
     - ## odb.c ##
     -@@ odb.c: static int odb_source_write_alternate(struct odb_source *source,
     - 	int found = 0;
     - 	int ret;
     - 
     --	hold_lock_file_for_update(&lock, path, LOCK_DIE_ON_ERROR);
     -+	hold_lock_file_for_update(&lock, path, LOCK_DIE_ON_ERROR,
     -+				  LOCKFILE_PID_OTHER);
     - 	out = fdopen_lock_file(&lock, "w");
     - 	if (!out) {
     - 		ret = error_errno(_("unable to fdopen alternates lockfile"));
     -
     - ## refs/files-backend.c ##
     -@@ refs/files-backend.c: retry:
     - 
     - 	if (hold_lock_file_for_update_timeout(
     - 			    &lock->lk, ref_file.buf, LOCK_NO_DEREF,
     --			    get_files_ref_lock_timeout_ms()) < 0) {
     -+			    get_files_ref_lock_timeout_ms(),
     -+			    LOCKFILE_PID_REFS) < 0) {
     - 		int myerr = errno;
     - 		errno = 0;
     - 		if (myerr == ENOENT && --attempts_remaining > 0) {
     -@@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
     - 
     - 	return hold_lock_file_for_update_timeout(
     - 			lk, path, LOCK_NO_DEREF,
     --			get_files_ref_lock_timeout_ms()) < 0 ? -1 : 0;
     -+			get_files_ref_lock_timeout_ms(),
     -+			LOCKFILE_PID_REFS) < 0 ? -1 : 0;
     - }
     - 
     - /*
     -@@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
     - 		 * work we need, including cleaning up if the program
     - 		 * exits unexpectedly.
     - 		 */
     --		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
     -+		if (hold_lock_file_for_update(&reflog_lock, log_file, 0,
     -+					      LOCKFILE_PID_REFS) < 0) {
     - 			struct strbuf err = STRBUF_INIT;
     - 			unable_to_lock_message(log_file, errno, &err);
     - 			error("%s", err.buf);
     -
     - ## refs/packed-backend.c ##
     -@@ refs/packed-backend.c: int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
     - 	if (hold_lock_file_for_update_timeout(
     - 			    &refs->lock,
     - 			    refs->path,
     --			    flags, timeout_value) < 0) {
     -+			    flags, timeout_value,
     -+			    LOCKFILE_PID_REFS) < 0) {
     - 		unable_to_lock_message(refs->path, errno, err);
     - 		return -1;
     - 	}
     -
     - ## reftable/system.c ##
     -@@ reftable/system.c: int flock_acquire(struct reftable_flock *l, const char *target_path,
     - 		return REFTABLE_OUT_OF_MEMORY_ERROR;
     - 
     - 	err = hold_lock_file_for_update_timeout(lockfile, target_path, LOCK_NO_DEREF,
     --						timeout_ms);
     -+						timeout_ms, LOCKFILE_PID_REFS);
     - 	if (err < 0) {
     - 		reftable_free(lockfile);
     - 		if (errno == EEXIST)
     -
     - ## repository.c ##
     -@@ repository.c: int repo_hold_locked_index(struct repository *repo,
     - {
     - 	if (!repo->index_file)
     - 		BUG("the repo hasn't been setup");
     --	return hold_lock_file_for_update(lf, repo->index_file, flags);
     -+	return hold_lock_file_for_update(lf, repo->index_file, flags,
     -+					 LOCKFILE_PID_INDEX);
     - }
     -
     - ## rerere.c ##
     -@@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
     - 	else
     - 		fd = hold_lock_file_for_update(&write_lock,
     - 					       git_path_merge_rr(r),
     --					       LOCK_DIE_ON_ERROR);
     -+					       LOCK_DIE_ON_ERROR,
     -+					       LOCKFILE_PID_OTHER);
     - 	read_rr(r, merge_rr);
     - 	return fd;
     - }
     -
     - ## sequencer.c ##
     -@@ sequencer.c: static int write_message(const void *buf, size_t len, const char *filename,
     - {
     - 	struct lock_file msg_file = LOCK_INIT;
     - 
     --	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
     -+	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0,
     -+					       LOCKFILE_PID_OTHER);
     - 	if (msg_fd < 0)
     - 		return error_errno(_("could not lock '%s'"), filename);
     - 	if (write_in_full(msg_fd, buf, len) < 0) {
     -@@ sequencer.c: static int save_todo(struct todo_list *todo_list, struct replay_opts *opts,
     - 	if (is_rebase_i(opts) && !reschedule)
     - 		next++;
     - 
     --	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
     -+	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0,
     -+				       LOCKFILE_PID_OTHER);
     - 	if (fd < 0)
     - 		return error_errno(_("could not lock '%s'"), todo_path);
     - 	offset = get_item_line_offset(todo_list, next);
     -@@ sequencer.c: static int safe_append(const char *filename, const char *fmt, ...)
     - 	va_list ap;
     - 	struct lock_file lock = LOCK_INIT;
     - 	int fd = hold_lock_file_for_update(&lock, filename,
     --					   LOCK_REPORT_ON_ERROR);
     -+					   LOCK_REPORT_ON_ERROR,
     -+					   LOCKFILE_PID_OTHER);
     - 	struct strbuf buf = STRBUF_INIT;
     - 
     - 	if (fd < 0)
     -@@ sequencer.c: static int write_update_refs_state(struct string_list *refs_to_oids)
     - 		goto cleanup;
     - 	}
     - 
     --	if (hold_lock_file_for_update(&lock, path, 0) < 0) {
     -+	if (hold_lock_file_for_update(&lock, path, 0, LOCKFILE_PID_OTHER) < 0) {
     - 		result = error(_("another 'rebase' process appears to be running; "
     - 				 "'%s.lock' already exists"),
     - 			       path);
     -
     - ## shallow.c ##
     -@@ shallow.c: void setup_alternate_shallow(struct shallow_lock *shallow_lock,
     - 
     - 	fd = hold_lock_file_for_update(&shallow_lock->lock,
     - 				       git_path_shallow(the_repository),
     --				       LOCK_DIE_ON_ERROR);
     -+				       LOCK_DIE_ON_ERROR,
     -+				       LOCKFILE_PID_SHALLOW);
     - 	check_shallow_file_for_update(the_repository);
     - 	if (write_shallow_commits(&sb, 0, extra)) {
     - 		if (write_in_full(fd, sb.buf, sb.len) < 0)
     -@@ shallow.c: void prune_shallow(unsigned options)
     - 	}
     - 	fd = hold_lock_file_for_update(&shallow_lock.lock,
     - 				       git_path_shallow(the_repository),
     --				       LOCK_DIE_ON_ERROR);
     -+				       LOCK_DIE_ON_ERROR,
     -+				       LOCKFILE_PID_SHALLOW);
     - 	check_shallow_file_for_update(the_repository);
     - 	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
     - 		if (write_in_full(fd, sb.buf, sb.len) < 0)
     -
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
         't0028-working-tree-encoding.sh',
     @@ t/t0031-lockfile-pid.sh (new)
      +test_description='lock file PID info tests
      +
      +Tests for PID info file alongside lock files.
     -+The feature is opt-in via core.lockfilePid config setting.
     ++The feature is opt-in via core.lockfilePid config setting (boolean).
      +'
      +
      +. ./test-lib.sh
     @@ t/t0031-lockfile-pid.sh (new)
      +		cd repo &&
      +		touch .git/index.lock &&
      +		printf "pid 99999" >.git/index~pid.lock &&
     -+		test_must_fail git -c core.lockfilePid=index add . 2>err &&
     ++		test_must_fail git -c core.lockfilePid=true add . 2>err &&
      +		test_grep "process 99999, which is no longer running" err &&
      +		test_grep "Remove the stale lock file" err
      +	)
     @@ t/t0031-lockfile-pid.sh (new)
      +		touch .git/index.lock &&
      +		printf "pid %d" "$shell_pid" >.git/index~pid.lock &&
      +		# Verify our PID is shown in the error message
     -+		test_must_fail git -c core.lockfilePid=index add file 2>err &&
     ++		test_must_fail git -c core.lockfilePid=true add file 2>err &&
      +		test_grep "held by process $shell_pid" err
      +	)
      +'
     @@ t/t0031-lockfile-pid.sh (new)
      +	(
      +		cd repo4 &&
      +		echo content >file &&
     -+		git -c core.lockfilePid=index add file &&
     ++		git -c core.lockfilePid=true add file &&
      +		# After successful add, no lock or PID files should exist
      +		test_path_is_missing .git/index.lock &&
      +		test_path_is_missing .git/index~pid.lock
     @@ t/t0031-lockfile-pid.sh (new)
      +	)
      +'
      +
     -+test_expect_success 'core.lockfilePid=all enables for all components' '
     ++test_expect_success 'core.lockfilePid=false does not create PID file' '
      +	git init repo6 &&
      +	(
      +		cd repo6 &&
     -+		touch .git/index.lock &&
     -+		printf "pid 99999" >.git/index~pid.lock &&
     -+		test_must_fail git -c core.lockfilePid=all add . 2>err &&
     -+		test_grep "process 99999" err
     -+	)
     -+'
     -+
     -+test_expect_success 'multiple components can be specified' '
     -+	git init repo8 &&
     -+	(
     -+		cd repo8 &&
     -+		touch .git/index.lock &&
     -+		printf "pid 99999" >.git/index~pid.lock &&
     -+		test_must_fail git -c core.lockfilePid=index,config add . 2>err &&
     -+		test_grep "process 99999" err
     -+	)
     -+'
     -+
     -+test_expect_success 'core.lockfilePid=none does not create PID file' '
     -+	git init repo9 &&
     -+	(
     -+		cd repo9 &&
      +		echo content >file &&
     -+		git -c core.lockfilePid=none add file &&
     ++		git -c core.lockfilePid=false add file &&
      +		# PID file should not be created when feature is disabled
      +		test_path_is_missing .git/index~pid.lock
      +	)
      +'
      +
      +test_expect_success 'existing PID files are read even when feature disabled' '
     -+	git init repo10 &&
     ++	git init repo7 &&
      +	(
     -+		cd repo10 &&
     ++		cd repo7 &&
      +		touch .git/index.lock &&
      +		printf "pid 99999" >.git/index~pid.lock &&
      +		# Even with lockfilePid disabled, existing PID files are read
     @@ t/t0031-lockfile-pid.sh (new)
      +	)
      +'
      +
     -+test_expect_success 'negative component syntax excludes specific components' '
     -+	git init repo11 &&
     -+	(
     -+		cd repo11 &&
     -+		echo content >file &&
     -+		# Enable all components except index
     -+		git -c core.lockfilePid=all,-index add file &&
     -+		# PID file should not be created for index when excluded
     -+		test_path_is_missing .git/index~pid.lock
     -+	)
     -+'
     -+
      +test_done
     -
     - ## unix-stream-server.c ##
     -@@ unix-stream-server.c: int unix_ss_create(const char *path,
     - 	/*
     - 	 * Create a lock at "<path>.lock" if we can.
     - 	 */
     --	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout_ms) < 0)
     -+	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout_ms,
     -+					      LOCKFILE_PID_OTHER) < 0)
     - 		return -1;
     - 
     - 	/*


 Documentation/config/core.adoc |  11 +++
 builtin/commit.c               |   3 +-
 builtin/gc.c                   |   6 +-
 compat/mingw.c                 |  10 ++
 environment.c                  |   6 ++
 lockfile.c                     | 170 ++++++++++++++++++++++++++++++---
 lockfile.h                     |  43 ++++++---
 t/meson.build                  |   1 +
 t/t0031-lockfile-pid.sh        | 105 ++++++++++++++++++++
 9 files changed, 320 insertions(+), 35 deletions(-)
 create mode 100755 t/t0031-lockfile-pid.sh

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 01202da7cd..5c4bc9206f 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -348,6 +348,17 @@ confusion unless you know what you are doing (e.g. you are creating a
 read-only snapshot of the same index to a location different from the
 repository's usual working tree).
 
+core.lockfilePid::
+	If true, Git will create a PID file alongside lock files. When a
+	lock acquisition fails and a PID file exists, Git can provide
+	additional diagnostic information about the process holding the
+	lock, including whether it is still running. Defaults to `false`.
++
+The PID file is named by inserting `~pid` before the `.lock` suffix.
+For example, if the lock file is `index.lock`, the PID file will be
+`index~pid.lock`. The file contains a single line in the format
+`pid <value>` followed by a newline.
+
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
 	"`$GIT_DIR/logs/<ref>`", by appending the new and old
diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..4378256fa5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -539,8 +539,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 
 	path = repo_git_path(the_repository, "next-index-%"PRIuMAX,
 			     (uintmax_t) getpid());
-	hold_lock_file_for_update(&false_lock, path,
-				  LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&false_lock, path, LOCK_DIE_ON_ERROR);
 
 	create_base_index(current_head);
 	add_remove_files(&partial);
diff --git a/builtin/gc.c b/builtin/gc.c
index 92c6e7b954..1dcc8dd550 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -748,8 +748,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 		xsnprintf(my_host, sizeof(my_host), "unknown");
 
 	pidfile_path = repo_git_path(the_repository, "gc.pid");
-	fd = hold_lock_file_for_update(&lock, pidfile_path,
-				       LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&lock, pidfile_path, LOCK_DIE_ON_ERROR);
 	if (!force) {
 		static char locking_host[HOST_NAME_MAX + 1];
 		static char *scan_fmt;
@@ -1016,8 +1015,7 @@ int cmd_gc(int argc,
 
 	if (daemonized) {
 		char *path = repo_git_path(the_repository, "gc.log");
-		hold_lock_file_for_update(&log_lock, path,
-					  LOCK_DIE_ON_ERROR);
+		hold_lock_file_for_update(&log_lock, path, LOCK_DIE_ON_ERROR);
 		dup2(get_lock_file_fd(&log_lock), 2);
 		atexit(process_log_file_at_exit);
 		free(path);
diff --git a/compat/mingw.c b/compat/mingw.c
index 939f938fe2..146b2585ce 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1972,6 +1972,16 @@ int mingw_kill(pid_t pid, int sig)
 			CloseHandle(h);
 			return 0;
 		}
+		/*
+		 * OpenProcess returns ERROR_INVALID_PARAMETER for
+		 * non-existent PIDs. Map this to ESRCH for POSIX
+		 * compatibility with kill(pid, 0).
+		 */
+		if (GetLastError() == ERROR_INVALID_PARAMETER)
+			errno = ESRCH;
+		else
+			errno = err_win_to_posix(GetLastError());
+		return -1;
 	}
 
 	errno = EINVAL;
diff --git a/environment.c b/environment.c
index a770b5921d..4adcce8606 100644
--- a/environment.c
+++ b/environment.c
@@ -21,6 +21,7 @@
 #include "gettext.h"
 #include "git-zlib.h"
 #include "ident.h"
+#include "lockfile.h"
 #include "mailmap.h"
 #include "object-name.h"
 #include "repository.h"
@@ -532,6 +533,11 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "core.lockfilepid")) {
+		lockfile_pid_enabled = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.createobject")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/lockfile.c b/lockfile.c
index 1d5ed01682..ac7eb86541 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -6,6 +6,9 @@
 #include "abspath.h"
 #include "gettext.h"
 #include "lockfile.h"
+#include "parse.h"
+#include "strbuf.h"
+#include "wrapper.h"
 
 /*
  * path = absolute or relative path name
@@ -71,19 +74,119 @@ static void resolve_symlink(struct strbuf *path)
 	strbuf_reset(&link);
 }
 
+/*
+ * Lock PID file functions - write PID to a foo~pid.lock file alongside
+ * the lock file for debugging stale locks. The PID file is registered
+ * as a tempfile so it gets cleaned up by signal/atexit handlers.
+ *
+ * Naming: For "foo.lock", the PID file is "foo~pid.lock". The tilde is
+ * forbidden in refnames and allowed in Windows filenames, guaranteeing
+ * no collision with the refs namespace.
+ */
+
+/* Global config variable, initialized from core.lockfilePid */
+int lockfile_pid_enabled;
+
+/*
+ * Path generation helpers.
+ * Given base path "foo", generate:
+ *   - lock path: "foo.lock"
+ *   - pid path:  "foo-pid.lock"
+ */
+static void get_lock_path(struct strbuf *out, const char *path)
+{
+	strbuf_addstr(out, path);
+	strbuf_addstr(out, LOCK_SUFFIX);
+}
+
+static void get_pid_path(struct strbuf *out, const char *path)
+{
+	strbuf_addstr(out, path);
+	strbuf_addstr(out, LOCK_PID_INFIX);
+	strbuf_addstr(out, LOCK_SUFFIX);
+}
+
+static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
+{
+	struct strbuf content = STRBUF_INIT;
+	struct tempfile *pid_tempfile = NULL;
+	int fd = -1;
+
+	if (!lockfile_pid_enabled)
+		goto out;
+
+	fd = open(pid_path, O_WRONLY | O_CREAT | O_EXCL, mode);
+	if (fd < 0)
+		goto out;
+
+	strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
+	if (write_in_full(fd, content.buf, content.len) < 0) {
+		warning_errno(_("could not write lock pid file '%s'"), pid_path);
+		close(fd);
+		fd = -1;
+		unlink(pid_path);
+		goto out;
+	}
+
+	close(fd);
+	fd = -1;
+	pid_tempfile = register_tempfile(pid_path);
+
+out:
+	if (fd >= 0)
+		close(fd);
+	strbuf_release(&content);
+	return pid_tempfile;
+}
+
+static int read_lock_pid(const char *pid_path, uintmax_t *pid_out)
+{
+	struct strbuf content = STRBUF_INIT;
+	const char *val;
+	int ret = -1;
+
+	if (strbuf_read_file(&content, pid_path, LOCK_PID_MAXLEN) <= 0)
+		goto out;
+
+	strbuf_rtrim(&content);
+
+	if (skip_prefix(content.buf, "pid ", &val)) {
+		char *endptr;
+		*pid_out = strtoumax(val, &endptr, 10);
+		if (*pid_out > 0 && !*endptr)
+			ret = 0;
+	}
+
+	if (ret)
+		warning(_("malformed lock pid file '%s'"), pid_path);
+
+out:
+	strbuf_release(&content);
+	return ret;
+}
+
 /* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags,
 		     int mode)
 {
-	struct strbuf filename = STRBUF_INIT;
+	struct strbuf base_path = STRBUF_INIT;
+	struct strbuf lock_path = STRBUF_INIT;
+	struct strbuf pid_path = STRBUF_INIT;
 
-	strbuf_addstr(&filename, path);
+	strbuf_addstr(&base_path, path);
 	if (!(flags & LOCK_NO_DEREF))
-		resolve_symlink(&filename);
+		resolve_symlink(&base_path);
+
+	get_lock_path(&lock_path, base_path.buf);
+	get_pid_path(&pid_path, base_path.buf);
+
+	lk->tempfile = create_tempfile_mode(lock_path.buf, mode);
+	if (lk->tempfile)
+		lk->pid_tempfile = create_lock_pid_file(pid_path.buf, mode);
 
-	strbuf_addstr(&filename, LOCK_SUFFIX);
-	lk->tempfile = create_tempfile_mode(filename.buf, mode);
-	strbuf_release(&filename);
+	strbuf_release(&base_path);
+	strbuf_release(&lock_path);
+	strbuf_release(&pid_path);
 	return lk->tempfile ? lk->tempfile->fd : -1;
 }
 
@@ -151,16 +254,47 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 {
 	if (err == EEXIST) {
-		strbuf_addf(buf, _("Unable to create '%s.lock': %s.\n\n"
-		    "Another git process seems to be running in this repository, e.g.\n"
-		    "an editor opened by 'git commit'. Please make sure all processes\n"
-		    "are terminated then try again. If it still fails, a git process\n"
-		    "may have crashed in this repository earlier:\n"
-		    "remove the file manually to continue."),
-			    absolute_path(path), strerror(err));
-	} else
+		const char *abs_path = absolute_path(path);
+		struct strbuf lock_path = STRBUF_INIT;
+		struct strbuf pid_path = STRBUF_INIT;
+		uintmax_t pid;
+		int pid_status = 0; /* 0 = unknown, 1 = running, -1 = stale */
+
+		get_lock_path(&lock_path, abs_path);
+		get_pid_path(&pid_path, abs_path);
+
+		strbuf_addf(buf, _("Unable to create '%s': %s.\n\n"),
+			    lock_path.buf, strerror(err));
+
+		/*
+		 * Try to read PID file unconditionally - it may exist if
+		 * core.lockfilePid was enabled.
+		 */
+		if (!read_lock_pid(pid_path.buf, &pid)) {
+			if (kill((pid_t)pid, 0) == 0 || errno == EPERM)
+				pid_status = 1;  /* running (or no permission to signal) */
+			else if (errno == ESRCH)
+				pid_status = -1; /* no such process - stale lock */
+		}
+
+		if (pid_status == 1)
+			strbuf_addf(buf, _("Lock is held by process %" PRIuMAX ". "
+					   "Wait for it to finish, or remove the lock file to continue"),
+				    pid);
+		else if (pid_status == -1)
+			strbuf_addf(buf, _("Lock was held by process %" PRIuMAX ", "
+					   "which is no longer running. Remove the stale lock file to continue"),
+				    pid);
+		else
+			strbuf_addstr(buf, _("Another git process seems to be running in this repository. "
+					     "Wait for it to finish, or remove the lock file to continue"));
+
+		strbuf_release(&lock_path);
+		strbuf_release(&pid_path);
+	} else {
 		strbuf_addf(buf, _("Unable to create '%s.lock': %s"),
 			    absolute_path(path), strerror(err));
+	}
 }
 
 NORETURN void unable_to_lock_die(const char *path, int err)
@@ -207,6 +341,8 @@ int commit_lock_file(struct lock_file *lk)
 {
 	char *result_path = get_locked_file_path(lk);
 
+	delete_tempfile(&lk->pid_tempfile);
+
 	if (commit_lock_file_to(lk, result_path)) {
 		int save_errno = errno;
 		free(result_path);
@@ -216,3 +352,9 @@ int commit_lock_file(struct lock_file *lk)
 	free(result_path);
 	return 0;
 }
+
+int rollback_lock_file(struct lock_file *lk)
+{
+	delete_tempfile(&lk->pid_tempfile);
+	return delete_tempfile(&lk->tempfile);
+}
diff --git a/lockfile.h b/lockfile.h
index 1bb9926497..e7233f28de 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -119,6 +119,7 @@
 
 struct lock_file {
 	struct tempfile *tempfile;
+	struct tempfile *pid_tempfile;
 };
 
 #define LOCK_INIT { 0 }
@@ -127,6 +128,22 @@ struct lock_file {
 #define LOCK_SUFFIX ".lock"
 #define LOCK_SUFFIX_LEN 5
 
+/*
+ * PID file naming: for a lock file "foo.lock", the PID file is "foo~pid.lock".
+ * The tilde is forbidden in refnames and allowed in Windows filenames, avoiding
+ * namespace collisions (e.g., refs "foo" and "foo~pid" cannot both exist).
+ */
+#define LOCK_PID_INFIX "~pid"
+#define LOCK_PID_INFIX_LEN 4
+
+/* Maximum length for PID file content */
+#define LOCK_PID_MAXLEN 32
+
+/*
+ * Whether to create PID files alongside lock files.
+ * Configured via core.lockfilePid (boolean).
+ */
+extern int lockfile_pid_enabled;
 
 /*
  * Flags
@@ -169,12 +186,12 @@ struct lock_file {
  * handling, and mode are described above.
  */
 int hold_lock_file_for_update_timeout_mode(
-		struct lock_file *lk, const char *path,
-		int flags, long timeout_ms, int mode);
+	struct lock_file *lk, const char *path,
+	int flags, long timeout_ms, int mode);
 
 static inline int hold_lock_file_for_update_timeout(
-		struct lock_file *lk, const char *path,
-		int flags, long timeout_ms)
+	struct lock_file *lk, const char *path,
+	int flags, long timeout_ms)
 {
 	return hold_lock_file_for_update_timeout_mode(lk, path, flags,
 						      timeout_ms, 0666);
@@ -186,15 +203,14 @@ static inline int hold_lock_file_for_update_timeout(
  * argument and error handling are described above.
  */
 static inline int hold_lock_file_for_update(
-		struct lock_file *lk, const char *path,
-		int flags)
+	struct lock_file *lk, const char *path, int flags)
 {
 	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
 }
 
 static inline int hold_lock_file_for_update_mode(
-		struct lock_file *lk, const char *path,
-		int flags, int mode)
+	struct lock_file *lk, const char *path,
+	int flags, int mode)
 {
 	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode);
 }
@@ -319,13 +335,10 @@ static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
 
 /*
  * Roll back `lk`: close the file descriptor and/or file pointer and
- * remove the lockfile. It is a NOOP to call `rollback_lock_file()`
- * for a `lock_file` object that has already been committed or rolled
- * back. No error will be returned in this case.
+ * remove the lockfile and any associated PID file. It is a NOOP to
+ * call `rollback_lock_file()` for a `lock_file` object that has already
+ * been committed or rolled back. No error will be returned in this case.
  */
-static inline int rollback_lock_file(struct lock_file *lk)
-{
-	return delete_tempfile(&lk->tempfile);
-}
+int rollback_lock_file(struct lock_file *lk);
 
 #endif /* LOCKFILE_H */
diff --git a/t/meson.build b/t/meson.build
index 459c52a489..2aec2c011e 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -98,6 +98,7 @@ integration_tests = [
   't0028-working-tree-encoding.sh',
   't0029-core-unsetenvvars.sh',
   't0030-stripspace.sh',
+  't0031-lockfile-pid.sh',
   't0033-safe-directory.sh',
   't0034-root-safe-directory.sh',
   't0035-safe-bare-repository.sh',
diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
new file mode 100755
index 0000000000..44f3ba1f25
--- /dev/null
+++ b/t/t0031-lockfile-pid.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+
+test_description='lock file PID info tests
+
+Tests for PID info file alongside lock files.
+The feature is opt-in via core.lockfilePid config setting (boolean).
+'
+
+. ./test-lib.sh
+
+test_expect_success 'stale lock detected when PID is not running' '
+	git init repo &&
+	(
+		cd repo &&
+		touch .git/index.lock &&
+		printf "pid 99999" >.git/index~pid.lock &&
+		test_must_fail git -c core.lockfilePid=true add . 2>err &&
+		test_grep "process 99999, which is no longer running" err &&
+		test_grep "Remove the stale lock file" err
+	)
+'
+
+test_expect_success 'PID info not shown by default' '
+	git init repo2 &&
+	(
+		cd repo2 &&
+		touch .git/index.lock &&
+		printf "pid 99999" >.git/index~pid.lock &&
+		test_must_fail git add . 2>err &&
+		# Should not crash, just show normal error without PID
+		test_grep "Unable to create" err &&
+		! test_grep "is held by process" err
+	)
+'
+
+test_expect_success 'running process detected when PID is alive' '
+	git init repo3 &&
+	(
+		cd repo3 &&
+		echo content >file &&
+		# Get the correct PID for this platform
+		shell_pid=$$ &&
+		if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
+		then
+			# In Git for Windows, Bash uses MSYS2 PIDs but git.exe
+			# uses Windows PIDs. Use the Windows PID.
+			shell_pid=$(cat /proc/$shell_pid/winpid)
+		fi &&
+		# Create a lock and PID file with current shell PID (which is running)
+		touch .git/index.lock &&
+		printf "pid %d" "$shell_pid" >.git/index~pid.lock &&
+		# Verify our PID is shown in the error message
+		test_must_fail git -c core.lockfilePid=true add file 2>err &&
+		test_grep "held by process $shell_pid" err
+	)
+'
+
+test_expect_success 'PID info file cleaned up on successful operation when enabled' '
+	git init repo4 &&
+	(
+		cd repo4 &&
+		echo content >file &&
+		git -c core.lockfilePid=true add file &&
+		# After successful add, no lock or PID files should exist
+		test_path_is_missing .git/index.lock &&
+		test_path_is_missing .git/index~pid.lock
+	)
+'
+
+test_expect_success 'no PID file created by default' '
+	git init repo5 &&
+	(
+		cd repo5 &&
+		echo content >file &&
+		git add file &&
+		# PID file should not be created when feature is disabled
+		test_path_is_missing .git/index~pid.lock
+	)
+'
+
+test_expect_success 'core.lockfilePid=false does not create PID file' '
+	git init repo6 &&
+	(
+		cd repo6 &&
+		echo content >file &&
+		git -c core.lockfilePid=false add file &&
+		# PID file should not be created when feature is disabled
+		test_path_is_missing .git/index~pid.lock
+	)
+'
+
+test_expect_success 'existing PID files are read even when feature disabled' '
+	git init repo7 &&
+	(
+		cd repo7 &&
+		touch .git/index.lock &&
+		printf "pid 99999" >.git/index~pid.lock &&
+		# Even with lockfilePid disabled, existing PID files are read
+		# to help diagnose stale locks
+		test_must_fail git add . 2>err &&
+		test_grep "process 99999" err
+	)
+'
+
+test_done

base-commit: 66ce5f8e8872f0183bb137911c52b07f1f242d13
-- 
gitgitgadget
