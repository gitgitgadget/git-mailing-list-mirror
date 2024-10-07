Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649F143C4C
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296287; cv=none; b=op/rQCsqSjccJaHdTMhxyG/pV+WwJbIwQEfVdhNJ/IfQhVlRzdOURvpKLwLFqjjUWu8p97FenE6Uiy8CjQm2WSorN/cqem7VtjH5ljerqNr32Tg8w0H/JalYNU+3EQa+rpljM7TNbpNGfwfqiHKOJJ/tciq8HBrRrk0u6y1f7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296287; c=relaxed/simple;
	bh=XNIuHYBiTcAelGCZ74U7wI4yTjcMZNFmZYZn14XLZPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWWwkGR0FscB6tpK8EesF8MpGU7nMvzmtHYabmu9c3J5SXVHfRutVEW6JH51YwWOHKnlW2vIWXYy705oSgou/ZjjsbP6sEraBAeeyyKizWzxRuAufDk8D+EZdsGVfQRt5OJgz7VSQKXIxu/RdujlzAMKNxjehNwctBRbT5SRxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ijhCyThE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dec4Y1Rp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ijhCyThE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dec4Y1Rp"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4FF8525400C5;
	Mon,  7 Oct 2024 06:18:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Oct 2024 06:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728296285; x=1728382685; bh=dG0cb/wJ1j
	eOEUb5I8wzwJ9b5aJf6LruePd7r2tu8ZQ=; b=ijhCyThE+HncTcM9qRedUjpQoI
	s4jvdX/36zOUC/T5I4JElVJCSMyZgJndm5I6AyA04bi3E4GnsFSiUjgvKx4W4MzJ
	KwAIZCg5si3aP42axS6GEkeQhiBiBApGUsVRQsLx5wsBrsBbNkzfM+hHJU4gQz1M
	iZwDOHcCwSJLZ1N7OlZFKxrv/0g12HPwljl0t4YllgE5+wMmw2s3ESPW6B0AB73f
	YgywQeG3n0Xh661eMJYiztKhbovjeaLK4b3GwBAnsXYfaxz/RbEcrD2FWj8rcUBF
	MYxZzQHVqwJedM4ZyqLdDpDev1BmI+cwsZ7BePRMKUYd5uBDO+Z63ZKt1tZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728296285; x=1728382685; bh=dG0cb/wJ1jeOEUb5I8wzwJ9b5aJf
	6LruePd7r2tu8ZQ=; b=Dec4Y1RpSAni5OyvG8VcveCEp5Kw0AF41/oH6UhbJCDD
	+O1U1pjyAdyeVd7Nxkux7smjJI/xjATx1hKH9Ze5At1awyH4lgTigVjZ48fiwTMk
	M4IrXgNgvmV4nhVbPvp1Ka7ROFPrpIbaUw+OO1ygU9hW/HzkSFykKEEqcjpEncQ6
	W5nUxC25v9L5zZQ7WtukrVoTk56EuuQ4wSU4UEKbCGNfZx5AgYbZ+BJyk0EvhgI0
	WDDhpbcQPI0p0VE3C4k6Cl7oStaOhPG8Wl0BlQtbalUXegEgSCyjls69mkUq1kuE
	//rPlxUVxL3eN/ZLFTBRisgwSItrnkKKYIVZGEdzwg==
X-ME-Sender: <xms:XLUDZ-GQ5JtjX4CkmC1pFdfzCRE5YdiDfu-bUX9BYOGyUrqbF2VqNg>
    <xme:XLUDZ_Xx3a8KQbQPbCve89l5ddzFtdj5PHgiY5phFjm6gZLuZMsVmNP8hG__zLCrq
    xLn1oc67CEBalJz2Q>
X-ME-Received: <xmr:XLUDZ4J7HsQokBng3gBBLb61R8JdgT5o35BV_lRhqQgZPRdYl_gUVGFL-DDQZbveXTMjuwtt_w5H0b_IJRNGgGYeAqjvkG4CEp5GZlUZKbg7ZfiGKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XLUDZ4HOrMD2XDFxLUYwCMa7E1IIyYRPf0YqH1YHUuHXx77IXuZXNw>
    <xmx:XbUDZ0WXS8RGk0-lQOKc8anNaASUkhGnZgv7tQ6slQlubLy-NoqAmA>
    <xmx:XbUDZ7MCmkjCmE7ytRa180HLHD7KCQHXBmboGYwp7h3Z3TuMKhX8Zw>
    <xmx:XbUDZ72JoXFz0eVI3GCfJBxIpMFBh6c1jERgOeoIa6AAPn6Qq6h8AA>
    <xmx:XbUDZ7TrDno2obBv2UhW8IXz9Cuuq4EVNj6grcDUvS-cxtptt2FwJnxT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 06:18:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d864e8e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 10:17:05 +0000 (UTC)
Date: Mon, 7 Oct 2024 12:18:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 01/21] Documentation: add comparison of build systems
Message-ID: <ZwO1WlBDABVs0CRU@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <508e3783d284fd2d3bd4840907ed0bdc20bc1b23.1727881164.git.ps@pks.im>
 <xmqqjzeqmkwz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzeqmkwz.fsf@gitster.g>

On Wed, Oct 02, 2024 at 11:14:52AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/Documentation/technical/build-systems.txt b/Documentation/technical/build-systems.txt
> > new file mode 100644
> > index 0000000000..8fac36ce1d
> > --- /dev/null
> > +++ b/Documentation/technical/build-systems.txt
> > @@ -0,0 +1,164 @@
> > += Build Systems
> > +
> > +The build system is the primary way for both developers and system integrators
> > +to interact with the Git project. As such, we consider it important to pick a
> > +build system that fulfills our requirements while being easy to use and extend.
> 
> Maybe it is me, but this sounds as if _we_ do not need "easy to use
> and extend", but "easy to use and extend" are extra afterthought
> consideration we are making for others, which is a bit disturbing.
> 
> Let me try paraphrasing what I think you wanted to say
> 
> 	As such, being easy to use and extend for those who are not
> 	directly developing Git itself is just as important as other
> 	requirements we have on any potential build system.
> 
> which hopefully would sound more like we are not treating those who
> only build and tweak the product of our project as second-class
> citizens.

Oh, that sounds way better, yes!

> > +This document outlines the different requirements that we have for the build
> > +system and then compares available build systems using these criteria.
> > +
> > +== Requirements
> > +
> > +The following subsections prevent a list of requirements that we have for any
> 
> I think you meant "present".

Yup.

> > +potential build system. Sections are sorted by decreasing priority, even though
> > +these priorities will naturally differ between users.
> > +
> > +=== Platform support
> > +
> > +The most important criterium is whether the build system supports all of the
> > +platforms that Git supports. The most important platforms include:
> 
> Maybe it is just me, but when I hear "The most", I expect an
> exhaustive list (hence "include" that came later somewhat surprised
> me), and I consider these "the more important systems" (implying
> "than others").

Fair point. Ideally, I would be able to just point to our platform
support policy, but that document stops short of defining what kind of
guarantees we give for each platform.

So what are our primary platforms? Based on the criteria we have it
would be Windows, Ubuntu and macOS because we have CI runners for these,
all of which are included. Providing support for the BSDs is nice, but
these are likely rather "secondary" platforms.

> > +=== Ease of use
> > +
> > +The build system SHOULD be both easy to use and easy to extend. While this is
> > +naturally a subjective metric it is likely not controversial to say that some
> > +build systems are considerably harder to use than others.
> 
> If we want to pull RFC-2119/BCP-14 with shouting "SHOULD", we
> probably should use something similar in the previous "Platform
> support" section.

I think I originally wanted to use RFC-2119, but then noticed that it's
rather pointless. I'll stop shouting.

> > +=== IDE support
> > +=== Out-of-tree builds
> 
> Cross platform builds (e.g., building for arm on x86-64 host)?

Oh, yes, that one is indeed an ommission in the current doc.

> > +=== Rust support
> > +
> > +Many long-time Git contributors are nowadays in favor of adopting Rust as a
> > +second language next to C. The build system SHOULD thus support Rust such that
> > +we do not have to reopen the discussion once we decide to pick up Rust.
> 
> What reasons do you have in mind that, without spelling this out,
> Rust will be left behind while C is fully supported?  If the build
> system can keep track of dependencies by knowing foo.o is made from
> foo.c and turning foo.c into foo.o takes running cc, it can do the
> same for rustc.  Do you mean include file dependencies and the like?

> If the reason why we say "Language X needs to be supported" is
> because it is not enough to be able to run a compiler on source
> files written in the language, but it is also necessary to know when
> to run the compiler (i.e., by dependency tracking), it is better to
> spell it out.

Eli already did a good job of explaining this. While it should be
possible to "retrofit" Rust support to basically all build systems out
there, it certainly would be nice if we could hide away most of the
intricate details of how Rust code needs to be compiled. It can get
complex rather fast.

> In any case, instead of singling out Rust in the title, name the
> section "languate support", and give an enumeration of compilers
> languages, processors that we care about, just like we did for
> platforms.  For exaple, we may not necessarily want to treat "C
> support, done as an afterthought of supporting C++" and "C support,
> done natively" as equivalents (of course, the latter is better).

That makes sense to me, will do.

> Shouldn't it also "support" asciidoc/asciidoctor/makeinfo for
> the documentation toolchain?

It certainly should be flexible enough to allow for this, yes.

> Are there other things we use Makefile for in our current system
> that we are forgetting in this requirements section, like "running
> lint" or "running tests"?

I was a bit torn on whether or not to add "running tests", mostly
because it was supported by all of the proposed build systems. But
that's probably not a good reason to not make this requirement explicit.

Patrick
