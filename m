Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B1274B2A
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199212; cv=none; b=t/eKgo48L8P3RRiojEqI19YL5SO5LKrGQ+GFrkQD7vCU+1a6f43QM+9WugXYqjuv4/VvKRrzYsBIcJ8Nz7pPWUKWeJhpEQk2sNwxSkKjGrkbjiQu/YIq6OOAzZiZ6rmhefgNLxXgaSJB86U6rmpFBAw8cK17IE2tXKOMArWuccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199212; c=relaxed/simple;
	bh=n/B5JVgxEutEA5Hfk/Dn8CKbUUNbFGVZGsCfG97tyGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gze1vIA+Kx74BZQYCjjj65D8nz5+Atax3nzZmIoy3qCkBJ+Ci3ynXXa4e7sTO7OThWNS5+P9Jc68/mc88zoSQ+sfOQbXQHMDqfYw9xTocB97oYsmdox/lUhi0oFAXG3vmMOfuCNITDRNVkBkeKdwSjtfxTiFrUPxI4jkt4KJ+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FmkeXneK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m4IivwWv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FmkeXneK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m4IivwWv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 05A42EC01F2;
	Thu, 23 Oct 2025 02:00:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 23 Oct 2025 02:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761199210; x=1761285610; bh=J2sk7An0JI
	zBCbx3H695NITLYt2W5bglWgXI/ovvdyU=; b=FmkeXneK72mssZvwq7HZt0fZiA
	w1BrePo5vN0iChOdo2tWbdC4SWUD3VuRSWuZBcqKwf2M0ZFQnHH46VQw8UQNFRyP
	2YaNxPULXQ35JGFpVlopJ7nysxWmYDWiUhh0wM2vnjD6xYpAs5EIckI/Uyeu+0Tf
	ojob1G5Udhs5aRThFTUOyCw7hHkTUmmA97esLPVjFEg/msthBf2vCcBap9Jk95b0
	sNQkzUNIeOrKg76SkMG0DXPNH+uyPil0YdxWKzoFsUkKCopnh/R2OOXO/BA02o1L
	bCeRAk8NETN4QTCfNzqc6q2rRkrukhDbvCDNOldD+PSnMqUZwmtG60zN9qSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761199210; x=1761285610; bh=J2sk7An0JIzBCbx3H695NITLYt2W5bglWgX
	I/ovvdyU=; b=m4IivwWvbG2dttkT+9PHW2lUBON6fhwpgMx9c8wspLBeqkK0cW1
	yVEVfBD1ZT3Nh2JepN5pGZ4c+bWHvBGGZoNznUtnHwYhsF29GX4FBkRozfdhAz75
	2Shh8/wYxflQlkFcgnEW4c3LJNt9QmswwccHS63BqaMjhl8EXN0xNHM+LBrw2nhw
	SMWjsnqAMTyaqdRemFsjtnfDayrOzRS82t7lQkcNUeGMSO9/JfCJRVm/KLxBQVA4
	64LpRKrGI7Mx8J0yXOOpc0Bzc00vzQLHvZQCZiLKU6KpkfOrhe+JRJjtJ4neOrdQ
	OTHPAXPa+f+Smy8z94lAxKihZrLula4iHzQ==
X-ME-Sender: <xms:acT5aKXrpPnzupQQqLLI156HtWwLckNLMQwLV-p-l6TDGCYnWG6ppw>
    <xme:acT5aKTUe8AaVP6Hfrl2Wop1bFC_EwuQwawxIrBDpw7ZHdXfAl_NnfyexfjoNqO8b
    KSqOsHS79t388oDdPT7YK72RnU79t_uHVP1zWUca6oU7ZPh9G4Hf5Y>
X-ME-Received: <xmr:acT5aIM8uL3EqFM6B7avv0-smsBUQr6IJVb11nV3YgrckDqEvhE26soa0D3WvnEfQ2dLT2ALqe61St30QOOE6G6yjkgDzh2orLZz0CqNOJk4UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:acT5aITlgJRhQGjDYlMoLIE-DWaML883s1kVlKHpWhVBlj324tni1w>
    <xmx:acT5aGggPH1vXOyZJw43Qku9iulNw_zjdcoxmp-yLKuBZ9ZY3xTj_w>
    <xmx:acT5aB9bx_bk6KKPFL30zUOlWn1wG1Nx-jP5L4MUXG3YweX9skCsaA>
    <xmx:acT5aNEcXB_Lt0pKQ8PrnK1L9pfOQpnqCRQ03WYeHFfYgDvkJNWG5w>
    <xmx:acT5aISEMqj8KABSbS8liYvLoYz8tR1MOxZK4k-APbGhDwuYzgKPf1dr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 02:00:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b97ed3d3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 06:00:06 +0000 (UTC)
Date: Thu, 23 Oct 2025 08:00:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 14/14] ref-filter: parse objects on demand
Message-ID: <aPnEYzHvY9u8tfw6@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
 <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-14-eb9f71985ef0@pks.im>
 <xmqqtszryn10.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtszryn10.fsf@gitster.g>

On Wed, Oct 22, 2025 at 08:27:39AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +static int get_or_parse_object(struct expand_data *data, const char *refname,
> > +			       struct object **object, struct strbuf *err, int *eaten)
> > +{
> > +	if (!data->maybe_object) {
> > +		data->maybe_object = parse_object_buffer(the_repository, &data->oid, data->type,
> > +							 data->size, data->content, eaten);
> > +		if (!data->maybe_object)
> > +			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
> > +					       oid_to_hex(&data->oid), refname);
> > +	}
> > +
> > +	*object = data->maybe_object;
> > +	return 0;
> > +}
> 
> I wonder if the calling convention for this function can use further
> ergonomic improvements, after seeing that ...
> 
> > +		if (!tag) {
> > +			struct object *object;
> > +
> > +			ret = get_or_parse_object(data, refname, &object, err, eaten);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			tag = (struct tag *) object;
> > +		}
> 
> ... this pattern is repeated three times in the patch.  If the
> helper cannot legitimately return 0 (success) while stuffing NULL to
> the object, then something like this
> 
> 		if (!tag) {
> 			tag = (struct tag *) get_or_parse(data,	refname, err, eaten);
> 			if (!tag)
> 				return -1;
> 		}
> 
> ought to be sufficient for this caller and the other two.  I also
> wonder if this can further be simplified, but stopping at the above
> is fine to me.

Good suggestion indeed. Let me use this style and send another version.
Thanks!

Patrick
