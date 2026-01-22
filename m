Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8023E3A8FED
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769064677; cv=none; b=jQ2Q9pGF4UlpIArKGrJxDfAjQs9cwFFArKXCA4sB5KrF8i/9dLs7YnB6+Q2S0BliMi3VufP16/0ok+cL8T+NmXoJ3E1JTNBoHnAFBNK+YnLx3fCjo/5MMXmog0aljkMvE73B2u2Cgi2paV3AyntaoDuArlQe2T+7A4o00y2ANOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769064677; c=relaxed/simple;
	bh=ZB0k9D0Wn4uQ6bIcvQFwUpndJRH/JLok7jAo/B6bCKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJpBYVWuCCA8xskg/MHvQ2lFbr80ueii17q0vh0TXMmQJi57z0tcGQdwkiih85zYztf7JXI1ZelJKV+ZmrB3AqYTbwVK+bC2zNQqfuPhhBCekYm7IEyUniJHj9XOhKKJhWWpQOzi0J77AbVAdjTa5jLnDKbTJalhd5Q2xtIz+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HNCjam4V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mRoUGiHN; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HNCjam4V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mRoUGiHN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CF421400153;
	Thu, 22 Jan 2026 01:51:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 22 Jan 2026 01:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769064664; x=1769151064; bh=q35KD5MwrQ
	jYtGVV5C5jDd+0796cnKgHgO1CcIy4Bd4=; b=HNCjam4VpKQs8LEi+Jc0GQeHM/
	pwjbk2sytoqUUtsSUTJzL9uoTMPGa5La10nBo/eyp5bT+MtdMhyxHhXzI5xUgoX3
	kMDwhu3ToVTA4sXT+QPbt7K/MJUG1kkcz4m/SWMtFjkYxvAL6i/Ku9ypJfqdiqMG
	OiAmwFb/qkVihzCT1ClfxjVRlUNlo5JTxBu1hA4RxzXsTWTINUOLJT9/BaRnfdz+
	wsRkwhDIVl8/W8ttZqvSmxwSpgQ1+10WXbf99kniFr4Wx/ryn1F0oqM/qE0VgCm5
	KsA0D+NxV443IUy4mlR7hWGHHe5FwGSyY7xloyWo0A11TDS67N8iCfJJZ45w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769064664; x=1769151064; bh=q35KD5MwrQjYtGVV5C5jDd+0796cnKgHgO1
	CcIy4Bd4=; b=mRoUGiHNJ9yeZ0P1Eh4ncRfbqURld/2e4gDWiLogiPHPFPxZDcK
	LtozptsbSd3p2UzFTLk8EIxwf/PJCf1Yq2iTkse9P/1h6NAKCWu9eg0j+8s0SqSv
	iFaYS+lvld9RLqa5ZEohixDfEqQui+SlgVQszPfGS/ZMmAh9KaYK8IL7NRzo0OJD
	oU1wSCvisgQhK1Mg3dYjiNNxPcTEQXABCUElkS7GP8L2toQfdBFcwlQ6Pzxo8bHl
	jXN2Ka2gr0asSWvnvZNAj+ImSRTJpcp/52LIDDdsUea22G0ohvZsZkF74M/O3n6k
	CQ8B5gz6/H64Kt5BRC8bUQKsqG0PckAN26w==
X-ME-Sender: <xms:2MhxaYzL14eWefuIYad4ytl6kWV-v1W_TPC_sdaXl7Th4aaFDv6RgQ>
    <xme:2MhxaTJZ_t_P7REAdt_mxT7tYeAvg4q8JsAFfmZc8ktltQKiD-uUQvbhfam4jgEw0
    3WbeolLVjKt-aBOh4RCqI1Mcjm1zCKOhirCBJEgp3sXcFzYsxbfdnE>
X-ME-Received: <xmr:2MhxaSp5mRx_f6PzU2jpUnMaX2nb-1HFM4axdC-Dmv7xDuJ7-6N3v5fPwhUfbyzJ-DuYC9cv-joNZb0HkuiukIjBfoyY183IC54RSU1ThNf1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:2MhxaSJ9jbR5DjvguDed6HZO52PEcy44axL9KeRi08Hv8LYowwQSRQ>
    <xmx:2MhxaXSQGAvVGT0KLXUDnQjAgN8yFOama5wzYks0MAx3DMaaoYBWFw>
    <xmx:2MhxaRsTKpKhZZMGYGcg7TpVvmYVQ43EI8MzpC14kA9iuH06m6Vokg>
    <xmx:2MhxaYasMWZShfGuwV-R_YoUYkIkne6aveDLcyjpD0YhZvBh2Aficw>
    <xmx:2MhxaerHSa_f6f1UROdnInSsjIxQv3YlvIQ_gAQhRP01I1a3WFxwSHOo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 01:51:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6069ff16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Jan 2026 06:51:01 +0000 (UTC)
Date: Thu, 22 Jan 2026 07:50:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/14] odb: fix flags parameter to be unsigned
Message-ID: <aXHI0vNArKiDCL-I@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-2-12c4dfd24227@pks.im>
 <20260121211128.GB723458@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121211128.GB723458@coredump.intra.peff.net>

On Wed, Jan 21, 2026 at 04:11:28PM -0500, Jeff King wrote:
> On Wed, Jan 21, 2026 at 01:50:18PM +0100, Patrick Steinhardt wrote:
> 
> > The `flags` parameter accepted by various `for_each_object()` functions
> > is a bitfield of multiple flags. Such parameters are typically unsigned
> > in the Git codebase, but we use `enum odb_for_each_object_flags` in
> > some places.
> 
> I agree that using "unsigned" instead of "int" for flags is a good
> practice in general. But isn't using "unsigned" instead of an enum
> strictly worse?
> 
> The enum is more descriptive to human readers (since the type defines
> which flags we expect to see). And it lets the compiler use the correct
> type in the few cases where it might matter. E.g., if you imagine an
> enum that defines 40 bits, then the compiler will know that it needs to
> use a type larger than 32 bits to store it. Whereas passing a raw
> "unsigned" will truncate some values.
> 
> I don't expect this latter reason to be common, but if we are going to
> have a general principle for how to pass flags, it feels like passing
> the enum (assuming the flags are defined in one) is always better. And
> IMHO just the first reason (human readers) makes it worth doing that way
> anyway.

I'd agree if we used the enum as a plain value directly. But in case
we're using it as a bitset I think it muddies the waters a bit, and I
had the understanding that we typically want to use `unsigned` for
flag bitsets like this.

I think the reason I'm a bit torn is that I'm not a huge fan of having
enum values that don't fall into the range of valid enums. It's valid C
of course, but it just smells weird to me.

> You can find this pattern in lots of places (try grepping for "enum
> [a-z_]* flag"). The ones that aren't are typically using flags that are
> not using enums at all (just #defines).

True, but `unsigned flags` is way more common:

    $ git grep 'unsigned flags' | wc -l
    219

    $ git grep 'enum [a-z_]* flag' | wc -l
    56

In any case, I don't feel too strongly about all of this. I'm happy to
adapt if there is general consensus that we want to use enums instead,
but if so I'd like us to document this in our coding guidelines.

Thanks!

Patrick
