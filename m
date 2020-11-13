Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D897FC63697
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5787422240
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxUlJCEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgKMMKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgKMMKt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:10:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE432C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:10:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p1so9570683wrf.12
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hhKrtQqTJQmLylTT1wapAZFkErmrFhjqdJ0hszey5u8=;
        b=PxUlJCErvqNQ+sb8GILsC7UI0L/wLz+xpnPLWI6D/Ur8IjLwL86iCGEhNEBXZ/8iCM
         RGwIcSjmrk8rmi40rRL76+HbESy5p29QLqnY576e7h7GgUJ85P0i/x6sm4Rd8Zo1SH6U
         FgVJCu+pNPVBaDttmDqd3rGpWo7fCWwf11RyP7Gdn2fqLuRD5lmYJ/Lr5DPrg3XE1OB4
         DEPaSTpJHugvE1OyYUTgVGhwlsIMOI0sgMCQgFzxDQN+/hN/yTp1fwVzwa87ACr9F49k
         BrRbAa/B6ecnHIsx7fbl6fJaPVWRnNaPqauekG9umgiqjGX/0pPZAv+i+diulq/RZyR0
         GOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hhKrtQqTJQmLylTT1wapAZFkErmrFhjqdJ0hszey5u8=;
        b=om7EJRJtN1Nt4D/2f/uJ3T1r0s78zYoNtRJRtYPWD762zKCaV54K3y9L0TZbVaoz33
         ncX2VNDY1u2uRbyvKojnolT/5hs+EExkqK1EaD9Vo6V04IOHhKFJb9No1yPyr9Y08dkv
         ZeSkcC3C4lM+lfIZKdoYznPDMYihWTrBQKFHip9x/ASYbhcd8dGCNmJP4VwpiT/F2Nf9
         izM6jJdB0Bow/j7Lk9HRK4fA46rGx/8qtZiyTotwWISFQboNyE+/425px5QUrFAZk/+y
         wd0plkXdQzQQfiDR9i8ceqMmOlPmwJwKR9ZnBPX4DGNrgfDTMbOWfPIWTVSvQuL8IE7Z
         BPOA==
X-Gm-Message-State: AOAM530klWkXFqHK8Gm9DakmGTKoIhjF6XB8aOdSpLKzB7OK4x8TIHoA
        a9VUkMdAxZq+Misnqr4O8awSm/hMsCQ=
X-Google-Smtp-Source: ABdhPJwWIj9JZPhU+TNvz7ZsPoLmtMnEltDDG2gNFUAOr5lJm2g5gRVUfidXqxZ1M6085zeYZiUmcQ==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr3076807wru.362.1605269446232;
        Fri, 13 Nov 2020 04:10:46 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id g138sm10083697wme.39.2020.11.13.04.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:10:45 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 00/12] Rewrite the remaining merge strategies from shell to C
Date:   Fri, 13 Nov 2020 12:04:16 +0100
Message-Id: <20201113110428.21265-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
References: <20201005122646.27994-1-alban.gruin@gmail.com>
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
tip is tagged as "rewrite-merge-strategies-v4" at
https://github.com/agrn/git.

Changes since v3:

 - [2/12] Move add_cacheinfo() to read-cache.c and rename it
   add_to_index_cacheinfo().  That way, there is no need to copy it to
   merge-strategies.c.  It also returns the new cache entry.

 - [3/12] Changed SHA1 to "object name" in the comments

 - [3/12] Error out if an object was not specified but a corresponding
   mode was.

 - [3/12] Add a cache entry parameter to checkout_from_index() to avoid
   calling index_file_exists(), as all of its callers now have the new
   cache entry thanks to add_to_index_cacheinfo().

 - [3/12] Replace ll_merge() with xdl_merge() in do_merge_one_file().

 - [3/12] Fail earlier in the case of a permission conflict in
   do_merge_one_file().

 - [3/12] Use `our_mode' instead of fetching a cache entry to define the
   mode of a merged file in do_merge_one_file().

 - [3/12] Rename merge_strategies_one_file() to merge_three_way().

 - [3/12] Reformatted a long chain of if/else if/else blocks.

 - [4/12] Rename merge_all() to merge_all_index(), merge_one_path() by
   merge_index_path(), merge_program_cb() to merge_one_file_spawn(),
   `merge_cb' to `merge_fn', and the parameters `cb' to `fn'.

 - [4/12] Use oid_to_hex_r() instead of oid_to_hex() in
   merge_one_file_spawn().

 - [5/12] Rename merge_one_file_cb() to merge_one_file_func().

 - [6/12, 8/12] Enable `USE_THE_INDEX_COMPATIBILITY_MACROS' and use
   read_cache() instead of repo_read_index().

 - [6/12] The parameter parsing has been rewritten to look less
   convoluted.

 - [6/12] Reformatted multi-line comments.

 - [7/12] Fixed multiple mistakes in the commit message.

 - [8/12] The parameters parsing has been rewritten to look more like
   builtin/merge-resolve.c.

 - [3/12, 6/12, 8/12] Removed obsolete informations from commit
   messages.

Alban Gruin (12):
  t6027: modernise tests
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
 builtin/merge-index.c           | 102 ++----
 builtin/merge-octopus.c         |  69 ++++
 builtin/merge-one-file.c        |  94 ++++++
 builtin/merge-recursive.c       |  16 +-
 builtin/merge-resolve.c         |  73 ++++
 builtin/merge.c                 |   9 +-
 builtin/update-index.c          |  25 +-
 cache.h                         |   7 +-
 git-merge-octopus.sh            | 112 -------
 git-merge-one-file.sh           | 167 ---------
 git-merge-resolve.sh            |  54 ---
 git.c                           |   3 +
 merge-strategies.c              | 576 ++++++++++++++++++++++++++++++++
 merge-strategies.h              |  43 +++
 merge.c                         |  12 +
 read-cache.c                    |  35 ++
 sequencer.c                     |  16 +-
 t/t6407-merge-binary.sh         |  27 +-
 t/t6415-merge-dir-to-symlink.sh |   2 +-
 21 files changed, 987 insertions(+), 465 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 create mode 100644 builtin/merge-one-file.c
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-octopus.sh
 delete mode 100755 git-merge-one-file.sh
 delete mode 100755 git-merge-resolve.sh
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

Range-diff against v3:
 1:  08c7df596a =  1:  08c7df596a t6027: modernise tests
 -:  ---------- >  2:  df237da758 update-index: move add_cacheinfo() to read-cache.c
 2:  ce911c99c0 !  3:  b64bad0d23 merge-one-file: rewrite in C
    @@ -10,22 +10,23 @@
         external processes are replaced by calls to functions in libgit.a:
     
          - calls to `update-index --add --cacheinfo' are replaced by calls to
    -       add_cache_entry();
    +       add_to_index_cacheinfo();
     
          - calls to `update-index --remove' are replaced by calls to
    -       remove_file_from_cache();
    +       remove_file_from_index();
     
          - calls to `checkout-index -u -f' are replaced by calls to
            checkout_entry();
     
          - calls to `unpack-file' and `merge-files' are replaced by calls to
    -       read_mmblob() and ll_merge(), respectively, to merge files
    +       read_mmblob() and xdl_merge(), respectively, to merge files
            in-memory;
     
    -     - calls to `checkout-index -f --stage=2' are replaced by calls to
    -       cache_file_exists();
    +     - calls to `checkout-index -f --stage=2' are removed, as this is needed
    +       to have the correct permission bits on the merged file from the
    +       script, but not in the C version;
     
    -     - calls to `update-index' are replaced by calls to add_file_to_cache().
    +     - calls to `update-index' are replaced by calls to add_file_to_index().
     
         The bulk of the rewrite is done in a new file in libgit.a,
         merge-strategies.c.  This will enable the resolve and octopus strategies
    @@ -96,9 +97,9 @@
     + *
     + * This is the git per-file merge utility, called with
     + *
    -+ *   argv[1] - original file SHA1 (or empty)
    -+ *   argv[2] - file in branch1 SHA1 (or empty)
    -+ *   argv[3] - file in branch2 SHA1 (or empty)
    ++ *   argv[1] - original file object name (or empty)
    ++ *   argv[2] - file in branch1 object name (or empty)
    ++ *   argv[3] - file in branch2 object name (or empty)
     + *   argv[4] - pathname in repository
     + *   argv[5] - original file mode (or empty)
     + *   argv[6] - file in branch1 mode (or empty)
    @@ -150,27 +151,29 @@
     +
     +	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
     +
    -+	if (!get_oid(argv[1], &orig_blob)) {
    ++	if (!get_oid_hex(argv[1], &orig_blob)) {
     +		p_orig_blob = &orig_blob;
     +		ret = read_mode("orig", argv[5], &orig_mode);
    -+	}
    ++	} else if (!*argv[1] && *argv[5])
    ++		ret = error(_("no 'orig' object id given, but a mode was still given."));
     +
    -+	if (!get_oid(argv[2], &our_blob)) {
    ++	if (!get_oid_hex(argv[2], &our_blob)) {
     +		p_our_blob = &our_blob;
     +		ret = read_mode("our", argv[6], &our_mode);
    -+	}
    ++	} else if (!*argv[2] && *argv[6])
    ++		ret = error(_("no 'our' object id given, but a mode was still given."));
     +
    -+	if (!get_oid(argv[3], &their_blob)) {
    ++	if (!get_oid_hex(argv[3], &their_blob)) {
     +		p_their_blob = &their_blob;
     +		ret = read_mode("their", argv[7], &their_mode);
    -+	}
    ++	} else if (!*argv[3] && *argv[7])
    ++		ret = error(_("no 'their' object id given, but a mode was still given."));
     +
     +	if (ret)
     +		return ret;
     +
    -+	ret = merge_strategies_one_file(the_repository,
    -+					p_orig_blob, p_our_blob, p_their_blob, argv[4],
    -+					orig_mode, our_mode, their_mode);
    ++	ret = merge_three_way(the_repository, p_orig_blob, p_our_blob, p_their_blob,
    ++			      argv[4], orig_mode, our_mode, their_mode);
     +
     +	if (ret) {
     +		rollback_lock_file(&lock);
    @@ -372,55 +375,25 @@
     @@
     +#include "cache.h"
     +#include "dir.h"
    -+#include "ll-merge.h"
     +#include "merge-strategies.h"
     +#include "xdiff-interface.h"
     +
    -+static int add_to_index_cacheinfo(struct index_state *istate,
    -+				  unsigned int mode,
    -+				  const struct object_id *oid, const char *path)
    -+{
    -+	struct cache_entry *ce;
    -+	int len, option;
    -+
    -+	if (!verify_path(path, mode))
    -+		return error(_("Invalid path '%s'"), path);
    -+
    -+	len = strlen(path);
    -+	ce = make_empty_cache_entry(istate, len);
    -+
    -+	oidcpy(&ce->oid, oid);
    -+	memcpy(ce->name, path, len);
    -+	ce->ce_flags = create_ce_flags(0);
    -+	ce->ce_namelen = len;
    -+	ce->ce_mode = create_ce_mode(mode);
    -+	if (assume_unchanged)
    -+		ce->ce_flags |= CE_VALID;
    -+	option = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
    -+	if (add_index_entry(istate, ce, option))
    -+		return error(_("%s: cannot add to the index"), path);
    -+
    -+	return 0;
    -+}
    -+
    -+static int checkout_from_index(struct index_state *istate, const char *path)
    ++static int checkout_from_index(struct index_state *istate, const char *path,
    ++			       struct cache_entry *ce)
     +{
     +	struct checkout state = CHECKOUT_INIT;
    -+	struct cache_entry *ce;
     +
     +	state.istate = istate;
     +	state.force = 1;
     +	state.base_dir = "";
     +	state.base_dir_len = 0;
     +
    -+	ce = index_file_exists(istate, path, strlen(path), 0);
     +	if (checkout_entry(ce, &state, NULL, NULL) < 0)
     +		return error(_("%s: cannot checkout file"), path);
     +	return 0;
     +}
     +
     +static int merge_one_file_deleted(struct index_state *istate,
    -+				  const struct object_id *orig_blob,
     +				  const struct object_id *our_blob,
     +				  const struct object_id *their_blob, const char *path,
     +				  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
    @@ -452,16 +425,15 @@
     +	ssize_t written;
     +	mmbuffer_t result = {NULL, 0};
     +	mmfile_t mmfs[3];
    -+	struct ll_merge_options merge_opts = {0};
    -+	struct cache_entry *ce;
    ++	xmparam_t xmp = {{0}};
     +
     +	if (our_mode == S_IFLNK || their_mode == S_IFLNK)
     +		return error(_("%s: Not merging symbolic link changes."), path);
     +	else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK)
     +		return error(_("%s: Not merging conflicting submodule changes."), path);
    -+
    -+	read_mmblob(mmfs + 1, our_blob);
    -+	read_mmblob(mmfs + 2, their_blob);
    ++	else if (our_mode != their_mode)
    ++		return error(_("permission conflict: %o->%o,%o in %s"),
    ++			     orig_mode, our_mode, their_mode, path);
     +
     +	if (orig_blob) {
     +		printf(_("Auto-merging %s\n"), path);
    @@ -471,12 +443,14 @@
     +		read_mmblob(mmfs + 0, &null_oid);
     +	}
     +
    -+	merge_opts.xdl_opts = XDL_MERGE_ZEALOUS_ALNUM;
    -+	ret = ll_merge(&result, path,
    -+		       mmfs + 0, "orig",
    -+		       mmfs + 1, "our",
    -+		       mmfs + 2, "their",
    -+		       istate, &merge_opts);
    ++	read_mmblob(mmfs + 1, our_blob);
    ++	read_mmblob(mmfs + 2, their_blob);
    ++
    ++	xmp.level = XDL_MERGE_ZEALOUS_ALNUM;
    ++	xmp.style = 0;
    ++	xmp.favor = 0;
    ++
    ++	ret = xdl_merge(mmfs + 0, mmfs + 1, mmfs + 2, &xmp, &result);
     +
     +	for (i = 0; i < 3; i++)
     +		free(mmfs[i].ptr);
    @@ -484,18 +458,13 @@
     +	if (ret < 0) {
     +		free(result.ptr);
     +		return error(_("Failed to execute internal merge"));
    ++	} else if (ret > 0 || !orig_blob) {
    ++		free(result.ptr);
    ++		return error(_("content conflict in %s"), path);
     +	}
     +
    -+	/*
    -+	 * Create the working tree file, using "our tree" version from
    -+	 * the index, and then store the result of the merge.
    -+	 */
    -+	ce = index_file_exists(istate, path, strlen(path), 0);
    -+	if (!ce)
    -+		BUG("file is not present in the cache?");
    -+
     +	unlink(path);
    -+	if ((dest = open(path, O_WRONLY | O_CREAT, ce->ce_mode)) < 0) {
    ++	if ((dest = open(path, O_WRONLY | O_CREAT, our_mode)) < 0) {
     +		free(result.ptr);
     +		return error_errno(_("failed to open file '%s'"), path);
     +	}
    @@ -508,49 +477,42 @@
     +	if (written < 0)
     +		return error_errno(_("failed to write to '%s'"), path);
     +
    -+	if (ret != 0 || !orig_blob)
    -+		ret = error(_("content conflict in %s"), path);
    -+	if (our_mode != their_mode)
    -+		return error(_("permission conflict: %o->%o,%o in %s"),
    -+			     orig_mode, our_mode, their_mode, path);
    -+	if (ret)
    -+		return -1;
    -+
     +	return add_file_to_index(istate, path, 0);
     +}
     +
    -+int merge_strategies_one_file(struct repository *r,
    -+			      const struct object_id *orig_blob,
    -+			      const struct object_id *our_blob,
    -+			      const struct object_id *their_blob, const char *path,
    -+			      unsigned int orig_mode, unsigned int our_mode,
    -+			      unsigned int their_mode)
    ++int merge_three_way(struct repository *r,
    ++		    const struct object_id *orig_blob,
    ++		    const struct object_id *our_blob,
    ++		    const struct object_id *their_blob, const char *path,
    ++		    unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
     +{
     +	if (orig_blob &&
     +	    ((!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
    -+	     (!our_blob && their_blob && oideq(orig_blob, their_blob))))
    ++	     (!our_blob && their_blob && oideq(orig_blob, their_blob)))) {
     +		/* Deleted in both or deleted in one and unchanged in the other. */
    -+		return merge_one_file_deleted(r->index,
    -+					      orig_blob, our_blob, their_blob, path,
    ++		return merge_one_file_deleted(r->index, our_blob, their_blob, path,
     +					      orig_mode, our_mode, their_mode);
    -+	else if (!orig_blob && our_blob && !their_blob) {
    ++	} else if (!orig_blob && our_blob && !their_blob) {
     +		/*
     +		 * Added in one.  The other side did not add and we
     +		 * added so there is nothing to be done, except making
     +		 * the path merged.
     +		 */
    -+		return add_to_index_cacheinfo(r->index, our_mode, our_blob, path);
    ++		return add_to_index_cacheinfo(r->index, our_mode, our_blob, path, 0, 1, 1, NULL);
     +	} else if (!orig_blob && !our_blob && their_blob) {
    ++		struct cache_entry *ce;
     +		printf(_("Adding %s\n"), path);
     +
     +		if (file_exists(path))
     +			return error(_("untracked %s is overwritten by the merge."), path);
     +
    -+		if (add_to_index_cacheinfo(r->index, their_mode, their_blob, path))
    ++		if (add_to_index_cacheinfo(r->index, their_mode, their_blob, path, 0, 1, 1, &ce))
     +			return -1;
    -+		return checkout_from_index(r->index, path);
    ++		return checkout_from_index(r->index, path, ce);
     +	} else if (!orig_blob && our_blob && their_blob &&
     +		   oideq(our_blob, their_blob)) {
    ++		struct cache_entry *ce;
    ++
     +		/* Added in both, identically (check for same permissions). */
     +		if (our_mode != their_mode)
     +			return error(_("File %s added identically in both branches, "
    @@ -559,15 +521,15 @@
     +
     +		printf(_("Adding %s\n"), path);
     +
    -+		if (add_to_index_cacheinfo(r->index, our_mode, our_blob, path))
    ++		if (add_to_index_cacheinfo(r->index, our_mode, our_blob, path, 0, 1, 1, &ce))
     +			return -1;
    -+		return checkout_from_index(r->index, path);
    -+	} else if (our_blob && their_blob)
    ++		return checkout_from_index(r->index, path, ce);
    ++	} else if (our_blob && their_blob) {
     +		/* Modified in both, but differently. */
     +		return do_merge_one_file(r->index,
     +					 orig_blob, our_blob, their_blob, path,
     +					 orig_mode, our_mode, their_mode);
    -+	else {
    ++	} else {
     +		char orig_hex[GIT_MAX_HEXSZ] = {0}, our_hex[GIT_MAX_HEXSZ] = {0},
     +			their_hex[GIT_MAX_HEXSZ] = {0};
     +
    @@ -595,12 +557,11 @@
     +
     +#include "object.h"
     +
    -+int merge_strategies_one_file(struct repository *r,
    -+			      const struct object_id *orig_blob,
    -+			      const struct object_id *our_blob,
    -+			      const struct object_id *their_blob, const char *path,
    -+			      unsigned int orig_mode, unsigned int our_mode,
    -+			      unsigned int their_mode);
    ++int merge_three_way(struct repository *r,
    ++		    const struct object_id *orig_blob,
    ++		    const struct object_id *our_blob,
    ++		    const struct object_id *their_blob, const char *path,
    ++		    unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode);
     +
     +#endif /* MERGE_STRATEGIES_H */
     
 3:  7f0999f5a3 !  4:  c5577dc691 merge-index: libify merge_one_path() and merge_all()
    @@ -9,11 +9,11 @@
         libgit.a, which means that once rewritten, the strategies would still
         have to invoke `merge-one-file' by spawning a new process first.
     
    -    To avoid this, this moves merge_one_path(), merge_all(), and their
    -    helpers to merge-strategies.c.  They also take a callback to dictate
    -    what they should do for each file.  For now, to preserve the behaviour
    -    of `merge-index', only one callback, launching a new process, is
    -    defined.
    +    To avoid this, this moves and renames merge_one_path(), merge_all(), and
    +    their helpers to merge-strategies.c.  They also take a callback to
    +    dictate what they should do for each file.  For now, to preserve the
    +    behaviour of `merge-index', only one callback, launching a new process,
    +    is defined.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
    @@ -103,15 +103,15 @@
      			}
      			if (!strcmp(arg, "-a")) {
     -				merge_all();
    -+				err |= merge_all(&the_index, one_shot, quiet,
    -+						 merge_program_cb, (void *)pgm);
    ++				err |= merge_all_index(&the_index, one_shot, quiet,
    ++						       merge_one_file_spawn, (void *)pgm);
      				continue;
      			}
      			die("git merge-index: unknown option %s", arg);
      		}
     -		merge_one_path(arg);
    -+		err |= merge_one_path(&the_index, one_shot, quiet, arg,
    -+				      merge_program_cb, (void *)pgm);
    ++		err |= merge_index_path(&the_index, one_shot, quiet, arg,
    ++					merge_one_file_spawn, (void *)pgm);
      	}
     -	if (err && !quiet)
     -		die("merge program failed");
    @@ -122,45 +122,49 @@
      --- a/merge-strategies.c
      +++ b/merge-strategies.c
     @@
    + #include "cache.h"
      #include "dir.h"
    - #include "ll-merge.h"
      #include "merge-strategies.h"
     +#include "run-command.h"
      #include "xdiff-interface.h"
      
    - static int add_to_index_cacheinfo(struct index_state *istate,
    + static int checkout_from_index(struct index_state *istate, const char *path,
     @@
      
      	return 0;
      }
     +
    -+int merge_program_cb(const struct object_id *orig_blob,
    -+		     const struct object_id *our_blob,
    -+		     const struct object_id *their_blob, const char *path,
    -+		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    -+		     void *data)
    ++int merge_one_file_spawn(const struct object_id *orig_blob,
    ++			 const struct object_id *our_blob,
    ++			 const struct object_id *their_blob, const char *path,
    ++			 unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    ++			 void *data)
     +{
    -+	char ownbuf[3][GIT_MAX_HEXSZ] = {{0}};
    -+	const char *arguments[] = { (char *)data, "", "", "", path,
    -+				    ownbuf[0], ownbuf[1], ownbuf[2],
    -+				    NULL };
    ++	char oids[3][GIT_MAX_HEXSZ + 1] = {{0}};
    ++	char modes[3][10] = {{0}};
    ++	const char *arguments[] = { (char *)data, oids[0], oids[1], oids[2],
    ++				    path, modes[0], modes[1], modes[2], NULL };
     +
    -+	if (orig_blob)
    -+		arguments[1] = oid_to_hex(orig_blob);
    -+	if (our_blob)
    -+		arguments[2] = oid_to_hex(our_blob);
    -+	if (their_blob)
    -+		arguments[3] = oid_to_hex(their_blob);
    ++	if (orig_blob) {
    ++		oid_to_hex_r(oids[0], orig_blob);
    ++		xsnprintf(modes[0], sizeof(modes[0]), "%06o", orig_mode);
    ++	}
     +
    -+	xsnprintf(ownbuf[0], sizeof(ownbuf[0]), "%o", orig_mode);
    -+	xsnprintf(ownbuf[1], sizeof(ownbuf[1]), "%o", our_mode);
    -+	xsnprintf(ownbuf[2], sizeof(ownbuf[2]), "%o", their_mode);
    ++	if (our_blob) {
    ++		oid_to_hex_r(oids[1], our_blob);
    ++		xsnprintf(modes[1], sizeof(modes[1]), "%06o", our_mode);
    ++	}
    ++
    ++	if (their_blob) {
    ++		oid_to_hex_r(oids[2], their_blob);
    ++		xsnprintf(modes[2], sizeof(modes[2]), "%06o", their_mode);
    ++	}
     +
     +	return run_command_v_opt(arguments, 0);
     +}
     +
     +static int merge_entry(struct index_state *istate, int quiet, int pos,
    -+		       const char *path, merge_cb cb, void *data)
    ++		       const char *path, merge_fn fn, void *data)
     +{
     +	int found = 0;
     +	const struct object_id *oids[3] = {NULL};
    @@ -179,7 +183,7 @@
     +	if (!found)
     +		return error(_("%s is not in the cache"), path);
     +
    -+	if (cb(oids[0], oids[1], oids[2], path, modes[0], modes[1], modes[2], data)) {
    ++	if (fn(oids[0], oids[1], oids[2], path, modes[0], modes[1], modes[2], data)) {
     +		if (!quiet)
     +			error(_("Merge program failed"));
     +		return -2;
    @@ -188,8 +192,8 @@
     +	return found;
     +}
     +
    -+int merge_one_path(struct index_state *istate, int oneshot, int quiet,
    -+		   const char *path, merge_cb cb, void *data)
    ++int merge_index_path(struct index_state *istate, int oneshot, int quiet,
    ++		     const char *path, merge_fn fn, void *data)
     +{
     +	int pos = index_name_pos(istate, path, strlen(path)), ret;
     +
    @@ -198,7 +202,7 @@
     +	 * already merged and there is nothing to do.
     +	 */
     +	if (pos < 0) {
    -+		ret = merge_entry(istate, quiet, -pos - 1, path, cb, data);
    ++		ret = merge_entry(istate, quiet, -pos - 1, path, fn, data);
     +		if (ret == -1)
     +			return -1;
     +		else if (ret == -2)
    @@ -207,8 +211,8 @@
     +	return 0;
     +}
     +
    -+int merge_all(struct index_state *istate, int oneshot, int quiet,
    -+	      merge_cb cb, void *data)
    ++int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    ++		    merge_fn fn, void *data)
     +{
     +	int err = 0, i, ret;
     +	for (i = 0; i < istate->cache_nr; i++) {
    @@ -216,7 +220,7 @@
     +		if (!ce_stage(ce))
     +			continue;
     +
    -+		ret = merge_entry(istate, quiet, i, ce->name, cb, data);
    ++		ret = merge_entry(istate, quiet, i, ce->name, fn, data);
     +		if (ret > 0)
     +			i += ret - 1;
     +		else if (ret == -1)
    @@ -236,24 +240,24 @@
      --- a/merge-strategies.h
      +++ b/merge-strategies.h
     @@
    - 			      unsigned int orig_mode, unsigned int our_mode,
    - 			      unsigned int their_mode);
    + 		    const struct object_id *their_blob, const char *path,
    + 		    unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode);
      
    -+typedef int (*merge_cb)(const struct object_id *orig_blob,
    ++typedef int (*merge_fn)(const struct object_id *orig_blob,
     +			const struct object_id *our_blob,
     +			const struct object_id *their_blob, const char *path,
     +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
     +			void *data);
     +
    -+int merge_program_cb(const struct object_id *orig_blob,
    -+		     const struct object_id *our_blob,
    -+		     const struct object_id *their_blob, const char *path,
    -+		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    -+		     void *data);
    ++int merge_one_file_spawn(const struct object_id *orig_blob,
    ++			 const struct object_id *our_blob,
    ++			 const struct object_id *their_blob, const char *path,
    ++			 unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    ++			 void *data);
     +
    -+int merge_one_path(struct index_state *istate, int oneshot, int quiet,
    -+		   const char *path, merge_cb cb, void *data);
    -+int merge_all(struct index_state *istate, int oneshot, int quiet,
    -+	      merge_cb cb, void *data);
    ++int merge_index_path(struct index_state *istate, int oneshot, int quiet,
    ++		     const char *path, merge_fn fn, void *data);
    ++int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    ++		    merge_fn fn, void *data);
     +
      #endif /* MERGE_STRATEGIES_H */
 4:  c0bc05406d !  5:  a0e6cebe89 merge-index: don't fork if the requested program is `git-merge-one-file'
    @@ -3,8 +3,8 @@
         merge-index: don't fork if the requested program is `git-merge-one-file'
     
         Since `git-merge-one-file' has been rewritten and libified, this teaches
    -    `merge-index' to call merge_strategies_one_file() without forking using
    -    a new callback, merge_one_file_cb().
    +    `merge-index' to call merge_three_way() without forking using a new
    +    callback, merge_one_file_func().
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
    @@ -22,7 +22,7 @@
      	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
      	const char *pgm;
     +	void *data;
    -+	merge_cb merge_action;
    ++	merge_fn merge_action;
     +	struct lock_file lock = LOCK_INIT;
      
      	/* Without this we cannot rely on waitpid() to tell
    @@ -34,13 +34,13 @@
     +
      	pgm = argv[i++];
     +	if (!strcmp(pgm, "git-merge-one-file")) {
    -+		merge_action = merge_one_file_cb;
    ++		merge_action = merge_one_file_func;
     +		data = (void *)the_repository;
     +
     +		setup_work_tree();
     +		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
     +	} else {
    -+		merge_action = merge_program_cb;
    ++		merge_action = merge_one_file_spawn;
     +		data = (void *)pgm;
     +	}
     +
    @@ -50,19 +50,19 @@
     @@
      			}
      			if (!strcmp(arg, "-a")) {
    - 				err |= merge_all(&the_index, one_shot, quiet,
    --						 merge_program_cb, (void *)pgm);
    -+						 merge_action, data);
    + 				err |= merge_all_index(&the_index, one_shot, quiet,
    +-						       merge_one_file_spawn, (void *)pgm);
    ++						       merge_action, data);
      				continue;
      			}
      			die("git merge-index: unknown option %s", arg);
      		}
    - 		err |= merge_one_path(&the_index, one_shot, quiet, arg,
    --				      merge_program_cb, (void *)pgm);
    -+				      merge_action, data);
    + 		err |= merge_index_path(&the_index, one_shot, quiet, arg,
    +-					merge_one_file_spawn, (void *)pgm);
    ++					merge_action, data);
     +	}
     +
    -+	if (merge_action == merge_one_file_cb) {
    ++	if (merge_action == merge_one_file_func) {
     +		if (err) {
     +			rollback_lock_file(&lock);
     +			return err;
    @@ -80,20 +80,20 @@
      	return 0;
      }
      
    -+int merge_one_file_cb(const struct object_id *orig_blob,
    -+		      const struct object_id *our_blob,
    -+		      const struct object_id *their_blob, const char *path,
    -+		      unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    -+		      void *data)
    ++int merge_one_file_func(const struct object_id *orig_blob,
    ++			const struct object_id *our_blob,
    ++			const struct object_id *their_blob, const char *path,
    ++			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    ++			void *data)
     +{
    -+	return merge_strategies_one_file((struct repository *)data,
    -+					 orig_blob, our_blob, their_blob, path,
    -+					 orig_mode, our_mode, their_mode);
    ++	return merge_three_way((struct repository *)data,
    ++			       orig_blob, our_blob, their_blob, path,
    ++			       orig_mode, our_mode, their_mode);
     +}
     +
    - int merge_program_cb(const struct object_id *orig_blob,
    - 		     const struct object_id *our_blob,
    - 		     const struct object_id *their_blob, const char *path,
    + int merge_one_file_spawn(const struct object_id *orig_blob,
    + 			 const struct object_id *our_blob,
    + 			 const struct object_id *their_blob, const char *path,
     
      diff --git a/merge-strategies.h b/merge-strategies.h
      --- a/merge-strategies.h
    @@ -102,12 +102,12 @@
      			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
      			void *data);
      
    -+int merge_one_file_cb(const struct object_id *orig_blob,
    -+		      const struct object_id *our_blob,
    -+		      const struct object_id *their_blob, const char *path,
    -+		      unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    -+		      void *data);
    ++int merge_one_file_func(const struct object_id *orig_blob,
    ++			const struct object_id *our_blob,
    ++			const struct object_id *their_blob, const char *path,
    ++			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    ++			void *data);
     +
    - int merge_program_cb(const struct object_id *orig_blob,
    - 		     const struct object_id *our_blob,
    - 		     const struct object_id *their_blob, const char *path,
    + int merge_one_file_spawn(const struct object_id *orig_blob,
    + 			 const struct object_id *our_blob,
    + 			 const struct object_id *their_blob, const char *path,
 5:  cbfe192982 !  6:  94fbc7e286 merge-resolve: rewrite in C
    @@ -17,12 +17,10 @@
            write_index_as_tree().
     
          - The call to `merge-index', needed to invoke `git merge-one-file', is
    -       replaced by a call to the new merge_all() function.  A callback
    -       function, merge_one_file_cb(), is added to allow it to call
    -       merge_one_file() without forking.
    +       replaced by a call to the new merge_all_index() function.
     
    -    Here too, the index is read in cmd_merge_resolve(), but
    -    merge_strategies_resolve() takes care of writing it back to the disk.
    +    The index is read in cmd_merge_resolve(), and is wrote back by
    +    merge_strategies_resolve().
     
         The parameters of merge_strategies_resolve() will be surprising at first
         glance: why using a commit list for `bases' and `remote', where we could
    @@ -83,6 +81,7 @@
     + * Resolve two trees, using enhanced multi-base read-tree.
     + */
     +
    ++#define USE_THE_INDEX_COMPATIBILITY_MACROS
     +#include "cache.h"
     +#include "builtin.h"
     +#include "merge-strategies.h"
    @@ -92,7 +91,7 @@
     +
     +int cmd_merge_resolve(int argc, const char **argv, const char *prefix)
     +{
    -+	int i, is_baseless = 1, sep_seen = 0;
    ++	int i, sep_seen = 0;
     +	const char *head = NULL;
     +	struct commit_list *bases = NULL, *remote = NULL;
     +	struct commit_list **next_base = &bases;
    @@ -101,42 +100,45 @@
     +		usage(builtin_merge_resolve_usage);
     +
     +	setup_work_tree();
    -+	if (repo_read_index(the_repository) < 0)
    ++	if (read_cache() < 0)
     +		die("invalid index");
     +
    -+	/* The first parameters up to -- are merge bases; the rest are
    -+	 * heads. */
    ++	/*
    ++	 * The first parameters up to -- are merge bases; the rest are
    ++	 * heads.
    ++	 */
     +	for (i = 1; i < argc; i++) {
    -+		if (strcmp(argv[i], "--") == 0)
    ++		if (!strcmp(argv[i], "--"))
     +			sep_seen = 1;
    -+		else if (strcmp(argv[i], "-h") == 0)
    ++		else if (!strcmp(argv[i], "-h"))
     +			usage(builtin_merge_resolve_usage);
     +		else if (sep_seen && !head)
     +			head = argv[i];
    -+		else if (remote) {
    -+			/* Give up if we are given two or more remotes.
    -+			 * Not handling octopus. */
    -+			return 2;
    -+		} else {
    ++		else {
     +			struct object_id oid;
    ++			struct commit *commit;
     +
    -+			get_oid(argv[i], &oid);
    -+			is_baseless &= sep_seen;
    ++			if (get_oid(argv[i], &oid))
    ++				die("object %s not found.", argv[i]);
     +
    -+			if (!oideq(&oid, the_hash_algo->empty_tree)) {
    -+				struct commit *commit;
    -+				commit = lookup_commit_or_die(&oid, argv[i]);
    ++			commit = lookup_commit_or_die(&oid, argv[i]);
     +
    -+				if (sep_seen)
    -+					commit_list_append(commit, &remote);
    -+				else
    -+					next_base = commit_list_append(commit, next_base);
    -+			}
    ++			if (sep_seen)
    ++				commit_list_insert(commit, &remote);
    ++			else
    ++				next_base = commit_list_append(commit, next_base);
     +		}
     +	}
     +
    ++	/*
    ++	 * Give up if we are given two or more remotes.  Not handling
    ++	 * octopus.
    ++	 */
    ++	if (remote && remote->next)
    ++		return 2;
    ++
     +	/* Give up if this is a baseless merge. */
    -+	if (is_baseless)
    ++	if (!bases)
     +		return 2;
     +
     +	return merge_strategies_resolve(the_repository, bases, head, remote);
    @@ -221,14 +223,13 @@
      #include "cache.h"
     +#include "cache-tree.h"
      #include "dir.h"
    - #include "ll-merge.h"
     +#include "lockfile.h"
      #include "merge-strategies.h"
      #include "run-command.h"
     +#include "unpack-trees.h"
      #include "xdiff-interface.h"
      
    - static int add_to_index_cacheinfo(struct index_state *istate,
    + static int checkout_from_index(struct index_state *istate, const char *path,
     @@
      
      	return err;
    @@ -303,7 +304,7 @@
     +
     +		puts(_("Simple merge failed, trying Automatic merge."));
     +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+		ret = merge_all(r->index, 0, 0, merge_one_file_cb, r);
    ++		ret = merge_all_index(r->index, 0, 0, merge_one_file_func, r);
     +
     +		write_locked_index(r->index, &lock, COMMIT_LOCK);
     +		return !!ret;
    @@ -326,10 +327,10 @@
     +#include "commit.h"
      #include "object.h"
      
    - int merge_strategies_one_file(struct repository *r,
    + int merge_three_way(struct repository *r,
     @@
    - int merge_all(struct index_state *istate, int oneshot, int quiet,
    - 	      merge_cb cb, void *data);
    + int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    + 		    merge_fn fn, void *data);
      
     +int merge_strategies_resolve(struct repository *r,
     +			     struct commit_list *bases, const char *head_arg,
 6:  35e386f626 !  7:  b582b7e5d1 merge-recursive: move better_branch_name() to merge.c
    @@ -2,8 +2,8 @@
     
         merge-recursive: move better_branch_name() to merge.c
     
    -    get_better_branch_name() will be used by rebase-octopus once it is
    -    rewritten in C, so instead of duplicating it, this moves this function
    +    better_branch_name() will be used by merge-octopus once it is rewritten
    +    in C, so instead of duplicating it, this moves this function
         preventively inside an appropriate file in libgit.a.  This function is
         also renamed to reflect its usage by merge strategies.
     
 7:  41eb0f7199 !  8:  d1936645d5 merge-octopus: rewrite in C
    @@ -13,11 +13,10 @@
            write_index_as_tree().
     
          - The call to `diff-index ...' is replaced by a call to
    -       repo_index_has_changes(), and is moved from cmd_merge_octopus() to
    -       merge_octopus().
    +       repo_index_has_changes().
     
          - The call to `merge-index', needed to invoke `git merge-one-file', is
    -       replaced by a call to merge_all().
    +       replaced by a call to merge_all_index().
     
         The index is read in cmd_merge_octopus(), and is wrote back by
         merge_strategies_octopus().
    @@ -75,6 +74,7 @@
     + * Resolve two or more trees.
     + */
     +
    ++#define USE_THE_INDEX_COMPATIBILITY_MACROS
     +#include "cache.h"
     +#include "builtin.h"
     +#include "commit.h"
    @@ -94,8 +94,8 @@
     +		usage(builtin_merge_octopus_usage);
     +
     +	setup_work_tree();
    -+	if (repo_read_index(the_repository) < 0)
    -+		die("corrupted cache");
    ++	if (read_cache() < 0)
    ++		die("invalid index");
     +
     +	/*
     +	 * The first parameters up to -- are merge bases; the rest are
    @@ -110,18 +110,17 @@
     +			head_arg = argv[i];
     +		else {
     +			struct object_id oid;
    ++			struct commit *commit;
     +
    -+			get_oid(argv[i], &oid);
    ++			if (get_oid(argv[i], &oid))
    ++				die("object %s not found.", argv[i]);
     +
    -+			if (!oideq(&oid, the_hash_algo->empty_tree)) {
    -+				struct commit *commit;
    -+				commit = lookup_commit_or_die(&oid, argv[i]);
    ++			commit = lookup_commit_or_die(&oid, argv[i]);
     +
    -+				if (sep_seen)
    -+					next_remote = commit_list_append(commit, next_remote);
    -+				else
    -+					next_base = commit_list_append(commit, next_base);
    -+			}
    ++			if (sep_seen)
    ++				next_remote = commit_list_append(commit, next_remote);
    ++			else
    ++				next_base = commit_list_append(commit, next_base);
     +		}
     +	}
     +
    @@ -273,8 +272,8 @@
      #include "cache-tree.h"
     +#include "commit-reach.h"
      #include "dir.h"
    - #include "ll-merge.h"
      #include "lockfile.h"
    + #include "merge-strategies.h"
     @@
      	rollback_lock_file(&lock);
      	return 2;
    @@ -463,7 +462,7 @@
     +
     +				puts(_("Simple merge did not work, trying automatic merge."));
     +				repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+				ret = !!merge_all(r->index, 0, 0, merge_one_file_cb, r);
    ++				ret = !!merge_all_index(r->index, 0, 0, merge_one_file_func, r);
     +				write_locked_index(r->index, &lock, COMMIT_LOCK);
     +
     +				write_tree(r, &next);
 8:  8f6c1ac057 =  9:  26b1a3979c merge: use the "resolve" strategy without forking
 9:  b1125261d1 = 10:  23bc9824df merge: use the "octopus" strategy without forking
10:  8d0932fd02 = 11:  3a340f5984 sequencer: use the "resolve" strategy without forking
11:  e304723957 = 12:  ce3723cf34 sequencer: use the "octopus" merge strategy without forking
-- 
2.20.1

