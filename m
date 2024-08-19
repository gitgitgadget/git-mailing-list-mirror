Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8E85956
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081989; cv=none; b=A2EMmF3oaZn211rCyN8thgdxK4ct5QcsReGJYX7H6+TMuffX5OqshUX9DoKKUcQ9yHosp2aCwsOOM3M31uOZqkP8DDbyQ5H5NdZQtXbNAjwKM5UGd3Nri6Vikq/zdTY7ZzX6m8AHS9DQ+RGpBMiM8nUsLWP7hUgvtO4+FCN0CKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081989; c=relaxed/simple;
	bh=821QLf6UPKXLEbNF4c5/xuGbilO+2kvNGcVIa8jKX4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qtc1J4sAJIQFx8bV1VWEzjYHLwbHrf0NgIMGLZVMQLr1dzQYKiS9xy3T8kQSJ/HeMzwsGGp2xtsqQcR/vGpGLkvLED+D2UpYhvYnDJT1PrI8mXkpkNX5uKrxzzoDM1TPOXpS/YtCgZN7Y88l4AfvcuB31M8fSTojvdTrJzDq/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=inRV3Wmw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fx30TRgD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="inRV3Wmw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fx30TRgD"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id B1EBE138FF3A;
	Mon, 19 Aug 2024 11:39:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 Aug 2024 11:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724081986; x=1724168386; bh=LX7Ry5Q2vW
	W7NbPfwwLw+yndxqhGNGCGEHGEx1nhxYk=; b=inRV3WmwZsaIe3XVWL9dAhWyKT
	m95H8nsACsLy0aOzXaWOQsx4STFqZJVYBzmWaGCS2qWjD1YOBMEoYfEv8GPuuvbo
	kyh79O9H8LMN8eL8N47NGM9bVToes1/2axh/K9CaHJ1M56MFLB8Uyh5AohjEjB/q
	Z+lrvl3cEJHZCk799LRmDA4kT2bGij5mrzgUIR0bAM/MdPVC6B/4pf1fkNnB/UEg
	c/U5jr7ymjq8crWVSClNj4QDynhp0ZmbiZ4SgRfs0QajDxt4B29rqK3K3SiriDX9
	1l/ggrZWj5aTgvnKCKZXG20X0bDesn4csgW8oMg4jSS0/JPz4ACItYIn+ONQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724081986; x=1724168386; bh=LX7Ry5Q2vWW7NbPfwwLw+yndxqhG
	NGCGEHGEx1nhxYk=; b=fx30TRgD9j6v8KQkW/BWcps9lPlGXdapdyTrakQ0dp9t
	GLgtEaeKjIKiChqHbIgZeDqUnhlE2MGCE9utXaO4mmGq6qWJHBkk086K2WCDeByw
	eBAnrsaYoAtrgJRBEYr3jdxwbT/PrrWUsCbFJ7PX4+sWQICjJgSYwu5+RVJGUq+2
	Q9ZZ1ENOFd1oamR/BfdUTWuyEJd61xHT2S1YgcjTlUGPuhC3A+Uh0RhofG1oZEW6
	Yx8j06Fy0B6bH0y9kQbTv2qET9ctA4LfrH9Q1dKaxPfBCi5oAXRgNiDjQMVFCgM4
	kW0NVY78gFaGjyD1p2Q215yfpkiGFRfLPpwSv10j0w==
X-ME-Sender: <xms:QmfDZstz3LDECmawDR9KcJKLPWGePPfQyfl19WGtcwyQcU0LNY_dQw>
    <xme:QmfDZpfL_25mwP5qmbHIaMZKcq_LVtVpuc-Y9XmH-MICEA6XMb2VCVImKH3RoawbS
    QEa1mvaT7Qb-nRdFw>
X-ME-Received: <xmr:QmfDZnyxZ6yFAsCWXuSMuCjrnI1YvYXfw86G9EMkOclRUpjnqW3Z6e0YCiw-MFelVsCDyi4cUuR9dKUOCNJ6RxNjO5zpV7guDtgTM_GynUq9spo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QmfDZvNlz_y26hCXnc4rIfRe052DjHBnL0Pn7vML11w7CayeJ2rGrg>
    <xmx:QmfDZs9-Luw5b-8LENSvI0L4K77dZ8LL1CuLxjqPtRXERJQ3BSBKaw>
    <xmx:QmfDZnWUdD_0GV-3fEsoxoUKylWCGbIflfGLKpsyB0mLIi3v5I38Sw>
    <xmx:QmfDZlflfYZqthrCN-pqTQ37EoGpHr_D20aUDlWMZKSlwkGgr-hkcA>
    <xmx:QmfDZuL2dvQBbqiYMm5gD5XriSCxGx8vZlVfNgN7aTxeKiZimAuy_uVb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:39:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3bc7aa6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:16 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:39:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 02/10] reftable/stack: inline `stack_compact_range_stats()`
Message-ID: <3c0cf2bf46f4106d7c0b30c863946262639b2351.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724080006.git.ps@pks.im>

The only difference between `stack_compact_range_stats()` and
`stack_compact_range()` is that the former updates stats on failure,
whereas the latter doesn't. There are no callers anymore that do not
want their stats updated though, making the indirection unnecessary.

Inline the stat updates into `stack_compact_range()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index d3a95d2f1d..891ea971b7 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1328,17 +1328,9 @@ static int stack_compact_range(struct reftable_stack *st,
 	strbuf_release(&table_name);
 	free_names(names);
 
-	return err;
-}
-
-static int stack_compact_range_stats(struct reftable_stack *st,
-				     size_t first, size_t last,
-				     struct reftable_log_expiry_config *config,
-				     unsigned int flags)
-{
-	int err = stack_compact_range(st, first, last, config, flags);
 	if (err == REFTABLE_LOCK_ERROR)
 		st->stats.failures++;
+
 	return err;
 }
 
@@ -1346,7 +1338,7 @@ int reftable_stack_compact_all(struct reftable_stack *st,
 			       struct reftable_log_expiry_config *config)
 {
 	size_t last = st->merged->readers_len ? st->merged->readers_len - 1 : 0;
-	return stack_compact_range_stats(st, 0, last, config, 0);
+	return stack_compact_range(st, 0, last, config, 0);
 }
 
 static int segment_size(struct segment *s)
@@ -1452,8 +1444,8 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
 					   st->opts.auto_compaction_factor);
 	reftable_free(sizes);
 	if (segment_size(&seg) > 0)
-		return stack_compact_range_stats(st, seg.start, seg.end - 1,
-						 NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
+		return stack_compact_range(st, seg.start, seg.end - 1,
+					   NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
 
 	return 0;
 }
-- 
2.46.0.164.g477ce5ccd6.dirty

