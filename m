Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982071DED47
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061133; cv=none; b=q45m6oZCpdvYqVjkef1rJ3Cay/2YLmbpNpCLye6zQNa4Hv0glrVWaxtIYfAMkS8i9PbGiV9oaX1d9L0BbMnZNE9ylIhhPnFloBneyEyAedSLweU+SdRVOGpflL19zKDJ6HwgQt3UuZBT1dBG4m88JQ1v9NjQJ38aXRGDQbF5IMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061133; c=relaxed/simple;
	bh=PToinU6PKK7VJeFJdQg16kyuIoUSHHm877xAMFU9xjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGT4UK+ZMSL3TQnfKUD97PsFgu7jJnU/AhCkdf3Ru4RDwskOkrj+SuyjrFUt0Ap+REfkJfQSCqzEXWZyQeS7xmBSxu1B1WCtueQdp33T5Kla8GTWlyoikdLD3C1TMmTUKnGqfRIaNgQls7diBUpFV1g/7NYPYU6W77YruzpqOZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M86ji3R5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iqo8lviP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M86ji3R5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iqo8lviP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 53E7B254010D;
	Mon, 12 May 2025 10:45:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 12 May 2025 10:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747061130; x=1747147530; bh=6B0RnC5oh3
	udIwYfXoHF6zIogfoI8s55133DaN1kXnc=; b=M86ji3R5oxqZCthargdiRSihH+
	cZWiHXKBvLgQ662wFUYU98zAzBcMpHyBPw0cuV/bY+H9kPZ0lcq9GiOD2QE1NmaK
	IhkFh1wtzOd/GhhmH2d8v2upxX3jAfTzuSS6TzOfxi4hBESzoaGPe5PTh78H5uAY
	YEJLe6Tee/tOoxRiMxv8n5tuRRoxi9+luPopnn0ngVJr4crkH7CW4Z1w/3e1GXpy
	ykumwfzlD18KVDhOigeAIQkxb7hwLRWAfWw3pkXd/7w6HGJbjx1jewNcayx2U8K4
	6BYjvfbwK0lwqcqHCjrWkOY37NCkLOIwuRRJIW5i6OWteds8QTXJ6R7QwsRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747061130; x=1747147530; bh=6B0RnC5oh3udIwYfXoHF6zIogfoI8s55133
	DaN1kXnc=; b=Iqo8lviPPY8FwRQTZ8Qys7h5fYusoZH5Wb8ztcEQL9MNHkll01U
	S+YihA40aGRam+1Eu2YHPd1MyAXck6WEVVCAqP1nlOa8dKkkUeRY+8olu8rDRKlj
	5io65UH7A3cQo4xI87d/nGdjmk6RuRvD6OAQifdFMx0Pt7+1tqMd+i0LKorRHjmx
	3sg52W5ION/Ne7mXHukQJrdIQUoiS2Hd5eKuKevEjMa38Vr+23rKkgKhuWA+8oY0
	GjpsvyyPUO5yOgesFQgmlWczIEMj4utMF/l9MMVsG2LEM/79lzryFWqz9o/Ohpht
	HNxrDqGbpTGcCcY4UuetpL5zGKQIQx4jJBQ==
X-ME-Sender: <xms:iQkiaLEBsDn2ApaehcKZUzi22zM86uL6geZoYKTECoWRgM-2uVl0CQ>
    <xme:iQkiaIXalwaW343ENaKXdjO9_WdXFAUARQYVxT2QW4lXq4_xzxUPBUpjihGr1PgEk
    zu5yd5uR3GzKGqpqQ>
X-ME-Received: <xmr:iQkiaNLg9_ynUWQauE1gVEOSPYQD1Aa5eOXlMSBwDqbYAL4XExVGby1L7GXYEiAmLMzdlgqnQ7PEu4AP0o3P2t1TNX-MJFSKc4p9Gj1xbbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehmrghtthhhihgv
    uhdqmhhohidrfhhr
X-ME-Proxy: <xmx:iQkiaJHRAgw4p7pZrcE7KhxHSSXXP0R3L74E1S12gYmvseszqX9Lfg>
    <xmx:iQkiaBVFa9FA1rBAKO4eYP-0-4Pvc5On98bAqnSZK0W0OgUj6vQzNw>
    <xmx:iQkiaEPk__BWohlgMBvXdeZzTMND_BKkmObRqBuKVqWNiz1iWq9ZDw>
    <xmx:iQkiaA30aX6Haiv9JwSuhEw_cfWU2lI05g65ild97k3juUSN__UTsA>
    <xmx:igkiaHX_CAP5Mgp-mgF6m1PM6UYYi9UqCGIlNLTC_Tusr-4OOVQdIGS4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 10:45:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 38ee7fd2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 14:45:26 +0000 (UTC)
Date: Mon, 12 May 2025 16:45:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Matthieu Moy <git@matthieu-moy.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 04/11] contrib: remove "thunderbird-patch-inline"
Message-ID: <aCIJhfw8Am_T0Khz@pks.im>
References: <87jz6mo4n9.fsf@gmail.com>
 <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>

On Mon, May 12, 2025 at 02:02:43PM +0100, Phillip Wood wrote:
> Hi Collin
> 
> On 12/05/2025 05:05, Collin Funk wrote:
> > Hi,
> > 
> > You said:
> > 
> > > The "thunderbird-patch-inline" directory in "contrib/" contains a script
> > > to send patch files via Thunderbird. This script depends on the
> > > ExternalEditor extension [1], which seems to be effectively unmaintained
> > > with the last update being in 2008. While the extension has eventually
> > > been maintained in [2], that fork hasn't received any updates since
> > > 2020, either.
> > > 
> > > In addition, the script itself hasn't really seen a lot of maintenance
> > > outside of a couple of global cleanups. It is quite unlikely that this
> > > setup still works, and if it did it's even less likely that somebody
> > > uses this script.
> > 
> > FWIW, in case it helps any Thunderbird users, there is External Editor
> > Revived which seems to work pretty well when I used Thunderbird [1].
> 
> Thanks for pointing that out. I noticed that extensional the other day
> but had not got around to posting it.
> 
> > I think this script would be irrelevant with that extension though.
> 
> Users who want to post patches using thunderbird would still benefit
> from the script. It needs tweaking to account for a different
> separator between the headers and message body though. The patch below
> does that.

The question to me is whether we want that patch though. It is clear
that nobody has bothered in the past couple of years, so why would
someone care now?

It's nice to have this patch on the list so that somebody searching
for discussions around the tool may find it. But I'd personally prefer
to not carry around legacy code that nobody seems to be using and
maintaining.

Patrick
