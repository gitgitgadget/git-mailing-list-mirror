Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7377DA86
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720924; cv=none; b=BjILMBNNuTGFvrNYLX1C6+gjd5GP7PliXrRzHCGcKulFdwiwfQXt+vROxk1iApR+lQc5gyYB11lRhKlplI6IhLtBgTh6CfuA9V0f/IPGwIZRoV3xf6IS8hmq8iGlA1FQTgd3kziotEAPCqS54v3er5y+gWxoHCDtd5PDLBD5Hvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720924; c=relaxed/simple;
	bh=rr8+XbK/LuUSXOhM1bCsFj4iFvXpZdp32Ca2vt9Q/9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4yuVfAEYlMqDroIUPReoVQW+2CC7eGJ7OvmzZyb5aiIbJu/MYAPQXynHYpkfpFtrxnB+SUawngdHzWu7QL9XjZco5pOEHDIIz+JWGxgDcAPU+D0/aA4Gbidzjbs4GZW/NEzoH9/VK0DOQLAG3C7uqrmXHl6xdg0I1Djig8lx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZLiladYT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmq7APV8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZLiladYT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmq7APV8"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B2EC51151D23;
	Thu, 15 Aug 2024 05:41:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Aug 2024 05:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723714866; x=1723801266; bh=P3rJfk6Pjb
	zRcRq02w2PK04uJ8sVqjDpO4gkU1+kVD4=; b=ZLiladYTXFNj46xjl28zfNp2rK
	avybod9UPOY53MBm3OSGcnBM+bO3pEMLVRX3Y/kDxN508y4L4qicCmeZPpbWabjS
	CRD+e9zIA52cxG6BvD0GKkplxr0B9auzWXby5O/Sudtv0G2tL6tvYEgwp4kYobHq
	FKpWWOj8hFlJOW481qMVuvtaV3h01NPYOD+lRtxG2rCKP7n5l6smf7/eSLpDxmeZ
	P18ETsgtPGkCm1nXfYyY4WIMIpPM98MrOpDCmBI7SkUuDcJ4XLErVWG0/oDtviV4
	JaZivrJVxNfjmP2Uy8JVBfsn43F6yOnAcsbXz+Xu7mdO+tRNsRa6GrNA1yRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723714866; x=1723801266; bh=P3rJfk6PjbzRcRq02w2PK04uJ8sV
	qjDpO4gkU1+kVD4=; b=kmq7APV87asGFQe2nlI2o3fhezYV0LaVC5uCFxgA8awo
	6t5/or7S1T0RGPlDzpVgq7MfEjOa2at4U8MyXcxsBO81vWtBDvppb8x32RU5bTWM
	J8051wWUsski+2F7s8JFzk5iSSyJdQTBmOjIaTZpN6YBQHIwpgt/53ZVueJu/Wjk
	sqSZsM9sKyyw5xXJS0HkGMfS+ubWVJEJmCjQUYVAqXd5czlgh3eYov38W0VLQYg+
	5ru5dIkIqR0cEsxkfITNrR6y8UiReB4D2vOBw3qn++h14DLwW+iA50/NpmikSDKH
	JPCAY2pudl4bKo4PgI7rWuYLsW15NtFViV7C1hUKEA==
X-ME-Sender: <xms:Ms29ZvZMgjnw8Jo7XAVPW6ZwDvuDc03iB2klyNITgwgIdBe19RU8Sg>
    <xme:Ms29ZubkXRytI9pZVtpx0uH8v-I9p3JL0VAPcgeVAu_gGeNZSqX3mjP7Bw4TSxdPs
    nJlSSNaMT60vSWSwg>
X-ME-Received: <xmr:Ms29Zh9yCd_4ugM0ZVUqBN7fhylOUXAjhsNBi0RswB9eLncJpl7c4_Z7sJ4DK4GKFpi0GqdMX2F7vbbX23VbIa9VCZ4s_1NX5sfGKMg7G7Xp7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Ms29ZlrdBM-K5hmIybQnI5-m8kgqp3VXoyTAWt516r5Tg4GftLN48Q>
    <xmx:Ms29ZqrfLNsCz4bnnz8NU_z93vMBQipxX9oTFcP30vm8htzitKeOBg>
    <xmx:Ms29ZrSTrMD-u6jtMGX8PBENxY80xQvAMfzmuQqbUt2-s3BisQV7ow>
    <xmx:Ms29ZiotvMrMs54aG9v-imOK6JNcS7YNPYsIcdz-3e6uXHQJdIMTBQ>
    <xmx:Ms29ZtU7qBCf47kDv9xFutWWY9BFbyjea8KfqVP62cAbipBTxTgChdvf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:41:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 721c63c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:40:44 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:41:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 08/10] t-reftable-block: add tests for log blocks
Message-ID: <Zr3NMOQWYDOufHXg@tanuki>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-9-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814121122.4642-9-chandrapratap3519@gmail.com>

On Wed, Aug 14, 2024 at 05:33:16PM +0530, Chandra Pratap wrote:
> @@ -101,9 +101,95 @@ static void t_block_read_write(void)
>  		reftable_record_release(&recs[i]);
>  }
>  
> +static void t_log_block_read_write(void)
> +{
> +	const int header_off = 21;
> +	struct reftable_record recs[30];
> +	const size_t N = ARRAY_SIZE(recs);
> +	const size_t block_size = 2048;
> +	struct reftable_block block = { 0 };
> +	struct block_writer bw = {
> +		.last_key = STRBUF_INIT,
> +	};
> +	struct reftable_record rec = {
> +		.type = BLOCK_TYPE_LOG,
> +	};
> +	size_t i = 0;
> +	int n;
> +	struct block_reader br = { 0 };
> +	struct block_iter it = BLOCK_ITER_INIT;
> +	struct strbuf want = STRBUF_INIT;
> +
> +	REFTABLE_CALLOC_ARRAY(block.data, block_size);
> +	block.len = block_size;
> +	block.source = malloc_block_source();
> +	block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
> +			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
> +
> +	for (i = 0; i < N; i++) {
> +		rec.u.log.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
> +		rec.u.log.update_index = i;
> +		rec.u.log.value_type = REFTABLE_LOG_UPDATE;
> +
> +		recs[i] = rec;
> +		n = block_writer_add(&bw, &rec);
> +		rec.u.log.refname = NULL;
> +		rec.u.log.value_type = REFTABLE_LOG_DELETION;
> +		check_int(n, ==, 0);
> +	}
> +
> +	n = block_writer_finish(&bw);
> +	check_int(n, >, 0);

Do we maybe want to rename `n` to `ret`? That's way more customary in
our codebase.

> +	block_writer_release(&bw);
> +
> +	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
> +
> +	block_iter_seek_start(&it, &br);
> +
> +	for (i = 0; ; i++) {
> +		int r = block_iter_next(&it, &rec);
> +		check_int(r, >=, 0);
> +		if (r > 0)
> +			break;

We can also reuse `n` (or `ret`) here, right?

> +		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
> +	}

One thing that this loop doesn't verify is whether we actually got the
expected number of log records. It could be that the first iteration
already returns `r > 0`, which is not our expectation. So we should
likely add a check for `i == N` after the loop.

Patrick
