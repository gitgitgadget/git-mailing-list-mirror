Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFADB21C17C
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742451; cv=none; b=r+7QBvCHPku7sm3ziWiVxFv6Qbshl3IEApVFD4yKXMGlouLZoOgM/e/dsWGu8ZkfY+WvGKCaHEDJoX904y1cPRNvM0wsV6jCM51AfxH9XVlKsju20lvyhFmQ/5BnqLuyYxggNL6BghNpPn+kEg5vO5cim6SXFZY/ZTtOo6QEBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742451; c=relaxed/simple;
	bh=WGQz9kGlhiqH8Cl10higM364cpuFdIUZl1NSy3ZRwIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQ8tfOmKr1m9zGjbAj8gZmQ97CYXxI3gtUrnQ/g8GMek1tzOPpy7c/um/7nBVW8zaHpeDwrEmncFWOr+KdVFSAthIM3lrSN3vpC5pRoML/LLVtHCAF5LT+6MavVOFlrGVdhcwdrwyTJsKPNZfu3us9DqAX+GMGfRA0RB4kAqcLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLU5VMKO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLU5VMKO"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso231790166b.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 03:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733742448; x=1734347248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxj3xT5a2DekMcb+oyYc7qlHEsze3X91betL5eqZT28=;
        b=iLU5VMKOnInRX1wQSHeUMuQnrvCdbTTX0hfJJ0QhtxHMrWNoyKhj7Sxq9fyyYLAIyg
         VCIKlgYPViXVIwYPXKo/dRhIQZ696I//uyFXRJidfF65LKeUeG+KaL84MZYvCGDC2sNN
         s6D65UIWzY9HyH0LMdqlRaYks89aQ7V96wHyKFVLxVxuW/SkU25gEmwxKHxjJnzzlQsK
         bpdmvKEV2J1WZlhl6QcH891UC0m7oY9w4bTYoJpeNNIKHqddOLMv9FE0O1wzaJhMx0au
         GUuvzA2tUMsCzjgN1DGog5MEOcpGtrvP5hIATv7XNdYiRBfd4cKPCG+kkxSyM4TOWIHn
         QJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742448; x=1734347248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxj3xT5a2DekMcb+oyYc7qlHEsze3X91betL5eqZT28=;
        b=wkgLSdZJYZXg5xPzJZ17+hMjIvycCvEmMhub1Cb6kA0DfA/yv+WlHn6IOoGI8GPsnO
         8ELij9ZTF8wEy/Ns4St9yh7GTOkRWod02p/tnHeyAKsq70IDhwvbv7RWPft4Hz/ElrLo
         DhBRJOK9d7giKYrvKbaIWEBIuRSxLPA5tIEf5aHJsXfo6EUwfs1UTeXf/dv+D0lkpyYJ
         RJ0ZVzQjN0oLfC59nha3UvkmXehUuxushRGmmvr9l5mOYXCpEB98/GM/qwXoe9CVRzxD
         o2fLUirJtIxAvjDiRGtvtmdauVKEvB+N3Exr6sqSI2YVJSReL4GFLzQ1tEEel/SYkcBR
         4c7w==
X-Gm-Message-State: AOJu0Yw988riH2FFIwM3eRPw1yjaOXrTRxJmfOVlblhsxXYSntXn1lnD
	alRFXfXPWKJAQPLBQxnGc5iLrdIp1Eb649ma6BkeHgA07+MwyQxqRlSYd8kU
X-Gm-Gg: ASbGncuC4NqQ390SkC3HUC9/5nQy16/luqA1paH2VdM2BkAKIchAEpzdwvk7NGULXUZ
	DJOT0J4uz2PO8EDx508q/FfxZ7Ho9peFU/lysmVeCrwKB5TBCVA9LO5wtrzK6zePvWEhYDXEOe4
	kKvziJjuxt8zv5B05ftsFW1+OzpnovUDLAU3VvwffE7ONu1I2rzOHcNuNC4gzZd1OUWFJyCSFkf
	+NYluEVdXQyoO+WTG+TzduUe1enFkXFjzLdTVMZP6u0nQk7bMCMGwp6LhIo/hc=
X-Google-Smtp-Source: AGHT+IE74Lz9ugFcNGatg+1a3ZSJI9T4n755mo4wo2v1SwyZGixfYSUvJDELm4iFBG6bjgq8eWsqPg==
X-Received: by 2002:a17:906:23e9:b0:aa6:8d51:8fdb with SMTP id a640c23a62f3a-aa68d519148mr252471766b.19.1733742447599;
        Mon, 09 Dec 2024 03:07:27 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d377fbsm257013366b.75.2024.12.09.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:07:27 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Dec 2024 12:07:20 +0100
Subject: [PATCH 6/7] refs: allow multiple reflog entries for the same
 refname
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-320-git-refs-migrate-reflogs-v1-6-d4bc37ee860f@gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4867; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WGQz9kGlhiqH8Cl10higM364cpuFdIUZl1NSy3ZRwIg=;
 b=owEB7AET/pANAwAIAT7VnySORox/AcsmYgBnVs9nU1I5k1k6BuP8eZCylXejKtGvaRsIhG9sZ
 54TDSeDYU2JAbIEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1bPZwAKCRA+1Z8kjkaM
 fx0BC/YmzyWedPtd/GpLQu00xB+SdOJxG5lxQOQa8k5DQg/g+1BTQIjgo6dPUlTViUHzHQV5zdg
 tMkB+MYNFhZ/hxFL7AHejODZB9xumPFdIUVbQlu0s94cEkiiVp1qXpBHKm7FPDLFiL5gkrSoxMQ
 mMsa+75/40TB/t9aBvDFXHmxZldsATPYje2Fnq98tD2yOk1/YpIUOus2dd49a0PKOM1a1ELwxbv
 kCR+sZjo/Rf5CO5G59y2KhpH24arVAWa2a6BGYL/TNkMP1tCcrbdMS6rxF86w9uWf2ezILyuuQe
 EOMuKgKX6ZQ+Pw999wCbrIBjxiw9qLBdXXAWAZVKxywxgONXYm6XctbhZnn0DKgk/urGGYFTswp
 Nmsbrf97k8COvzi1Hx4qdCq7+BmN+MF3Hvol2TQVAqHVc9TnXh6lcHg12pyE6AS0vmNw+V5t3WU
 q8577eEzy1geWVr2q1q5Dlc0k+66M+QhN2SJcVeaSVsLj5jnQJZDPSxD8Gp1wP74LT+A==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference transaction only allows a update for a given reference to
avoid conflicts. This, however, isn't an issue for reflogs. There are no
conflicts to be resolved in reflogs and when migrating reflogs between
backends we'd have multiple reflog entries for the same refname.

So allow multiple reflog updates within a single transaction. Also the
reflog creation logic isn't exposed to the end user. While this might
change in the future, currently, this reduces the scope of issues to
think about.

This is required to add reflog migration support to `git refs migrate`
which currently doesn't support it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c    | 15 +++++++++++----
 refs/reftable-backend.c | 16 +++++++++++++---
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 32975e0fd7a03ab8ddf99c0a68af99921d3f5090..10fba1e97b967fbc04c62a0a6d7d9648ce1c51fb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2612,6 +2612,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	update->backend_data = lock;
 
+	if (update->flags & REF_LOG_ONLY)
+		goto out;
+
 	if (update->type & REF_ISSYMREF) {
 		if (update->flags & REF_NO_DEREF) {
 			/*
@@ -2830,13 +2833,16 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
-		struct string_list_item *item =
-			string_list_append(&affected_refnames, update->refname);
+		struct string_list_item *item;
 
 		if ((update->flags & REF_IS_PRUNING) &&
 		    !(update->flags & REF_NO_DEREF))
 			BUG("REF_IS_PRUNING set without REF_NO_DEREF");
 
+		if (update->flags & REF_LOG_ONLY)
+			continue;
+
+		item = string_list_append(&affected_refnames, update->refname);
 		/*
 		 * We store a pointer to update in item->util, but at
 		 * the moment we never use the value of this field
@@ -3036,8 +3042,9 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 
 	/* Fail if a refname appears more than once in the transaction: */
 	for (i = 0; i < transaction->nr; i++)
-		string_list_append(&affected_refnames,
-				   transaction->updates[i]->refname);
+		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
+			string_list_append(&affected_refnames,
+					   transaction->updates[i]->refname);
 	string_list_sort(&affected_refnames);
 	if (ref_update_reject_duplicates(&affected_refnames, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b2e3ba877de9e59fea5a4d066eb13e60ef22a32b..d9d2e28122a00ddd7f835c35a5851e390761885b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -990,8 +990,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		if (ret)
 			goto done;
 
-		string_list_append(&affected_refnames,
-				   transaction->updates[i]->refname);
+		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
+			string_list_append(&affected_refnames,
+					   transaction->updates[i]->refname);
 	}
 
 	/*
@@ -1302,6 +1303,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 	struct ident_split committer_ident = {0};
 	size_t logs_nr = 0, logs_alloc = 0, i;
 	const char *committer_info;
+	struct strintmap logs_ts;
 	int ret = 0;
 
 	committer_info = git_committer_info(0);
@@ -1310,6 +1312,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 
 	QSORT(arg->updates, arg->updates_nr, transaction_update_cmp);
 
+	strintmap_init(&logs_ts, ts);
+
 	reftable_writer_set_limits(writer, ts, ts);
 
 	for (i = 0; i < arg->updates_nr; i++) {
@@ -1391,6 +1395,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 
 			if (create_reflog) {
 				struct ident_split c;
+				uint64_t update_index;
 
 				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 				log = &logs[logs_nr++];
@@ -1405,7 +1410,11 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 				}
 
 				fill_reftable_log_record(log, &c);
-				log->update_index = ts;
+
+				update_index = strintmap_get(&logs_ts, u->refname);
+				log->update_index = update_index;
+				strintmap_set(&logs_ts, u->refname, update_index+1);
+
 				log->refname = xstrdup(u->refname);
 				memcpy(log->value.update.new_hash,
 				       u->new_oid.hash, GIT_MAX_RAWSZ);
@@ -1476,6 +1485,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
+	strintmap_clear(&logs_ts);
 	for (i = 0; i < logs_nr; i++)
 		reftable_log_record_release(&logs[i]);
 	free(logs);

-- 
2.47.1

