Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD312E78
	for <git@vger.kernel.org>; Tue, 14 May 2024 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662488; cv=none; b=ScCiS9nCTXq3bbOGGz5ZXw0TdlzCETLhdZfpja/29v/pOYs+tDh/uoQx1arr7uQc73+Zbh4lY5ZNLCCsNcnTnzyyOpZlNoGpHN08/N/Mkoq9sRbP1QsjFH12kCP6Dftwtv6SDQyG/OcA1mjKC5MLtnaJMnBDXd0VxtR8pSqw0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662488; c=relaxed/simple;
	bh=4QBlKYKkNl0gvYWD/IyhrfV3YL6W8N9uzxbyI292QTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udZa1QsmjEZ3OCVvaX/tjM0ILxhL496uQq63v7S0FbsBrZbc9Y49DZ9wed0qZPrD8i/k94Z5BRbKyIyBDe2xwMLfpU8Stv3y1cJtM9u6xLaoWpn+h7zDXWx5YUJsAPuqpzBE9sKdh3TLBmhgQxtyXvg1QLBmRPPFQ3HfQINHyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HK4b5L2U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fzsYaKuM; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HK4b5L2U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fzsYaKuM"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 60D461800181;
	Tue, 14 May 2024 00:54:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 14 May 2024 00:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715662485; x=1715748885; bh=4wqWJShDz6
	mFV/uaqzLQnwOj6+XHPhuXwau8B0zoitQ=; b=HK4b5L2Uplht9mjaNxlXA2paMr
	OLENPwfVf9jtELCyYY97oxYfBLxH9y2ZYJmZbV9oNVqIkYo0DevgniO1Vtp2Uwas
	B75bfvnVr2B3WuEuLJl/n247CWbVESVFrf+odYp8sOj5AKxS4iuq/28fyXizl+DX
	RTFx57evVy3jfEvqj2s+cGLUbgJlFVjh6zYuDTQytAiHimi/sIajcH4x+gh8d/NA
	U0In2Xm2wcboS5K/WdSXy305FHshRkDADSgEW4buFlY4qf3adsvjFpPUJ0qMEx9W
	q6spKGcJK5zPhuegWQhNtyP/JeqShUyBT51l8Jpub63YgAKYA/K6rIUufkzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715662485; x=1715748885; bh=4wqWJShDz6mFV/uaqzLQnwOj6+XH
	PhuXwau8B0zoitQ=; b=fzsYaKuMt6yyP2EFfeetStZy/TAPRS1K9udbwjkeGKtL
	D65eOVM2q7GDPD2rrqc1jhKtXO+BAzV/ciJwWZ4QjIF98NhxgA95IKz0gGPSWTlc
	JXJ1VTmpwA/oEX/wp7BVyw6QXNOn04JykOQ44BE4CZSl3HX7xlpTTXXAaVVdOFz5
	yb2uyWfQq7OhmnotEjrPriJd3bz0YEp4gwOHbKn4Dsid+CE5w8G7KHOaiNiWrLX0
	TXHbd74JoI5JI8M7nU0gfjykVdM6DN5b58HlyyV70aeiKNj5SdXSMXUXz+lEQS4f
	3yQRKd5WhsBygM0VX35xxIMmIJKNkj8VdxAsjhAjaw==
X-ME-Sender: <xms:lO5CZgrY3tO4oQUFH9DHuVThqPBbACvEU10Hlos9e3S9xHNnSgA8aw>
    <xme:lO5CZmoUKYl_QH_JgAjOJjOoKYMLtdNco1zR8dAdElU64TIy-XvNP4I9mcZDDqNNM
    90a8C834D8RMZs3mw>
X-ME-Received: <xmr:lO5CZlNF7QM0a2QS-wUg6W7jTynMe9YUT8xo_87SYvqwiIUrlAV7qs7XybeJvm-vwCBuU_CVeRKJ1HHLh5TlgcdtTvrjwTVumZd8Cyuo_Zck3jt6RQJX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeghedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lO5CZn6Ctv_KQ9kLMtbGLTsGe2QiEialO78Jj3A4Wea6Lf1JYXqNtQ>
    <xmx:lO5CZv6HXqasqaBXIb9atDic1zRiv2sTsWWr2TPnExcE-jgDvX-g5g>
    <xmx:lO5CZni3fOdsZyyC7cezjFf-6Sf8QJLtluNaN7GtKpw_fKa2QAOqoA>
    <xmx:lO5CZp5_LUIT8I0dYPAiN6EBAWkjGiBv7uRjItdgN9aF6TWBjpXMnw>
    <xmx:le5CZlTLHFE_TUzL4XxwIsx4mOKHaGDkMo6Fxc8uMgdYHZK_3cjAc78C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 00:54:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id af407b1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 04:54:21 +0000 (UTC)
Date: Tue, 14 May 2024 06:54:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 10/11] reftable: make the compaction factor
 configurable
Message-ID: <ZkLujyOtvKBf2LOM@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
 <9d4c1f034038df2ae232b6665a0d9d7ee5833c5f.1715336798.git.ps@pks.im>
 <xmqqy18h1fm4.fsf@gitster.g>
 <ZkHHIgyeWq9FCYuq@tanuki>
 <xmqqmsotheb5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nNcFPZbRHHOo6Ql1"
Content-Disposition: inline
In-Reply-To: <xmqqmsotheb5.fsf@gitster.g>


--nNcFPZbRHHOo6Ql1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 09:22:38AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > So this may be good enough for now, and when we gain the ability to
> > parse floats we may convert this to accept floats, as well. An
> > alternative would be to convert this to percent, where the default value
> > would be 200. That should give sufficient flexibility without having to
> > introduce floats.
>=20
> There already is an established way to specify float with arbitrary
> precision on the command line if we limit the value to 0..1, by the
> way.
>=20
> https://lore.kernel.org/git/Pine.LNX.4.58.0505191516350.2322@ppc970.osdl.=
org/

The problem is that we don't want to limit the value to 0..1, but to
1..n. 1 really is the lowest semi-sensible number you can pick and means
that all tables should have the same size. And in practice, there is no
upper limit, even though it's probably not all that reasonable to pick
anything beyond 10.

In any case, I'd propose to keep this as-is for now. The simple reason
is that we have preexisting commands (`git repack -g`) and in-flight
series (pseudo-merge bitmaps) that also use plain integers to represent
the geometric factor. So I'm aiming for consistency. From thereon we can
then iterate and design a solution that works for all of them, e.g. by
allowing for floats outside of the 0..1 range in whatever form.

> It is amusing to revisit an ancient discussion thread.  I can see,
> on the same thread in the discussion following that message, that
> back in May 2005, we were discussing "intent to add" that did not
> get invented until mid 2008 already ;-).

:)

Patrick

--nNcFPZbRHHOo6Ql1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZC7o4ACgkQVbJhu7ck
PpT6MxAAkGULfU/gA16RkrdtQ7o+qWV43nt4gPybUBoVAcIdz4fpACUhTT/cOTZ/
8k7IvgGFSS7Dy+9UgYab5ln7g18goPrjYesWLiokpY6janyynTUx4eZ/cJnFdIo5
XkQMxrZuQiBkUsGi8cSP6huZ0TlQUjeRA+QaDFenXCBUDbV7YTYW/uZxlnUD76J8
61Tj90lLGPfOMFiN9rlxN12zjymeIMFFIUtWxWqa1p1WLei5g+Lw1Adq/LHDvemR
bND6oMtH7fSjAq9ODfALaIx4knfXWaTrEKvanTWqgNT0TphXHSyRjXhXfbF7cjrt
3rWf1R5V8faEb98+jLnSr8JBDXcnpjMOFeObMouWRXsiVG56yTqG9OapV+TlaCvr
zDbo0jXXg+8y+jSSK9m3A/UFUQZKmMEWDCKMJQUi/n/UnpbBRh7K59Ju+ncwqS+e
fh087P29o9G5WIN/PcIY09sYow+vmG27Iy51xFQUiTYklzGCweJY+tCXrBiITd4c
5OZ577ANS7FIuer2Hl9x5RPne+hHX5nPMSwRIcwxkldbnIw5hOqKQzZEIcVc+M+P
FmVcJyFlmg/Jpcz7MOjWxRcNcDMzTF/ejkzOb1sDbFJ7465v4GmzuKCWb9fsGrdQ
bioyQvmIrciedaFGGKbhwmdwB+fjZwZZo9FRU+IVygfaND/C10Q=
=cMyh
-----END PGP SIGNATURE-----

--nNcFPZbRHHOo6Ql1--
