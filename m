Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90717A318
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814721; cv=none; b=Gl4CL2ViiAWGE4unPX18mmw31RuMbDQY9Eq9SCj+jyIB7+NRdp92PuV1SGl7KhoCS1ep+47yrnpT4wGilkBmoTiwV4Xw+dTn78Gq8ag9LMIxPMAwsyCJUy1WKGQtkkfSTpbv9XncGgtfu5OVNTc7wHmDWaTU5gyJ9itmKGtm/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814721; c=relaxed/simple;
	bh=RTvVphHyiOY/v8TLNJMIwXAyJrWthCnYI8DP8gMocKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+sZwaPGWbx/Bof/ym9T0Iv+iiIqFSacapbqW9jvsFe+LUfFpzAuIuOm0qgP7lrQo9Pjpyu/tUU3DcLE8Lo3z2omTiqU/Hq6zgWKHcLof9whjrwuAOcC5/oAEMYlMfS22l+HCr5hKXAhdCh6O+5XD3gl2D94u3FfwubxucgVdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WsEm8eeS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6A/owl5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WsEm8eeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6A/owl5"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95B66140018F;
	Thu, 30 Oct 2025 04:58:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 04:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761814718; x=1761901118; bh=mxSBCveTPB
	bA7O8lhSIPAWRfhRnxuZLj6Ut6DKsjMS8=; b=WsEm8eeSbUpVUOdVcBjzYITBL6
	VvwyZDjkugAIzFQBgd0r0n+D7nTtujslgpenDPsuhy4z5gDkY2mWLKoGpOP4D5g7
	As9Mf3yVebbBwR2hOOBEyHUNbXpsMpreVEhixfZL2kCf84pPuww1yFoB5y7HJszE
	QSbZjQtFV1r3s5DdamXGMQNIuQrt+IdgPkUGrgK2Kh6wH+jF7hxmWnRFDbLVeQ9B
	kn7m7QW5JJlmqiFAwPBOezOybbpzmGW4Vus19vD5Sw44h9Ek/L9q0d3yUNqPd0si
	muR/iiDgx1oiBnf8YF8HfvkR4LXHsH5wH0pqlE9xLBjO4XoxGt4JkU83vbnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761814718; x=1761901118; bh=mxSBCveTPBbA7O8lhSIPAWRfhRnxuZLj6Ut
	6DKsjMS8=; b=E6A/owl5w6LOT6OFRVTAlx4wUIivD7Qao0u+/SUg1T2hocRlI1G
	rw5o+o2dFSzMfgpiN/vQTaczyvcKnOlMtSept/0l7zKXljemrr1wVpRLOLSI5gHe
	fHLu5xg75cEJUNecVV/EGUykger0UC4GImLVsAv7BVyMamOgmJIh8gStoFgOExCo
	fF8MK0t4T0cI1wuZcPYMuSkT8tQ2YAs/WatfCRgL/qd37AQs1Z7VgCzoXQ7WEjdt
	Uo4ex9vPp27uLfpJ6X+M6H+3Q1jyliIr68pfRV/F3LUVOxmpfDKFLwZbMYUw1xtc
	hpdupYezi7dYSmxOfCO5WM6qyu93XURssqg==
X-ME-Sender: <xms:vSgDaQa9nL_C4ThYfbaagmPB8y2siEg73FJ80xISvDDYkwizus2yZg>
    <xme:vSgDaSagRkBXKkLGNnUcIv3I3hq-zLLEDaRTDWb8chFJxt1p3jAO9D4eDgpHkkqIo
    pcY-omKcmVnEcgSFmFjzlnwkWckm-MTDg2IQ9SONY9wHpJ2BeV3LA>
X-ME-Received: <xmr:vSgDaf9h5tbl60zVJzzXATOCSm3qyhppBlIUMuq5dXfPjajSfS0hMgjDNdKvuK_aNutC1GcpHs_u8XNtzjZ5R7B1afwhb94QIiu8Hec6Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehtohhonhesihhothgtlhdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vSgDaZjhVs5hDAR44mFj64EcbCfj37ccwVUKYqnLWFDy64RVOeikfQ>
    <xmx:vigDaXfTDV_7UfUGuRufJE2DvTfPhe1jlMFFrTH1hKJZCFXrj0szRA>
    <xmx:vigDaYpBKlf52ZmmIAag3MXMIupFGSzTVfwXlOQeu7bQ9Vw4gZ7jbg>
    <xmx:vigDaUD3ArNmlk8epqbFkG8-gprOFBH6UwcF9x6XhjgbrzLmhxcZIw>
    <xmx:vigDafdcOS15WA7dpJQtQzKPeP1Q3hqq34Wh4Evs02zNWtz9WwnefxzS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 04:58:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a91408d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 08:58:35 +0000 (UTC)
Date: Thu, 30 Oct 2025 09:58:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/8] http: refactor subsystem to use `packfile_list`s
Message-ID: <aQMotPUNIPUfa6U-@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-3-1a3b82030a7a@pks.im>
 <87h5vhrdjq.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5vhrdjq.fsf@iotcl.com>

On Wed, Oct 29, 2025 at 03:24:41PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> diff --git a/packfile.c b/packfile.c
> > index 4d2d3b674f3..6aa2ca8ac9e 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -121,6 +121,15 @@ void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
> >  	}
> >  }
> >  
> > +struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
> > +					  const struct object_id *oid)
> > +{
> 
> Why does it take a `struct packfile_list_entry` and not a `struct
> packfile_list` ?

This is because `packfile_store_get_packs()` returns the first entry and
not head itself. It makes the interface a bit easier to use going
forward.

Patrick
