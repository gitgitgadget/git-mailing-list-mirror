Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B77225397
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768545947; cv=none; b=Tmv+6wq7wPrpH6yDZz+zTzsM1ZGzNm7QqFKxjsx7M1D+ICYLms/ARgKntjBrGagrsww9o63CyflmyEOWZ/BrQ6RxaYNweIEhrxmqfdP2IiAoKXN+Gbf59x4lg8v+3N9pSIxLm9lb70XYcsIfcTf6p0N9/5ZJD98l2o7Pw8ygRZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768545947; c=relaxed/simple;
	bh=rD+jj+4+0h0qWLIx3mKVCRwLbRCbz+Mj8r60fWwnjbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na8J4PEKA5fLuCvipTKcLU1TMopqJXoirgpVwhgmzz2BiLx4nRUFM7R/mD1D2r6cNguvWa05g11TaHu1BigcRIbKCBVRkCIJmqTGX+GqYPAGQpXAZHnSKvErRy4Pydfnl0fS2OVSRYFaZ5JpkRgTV8xa865tWXN2uKRXHG7UXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oeg0yCBX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FlNlACRf; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oeg0yCBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FlNlACRf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 26F797A0126;
	Fri, 16 Jan 2026 01:45:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 16 Jan 2026 01:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768545944; x=1768632344; bh=Kf6cb/JgmM
	/agmGwnShiPD1oeaZSruno/m/MbgMjKgA=; b=Oeg0yCBXIo7G48PCSkoyyXdkoj
	TxDKLt82IdDFZRCtRECB9E3sUjHx+Lhb/rXsg8mQ4ihY/IsVVlz7i3zRK5WQ+jgT
	lVkxbjOz0Tkovxa9CDPsuFx9vxxAuwe993Hwdv+X4Nk+2jKBEACVvGZgxM/IfcNI
	zGJ/i7TtD28Sc8WeHJ7bYoGWfi5aX8tvB2ThYA2ReoMD8bP6AN310odug9cT2D03
	hNe5QQR0fbKK75o94VCRTsn4Mvl1Xf2ccDFaXt2w0VhS1dsfPt9mjVaatGkNWtNA
	SchZkS9bpt0LLAiYWDOo8pZnAascw6Fgh154p9yC+OQb7vZYR7K0MrSmxNiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768545944; x=1768632344; bh=Kf6cb/JgmM/agmGwnShiPD1oeaZSruno/m/
	MbgMjKgA=; b=FlNlACRflUXcBm5LdyKWyCZyLrU2JX/Uh4AgUXRaP63Arka0ien
	pEmUcWlKUxRfWUoiw8hDN9PBh7Ngid1NqvOKtJfFtwr9JSf03Zlpddu0yvQJ66T8
	HYpqKhtCOdxBDp82ft+ZYNvl2R3LJ8VMS/3LWMJhn6tP0km1XjvE5k8gCmbgFMis
	4vyahtV10Hljn8TowGsBkhZl+CVVVAtqozS+SgM8dXoXLzPskg3rV7cjfHVz3DO1
	FlY+P9cUEe3AgilX/kkCWMtl8ivjdPoNSVJmrlKeMGdc7tg1BYFwB8i+rdwk/TZu
	P3b9ePLDwuTQ1QMcy0/OTiy4Gve6XkWnhqQ==
X-ME-Sender: <xms:mN5paVCFV596SCsiDsXUdgmPbtETd0-GdJEKe1xiUoXHKBO_KK0Lfg>
    <xme:mN5paWGDffL2gV-sEKHglfkRHeqhoMhMoH2HU1tgHrS5Wgzht4xPqUcK5ytT1AHxQ
    z9gfrnEMLR6J67xPhAf2QZ6bnjTr2SETsH1-aKAVveFv6YOVPAHLKY>
X-ME-Received: <xmr:mN5paUPrA8ZKPdFH8DDRx7IouYgFYxuPSzqqPy4HTFDxYbqtqoKfpHhr3jdMZfdJugfe2Vpb6Hm-LUeGiRVyyAazLlovQdlr8O_Gje1ROQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgeeuveeitdfgfeejgeehheelveeuieekhfehgfffheekkefgffefjeehffetvdefnecu
    ffhomhgrihhnpehmihhtrhgvrdhorhhgpdhinhhfohhsvggtmhgrthhtvghrrdgtohhmpd
    gthigsvghrrghrkhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtg
    hpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mN5paf4SWt6_GQMSYcaqnXTOkELfKoVBVXgxKA2Hdz7WD4MvD8ha9A>
    <xmx:mN5pafh5EuEK9YKdrv_FnlPTqhYJY9ckvJa2PQdQ1KUErem55k491Q>
    <xmx:mN5pacd0tAAfcr2KErTZ8aOdENs8H1VodK6DegQOimPuDlHiDkI-Yw>
    <xmx:mN5pafx-O3D-QB8evHFFoGwiArOZnTwM9lGm1NQKRnzFfMBYTy33mw>
    <xmx:mN5paYZtQd8GT-S0EfSecvt6DprK_lxrZsel6T_34_6ZnGuMmp-9WCmV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 01:45:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d73a3343 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Jan 2026 06:45:41 +0000 (UTC)
Date: Fri, 16 Jan 2026 07:45:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
Message-ID: <aWnekt4ESo0bKpOT@pks.im>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
 <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
 <aWD2x154F5f-c3pL@pks.im>
 <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net>
 <xmqqa4yeblsx.fsf@gitster.g>
 <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>

On Fri, Jan 16, 2026 at 12:12:47AM +0100, Johannes Schindelin wrote:
> Hi Junio, Jeff, and other interested parties,
> 
> On Thu, 15 Jan 2026, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > Is there any reason we cannot introduce the new functionality as a
> > > config option but _not_ enable it by default?
> > >
> > > That gives people the tools to protect themselves if they want to bear
> > > the potential cost. It just feels a shame to deny them the tool because
> > > we can't agree on the default.
> > 
> > Yeah, I like the suggestion---making it opt-in would have much less
> > chance of breaking set-up people are relying on all of a sudden.
> 
> Can you help me understand how these existing use cases (which are not
> actually in wide-spread use) aren't broken by design, given that they have
> no chance to ensure that their ANSI sequences go to an actual terminal
> that can understand those sequences?
> 
> As such, it looks to me as if they have a valid goal, but go about it in a
> way that is easily improved: If they want color in their sideband output,
> then Git has to be taught about it, much in the same way as bf1a11f0a10
> (sideband: highlight keywords in remote sideband output, 2018-08-07)
> taught Git to highlight keywords in the remote sideband output. That is
> the actual correct way to do this, not by expecting Git to pass through
> all bytes to the terminal without sanitizing, which is a well-known worst
> practice (not even GNU tar does that when listing the contents of an
> archive, nor does cURL do that, just to list two of the command-line
> programs that sanitize properly what they pass on to the terminal).
> 
> Given that those use cases are rare (none of the popular Git forges
> support this!), and that it is a security issue, I still think that the
> default should be as I proposed: To pass through only a small subset of
> ANSI control sequences that you gentle people already agreed should be
> safe.

I have to agree with Johannes here. There's been way to many CVEs
assigned to terminal emulators out there that allowed arbitrary code
execution via ANSI escape sequences. Sure, you could argue that this is
an issue in the terminal emulator that needs to be fixed, and that is
certainly true. But we are significantly increasing the attack surface
if we don't sanitize escape sequences. And even when working as designed
I would claim that a lot of the escape sequences can cause active harm
[1][2][3].

So I would think that we should have behaviour in Git that is safe by
default, not safe if you know that the options happen to exist. Because
if we do the latter, then the majority of people will never enable it,
and I'm just not sure whether it's a good idea to increase the attack
surface for the majority of our users only to enable a small set of
niche edge cases. Doubly so when those niche edge cases can be made to
work again with an opt-out.

Patrick

[1]: https://cwe.mitre.org/data/definitions/150.html
[2]: https://www.infosecmatter.com/terminal-escape-injection/
[3]: https://www.cyberark.com/resources/threat-research-blog/dont-trust-this-title-abusing-terminal-emulators-with-ansi-escape-characters
