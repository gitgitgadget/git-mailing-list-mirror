Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB20B1F131B
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296442; cv=none; b=ipV3LKAoAPClRgkQ751Y99AV1FRJXEf2AMVCpN/vSzV272+1zaloS7j5snZKwtSf0G05RC3cF6V9GGPa6VCXjrIMtAHswe0OGgiJm7812a548aN7VCDRLsGEaFRNKJXFiTZdsT/TOdvpeEp86/ZeHa0s2neVACHJFRfmg+tzAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296442; c=relaxed/simple;
	bh=sWWvdFX8+G0JZdD6Y1RBbEuLWUrVe5mkzJZKo/VtHDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DS3Zqr5fh0hANmArFwUA5CKRaElvNNVTP5o4cSN0yk0ogLRdaA/7FSBFBuUnsW2N9gOaomfHckV3pxREtDdeSQrLBaLnHQAurntu81I+zowY3ytdBn1oieUtlDB/xy1hjEeuCNL939AxTruCRx0lySLdkidNr4V7niyY+7eJLNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iLmus2H3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ey8neuZP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iLmus2H3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ey8neuZP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F18BA11400C9;
	Fri, 27 Dec 2024 05:47:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 27 Dec 2024 05:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735296439;
	 x=1735382839; bh=zVGUr6/t6ZAEB/umwIvhBQhcLRmlUt7JQVHGCn4Iqw0=; b=
	iLmus2H3rL2CS8LhfNnlHJFkEMTHVm+CqiLnZjAqJWLndLeQp5vt5U7NADQalvea
	m8F1NC1JaaJm4SBBaPq9KdTscjMtqbKyzRlXt0G4rxvAJ0u59ZZhBpYcXnI5au+2
	5Qy97YJNDwjFciLL4+Mly6aXoG8G8garfZc38ojTpo9j7EQ/qVUyH/bfVQfLOKvo
	1x5PgU8ErFBjXOQwc4NL2z+pAqFl80KQQBNDu/h+DVD29FDQL7iSIxxpaqgt5ePg
	h6wFADoUi61Y6SmkGipZ5Vq1t9hbQr/UOtVLl4B/gFPCIGVZ/HArg09+FrmCbZUb
	63tjh8UvfSsuelzaoPOkog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735296439; x=
	1735382839; bh=zVGUr6/t6ZAEB/umwIvhBQhcLRmlUt7JQVHGCn4Iqw0=; b=e
	y8neuZPq5Kiv2MKijgK2sBXWiv+4Aikocguc3nktDmQlDLU0O8j2nXZ2DBm+vmLl
	sQb/2rhlwQUR3JL0RxOp48zTx4grWmhpPBYCOxQp4zbXM7jQXmfRrZNUCwX3p8ng
	GOsmup0gYuLqtfl0Fhwm0jGev1dn3KWCaJWAiRMkFXYGtcTLoOi1Crf7hLAOIE35
	0bn9l52cWploCpSVUocY+Zsfp0DAflToG+Euh+uuRTyTQ8TfFxoAjeZxL9JaUN+n
	7nAC2QKto1azpkAXIohKIxp7NCrVUAS9MgjIC2MULCzGGArwaTBsyFRLWqUUUoob
	eRCdgiNzxAZXYCGhw57qQ==
X-ME-Sender: <xms:t4VuZ92eIhTdEMyTwnL8eOVkc1Na_ekPRyn2Y4V2DC6jAGyUUWcfqA>
    <xme:t4VuZ0FOKg8fa1LirmxlxrjvTRfvj97oEHwAaZ5t951BeDrHrpf_C9BZ0Dk0-Bgnm
    wHY6tvynREaIUwVgA>
X-ME-Received: <xmr:t4VuZ94PnvAO_o_KPHlKRauUpBk9o4Shqx4UIY596Fd81OXleaJXXh_K0BMdGvpO3NRviObEVuW1NtqUOaw_jdOqhaUilP8uDt0g7pJzTJcYMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    ht
X-ME-Proxy: <xmx:t4VuZ62hGd-qdW2SHdoroDC7YystpXQkVQNy4p88Oh7gVreegBkEhQ>
    <xmx:t4VuZwEJ61LRIvWD1sBSzBaeCODvsCwRZdgCT1PVMDdXNIMid9l17A>
    <xmx:t4VuZ79X_CNTRfgrwGaaDVcEQdlFTOr9yxxJ5ndxxOu6kg2helg5Jg>
    <xmx:t4VuZ9mH-AEHGyP0UcZYZP83Q2pgAr00qrMmaXZ7n67qCe5RLr9Apg>
    <xmx:t4VuZ1TV01NyZJJ6J8b7VsS5bUqDNMVEe43a7HKc2KvKUpuOge0__4Q0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:47:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e97b52c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:45:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 11:46:24 +0100
Subject: [PATCH 4/9] commit-reach: use `size_t` to track indices in
 `remove_redundant()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-commit-reach-sign-compare-v1-4-07c59c2aa632@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The function `remove_redundant()` gets as input an array of commits as
well as the size of that array and then drops redundant commits from
that array. It then returns either `-1` in case an error occurred, or
the new number of items in the array.

The function receives and returns these sizes with a signed integer,
which causes several warnings with -Wsign-compare. Fix this issue by
consistently using `size_t` to track array indices and splitting up
the returned value into a returned error code and a separate out pointer
for the new computed size.

Note that `get_merge_bases_many()` and related functions still track
array sizes as a signed integer. This will be fixed in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-reach.c | 53 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9f8b2457bcc12bebf725a5276d1aec467bb7af05..d7f6f1be75e95cc834d60be719e930a77ad0518f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -212,12 +212,13 @@ int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result)
 }
 
 static int remove_redundant_no_gen(struct repository *r,
-				   struct commit **array, int cnt)
+				   struct commit **array,
+				   size_t cnt, size_t *dedup_cnt)
 {
 	struct commit **work;
 	unsigned char *redundant;
-	int *filled_index;
-	int i, j, filled;
+	size_t *filled_index;
+	size_t i, j, filled;
 
 	CALLOC_ARRAY(work, cnt);
 	redundant = xcalloc(cnt, 1);
@@ -267,20 +268,22 @@ static int remove_redundant_no_gen(struct repository *r,
 	for (i = filled = 0; i < cnt; i++)
 		if (!redundant[i])
 			array[filled++] = work[i];
+	*dedup_cnt = filled;
 	free(work);
 	free(redundant);
 	free(filled_index);
-	return filled;
+	return 0;
 }
 
 static int remove_redundant_with_gen(struct repository *r,
-				     struct commit **array, int cnt)
+				     struct commit **array, size_t cnt,
+				     size_t *dedup_cnt)
 {
-	int i, count_non_stale = 0, count_still_independent = cnt;
+	size_t i, count_non_stale = 0, count_still_independent = cnt;
 	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
 	struct commit **walk_start, **sorted;
 	size_t walk_start_nr = 0, walk_start_alloc = cnt;
-	int min_gen_pos = 0;
+	size_t min_gen_pos = 0;
 
 	/*
 	 * Sort the input by generation number, ascending. This allows
@@ -326,12 +329,12 @@ static int remove_redundant_with_gen(struct repository *r,
 	 * terminate early. Otherwise, we will do the same amount of work
 	 * as before.
 	 */
-	for (i = walk_start_nr - 1; i >= 0 && count_still_independent > 1; i--) {
+	for (i = walk_start_nr; i && count_still_independent > 1; i--) {
 		/* push the STALE bits up to min generation */
 		struct commit_list *stack = NULL;
 
-		commit_list_insert(walk_start[i], &stack);
-		walk_start[i]->object.flags |= STALE;
+		commit_list_insert(walk_start[i - 1], &stack);
+		walk_start[i - 1]->object.flags |= STALE;
 
 		while (stack) {
 			struct commit_list *parents;
@@ -388,10 +391,12 @@ static int remove_redundant_with_gen(struct repository *r,
 	clear_commit_marks_many(walk_start_nr, walk_start, STALE);
 	free(walk_start);
 
-	return count_non_stale;
+	*dedup_cnt = count_non_stale;
+	return 0;
 }
 
-static int remove_redundant(struct repository *r, struct commit **array, int cnt)
+static int remove_redundant(struct repository *r, struct commit **array,
+			    size_t cnt, size_t *dedup_cnt)
 {
 	/*
 	 * Some commit in the array may be an ancestor of
@@ -401,19 +406,17 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	 * that number.
 	 */
 	if (generation_numbers_enabled(r)) {
-		int i;
-
 		/*
 		 * If we have a single commit with finite generation
 		 * number, then the _with_gen algorithm is preferred.
 		 */
-		for (i = 0; i < cnt; i++) {
+		for (size_t i = 0; i < cnt; i++) {
 			if (commit_graph_generation(array[i]) < GENERATION_NUMBER_INFINITY)
-				return remove_redundant_with_gen(r, array, cnt);
+				return remove_redundant_with_gen(r, array, cnt, dedup_cnt);
 		}
 	}
 
-	return remove_redundant_no_gen(r, array, cnt);
+	return remove_redundant_no_gen(r, array, cnt, dedup_cnt);
 }
 
 static int get_merge_bases_many_0(struct repository *r,
@@ -425,7 +428,8 @@ static int get_merge_bases_many_0(struct repository *r,
 {
 	struct commit_list *list;
 	struct commit **rslt;
-	int cnt, i;
+	size_t cnt, i;
+	int ret;
 
 	if (merge_bases_many(r, one, n, twos, result) < 0)
 		return -1;
@@ -452,8 +456,8 @@ static int get_merge_bases_many_0(struct repository *r,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(r, rslt, cnt);
-	if (cnt < 0) {
+	ret = remove_redundant(r, rslt, cnt, &cnt);
+	if (ret < 0) {
 		free(rslt);
 		return -1;
 	}
@@ -582,7 +586,8 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	struct commit_list *p;
 	struct commit_list *result = NULL, **tail = &result;
 	struct commit **array;
-	int num_head, i;
+	size_t num_head, i;
+	int ret;
 
 	if (!heads)
 		return NULL;
@@ -603,11 +608,13 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 			p->item->object.flags &= ~STALE;
 		}
 	}
-	num_head = remove_redundant(the_repository, array, num_head);
-	if (num_head < 0) {
+
+	ret = remove_redundant(the_repository, array, num_head, &num_head);
+	if (ret < 0) {
 		free(array);
 		return NULL;
 	}
+
 	for (i = 0; i < num_head; i++)
 		tail = &commit_list_insert(array[i], tail)->next;
 	free(array);

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

