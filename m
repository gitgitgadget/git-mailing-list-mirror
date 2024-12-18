Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3188E219ED
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533616; cv=none; b=XwOZ+oOWkPihqUmVS2p1fDm00WPea6ciUmoFNgctpNZE0BIWaj9Z7rgnOtsXfpfQEpQWNPgvT1L1wnMfWPcPFceZnMfEX6QpF07jlcJl8lpwO6ofw64U/VKnEyVR8iGtI5uwQiwZftyIGFFBHMoNs206ZiHVS0+NdpoqZXGR5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533616; c=relaxed/simple;
	bh=CEVUwqaJLJanNGSTxM3H8/5zWLPT5V8LXu0StMcH4IY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aO9gWJ/QY7dDwCiPkJPHIauuNIs3ee9jjW+DbPrTXVpJ4fAOCCAvYGEL0n67t63ySryS1Xza9D71caM+gnLWBRVyhpDNJNQCaLtshCUllXJXISrV1yPSWM9kp93sdP8rWKXy9Qk3nlVC734ajtM88WkyvKA3VPewn26U5BC09dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q0018bNz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OqkrUVge; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q0018bNz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OqkrUVge"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C53A114006E;
	Wed, 18 Dec 2024 09:53:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 18 Dec 2024 09:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734533613; x=1734620013; bh=TmCxKaPHx6
	014Tx8XefKgcKKmngjfvY+bf+4ghD/pV8=; b=q0018bNzIooGrox3H3qQR+3gO4
	2d2kiaNCjmeB6D+tWjANC4OagjogKY0nbKUP+WCTRmPSRazVR5Gm+kIB6/vLhMb3
	N+Pcl+OB+v9dUGr9JaIoUXFb1TX9DI4Oyp2s8jcnNyEM/xbtLeXInM7TD9Pal8ZU
	ujpueDNsZ4RkMVsmkOzkdM980lIzWwFe5cZOr3fZQEpelrBTdDvtSh8Iw8lRBL1P
	nfz7vzkkb7va6g7Nz+7rqIlxVhtOSmrEAp7TA8mCwBU2EC2swF/r/SA9xYno2Ek4
	QxoiuY4dHXgK+lthzoAjCEr8nlvHCqn25rdMS8YsX9td32q0LxalM4uncrCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734533613; x=1734620013; bh=TmCxKaPHx6014Tx8XefKgcKKmngjfvY+bf+
	4ghD/pV8=; b=OqkrUVge0z7ZQ+RFTq2PorNLTAzdcmpTg3GF2HyzF4eFLpaXbJl
	69/ZA4Mug+Ge50qbwCxvIWrp1b3ekId5b3JVk5JI67FQNkfqtAwplRtn24yWWgTT
	gn73jnsVVWRyZdfnozlxDLr07XZ83uUDY3WScpVpg88ezN6N9XvTVviMgiJ2L9K4
	1rjbJRm+1noldBXZ16aalIcdNVIe5mWxrioo+whptL64wy3K94GiTop0nhmK/cJH
	K4lBhM4ounh7fAKs4RzE0nYpgHe8+G9EQKx04yq1AWf6x0CqDCG2D5NIRJyjacmt
	sL+tKVKK268DlMcPQFWH/Dow/L1UC12DdDg==
X-ME-Sender: <xms:7OFiZ1Ja6oOnqmh5ROzcZsyQFq7uLdZCF0z9yfOuARGyyhuX4d_oVw>
    <xme:7OFiZxI9fF-cvgBJvBZBPSDXTb2MRDkR3TmC7MWLX_YpUdVkQ08r19P1hvc-bZN2L
    h-bqN5yGo4ONoDWUw>
X-ME-Received: <xmr:7OFiZ9uEvCY4zpIvwIt4g8s0pCb5KoUidKUjnJ7TLxDSlmCyaMELGbHkC_ZItzbU58AOX4QarSyPCS6vIza60lev6q9076JEDC-5CV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7OFiZ2a_aIbkjvR4LakacOnionR_rnh17rDwb8U74zYoOGaxBVeIWw>
    <xmx:7OFiZ8bm2niOqZXUfWoIr0CADZxxcE7ulQ-NYbun_QJg_t-5TKm5YQ>
    <xmx:7OFiZ6DC-BMFs8RbRpkmHhNuUausf4g5Vlog512LaKPWs6tOnhvpdQ>
    <xmx:7OFiZ6Yv5J1t0lMzUP2529OCQH6oFrCWKIZYISBU7yNMGHokjRIgrw>
    <xmx:7eFiZ7zzdv0sP6QzmSbtx-95zr6EPgFeAQYMkVjzOexz5o1ybCFxffUH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 09:53:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
In-Reply-To: <20241218113927.GB594795@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 18 Dec 2024 06:39:27 -0500")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20241213081211.GA1443203@coredump.intra.peff.net>
	<xmqqv7vnevjc.fsf@gitster.g>
	<20241213103850.GA1456983@coredump.intra.peff.net>
	<xmqqcyhtaecy.fsf@gitster.g> <xmqq5xnladwi.fsf@gitster.g>
	<20241216111112.GA2201417@coredump.intra.peff.net>
	<xmqq5xnj7fre.fsf@gitster.g>
	<20241218113927.GB594795@coredump.intra.peff.net>
Date: Wed, 18 Dec 2024 06:53:31 -0800
Message-ID: <xmqqv7vhujo4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> > I recall that the performance of attr.tree is not great for _some_
>> > commands (like pack-objects). So it's perhaps reasonable to use for
>> > single commands like "git diff" but not to set in your on-disk config.
>> > It's possible we'd want to warn people about that before advertising it
>> > more widely? I dunno.
>> 
>> Or we disable the unusably-inefficient feature before doing so.
>> Would attr.tree be much less efficient than GIT_ATTR_SOURCE?
>
> Whether it's unusably inefficient depends on what you throw at it. IIRC,
> the performance difference for pack-objects on git.git was fairly
> negligible. The problem in linux.git is that besides being big, it has a
> deep(er) directory structure. So collecting all of the attributes for a
> file like drivers/gpu/drm/foo/bar.h needs to open all of those
> intermediate trees.
>
> So I'd be inclined to leave it in place, in case somebody is actually
> happily using it.
>
> GIT_ATTR_SOURCE suffers all of the same problems; it's just that you'd
> presumably only use it with a few select commands (as far as I know,
> pack-objects is the worst case because it's looking up one attribute on
> every single blob in all of history).

Ah, OK.  So your "caution" was about the underlying mechanism to
allow attributes corrected from the specified tree, and not
specifically about using "attr.tree" to specify that tree?  That was
what got me confused.

If that is the case, I do not think the documentation patch that
started this exchange that adds attr.tree to where GIT_ATTR_SOURCE
and --attr-source are already mentioned makes anything worse.

Thanks.
