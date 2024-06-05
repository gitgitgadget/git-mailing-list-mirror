Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6A1922E9
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574551; cv=none; b=qcUIMNIeAAKjBRD8l7J+U5AnYDyqL/eERydCMM3KwYOFKysdmYrR7xtfCFAlCdbk5Mx4bF1X9HE880tShDWfOKSqRQOqm6JqPnfqpPU01uuED3lQG/0UEghReRa+l5HZ8BkIRp2XIARURwBHqFvQczZ1D+IeFjHX3Sfa7uU3X1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574551; c=relaxed/simple;
	bh=QTo55JuJFjWo5a4+5jgLYMo9WWx5bSpTYivGR51fOkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hw/xpcBlRB2dIQS8bfdLo+rvyqM2beSOLEQPCot/46Sfw6IktgEmV8GtBtxNtGyhtCAsx2CpPhCwUfqHpZCK4xq7uwR8wNyWHdzfcGbwsQY0vaJZZacB3DJxMlXrIvcVM3YA5ZlzAj+ebEjezzHECdxAoBniO6+jCA3+eXagntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DMgTaOLB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LiiRudc7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DMgTaOLB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LiiRudc7"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1F726138018E;
	Wed,  5 Jun 2024 04:02:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Jun 2024 04:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717574549; x=1717660949; bh=QTo55JuJFj
	Wo5a4+5jgLYMo9WWx5bSpTYivGR51fOkc=; b=DMgTaOLBD+l2jqwdFQhd1iAS+m
	y+8mTAzMITYXsSV7BURn3w909P3pv7tm1B2wCc0GBTXW6dAwAMX3kBLj7v0ude9Q
	s+vIorK0LsO2g50R4yLooi0VPUqPonTxvgeal4JeFuhvyyM9wQxH+7fI1k+W29Ij
	g3QYauJ3GP7Q2llqAeMyxRD6YBVz+jJrfIRngSA5naJMMGb1meQCUogY/SITFqA5
	0mkeJ9qDtx2fx7Ux8RKjJwja5JaIkX/I4eX9bMWKC/lKgK1p3Rt+QAShLdDfsUda
	rMDgfTBQmOWEiwbxZ/YqNxqi6lghTUcLM5PTQ86P7Ehn9xcMXinWZyr0BNrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717574549; x=1717660949; bh=QTo55JuJFjWo5a4+5jgLYMo9WWx5
	bSpTYivGR51fOkc=; b=LiiRudc7PGRyZncAWdlwy29v1EoLLIRyHK4ZCmwCUxmT
	Y0e8Q33Ykb0NREpZcTMiDC4z4kE5o2dfOMk8WBIzHkjJX48Ia+IiCa5XkFbh2Xoq
	ect6nxYe8FWpvSWzpFjw2YlgCAqWsOmMHnw5L9cyEPXZkeoGaedOCxI/d53m4M0o
	oDT8mT14WyedIIETIkgKwRJr4sQNDqK/6/EvtGRyYzq3EpoWHFoy48roH2Sfo0LP
	Ij3JLnosZJ7YMrzP8RFawqVHA6sexy4P4MRB4K3DfHfV68H4YAcnlUoVuL/ACMeA
	gawW504pPNRL7MJarWfCDK3QhKRqY0DgbOcp2P4BeA==
X-ME-Sender: <xms:lBtgZrZesI5fp4njI40AAiPfrD_9vDS5MhQBD8XZ8_5DRY50RjLmBg>
    <xme:lBtgZqbz7aG6s8rQaNhamtJ0FU3JetAa6lGVdLwvU1Q0nf3XtNzUG8h2aFO1KZRcc
    --CgJzBq51GhZ7S_g>
X-ME-Received: <xmr:lBtgZt85oEPiP012yLRgxCF8PWpaORFoPmpOJE52pNj68zx7XQEaakzqbgAWwHgDOJPrW1p0xyR7xwUvMz4IoAgWUlbabquIuo5dTAlgS6SF21U1jxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeljefftddufeekudekueelveelhfeuheeufeegueekteeujeelteeuleetleeg
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:lBtgZhpqrr9eJEQAEqdThBj0Sz8tj1aHjQN0XJWd4UVCgLtJjOM8oQ>
    <xmx:lBtgZmpN0ui-BuC8qZvdX8wWf3wRUp4h-uCp04fflXkSbQLq8uNv6w>
    <xmx:lBtgZnTOtt2Iq2B6GKshsirSPXRB9xabAxfPPravRYCj8scH72nLSg>
    <xmx:lBtgZuqw3wGdh4uW5c8-idtJo-VNGC2xylfMh_lNbsw6GLtOzy0cbg>
    <xmx:lRtgZpUON-cCbOaXzifFCqNSle-a0RZgCsVsnuTqpB0x7kM5InX5xBLn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 04:02:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9b2664de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Jun 2024 08:01:59 +0000 (UTC)
Date: Wed, 5 Jun 2024 10:02:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 0/6] update-ref: add symref support for --stdin
Message-ID: <ZmAbkVtgfriYsOdX@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240530120940.456817-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M5V7SYP/H5OLeU0r"
Content-Disposition: inline
In-Reply-To: <20240530120940.456817-1-knayak@gitlab.com>


--M5V7SYP/H5OLeU0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 03:09:34PM +0300, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The 'update-ref' command is used to update refs using transactions. The
> command allows users to also utilize a '--stdin' mode to provide a
> batch of sub-commands which can be processed in a transaction.
>=20
> Currently, the sub-commands involve {verify, delete, create, update}
> and they allow users to work with regular refs in the repository. To
> work with symrefs, users only have the option of using
> 'git-symbolic-ref', which doesn't provide transaction support to the
> users eventhough it uses the same behind the hood.
>=20
> Recently, we modified the reference backend to add symref support,
> following which, 'git-symbolic-ref' also uses the transaction backend.
> But, it doesn't expose this to the user. To allow users to work with
> symrefs via transaction, this series adds support for new sub-commands
> {symrer-verify, symref-delete, symref-create, symref-update} to the
> '--stdin' mode of update-ref. These complement the existing
> sub-commands.
>=20
> The patches 1, 5 fix small issues in the reference backends. The other
> patches 2, 3, 4 & 6, each add one of the new sub-commands.
>=20
> The series is based off master, with 'kn/ref-transaction-symref' merged
> in. There seem to be no conflicts with 'next' or 'seen'.
>=20
> There was some discussion [1] also about adding `old_target` support to
> the existing `update` command. I think its worthwhile to do this with
> some tests cleanup, will follow that up as a separate series.
>=20
> Changes since v2:
> * Based off 'ps/fixleaks' (commit: ebdbefa4fe9f618347124b37d44e517e0c6a3e=
4c)
> which brought to light two leaks, which have been fixed.
> * Adding credit where it's due.
>=20
> [1]: https://lore.kernel.org/r/CAOLa=3DZQW-cCV5BP_fCvuZimfkjwAzjEiqXYRPft=
1Wf9kAX=3D_bw@mail.gmail.com
>=20
> I used the '--range-diff' flag for 'git-format-patch(1)' this time.
> Also I'm on vacation at the moment, so my responses are a bit slower than=
 usual.

Thanks, overall this looks good to me. I've got a small couple of nits,
none of which are mandatory to be addressed from my point of view.

Patrick

--M5V7SYP/H5OLeU0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZgG5AACgkQVbJhu7ck
PpQNpA//YaWitI0rluXBCJmBhorfAB9YS1REG+sHE/HWYgWgsgWGtxWfcahj3DhI
sX7Vx1lDwkdmIjKL1hz6T3m5+fTffnwtnyvHUtqJ7eyrMaoAloozK3rlL2TSvL1f
uIkqGxuczzK0DZMNxvxZsnkMS7F1JAnfDvMqenCmJwxWPiDb7SguER47VYS/ho/C
4TzzrVnjpKfeX19SWUj1n1TgimJmcZl04bKzoYB4WCra+UANwf0iBoeY+gi9thhX
QUe4g/852y0uMtVB+QoIWaQ6+zed6ZMgmvHmClGC9vVfsbkLRQa8q8n6OxB/STs0
ksFqVrA9L0QEW4L6pWhmsxKt8OZOrn0cOdBVkTqE+xqTn64hwGvToKB8g8xCDtW5
KYH452BTDDNJJmT73DJQSheaeFnda+VKRHUon2SECFj5nz2gKnwTU1HYRyLH48Ov
1/SgfRuAlV9uqv1EKgXd27TtuG58IZM6JYWzQLaYNxWE/PwEoPnwQq0+B6PogcyG
m5fTmEuri+NdvAYr4Dwu8CUsGpNUYD3Vszgu8C3ja8LkLPNgXXtPtx4Yq4e+6CFT
cgFfhsoVKmQdwjWC/Vij4bb9PR+aspkQ4EsQnmL9LKMi+gXL86qFidhn/xD2LOJl
AbP1jM2gpUKjbWmJ684Fjx7iM+sQJCZjCPlBMSWSUsjHqCtQFcs=
=knhC
-----END PGP SIGNATURE-----

--M5V7SYP/H5OLeU0r--
