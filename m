Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C611DACB4
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486744; cv=none; b=qY3pVgaWSS4svYmXo9c0nSRR/YRWh6moKfOFqxOJ9229oQmU5IMoVYi17MaLZu/Lr5H8lcUWogxHFl6e6a9v+HCu58QmjcySc88qvEU9KtUPasi/7MGZMCyPylZcyXM4YQhmJAUShZAGRP/s+RRGxCjdJTSwaEqYcLVP9YmrgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486744; c=relaxed/simple;
	bh=pcs8XzVtzLtcGh/N4K5xEouVTIj3qMZUSkIXmsaukd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s724Z+VDmL7WJ1+eYc0vrWGCCuALlTdCLrZtzr7FYii7d+F0SOvVLrtcV1ZEOwGk4Zx9BwtmuA+zz543UlB3DIA1kGsuO3MeRfyiUwj1Fho7WSc1cjrhZKQu1CmGcFw2fb/JfL+pLUNQ31xuQgM5LlBvzX+C72UfqbleOeybu7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=reyZImMr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IETuo8Al; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="reyZImMr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IETuo8Al"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17A8F25401E6;
	Fri,  6 Dec 2024 07:05:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 07:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733486740;
	 x=1733573140; bh=G0XeIWZ2IKOhrtuXiq1mBzY06uZ5kShMklalXBIW1Qs=; b=
	reyZImMr2M0tlSamVJrSXy8f4MrP3A7TdlYXroFXb3qehrdcp7kF2dCfYR1I/EEd
	5Zjwhr00Aj710uM6G5gGiz0V9a/bpiqZ2tPf6ZrMWOMNt+g0sIchIkp3ybp5t8tM
	VWmMFEr5LYzkWe9gcACzMtXykW5KT+HV3D8plTBqnJ0EnUNvVpxEay7zE7P9Zy+h
	2QvvzuNGDpdtRck7nHgVq0fjzuQPln7b8Ow46u0yEacmeEftILXXpltDV9ymtycO
	Y91tUkeGyqzlJHzZah9YcDCvpNA+qkmzOlT9QCTeJtnBahSeiAop7djp4K3ZBGrM
	RbtDUXxNvPbdTAzrx4tLXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733486740; x=
	1733573140; bh=G0XeIWZ2IKOhrtuXiq1mBzY06uZ5kShMklalXBIW1Qs=; b=I
	ETuo8Al3rXDxcnocizumSxKCKcxLi3rBN1nWipC56wegP0vY5a5LeZNUHe25kv8g
	c/U4Ju2JAv9qwv7zm66EviVGZgsNRwxZ6zM08NmVZfijgUCNALZJYx8fQcrhtbSt
	9AwCLF7cwCmJ9k9NlhM+TQq7xkLK1rQlYUuGWi9I9b+HAFbxcK1+UZfh+Tm3sx4I
	soTgYWpydVY0k1V5rwW1et09ATG/Ib2dRxgvjbmG/tp50GVWyjqW5nY9ah5WAQdr
	VvvXZ4Pm/U+Yc6h5UEa0w79krV61mZcHt33vuXzF/lKeSCji+btPNlSbw9WYUMAW
	UgsVi4e7Y/M9eyU3Ghf5A==
X-ME-Sender: <xms:lOhSZ_Zdgsd16tDMRjqWIGqTzB9FAhZtkLqITDXQtV-an7vNMigjjA>
    <xme:lOhSZ-Yhq03uv0QCd5WPQLXUI4AJf0Vchp0uDy-snOjCC4Rw5lzJ7V_k19R7nVws0
    EwNnoG6iOO6KWO8DA>
X-ME-Received: <xmr:lOhSZx9run1XsoD054pwtG90Zcc35tcqOuvKZcQ4Qr2eCZkphCMwXThuEOCmGk9vctYSe0N1DxbfQHGekmug7fwKORRg5EbGDp3R-ALhKVZe8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteehffdvtdeltedtteeuueekudegteetuddtgeeuueek
    teehfeeuvedviedttdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprggrrhhnihesvhgrlhhohhgrihdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lOhSZ1riFOxAvdsNAtEm3mcwZBIAGdZaE16TYBC6rmFmWau6COJ9ig>
    <xmx:lOhSZ6oAfTug39cERGKrRFnIoP_5rf8T4n0ghpX6r5q9QQdCrz_kZw>
    <xmx:lOhSZ7SgcCxFKHT08l6R4lfSdp33netKL0ZRPBH5x-ehICwinnq0vw>
    <xmx:lOhSZyq248yvUU7bIPF8WwEA0xIAWqLwQhCRGayWXz37f8pZ2BD5RA>
    <xmx:lOhSZ3DkL1UcFxP71yzzf82hSE5lGojvSKHqe92i964sxKUeUPJEfzOL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 07:05:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e50b9115 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 12:04:15 +0000 (UTC)
Date: Fri, 6 Dec 2024 13:05:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Aarni Koskela <aarni@valohai.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] object-name: fix reversed ordering with magic pathspecs
Message-ID: <Z1LohIVUyAOJvjW7@pks.im>
References: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
 <9c7b9090-8cf2-4095-8e86-2c85b6fe407f@app.fastmail.com>
 <xmqqcyi5vxbj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqcyi5vxbj.fsf@gitster.g>

On Fri, Dec 06, 2024 at 08:57:04PM +0900, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> 
> > On Fri, Dec 6, 2024, at 10:51, Patrick Steinhardt wrote:
> >> It was reported
> >
> > It would be nice with a hyperlink since this email is not part of the
> > email thread for the report.
> >
> > https://lore.kernel.org/git/Z1LJSADiStlFicTL@pks.im/T/#mae906ec74d5657e702165e29b90927f730280c29
> >
> >> It was reported that magic pathspecs started to return results in
> >
> > I’m not used to this being called “magic pathspecs” as a user.
> > gitglossary(7) talks about (magic) pathspecs as filepaths.
> 
> Thanks for catching the mistaken phrasing.  It would have caused
> unnecessary confusion later to "git log" readers.
> 
> The syntax to say that the following path is from the top-level of
> the working tree even when you are running the command from a
> subdirectory, e.g.
> 
>     cd Documentation
>     git log :/t
> 
> is described in gitglossary(7):
> 
>     A pathspec that begins with a colon `:` has special meaning.  In the
>     short form, the leading colon `:` is followed by zero or more "magic
>     signature" letters (which optionally is terminated by another colon `:`),
>     and the remainder is the pattern to match against the path.
>     The "magic signature" consists of ASCII symbols that are neither
>     alphanumeric, glob, regex special characters nor colon.
>     The optional colon that terminates the "magic signature" can be
>     omitted if the pattern begins with a character that does not belong to
>     "magic signature" symbol set and is not a colon.
> 
> and even though the word "magic" signature is used, there is no
> definition given for the entire construct, i.e. the pathspec that
> uses a special meaning introduced by the use of "colon followed by
> one or more magic signature letters".  We probably should add a
> sentence to officially define it, if only to reduce the need for
> exchanges like this ;-)
> 
>     ... and is not a colon.  Such a pathspec that uses these "magic"
>     meaning is called "magic pathspec".
> 
> But more importantly, the syntax that triggered this topic in
> 
> <CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com>
> 
> is *NOT* a magic pathspec at all.  It is a revision syntax to name
> the first commit that is reachable from the current HEAD with a
> commit log message, that matches the given patterh, i.e.
> 
>     git show ":/my message"
> 
> which is a (rather lousy) short-hand for a more general
> 
>     git show "HEAD^{/my message}"
> 
> i.e. <startingRev>^{/<pattern>}.  There is no specific name for
> this syntax.

Hm, yeah. I think I read pathspec somewhere and just went with it
without thinking.

> I suspect that "filepath" you mentioned may be something some folks
> (but not me or any other long timers) would call yet another syntax,
> which is :<path>, that names the object sitting at <path> in the
> index.  Because ":/myMessage" look so similar to ":myFile", yet
> they mean so different things, as I said, ":/myMessage" is a rather
> lousy short-hand for the more general "^{/<pattern>}" suffix that
> is less ambiguous.
> 
> Patrick, let's not use a wrong word.  This is not about pathspec at
> all, and is a revision syntax.  As there is no specific jargon for
> the syntax, here is what I would write, if I were explaining the
> problem being solved:
> 
>     Recently it was reported [*1*] that "look for the youngest
>     reachable commit with log message that match the given pattern"
>     syntax (e.g. :/myMessagePattern, or HEAD^{/myMessagePattern})
>     started to show older commit.
> 
>     [Footnote]
>     *1* <CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com>

Will update in v2. Thanks!

Patrick
