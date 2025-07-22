Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6F2DE6F4
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186885; cv=none; b=CnFbjrNTnxcXx+x0qbGTGTXvTXBu9c4TqGR3D0czIeGq2jqntCSOcUYzV/kCkMBBIeFaLFxqWSyydYnCAcFvpV7Iw4LmWkmCYK0hTvwnxVgqV+UEOe0cj9IbweTrQ1xgRO88LX/Cw7+QHWJ3RijCnzrN/57dJ2HARid8l0UrOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186885; c=relaxed/simple;
	bh=zQnTAxCh6qEp2IS3D+dV3x0kBfHzwJk9xF5a4CgmHdg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfP/Qt4qPjC4HSiHmQECZwQUz5qKB6M8oXj6Q43Rm3Y4ANjv66a+OrMi47VSepVi2pLpS+BgJ68VrsxcvPdkb65DOgO1ZttVnOt9d0Q04GNmXa78ooJjGlhGlJQCSSq4UTFl824owycJsY+GpzbrNsAba6VaCHXTW+VUxy/kU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TNWOtnRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZwS7MwD; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TNWOtnRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZwS7MwD"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 995F4EC0302;
	Tue, 22 Jul 2025 08:21:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 22 Jul 2025 08:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753186882; x=1753273282; bh=loviDwx+qM
	5h18+DHx4v3CTvYVKB60IoAuMuN0S1vsA=; b=TNWOtnRop3Z9bsJF1KS0gPhN1T
	OAe0SZjrPQUWCalRvPgkrC9n62E6vAlBwXq/rrgaFRFHrY2ZHMh3wMQ59neANLab
	ked1ZO1gGLLQghFekUgvhgyD0SLWQVrEKyXyauyYIh02ilWwZSbjqdK3aOoBoAgv
	F+jLuazvXEeUt34CzZIYyXn/ZeEWmXB14//ZYokD2HuuPGF5bkk+KzJmxBEzyhrV
	7ox90229wuf2WsYKjI+U0XGS2TXxCQSbSlLAetgnByUUrlkyeJ5oJO2oieq8fycN
	8vYyGNGYlGBFQsnUd+oQWvlDLCroTjMkF6dVDt4X3qqNgYn138e9VvjWHP1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753186882; x=1753273282; bh=loviDwx+qM5h18+DHx4v3CTvYVKB60IoAuM
	uN0S1vsA=; b=mZwS7MwDHb4uhkuqPE/iboNF6Suh78n4Kinq0uI09LL1fdyw5FT
	mqZqYa3eRG8AoMOtIjbnT1kbhsonj6cNOnudajA2KCyXzgg+b7BF47Jfh6on3beu
	J+iBJyuS6UK9w5dR4QIn/pngznsLt4LvLeKkWRUAOJm/D23peZrBUsjMNxjJ7bFR
	8C5gfEsBoZ2LvseMCxwjiZVXmfmrH1pZd6Tu+wNK02m6GrLiPRAXvuq3wcSZseyl
	1IzNIS/5yipkVQbnEqGqFS+2iTeZNm/eOfyDewwtNmXSgIIjHRXoNDFwSsma74vY
	AvsA2BOEe5wTrWm05/48KIEQlat/IJPGeKw==
X-ME-Sender: <xms:QoJ_aDfTaADHp5PzKuer7KgTzvZfwdqHVhetQtAau8UxWrROB60bRg>
    <xme:QoJ_aBqz3Av724xaSGnBWi3n5ZGcKMFXQRcBlS3viCdZUWFf_4OxFoJ_UoXH8hDrP
    ISls2Z0RaJwTPwDig>
X-ME-Received: <xmr:QoJ_aM8Nx-F39Odjwom4xIk4vler_2UrdfdVTqKJGV5apt51M3SJ7xAVQw18PJY0l2UGlgbYLFHEDSEP5h5bQQAnKh8r6_KoO5z8aOTuRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephe
    ekfeefgeegvdegvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QoJ_aFeqcpudl-NQANWAzG6EEQeAL3FyILbov2GFkV_JbMEb6ZODKg>
    <xmx:QoJ_aOLPQD6ccrX5EiCAOp5XOpzaQU0uJhpjEWL97KDgaZsJ1Sf-UA>
    <xmx:QoJ_aNgFvmppVk9Jw7xMihQzc7MogbK9andsTGCorSnmQldXuluawg>
    <xmx:QoJ_aESRFt4ETxZwY23QaSgFPy0HO58fNdYvUqTCr0Is4fIL9XFFyw>
    <xmx:QoJ_aKzg-pGGFhVwNSzqzZL3v0h3_y7S4nPNYzcL3IvwzReLzm7V1rwM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 08:21:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44c226ed (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 12:21:19 +0000 (UTC)
Date: Tue, 22 Jul 2025 14:21:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-ID: <aH-CN0RYFmpm7fMt@pks.im>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <aHlwZPbiKnakMN75@fruit.crustytoothpaste.net>
 <aHl4U98BBvpA5eKF@nand.local>
 <aHmVXDOiKzfKU8nb@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHmVXDOiKzfKU8nb@fruit.crustytoothpaste.net>

On Fri, Jul 18, 2025 at 12:29:16AM +0000, brian m. carlson wrote:
> On 2025-07-17 at 22:25:23, Taylor Blau wrote:
> > I agree. I don't think that there is ever going to be a "perfect" time
> > to introduce a hard dependency on Rust, and I don't think that should
> > hold the project back from adopting it.
> > 
> > I am far from a Rust expert, but I think that a more modern, memory-safe
> > language will attract newer contributors who may have a fresher
> > perspective on the project, and I think that's a good thing.
> 
> Yes, I think that's true.  Rust is by far the most admired programming
> language to work with, according to the 2024 Stack Overflow Developer
> Survey.  We will likely attract new contributors who find C intimidating
> or a bit of a hassle[0] but are excited about working on Rust,
> especially in a project as compelling as Git[1].

I am also aligned with allowing Rust into Git. I think the ecosystem has
kind of settled on Rust as the next system-level programming language,
and it does have good interop with C.

I think with the ongoing efforts to reduce our reliance on global state
we should eventually be able to encapsulate more and more of our
subsystems. And once they are neatly encapsulated we would be able to
swap out their respective implementation and plug in a Rust replacement.

Good candidates are for example the reftable library, as I've already
proposed in the past.

> > The alternative, of course, is to continue to use C and not take any
> > dependency on Rust. I think there is a middle-ground in there somewhere
> > to be able to build with (e.g.) "make" or "make RUST=1", but I would
> > really like to see the project take a firmer stance here.
> > 
> > I worry that having build support for both "with Rust" and "C only" will
> > create a headache not just at the build system level, but also in the
> > code itself. Having a patchwork of features, optimizations, or bug fixes
> > that either are or aren't supported depending on whether Rust support
> > was specified at build-time seems like a worst-of-all-worlds outcome.
> 
> I definitely agree.  I already find it terribly inconvenient when I end
> up when `git grep` doesn't support `-P` and I imagine that having lots
> of features that weren't available would be bothersome.
> 
> I also think that using a combination of C and Rust will end up with us
> still writing a lot of unsafe Rust code to interoperate with C.  If we
> want to reap the benefits in terms of memory and thread safety[2], we'll
> be better off sticking with just Rust.
> 
> I will also say that while it may be more challenging to compile Git at
> first on Windows, as we move more towards an all-Rust codebase, Git may
> end up being easier to maintain there as we depend more on the standard
> library.

Fully agreed. I've said so at the last contributors summit, but I think
it would become awfully unmaintainable if we retain two implementations
of every subsystem that we convert to Rust. If we decide to use Rust I
would strongly advocate for going all-in.

Patrick
