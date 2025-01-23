Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACA20F070
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640586; cv=none; b=n9f3RGTy1UqQeVQhCJYlXzSQErDfXwQP1UdYNJjx/Nj9CQEDf/LggBQGpgqHcuIA1ISCFMt3URzjDgj9VhVDdoQD0LR60X69giByLHy7hSgY7PhL/T3yWa5s/meMAedGwaGWdCIQ2dVFJahWUzSg+q7K9L/dBZc8BiIpTS5AboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640586; c=relaxed/simple;
	bh=onuVc7XmUUFvaT/MgB0WmAI7UKVVnizdHSWo7EEkJIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkBPBz7iUx/AWPDlmIlNPZXwe/ofhweWKsccDooo4St5jjsqZCQR21qTGutIcG1KFbNUVo8Jb6GKl54c2SxGIKm2rIXt64/Cv5XW46FT7j5qe5/qCfLgzGplJB/o+5aVDnLnZUzEpngVj4LAulGwG3K9Qy740fboWxcF6LP6r64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXW8U6w8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXW8U6w8"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so1754717a91.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 05:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737640583; x=1738245383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKPqIdYiMYolTXwFzlAmiOCsPVeaj9LPSPKqCZ+Poro=;
        b=HXW8U6w8V9EKDsK1ng9R1PoKsSgDeAF6JgjaIWSY+2hZeA5YW2ptj9RWezzWAxhv0Q
         u6T/Mxevf3haVm21UcU3vmNVWa753YO84RFIeNw2dqU28Lb4gW989+l7uCAE4dECE/VA
         qZqpSR+VnqRMN8gPtk8Cwt8Jo3K2kdCwobI+nomU3M3RO8wrO4voZ8rYeVuStv/D+o6h
         YuVkPkXYtGuZS0oQK9HrZsUIUG2RVYVSxugrnJzUI3RIlaKDNXdsIivEz1/6Y24gcN+P
         ZwTgnTHFja59eHQ230CQPBkODsHCL0vwCPElpMhjJFljaNZKrTtQlnGaVffg/rNPfE+/
         LJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737640583; x=1738245383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKPqIdYiMYolTXwFzlAmiOCsPVeaj9LPSPKqCZ+Poro=;
        b=l6HLJoxcV61XHh5frevbm8qZ7x5RmA25DUKsmW3VQ1ovJwijgPmPlLbM39tZTo4UtX
         fi6am0DopWyM+WFrZDqBHRCQjmfts+lvzp5Y++IGc/O0osAq/f/FM5uYzsc5vQgyJl7D
         hVb7AM+FB+hL20LD8yFLqH2zHUwFsuUyR3HN/09XCzRv6Ej1JfcueTEs16cafGfr9NCK
         u+eCCRowwKSzJgU7Nv/MzzyRDpJ8KaIM5cbsMHaTAq23zYg8aix+1uBuOtNcHvjhT50h
         sLlos4Luww19FH7LZtWEMQDMddzaC02UUOai6Cqsh5MKLSh6kUdSGjALIo4BuOmRR8yI
         5DXg==
X-Gm-Message-State: AOJu0YwIhhxui7iE8iWyc4C1mY1OFsKJwAnfaBSrnkd4KbO4deSrk9Gt
	y2KqC6V4NfAOzreIrzKPcZkdlB87OUf+Mzj7OPHLtucDrJqBdIFRartRM2HG
X-Gm-Gg: ASbGncvRD8GjKUGjB9qyAVcDEy7LzcFj0tDFVrfdB+vU+T/UI12ek+eFCVIBsmh/vQY
	79+D4jOZHrBBz3rUgEOvMaVWwidhekGhHEJ2gBSg1EN5lXOnoOwhpfYyrLBYYWDvusoDOxNxzuq
	4IGvxUpLrrmn6Ekagn8wndoS7Ksz8wWq+zcYaOT9FX4fkHo7cRTQbvLpoP0e+BypCRNw83460XE
	l6X43aMzavEkpnjqQDEL4mifoFc9LjKLEdKeqWSJZe/VPEWusBemZAsN88/fwV5EaWbnBaFWlE4
	n2BRiF/18I2IfppK+fPO
X-Google-Smtp-Source: AGHT+IG+OQ4g9y/N4C9cQeEeVmIcf45gmMscSamcwUQaB9WX6+fN4YiUhPIQesPTrlDVqCOq6jGg4g==
X-Received: by 2002:a17:90b:4d05:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-2f782c70176mr38764651a91.9.1737640583199;
        Thu, 23 Jan 2025 05:56:23 -0800 (PST)
Received: from localhost.localdomain ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a64371sm4002207a91.5.2025.01.23.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:56:22 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	gitster@pobox.com,
	sandals@crustytoothpaste.net,
	Johannes.Schindelin@gmx.de
Subject: [PATCH v2] reftable: write correct max_update_index to header
Date: Thu, 23 Jan 2025 14:56:13 +0100
Message-ID: <20250123135613.748916-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
References: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 297c09eabb (refs: allow multiple reflog entries for the same refname,
2024-12-16), the reftable backend learned to handle multiple reflog
entries within the same transaction. This was done modifying the
`update_index` for reflogs with multiple indices. During writing the
logs, the `max_update_index` of the writer was modified to ensure the
limits were raised to the modified `update_index`s.

However, since ref entries are written before the modification to the
`max_update_index`, if there are multiple blocks to be written, the
reftable backend writes the header with the old `max_update_index`. When
all logs are finally written, the footer will be written with the new
`min_update_index`. This causes a mismatch between the header and the
footer and causes the reftable file to be corrupted. The existing tests
only spawn a single block and since headers are lazily written with the
first block, the tests didn't capture this bug.

To fix the issue, the appropriate `max_update_index` limit must be set
even before the first block is written. Add a `max_index` field to the
transaction which holds the `max_index` within all its updates, then
propagate this value to the reftable backend, wherein this is used to
the set the `max_update_index` correctly.

Add a test which creates a few thousand reference updates with multiple
reflog entries, which should trigger the bug.

Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Hello,

While this patch was merged to next, Dscho reported that it was flaky
on macos pipeline. On further investigation I found this was easily
reproducible when the leak sanitizer was turned on and the reftable
tests were run. The fix was simply to add the missing 0 initialization.

I also found that we didn't set the appropriate values for all elements
of the `reftable_transaction_data`. Which I've done now.

The patch is based on Maint f93ff170b9 (Git 2.48.1, 2025-01-13). 

Thanks

Changes from v1:
1. Correctly intialize the value to `0` for `write_transaction_table_arg.max_index`.
2. Set the `max_index` for all elements of `reftable_transaction_data`.
3. The range diff was made against the commit in Junio's branch
   `gitster/kn/reflog-migration-fix`, which included his 'S-o-b', which I've
   removed in this patch, since that is usually applied by Junio. Not sure if
   that was the right move. 

Range diff:
1:  bc67b4ab5f ! 1:  5489826b47 reftable: write correct max_update_index to header
    @@ Commit message
     
         Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## refs.c ##
     @@ refs.c: int ref_transaction_update_reflog(struct ref_transaction *transaction,
    @@ refs/reftable-backend.c: struct write_transaction_table_arg {
      };
      
      struct reftable_transaction_data {
    +@@ refs/reftable-backend.c: static int prepare_transaction_update(struct write_transaction_table_arg **out,
    + 		arg->updates_nr = 0;
    + 		arg->updates_alloc = 0;
    + 		arg->updates_expected = 0;
    ++		arg->max_index = 0;
    + 	}
    + 
    + 	arg->updates_expected++;
     @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
      	struct reftable_log_record *logs = NULL;
      	struct ident_split committer_ident = {0};
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
      		if (ret < 0)
      			goto done;
     @@ refs/reftable-backend.c: static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
    - 	struct reftable_transaction_data *tx_data = transaction->backend_data;
      	int ret = 0;
      
    -+	if (tx_data->args)
    -+		tx_data->args->max_index = transaction->max_index;
    -+
      	for (size_t i = 0; i < tx_data->args_nr; i++) {
    ++		tx_data->args[i].max_index = transaction->max_index;
    ++
      		ret = reftable_addition_add(tx_data->args[i].addition,
      					    write_transaction_table, &tx_data->args[i]);
    + 		if (ret < 0)
     
      ## t/t1460-refs-migrate.sh ##
     @@ t/t1460-refs-migrate.sh: do
---
 refs.c                  |  7 +++++++
 refs/refs-internal.h    |  1 +
 refs/reftable-backend.c | 20 ++++++++++----------
 t/t1460-refs-migrate.sh | 12 ++++++++++++
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 0f41b2fd4a..f7b6f0f897 100644
--- a/refs.c
+++ b/refs.c
@@ -1345,6 +1345,13 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
 	update->flags &= ~REF_HAVE_OLD;
 	update->index = index;
 
+	/*
+	 * Reference backends may need to know the max index to optimize
+	 * their writes. So we store the max_index on the transaction level.
+	 */
+	if (index > transaction->max_index)
+		transaction->max_index = index;
+
 	return 0;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 16550862d3..aaab711bb9 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -203,6 +203,7 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 	void *backend_data;
 	unsigned int flags;
+	unsigned int max_index;
 };
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 00d95a9a2f..d39a14c5a4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -942,6 +942,7 @@ struct write_transaction_table_arg {
 	size_t updates_nr;
 	size_t updates_alloc;
 	size_t updates_expected;
+	unsigned int max_index;
 };
 
 struct reftable_transaction_data {
@@ -1019,6 +1020,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 		arg->updates_nr = 0;
 		arg->updates_alloc = 0;
 		arg->updates_expected = 0;
+		arg->max_index = 0;
 	}
 
 	arg->updates_expected++;
@@ -1428,7 +1430,6 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 	struct reftable_log_record *logs = NULL;
 	struct ident_split committer_ident = {0};
 	size_t logs_nr = 0, logs_alloc = 0, i;
-	uint64_t max_update_index = ts;
 	const char *committer_info;
 	int ret = 0;
 
@@ -1438,7 +1439,12 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 
 	QSORT(arg->updates, arg->updates_nr, transaction_update_cmp);
 
-	reftable_writer_set_limits(writer, ts, ts);
+	/*
+	 * During reflog migration, we add indexes for a single reflog with
+	 * multiple entries. Each entry will contain a different update_index,
+	 * so set the limits accordingly.
+	 */
+	reftable_writer_set_limits(writer, ts, ts + arg->max_index);
 
 	for (i = 0; i < arg->updates_nr; i++) {
 		struct reftable_transaction_update *tx_update = &arg->updates[i];
@@ -1540,12 +1546,6 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 				 */
 				log->update_index = ts + u->index;
 
-				/*
-				 * Note the max update_index so the limit can be set later on.
-				 */
-				if (log->update_index > max_update_index)
-					max_update_index = log->update_index;
-
 				log->refname = xstrdup(u->refname);
 				memcpy(log->value.update.new_hash,
 				       u->new_oid.hash, GIT_MAX_RAWSZ);
@@ -1609,8 +1609,6 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 	 * and log blocks.
 	 */
 	if (logs) {
-		reftable_writer_set_limits(writer, ts, max_update_index);
-
 		ret = reftable_writer_add_logs(writer, logs, logs_nr);
 		if (ret < 0)
 			goto done;
@@ -1632,6 +1630,8 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 	int ret = 0;
 
 	for (size_t i = 0; i < tx_data->args_nr; i++) {
+		tx_data->args[i].max_index = transaction->max_index;
+
 		ret = reftable_addition_add(tx_data->args[i].addition,
 					    write_transaction_table, &tx_data->args[i]);
 		if (ret < 0)
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index f59bc4860f..307b2998ef 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -227,6 +227,18 @@ do
 	done
 done
 
+test_expect_success 'multiple reftable blocks with multiple entries' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	test_commit -C repo first &&
+	printf "create refs/heads/ref-%d HEAD\n" $(test_seq 5000) >stdin &&
+	git -C repo update-ref --stdin <stdin &&
+	test_commit -C repo second &&
+	printf "update refs/heads/ref-%d HEAD\n" $(test_seq 3000) >stdin &&
+	git -C repo update-ref --stdin <stdin &&
+	test_migration repo reftable
+'
+
 test_expect_success 'migrating from files format deletes backend files' '
 	test_when_finished "rm -rf repo" &&
 	git init --ref-format=files repo &&
-- 
2.47.0

