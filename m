Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349224022D
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782808; cv=none; b=d9OcCSuJAzTkPsGX3MK9r64E5ciAy6AZ5Vzyb5OYC/jrbu6wAVoSQY8d3RFew9IeIeUKje8OPqdKPIQaOfZ23zJr7A5fL+ilk7P8B7Yp2kgt2LBZBlPSUAuPg1LA59BLqmI9OVDSeULxACoUgksGBA8j9O5Sbv/IEa3XoKk+lz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782808; c=relaxed/simple;
	bh=8/DobFbBZ862dxcgaqKiT+UM+VMtN74mPAgHubImccs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9BHKW1YdSf6n2xpvM04XQQ21vYONcnWaQAdh589a39yroXTyVnc2yKP36RC2f/NJtICh1xpmUIhRQ0yBaZPLbtUpoWa/SXIMthk7MiyeD16S+OV1vgRXxLpdyAwwyRIJsG0SG9vOsZlv0LhVf2l6CKXW0j26LOYMjsm4kF++OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jpEmRfCI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CnZnePak; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jpEmRfCI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CnZnePak"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C5CA1140226;
	Mon, 13 Jan 2025 10:40:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jan 2025 10:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736782805; x=1736869205; bh=W4QXIWpaH9
	B5JYl9vZCC4UZQbJDwVd53zn8J45pYOwg=; b=jpEmRfCIJcq6ycBx68xIE587gt
	lcEiu/+hIDFLVXdrmojrrVP1W/AJKeAo32LaZPslnfV79oUHRRMSAGGSP/fRXk7l
	AldefTirOhH823yF4KBL0IT339TIawVvZgkWSsOQL+kuDTHWU8rshvj39f3hae8x
	yqHqQYY98dHowO/ZcgvHzSb6NMgq9tGfYEGiXgSlIUwcThLT/fJ72GxVcHSKF3sR
	LNnMESDTcc7gTodYOkX2PHabOPiTUSNRG0vA6gUFp6+G9AdR2yk5fpbEujP2Cbia
	bXqKrufxyvsncE2I8Cepwumj7sDSH7sSi0MtwVWoR1fGyiM/bSHsVvEimuFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736782805; x=1736869205; bh=W4QXIWpaH9B5JYl9vZCC4UZQbJDwVd53zn8
	J45pYOwg=; b=CnZnePak7pzTOpVljZaM7wr5M9XU5Hhoy+3TOGOOqNpjcs3wSgI
	7kshvCh82Y6Y8VGfsA8ZW1iiiVDv9ofDpArq48MQix4Y7Tm56uER9G/JLxTcUAVu
	8RqsVYBccQ5fX1XxSVlMWqOgQA0/QG/MInce2BJKY6ogASmsyBJcI0rLBU3Sk7OI
	QzzWkJM5Ll2gZ/ssQLhnoVhPpwaHCmM/SpBB4iYbuSabfBC5BR+rgmmbDqsbCtwm
	jEMCHW00zkH47guFYvv4YtXbFfhhcYB0+TpUcR3rouVQOZeLLUf4oriErOdvb3Gd
	17+25vTjwjByqJTWom/6g6k06vMCIf3HTCg==
X-ME-Sender: <xms:1DOFZ65iguQ7fecy9zC5S67Pt-yX7wmsEA9cDHnKEbwGu52UpVWfHg>
    <xme:1DOFZz50ipTrxPyS0GKBsWt4zp5nO8RfmgRN6eElnlUlhi-rfaUa8eYBPwWIFV_f6
    Jm0iUjAt56Tdn0lFg>
X-ME-Received: <xmr:1DOFZ5eK64dHzr3Zwk55HR2S1Hiyl6QVxzPFSX223tzwxR2IZIMKwAJb2JS-zWVOR07zcZXsrQtbxPTL-yYHXiShqP9J1A9lZUOcHbnlHnWz9jiW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihinhhksehsrghvihhllhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:1DOFZ3IY5Xfemd1OEl7ovFMwbOZ0_WZHV4fXETwz84XUChfmnMZRWw>
    <xmx:1DOFZ-KY3YHOH7BFxb6OOvZkXtMFAe1HPuEDe4mySL5Uu-k4-2lndg>
    <xmx:1DOFZ4zA88_cdIuUQte53aTV47S9rnDQYGyjbA56AuGjyxvFgQSjIA>
    <xmx:1DOFZyJVdOVcAiOdNqKwFpCsfxnfTss4KW63qKV6Ur4kYbYGNvgJkA>
    <xmx:1TOFZzGmupVGoax7HmpNg-WEXIeLCtRy_ydmygGFx9yoOT_YIBZhIQsN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 10:40:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81a69f0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 15:40:01 +0000 (UTC)
Date: Mon, 13 Jan 2025 16:40:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Wink Saville <wink@saville.com>
Subject: Re: [PATCH 08/14] tree-diff: pass whole path string to
 path_appendnew()
Message-ID: <Z4UzyFqao8Ty_RQb@pks.im>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
 <20250109084907.GH2748836@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109084907.GH2748836@coredump.intra.peff.net>

On Thu, Jan 09, 2025 at 03:49:07AM -0500, Jeff King wrote:
> diff --git a/tree-diff.c b/tree-diff.c
> index 22fc2d8f8c..d2f8dd14a6 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -129,20 +129,18 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
>   * and append it to paths list tail.
>   */
>  static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
> -	int nparent, const struct strbuf *base, const char *path, int pathlen,
> +	int nparent, const char *path, size_t len,

Sneaky, you also changed the type of `len` :) You might want to point
that out in the commit message.

>  	unsigned mode, const struct object_id *oid)
>  {
>  	struct combine_diff_path *p;
> -	size_t len = st_add(base->len, pathlen);
>  	size_t alloclen = combine_diff_path_size(nparent, len);
>  
>  	p = xmalloc(alloclen);
>  	p->next = NULL;
>  	last->next = p;
>  
>  	p->path = (char *)&(p->parent[nparent]);
> -	memcpy(p->path, base->buf, base->len);
> -	memcpy(p->path + base->len, path, pathlen);
> +	memcpy(p->path, path, len);
>  	p->path[len] = 0;
>  	p->mode = mode;
>  	oidcpy(&p->oid, oid ? oid : null_oid());
> @@ -206,7 +204,10 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
>  	if (emitthis) {
>  		int keep;
>  		struct combine_diff_path *pprev = p;
> -		p = path_appendnew(p, nparent, base, path, pathlen, mode, oid);
> +
> +		strbuf_add(base, path, pathlen);
> +		p = path_appendnew(p, nparent, base->buf, base->len, mode, oid);
> +		strbuf_setlen(base, old_baselen);
>  
>  		for (i = 0; i < nparent; ++i) {
>  			/*

Makes sense. And there is a single caller of `path_appendnew()`, only,
so no further changes should be required.

Patrick
