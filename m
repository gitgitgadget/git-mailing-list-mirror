Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6183C17
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077414; cv=none; b=PbzeitxxrS+ntEHOrQd6LrmiXHbEzdDCmqL2C7+peoZjINpW+v2eJVQDKcgimQudI3xkMFDGaGhJtfltC56gvCu0AobIF3deOVraUWJB6SqW56rcLCw8uwr7Paajisyl2PHH/9/BcK3x+vs1fJqVWxCNH+QaA84Ck94pF2eRxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077414; c=relaxed/simple;
	bh=nnh91fnrbicsPHZw/C+9MZNTPadNETTDg6UNBKnliFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Or0Q+WFLbCifP3uHnkzxy8PAd8PAVF2wyDQ0O5QKfRomN5homH3oYtdoUkYnErPum2NzyCwRLi0+9jaOcig8thuKRK6RCnKuHZdamGlHjFJPkCVKm9fQe1s05OVvUDbtthGwdGxM+c2dWFP+3vVQDL827XzUaPjZv6TCWcA7C0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJqnM2s4; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJqnM2s4"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45c92df37fdso2367010b6e.3
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 16:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770077411; x=1770682211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjxSkIBFFtHxGBkwDtifFePW9PxvL4rVX0gvGQLWaNg=;
        b=YJqnM2s41eDqDQPUMMXYUPKZArTIFCkEVijtq1H3YLzKrEkPfI5jJk1EXmFjJiQ4pu
         p1APg9kJ+PC2oYPM3NwRRHBa/KWfTXKDIu+fl0WM+JYMz4T1KP49qa1cELT+mRunIa+v
         /0BPH9Bg3GbvTmOGS44FRzf67YOQED2aHPQgq9go2Eep34V3fW2cCKwGxGyH69clTIlj
         0uYb1TPyUHn27W1UF8mHi9jMaaF58j16uP2I953+/Xkb9A2Fq6rKdc+z8DujeHMIifrG
         XqyuGEBMJ32urO1r9HsE1LNwDAzX29vfxzuEAcceqgn6z5mMhDr34EnjWZaAO0CgWuEW
         dfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770077411; x=1770682211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjxSkIBFFtHxGBkwDtifFePW9PxvL4rVX0gvGQLWaNg=;
        b=O5vOzp0EaEOShoUrr0pem6hIKw+we3Ebb30RNwbnPhPx2K2u9RPcXnZlNoUreAkHsH
         qzsI/UA4a3iLZLLv60AV9TDwEFuQFfvKoxJGNiYAx/4ARZj5S6Da+wON2tTfV3n+3Boc
         xTQdytabIf58ANxrrJANczYAgEZkyNRF6wYrfsaWS6WmMjpDt0Z4jzCnyBDRH6dZgsJ5
         KyQDa0T5etrXlSwiY+/WsvUsnOdH0PNMH/2FP7tgrz2gEuJOmmt72LOzna6c+eU4WYNK
         lnGgOvisEwQ6HI/Aj2USe28G0S4ywG1sv9QSk9z93A88qkxZKuQuWiIkyIkechjGpz2W
         DQFw==
X-Gm-Message-State: AOJu0YzNDHhgmuqyn2DJVFlgmrNH0KHwSIwkrsdMev7zPpl2i8Y8hwkU
	y42Rvq1h7ca9RUtvEavzx+LEGq7oxWbYchglFE8W+9FjYYEJiZOHA+Qr+CE8hA==
X-Gm-Gg: AZuq6aLvCEuBRZO5MGLdL662/5i+w0SsoYTA8/RU3x4UeMdKCidw4piwWv0TjJbpY7+
	9fbsSSzKuItOSnRXCAh3I2EYntYBztkMVDsRYcZjtxSbDXXt+5tyecJ72WkMDJXs89BDkioRhZ1
	Q3J21HO/iVNKu6eeelbMeS1gQRbD0Ls3Cy/9uC3dMtHQMWAFdMoqSz1h1qSOjHFQSKUXTN7Caas
	CRGqERvjGjzlgLRX1zWdVMxtEVO/2TROV2Y+TyfVjmlurGKMeiKqCzH0jpcgKw9dA4JmDPSxnSS
	/bOEJMxasti4XY/BbsnJkgjPaRrtss9zGtxHQhjQoz44xfQAtapPaQ3AvTawImRkek7zfDbOpKm
	nqoKgA6qU4PkQ8qWDajGebgV1CYt1bTRPqxq91bI2LJ5SK6xAR3Td1nQlVegf8Hvj7Dd+I7WRxX
	WIgQFLO394h9Q5r1Km3Cs=
X-Received: by 2002:a05:6808:150d:b0:45e:e0a5:301a with SMTP id 5614622812f47-45f34d8b6efmr6337290b6e.65.1770077410823;
        Mon, 02 Feb 2026 16:10:10 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f6010esm9851179b6e.15.2026.02.02.16.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:10:10 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/4] odb: support ODB source specific transaction handling
Date: Mon,  2 Feb 2026 18:09:58 -0600
Message-ID: <20260203001002.2500198-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.373.g68cb7f9e92
In-Reply-To: <20260128234519.2721179-1-jltobler@gmail.com>
References: <20260128234519.2721179-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

ODB transactions provide a mechanism for writing new objects in the
repository that are in a pending state until they are committed. With
pluggable ODBs, each source will likely need to handle transactions
differently. This patch series prepares ODB transaction handling to be
defined for each ODB source by creating a generic odb_transaction
structure that stores a callback for committing the transaction.

For now, `struct odb_transaction_files` is the only transaction
implementation and what is always returned when creating a transaction.
Additionally, this series lifts transaction logic that is common to all
backends out of the implementation layer into
`odb_transaction_{begin,commit}()` layer.

Changes since V1:

- Renamed the files transaction type to be `odb_transaction_files`.
  Associated functions were also renamed accordingly.
- Updated commit messages.
- The `tmp_objdir` subsystem has been left unchange in the version. In a
  followup series, I plan to couple tmpdirs directly to ODB files
  transactions.

Thanks,
-Justin

Justin Tobler (4):
  odb: store ODB source in `struct odb_transaction`
  object-file: rename transaction functions
  odb: prepare `struct odb_transaction` to become generic
  odb: transparently handle common transaction behavior

 object-file.c | 77 +++++++++++++++++++++++++--------------------------
 object-file.h | 10 ++-----
 odb.c         | 19 +++++++++++--
 odb.h         | 17 ++++++++++++
 4 files changed, 74 insertions(+), 49 deletions(-)

Range-diff against v1:
1:  525c96f5f2 = 1:  525c96f5f2 odb: store ODB source in `struct odb_transaction`
2:  5ee1085453 ! 2:  02528f49fb object-file: rename transaction functions
    @@ Commit message
         In a subsequent commit, ODB transactions are made more generic to
         facilitate each ODB source providing its own transaction handling.
         Rename `object_file_transaction_{begin,commit}()` to
    -    `odb_transaction_loose_{begin,commit}()` to better match the future
    +    `odb_transaction_files_{begin,commit}()` to better match the future
         source specific transaction implementation.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
    @@ object-file.c: static void prepare_loose_object_transaction(struct odb_transacti
      	 * the first time an object might be added, since
      	 * callers may not know whether any objects will be
     -	 * added at the time they call object_file_transaction_begin.
    -+	 * added at the time they call odb_transaction_loose_begin.
    ++	 * added at the time they call odb_transaction_files_begin.
      	 */
      	if (!transaction || transaction->objdir)
      		return;
    @@ object-file.c: int read_loose_object(struct repository *repo,
      }
      
     -struct odb_transaction *object_file_transaction_begin(struct odb_source *source)
    -+struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source)
    ++struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
      {
      	struct object_database *odb = source->odb;
      
    @@ object-file.c: struct odb_transaction *object_file_transaction_begin(struct odb_
      }
      
     -void object_file_transaction_commit(struct odb_transaction *transaction)
    -+void odb_transaction_loose_commit(struct odb_transaction *transaction)
    ++void odb_transaction_files_commit(struct odb_transaction *transaction)
      {
      	if (!transaction)
      		return;
    @@ object-file.h: struct odb_transaction;
      /*
       * Tell the object database to optimize for adding
     - * multiple objects. object_file_transaction_commit must be called
    -+ * multiple objects. odb_transaction_loose_commit must be called
    ++ * multiple objects. odb_transaction_files_commit must be called
       * to make new objects visible. If a transaction is already
       * pending, NULL is returned.
       */
     -struct odb_transaction *object_file_transaction_begin(struct odb_source *source);
    -+struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source);
    ++struct odb_transaction *odb_transaction_files_begin(struct odb_source *source);
      
      /*
       * Tell the object database to make any objects from the
       * current transaction visible.
       */
     -void object_file_transaction_commit(struct odb_transaction *transaction);
    -+void odb_transaction_loose_commit(struct odb_transaction *transaction);
    ++void odb_transaction_files_commit(struct odb_transaction *transaction);
      
      #endif /* OBJECT_FILE_H */
     
    @@ odb.c: void odb_reprepare(struct object_database *o)
      struct odb_transaction *odb_transaction_begin(struct object_database *odb)
      {
     -	return object_file_transaction_begin(odb->sources);
    -+	return odb_transaction_loose_begin(odb->sources);
    ++	return odb_transaction_files_begin(odb->sources);
      }
      
      void odb_transaction_commit(struct odb_transaction *transaction)
      {
     -	object_file_transaction_commit(transaction);
    -+	odb_transaction_loose_commit(transaction);
    ++	odb_transaction_files_commit(transaction);
      }
3:  a06bfd8c55 ! 3:  081c82428b odb: prepare `struct odb_transaction` to support more sources
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    odb: prepare `struct odb_transaction` to support more sources
    +    odb: prepare `struct odb_transaction` to become generic
     
    -    Each ODB transaction should be specific to the ODB source it pertains
    -    to. Update `struct odb_transaction` to store a commit callback specific
    -    to its object source type. For now `struct odb_transaction_loose` is the
    +    An ODB transaction handles how objects are stored temporarily and
    +    eventually committed. Due to object storage being implemented
    +    differently for a given ODB source, the ODB transactions must be
    +    implemented in a manner specific to the source the objects are being
    +    written to. To provide generic transactions, `struct odb_transaction` is
    +    updated to store a commit callback that can be configured to support a
    +    specific ODB source. For now `struct odb_transaction_files` is the
         only transaction type and what is always returned when starting a
         transaction.
     
    @@ object-file.c: struct transaction_packfile {
      
     -struct odb_transaction {
     -	struct odb_source *source;
    -+struct odb_transaction_loose {
    ++struct odb_transaction_files {
     +	struct odb_transaction base;
      
      	struct tmp_objdir *objdir;
    @@ object-file.c: struct transaction_packfile {
     -static void prepare_loose_object_transaction(struct odb_transaction *transaction)
     +static void prepare_loose_object_transaction(struct odb_transaction *base)
      {
    -+	struct odb_transaction_loose *transaction = (struct odb_transaction_loose *)base;
    ++	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
     +
      	/*
      	 * We lazily create the temporary object directory
    @@ object-file.c: static void prepare_loose_object_transaction(struct odb_transacti
     +static void fsync_loose_object_transaction(struct odb_transaction *base,
      					   int fd, const char *filename)
      {
    -+	struct odb_transaction_loose *transaction = (struct odb_transaction_loose *)base;
    ++	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
     +
      	/*
      	 * If we have an active ODB transaction, we issue a call that
    @@ object-file.c: static void fsync_loose_object_transaction(struct odb_transaction
       * Cleanup after batch-mode fsync_object_files.
       */
     -static void flush_loose_object_transaction(struct odb_transaction *transaction)
    -+static void flush_loose_object_transaction(struct odb_transaction_loose *transaction)
    ++static void flush_loose_object_transaction(struct odb_transaction_files *transaction)
      {
      	struct strbuf temp_path = STRBUF_INIT;
      	struct tempfile *temp;
    @@ object-file.c: static int index_core(struct index_state *istate,
      }
      
     -static int already_written(struct odb_transaction *transaction,
    -+static int already_written(struct odb_transaction_loose *transaction,
    ++static int already_written(struct odb_transaction_files *transaction,
      			   struct object_id *oid)
      {
      	/* The object may already exist in the repository */
    @@ object-file.c: static int already_written(struct odb_transaction *transaction,
      
      /* Lazily create backing packfile for the state */
     -static void prepare_packfile_transaction(struct odb_transaction *transaction,
    -+static void prepare_packfile_transaction(struct odb_transaction_loose *transaction,
    ++static void prepare_packfile_transaction(struct odb_transaction_files *transaction,
      					 unsigned flags)
      {
      	struct transaction_packfile *state = &transaction->packfile;
    @@ object-file.c: static int stream_blob_to_pack(struct transaction_packfile *state
      }
      
     -static void flush_packfile_transaction(struct odb_transaction *transaction)
    -+static void flush_packfile_transaction(struct odb_transaction_loose *transaction)
    ++static void flush_packfile_transaction(struct odb_transaction_files *transaction)
      {
      	struct transaction_packfile *state = &transaction->packfile;
     -	struct repository *repo = transaction->source->odb->repo;
    @@ object-file.c: static void flush_packfile_transaction(struct odb_transaction *tr
       * callers should avoid this code path when filters are requested.
       */
     -static int index_blob_packfile_transaction(struct odb_transaction *transaction,
    -+static int index_blob_packfile_transaction(struct odb_transaction_loose *transaction,
    ++static int index_blob_packfile_transaction(struct odb_transaction_files *transaction,
      					   struct object_id *result_oid, int fd,
      					   size_t size, const char *path,
      					   unsigned flags)
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     -		transaction = odb_transaction_begin(the_repository->objects);
     -		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
     +		transaction = odb_transaction_begin(odb);
    -+		ret = index_blob_packfile_transaction((struct odb_transaction_loose *)odb->transaction,
    ++		ret = index_blob_packfile_transaction((struct odb_transaction_files *)odb->transaction,
      						      oid, fd,
      						      xsize_t(st->st_size),
      						      path, flags);
    @@ object-file.c: int read_loose_object(struct repository *repo,
      	return ret;
      }
      
    --struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source)
    -+static void odb_transaction_loose_commit(struct odb_transaction *base)
    +-struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
    ++static void odb_transaction_files_commit(struct odb_transaction *base)
      {
     -	struct object_database *odb = source->odb;
     -
    @@ object-file.c: int read_loose_object(struct repository *repo,
     -	return odb->transaction;
     -}
     -
    --void odb_transaction_loose_commit(struct odb_transaction *transaction)
    +-void odb_transaction_files_commit(struct odb_transaction *transaction)
     -{
     -	if (!transaction)
     -		return;
    -+	struct odb_transaction_loose *transaction = (struct odb_transaction_loose *)base;
    ++	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
      
      	/*
      	 * Ensure the transaction ending matches the pending transaction.
    @@ object-file.c: int read_loose_object(struct repository *repo,
      	free(transaction);
      }
      
    -+struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source)
    ++struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
     +{
    -+	struct odb_transaction_loose *transaction;
    ++	struct odb_transaction_files *transaction;
     +	struct object_database *odb = source->odb;
     +
     +	if (odb->transaction)
    @@ object-file.c: int read_loose_object(struct repository *repo,
     +
     +	transaction = xcalloc(1, sizeof(*transaction));
     +	transaction->base.source = source;
    -+	transaction->base.commit = odb_transaction_loose_commit;
    ++	transaction->base.commit = odb_transaction_files_commit;
     +
     +	odb->transaction = &transaction->base;
     +
    @@ object-file.c: int read_loose_object(struct repository *repo,
      ## object-file.h ##
     @@ object-file.h: struct odb_transaction;
       */
    - struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source);
    + struct odb_transaction *odb_transaction_files_begin(struct odb_source *source);
      
     -/*
     - * Tell the object database to make any objects from the
     - * current transaction visible.
     - */
    --void odb_transaction_loose_commit(struct odb_transaction *transaction);
    +-void odb_transaction_files_commit(struct odb_transaction *transaction);
     -
      #endif /* OBJECT_FILE_H */
     
    @@ odb.c: struct odb_transaction *odb_transaction_begin(struct object_database *odb
      
      void odb_transaction_commit(struct odb_transaction *transaction)
      {
    --	odb_transaction_loose_commit(transaction);
    +-	odb_transaction_files_commit(transaction);
     +	if (!transaction)
     +		return;
     +
4:  476ed1235c ! 4:  ed8164a3a3 odb: transparently handle common transaction behavior
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## object-file.c ##
    -@@ object-file.c: static void odb_transaction_loose_commit(struct odb_transaction *base)
    +@@ object-file.c: static void odb_transaction_files_commit(struct odb_transaction *base)
      {
    - 	struct odb_transaction_loose *transaction = (struct odb_transaction_loose *)base;
    + 	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
      
     -	/*
     -	 * Ensure the transaction ending matches the pending transaction.
    @@ object-file.c: static void odb_transaction_loose_commit(struct odb_transaction *
     -	free(transaction);
      }
      
    - struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source)
    -@@ object-file.c: struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source)
    + struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
    +@@ object-file.c: struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
      	transaction->base.source = source;
    - 	transaction->base.commit = odb_transaction_loose_commit;
    + 	transaction->base.commit = odb_transaction_files_commit;
      
     -	odb->transaction = &transaction->base;
     -
    @@ odb.c: void odb_reprepare(struct object_database *o)
      
      struct odb_transaction *odb_transaction_begin(struct object_database *odb)
      {
    --	return odb_transaction_loose_begin(odb->sources);
    -+	struct odb_transaction *transaction;
    -+
    +-	return odb_transaction_files_begin(odb->sources);
     +	if (odb->transaction)
     +		return NULL;
     +
    -+	transaction = odb_transaction_loose_begin(odb->sources);
    -+	odb->transaction = transaction;
    ++	odb->transaction = odb_transaction_files_begin(odb->sources);
     +
    -+	return transaction;
    ++	return odb->transaction;
      }
      
      void odb_transaction_commit(struct odb_transaction *transaction)

base-commit: ea717645d199f6f1b66058886475db3e8c9330e9
-- 
2.52.0.373.g68cb7f9e92

