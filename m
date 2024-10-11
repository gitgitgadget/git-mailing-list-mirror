Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E420A5CA
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632978; cv=none; b=ILj2IrX6N/KxtQDaGakdSuiXo48wNt4N1MqElffodWXiozoKE5FGLgO1Kwnt0PN5sj5+BABw0dFPIMKf0/uWU361yCzP+DQU/2UZ0q64btCyEhCJ3bSbJd/bGgghS5B/VF231MmwwW+3ndZi+W2jioXfYd7824SJR3lqLjidz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632978; c=relaxed/simple;
	bh=s4eF7ydGBehs5abVg6JG+6S1b6NCl0f8OJn9v5oATtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS5r+Y+EgeT77NjXjAKJgCV3CJ+nry5b8i4hmeQ6HA+opXuhdoddvLTOXspr68HiEs7NC2Pwf35OZoFMq4j3iPCP7AnYac5O26eIY9Vx0k8xdsZqQ/Lr+qZ2dmylfg8+W2ufWCP3rOLY7WgF7TVFHNl65XHjWZ5/noAhG4y3rFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WKVgtv96; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9qFBWq4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WKVgtv96";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9qFBWq4"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 73D0D1380138;
	Fri, 11 Oct 2024 03:49:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 11 Oct 2024 03:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728632975; x=1728719375; bh=ukaMdO61PU
	Y9I19T0WCnHaDaZayDakNNOJWSP7SBJ5g=; b=WKVgtv96HYi8dqchgT4shB3/+z
	EayY6ORz0YDd7PWp1By06W9B7E/NhLjR9dAM7L2Jx+jhVTIl6LsCa0q5w+9zQeFB
	eUv7qyV3/j7KRmQmFtkn9tQjO2bex1ViwJX5D6l9q82e058m54zJ36R+mDHRB2HV
	KjbF914S2QT5nIYR3DDBNgZ2njKVbtFbEEVVhzGfKezsRj/g5jCZksrx+jH1+zgV
	JGJKfAZmboFgPQqS6VrRqC9P8s4C8ZFq3ZMf3giCyEl6TvZYwiQ1X1OFKtssvWL1
	RABlDyqpb4biBxM5Vp/X3nOtxVIKmseyXhlW6x2L6j+vWJcIUaOsvO2SdUbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728632975; x=1728719375; bh=ukaMdO61PUY9I19T0WCnHaDaZayD
	akNNOJWSP7SBJ5g=; b=i9qFBWq4k/vl6OL0IDAkNw8/7ESDZB0Bo2HgskqMCq1T
	6TCZZuBwrlE2juAC7Kt5j0oXo9WiVf0+oP322v+M5mmFEMUNgZAvp6E+q8hhAio/
	ZXCGbo1mAhmrKpPYU3xxqEtHJUfcYnib9yzKp6e4IkxOSa5Ne+fNGuU0zrFnjgwT
	G4x1J/M8j4j9vWz5VOXHFyD7edMeJPOJ+aQl20Wqaxuz+jzMoFS8rX2SsMzDj4yo
	idlIJsLy0dRRH7sJkIRFbd52yIGq2hi2Qjt2EaO4gOfrxe43/1nTg/AhGek9cgQw
	U6/lTedsR24RGqYm9tOVHyDWsutGp2SUiu9mox5R7w==
X-ME-Sender: <xms:j9gIZxIsKuDIo53S5QoSFDR_zF2qY9sbhjbh1foJS88YJ-4j49m9qA>
    <xme:j9gIZ9ILG9oysAxoWUS7xP1F8942v84lS4ki900NaP8iJPvfUUhMGGSIaC-rhRKks
    wbPWxTlBNkcgGKuHQ>
X-ME-Received: <xmr:j9gIZ5sMGyPmGH9Jk-uYIzvhzSjgbrcrnbqPEBwzbXW69LH4ArUy-UpjwPFY9WE5kMGLYkwXuwvtXimIQOZn51vJ4mV-_wyQtdnpxqLvBZMY2iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjeevudeggf
    ffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j9gIZyYMn43yK_7U9BwEdgM9_e4_BbApgBFzzU4GL14IBDb2KqFQLg>
    <xmx:j9gIZ4YU7pThKhH4p18yaQAOI-zUsdw3qqAGKDTMJqxrkrDMgvZ_Nw>
    <xmx:j9gIZ2C9PfB8NSlyxbcXv2xKn6dumfrxDeU92gzOiS-kvBnGm9SJTQ>
    <xmx:j9gIZ2Zziwn5Pf0uBLyMcbHO0lZuTvOipMDRX64V-D1r3QRB4CxM8w>
    <xmx:j9gIZ_XIVTTBry7n7JdNRkfjDB3XjeaHm8NokL33Rba8BWSPW60EuzLU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 03:49:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03135639 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 07:48:25 +0000 (UTC)
Date: Fri, 11 Oct 2024 09:49:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/13] git-curl-compat: remove check for curl 7.56.0
Message-ID: <ZwjYinN7oKSw2DIq@pks.im>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241010235621.738239-10-sandals@crustytoothpaste.net>
 <ZwjKTJye2OmQClSW@pks.im>
 <20241011073326.GB18010@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011073326.GB18010@coredump.intra.peff.net>

On Fri, Oct 11, 2024 at 03:33:26AM -0400, Jeff King wrote:
> On Fri, Oct 11, 2024 at 08:48:51AM +0200, Patrick Steinhardt wrote:
> 
> > I wonder whether we want to have something like the below patch to give
> > people a better error message in case they have a version that is too
> > old now.
> > [...]
> > +#if LIBCURL_VERSION_NUM < 0x073d00
> > +# error "Your version of curl is too old. You need to have at least curl 7.61.0"
> > +#endif
> 
> IIRC we ran into some interesting situations in the past where some
> distros had older versions that had backported some features. So Git
> would continue to compile, even though it was not technically the
> version we said was needed. And a patch like the one above would break
> those systems, even they'd otherwise be OK.
> 
> Now possibly that is a little bit insane and not something we should
> worry about. I don't have good examples of what kinds of things got
> backported, but searching the archive for LIBCURL_VERSION_NUM and
> "backport" yielded this:
> 
>   https://lore.kernel.org/git/4d29d43d458f61c6dabca093f591ad8698ca2ceb.1502462884.git.tgc@jupiterrise.com/
> 
> and I seem to recall most of the discussion of this was around that
> author and RHEL/EPEL.

Huh, interesting, thanks for the context! I'm not really sure whether we
really should worry about such weird backports all that much. But in any
case I'm okay with not pursuing the error.

Patrick
