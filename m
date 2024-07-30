Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0F2563
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321675; cv=none; b=NdJpmrrhgIMDPOME64Afb6DH5Fps3E6GDpLI/LhTwvHoFA640pP3oOm7p8b/mZ+YVd0gbCuvgIY7GKTgb3y7LaCro1Smia+fqlPSF8jonryurhiM0D9YxsDZecI1Nac/HhwamgJJQjV3skcL2LvDLZmS0exipT6imDIlqDc7LwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321675; c=relaxed/simple;
	bh=j+vaTjOb5ac1+rl8Gw0QDbXxhI1ZsmMEH4AFl/McCGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJo+iA9EZLmUr8kbL5G5C+fuVQQhwMPLh/LgTowxU992GyQNq1YM7OwctR6MZrUCHfbJD0nZKLDQNZpUymVpXaANc3t464JdijAE4yWcZucnFOq8SX9IHqidOuhHJ0jrSxQrdXmYEwnYrM/ZnXEY2Mf5HrozFZXkpwrYtPmS4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oWpOJjNm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CPR7brxs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oWpOJjNm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CPR7brxs"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 198DB11405FF;
	Tue, 30 Jul 2024 02:41:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Jul 2024 02:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722321672; x=1722408072; bh=mLvLJpWnP4
	dtyy1VIgPtluU7oyWEpI1ng1h5DkSU7wQ=; b=oWpOJjNmVrOo86j1tJJtPo607Y
	p0ccHsB4J78tlEOeYu+k9xpiAxmSiG0rAsmF2ifi8UdQHeCh6a0u2t2e1O0V6flh
	ws3oVXIytUoXyUnXUNi+xLS9aeOd/PXtP4GYcgdZAv8E+BAS0ZI/akPh55ae3N+7
	qkLHjw8w5uY88vwN64cRS6DaX9G2BcDJ8YxT7MujotpknvqW2Wk/BxvMqB0qePTv
	qu4n7xFreS2VutS7uOqfHwS/Y2w+Y5uCPm+spqIYb3k8fqH9UcdmLHQcnikiBDLI
	e4p+E0C0QsZwAhOpz+zAFnaSHtz8OhBtyg/9sZflfUuveyBpMZENjbUPjRPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722321672; x=1722408072; bh=mLvLJpWnP4dtyy1VIgPtluU7oyWE
	pI1ng1h5DkSU7wQ=; b=CPR7brxsMBEGNXxMNhTW3CqaJOFYtV6eZOwhUIpnLgZr
	DHBZj1yeXVj5zaL1dTVTnjZLUtzluNoWMeDAhV8pQzJ49eefnjWMiukdskWpPr+K
	vFjQTlAz0uK8Se/1VrBzVraB+GdUyQqK97tqjv9KIs98H50XNCnMxamjHY+tG713
	BFHjIOuMBmcjxQOV8wa2ofAR2ULhJ4Zh4PAflDK5l7ESMRYGDKTu/JbEN4UgsNoJ
	jP+b0peWf5/b5x1S+Qrd5DBWWbILoLVpgmDmcsVOTJSQzXzDblfwL7T4XaooajSL
	FlRxPyrAwSO9oGhlKUtFRjmGt0hk1VMJtDGGbbPwGw==
X-ME-Sender: <xms:B4uoZhgK_6orBYV95KcZfj-YkV6Oy_HcQLPMOoPHiP4mvlYrYHcV2g>
    <xme:B4uoZmD4vlefzzMHBnbztCyAhi5P0lwv6j39PbLEljqbZ8zIRqeWx4WCkDf3CqVUi
    GA8rkC6cWXBiDjGbw>
X-ME-Received: <xmr:B4uoZhFZVh_DSh0eB6KlcExH5lPY4Cduj4LJ3rwS-aY4NIRoAVYe-ANWaGRx2hrqA9RmvgFdAxxmTiT8pTOxKQ9HGsvGxZcHxTf6EgRFa0KcnYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:CIuoZmSeWAqQaudH616wxbPvwsU-V9BhVMH2nY_vi_X6iCZdC41oPg>
    <xmx:CIuoZuwMff4vGxD0bxPY_bKkc_i4gC40of7j1bseHPUw7FzUQoJHmg>
    <xmx:CIuoZs4kUcfhdaf88QXU_idTT3KqAwT1w1_Pt7yyX3wLxUqE1HT0mg>
    <xmx:CIuoZjxRI8nFua3J5loJy8WiP4YFdbc7k06fxNHb_v18fdEykUvfiQ>
    <xmx:CIuoZi8WwEBYtBW4otvFfrOTGRQy2yQj7jFWp69nmbXwo5ddiO4JWfNI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 02:41:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 17fe346c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 06:39:42 +0000 (UTC)
Date: Tue, 30 Jul 2024 08:41:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] Documentation: document naming schema for
 struct-related functions
Message-ID: <ZqiLA0bGYZfH1OWD@tanuki>
References: <cover.1721818488.git.ps@pks.im>
 <7f07bf1f3beee2f74a3572d2b9a8d28b6535053e.1721818488.git.ps@pks.im>
 <xmqqikwuwx7j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TmRfXa+gxbdCuWCz"
Content-Disposition: inline
In-Reply-To: <xmqqikwuwx7j.fsf@gitster.g>


--TmRfXa+gxbdCuWCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 09:50:40AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > + - Functions that operate on a specific structure and which are used by
> > +   other subsystems shall be named after the structure.
>=20
> I am not sure if this is a good guideline.  In the case of strbuf_,
> you could say it is named after the structure, but I would actually
> think that both structure and the functions are named after the
> subsystem/API (i.e. we have "strbuf" that other subsystems can use).

Well, in most cases I'd expect that the structure is named after the
subsystem/API, itself. I'm happy to relax this statement though and say
that functions should be named after the subsystem.

> > + The function
> > +   name should start with the name of the structure followed by a verb.
> > +   E.g.
> > +
> > +	struct strbuf;
> > +
> > +	void strbuf_add(struct strbuf *buf, ...);
> > +
> > +	void strbuf_reset(struct strbuf *buf);
> > +
> > +    is preferred over:
> > +
> > +	struct strbuf;
> > +
> > +	void add_string(struct strbuf *buf, ...);
> > +
> > +	void reset_strbuf(struct strbuf *buf);
>=20
> Do we want to rename start_command(), finish_command(),
> run_command() and pipe_command()?=20

I wouldn't quite go that far for now. We may want to slowly adapt some
parts of our interfaces over time. But my main goal is rather to make
the style consistent for _new_ interfaces we add.

> child_process_start() sounds somewhat ungrammatical.

It does, but I would argue that it is no different from `strbuf_reset()`
and other functions where we have the verb as a trailer. And I have to
say that I find it a ton easier to reason about code where we have the
subsystem it belongs to as a prefix as it neatly groups together things
and immediately sets you into the correct mindset of what to expect.
That is of course a question of preference, I'm not claiming that my
preferral is objectively the best.

But again, what I do want to see is consistency. Nobody is helped when
we mix both styles in my opinion. It makes writing, reading and
reviewing code harder than it has to be because you always have to
remember whether it is `string_list_free()`, `free_string_list()`,
`string_list_clear()` or `clear_string_list()`.

> By the way, some functions that have strbuf_ in their names do not
> have anything to do with managing strings using the strbuf
> structure, but they do things that are *not* about strings, but
> happen to use strbuf as a way to either feed input to them or carry
> output out of them.  They should be renamed away to lose "strbuf_"
> in their names (e.g. strbuf_realpath() is about pathnames; it is
> immaterial that the function happens to use strbuf to hold its
> output but takes input from "const char *").

Yeah, that's fair indeed.

Patrick

--TmRfXa+gxbdCuWCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoiwIACgkQVbJhu7ck
PpSxTw/5AZjmR4uRWOYb8agr7aZbCVb3vnsK848F8UkdF1wl2bgvyaCbj9AJoagk
YjZqWbOt7c2k0zIHAy+CQLsPrPLlth/QJmKhnVrUvW76fa9mKKcfeviyOg9oCFtT
xTq0rZ3wTa6l5AAHHFz0y3BQgv6zoCn4vnR0JeQ6SpjVzNgU+Ymtxw7Edm0fqa5M
HlGV1ZmdQUqzJNPqPkBN8cDI522DZCS9Isgu74Uch9GN91D7Bm1tcHp0FTzUISMc
vRMUBhFAoho1eI6LgU3AnOx3B4HExDz8ujF4JLafJmqTV2b5lM8x2bjirsDCRhon
huBEnbu+I9SGL8s241Mn/8TMF9S4/CZtQmX+i1YY/A4dQPNzLpdFJfqWZv7DCDz+
UWnQg45JrVhDDPQ3MXPxMg//9Jai31xdqC/XtD1TYcMkeYIr/++0+5YK0idZ+a7a
0EhRFPxTcX6fj73+9+rVAE1RZpD6LEwGlpao9a916sEjebKGSo6WMslUew4s+qXr
KlDZBhH5Ccdz6U5oFZem6bs2VinZq54x+SNNGG2znzTF3GP5+ul2Sm453ks2BHSx
ZbRwJuj9y9p0Fxu/ju7yBt/a9gikv8k2uNbjTyW344H6jbKMRQNomSaqMjl+eQSj
K/gGLAlXDnr06NjRz1nUQX6mE9YUkfNbDLW2mc1Ok38vu+OCjx8=
=zzrr
-----END PGP SIGNATURE-----

--TmRfXa+gxbdCuWCz--
