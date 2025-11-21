Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6432F76E
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706789; cv=none; b=ucjY+HXeXnLysR2slHaekEY+MaoWqSfKGDx44WLgS8S8bIFrUW8prReO5f6EcNMnG8ordP2yrNwb8KkGU7dSKAPYzobCHRCkw3PUCPwmq5o9U9wOrnDcJXVs0F/Np33JRq0QOarFQLygUY6MJpW4wZhsTBdzEJIcRcFjc3hjI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706789; c=relaxed/simple;
	bh=0OypS10tNwJknUfS9462ROsRKQzEDzdxY5yIByh8jOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf/nwykzC0yjMB0YBDnNWNo9C8+ZLnrcS5EQyYtWoFP8duMUHmzSp31eZaXLfKViAdO8Gk9hpGoM2MH8EfzzhLQ4jhKFvSEkkES0dKOisjl72fAkNgqsekkY4rPYXmYgYKwfctQKJCUNOXz0IxbZkI/f0BO7SSbDz2LEtnhXl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LCNW8I5g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wXN65vb/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LCNW8I5g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wXN65vb/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0038A1D00198;
	Fri, 21 Nov 2025 01:33:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 01:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763706785; x=1763793185; bh=VBKepafGJn
	ydIQdW3djajmuBn/22KnwON2prmH/WRzU=; b=LCNW8I5gLXFmdUuNdPOZlaHF0i
	Gq9IacitKt2IiEB3VuRdZsL1wDtTFnhsOoT+GBEv5pQnOpIbs6jpbk+xpSOeUNbd
	Wrow7KWAqazJpF1OYC3w79tjAUg3GY3WhcXZ2fuMXTB8A6Pi69C5kzld3eAX6bUE
	w4qE8TK+cetJu9oplETR+TS89Eg46qFNA6OkcEMGQrKQLgOwQCIAnABuEd55/HR6
	HCipkfV/Qlmi0FFUhxZP5zlS4sFIWUvqCMYJs6mKhvznFto0L5KOZ4UqVUVJ4ft7
	4UQ857i/omjtwBwwtw8nxDG/7VJljNldgKTEjFx222qD/7TKLFHncR2aDm4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763706785; x=1763793185; bh=VBKepafGJnydIQdW3djajmuBn/22KnwON2p
	rmH/WRzU=; b=wXN65vb/DSmOJDcIqOUdaz+KlQxSh7ym5rxhjKOCPcrtzRN5GAC
	ZHjA+Pqn0dCkz4qnYUE5E5P+ubR2DssymmpeBG89J9CZ06ut8ruEiVCLJQsKFsIN
	C8GrgZ76hw9fisMHS8Supxy6YMm/2LYc83YENhtIoc8qKRuGscckQkATEwRn77rs
	vdzdNTB5fZZzQVgWDqMRvALT9MulpxXih9ZpWAbkzFnz4cA2UVJcJ84WPIkMpttx
	ah/Gwklc8aBd++hJZmhVWU9KYlOIHZM7H6Lgk+ox+Mw99G9xgeRtF2hnCIIyxFYV
	iNlLsgIfsZ7nOdvDLMR/sXlrxhsyedZlxbA==
X-ME-Sender: <xms:oQcgacdbyv0yxiCYBy6LLsB5TbYXVgoFhUyq5e28iWeLJh9WJGd0fw>
    <xme:oQcgaUN9peO7U_t4YlbLVcMNwpT52FNFL74_YymZEld8lZ0BvEUcpMVamzq0NTsx-
    ApXcuZe90siUOkvvuRx_AKMkdYy0qiAn6cwBSrIKXC0j77yQaZOFg>
X-ME-Received: <xmr:oQcgabJ9DWS9hTrYMAunt7JHVPGAy-z1QwtFCb8p5lCpGpJweuF7nr5o7gBC2eaA32Qh180mGLwGEHPrVmGeNBg5a3JE5cckV4_CtijYRnXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oQcgadG5nhyA8DlB-hXtJiZzEOl8eFiRH1KkjEIOAyFev-GfVs13Iw>
    <xmx:oQcgabRh-T63cjCPCE6PkDz8U1e-Bqia47vo-Y95BbtpkJoVsY_lVg>
    <xmx:oQcgaRE9fqW0jTGHmDDux3sWk_Dg0wxqRCAmBo2cuEalIm86yly4tQ>
    <xmx:oQcgaf_43cau8cWEJKBpEHWSyDxoTTbbh5pOSY7L4SFosRNRocQzdw>
    <xmx:oQcgaTN7y3abRxC-O-0lv-sWa8mjUQ_CciOjxKK_w1gv4DHkZlPdWuyr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 01:33:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7224c876 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 06:33:04 +0000 (UTC)
Date: Fri, 21 Nov 2025 07:33:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/18] packfile: introduce function to read object info
 from a store
Message-ID: <aSAHnduhZUk7gC-K@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
 <20251119-b4-pks-odb-read-stream-v1-11-adacf03c2ccf@pks.im>
 <CAOLa=ZQDqGLh3hrV6T32mdrb1Z-nrVh-zkgjgfoHJrmrTRSWFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQDqGLh3hrV6T32mdrb1Z-nrVh-zkgjgfoHJrmrTRSWFQ@mail.gmail.com>

On Wed, Nov 19, 2025 at 02:48:24PM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.c b/odb.c
> > index 3ec21ef24e..f4cbee4b04 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -702,8 +700,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
> >  	while (1) {
> >  		struct odb_source *source;
> >
> > -		if (find_pack_entry(odb->repo, real, &e))
> > -			break;
> > +		if (!packfile_store_read_object_info(odb->packfiles, real, oi, flags))
> > +			return 0;
> >
> 
> Earlier we would try to find the pack entry and if we did, we would
> break this `while` loop and fill in the object information. Now that is
> part of the `packfile_store_read_object_info()` function. So we simply
> have to loop until it returns a success.
> 
> Speaking of which, the loop simply exists to capture:
> 1. Trying to read objects from a submodule, so we add the submodule
> sources and try everything again
> 2. If its a promisor remote, we try to fetch and try everything again.

Exactly. The loop will be changed somewhat to also handle the ODB
sources. But that will be part of a later patch series that moves the
packfile store into the ODB source.

Patrick
