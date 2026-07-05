Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A22233938
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239875; cv=none; b=rHD176VTnhJKLfWbVPk+DIlKGpwTT/3aIuCtoPTMCF0mk++eia6jLh+CH1ijEL8KrzGT+SULwTJoD1YVii0ae+AS9QuYnyd5wQcnrWTW7lyq4faXZJTsxFkD61Gxq+VxzK004JGvRhjCZrXD1nBE4Axg1Yplex29ZRDtAPQeMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239875; c=relaxed/simple;
	bh=WKpehUsML/6MRMRKq5fxXnosUDe2dp/2aMc8q/VhYT4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YdxiiBJXCnmpEGsL30Tu7gN8WfKZJ++/9g4IOZKeYnJExzhmgyUDaKRFEp4lk+IKA7H4d1kpY8lSnEYbeRPoJDQyFt+dYasY/w1i3xpnwNXYDPUP/Z5CggXaXPjsC7AygoOrMUv0qT2+ikcbPFVnJJ5hzhL78nyrxr3IKqz5nB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA8/CZJa; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA8/CZJa"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f0079614b2so22194516d6.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239873; x=1783844673; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W3aO2VIGc2239nX7/thJcMhxmbtIe88AWB/aAFViWM=;
        b=kA8/CZJawrpLtQHRK4IQF3r1oGqhdE2ONkRGUEANjNCDibVlW7jzk/WmVeUBvAmRPt
         f3+jRgdNSjW2Kks8SG6ZQnd0wb7lDl3U+J0AlqoGMq9vrpHxa9REcDBUrRHLyS1Qb2/r
         wec4cxH0Eld46P8Btv1iEAe8ml6lotDcGuWQy+4Z4BQn/+SP5fjxz1T/znDMhiq+1Hnt
         DGtgSOBH18xI+3DttaLieaMkESNojjCcXfuTg2FFiL1eJ7X5aWgHALhldwbIKmDyAckx
         FPUw41Ht4dLVlAgBkEUZ7da6n6FWLoAGQeVLlQzQaFwn+oXjOMQ801mRZkQRg/i8r5TR
         bctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239873; x=1783844673;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/W3aO2VIGc2239nX7/thJcMhxmbtIe88AWB/aAFViWM=;
        b=T8V+x95orzoLlC19IavkscV65nk37ywoJS8oWLwCzkVZKBLQNBXJmMnG+Dx2naNUAt
         A7vVJm/cOJSJHMpXLOTkombcpJXFTAn9vFXi1EDnUr7qCQr8fBF1rcutBNgQnN36U/ES
         9YoDcXiR8dfBhK4sXTNInIGWbgE+YcpAcRmtWA9iN0cecTfsrz1aeyBA+hTCnPI7jCX7
         wvq/uxk+I1Ro3ltU0Si0F3cx+V4txovgPoOg5hVLz6e2LzvnJlHcpo7wk+wVOAZAx1N9
         VEkh8i6yO/r3DVbGD2sqpELr4JDgGZ1hnBI8Dg2dLUJhSBPOXEAPsjHU8/hqHtnbVkgH
         Cwhw==
X-Gm-Message-State: AOJu0YwGXtttE6kFKs/1K46RehUFsU7Lk36qaJTDRaEssmRqrG57Mxcq
	7lZ/FEApdwRsyhDM3gybI/tGpHMSmaVf81z1alACNpDwMGo3wbfc/qo5NNf/1w==
X-Gm-Gg: AfdE7ckmznssSIZ7NjVLg4KbhFVJNtpbM87EnDAJwsfbHEU5pl0slFx4zJeTBI9OqZa
	SExrpZcNEITSJVe6prztsPs+kyFkV1yhaPrXfPEP7wJ81irvdHD6fJA+x3Fx6tnHphClezGTjAF
	Yvy1G83FCCvIprIPXcCLRz7vhM5+abCbFvW725LkT9E+krLng8jYLayBpOfkx4N19F4UDTaD3A+
	fPiN40H6VYK53gx3H9x2tqREASeHH1+UhtwKO9yYyznnIMkip2tCdAWGnLgXsAnsOtoQx7410YO
	dDaEobbV8nTqvpjAAcJec8spWP0BFB6VVOZz7w1lwieG5QTfdb5kcb6ZlglRM4t8SLXSoXOLaNm
	1HOzBbBPn/HCxoKYdnzvqlCkaCplxYtegnTG0WkSYmjTnido7UKQuz8X1ozwphWqPY48b2mU3Pd
	i0aJ+8Cxrd3JsovWIwAQ==
X-Received: by 2002:ad4:5d65:0:b0:8e9:f5de:d631 with SMTP id 6a1803df08f44-8f74d6a94afmr86077976d6.50.1783239872626;
        Sun, 05 Jul 2026 01:24:32 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f30b94fsm102067796d6.21.2026.07.05.01.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:31 -0700 (PDT)
Message-Id: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:17 +0000
Subject: [PATCH v2 00/12] coverity: fix leaks and error paths
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

I wanted to whittle down the many issues reported by Coverity in the Git for
Windows project. Turns out: The vast majority of the issues are false
positives. Most of the remaining issues are in core Git proper.

This effort was forced on pause while Coverity was down from May 16
[https://web.archive.org/web/20260516152422/https://scan.coverity.com/] to
June 22
[https://web.archive.org/web/20260622182153/https://scan.coverity.com/]).

Here is a first batch of fixes for those issues.

Changes since v1:

 * Edited the commit messages to put function names in backticks, and
   reflowed the messages afterwards.
 * Took Junio's suggestion to avoid (ab-)using errno to determine the return
   value of load_one_loose_object_map().
 * Dropped the obsolete patch "run_diff_files: avoid memory leak".
 * Rewrote the commit message of "dir: free allocations on parse-error paths
   in read_one_dir()" to clarify ownership of the allocated untracked/dirs
   buffers.
 * Changed "submodule: fix cwd leak in get_superproject_working_tree()" to
   reduce the cognitive load on the reader (i.e. to make it a lot easier to
   reason about the correctness of the patch).

Johannes Schindelin (12):
  load_one_loose_object_map(): fix resource leak
  loose: avoid closing invalid fd on error path
  download_https_uri_to_file(): do not leak fd upon failure
  run-command: avoid `close(-1)` in `start_command()` error paths
  line-log: avoid redundant copy that leaks in process_ranges
  dir: free allocations on parse-error paths in `read_one_dir()`
  submodule: fix cwd leak in `get_superproject_working_tree()`
  worktree: fix resource leaks when branch creation fails
  imap-send: avoid leaking the IMAP upload buffer
  reftable/table: release filter on error path
  fsmonitor: plug token-data leak on early daemon-startup failures
  mingw: make `exit_process()` own the process handle on all paths

 builtin/fsmonitor--daemon.c |  2 ++
 builtin/worktree.c          |  7 +++++--
 bundle-uri.c                |  2 +-
 compat/mingw.c              |  4 +---
 compat/win32/exit-process.h |  1 +
 dir.c                       |  9 +++++++--
 imap-send.c                 |  1 +
 line-log.c                  |  3 +--
 loose.c                     | 12 ++++++------
 reftable/table.c            |  4 ++++
 run-command.c               |  6 +++---
 submodule.c                 | 19 ++++++++++---------
 12 files changed, 42 insertions(+), 28 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2163%2Fdscho%2Fcoverity-fixes-leaks-and-error-paths-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2163/dscho/coverity-fixes-leaks-and-error-paths-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2163

Range-diff vs v1:

  1:  17242c249f !  1:  80ae35227d load_one_loose_object_map(): fix resource leak
     @@ loose.c: static int load_one_loose_object_map(struct repository *repo, struct od
       
       	if (!loose->map)
       		loose_object_map_init(&loose->map);
     +@@ loose.c: static int load_one_loose_object_map(struct repository *repo, struct odb_source_
     + 		return 0;
     + 	}
     + 
     +-	errno = 0;
     + 	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header))
     + 		goto err;
     + 	while (!strbuf_getline_lf(&buf, fp)) {
      @@ loose.c: static int load_one_loose_object_map(struct repository *repo, struct odb_source_
       		insert_loose_map(loose, &oid, &compat_oid);
       	}
     @@ loose.c: static int load_one_loose_object_map(struct repository *repo, struct od
      -	strbuf_release(&buf);
      -	strbuf_release(&path);
      -	return errno ? -1 : 0;
     -+	ret = 0;
     ++	ret = ferror(fp) ? -1 : 0;
       err:
      +	fclose(fp);
       	strbuf_release(&buf);
  2:  a1cd229e33 !  2:  546a7c5d9f loose: avoid closing invalid fd on error path
     @@ Metadata
       ## Commit message ##
          loose: avoid closing invalid fd on error path
      
     -    write_one_object() opens a file at line 186 and jumps to the
     -    errout label on failure. The errout cleanup unconditionally calls
     -    close(fd), but when open() itself failed, fd is -1. Calling
     -    close(-1) is harmless on most platforms (returns EBADF) but is
     -    undefined behavior per POSIX and can confuse fd tracking in
     -    sanitizer builds.
     +    `write_one_object()` opens a file at line 186 and jumps to the errout
     +    label on failure. The errout cleanup unconditionally calls `close(fd)`,
     +    but when `open()` itself failed, fd is -1. Calling `close(-1)` is
     +    harmless on most platforms (returns EBADF) but is undefined behavior per
     +    POSIX and can confuse fd tracking in sanitizer builds.
      
          Guard the close with fd >= 0.
      
  3:  a770d9708d =  3:  17c3b4ce4f download_https_uri_to_file(): do not leak fd upon failure
  4:  d7bcdda312 !  4:  0360016d91 run-command: avoid close(-1) in start_command() error paths
     @@ Metadata
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Commit message ##
     -    run-command: avoid close(-1) in start_command() error paths
     +    run-command: avoid `close(-1)` in `start_command()` error paths
      
     -    When start_command() fails to set up a pipe partway through, it
     -    rolls back by closing the pipe ends it has already opened. For
     -    descriptors supplied by the caller rather than allocated locally,
     -    that rollback tested `if (cmd->in)` / `if (cmd->out)` before calling
     -    close(). The CHILD_PROCESS_INIT default of -1 ("no descriptor") is
     -    non-zero and so passes the test, meaning a caller that sets
     -    cmd->no_stdin or cmd->no_stdout without supplying a real fd ends up
     -    triggering close(-1) on the error path.
     +    When `start_command()` fails to set up a pipe partway through, it rolls
     +    back by closing the pipe ends it has already opened. For descriptors
     +    supplied by the caller rather than allocated locally, that rollback
     +    tested `if (cmd->in)` / `if (cmd->out)` before calling close(). The
     +    CHILD_PROCESS_INIT default of -1 ("no descriptor") is non-zero and so
     +    passes the test, meaning a caller that sets cmd->no_stdin or
     +    cmd->no_stdout without supplying a real fd ends up triggering close(-1)
     +    on the error path.
      
     -    The stdin-pipe failure branch a few lines above already uses the
     -    right idiom, `if (cmd->out > 0)`, which rejects both the -1 sentinel
     -    and 0 (the parent's own standard streams). Apply it to the three
     -    remaining rollback sites.
     +    The stdin-pipe failure branch a few lines above already uses the right
     +    idiom, `if (cmd->out > 0)`, which rejects both the -1 sentinel and 0
     +    (the parent's own standard streams). Apply it to the three remaining
     +    rollback sites.
      
          Reported by Coverity as CID 1049722 ("Argument cannot be negative").
      
  5:  860bc8f52d <  -:  ---------- run_diff_files: avoid memory leak
  6:  5a6b17f075 !  5:  8c623cc28f line-log: avoid redundant copy that leaks in process_ranges
     @@ Metadata
       ## Commit message ##
          line-log: avoid redundant copy that leaks in process_ranges
      
     -    When bloom_filter_check() indicates that a commit does not touch
     -    any of the tracked paths, line_log_process_ranges_arbitrary_commit()
     +    When `bloom_filter_check()` indicates that a commit does not touch any
     +    of the tracked paths, `line_log_process_ranges_arbitrary_commit()`
          propagates the current ranges to the parent by calling
     -    line_log_data_copy() and passing the copy to add_line_range().
     -    However, add_line_range() always makes its own copy internally
     -    (via line_log_data_copy or line_log_data_merge), so the caller's
     -    copy is never freed and leaks every time this path is taken.
     +    `line_log_data_copy()` and passing the copy to add_line_range().
     +    However, `add_line_range()` always makes its own copy internally (via
     +    line_log_data_copy or line_log_data_merge), so the caller's copy is
     +    never freed and leaks every time this path is taken.
      
     -    Pass range directly to add_line_range() instead of making a
     -    redundant intermediate copy. The callee's internal copy handles
     -    ownership correctly.
     +    Pass range directly to `add_line_range()` instead of making a redundant
     +    intermediate copy. The callee's internal copy handles ownership
     +    correctly.
      
          Pointed out by Coverity.
      
  7:  62ce03454a !  6:  8a8fe2d3e3 dir: free allocations on parse-error paths in read_one_dir()
     @@ Metadata
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Commit message ##
     -    dir: free allocations on parse-error paths in read_one_dir()
     +    dir: free allocations on parse-error paths in `read_one_dir()`
      
     -    When read_one_dir() encounters a parse error while reading the
     -    untracked cache from disk, it returns -1 immediately. Two
     -    allocations made earlier in the function can leak on these
     -    early-return paths: ud.untracked (allocated at line 3846 when
     -    untracked_nr > 0) and ud.dirs (allocated at line 3851).
     +    Two of `read_one_dir()`'s parse-error early returns leak ud.untracked
     +    and ud.dirs. Plug them.
      
     -    Free both before returning on the two error paths between these
     -    allocations and the point where they are transferred into the
     -    final xmalloc'd struct at line 3857.
     +    The other early returns in the same function are fine: they occur after
     +    the `xmalloc()`+`memcpy()` that copies ud into `*untracked_`, at which
     +    point ownership is transferred to the caller.
     +    `read_untracked_extension()` then releases everything via
     +    `free_untracked_cache()` on failure.
      
          Pointed out by Coverity.
      
  8:  6a43f95241 !  7:  5397ea785c submodule: fix cwd leak in get_superproject_working_tree()
     @@ Metadata
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Commit message ##
     -    submodule: fix cwd leak in get_superproject_working_tree()
     +    submodule: fix cwd leak in `get_superproject_working_tree()`
      
     -    get_superproject_working_tree() allocates cwd via xgetcwd() at
     -    the top of the function, but two early-return paths (when not
     -    inside a work tree, and when strbuf_realpath for "../" fails)
     -    return 0 without freeing it.
     +    `get_superproject_working_tree()` allocates cwd via `xgetcwd()` at the
     +    top of the function, but two early-return paths (when not inside a work
     +    tree, and when strbuf_realpath for "../" fails) return 0 without freeing
     +    it.
      
     -    Redirect these early returns through a cleanup label that frees
     -    cwd before returning.
     +    Redirect these early returns through a cleanup label that frees cwd
     +    before returning.
      
          Pointed out by Coverity.
      
     @@ submodule.c: int get_superproject_working_tree(struct strbuf *buf)
      +		goto out;
       
       	subpath = relative_path(cwd, one_up.buf, &sb);
     - 	strbuf_release(&one_up);
     +-	strbuf_release(&one_up);
     + 
     + 	prepare_submodule_repo_env(&cp.env);
     + 	strvec_pop(&cp.env);
      @@ submodule.c: int get_superproject_working_tree(struct strbuf *buf)
     + 		ret = 1;
     + 		free(super_wt);
     + 	}
     +-	free(cwd);
     +-	strbuf_release(&sb);
     + 
     + 	code = finish_command(&cp);
     + 
     + 	if (code == 128)
     + 		/* '../' is not a git repository */
     +-		return 0;
     +-	if (code == 0 && len == 0)
     ++		ret = 0;
     ++	else if (code == 0 && len == 0)
     + 		/* There is an unrelated git repository at '../' */
     +-		return 0;
     +-	if (code)
     ++		ret = 0;
     ++	else if (code)
       		die(_("ls-tree returned unexpected return code %d"), code);
       
     - 	return ret;
     -+
      +out:
     ++	strbuf_release(&sb);
     ++	strbuf_release(&one_up);
      +	free(cwd);
     -+	return 0;
     + 	return ret;
       }
       
     - /*
  9:  e39e2f5aa4 !  8:  0048c0ca27 worktree: fix resource leaks when branch creation fails
     @@ Metadata
       ## Commit message ##
          worktree: fix resource leaks when branch creation fails
      
     -    In the "add" subcommand, when run_command() fails while creating
     -    a new branch (line 948), the function returns -1 immediately
     -    without freeing the allocations made earlier: path (from
     -    prefix_filename at line 858), opt_track, branch_to_free, and
     -    new_branch_to_free.
     +    In the "add" subcommand, when `run_command()` fails while creating a new
     +    branch (line 948), the function returns -1 immediately without freeing
     +    the allocations made earlier: path (from prefix_filename at line 858),
     +    opt_track, branch_to_free, and new_branch_to_free.
      
     -    Redirect the error return through the existing cleanup block at
     -    the end of the function so all four allocations are properly
     -    freed.
     +    Redirect the error return through the existing cleanup block at the end
     +    of the function so all four allocations are properly freed.
      
          Pointed out by Coverity.
      
 10:  cc19a300f5 !  9:  4048a225a5 imap-send: avoid leaking the IMAP upload buffer
     @@ Metadata
       ## Commit message ##
          imap-send: avoid leaking the IMAP upload buffer
      
     -    When uploading messages via libcurl, curl_append_msgs_to_imap()
     -    accumulates each one in a strbuf that grows across loop iterations
     -    but is never released before the function returns.
     +    When uploading messages via libcurl, `curl_append_msgs_to_imap()`
     +    accumulates each one in a strbuf that grows across loop iterations but
     +    is never released before the function returns.
      
          Release it alongside the existing libcurl cleanup.
      
 11:  198062addd ! 10:  13ecebcdee reftable/table: release filter on error path
     @@ Metadata
       ## Commit message ##
          reftable/table: release filter on error path
      
     -    reftable_table_refs_for_unindexed() allocates a filtering_ref_iterator
     -    and then calls reftable_buf_add() to populate its oid buffer. On
     +    `reftable_table_refs_for_unindexed()` allocates a filtering_ref_iterator
     +    and then calls `reftable_buf_add()` to populate its oid buffer. On
          success ownership is transferred to the output iterator, but if
     -    reftable_buf_add() fails, the goto-out cleanup only frees the table
     -    iterator and walks away from both the filter allocation and the
     -    oid buffer that reftable_buf_add() may have grown.
     +    `reftable_buf_add()` fails, the goto-out cleanup only frees the table
     +    iterator and walks away from both the filter allocation and the oid
     +    buffer that `reftable_buf_add()` may have grown.
      
          Release filter->oid and free filter alongside the existing table
          iterator cleanup.
 12:  8ad6b220e9 = 11:  97049d7cc3 fsmonitor: plug token-data leak on early daemon-startup failures
 13:  23ab9864b2 ! 12:  a5a6c27184 mingw: make exit_process() own the process handle on all paths
     @@ Metadata
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Commit message ##
     -    mingw: make exit_process() own the process handle on all paths
     +    mingw: make `exit_process()` own the process handle on all paths
      
          After "mingw: kill child processes in a gentler way", the ownership of
     -    the HANDLE passed to exit_process() and terminate_process_tree() is
     -    inconsistent. terminate_process_tree() always closes the handle;
     -    exit_process() closes it on success and on the terminate-tree
     +    the HANDLE passed to `exit_process()` and `terminate_process_tree()` is
     +    inconsistent. `terminate_process_tree()` always closes the handle;
     +    `exit_process()` closes it on success and on the terminate-tree
          fallback, but leaks it on the early return where GetExitCodeProcess()
          fails or reports the process is no longer STILL_ACTIVE.
      
     -    mingw_kill() compensated by closing the handle on its own error path,
     -    which is a double-close on every error path that does not hit that
     -    one leaky branch -- the callee has already closed the handle by then.
     +    `mingw_kill()` compensated by closing the handle on its own error path,
     +    which is a double-close on every error path that does not hit that one
     +    leaky branch -- the callee has already closed the handle by then.
          Coverity flagged the resulting use-after-free as CID 1437238.
      
     -    Pin down the invariant that exit_process() and
     -    terminate_process_tree() own the handle from the call onward and
     -    close it on every return path; with that, the bogus close in
     -    mingw_kill() goes away.
     +    Pin down the invariant that `exit_process()` and
     +    `terminate_process_tree()` own the handle from the call onward and close
     +    it on every return path; with that, the bogus close in `mingw_kill()`
     +    goes away.
      
          Assisted-by: Opus 4.7
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

-- 
gitgitgadget
