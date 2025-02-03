Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D41F5428
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569831; cv=none; b=CQv+x5aJ1gqT2TXRPeYGgHQWb4VR/5wdjBt3NSY3tCuaEqNWThzRhRj9daYSxi3BVuvxJl78SNoeC9ECvFTAzhd5MQaI64lgDmmXFGhY+uTK8+NZ/ccaxWfJ7rpbAFzXfeii8+8kvw8dVFf0XII7GSYymPvoWGjgNHGcyIcZXn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569831; c=relaxed/simple;
	bh=hAQU5SN39e6qduBogodBw1Ow9PHSmMAXEAh+mQ3F5fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SmbGaxToZaqzuzAH2lN2X0M6yv71yVen6XNTteUfMBI+uU7/9Sw4/mrqH9jAW/N2jQsyk4vHIx59D0Dl/uUzCR/G2h1fvR+Kb3jA3PRMd8L3RL8dmrRtYEIuBJ4DW9zmC/M5bQCU0rqsjvzpOZnTPwqlxh+Vq6/TEaJgi5WxqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CFLJuPAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tmJPOgRO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CFLJuPAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tmJPOgRO"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 59EC61380850;
	Mon,  3 Feb 2025 03:03:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 03:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569828;
	 x=1738656228; bh=j4yHxoV0LbAzL80S95an56qyrh58Lp57N9iHlAa7V74=; b=
	CFLJuPANVSa4yng7lhQsV/+knh0huE2MHOUSpXCXwNv8CfzxZes/5fvkhrC8d9E3
	VxDvmELE1KteRdeihxoCiIKKHsDWcdSg9gjsVCrFow7ieuIMiEOcGFC6O9alPlnZ
	NghGdwgzjhxinmHWvC4ph07PElmea96a62XqWs1/wQxeO4l5VbqHu9AmzWrAnvPx
	1zZGzvL59AgDXGRbL4lhJaLBvmETvIBuXV1AwK3wHSA1QP7m3sfozdHuQBA6JzCC
	1Ujbt+rF/XnXOZdeeFBT0TbLSCHXfpcIidb8Ppfrz74WTqELAZ3Tnin4B6LjPN94
	Spo0xja5WFJAfH9jBqVpRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569828; x=
	1738656228; bh=j4yHxoV0LbAzL80S95an56qyrh58Lp57N9iHlAa7V74=; b=t
	mJPOgROVpWGK0svnEIC/dsP3k0NKAOB4AWlnsOxal7X+/ikV8Joniva/tujcXyy/
	TODg/RV0ukV7AW5yAGp3Emm6wy75p6YaTsvi1MZw/hGtgsm0xjAb6SboYf1pL7c2
	iC3ThSJt0uZy8dNlUcq2OX0YaaUoSfEfYfSeM/AnfVZFsjICKRSf+1nSwyLIK27Z
	s5R0f8/IcypfZZy1fNBCZ/eG5kbG84h4d9Gt4yoGeYBgdoQ3ahy1TVY5/sgEbAGW
	1UI2sZe8CMugX50QddZY2Ys4xwGlD4nXGWWnLAktukqCj0VIUHWsGBJX6cX5NrJx
	olySkMjwtULXOUo0e6yDA==
X-ME-Sender: <xms:ZHigZ44-hde3AjgUw34erBzaRzsI2Jy96yZM8JRQL1dHN9X_py99qA>
    <xme:ZHigZ55SzZBHKyaME-GndGwhL5wsh-P1J9TprNmJfYgl_hYgEeZ02Y6JKMxaUeKSV
    BOjty_WXqHqUWGJWw>
X-ME-Received: <xmr:ZHigZ3d5rkQGJovy36Sx8ElNjIOwFunOY6MkmVt-y3bD2zR2yDkahsPAS98kcNt_l3p6GTCZsrHZMU60VJxbJgWa2D0lEpdENJChiSf78u6yBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegv
    thhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZHigZ9INAnDNEYtnvvGjFkmPdE2JnDbrawT71n1tikYNl590ikjwRg>
    <xmx:ZHigZ8JSJp-RX8qGRZghbyb4QcaIjozgtTjYcr0o_ZLieB4lGTPyPg>
    <xmx:ZHigZ-wkajkcwflgn6DNxwTYWE06iC6g7pb_R7_wWtE2uJUoXDcMCw>
    <xmx:ZHigZwJSi_OW5BbJzxjqZcNg84NbvllHqlc9OPsALNumL7SsC4HChQ>
    <xmx:ZHigZxFfIFrw6ti5_zyQcMq_iy4zi55Hv86UiQ9xpOtBAQWK0uE_cAUj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da744542 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:36 +0100
Subject: [PATCH v3 05/18] reftable/record: stop using `BUG()` in
 `reftable_record_init()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-5-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We're aborting the program via `BUG()` in case `reftable_record_init()`
was invoked with an unknown record type. This is bad because we may now
die in library code, and because it makes us depend on the Git codebase.

Refactor the code such that `reftable_record_init()` can return an error
code to the caller. Adapt any callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                 | 4 +++-
 reftable/merged.c                | 5 ++++-
 reftable/reader.c                | 5 ++++-
 reftable/record.c                | 8 ++++----
 reftable/record.h                | 4 ++--
 t/unit-tests/t-reftable-pq.c     | 6 +++---
 t/unit-tests/t-reftable-record.c | 2 +-
 7 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 8ac865ce78..255d566854 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -509,7 +509,9 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 	it->block_len = br->block_len;
 	it->hash_size = br->hash_size;
 
-	reftable_record_init(&rec, block_reader_type(br));
+	err = reftable_record_init(&rec, block_reader_type(br));
+	if (err < 0)
+		goto done;
 
 	/*
 	 * We're looking for the last entry less than the wanted key so that
diff --git a/reftable/merged.c b/reftable/merged.c
index e72b39e178..4156eec07f 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -253,7 +253,10 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 	}
 
 	for (size_t i = 0; i < mt->readers_len; i++) {
-		reftable_record_init(&subiters[i].rec, typ);
+		ret = reftable_record_init(&subiters[i].rec, typ);
+		if (ret < 0)
+			goto out;
+
 		ret = reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
 		if (ret < 0)
 			goto out;
diff --git a/reftable/reader.c b/reftable/reader.c
index 3f2e4b2800..de6e6dd932 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -360,7 +360,10 @@ static int table_iter_seek_linear(struct table_iter *ti,
 	struct reftable_record rec;
 	int err;
 
-	reftable_record_init(&rec, reftable_record_type(want));
+	err = reftable_record_init(&rec, reftable_record_type(want));
+	if (err < 0)
+		goto done;
+
 	err = reftable_record_key(want, &want_key);
 	if (err < 0)
 		goto done;
diff --git a/reftable/record.c b/reftable/record.c
index 2c0cc32cbd..1e18f8dffb 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1306,7 +1306,7 @@ reftable_record_vtable(struct reftable_record *rec)
 	abort();
 }
 
-void reftable_record_init(struct reftable_record *rec, uint8_t typ)
+int reftable_record_init(struct reftable_record *rec, uint8_t typ)
 {
 	memset(rec, 0, sizeof(*rec));
 	rec->type = typ;
@@ -1315,11 +1315,11 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ)
 	case BLOCK_TYPE_REF:
 	case BLOCK_TYPE_LOG:
 	case BLOCK_TYPE_OBJ:
-		return;
+		return 0;
 	case BLOCK_TYPE_INDEX:
 		reftable_buf_init(&rec->u.idx.last_key);
-		return;
+		return 0;
 	default:
-		BUG("unhandled record type");
+		return REFTABLE_API_ERROR;
 	}
 }
diff --git a/reftable/record.h b/reftable/record.h
index c7755a4d75..e1846c294b 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -130,8 +130,8 @@ struct reftable_record {
 	} u;
 };
 
-/* Initialize the reftable record for the given type */
-void reftable_record_init(struct reftable_record *rec, uint8_t typ);
+/* Initialize the reftable record for the given type. */
+int reftable_record_init(struct reftable_record *rec, uint8_t typ);
 
 /* see struct record_vtable */
 int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index f3f8a0cdf3..d8a4c283a1 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -32,7 +32,7 @@ static void t_pq_record(void)
 	char *last = NULL;
 
 	for (i = 0; i < N; i++) {
-		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
 	}
 
@@ -72,7 +72,7 @@ static void t_pq_index(void)
 	size_t N = ARRAY_SIZE(recs), i;
 
 	for (i = 0; i < N; i++) {
-		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = (char *) "refs/heads/master";
 	}
 
@@ -111,7 +111,7 @@ static void t_merged_iter_pqueue_top(void)
 	size_t N = ARRAY_SIZE(recs), i;
 
 	for (i = 0; i < N; i++) {
-		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = (char *) "refs/heads/master";
 	}
 
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index d49d2a2729..6540bd20e3 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -17,7 +17,7 @@ static void t_copy(struct reftable_record *rec)
 	uint8_t typ;
 
 	typ = reftable_record_type(rec);
-	reftable_record_init(&copy, typ);
+	check(!reftable_record_init(&copy, typ));
 	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);

-- 
2.48.1.502.g6dc24dfdaf.dirty

