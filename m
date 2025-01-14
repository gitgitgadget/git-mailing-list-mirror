Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE09B1B87EF
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736837536; cv=none; b=mo4S8O0Jft5sqwh3zDmjcN75sp+TXvbNnK2xJpuAve9fR8tXcTb1iP2jXdnyyxabdW8JAXTjw7O516m7n/zXV8GOiok679MXrMNd3bFeTIW/xfHffS+xYJxUfyO93G558+ezlD6Ft3EUHMTFtIV01MM+ElCYLmXJndK0HadivFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736837536; c=relaxed/simple;
	bh=/kKSKxP3H45mi5Fl1gtaK3Pb76bj2gvtpVOYKud2nM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw+i5GR8kZiBY1ASL9ioJwTua8mNvee42rHkHnjAkEUKGunwm8UHQINmP2N+6gW5i+iJKtGsfpiMkPR9mEtBmDta5vryKq529I5URXQxA4ceoOek2Z7JesJg+P4wfJ4v+Xo8Fh7pZrAXH0Dx9Dxxne5oothnx4Ou7UYYIaNRw4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NzfkmcS+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5G82JMr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NzfkmcS+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5G82JMr"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id ACADE138019B;
	Tue, 14 Jan 2025 01:52:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 14 Jan 2025 01:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736837532; x=1736923932; bh=W7UEmmaB/t
	wWEmNMU6oP7/11pfCAKEMBu7fmuDVQeW4=; b=NzfkmcS+Vj3Ya3hPkAzJkXR7zt
	TRXt6cjtZyrv3Pj10HUqU6e5VVNehJdlGlJCF4V8rlQuwLP8aBdmtW8p9hMaHLVp
	xZOWJ0Op/ZwYcvN4pRGVjUaiAQg61ikgPKrcGqv+A+mZ+o56oq0TFlz6tCYz5jMT
	P0StHZ5zSpLX0zCFkeIKviI7FaOSkdG1zRfAZiYcNHTNmsjKLFzIyPO4VQBdaVvx
	PNuPa7z6bvlAFYOcsc7fe1sKm3okd8VhkBexCagqQ9TGc+ukgOwl2nXYJpqQlSoF
	/L0zSUDwKIXEWKUcZqVNV8iYz/km2Xexgm5r5/mYFfEKvkd17Crt+nmidHPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736837532; x=1736923932; bh=W7UEmmaB/twWEmNMU6oP7/11pfCAKEMBu7f
	muDVQeW4=; b=m5G82JMrZE7sLD0eAzqZBspxMSH78hQ7Fif6mkIOQp3oewbhBN5
	paJK42gC+gZz77EonuAooOcm2JEhDyXMkOyjehyFrZWqIL15cyV+Ip7x7+iZF3Bb
	vl6B5BXX1+NL6JH22oFRRGIFzIrqLIKQ11uWnxMvHO2kkk6M/1trkouMmrYkYHLa
	yv9VwSVoY1MudyqxVCXGei3i18TBwZLloJs/ZQELh1Pdb6MPlGgklWqiveFktyUx
	Qbsub0tMnyL5rx3SjmtdZ7VL9B2hU4HvfFqSt0tdYUSP+GtJCE6SKH8XFlqggFq5
	+VcVxcVw4fj/xElETA4bF3/A9QwrbjTgLFg==
X-ME-Sender: <xms:nAmGZ-MmQtygTkKedgkPg7aqPLD21V0EeEgKpafyqXCWOkt2VQ08FA>
    <xme:nAmGZ8-cVDKmxARiOIDFGAcQHl3nXckY42QCx4lDxmfsbZQZ2Mxlwxv7oEYLHc006
    QpECUGMWrcddwyqxw>
X-ME-Received: <xmr:nAmGZ1QWHXv_tG9p-1TxtxgIrPi8tfAowce3PoyqHMGd0JFjX_Ea-KFkoAFOQhuRLsUrTYlkXakBEh80VmlZ1JcI-0v-fpNgVLFG19EX8XlOPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehhedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nAmGZ-tlxT9PyLB6cdGGN_u7JEWgwi-YM_1o6sCo4J1QJMkahDE1ew>
    <xmx:nAmGZ2dLhXvqKZCATSFwdgR-5HK9pts1YGfQucwI-AMohdfBoaBQ-w>
    <xmx:nAmGZy1BWq8mh2E8QJ8e5sjQCmbel8j2YUmvSL9s5EtCdAdCcYh2zg>
    <xmx:nAmGZ6-_FU6OM5XcjsJ1oOcsB01RymlKJv0bpA5zSTD9q0_-HFKBCw>
    <xmx:nAmGZ26_Ru0PoIMC4VMT331a-AgDTmsX4p7tAXrd0j8M9Pcoxp1F3O95>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 01:52:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b384f31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 06:52:08 +0000 (UTC)
Date: Tue, 14 Jan 2025 07:52:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] meson: ensure correct version-def.h is used
Message-ID: <Z4YJkUg_DB0yyARs@pks.im>
References: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>
 <xmqqr056abry.fsf@gitster.g>
 <87bjwak4p7.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjwak4p7.fsf@iotcl.com>

On Mon, Jan 13, 2025 at 06:24:04PM +0100, Toon Claes wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > What happens if we use <version-def.h> to include (which is how C
> > standard tells us to do), with an explicit include path specified
> > with -I<directory>?  If it solves the issue, that may be a better
> > approach.
> 
> I don't have a good source, but for example Wikipedia[1] says:
> 
>     Some preprocessors locate the include file differently based on the
>     enclosing delimiters; treating a path in double-quotes as relative
>     to the including file and a path in angle brackets as located in one
>     of the directories of the configured system search path.
> 
> So behavior seems to depend on the implementation of the compiler. I'm
> not sure we can trust all architectures to do what we expect.

Even if we could it still feels somewhat fragile. The top-level source
directory gets added to our include paths, as well, and consequently it
may also be found via <version-def.h>. So things would depend on the
order of "-I" directives now. Which makes me lean into the direction of
my proposed workaround, to optionally inject an absolute path.

> Or, because I don't expect many people to use Make and Meson at the
> same time, do we not consider this an issue for most anyway?

In the current phase I think it's still quite likely that people use
both at the same time, so fixing it would be nice.

Patrick
