Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35A353A95
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470866; cv=none; b=BDBc8zS5wnPMA/Xui/VRR5cK01C5CDjAppizPUD7Z3QnAbpGemmUHQzJV2PUw51t6elDIxzKQkeF+8G5xMUWJAVtBK9/vV1SNkrPifdhslksQLhvY0YceEcQZaPJ8i68deMFNv+GzzVsSbmNpLKQP1NngILiEv6QorxvlJ0dYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470866; c=relaxed/simple;
	bh=lj/I0BHJXO8Y/J/xVNSgIHGhoPpRrXdGTZY/Ljmla4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3Tsg0x1XZo5ta0PflDgzWldMeI3LXYa61tHxBT42iJNU1P5YLSOwK7monqOdxgk6p25bL+uyvog/s8/mKVXrmpVgkWAJazJhfa/r4Wi8XmeMZxZUAX5aOeEjShezikjyGcd75+3sF26YMtS7oJiqgtrx6TYsaZLH2u+lrMTE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXjGpY24; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXjGpY24"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44cb057311bso27536fac.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470863; x=1787075663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNhJ9/j9bomucNM0CfmwFcfBaRfDvCxwupieHGtGNt4=;
        b=kXjGpY24H7T2rRFB11fDq1VodsJUWY49G75wQfhxqR9dSh2yStItEzqzhlulDkTRjI
         vMHi3jLw2Tz36lgEkbDQmGrLLUlIdoyi20nFU9lrgH0K+lSQUT3b7Nhc5LMeDuD9OzzI
         Y0mDRg+2wYvqcbvVXbRQ3HTjSVrgZbbmPOpqepfXeTtlkqwmANgD1EAslVn0dzDlu0IG
         tjbcvs1HJfjcV/cWNyH4VzkLwmV5FnYL/zOHmEKgkzo6vAzzR9W2vBHowh4cuJl6Q5gA
         74LNaTxGuxkWS9DRKzlYTyU5x/wRGTRhMk9zf4vwXk2GWJpzeB5XQKtPvgr6rfTRDxfo
         TAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470863; x=1787075663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hNhJ9/j9bomucNM0CfmwFcfBaRfDvCxwupieHGtGNt4=;
        b=NoN6wiHF+WVLKMp0lizElXjqrpZg9IsxXyvY37dHTo6YZ5BEF8W4vRExC4BQNc2Rvq
         YBb5N9ph1DvEFn0Nt5pu4t4WUjIep2LXuepl1FVpCZrPvTN9ed0fwzNNot359UlHOFWA
         4L9jKPJNoE0FWkulOJS3Hl2XwzkgQj0qkAp6PvI8qaPqT4nQ4sUw73lbObLCDTy22Md3
         loIByzoTJvMh/U7VVXfiMi14LZcnZHBc9gL/j7/zFdCF2Fr7RFl4xxhqjqwjYK9GH0oE
         jcWp4olMuH7stz3XoluRKjZCJQ6HJQJGklz7CUvYAWP/xhHg3JHSRezUeI6nAfdHtLfT
         tZ/Q==
X-Gm-Message-State: AOJu0YyGIlnU591uzGoXw/4Hku1KoZT1IPM39cEJU3xf2c/Hiolbx+Ot
	xcvcqcxIUwu8lvLbqx56cHyDg+UTvny4tJ2dCfDw4aQ8EeynrSwPttsfehzIvQ==
X-Gm-Gg: AR+sD11QLF/oSrJo1OZvx6Fpx8IYj95VgEA+QNxUKhKk65U0+mz+ByqLgB/aB0WNcK8
	FLN287qz6qt2HGtprKc1lnnMcjxgT+G+eDkrxtc2abbOQhiMIDBRAv6/3sSQxjY/26MExV21Aj3
	t1PrlY3VIDrnjTWyKYWfL1TjtlGXnD96kIICL2dcTRjc4XbeLo7KFeNAEjGq0KD0CY+4LTf2gHR
	2uTy5AjG4PZlXrIqqmO9CLEHGJnmeDK1CiQVVwDTJdvAbc1xmdGtaeVMAH/bQQLMwCiPc5AglB5
	ns1+u4odKh2iUgm0aV5P3XULnArmGhrwPSj24uB9X5+we5SSGf6wZjFp2zJCwjB0Bxl+osnYgDl
	ALfpkPiEYZ2xA8knZIke2FA0n4WkqvxgcdIdZv9OuIHJCeZM4qoI2kBjimt7WPqNala0xOc/6jl
	ZVY8GvNhhOzex7P0zugPJ9dbnQHAqDrjeM0FG8Tlii50XYsVLLJOnxNHVblhKVHQmhrQUwac7ag
	cc6hwI=
X-Received: by 2002:a05:6808:1996:b0:495:f74a:b572 with SMTP id 5614622812f47-4b209aa84c5mr1297847b6e.5.1786470863126;
        Tue, 11 Aug 2026 10:54:23 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2001331d2sm1241489b6e.11.2026.08.11.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:54:22 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/9] builtin/receive-pack: support pluggable packfile writes
Date: Tue, 11 Aug 2026 12:54:06 -0500
Message-ID: <20260811175415.2044235-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260809190106.1565882-1-jltobler@gmail.com>
References: <20260809190106.1565882-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

With bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
transactions, 2026-07-10), git-receive-pack(1) started using the ODB
transaction interfaces to stage incoming objects. While this brought the
command closer to being ODB backend agnostic, the underlying
git-index-pack(1) and git-unpack-objects(1) processes used to actually
write the objects to the transaction are still fundamentally tied to the
"files" backend.

This series aims to address this by introducing a generic
`odb_transaction_write_pack()` transaction interface to handle writing
the incoming packfile to the transaction. The existing logic in
git-receive-pack(1) that spawns the child processes to write the
packfile becomes the "files" backend implementation of this interface.

Changes since V2:
- Added a patch to address a bug causing ".keep" files from not being
  removed.
- Started handling errors at transaction commit and finalize call sites
  instead of ignoring them. We also make sure
  `odb_transaction_finalize()` runs after every successful commit
  callsite to ensure proper cleanup.
- Updated the code handling lazy loading of unpack limit configuration
  to not longer cache the value.
- Added a patch to begin explictly tracking the ODB source used by the
  "files" transaction to avoid relying on the ordering of the ODB source
  list.
- Updated some commit messages to improve clarity.

Changes since V1:
- Changed the "release" interface name to "finalize" and updated it to
  return error codes.
- Marked some function parameters as const.
- Unpack limit configuration is now resolved in the ODB transaction
  backend instead of wiring it through the interface.
- When writing a packfile to the transaction, now only the transaction
  source is prepared.
- Updated some commit messages.
- Updated some code formatting.

Thanks for the review,
-Justin

Justin Tobler (9):
  builtin/receive-pack: properly clean up keep files
  odb/transaction: add transaction finalize interface
  builtin/receive-pack: pass shallow file explicitly
  builtin/receive-pack: read unpack limit config lazily
  builtin/receive-pack: lift global state out of unpack()
  builtin/receive-pack: report unpack errors via strbuf
  builtin/receive-pack: explicitly pass packfile fd
  odb: return temporary ODB source when set
  odb/transaction: add transaction interface to write packfiles

 builtin/add.c              |   4 +-
 builtin/receive-pack.c     | 211 ++++++++-----------------------------
 builtin/unpack-objects.c   |   2 +-
 builtin/update-index.c     |   4 +-
 cache-tree.c               |   2 +-
 fetch-pack.c               |   2 +-
 object-file.c              | 177 ++++++++++++++++++++++++++++++-
 odb.c                      |   9 +-
 odb.h                      |   6 +-
 odb/transaction.c          |  21 ++++
 odb/transaction.h          |  85 +++++++++++++++
 pack-write.c               |   7 +-
 pack.h                     |   4 +-
 read-cache.c               |   2 +-
 t/t5547-push-quarantine.sh |  14 +++
 tmp-objdir.c               |   8 +-
 tmp-objdir.h               |   6 +-
 17 files changed, 376 insertions(+), 188 deletions(-)

Range-diff against v2:
 -:  ---------- >  1:  58569303f9 builtin/receive-pack: properly clean up keep files
 1:  10efcc22e4 !  2:  dba9696866 odb/transaction: add transaction finalize interface
    @@ Commit message
         `odb_transaction_finalize()` call site in git-receive-pack(1) is made
         after the reference updates are finished.
     
    +    All other callers commit a transaction and immediately finalize it with
    +    no work in between and cannot meaningfully recover should either step
    +    fail, so introduce an `odb_transaction_commit_and_finalize_or_die()`
    +    helper that performs both and dies on error. Call sites are updated
    +    accordingly.
    +
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## builtin/add.c ##
    @@ builtin/add.c: int cmd_add(int argc,
      	repo_config(repo, add_config, NULL);
      
     @@ builtin/add.c: int cmd_add(int argc,
    - 	free(ps_matched);
    - 	dir_clear(&dir);
    - 	clear_pathspec(&pathspec);
    -+	odb_transaction_finalize(transaction);
    - 	return exit_status;
    - }
    + 
    + 	if (chmod_arg && pathspec.nr)
    + 		exit_status |= chmod_pathspec(repo, &pathspec, chmod_arg[0], show_only);
    +-	odb_transaction_commit(transaction);
    ++	odb_transaction_commit_and_finalize_or_die(transaction);
    + 
    + finish:
    + 	if (write_locked_index(repo->index, &lock_file,
     
      ## builtin/receive-pack.c ##
     @@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
    @@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
     
      ## builtin/unpack-objects.c ##
     @@ builtin/unpack-objects.c: static void unpack_all(void)
    + 		unpack_one(i);
      		display_progress(progress, i + 1);
      	}
    - 	odb_transaction_commit(transaction);
    -+	odb_transaction_finalize(transaction);
    +-	odb_transaction_commit(transaction);
    ++	odb_transaction_commit_and_finalize_or_die(transaction);
      	stop_progress(&progress);
      
      	if (delta_list)
     
      ## builtin/update-index.c ##
     @@ builtin/update-index.c: int cmd_update_index(int argc,
    + 			 * a transaction.
      			 */
      			if (transaction && verbose) {
    - 				odb_transaction_commit(transaction);
    -+				odb_transaction_finalize(transaction);
    +-				odb_transaction_commit(transaction);
    ++				odb_transaction_commit_and_finalize_or_die(transaction);
      				transaction = NULL;
      			}
      
     @@ builtin/update-index.c: int cmd_update_index(int argc,
    + 	/*
      	 * By now we have added all of the new objects
      	 */
    - 	odb_transaction_commit(transaction);
    -+	odb_transaction_finalize(transaction);
    +-	odb_transaction_commit(transaction);
    ++	odb_transaction_commit_and_finalize_or_die(transaction);
      
      	if (split_index > 0) {
      		if (repo_config_get_split_index(the_repository) == 0)
     
      ## cache-tree.c ##
     @@ cache-tree.c: int cache_tree_update(struct index_state *istate, int flags)
    - 		odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
      	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
      		       "", 0, &skip, flags);
    --	if (!inflight)
    -+	if (!inflight) {
    - 		odb_transaction_commit(transaction);
    -+		odb_transaction_finalize(transaction);
    -+	}
    + 	if (!inflight)
    +-		odb_transaction_commit(transaction);
    ++		odb_transaction_commit_and_finalize_or_die(transaction);
      	trace2_region_leave("cache_tree", "update", istate->repo);
      	trace_performance_leave("cache_tree_update");
      	if (i < 0)
     
      ## object-file.c ##
     @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    - 								  &stream,
      								  xsize_t(st->st_size),
      								  oid);
    --			if (!inflight)
    -+			if (!inflight) {
    - 				odb_transaction_commit(transaction);
    -+				odb_transaction_finalize(transaction);
    -+			}
    + 			if (!inflight)
    +-				odb_transaction_commit(transaction);
    ++				odb_transaction_commit_and_finalize_or_die(transaction);
      		} else {
      			ret = hash_blob_stream(&stream,
      					       the_repository->hash_algo, oid,
    @@ odb/transaction.h: static inline void odb_transaction_begin_or_die(struct object
     + * a negative error code otherwise.
     + */
     +int odb_transaction_finalize(struct odb_transaction *transaction);
    ++
    ++static inline void odb_transaction_commit_and_finalize_or_die(struct odb_transaction *transaction)
    ++{
    ++	if (odb_transaction_commit(transaction))
    ++		die(_("failed to commit ODB transaction"));
    ++	if (odb_transaction_finalize(transaction))
    ++		die(_("failed to finalize ODB transaction"));
    ++}
     +
      /*
       * Writes the object in the provided stream into the transaction. The resulting
    @@ odb/transaction.h: static inline void odb_transaction_begin_or_die(struct object
     
      ## read-cache.c ##
     @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix,
    - 	if (!inflight)
      		odb_transaction_begin_or_die(repo->objects, &transaction, 0);
      	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
    --	if (!inflight)
    -+	if (!inflight) {
    - 		odb_transaction_commit(transaction);
    -+		odb_transaction_finalize(transaction);
    -+	}
    + 	if (!inflight)
    +-		odb_transaction_commit(transaction);
    ++		odb_transaction_commit_and_finalize_or_die(transaction);
      
      	release_revisions(&rev);
      	return !!data.add_errors;
 2:  e1903ac32f =  3:  09bc00a070 builtin/receive-pack: pass shallow file explicitly
 3:  e4950c0abe !  4:  2586ea4041 builtin/receive-pack: read unpack limit config lazily
    @@ builtin/receive-pack.c: static void push_header_arg(struct strvec *args, struct
      		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
      }
      
    -+static int get_unpack_limit(struct repository *repo)
    ++static unsigned int get_unpack_limit(struct repository *repo)
     +{
    -+	static int limit = -1;
    ++	unsigned int limit = 100;
     +
    -+	if (limit < 0) {
    -+		int receive_limit = -1;
    -+		int transfer_limit = -1;
    -+
    -+		repo_config_get_int(repo, "receive.unpacklimit",
    -+				    &receive_limit);
    -+		repo_config_get_int(repo, "transfer.unpacklimit",
    -+				    &transfer_limit);
    -+
    -+		if (receive_limit >= 0)
    -+			limit = receive_limit;
    -+		else if (transfer_limit >= 0)
    -+			limit = transfer_limit;
    -+		else
    -+			limit = 100;
    -+	}
    ++	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
    ++	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
     +
     +	return limit;
     +}
 4:  c9b4ff73ba !  5:  adf325095e builtin/receive-pack: lift global state out of unpack()
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## builtin/receive-pack.c ##
    -@@ builtin/receive-pack.c: static int get_unpack_limit(struct repository *repo)
    +@@ builtin/receive-pack.c: static unsigned int get_unpack_limit(struct repository *repo)
      	return limit;
      }
      
 5:  7be990c2c2 !  6:  29f407bf36 builtin/receive-pack: report unpack errors via strbuf
    @@ builtin/receive-pack.c: static const char *unpack(struct odb_transaction *transa
     +			return -1;
     +		}
      
    - 		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
    - 		if (lockfile) {
    + 		/*
    + 		 * The lockfile filepath is expected to be the final location of
     @@ builtin/receive-pack.c: static const char *unpack(struct odb_transaction *transaction,
      		close(child.out);
      
 6:  742c724943 =  7:  b85f5e868c builtin/receive-pack: explicitly pass packfile fd
 -:  ---------- >  8:  620eafe035 odb: return temporary ODB source when set
 7:  7743cf242a !  9:  2e75a8bd6c odb/transaction: add transaction interface to write packfiles
    @@ Commit message
     
         Introduce `odb_transaction_write_pack()` as a generic interface to
         handle writing a packfile to a transaction and use the logic from
    -    `unpack()` as the "files" backend implementation. Note that a packfile
    -    written via git-index-pack(1) is kept in place by a ".keep" lockfile
    -    that must be retained until references are updated. To faciliate this in
    -    an ODB backend agnostic manner, the "files" transaction backend takes
    -    ownership of these lockfiles and removes them post-commit through its
    -    release callback.
    +    `unpack()` as the "files" backend implementation. Note that when storing
    +    the objects as a packfile, git-index-pack(1) also writes a ".keep"
    +    lockfile next to it to prevent a concurrent repack from removing the new
    +    pack prior to reference updates being performed. The "files" transaction
    +    backend is responsible for managing these ".keep" files and removes them
    +    post-commit once the transaction is finalized.
     
         Call sites in git-receive-pack(1) are updated accordingly.
     
    @@ builtin/receive-pack.c: static void read_push_options(struct packet_reader *read
     -		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
     -}
     -
    --static int get_unpack_limit(struct repository *repo)
    +-static unsigned int get_unpack_limit(struct repository *repo)
     -{
    --	static int limit = -1;
    +-	unsigned int limit = 100;
     -
    --	if (limit < 0) {
    --		int receive_limit = -1;
    --		int transfer_limit = -1;
    --
    --		repo_config_get_int(repo, "receive.unpacklimit",
    --				    &receive_limit);
    --		repo_config_get_int(repo, "transfer.unpacklimit",
    --				    &transfer_limit);
    --
    --		if (receive_limit >= 0)
    --			limit = receive_limit;
    --		else if (transfer_limit >= 0)
    --			limit = transfer_limit;
    --		else
    --			limit = 100;
    --	}
    +-	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
    +-	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
     -
     -	return limit;
     -}
    @@ builtin/receive-pack.c: static void read_push_options(struct packet_reader *read
     -			return -1;
     -		}
     -
    --		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
    +-		/*
    +-		 * The lockfile filepath is expected to be the final location of
    +-		 * the ".keep" file after being migrated to the main ODB source.
    +-		 * This ensures the lockfile can be found and removed later
    +-		 * after the ODB transaction has been committed.
    +-		 */
    +-		lockfile = index_pack_lockfile(transaction->source, child.out, NULL);
     -		if (lockfile) {
     -			pack_lockfile = register_tempfile(lockfile);
     -			free(lockfile);
    @@ object-file.c
      #include "strvec.h"
      #include "tempfile.h"
     @@ object-file.c: struct odb_transaction_files {
    - 	struct tmp_objdir *objdir;
    + 	struct odb_source *quarantine;
      	struct transaction_packfile packfile;
      	const char *prefix;
     +
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
     +		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
     +}
     +
    -+static int get_unpack_limit(struct repository *repo)
    ++static unsigned int get_unpack_limit(struct repository *repo)
     +{
    -+	static int limit = -1;
    -+
    -+	if (limit < 0) {
    -+		int receive_limit = -1;
    -+		int transfer_limit = -1;
    -+
    -+		repo_config_get_int(repo, "receive.unpacklimit",
    -+				    &receive_limit);
    -+		repo_config_get_int(repo, "transfer.unpacklimit",
    -+				    &transfer_limit);
    -+
    -+		if (receive_limit >= 0)
    -+			limit = receive_limit;
    -+		else if (transfer_limit >= 0)
    -+			limit = transfer_limit;
    -+		else
    -+			limit = 100;
    -+	}
    ++	unsigned int limit = 100;
    ++
    ++	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
    ++	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
     +
     +	return limit;
     +}
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
     +
     +	odb_transaction_env(base, &child.env);
     +
    -+	if (ntohl(hdr.hdr_entries) < (unsigned int)get_unpack_limit(repo)) {
    ++	if (ntohl(hdr.hdr_entries) < get_unpack_limit(repo)) {
     +		strvec_push(&child.args, "unpack-objects");
     +		push_header_arg(&child.args, &hdr);
     +		if (opts->quiet)
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
     +			return -1;
     +		}
     +
    -+		lockfile = index_pack_lockfile(repo, child.out, NULL);
    ++		/*
    ++		 * The lockfile filepath is expected to be the final location of
    ++		 * the ".keep" file after being migrated to the main ODB source.
    ++		 * This ensures the lockfile can be found and removed later
    ++		 * after the ODB transaction has been committed.
    ++		 */
    ++		lockfile = index_pack_lockfile(base->source, child.out, NULL);
     +		if (lockfile) {
     +			ALLOC_GROW(transaction->pack_lockfiles,
     +				   transaction->pack_lockfiles_nr + 1,
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
     +			return -1;
     +		}
     +
    -+		odb_source_prepare(repo->objects->sources,
    ++		odb_source_prepare(transaction->quarantine,
     +				   ODB_PREPARE_FLUSH_CACHES);
     +	}
     +
    @@ odb/transaction.h
     +	 * The max size in bytes of the incoming packfile allowed. No limit is
     +	 * enforced when set to 0.
     +	 */
    -+
     +	off_t max_input_size;
     +
     +	/*

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.424.g13c7afec21

