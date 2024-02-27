Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E95465B
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017369; cv=none; b=N+gbAsKwoHJtvIo/LQiWbBm+PDizSCcjPjrsfovnwR6pDgpjfANK+bKkK7MpNZ9TodzyGKWGAjE98TIJVDelt5KDwG7ivASk+DNcX8mubHQCyr9HwVYjjfIq9H2C1mi9OyAdDKpUSzLR7Xv6E1Vkf0X0OCRj5fhol6Za2qPSBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017369; c=relaxed/simple;
	bh=72BSzgxSUoIZ1N7oSzdTKre78ZuPtfrb5fCvlH5Fpzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz2oBwwuqms2X1VkhYK1/tJBkl4EpmM54nMsnivD6fIBSthZBPkE8dByOa5IBhlYKGK64XwB2oVcvrOq3zcRYiFPktChl9eSXyJx2fjDzQBroWt9SFKWTio6zG8aRwK34P13waroO3Uz7I83g7cyNZLmRoRDhMF+gmIxZkkMd0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CnsICbag; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mHTsAjm6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CnsICbag";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mHTsAjm6"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E2FB711400E7;
	Tue, 27 Feb 2024 02:02:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Feb 2024 02:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709017364; x=1709103764; bh=72BSzgxSUo
	IZ1N7oSzdTKre78ZuPtfrb5fCvlH5Fpzo=; b=CnsICbagks0MCGVQT8DcqgZKVA
	opmD/O2QlaPFqOhIr1+W2pw/Jdf0stfx2s039umvmSEkfh1JbpPF30mIWaUQl446
	Z6EIFSflWtUUnoGPCkV0wQq5HaPsXq/edno0Qd+iZlciBWD1pqR92LpItffVs3lA
	PlK2491m8fR6nKiDQnmVKWX5BEYbLBkKEOgU2A3X2Vkgvgpm2hyMUoAPCN3VrgMV
	H5XKlTsJJYVnpM8BCZ4Iznq5OKZZ3gWRfaPwUo++t2xE4hZVumu2S8ITLoQVg1HY
	SZ+FcYt5kRUgFtMjs9bGJyyIAxUjtHuRQw33KUSB974XHwsV8RkgTZS6/SSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709017364; x=1709103764; bh=72BSzgxSUoIZ1N7oSzdTKre78ZuP
	tfrb5fCvlH5Fpzo=; b=mHTsAjm6zrcKmuqvKt2JpS4i3LoWNa2GwmK9HEAdJrDO
	xwypFLHVRNnzrzc7+eLSlVwVeIhCeHr4zQMi/8/VaMhslQ1YIXUZELONsgwOkTJD
	kC65A48QIOhZb1xjWfZKdvT1QWw+w51Ji0DAZ2ju7t0FKnWgJ/TUryMKWLMlWPw5
	tqKs7GK1J6Uzuo8DDd9vfW48qB1fs8qT0e7Colv1YoCgYcCmkkyrgF2i4xgIbVVr
	BTgsjuzDvriThAlDAD6ibZLhxCJvUAcRWaGHXFBRGetKyyvbogmEWK2t73suSXjQ
	HdWJ3EieQdGTeb0OePxQZjvMuUJkBMMtvhZC3N3bcg==
X-ME-Sender: <xms:FIndZRmTLdSRRJ6HmSLoKAzQ3ZzFxiGI-Do_u_1zOgUsDk4BO0tgmg>
    <xme:FIndZc0zktpKUf5yXU_5c-yAQ5ZnKnVbstXIgrTvxMv7-u9VfeDTmJWqt3iPIWVbS
    vYSFkxoTX3mOyApVw>
X-ME-Received: <xmr:FIndZXqUJulgYEWo2fVmydjwbtfT4eAw8eyuTI7LBtY4GiMqSfgVKBSoVUlP8isIDAHFQTwIqZ2-1iATd1nUykaQesh8o6mMgxrfzk2gjs8jwvgh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FIndZRlALuAotuoZq7DlhxkxbuUPEd4a6HRvcO33J-2l5YL1lzx6Kw>
    <xmx:FIndZf2ElwIxWas72Q3c3QFeqUkTNd1YQT55D6b_0SED9jMzsrVMjA>
    <xmx:FIndZQuKIbwITlxvpbhzPHBF0NSjZo4Uy8tsPOt5dQBtaNepMbpU6g>
    <xmx:FIndZaT6t_uPAho9qwxXyehRRrlVpuk6pp-IcMHCKnw3ULBueh_fBA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 02:02:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61bc701d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 06:58:24 +0000 (UTC)
Date: Tue, 27 Feb 2024 08:02:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.44.0
Message-ID: <Zd2JBk7JWEGENAiu@tanuki>
References: <xmqqbk87w164.fsf@gitster.g>
 <20240224051040.ftuo24smozqugbde@glandium.org>
 <ZdmOZRjJ-mClBR02@framework>
 <20240224195550.ignhzidmdy3ce6q4@glandium.org>
 <ZdrnvKRl8oGPJxOD@framework>
 <xmqqbk84jwfy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="itAhnWjHD6u/5DGT"
Content-Disposition: inline
In-Reply-To: <xmqqbk84jwfy.fsf@gitster.g>


--itAhnWjHD6u/5DGT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 09:16:49AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > That's ultimately the reason why I don't want HEAD to look like a proper
> > ref. But doing the "refs/heads/.invalid" workaround shouldn't be too ba=
d,
> > I guess.
>=20
> Isn't the reason why reftable backend initializes refs/heads to be a
> regular file exactly because we want to reject an attempt to create
> such a file on the filesystem, though?

Yeah, "refs/heads" being a file is also part of this mechanism. But that
wouldn't help a client that e.g. uses git-symbolic-ref(1) while assuming
the old "files" backend, because they would now get a plausible value of
whatever value we have in there if we were to initialize it e.g. with
"refs/heads/main".

That's why we have both mechanisms -- it's a bit like defense in depth.
One could go even further and make "HEAD" contain complete garbage,
only, so that anybody who was trying to read it would fail immediately.

Patrick

--itAhnWjHD6u/5DGT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXdiQ0ACgkQVbJhu7ck
PpRDtg/9EaMr0UQVM75HXPC6/nqdTTvTIIWiZbNQBdc+kb5rlLgdeQh1RlEElLnI
+GFIh2ZGYFDPjOn+xFidp2zPXt8tW55QMw2JLhkshtVJHMpNBPHHvXM2yC0Zl0dc
oiXxuEikAQoH7R00SV17+RXe5bsxY4A8BuocQNhghLY4cWGbhkT56pdyTVNM1loL
uXBDGPq0zPbmvUJMbjXEPKYEmfsKUit/5qJxmuL8LZSRAk7v+v6wOpzZGuut3Flj
b4SzGVmQpGONKwe4cR/X6jwm4rf4IRrz6OtrysoJTVXFTmDOlEb78LsfHgvGbEdk
95rbLZgdi0Yzv14cPQmIKwqQSaaXhxF89CeWvA6mIhNP6qJyaDv0+tt7wdPtkaxM
EA35uAutMddwx2B97PP5jfp6kXl5RgHgP6sUeCHq3yfpme9m4Vt+lOSNulmNCf7b
RevcdguEKspRdyxoc5kRHvmK/Gs1Nay670IAnX1pfrEWPILlAxk16Ln2vkIg50Qe
xlw2IlqUnAxa0XWgoM/REmo+f7Wkcl9qaLbJBkOYWVHekxzrR4MXdJnXHTt/rM3M
0wMRlf5qMZilQrvDIreFPT9f77SfiBrJBGiCrnH/koZKLmP8a9PgzX9BJ8KmNmZa
BK5tw4xa1qEDujBGu/rStjkyR67oGfSsjQllBuVg508awamwSUs=
=E8f9
-----END PGP SIGNATURE-----

--itAhnWjHD6u/5DGT--
