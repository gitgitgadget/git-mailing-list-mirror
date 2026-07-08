Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B729405
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484063; cv=none; b=UYfBC+kqmBiyRs/RbrC0y9Cz/N5vLNj42dgkkHF9HXLUFYyfgm4PI1Cd1uNA/UcM8ssRp6Qcw1qiLOe4BC/QsPYkZQBZDVQlRChjBmA0Ts7sIRHwzY7QGf/YeOSwQrLRv5j6Gbx1Z1yMnlMudBEQRnHoRPKXTIrD+4mfVe7ih0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484063; c=relaxed/simple;
	bh=U8+6SZc1dEkyS3JZ+LcHrspeKAa4Ft5M9YpKjYQ+M3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eg8nRNXexgf+pG7leN18ZpMJ04FdDD3CfLjeCdS2w4MoGc1JgXBMqOxf1NUytJMt6Qa98PJZRv4L7xix1Dh/Y2eYNPLZR5L9kZdNhOlpLx5SKDEH0p57/3VmYm7zlP8kQMOYMg72Sv2pmeCgi0OlE1E6WwPKw84z8DpwHbw80wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnt/F8Mr; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnt/F8Mr"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-49c86d1d21cso100613b6e.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484059; x=1784088859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC5CPBe/F1OjPYB0NKl3MV6B1b2jnGXnL+9guToiMCc=;
        b=rnt/F8MrphcCBLl12tzgKoPGcI6SBMj3jv1RAiytJs/Hc+FtZiE44Zmg75lcpPqvhN
         Y5iz7pnZwlTfJrcwo0KnTmO+ga7GF4Rh3UBvzb5gev44T60chxZg0RgREvrhULrofqmr
         F9FZFeZuJXh4gNM8py0Eau+GMcB5u5pPsY2nUHiCsGV/Bq1ONscQoxpW25gdvNJSl0I7
         BvtUGPb3I0yUuI4EbizjyuVGjPaSFpebweiLQmDJkTc0Vf7tKznkjsC+x3+LYOs6tJqb
         fZ735ksm/Zz52tFEgAbLRuI/MhBeXYG9Yrk4NehWnlA56T/XF5U3iZpPeNkWfR2+AqqW
         3zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484059; x=1784088859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FC5CPBe/F1OjPYB0NKl3MV6B1b2jnGXnL+9guToiMCc=;
        b=Gutfc8nJDXAXKzSwRbHE/vc2PtjFfdALObkLtrlUa9D6eqJMt6+VGcwXDRuh2GhCez
         zNXXz0dTaltDh4U7F6VlfoLHyDDOGfoXAjlP8NVjyx1aWbtDJ0jthRxbPyknyWWCzAtm
         yyzDMQ6tb6UJEMljqLV53KBxC9n72fPnRnNXnzOQtJW+cvpeL6fJcMoMVFitfZf1OFkg
         wQdrnoxhuv3+8P66Inq5/39qDzwy/29vKp04zA4clI0z+2A9y/JxcrC2pDkwcH5XhqAu
         0IpUr0f4TOHvPElLBNj+m6dP9iU2dK09TQjkbwjenhhG7XV4Qa7/Mqap8jadXozR2rRI
         /QhA==
X-Gm-Message-State: AOJu0YzILEGaZoW1jeFOqxAdoHjQPALyPu7cJjMuDUcxnG3JbryCYRDw
	ZPF7KnoHW3KyAX5f4RRLlWQNGCRzIjrG9tcqCjrqjKJikhpc/dyCfbLu25adgA==
X-Gm-Gg: AfdE7clmrtSDXQtKPzTJd3lfk9tHNfSjNeyaAJumGawiklW9Dhfuu/ULlitlv87bYRC
	RQsvYiC1IB/APWWmxi+UOXPrK7mPB3UMNBjaASQpptBEN0HqMauoxQXfHWlhtZLt1qlX5QrSXLp
	Gj/rZ7AWEp0yeos5eci3pj+UFz+wHSunUfTL8lgnD620YwKyVRA5ZE6KOjDO1WjqB9xnqOntVUg
	+B+cpXCUjFOVU1PmsVzgV+N23pXqPIQgAQqdn0PBin8nH8Snru9CmzOCUxQToXP1RMysI43cUDL
	dxny+5dFme3X6Jj9HAZLIKLwIM2JRgLsq3uHNjOrpH7wZu+zysZpyH1HlJNzscXNOjtO32cGI63
	3lbyIiwmR3zA1ELT7ZDGD/jqQig0KxkiYPTcNCQbcZ5pv82Tv+N7wjjTIPLgJXN2tOiTv5TCfdi
	BQkRZs0cnHKd1zTD79dMea
X-Received: by 2002:a05:6808:2507:b0:495:ecd3:ba00 with SMTP id 5614622812f47-4a201bee9e3mr640298b6e.1.1783484058897;
        Tue, 07 Jul 2026 21:14:18 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:18 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 00/11] receive-pack: use ODB transactions to stage object writes
Date: Tue,  7 Jul 2026 23:14:01 -0500
Message-ID: <20260708041412.1157499-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260624041920.2601961-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This patch series replaces direct usage of the `tmp_objdir` interfaces
in git-receive-pack(1) to instead use the `odb_transaction` interfaces
to create/manage a staging area to write objects to. The purpose of this
change is to get git-receive-pack(1) one step closer to being ODB
backend agnostic. For now, the object writes themselves are still
"files" backend specific due to being handled by the git-index-pack(1)
and git-unpack-objects(1) child processes. This will be tackled in a
separate series though.

Changes since V1:

  - Adapted other "file" ODB transaction helpers to be more consistent
    with current naming scheme.
  - Removed redundant NULL transaction handling from
    `odb_transaction_files_begin()`.
  - `odb_transaction_begin()` now returns an error if there is already
    an inflight transaction pending instead of setting the `out` pointer
    to NULL.
  - Updated `odb_transaction_env()` to return an error code and append
    environment variables to a strvec provided as an argument.
  - Removed redundant setting of tmpdir environment variables for child
    processes after tmpdir has been migrated.
  - Split changes adding ODB transaction flags into a separate commit.
  - Consistently wire the ODB transaction throughout git-receive-pack
    code instead of reading it from `the_repository`.
  - Updated user facing error message.
  - Updated some comments to better document functions/flags.
  - Clarified some commit messages.
  - Fixed typos.

Thanks,
-Justin

Justin Tobler (11):
  object-file: rename files transaction prepare function
  object-file: rename files transaction fsync function
  object-file: embed transaction flush logic in commit function
  object-file: drop check for inflight transactions
  object-file: propagate files transaction errors
  odb/transaction: propagate begin errors
  odb/transaction: propagate commit errors
  odb/transaction: add transaction env interface
  odb/transaction: introduce ODB transaction flags
  builtin/receive-pack: drop redundant tmpdir env
  builtin/receive-pack: stage incoming objects via ODB transactions

 builtin/add.c            |   2 +-
 builtin/receive-pack.c   |  69 ++++++++---------
 builtin/unpack-objects.c |   2 +-
 builtin/update-index.c   |   2 +-
 cache-tree.c             |   7 +-
 object-file.c            | 159 +++++++++++++++++++++++++--------------
 object-file.h            |   8 +-
 odb/source-files.c       |   9 +--
 odb/source-inmemory.c    |   3 +-
 odb/source-loose.c       |   3 +-
 odb/source.h             |   9 ++-
 odb/transaction.c        |  34 +++++++--
 odb/transaction.h        |  60 ++++++++++++---
 read-cache.c             |   7 +-
 14 files changed, 244 insertions(+), 130 deletions(-)

Range-diff against v1:
 1:  9c14b219ad =  1:  9c14b219ad object-file: rename files transaction prepare function
 -:  ---------- >  2:  5703a9e93b object-file: rename files transaction fsync function
 -:  ---------- >  3:  4c37398ac8 object-file: embed transaction flush logic in commit function
 -:  ---------- >  4:  623c6b02ea object-file: drop check for inflight transactions
 2:  201f543692 !  5:  ca59176657 object-file: propagate files transaction errors
    @@ Commit message
         the temporary directory used to stage objects, but silently ignores
         these errors. Instead return errors encountered in the
         `odb_transaction_files_{prepare,begin,commit}()` interfaces to allow
    -    callers to handle as needed.
    +    callers to handle them as needed.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ object-file.c: static void odb_transaction_files_prepare(struct odb_transaction
     +	return 0;
      }
      
    - static void fsync_loose_object_transaction(struct odb_transaction *base,
    -@@ object-file.c: static void fsync_loose_object_transaction(struct odb_transaction *base,
    - /*
    -  * Cleanup after batch-mode fsync_object_files.
    -  */
    --static void flush_loose_object_transaction(struct odb_transaction_files *transaction)
    -+static int flush_loose_object_transaction(struct odb_transaction_files *transaction)
    - {
    - 	struct strbuf temp_path = STRBUF_INIT;
    - 	struct tempfile *temp;
    - 
    - 	if (!transaction->objdir)
    --		return;
    -+		return 0;
    - 
    - 	/*
    - 	 * Issue a full hardware flush against a temporary file to ensure
    -@@ object-file.c: static void flush_loose_object_transaction(struct odb_transaction_files *transac
    - 	 * Make the object files visible in the primary ODB after their data is
    - 	 * fully durable.
    - 	 */
    --	tmp_objdir_migrate(transaction->objdir);
    -+	if (tmp_objdir_migrate(transaction->objdir))
    -+		return -1;
    -+
    - 	transaction->objdir = NULL;
    -+
    -+	return 0;
    - }
    - 
    - /* Finalize a file on disk, and close it. */
    + static void odb_transaction_files_fsync(struct odb_transaction *base,
     @@ object-file.c: int read_loose_object(struct repository *repo,
      	return ret;
      }
    @@ object-file.c: int read_loose_object(struct repository *repo,
      {
      	struct odb_transaction_files *transaction =
      		container_of(base, struct odb_transaction_files, base);
    +@@ object-file.c: static void odb_transaction_files_commit(struct odb_transaction *base)
    + 		 * Make the object files visible in the primary ODB after their data is
    + 		 * fully durable.
    + 		 */
    +-		tmp_objdir_migrate(transaction->objdir);
    ++		if (tmp_objdir_migrate(transaction->objdir))
    ++			return -1;
    ++
    + 		transaction->objdir = NULL;
    + 	}
      
    --	flush_loose_object_transaction(transaction);
    -+	if (flush_loose_object_transaction(transaction))
    -+		return -1;
      	flush_packfile_transaction(transaction);
     +
     +	return 0;
    @@ object-file.c: int read_loose_object(struct repository *repo,
     +				struct odb_transaction **out)
      {
      	struct odb_transaction_files *transaction;
    - 	struct object_database *odb = source->odb;
    - 
    --	if (odb->transaction)
    --		return NULL;
    -+	if (odb->transaction) {
    -+		*out = NULL;
    -+		return 0;
    -+	}
      
    - 	transaction = xcalloc(1, sizeof(*transaction));
    +@@ object-file.c: struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
      	transaction->base.source = source;
      	transaction->base.commit = odb_transaction_files_commit;
      	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
    @@ object-file.c: int read_loose_object(struct repository *repo,
     
      ## object-file.h ##
     @@ object-file.h: struct odb_transaction;
    -  * Tell the object database to optimize for adding
       * multiple objects. odb_transaction_files_commit must be called
    -  * to make new objects visible. If a transaction is already
    -- * pending, NULL is returned.
    -+ * pending, out is set to NULL.
    +  * to make new objects visible.
       */
     -struct odb_transaction *odb_transaction_files_begin(struct odb_source *source);
     +int odb_transaction_files_begin(struct odb_source *source,
    @@ odb/source-files.c: static int odb_source_files_write_object_stream(struct odb_s
     
      ## odb/transaction.h ##
     @@ odb/transaction.h: struct odb_transaction {
    + 	/* The ODB source the transaction is opened against. */
      	struct odb_source *source;
      
    - 	/* The ODB source specific callback invoked to commit a transaction. */
    +-	/* The ODB source specific callback invoked to commit a transaction. */
     -	void (*commit)(struct odb_transaction *transaction);
    ++	/*
    ++	 * The ODB source specific callback invoked to commit a transaction.
    ++	 * Returns 0 on success, a negative error code otherwise.
    ++	 */
     +	int (*commit)(struct odb_transaction *transaction);
      
      	/*
 3:  68cdd88ab5 !  6:  717a1ce9a7 odb/transaction: propagate begin errors
    @@ Commit message
         convenience for callsites that do not need to handle errors
         explicitly.
     
    +    Note that `odb_transaction_begin()` now returns an error when the ODB
    +    already has an inflight transaction pending. ODB transaction call sites
    +    that may encounter an inflight transaction are updated to explicitly
    +    handle this case.
    +
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## builtin/add.c ##
    @@ builtin/update-index.c: int cmd_update_index(int argc,
      			parseopt_state = parse_options_step(&ctx, options,
     
      ## cache-tree.c ##
    +@@ cache-tree.c: static int update_one(struct cache_tree *it,
    + 
    + int cache_tree_update(struct index_state *istate, int flags)
    + {
    ++	int inflight = !!the_repository->objects->transaction;
    + 	struct odb_transaction *transaction;
    + 	int skip, i;
    + 
     @@ cache-tree.c: int cache_tree_update(struct index_state *istate, int flags)
      
      	trace_performance_enter();
      	trace2_region_enter("cache_tree", "update", istate->repo);
     -	transaction = odb_transaction_begin(the_repository->objects);
    -+	odb_transaction_begin_or_die(the_repository->objects, &transaction);
    ++	if (!inflight)
    ++		odb_transaction_begin_or_die(the_repository->objects, &transaction);
      	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
      		       "", 0, &skip, flags);
    - 	odb_transaction_commit(transaction);
    +-	odb_transaction_commit(transaction);
    ++	if (!inflight)
    ++		odb_transaction_commit(transaction);
    + 	trace2_region_leave("cache_tree", "update", istate->repo);
    + 	trace_performance_leave("cache_tree_update");
    + 	if (i < 0)
     
      ## object-file.c ##
     @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
      		if (flags & INDEX_WRITE_OBJECT) {
      			struct object_database *odb = the_repository->objects;
     -			struct odb_transaction *transaction = odb_transaction_begin(odb);
    -+			struct odb_transaction *transaction;
    ++			struct odb_transaction *transaction = odb->transaction;
    ++			int inflight = !!transaction;
      
    -+			odb_transaction_begin_or_die(odb, &transaction);
    - 			ret = odb_transaction_write_object_stream(odb->transaction,
    +-			ret = odb_transaction_write_object_stream(odb->transaction,
    ++			if (!inflight)
    ++				odb_transaction_begin_or_die(odb, &transaction);
    ++			ret = odb_transaction_write_object_stream(transaction,
      								  &stream,
      								  xsize_t(st->st_size),
    + 								  oid);
    +-			odb_transaction_commit(transaction);
    ++			if (!inflight)
    ++				odb_transaction_commit(transaction);
    + 		} else {
    + 			ret = hash_blob_stream(&stream,
    + 					       the_repository->hash_algo, oid,
     
      ## odb/transaction.c ##
     @@
    @@ odb/transaction.c
     +int odb_transaction_begin(struct object_database *odb,
     +			  struct odb_transaction **out)
      {
    --	if (odb->transaction)
    --		return NULL;
     +	int ret;
    ++
    + 	if (odb->transaction)
    +-		return NULL;
    ++		return -1;
      
     -	odb_source_begin_transaction(odb->sources, &odb->transaction);
    -+	if (odb->transaction) {
    -+		*out = NULL;
    -+		return 0;
    -+	}
    - 
    --	return odb->transaction;
     +	ret = odb_source_begin_transaction(odb->sources, out);
     +	odb->transaction = *out;
    -+
    + 
    +-	return odb->transaction;
     +	return ret;
      }
      
    @@ odb/transaction.h: struct odb_transaction {
     + * Starts an ODB transaction and returns it via `out`. Subsequent objects are
     + * written to the transaction and not committed until odb_transaction_commit()
     + * is invoked on the transaction. Returns 0 on success and a negative value on
    -+ * error. If the ODB already has a pending transaction, `out` is set to NULL.
    ++ * error. Note that it is considered an error to start a new transaction if the
    ++ * ODB already has an inflight transaction pending.
       */
     -struct odb_transaction *odb_transaction_begin(struct object_database *odb);
     +int odb_transaction_begin(struct object_database *odb,
    @@ odb/transaction.h: struct odb_transaction {
       * Commits an ODB transaction making the written objects visible. If the
     
      ## read-cache.c ##
    +@@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix,
    + 		       const struct pathspec *pathspec, char *ps_matched,
    + 		       int include_sparse, int flags, int ignored_too )
    + {
    ++	int inflight = !!repo->objects->transaction;
    + 	struct odb_transaction *transaction;
    + 	struct update_callback_data data;
    + 	struct rev_info rev;
     @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix,
      	 * This function is invoked from commands other than 'add', which
      	 * may not have their own transaction active.
      	 */
     -	transaction = odb_transaction_begin(repo->objects);
    -+	odb_transaction_begin_or_die(repo->objects, &transaction);
    ++	if (!inflight)
    ++		odb_transaction_begin_or_die(repo->objects, &transaction);
      	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
    - 	odb_transaction_commit(transaction);
    +-	odb_transaction_commit(transaction);
    ++	if (!inflight)
    ++		odb_transaction_commit(transaction);
      
    + 	release_revisions(&rev);
    + 	return !!data.add_errors;
 -:  ---------- >  7:  ff8e133965 odb/transaction: propagate commit errors
 5:  82302db9f0 !  8:  264ba94b83 odb/transaction: add transaction env interface
    @@ Commit message
     
         The ODB transaction backend is responsible for creating/managing its own
         staging area for writing objects. Other child processes spawned by Git
    -    may need to access to uncommitted objects or write new objects in the
    +    may need access to uncommitted objects or write new objects in the
         staging area though.
     
         Introduce `odb_transaction_env()` which is expected to provide the set
         of environment variables needed by a child process to access the
    -    transaction staging area.
    +    transaction's staging area.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## object-file.c ##
    +@@
    + #include "path.h"
    + #include "read-cache-ll.h"
    + #include "setup.h"
    ++#include "strvec.h"
    + #include "tempfile.h"
    + #include "tmp-objdir.h"
    + 
     @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *base)
      	return 0;
      }
      
    -+static const char **odb_transaction_files_env(struct odb_transaction *base)
    ++static int odb_transaction_files_env(struct odb_transaction *base,
    ++				     struct strvec *env)
     +{
     +	struct odb_transaction_files *transaction =
     +		container_of(base, struct odb_transaction_files, base);
     +
     +	odb_transaction_files_prepare(&transaction->base);
    ++	strvec_pushv(env, tmp_objdir_env(transaction->objdir));
     +
    -+	return tmp_objdir_env(transaction->objdir);
    ++	return 0;
     +}
     +
      int odb_transaction_files_begin(struct odb_source *source,
    @@ odb/transaction.c: int odb_transaction_write_object_stream(struct odb_transactio
      	return transaction->write_object_stream(transaction, stream, len, oid);
      }
     +
    -+const char **odb_transaction_env(struct odb_transaction *transaction)
    ++int odb_transaction_env(struct odb_transaction *transaction, struct strvec *env)
     +{
     +	if (!transaction)
    -+		return NULL;
    ++		return 0;
     +
    -+	return transaction->env(transaction);
    ++	return transaction->env(transaction, env);
     +}
     
      ## odb/transaction.h ##
    @@ odb/transaction.h: struct odb_transaction {
      				   struct object_id *oid);
     +
     +	/*
    -+	 * This callback is expected to return a NULL-terminated array of
    -+	 * environment variables that a child process should inherit so
    -+	 * that its object writes participate in the transaction. The
    -+	 * returned array is owned by the backend and remains valid until
    -+	 * the transaction ends. May return NULL when the backend does not
    -+	 * need to expose any state to child processes.
    ++	 * This callback is expected to populate the provided strvec with the
    ++	 * environment variables that a child process should inherit so that its
    ++	 * object writes participate in the transaction. Returns 0 on success, a
    ++	 * negative error code otherwise.
     +	 */
    -+	const char **(*env)(struct odb_transaction *transaction);
    ++	int (*env)(struct odb_transaction *transaction, struct strvec *env);
      };
      
      /*
    @@ odb/transaction.h: int odb_transaction_write_object_stream(struct odb_transactio
      					size_t len, struct object_id *oid);
      
     +/*
    -+ * Returns a NULL-terminated array of environment variables that a child
    ++ * Populates the provided strvec with the environment variables that a child
     + * process should inherit so that its object writes participate in the
    -+ * transaction, suitable for passing via child_process.env. Returns NULL if
    -+ * the transaction is NULL or the backend does not expose any state to child
    -+ * processes.
    ++ * transaction, suitable for using via child_process.env. Returns 0 on success,
    ++ * a negative error code otherwise. Note that, if the specified transaction is
    ++ * NULL, the function is a no-op and no error is returned.
     + */
    -+const char **odb_transaction_env(struct odb_transaction *transaction);
    ++int odb_transaction_env(struct odb_transaction *transaction, struct strvec *env);
     +
      #endif
 6:  0674e8a3d3 !  9:  1e0a491ef2 builtin/receive-pack: stage incoming objects via ODB transactions
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    builtin/receive-pack: stage incoming objects via ODB transactions
    +    odb/transaction: introduce ODB transaction flags
     
    -    Objects received by git-receive-pack(1) are quarantined in a temporary
    -    "incoming" directory and migrated into the object database prior to the
    -    reference updates. The quarantine is currently managed through
    -    `tmp_objdir` directly. In a pluggable ODB future, how exactly an object
    -    gets written to a transaction may vary for a given ODB source. Refactor
    -    git-receive-pack(1) to use the ODB transaction interfaces to manage the
    -    object staging area in a more agnostic manner accordingly.
    +    The temporary directory used by git-receive-pack(1) to write objects is
    +    managed slightly differently than how it is done via ODB transactions:
     
    -    Note that the temporary directory created for git-receive-pack(1) is
    -    eagerly created and uses a different prefix name. This behavior is
    -    special cased in the "files" backend by having `odb_transaction_begin()`
    -    callers that require this behavior provide an `ODB_TRANSACTION_RECEIVE`
    -    flag.
    +      - The temporary directory is eagerly created upfront, instead of
    +        waiting for the first object write.
    +
    +      - The prefix name of the temporary directory is "incoming" instead of
    +        "bulk-fsync".
    +
    +    In a subsequent commit, git-receive-pack(1) will use ODB transactions
    +    instead of `tmp_objdir` directly. To provide a means to configure the
    +    same transaction behavior, introduce `enum odb_transaction_flags` and
    +    the ODB_TRANSACTION_RECEIVE flag intended as a signal for ODB
    +    transactions using the "files" backend to be set up for
    +    git-receive-pack(1). Transaction call sites are updated accordingly to
    +    provide the required flag parameter.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ builtin/add.c: int cmd_add(int argc,
      	ps_matched = xcalloc(pathspec.nr, 1);
      	if (add_renormalize)
     
    - ## builtin/receive-pack.c ##
    -@@ builtin/receive-pack.c: static enum {
    - } use_keepalive;
    - static int keepalive_in_sec = 5;
    - 
    --static struct tmp_objdir *tmp_objdir;
    --
    - static struct proc_receive_ref {
    - 	unsigned int want_add:1,
    - 		     want_delete:1,
    -@@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
    - 		strvec_push(&opt.env, "GIT_PUSH_OPTION_COUNT");
    - 	}
    - 
    --	if (tmp_objdir)
    --		strvec_pushv(&opt.env, tmp_objdir_env(tmp_objdir));
    -+	if (the_repository->objects->transaction)
    -+		strvec_pushv(&opt.env, odb_transaction_env(the_repository->objects->transaction));
    - 
    - 	prepare_push_cert_sha1(&opt);
    - 
    -@@ builtin/receive-pack.c: static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
    - 		    !delayed_reachability_test(si, i))
    - 			oid_array_append(&extra, &si->shallow->oid[i]);
    - 
    --	opt.env = tmp_objdir_env(tmp_objdir);
    -+	opt.env = odb_transaction_env(the_repository->objects->transaction);
    - 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
    - 	if (check_connected(command_singleton_iterator, cmd, &opt)) {
    - 		rollback_shallow_file(the_repository, &shallow_lock);
    -@@ builtin/receive-pack.c: static void set_connectivity_errors(struct command *commands,
    - 			/* to be checked in update_shallow_ref() */
    - 			continue;
    - 
    --		opt.env = tmp_objdir_env(tmp_objdir);
    -+		opt.env = odb_transaction_env(the_repository->objects->transaction);
    - 		if (!check_connected(command_singleton_iterator, &singleton,
    - 				     &opt))
    - 			continue;
    -@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
    - 		data.si = si;
    - 		opt.err_fd = err_fd;
    - 		opt.progress = err_fd && !quiet;
    --		opt.env = tmp_objdir_env(tmp_objdir);
    -+		opt.env = odb_transaction_env(the_repository->objects->transaction);
    - 		opt.exclude_hidden_refs_section = "receive";
    - 
    - 		if (check_connected(iterate_receive_command_list, &data, &opt))
    -@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
    - 	 * Now we'll start writing out refs, which means the objects need
    - 	 * to be in their final positions so that other processes can see them.
    - 	 */
    --	if (tmp_objdir_migrate(tmp_objdir) < 0) {
    -+	if (odb_transaction_commit(the_repository->objects->transaction)) {
    - 		for (cmd = commands; cmd; cmd = cmd->next) {
    - 			if (!cmd->error_string)
    - 				cmd->error_string = "unable to migrate objects to permanent storage";
    - 		}
    - 		return;
    - 	}
    --	tmp_objdir = NULL;
    - 
    - 	check_aliased_updates(commands);
    - 
    -@@ builtin/receive-pack.c: static void push_header_arg(struct strvec *args, struct pack_header *hdr)
    - 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
    - }
    - 
    --static const char *unpack(int err_fd, struct shallow_info *si)
    -+static const char *unpack(int err_fd, struct shallow_info *si,
    -+			  struct odb_transaction *transaction)
    - {
    - 	struct pack_header hdr;
    - 	const char *hdr_err;
    -@@ builtin/receive-pack.c: static const char *unpack(int err_fd, struct shallow_info *si)
    - 		strvec_push(&child.args, alt_shallow_file);
    - 	}
    - 
    --	tmp_objdir = tmp_objdir_create(the_repository, "incoming");
    --	if (!tmp_objdir) {
    --		if (err_fd > 0)
    --			close(err_fd);
    --		return "unable to create temporary object directory";
    --	}
    --	strvec_pushv(&child.env, tmp_objdir_env(tmp_objdir));
    --
    --	/*
    --	 * Normally we just pass the tmp_objdir environment to the child
    --	 * processes that do the heavy lifting, but we may need to see these
    --	 * objects ourselves to set up shallow information.
    --	 */
    --	tmp_objdir_add_as_alternate(tmp_objdir);
    -+	strvec_pushv(&child.env, odb_transaction_env(transaction));
    - 
    - 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
    - 		strvec_push(&child.args, "unpack-objects");
    -@@ builtin/receive-pack.c: static const char *unpack(int err_fd, struct shallow_info *si)
    - 	return NULL;
    - }
    - 
    --static const char *unpack_with_sideband(struct shallow_info *si)
    -+static const char *unpack_with_sideband(struct shallow_info *si,
    -+					struct odb_transaction *transaction)
    - {
    - 	struct async muxer;
    - 	const char *ret;
    - 
    - 	if (!use_sideband)
    --		return unpack(0, si);
    -+		return unpack(0, si, transaction);
    - 
    - 	use_keepalive = KEEPALIVE_AFTER_NUL;
    - 	memset(&muxer, 0, sizeof(muxer));
    -@@ builtin/receive-pack.c: static const char *unpack_with_sideband(struct shallow_info *si)
    - 	if (start_async(&muxer))
    - 		return NULL;
    - 
    --	ret = unpack(muxer.in, si);
    -+	ret = unpack(muxer.in, si, transaction);
    - 
    - 	finish_async(&muxer);
    - 	return ret;
    -@@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
    - 	struct oid_array ref = OID_ARRAY_INIT;
    - 	struct shallow_info si;
    - 	struct packet_reader reader;
    -+	struct odb_transaction *transaction = NULL;
    - 
    - 	struct option options[] = {
    - 		OPT__QUIET(&quiet, N_("quiet")),
    -@@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
    - 		if (!si.nr_ours && !si.nr_theirs)
    - 			shallow_update = 0;
    - 		if (!delete_only(commands)) {
    --			unpack_status = unpack_with_sideband(&si);
    -+			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
    -+				unpack_status = "unable to start ODB transaction";
    -+			else
    -+				unpack_status = unpack_with_sideband(&si, transaction);
    - 			update_shallow_info(commands, &si, &ref);
    - 		}
    - 		use_keepalive = KEEPALIVE_ALWAYS;
    -
      ## builtin/unpack-objects.c ##
     @@ builtin/unpack-objects.c: static void unpack_all(void)
      		progress = start_progress(the_repository,
    @@ builtin/update-index.c: int cmd_update_index(int argc,
     
      ## cache-tree.c ##
     @@ cache-tree.c: int cache_tree_update(struct index_state *istate, int flags)
    - 
      	trace_performance_enter();
      	trace2_region_enter("cache_tree", "update", istate->repo);
    --	odb_transaction_begin_or_die(the_repository->objects, &transaction);
    -+	odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
    + 	if (!inflight)
    +-		odb_transaction_begin_or_die(the_repository->objects, &transaction);
    ++		odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
      	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
      		       "", 0, &skip, flags);
    - 	odb_transaction_commit(transaction);
    + 	if (!inflight)
     
      ## object-file.c ##
     @@ object-file.c: struct odb_transaction_files {
    @@ object-file.c: static int odb_transaction_files_prepare(struct odb_transaction *
      		return -1;
      
     @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    - 			struct object_database *odb = the_repository->objects;
    - 			struct odb_transaction *transaction;
    + 			int inflight = !!transaction;
      
    --			odb_transaction_begin_or_die(odb, &transaction);
    -+			odb_transaction_begin_or_die(odb, &transaction, 0);
    - 			ret = odb_transaction_write_object_stream(odb->transaction,
    + 			if (!inflight)
    +-				odb_transaction_begin_or_die(odb, &transaction);
    ++				odb_transaction_begin_or_die(odb, &transaction, 0);
    + 			ret = odb_transaction_write_object_stream(transaction,
      								  &stream,
      								  xsize_t(st->st_size),
    -@@ object-file.c: static const char **odb_transaction_files_env(struct odb_transaction *base)
    +@@ object-file.c: static int odb_transaction_files_env(struct odb_transaction *base,
      }
      
      int odb_transaction_files_begin(struct odb_source *source,
    @@ object-file.c: static const char **odb_transaction_files_env(struct odb_transact
     +				enum odb_transaction_flags flags)
      {
      	struct odb_transaction_files *transaction;
    - 	struct object_database *odb = source->odb;
    + 
     @@ object-file.c: int odb_transaction_files_begin(struct odb_source *source,
      	transaction->base.commit = odb_transaction_files_commit;
      	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
    @@ object-file.c: int odb_transaction_files_begin(struct odb_source *source,
     +	if (flags & ODB_TRANSACTION_RECEIVE) {
     +		/*
     +		 * ODB transactions for git-receive-pack(1) eagerly create a
    -+		 * temporary directory and use a different prefix.
    ++		 * temporary directory and use a different temporary directory
    ++		 * prefix.
    ++		 *
    ++		 * NEEDSWORK: This transaction flag is only used by the "files"
    ++		 * backend to special case temporary directory set up and
    ++		 * handling. Ideally transaction users should not have to care
    ++		 * though. To avoid this, we could eagerly create the temporary
    ++		 * directory and use the same prefix name for all transactions.
     +		 */
     +		transaction->prefix = "incoming";
     +		if (odb_transaction_files_prepare(&transaction->base)) {
    @@ object-file.h
      /* The maximum size for an object header. */
      #define MAX_HEADER_LEN 32
     @@ object-file.h: struct odb_transaction;
    -  * pending, out is set to NULL.
    +  * to make new objects visible.
       */
      int odb_transaction_files_begin(struct odb_source *source,
     -				struct odb_transaction **out);
    @@ odb/transaction.c
      {
      	int ret;
      
    -@@ odb/transaction.c: int odb_transaction_begin(struct object_database *odb,
    - 		return 0;
    - 	}
    + 	if (odb->transaction)
    + 		return -1;
      
     -	ret = odb_source_begin_transaction(odb->sources, out);
     +	ret = odb_source_begin_transaction(odb->sources, out, flags);
    @@ odb/transaction.h
      /*
       * A transaction may be started for an object database prior to writing new
     @@ odb/transaction.h: struct odb_transaction {
    - 	const char **(*env)(struct odb_transaction *transaction);
    + 	int (*env)(struct odb_transaction *transaction, struct strvec *env);
      };
      
    ++/* Flags used to configure an ODB transaction. */
     +enum odb_transaction_flags {
    ++	/* Configures the transaction for use with git-receive-pack(1). */
     +	ODB_TRANSACTION_RECEIVE = (1 << 0),
     +};
     +
    @@ odb/transaction.h: struct odb_transaction {
       * Starts an ODB transaction and returns it via `out`. Subsequent objects are
       * written to the transaction and not committed until odb_transaction_commit()
     @@ odb/transaction.h: struct odb_transaction {
    -  * error. If the ODB already has a pending transaction, `out` is set to NULL.
    +  * ODB already has an inflight transaction pending.
       */
      int odb_transaction_begin(struct object_database *odb,
     -			  struct odb_transaction **out);
    @@ odb/transaction.h: struct odb_transaction {
     
      ## read-cache.c ##
     @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix,
    - 	 * This function is invoked from commands other than 'add', which
      	 * may not have their own transaction active.
      	 */
    --	odb_transaction_begin_or_die(repo->objects, &transaction);
    -+	odb_transaction_begin_or_die(repo->objects, &transaction, 0);
    + 	if (!inflight)
    +-		odb_transaction_begin_or_die(repo->objects, &transaction);
    ++		odb_transaction_begin_or_die(repo->objects, &transaction, 0);
      	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
    - 	odb_transaction_commit(transaction);
    - 
    + 	if (!inflight)
    + 		odb_transaction_commit(transaction);
 -:  ---------- > 10:  6c8d878349 builtin/receive-pack: drop redundant tmpdir env
 4:  e9303f9b08 ! 11:  8db95fef56 odb/transaction: propagate commit errors
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    odb/transaction: propagate commit errors
    +    builtin/receive-pack: stage incoming objects via ODB transactions
     
    -    When `odb_transaction_commit()` is invoked, the return value of the
    -    backend commit callback is silently discarded. A backend has no way
    -    to signal that committing failed, such as when the "files" backend
    -    cannot migrate its temporary object directory into the permanent
    -    ODB.
    +    Objects received by git-receive-pack(1) are quarantined in a temporary
    +    "incoming" directory and migrated into the object database prior to the
    +    reference updates. The quarantine is currently managed through
    +    `tmp_objdir` directly. In a pluggable ODB future, how exactly an object
    +    gets written to a transaction may vary for a given ODB source. Refactor
    +    git-receive-pack(1) to use the ODB transaction interfaces to manage the
    +    object staging area in a more agnostic manner accordingly.
     
    -    In a subsequent commit, git-receive-pack(1) starts using ODB transaction
    -    to stage objects and consequently cares about such failures so it can
    -    handle the error appropriately. Change the commit callback signature to
    -    return an int error code and have `odb_transaction_commit()` forward it
    -    accordingly.
    +    Note that the ODB transaction is now responsible for managing the
    +    primary and alternate ODBs for the repository. One small change as a
    +    result is that the temporary directory is now applied as the primary ODB
    +    in the main process instead of an alternate. This does not change
    +    anything for git-receive-pack(1) though because it only needs access to
    +    the newly written objects and doesn't care how exactly it is set up.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    - ## odb/transaction.c ##
    -@@ odb/transaction.c: int odb_transaction_begin(struct object_database *odb,
    - 	return ret;
    + ## builtin/receive-pack.c ##
    +@@
    + #include "sigchain.h"
    + #include "string-list.h"
    + #include "strvec.h"
    +-#include "tmp-objdir.h"
    + #include "trace.h"
    + #include "trace2.h"
    + #include "version.h"
    +@@ builtin/receive-pack.c: static enum {
    + } use_keepalive;
    + static int keepalive_in_sec = 5;
    + 
    +-static struct tmp_objdir *tmp_objdir;
    +-
    + static struct proc_receive_ref {
    + 	unsigned int want_add:1,
    + 		     want_delete:1,
    +@@ builtin/receive-pack.c: static void receive_hook_feed_state_free(void *data)
    + static int run_receive_hook(struct command *commands,
    + 			    const char *hook_name,
    + 			    int skip_broken,
    ++			    struct odb_transaction *transaction,
    + 			    const struct string_list *push_options)
    + {
    + 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    +@@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
    + 		strvec_push(&opt.env, "GIT_PUSH_OPTION_COUNT");
    + 	}
    + 
    +-	if (tmp_objdir)
    +-		strvec_pushv(&opt.env, tmp_objdir_env(tmp_objdir));
    ++	if (transaction)
    ++		odb_transaction_env(transaction, &opt.env);
    + 
    + 	prepare_push_cert_sha1(&opt);
    + 
    +@@ builtin/receive-pack.c: static const struct object_id *command_singleton_iterator(void *cb_data)
      }
      
    --void odb_transaction_commit(struct odb_transaction *transaction)
    -+int odb_transaction_commit(struct odb_transaction *transaction)
    + static void set_connectivity_errors(struct command *commands,
    +-				    struct shallow_info *si)
    ++				    struct shallow_info *si,
    ++				    struct odb_transaction *transaction)
      {
    -+	int ret;
    + 	struct command *cmd;
    + 
    + 	for (cmd = commands; cmd; cmd = cmd->next) {
    + 		struct command *singleton = cmd;
    + 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
    ++		struct strvec env = STRVEC_INIT;
    + 
    + 		if (shallow_update && si->shallow_ref[cmd->index])
    + 			/* to be checked in update_shallow_ref() */
    + 			continue;
    + 
    +-		opt.env = tmp_objdir_env(tmp_objdir);
    ++		odb_transaction_env(transaction, &env);
    ++		opt.env = env.v;
     +
    - 	if (!transaction)
    --		return;
    -+		return 0;
    + 		if (!check_connected(command_singleton_iterator, &singleton,
    + 				     &opt))
    + 			continue;
      
    - 	/*
    - 	 * Ensure the transaction ending matches the pending transaction.
    - 	 */
    - 	ASSERT(transaction == transaction->source->odb->transaction);
    + 		cmd->error_string = "missing necessary objects";
    ++
    ++		strvec_clear(&env);
    + 	}
    + }
    + 
    +@@ builtin/receive-pack.c: static void execute_commands_atomic(struct command *commands,
    + static void execute_commands(struct command *commands,
    + 			     const char *unpacker_error,
    + 			     struct shallow_info *si,
    ++			     struct odb_transaction *transaction,
    + 			     const struct string_list *push_options)
    + {
    + 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
    +@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
    + 	}
      
    --	transaction->commit(transaction);
    -+	ret = transaction->commit(transaction);
    -+	if (ret)
    -+		return ret;
    + 	if (!skip_connectivity_check) {
    ++		struct strvec env = STRVEC_INIT;
     +
    - 	transaction->source->odb->transaction = NULL;
    - 	free(transaction);
    + 		if (use_sideband) {
    + 			memset(&muxer, 0, sizeof(muxer));
    + 			muxer.proc = copy_to_sideband;
    +@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
    + 		data.si = si;
    + 		opt.err_fd = err_fd;
    + 		opt.progress = err_fd && !quiet;
    +-		opt.env = tmp_objdir_env(tmp_objdir);
    ++		odb_transaction_env(transaction, &env);
    ++		opt.env = env.v;
    + 		opt.exclude_hidden_refs_section = "receive";
    + 
    + 		if (check_connected(iterate_receive_command_list, &data, &opt))
    +-			set_connectivity_errors(commands, si);
    ++			set_connectivity_errors(commands, si, transaction);
    + 
    + 		if (use_sideband)
    + 			finish_async(&muxer);
     +
    -+	return 0;
    ++		strvec_clear(&env);
    + 	}
    + 
    + 	reject_updates_to_hidden(commands);
    +@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
    + 		}
    + 	}
    + 
    +-	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
    ++	if (run_receive_hook(commands, "pre-receive", 0, transaction, push_options)) {
    + 		for (cmd = commands; cmd; cmd = cmd->next) {
    + 			if (!cmd->error_string)
    + 				cmd->error_string = "pre-receive hook declined";
    +@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
    + 	 * Now we'll start writing out refs, which means the objects need
    + 	 * to be in their final positions so that other processes can see them.
    + 	 */
    +-	if (tmp_objdir_migrate(tmp_objdir) < 0) {
    ++	if (odb_transaction_commit(transaction)) {
    + 		for (cmd = commands; cmd; cmd = cmd->next) {
    + 			if (!cmd->error_string)
    + 				cmd->error_string = "unable to migrate objects to permanent storage";
    + 		}
    + 		return;
    + 	}
    +-	tmp_objdir = NULL;
    + 
    + 	check_aliased_updates(commands);
    + 
    +@@ builtin/receive-pack.c: static void push_header_arg(struct strvec *args, struct pack_header *hdr)
    + 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
      }
      
    - int odb_transaction_write_object_stream(struct odb_transaction *transaction,
    -
    - ## odb/transaction.h ##
    -@@ odb/transaction.h: static inline void odb_transaction_begin_or_die(struct object_database *odb,
    -  * Commits an ODB transaction making the written objects visible. If the
    -  * specified transaction is NULL, the function is a no-op.
    -  */
    --void odb_transaction_commit(struct odb_transaction *transaction);
    -+int odb_transaction_commit(struct odb_transaction *transaction);
    - 
    - /*
    -  * Writes the object in the provided stream into the transaction. The resulting
    +-static const char *unpack(int err_fd, struct shallow_info *si)
    ++static const char *unpack(int err_fd, struct shallow_info *si,
    ++			  struct odb_transaction *transaction)
    + {
    + 	struct pack_header hdr;
    + 	const char *hdr_err;
    +@@ builtin/receive-pack.c: static const char *unpack(int err_fd, struct shallow_info *si)
    + 		strvec_push(&child.args, alt_shallow_file);
    + 	}
    + 
    +-	tmp_objdir = tmp_objdir_create(the_repository, "incoming");
    +-	if (!tmp_objdir) {
    +-		if (err_fd > 0)
    +-			close(err_fd);
    +-		return "unable to create temporary object directory";
    +-	}
    +-	strvec_pushv(&child.env, tmp_objdir_env(tmp_objdir));
    +-
    +-	/*
    +-	 * Normally we just pass the tmp_objdir environment to the child
    +-	 * processes that do the heavy lifting, but we may need to see these
    +-	 * objects ourselves to set up shallow information.
    +-	 */
    +-	tmp_objdir_add_as_alternate(tmp_objdir);
    ++	odb_transaction_env(transaction, &child.env);
    + 
    + 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
    + 		strvec_push(&child.args, "unpack-objects");
    +@@ builtin/receive-pack.c: static const char *unpack(int err_fd, struct shallow_info *si)
    + 	return NULL;
    + }
    + 
    +-static const char *unpack_with_sideband(struct shallow_info *si)
    ++static const char *unpack_with_sideband(struct shallow_info *si,
    ++					struct odb_transaction *transaction)
    + {
    + 	struct async muxer;
    + 	const char *ret;
    + 
    + 	if (!use_sideband)
    +-		return unpack(0, si);
    ++		return unpack(0, si, transaction);
    + 
    + 	use_keepalive = KEEPALIVE_AFTER_NUL;
    + 	memset(&muxer, 0, sizeof(muxer));
    +@@ builtin/receive-pack.c: static const char *unpack_with_sideband(struct shallow_info *si)
    + 	if (start_async(&muxer))
    + 		return NULL;
    + 
    +-	ret = unpack(muxer.in, si);
    ++	ret = unpack(muxer.in, si, transaction);
    + 
    + 	finish_async(&muxer);
    + 	return ret;
    +@@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
    + 	struct oid_array ref = OID_ARRAY_INIT;
    + 	struct shallow_info si;
    + 	struct packet_reader reader;
    ++	struct odb_transaction *transaction = NULL;
    + 
    + 	struct option options[] = {
    + 		OPT__QUIET(&quiet, N_("quiet")),
    +@@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
    + 		if (!si.nr_ours && !si.nr_theirs)
    + 			shallow_update = 0;
    + 		if (!delete_only(commands)) {
    +-			unpack_status = unpack_with_sideband(&si);
    ++			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
    ++				unpack_status = "unable to start object transaction";
    ++			else
    ++				unpack_status = unpack_with_sideband(&si, transaction);
    + 			update_shallow_info(commands, &si, &ref);
    + 		}
    + 		use_keepalive = KEEPALIVE_ALWAYS;
    +-		execute_commands(commands, unpack_status, &si,
    ++		execute_commands(commands, unpack_status, &si, transaction,
    + 				 &push_options);
    + 		delete_tempfile(&pack_lockfile);
    + 		sigchain_push(SIGPIPE, SIG_IGN);
    +@@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
    + 		else if (report_status)
    + 			report(commands, unpack_status);
    + 		sigchain_pop(SIGPIPE);
    +-		run_receive_hook(commands, "post-receive", 1,
    ++		run_receive_hook(commands, "post-receive", 1, NULL,
    + 				 &push_options);
    + 		run_update_post_hook(commands);
    + 		free_commands(commands);

base-commit: ab776a62a78576513ee121424adb19597fbb7613
-- 
2.55.0.122.gf85a7e6620

