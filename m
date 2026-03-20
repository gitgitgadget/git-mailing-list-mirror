Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6352DB780
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773988817; cv=none; b=Nb6BPAqpyV639cXbspi5+7PC0mguFK9WnT638zAfk7upMfXTmj62MG2CWpqVpUmy9OBAtNJl9q8O7Xuw6y6taJqr4Yhlf5O3lcYsm8pBHErjKohFnKdQZHtMRhp62J4jlmaCJFQ/UjS86q7jyhKqLq3vIBTs7Ro4v70+Xyfa/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773988817; c=relaxed/simple;
	bh=onUVY5ifA03Lqd+ZLEYX6SHS8Wes7leYzZOJOMivg/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYBwjZvrqb+fqjNLDBSL3BsivCg7oK2i8DFV5V9tp1crxrkZEEjD+gRes1Gqg6GYlQd70zUffjOo8tsUZ051/3uKwhVEHANser+4wWktLH12oXl3lb00a4Pps5R+wOrWBwgq/MouqF0Ek32Flsj1q3tHclWFJdoDe0D3FW3VeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KfcLbdS1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q7LzmgMs; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KfcLbdS1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q7LzmgMs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C1EA6140005E;
	Fri, 20 Mar 2026 02:40:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 02:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773988815; x=1774075215; bh=gAy3CEKNWB
	+600rbtpHhPiB0vq3vXTVjhB50iqy3dx4=; b=KfcLbdS1xt/Lo1VuS95XJphdpt
	rsx5e/eNuKoeE/hnYIRcq/286UZR4gYH0oFsdftLOPxxd5FaWLIJRmI9iLVvQxNM
	cTKXzxWJIXjniaD5PB4SXnOIPLpL6itUm36BpsCe/eueGQfIbgE5+u30h7UGuHDo
	7wQIEh6xeqhQ4ffN7B1BwMnRjHMLxoF1jonB/1zaMoikthghQNq3oT1mXvncJnPt
	FteLQv5pY4ypj9hBiCD51xXbdGFLV74MsyY7iMJtAJhLEChw4U1OQ2YfPMQdzUs3
	RzIjiANd3XX1b8LQB6LlA0VhKHtBcxM8kxKgvCNVyb3XOB4ofCjmiSVKsQLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773988815; x=1774075215; bh=gAy3CEKNWB+600rbtpHhPiB0vq3vXTVjhB5
	0iqy3dx4=; b=q7LzmgMs58tmznE5mrt6b3k7rojsSMYHlgt/DlTS7ZGuuf8AhkY
	zD1OlSLoLwrnU7uW7jpVgcfnah77F/pDcusAtd79OtDMamL0EMzHaeATpzsgkfFe
	e6jLtHkcUjrXMvSG2V6RdBVMn9VQ4sHYqUVgKl+9uWlvIuaZ0LgxZDNkH3l3TYTq
	3mDfULqTJEsbI1s2p164nwEpn1XpCmMo8tR5bbc38RV/dTKfV7fmCP2rz1eKWJFN
	l5L6ttT5qkiMQZxCopEU61E8gJp0HQIq3nOP8jjSkIE3fkSoUgN8QQRCnWAEmRZD
	f3f5D2lUz1ts4b7R9V1S/yymIDpv4Nkgcug==
X-ME-Sender: <xms:z-u8afcYVraEbP03YYlQf2JbH4rnQ4GG82ydwOJlkky-OZLvvXlTKQ>
    <xme:z-u8abMqXgtjTLM96sM45ioOh8MFNiV2oVOuvTWkGNVFRtgTAD7royXMcn0RlkAL5
    fS1tdqh3ToinamiXMotd_0OnPnKb-CzvYmpEOTGjYjAe-o5fvRZIQ>
X-ME-Received: <xmr:z-u8aWL2wTwgBGuu8KmdUW44uEOBBlEonmujDLVRhQeQWrvRUH3hFxkOft43jpNJfvqsjLaFFtiJVrwVhrjPzl3HXsGA0TVibvpRkT3D6hv_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeludelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:z-u8acE8JGgr4G3kWGECKCgBJFBbzMVgrKyBTPDDWAMgJDpwUMw4OA>
    <xmx:z-u8aeTBtS9oE_30pL-L2lMZ1wnWje2MxlRaL0Qnja7Laf05OLIjyA>
    <xmx:z-u8aYFRXrDXDmDyJLmxGRbhjECivw4bLkslZkAV4aJ_evHFL-Zj9Q>
    <xmx:z-u8aa9M47FATYAXkjU3910ezaPf16CwQL5qG5XB8H51IxG5kFmiWw>
    <xmx:z-u8aa3uVUS7Fnknh0qoZnjoV0RyFHYM5qzKyu4LFPPSMLCEpozcaS4w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 02:40:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bf71c991 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 06:40:13 +0000 (UTC)
Date: Fri, 20 Mar 2026 07:40:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/14] oidtree: modernize the code a bit
Message-ID: <abzryk0qjlbvy8OL@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
 <20260319-b4-pks-odb-source-abbrev-v1-1-5ddebad292b0@pks.im>
 <xmqqeclfn6nn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeclfn6nn.fsf@gitster.g>

On Thu, Mar 19, 2026 at 09:08:44AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +void oidtree_each(struct oidtree *ot, const struct object_id *prefix,
> > +		  size_t prefix_hex_len, oidtree_each_cb cb, void *cb_data)
> >  {
> > -	size_t klen = oidhexsz / 2;
> > -	struct oidtree_iter_data x = { 0 };
> > -	assert(oidhexsz <= GIT_MAX_HEXSZ);
> > -
> > -	x.fn = fn;
> > -	x.arg = arg;
> > -	x.algo = oid->algo;
> > -	if (oidhexsz & 1) {
> > -		x.last_byte = oid->hash[klen];
> > -		x.last_nibble_at = &klen;
> > +	struct oidtree_each_data data = {
> > +		.cb = cb,
> > +		.cb_data = cb_data,
> > +		.algo = prefix->algo,
> > +	};
> > +	size_t klen = prefix_hex_len / 2;
> > +	assert(prefix_hex_len <= GIT_MAX_HEXSZ);
> 
> I know the original also used GIT_MAX_HEXSZ to clamp the length for
> sanity, but because we know what algorithm is in use, I wonder if we
> want to use the limit more specific to it.

That assumes that the passed prefix OID actually has an algorithm
attached to it, and that may not be the case. We could initialize the
overall oidtree with a hash algorithm in `oidtree_init()`, and if so we
can then become a bit more thorough with our asserts.

But I feel like that would go beyond the smallish cleanups that I'm
doing in this patch.

Patrick
