Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9C3EFFB6
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181448; cv=none; b=EqXvknUZuPkg5WV7VFmIJQA7cOkBDhSPxcEHktVG33y0qFx0qCHN1oOC2xAW0AeRC87aiVN2tjMVtM1cLM7yJGCOY0A5BPs/VMuKzxrli79rVSt11zwp207/JU/8I60g6IYmqkp1qnz0OEsmr8jn2FBI49/DqTgLw84yk3MkE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181448; c=relaxed/simple;
	bh=jEgmWyKg8BjopjI9WBZk5GL35c7WpVC57Pa2OuAwJIo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R5TqdSl32qEjWcvn3ntg9YfbY2WBG+qIPb2mi8xGMpYuy3D2uba/TYcIVJPbXHl24jmnDj14NlO1blYZ10fiONE1bT5R4sfgB+juW848skKQfJagsyLTdk5Y8cN3uTxoZvGt5jPne0L4XteB2eITRk4xzxK+Wulj0yzy8RtDWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hurrell.net; spf=pass smtp.mailfrom=hurrell.net; dkim=pass (2048-bit key) header.d=hurrell.net header.i=@hurrell.net header.b=UeCDJUla; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cz12jV6r; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hurrell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hurrell.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hurrell.net header.i=@hurrell.net header.b="UeCDJUla";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cz12jV6r"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AA96C1D00099;
	Tue, 19 May 2026 05:04:05 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Tue, 19 May 2026 05:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1779181445;
	 x=1779267845; bh=NOLC0byNEM89Eh3OyGzBPXZhW3zbeNibSGnCE0HL7qE=; b=
	UeCDJUla8CnXTrcmcUGtTd+2Mss42iJU58UiPllGyKguoSjAmzw5IzIrmHHyB2zK
	LJs5Xu2xvJtGCO71ayi1A8dGnSAWfYngvqJ3uEv1tQ4ynvYrdIbR8UiWp4D5Od3R
	xC1pK64BDeJwT88+dw8U7eD1ouF1h+ETRE837H1/xszIxmS/Qksa7ni5xSTWgxgC
	rxCr+R0tFSAlkxf9Jbuio6UafLaj0Ax/7H9LiHi4lKso+lyLwgyvuBnf+BCHJOxN
	gRE/egc5AtVqnhkwd4m/+Aii5X6Er/fLm2fZJYjfqAV0DT/+XoZncc9boEHgSOm+
	5fJm34fSCH3fLwgSVu9ykA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779181445; x=
	1779267845; bh=NOLC0byNEM89Eh3OyGzBPXZhW3zbeNibSGnCE0HL7qE=; b=C
	z12jV6rnDKXk0Z3LRpw/Xo3IiqM4GtYVi0GELfPAgRw3jsKxSwKsR0PV6X7vynPA
	KlYI7q7YyBMv2/KsSBZ0BpKXRuYlghV47AqneVsZfIwe8kIMP467qB9/0AJc7nPv
	RE4vYBIYrtGExF9sIbML0XWtiSb6kzxagwLdA+jvY1BTZoWFHsplU27sI9LFP5lg
	ADMFK+9Ki7sadm+aHMIBp6hFbAqtl77nOgOxLCqTBlkuoFS09FYTayPXlNmbCyPi
	a8jhsUsKzsBn6WyDUlXMFwONwiGXvZMl9wU7vBsBQqRvEEkID3U1momlXpngNgIt
	dMoxQsz4oLfKKeaYX4szw==
X-ME-Sender: <xms:hScMahlgGd5vQDFqvRp-pj0DrUXcUuO7PT4ch4QgtI_gjmYUiN4PNw>
    <xme:hScMano0v31NGKNzPYiZ1Tx1JmzpEFZln2d8qPQ6543vXtlVOZcGWYcVolPDV5kCl
    vQErRM2hrqPmm4BEBmVb9X_Qyx_RGqcNVGi9Refiv5IKvO_8wfQ6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfifhrvghg
    ucfjuhhrrhgvlhhlfdcuoehgrhgvgheshhhurhhrvghllhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjeeluedujeefudeludffueegleeitedufeeuheeutdfggeeuudektdejveel
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvghgsehhuhhrrhgvlhhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegvrhhikhestggvrhhvihhnvggurdhinhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:hScMauiqGLTBBqhTS9QHNx0w_WJziMsbEWOsfgRKqK19IC4R-noBng>
    <xmx:hScMamy4t37bIxm_GU3cGGO4GZsj35A_I5eY0YJGQbAG_v-FWOnQ-g>
    <xmx:hScMapIJ3BmvOLuwMBm_r7XoHPQW_v2QXsI3g4QfNV3FOgsnhpjKXw>
    <xmx:hScMalTAciwiijQnSfCWrPbUaZwxwqF2qoq_c1jfqx3yefRcu9Gl3Q>
    <xmx:hScMahIIx1iwjip5tOE6V97JK4pfj-0GkOBLRnY-2xzVM6RljfpAzU-M>
Feedback-ID: i12114735:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2AD722CE0072; Tue, 19 May 2026 05:04:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-iWxsR32d1o
Date: Tue, 19 May 2026 11:03:44 +0200
From: "Greg Hurrell" <greg@hurrell.net>
To: "Erik Cervin Edin" <erik@cervined.in>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>
Message-Id: <8f4b75d8-f875-434a-8fc5-06a708cbc53f@app.fastmail.com>
In-Reply-To: <agXb1SXKnA69L9ak@mbp>
References: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
 <20260508141314.GB709299@coredump.intra.peff.net>
 <c5e0a1fa-f228-41dd-b547-07b0ad6c0964@app.fastmail.com>
 <20260508175240.GA737125@coredump.intra.peff.net> <agXb1SXKnA69L9ak@mbp>
Subject: Re: [PATCH] git-jump: pick a mode automatically when invoked without arguments
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 14, 2026, at 5:40 PM, Erik Cervin Edin wrote:
> On 26/05/08 09:07AM, Greg Hurrell via GitGitGadget wrote:
> > -usage: git jump [--stdout] <mode> [<args>]
> > +usage: git jump [--stdout] [<mode>] [<args>]
> 
> The usage message makes <mode> optional but doesn't explain what
> happens when you omit it. Seems worth documenting the auto-detect behavior
> there too.
> 
> If we're going to teach git-jump how to be more clever about where to jump,
> does it also make sense to bake `git jump ws` into this?
> 
> Also, if this is going to grow into a proper auto-detect heuristic, it
> might be cleaner as a first-class mode rather than logic spliced into the
> argument parser. Something like:
> 
>     mode_auto() {
>         if test -n "$(git ls-files -u)"; then
>             mode_merge "$@"
>         elif ! git diff --quiet; then
>             mode_diff "$@"
>         elif ! git diff --cached --check >/dev/null 2>&1; then
>             mode_ws --cached "$@"
>         else
>             return 0
>         fi
>     }
> 
> That way `git jump auto` works explicitly, bare `git jump` defaults
> to it (just `set -- auto` when $# -lt 1), and the usage text can
> document the heuristic. It also keeps the detection and dispatch in
> one place in case someone wants to tweak the priority later.

All of those suggestions sound reasonable to me. Jeff, do you agree?
If so, I can update the patch.

Best wishes,
Greg
