Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741E184558
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209581; cv=none; b=tkLOG3Jr8Zgk9b/jjyFoxbGXa9pSVzjI32tkb4cuEnBraMHkARGxJ5+iUTECYodENBbe8kKy7ghHbzX/pv0EQ/w8Su2Z1I5b9kbKxSe+YMs5qE+jb1/2D2eA4tSoJy7+H3op+tc2RuGCrrgDRmw6ts1RkFQNc3izMh/w/IvlmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209581; c=relaxed/simple;
	bh=6/lU3LHbgOubZ8TNTIsWmYaIkJ0gq9XgDuWLFSjKvrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFj8D4UG9D581Bvij6h1UZmz3oBq/uV6i3yBOqEsD7+EHa//4JSu9WgxqdjtNK+PXGelgEaCBQzFCmnzHdfLUK4BxOlKCniNDQJK3+Nxiqm/6t/sAgvXOgDOYOA4za9+sFTn8A0Zet0YTRtLz5b5TijbBO1qKXY0rRZvxWyxrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q6LqscOj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kEE3PwPk; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q6LqscOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEE3PwPk"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CFED1140563;
	Fri, 13 Sep 2024 02:39:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 13 Sep 2024 02:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726209578; x=1726295978; bh=1qWcwL61aS
	+O6h64VDdPatObynCdlPJS6btv6KfMPSA=; b=q6LqscOjOx1drvvFvKc6E5BLKm
	LgqjJeEFc1LzksR67vUyuJrkNXBmL93aGXlcwCox/vahjpLyQDh6QKJILIKrRiG7
	5C1Ece4HLQZL07T6u8OkKn11fxPSjG8x5Ul4JClvuh/iDZ5/jEbx3WwgrpAISH+k
	1bCE7kzN6ELYBgkIs40P8JECyl6AUs68PPIUptFzTw8Dn/1fTaLJLnundedXd03t
	z0ukA4qew2pAs/CdtO2SfXQqOGkGdNm7pWvO/BfExLM73NbzQQqNkljP9iUnFIv5
	jSAcFvMsGE0a2i6vdWIeK2xNidHYme17aPCbxQr5bJjl/MrKK7INOkLqExJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726209578; x=1726295978; bh=1qWcwL61aS+O6h64VDdPatObynCd
	lPJS6btv6KfMPSA=; b=kEE3PwPkoa5Zj0iKb5lxY2R1eSu2lzJXOH+Ss5k8b++M
	gqs+uKrf26xZ+JAn1mdeFwiMRJRUAKGA6pHWWGiS1MFnCQ/w+pIl4g1NKAo3l+Og
	/LzhFmPOoyTwmAU6grkc88bbTH45/rNuXDqHk9Jl2UwAoz/+kKJ+HwBTqkqLxVi/
	qk9PST5cKlQKybmytvDso+xWDoP7NI+pk4YxjWMur7IkxGp+Bz8OSqM0qZIuxANg
	40Lj97IQ9LdRu7h10oJ3G4sihjfYO5+C9ya2uhoqbvqPW+Ry1ZXunzLo5aJSy/33
	C/F6J7kceRWxVYyKWU9DO8pjSgjiV14y138lYq38LQ==
X-ME-Sender: <xms:Kt7jZmjURxmT_C_L0jXDWiJ6qlQtZGSKR6Sb6CwplnZMZTavnoxTyw>
    <xme:Kt7jZnD8QJRXOmvpQTj64ZjdVd5Zn5w2C3or84R-SnMLRX3nC60whsrEolH91NnEp
    SVrzS4q0w_eBD3mng>
X-ME-Received: <xmr:Kt7jZuFzGFF70MXOpw0rzZPDDf1LBl8baJbOe9gOPOQwc40l-ofz_a71OSq2cO4sULRONXYkvvobmHLwZrSpogdpzi3rvNZ2K1iTvvvMz3pB0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejiedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Kt7jZvTo1LV3bs37g7m-4fPSMdxQdW9aKzhEr5Do_Zz1KkiRsYNbuQ>
    <xmx:Kt7jZjwsJkrQzuxsRQGccBGZfREoZeSz1N0V8WaDJzoUPrhahugxpQ>
    <xmx:Kt7jZt5ZNS6zzbOgZmmxdHYzb-EE4N9izS62EL-1iOrPXL-ApILI6w>
    <xmx:Kt7jZgxJumplpUAvoVoUGT12uMuOt7HlMBhUlwvJPKSpwROptFdMJg>
    <xmx:Kt7jZj_db9wkyKbx5gPDhB208u-a3WjRB3KFsmTIsZi-5WESOF43uzMi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 02:39:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f532c3b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 06:39:26 +0000 (UTC)
Date: Fri, 13 Sep 2024 08:39:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/4] ci: add Ubuntu 16.04 job to GitLab CI
Message-ID: <ZuPeJqOg2GFqqOxa@pks.im>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <00a9fe6b7d77c16c9fd6dfe746aacf9068a76942.1726206484.git.ps@pks.im>
 <20240913062113.GA1232933@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913062113.GA1232933@coredump.intra.peff.net>

On Fri, Sep 13, 2024 at 02:21:13AM -0400, Jeff King wrote:
> On Fri, Sep 13, 2024 at 07:52:51AM +0200, Patrick Steinhardt wrote:
> 
> > In the preceding commits we had to convert the linux32 job to be based
> > on Ubuntu 20.04 instead of Ubuntu 16.04 due to a limitation in GitHub
> > Workflows. This was the only job left that still tested against this old
> > but supported Ubuntu version, and we have no other jobs that test with a
> > comparatively old Linux distribution.
> > 
> > Add a new job to GitLab CI that tests with Ubuntu 16.04 to cover the
> > resulting test gap. GitLab doesn't modify Docker images in the same way
> > GitHub does and thus doesn't fall prey to the same issue. There are two
> > compatibility issues uncovered by this:
> > 
> >   - Ubuntu 16.04 does not support HTTP/2 in Apache. We thus cannot set
> >     `GIT_TEST_HTTPD=true`, which would otherwise cause us to fail when
> >     Apache fails to start.
> > 
> >   - Ubuntu 16.04 cannot use recent JGit versions as they depend on a
> >     more recent Java runtime than we have available. We thus disable
> >     installing any kind of optional dependencies that do not come from
> >     the package manager.
> 
> OK, this looks reasonable to me. I do think we could have our cake and
> eat it too on the Apache support if we added a GIT_TEST_HTTP2 knob. But
> it's probably not all that big a deal in practice, and after another 1.5
> years I think we'd drop this 16.04 job anyway (since it will be out of
> LTS then).

Note that we _do_ run the Apache tests, but only for HTTP/1. That's what
the "auto" setting does automatically: Apache starts up just fine
without the HTTP/2 module and thus we run all tests that don't rely on
HTTP/2. On the other hand it fails to boot with HTTP/2, and thus we skip
over these tests automatically.

Patrick
