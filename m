Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC11FA859
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438299; cv=none; b=D7RPigrOQ5M4oxCLS5Wt/4oDZpPTtTbDA0lI+LDXjG0PYIQr3sjZDElqenyDDhODSi/R0Kl5qi4bynmjq6tJuwDXKeIaZvOOCnhhD2H720w3l0mfH7z3sRUrnIhzzYnvUC9jHu5S/hXL9R9gnXFqcszGhRkwxq2weYKnjmcbFfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438299; c=relaxed/simple;
	bh=m7E41QmonE3Qvsp/1HR9WlSe4TyVvRbkzN6uBMQmLOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IakNNlSN3tMKtYv6HC7fKTibTu4x0piKFXNEMHfg2YFBhOIgYNjD616fdSIjrXIl+KAlUlKSt/OpEXHZQShL19AngpjZVW4+tua3RVyNzj0ubLrNBH+jjT6ZJ4v42P3xGqD8C407r3qrYP69nPWIaEempIz7BfATiEXnFvuWhdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tCr3yRYf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Io2WKGmo; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tCr3yRYf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Io2WKGmo"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DF4C311401CE;
	Mon,  5 May 2025 05:44:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 05 May 2025 05:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746438295; x=1746524695; bh=CZNgNViJuI
	JG7uMsieIk5hGJVMBHJN93KJBv0e+7R38=; b=tCr3yRYfqqS7ctMbGSEg84IWD5
	LegJqxtRK7JcujDdd62k68A7FT5rKB1jA4PY0H2jTx+bfjm5HqduwFlSgqESRTGQ
	27tIPnO3bf4ueDuxMYNhQsov8YK1ID7Vh7gfbXRgKhHYI89AjH4gZwLX5mtxSjyc
	o/zDENJRsXmm7LDjAHcqC3ovY0RDC3OFXrZ6IMkotpvSkp7HM8ArmASGdNgKWD/5
	qnA0rPuSHUOshXTOWd+PBEckWyJTqF0s6d3WYMsCN/sRe3GqJPYSl2Wn2lVp3Vyh
	UUXEtvFhRAHdSAIZ6zupEWaYHa65ve29sgz8ZzLQ5REM9xkTGVqf3SoncflA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746438295; x=1746524695; bh=CZNgNViJuIJG7uMsieIk5hGJVMBHJN93KJB
	v0e+7R38=; b=Io2WKGmoU8BnQmrVfVf1eThbgi5LzpoWWig+zRVxXR5Zxswfbuf
	yEwjh26i8T0SFQ3ZimRIlpogak2AoLvbIz2QccBhBn/CewUeuP8GLqE7R0AaCLX0
	MAJWdJoF0XFefQXCdO5hopNej/kK10I2bxSIRas1hKzosXFgpDwP8NWuBO6qr4SW
	zM9tNeDY17DYwWXUfBFI1F66R/TSOmp6PxRnPEsl1fs05PbvyekdcqCqG32pQR1+
	JkWCNf9YrDBOF+s22FKaKHGkwaKrFAstgXpIopjDyMfs0P0iv+Pt4/EfdCpWI/jh
	adYp5QD+p9q+P/4Nf+Xn0e4FkSDqjBkAG9w==
X-ME-Sender: <xms:l4gYaInf-duPy646kz_AsvLr-8fOHPQ69ibUdaBjtAcpoARBrs15WA>
    <xme:l4gYaH1fe1DvfLHBHMnetyxDWE2450GKF0yMfiVwn5aCU72wS9tIFchVE-zRsaQ6-
    qHy0tAHAPsDvzulZQ>
X-ME-Received: <xmr:l4gYaGpO7oB0ipMwdfgGMEyT0vZsXm5KVmf3jJKwpRpqipSpjEaSIc07a-us525jq-mlaBpXGQEUy7VfSaqqkIxxNbTWu2j66bWkGWKFveL62A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtoheprghrnhhouhgurdgsvghrvghnughsvghnsehsohhp
    rhgrshhtvghrihgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:l4gYaEkLhnojHrxoWb_DW_S9FgedRaPCn4k_OruYiXuSO3MYeMHXrg>
    <xmx:l4gYaG0oxoo4oAtJn2FRQMtsS3yFhbAtC1GKmoStsa9r16-GbyzHTQ>
    <xmx:l4gYaLvAE2pvztlebncLgXBH-PYgGcBQrMAB_C0PfX1QIM1YifGXFA>
    <xmx:l4gYaCWjkjJ7unZd8dVGNUjaqxQcmtK1qN0QQ1N8nBiimjkJsA-ZhQ>
    <xmx:l4gYaF4XzmHxyAOTK4zQuL3BjXgTX6d4A5wX6kLUZjfgQwMZZztdPqer>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 05:44:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e609218 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 09:44:53 +0000 (UTC)
Date: Mon, 5 May 2025 11:44:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cleaning up "contrib/" (was: git svn clone failed)
Message-ID: <aBiIlDh0XAokwHZm@pks.im>
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
 <3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
 <aBhZHA7av8bWH9Ac@pks.im>
 <5ffefc29-75ee-e278-448c-9124740d02fb@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffefc29-75ee-e278-448c-9124740d02fb@gmx.de>

On Mon, May 05, 2025 at 09:36:06AM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Mon, 5 May 2025, Patrick Steinhardt wrote:
> 
> > On Sun, May 04, 2025 at 10:19:06AM +0200, Johannes Schindelin wrote:
> > > 
> > > On Fri, 2 May 2025, BERENDSEN Arnoud wrote:
> > > 
> > > > [... talks about `git svn` not working in Git for Windows ...]
> > > 
> > > In Git for Windows, `git svn` is quite a maintenance burden [... then
> > > suggests to use Windows System for Linux (WSL) as a workaround ...].
> > 
> > I sometimes wonder whether we should move such basically-unmaintained
> > scripts out of the Git repository. They do a disservice to both us and
> > to our users as they create the wrong impression of being the sanctioned
> > way of doing a particular task even though they have only been gathering
> > dust for ages.
> > 
> > Many of the tools in "contrib/" fall into this category, and to the best
> > of my knowledge there isn't really a clear strategy for that directory.
> > So from my perspective, we should either rethink whether it is worth it
> > to have "contrib/" as part of Git, or we should at least do a spring
> > cleanup and drop bits that haven't seen any love in the last couple of
> > years.
> 
> While I am thoroughly sympathetic to the idea of cleaning up `contrib/`
> (which is a mixture of things that are quite well supported, such as the
> Bash tab completion script, and of things that are the opposite of
> maintained, such as `contrib/workdir/` that should have been dropped a
> long time ago since it encourages relying on Git's internals and has been
> superseded by `git worktree`), I cannot fail to notice that `git-svn`
> isn't even in `contrib/`.

Oh, right you are!

> Instead, `git-svn` is in the same category as `git-archimport`,
> `git-cvsserver`, `git-cvsexportcommit` and `git-cvsimport`, i.e. Git
> commands that tried to facilitate transitioning from specific version
> control systems that had been a lot more common than Git at the time, but
> no longer are. Maybe `git-svn` is not quite as obsolete as the other
> commands in that category, but they are all merely dust collectors in
> Git's codebase.

Fully agreed.

Patrick
