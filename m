Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F9288C24
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546080; cv=none; b=hG51ux4v1A5UYqy40ZSzsi+i5lJVSiK1nWiepdSVn8TCoPdZql2lEDKlrNEbgJXwJsqkMphY9Rpp6PywqyXR5zBkklZIGBU6BP3GtYXTmlDdpOyHbzZGCKH67bZ+fhFxm6O+SVx20Fio9veJv3w4SP46hCwShpi+iJywoa9qe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546080; c=relaxed/simple;
	bh=11aPGEXqfrj0uOzL0Mtra6L2vsdueMssnlA/sSmPoSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HINW9JR95yW9ikH+0YsPl0CciW+Fflx3XfXLlgFdn71ZR6QFanGyM7TqpP4PfzOwS7efOcY4ID37fyldCdyhzvdIvdTKtHPEibq6gT5sTcISmZT5YN2pg4DgbcvoGMYaeBFjvKTBKB4MMHPs1DW2WHA91TZd0rfJPEsBn9a/FVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PxVumNxq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kSLowHVI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PxVumNxq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSLowHVI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 331247A018D;
	Mon, 22 Sep 2025 09:01:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 22 Sep 2025 09:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758546076; x=1758632476; bh=3HnSwJON34
	HWbBEg1PkQgbu2v0fVMIZbiX8/sADUJlU=; b=PxVumNxqa00o2I+ygOPIemu3Co
	R1hiagHJe+6ecaCKOCX4Gg69nYoJ8TBpWoLD8L59xHTmQ/U6aDWXmSJlOQxaLLOT
	lC2PftptEYYwCZIvvQdU+v5gyEKKgxRKlKAJV4O8ki4wOgCYvEeYd3XhtCOyadyL
	ZDK7BJsBLlaV1Q20rZ/zFnMXOe3nfQi9TycJpE8B6c8B7tMkoj5Z0HBrBe8LF7Cn
	5QLBgWNhSOZOUsqYkl0LZ0DbFiDgMguklEawEoQoatqMmctN5Rq2WYBCzSLTity4
	Tnq/cnKYsPyvaWdDL1ZzLe4HDh3/GSkXUPKdV+e1xXQuWFbNQmyQLoaKZsdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758546076; x=1758632476; bh=3HnSwJON34HWbBEg1PkQgbu2v0fVMIZbiX8
	/sADUJlU=; b=kSLowHVIKaASAv6hg9OMpKh2d2Z7rNlrXqFto8AHLYFP27jqYNg
	TyRTT9TwmOgtt8EGonfNEIfYjBA7+9x3YKb3YhGOsHdSuiXZtGGzPkE7Zwgkq/JB
	FYJG/FcgeJwldjTII1OZaN8qnxviRiiFd2PL3YUxeMaPn3arm8RtZTdRsSQxc7m9
	SCaklNma5h7v27U6H1Dv3kXzJ9plFe8oV8uNpq0D3Vb9Kc8D5wHyflCD1svdoRF5
	vDU/sotHRZUAqvroNu+S53V17/tH8IgD4SN6EJefUwdHnnOoXCj3SDlqIqo+NJ0o
	7ymhOm5/zQ+yHYcMG200iGs/UCGutrykdUw==
X-ME-Sender: <xms:mkjRaGHI_AoqhiImLrqpOiFtizTbMO8Lz8W9xT7RW-OdhmfZmRxEXw>
    <xme:mkjRaM7Wx1RVTynQT3lBcXK5wfrDnfz-aZnTCLiCBJzMco2E1wRlh-df5xfVX3JO7
    an-KiVOX-gPQSJcdQ>
X-ME-Received: <xmr:mkjRaJsRTWIBZFBtHDmprQigetu8I_uFq30U1SUN5DCOaZImN36Zhk0UbChy0gAMLiQ0ptdNbQAgFC0on5U21QMfe8mwI0XBH8dOUVo0Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegtsgesvdeh
    iegsihhtrdhorhhgpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqd
    gsvghrlhhinhdruggvpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdr
    mhgvpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhi
    vghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mkjRaA__C50j7H8De8Dbv4D5YJgced3dFWoN7Z6XDMMpF6kbKmy01w>
    <xmx:mkjRaDkvEz9RKtgZGNPF1HvxwMcGPFf0gdBpQp03IfVvA-TM4v_rHw>
    <xmx:mkjRaAOdit-CFz_n5NS_CiujlZz6B1bAY_CIt3Z-WHmWAYmShGKZ7A>
    <xmx:mkjRaCLK2N85NevOM8u1s5NgCGmJa-74D_08VPz_Oy7lW6sRmmFb4w>
    <xmx:nEjRaCI_29PwaLiSxZgTmG5GzH7U5o2SjOeV-v9Say4zWdXOJXO9Klz6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:01:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 80f64ea5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:01:10 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:01:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
Message-ID: <aNFIjWKX2Wa6GEkA@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <6674eb07df107d786b747ccd6dce4555d36d5d2c.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6674eb07df107d786b747ccd6dce4555d36d5d2c.camel@physik.fu-berlin.de>

On Fri, Sep 19, 2025 at 08:41:45PM +0200, John Paul Adrian Glaubitz wrote:
> On Thu, 2025-09-04 at 16:26 +0200, Patrick Steinhardt wrote:
> > this small patch series introduces Rust into the core of Git. This patch
> > series is designed as a test balloon, similar to how we introduced test
> > balloons for C99 features in the past. The goal is threefold:
> > 
> >   - Give us some time to experiment with Rust and introduce proper build
> >     infrastructure.
> > 
> >   - Give distributors time to ease into the new toolchain requirements.
> >     Introducing Rust is impossible for some platforms and hard for
> >     others.
> > 
> >   - Announce that Git 3.0 will make Rust a mandatory part of our build
> >     infrastructure.
> 
> I'm one of Debian's maintainers in Debian Ports and I maintain Debian unstable
> on older and more obscure architectures such as alpha, hppa, m68k, sh4 and sparc64.
> 
> Of all the architectures in Debian, there are currently four architectures that
> don't support rustc. Those are alpha, hppa, m68k and sh4 [1]. For m68k, the
> situation is special as both LLVM and rustc already support m68k but with Linux
> still defaulting to 16-bit alignment on this architecture [2], building LLVM and
> rustc is currently not possible. I'm working on a switch to 32-bit alignment
> though which is default for NetBSD/m68k and also what specified in the official
> SysV ELF ABI documentation.
> 
> In general, I'm not against introducing Rust support into existing projects. However,
> I wished projects would be a little more patient until either the GCC codegen in
> rustc called rustc_codegen_gcc [3] or the Rust frontend in GCC have become ready
> for prime time.

Thanks for raising these concerns, I really appreciate that! Making
platform maintainers aware of this upcoming change was one of the goals
of announcing the breaking change in the first place, so I'm happy to
see that this discussion is happening now :) After all, we are aware
that the proposed change can create hardships for downstream
distributions and maintainers.

The timeline I have layed out right now is trying to cater towards
gccrs, at least to a certain extent. As Pierre-Emmanuel mentioned in
[1], gccrs _may_ start to become ready next year with a target version
of Rust 1.49. Given proposed timelines, Git 3.0 with mandatory Rust
would be released at the end of next year, which would hopefully be
after gccrs slowly becoming a viable alternative to compile Rust.

This is also the reason why I've picked Rust 2018 as the edition, as
Rust 1.49 doesn't know about any later editions.

Of course, given that the work on gccrs is driven by volunteers to the
best of my understanding I don't want to "force" them to get this done
by that point, and Pierre-Emmanual also made clear that the initial
release is still likely to have many bugs. So it may be the case that
gccrs or any other codegen is not ready yet at that point in time. If
so, we might have to reopen the discussion of whether or not we really
want to switch over to mandatory Rust with Git 3.0.

Ultimately, I guess that this will also depend on how much of a pain it
is for us to keep Rust non-mandatory. We don't have a lot of experience
with Rust in our codebase yet, but if we eventually see that it's a
breeze to keep it optional I think we should consider deferring the date
where it's becoming mandatory.

All to say: I don't think we should blindly pull the trigger with Git
3.0. I think we should take a more nuanced approach and consider:

  - Any of the learnings we had with the initial Rust infra and how hard
    it is to keep it optional.

  - The status quo of the ecosystem and whether we can expect either
    gccrs or rustc_codegen_gcc to become stable.

That being said, I think we should keep the current intent spelt out in
our breaking changes document so that we can get more feedback from
downstream maintainers that aren't currently aware of the porposed
upcoming change.

Thanks!

Patrick

[1]: <7bf054a1-0196-4ad8-aaa4-a432cd2c93a5@embecosm.com>
