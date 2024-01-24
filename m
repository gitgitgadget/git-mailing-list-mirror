Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473D171D2
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086319; cv=none; b=g6dnxoomkz7GPo8SOMhpZUT8K4KBcEaqn9E0rYEe6VlCOVcDLqwgDKwg3TW0ZRm2fnsxI4vHKhnuzAStNtI83otN87G/NRR8TToqbnAQzlndmUdxXtLksS477a9JXAAcmVLtGVpvSqcdlOefYYogpwYxKsC+tUxkC+t0TS9goYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086319; c=relaxed/simple;
	bh=vUN78YYF+ewEJA3su59pbOXvBJmFjPlat5on/EjtLiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNGmCEO2LOLjglIZOxtMOXup/UyT/Hfd8Yg+vzB4aJdEkKa6lWSjfaKIWG9F97g9DeeINthCQpHTP+26j3zBIieg1dapDOjFSQLCbBibuPQ7eyJhoj7FHbgQZu4z8ZsVItK4Yjl4Uh5YyJuaRzIze5e9SSSdhkdTnzZqrbd9fD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z/Ado3Do; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QRd20wVp; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z/Ado3Do";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QRd20wVp"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id C94E23200AE0;
	Wed, 24 Jan 2024 03:51:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 24 Jan 2024 03:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706086316; x=1706172716; bh=9Hp9zZutG0
	f4++9NtNZxs4h0e9H8m1P04nj21Ac26UQ=; b=Z/Ado3DoSRzLCiCyGq1LIDZHoB
	of5YsI7ukU9/ROFtvzxva5gDH/EVewVKDaYvcs/EoYfm8iuZbzLT4WIeZJ79woyc
	AbaNWWTIo3uZhDnoNM9rd6Y5UfgUmm7+Fl4xU+cZkIaQm6aq97Vnb7gkXLC/VszU
	CunHbsYxY0kPGDCLBDxAr8+a0BHbKL2eh0cM/jfeDSw7Yl8Dxg0X9AjtUxQXYM3B
	7QWv02+uqSB3ygHu1K6y9wTmuSLFsgKI7OK3jnwX0EA1oyNCx99jlBTNQeZr8ng4
	p2XXGbYFlD1yKo4xuwhPpLXtHLkqfMhzWtzMDnE9vTH01pCPlY3VufLQG09A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706086316; x=1706172716; bh=9Hp9zZutG0f4++9NtNZxs4h0e9H8
	m1P04nj21Ac26UQ=; b=QRd20wVpfefsDfeYzuQHtrXl207cpavDzKVoDOvEETQD
	ih+RLWspHl761YXCpxBU+Dle+h6IwLhGvwLPFCPBNKi/h1aWC3uhfTmUS8wlpKxv
	G1mpSDpRnZLjjW8KKGgFlPcBJN0b4vv7LYXxYYSMI5DgOZiaMZV4H95qFYsHoY9h
	zZz4otpv6SaQVEP5BoJf1Xokem3ezmzcpmaPKofBHnB9AstsqC6CIZ5f0VeIeVdz
	j+bSXRC07JFeE/XLfsTgJXYtsWSuwetEQSuiEFxXpiCAPv8WkSHY4XnZM81A1AXo
	UNeBeeyqxZfkOfTCWOzQ7qaXUTzUnO0WeuVt45XKxQ==
X-ME-Sender: <xms:rM-wZcsOCKlcjfQ08ts0s2TeuBRldSFSdNS12Y3LeKIB7ULgFVpg6g>
    <xme:rM-wZZfK0ipMFDfjAVUJPSPt9iskyCXDFP9FO_WFmrmgjZbY9Va7buPMvkjzmQSmw
    AzJmSdguqvG_p5rSg>
X-ME-Received: <xmr:rM-wZXxEWEqbqNOfCjPw7vV2ba0rClgmpcLCy2Lvo-KsNSqj9UQfVIgIWWSOUXb_-sFd0MRNSEA89gwrS9k2kGam3OeL0DOyvSGUcJFO8EwkQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:rM-wZfP8T-TtE25VDGUNfHvCAc5WstRsUdrKTPWkAhC8TgsGZrmvVg>
    <xmx:rM-wZc_JmDk8qmsmj-Q7Xo_Sbvsp_-2UP5TmWC4vNczegPO6xv-j6g>
    <xmx:rM-wZXWDGNlEPUp-AF7JDz8ETvzjEx6Sw176TS5BcNPXn_ScQoysqw>
    <xmx:rM-wZeKhv8rxeGQDYycbNpC2r_ZiPo0KcOTWr9ODqJL7mEmEUDq-eQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:51:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 53c1acf7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:48:48 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:51:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
Message-ID: <ZbDPqOnyLw4yhu--@tanuki>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240119142705.139374-3-karthik.188@gmail.com>
 <ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com>
 <xmqqplxtrucm.fsf@gitster.g>
 <Za-gF_Hp_lXViGWw@tanuki>
 <xmqqwms0ndvu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ks39HFS5rQ83rKg9"
Content-Disposition: inline
In-Reply-To: <xmqqwms0ndvu.fsf@gitster.g>


--ks39HFS5rQ83rKg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 09:44:21AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > My first hunch was to convert it so that it indeed always is a proper
> > ref. But thinking about it a bit more I'm less convinced that this is
> > sensible as it is deeply tied to the behaviour of git-bisect(1) and only
> > represents its internal state. I thus came to the conclusion that it is
> > more similar to the sequencer state that we have in ".git/rebase-merge"
> > and ".git/rebase-apply" than anything else.
>=20
> Fair enough.
>=20
> > So if we wanted to rectify this, I think the most sensible way to
> > address this would be to introduce a new ".git/bisect-state" directory
> > that contains all of git-bisect(1)'s state:
> >
> >     - BISECT_TERMS -> bisect-state/terms
> >     - BISECT_LOG -> bisect-state/log
> >     - BISECT_START -> bisect-state/start
> >     - BISECT_RUN -> bisect-state/run
> >     - BISECT_FIRST_PARENT -> bisect-state/first-parent
> >     - BISECT_ANCESTORS_OK -> bisect-state/ancestors-ok
> >
> > I think this would make for a much cleaner solution overall as things
> > are neatly contained. Cleaning up after a bisect would thus only require
> > a delete of ".git/bisect-state/" and we're done.
>=20
> And bisect-state/ needs to be marked as per-worktree hierarchy, I suppose.

Yes, "bisect-state/" would need to be stored in GIT_DIR, not COMMON_DIR.

> > Of course, this would be a backwards-incompatible change.
>=20
> As long as we ignore folks who switches versions of Git in the
> middle of their "git bisect" session, we should be OK.
>=20
> If we really cared the backward compatibility, the new version of
> Git that knows and uses this new layout could notice these old-style
> filenames and move them over to the new place under new names.  From
> there, everything should work (including things like "git bisect log").

We also have consider that there may be alternate implementations of Git
that would only know to handle the old layout. Those tools would be
broken in case we did such a migration, but they would be broken anyway
if the bisect was started via Git and not via the tool.

Anyway, I'll add this to our growing backlog of issues that we might
want to investigate once the reftable backend has been upstreamed. Which
of course shouldn't preclude anybody else from picking up this topic in
case they are interested.

Patrick

--ks39HFS5rQ83rKg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwz6cACgkQVbJhu7ck
PpRCpxAAoyR95GmFEc7Qh2wcAtmFTEzJO2imD5DzH18+H7RhRfWnckNb3qI9NqnO
7Mrr9iGD+BK2OAuEzigUZ5x9slyPMIpxqUqwV3j18KXceLY/okb19y+/USunAaXk
9+Q8LL2UOEYV52M6Su/WM6WkQ2b7mfKw8+V4OxixnTujn4CSci0CdeTmIvVJeatd
gULzIbzXxN3nAYfn2mI4HKaMj1fj/pcZ+oyvpHPquSBQoE4deKsPbjR5gGtYLkBt
W/4CIw2WBZRQvmQI+wC9NFe4QLgpVWCJ+FAtR8DqeVOd7IL2eGr7NCF8OlbV+839
YA3fh857/z6HKe7is3kh1fBBOvWtylFwobaIQzUS0ZvzLZmp3NsiLmneBDxfKI3w
PipX5o68qRLgBDy75i4N0XdHkG8kKXHiqR6V5AfeYFtxYREhsUMTrLLKnvLWoBTU
Jsri9FYCOr4mEE1m7hudORxLaFANxMmIpaEG2P4BGQV+FD7n24pEKJOXeIiHD5eT
+XEq/KtQsLBQ/mY7bxk8wTrphTTCh3dmenR7Ru5VL5wHyDca4ytU73Fmf6U0exok
StCRFuujqzUX6JVzrDBgkljp0VVZqfXLB50ojGdr4UztPfd6rrqLTgMPeolwBX3b
TOVok5iLMCTam4XzybqUiZr3WgzJnqiQD1LIWxLtW8923nAp8+A=
=N0JZ
-----END PGP SIGNATURE-----

--ks39HFS5rQ83rKg9--
