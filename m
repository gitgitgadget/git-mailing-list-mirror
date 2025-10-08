Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A461F12E9
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931063; cv=none; b=dgJjLMXGEq5QXjcmzdSGQ9UNHDmx3ZDPv4PFuFq2mHGZZ6IKvkdF48lCVjPGhEAyHby4PsBkSOsppi27paVIjFIgxWcGob3ss6+Cw0Kkig4bpm2aEnuxQSs+OUSBdXrmcOf3C0P47KBCUusz0DaFcMzVgsnOppP8FnVa0xPf18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931063; c=relaxed/simple;
	bh=y4uB1rElhhHv8KP87IA2Xqk2+eimZK0FEiZHX/15EUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/6MdCf5Qhd4H0UP1xbcab7rypfdJSiJ7Oj0LIEXdpnHG8Upaeg/38Bi09AfUYPg8bzq5a1ynBQwOv6qva0ywm4KVOeSVp3T+vBtW4AVJBU5QFRHz2Onb3ZdaEWzxDl8MSKYVN0PMB5k2UbdlXuM4Ki2L/IW4YQm56Vifp41p8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f5X/Jt3J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMlF3g9v; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f5X/Jt3J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMlF3g9v"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0479D7A0062;
	Wed,  8 Oct 2025 09:44:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 08 Oct 2025 09:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759931060; x=1760017460; bh=7hsdwmPYbJ
	hMxHYnT646LLpy5GQFp+tZRXSSjuZyeTE=; b=f5X/Jt3J5Ly/TQJEbjIKVsjenq
	XUh93APBxQmbZfg7GJnq7YtHJ8NICKPxg1zKHNk4UsZz28ucmvK8SfPyDFBsx3+1
	tZoLTb8I2OnxPfH2Xehh5KjMBZe6YYCSAdbdMTSjGp3jcBd9XD/IPmWiEFkM99uH
	EATLoiFObi7MhLibRne5XqxgJm144+Q5S7F+TU1uJew+bs9aAuABtie6EZVUwNnx
	hQGqVTcezLAeACbcBvraE5Ibcv7ZjjVwGBUU6HXIkkOPJpZowA6nTjHyFrEyFjjf
	agCpinPeOcZ96oe/sK8Dl3jb8K9otQdmX/YjAVYYwu0he/f75GQ/9R5QyPHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759931060; x=1760017460; bh=7hsdwmPYbJhMxHYnT646LLpy5GQFp+tZRXS
	SjuZyeTE=; b=OMlF3g9v7sC4BkaHYLMBwkbn1mbUFc6JGiROM2bj+wLy+vMgeK8
	bHw0FEl45lHBsXF9llL+6QnWLKD+7ezJssRpsc5YYZV2jIlgX0nElJ+UT1auYviC
	m+Cat7xV9YQf1inYkL47OWOrF6NTjBq5EV8G4IKDa8xPDDt2YlPZZCfrJSa38fst
	GmMzAXCVtfl5WokYj1xVFRNpRONS+izp4wiTKbKRLA9JerOowohMMsRkNX30PCEL
	5ZfQMhrh9N1Tvbm+JqvqjDPDaD/TskYmXVaCW9GxD2l/DhfG35YignZ0fqIHCv/F
	1tNHOQOz3WR00f7/v6qkAKIFF56pTAvdppQ==
X-ME-Sender: <xms:tGrmaMzxbqa6Az10cPJIWkTfPkfw-v3OhTxRJvhIWjXBv1Ol5b2PcA>
    <xme:tGrmaGTbHTPMvSBHO0pE0Evt8YCfcQN1dDQ3Ji59Bp5Iktp905iGf2q_WBd8-NHPM
    TRJZiQiAiBw5qDnhg6yzva1pzAj1DrB80IBsSwYQBjw2ZgXRQ78>
X-ME-Received: <xmr:tGrmaL83S8OuLEaWVYO_GHAHpuloBtviJVWBLjAQni9OTFiteq0fLhC7R4TieZn-jNqWWYA5S6rILuxWeJED7-rFfEdxtEZ47jBQ9c8z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tGrmaFqfCunGDp0f8y1LIW1QAcZvBl2M_BJcbBCY5zuqNXeaq9CprA>
    <xmx:tGrmaAkzb6EH-Um6DgrVdv_eKHKObQNWsPThNjh3hSvfMLa52VIvCg>
    <xmx:tGrmaEK8FhyxFsIZH8vj_1D4RW79sxtszuJRSFrAJz-9kvAcuBy0CA>
    <xmx:tGrmaNwmPgfEZkxEQuSeDf5BEMec0LNtnVBpgy0GFSghwRtFaO_7-w>
    <xmx:tGrmaIgp868RvP0QyAteh5EcLDWFR9PLfSDMSL6pLZJcoFtDI6aqNDFk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 09:44:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd7c0335 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 13:44:19 +0000 (UTC)
Date: Wed, 8 Oct 2025 15:44:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] refs: introduce `.ref` field for the base iterator
Message-ID: <aOZqsM2TKv3g8lJ3@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-2-916cc7c6886b@pks.im>
 <CAOLa=ZR0KWkpB4kjFm2g8F-PK_LWpE20P21rmJGOLONCkfN7yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR0KWkpB4kjFm2g8F-PK_LWpE20P21rmJGOLONCkfN7yA@mail.gmail.com>

On Tue, Oct 07, 2025 at 07:24:01AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The base iterator has a couple of fields that tracks the name, target,
> > object ID and flags for the current reference. Due do this design we
> > have to create a new `struct reference` whenever we want to hand over
> > that reference to the callback function, which is tedious and not very
> > efficient.
> >
> > Convert the structure to instead contain a `stuct reference` as member.
> 
> s/stuct/struct
> 
> > This member is expected to be populated by the implementations of the
> > iterator and is handed over to the callback directly.
> >
> 
> Wouldn't this also add the burden on each backend to ensure we don't
> serve stale data for each '_advance()' call?
> 
> Would it make sense to reset this data in `ref_iterator_advance()`?

Yeah, that's true indeed. I was a bit hesitant to do such a change
though because the ref iterator is part of a bunch of hot loops. I'll do
some benchmarking here to figure out whether a memset(3p) would have a
negative impact on performance.

Patrick
