Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129E1A9F97
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302073; cv=none; b=M9HQkRmlEhH54BYC3qjCC4VCfekhKdRW6Pq8zDjzfc0ZYAQ60IyKL06eBYhMpIsNyLJuMA3r0IBkjV9IUYlfmbtH4u8T0Wt2XOSKihY7IstROFItMOWbCnDoMbDvMIOSO7rNkkXyeaIg+R4fzkri5ebK44AMgZiycuQELo/8nIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302073; c=relaxed/simple;
	bh=g9tFL3VzvZfD0r1UCA2RAlBSAiNDrTI5hS+y/97AwU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1O9w9lU4Kx+ym7Gv4AcXi9GqSvogsVOtvFTGZPEvJ/GlgBPfOhk2vElsGXOTOgb18qCq3XxBUpZWxernnPyo61JO2ugFZFGQuz553C+7sdWHqjKLE0r7JoFgqtAZP4Rb+q4gqm4GqEc7/DLDi6R2vtsRxZhxzvJXLBF+DCu6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxJM0iCB; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxJM0iCB"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-456f7012050so2812266fac.0
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786302071; x=1786906871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YHOzJMVGFWRrn5js0jnwX1XYapYKvZ/TFqBb3wPTZVU=;
        b=jxJM0iCB/lMBAByU4oAHgthe2KOd3Yok0H3PXUXSJ22JP1A/FqZ6XuKQfYM1dQ3pOw
         cKfO8cwcKp5pPewTWZr5/l1P3Fzohx6enuVr0gc4Ms28INsdsFWENvaySPMBWASmLwZy
         XcrcQC3pyLLJNF1H4Xv29sRQ8QHNSxB4h3C4b38dYSYmEnXViIqJ0F6q8QvCsLbVbwEp
         osMRQ9PGHD94gbGOqyWkuG3ezMdIcSEU9xCo9tq3mTcZwjVYgzspptz7vlya++QEYTcf
         jD4JRzlJEO+tnnk3M864ifDSTrV8zfsbAFhtjVde0597FM/q/0Iwyk9tGCeB/qG4klHZ
         xQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302071; x=1786906871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YHOzJMVGFWRrn5js0jnwX1XYapYKvZ/TFqBb3wPTZVU=;
        b=jlwNsbsy1n5ZeNmQI+Z0dE3tUKv4wR5y/oIAjCwFpr2lZW9e8QhvxqPBxUA59QI+NA
         etkhvXJ4qnDCravzKmnZFbUANw3MkBLU5pL59h3BtG5Q7xoM1yJAOrA0jGycha7v82Vl
         WNmM+cPxFGRSwhnaifw8ekRn8kSa4gR8xmd1+aosbxfQZKQjQjDhgv7OdiqgPWrq9iie
         3o97RTls5vNwHfJ+cIT016DePiokMunz+70d6dD3ALROzR5Ga4bcMAnCpBgTY8dfKcEP
         YqTBRuQamXx3LdkQZduvIcCZEeqFLuKI8zRSlb0H0HYk1MtflmNCeYg/+4/ySGeACvNs
         aGmw==
X-Gm-Message-State: AOJu0YyOcjqFWJRFEdOfQCa2fEVAt1YWUL4H4bmEiC1pLmvmjvgZPUyR
	vsLlVqo/DM3rm86cdsZc6+NCEa8QZWmab6UXUgqTlGm4lDz7vAbvgx9fvmVbJw==
X-Gm-Gg: AR+sD122fZg3YLmp68Dsas6+W4DkS18ueY9nk9PZn9BD8xNHWK2ryMzYtItsRwDbJqp
	dG//MGW3wbzcuRj0HqM/zxTDsHbVfO/ACWS9SiysGVRhGDpwZtu5gSOWzns4eiUzLH2UAu7Fz59
	o168VSzwM+XpPv3WCxZZbLQ9oDjzzcc4LEIsRI7ALiqY+thbBPjktSF8p8Btk+rc24mfDwzRPGG
	x31ifS3zyrOaAPxCq/GoNsWp/0r5qAflRE8y9yIRXPhHTAP0F6lw2Bmum2zfqVkrievZt19dZ7Q
	Sj6iSQDmkWfbzj+NcGcXoFRcWIiH9m3L1Yabrvt0hYHySzL4hLol9PRyt+OhbqG0Kv3EU6hjb8o
	U+EG+k0jVCImqoFD1/YCZrLLQ1SIv0hklM76FDbj3zFYBBGkwVnZv/24hmytT/UaKQ6DC3oerAN
	2C6GwU/Hr2D0spJSitmk4KePuLS4jGBHW1xZjdjDZlDwQ0lLKGPpX+RhTx8gIefgfjoZfSY8MYy
	ftVJUw=
X-Received: by 2002:a05:6808:2381:b0:492:c9a4:2104 with SMTP id 5614622812f47-4b1af83fae5mr7101672b6e.10.1786302070578;
        Sun, 09 Aug 2026 12:01:10 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af5e7b77sm4872188b6e.10.2026.08.09.12.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:01:10 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/7] builtin/receive-pack: support pluggable packfile writes
Date: Sun,  9 Aug 2026 14:00:59 -0500
Message-ID: <20260809190106.1565882-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260806213859.816157-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
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

Justin Tobler (7):
  odb/transaction: add transaction finalize interface
  builtin/receive-pack: pass shallow file explicitly
  builtin/receive-pack: read unpack limit config lazily
  builtin/receive-pack: lift global state out of unpack()
  builtin/receive-pack: report unpack errors via strbuf
  builtin/receive-pack: explicitly pass packfile fd
  odb/transaction: add transaction interface to write packfiles

 builtin/add.c            |   3 +-
 builtin/receive-pack.c   | 211 +++++++++------------------------------
 builtin/unpack-objects.c |   1 +
 builtin/update-index.c   |   2 +
 cache-tree.c             |   4 +-
 object-file.c            | 184 +++++++++++++++++++++++++++++++++-
 odb/transaction.c        |  21 ++++
 odb/transaction.h        |  78 +++++++++++++++
 read-cache.c             |   4 +-
 9 files changed, 339 insertions(+), 169 deletions(-)

Range-diff against v1:
1:  d0a4b632bd ! 1:  10efcc22e4 odb/transaction: add transaction release interface
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    odb/transaction: add transaction release interface
    +    odb/transaction: add transaction finalize interface
     
         When committing an ODB transaction via `odb_transaction_commit()`, the
         staged objects are made visible and the underlying transaction is freed
    @@ Commit message
         the case with the existing "files" backend in git-receive-pack(1).
     
         Stop freeing the transaction in `odb_transaction_commit()` and introduce
    -    `odb_transaction_release()` to explicitly clean up the transaction
    -    accordingly. Note that the release interface also provides an optional
    +    `odb_transaction_finalize()` to explicitly clean up the transaction
    +    accordingly. Note that the finalize interface also provides an optional
         callback for any backend-specific deferred cleanup. In a subsequent
         commit, the "files" transaction backend will use this to remove ".keep"
         files generated for packfiles received via git-receive-pack(1) after
    -    references have been updated.
    +    references have been updated. In preparation for this, the
    +    `odb_transaction_finalize()` call site in git-receive-pack(1) is made
    +    after the reference updates are finished.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ builtin/add.c: int cmd_add(int argc,
      	free(ps_matched);
      	dir_clear(&dir);
      	clear_pathspec(&pathspec);
    -+	odb_transaction_release(transaction);
    ++	odb_transaction_finalize(transaction);
      	return exit_status;
      }
     
    @@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
      		use_keepalive = KEEPALIVE_ALWAYS;
      		execute_commands(commands, unpack_status, &si, transaction,
      				 &push_options);
    -+		odb_transaction_release(transaction);
    ++		odb_transaction_finalize(transaction);
      		delete_tempfile(&pack_lockfile);
      		sigchain_push(SIGPIPE, SIG_IGN);
      		if (report_status_v2)
    @@ builtin/unpack-objects.c: static void unpack_all(void)
      		display_progress(progress, i + 1);
      	}
      	odb_transaction_commit(transaction);
    -+	odb_transaction_release(transaction);
    ++	odb_transaction_finalize(transaction);
      	stop_progress(&progress);
      
      	if (delta_list)
    @@ builtin/update-index.c: int cmd_update_index(int argc,
      			 */
      			if (transaction && verbose) {
      				odb_transaction_commit(transaction);
    -+				odb_transaction_release(transaction);
    ++				odb_transaction_finalize(transaction);
      				transaction = NULL;
      			}
      
    @@ builtin/update-index.c: int cmd_update_index(int argc,
      	 * By now we have added all of the new objects
      	 */
      	odb_transaction_commit(transaction);
    -+	odb_transaction_release(transaction);
    ++	odb_transaction_finalize(transaction);
      
      	if (split_index > 0) {
      		if (repo_config_get_split_index(the_repository) == 0)
    @@ cache-tree.c: int cache_tree_update(struct index_state *istate, int flags)
     -	if (!inflight)
     +	if (!inflight) {
      		odb_transaction_commit(transaction);
    -+		odb_transaction_release(transaction);
    ++		odb_transaction_finalize(transaction);
     +	}
      	trace2_region_leave("cache_tree", "update", istate->repo);
      	trace_performance_leave("cache_tree_update");
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     -			if (!inflight)
     +			if (!inflight) {
      				odb_transaction_commit(transaction);
    -+				odb_transaction_release(transaction);
    ++				odb_transaction_finalize(transaction);
     +			}
      		} else {
      			ret = hash_blob_stream(&stream,
    @@ odb/transaction.c: int odb_transaction_commit(struct odb_transaction *transactio
      
      	ret = transaction->commit(transaction);
      	transaction->source->odb->transaction = NULL;
    --	free(transaction);
    - 
    - 	return ret;
    - }
    - 
    -+void odb_transaction_release(struct odb_transaction *transaction)
    ++
    ++	return ret;
    ++}
    ++
    ++int odb_transaction_finalize(struct odb_transaction *transaction)
     +{
    -+	if (!transaction)
    -+		return;
    ++	int ret = 0;
     +
    -+	if (transaction->release)
    -+		transaction->release(transaction);
    ++	if (!transaction)
    ++		return 0;
     +
    -+	free(transaction);
    -+}
    ++	if (transaction->finalize)
    ++		ret = transaction->finalize(transaction);
     +
    - int odb_transaction_write_object_stream(struct odb_transaction *transaction,
    - 					struct odb_write_stream *stream,
    - 					size_t len, struct object_id *oid)
    + 	free(transaction);
    + 
    + 	return ret;
     
      ## odb/transaction.h ##
     @@ odb/transaction.h: struct odb_transaction {
    @@ odb/transaction.h: struct odb_transaction {
     +	/*
     +	 * Optional ODB source specific callback invoked when the transaction
     +	 * needs to perform any deferred cleanup after objects have been
    -+	 * committed.
    ++	 * committed. Returns 0 on success, a negative error code otherwise.
     +	 */
    -+	void (*release)(struct odb_transaction *transaction);
    ++	int (*finalize)(struct odb_transaction *transaction);
     +
      	/*
      	 * This callback is expected to write the given object stream into
    @@ odb/transaction.h: static inline void odb_transaction_begin_or_die(struct object
      int odb_transaction_commit(struct odb_transaction *transaction);
      
     +/*
    -+ * Releases an ODB transaction, performing any deferred cleanup and freeing it.
    ++ * Finalizes an ODB transaction, performing any deferred cleanup and freeing it.
     + * Must be called for every successfully started transaction. Note that, if the
    -+ * specified transaction is NULL, the function is a no-op.
    ++ * specified transaction is NULL, the function is a no-op. Returns 0 on success,
    ++ * a negative error code otherwise.
     + */
    -+void odb_transaction_release(struct odb_transaction *transaction);
    ++int odb_transaction_finalize(struct odb_transaction *transaction);
     +
      /*
       * Writes the object in the provided stream into the transaction. The resulting
    @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix
     -	if (!inflight)
     +	if (!inflight) {
      		odb_transaction_commit(transaction);
    -+		odb_transaction_release(transaction);
    ++		odb_transaction_finalize(transaction);
     +	}
      
      	release_revisions(&rev);
2:  0aff7f769e = 2:  e1903ac32f builtin/receive-pack: pass shallow file explicitly
-:  ---------- > 3:  e4950c0abe builtin/receive-pack: read unpack limit config lazily
3:  61bac2a56f ! 4:  c9b4ff73ba builtin/receive-pack: lift global state out of unpack()
    @@ Commit message
         invoke the underlying git-index-pack(1) or git-unpack-objects(1) child
         processes. In a subsequent commit, the `unpack()` logic is moved behind
         a generic ODB transaction interface to handle writing packfiles and thus
    -    can no rely on these globals.
    +    can no longer rely on these globals.
     
         Lift the global state out of `unpack()` by instead storing this state in
         a `struct unpack_opts` that gets passed to the function explicitly.
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## builtin/receive-pack.c ##
    -@@ builtin/receive-pack.c: static void push_header_arg(struct strvec *args, struct pack_header *hdr)
    - 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
    +@@ builtin/receive-pack.c: static int get_unpack_limit(struct repository *repo)
    + 	return limit;
      }
      
     +struct unpack_opts {
    @@ builtin/receive-pack.c: static void push_header_arg(struct strvec *args, struct
     +	const char *shallow_file;
     +	off_t max_input_size;
     +	int fsck_objects;
    -+	int unpack_limit;
     +	int reject_thin;
     +	int err_fd;
     +	int quiet;
    @@ builtin/receive-pack.c: static const char *unpack(struct odb_transaction *transa
      	}
      
      	odb_transaction_env(transaction, &child.env);
    - 
    --	if (ntohl(hdr.hdr_entries) < unpack_limit) {
    -+	if (ntohl(hdr.hdr_entries) < opts->unpack_limit) {
    +@@ builtin/receive-pack.c: static const char *unpack(struct odb_transaction *transaction,
    + 	if (ntohl(hdr.hdr_entries) < get_unpack_limit(the_repository)) {
      		strvec_push(&child.args, "unpack-objects");
      		push_header_arg(&child.args, &hdr);
     -		if (quiet)
    @@ builtin/receive-pack.c: static const char *unpack(struct odb_transaction *transa
     +		.fsck_msg_types = fsck_msg_types.buf,
     +		.max_input_size = max_input_size,
     +		.shallow_file = shallow_file,
    -+		.unpack_limit = unpack_limit,
     +		.reject_thin = reject_thin,
     +		.quiet = quiet,
     +	};
4:  12b83ee3bc ! 5:  7be990c2c2 builtin/receive-pack: report unpack errors via strbuf
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
      }
      
     -static void report(struct command *commands, const char *unpack_status)
    -+static void report(struct command *commands, struct strbuf *unpack_status)
    ++static void report(struct command *commands, const struct strbuf *unpack_status)
      {
      	struct command *cmd;
      	struct strbuf buf = STRBUF_INIT;
    @@ builtin/receive-pack.c: static void report(struct command *commands, const char
      }
      
     -static void report_v2(struct command *commands, const char *unpack_status)
    -+static void report_v2(struct command *commands, struct strbuf *unpack_status)
    ++static void report_v2(struct command *commands, const struct strbuf *unpack_status)
      {
      	struct command *cmd;
      	struct strbuf buf = STRBUF_INIT;
    @@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
     -		execute_commands(commands, unpack_status, &si, transaction,
     +		execute_commands(commands, !!unpack_status.len, &si, transaction,
      				 &push_options);
    - 		odb_transaction_release(transaction);
    + 		odb_transaction_finalize(transaction);
      		delete_tempfile(&pack_lockfile);
      		sigchain_push(SIGPIPE, SIG_IGN);
      		if (report_status_v2)
5:  8678f4cd45 = 6:  742c724943 builtin/receive-pack: explicitly pass packfile fd
6:  c390f59367 ! 7:  7743cf242a odb/transaction: add transaction interface to write packfiles
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## builtin/receive-pack.c ##
    +@@
    + #include "gpg-interface.h"
    + #include "hex.h"
    + #include "hook.h"
    +-#include "lockfile.h"
    + #include "object.h"
    + #include "object-file.h"
    + #include "object-name.h"
    +@@
    + #include "oid-array.h"
    + #include "oidset.h"
    + #include "pack.h"
    +-#include "packfile.h"
    + #include "parse-options.h"
    + #include "pkt-line.h"
    + #include "protocol.h"
     @@ builtin/receive-pack.c: static void read_push_options(struct packet_reader *reader,
      	}
      }
    @@ builtin/receive-pack.c: static void read_push_options(struct packet_reader *read
     -		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
     -}
     -
    +-static int get_unpack_limit(struct repository *repo)
    +-{
    +-	static int limit = -1;
    +-
    +-	if (limit < 0) {
    +-		int receive_limit = -1;
    +-		int transfer_limit = -1;
    +-
    +-		repo_config_get_int(repo, "receive.unpacklimit",
    +-				    &receive_limit);
    +-		repo_config_get_int(repo, "transfer.unpacklimit",
    +-				    &transfer_limit);
    +-
    +-		if (receive_limit >= 0)
    +-			limit = receive_limit;
    +-		else if (transfer_limit >= 0)
    +-			limit = transfer_limit;
    +-		else
    +-			limit = 100;
    +-	}
    +-
    +-	return limit;
    +-}
    +-
     -struct unpack_opts {
     -	const char *fsck_msg_types;
     -	const char *shallow_file;
     -	off_t max_input_size;
     -	int fsck_objects;
    --	int unpack_limit;
     -	int reject_thin;
     -	int err_fd;
     -	int quiet;
    @@ builtin/receive-pack.c: static void read_push_options(struct packet_reader *read
     -
     -	odb_transaction_env(transaction, &child.env);
     -
    --	if (ntohl(hdr.hdr_entries) < opts->unpack_limit) {
    +-	if (ntohl(hdr.hdr_entries) < get_unpack_limit(the_repository)) {
     -		strvec_push(&child.args, "unpack-objects");
     -		push_header_arg(&child.args, &hdr);
     -		if (opts->quiet)
    @@ builtin/receive-pack.c: static int unpack_with_sideband(struct odb_transaction *
     @@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
      		execute_commands(commands, !!unpack_status.len, &si, transaction,
      				 &push_options);
    - 		odb_transaction_release(transaction);
    + 		odb_transaction_finalize(transaction);
     -		delete_tempfile(&pack_lockfile);
      		sigchain_push(SIGPIPE, SIG_IGN);
      		if (report_status_v2)
      			report_v2(commands, &unpack_status);
     
      ## object-file.c ##
    +@@
    + #define USE_THE_REPOSITORY_VARIABLE
    + 
    + #include "git-compat-util.h"
    ++#include "config.h"
    + #include "convert.h"
    + #include "dir.h"
    + #include "environment.h"
     @@
      #include "packfile.h"
      #include "path.h"
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
     +		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
     +}
     +
    ++static int get_unpack_limit(struct repository *repo)
    ++{
    ++	static int limit = -1;
    ++
    ++	if (limit < 0) {
    ++		int receive_limit = -1;
    ++		int transfer_limit = -1;
    ++
    ++		repo_config_get_int(repo, "receive.unpacklimit",
    ++				    &receive_limit);
    ++		repo_config_get_int(repo, "transfer.unpacklimit",
    ++				    &transfer_limit);
    ++
    ++		if (receive_limit >= 0)
    ++			limit = receive_limit;
    ++		else if (transfer_limit >= 0)
    ++			limit = transfer_limit;
    ++		else
    ++			limit = 100;
    ++	}
    ++
    ++	return limit;
    ++}
    ++
     +static int odb_transaction_files_write_pack(struct odb_transaction *base,
     +					    int pack_fd, struct strbuf *err_msg,
     +					    const struct odb_transaction_write_pack_opts *opts)
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
     +
     +	odb_transaction_env(base, &child.env);
     +
    -+	if (ntohl(hdr.hdr_entries) < (unsigned int)opts->unpack_limit) {
    ++	if (ntohl(hdr.hdr_entries) < (unsigned int)get_unpack_limit(repo)) {
     +		strvec_push(&child.args, "unpack-objects");
     +		push_header_arg(&child.args, &hdr);
     +		if (opts->quiet)
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
     +			strbuf_addstr(err_msg, "index-pack abnormal exit");
     +			return -1;
     +		}
    -+		odb_reprepare(repo->objects);
    ++
    ++		odb_source_prepare(repo->objects->sources,
    ++				   ODB_PREPARE_FLUSH_CACHES);
     +	}
     +
     +	return 0;
     +}
     +
    -+static void odb_transaction_files_release(struct odb_transaction *base)
    ++static int odb_transaction_files_finalize(struct odb_transaction *base)
     +{
     +	struct odb_transaction_files *transaction =
     +		container_of(base, struct odb_transaction_files, base);
    ++	int ret = 0;
     +
     +	for (size_t i = 0; i < transaction->pack_lockfiles_nr; i++)
    -+		delete_tempfile(&transaction->pack_lockfiles[i]);
    ++		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
    ++
     +	free(transaction->pack_lockfiles);
    ++
    ++	return ret;
     +}
     +
      static int odb_transaction_files_env(struct odb_transaction *base,
    @@ object-file.c: int odb_transaction_files_begin(struct odb_source *source,
      	transaction = xcalloc(1, sizeof(*transaction));
      	transaction->base.source = source;
      	transaction->base.commit = odb_transaction_files_commit;
    -+	transaction->base.release = odb_transaction_files_release;
    ++	transaction->base.finalize = odb_transaction_files_finalize;
      	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
     +	transaction->base.write_pack = odb_transaction_files_write_pack;
      	transaction->base.env = odb_transaction_files_env;
    @@ odb/transaction.h
     +	 * are verified.
     +	 */
     +	const char *fsck_msg_types;
    ++
     +	/*
     +	 * Path to an alternative shallow file describing the shallow boundaries
     +	 * to honor while ingesting the pack.
     +	 */
     +	const char *shallow_file;
    ++
     +	/*
     +	 * The max size in bytes of the incoming packfile allowed. No limit is
     +	 * enforced when set to 0.
     +	 */
    ++
     +	off_t max_input_size;
    ++
     +	/*
     +	 * Whether the validity of incoming objects should be verified.
     +	 */
     +	int fsck_objects;
    -+	/*
    -+	 * The threshold for the number of incoming objects required to store
    -+	 * the objects in a packfile. This option may not be relevant to
    -+	 * backends that do not store obejcts in loose/packed formats and can be
    -+	 * ignored.
    -+	 */
    -+	int unpack_limit;
    ++
     +	/*
     +	 * Whether to reject an incoming packfile if it is "thin".
     +	 */
     +	int reject_thin;
    ++
     +	/*
     +	 * Optional file descriptor for reporting progress and errors. Set to 0
     +	 * for none.
     +	 */
     +	int err_fd;
    ++
     +	/*
     +	 * Suppresses progress reporting.
     +	 */

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.424.g13c7afec21

