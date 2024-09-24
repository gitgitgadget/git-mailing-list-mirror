Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD51FB4
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156952; cv=none; b=GP6sMfJYZe8WGxCPIAiQnLLC1mu0IRzRH5t2TIawBskWx8ds4UX7NHSSyuKyTQItZd0+4bPHbSZbYdPlNf2oGbVGLIchE9ZekZP1cXDRHpow+igHZNMDMvsmOUESR8sE+CvIiFw6GbbLvH+/KtgpIVg6BuiXPcqpEmwWw5Ri0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156952; c=relaxed/simple;
	bh=uqEky2NzHM4rzAJ004k13R1R5NGP2K18X+TYMQFMHKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8BRntj6gU3FxV+qzlAE8RDP6Ae9W6MXedvcm6CV2lzs05Zh0GJ3cVWnBqulOKICfKbNrnkowUw/5x54t9os5wfzsnJNkMWxXfKYbYkOonQ5mggW36rQ+HJs58udXz7yRJZ+xAzEidBI5568hWQtwVqwLmK0nbSEM9Tecyhl7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PEUZj0kY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dVlSz5Q9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PEUZj0kY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dVlSz5Q9"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E9351380437;
	Tue, 24 Sep 2024 01:49:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 24 Sep 2024 01:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727156949; x=1727243349; bh=xzAzVqLraP
	FW2krqihZd8CZM1xRDMThGa7xGPnBPBec=; b=PEUZj0kYzsCVSwR/Ak0l3w8I46
	4a2XvS+lZeB/N6Yx2F7DmQLKI/tnB44C83z0mvAaDG6wGZyFtbQtD+U8GFtn0sRj
	ttgMMZrOnPiUhOZgF/nijd0CmELx5nRNto2ujSVH0O/3s7Sd+RNY1gvVGJsQAq29
	4tp/oeplVHYtJvNAzxdWDtup7O/syIIxl0/oHI+zbm/1abEdKwnPMUiEI/GAeiv4
	gxtcJAxEtnW0nrlNWNjFDYMT91QfLkiIHB2GIEJeCklYLcY/iRYD6W6d90J14Wxr
	t3jLi09JLzvtXbl4OMLsHCg6cvMiggncVcy1DmmJUtWhFa48BRQQMdU5XJQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727156949; x=1727243349; bh=xzAzVqLraPFW2krqihZd8CZM1xRD
	MThGa7xGPnBPBec=; b=dVlSz5Q9DcOugso91neIOiBTTfXSOuJ1C/JZkKtQLDwM
	ia1ocDQJS0wXugArPGWQc/BGeS7sFJuGX1rm6wBC+aMbzLUw0xC4AFkZas3helNS
	PeznJYGCH3qqpYdQpxBAbGC/7bkKd4Da/p1sH39A+Z6CH8BzN6MMXT+8S9muhSdF
	OHNSLzpF108FxHV2wWVWBgaqFtIvtxUjJV0UAbVgVQ3N1wlF3APdvARf9H1YQXhJ
	ZQUTQUb1Z0N7t/tIEI3+xrYdsBGsGT+tIvcswPGvF3nZF+GmTWiG4tbdUcO7doYS
	fuoOuRpISAuaY1A5ib4OekSMA4/CeW8Y/GKEx+iS5A==
X-ME-Sender: <xms:1VLyZvRXjUFb7qHu4OFb0XtRwsydoC8aNXxxJLQDZAwDPPZunGwBxQ>
    <xme:1VLyZgzHGdsmDYSilwFIR7ViqL-PS6yBdOUyZqcF5msGBAPi2jf2HcrR5DCxqELDU
    HMXiyXcbQtnKWYAfw>
X-ME-Received: <xmr:1VLyZk3gPlHxeplrsPeX0VCqnNzhnGIjm72hYUSEsx-2hLRR8EId7EgzD3WO0GNynnKspbhahWpgFHWDl20wTMBOr_orF6kSvKTRpSatkC0ufQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1VLyZvAaKufZEraOHQ6-NCVCHn5X3-e5T-QRT4dDKQQRbZbaZgGF8g>
    <xmx:1VLyZojcpHISDY7rarh0146zh9P_ieCcXsuurUcOaduo-OqapyZqqA>
    <xmx:1VLyZjqymqwZjHc5gOU9j6WhBih0ImFWzHB-OJWABhkGuk5CAkXHXw>
    <xmx:1VLyZjiQE4bxdkbnf8GSOnE5mYg2q_aHjWzIutBy_2ASzT53Pbc8tw>
    <xmx:1VLyZhtlrQI0IvmB6NJw8HsT0YuqzgnEZcuaKgwlnC5APMys4l02JIT5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 01:49:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f77e2368 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 05:48:35 +0000 (UTC)
Date: Tue, 24 Sep 2024 07:49:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 17/22] reftable/iter: handle allocation failures when
 creating indexed table iter
Message-ID: <ZvJS0Nt-1_Bbq5fB@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <32fead57de989335b17d16f63c1cd144460495a1.1726489647.git.ps@pks.im>
 <xmqq7cb49pby.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7cb49pby.fsf@gitster.g>

On Sat, Sep 21, 2024 at 11:26:09PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > -int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
> > +int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
> >  			       struct reftable_reader *r, uint8_t *oid,
> >  			       int oid_len, uint64_t *offsets, int offset_len)
> >  {
> >  	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
> > -	struct indexed_table_ref_iter *itr = reftable_calloc(1, sizeof(*itr));
> > +	struct indexed_table_ref_iter *itr;
> >  	int err = 0;
> >  
> > +	itr = reftable_calloc(1, sizeof(*itr));
> > +	if (!itr) {
> > +		err = REFTABLE_OUT_OF_MEMORY_ERROR;
> > +		goto out;
> > +	}
> > +
> >  	*itr = empty;
> >  	itr->r = r;
> >  	strbuf_add(&itr->oid, oid, oid_len);
> > @@ -197,11 +203,15 @@ int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
> >  	itr->offset_len = offset_len;
> >  
> >  	err = indexed_table_ref_iter_next_block(itr);
> > -	if (err < 0) {
> > +	if (err < 0)
> > +		goto out;
> > +
> > +	*dest = itr;
> > +	err = 0;
> > +
> > +out:
> > +	if (err < 0)
> >  		reftable_free(itr);
> > -	} else {
> > -		*dest = itr;
> > -	}
> >  	return err;
> >  }
> 
> Unless the service the helper function offers is to upgrade an
> existing resource (e.g., realloc() taking a pointer and give an
> enlarged piece of memory), it may be a safer calling convention to
> promise that *dest is cleared to NULL when the function fails,
> instead of promising that *dest is left intact.  The caller, when it
> needs to evantually release the resource acquired here, has to
> remember what the returned value (i.e., err) was, in order to decide
> if it needs to call the release helper on *dest it obtained from us.
> 
> The only caller seems to initialize *dest to NULL itself, so it does
> not matter in the current code, though.

I don't really see it as much of a problem here, mostly because this
function is internal to the reftable library anyway. Also, callers
essentially have to NULL-initialize the variable anyway once there are
multiple error paths and if they want to free it, because otherwise they
could end up freeing a uninitialized pointer.

On the other hand it doesn't hurt much to assign `NULL` on the error
path either, so I'll just do that.

Patrick
