Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126878B49
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060453; cv=none; b=m6hm7UzMQHW1aAUKRovc+FWv0affYXTR+XJ9h5+2a7z9XC/bJwDvfR3xBqceYw/TWYQZtK5JKlS/p1WwEPao/4VwWCHwIWnSJcrbzTAYs7hNyNVhyaXm24GAdvX8ZtSK/fhvFhOJ5e8EBgpGr1SZOCT3+Nz+vqV9jHZqjKu4R28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060453; c=relaxed/simple;
	bh=d72OZDvsicrixv9r11K5bDigI1wVnMyI9Y7S9n8Ousc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5QkiHP8NQ7+TsvWjeav4JX74gsCjqWcPnKHfa91AaE7aZ1cgKxL89fm97vJMxvF0REvUedLVALDtvPB+tyTyzya9I5w6JkoJ/hwBJPmwd7UlxeVaf5wYwMvFQm14l5+r8SKqW/1AlG4TMBtgqHfjHbYnAdPGKaCiHwbh4mpTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Aqk5RWDa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WhHQg6If; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Aqk5RWDa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WhHQg6If"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id D5BA81C000F3;
	Tue,  2 Apr 2024 08:20:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 08:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712060450; x=1712146850; bh=bgfpEZJJJn
	XqYD4l4YPIB7Yo6ptYc/Zm2MzxKq/CZBY=; b=Aqk5RWDaER8K7elGCwOO82liHH
	wk8pQWmRSOY3MHfHNdsgP86jRQG4YsqNwnBFeQ3y/OTxtEqdC2rHpdZxgj1Y4N7N
	Dnre6iLkV7O5QjTALwvGRUsk0gZ3P5JHEUKQ0ALVYup31/TMk+tLkHplU0Ku1o6o
	w0VmoKzL2VaosXxReUtCDifO8YaAEu3xSxO0SIebQlUcVtgytaQYAnJUdFV7dx9P
	QKzKsJZ+U5FfEVRRIFoA9VtMPeNJQWcxDcxr/xGOMPWFUbAFH1568HMd9OqbK0/K
	PrK+Nf81V1ylB05S0lIdc/TxgXKioyP5Dz8jgcgYND4TtPwSKS41BXJYZcHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712060450; x=1712146850; bh=bgfpEZJJJnXqYD4l4YPIB7Yo6ptY
	c/Zm2MzxKq/CZBY=; b=WhHQg6IfC8yGMibzmDBHxc+Ib61VdlyMIEhhnqnn+wi2
	HiZr0oFFFdc8n5+tJN1Lt3DCUj9YBIoFacJcNznrhyWNCXzmO5W7UkZhNPRkd5vr
	6opqlkxyzJq8gFqnAYS3tNwBlawncW0QosR4DlvlqZbJlgJ5Cpqb8JWLoeqUc6yS
	IkIEUqhCYkij4HCYwYyeseghBTzR3QUNmCPQa13/gXAQ9zLfA4NES/eHqkyNInDE
	VUhBXgNrqmwjANqpP8xdSfd5CKbI5OM2xYjIGBSZgPrUJR+EkDpjgCmqHQRIYW2P
	y91sw6zLeWo2buoyi9Yj0CTUSe3FrW19u3pD+8QcGA==
X-ME-Sender: <xms:IvgLZpxfhew-lQM9JDDSkk_EIv_RrjCsesC0heYG_pmWu1X9Al5fFQ>
    <xme:IvgLZpT5dTw_3lVfpE2_bGc6OcRXs-0JAQbUXvW6fhcHkkya4OiCl_uKYJXNfd-pv
    U-LVS5fUxy87QChGA>
X-ME-Received: <xmr:IvgLZjWURiDPEZP0K3E7KWCHbmVy2ohcEu4UYmkZelLZeh74XHuQReI8DBWortglsnDorRSqHjg1eRs7N71w5uaFN9VP4vX7pwbBPitTsOMe2us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IvgLZrgk9AJz4qIRyXOf9SsNlw56f0Ye1gFLpnNt0yzPMJRxFnQdJQ>
    <xmx:IvgLZrC21EDdvZzuW8-Kz7pOwaIZD2kcK3SWTBdKasKzsXPFfitCgA>
    <xmx:IvgLZkKF2kF2Wc4V5k0-ZvTmMN3x3Q5WQpBSjgeYR5Ggt_wdSoG3Qw>
    <xmx:IvgLZqCaOeU9N_mYpG278AVjTwSiJOSCG9lg4kg_lV6rSFSfiyjuGQ>
    <xmx:IvgLZm74ZzD9xDKWEquSs0kyVkd3VnNGlL8qswQTKOwVadrgc7wwqoYB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 08:20:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92b71b3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 12:20:41 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:20:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chris Torek <chris.torek@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
Message-ID: <Zgv4H66NmLZ_o1IC@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240330224623.579457-8-knayak@gitlab.com>
 <xmqqy19yf40l.fsf@gitster.g>
 <CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
 <xmqqplvadmeq.fsf@gitster.g>
 <xmqqle5xeun1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bq5a7hVlJ9ItzUQ6"
Content-Disposition: inline
In-Reply-To: <xmqqle5xeun1.fsf@gitster.g>


--bq5a7hVlJ9ItzUQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 06:31:14PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Chris Torek <chris.torek@gmail.com> writes:
> >
> >> For these reasons, I'd suggest that the all-zero hash be officially
> >> deprecated in favor of create/delete and of course create-symref
> >> and delete-symref. Of course, compatibility requires some sort
> >> of support for the old system for some time.  As to whether that
> >> means something like the suggestion of ".missing" etc, I have no
> >> particular opinion -- but since the symref options are new, they
> >> would not *need* symmetric options, if we just say that "update-symref"
> >> cannot create or delete a symref.
> >
> > I love that simplicity.
>=20
> Having said that, the loose "update that can create or delete" may
> actually be used by applications that do not care about overwriting
> competing operation, so I am not sure if we can easily deprecate
> that mode of operation.  Saying "update refs/heads/next to point at
> this object" and have it created if it does not exist may be handy
> for some loosely written applications.

I wouldn't say "loosely written here". I certainly know that we do use
these implicit modes in Gitaly, and we have conciously chosen them
because they have been supported by Git all along. It simply makes our
lifes easier when we don't have to special-case creations and deletions
in any way.

So I'd really not want those to go away or become deprecated.

Patrick

> So perhaps we can say "update with a concrete <old-oid> will ensure
> that the <ref> poitns at <old-oid> before proceeding, but update
> with 0{40} as <old-oid> to ensure creation is deprecated.  update
> with 0{40} as <new-oid> as deletion is also deprecated.  Use create
> and delete for these two deprecated operation modes".
>=20
> This assumes that create and delete currently ensures that what is
> asked to be created does not exist, and what is asked to be deleted
> does exist, before the operation.  If we are loosely doing these two
> operations, then we cannot easily deprecate the checking-update,
> without breaking existing users.
>=20
> As {create,update,delete,verify}-symref do not exist yet, we can
> start with the right semantics from day one.  "update-symref" will
> accept a <old-ref> only to ensure that the symref is pointing to
> that ref and there is no "zero" value based creation/deletion
> validation offered via "update-symref".  "create-symref" will error
> out if the ref asked to be created already exists, "delete-symref"
> will error out if the ref asked to be deleted does not exist.
>=20

--bq5a7hVlJ9ItzUQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL+B4ACgkQVbJhu7ck
PpRBRg/+MghB7xrqZBpP7EZxXwhmN9yqjNju8ec30rL+Ec9h7yUop+soAMaixTJv
kuuBFKGvAphZDUm9QRcGxwR41YEtbM5XY+Pmr3TJ+IVDG9KLsjosa8WDllTWwD3j
hWHuBnQInxAnp1mBRArSd16jbhMnkR0ls1YGNKVakc15RC1Tlm66eocbjn/HnXA/
JfS9ANRXkOfYP74GOIuxgE2SxCKe9tCerB0ofyuTAb56/VeHuWjMObRCxobsa8gw
WdRIkbZWNhQc+2HyqEGA1xtFeoX2nyjtDeONcIpFEy1/SaUDN7KlGeeY+LbOKxkv
M7520x+RftavA/7vYerC602JM2dbJeDdee2IeHOVy10bvPbXmXWtxANn42uITnYZ
5AK1m2GSSaUeZ9mOWrVP25efWZt4snXkByM+jy7LSs798irQ+RBwopujdztfHhz0
SNBXPjk7kCFc+I2XOnRr3+23Y4mWQY8J6SN6iFQO8IkLBssWjQpD80vc5eVvl11J
IbzhO3SJqwhS2ETWwpjdYqpirEkAiGsri4Jzyw1EBYlyuHtGtNs9ri+dHtskj+q7
RZEgQ7+TreufH5VskddLykbAWRo4+K55Wbf6HU64hiU3eaY8pmvqvAf9oGWEGCHU
ibvUbhDFiSc6/YikI5oFPTHbs3KAJQoGQZFHer9GLFJy7+6u/s8=
=EoJH
-----END PGP SIGNATURE-----

--bq5a7hVlJ9ItzUQ6--
