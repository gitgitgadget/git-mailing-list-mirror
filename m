Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC518130D
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516054; cv=none; b=X+KmGaRoCptAa0BCxgN3M8WuFXjSITT8tgdAjky8RXg4SxVQEv+Zsr0RZAYjbegyaSByY4qacA0QJ2uD6wz+2VLETBDlVqhmWycPd3FTPYrE0FziKkFXtKI63O19sW6Dmi4QoK1C0DDKR9H8qKESmyWjz/xBqRFbfts5Qk0KEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516054; c=relaxed/simple;
	bh=FXDmYg6D4uUFuHIvHbg4tbg6CMhfo5t4nBQafWTyRqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRaItMT5AhYLncQXhuzIEsc4P1Zojbzbu5UEOI5QZOkDsVXjm1Men/AccposDvhJz/xwQ9qwnOS/dxJxhGcibqThhIwcF2Sha2Jqrd/ze+N0tp+bglHxJdaBzwhPgy8hzKxXjXuDgaxVQymEW7WAGU0hqYzzUHx6OrBSwa5ChEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n5MUTUBl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sV9Ut0j2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n5MUTUBl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sV9Ut0j2"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 318A62540177;
	Mon, 25 Nov 2024 01:27:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 25 Nov 2024 01:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732516051;
	 x=1732602451; bh=++253ukxndlgiisaUE4XOa59OXnCIljLQcwu9SvCWrg=; b=
	n5MUTUBl8BLXR+pM44DJUTBfp0xAdgBBk9QJCQCPz0VAklOlas+zl4rRS71KumA8
	ZSt+Xom65jebxUOiqiVYvR3l2SYFSEb+7KEFuGh7cMdG9TJkz1oTvWK9nxoTf1Gl
	ub+O5r0UIiIsaeGijOrt8V3HsDx4kOsKXZBd3SsMsChND2TEqKpQ6IZ2Edfiat68
	cl9R4q/IV8EKGSSaXzMZZS68+rf/5ipoRoMR3CrcZkdYLFBQa0GLeTcllLPCMiKn
	Pit7k/KvT9XA5Vem7qShjtMUtYJKSvTyfJlTVAWKEkBBBYsGIf0D1qaSqHmgpeRY
	Dm6CE10ZTPqt9tfkcRrQIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732516051; x=
	1732602451; bh=++253ukxndlgiisaUE4XOa59OXnCIljLQcwu9SvCWrg=; b=s
	V9Ut0j2W7AjEmZkkLUteLFIpgRSKTTDEXjaz15s/AhgorBiDcOgAPipk+X1+J8Rr
	83kGNHDRopwdM0YhbvJwew78UUDLK2up8VHqUOZ83ZQ/lMffscgaG0XZOLe5UQwp
	GvEZQI+qpAYL9tSEAuUpTTlygSq8gkXR5+OV3Laj0u8HFOLf/37dzS6TUBZL0njR
	3FChbup2l00KFxc9vnPFD0fdcpoK+cJt5oRBn4wkXMORWzD/6ZziXiNh4ahVF/hJ
	wlpj/KEkZtfDkJl68/S6i32yPEiWmswcbSirK9n4tOXdALo4g2bh5/f3RH8zX5t1
	G6BIWllB3EOYMYDEVkBpQ==
X-ME-Sender: <xms:0hhEZy6cCqPG-sIuH4CI9DzV1S72BWiKrXl1lzUA1BrBWyjAjmgJLQ>
    <xme:0hhEZ77vMxrJg2-eudKDbrqedv1dNfYGaSLTnFzxc1r3AoOjw4_5qaIvPrIY9SouN
    d1NTBUjxPH-41la6g>
X-ME-Received: <xmr:0hhEZxcgCpARpImKNjx_fUTe9MdPJWtFqdegJmLqWaaaXN14NYAxmBzA0zT-8CZ8NNND26gDjFcpewTgNThLOElanUqmfp9tGC4Dg4Uwl8aXpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtdduffdu
    veevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0hhEZ_K_Ozlmpkh-M72UsK9EzQgxDGhri1EvU9njqfaqSq7828Rd9Q>
    <xmx:0hhEZ2LqPxi7oWMXhcd8dLaADjsqZ6QnJ6aHKY9k61c1y6ELUYAcnw>
    <xmx:0hhEZwx0CU8ThXm7aa5B8Y67b2PkRSxYAtV9Wh1p9xA2b135z5fuXQ>
    <xmx:0hhEZ6LC9vrga66GMkpc7fWvJveowlejDjpSJxTlNgA4ud8U193D6w>
    <xmx:0xhEZ4jO62aouEuCClQap5K5Evu7RQ9X6GpowIgNbKWH51fsRw_909md>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 01:27:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 73e3111e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 06:26:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 07:27:13 +0100
Subject: [PATCH v3 08/10] reftable/writer: optimize allocations by using a
 scratch buffer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241125-pks-refs-optimize-migrations-v3-8-17bc85e33ad7@pks.im>
References: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
In-Reply-To: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Both `writer_add_record()` and `reftable_writer_add_ref()` get executed
for every single ref record we're adding to the reftable writer. And as
both functions use a local buffer to write data, the allocations we have
to do here add up during larger transactions.

Refactor the code to use a scratch buffer part of the `reftable_writer`
itself such that we can reuse it. This signifcantly reduces the number
of allocations during large transactions, e.g. when migrating refs from
the "files" backend to the "reftable" backend. Before this change:

    HEAP SUMMARY:
        in use at exit: 80,048 bytes in 49 blocks
      total heap usage: 5,032,171 allocs, 5,032,122 frees, 418,792,092 bytes allocated

After this change:

    HEAP SUMMARY:
        in use at exit: 80,048 bytes in 49 blocks
      total heap usage: 3,025,864 allocs, 3,025,815 frees, 372,746,291 bytes allocated

This also translate into a small speedup:

    Benchmark 1: migrate files:reftable (refcount = 1000000, revision = HEAD~)
      Time (mean ± σ):     827.2 ms ±  16.5 ms    [User: 689.4 ms, System: 124.9 ms]
      Range (min … max):   809.0 ms … 924.7 ms    50 runs

    Benchmark 2: migrate files:reftable (refcount = 1000000, revision = HEAD)
      Time (mean ± σ):     813.6 ms ±  11.6 ms    [User: 679.0 ms, System: 123.4 ms]
      Range (min … max):   786.7 ms … 833.5 ms    50 runs

    Summary
      migrate files:reftable (refcount = 1000000, revision = HEAD) ran
        1.02 ± 0.02 times faster than migrate files:reftable (refcount = 1000000, revision = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 23 +++++++++++------------
 reftable/writer.h |  2 ++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index fd136794d5a27b33b5017f36fbd6b095ab8dac5b..be0fae6cb229411258d40b8865c2fdee88fd5bcd 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -148,6 +148,7 @@ int reftable_writer_new(struct reftable_writer **out,
 
 	reftable_buf_init(&wp->block_writer_data.last_key);
 	reftable_buf_init(&wp->last_key);
+	reftable_buf_init(&wp->scratch);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 	if (!wp->block) {
 		reftable_free(wp);
@@ -180,6 +181,7 @@ static void writer_release(struct reftable_writer *w)
 		w->block_writer = NULL;
 		writer_clear_index(w);
 		reftable_buf_release(&w->last_key);
+		reftable_buf_release(&w->scratch);
 	}
 }
 
@@ -249,20 +251,19 @@ static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *has
 static int writer_add_record(struct reftable_writer *w,
 			     struct reftable_record *rec)
 {
-	struct reftable_buf key = REFTABLE_BUF_INIT;
 	int err;
 
-	err = reftable_record_key(rec, &key);
+	err = reftable_record_key(rec, &w->scratch);
 	if (err < 0)
 		goto done;
 
-	if (reftable_buf_cmp(&w->last_key, &key) >= 0) {
+	if (reftable_buf_cmp(&w->last_key, &w->scratch) >= 0) {
 		err = REFTABLE_API_ERROR;
 		goto done;
 	}
 
 	reftable_buf_reset(&w->last_key);
-	err = reftable_buf_add(&w->last_key, key.buf, key.len);
+	err = reftable_buf_add(&w->last_key, w->scratch.buf, w->scratch.len);
 	if (err < 0)
 		goto done;
 
@@ -312,7 +313,6 @@ static int writer_add_record(struct reftable_writer *w,
 	}
 
 done:
-	reftable_buf_release(&key);
 	return err;
 }
 
@@ -325,7 +325,6 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 			.ref = *ref
 		},
 	};
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int err;
 
 	if (!ref->refname ||
@@ -340,24 +339,25 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 		goto out;
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val1(ref)) {
-		err = reftable_buf_add(&buf, (char *)reftable_ref_record_val1(ref),
+		reftable_buf_reset(&w->scratch);
+		err = reftable_buf_add(&w->scratch, (char *)reftable_ref_record_val1(ref),
 				       hash_size(w->opts.hash_id));
 		if (err < 0)
 			goto out;
 
-		err = writer_index_hash(w, &buf);
+		err = writer_index_hash(w, &w->scratch);
 		if (err < 0)
 			goto out;
 	}
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val2(ref)) {
-		reftable_buf_reset(&buf);
-		err = reftable_buf_add(&buf, reftable_ref_record_val2(ref),
+		reftable_buf_reset(&w->scratch);
+		err = reftable_buf_add(&w->scratch, reftable_ref_record_val2(ref),
 				       hash_size(w->opts.hash_id));
 		if (err < 0)
 			goto out;
 
-		err = writer_index_hash(w, &buf);
+		err = writer_index_hash(w, &w->scratch);
 		if (err < 0)
 			goto out;
 	}
@@ -365,7 +365,6 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 	err = 0;
 
 out:
-	reftable_buf_release(&buf);
 	return err;
 }
 
diff --git a/reftable/writer.h b/reftable/writer.h
index e8a6fbb78543e6e56920a2999601db0db9fe4d97..1f4788a430c52c5387b5e97f639e84544d0b9ba2 100644
--- a/reftable/writer.h
+++ b/reftable/writer.h
@@ -20,6 +20,8 @@ struct reftable_writer {
 	void *write_arg;
 	int pending_padding;
 	struct reftable_buf last_key;
+	/* Scratch buffer used to avoid allocations. */
+	struct reftable_buf scratch;
 
 	/* offset of next block to write. */
 	uint64_t next;

-- 
2.47.0.274.g962d0b743d.dirty

