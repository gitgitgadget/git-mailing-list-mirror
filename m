Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EED2080F4
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367485; cv=none; b=geDjcuIlBKJWsaJuqXw7bGBG5HnO2cDvwssMEmX+OcL0lIEvHLreFB8Lm51/0DA9ul8kKs7e1WryY+Wvn1gCFOCakAXKZIZRewsI3aSt0JABZ/LDrvTGyAZTWntpw6YssUidH8Zba90iHOU6jIssiWSnHaMN8c/sWVuek9AWJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367485; c=relaxed/simple;
	bh=jDPMqKatsQhg+EBjNPw/kC4fYprM2j3L9khrIu5BB0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQIhygA2+CCc7Go8hzHTVcVqfFTY5hWNTpZC2P+yOjXx9Qw/ej8qXIJShxkU/lCq45tOij0lxaiBWgttFx1wVAC2dAXuDXR0sRcwFqAwg1Io3wg3zl3SX1UvVi5OUsmFru9jCfSuc6t19mvcEVVqzRBloiDyRZ6oMD7A3NuC2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cc8Dc/TF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc8Dc/TF"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so712914466b.2
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367481; x=1734972281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFja4Dce2bjeu8KBc7aHCgLjbi7WVN8kJntGzJ+xVtg=;
        b=Cc8Dc/TFsyduJmzcx8OxqJ7M2nJDFOni1HQouGbrLkX4PRkcaSLSJLOLCHBvnqbJn4
         GANz3FtcUCpz1xjhHRPYQtaXl/akrqVTOQ0xfGo9mdy2V7kb6q5rEKHO94YCUSLRbHCb
         mae2/L1+Qcg+eOQsUA4MAysZiKmqwepiWN0rr7Vydm20alMcGFKIlZpO2ghS4uPrR64o
         2x7Zko9xYf6cqSG+OPSp3unuagbF+b47gASy9/OzqJL3S0CfUEx9OASUy/yz8uXXZw6B
         2RoZENoP0Gedm8IDzF3ghvy2z50d0WkL0RiW7bvJBiLcq1HEtGJlE0mrYFqIK5rAw6mO
         pbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367481; x=1734972281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFja4Dce2bjeu8KBc7aHCgLjbi7WVN8kJntGzJ+xVtg=;
        b=O1pGbr/rwh9XtsJC4AC8muSAeUIcDXdymmL4mTXWH6Am7SAAnzJF7GOleacQUMoyKb
         uJtMLsAQO2KH/wtrYlvG+eENG5ZdbZO9RNT1WKMmIuxkeEH9SxE0VfY/iTynyCzQaJMq
         3yUoV+T1as/iTOfdaQ+wm5noA9w8lY9IwrEma/OaCaS815TkZ1g2Zplm7hGMtUPdVXl3
         +3j+/IQ71MdsGlMn6PgnQS6ZJszCVTbuuWa8AEcD+lv38yAWyR84DpxBrpuIUJ2R07a9
         MTtv2kz/B98LuiO4rlTEQFBh7Q7F7fleBO0e/UgBGhBCj6a/ga/YtcME8J3kqL45fpX5
         +vcQ==
X-Gm-Message-State: AOJu0YyyXMn5EpDhRWzDUYSjDrUV+shsZlLiXAeq8dDmJwEeMTAwKJh5
	h+ponLW2YR5wRM6Q1xwA1BtOTiFLae/iEAbHuCZT92KVIvIxufA381P3E9Be
X-Gm-Gg: ASbGncvnUVmTt0BSkIbS0KaJFUipF+8o/MAIxYHuu18QcnKkB43qcaT6m+8xOJd3SBx
	C1NQfO7QmZckfAH7QpXnzy7K58RUBhHd/RjVf/eqLCrIee3Brzk3WOF27piOBWkuAExHGeqxl3l
	wbRUOu9wDvrmlGq36wtLwjVpTU6WeTGMswofoHKsTr1cr5hk7hTchutNOely8VkSzwei7dCHQ+R
	y9VC/mPg4WGHu+7AiC6j4j4ztRs6Ehdu1iPV/DTWuKNpgB840mZjVpoeAw=
X-Google-Smtp-Source: AGHT+IG0m9MdR8R5euzWpztVUxgFnEhI3CBZx+6N524QhYyxrXk+lu1PllEUoUrg3Ctl4VGiLR0ieg==
X-Received: by 2002:a17:907:780b:b0:aa6:8fa5:f3f5 with SMTP id a640c23a62f3a-aab77909c78mr1214061866b.15.1734367481061;
        Mon, 16 Dec 2024 08:44:41 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635957fsm354834366b.109.2024.12.16.08.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:44:40 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 16 Dec 2024 17:44:32 +0100
Subject: [PATCH v4 7/8] refs: allow multiple reflog entries for the same
 refname
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-320-git-refs-migrate-reflogs-v4-7-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4945; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jDPMqKatsQhg+EBjNPw/kC4fYprM2j3L9khrIu5BB0Q=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnYFjwPyYaq0W+TAdPm0kqK+Cfotz/LtZJzdVM8
 Vieyzu0B5iJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ2BY8AAKCRA+1Z8kjkaM
 f+auDAChVzlTSvUHxW6oN8cokduDxWNNcvvP2lSz8q+a79U6xVQGczyaXxirwK305WqRZzyGcHf
 p7ph9k8SZl0VQJUquTNNwyL2p8TG5WMGwVxFW6hrAPx4TpC2JebUOY/Y+ZwlPp1KT5ZOLCC980z
 e0F8/ymOwWCvgM0YOERndSTfcE3IUtWPzsPL+7dIJ45kGpikJIi+M/bbgDiq+r+nRfUDX0p2+3u
 Vk7/YyjeU1m0Ix1aDyIbMN0xUHtZLM1mkt52dxRQWOmi+X6vgT93pXef1r/vg5TqCgbwqbpEYjT
 23lMbI0R4UJnmldwZNu/eEoOkHpZkjZIZNcZSoofvYD+RauFSNe1lkhxZNDkBxwP0ynKhM1wpkq
 WmxvF1g6gRPWS2UNsQhUkhTG4ZCRMCJgqDMmE1uLLW0TKnSn4I8USj08oIrTEHHDE93jFq+w20k
 2ysEbChtSOHD8LDrPvP4bpvD9rziZEE14bV9RAUBFKNjfyZ9QrJy1Nuaa/wbwbJWnF+lo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference transaction only allows a single update for a given
reference to avoid conflicts. This, however, isn't an issue for reflogs.
There are no conflicts to be resolved in reflogs and when migrating
reflogs between backends we'd have multiple reflog entries for the same
refname.

So allow multiple reflog updates within a single transaction. Also the
reflog creation logic isn't exposed to the end user. While this might
change in the future, currently, this reduces the scope of issues to
think about.

In the reftable backend, the writer sorts all updates based on the
update_index before writing to the block. When there are multiple
reflogs for a given refname, it is essential that the order of the
reflogs is maintained. So add the `index` value to the `update_index`.
The `index` field is only set when multiple reflog entries for a given
refname are added and as such in most scenarios the old behavior
remains.

This is required to add reflog migration support to `git refs migrate`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c    | 15 +++++++++++----
 refs/reftable-backend.c | 22 +++++++++++++++++++---
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c11213f52065bcf2fa7612df8f9500692ee2d02c..8953d1c6d37b13b0db701888b3db92fd87a68aaa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2611,6 +2611,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	update->backend_data = lock;
 
+	if (update->flags & REF_LOG_ONLY)
+		goto out;
+
 	if (update->type & REF_ISSYMREF) {
 		if (update->flags & REF_NO_DEREF) {
 			/*
@@ -2829,13 +2832,16 @@ static int files_transaction_prepare(struct ref_store *ref_store,
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
@@ -3035,8 +3041,9 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 
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
index b2e3ba877de9e59fea5a4d066eb13e60ef22a32b..bec5962debea7b62572d08f6fa8fd38ab4cd8af6 100644
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
@@ -1301,6 +1302,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 	struct reftable_log_record *logs = NULL;
 	struct ident_split committer_ident = {0};
 	size_t logs_nr = 0, logs_alloc = 0, i;
+	uint64_t max_update_index = ts;
 	const char *committer_info;
 	int ret = 0;
 
@@ -1405,7 +1407,19 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 				}
 
 				fill_reftable_log_record(log, &c);
-				log->update_index = ts;
+
+				/*
+				 * Updates are sorted by the writer. So updates for the same
+				 * refname need to contain different update indices.
+				 */
+				log->update_index = ts + u->index;
+
+				/*
+				 * Note the max update_index so the limit can be set later on.
+				 */
+				if (log->update_index > max_update_index)
+					max_update_index = log->update_index;
+
 				log->refname = xstrdup(u->refname);
 				memcpy(log->value.update.new_hash,
 				       u->new_oid.hash, GIT_MAX_RAWSZ);
@@ -1469,6 +1483,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 	 * and log blocks.
 	 */
 	if (logs) {
+		reftable_writer_set_limits(writer, ts, max_update_index);
+
 		ret = reftable_writer_add_logs(writer, logs, logs_nr);
 		if (ret < 0)
 			goto done;

-- 
2.47.1

