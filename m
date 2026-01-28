Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF627A45C
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643930; cv=none; b=Xru9GT2VXKe6OyRIsyBYs2HJfPhq5GVtiZ3FEIDyI8CCgUHEmD0M7Y/ZuneUGe8OSkrpt/R0QDlaiiaVPHsC5/hcQu7cUBhz3M1QfUbv+QLrSeNvtQX0pKH9xfOQML8LY5s6Se0TvPjD6CFsViLuS78VF8GGCiz69QxHkPjgGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643930; c=relaxed/simple;
	bh=vFjdr/HMQQimSXHYlZV0qixfy3cpM8Ih6R+qHUISUq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxOJn51Vc1OjgyMDD0UUxo+nEdxZXxVEoKSs1ULOOR4lzru/XqQcPbX1+dKcMbxjWyBTYt74VqK/UjCGca7x+PxK0Shy2Noxv/BfmH6MNRjteb8Ba3GUE+3JluhAwvOuX9fV1lcR37AocMBJcX+e6qyQjdDLxkMIDWdnoKrPA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNV93YOl; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNV93YOl"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d18f80b5c2so270919a34.3
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 15:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769643928; x=1770248728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXXNLnMuuCmprIlRHbCtme2CjWx33SAE4AbbXpKfbpM=;
        b=JNV93YOl4dkKhc66MXHbFpki6nPwcL8eWPa863+2zNaocTrYLfj6z3rkoNlevjEVSh
         4HRDotcp62750maaJpHDBjvYx1y2C3YOwimWvLKjBdwIS4DDuEGC/eBzNkJyYVogFzuD
         lOfX8wC+JMctM/Ep/dynrSID+CPNv4DoHqrQVVOJFZPLzQSW8sSyp/n2Ex68hgfFxOgb
         PVMVb8xdnoDIaI60GcVZTXcdjnpxWZRmqEy74yWFkFvCydeetYpp1C1j6ywcwfSwkqKR
         /tcm0S3eFdFPsO2afGWfgt1gsDVcwlTdO2iNZg5L5AeLS3AsG+tBDMbnQTDOHawaMQTL
         f4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643928; x=1770248728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXXNLnMuuCmprIlRHbCtme2CjWx33SAE4AbbXpKfbpM=;
        b=vujGPwzrls2FIT0eF/zd05cZ0bDz7rs1HlVPSfWpNoA3Yb3Kx5QZEhW8VRXQF2eK4o
         9mF9cb5PSSALjDeZ823ioBdEp3vt655H1bv9k+4O9NT08/3pVN5GwfqW3hyh3Vvht+IC
         odLFKNAcEN+LQuWHPxPsal14ZWnpDJTTzz3dmOCLzfXUeWTqVDXHtZsPFMTK29QvHXp2
         RMRC1zb6g7zYsQEX4s5HECkreGtyA1EomOKXAuhX0MfJeiLVrumbiXXfCv2eqsqC1Qg5
         aDFBFKqA1htxLwlZpky9D4584V5IpovE6ceMwKlWOvhecCLHqKu8crO9tu2Dhw3OZsce
         FN4Q==
X-Gm-Message-State: AOJu0Yww3UsfTppFmuHoDfGE/V6U89MDDr3lA13jywwSC8LIzL0SEoBh
	wRR42mWwzMUK/tlfi8XTYoHuLpeNuXE0GwkiZpHVlfug4E3BvAebs0Tr3z7otw==
X-Gm-Gg: AZuq6aLAa15gnzuZg75lEez5TxtJ3CH2eWB+trAXl9Fz/i/VfJIEoG6TRjg8vbbIL/j
	BdDfz5d2m6D09Iql88bZ/ZZBN3hHeaa/cgjgWBc+rv9FHAGu+9rKnBRN8HrI8WdXV9YTMolz9SJ
	ZEEo3xbiS7uD1JuA8g4diu2VYamlJk6B62or4fhHb8H6igPBSN1CIPaTi493n87UXMyW90oWo0t
	lFei2O1fg4F0nsHDhziSzBygy4XAQfGTSaadj5U0PwwAKIfan1QeQeptgDMOuPDdP5PO8j4AQS2
	fDkXfU1czFLJEHDJD6PjOmVSGx5rDUFAY+XHnBFr41FOO9slvZUhtZB1u/N+fWfet0tZEJQvVDr
	68YhJGaH5SaBWzHfRHoNE3x0KCPbrMWjVtvCzSJd/9GOitnkq+LDhXznSus7sT/ePltiWWzf3XS
	w1gzgN8FI4h57MpVLd9bA=
X-Received: by 2002:a05:6830:6001:b0:7cf:cbec:293f with SMTP id 46e09a7af769-7d185112156mr4022869a34.27.1769643928240;
        Wed, 28 Jan 2026 15:45:28 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm2648676a34.6.2026.01.28.15.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 15:45:27 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/4] odb: store ODB source in `struct odb_transaction`
Date: Wed, 28 Jan 2026 17:45:16 -0600
Message-ID: <20260128234519.2721179-2-jltobler@gmail.com>
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

Each `struct odb_transaction` currently stores a reference to the
`struct object_database`. Since transactions are handled per object
source, instead store a reference to the source.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/object-file.c b/object-file.c
index e7e4c3348f..196509b252 100644
--- a/object-file.c
+++ b/object-file.c
@@ -711,7 +711,7 @@ struct transaction_packfile {
 };
 
 struct odb_transaction {
-	struct object_database *odb;
+	struct odb_source *source;
 
 	struct tmp_objdir *objdir;
 	struct transaction_packfile packfile;
@@ -728,7 +728,7 @@ static void prepare_loose_object_transaction(struct odb_transaction *transaction
 	if (!transaction || transaction->objdir)
 		return;
 
-	transaction->objdir = tmp_objdir_create(transaction->odb->repo, "bulk-fsync");
+	transaction->objdir = tmp_objdir_create(transaction->source->odb->repo, "bulk-fsync");
 	if (transaction->objdir)
 		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 }
@@ -772,7 +772,7 @@ static void flush_loose_object_transaction(struct odb_transaction *transaction)
 	 * the final name is visible.
 	 */
 	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
-		    repo_get_object_directory(transaction->odb->repo));
+		    repo_get_object_directory(transaction->source->odb->repo));
 	temp = xmks_tempfile(temp_path.buf);
 	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
 	delete_tempfile(&temp);
@@ -1344,7 +1344,7 @@ static int already_written(struct odb_transaction *transaction,
 			   struct object_id *oid)
 {
 	/* The object may already exist in the repository */
-	if (odb_has_object(transaction->odb, oid,
+	if (odb_has_object(transaction->source->odb, oid,
 			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 1;
 
@@ -1365,7 +1365,7 @@ static void prepare_packfile_transaction(struct odb_transaction *transaction,
 	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
 		return;
 
-	state->f = create_tmp_packfile(transaction->odb->repo,
+	state->f = create_tmp_packfile(transaction->source->odb->repo,
 				       &state->pack_tmp_name);
 	reset_pack_idx_option(&state->pack_idx_opts);
 
@@ -1469,7 +1469,7 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 static void flush_packfile_transaction(struct odb_transaction *transaction)
 {
 	struct transaction_packfile *state = &transaction->packfile;
-	struct repository *repo = transaction->odb->repo;
+	struct repository *repo = transaction->source->odb->repo;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
 	char *idx_tmp_name = NULL;
@@ -1494,7 +1494,7 @@ static void flush_packfile_transaction(struct odb_transaction *transaction)
 	}
 
 	strbuf_addf(&packname, "%s/pack/pack-%s.",
-		    repo_get_object_directory(transaction->odb->repo),
+		    repo_get_object_directory(transaction->source->odb->repo),
 		    hash_to_hex_algop(hash, repo->hash_algo));
 
 	stage_tmp_packfiles(repo, &packname, state->pack_tmp_name,
@@ -1553,7 +1553,7 @@ static int index_blob_packfile_transaction(struct odb_transaction *transaction,
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
-	transaction->odb->repo->hash_algo->init_fn(&ctx);
+	transaction->source->odb->repo->hash_algo->init_fn(&ctx);
 	git_hash_update(&ctx, obuf, header_len);
 
 	/* Note: idx is non-NULL when we are writing */
@@ -1993,7 +1993,7 @@ struct odb_transaction *object_file_transaction_begin(struct odb_source *source)
 		return NULL;
 
 	CALLOC_ARRAY(odb->transaction, 1);
-	odb->transaction->odb = odb;
+	odb->transaction->source = source;
 
 	return odb->transaction;
 }
@@ -2006,11 +2006,11 @@ void object_file_transaction_commit(struct odb_transaction *transaction)
 	/*
 	 * Ensure the transaction ending matches the pending transaction.
 	 */
-	ASSERT(transaction == transaction->odb->transaction);
+	ASSERT(transaction == transaction->source->odb->transaction);
 
 	flush_loose_object_transaction(transaction);
 	flush_packfile_transaction(transaction);
-	transaction->odb->transaction = NULL;
+	transaction->source->odb->transaction = NULL;
 	free(transaction);
 }
 
-- 
2.52.0.373.g68cb7f9e92

