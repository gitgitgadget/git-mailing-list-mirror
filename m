Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B448CFC
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557297; cv=none; b=tsnJetdkgwA6J2b8fFyjYYrW4tSuMZZ/lY/PD9/7HK9RITwcuG3hL1xlaroO90CL+rKC3WEudOrQSTmmbOGtcb5/dahFiMK+0EQsimimq+R6HygrHBfyl7Vuh4+wsmyc2N9+J6Y1D6gT1SrVug0DvxyoqRUVeiFWZXCsJFfCuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557297; c=relaxed/simple;
	bh=OlN8SAC59h7uKk1Tm0098mk7DT7Gw/nTsG4EDn5Se10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO6Mf+E0wVk46fcLFQwIIBWMuOiuqfCc39AosLzwGYHD7e7tL3VY+/d8qpZUbcScM0X5C/E66ug2oiX/D2w0ED257PZckC5jrMS8yEXYP2wl17iH3ydux71vPJwpImBbC7NxejOuwWxDtbdZWzCWcH+Alx5YUgZmi3iw+/GvwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MBiVsb0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ebwq+2iw; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MBiVsb0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ebwq+2iw"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D1251D001EE;
	Mon, 22 Sep 2025 12:08:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 22 Sep 2025 12:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758557294;
	 x=1758643694; bh=S/3StshpQdn8V2qI6AC8VWGDuoEc8AzvqFIxGGZxXsE=; b=
	MBiVsb0erHkkP8Da5i2osIZFnbDfde/WcDIfNgtpXRxIefvYSOnr15xwpbJSxcCo
	cq6cLspOOmLiA1uGLNobi2g1rdikRUI8SK0YRw5wzPInr4Gwn2t1XPGqiuHwpOZb
	Qbaqi6jZMG9Oy9dhpwOi3mKRI8cm/gSgdrFdhwtMUBfRQrYa7Wc8swvp16WJj1xt
	RvZUjb1NrTdfwber8q60tPvXLTY3kX7wVXZf0f3iBkiEDWxpnJcv36FwXvmWTpwu
	hflBzY7wNQPk14r3UnHTL4VoHncDREJ61p0sKxbwyJxliuJ38F6RrW7mZT6ogwaJ
	uH/ngSpHeT6s03zV5vuluQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758557294; x=
	1758643694; bh=S/3StshpQdn8V2qI6AC8VWGDuoEc8AzvqFIxGGZxXsE=; b=E
	bwq+2iwAHsxZbZMuQaz9xHipCnGPuFlQWBBj5bSaJDeo/cf+R6pI4o7808mUfAGf
	j9vfCZH1prEv8b4UosC1NPpAMkC4HQO+C1yovsF5lGzNr7BntFmGW1iUe4qFW7Fn
	eaNcObVcX4gWDkwdNq/mE4/Q9itRTk3KViI0MUzVfVcDiQsgJeGdoQjLv2lo8cM2
	6xkSmA3lSRL4iO9l2ssGa8gm4M31HzNSC7Ofan/es9YO3gth/RfSqGzbPBTjzPz7
	gLqHVVOaZr5mkVX59+FDEavmqtmnipF3R7ZBUXQBfElNadPSadrDDjySxV9NQEqO
	DEB0mKgg+StGg01gvl+ZQ==
X-ME-Sender: <xms:bXTRaKN-tOAUY8ZRVbhD4gOEKhCvZ6m64xIpXOqfnr8vBBVcMYN9AQ>
    <xme:bXTRaAZVtqDFWeMqvNKHqWP3jIudAE7HLW7roetBUH7om91T9J262Onj3PAc_Bcj8
    dg0GBqlt68Hvk1SdDjiT0pxGwqokNO8OTz7_OkrXeohQJhOHyh1XQ>
X-ME-Received: <xmr:bXTRaOqfCwhEyJNDC5ouMM7LZPBJ0IkwVbgxseO2Cvqmx8USiwQOI7Zx6LJb7PODCbBNL_qwlnKcxH3Ii6qudBi00BgSIdn0m7kNwpLyIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bXTRaEbWIR8CmPNghsc3gVwUU7MtFp3EyUHWzJ1iDO48CL_sd-p0hA>
    <xmx:bXTRaGSb1E6U2HCns_7BdzNgzhtJX_JhzLIYcFWZ_Hzw7HOC5ScjWQ>
    <xmx:bXTRaL6C45arvhQwjkL42VVQvR5m0KAixokCSfT5zVIDIuWFLEzyvQ>
    <xmx:bXTRaLxoUF-1A2m1k_ItVqaBcbayBTMyt7H1FU_lfZ70hUn0mtfXlg>
    <xmx:bnTRaK2NlWuAmvTT2rPfbyHs3QnasMZg76HKIRlebQ9tu7HzrG265l1->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 12:08:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 619a8161 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 16:08:11 +0000 (UTC)
Date: Mon, 22 Sep 2025 18:08:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
Message-ID: <aNF0YJGxB4ZmociE@pks.im>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
 <aMpODEpyaaVhFMO0@pks.im>
 <CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>
 <aNFIozagGc0MoseL@pks.im>
 <CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>

On Mon, Sep 22, 2025 at 09:31:10AM -0600, Ezekiel Newren wrote:
> On Mon, Sep 22, 2025 at 7:01 AM Patrick Steinhardt <ps@pks.im> wrote:
> > I don't think there'd have to be major changes to the current version
> > of my patch series. The idea of that patch series is very much getting
> > buy-in regarding our roadmap and focus less on the actual build infra.
> > So the changes introduced are mostly an MVC, and I very much think that
> > we'll have to iterate quite a bit on it, but that's intended.
> 
> So long as you're flexible with the build infra details then I'm ok
> with rebasing on your work.
> 
> What does MVC stand for?

Minimum viable... candidate? I guess I rather meant "product", so MVP
would be the better term.

[snip]
> > >   * What should we call the crate that will be the new home for .c and
> > > .h files in the root of Git?
> >
> > We could call this something like "libgit-ffi", but I don't care too
> > much.
> 
> I prefer Eric Sunshine's suggestion of gitcore, no hyphen.

Sounds reasonable to me.

Patrick
