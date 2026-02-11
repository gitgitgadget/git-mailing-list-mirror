Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8A25228C
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807628; cv=none; b=i+ZLdAum+ircz+AoBQh5rTG84TO6i9zX5jXIz1HNpysvY1PbywsAn4gZsa0HGlttvfD6+ofcYQ2Y3Y1DQip6y6cFt6dJRtlxtinC1Rrw7HAowJ27jsS7lnEt3xfmadTEH8zwpRQopLg5KjQF8HQHCDB+vDpxE7zHYPYEdV0Sw8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807628; c=relaxed/simple;
	bh=t1ac8L/MP2IhFYSAdMBts0Zdi4WmZJUg4YbBx9gKxxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/pmuWJ7FG3t7Jvlc2xDarTYfbimn8S7/+HC/CKtdw0FhCzCHpz2LxOiKBS33hhPJlMAd6hsG5TmIRhwKS9LkboMxRcP/42RNIfdsAFQOUtrEhyhp0Eslspso35zBfOd3JcBYVTUB3bTH3/WPDw8ZwFJD51fPMhc60l3f3UEbmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p5vbgeSS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YERcGJai; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p5vbgeSS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YERcGJai"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 232821D00244;
	Wed, 11 Feb 2026 06:00:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 11 Feb 2026 06:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770807625;
	 x=1770894025; bh=Qg7M4lV9UZKh+5FWBEdKMlpfDeT/MMon62gEYa7atWQ=; b=
	p5vbgeSSYaqG3quhPFN2dug6q+wOgx1k3ZfIbdPR1iNcvXw2aUuOQxtGrOA65OWz
	RD9GJfOYaFqm86wkOQCLGl6lBwMhX0BKvWARZFmtIDmcv+70OE7BhCw6TRGfWATk
	ncGAsOFUYMEqslfzoxBLxf6B8F9DgFUGPYFKr6xjYGDm9EOxfLbkRpxb5JcIzJNR
	87JXZrbdza1tpCf5rKbO9Ubg1rRjo+k20x8wqj0whce4w1ugqdj4AGFZ7I1iVy2t
	W7XKN9Wf081JliWnXh/HjCtCVHnw4sS/Z14b8mYJYlT237Q1ba97LFjqFXF/EyES
	BR/IX28ndDppmy8nsEdUxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770807625; x=
	1770894025; bh=Qg7M4lV9UZKh+5FWBEdKMlpfDeT/MMon62gEYa7atWQ=; b=Y
	ERcGJaima0YbuVHlBOOeud20klO05RhYr+9Ty7Vq5dIZj6nq4X5wLRPUyymtbmu+
	Z20mVELGw0yrdYvxsEEl0c1Vi4RBZeo0Ke3RnVlmoPplCY0672mh8z2hp15bMLfC
	cB2kfkF4ATq489cb8O3og6g/MiNw4SIpkGcgkI8R7OhEI0s6bviuOzSjcZFEK+Q9
	5vhoMlX0vTDdnxc+Jg8byR+wZh50+9dvZ1PGyPRKOz3VnrroBUSNRO5rIjOoqOuR
	gvwiRuyLHGKA5hxX2lEItO5Q/xpBNjLVCtF82oGSrZ8/Xf8Lr7lM03xN+1DlF+Q1
	bLwe3Uk761NFcqciDS2vw==
X-ME-Sender: <xms:SWGMadVuj4AyuHDBMbtuVQt84AAVdVHKc6XDbx6rQv0wPVdvkYGj7A>
    <xme:SWGMafG4ogLoBiPCe2OnIiBKH0z60Mz-1BFVI17Bc-s-0TMgJY3SEwkyRYP2h63jV
    XqSnZu_iNSf0UN0az7Z80_b5KDFpLgxEjj1UzVNDeUEexVxQQDm>
X-ME-Received: <xmr:SWGMaZcBswKGlRVJrLYTyPUW8cRYIx4mbA3Pd7W0C5TCGowL-zUnsKDG1yRron7yq7aCvE4XQfFuir8JRINpXfMBp0Lxl3uW6_gxpdup3ScY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:SWGMaQKx1Wa4XHXZAAAMZckX80_IwST1G1Mqbtz99XxnugInaOQlfg>
    <xmx:SWGMaeFxFQbhJDvMOaFGUF-cLru4pqq0L6D18TM-52BBdRLXXQOAJA>
    <xmx:SWGMaTDkTuyiZbFrK9Pgxlip7MF95uxypJ4OYjb1qD_E529w_llNYg>
    <xmx:SWGMaR-jncNzA_jDI_ikiBDaOz7ru_JjvfRF0p4OCye7Lnlu8rKUzQ>
    <xmx:SWGMaUZFl-WKOVVur5gKamDtlxQmKG53lh6ehKOwxDnsKTY20NB94Pif>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 06:00:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5b449875 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 11:00:23 +0000 (UTC)
Date: Wed, 11 Feb 2026 12:00:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Evan Martin <evan.martin@gmail.com>
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation
 changes
Message-ID: <aYxhRNQSpctbUB7x@pks.im>
References: <aYn8XKv2hH2HX2xO@pks.im>
 <20260209215015.25867-1-ben.knoble+github@gmail.com>
 <aYwzAt-dugh_acj9@pks.im>
 <4a566010-821b-4078-9563-9ca00ada55a0@gmail.com>
 <81ff4cc8-676e-43fe-8193-609887b887d6@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81ff4cc8-676e-43fe-8193-609887b887d6@gmail.com>

On Wed, Feb 11, 2026 at 10:57:10AM +0000, Phillip Wood wrote:
> On 11/02/2026 09:44, Phillip Wood wrote:
> > On 11/02/2026 07:42, Patrick Steinhardt wrote:
> > > On Mon, Feb 09, 2026 at 04:50:06PM -0500, D. Ben Knoble wrote:
> > > > > On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
> > > [snip]
> > > > Only, things are behaving oddly. For example:
> > > > 
> > > >      λ meson setup build2
> > > >      λ ninja -C build2
> > > > 
> > > > works fine, but
> > > > 
> > > >      λ ls -l build2/config*
> > > >      -rw-r--r-- 1 benknoble benknoble 17169  9 févr. 16:39
> > > > build2/ config-list.h
> > > > 
> > > > I don't see the dependency file.
> 
> I've just had a play with this and I don't see the dependency file either -
> I wonder if ninja deletes it after it has read it.

Yeah, that's expected. Meson will prune the depfile after consuming it.

> If I delete Documentation/config/add.adoc then config-list.h is rebuilt.
> However if I edit generate-configlist.sh it is not rebuilt - I guess we need
> to add the script to the dependency file.

True. This is typically handled automatically by Meson, but in our case
it doesn't know that the string we pass to the shell refers to a script,
and that it should thus cause a rebuild if it changes.

Patrick
