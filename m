Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3D2309B5
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870523; cv=none; b=Y2+bxyzYxpvNYUWzvSGR/ePdcJNoPxgx76mldUhkBBUp/D7OUr6Str3xjf0jrIlzAeaV3QhPty3Vm3ONYYt+/4o8FYsLdtNiiwKUTHabtEuyRWfqWhM27WymhVizYyOpJU3h+cjK+Rf7L74k1w8UEk2xKwKsVqjnxUIjhocAxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870523; c=relaxed/simple;
	bh=IAOtoFtgL+mS63lbnrwBj8O+zsgHw0pznMlnZ+uTStA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZC71frJSYHmFJIDz3ShUk2+QpE2MeY1S3u+HZMpxH2XBziPZyfJQjUQCuNVpsttxMQvvwJ0D7xgG5IO3+467H+IjjtWQxF96zMH0XuD7dKCDgJKtbHfEsY11s1Co/LC+213ZLXti+YByCJavRscTJBw53viAPOLkZ8HQO6iEbg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gEB8Cf6p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QUhNNwlS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gEB8Cf6p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QUhNNwlS"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 799BD1140279;
	Tue, 18 Feb 2025 04:22:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 18 Feb 2025 04:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870520;
	 x=1739956920; bh=LgnnGeDOBWWOjGalA4mXHalBDgBjpxV5C+6sBNyXXTo=; b=
	gEB8Cf6p9MNYZ6dHHKAMRvrxWQgbwsIiW/sTu7GhRfEJJ5f6X3USNkbmxcAIfn0e
	8uafSo3CFBMND9DcuAlNIRHy/eQiJeLj8VomgMmE3kde9k4Kqnu7I7NjkOQQNz4/
	FsciRs0R2KoCjG0UjaahxsmcsQtq68m9maValDzqYyxX6bJubn7Mpe+NrV/RipA7
	hDqIFDkmuf/ZAILg2lFE8dNk4MFJN/ngHnEj2802ma1RoVFJ7CWtIEeBart7wCVh
	Wwdpjm1V9Mx9OHfXnF5eouNRDvI9Y3MmwJFq82414KwLu4FiL3VRmBkR9X9QvvUa
	N6ewUSHeDgC2GR74sBKELw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870520; x=
	1739956920; bh=LgnnGeDOBWWOjGalA4mXHalBDgBjpxV5C+6sBNyXXTo=; b=Q
	UhNNwlSueiptmcDiGMQbq5VR0zTUW0GxvOOZHQFJMuOZ2WXKgbiGIrJEKiQ3syTL
	p5TASgrWt3WCWLB2lMZJ1kPisF4qVt2dh5l+guEzeJdKwqCmXsncAvv6QON2Ecz1
	IpcNFxMlA/YcMvlfo38gbZVZNPIEtvSMz8NQ8e2cpxvliq8+yK7kd54t8H07aQ8Y
	oOb+Ntr0Np0soUBMc9pRTX39bM1K1Bnwf4o7P0E6p5YZzug2ejsD3GJ6PSH6f08K
	shjRIhT7AU9uHG084EfgSBVZavUKBIjhUePwWQIRwE0EpjmUebD07HfQK8/FZU3o
	MJ4TVUQvRt3jojBPBr9wg==
X-ME-Sender: <xms:OFG0Z1qKNmfBUnZuMFcYoFmtAGhvn4dkbJQIHRb0ZL7OY5FRKtB_Ig>
    <xme:OFG0Z3rgc9Fd0o1YorDeozEw4WyIpYeU244V1YtiFQGCTLUQobZ1fFQZDvpuyaSuE
    GW0DjA3QFIaIqRRng>
X-ME-Received: <xmr:OFG0ZyOI3P2GHAm3M3Fci7qLLcUXgpgmXmNIPolcem0YTIpFCuEhJhkPuN9e2ZZHKRSLVZPLSJJWMMoRCuLBu3Gxd8m9F_CLcAPN5oNeiQhokbuY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OFG0Zw7VXFh4Ldbf4s4_xef34bCz_PXhpbqmJO9NtSyxWZbsGC3q1A>
    <xmx:OFG0Z04PHdCFWoz0PSiHmrUvh7WknNkmXD5kIDdSRK1W7XNI30MTBQ>
    <xmx:OFG0Z4g07vg8zULBgtVqNAfTEzNve9fZoom0oQMl-jJyNiYTVJXtgQ>
    <xmx:OFG0Z24fnNDu-4f3wHxy7t50upEfqqtBim4hX5RqGgVbVMrSki8NdA>
    <xmx:OFG0Zxs6I742ENcHdUDhALx8EUReLY2e3_zJYLKWC89YJDiATNUQBoHJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:21:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca565841 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:21:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:41 +0100
Subject: [PATCH v6 05/18] reftable/record: stop using `BUG()` in
 `reftable_record_init()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-5-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
index b14a8f1259a..999876826d1 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -508,7 +508,9 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 	it->block_len = br->block_len;
 	it->hash_size = br->hash_size;
 
-	reftable_record_init(&rec, block_reader_type(br));
+	err = reftable_record_init(&rec, block_reader_type(br));
+	if (err < 0)
+		goto done;
 
 	/*
 	 * We're looking for the last entry less than the wanted key so that
diff --git a/reftable/merged.c b/reftable/merged.c
index e72b39e178d..4156eec07fc 100644
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
index 3f2e4b28005..de6e6dd9322 100644
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
index 2c0cc32cbd3..1e18f8dffb1 100644
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
index c7755a4d750..e1846c294ba 100644
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
index f3f8a0cdf38..d8a4c283a11 100644
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
index d49d2a2729c..6540bd20e37 100644
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
2.48.1.666.gff9fcf71b7.dirty

