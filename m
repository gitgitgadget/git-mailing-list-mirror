Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F378C60
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720566; cv=none; b=nn6hzKGvovOoX9Q3g7dXbW9oTzhvUDcHwtJRy8IlC5tSf4yz2Xlx1eL1p7QOB47lMLihgZ9Gbf/K6Z+m6fUu7vDefoEy5UPlzqPX+qUlURXGzukkk9JYyorvly41pGGV0Qa+yqYVwqyIQgmchy+8B8MvimoosseCrnuTXZbUB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720566; c=relaxed/simple;
	bh=IRT2pc38B4m8tguYqSiV4UE4nvvhi9jpoTo9LLKfMqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As0Lp4mePbfkPrRw0weITGaRt/eius36SCI05PyBIN2UPA8RH4MkbgPc/Wwarn+WNq6SzdFU6oKOXkOpA60UXw/hfuMH7wMrvl9C/It4QDkk5PtbVFpz1rUHAN7oanxRwxoGC2nvi8973+e7MmQz/AFmDPDxGDky2BNvbRwmQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LX6XtvqR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUFd/7WX; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LX6XtvqR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUFd/7WX"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A7DBA13801D7;
	Mon, 30 Sep 2024 14:22:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 30 Sep 2024 14:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727720562;
	 x=1727806962; bh=g4IZ0iBMLp8GEarcKRxNMbVTPNILgd14rHCSYMpE7JQ=; b=
	LX6XtvqRqNXxX38u9RorEo6j2x1qo+Jqg+evu13IWmFVRNzXT3haFUKhlrcOl+ga
	c1/j87yIWrnB2iLgbu4bi3WfWYUikmptSUwCfQvOClrzej9UZbGyzG9R3P7Bn8T0
	4bG2zE/e1PDLMgSawGNKu379RmIf920q/tREKes9sw1SpG6b0Wy2SYGJQLKiHDOV
	o9OVFwWGDeb5IXUl1hHKloeokc1MRCkNVHSHQnUrrPPgLt/dy8P8cgJ1gI4SzYtU
	BSDtBYp9OCcGpMlvVciSvj6y0+JA28CT7MBlsy3rR6IthTQwibKIUn+XsSW3aO0Z
	PQSEtWvGXN8tIuIeJXHFcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727720562; x=
	1727806962; bh=g4IZ0iBMLp8GEarcKRxNMbVTPNILgd14rHCSYMpE7JQ=; b=W
	UFd/7WXjAfNAj73cog//uRXRFDwsIYq95NTuZxfjd/V8SbYfVNPeIyZ1fny0++ru
	8yksdESFzAIQToovwhiLllLQBQfwO7jN/NSEY++nNR79atqlpbUfEKvCU5pWdDGB
	rfzN0UgrIl1K6Lo3T5qPlKIMjuX9BWUDmkXx298ROaBpEoSpCB311K0jZ5RveDHc
	Ij5SaZXyf0g8TOZM6YijYwieMxiXRUWZbBYeBifvgCDHv7MhfgIBCgXzpGL9GAje
	Yo73Q1Yk+rLXL6PgH30cB1c75oC9vMPkfsprJlqIecveOMUunq5mw2fqbXOmB+Xl
	9k/g8icL1lbmvQ5D+aQxA==
X-ME-Sender: <xms:cuz6ZomMXdl7qMNxnuLbTY62VbJZrl-gZlyasULBpUfDIb5rhCEISA>
    <xme:cuz6Zn0IWj1lGoBPHCMdpIBs0xdlVc_4xGZaLeS7BVtcFVdr1Am_dzXueaeLdx-L4
    Sz3cs2PmFrT8UiN0Q>
X-ME-Received: <xmr:cuz6ZmpDkjPAFE_B8MZAiPkhRfQ-780DRuV2kHqvj59oNqvJugX06ChFrPrlJEq4T9v5Jluv6SnKmGFazwCBIi7e-U6c_WAejh2QVjTtfNsDLWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthh
    homhhsohhnrdgtohhm
X-ME-Proxy: <xmx:cuz6Zklcc7S_i3T1eVpTWrLN1fh6Y_GxLEJlnrbdTw3el_x3rE0ziQ>
    <xmx:cuz6Zm2llxeNuCQ5WakVO3x6QvEKnYjTY6jL5v6Q-pl1rudo6dDlvQ>
    <xmx:cuz6Zrv5k9FRglbIAmJBBAzbXu1fbTxBN4uOhfTaUhhYamDYpBIWxA>
    <xmx:cuz6ZiXoYAPssxR5HO1SLB9tVhhNs3P4Pbf9Rapeko7FA4BTz5q3KQ>
    <xmx:cuz6ZpR293wx6pM_O2Lut9frFSl5vn3Ai0_R_TE50RPB0eC9-yENCpn4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 14:22:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bfa7d4ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 18:21:52 +0000 (UTC)
Date: Mon, 30 Sep 2024 20:22:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/22] reftable/writer: handle allocation failures in
 `reftable_new_writer()`
Message-ID: <Zvrsd5JQr8RAhSaN@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
 <9edd1d84cdbd53d966ff5cfe9b75281dd5966b07.1727680272.git.ps@pks.im>
 <64253c71-915d-4862-8fa2-555ca2fc63cc@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64253c71-915d-4862-8fa2-555ca2fc63cc@web.de>

On Mon, Sep 30, 2024 at 07:40:48PM +0200, René Scharfe wrote:
> Am 30.09.24 um 10:08 schrieb Patrick Steinhardt:
> > diff --git a/reftable/writer.c b/reftable/writer.c
> > index ed61aaf59c..54ec822e1c 100644
> > --- a/reftable/writer.c
> > +++ b/reftable/writer.c
> > @@ -117,13 +117,17 @@ static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
> >  	w->block_writer->restart_interval = w->opts.restart_interval;
> >  }
> >
> > -struct reftable_writer *
> > -reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
> > -		    int (*flush_func)(void *),
> > -		    void *writer_arg, const struct reftable_write_options *_opts)
> > +int reftable_writer_new(struct reftable_writer **out,
> > +			ssize_t (*writer_func)(void *, const void *, size_t),
> > +			int (*flush_func)(void *),
> > +			void *writer_arg, const struct reftable_write_options *_opts)
> >  {
> > -	struct reftable_writer *wp = reftable_calloc(1, sizeof(*wp));
> >  	struct reftable_write_options opts = {0};
> > +	struct reftable_writer *wp;
> > +
> > +	wp = reftable_calloc(1, sizeof(*wp));
> > +	if (!wp)
> > +		return REFTABLE_OUT_OF_MEMORY_ERROR;
> >
> >  	if (_opts)
> >  		opts = *_opts;
> > @@ -134,13 +138,19 @@ reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
> >  	strbuf_init(&wp->block_writer_data.last_key, 0);
> >  	strbuf_init(&wp->last_key, 0);
> >  	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
> > +	if (!wp->block) {
> > +		free(wp);
> 
> Better use reftable_free() to free it, since you use reftable_calloc()
> to allocate it above.
> 
> Perhaps ban free(3), strdup(3) etc. at the end of reftable/basics.h,
> banned.h style?

Ugh. I was relying too much on your review having mentioned all cases,
but I really should've double-checked the other patches, too. Mind you,
I really don't mean to blame you here, I blame myself.

In any case, banning these functions via "reftable/basics.h" certainly
seems like a good idea. It's just too easy to screw up by accident. Will
fix tomorrow.

Thanks!

Patrick
