Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149CB54FAB
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632732; cv=none; b=AI7m13hO0/exi+16nJa3Rv2X3DAld7fFYxIU7p9uhjHEU+yBMy4dn3tVs/8DTyjtWd25C/x+J5PfAknSZMgOpn+W7D9bmhJeQkn4l2n4r3zo5dOgG2ueB3Vvp7spjuAizVCHB9zrmYxAMSpthp9BaoGuAbI7mV0dPjejeRq+Ocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632732; c=relaxed/simple;
	bh=Kr0eZdx0ZbGRGGnLu24M5hjhyKo2+lwRjm5U41xOjE8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov35zUEBiklLqLkXP0tEwMIn7mkkm0EzIlSaBS+szKQENGiJrKIez0E2ZgHNtltKMg+LQtB5RsXqoxdK69Fgx6qikrg709fv41MnLvtakex1EzNSq1ZKYuKPdeB8o0ZSwDRI9SZmCXwd8ae8ytS/5SKKbvWmprL2/W4o2WUYZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O9DW2HAi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HdqGlFHD; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O9DW2HAi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HdqGlFHD"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C6AB01380231;
	Mon,  8 Apr 2024 23:18:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 23:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712632729; x=1712719129; bh=3faNcniEwS
	9R+u2JHYpkup16+HvysckuQGuF0bepS9w=; b=O9DW2HAiTWf6t7tVr1VKEzHVxj
	VZ/jOcqxdfnm2ujluWgmOOvIxe2fcacPNfAvAoa4n+CVLKawAqTMoYKAKrWNSFIQ
	xvcrG0csLx4pe3GmKPhDp+wNPeubDBo2SkknDxvdZOp9vG/ltl1xOWD4CRTlscF1
	oLyOIm5g6As1bB1boIV4+h74GbPyij2O8Ry+7uWYfLdtx/3r/4yQnoXRTzYcVQSb
	OObpcVbJrURrPBh8dL6ZUCjUEJmP5NiLnlwrc+YSt+0pPQXYCPg+lWrDXW8asz0c
	+ugP+Hv+MS1bcfyQTlLYgX031oSq3TfOCL+cG+Rv/hEipaFQaF/OnsiRvcdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712632729; x=1712719129; bh=3faNcniEwS9R+u2JHYpkup16+Hvy
	sckuQGuF0bepS9w=; b=HdqGlFHDYhBXnlJP29s2M1pvYLHZWil505ZnSOM7mJbI
	SfyxvIiCE3PMl4Kw7IJ5UghgYjopmA2Kso0x9mMTig31jCxFEu3MRHYryM5zec36
	d2VFg/iHTGWafBYZTA8YEWHL9dMpy2JN/tUKppTI1GWGrsCL0zi5QFEplTA5IT5E
	bp2gLpUAa897DoYA94SWy1RuRZ+mCq3GXngiF6pqqmIxqBj1jr/sB5dR75W0vblr
	dGEKuuEuRDHcDno/oFg2oTNmg6xDDE+acSdgE1kBHnSDu05Q6MKMT/NfKBEGzeNc
	42i1dWI1BlSriCdC/nbaXeMCPhT4WvauCrlaA3z9+A==
X-ME-Sender: <xms:mbMUZg3Jhf3rNSYI5N2Zq__zlIP4c5iXqN-KB9gVdGaNIrmVFEn4DQ>
    <xme:mbMUZrFkigqOju4QoOXc2SAjIBTVWVN93cSnM0lxYycOIE0YjIE-SfDqXTMB4Q7zT
    HPSl5dmjtKXvmhB5Q>
X-ME-Received: <xmr:mbMUZo498Bvp7fjY4yXiI6jJGQRV6VpPmRVUDYbHjpOWvp4NBAQECzxpicVvn5Wn7ZIQYR6dubTcRLaFWBLs_ac0sr2IZ6beNrC9a47vKxG0tQlW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:mbMUZp01Y-SEqZT0LkBhhZM5Rleyv6eSbLnljDW6D87N9r2yOFr4sA>
    <xmx:mbMUZjGmaC-psw0SHM9NgCIuWvpbrGsjypFfCH9ORkXNa-tW0iJiVw>
    <xmx:mbMUZi9l8Wj87qbRpDRDVLfJYXwIwaUKiLvGXv95i8WH5JjayadlFw>
    <xmx:mbMUZongoQtfe_OrPERgg_wgMkLXQqhkibrr_EEdxSr_kk3jvx9Y-g>
    <xmx:mbMUZrChaSuKKtbVNiLP6_KYgP39eIqwGddh7ku0jjLrt-mZj4dz_82j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 23:18:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a4e512f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 03:18:40 +0000 (UTC)
Date: Tue, 9 Apr 2024 05:18:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/10] reftable/block: avoid copying block iterators
 on seek
Message-ID: <ZhSzla7GwfdokQbG@tanuki>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
 <cc5ff0d5988691043206f9e912f5ffa1bcfee94e.1712578376.git.ps@pks.im>
 <vab3mzg3meohikmfl5v57uxj6w7w2odrx7cvhmoto7am2bl2yt@6l4salel4ko5>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ZjEtHhyaDZYrKwi"
Content-Disposition: inline
In-Reply-To: <vab3mzg3meohikmfl5v57uxj6w7w2odrx7cvhmoto7am2bl2yt@6l4salel4ko5>


--5ZjEtHhyaDZYrKwi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 08:29:14PM -0500, Justin Tobler wrote:
> On 24/04/08 02:17PM, Patrick Steinhardt wrote:
> > When seeking a reftable record in a block we need to position the
> > iterator _before_ the sought-after record so that the next call to
> > `block_iter_next()` would yield that record. To achieve this, the loop
> > that performs the linear needs to restore the previous position once it
>=20
> Did we mean to say "linear seek" here? Otherwise this looks good to me.
>=20
> -Justin

Oh, yes, of course. Thanks for reading this carefully!

Patrick

> > has found the record.
> >=20
> > This is done by advancing two `block_iter`s: one to check whether the
> > next record is our sought-after record, and one that we update after
> > every iteration. This of course involves quite a lot of copying and also
> > leads to needless memory allocations.
> >=20
> > Refactor the code to get rid of the `next` iterator and the copying this
> > involves. Instead, we can restore the previous offset such that the call
> > to `next` will return the correct record.
> >=20
> > Next to being simpler conceptually this also leads to a nice speedup.
> > The following benchmark parser 10k refs out of 100k existing refs via
> > `git-rev-list --no-walk`:
> >=20
> >   Benchmark 1: rev-list: print many refs (HEAD~)
> >     Time (mean =C2=B1 =CF=83):     170.2 ms =C2=B1   1.7 ms    [User: 8=
6.1 ms, System: 83.6 ms]
> >     Range (min =E2=80=A6 max):   166.4 ms =E2=80=A6 180.3 ms    500 runs
> >=20
> >   Benchmark 2: rev-list: print many refs (HEAD~)
> >     Time (mean =C2=B1 =CF=83):     161.6 ms =C2=B1   1.6 ms    [User: 7=
8.1 ms, System: 83.0 ms]
> >     Range (min =E2=80=A6 max):   158.4 ms =E2=80=A6 172.3 ms    500 runs
> >=20
> >   Summary
> >     rev-list: print many refs (HEAD) ran
> >       1.05 =C2=B1 0.01 times faster than rev-list: print many refs (HEA=
D~)
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ...

--5ZjEtHhyaDZYrKwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYUs5QACgkQVbJhu7ck
PpRBiQ/8Du/9DzlaZo0XTyq56Ps3B3kSS1u8mNHYTf1ylr4Dj2yja/V/npr77cxU
VeVlE/jAmw3cBMYGGIEye99fDLgQKESFg566JI9Fwo0s9953ek3aovoaKbJMaZIL
eV5asQjzQjAhZbsLaslFZK5ZfU2m3AO3eil0/45mVzWOlEc2OCAiWQIbeVuj+zLy
s/RKBP3agku16O5J+LbqeCMAuQhg5JzRGQfH6qMqNvhjGf/acxbSGNTEL40XQ7Og
ccfai/LuxSGqIj0scfq8cjylxgmUGbVUkFGAbuKl3wvyHkuV+O4YZ08l0/LkKHbM
q9BxV4SwdFqZaJcApEXD49CfiKSb4gNhCkxmn8UOcmvwPHk1j/9CtJ+R5EPQKL86
T4j4n2Ag0QmR7sqfZMDiEWhSJ9Ithe0rIITpLbuJX8mEsObF8pxi7AMSmJJ/i2Qb
YvfC+1VilcgL3Mc3SdARz5ov6FG4gAji43XU4ICxTmU+M8vXv5vVyPVUudMM3vOv
hViPmS6erUFCn1uvVjPv/+tPdySdN+h8YJM14PtjzAc47ddpdFSUfBaZ1EZz4o0c
zTUJFjKLABGkFzz9VK9y8XZqDQyUi7lYBPlAirBV9IO5Z1GGqfJXt36B/g2QGaF0
SdObK1Xw8W54j5z7LSZWKv0N5udii58BCHNV8IJy7LbIwMQP58g=
=xyg+
-----END PGP SIGNATURE-----

--5ZjEtHhyaDZYrKwi--
