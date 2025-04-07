Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8A248896
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029076; cv=none; b=e6bSFcOBUyNFwo6p0xgJS8L0yxsIyaZAremNR2Nr1cm1cYtuRf5wOky3U5vDjD4yz5Ammst3XB+iSGvbNWDIaFLAn8dv+QPhnB0P7xhT3FJmDbCLZLqJBCnclQyNgis+KMfY9QoI5QhcO6GHNPIJvAx+7735TbQhA6r5TCbbY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029076; c=relaxed/simple;
	bh=nry2jVYvRGPg5v+G7/LMAkICVDHuDndMKw0yp09ptPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgvRQ1hLz+jt8eAcQRX4ED6XkFWAXFwZwvLatN6+at5xMU3qXK1DiTugKbRlnjtAnRpfSz/Qp24Ay6KgSl9a7Y0aeqmdV2FUY5PMUaiyBRsWJM6gzAL0QScAbzt/AZ+xyaFQp3ZMpuNsY2hGmElxXcC5egjWZgbLEG/pi+NCshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CR7159eh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQCuuOBo; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CR7159eh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQCuuOBo"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7389E11400F7;
	Mon,  7 Apr 2025 08:31:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 07 Apr 2025 08:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744029073; x=1744115473; bh=jEwAsrOf0u
	Nk4ZHgSTHYQ4eKgJWM/dgSF04lA+sbTdk=; b=CR7159eh53djHupnp3RND3LS1E
	KSygQDcJh+5e75hQpTkJ911g38knagSYmgGSVtqdbR+S0F6eOvD/BD2mdaoqtfhR
	Mc9wA/QUruupR8KSGGi23g0WoiQrNH4dFzD59owPDpKTkJlxIP5M6yzvewDm/NSQ
	C7CSAn/R8I2hlQ+6Xaz4eZmDEzbb2sjsOBe4p58U4UWgxui00IQR1oZ7uEweqshT
	mhZ+q1sOoF7HZefEIK6WwKuC2BUPQfa2Q7LCNhJ1OoHxQYpuL+xr02Zrt/p/Wex5
	Lk51/xpZnJ4IdZvWmh09J2NRLtSatDlq/igCd9aucAxVVrYD0bQrDUKUi+Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744029073; x=1744115473; bh=jEwAsrOf0uNk4ZHgSTHYQ4eKgJWM/dgSF04
	lA+sbTdk=; b=IQCuuOBoBbTWnLZjjHlVDA6WRUG6yjCuFt55MW0YkI7SBwEfP31
	LsEMl1v0uLwP2tYPTxCm6t3A77Fbfo8YnD4aUE9MMEcDYdwcH3tGDwjRn+0Kdysk
	I+tRzlVn6PqQge3MztsmpcdPugeGw+Oc2WPrzX0TpDyeIEtwZNOYBjtXwMSEa890
	fMktFR6RwqBX78WhZcmS0vG4N5+vcJtjXFmJ7MLO9CW4Q/fN3m5tZlIjEAjYaSYu
	jrlMW04NYFJPWgbZpkgb1D5cbIQRR2IXJYh/agWA5fI+k5MbnZ2F4UPAwIgsxyB5
	3BVO2rV12klI4M45Eq6CxVbtRU8E2kXXerg==
X-ME-Sender: <xms:kcXzZ5EmK6nNqfCMvrvh86hPTTgET1RsAmeQy_qRI1aJsDU4eZLGrw>
    <xme:kcXzZ-XNp181ZViXnVqNhkGMLoMxTPK_Nod_lgoXgDN1DUkBvf-LsrmSmJRVjGGTo
    q-3ROJ5w8gCCYsz-g>
X-ME-Received: <xmr:kcXzZ7LA6tl2rlP8XQyMr9FlrWg7AoDI_eTE6Iu-og_3-trtlJ8sBJZz1J2j1V6nWhGPZ5xGKkFvnMWeexhZIv6R3gQxLWOdUKIS8npaTxX1kQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kcXzZ_FjD_cvU952kWr-T8z-2pRAj1SxrqDr80b4w130-b2nW07O5A>
    <xmx:kcXzZ_XXx2FJH9BM3F6YidT7CtkV3REpnGRyJ2g6VoNTzROtVKfvAQ>
    <xmx:kcXzZ6Ot3zpMQHFFTzBFR35yfaODBlcbLYcBiARMf7gaBC4Xrb-FMg>
    <xmx:kcXzZ-3xHuZqChyMYdZCg01xBdk7iyuH-omp2-0uGBrUAJEg7QMhHw>
    <xmx:kcXzZ2w9SQ1SHK5nWECAe4noirTk9nr5oy4Ll5AK_BLoOkw_T0ziTH4W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 08:31:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 90b39f13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 12:31:11 +0000 (UTC)
Date: Mon, 7 Apr 2025 14:31:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/16] reftable/table: move reading block into block
 reader
Message-ID: <Z_PFjr9p4u4MA4yD@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-5-ebed5247434c@pks.im>
 <umaolgemnks4g4cgwgnurl7alic2a3pzrfx2ws3s7uxypiedia@7mwqxvhw2zxg>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <umaolgemnks4g4cgwgnurl7alic2a3pzrfx2ws3s7uxypiedia@7mwqxvhw2zxg>

On Wed, Apr 02, 2025 at 03:13:03PM -0500, Justin Tobler wrote:
> On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> > diff --git a/reftable/block.c b/reftable/block.c
> > index f2567a8f0fd..2517108b8ef 100644
> > --- a/reftable/block.c
> > +++ b/reftable/block.c
> > @@ -209,31 +209,57 @@ int block_writer_finish(struct block_writer *w)
> >  	return w->next;
> >  }
> >  
> > -int block_reader_init(struct block_reader *br, struct reftable_block *block,
> > -		      uint32_t header_off, uint32_t table_block_size,
> > -		      uint32_t hash_size)
> > +static int read_block(struct reftable_block_source *source,
> > +		      struct reftable_block *dest, uint64_t off,
> > +		      uint32_t sz)
> >  {
> > +	size_t size = block_source_size(source);
> > +	block_source_return_block(dest);
> > +	if (off >= size)
> > +		return 0;
> > +	if (off + sz > size)
> > +		sz = size - off;
> > +	return block_source_read_block(source, dest, off, sz);
> > +}
> > +
> > +int block_reader_init(struct block_reader *br,
> > +		      struct reftable_block_source *source,
> > +		      uint32_t offset, uint32_t header_size,
> > +		      uint32_t table_block_size, uint32_t hash_size)
> > +{
> > +	uint32_t guess_block_size = table_block_size ?
> > +		table_block_size : DEFAULT_BLOCK_SIZE;
> 
> Out of curiousity, in what scenarios would the table not know the block
> size and we have to rely on the guess?

By default, reftable blocks are aligned with padding, and if so the
block size is tracked as part of the footer and well-known. Ideally, the
block size would be picked so that it is the same as your disk sector
size. Git picks 4kB by default.

There is another mode though: reftable blocks can be unaligned, so the
padding is dropped. Consequently there is no fixed block siz, and this
is indicated by having a block size of 0 in the header/trailer.

Patrick
