Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10521B12FB
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868411; cv=none; b=gUraBTZernoakHavXwSnGB+5iNg9PAYVk4PuorR2Rt59O2bCBGTiUguWupKYfYzDeSWsAbQPG/1ghHMJS0QWxttbz78WIKCA8WIbR1vWPiphTEdwFVdx/V6rwUfyd9G9Fzkzc2yWGDhiumPxaNwJg1PAMxJw+F5UdDIPtbaPnKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868411; c=relaxed/simple;
	bh=l1Ldq/Z+CTBWo9BVyF4cRivYqXce7tfl7fQZkbreIl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slWdZSJ80EJdxAp/7H6yWQRgMlveXO8L4UM9lvOk/vqOfGdP7BZkSG3W/UBwvt2Pp9JMBIf4iy+s3EZwEI6ZqZ2JQDbkGd5hPSywnpgUgooyASmzo+SUVsCwHzB1Ahht7WEJz0iSXUtsa2mR04RfCGXRWPL2NcNmFjJAtjCUGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nu9VtUvw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bfGqcJpI; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nu9VtUvw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bfGqcJpI"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA64C1140084;
	Mon,  9 Sep 2024 03:53:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 09 Sep 2024 03:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725868407; x=1725954807; bh=+2o4uON4th
	/mCeVnxmttaJf1BdgLZ4W31s4GE1G8zoQ=; b=nu9VtUvw0/w84gDZNlC9Qv/tA0
	ReqtSDZlOP/XdgdTBmXgVI+iJEqUnqhl1jFRmrNYZaw4bcLFQcybSH2sV4sOmHmD
	tfEf4QA67P/RVlBKDilkHEuW2qMLmrc4jLXCMKqTCIvmF8vuxueYEc4Pb7+j4FJA
	ZHvVEME/MLJKKqZO+OuWdFpG+ZKENv93qCu7xy0RS0Gq5IL5JBfVPGjRBbdxGfY0
	RBdp/k6vML1hINdO3U3ImepEHa2koL9cNkvmXur1c0j8CYfWz8eitPMTwtB55Gmx
	G5M1GBVYZ3EjqyhXbHhQgwOLH9T0j+4MyPOUjnsCBZ/aue/73a6WBHiA/HIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725868407; x=1725954807; bh=+2o4uON4th/mCeVnxmttaJf1BdgL
	Z4W31s4GE1G8zoQ=; b=bfGqcJpI6jL3lvm+JnujFfONs3IYdInTgilfdOi3uaMj
	jaRYPMGkOrdvjUZ0+kCR2aBh9/ZOOgcJdvOVJJeaxYAhXnH9kQ+wDGEUrjSYJ8fy
	o+siXZV+C1YZBDP0hr4sY7jgt7vWkZ0CG+iiZGJm/xS/XLZR1Bh/BX+7i2vRcNKk
	vKFDU2hTnR+dM3wiar+ck+rMxghfEAN304Pj+WWfczvLA9R0d6SFL5YV/Opjj0ie
	wRaq+FLx6GX34QsvQZpUg2gkoLQXs8YF3rG/rzNwrspDwwJ8NFGNn30lMHlDDIFf
	i02HQCBSanOFEfySEW6CYmfg65t1FIZoHQCdW8Zr5g==
X-ME-Sender: <xms:d6neZiT4Mw9NsgqL2Vkhq5jue3fxMoCanr-9tQJLodsm_bR7tGxV3A>
    <xme:d6neZnwbN2s12thIPHK9WWyZjA1D1jkzDiPIKyktPpHuEqcO47FA_TqcOI-qA1zgG
    ckS80Z9Dkmm9Cwjtw>
X-ME-Received: <xmr:d6neZv1z2P4bhbDGSrbT0I9xRkoJLWFfSXICYUhe1UlTGiRcT2ioAGGRmJQPuSCQO7KcfbdRsvkq9QdXtauVMiD-CHJw_FY4Y35arc0afhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiiedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteeugfegvdehleelueefveffgfehtdelvdetuefhveel
    feeffffhheevgfefueelnecuffhomhgrihhnpehsfhgtohhnshgvrhhvrghntgihrdhorh
    hgpdhouhhtrhgvrggthhihrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhs
    thhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepohhrghgrnhhiiigvrhhssehouhhtrhgvrggthhihrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtohepghhithesshhftghonhhsvghrvhgrnhgthidrohhrghdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:d6neZuAcfpIYuNAaqRx4yAn3ZoYdncmCL11CPhcrOTJHTIOKq7oBQQ>
    <xmx:d6neZrhPZ8h-7AjGrjUO1Yi-MlKlfXLfXbedACZWNK8CV22lDEH8bw>
    <xmx:d6neZqrdIrTf8WZNnnFeRvrtFRuunvQDIpfTftiq3n7S46tQLBoqjg>
    <xmx:d6neZuiuVD21HFj-Ar2yk5AlwTBgyJJXhvZ_XRWgYim0rQtbsLGalw>
    <xmx:d6neZsVVMAw36g9OK6OENVbmYyTrMBiODzbSIPFbTrqmAreBCBgzwpU_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 03:53:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 60aa8ea1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 07:53:21 +0000 (UTC)
Date: Mon, 9 Sep 2024 09:53:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Git at SFC <git@sfconservancy.org>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Tilda Udufo - Outreachy Organizer <organizers@outreachy.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [ANNOUNCE] Outreachy mentor sign-up deadline is Wednesday
 September 11th at 4pm UTC
Message-ID: <Zt6pbMP3Rpjy-pC_@pks.im>
References: <CAP8UFD10B4ROEjvP7MPygALuUFgyBQqZVhAjgSUris3cdiowsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD10B4ROEjvP7MPygALuUFgyBQqZVhAjgSUris3cdiowsQ@mail.gmail.com>

On Thu, Sep 05, 2024 at 11:50:20AM +0200, Christian Couder wrote:
> Hi everyone,
> 
> I signed up for Git as a mentoring community in the Outreachy December
> 2024 internship cohort. The deadline was September 6th at 4pm UTC and
> I think we will be able to change our mind later if we decide to not
> participate for some reason. So it was better to just sign-up.
> 
> I have also added a project with the title: "Finish adding a
> 'os-version' capability to Git protocol v2" that I am willing to
> mentor or co-mentor. I think it's possible to add more projects and to
> remove this one if we find better ones.
> 
> The mentor sign-up deadline is very soon too: Wednesday September 11th
> at 4pm UTC
> 
> So if you are interested in mentoring please sign-up. I think
> co-mentors might be able to sign-up later but I am not sure.
> 
> Tilda, please correct me if I am wrong.
> 
> Also please let us know if some companies might be willing to sponsor
> an Outreachy intern or Outreachy itself. Outreachy is part of the
> Software Freedom Conservancy (https://sfconservancy.org/) like the Git
> project.
> 
> See: https://www.outreachy.org/communities/cfp/git/

Thanks for organizing this! With the clar unit testing framework having
landed I think it would be a nice project for Outreachy to convert (a
subset of) our unit tests to that new framework.

There is still a bunch of work that I'm in the process of upstreaming
[1][2][3][4] as well as a refactoring of the macros to make them
typesafe that I'm currently preparing. But none of these changes should
impact how the clar is used, so I would say that it is fine to queue up
such a project.

Patrick

[1]: https://github.com/clar-test/clar/pull/99 (MinGW and HPE support, merged)
[2]: https://github.com/clar-test/clar/pull/100 (CI support for Windows)
[3]: https://github.com/clar-test/clar/pull/101 (out-of-memory handling)
[4]: https://github.com/clar-test/clar/pull/102 (selftests)
