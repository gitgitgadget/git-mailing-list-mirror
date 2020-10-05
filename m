Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B5CC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FBD2085B
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0ry7LkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgJEM1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEM1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628B5C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:27:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e17so640766wru.12
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4mQMYLTK9Aa2St3Fe6s41Dal/6Dnni0sxjNq92seQ0=;
        b=r0ry7LkZGoUdDU5hVp4xwDrjbcO94FXL/rlZEZtcqV5Cwyv+gTGqUoAhQzS1DRcEXW
         55cK83QpxKqgOFksl0+z3Uj8q86pDdcmp8c9W0f1ZjTMigTs1UWbsZunygQQBE/E+pvk
         IBPirfYImPnW4ixECt6JnaVuCt5ZKuTitNoemZCAPoTnWAwHKyXKZeHgptSQTmbAFPVL
         XRtAuiKGzEsvWYuJQTQ1L/aARR/BgqlCy1FbOWM794f6aD6f9NSvZoUMR0gCc1k2GdLX
         YaHg0vtHNCi0B+6mEOM+R5rGpezH6Ky432x5TdXlga8QyEeC1O7HL+qffHW8uuQXFwgN
         gS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4mQMYLTK9Aa2St3Fe6s41Dal/6Dnni0sxjNq92seQ0=;
        b=QWg+BIdHbF3IFjBGFcuALgpBLEYSsZvNM1PDIqjNnuHTLFg1JxVEm2mG6XLoMfk0ol
         /mss8mabGsNaF4PXVwQ2AUjGUBWaBbbkUbMXahVHzGQI+AIz7P2jUqfxXqWH9Qa028FO
         MlBcyL0XRvuwZuYqhnpDLBY+10aFeVTsLfoA0jEi7953CBzDe4gQUASmNImhFlUXF/5K
         SjKDk1zUsmkdKECRHBEyiQ7AWd+jyUBLPF+b+k151QMKp2GeRhiDbBtoeZRy6CPE6iU3
         BMsRUbPgvhObX3Yp1XlAKP9eetj+Gk2o5MjkFzSNjsn0SL6S34yZitD0hdsox9oRJEl/
         zvGQ==
X-Gm-Message-State: AOAM532qW6bNN45t4/YBEeMlOmBvDgcaT+3e9YfEj6wPxsUISPGJ1oMM
        RzFat3MuZlEhHdt+eFpjjBlpEeXNsEk=
X-Google-Smtp-Source: ABdhPJx2hDmIP4SNI4x3vhh/fgb21pI+8uGHZMscKdyyfzOArOk86Rsd01FyzofLn+7HiP7lIiGHOg==
X-Received: by 2002:adf:fc4e:: with SMTP id e14mr17513486wrs.329.1601900854981;
        Mon, 05 Oct 2020 05:27:34 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-293-21.w86-199.abo.wanadoo.fr. [86.199.76.21])
        by smtp.googlemail.com with ESMTPSA id n2sm13270400wma.29.2020.10.05.05.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:34 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 00/11] Rewrite the remaining merge strategies from shell to C
Date:   Mon,  5 Oct 2020 14:26:35 +0200
Message-Id: <20201005122646.27994-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901105705.6059-1-alban.gruin@gmail.com>
References: <20200901105705.6059-1-alban.gruin@gmail.com>
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
tip is tagged as "rewrite-merge-strategies-v3" at
https://github.com/agrn/git.

Changes since v2:

 - Enable `USE_THE_INDEX_COMPATIBILITY_MACROS' in merge-one-file.c and
   use read_cache() and hold_locked_index() instead of repo_read_index()
   and repo_hold_locked_index() to improve readability.

 - Move file mode parsing to its own function in merge-one-file.c.

 - Improve IO errors handling in do_merge_one_file().

 - Return -1 instead of 1 when erroring out in do_merge_one_file() and
   merge_strategies_one_file().

 - Use oid_to_hex_r() instead of oid_to_hex() in do_merge_one_file().

 - Reformat multilines comments.

 - Reworded a sentence in commit 3/11.

Alban Gruin (11):
  t6027: modernise tests
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
 builtin/merge-index.c           | 102 ++----
 builtin/merge-octopus.c         |  69 ++++
 builtin/merge-one-file.c        |  92 +++++
 builtin/merge-recursive.c       |  16 +-
 builtin/merge-resolve.c         |  69 ++++
 builtin/merge.c                 |   9 +-
 cache.h                         |   2 +-
 git-merge-octopus.sh            | 112 ------
 git-merge-one-file.sh           | 167 ---------
 git-merge-resolve.sh            |  54 ---
 git.c                           |   3 +
 merge-strategies.c              | 613 ++++++++++++++++++++++++++++++++
 merge-strategies.h              |  44 +++
 merge.c                         |  12 +
 sequencer.c                     |  16 +-
 t/t6407-merge-binary.sh         |  27 +-
 t/t6415-merge-dir-to-symlink.sh |   2 +-
 19 files changed, 972 insertions(+), 447 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 create mode 100644 builtin/merge-one-file.c
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-octopus.sh
 delete mode 100755 git-merge-one-file.sh
 delete mode 100755 git-merge-resolve.sh
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

Range-diff against v2:
 1:  28c8fd11b6 =  1:  08c7df596a t6027: modernise tests
 2:  f5ab0fdf0a !  2:  ce911c99c0 merge-one-file: rewrite in C
    @@ builtin/merge-one-file.c (new)
     + * that might change the tree layout.
     + */
     +
    ++#define USE_THE_INDEX_COMPATIBILITY_MACROS
     +#include "cache.h"
     +#include "builtin.h"
     +#include "lockfile.h"
    @@ builtin/merge-one-file.c (new)
     +	"<orig mode> <our mode> <their mode>\n\n"
     +	"Blob ids and modes should be empty for missing files.";
     +
    ++static int read_mode(const char *name, const char *arg, unsigned int *mode)
    ++{
    ++	char *last;
    ++	int ret = 0;
    ++
    ++	*mode = strtol(arg, &last, 8);
    ++
    ++	if (*last)
    ++		ret = error(_("invalid '%s' mode: expected nothing, got '%c'"), name, *last);
    ++	else if (!(S_ISREG(*mode) || S_ISDIR(*mode) || S_ISLNK(*mode)))
    ++		ret = error(_("invalid '%s' mode: %o"), name, *mode);
    ++
    ++	return ret;
    ++}
    ++
     +int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
     +{
     +	struct object_id orig_blob, our_blob, their_blob,
    @@ builtin/merge-one-file.c (new)
     +	if (argc != 8)
     +		usage(builtin_merge_one_file_usage);
     +
    -+	if (repo_read_index(the_repository) < 0)
    ++	if (read_cache() < 0)
     +		die("invalid index");
     +
    -+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
    ++	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
     +
     +	if (!get_oid(argv[1], &orig_blob)) {
     +		p_orig_blob = &orig_blob;
    -+		orig_mode = strtol(argv[5], NULL, 8);
    -+
    -+		if (!(S_ISREG(orig_mode) || S_ISDIR(orig_mode) || S_ISLNK(orig_mode)))
    -+			ret |= error(_("invalid 'orig' mode: %o"), orig_mode);
    ++		ret = read_mode("orig", argv[5], &orig_mode);
     +	}
     +
     +	if (!get_oid(argv[2], &our_blob)) {
     +		p_our_blob = &our_blob;
    -+		our_mode = strtol(argv[6], NULL, 8);
    -+
    -+		if (!(S_ISREG(our_mode) || S_ISDIR(our_mode) || S_ISLNK(our_mode)))
    -+			ret |= error(_("invalid 'our' mode: %o"), our_mode);
    ++		ret = read_mode("our", argv[6], &our_mode);
     +	}
     +
     +	if (!get_oid(argv[3], &their_blob)) {
     +		p_their_blob = &their_blob;
    -+		their_mode = strtol(argv[7], NULL, 8);
    -+
    -+		if (!(S_ISREG(their_mode) || S_ISDIR(their_mode) || S_ISLNK(their_mode)))
    -+			ret = error(_("invalid 'their' mode: %o"), their_mode);
    ++		ret = read_mode("their", argv[7], &their_mode);
     +	}
     +
     +	if (ret)
    @@ builtin/merge-one-file.c (new)
     +
     +	if (ret) {
     +		rollback_lock_file(&lock);
    -+		return ret;
    ++		return !!ret;
     +	}
     +
    -+	return write_locked_index(the_repository->index, &lock, COMMIT_LOCK);
    ++	return write_locked_index(&the_index, &lock, COMMIT_LOCK);
     +}
     
      ## git-merge-one-file.sh (deleted) ##
    @@ merge-strategies.c (new)
     +			     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
     +{
     +	int ret, i, dest;
    ++	ssize_t written;
     +	mmbuffer_t result = {NULL, 0};
     +	mmfile_t mmfs[3];
     +	struct ll_merge_options merge_opts = {0};
    @@ merge-strategies.c (new)
     +	for (i = 0; i < 3; i++)
     +		free(mmfs[i].ptr);
     +
    -+	if (ret > 127 || !orig_blob)
    -+		ret = error(_("content conflict in %s"), path);
    ++	if (ret < 0) {
    ++		free(result.ptr);
    ++		return error(_("Failed to execute internal merge"));
    ++	}
     +
    -+	/* Create the working tree file, using "our tree" version from
    -+	   the index, and then store the result of the merge. */
    ++	/*
    ++	 * Create the working tree file, using "our tree" version from
    ++	 * the index, and then store the result of the merge.
    ++	 */
     +	ce = index_file_exists(istate, path, strlen(path), 0);
     +	if (!ce)
     +		BUG("file is not present in the cache?");
     +
     +	unlink(path);
    -+	dest = open(path, O_WRONLY | O_CREAT, ce->ce_mode);
    -+	write_in_full(dest, result.ptr, result.size);
    ++	if ((dest = open(path, O_WRONLY | O_CREAT, ce->ce_mode)) < 0) {
    ++		free(result.ptr);
    ++		return error_errno(_("failed to open file '%s'"), path);
    ++	}
    ++
    ++	written = write_in_full(dest, result.ptr, result.size);
     +	close(dest);
     +
     +	free(result.ptr);
     +
    -+	if (ret && our_mode != their_mode)
    ++	if (written < 0)
    ++		return error_errno(_("failed to write to '%s'"), path);
    ++
    ++	if (ret != 0 || !orig_blob)
    ++		ret = error(_("content conflict in %s"), path);
    ++	if (our_mode != their_mode)
     +		return error(_("permission conflict: %o->%o,%o in %s"),
     +			     orig_mode, our_mode, their_mode, path);
     +	if (ret)
    -+		return 1;
    ++		return -1;
     +
     +	return add_file_to_index(istate, path, 0);
     +}
    @@ merge-strategies.c (new)
     +	if (orig_blob &&
     +	    ((!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
     +	     (!our_blob && their_blob && oideq(orig_blob, their_blob))))
    -+		/* Deleted in both or deleted in one and unchanged in
    -+		   the other */
    ++		/* Deleted in both or deleted in one and unchanged in the other. */
     +		return merge_one_file_deleted(r->index,
     +					      orig_blob, our_blob, their_blob, path,
     +					      orig_mode, our_mode, their_mode);
     +	else if (!orig_blob && our_blob && !their_blob) {
    -+		/* Added in one.  The other side did not add and we
    -+		   added so there is nothing to be done, except making
    -+		   the path merged. */
    ++		/*
    ++		 * Added in one.  The other side did not add and we
    ++		 * added so there is nothing to be done, except making
    ++		 * the path merged.
    ++		 */
     +		return add_to_index_cacheinfo(r->index, our_mode, our_blob, path);
     +	} else if (!orig_blob && !our_blob && their_blob) {
     +		printf(_("Adding %s\n"), path);
    @@ merge-strategies.c (new)
     +			return error(_("untracked %s is overwritten by the merge."), path);
     +
     +		if (add_to_index_cacheinfo(r->index, their_mode, their_blob, path))
    -+			return 1;
    ++			return -1;
     +		return checkout_from_index(r->index, path);
     +	} else if (!orig_blob && our_blob && their_blob &&
     +		   oideq(our_blob, their_blob)) {
    -+		/* Added in both, identically (check for same
    -+		   permissions). */
    ++		/* Added in both, identically (check for same permissions). */
     +		if (our_mode != their_mode)
     +			return error(_("File %s added identically in both branches, "
     +				       "but permissions conflict %o->%o."),
    @@ merge-strategies.c (new)
     +		printf(_("Adding %s\n"), path);
     +
     +		if (add_to_index_cacheinfo(r->index, our_mode, our_blob, path))
    -+			return 1;
    ++			return -1;
     +		return checkout_from_index(r->index, path);
     +	} else if (our_blob && their_blob)
     +		/* Modified in both, but differently. */
    @@ merge-strategies.c (new)
     +					 orig_blob, our_blob, their_blob, path,
     +					 orig_mode, our_mode, their_mode);
     +	else {
    -+		char *orig_hex = "", *our_hex = "", *their_hex = "";
    ++		char orig_hex[GIT_MAX_HEXSZ] = {0}, our_hex[GIT_MAX_HEXSZ] = {0},
    ++			their_hex[GIT_MAX_HEXSZ] = {0};
     +
     +		if (orig_blob)
    -+			orig_hex = oid_to_hex(orig_blob);
    ++			oid_to_hex_r(orig_hex, orig_blob);
     +		if (our_blob)
    -+			our_hex = oid_to_hex(our_blob);
    ++			oid_to_hex_r(our_hex, our_blob);
     +		if (their_blob)
    -+			their_hex = oid_to_hex(their_blob);
    ++			oid_to_hex_r(their_hex, their_blob);
     +
     +		return error(_("%s: Not handling case %s -> %s -> %s"),
     +			     path, orig_hex, our_hex, their_hex);
 3:  7f3ce7da17 !  3:  7f0999f5a3 merge-index: libify merge_one_path() and merge_all()
    @@ Commit message
     
         To avoid this, this moves merge_one_path(), merge_all(), and their
         helpers to merge-strategies.c.  They also take a callback to dictate
    -    what they should do for each file.  For now, only one launching a new
    -    process is defined to preserve the behaviour of the builtin version.
    +    what they should do for each file.  For now, to preserve the behaviour
    +    of `merge-index', only one callback, launching a new process, is
    +    defined.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
 4:  07e6a6aaef =  4:  c0bc05406d merge-index: don't fork if the requested program is `git-merge-one-file'
 5:  117d4fc840 =  5:  cbfe192982 merge-resolve: rewrite in C
 6:  4fc955962b =  6:  35e386f626 merge-recursive: move better_branch_name() to merge.c
 7:  e7b9e15b34 !  7:  41eb0f7199 merge-octopus: rewrite in C
    @@ Makefile: BUILTIN_OBJS += builtin/mailsplit.o
      BUILTIN_OBJS += builtin/merge-recursive.o
     
      ## builtin.h ##
    -@@ builtin.h: int cmd_mailsplit(int argc, const char **argv, const char *prefix);
    +@@ builtin.h: int cmd_maintenance(int argc, const char **argv, const char *prefix);
      int cmd_merge(int argc, const char **argv, const char *prefix);
      int cmd_merge_base(int argc, const char **argv, const char *prefix);
      int cmd_merge_index(int argc, const char **argv, const char *prefix);
    @@ builtin/merge-octopus.c (new)
     +	if (repo_read_index(the_repository) < 0)
     +		die("corrupted cache");
     +
    -+	/* The first parameters up to -- are merge bases; the rest are
    -+	 * heads. */
    ++	/*
    ++	 * The first parameters up to -- are merge bases; the rest are
    ++	 * heads.
    ++	 */
     +	for (i = 1; i < argc; i++) {
     +		if (strcmp(argv[i], "--") == 0)
     +			sep_seen = 1;
    @@ builtin/merge-octopus.c (new)
     +		}
     +	}
     +
    -+	/* Reject if this is not an octopus -- resolve should be used
    -+	 * instead. */
    ++	/*
    ++	 * Reject if this is not an octopus -- resolve should be used
    ++	 * instead.
    ++	 */
     +	if (commit_list_count(remotes) < 2)
     +		return 2;
     +
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +		int can_ff = 1;
     +
     +		if (ret) {
    -+			/* We allow only last one to have a
    -+			   hand-resolvable conflicts.  Last round failed
    -+			   and we still had a head to merge. */
    ++			/*
    ++			 * We allow only last one to have a
    ++			 * hand-resolvable conflicts.  Last round failed
    ++			 * and we still had a head to merge.
    ++			 */
     +			puts(_("Automated merge did not work."));
     +			puts(_("Should not be doing an octopus."));
     +
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +		}
     +
     +		if (!non_ff_merge && can_ff) {
    -+			/* The first head being merged was a
    -+			   fast-forward.  Advance the reference commit
    -+			   to the head being merged, and use that tree
    -+			   as the intermediate result of the merge.  We
    -+			   still need to count this as part of the
    -+			   parent set. */
    ++			/*
    ++			 * The first head being merged was a
    ++			 * fast-forward.  Advance the reference commit
    ++			 * to the head being merged, and use that tree
    ++			 * as the intermediate result of the merge.  We
    ++			 * still need to count this as part of the
    ++			 * parent set.
    ++			 */
     +			struct object_id oids[2];
     +			printf(_("Fast-forwarding to: %s\n"), branch_name);
     +
 8:  cd0662201d =  8:  8f6c1ac057 merge: use the "resolve" strategy without forking
 9:  0525ff0183 =  9:  b1125261d1 merge: use the "octopus" strategy without forking
10:  6fbf599ba4 = 10:  8d0932fd02 sequencer: use the "resolve" strategy without forking
11:  2c2dc3cc62 = 11:  e304723957 sequencer: use the "octopus" merge strategy without forking
-- 
2.28.0.662.ge304723957

