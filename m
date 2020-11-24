Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584F7C56201
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E112120782
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM8OzL4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgKXLzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgKXLy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:54:59 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3ACC0617A6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:54:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i2so2984854wrs.4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sq+yFGLciSoHbZShPJ8hl4EVlme+1VKIWjOTiWfJ8W0=;
        b=fM8OzL4Ov4Wj3DSJpNeIXdyjncAD2x5KDrmhJN2fgug3c1++dp0/T7U69eLivu+h9r
         1QnsME3T4EKcf+OqX9+tFByYDPMrgZZKyP1jiK1YqZnYJcEkiXmQ1nslvIC3MjBLQH4N
         kMrS14HOHAgd9kMdULIcuUm59oApRnCmSsnVbcCwV7MT51t0gkLWYI8mnT83Z+3nogW7
         dV3Vd5OFrcdfjkk9Sa0tToqCsurja4yfIukETRshiUXVSPzUfTZEf49nBWAGacpd7lIJ
         IPT17UXldAxAiA7F9pgYZ+kFCEiQOEEuIOZEASPC/4EijKDyxX/kvO55IiU19vIX/QfT
         fezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sq+yFGLciSoHbZShPJ8hl4EVlme+1VKIWjOTiWfJ8W0=;
        b=Pg/bZ5sM02F/9bOv05VA3dlhtFqAtKYQzEFb+LvTsfMXBhBkFOdkx7uvelj1sU9+dx
         3R7hTAr5IZXYyxjRea4h9QDgk1NLZbK+fE5FYHJtkIIW/YGMi9U1cUNCBCNe/ZKfyCFb
         H/BZc1DqK7lI60245Tq9AV4hV4xu6/dg7BUZZ58s6cgmcuummdpBofG+t17om0k13F2f
         JbVL66x/XzOcdN41ilQJKX/MS17MDhizEjATbdCs6/fWibqUYMIbDO9Jhoqid1+DdW2S
         EQ6DldTYJbtzwvx1cwR8s9lDUFpUOeSeIuvgAxm3zcJXLNcrdxx+PZc3cjGXrF7FhMG3
         rP6g==
X-Gm-Message-State: AOAM5310ZKDVlJYxemi6r3s/EfVTIMCb9ywuiP6/atZGDKojE3V5Gz8E
        /j8nxOjzc2OmNF+SQbrDbNE/utxkkTQ=
X-Google-Smtp-Source: ABdhPJzVoHr3ivky5APaJpyObmejO3c2J/NESm1AJ30OpTGm3NXM3ihteAeHOAU1uH20xshmdPCIaA==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr4761255wrp.230.1606218895542;
        Tue, 24 Nov 2020 03:54:55 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:54:54 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 00/13] Rewrite the remaining merge strategies from shell to C
Date:   Tue, 24 Nov 2020 12:53:02 +0100
Message-Id: <20201124115315.13311-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116102158.8365-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a effort to reduce the number of shell scripts in git's codebase, I
propose this patch series converting the two remaining merge strategies,
resolve and octopus, from shell to C.  This will enable slightly better
performance, better integration with git itself (no more forking to
perform these operations), better portability (Windows and shell scripts
don't mix well).

Three scripts are actually converted: first git-merge-one-file.sh, then
git-merge-resolve.sh, and finally git-merge-octopus.sh.  Not only they
are converted, but they also are modified to operate without forking,
and then libified so they can be used by git without spawning another
process.

The first patch is not important to make the whole series work, but I
made this patch while working on it.

This series keeps the commands `git merge-one-file', `git
merge-resolve', and `git merge-octopus', so any script depending on them
should keep working without any changes.

This series is based on 306ee63a70 (Eighteenth batch, 2020-09-29).  The
tip is tagged as "rewrite-merge-strategies-v6" at
https://github.com/agrn/git.

Changes since v5:

 - [1/13] Change the commit message to reflect the change of the name of
   t6027.

 - [2/13] Introduce changes in t6060 to avoid potential issues with the
   libified version of merge-index, where a conflicted file could be
   left unmerged (more details in the commit message).

 - [4/13] Fix error handling in do_merge_one_file().

 - [5/13] Pass the repository instead of the index to the libified
   version of merge-index.  This will be useful when merge_three_way()
   will be modified to put more information in the merge markers:
   instead of passing the repository as context, an array of two strings
   will be given to merge_entry()'s callback.

 - [5/13] Change error handling in merge_entry().  Instead of returning
   -2 when the merge program failed, it will increase the number of
   errors, passed by a pointer.  This change is introduced so the caller
   (namely merge_all_index()) still knows how many times a file was
   found in the index with its return value.  When not ran in oneshot
   mode, the number of errors should remain 0.  merge_entry() should
   also not print "Merge program failed" when ran in oneshot mode.

 - [6/13] Fix the issue described in the second patch.

 - [7/13] Pass the repository to merge_all_index().

 - [9/13] Set the flag WRITE_TREE_SILENT when calling
   write_index_as_tree().

 - [9/13] Cleanup of merge_strategies_octopus() (removing redundant
   code, removing gotos, etc.).

 - [12/13, 13/13] Reformatted an if/else if/else sequence.

Alban Gruin (13):
  t6407: modernise tests
  t6060: modify multiple files to expose a possible issue with
    merge-index
  update-index: move add_cacheinfo() to read-cache.c
  merge-one-file: rewrite in C
  merge-index: libify merge_one_path() and merge_all()
  merge-index: don't fork if the requested program is
    `git-merge-one-file'
  merge-resolve: rewrite in C
  merge-recursive: move better_branch_name() to merge.c
  merge-octopus: rewrite in C
  merge: use the "resolve" strategy without forking
  merge: use the "octopus" strategy without forking
  sequencer: use the "resolve" strategy without forking
  sequencer: use the "octopus" merge strategy without forking

 Makefile                        |   7 +-
 builtin.h                       |   3 +
 builtin/merge-index.c           | 101 ++----
 builtin/merge-octopus.c         |  69 ++++
 builtin/merge-one-file.c        |  94 ++++++
 builtin/merge-recursive.c       |  16 +-
 builtin/merge-resolve.c         |  73 ++++
 builtin/merge.c                 |   7 +
 builtin/update-index.c          |  25 +-
 cache.h                         |   7 +-
 git-merge-octopus.sh            | 112 -------
 git-merge-one-file.sh           | 167 ----------
 git-merge-resolve.sh            |  54 ---
 git.c                           |   3 +
 merge-strategies.c              | 571 ++++++++++++++++++++++++++++++++
 merge-strategies.h              |  46 +++
 merge.c                         |  12 +
 read-cache.c                    |  35 ++
 sequencer.c                     |  17 +-
 t/t6060-merge-index.sh          |  10 +-
 t/t6407-merge-binary.sh         |  27 +-
 t/t6415-merge-dir-to-symlink.sh |   2 +-
 22 files changed, 992 insertions(+), 466 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 create mode 100644 builtin/merge-one-file.c
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-octopus.sh
 delete mode 100755 git-merge-one-file.sh
 delete mode 100755 git-merge-resolve.sh
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

Range-diff against v5:
 1:  08c7df596a !  1:  70d6507330 t6027: modernise tests
    @@ Metadata
     Author: Alban Gruin <alban.gruin@gmail.com>
     
      ## Commit message ##
    -    t6027: modernise tests
    +    t6407: modernise tests
     
    -    Some tests in t6027 uses a if/then/else to check if a command failed or
    +    Some tests in t6407 uses a if/then/else to check if a command failed or
         not, but we have the `test_must_fail' function to do it correctly for us
         nowadays.
     
 -:  ---------- >  2:  25e9c47e41 t6060: modify multiple files to expose a possible issue with merge-index
 2:  df237da758 =  3:  e7ea43c5ff update-index: move add_cacheinfo() to read-cache.c
 3:  eedddde8ea !  4:  284fc4227f merge-one-file: rewrite in C
    @@ merge-strategies.c (new)
     +		return error(_("%s: Not merging symbolic link changes."), path);
     +	else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK)
     +		return error(_("%s: Not merging conflicting submodule changes."), path);
    -+	else if (our_mode != their_mode)
    -+		return error(_("permission conflict: %o->%o,%o in %s"),
    -+			     orig_mode, our_mode, their_mode, path);
     +
     +	if (orig_blob) {
     +		printf(_("Auto-merging %s\n"), path);
    @@ merge-strategies.c (new)
     +	if (ret < 0) {
     +		free(result.ptr);
     +		return error(_("Failed to execute internal merge"));
    -+	} else if (ret > 0 || !orig_blob) {
    -+		free(result.ptr);
    -+		return error(_("content conflict in %s"), path);
     +	}
     +
    ++	if (ret > 0 || !orig_blob)
    ++		ret = error(_("content conflict in %s"), path);
    ++	if (our_mode != their_mode)
    ++		ret = error(_("permission conflict: %o->%o,%o in %s"),
    ++			    orig_mode, our_mode, their_mode, path);
    ++
     +	unlink(path);
     +	if ((dest = open(path, O_WRONLY | O_CREAT, our_mode)) < 0) {
     +		free(result.ptr);
    @@ merge-strategies.c (new)
     +
     +	if (written < 0)
     +		return error_errno(_("failed to write to '%s'"), path);
    ++	if (ret)
    ++		return ret;
     +
     +	return add_file_to_index(istate, path, 0);
     +}
 4:  a9b9942243 !  5:  54abee902f merge-index: libify merge_one_path() and merge_all()
    @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const ch
      			}
      			if (!strcmp(arg, "-a")) {
     -				merge_all();
    -+				err |= merge_all_index(&the_index, one_shot, quiet,
    ++				err |= merge_all_index(the_repository, one_shot, quiet,
     +						       merge_one_file_spawn, (void *)pgm);
      				continue;
      			}
      			die("git merge-index: unknown option %s", arg);
      		}
     -		merge_one_path(arg);
    -+		err |= merge_index_path(&the_index, one_shot, quiet, arg,
    ++		err |= merge_index_path(the_repository, one_shot, quiet, arg,
     +					merge_one_file_spawn, (void *)pgm);
      	}
     -	if (err && !quiet)
    @@ merge-strategies.c: int merge_three_way(struct repository *r,
      	return 0;
      }
     +
    -+int merge_one_file_spawn(const struct object_id *orig_blob,
    ++int merge_one_file_spawn(struct repository *r,
    ++			 const struct object_id *orig_blob,
     +			 const struct object_id *our_blob,
     +			 const struct object_id *their_blob, const char *path,
     +			 unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    @@ merge-strategies.c: int merge_three_way(struct repository *r,
     +	return run_command_v_opt(arguments, 0);
     +}
     +
    -+static int merge_entry(struct index_state *istate, int quiet, int pos,
    -+		       const char *path, merge_fn fn, void *data)
    ++static int merge_entry(struct repository *r, int quiet, unsigned int pos,
    ++		       const char *path, int *err, merge_fn fn, void *data)
     +{
     +	int found = 0;
     +	const struct object_id *oids[3] = {NULL};
     +	unsigned int modes[3] = {0};
     +
     +	do {
    -+		const struct cache_entry *ce = istate->cache[pos];
    ++		const struct cache_entry *ce = r->index->cache[pos];
     +		int stage = ce_stage(ce);
     +
     +		if (strcmp(ce->name, path))
    @@ merge-strategies.c: int merge_three_way(struct repository *r,
     +		found++;
     +		oids[stage - 1] = &ce->oid;
     +		modes[stage - 1] = ce->ce_mode;
    -+	} while (++pos < istate->cache_nr);
    ++	} while (++pos < r->index->cache_nr);
     +	if (!found)
     +		return error(_("%s is not in the cache"), path);
     +
    -+	if (fn(oids[0], oids[1], oids[2], path, modes[0], modes[1], modes[2], data)) {
    ++	if (fn(r, oids[0], oids[1], oids[2], path,
    ++	       modes[0], modes[1], modes[2], data)) {
     +		if (!quiet)
     +			error(_("Merge program failed"));
    -+		return -2;
    ++		(*err)++;
     +	}
     +
     +	return found;
     +}
     +
    -+int merge_index_path(struct index_state *istate, int oneshot, int quiet,
    ++int merge_index_path(struct repository *r, int oneshot, int quiet,
     +		     const char *path, merge_fn fn, void *data)
     +{
    -+	int pos = index_name_pos(istate, path, strlen(path)), ret;
    ++	int pos = index_name_pos(r->index, path, strlen(path)), ret, err = 0;
     +
     +	/*
     +	 * If it already exists in the cache as stage0, it's
     +	 * already merged and there is nothing to do.
     +	 */
     +	if (pos < 0) {
    -+		ret = merge_entry(istate, quiet, -pos - 1, path, fn, data);
    ++		ret = merge_entry(r, quiet || oneshot, -pos - 1, path, &err, fn, data);
     +		if (ret == -1)
     +			return -1;
    -+		else if (ret == -2)
    ++		else if (err)
     +			return 1;
     +	}
     +	return 0;
     +}
     +
    -+int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    ++int merge_all_index(struct repository *r, int oneshot, int quiet,
     +		    merge_fn fn, void *data)
     +{
    -+	int err = 0, i, ret;
    -+	for (i = 0; i < istate->cache_nr; i++) {
    -+		const struct cache_entry *ce = istate->cache[i];
    ++	int err = 0, ret;
    ++	unsigned int i;
    ++
    ++	for (i = 0; i < r->index->cache_nr; i++) {
    ++		const struct cache_entry *ce = r->index->cache[i];
     +		if (!ce_stage(ce))
     +			continue;
     +
    -+		ret = merge_entry(istate, quiet, i, ce->name, fn, data);
    ++		ret = merge_entry(r, quiet || oneshot, i, ce->name, &err, fn, data);
     +		if (ret > 0)
     +			i += ret - 1;
     +		else if (ret == -1)
     +			return -1;
    -+		else if (ret == -2) {
    -+			if (oneshot)
    -+				err++;
    -+			else
    -+				return 1;
    -+		}
    ++
    ++		if (err && !oneshot)
    ++			return 1;
     +	}
     +
     +	return err;
    @@ merge-strategies.h: int merge_three_way(struct repository *r,
      		    const struct object_id *their_blob, const char *path,
      		    unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode);
      
    -+typedef int (*merge_fn)(const struct object_id *orig_blob,
    ++typedef int (*merge_fn)(struct repository *r,
    ++			const struct object_id *orig_blob,
     +			const struct object_id *our_blob,
     +			const struct object_id *their_blob, const char *path,
     +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
     +			void *data);
     +
    -+int merge_one_file_spawn(const struct object_id *orig_blob,
    ++int merge_one_file_spawn(struct repository *r,
    ++			 const struct object_id *orig_blob,
     +			 const struct object_id *our_blob,
     +			 const struct object_id *their_blob, const char *path,
     +			 unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
     +			 void *data);
     +
    -+int merge_index_path(struct index_state *istate, int oneshot, int quiet,
    ++int merge_index_path(struct repository *r, int oneshot, int quiet,
     +		     const char *path, merge_fn fn, void *data);
    -+int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    ++int merge_all_index(struct repository *r, int oneshot, int quiet,
     +		    merge_fn fn, void *data);
     +
      #endif /* MERGE_STRATEGIES_H */
 5:  12775907c5 !  6:  acaf100edd merge-index: don't fork if the requested program is `git-merge-one-file'
    @@ Commit message
         `merge-index' to call merge_three_way() without forking using a new
         callback, merge_one_file_func().
     
    +    To avoid any issue with a shrinking index because of the merge function
    +    used (directly in the process or by forking), as described earlier, the
    +    iterator of the loop of merge_all_index() is increased by the number of
    +    entries with the same name, minus the difference between the number of
    +    entries in the index before and after the merge.
    +
    +    This should handle a shrinking index correctly, but could lead to issues
    +    with a growing index.  However, this case is not treated, as there is no
    +    callback that can produce such a case.
    +
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
      ## builtin/merge-index.c ##
    @@ builtin/merge-index.c
      {
      	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
      	const char *pgm;
    -+	void *data;
    ++	void *data = NULL;
     +	merge_fn merge_action;
     +	struct lock_file lock = LOCK_INIT;
      
    @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const ch
      	}
     +
      	pgm = argv[i++];
    ++	setup_work_tree();
    ++
     +	if (!strcmp(pgm, "git-merge-one-file")) {
     +		merge_action = merge_one_file_func;
    -+		data = (void *)the_repository;
    -+
    -+		setup_work_tree();
     +		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
     +	} else {
     +		merge_action = merge_one_file_spawn;
    @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const ch
     @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
      			}
      			if (!strcmp(arg, "-a")) {
    - 				err |= merge_all_index(&the_index, one_shot, quiet,
    + 				err |= merge_all_index(the_repository, one_shot, quiet,
     -						       merge_one_file_spawn, (void *)pgm);
     +						       merge_action, data);
      				continue;
      			}
      			die("git merge-index: unknown option %s", arg);
      		}
    - 		err |= merge_index_path(&the_index, one_shot, quiet, arg,
    + 		err |= merge_index_path(the_repository, one_shot, quiet, arg,
     -					merge_one_file_spawn, (void *)pgm);
     +					merge_action, data);
     +	}
    @@ merge-strategies.c: int merge_three_way(struct repository *r,
      	return 0;
      }
      
    -+int merge_one_file_func(const struct object_id *orig_blob,
    ++int merge_one_file_func(struct repository *r,
    ++			const struct object_id *orig_blob,
     +			const struct object_id *our_blob,
     +			const struct object_id *their_blob, const char *path,
     +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
     +			void *data)
     +{
    -+	return merge_three_way((struct repository *)data,
    ++	return merge_three_way(r,
     +			       orig_blob, our_blob, their_blob, path,
     +			       orig_mode, our_mode, their_mode);
     +}
     +
    - int merge_one_file_spawn(const struct object_id *orig_blob,
    + int merge_one_file_spawn(struct repository *r,
    + 			 const struct object_id *orig_blob,
      			 const struct object_id *our_blob,
    - 			 const struct object_id *their_blob, const char *path,
    +@@ merge-strategies.c: int merge_all_index(struct repository *r, int oneshot, int quiet,
    + 		    merge_fn fn, void *data)
    + {
    + 	int err = 0, ret;
    +-	unsigned int i;
    ++	unsigned int i, prev_nr;
    + 
    + 	for (i = 0; i < r->index->cache_nr; i++) {
    + 		const struct cache_entry *ce = r->index->cache[i];
    + 		if (!ce_stage(ce))
    + 			continue;
    + 
    ++		prev_nr = r->index->cache_nr;
    + 		ret = merge_entry(r, quiet || oneshot, i, ce->name, &err, fn, data);
    +-		if (ret > 0)
    +-			i += ret - 1;
    +-		else if (ret == -1)
    ++		if (ret > 0) {
    ++			/* Don't bother handling an index that has
    ++			   grown, since merge_one_file_func() can't grow
    ++			   it, and merge_one_file_spawn() can't change
    ++			   it. */
    ++			i += ret - (prev_nr - r->index->cache_nr) - 1;
    ++		} else if (ret == -1)
    + 			return -1;
    + 
    + 		if (err && !oneshot)
     
      ## merge-strategies.h ##
    -@@ merge-strategies.h: typedef int (*merge_fn)(const struct object_id *orig_blob,
    +@@ merge-strategies.h: typedef int (*merge_fn)(struct repository *r,
      			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
      			void *data);
      
    -+int merge_one_file_func(const struct object_id *orig_blob,
    ++int merge_one_file_func(struct repository *r,
    ++			const struct object_id *orig_blob,
     +			const struct object_id *our_blob,
     +			const struct object_id *their_blob, const char *path,
     +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
     +			void *data);
     +
    - int merge_one_file_spawn(const struct object_id *orig_blob,
    + int merge_one_file_spawn(struct repository *r,
    + 			 const struct object_id *orig_blob,
      			 const struct object_id *our_blob,
    - 			 const struct object_id *their_blob, const char *path,
 6:  54a4a12504 !  7:  9a9e3faeff merge-resolve: rewrite in C
    @@ merge-strategies.c
      #include "xdiff-interface.h"
      
      static int checkout_from_index(struct index_state *istate, const char *path,
    -@@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    +@@ merge-strategies.c: int merge_all_index(struct repository *r, int oneshot, int quiet,
      
      	return err;
      }
    @@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot,
     +
     +		puts(_("Simple merge failed, trying Automatic merge."));
     +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+		ret = merge_all_index(r->index, 0, 0, merge_one_file_func, r);
    ++		ret = merge_all_index(r, 1, 0, merge_one_file_func, NULL);
     +
     +		write_locked_index(r->index, &lock, COMMIT_LOCK);
     +		return !!ret;
    @@ merge-strategies.h
      #include "object.h"
      
      int merge_three_way(struct repository *r,
    -@@ merge-strategies.h: int merge_index_path(struct index_state *istate, int oneshot, int quiet,
    - int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    +@@ merge-strategies.h: int merge_index_path(struct repository *r, int oneshot, int quiet,
    + int merge_all_index(struct repository *r, int oneshot, int quiet,
      		    merge_fn fn, void *data);
      
     +int merge_strategies_resolve(struct repository *r,
 7:  7c4ad06b95 =  8:  359346229c merge-recursive: move better_branch_name() to merge.c
 8:  edbe08d41b !  9:  4dff780212 merge-octopus: rewrite in C
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +	struct object_id oid;
     +	int ret;
     +
    -+	if (!(ret = write_index_as_tree(&oid, r->index, r->index_file, 0, NULL)))
    ++	if (!(ret = write_index_as_tree(&oid, r->index, r->index_file,
    ++					WRITE_TREE_SILENT, NULL)))
     +		*reference_tree = lookup_tree(r, &oid);
     +
     +	return ret;
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +
     +		puts(_("Simple merge did not work, trying automatic merge."));
     +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+		ret = merge_all_index(r->index, 0, 0, merge_one_file_func, r);
    ++		ret = merge_all_index(r, 1, 0, merge_one_file_func, NULL);
     +		write_locked_index(r->index, &lock, COMMIT_LOCK);
     +
     +		write_tree(r, reference_tree);
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +			     struct commit_list *remotes)
     +{
     +	int ff_merge = 1, ret = 0, references = 1;
    -+	struct commit **reference_commit;
    -+	struct tree *reference_tree, *tree_head;
    ++	struct commit **reference_commit, *head_commit;
    ++	struct tree *reference_tree, *head_tree;
     +	struct commit_list *i;
     +	struct object_id head;
     +	struct strbuf sb = STRBUF_INIT;
     +
     +	get_oid(head_arg, &head);
    ++	head_commit = lookup_commit_reference(r, &head);
    ++	head_tree = repo_get_commit_tree(r, head_commit);
     +
    -+	reference_commit = xcalloc(commit_list_count(remotes) + 1,
    -+				   sizeof(struct commit *));
    -+	reference_commit[0] = lookup_commit_reference(r, &head);
    -+	reference_tree = repo_get_commit_tree(r, reference_commit[0]);
    ++	if (parse_tree(head_tree))
    ++		return 2;
     +
    -+	tree_head = repo_get_commit_tree(r, reference_commit[0]);
    -+	if (parse_tree(tree_head)) {
    -+		ret = 2;
    -+		goto out;
    -+	}
    -+
    -+	if (repo_index_has_changes(r, reference_tree, &sb)) {
    ++	if (repo_index_has_changes(r, head_tree, &sb)) {
     +		error(_("Your local changes to the following files "
     +			"would be overwritten by merge:\n  %s"),
     +		      sb.buf);
     +		strbuf_release(&sb);
    -+		ret = 2;
    -+		goto out;
    ++		return 2;
     +	}
     +
    ++	reference_commit = xcalloc(commit_list_count(remotes) + 1,
    ++				   sizeof(struct commit *));
    ++	reference_commit[0] = head_commit;
    ++	reference_tree = head_tree;
    ++
     +	for (i = remotes; i && i->item; i = i->next) {
     +		struct commit *c = i->item;
     +		struct object_id *oid = &c->object.oid;
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +			puts(_("Automated merge did not work."));
     +			puts(_("Should not be doing an octopus."));
     +
    -+			ret = 2;
    -+			goto out;
    ++			free(reference_commit);
    ++			return 2;
     +		}
     +
     +		branch_name = merge_get_better_branch_name(oid_to_hex(oid));
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +
     +			free(branch_name);
     +			free_commit_list(common);
    ++			free(reference_commit);
     +
    -+			ret = 2;
    -+			goto out;
    ++			return 2;
     +		}
     +
     +		for (j = common; j && !(up_to_date || !ff_merge); j = j->next) {
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +		}
     +
     +		if (ff_merge) {
    -+			ret = octopus_fast_forward(r, branch_name, tree_head,
    ++			ret = octopus_fast_forward(r, branch_name, head_tree,
     +						   current_tree, &reference_tree);
     +			references = 0;
     +		} else {
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +		free_commit_list(common);
     +
     +		if (ret == -1)
    -+			goto out;
    ++			break;
     +
     +		reference_commit[references++] = c;
     +	}
     +
    -+out:
     +	free(reference_commit);
     +	return ret;
     +}
     
      ## merge-strategies.h ##
    -@@ merge-strategies.h: int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    +@@ merge-strategies.h: int merge_all_index(struct repository *r, int oneshot, int quiet,
      int merge_strategies_resolve(struct repository *r,
      			     struct commit_list *bases, const char *head_arg,
      			     struct commit_list *remote);
 9:  e677b27c06 = 10:  76f02b4531 merge: use the "resolve" strategy without forking
10:  963f316fd6 = 11:  c9e0a38d0f merge: use the "octopus" strategy without forking
11:  0ad967a7e5 ! 12:  5b595efa46 sequencer: use the "resolve" strategy without forking
    @@ sequencer.c: static int do_pick_commit(struct repository *r,
     +		if (!strcmp(opts->strategy, "resolve")) {
     +			repo_read_index(r);
     +			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
    -+		} else
    ++		} else {
     +			res |= try_merge_command(r, opts->strategy,
     +						 opts->xopts_nr, (const char **)opts->xopts,
     +						 common, oid_to_hex(&head), remotes);
    ++		}
     +
      		free_commit_list(common);
      		free_commit_list(remotes);
12:  3814f61717 ! 13:  7eb0f13442 sequencer: use the "octopus" merge strategy without forking
    @@ sequencer.c: static int do_pick_commit(struct repository *r,
     +		} else if (!strcmp(opts->strategy, "octopus")) {
     +			repo_read_index(r);
     +			res |= merge_strategies_octopus(r, common, oid_to_hex(&head), remotes);
    - 		} else
    + 		} else {
      			res |= try_merge_command(r, opts->strategy,
      						 opts->xopts_nr, (const char **)opts->xopts,
-- 
2.29.2.260.ge31aba42fb

