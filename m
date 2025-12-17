Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960A19CD0A
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997974; cv=none; b=APpEclJQgwMpOrGcAOU31E8gJWesmClyJE6Gr0QA5jvc+5UKcBl8MVNZjmhqFxQAv7JwA7iJlxUrzbraAlE9jwvhn8wR6pmOXTnY8/dBnzdshd3nrz84hQwow3lb2Sn1EPJE2Jc6D8zMfXM/SiL90pDg8FayYU95e+C4xTen+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997974; c=relaxed/simple;
	bh=XmfGla1mlOZaBp+EMqAjO3uQRKCZ9z2CrPENMZ8AJ1I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ppoiF/6KQnTFWhIKUs/79biQEkxydz/ROEZRNq3qPVtSGpUZhbHUaoh5YKM0RHHW0F1K6uTlflfpaqjxEDj7OEYgYXxWWan7c9OLcQ89irdg36sMkF0+VFJmPt/OGVVq5l1vDvA2tKe/1DtMxqvD4Oz74zMYQFVZOnykFne8+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IM+naCrn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM+naCrn"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c902f6845so4792283a91.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 10:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765997969; x=1766602769; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfZVXJa5u2V2gNkvyGUG1US02YLuP4UOFTKfzi1gCqY=;
        b=IM+naCrn6fybu7D7+pGFgWhbmK4R+aEMLdGI7qIRGPQt6TD2uKTCDwUUUgkgoj46sd
         5FNaTRH401VZFWjEKSIqVnopGX2/x8sy7sYt9dvWlQnDtykLOaEF3/+1JBmjvvrQsyTA
         6PfLlonXGYjxGX0QtptzZieQz7M8+pyJD6EIyuSk4fb6iwz1ViMZhz+YKlCQSV5VORVj
         fbKYXsQsT7Xc9YU3O3sdYT+GEHo7pH1eTQCRtOvs1TDqRH2DR35k8Q+kvFT3QCqBjCYb
         oGopGznPn466OSvIg8L6Rke5DfF5YcclUwz61xelue/9DmIN2kozzvs3+AXBUjuOIUQ4
         DnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765997969; x=1766602769;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yfZVXJa5u2V2gNkvyGUG1US02YLuP4UOFTKfzi1gCqY=;
        b=F3zYT1ZDjxQorRvp/LRmjQ7EbyXLOezYecNaoarO8cE3iBT/ddbFhiG9gbcrZKEfAh
         ecYGOSuSulBtVwXq2RKwMfPXh1DdLF40yI9c84tlFpkdqvlIPZmOqMEQdeafxFuuFeR5
         P10Hiej0IDdCnIlUHCHaZs61zL6JgJy89Wxuc15gRFLAVPMZfJEbmVqas0Q5l+so8HMe
         QrKf47KrHHEKnTS3Wq+sm7ztAPG0jjnaT9KiS5iv2yg+XDRK/R1DOCNkeGSuVyh8J1vi
         qe91vJBwDlMCA13fGSCyt10X9WrZ5S3A8GAwoCsJaYntmn6GSDM0NpfLH9IS1otneHtr
         OfTw==
X-Gm-Message-State: AOJu0YyNB3mAZGiUuGlYNdhKO+lPYWWtWH/o9i9VtaPR126oWMERfv8y
	VV6015WF8zS/Q9bqKDhoKFVihMipXSekm4M3gXJQSkUXaRJ6K5Q4J590Z3So8IDOy1E=
X-Gm-Gg: AY/fxX44f1Mutt0G5CRd5zKY1RFBrACbPqsoPXUDnO1noQSfUSxT+Ix5sO/vj7vHWmo
	zYYWDi36HS4LIhvyFnKfmZT5MRSNAdOP+GGVxFStIFOl/FMTov2wOxDuh49wbYPLNeaJUjJNHVK
	uty654Ml1DUm/T3E02liUWvJ27bA1qe5Mpxz3SzTHuMUmxNx2uIjztWZnadxO4l0UlgTUWOH0Dk
	3yarO3LzbwmBOaUxIdTVkazJhwE2pntcet/ruSR9ytuwrWjrrzUW80IdTPibh8437WTtETrZhyc
	M3atDSuzyoqzJltHbZ2kzBMqz0Bw637Gzrvmf7RjaZNDZVTU7GppbTy8aziuWzQuX+thzcMkLG1
	FiqokiOEW1BPsV75RN0GHBnjnCRqChmQFkQb3k1BY6oZYHFzSIPuCPzPSyQRo5r+1EwTxCp9RN5
	xIknokzq54+hFDrGYhQdGsutI=
X-Google-Smtp-Source: AGHT+IGDrmBJsyeNfnRcPTqWr4CrYeIe1Hr5NwIbdJhMc1bF8F0fWCHtFTjy1JSq7EtIO2TjuFglJg==
X-Received: by 2002:a17:90b:2e0c:b0:341:8c8b:b8e6 with SMTP id 98e67ed59e1d1-34abd734244mr16887161a91.16.1765997968132;
        Wed, 17 Dec 2025 10:59:28 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd40eb2b9sm2184311a91.2.2025.12.17.10.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:59:27 -0800 (PST)
Message-Id: <pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>
In-Reply-To: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
From: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 18:59:26 +0000
Subject: [PATCH v2] lockfile: add PID file for debugging stale locks
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
    Paulo Casaretto <pcasaretto@gmail.com>,
    Paulo Casaretto <pcasaretto@gmail.com>

From: Paulo Casaretto <pcasaretto@gmail.com>

When a lock file is held, it can be helpful to know which process owns
it, especially when debugging stale locks left behind by crashed
processes. Add an optional feature that creates a companion PID file
alongside each lock file, containing the PID of the lock holder.

For a lock file "foo.lock", the PID file is named "foo.pid.lock". The
file uses a simple key-value format ("pid <value>") following the same
pattern as Git object headers, making it extensible for future metadata.

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

The feature is controlled via core.lockfilePid configuration, which
accepts per-component values similar to core.fsync:

  - none: Disable for all components (default)
  - all: Enable for all components
  - index, config, refs, commit-graph, midx, shallow, gc, other:
    Enable for specific components

Multiple components can be combined with commas:

  git config core.lockfilePid index,config

Each lock file call site specifies which component it belongs to,
allowing users fine-grained control over which locks create PID files.

Existing PID files are always read when displaying lock errors,
regardless of the core.lockfilePid setting. This ensures helpful
diagnostics even when the feature was previously enabled and later
disabled.

Signed-off-by: Paulo Casaretto <pcasaretto@gmail.com>
---
    lockfile: add holder info file for debugging stale locks
    
    Changes in v2
    
     * Changed file naming: Using foo.pid.lock to keep the .lock suffix
       (which is rejected by ref validation), while clearly indicating the
       file's purpose
    
     * Extensible file format: Using pid <value> key-value format (same
       pattern as Git object headers) instead of raw PID, allowing future
       fields (hostname?)
    
     * Replaced environment variable with config: Now uses core.lockfilePid
       configuration instead of GIT_LOCK_PID_INFO environment variable
    
     * Added per-component configuration: Similar to core.fsync, users can
       enable PID files for specific components:
       
       * none (default), all
       * index, config, refs, commit-graph, midx, shallow, gc, other
    
     * Caller-specified components: Each call site specifies which component
       it belongs to, giving users fine-grained control
    
     * Always read existing PID files: When displaying lock errors, existing
       PID files are read regardless of config setting, ensuring helpful
       diagnostics
    
    I'm not very confident in my capacity to attribute the right component
    name for each of the code paths. Specially the ones I marked as other.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2011%2Fpcasaretto%2Fpid-holder-file-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2011/pcasaretto/pid-holder-file-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2011

Range-diff vs v1:

 1:  7068ec0041 ! 1:  d62edb0ca5 lockfile: add PID file for debugging stale locks
     @@ Commit message
      
          When a lock file is held, it can be helpful to know which process owns
          it, especially when debugging stale locks left behind by crashed
     -    processes. Add an optional feature that creates a companion .lock.pid
     -    file alongside each lock file, containing the PID of the lock holder.
     +    processes. Add an optional feature that creates a companion PID file
     +    alongside each lock file, containing the PID of the lock holder.
      
     -    The .lock.pid file is created when a lock is acquired (if enabled), and
     +    For a lock file "foo.lock", the PID file is named "foo.pid.lock". The
     +    file uses a simple key-value format ("pid <value>") following the same
     +    pattern as Git object headers, making it extensible for future metadata.
     +
     +    The PID file is created when a lock is acquired (if enabled), and
          automatically cleaned up when the lock is released (via commit or
          rollback). The file is registered as a tempfile so it gets cleaned up
          by signal and atexit handlers if the process terminates abnormally.
      
     -    When a lock conflict occurs, the code checks if the PID from the .pid
     -    file is still running using kill(pid, 0). This allows providing
     -    context-aware error messages. With PID info enabled:
     +    When a lock conflict occurs, the code checks for an existing PID file
     +    and, if found, uses kill(pid, 0) to determine if the process is still
     +    running. This allows providing context-aware error messages:
      
            Lock is held by process 12345. Wait for it to finish, or remove
            the lock file to continue.
     @@ Commit message
            Lock was held by process 12345, which is no longer running.
            Remove the stale lock file to continue.
      
     -    Without PID info (default):
     +    The feature is controlled via core.lockfilePid configuration, which
     +    accepts per-component values similar to core.fsync:
     +
     +      - none: Disable for all components (default)
     +      - all: Enable for all components
     +      - index, config, refs, commit-graph, midx, shallow, gc, other:
     +        Enable for specific components
     +
     +    Multiple components can be combined with commas:
     +
     +      git config core.lockfilePid index,config
      
     -      Another git process seems to be running in this repository.
     -      Wait for it to finish, or remove the lock file to continue.
     +    Each lock file call site specifies which component it belongs to,
     +    allowing users fine-grained control over which locks create PID files.
      
     -    The feature is opt-in via GIT_LOCK_PID_INFO=1 environment variable.
     +    Existing PID files are always read when displaying lock errors,
     +    regardless of the core.lockfilePid setting. This ensures helpful
     +    diagnostics even when the feature was previously enabled and later
     +    disabled.
      
          Signed-off-by: Paulo Casaretto <pcasaretto@gmail.com>
      
     - ## Documentation/git.adoc ##
     -@@ Documentation/git.adoc: be in the future).
     - 	the background which do not want to cause lock contention with
     - 	other operations on the repository.  Defaults to `1`.
     - 
     -+`GIT_LOCK_PID_INFO`::
     -+	If this Boolean environment variable is set to `1`, Git will create
     -+	a `.lock.pid` file alongside each lock file containing the PID of the
     -+	process that created the lock. This information is displayed in error
     -+	messages when a lock conflict occurs, making it easier to identify
     -+	stale locks or debug locking issues. The PID files are automatically
     -+	cleaned up via signal and atexit handlers; however, if a process is
     -+	terminated abnormally (e.g., SIGKILL), the file may remain as a stale
     -+	indicator. Disabled by default.
     -+
     - `GIT_REDIRECT_STDIN`::
     - `GIT_REDIRECT_STDOUT`::
     - `GIT_REDIRECT_STDERR`::
     + ## Documentation/config/core.adoc ##
     +@@ Documentation/config/core.adoc: confusion unless you know what you are doing (e.g. you are creating a
     + read-only snapshot of the same index to a location different from the
     + repository's usual working tree).
     + 
     ++core.lockfilePid::
     ++	A comma-separated list of components for which Git should create
     ++	a PID file alongside the lock file. When a lock acquisition fails
     ++	and a PID file exists, Git can provide additional diagnostic
     ++	information about the process holding the lock, including whether
     ++	it is still running.
     +++
     ++This feature is disabled by default. You can enable it for specific
     ++components or use `all` to enable for all components.
     +++
     ++* `none` disables PID file creation for all components.
     ++* `index` creates PID files for index lock operations.
     ++* `config` creates PID files for config file lock operations.
     ++* `refs` creates PID files for reference lock operations.
     ++* `commit-graph` creates PID files for commit-graph lock operations.
     ++* `midx` creates PID files for multi-pack-index lock operations.
     ++* `shallow` creates PID files for shallow file lock operations.
     ++* `gc` creates PID files for garbage collection lock operations.
     ++* `other` creates PID files for other miscellaneous lock operations.
     ++* `all` enables PID file creation for all components.
     +++
     ++The PID file is named by inserting `.pid` before the `.lock` suffix.
     ++For example, if the lock file is `index.lock`, the PID file will be
     ++`index.pid.lock`. The file contains `pid <value>` on a single line,
     ++following the same key-value format used by Git object headers.
     ++
     + core.logAllRefUpdates::
     + 	Enable the reflog. Updates to a ref <ref> is logged to the file
     + 	"`$GIT_DIR/logs/<ref>`", by appending the new and old
     +
     + ## apply.c ##
     +@@ apply.c: static int build_fake_ancestor(struct apply_state *state, struct patch *list)
     + 		}
     + 	}
     + 
     +-	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR);
     ++	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR,
     ++				  LOCKFILE_PID_OTHER);
     + 	res = write_locked_index(&result, &lock, COMMIT_LOCK);
     + 	discard_index(&result);
     + 
     +@@ apply.c: static int apply_patch(struct apply_state *state,
     + 		if (state->index_file)
     + 			hold_lock_file_for_update(&state->lock_file,
     + 						  state->index_file,
     +-						  LOCK_DIE_ON_ERROR);
     ++						  LOCK_DIE_ON_ERROR,
     ++						  LOCKFILE_PID_INDEX);
     + 		else
     + 			repo_hold_locked_index(state->repo, &state->lock_file,
     + 					       LOCK_DIE_ON_ERROR);
     +
     + ## builtin/commit.c ##
     +@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
     + 	path = repo_git_path(the_repository, "next-index-%"PRIuMAX,
     + 			     (uintmax_t) getpid());
     + 	hold_lock_file_for_update(&false_lock, path,
     +-				  LOCK_DIE_ON_ERROR);
     ++				  LOCK_DIE_ON_ERROR, LOCKFILE_PID_OTHER);
     + 
     + 	create_base_index(current_head);
     + 	add_remove_files(&partial);
     +
     + ## builtin/credential-store.c ##
     +@@ builtin/credential-store.c: static void rewrite_credential_file(const char *fn, struct credential *c,
     + 	int timeout_ms = 1000;
     + 
     + 	repo_config_get_int(the_repository, "credentialstore.locktimeoutms", &timeout_ms);
     +-	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
     ++	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms,
     ++					      LOCKFILE_PID_CONFIG) < 0)
     + 		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
     + 	if (extra)
     + 		print_line(extra);
     +
     + ## builtin/difftool.c ##
     +@@ builtin/difftool.c: static int run_dir_diff(struct repository *repo,
     + 			struct lock_file lock = LOCK_INIT;
     + 			strbuf_reset(&buf);
     + 			strbuf_addf(&buf, "%s/wtindex", tmpdir.buf);
     +-			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
     ++			if (hold_lock_file_for_update(&lock, buf.buf, 0,
     ++					      LOCKFILE_PID_OTHER) < 0 ||
     + 			    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
     + 				ret = error("could not write %s", buf.buf);
     + 				goto finish;
     +
     + ## builtin/fast-import.c ##
     +@@ builtin/fast-import.c: static void dump_marks(void)
     + 		return;
     + 	}
     + 
     +-	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) {
     ++	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0,
     ++				      LOCKFILE_PID_OTHER) < 0) {
     + 		failure |= error_errno(_("unable to write marks file %s"),
     + 				       export_marks_file);
     + 		return;
     +
     + ## builtin/gc.c ##
     +@@ builtin/gc.c: static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
     + 
     + 	pidfile_path = repo_git_path(the_repository, "gc.pid");
     + 	fd = hold_lock_file_for_update(&lock, pidfile_path,
     +-				       LOCK_DIE_ON_ERROR);
     ++				       LOCK_DIE_ON_ERROR, LOCKFILE_PID_GC);
     + 	if (!force) {
     + 		static char locking_host[HOST_NAME_MAX + 1];
     + 		static char *scan_fmt;
     +@@ builtin/gc.c: int cmd_gc(int argc,
     + 	if (daemonized) {
     + 		char *path = repo_git_path(the_repository, "gc.log");
     + 		hold_lock_file_for_update(&log_lock, path,
     +-					  LOCK_DIE_ON_ERROR);
     ++					  LOCK_DIE_ON_ERROR, LOCKFILE_PID_GC);
     + 		dup2(get_lock_file_fd(&log_lock), 2);
     + 		atexit(process_log_file_at_exit);
     + 		free(path);
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts,
     + 	struct repository *r = the_repository;
     + 	char *lock_path = xstrfmt("%s/maintenance", r->objects->sources->path);
     + 
     +-	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
     ++	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF,
     ++				      LOCKFILE_PID_GC) < 0) {
     + 		/*
     + 		 * Another maintenance command is running.
     + 		 *
     +@@ builtin/gc.c: static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
     + 		lock_file_timeout_ms = 150;
     + 
     + 	fd = hold_lock_file_for_update_timeout(&lk, filename, LOCK_DIE_ON_ERROR,
     +-					       lock_file_timeout_ms);
     ++					       lock_file_timeout_ms,
     ++					       LOCKFILE_PID_GC);
     + 
     + 	/*
     + 	 * Does this file already exist? With the intended contents? Is it
     +@@ builtin/gc.c: static int update_background_schedule(const struct maintenance_start_opts *opts,
     + 	struct lock_file lk;
     + 	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->sources->path);
     + 
     +-	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
     ++	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF,
     ++				      LOCKFILE_PID_GC) < 0) {
     + 		if (errno == EEXIST)
     + 			error(_("unable to create '%s.lock': %s.\n\n"
     + 			    "Another scheduled git-maintenance(1) process seems to be running in this\n"
     +
     + ## builtin/sparse-checkout.c ##
     +@@ builtin/sparse-checkout.c: static int write_patterns_and_update(struct repository *repo,
     + 	if (safe_create_leading_directories(repo, sparse_filename))
     + 		die(_("failed to create directory for sparse-checkout file"));
     + 
     +-	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
     ++	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR,
     ++				  LOCKFILE_PID_OTHER);
     + 
     + 	result = update_working_directory(repo, pl);
     + 	if (result) {
     +
     + ## bundle.c ##
     +@@ bundle.c: int create_bundle(struct repository *r, const char *path,
     + 		bundle_fd = 1;
     + 	else
     + 		bundle_fd = hold_lock_file_for_update(&lock, path,
     +-						      LOCK_DIE_ON_ERROR);
     ++						      LOCK_DIE_ON_ERROR,
     ++						      LOCKFILE_PID_OTHER);
     + 
     + 	if (version == -1)
     + 		version = min_version;
     +
     + ## cache-tree.c ##
     +@@ cache-tree.c: int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
     + 	struct lock_file lock_file = LOCK_INIT;
     + 	int ret;
     + 
     +-	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
     ++	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR,
     ++				  LOCKFILE_PID_INDEX);
     + 
     + 	entries = read_index_from(index_state, index_path,
     + 				  repo_get_git_dir(the_repository));
     +
     + ## commit-graph.c ##
     +@@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     + 		char *lock_name = get_commit_graph_chain_filename(ctx->odb_source);
     + 
     + 		hold_lock_file_for_update_mode(&lk, lock_name,
     +-					       LOCK_DIE_ON_ERROR, 0444);
     ++					       LOCK_DIE_ON_ERROR, 0444,
     ++					       LOCKFILE_PID_COMMIT_GRAPH);
     + 		free(lock_name);
     + 
     + 		graph_layer = mks_tempfile_m(ctx->graph_name, 0444);
     +@@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     + 			   get_tempfile_fd(graph_layer), get_tempfile_path(graph_layer));
     + 	} else {
     + 		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
     +-					       LOCK_DIE_ON_ERROR, 0444);
     ++					       LOCK_DIE_ON_ERROR, 0444,
     ++					       LOCKFILE_PID_COMMIT_GRAPH);
     + 		f = hashfd(ctx->r->hash_algo,
     + 			   get_lock_file_fd(&lk), get_lock_file_path(&lk));
     + 	}
     +
     + ## compat/mingw.c ##
     +@@ compat/mingw.c: int mingw_kill(pid_t pid, int sig)
     + 			CloseHandle(h);
     + 			return 0;
     + 		}
     ++		/*
     ++		 * OpenProcess returns ERROR_INVALID_PARAMETER for
     ++		 * non-existent PIDs. Map this to ESRCH for POSIX
     ++		 * compatibility with kill(pid, 0).
     ++		 */
     ++		if (GetLastError() == ERROR_INVALID_PARAMETER)
     ++			errno = ESRCH;
     ++		else
     ++			errno = err_win_to_posix(GetLastError());
     ++		return -1;
     + 	}
     + 
     + 	errno = EINVAL;
     +
     + ## config.c ##
     +@@ config.c: int repo_config_set_multivar_in_file_gently(struct repository *r,
     + 	 * The lock serves a purpose in addition to locking: the new
     + 	 * contents of .git/config will be written into it.
     + 	 */
     +-	fd = hold_lock_file_for_update(&lock, config_filename, 0);
     ++	fd = hold_lock_file_for_update(&lock, config_filename, 0,
     ++				       LOCKFILE_PID_CONFIG);
     + 	if (fd < 0) {
     + 		error_errno(_("could not lock config file %s"), config_filename);
     + 		ret = CONFIG_NO_LOCK;
     +@@ config.c: static int repo_config_copy_or_rename_section_in_file(
     + 	if (!config_filename)
     + 		config_filename = filename_buf = repo_git_path(r, "config");
     + 
     +-	out_fd = hold_lock_file_for_update(&lock, config_filename, 0);
     ++	out_fd = hold_lock_file_for_update(&lock, config_filename, 0,
     ++					   LOCKFILE_PID_CONFIG);
     + 	if (out_fd < 0) {
     + 		ret = error(_("could not lock config file %s"), config_filename);
     + 		goto out;
     +
     + ## environment.c ##
     +@@
     + #include "gettext.h"
     + #include "git-zlib.h"
     + #include "ident.h"
     ++#include "lockfile.h"
     + #include "mailmap.h"
     + #include "object-name.h"
     + #include "repository.h"
     +@@ environment.c: next_name:
     + 	return (current & ~negative) | positive;
     + }
     + 
     ++static const struct lockfile_pid_component_name {
     ++	const char *name;
     ++	enum lockfile_pid_component component_bits;
     ++} lockfile_pid_component_names[] = {
     ++	{ "index", LOCKFILE_PID_INDEX },
     ++	{ "config", LOCKFILE_PID_CONFIG },
     ++	{ "refs", LOCKFILE_PID_REFS },
     ++	{ "commit-graph", LOCKFILE_PID_COMMIT_GRAPH },
     ++	{ "midx", LOCKFILE_PID_MIDX },
     ++	{ "shallow", LOCKFILE_PID_SHALLOW },
     ++	{ "gc", LOCKFILE_PID_GC },
     ++	{ "other", LOCKFILE_PID_OTHER },
     ++	{ "all", LOCKFILE_PID_ALL },
     ++};
     ++
     ++static enum lockfile_pid_component parse_lockfile_pid_components(const char *var,
     ++								 const char *string)
     ++{
     ++	enum lockfile_pid_component current = LOCKFILE_PID_DEFAULT;
     ++	enum lockfile_pid_component positive = 0, negative = 0;
     ++
     ++	while (string) {
     ++		size_t len;
     ++		const char *ep;
     ++		int negated = 0;
     ++		int found = 0;
     ++
     ++		string = string + strspn(string, ", \t\n\r");
     ++		ep = strchrnul(string, ',');
     ++		len = ep - string;
     ++		if (len == 4 && !strncmp(string, "none", 4)) {
     ++			current = LOCKFILE_PID_NONE;
     ++			goto next_name;
     ++		}
     ++
     ++		if (*string == '-') {
     ++			negated = 1;
     ++			string++;
     ++			len--;
     ++			if (!len)
     ++				warning(_("invalid value for variable %s"), var);
     ++		}
     ++
     ++		if (!len)
     ++			break;
     ++
     ++		for (size_t i = 0; i < ARRAY_SIZE(lockfile_pid_component_names); ++i) {
     ++			const struct lockfile_pid_component_name *n = &lockfile_pid_component_names[i];
     ++
     ++			if (strncmp(n->name, string, len) || strlen(n->name) != len)
     ++				continue;
     ++
     ++			found = 1;
     ++			if (negated)
     ++				negative |= n->component_bits;
     ++			else
     ++				positive |= n->component_bits;
     ++		}
     ++
     ++		if (!found) {
     ++			char *component = xstrndup(string, len);
     ++			warning(_("ignoring unknown core.lockfilePid component '%s'"), component);
     ++			free(component);
     ++		}
     ++
     ++next_name:
     ++		string = ep;
     ++	}
     ++
     ++	return (current & ~negative) | positive;
     ++}
     ++
     + static int git_default_core_config(const char *var, const char *value,
     + 				   const struct config_context *ctx, void *cb)
     + {
     +@@ environment.c: static int git_default_core_config(const char *var, const char *value,
     + 		return 0;
     + 	}
     + 
     ++	if (!strcmp(var, "core.lockfilepid")) {
     ++		if (!value)
     ++			return config_error_nonbool(var);
     ++		lockfile_pid_components = parse_lockfile_pid_components(var, value);
     ++		return 0;
     ++	}
     ++
     + 	if (!strcmp(var, "core.createobject")) {
     + 		if (!value)
     + 			return config_error_nonbool(var);
      
       ## lockfile.c ##
      @@
     @@ lockfile.c: static void resolve_symlink(struct strbuf *path)
       }
       
      +/*
     -+ * Lock PID file functions - write PID to a .lock.pid file alongside
     ++ * Lock PID file functions - write PID to a foo-pid.lock file alongside
      + * the lock file for debugging stale locks. The PID file is registered
      + * as a tempfile so it gets cleaned up by signal/atexit handlers.
     ++ *
     ++ * Naming: For "foo.lock", the PID file is "foo-pid.lock" (not "foo.lock.pid").
     ++ * This avoids collision with the refs namespace.
     ++ */
     ++
     ++/* Global config variable, initialized from core.lockfilePid */
     ++enum lockfile_pid_component lockfile_pid_components = LOCKFILE_PID_DEFAULT;
     ++
     ++/*
     ++ * Path generation helpers.
     ++ * Given base path "foo", generate:
     ++ *   - lock path: "foo.lock"
     ++ *   - pid path:  "foo-pid.lock"
      + */
     ++static void get_lock_path(struct strbuf *out, const char *path)
     ++{
     ++	strbuf_addstr(out, path);
     ++	strbuf_addstr(out, LOCK_SUFFIX);
     ++}
      +
     -+static int lock_pid_info_enabled(void)
     ++static void get_pid_path(struct strbuf *out, const char *path)
      +{
     -+	return git_env_bool(GIT_LOCK_PID_INFO_ENVIRONMENT, 0);
     ++	strbuf_addstr(out, path);
     ++	strbuf_addstr(out, LOCK_PID_INFIX);
     ++	strbuf_addstr(out, LOCK_SUFFIX);
      +}
      +
     -+static struct tempfile *create_lock_pid_file(const char *lock_path, int mode)
     ++static struct tempfile *create_lock_pid_file(const char *pid_path, int mode,
     ++					     enum lockfile_pid_component component)
      +{
     -+	struct strbuf pid_path = STRBUF_INIT;
      +	struct strbuf content = STRBUF_INIT;
      +	struct tempfile *pid_tempfile = NULL;
     -+	int fd;
     -+
     -+	if (!lock_pid_info_enabled())
     -+		return NULL;
     -+
     -+	strbuf_addf(&pid_path, "%s%s", lock_path, LOCK_PID_SUFFIX);
     -+	fd = open(pid_path.buf, O_WRONLY | O_CREAT | O_TRUNC, mode);
     -+	if (fd >= 0) {
     -+		strbuf_addf(&content, "%"PRIuMAX"\n", (uintmax_t)getpid());
     -+		if (write_in_full(fd, content.buf, content.len) < 0)
     -+			warning_errno(_("could not write lock pid file '%s'"),
     -+				      pid_path.buf);
     -+		close(fd);
     -+		pid_tempfile = register_tempfile(pid_path.buf);
     ++	int fd = -1;
     ++
     ++	if (!(lockfile_pid_components & component))
     ++		goto out;
     ++
     ++	fd = open(pid_path, O_WRONLY | O_CREAT | O_EXCL, mode);
     ++	if (fd < 0)
     ++		goto out;
     ++
     ++	strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
     ++	if (write_in_full(fd, content.buf, content.len) < 0) {
     ++		warning_errno(_("could not write lock pid file '%s'"), pid_path);
     ++		goto out;
      +	}
     ++
     ++	close(fd);
     ++	fd = -1;
     ++	pid_tempfile = register_tempfile(pid_path);
     ++
     ++out:
     ++	if (fd >= 0)
     ++		close(fd);
      +	strbuf_release(&content);
     -+	strbuf_release(&pid_path);
      +	return pid_tempfile;
      +}
      +
     -+static int read_lock_pid(const char *lock_path, uintmax_t *pid_out)
     ++static int read_lock_pid(const char *pid_path, uintmax_t *pid_out)
      +{
     -+	struct strbuf pid_path = STRBUF_INIT;
      +	struct strbuf content = STRBUF_INIT;
     ++	const char *val;
      +	int ret = -1;
      +
     -+	strbuf_addf(&pid_path, "%s%s", lock_path, LOCK_PID_SUFFIX);
     -+	if (strbuf_read_file(&content, pid_path.buf, LOCK_PID_MAXLEN) > 0) {
     ++	if (strbuf_read_file(&content, pid_path, LOCK_PID_MAXLEN) <= 0)
     ++		goto out;
     ++
     ++	strbuf_rtrim(&content);
     ++
     ++	if (skip_prefix(content.buf, "pid ", &val)) {
      +		char *endptr;
     -+		*pid_out = strtoumax(content.buf, &endptr, 10);
     -+		if (*pid_out > 0 && (*endptr == '\n' || *endptr == '\0'))
     ++		*pid_out = strtoumax(val, &endptr, 10);
     ++		if (*pid_out > 0 && !*endptr)
      +			ret = 0;
     -+		else
     -+			warning(_("malformed lock pid file '%s'"), pid_path.buf);
      +	}
     -+	strbuf_release(&pid_path);
     ++
     ++	if (ret)
     ++		warning(_("malformed lock pid file '%s'"), pid_path);
     ++
     ++out:
      +	strbuf_release(&content);
      +	return ret;
      +}
      +
       /* Make sure errno contains a meaningful value on error */
       static int lock_file(struct lock_file *lk, const char *path, int flags,
     - 		     int mode)
     -@@ lockfile.c: static int lock_file(struct lock_file *lk, const char *path, int flags,
     - 	strbuf_addstr(&filename, path);
     +-		     int mode)
     ++		     int mode, enum lockfile_pid_component component)
     + {
     +-	struct strbuf filename = STRBUF_INIT;
     ++	struct strbuf base_path = STRBUF_INIT;
     ++	struct strbuf lock_path = STRBUF_INIT;
     ++	struct strbuf pid_path = STRBUF_INIT;
     + 
     +-	strbuf_addstr(&filename, path);
     ++	strbuf_addstr(&base_path, path);
       	if (!(flags & LOCK_NO_DEREF))
     - 		resolve_symlink(&filename);
     --
     - 	strbuf_addstr(&filename, LOCK_SUFFIX);
     +-		resolve_symlink(&filename);
     ++		resolve_symlink(&base_path);
      +
     - 	lk->tempfile = create_tempfile_mode(filename.buf, mode);
     -+	if (lk->tempfile)
     -+		lk->pid_tempfile = create_lock_pid_file(filename.buf, mode);
     ++	get_lock_path(&lock_path, base_path.buf);
     ++	get_pid_path(&pid_path, base_path.buf);
      +
     - 	strbuf_release(&filename);
     ++	lk->tempfile = create_tempfile_mode(lock_path.buf, mode);
     ++	if (lk->tempfile)
     ++		lk->pid_tempfile = create_lock_pid_file(pid_path.buf, mode,
     ++							component);
     + 
     +-	strbuf_addstr(&filename, LOCK_SUFFIX);
     +-	lk->tempfile = create_tempfile_mode(filename.buf, mode);
     +-	strbuf_release(&filename);
     ++	strbuf_release(&base_path);
     ++	strbuf_release(&lock_path);
     ++	strbuf_release(&pid_path);
       	return lk->tempfile ? lk->tempfile->fd : -1;
       }
     + 
     +@@ lockfile.c: static int lock_file(struct lock_file *lk, const char *path, int flags,
     +  * exactly once. If timeout_ms is -1, try indefinitely.
     +  */
     + static int lock_file_timeout(struct lock_file *lk, const char *path,
     +-			     int flags, long timeout_ms, int mode)
     ++			     int flags, long timeout_ms, int mode,
     ++			     enum lockfile_pid_component component)
     + {
     + 	int n = 1;
     + 	int multiplier = 1;
     +@@ lockfile.c: static int lock_file_timeout(struct lock_file *lk, const char *path,
     + 	static int random_initialized = 0;
     + 
     + 	if (timeout_ms == 0)
     +-		return lock_file(lk, path, flags, mode);
     ++		return lock_file(lk, path, flags, mode, component);
     + 
     + 	if (!random_initialized) {
     + 		srand((unsigned int)getpid());
     +@@ lockfile.c: static int lock_file_timeout(struct lock_file *lk, const char *path,
     + 		long backoff_ms, wait_ms;
     + 		int fd;
     + 
     +-		fd = lock_file(lk, path, flags, mode);
     ++		fd = lock_file(lk, path, flags, mode, component);
     + 
     + 		if (fd >= 0)
     + 			return fd; /* success */
      @@ lockfile.c: static int lock_file_timeout(struct lock_file *lk, const char *path,
       void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
       {
     @@ lockfile.c: static int lock_file_timeout(struct lock_file *lk, const char *path,
      -		    "may have crashed in this repository earlier:\n"
      -		    "remove the file manually to continue."),
      -			    absolute_path(path), strerror(err));
     +-	} else
     ++		const char *abs_path = absolute_path(path);
      +		struct strbuf lock_path = STRBUF_INIT;
     ++		struct strbuf pid_path = STRBUF_INIT;
      +		uintmax_t pid;
      +		int pid_status = 0; /* 0 = unknown, 1 = running, -1 = stale */
      +
     -+		strbuf_addf(&lock_path, "%s%s", absolute_path(path), LOCK_SUFFIX);
     ++		get_lock_path(&lock_path, abs_path);
     ++		get_pid_path(&pid_path, abs_path);
      +
      +		strbuf_addf(buf, _("Unable to create '%s': %s.\n\n"),
      +			    lock_path.buf, strerror(err));
      +
     -+		if (lock_pid_info_enabled() &&
     -+		    !read_lock_pid(lock_path.buf, &pid)) {
     -+			if (kill((pid_t)pid, 0) == 0)
     -+				pid_status = 1;
     -+			else
     -+				pid_status = -1;
     ++		/*
     ++		 * Try to read PID file unconditionally - it may exist if
     ++		 * core.lockfilePid was enabled for this component.
     ++		 */
     ++		if (!read_lock_pid(pid_path.buf, &pid)) {
     ++			if (kill((pid_t)pid, 0) == 0 || errno == EPERM)
     ++				pid_status = 1;  /* running (or no permission to signal) */
     ++			else if (errno == ESRCH)
     ++				pid_status = -1; /* no such process - stale lock */
      +		}
      +
      +		if (pid_status == 1)
     -+			strbuf_addf(buf, _("Lock is held by process %"PRIuMAX". "
     -+			    "Wait for it to finish, or remove the lock file to continue"),
     -+			    pid);
     ++			strbuf_addf(buf, _("Lock is held by process %" PRIuMAX ". "
     ++					   "Wait for it to finish, or remove the lock file to continue"),
     ++				    pid);
      +		else if (pid_status == -1)
     -+			strbuf_addf(buf, _("Lock was held by process %"PRIuMAX", "
     -+			    "which is no longer running. Remove the stale lock file to continue"),
     -+			    pid);
     ++			strbuf_addf(buf, _("Lock was held by process %" PRIuMAX ", "
     ++					   "which is no longer running. Remove the stale lock file to continue"),
     ++				    pid);
      +		else
      +			strbuf_addstr(buf, _("Another git process seems to be running in this repository. "
     -+			    "Wait for it to finish, or remove the lock file to continue"));
     ++					     "Wait for it to finish, or remove the lock file to continue"));
      +
      +		strbuf_release(&lock_path);
     - 	} else
     ++		strbuf_release(&pid_path);
     ++	} else {
       		strbuf_addf(buf, _("Unable to create '%s.lock': %s"),
       			    absolute_path(path), strerror(err));
     ++	}
     + }
     + 
     + NORETURN void unable_to_lock_die(const char *path, int err)
     +@@ lockfile.c: NORETURN void unable_to_lock_die(const char *path, int err)
     + /* This should return a meaningful errno on failure */
     + int hold_lock_file_for_update_timeout_mode(struct lock_file *lk,
     + 					   const char *path, int flags,
     +-					   long timeout_ms, int mode)
     ++					   long timeout_ms, int mode,
     ++					   enum lockfile_pid_component component)
     + {
     +-	int fd = lock_file_timeout(lk, path, flags, timeout_ms, mode);
     ++	int fd = lock_file_timeout(lk, path, flags, timeout_ms, mode, component);
     + 	if (fd < 0) {
     + 		if (flags & LOCK_DIE_ON_ERROR)
     + 			unable_to_lock_die(path, errno);
      @@ lockfile.c: int commit_lock_file(struct lock_file *lk)
       {
       	char *result_path = get_locked_file_path(lk);
     @@ lockfile.h: struct lock_file {
       #define LOCK_SUFFIX ".lock"
       #define LOCK_SUFFIX_LEN 5
       
     -+/* Suffix for PID file that stores PID of lock holder: */
     -+#define LOCK_PID_SUFFIX ".pid"
     -+#define LOCK_PID_SUFFIX_LEN 4
     ++/*
     ++ * PID file naming: for a lock file "foo.lock", the PID file is "foo.pid.lock".
     ++ */
     ++#define LOCK_PID_INFIX ".pid"
     ++#define LOCK_PID_INFIX_LEN 4
      +
      +/* Maximum length for PID file content */
      +#define LOCK_PID_MAXLEN 32
      +
     -+/* Environment variable to enable lock PID info (default: disabled) */
     -+#define GIT_LOCK_PID_INFO_ENVIRONMENT "GIT_LOCK_PID_INFO"
     ++/*
     ++ * Per-component lock PID file configuration, following core.fsync pattern.
     ++ * Each component can be individually enabled via core.lockfilePid config.
     ++ */
     ++enum lockfile_pid_component {
     ++	LOCKFILE_PID_NONE = 0,
     ++	LOCKFILE_PID_INDEX = 1 << 0, /* .git/index.lock */
     ++	LOCKFILE_PID_CONFIG = 1 << 1, /* .git/config.lock */
     ++	LOCKFILE_PID_REFS = 1 << 2, /* refs locks */
     ++	LOCKFILE_PID_COMMIT_GRAPH = 1 << 3, /* commit-graph.lock */
     ++	LOCKFILE_PID_MIDX = 1 << 4, /* multi-pack-index.lock */
     ++	LOCKFILE_PID_SHALLOW = 1 << 5, /* shallow file */
     ++	LOCKFILE_PID_GC = 1 << 6, /* gc locks */
     ++	LOCKFILE_PID_OTHER = 1 << 7, /* other locks */
     ++};
     ++
     ++#define LOCKFILE_PID_ALL (LOCKFILE_PID_INDEX | LOCKFILE_PID_CONFIG |      \
     ++			  LOCKFILE_PID_REFS | LOCKFILE_PID_COMMIT_GRAPH | \
     ++			  LOCKFILE_PID_MIDX | LOCKFILE_PID_SHALLOW |      \
     ++			  LOCKFILE_PID_GC | LOCKFILE_PID_OTHER)
     ++#define LOCKFILE_PID_DEFAULT LOCKFILE_PID_NONE
     ++
     ++/*
     ++ * Bitmask indicating which components should create PID files.
     ++ * Configured via core.lockfilePid.
     ++ */
     ++extern enum lockfile_pid_component lockfile_pid_components;
       
       /*
        * Flags
     +@@ lockfile.h: struct lock_file {
     +  * timeout_ms milliseconds. If timeout_ms is 0, try exactly once; if
     +  * timeout_ms is -1, retry indefinitely. The flags argument, error
     +  * handling, and mode are described above.
     ++ *
     ++ * The `component` argument specifies which lock PID component this lock
     ++ * belongs to, for selective PID file creation via core.lockfilePid config.
     +  */
     + int hold_lock_file_for_update_timeout_mode(
     +-		struct lock_file *lk, const char *path,
     +-		int flags, long timeout_ms, int mode);
     ++	struct lock_file *lk, const char *path,
     ++	int flags, long timeout_ms, int mode,
     ++	enum lockfile_pid_component component);
     + 
     + static inline int hold_lock_file_for_update_timeout(
     +-		struct lock_file *lk, const char *path,
     +-		int flags, long timeout_ms)
     ++	struct lock_file *lk, const char *path,
     ++	int flags, long timeout_ms,
     ++	enum lockfile_pid_component component)
     + {
     + 	return hold_lock_file_for_update_timeout_mode(lk, path, flags,
     +-						      timeout_ms, 0666);
     ++						      timeout_ms, 0666,
     ++						      component);
     + }
     + 
     + /*
     +@@ lockfile.h: static inline int hold_lock_file_for_update_timeout(
     +  * argument and error handling are described above.
     +  */
     + static inline int hold_lock_file_for_update(
     +-		struct lock_file *lk, const char *path,
     +-		int flags)
     ++	struct lock_file *lk, const char *path,
     ++	int flags, enum lockfile_pid_component component)
     + {
     +-	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
     ++	return hold_lock_file_for_update_timeout(lk, path, flags, 0, component);
     + }
     + 
     + static inline int hold_lock_file_for_update_mode(
     +-		struct lock_file *lk, const char *path,
     +-		int flags, int mode)
     ++	struct lock_file *lk, const char *path,
     ++	int flags, int mode, enum lockfile_pid_component component)
     + {
     +-	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode);
     ++	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode,
     ++						      component);
     + }
     + 
     + /*
      @@ lockfile.h: static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
       
       /*
     @@ lockfile.h: static inline int commit_lock_file_to(struct lock_file *lk, const ch
       
       #endif /* LOCKFILE_H */
      
     + ## loose.c ##
     +@@ loose.c: int repo_write_loose_object_map(struct repository *repo)
     + 		return 0;
     + 
     + 	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
     +-	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
     ++	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1,
     ++					       LOCKFILE_PID_OTHER);
     + 	iter = kh_begin(map);
     + 	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
     + 		goto errout;
     +@@ loose.c: static int write_one_object(struct odb_source *source,
     + 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
     + 
     + 	strbuf_addf(&path, "%s/loose-object-idx", source->path);
     +-	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
     ++	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1,
     ++					  LOCKFILE_PID_OTHER);
     + 
     + 	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
     + 	if (fd < 0)
     +
     + ## midx-write.c ##
     +@@ midx-write.c: static int write_midx_internal(struct odb_source *source,
     + 		struct strbuf lock_name = STRBUF_INIT;
     + 
     + 		get_midx_chain_filename(source, &lock_name);
     +-		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
     ++		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR,
     ++					  LOCKFILE_PID_MIDX);
     + 		strbuf_release(&lock_name);
     + 
     + 		incr = mks_tempfile_m(midx_name.buf, 0444);
     +@@ midx-write.c: static int write_midx_internal(struct odb_source *source,
     + 		f = hashfd(r->hash_algo, get_tempfile_fd(incr),
     + 			   get_tempfile_path(incr));
     + 	} else {
     +-		hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR);
     ++		hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR,
     ++					  LOCKFILE_PID_MIDX);
     + 		f = hashfd(r->hash_algo, get_lock_file_fd(&lk),
     + 			   get_lock_file_path(&lk));
     + 	}
     +
     + ## odb.c ##
     +@@ odb.c: void odb_add_to_alternates_file(struct object_database *odb,
     + 	FILE *in, *out;
     + 	int found = 0;
     + 
     +-	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
     ++	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR,
     ++				  LOCKFILE_PID_OTHER);
     + 	out = fdopen_lock_file(&lock, "w");
     + 	if (!out)
     + 		die_errno(_("unable to fdopen alternates lockfile"));
     +
     + ## refs/files-backend.c ##
     +@@ refs/files-backend.c: retry:
     + 
     + 	if (hold_lock_file_for_update_timeout(
     + 			    &lock->lk, ref_file.buf, LOCK_NO_DEREF,
     +-			    get_files_ref_lock_timeout_ms()) < 0) {
     ++			    get_files_ref_lock_timeout_ms(),
     ++			    LOCKFILE_PID_REFS) < 0) {
     + 		int myerr = errno;
     + 		errno = 0;
     + 		if (myerr == ENOENT && --attempts_remaining > 0) {
     +@@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
     + 
     + 	return hold_lock_file_for_update_timeout(
     + 			lk, path, LOCK_NO_DEREF,
     +-			get_files_ref_lock_timeout_ms()) < 0 ? -1 : 0;
     ++			get_files_ref_lock_timeout_ms(),
     ++			LOCKFILE_PID_REFS) < 0 ? -1 : 0;
     + }
     + 
     + /*
     +@@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
     + 		 * work we need, including cleaning up if the program
     + 		 * exits unexpectedly.
     + 		 */
     +-		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
     ++		if (hold_lock_file_for_update(&reflog_lock, log_file, 0,
     ++					      LOCKFILE_PID_REFS) < 0) {
     + 			struct strbuf err = STRBUF_INIT;
     + 			unable_to_lock_message(log_file, errno, &err);
     + 			error("%s", err.buf);
     +
     + ## refs/packed-backend.c ##
     +@@ refs/packed-backend.c: int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
     + 	if (hold_lock_file_for_update_timeout(
     + 			    &refs->lock,
     + 			    refs->path,
     +-			    flags, timeout_value) < 0) {
     ++			    flags, timeout_value,
     ++			    LOCKFILE_PID_REFS) < 0) {
     + 		unable_to_lock_message(refs->path, errno, err);
     + 		return -1;
     + 	}
     +
     + ## reftable/system.c ##
     +@@ reftable/system.c: int flock_acquire(struct reftable_flock *l, const char *target_path,
     + 		return REFTABLE_OUT_OF_MEMORY_ERROR;
     + 
     + 	err = hold_lock_file_for_update_timeout(lockfile, target_path, LOCK_NO_DEREF,
     +-						timeout_ms);
     ++						timeout_ms, LOCKFILE_PID_REFS);
     + 	if (err < 0) {
     + 		reftable_free(lockfile);
     + 		if (errno == EEXIST)
     +
     + ## repository.c ##
     +@@ repository.c: int repo_hold_locked_index(struct repository *repo,
     + {
     + 	if (!repo->index_file)
     + 		BUG("the repo hasn't been setup");
     +-	return hold_lock_file_for_update(lf, repo->index_file, flags);
     ++	return hold_lock_file_for_update(lf, repo->index_file, flags,
     ++					 LOCKFILE_PID_INDEX);
     + }
     +
     + ## rerere.c ##
     +@@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
     + 	else
     + 		fd = hold_lock_file_for_update(&write_lock,
     + 					       git_path_merge_rr(r),
     +-					       LOCK_DIE_ON_ERROR);
     ++					       LOCK_DIE_ON_ERROR,
     ++					       LOCKFILE_PID_OTHER);
     + 	read_rr(r, merge_rr);
     + 	return fd;
     + }
     +
     + ## sequencer.c ##
     +@@ sequencer.c: static int write_message(const void *buf, size_t len, const char *filename,
     + {
     + 	struct lock_file msg_file = LOCK_INIT;
     + 
     +-	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
     ++	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0,
     ++					       LOCKFILE_PID_OTHER);
     + 	if (msg_fd < 0)
     + 		return error_errno(_("could not lock '%s'"), filename);
     + 	if (write_in_full(msg_fd, buf, len) < 0) {
     +@@ sequencer.c: static int save_todo(struct todo_list *todo_list, struct replay_opts *opts,
     + 	if (is_rebase_i(opts) && !reschedule)
     + 		next++;
     + 
     +-	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
     ++	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0,
     ++				       LOCKFILE_PID_OTHER);
     + 	if (fd < 0)
     + 		return error_errno(_("could not lock '%s'"), todo_path);
     + 	offset = get_item_line_offset(todo_list, next);
     +@@ sequencer.c: static int safe_append(const char *filename, const char *fmt, ...)
     + 	va_list ap;
     + 	struct lock_file lock = LOCK_INIT;
     + 	int fd = hold_lock_file_for_update(&lock, filename,
     +-					   LOCK_REPORT_ON_ERROR);
     ++					   LOCK_REPORT_ON_ERROR,
     ++					   LOCKFILE_PID_OTHER);
     + 	struct strbuf buf = STRBUF_INIT;
     + 
     + 	if (fd < 0)
     +@@ sequencer.c: static int write_update_refs_state(struct string_list *refs_to_oids)
     + 		goto cleanup;
     + 	}
     + 
     +-	if (hold_lock_file_for_update(&lock, path, 0) < 0) {
     ++	if (hold_lock_file_for_update(&lock, path, 0, LOCKFILE_PID_OTHER) < 0) {
     + 		result = error(_("another 'rebase' process appears to be running; "
     + 				 "'%s.lock' already exists"),
     + 			       path);
     +
     + ## shallow.c ##
     +@@ shallow.c: void setup_alternate_shallow(struct shallow_lock *shallow_lock,
     + 
     + 	fd = hold_lock_file_for_update(&shallow_lock->lock,
     + 				       git_path_shallow(the_repository),
     +-				       LOCK_DIE_ON_ERROR);
     ++				       LOCK_DIE_ON_ERROR,
     ++				       LOCKFILE_PID_SHALLOW);
     + 	check_shallow_file_for_update(the_repository);
     + 	if (write_shallow_commits(&sb, 0, extra)) {
     + 		if (write_in_full(fd, sb.buf, sb.len) < 0)
     +@@ shallow.c: void prune_shallow(unsigned options)
     + 	}
     + 	fd = hold_lock_file_for_update(&shallow_lock.lock,
     + 				       git_path_shallow(the_repository),
     +-				       LOCK_DIE_ON_ERROR);
     ++				       LOCK_DIE_ON_ERROR,
     ++				       LOCKFILE_PID_SHALLOW);
     + 	check_shallow_file_for_update(the_repository);
     + 	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
     + 		if (write_in_full(fd, sb.buf, sb.len) < 0)
     +
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
         't0028-working-tree-encoding.sh',
     @@ t/t0031-lockfile-pid.sh (new)
      +test_description='lock file PID info tests
      +
      +Tests for PID info file alongside lock files.
     -+The feature is opt-in via GIT_LOCK_PID_INFO=1.
     ++The feature is opt-in via core.lockfilePid config setting.
      +'
      +
      +. ./test-lib.sh
     @@ t/t0031-lockfile-pid.sh (new)
      +	(
      +		cd repo &&
      +		touch .git/index.lock &&
     -+		echo "99999" >.git/index.lock.pid &&
     -+		test_must_fail env GIT_LOCK_PID_INFO=1 git add . 2>err &&
     ++		printf "pid 99999" >.git/index.pid.lock &&
     ++		test_must_fail git -c core.lockfilePid=index add . 2>err &&
      +		test_grep "process 99999, which is no longer running" err &&
      +		test_grep "Remove the stale lock file" err
      +	)
     @@ t/t0031-lockfile-pid.sh (new)
      +	(
      +		cd repo2 &&
      +		touch .git/index.lock &&
     -+		echo "99999" >.git/index.lock.pid &&
     ++		printf "pid 99999" >.git/index.pid.lock &&
      +		test_must_fail git add . 2>err &&
      +		# Should not crash, just show normal error without PID
      +		test_grep "Unable to create" err &&
     @@ t/t0031-lockfile-pid.sh (new)
      +	(
      +		cd repo3 &&
      +		echo content >file &&
     ++		# Get the correct PID for this platform
     ++		shell_pid=$$ &&
     ++		if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
     ++		then
     ++			# In Git for Windows, Bash uses MSYS2 PIDs but git.exe
     ++			# uses Windows PIDs. Use the Windows PID.
     ++			shell_pid=$(cat /proc/$shell_pid/winpid)
     ++		fi &&
      +		# Create a lock and PID file with current shell PID (which is running)
      +		touch .git/index.lock &&
     -+		echo $$ >.git/index.lock.pid &&
     ++		printf "pid %d" "$shell_pid" >.git/index.pid.lock &&
      +		# Verify our PID is shown in the error message
     -+		test_must_fail env GIT_LOCK_PID_INFO=1 git add file 2>err &&
     -+		test_grep "held by process $$" err
     ++		test_must_fail git -c core.lockfilePid=index add file 2>err &&
     ++		test_grep "held by process $shell_pid" err
      +	)
      +'
      +
     @@ t/t0031-lockfile-pid.sh (new)
      +	(
      +		cd repo4 &&
      +		echo content >file &&
     -+		env GIT_LOCK_PID_INFO=1 git add file &&
     ++		git -c core.lockfilePid=index add file &&
      +		# After successful add, no lock or PID files should exist
     -+		! test -f .git/index.lock &&
     -+		! test -f .git/index.lock.pid
     ++		test_path_is_missing .git/index.lock &&
     ++		test_path_is_missing .git/index.pid.lock
      +	)
      +'
      +
     @@ t/t0031-lockfile-pid.sh (new)
      +		echo content >file &&
      +		git add file &&
      +		# PID file should not be created when feature is disabled
     -+		! test -f .git/index.lock.pid
     ++		test_path_is_missing .git/index.pid.lock
     ++	)
     ++'
     ++
     ++test_expect_success 'core.lockfilePid=all enables for all components' '
     ++	git init repo6 &&
     ++	(
     ++		cd repo6 &&
     ++		touch .git/index.lock &&
     ++		printf "pid 99999" >.git/index.pid.lock &&
     ++		test_must_fail git -c core.lockfilePid=all add . 2>err &&
     ++		test_grep "process 99999" err
     ++	)
     ++'
     ++
     ++test_expect_success 'multiple components can be specified' '
     ++	git init repo8 &&
     ++	(
     ++		cd repo8 &&
     ++		touch .git/index.lock &&
     ++		printf "pid 99999" >.git/index.pid.lock &&
     ++		test_must_fail git -c core.lockfilePid=index,config add . 2>err &&
     ++		test_grep "process 99999" err
     ++	)
     ++'
     ++
     ++test_expect_success 'core.lockfilePid=none does not create PID file' '
     ++	git init repo9 &&
     ++	(
     ++		cd repo9 &&
     ++		echo content >file &&
     ++		git -c core.lockfilePid=none add file &&
     ++		# PID file should not be created when feature is disabled
     ++		test_path_is_missing .git/index.pid.lock
     ++	)
     ++'
     ++
     ++test_expect_success 'existing PID files are read even when feature disabled' '
     ++	git init repo10 &&
     ++	(
     ++		cd repo10 &&
     ++		touch .git/index.lock &&
     ++		printf "pid 99999" >.git/index.pid.lock &&
     ++		# Even with lockfilePid disabled, existing PID files are read
     ++		# to help diagnose stale locks
     ++		test_must_fail git add . 2>err &&
     ++		test_grep "process 99999" err
     ++	)
     ++'
     ++
     ++test_expect_success 'negative component syntax excludes specific components' '
     ++	git init repo11 &&
     ++	(
     ++		cd repo11 &&
     ++		echo content >file &&
     ++		# Enable all components except index
     ++		git -c core.lockfilePid=all,-index add file &&
     ++		# PID file should not be created for index when excluded
     ++		test_path_is_missing .git/index.pid.lock
      +	)
      +'
      +
      +test_done
     +
     + ## unix-stream-server.c ##
     +@@ unix-stream-server.c: int unix_ss_create(const char *path,
     + 	/*
     + 	 * Create a lock at "<path>.lock" if we can.
     + 	 */
     +-	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout_ms) < 0)
     ++	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout_ms,
     ++					      LOCKFILE_PID_OTHER) < 0)
     + 		return -1;
     + 
     + 	/*


 Documentation/config/core.adoc |  26 +++++
 apply.c                        |   6 +-
 builtin/commit.c               |   2 +-
 builtin/credential-store.c     |   3 +-
 builtin/difftool.c             |   3 +-
 builtin/fast-import.c          |   3 +-
 builtin/gc.c                   |  13 ++-
 builtin/sparse-checkout.c      |   3 +-
 bundle.c                       |   3 +-
 cache-tree.c                   |   3 +-
 commit-graph.c                 |   6 +-
 compat/mingw.c                 |  10 ++
 config.c                       |   6 +-
 environment.c                  |  80 +++++++++++++++
 lockfile.c                     | 182 +++++++++++++++++++++++++++++----
 lockfile.h                     |  77 ++++++++++----
 loose.c                        |   6 +-
 midx-write.c                   |   6 +-
 odb.c                          |   3 +-
 refs/files-backend.c           |   9 +-
 refs/packed-backend.c          |   3 +-
 reftable/system.c              |   2 +-
 repository.c                   |   3 +-
 rerere.c                       |   3 +-
 sequencer.c                    |  11 +-
 shallow.c                      |   6 +-
 t/meson.build                  |   1 +
 t/t0031-lockfile-pid.sh        | 139 +++++++++++++++++++++++++
 unix-stream-server.c           |   3 +-
 29 files changed, 546 insertions(+), 75 deletions(-)
 create mode 100755 t/t0031-lockfile-pid.sh

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 11efad189e..45597b9cea 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -348,6 +348,32 @@ confusion unless you know what you are doing (e.g. you are creating a
 read-only snapshot of the same index to a location different from the
 repository's usual working tree).
 
+core.lockfilePid::
+	A comma-separated list of components for which Git should create
+	a PID file alongside the lock file. When a lock acquisition fails
+	and a PID file exists, Git can provide additional diagnostic
+	information about the process holding the lock, including whether
+	it is still running.
++
+This feature is disabled by default. You can enable it for specific
+components or use `all` to enable for all components.
++
+* `none` disables PID file creation for all components.
+* `index` creates PID files for index lock operations.
+* `config` creates PID files for config file lock operations.
+* `refs` creates PID files for reference lock operations.
+* `commit-graph` creates PID files for commit-graph lock operations.
+* `midx` creates PID files for multi-pack-index lock operations.
+* `shallow` creates PID files for shallow file lock operations.
+* `gc` creates PID files for garbage collection lock operations.
+* `other` creates PID files for other miscellaneous lock operations.
+* `all` enables PID file creation for all components.
++
+The PID file is named by inserting `.pid` before the `.lock` suffix.
+For example, if the lock file is `index.lock`, the PID file will be
+`index.pid.lock`. The file contains `pid <value>` on a single line,
+following the same key-value format used by Git object headers.
+
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
 	"`$GIT_DIR/logs/<ref>`", by appending the new and old
diff --git a/apply.c b/apply.c
index a2ceb3fb40..95e3bafabd 100644
--- a/apply.c
+++ b/apply.c
@@ -4173,7 +4173,8 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 		}
 	}
 
-	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR,
+				  LOCKFILE_PID_OTHER);
 	res = write_locked_index(&result, &lock, COMMIT_LOCK);
 	discard_index(&result);
 
@@ -4830,7 +4831,8 @@ static int apply_patch(struct apply_state *state,
 		if (state->index_file)
 			hold_lock_file_for_update(&state->lock_file,
 						  state->index_file,
-						  LOCK_DIE_ON_ERROR);
+						  LOCK_DIE_ON_ERROR,
+						  LOCKFILE_PID_INDEX);
 		else
 			repo_hold_locked_index(state->repo, &state->lock_file,
 					       LOCK_DIE_ON_ERROR);
diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..30db6409a1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -540,7 +540,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	path = repo_git_path(the_repository, "next-index-%"PRIuMAX,
 			     (uintmax_t) getpid());
 	hold_lock_file_for_update(&false_lock, path,
-				  LOCK_DIE_ON_ERROR);
+				  LOCK_DIE_ON_ERROR, LOCKFILE_PID_OTHER);
 
 	create_base_index(current_head);
 	add_remove_files(&partial);
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index b74e06cc93..e1d1be5cd1 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -67,7 +67,8 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 	int timeout_ms = 1000;
 
 	repo_config_get_int(the_repository, "credentialstore.locktimeoutms", &timeout_ms);
-	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
+	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms,
+					      LOCKFILE_PID_CONFIG) < 0)
 		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
 	if (extra)
 		print_line(extra);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index e4bc1f8316..15d0af0031 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -636,7 +636,8 @@ static int run_dir_diff(struct repository *repo,
 			struct lock_file lock = LOCK_INIT;
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/wtindex", tmpdir.buf);
-			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
+			if (hold_lock_file_for_update(&lock, buf.buf, 0,
+					      LOCKFILE_PID_OTHER) < 0 ||
 			    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
 				ret = error("could not write %s", buf.buf);
 				goto finish;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 4cd0b079b6..9715f04d2d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1734,7 +1734,8 @@ static void dump_marks(void)
 		return;
 	}
 
-	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) {
+	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0,
+				      LOCKFILE_PID_OTHER) < 0) {
 		failure |= error_errno(_("unable to write marks file %s"),
 				       export_marks_file);
 		return;
diff --git a/builtin/gc.c b/builtin/gc.c
index e9a76243aa..6ba56d784d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -749,7 +749,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 
 	pidfile_path = repo_git_path(the_repository, "gc.pid");
 	fd = hold_lock_file_for_update(&lock, pidfile_path,
-				       LOCK_DIE_ON_ERROR);
+				       LOCK_DIE_ON_ERROR, LOCKFILE_PID_GC);
 	if (!force) {
 		static char locking_host[HOST_NAME_MAX + 1];
 		static char *scan_fmt;
@@ -1017,7 +1017,7 @@ int cmd_gc(int argc,
 	if (daemonized) {
 		char *path = repo_git_path(the_repository, "gc.log");
 		hold_lock_file_for_update(&log_lock, path,
-					  LOCK_DIE_ON_ERROR);
+					  LOCK_DIE_ON_ERROR, LOCKFILE_PID_GC);
 		dup2(get_lock_file_fd(&log_lock), 2);
 		atexit(process_log_file_at_exit);
 		free(path);
@@ -1797,7 +1797,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	struct repository *r = the_repository;
 	char *lock_path = xstrfmt("%s/maintenance", r->objects->sources->path);
 
-	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF,
+				      LOCKFILE_PID_GC) < 0) {
 		/*
 		 * Another maintenance command is running.
 		 *
@@ -2561,7 +2562,8 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 		lock_file_timeout_ms = 150;
 
 	fd = hold_lock_file_for_update_timeout(&lk, filename, LOCK_DIE_ON_ERROR,
-					       lock_file_timeout_ms);
+					       lock_file_timeout_ms,
+					       LOCKFILE_PID_GC);
 
 	/*
 	 * Does this file already exist? With the intended contents? Is it
@@ -3372,7 +3374,8 @@ static int update_background_schedule(const struct maintenance_start_opts *opts,
 	struct lock_file lk;
 	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->sources->path);
 
-	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF,
+				      LOCKFILE_PID_GC) < 0) {
 		if (errno == EEXIST)
 			error(_("unable to create '%s.lock': %s.\n\n"
 			    "Another scheduled git-maintenance(1) process seems to be running in this\n"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..566df7d229 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -341,7 +341,8 @@ static int write_patterns_and_update(struct repository *repo,
 	if (safe_create_leading_directories(repo, sparse_filename))
 		die(_("failed to create directory for sparse-checkout file"));
 
-	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR,
+				  LOCKFILE_PID_OTHER);
 
 	result = update_working_directory(repo, pl);
 	if (result) {
diff --git a/bundle.c b/bundle.c
index 42327f9739..25728278fc 100644
--- a/bundle.c
+++ b/bundle.c
@@ -520,7 +520,8 @@ int create_bundle(struct repository *r, const char *path,
 		bundle_fd = 1;
 	else
 		bundle_fd = hold_lock_file_for_update(&lock, path,
-						      LOCK_DIE_ON_ERROR);
+						      LOCK_DIE_ON_ERROR,
+						      LOCKFILE_PID_OTHER);
 
 	if (version == -1)
 		version = min_version;
diff --git a/cache-tree.c b/cache-tree.c
index 2aba47060e..b370fa94d0 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -730,7 +730,8 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 	struct lock_file lock_file = LOCK_INIT;
 	int ret;
 
-	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR,
+				  LOCKFILE_PID_INDEX);
 
 	entries = read_index_from(index_state, index_path,
 				  repo_get_git_dir(the_repository));
diff --git a/commit-graph.c b/commit-graph.c
index 80be2ff2c3..b18249fb73 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2075,7 +2075,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		char *lock_name = get_commit_graph_chain_filename(ctx->odb_source);
 
 		hold_lock_file_for_update_mode(&lk, lock_name,
-					       LOCK_DIE_ON_ERROR, 0444);
+					       LOCK_DIE_ON_ERROR, 0444,
+					       LOCKFILE_PID_COMMIT_GRAPH);
 		free(lock_name);
 
 		graph_layer = mks_tempfile_m(ctx->graph_name, 0444);
@@ -2094,7 +2095,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			   get_tempfile_fd(graph_layer), get_tempfile_path(graph_layer));
 	} else {
 		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
-					       LOCK_DIE_ON_ERROR, 0444);
+					       LOCK_DIE_ON_ERROR, 0444,
+					       LOCKFILE_PID_COMMIT_GRAPH);
 		f = hashfd(ctx->r->hash_algo,
 			   get_lock_file_fd(&lk), get_lock_file_path(&lk));
 	}
diff --git a/compat/mingw.c b/compat/mingw.c
index 736a07a028..cbd102fa0e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1982,6 +1982,16 @@ int mingw_kill(pid_t pid, int sig)
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
diff --git a/config.c b/config.c
index f1def0dcfb..ac35427523 100644
--- a/config.c
+++ b/config.c
@@ -2985,7 +2985,8 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	fd = hold_lock_file_for_update(&lock, config_filename, 0);
+	fd = hold_lock_file_for_update(&lock, config_filename, 0,
+				       LOCKFILE_PID_CONFIG);
 	if (fd < 0) {
 		error_errno(_("could not lock config file %s"), config_filename);
 		ret = CONFIG_NO_LOCK;
@@ -3330,7 +3331,8 @@ static int repo_config_copy_or_rename_section_in_file(
 	if (!config_filename)
 		config_filename = filename_buf = repo_git_path(r, "config");
 
-	out_fd = hold_lock_file_for_update(&lock, config_filename, 0);
+	out_fd = hold_lock_file_for_update(&lock, config_filename, 0,
+					   LOCKFILE_PID_CONFIG);
 	if (out_fd < 0) {
 		ret = error(_("could not lock config file %s"), config_filename);
 		goto out;
diff --git a/environment.c b/environment.c
index a770b5921d..0d1dfb525b 100644
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
@@ -324,6 +325,78 @@ next_name:
 	return (current & ~negative) | positive;
 }
 
+static const struct lockfile_pid_component_name {
+	const char *name;
+	enum lockfile_pid_component component_bits;
+} lockfile_pid_component_names[] = {
+	{ "index", LOCKFILE_PID_INDEX },
+	{ "config", LOCKFILE_PID_CONFIG },
+	{ "refs", LOCKFILE_PID_REFS },
+	{ "commit-graph", LOCKFILE_PID_COMMIT_GRAPH },
+	{ "midx", LOCKFILE_PID_MIDX },
+	{ "shallow", LOCKFILE_PID_SHALLOW },
+	{ "gc", LOCKFILE_PID_GC },
+	{ "other", LOCKFILE_PID_OTHER },
+	{ "all", LOCKFILE_PID_ALL },
+};
+
+static enum lockfile_pid_component parse_lockfile_pid_components(const char *var,
+								 const char *string)
+{
+	enum lockfile_pid_component current = LOCKFILE_PID_DEFAULT;
+	enum lockfile_pid_component positive = 0, negative = 0;
+
+	while (string) {
+		size_t len;
+		const char *ep;
+		int negated = 0;
+		int found = 0;
+
+		string = string + strspn(string, ", \t\n\r");
+		ep = strchrnul(string, ',');
+		len = ep - string;
+		if (len == 4 && !strncmp(string, "none", 4)) {
+			current = LOCKFILE_PID_NONE;
+			goto next_name;
+		}
+
+		if (*string == '-') {
+			negated = 1;
+			string++;
+			len--;
+			if (!len)
+				warning(_("invalid value for variable %s"), var);
+		}
+
+		if (!len)
+			break;
+
+		for (size_t i = 0; i < ARRAY_SIZE(lockfile_pid_component_names); ++i) {
+			const struct lockfile_pid_component_name *n = &lockfile_pid_component_names[i];
+
+			if (strncmp(n->name, string, len) || strlen(n->name) != len)
+				continue;
+
+			found = 1;
+			if (negated)
+				negative |= n->component_bits;
+			else
+				positive |= n->component_bits;
+		}
+
+		if (!found) {
+			char *component = xstrndup(string, len);
+			warning(_("ignoring unknown core.lockfilePid component '%s'"), component);
+			free(component);
+		}
+
+next_name:
+		string = ep;
+	}
+
+	return (current & ~negative) | positive;
+}
+
 static int git_default_core_config(const char *var, const char *value,
 				   const struct config_context *ctx, void *cb)
 {
@@ -532,6 +605,13 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "core.lockfilepid")) {
+		if (!value)
+			return config_error_nonbool(var);
+		lockfile_pid_components = parse_lockfile_pid_components(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.createobject")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/lockfile.c b/lockfile.c
index 1d5ed01682..4ee215374a 100644
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
@@ -71,19 +74,117 @@ static void resolve_symlink(struct strbuf *path)
 	strbuf_reset(&link);
 }
 
+/*
+ * Lock PID file functions - write PID to a foo-pid.lock file alongside
+ * the lock file for debugging stale locks. The PID file is registered
+ * as a tempfile so it gets cleaned up by signal/atexit handlers.
+ *
+ * Naming: For "foo.lock", the PID file is "foo-pid.lock" (not "foo.lock.pid").
+ * This avoids collision with the refs namespace.
+ */
+
+/* Global config variable, initialized from core.lockfilePid */
+enum lockfile_pid_component lockfile_pid_components = LOCKFILE_PID_DEFAULT;
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
+static struct tempfile *create_lock_pid_file(const char *pid_path, int mode,
+					     enum lockfile_pid_component component)
+{
+	struct strbuf content = STRBUF_INIT;
+	struct tempfile *pid_tempfile = NULL;
+	int fd = -1;
+
+	if (!(lockfile_pid_components & component))
+		goto out;
+
+	fd = open(pid_path, O_WRONLY | O_CREAT | O_EXCL, mode);
+	if (fd < 0)
+		goto out;
+
+	strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
+	if (write_in_full(fd, content.buf, content.len) < 0) {
+		warning_errno(_("could not write lock pid file '%s'"), pid_path);
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
-		     int mode)
+		     int mode, enum lockfile_pid_component component)
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
+		lk->pid_tempfile = create_lock_pid_file(pid_path.buf, mode,
+							component);
 
-	strbuf_addstr(&filename, LOCK_SUFFIX);
-	lk->tempfile = create_tempfile_mode(filename.buf, mode);
-	strbuf_release(&filename);
+	strbuf_release(&base_path);
+	strbuf_release(&lock_path);
+	strbuf_release(&pid_path);
 	return lk->tempfile ? lk->tempfile->fd : -1;
 }
 
@@ -102,7 +203,8 @@ static int lock_file(struct lock_file *lk, const char *path, int flags,
  * exactly once. If timeout_ms is -1, try indefinitely.
  */
 static int lock_file_timeout(struct lock_file *lk, const char *path,
-			     int flags, long timeout_ms, int mode)
+			     int flags, long timeout_ms, int mode,
+			     enum lockfile_pid_component component)
 {
 	int n = 1;
 	int multiplier = 1;
@@ -110,7 +212,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 	static int random_initialized = 0;
 
 	if (timeout_ms == 0)
-		return lock_file(lk, path, flags, mode);
+		return lock_file(lk, path, flags, mode, component);
 
 	if (!random_initialized) {
 		srand((unsigned int)getpid());
@@ -124,7 +226,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 		long backoff_ms, wait_ms;
 		int fd;
 
-		fd = lock_file(lk, path, flags, mode);
+		fd = lock_file(lk, path, flags, mode, component);
 
 		if (fd >= 0)
 			return fd; /* success */
@@ -151,16 +253,47 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
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
+		 * core.lockfilePid was enabled for this component.
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
@@ -174,9 +307,10 @@ NORETURN void unable_to_lock_die(const char *path, int err)
 /* This should return a meaningful errno on failure */
 int hold_lock_file_for_update_timeout_mode(struct lock_file *lk,
 					   const char *path, int flags,
-					   long timeout_ms, int mode)
+					   long timeout_ms, int mode,
+					   enum lockfile_pid_component component)
 {
-	int fd = lock_file_timeout(lk, path, flags, timeout_ms, mode);
+	int fd = lock_file_timeout(lk, path, flags, timeout_ms, mode, component);
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			unable_to_lock_die(path, errno);
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
index 1bb9926497..7e472cb5af 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -119,6 +119,7 @@
 
 struct lock_file {
 	struct tempfile *tempfile;
+	struct tempfile *pid_tempfile;
 };
 
 #define LOCK_INIT { 0 }
@@ -127,6 +128,42 @@ struct lock_file {
 #define LOCK_SUFFIX ".lock"
 #define LOCK_SUFFIX_LEN 5
 
+/*
+ * PID file naming: for a lock file "foo.lock", the PID file is "foo.pid.lock".
+ */
+#define LOCK_PID_INFIX ".pid"
+#define LOCK_PID_INFIX_LEN 4
+
+/* Maximum length for PID file content */
+#define LOCK_PID_MAXLEN 32
+
+/*
+ * Per-component lock PID file configuration, following core.fsync pattern.
+ * Each component can be individually enabled via core.lockfilePid config.
+ */
+enum lockfile_pid_component {
+	LOCKFILE_PID_NONE = 0,
+	LOCKFILE_PID_INDEX = 1 << 0, /* .git/index.lock */
+	LOCKFILE_PID_CONFIG = 1 << 1, /* .git/config.lock */
+	LOCKFILE_PID_REFS = 1 << 2, /* refs locks */
+	LOCKFILE_PID_COMMIT_GRAPH = 1 << 3, /* commit-graph.lock */
+	LOCKFILE_PID_MIDX = 1 << 4, /* multi-pack-index.lock */
+	LOCKFILE_PID_SHALLOW = 1 << 5, /* shallow file */
+	LOCKFILE_PID_GC = 1 << 6, /* gc locks */
+	LOCKFILE_PID_OTHER = 1 << 7, /* other locks */
+};
+
+#define LOCKFILE_PID_ALL (LOCKFILE_PID_INDEX | LOCKFILE_PID_CONFIG |      \
+			  LOCKFILE_PID_REFS | LOCKFILE_PID_COMMIT_GRAPH | \
+			  LOCKFILE_PID_MIDX | LOCKFILE_PID_SHALLOW |      \
+			  LOCKFILE_PID_GC | LOCKFILE_PID_OTHER)
+#define LOCKFILE_PID_DEFAULT LOCKFILE_PID_NONE
+
+/*
+ * Bitmask indicating which components should create PID files.
+ * Configured via core.lockfilePid.
+ */
+extern enum lockfile_pid_component lockfile_pid_components;
 
 /*
  * Flags
@@ -167,17 +204,23 @@ struct lock_file {
  * timeout_ms milliseconds. If timeout_ms is 0, try exactly once; if
  * timeout_ms is -1, retry indefinitely. The flags argument, error
  * handling, and mode are described above.
+ *
+ * The `component` argument specifies which lock PID component this lock
+ * belongs to, for selective PID file creation via core.lockfilePid config.
  */
 int hold_lock_file_for_update_timeout_mode(
-		struct lock_file *lk, const char *path,
-		int flags, long timeout_ms, int mode);
+	struct lock_file *lk, const char *path,
+	int flags, long timeout_ms, int mode,
+	enum lockfile_pid_component component);
 
 static inline int hold_lock_file_for_update_timeout(
-		struct lock_file *lk, const char *path,
-		int flags, long timeout_ms)
+	struct lock_file *lk, const char *path,
+	int flags, long timeout_ms,
+	enum lockfile_pid_component component)
 {
 	return hold_lock_file_for_update_timeout_mode(lk, path, flags,
-						      timeout_ms, 0666);
+						      timeout_ms, 0666,
+						      component);
 }
 
 /*
@@ -186,17 +229,18 @@ static inline int hold_lock_file_for_update_timeout(
  * argument and error handling are described above.
  */
 static inline int hold_lock_file_for_update(
-		struct lock_file *lk, const char *path,
-		int flags)
+	struct lock_file *lk, const char *path,
+	int flags, enum lockfile_pid_component component)
 {
-	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
+	return hold_lock_file_for_update_timeout(lk, path, flags, 0, component);
 }
 
 static inline int hold_lock_file_for_update_mode(
-		struct lock_file *lk, const char *path,
-		int flags, int mode)
+	struct lock_file *lk, const char *path,
+	int flags, int mode, enum lockfile_pid_component component)
 {
-	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode);
+	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode,
+						      component);
 }
 
 /*
@@ -319,13 +363,10 @@ static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
 
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
diff --git a/loose.c b/loose.c
index 56cf64b648..c0d2f0416f 100644
--- a/loose.c
+++ b/loose.c
@@ -135,7 +135,8 @@ int repo_write_loose_object_map(struct repository *repo)
 		return 0;
 
 	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
-	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
+	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1,
+					       LOCKFILE_PID_OTHER);
 	iter = kh_begin(map);
 	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
 		goto errout;
@@ -177,7 +178,8 @@ static int write_one_object(struct odb_source *source,
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 
 	strbuf_addf(&path, "%s/loose-object-idx", source->path);
-	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
+	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1,
+					  LOCKFILE_PID_OTHER);
 
 	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
 	if (fd < 0)
diff --git a/midx-write.c b/midx-write.c
index 23e61cb000..6196dcd7cd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1309,7 +1309,8 @@ static int write_midx_internal(struct odb_source *source,
 		struct strbuf lock_name = STRBUF_INIT;
 
 		get_midx_chain_filename(source, &lock_name);
-		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
+		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR,
+					  LOCKFILE_PID_MIDX);
 		strbuf_release(&lock_name);
 
 		incr = mks_tempfile_m(midx_name.buf, 0444);
@@ -1327,7 +1328,8 @@ static int write_midx_internal(struct odb_source *source,
 		f = hashfd(r->hash_algo, get_tempfile_fd(incr),
 			   get_tempfile_path(incr));
 	} else {
-		hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR);
+		hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR,
+					  LOCKFILE_PID_MIDX);
 		f = hashfd(r->hash_algo, get_lock_file_fd(&lk),
 			   get_lock_file_path(&lk));
 	}
diff --git a/odb.c b/odb.c
index 3ec21ef24e..570cea3029 100644
--- a/odb.c
+++ b/odb.c
@@ -292,7 +292,8 @@ void odb_add_to_alternates_file(struct object_database *odb,
 	FILE *in, *out;
 	int found = 0;
 
-	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR,
+				  LOCKFILE_PID_OTHER);
 	out = fdopen_lock_file(&lock, "w");
 	if (!out)
 		die_errno(_("unable to fdopen alternates lockfile"));
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6f6f76a8d8..e296154fe7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -790,7 +790,8 @@ retry:
 
 	if (hold_lock_file_for_update_timeout(
 			    &lock->lk, ref_file.buf, LOCK_NO_DEREF,
-			    get_files_ref_lock_timeout_ms()) < 0) {
+			    get_files_ref_lock_timeout_ms(),
+			    LOCKFILE_PID_REFS) < 0) {
 		int myerr = errno;
 		errno = 0;
 		if (myerr == ENOENT && --attempts_remaining > 0) {
@@ -1194,7 +1195,8 @@ static int create_reflock(const char *path, void *cb)
 
 	return hold_lock_file_for_update_timeout(
 			lk, path, LOCK_NO_DEREF,
-			get_files_ref_lock_timeout_ms()) < 0 ? -1 : 0;
+			get_files_ref_lock_timeout_ms(),
+			LOCKFILE_PID_REFS) < 0 ? -1 : 0;
 }
 
 /*
@@ -3536,7 +3538,8 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		 * work we need, including cleaning up if the program
 		 * exits unexpectedly.
 		 */
-		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
+		if (hold_lock_file_for_update(&reflog_lock, log_file, 0,
+					      LOCKFILE_PID_REFS) < 0) {
 			struct strbuf err = STRBUF_INIT;
 			unable_to_lock_message(log_file, errno, &err);
 			error("%s", err.buf);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4ea0c12299..f832c49eae 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1230,7 +1230,8 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	if (hold_lock_file_for_update_timeout(
 			    &refs->lock,
 			    refs->path,
-			    flags, timeout_value) < 0) {
+			    flags, timeout_value,
+			    LOCKFILE_PID_REFS) < 0) {
 		unable_to_lock_message(refs->path, errno, err);
 		return -1;
 	}
diff --git a/reftable/system.c b/reftable/system.c
index 725a25844e..5462111a04 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -67,7 +67,7 @@ int flock_acquire(struct reftable_flock *l, const char *target_path,
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
 	err = hold_lock_file_for_update_timeout(lockfile, target_path, LOCK_NO_DEREF,
-						timeout_ms);
+						timeout_ms, LOCKFILE_PID_REFS);
 	if (err < 0) {
 		reftable_free(lockfile);
 		if (errno == EEXIST)
diff --git a/repository.c b/repository.c
index 6aaa7ba008..30dde7076b 100644
--- a/repository.c
+++ b/repository.c
@@ -460,5 +460,6 @@ int repo_hold_locked_index(struct repository *repo,
 {
 	if (!repo->index_file)
 		BUG("the repo hasn't been setup");
-	return hold_lock_file_for_update(lf, repo->index_file, flags);
+	return hold_lock_file_for_update(lf, repo->index_file, flags,
+					 LOCKFILE_PID_INDEX);
 }
diff --git a/rerere.c b/rerere.c
index 6ec55964e2..71f1d5b176 100644
--- a/rerere.c
+++ b/rerere.c
@@ -917,7 +917,8 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 	else
 		fd = hold_lock_file_for_update(&write_lock,
 					       git_path_merge_rr(r),
-					       LOCK_DIE_ON_ERROR);
+					       LOCK_DIE_ON_ERROR,
+					       LOCKFILE_PID_OTHER);
 	read_rr(r, merge_rr);
 	return fd;
 }
diff --git a/sequencer.c b/sequencer.c
index 5476d39ba9..337f82e02c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -566,7 +566,8 @@ static int write_message(const void *buf, size_t len, const char *filename,
 {
 	struct lock_file msg_file = LOCK_INIT;
 
-	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
+	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0,
+					       LOCKFILE_PID_OTHER);
 	if (msg_fd < 0)
 		return error_errno(_("could not lock '%s'"), filename);
 	if (write_in_full(msg_fd, buf, len) < 0) {
@@ -3605,7 +3606,8 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts,
 	if (is_rebase_i(opts) && !reschedule)
 		next++;
 
-	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
+	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0,
+				       LOCKFILE_PID_OTHER);
 	if (fd < 0)
 		return error_errno(_("could not lock '%s'"), todo_path);
 	offset = get_item_line_offset(todo_list, next);
@@ -3877,7 +3879,8 @@ static int safe_append(const char *filename, const char *fmt, ...)
 	va_list ap;
 	struct lock_file lock = LOCK_INIT;
 	int fd = hold_lock_file_for_update(&lock, filename,
-					   LOCK_REPORT_ON_ERROR);
+					   LOCK_REPORT_ON_ERROR,
+					   LOCKFILE_PID_OTHER);
 	struct strbuf buf = STRBUF_INIT;
 
 	if (fd < 0)
@@ -4400,7 +4403,7 @@ static int write_update_refs_state(struct string_list *refs_to_oids)
 		goto cleanup;
 	}
 
-	if (hold_lock_file_for_update(&lock, path, 0) < 0) {
+	if (hold_lock_file_for_update(&lock, path, 0, LOCKFILE_PID_OTHER) < 0) {
 		result = error(_("another 'rebase' process appears to be running; "
 				 "'%s.lock' already exists"),
 			       path);
diff --git a/shallow.c b/shallow.c
index 55b9cd9d3f..412c37c96a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -392,7 +392,8 @@ void setup_alternate_shallow(struct shallow_lock *shallow_lock,
 
 	fd = hold_lock_file_for_update(&shallow_lock->lock,
 				       git_path_shallow(the_repository),
-				       LOCK_DIE_ON_ERROR);
+				       LOCK_DIE_ON_ERROR,
+				       LOCKFILE_PID_SHALLOW);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
@@ -447,7 +448,8 @@ void prune_shallow(unsigned options)
 	}
 	fd = hold_lock_file_for_update(&shallow_lock.lock,
 				       git_path_shallow(the_repository),
-				       LOCK_DIE_ON_ERROR);
+				       LOCK_DIE_ON_ERROR,
+				       LOCKFILE_PID_SHALLOW);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
diff --git a/t/meson.build b/t/meson.build
index dc43d69636..9a880db57c 100644
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
index 0000000000..d99f738cb3
--- /dev/null
+++ b/t/t0031-lockfile-pid.sh
@@ -0,0 +1,139 @@
+#!/bin/sh
+
+test_description='lock file PID info tests
+
+Tests for PID info file alongside lock files.
+The feature is opt-in via core.lockfilePid config setting.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'stale lock detected when PID is not running' '
+	git init repo &&
+	(
+		cd repo &&
+		touch .git/index.lock &&
+		printf "pid 99999" >.git/index.pid.lock &&
+		test_must_fail git -c core.lockfilePid=index add . 2>err &&
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
+		printf "pid 99999" >.git/index.pid.lock &&
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
+		printf "pid %d" "$shell_pid" >.git/index.pid.lock &&
+		# Verify our PID is shown in the error message
+		test_must_fail git -c core.lockfilePid=index add file 2>err &&
+		test_grep "held by process $shell_pid" err
+	)
+'
+
+test_expect_success 'PID info file cleaned up on successful operation when enabled' '
+	git init repo4 &&
+	(
+		cd repo4 &&
+		echo content >file &&
+		git -c core.lockfilePid=index add file &&
+		# After successful add, no lock or PID files should exist
+		test_path_is_missing .git/index.lock &&
+		test_path_is_missing .git/index.pid.lock
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
+		test_path_is_missing .git/index.pid.lock
+	)
+'
+
+test_expect_success 'core.lockfilePid=all enables for all components' '
+	git init repo6 &&
+	(
+		cd repo6 &&
+		touch .git/index.lock &&
+		printf "pid 99999" >.git/index.pid.lock &&
+		test_must_fail git -c core.lockfilePid=all add . 2>err &&
+		test_grep "process 99999" err
+	)
+'
+
+test_expect_success 'multiple components can be specified' '
+	git init repo8 &&
+	(
+		cd repo8 &&
+		touch .git/index.lock &&
+		printf "pid 99999" >.git/index.pid.lock &&
+		test_must_fail git -c core.lockfilePid=index,config add . 2>err &&
+		test_grep "process 99999" err
+	)
+'
+
+test_expect_success 'core.lockfilePid=none does not create PID file' '
+	git init repo9 &&
+	(
+		cd repo9 &&
+		echo content >file &&
+		git -c core.lockfilePid=none add file &&
+		# PID file should not be created when feature is disabled
+		test_path_is_missing .git/index.pid.lock
+	)
+'
+
+test_expect_success 'existing PID files are read even when feature disabled' '
+	git init repo10 &&
+	(
+		cd repo10 &&
+		touch .git/index.lock &&
+		printf "pid 99999" >.git/index.pid.lock &&
+		# Even with lockfilePid disabled, existing PID files are read
+		# to help diagnose stale locks
+		test_must_fail git add . 2>err &&
+		test_grep "process 99999" err
+	)
+'
+
+test_expect_success 'negative component syntax excludes specific components' '
+	git init repo11 &&
+	(
+		cd repo11 &&
+		echo content >file &&
+		# Enable all components except index
+		git -c core.lockfilePid=all,-index add file &&
+		# PID file should not be created for index when excluded
+		test_path_is_missing .git/index.pid.lock
+	)
+'
+
+test_done
diff --git a/unix-stream-server.c b/unix-stream-server.c
index 22ac2373e0..d8c79cd569 100644
--- a/unix-stream-server.c
+++ b/unix-stream-server.c
@@ -47,7 +47,8 @@ int unix_ss_create(const char *path,
 	/*
 	 * Create a lock at "<path>.lock" if we can.
 	 */
-	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout_ms) < 0)
+	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout_ms,
+					      LOCKFILE_PID_OTHER) < 0)
 		return -1;
 
 	/*

base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
-- 
gitgitgadget
