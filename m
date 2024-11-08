Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8031E1A1F
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058510; cv=none; b=Ur8W7chY/LtfAIjNR7hs0HFOkTlhsVAo0Mfj910H+bPP3NAghAW26f31fBvo1Ko7BwUyOy7MUdiFtfeEjea/TSSHcG0tJOStusRTYX8dEt0aReFqBsVPfyfaimi7Yn3rr0H5pFlbtjS4up+2uuXC0GPMoB4mTSdYvNBJ0SpZWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058510; c=relaxed/simple;
	bh=/ZEGkUvIs6fAJKNB1yLcDQVXSrK8Iov6t0wlNfdOwCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XyWJI4dVKz2FRvCTOytv3vZzHtkx7iPerr/aLrv9SrG3RtMTQl3eQ6pN9riVU3Iw7bOCnqKXKULwO4j8cIl9HTdSqoeL+aB1qUpKlReqBptc/zf21XxvbjQH5Fhp6j/adjLrlbiTYRvPuTP72HZRj2XC2MORI1qz+IBrIIGjKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1TC9nslM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJGlkgxg; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1TC9nslM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJGlkgxg"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A89BF1140157
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:35:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 08 Nov 2024 04:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731058507;
	 x=1731144907; bh=2onQYEhCzXNr1AZwRM/00FD5v0svwVWV8QzBB4ykI+Q=; b=
	1TC9nslM3ZuY1+KxqeJxfHQKXKbBkldHGZmIW0ai92IQ7uXM6AZGfKz++NIHf3lV
	l34jrlQiv6UxWh8QzWy+a6ZZS28Yoi/oL9am/xTJ73F2g+DUHlRQkQmEfb5kfS8p
	mzOYXTvGKpV+FgayIIqO5q8GVs94tRiW1rRR0Cp75gkz0PGJ6FAg/0kSerRIy4L8
	AOiomivXoYcyBs8HXV+pWUY413MPvUPOO1yn7QvCexUme6zCGxf/bxVY4y4Ji6AP
	rtIWmfCS1y6+OyA9De1hMKTQARAxSlzFohyryBjvdSeTf/ZM3ITEne9Igv7tSTrG
	x1kjy533he+DBsqQWMeWgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731058507; x=
	1731144907; bh=2onQYEhCzXNr1AZwRM/00FD5v0svwVWV8QzBB4ykI+Q=; b=K
	JGlkgxgW7W23ZIgouAlV4RSQByQWYI8Sg0wTTV1/V4OuzaNLCId8+JXqUKKpRvkP
	Y9TuwBbBjhJgMEZn5IIJgdl4S4vObRFBmiO+zmYsWT0rV17BDQAk90MTfhIvQBCx
	8IZtG8CF7iLF5SpP25Q4Q3DbzKPcE4Vv7Uv2aSzsA5qBZiZ9JHl+DNKhBg3aQeiP
	8A+I4J7tX6l/QZ55yPryLjCLpBzz1JKXPjkoOEYmAMeKsZRZQ6JO8uZFIyBsOWmI
	Xf3gwZTJcEsCfzdpH8keh9icazbEeciXIDU7/v3ic5AOyZeH49rUPredlRcGMYTO
	b/v1Nl/+Lwrxso6ro5NtQ==
X-ME-Sender: <xms:S9stZ7JLeHIDWj1DMvIa_Gb-CGTugjXJ2py8ZoUSRtQsZQ6dhvuTCQ>
    <xme:S9stZ_JCSD0qzzkT_cHrix06mr73XFqqzWHLThImSYeQOXcesAK9bXTk5qMT7bXEN
    CsZZA-VM1orhclqsA>
X-ME-Received: <xmr:S9stZztFYo6y0zHgsA5dX1XI57vBJqPyC3fDZhpRAnun4_MY8oldtCzDbamkioOSoQG712AUa4ogy1_dtN8KLLdlxLETK9kiUJ4wnC6kFOJSdSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelhe
    efjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:S9stZ0boUStA8I_Qpebp3WLrW9ozY5UrZFA1KNTuMam-kCXi83FGQA>
    <xmx:S9stZyaOWhkcTR1ThtGsgng00JSKAWNB6332q3XWJIMf9pid3mMz8w>
    <xmx:S9stZ4BGM6dhIYxkNg8jBvb_Hw4P-iFTaPbmMeu-kHLEO64OMe_gPg>
    <xmx:S9stZwaWybIxB0XX2OSK90HU4Qg4IeyGkLIzDl3KSHTSYimYBGy6FA>
    <xmx:S9stZ1x2R5yUw5CE-eyYeQEdRatRlL5Rd83UqMtpbv72d9jpJztysVWf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 8 Nov 2024 04:35:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac40b55d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 09:34:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 10:34:48 +0100
Subject: [PATCH 08/10] reftable/writer: optimize allocations by using a
 scratch buffer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241108-pks-refs-optimize-migrations-v1-8-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
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
 reftable/writer.h |  1 +
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index fd136794d5a27b33b5017f36fbd6b095ab8dac5b..6501376ce826469556a7dfa3c39258847300ae66 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -148,6 +148,7 @@ int reftable_writer_new(struct reftable_writer **out,
 
 	reftable_buf_init(&wp->block_writer_data.last_key);
 	reftable_buf_init(&wp->last_key);
+	reftable_buf_init(&wp->buf);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 	if (!wp->block) {
 		reftable_free(wp);
@@ -180,6 +181,7 @@ static void writer_release(struct reftable_writer *w)
 		w->block_writer = NULL;
 		writer_clear_index(w);
 		reftable_buf_release(&w->last_key);
+		reftable_buf_release(&w->buf);
 	}
 }
 
@@ -249,20 +251,19 @@ static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *has
 static int writer_add_record(struct reftable_writer *w,
 			     struct reftable_record *rec)
 {
-	struct reftable_buf key = REFTABLE_BUF_INIT;
 	int err;
 
-	err = reftable_record_key(rec, &key);
+	err = reftable_record_key(rec, &w->buf);
 	if (err < 0)
 		goto done;
 
-	if (reftable_buf_cmp(&w->last_key, &key) >= 0) {
+	if (reftable_buf_cmp(&w->last_key, &w->buf) >= 0) {
 		err = REFTABLE_API_ERROR;
 		goto done;
 	}
 
 	reftable_buf_reset(&w->last_key);
-	err = reftable_buf_add(&w->last_key, key.buf, key.len);
+	err = reftable_buf_add(&w->last_key, w->buf.buf, w->buf.len);
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
+		reftable_buf_reset(&w->buf);
+		err = reftable_buf_add(&w->buf, (char *)reftable_ref_record_val1(ref),
 				       hash_size(w->opts.hash_id));
 		if (err < 0)
 			goto out;
 
-		err = writer_index_hash(w, &buf);
+		err = writer_index_hash(w, &w->buf);
 		if (err < 0)
 			goto out;
 	}
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val2(ref)) {
-		reftable_buf_reset(&buf);
-		err = reftable_buf_add(&buf, reftable_ref_record_val2(ref),
+		reftable_buf_reset(&w->buf);
+		err = reftable_buf_add(&w->buf, reftable_ref_record_val2(ref),
 				       hash_size(w->opts.hash_id));
 		if (err < 0)
 			goto out;
 
-		err = writer_index_hash(w, &buf);
+		err = writer_index_hash(w, &w->buf);
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
index e8a6fbb78543e6e56920a2999601db0db9fe4d97..421a897dccd85ad0532860ff1b4f38b2813d438d 100644
--- a/reftable/writer.h
+++ b/reftable/writer.h
@@ -20,6 +20,7 @@ struct reftable_writer {
 	void *write_arg;
 	int pending_padding;
 	struct reftable_buf last_key;
+	struct reftable_buf buf;
 
 	/* offset of next block to write. */
 	uint64_t next;

-- 
2.47.0.229.g8f8d6eee53.dirty

