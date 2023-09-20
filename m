Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35389CE79CE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjITNDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjITNDB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:03:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25B391
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31dca134c83so6726901f8f.3
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214971; x=1695819771; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlsJdcAwCL6NQjheCIsrR3dGhnRxLhUXJAJutt9PMyI=;
        b=XyzVnw1eEtPytkmT4Ge3SaY3y8aQUXqfyVCkGfQ0U6EblNy7ms+1DG/LoGW6ErFFvK
         Rjs3BbGUJXz/o+8BTjjibXBwbMOvQJct5RYSCFYDef4KU2IWf5LS6n9Zzz9tFFJbBYsK
         q3JlU9DWqzjFYvvvT9cttakEmonhakGKhgQl2kvdgRetFQfLrONfooQBtwpek3OZhWoT
         H8NaYg6brXhhW+QdFR4P9WsJCx/2hgimYcy5Pbp7RXSz6LaxGKVP/YUhGvpz3xiYZt5B
         oKwJWO2BckJwuomjwdkUaA4+2bBO+SbLjViyCwZlQtjY0mZIk8NCsNPz68zUEuRX0Vd4
         XQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214971; x=1695819771;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlsJdcAwCL6NQjheCIsrR3dGhnRxLhUXJAJutt9PMyI=;
        b=KbBRc2na1oixuvuTg6lk1LEzjRM7uXQYRRI82w1ah+EDSHqnicXv85jL++lMmXhJ5K
         5v/Q0+3UqvI3Jo1vV5l6igj4Ndxp2mf+zVUgrOSeMtjQDNYbBANXKPMU+GJpgxkz4d4P
         Cmgb3peM/TwRTwYq7g4gpOBNHRaWJEWqWnvgC+OySgW10qGO7RaruFCxMZM/BiORJr/E
         UbTHcL2slhGwa2/MtncqVXv6SGh038Q/3T/qlREDzHBwFKfILbQQ2mScNk8tZrEBglxc
         DVQSmPKNG5ByfRUx7c6nYKr4oSOPI6+sJDrfRn3A3+iwNP5nc1xvGhx44SFIKR7TO1Bk
         9i7Q==
X-Gm-Message-State: AOJu0Yw+16NhlZQz/9s2BwIFjbRdqrhBI3ALWOXLUG9t3ZJK+0lUBrxR
        Yt3cl8OzUFCdynQgUA+Q0+sacEA5mTI=
X-Google-Smtp-Source: AGHT+IF1IsbKHiF4Q5PG8kZ90ojmSNv7QdisE2ZfZZXM5q/O0247U88I98tj82SSELlsMRNYaiOXBA==
X-Received: by 2002:a5d:4002:0:b0:31f:fa38:425f with SMTP id n2-20020a5d4002000000b0031ffa38425fmr2588121wrp.9.1695214970448;
        Wed, 20 Sep 2023 06:02:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b0031f5f0d0be0sm18657069wru.31.2023.09.20.06.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:02:50 -0700 (PDT)
Message-ID: <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
In-Reply-To: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Sep 2023 13:02:42 +0000
Subject: [PATCH v2 0/6] RFC: simple reftable backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series comes from a conversation with Patrick Steinhardt at Gitlab, who
have an interest in a more scalable ref storage system.

I unfortunately don't have business reasons to spend much time on this
project anymore, and the original, sweeping migration has too many open
questions.

I thought of an alternate approach, and I wanted to show it as input to
discussions at the contributor summit.

I think the first part (everything before "refs: alternate reftable ref
backend implementation") is a good improvement overall, and could be landed
separately without much tweaking.

The second part ("refs: alternate reftable ref backend implementation" and
follow-on) is something open for discussion: the alternative "packed
storage" is based on reftable, but it could conceivably be a different type
of database/file format too. I think it's attractive to use reftable here,
because over time more data (symrefs, reflog) could be moved into reftable.

I'm offering this series as a RFC. I hope that someone else (Patrick?) can
look into getting the bits and pieces of this merged.

Han-Wen Nienhuys (6):
  refs: construct transaction using a _begin callback
  refs: wrap transaction in a debug-specific transaction
  refs: push lock management into packed backend
  refs: move is_packed_transaction_needed out of packed-backend.c
  refs: alternate reftable ref backend implementation
  refs: always try to do packed transactions for reftable

 Makefile                        |    1 +
 config.mak.uname                |    2 +-
 contrib/workdir/git-new-workdir |    2 +-
 refs.c                          |   13 +-
 refs/debug.c                    |   87 +-
 refs/files-backend.c            |  216 ++--
 refs/packed-backend.c           |  149 +--
 refs/packed-backend.h           |   19 -
 refs/refs-internal.h            |    5 +
 refs/reftable-backend.c         | 1658 +++++++++++++++++++++++++++++++
 refs/reftable-backend.h         |    8 +
 11 files changed, 1929 insertions(+), 231 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100644 refs/reftable-backend.h


base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1574%2Fhanwen%2Fsimple-reftable-backend-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1574/hanwen/simple-reftable-backend-v2
Pull-Request: https://github.com/git/git/pull/1574

Range-diff vs v1:

 -:  ----------- > 1:  e99f3d20056 refs: construct transaction using a _begin callback
 -:  ----------- > 2:  9a459259330 refs: wrap transaction in a debug-specific transaction
 1:  dea0fbb139a ! 3:  8dedb23eb69 refs: push lock management into packed backend
     @@ Metadata
       ## Commit message ##
          refs: push lock management into packed backend
      
     -    Introduces a ref backend method transaction_begin, which for the
     -    packed backend takes packed-refs.lock.
     +    Take packed-refs.lock in the transaction_begin of the packed backend.
      
          This decouples the files backend from the packed backend, allowing the
          latter to be swapped out by another ref backend.
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## refs.c ##
     -@@ refs.c: struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
     - 						    struct strbuf *err)
     - {
     - 	struct ref_transaction *tr;
     -+	int ret = 0;
     - 	assert(err);
     - 
     - 	CALLOC_ARRAY(tr, 1);
     - 	tr->ref_store = refs;
     -+
     -+	if (refs->be->transaction_begin)
     -+		ret = refs->be->transaction_begin(refs, tr, err);
     -+	if (ret) {
     -+		free(tr);
     -+		return NULL;
     -+	}
     - 	return tr;
     - }
     - 
     -
     - ## refs/debug.c ##
     -@@ refs/debug.c: static int debug_init_db(struct ref_store *refs, struct strbuf *err)
     - 	return res;
     - }
     - 
     -+static int debug_transaction_begin(struct ref_store *refs,
     -+				   struct ref_transaction *transaction,
     -+				   struct strbuf *err)
     -+{
     -+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
     -+	int res;
     -+	transaction->ref_store = drefs->refs;
     -+	res = drefs->refs->be->transaction_begin(drefs->refs, transaction,
     -+						   err);
     -+	trace_printf_key(&trace_refs, "transaction_begin: %d \"%s\"\n", res,
     -+			 err->buf);
     -+	return res;
     -+}
     -+
     - static int debug_transaction_prepare(struct ref_store *refs,
     - 				     struct ref_transaction *transaction,
     - 				     struct strbuf *err)
     -@@ refs/debug.c: struct ref_storage_be refs_be_debug = {
     - 	 * has a function we should also have a wrapper for it here.
     - 	 * Test the output with "GIT_TRACE_REFS=1".
     - 	 */
     -+	.transaction_begin = debug_transaction_begin,
     - 	.transaction_prepare = debug_transaction_prepare,
     - 	.transaction_finish = debug_transaction_finish,
     - 	.transaction_abort = debug_transaction_abort,
     +@@ refs.c: int ref_transaction_abort(struct ref_transaction *transaction,
     + 	int ret = 0;
     + 
     + 	switch (transaction->state) {
     +-	case REF_TRANSACTION_OPEN:
     +-		/* No need to abort explicitly. */
     +-		break;
     + 	case REF_TRANSACTION_PREPARED:
     ++	case REF_TRANSACTION_OPEN:
     ++		/* an OPEN transactions may have a lock. */
     + 		ret = refs->be->transaction_abort(refs, transaction, err);
     + 		break;
     + 	case REF_TRANSACTION_CLOSED:
      
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static int files_pack_refs(struct ref_store *ref_store,
     @@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_
      -		backend_data->packed_transaction = NULL;
      -		if (ret)
      -			goto cleanup;
     -+	if (backend_data->packed_transaction) { 
     ++	if (backend_data->packed_transaction) {
      +		if (backend_data->packed_transaction_needed) {
      +			ret = ref_transaction_commit(packed_transaction, err);
      +			if (ret)
      +				goto cleanup;
     -+			/* TODO: leaks on error path. */
     ++
      +			ref_transaction_free(packed_transaction);
      +			packed_transaction = NULL;
      +			backend_data->packed_transaction = NULL;
     @@ refs/files-backend.c: static int files_initial_transaction_commit(struct ref_sto
       		ref_transaction_free(packed_transaction);
      
       ## refs/packed-backend.c ##
     +@@ refs/packed-backend.c: static int write_packed_entry(FILE *fh, const char *refname,
     + 	return 0;
     + }
     + 
     +-int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
     ++static int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
     + {
     + 	struct packed_ref_store *refs =
     + 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
     +@@ refs/packed-backend.c: int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
     + 	return 0;
     + }
     + 
     +-void packed_refs_unlock(struct ref_store *ref_store)
     ++static void packed_refs_unlock(struct ref_store *ref_store)
     + {
     + 	struct packed_ref_store *refs = packed_downcast(
     + 			ref_store,
     +@@ refs/packed-backend.c: void packed_refs_unlock(struct ref_store *ref_store)
     + 	rollback_lock_file(&refs->lock);
     + }
     + 
     +-int packed_refs_is_locked(struct ref_store *ref_store)
     +-{
     +-	struct packed_ref_store *refs = packed_downcast(
     +-			ref_store,
     +-			REF_STORE_READ | REF_STORE_WRITE,
     +-			"packed_refs_is_locked");
     +-
     +-	return is_lock_file_locked(&refs->lock);
     +-}
     +-
     + /*
     +  * The packed-refs header line that we write out. Perhaps other traits
     +  * will be added later.
      @@ refs/packed-backend.c: int is_packed_transaction_needed(struct ref_store *ref_store,
       
       struct packed_transaction_backend_data {
     @@ refs/packed-backend.c: static void packed_transaction_cleanup(struct packed_ref_
       	transaction->state = REF_TRANSACTION_CLOSED;
       }
       
     -+static int packed_transaction_begin(struct ref_store *ref_store,
     -+				    struct ref_transaction *transaction,
     +-
     + static struct ref_transaction *packed_transaction_begin(struct ref_store *ref_store,
     +-							struct strbuf *err) {
     +-	struct ref_transaction *tr;
     +-	CALLOC_ARRAY(tr, 1);
     +-	return tr;
      +				    struct strbuf *err)
      +{
      +	struct packed_ref_store *refs = packed_downcast(
     @@ refs/packed-backend.c: static void packed_transaction_cleanup(struct packed_ref_
      +			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
      +			"ref_transaction_begin");
      +	struct packed_transaction_backend_data *data;
     -+
     -+	CALLOC_ARRAY(data, 1);
     -+	string_list_init_nodup(&data->updates);
     ++	struct ref_transaction *transaction;
      +
      +	if (!is_lock_file_locked(&refs->lock)) {
      +		if (packed_refs_lock(ref_store, 0, err))
     -+			/* todo: leaking data */
     -+			return -1;
     ++			return NULL;
      +	}
     ++	CALLOC_ARRAY(transaction, 1);
     ++	CALLOC_ARRAY(data, 1);
     ++	string_list_init_nodup(&data->updates);
      +	transaction->backend_data = data;
     -+	return 0;
     -+}
     -+
     ++	return transaction;
     + }
     + 
       static int packed_transaction_prepare(struct ref_store *ref_store,
     - 				      struct ref_transaction *transaction,
     - 				      struct strbuf *err)
      @@ refs/packed-backend.c: static int packed_transaction_prepare(struct ref_store *ref_store,
       			ref_store,
       			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
     @@ refs/packed-backend.c: static int packed_transaction_prepare(struct ref_store *r
       	if (write_with_updates(refs, &data->updates, err))
       		goto failure;
       
     -@@ refs/packed-backend.c: struct ref_storage_be refs_be_packed = {
     - 	.name = "packed",
     - 	.init = packed_ref_store_create,
     - 	.init_db = packed_init_db,
     -+	.transaction_begin = packed_transaction_begin,
     - 	.transaction_prepare = packed_transaction_prepare,
     - 	.transaction_finish = packed_transaction_finish,
     - 	.transaction_abort = packed_transaction_abort,
      
       ## refs/packed-backend.h ##
      @@ refs/packed-backend.h: struct ref_store *packed_ref_store_create(struct repository *repo,
     @@ refs/packed-backend.h: struct ref_store *packed_ref_store_create(struct reposito
       /*
        * Return true if `transaction` really needs to be carried out against
        * the specified packed_ref_store, or false if it can be skipped
     -
     - ## refs/refs-internal.h ##
     -@@ refs/refs-internal.h: typedef struct ref_store *ref_store_init_fn(struct repository *repo,
     - 
     - typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
     - 
     -+typedef int ref_transaction_begin_fn(struct ref_store *refs,
     -+				     struct ref_transaction *transaction,
     -+				     struct strbuf *err);
     -+
     - typedef int ref_transaction_prepare_fn(struct ref_store *refs,
     - 				       struct ref_transaction *transaction,
     - 				       struct strbuf *err);
     -@@ refs/refs-internal.h: struct ref_storage_be {
     - 	ref_store_init_fn *init;
     - 	ref_init_db_fn *init_db;
     - 
     -+	ref_transaction_begin_fn *transaction_begin;
     - 	ref_transaction_prepare_fn *transaction_prepare;
     - 	ref_transaction_finish_fn *transaction_finish;
     - 	ref_transaction_abort_fn *transaction_abort;
 2:  a5cb3adc662 ! 4:  0b8919b05c4 refs: move is_packed_transaction_needed out of packed-backend.c
     @@ refs/files-backend.c: out:
       	return ret;
       }
       
     -+
      +/*
      + * Return true if `transaction` really needs to be carried out against
      + * the specified packed_ref_store, or false if it can be skipped
     @@ refs/files-backend.c: out:
       struct files_transaction_backend_data {
       	struct ref_transaction *packed_transaction;
       	int packed_transaction_needed;
     -@@ refs/files-backend.c: struct ref_storage_be refs_be_files = {
     - 	.delete_reflog = files_delete_reflog,
     - 	.reflog_expire = files_reflog_expire
     - };
     -+
      
       ## refs/packed-backend.c ##
      @@ refs/packed-backend.c: error:
 3:  559c04cee99 ! 5:  d5669da57e3 refs: alternate reftable ref backend implementation
     @@ Commit message
          refs: alternate reftable ref backend implementation
      
          This introduces the reftable backend as an alternative to the packed
     -    backend. This simplifies the code, because we now longer have to worry
     -    about:
     +    backend.
     +
     +    This is an alternative to the approach which was explored in
     +    https://github.com/git/git/pull/1215/. This alternative is simpler,
     +    because we now longer have to worry about:
      
          - pseudorefs and the HEAD ref
          - worktrees
          - commands that blur together files and references (cherry-pick, rebase)
      
          This deviates from the spec that in
     -    Documentation/technical/reftable.txt. It might be possible to update
     -    the code such that all writes by default go to reftable directly. Then
     -    the result would be compatible with an implementation that writes only
     -    reftable (the reftable lock would still prevent races) relative to an
     -    implementation that disregards loose refs. Or,  JGit could be adapted
     -    to follow this implementation.
     +    Documentation/technical/reftable.txt. It might be possible to update the
     +    code such that all writes by default go to reftable directly. Then the
     +    result would be compatible with an implementation that writes only
     +    reftable (the reftable lock would still prevent races), but something
     +    must be done about the HEAD ref (which JGit keeps in reftable too.)
     +    Alternatively, JGit could be adapted to follow this implementation:
     +    despite the code being there for 4 years now, I haven't heard of anyone
     +    using it in production (exactly because CGit does not support it).
      
          For this incremental path, the reftable format is arguably more
          complex than necessary, as
      
          - packed-refs doesn't support symrefs
     -    - reflogs aren't moved into reftable/
     +    - reflogs aren't moved into reftable
      
          on the other hand, the code is already there, and it's well-structured
          and well-tested.
      
     -    This implementation is a prototype. To test, you need to do `export
     -    GIT_TEST_REFTABLE=1`. Doing so creates a handful of errors in the
     -    test-suite, most seemingly related to the new behavior of pack-refs
     -    (which creates a reftable/ dir and not a packed-refs file.), but it
     -    seems overseeable.
     +    refs/reftable-backend.c was created by cannibalizing the first version
     +    of reftable support (github PR 1215 as mentioned above). It supports
     +    reflogs and symrefs, even though those features are never exercised.
     +
     +    This implementation is a prototype, for the following reasons:
     +
     +    - no considerations of backward compatibility and configuring an
     +    extension
     +    - no support for converting between packed-refs and reftable
     +    - no documentation
     +    - test failures when setting GIT_TEST_REFTABLE=1.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ contrib/workdir/git-new-workdir: trap cleanup $siglist
       	case $x in
      
       ## refs/files-backend.c ##
     +@@
     + #include "../git-compat-util.h"
     ++#include "../abspath.h"
     + #include "../config.h"
     + #include "../copy.h"
     + #include "../environment.h"
      @@
       #include "refs-internal.h"
       #include "ref-cache.h"
     @@ refs/files-backend.c
       #include "../iterator.h"
       #include "../dir-iterator.h"
      @@ refs/files-backend.c: static struct ref_store *files_ref_store_create(struct repository *repo,
     + 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
     + 	struct ref_store *ref_store = (struct ref_store *)refs;
     + 	struct strbuf sb = STRBUF_INIT;
     ++	int has_reftable, has_packed;
     + 
     + 	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
       	refs->store_flags = flags;
       	get_common_dir_noenv(&sb, gitdir);
       	refs->gitcommondir = strbuf_detach(&sb, NULL);
     -+
     -+	/* TODO: should look at the repo to decide whether to use packed-refs or
     -+	 * reftable. */
     - 	refs->packed_ref_store =
     +-	refs->packed_ref_store =
      -		packed_ref_store_create(repo, refs->gitcommondir, flags);
     -+		git_env_bool("GIT_TEST_REFTABLE", 0)  
     ++
     ++	strbuf_addf(&sb, "%s/reftable", refs->gitcommondir);
     ++	has_reftable = is_directory(sb.buf);
     ++	strbuf_reset(&sb);
     ++	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
     ++	has_packed = file_exists(sb.buf);
     ++
     ++	if (!has_packed && !has_reftable)
     ++		has_reftable = git_env_bool("GIT_TEST_REFTABLE", 0);
     ++
     ++	refs->packed_ref_store = has_reftable
      +		? git_reftable_ref_store_create(repo, refs->gitcommondir, flags)
      +		: packed_ref_store_create(repo, refs->gitcommondir, flags);
       
       	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
       	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
      
     - ## refs/packed-backend.c ##
     -@@ refs/packed-backend.c: static int write_packed_entry(FILE *fh, const char *refname,
     - 	return 0;
     - }
     - 
     --int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
     -+static int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
     - {
     - 	struct packed_ref_store *refs =
     - 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
     -@@ refs/packed-backend.c: int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
     - 	return 0;
     - }
     - 
     --void packed_refs_unlock(struct ref_store *ref_store)
     -+static void packed_refs_unlock(struct ref_store *ref_store)
     - {
     - 	struct packed_ref_store *refs = packed_downcast(
     - 			ref_store,
     -@@ refs/packed-backend.c: void packed_refs_unlock(struct ref_store *ref_store)
     - 	rollback_lock_file(&refs->lock);
     - }
     - 
     --int packed_refs_is_locked(struct ref_store *ref_store)
     --{
     --	struct packed_ref_store *refs = packed_downcast(
     --			ref_store,
     --			REF_STORE_READ | REF_STORE_WRITE,
     --			"packed_refs_is_locked");
     --
     --	return is_lock_file_locked(&refs->lock);
     --}
     --
     - /*
     -  * The packed-refs header line that we write out. Perhaps other traits
     -  * will be added later.
     -
       ## refs/refs-internal.h ##
      @@ refs/refs-internal.h: struct ref_storage_be {
       };
     @@ refs/reftable-backend.c (new)
      +#include "../worktree.h"
      +#include "refs-internal.h"
      +#include "reftable-backend.h"
     ++#include "../repository.h"
      +
      +extern struct ref_storage_be refs_be_reftable;
      +
     @@ refs/reftable-backend.c (new)
      +	return &ri->base;
      +}
      +
     -+static int fixup_symrefs(struct ref_store *ref_store,
     -+			 struct ref_transaction *transaction)
     -+{
     -+	struct strbuf referent = STRBUF_INIT;
     -+	int i = 0;
     -+	int err = 0;
     -+
     -+	for (i = 0; i < transaction->nr; i++) {
     -+		struct ref_update *update = transaction->updates[i];
     -+		struct object_id old_oid;
     -+		int failure_errno;
     -+
     -+		err = git_reftable_read_raw_ref(ref_store, update->refname,
     -+						&old_oid, &referent,
     -+						/* mutate input, like
     -+						   files-backend.c */
     -+						&update->type, &failure_errno);
     -+		if (err < 0 && failure_errno == ENOENT &&
     -+		    is_null_oid(&update->old_oid)) {
     -+			err = 0;
     -+		}
     -+		if (err < 0)
     -+			goto done;
     -+
     -+		if (!(update->type & REF_ISSYMREF))
     -+			continue;
     -+
     -+		if (update->flags & REF_NO_DEREF) {
     -+			/* what should happen here? See files-backend.c
     -+			 * lock_ref_for_update. */
     -+		} else {
     -+			/*
     -+			  If we are updating a symref (eg. HEAD), we should also
     -+			  update the branch that the symref points to.
     -+
     -+			  This is generic functionality, and would be better
     -+			  done in refs.c, but the current implementation is
     -+			  intertwined with the locking in files-backend.c.
     -+			*/
     -+			int new_flags = update->flags;
     -+			struct ref_update *new_update = NULL;
     -+
     -+			/* if this is an update for HEAD, should also record a
     -+			   log entry for HEAD? See files-backend.c,
     -+			   split_head_update()
     -+			*/
     -+			new_update = ref_transaction_add_update(
     -+				transaction, referent.buf, new_flags,
     -+				&update->new_oid, &update->old_oid,
     -+				update->msg);
     -+			new_update->parent_update = update;
     -+
     -+			/* files-backend sets REF_LOG_ONLY here. */
     -+			update->flags |= REF_NO_DEREF | REF_LOG_ONLY;
     -+			update->flags &= ~REF_HAVE_OLD;
     -+		}
     -+	}
     -+
     -+done:
     -+	assert(err != REFTABLE_API_ERROR);
     -+	strbuf_release(&referent);
     -+	return err;
     -+}
     -+
     -+static int git_reftable_transaction_prepare(struct ref_store *ref_store,
     -+					    struct ref_transaction *transaction,
     -+					    struct strbuf *errbuf)
     ++static struct ref_transaction *git_reftable_transaction_begin(struct ref_store *ref_store,
     ++							      struct strbuf *errbuf)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
      +	struct reftable_addition *add = NULL;
     -+	struct reftable_stack *stack = stack_for(
     -+		refs,
     -+		transaction->nr ? transaction->updates[0]->refname : NULL);
     -+	int i;
     ++	struct ref_transaction *transaction = NULL;
     ++	struct reftable_stack *stack = refs->main_stack;
      +
      +	int err = refs->err;
      +	if (err < 0) {
     @@ refs/reftable-backend.c (new)
      +
      +	err = reftable_stack_new_addition(&add, stack);
      +	if (err) {
     ++		strbuf_addf(errbuf, "reftable: transaction begin: %s",
     ++			    reftable_error_str(err));
      +		goto done;
      +	}
      +
     -+	for (i = 0; i < transaction->nr; i++) {
     -+		struct ref_update *u = transaction->updates[i];
     -+		if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
     -+		    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
     -+		    !(u->flags & REF_LOG_ONLY)) {
     -+			struct object *o =
     -+				parse_object(refs->base.repo, &u->new_oid);
     -+			if (!o) {
     -+				strbuf_addf(
     -+					errbuf,
     -+					"trying to write ref '%s' with nonexistent object %s",
     -+					u->refname, oid_to_hex(&u->new_oid));
     -+				err = -1;
     -+				goto done;
     -+			}
     -+		}
     -+	}
     -+
     -+	err = fixup_symrefs(ref_store, transaction);
     -+	if (err) {
     -+		goto done;
     -+	}
     -+
     ++	CALLOC_ARRAY(transaction, 1);
      +	transaction->backend_data = add;
     -+	transaction->state = REF_TRANSACTION_PREPARED;
     -+
      +done:
     -+	assert(err != REFTABLE_API_ERROR);
     -+	if (err < 0) {
     -+		if (add) {
     -+			reftable_addition_destroy(add);
     -+			add = NULL;
     -+		}
     -+		transaction->state = REF_TRANSACTION_CLOSED;
     -+		if (!errbuf->len)
     -+			strbuf_addf(errbuf, "reftable: transaction prepare: %s",
     -+				    reftable_error_str(err));
     -+	}
     ++	return transaction;
     ++}
      +
     -+	return err;
     ++static int git_reftable_transaction_prepare(struct ref_store *ref_store,
     ++					    struct ref_transaction *transaction,
     ++					    struct strbuf *errbuf)
     ++{
     ++	transaction->state = REF_TRANSACTION_PREPARED;
     ++	return 0;
      +}
      +
      +static int git_reftable_transaction_abort(struct ref_store *ref_store,
     @@ refs/reftable-backend.c (new)
      +					   struct ref_transaction *transaction,
      +					   struct strbuf *errmsg)
      +{
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)transaction->ref_store;
      +	struct reftable_addition *add =
      +		(struct reftable_addition *)transaction->backend_data;
      +	int err = 0;
     @@ refs/reftable-backend.c (new)
      +
      +	err = reftable_addition_commit(add);
      +
     ++	if (!err)
     ++		err = reftable_stack_auto_compact(refs->main_stack);
      +done:
      +	assert(err != REFTABLE_API_ERROR);
      +	reftable_addition_destroy(add);
     @@ refs/reftable-backend.c (new)
      +	.name = "reftable",
      +	.init = git_reftable_ref_store_create,
      +	.init_db = git_reftable_init_db,
     ++	.transaction_begin = git_reftable_transaction_begin,
      +	.transaction_prepare = git_reftable_transaction_prepare,
      +	.transaction_finish = git_reftable_transaction_finish,
      +	.transaction_abort = git_reftable_transaction_abort,
 -:  ----------- > 6:  2cf743031ab refs: always try to do packed transactions for reftable

-- 
gitgitgadget
