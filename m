Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A731196B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591601; cv=none; b=mmTUqkeA1O8X9fKLvPVtkLmbU0KnKV/DChlneTr/DRqNyBFKwgzQOuVunId0xtdiEZAdpjIQonn8QoVClnadGGh6ADndzLDGKftw2tRerC4vaXTbfqq9sB3AygObhjDzinfREXgJ/VZWczL6qryl/JCTBTWk8j7MLepqWJaWfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591601; c=relaxed/simple;
	bh=cdbd5bZ6/1Bqtkllxxkhn4avP2Loon6KNmCuzouMgYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXOOPbfG2yuchZKskK88sblzgHjsu/2S+mKSilhzBAzD1Wq+ejD5TSAhxW89tUum8GrOH33MgK87FFCDVFDYTx6CNpGDaUx3C6llgu+pjHwoQRO8iwvvVh8yqkFvw3yr+2PEpjzB6LiVm6Q9g8pMF6D/YZD+lfPJUnKPDwMtFjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tvq9IOPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OH54Dq9+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tvq9IOPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OH54Dq9+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89D717A027C
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 19 Aug 2025 04:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591599;
	 x=1755677999; bh=N6OkcV1HpR8qmyzuuOzxuFNMY4b3A48fXVZ0vU24RDs=; b=
	Tvq9IOPz7OOycTmGklx2SWkcdx03lqgdduD/+7ZAeBWsEtN7ddhvOMDGF/hnwbaA
	q5bV4V0S+24Ny2AW4LpXysLd/cSidph5FGz1nC4Qsuz28iUgpByFRJhvzkPFD5sH
	nFTlt8ADufgIlap0uXNDYrk2GFm71i3oe16wodCvlEpUPvm9+uTcSvkVGjujxcke
	syIxIvZM39jbijeAdGefGV16j3OKHA7wiemAVA3Ic5klhUGiVQV3wbi5keC+X3hA
	4H2PR+VGHNAEfhVC+L5WbrRQdUxFUTVlOq3jFFUAm3DpH/gRMMdSFfvPGuzI2fCM
	uA2AFLjLTHFyu4jZCLU2ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591599; x=
	1755677999; bh=N6OkcV1HpR8qmyzuuOzxuFNMY4b3A48fXVZ0vU24RDs=; b=O
	H54Dq9+5MM3IHXTWhXpBdImqivsg7VE48F/Md/fDsSsuSwqZXyqppBRjnFgggJ0u
	k9ylp02Tiv/QhMLc2dQFSKUSit2xc8r7kARAUr7btkeFjeFNGYPttCzVnh2gbyYM
	lepOQ+a9VEH36GGyrUsIUnpDjUaGpkDnvmELUnToIJ+xhs3EMsCmgnYl9GoAcOGz
	I70OlVznkaebQgP8tQwveB5xl1JXY115IoZen100LitTufMvWa9UVij9WuDNB7M8
	G4lhZPemsDlOCUSvvxdfNvoeQp9E7GpA6E4su627yS3+dYpWPonR1Q5A2h6Xktbj
	kqFh+/NmjwPMdSVQ6CUsw==
X-ME-Sender: <xms:rzOkaDuwsdUG8CkdGl7rR0o-N5v7m3y4hDVlKYGmfngYAFVqJm5-tQ>
    <xme:rzOkaGd2g70nwuLGSCssstsBCsF968pwMKqO8-LzBVqjhFd8NKgPt4JKhvDaX33jk
    FQ6JGa0_a3VMF8gNQ>
X-ME-Received: <xmr:rzOkaAJ1w64tbFRoc-6pStdsYZkYKFb_-GdEVtSnAMl6x01_VX46AtuOzS4MhpRLcUpVpEfnUyveWcXLaZuSvHf64V2OEovqVrrY8NpUt5Td>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:rzOkaEaTVT8VwReyhPUzyhXwgzp3oTTCIAem64p1EsHXCb9G6pJYBg>
    <xmx:rzOkaLuF8xMrOOw_25OsB0-ydn0eMFN57zTAfYKPXTNeG7qnG-e5XA>
    <xmx:rzOkaBv8OMqphc_9bfzA9KaAXe7rw4awCiLhMxu1L6liiiVvQPn-8A>
    <xmx:rzOkaAc5O_g8kXhBRhTrUqPM1wu36vPDTYnkY_NvqpVTUyr6itMcRA>
    <xmx:rzOkaLUVxI3Dyfm5JtKK7ttGInJ7UTkXV0iYlTCYkOOJjjzvvefIdPvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6cb73104 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:19:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:37 +0200
Subject: [PATCH 08/16] packfile: refactor `prepare_packed_git()` to work on
 packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-8-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `prepare_packed_git()` function and its friends are responsible for
loading packfiles as well as the multi-pack index for a given object
database. Refactor these functions to accept a packfile store instead of
a repository to clarify their scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/packfile.c b/packfile.c
index 99f2d20812..58e50d7b30 100644
--- a/packfile.c
+++ b/packfile.c
@@ -974,38 +974,33 @@ static int sort_pack(const struct packed_git *a, const struct packed_git *b)
 	return -1;
 }
 
-static void rearrange_packed_git(struct repository *r)
-{
-	sort_packs(&r->objects->packfiles->packs, sort_pack);
-}
-
-static void prepare_packed_git_mru(struct repository *r)
+static void packfile_store_prepare_mru(struct packfile_store *store)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&r->objects->packfiles->mru);
+	INIT_LIST_HEAD(&store->mru);
 
-	for (p = r->objects->packfiles->packs; p; p = p->next)
-		list_add_tail(&p->mru, &r->objects->packfiles->mru);
+	for (p = store->packs; p; p = p->next)
+		list_add_tail(&p->mru, &store->mru);
 }
 
-static void prepare_packed_git(struct repository *r)
+static void packfile_store_prepare(struct packfile_store *store)
 {
 	struct odb_source *source;
 
-	if (r->objects->packfiles->initialized)
+	if (store->initialized)
 		return;
 
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
-		int local = (source == r->objects->sources);
+	odb_prepare_alternates(store->odb);
+	for (source = store->odb->sources; source; source = source->next) {
+		int local = (source == store->odb->sources);
 		prepare_multi_pack_index_one(source, local);
 		prepare_packed_git_one(source, local);
 	}
-	rearrange_packed_git(r);
+	sort_packs(&store->packs, sort_pack);
 
-	prepare_packed_git_mru(r);
-	r->objects->packfiles->initialized = 1;
+	packfile_store_prepare_mru(store);
+	store->initialized = 1;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1028,25 +1023,25 @@ void reprepare_packed_git(struct repository *r)
 
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packfiles->initialized = 0;
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	obj_read_unlock();
 }
 
 struct packed_git *get_packed_git(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	return r->objects->packfiles->packs;
 }
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
-	prepare_packed_git(source->odb->repo);
+	packfile_store_prepare(source->odb->packfiles);
 	return source->midx;
 }
 
 struct packed_git *get_all_packs(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 
 	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
 		struct multi_pack_index *m = source->midx;
@@ -1061,7 +1056,7 @@ struct packed_git *get_all_packs(struct repository *r)
 
 struct list_head *get_packed_git_mru(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	return &r->objects->packfiles->mru;
 }
 
@@ -1079,7 +1074,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
 		unsigned long count = 0;
 		struct packed_git *p;
 
-		prepare_packed_git(r);
+		packfile_store_prepare(r->objects->packfiles);
 
 		for (source = r->objects->sources; source; source = source->next) {
 			struct multi_pack_index *m = get_multi_pack_index(source);
@@ -2069,7 +2064,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 {
 	struct list_head *pos;
 
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 
 	for (struct odb_source *source = r->objects->sources; source; source = source->next)
 		if (source->midx && fill_midx_entry(r, oid, e, source->midx))

-- 
2.51.0.261.g7ce5a0a67e.dirty

