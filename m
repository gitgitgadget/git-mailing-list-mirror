Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B746FC5
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077414; cv=none; b=tmyuAqvA+PFRd+idcilgmVldJXwwqkVg4fapWd0fq2iKbknLPWpdqFA8qjz+baitHbP+AZ6G2rwZLEx5DHa7Sw7w75JvbhcKm8f4RSSv5OhLTdrMDgFaHZyGw1QlNn7SDCezegg0H8EB732NVc9xWKSQ8VOGvx2JIAn4aI8n7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077414; c=relaxed/simple;
	bh=vFjdr/HMQQimSXHYlZV0qixfy3cpM8Ih6R+qHUISUq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cjiyn5/g609UGzCAscB/mNJzJy1+iJjyH2ZNI/9fm3IuBPqYBwOzK8HZHzobs/OTTQI6MiqMq6pJAp68NRWNv+DU5hPwRKemzwbIqKPXwBbRZ7ZQkG/vbKfe5sJzp9q/YRlpCAx21/1qC7OlV37VudRzOw+7Yhd4MrkKjlow/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlDm16wR; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlDm16wR"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45e934bb51dso1923127b6e.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 16:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770077412; x=1770682212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXXNLnMuuCmprIlRHbCtme2CjWx33SAE4AbbXpKfbpM=;
        b=JlDm16wRMQF9Y39LvL8cXWXWQE90QyKZll+Q13ok+J+adAptRWFON8PDDuY9dWK5lI
         RHAFMD5QTNycDcdfVT8J0tSyrhliaBLu4zPnWmzFxOfuCll+vr5nt7+M8zcrhiSbYJyJ
         LnlpaDifecEOAncFMpnD/4XwsTqluhcnD9GGkZKG8Dix+nz929rs1DyT92/oTKTCQzi6
         cnIT6ADk4VGnKRbOTqHxouDFPDZjpr00tvJHsAi3oxbdGpyQndq1hqkTdrBXUlqhqHcq
         MlFfhu28Z8WAf2AO8WoEEmRmG14WIshNwgkubTAbODfsWZjz5eGAAVhBAgF5F/eywIc2
         YE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770077412; x=1770682212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXXNLnMuuCmprIlRHbCtme2CjWx33SAE4AbbXpKfbpM=;
        b=Hxsf159Mj62jsl8rn6NuKl5BdLi86RlEQYpCqyYtBfc7uhqg+HzyF7J+lIt1SgM7i2
         2wdxyX9mVRK5rHXA2w6/G72sI7lmwzcKWcBDoViHdGI4iXkR9z9NnJDiIoc1WA8yrzFH
         fPim6eupQ47YVOK6/VwPvA17cVkQoNDjuuwhgyWtI5t9j3m546pPfD0GHwYkct02KvWg
         n7DIUSY4uouZytlSqF7ONtHa6Lszt6P0lzPgBLaaGTDnIiYUSbeZdhCcz1B2Vz//cs+9
         V8Fat4ni3BjWiN1YjucLsTklyjcaE/jppVie3FsF6a861Xpk/wf1xUucligT/j0d3Tmg
         4dKA==
X-Gm-Message-State: AOJu0YyioxE5aToOtT1G/tIHamz9wjHIFS3qmdLL5HLXLAjHp3QDU3jF
	XnXP0LlCO1BMlenz8JZuTPySujv8Nwkd9u7REnccbhl+QhIQvlTBQG9FiFfxpA==
X-Gm-Gg: AZuq6aKobpbiQo8k3w+yU+tQhlmb6DrjHFhH2ODaHxQdo/B89iFzFxcQ4VLMOwhFhKI
	rC9L6rx7L614G6Y8e/vGhgNu5WZholjBqBbHXC3lUafh0beOI1W7EsgXmrE3WAyp2LHvT3XJ5gm
	QZcxsDIo5bdnALMXYwf30TzianyiGjxH/YAJk/jT+vdSfiUte+k0N28oenTj7KPRWqDaF8SDgy2
	SaOpnUxrBkrcVHOzeO9z4gCEC3/g+Rd2amNs7lNNQgBSubg66wgPcFGI/TcuReZxBIPjfx2JTy3
	Ucdzee0bsbJ/KNUM6DfP5ikeNBvoWNbTTELdB3g8f61nSdBNqhI/8tz8vvNETBt/bAet0cBRBVG
	K2w2dlHtn4d7uhE1N71a8yg+lb7xtpDVzpZykZplHENo30e8AyKUHDAhUFPWokSl765VZ14CnwV
	UvkPeQ6OHj5+SVWS2S76S+4qODCI7h1Q==
X-Received: by 2002:a05:6808:179b:b0:459:bcff:a568 with SMTP id 5614622812f47-45f34da4ee1mr6166773b6e.65.1770077411734;
        Mon, 02 Feb 2026 16:10:11 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f6010esm9851179b6e.15.2026.02.02.16.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:10:11 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/4] odb: store ODB source in `struct odb_transaction`
Date: Mon,  2 Feb 2026 18:09:59 -0600
Message-ID: <20260203001002.2500198-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.373.g68cb7f9e92
In-Reply-To: <20260203001002.2500198-1-jltobler@gmail.com>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260203001002.2500198-1-jltobler@gmail.com>
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

