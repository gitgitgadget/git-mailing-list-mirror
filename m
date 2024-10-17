Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58C17D355
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140851; cv=none; b=PNkOZ4v4rRMGkzozUZnbb7EDBzEwKCP/KKKuqJTPKF7Vuo/H6eCuhNJIPgjEJqgqknkRKZKJ2TkNpOmLQTY170zLHsOe8cM98W0bSdgXnChaCCy1wb75x1Ladj4CZ9X5Epm+Br3jBPfbSUG0EW4wGd+UxT0uAsa6CjUxMEyoMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140851; c=relaxed/simple;
	bh=HQdN+VP6pp2esCQOvjtS/7n92ymvtBpsPBQLpv6w82E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJxorXqimcb+mTKIatswNdHsgiRaFViHX36lTXJnYPCcyHAtr+EnTtIPrRbImstUlaWlaof/R4oufmqpGPx4dc7628w1Nb++JX57fLpovsvykQAQKxX8BcliNe5aJPdoLQZfg8jv4jjgf5X9KhtH5G/ni1b4c5UIwKjqsw8oXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nZgmh2qn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dztUNu50; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nZgmh2qn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dztUNu50"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 827A313802B2;
	Thu, 17 Oct 2024 00:54:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 17 Oct 2024 00:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729140847; x=1729227247; bh=YJgTa8YwrK
	hi1qa7l0d9psTrqKETN5pCi8yD/RhxwPg=; b=nZgmh2qnnnZZ3lHHyNyoHrilIz
	+aIZIMPl9K6kz3xSzrrmw0KigKgCRDjwKxyXbAQiDyqiwrUM2gcpPCdX06UVScF3
	uZnKXojB+U5vD4cKMaUDhAfHgcIwex/075CbOonLL/gvBS0DIE4jhMQmqH/n5hfS
	yfKakmeJXu2BfsFb/gooDG1hpcYx1t12nTy8BRXxVG1DwAzH+Alg8OOVSCdIgMgp
	oS1NbLYnHmYceo9u/IhkgDlNoobfV+b+96TMW+64tgM1pZEimb4Urhdf/8uvb4Iz
	MXpQVUy6BRrXWU2SaNQsm3DwobOB6TtGjhQFMJ4pdQgBQmF/rvkJfK0WAYzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729140847; x=1729227247; bh=YJgTa8YwrKhi1qa7l0d9psTrqKET
	N5pCi8yD/RhxwPg=; b=dztUNu50dNSv7qqPBDlXpQc/3hLk/u6fBeFcmcc7lcI/
	h3IG4vUEAvRgTuAa6XbxIDf7GN9KG0d6/9gEuEjYB2k9/FM9mXEGKc8kU3MuHOJw
	PIOmWf+N7is6TdL17gjDQG/JEkgDxW3SxxpTZbSGeneYIb9XJX3oZnFX+sQcdo99
	FbrDcSfNtt5MDSoGywe/2Z1LmXQj259ZmgrjyVDbjdHgu7hxwnmWdOC1hKQIPJ5s
	mbEfR9RE5kpbmYs0SXZ02yRU1k+IEWawvXHjAqEMfg4cS5VZ0nWEv93uOdfdwWSy
	vsRuxyVXZceBxY06lON9XKaXToNwzp9pSYMMNpVl9w==
X-ME-Sender: <xms:b5gQZxAyMIxTKhiUOpWq18tWKsqEjc_50qaohzKnKdi8kMto5CuA9Q>
    <xme:b5gQZ_jMNUzDuvDgND1AVMD1PBigYvlRke5ZE0b04V3VbTlEXmaEfVlVrvTdd4Hpz
    JGJ8EGo6euM4G62AA>
X-ME-Received: <xmr:b5gQZ8ltD8VmzY8jokyh6p4fEPCJ8oGlWd_ylhGPCWM7Gy0JYUoRVghGPMyAgNZ7y3ZKaVoppYkwj6xDj8TRC8pvP4vNwEG-z0I5i1vQhbHKQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepsh
    hhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhm
X-ME-Proxy: <xmx:b5gQZ7zAY4wK-myixS1ZEEcB9aSX3G5K9gH8h184tBB0vZVruaB43Q>
    <xmx:b5gQZ2S8NVdviqQkHRTReu3ZA2BBgkNjag2IFNVc0yQtZdnRMMZIEQ>
    <xmx:b5gQZ-aqOU5XrZXDvDvP4TEokDmsVQaqlrSMUYZ_ekFSpgpL0CSY0Q>
    <xmx:b5gQZ3T5vZBrLP9B26V3WZ6ktqfWPYb0In5677eH45_QC_jfhESsoQ>
    <xmx:b5gQZzIVaC5W3n0d_Ohc3cLveip_iWbIx_GnMWIbBz3aJTQi5XUNiOx0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:54:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3044a7b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:52:48 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:54:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 07/10] reftable/stack: adapt `format_name()` to handle
 allocation failures
Message-ID: <8f8e2ca39624208e71aaca13e439ba7d32e77970.1729140565.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1729140565.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729140565.git.ps@pks.im>

The `format_name()` function cannot pass any errors to the caller as it
has a `void` return type. Adapt it and its callers such that we can
handle errors and start handling allocation failures.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 6ba48ddce5d..e94eb3c4685 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -623,14 +623,14 @@ int reftable_stack_add(struct reftable_stack *st,
 	return 0;
 }
 
-static void format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
+static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
 	uint32_t rnd = (uint32_t)git_rand();
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	reftable_buf_reset(dest);
-	reftable_buf_addstr(dest, buf);
+	return reftable_buf_addstr(dest, buf);
 }
 
 struct reftable_addition {
@@ -846,7 +846,10 @@ int reftable_addition_add(struct reftable_addition *add,
 	int tab_fd;
 
 	reftable_buf_reset(&next_name);
-	format_name(&next_name, add->next_update_index, add->next_update_index);
+
+	err = format_name(&next_name, add->next_update_index, add->next_update_index);
+	if (err < 0)
+		goto done;
 
 	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
 	reftable_buf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
@@ -893,7 +896,9 @@ int reftable_addition_add(struct reftable_addition *add,
 		goto done;
 	}
 
-	format_name(&next_name, wr->min_update_index, wr->max_update_index);
+	err = format_name(&next_name, wr->min_update_index, wr->max_update_index);
+	if (err < 0)
+		goto done;
 	reftable_buf_addstr(&next_name, ".ref");
 	stack_filename(&tab_file_name, add->stack, next_name.buf);
 
@@ -944,9 +949,11 @@ static int stack_compact_locked(struct reftable_stack *st,
 	struct tempfile *tab_file;
 	int tab_fd, err = 0;
 
-	format_name(&next_name,
-		    reftable_reader_min_update_index(st->readers[first]),
-		    reftable_reader_max_update_index(st->readers[last]));
+	err = format_name(&next_name, reftable_reader_min_update_index(st->readers[first]),
+			  reftable_reader_max_update_index(st->readers[last]));
+	if (err < 0)
+		goto done;
+
 	stack_filename(&tab_file_path, st, next_name.buf);
 	reftable_buf_addstr(&tab_file_path, ".temp.XXXXXX");
 
@@ -1370,8 +1377,11 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * it into place now.
 	 */
 	if (!is_empty_table) {
-		format_name(&new_table_name, st->readers[first]->min_update_index,
-			    st->readers[last]->max_update_index);
+		err = format_name(&new_table_name, st->readers[first]->min_update_index,
+				  st->readers[last]->max_update_index);
+		if (err < 0)
+			goto done;
+
 		reftable_buf_addstr(&new_table_name, ".ref");
 		stack_filename(&new_table_path, st, new_table_name.buf);
 
-- 
2.47.0.72.gef8ce8f3d4.dirty

