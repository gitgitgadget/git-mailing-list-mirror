Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B541F429C
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041539; cv=none; b=UanL+tkDtqu4Y8aug5bCgf2V0qYdYIyf+tDmBbuoYI9yjYMlYa5C5OlWcI1MeJwvbqtqgPe2Pg8QOFKwF7Z3wOZ6E8bCu0nqrTg8D7ix/eb14Hn3zepn9ZKIcvmDkFa9f3a3RNFfJcX3lwhkHXfZU7Mpv2ULAFy41xkGJTrIRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041539; c=relaxed/simple;
	bh=oblUx0hkhWRCFmybKrACQjb68/TXbeFSIUKRruzZ0ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdQaUbwb0uMziwFd8b2z2bSU/iYrFuUbEkUmY3lYQO6DgAQSY6zsD5Fy6v5hbwocFyaHL1hGU4BCBwJGtA5KFkZwNzaB+VG+ueH7hxgdiG0sv43hfUbU/JgHZzQRg/kyNU3cy3UeQKhRqcNfj3d0qt5C/QlWc2DcN/z6JDZgheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AAS5gtNn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LBUJg8L5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AAS5gtNn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LBUJg8L5"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CE0F1400162;
	Fri,  1 Aug 2025 05:45:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 01 Aug 2025 05:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754041535;
	 x=1754127935; bh=XYXEQikxMswy8pOmlJgdLa5p5OW4yPM5wpHUkIPmoMI=; b=
	AAS5gtNnOpmtb+W6gN782FQDitinIny7roNQLCenR+UUKan9g0QyjZ9HoJ89JTm2
	SMghHG5xKNwn6Y2Qll4s0qt+ik10d8if/x5+DXtDaKfgNTtr7NO9C1sw1zbZtZ9o
	BJLAxbJ4do0gKyrSNIWhrMHgTpnN3RrBg4dya9TZpp/ZplPTIMRqyjXHiFhWGXsD
	XdJHf9x839GOfb5ikPrK6BAgtwm1FMdpuE2rhTK1KGb5cTDKhR+QfpgSrW/j8axX
	ItAYN94oRaUbr0x7FiwII/R/Q7kcmaxpP2Sa6FLCgMHkFz/g/C50d3/WxqIpDeh2
	1COe/74jKj3UjgGxbk/vXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754041535; x=
	1754127935; bh=XYXEQikxMswy8pOmlJgdLa5p5OW4yPM5wpHUkIPmoMI=; b=L
	BUJg8L51/Prz1Goas347fK1762QT3i9Lu6TMKS3cAkYff0Xj1YcjFIATD/rP/Ex1
	V2lwqARCZYSArAnqd3Cs/okzmsmzvxRBvpgBDAXqOiYhEUn/sxFhz2HnY4KKEWdN
	0uSBQ8O/FQCYlu4kvlkXzkJlpAh5j83/7JbaSvgqoxS2DPTt9wNzQ6hnpLrRkWxZ
	68bNiugBuXDfY4Y9qoFj/qQUnmtjhidfKRKaJTICq8o/P+rKv4JUpoHQ38dyU7FM
	Rl7AAurJLvU8o5FRKGsfwW9Wy71xFjG1kmG+kdbKMD77O5reiOL2IulqE3pwxinb
	7s6fSvgFmXonYXoe/WR2Q==
X-ME-Sender: <xms:v4yMaOWrKQEpvaDU0p_yMCe2qPmS3KO1QqzEjv2G7HTL2xXyGHcBOw>
    <xme:v4yMaKzkkjDXeN3YxJourdWbPrPYjzanvscz1OsoBkIRyCO8sVHheAccTplNEbVbF
    NTkcS2dpQAyF2hu-A>
X-ME-Received: <xmr:v4yMaEMuaMYm8_r26AD0WiVTnavQidiZDH-fZS31pKLy6bKdhaTLUyEyQklHXSarQkTOf7Y3tHAaaN1aWgTA2kabU5TuVUmkYwXr4iOhmDBb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdeffeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeortddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeduteehffeguedtfeevgfethefhgeevfffftdevieffjeelueetkeetueejgeekveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmrghrthhinhesmhgrrhhtihhnrdhsthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:v4yMaD5idr0PaFz81dPw08Jn7AS5dII01SchWJIMK2ulQlPHEgdPIQ>
    <xmx:v4yMaNNza_rPBud0pKyIvUeTRyVDgXkEm92RbXBBVAUZnVrXBXYwXg>
    <xmx:v4yMaJmV6MUnPc3bjwQ-LDKx-9alpFjKrs-Yb6E8gEIeP7BZ5qBWQA>
    <xmx:v4yMaMQfTYMfOsb3-fKoCxOrXFUyPL6r-xEXVArjnMEbzwtHlHVpsw>
    <xmx:v4yMaMS55r3dC01SJWSHeoRibpjJ6Eg3T3XUYuV3-rhQkN1qa7ule-hs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 05:45:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 87065b6d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 09:45:32 +0000 (UTC)
Date: Fri, 1 Aug 2025 11:45:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] meson: Tolerate errors from git ls-files --deduplicate
Message-ID: <aIyMuUZaARaTpmOh@pks.im>
References: <69faab5-43d4-812c-90f-c518ff7f618@martin.st>
 <20250801075649.1796238-1-martin@martin.st>
 <aIyHoF70z0jV-sj8@pks.im>
 <226b2a31-6220-4a4e-d0bf-3ad80c3be9a@martin.st>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <226b2a31-6220-4a4e-d0bf-3ad80c3be9a@martin.st>

On Fri, Aug 01, 2025 at 12:42:52PM +0300, Martin Storsjö wrote:
> On Fri, 1 Aug 2025, Patrick Steinhardt wrote:
> 
> > On Fri, Aug 01, 2025 at 10:56:22AM +0300, Martin Storsjö wrote:
> > > index 9bc1826cb6..9b519e6eed 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -694,9 +694,12 @@ third_party_excludes = [
> > > 
> > >  headers_to_check = []
> > >  if git.found() and fs.exists(meson.project_source_root() / '.git')
> > > -  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
> > > -    headers_to_check += header
> > > -  endforeach
> > > +  ls_headers = run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: false)
> > > +  if ls_headers.returncode() == 0
> > > +    foreach header : ls_headers.stdout().split()
> > > +      headers_to_check += header
> > > +    endforeach
> > > +  endif
> > >  endif
> > 
> > Yup, this looks reasonable to me. We could have an `else` branch that
> > warns about the command failing, for example like this:
> > 
> >    warning("could not find headers: " + ls_headers.stderr())
> 
> This would work - however the output from ls_headers.stderr() is fairly long
> (if you try running e.g. "git ls-files --foobar", you'll get a 37 line
> listing of potential options); it's rather distracting for what's otherwise
> a fairly minor build configuration issue.
> 
> Using ls_headers.stderr().split('\n')[0] works and just gets us this:
> 
>     ../meson.build:703: WARNING: could not find headers: error: unknown option `deduplicate'
> 
> However I wonder if it's worth it, or if it just makes the meson file
> potentially more brittle? (E.g. what if split() returns an array of 0
> elements? Not sure if that's possible though...)

True. Maybe we can just not include stderr at all but say:

    could not list headers, disabling static analysis targets

That's probably sufficient.

Patrick
