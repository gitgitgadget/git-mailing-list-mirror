Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B656469
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525390; cv=none; b=EvqLA7j3OmiGn1USMCnlJ/9Wuo2dfHFYadxSAoEbspXJ1ykWqIrFiIwvzcouXF+pFQAEO6WyBJxiqohC87eBir8VBojuolEUQVI4BugHH0322J6NeqDlXpm98/fj4d6w/JTLGVAty6R67zRxBA99IdMYw+0+OIsWA0cE4OFq3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525390; c=relaxed/simple;
	bh=xvVro9CHn/2h7VUgN0UirtZrkM0K2m5nheie/nZxdDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIA+SBf6Dbb6WMaIvSwlxvW/RBe85J6qN+hyY4AtitWnCOjW1YYANHUzaK2HEU4/Jn44aqd6w3A2j6bIOSChmF0aaGd4XMtGXP8MZRzS2G+uryVwBwLa4VXjIxTr5MhvT4rSnZDgH5mz2+7t58FykU1Ntjl4fIUz1TwrvQrG2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lSsH7Wyf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tpK/3CJ5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lSsH7Wyf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tpK/3CJ5"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EF8C41140093;
	Mon, 29 Jan 2024 05:49:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 29 Jan 2024 05:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706525385; x=1706611785; bh=8WTz3YnQ+V
	Pl3zkwht42KRdOrZVCdZSU/zrFYlYUSWE=; b=lSsH7WyfTgIeVzBdTja73WlW9y
	QzPI5F6SChP15PaSTKAB/RVyD3UyBSioCpmN7SHAPTpgWkCKkaiLjTBHI4EsV8wF
	o7sBmjhblFm84TM5T1NvJ8q+xee8gF16tQsbYbMG/SlEPLRLS8VIRUonqWeF479s
	xcswCOVQnD2N7axXwbvLRsPm5uDPzcrywlPBKOCgoZzy+zrrHK40eEvSPJTFKLZ4
	g62gSCGOaSkRZ0yP2t/2KxfjPlp09MYlWxNIobQzssDMe9ARstPHAR0LecWpEnP5
	c2b3omzCjU1D7aps6iWCNPCyr3hRzRcjtph+wqlF/WOkIVX8B2/1MVPN02og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706525385; x=1706611785; bh=8WTz3YnQ+VPl3zkwht42KRdOrZVC
	dZSU/zrFYlYUSWE=; b=tpK/3CJ5BsKI1ulg9+eqKfzNkIxDzA+U0CVSN5YLDMog
	KZG5m8z7qaY7ql/RMVVFA5Paz14Y8n1BROnXlPWMmOb8hDdfBnGjrOSkqiWumADN
	EAtLDkhBvhYmU3YRfAGWUtYEA5Y0+lybzSYvm66cg/coLKUz45oEGssdtyMYW1Ks
	HX9K3NgQCqRIQfHNM6NYd2cGq/jd6bxZc63RxLSnWhFfwdItBMQftNW2L6FvcUJh
	AzXWOwkmtaL5JiFsu0nSshKs92qA+suR046xu5DQIZb3TStSnDZY+AFTJ/8rcLQC
	it4f8uf/V1tNAvBL7EX505Nwn/1y/o5MH8DE8b2CXg==
X-ME-Sender: <xms:yYK3ZXfaXjA-wYpBg-Vsss0TczDoJCOHTJnH-idgpZBULBilinboKw>
    <xme:yYK3ZdMKVLAyuHeDpbbdYk6tZ07DQbcLT6t_LltxqNWqx10ehdOeV1L7bfJQFb4us
    7kgOv88b4O-eYf4cQ>
X-ME-Received: <xmr:yYK3ZQiGZoGkCyqX3QFFRaR9dd4C764pKqvm1b6wSnb8Qag3XwMXeiM4RWhOFYFnl_h2GuddvlWtB2D1948LPQtOO2YJJFHZVOMNz89cBBeQJ-ogzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yYK3ZY-tVfmbuHrvT0svTfEDzGT8P_fM04Hg89fRShnVUbupyYIOFA>
    <xmx:yYK3ZTskgWG7cJFLLmCmFsIIiqpngjmga8DCGr00sJp0ulkTENOupQ>
    <xmx:yYK3ZXEL1JsXAoP0-BVy3Q_DKv3ndM36uXTF0RYuY4r_QJ3PU4sGtw>
    <xmx:yYK3ZdKWSPssFhyKC_ITCMknOBtkRrQTnKoAUsdet6HMJPFDczVCqA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 05:49:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 154ae122 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 10:46:25 +0000 (UTC)
Date: Mon, 29 Jan 2024 11:49:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/6] t1300: make tests more robust with non-default
 ref backends
Message-ID: <ZbeCw6DgIp3h5gMN@tanuki>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
 <0552123fa30243d6d8d6b378991651dd6ade7de3.1704877233.git.ps@pks.im>
 <CAP8UFD0p-OqYuTrB5m2uq7BRFko887bKszOLtP5peP-A79g=BA@mail.gmail.com>
 <ZbDP4ntRqrxX08yk@tanuki>
 <CAP8UFD2ZoV74jx3B_adwYENGtp9fCH_oVjW4QJXTZQJ0=_aeEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2G6E7HkfnmgXShJZ"
Content-Disposition: inline
In-Reply-To: <CAP8UFD2ZoV74jx3B_adwYENGtp9fCH_oVjW4QJXTZQJ0=_aeEA@mail.gmail.com>


--2G6E7HkfnmgXShJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:32:53AM +0100, Christian Couder wrote:
> On Wed, Jan 24, 2024 at 9:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > On Tue, Jan 23, 2024 at 05:15:48PM +0100, Christian Couder wrote:
> > > On Wed, Jan 10, 2024 at 10:01=E2=80=AFAM Patrick Steinhardt <ps@pks.i=
m> wrote:
[snip]
> > Hm. I don't really know how to phrase this better. The preceding
> > paragraph already explains why we're discarding the extension and what
> > the consequence is. I added a sentence saying ", which will cause
> > failures when trying to access any refs."
>=20
> To me the preceding paragraph said that we are overwriting the config
> file, but I just don't see how for example the above test overwrites
> anything. So maybe I am missing something obvious, or maybe you don't
> quite mean "overwrite", but I don't see how the extension would be
> discarded by the test which only seems to add stuff.

It happens before already, outside of any tests. See line 1036:

```
cat > .git/config <<\EOF
[section "sub=3Dsection"]
	val1 =3D foo=3Dbar
	val2 =3D foo\nbar
	val3 =3D \n\n
	val4 =3D
	val5
EOF
```

Overall, I agree that this is rather hard to discover and that the tests
really could require a bigger refactoring to make them more independent
of each other.

I'll send another version that mentions this explicitly.

Patrick

--2G6E7HkfnmgXShJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3gsMACgkQVbJhu7ck
PpSYkxAAkAvA/Q4O/Q9IqksVXP59a9oXU3z7NhFysjvrqJ+OSB98BHUOu5RLu8sv
TQC99CH95MinHLqMEN//UyBZzO1C84SNERlEpYp7l/a56JEiZNuNtq29ZTkVs6cy
3ZpqCCYrcJ6wd4bIJBWzvIVgZ2yB0e5n9AddLF+ekcXj3nyl5xhxklHP+9nvWNj+
ahA6ItsWa5c7lxjXdcMul4zO1rxX4FIrs0n8dvIfBJW4sov9wQJShDvWxdKCE4Vw
f2sIwfF2c+4nrsTk0PGKOV0INrGF5QAeorwB/+jiyLJbvMF+t98gCezt6uPe5zpt
J18bSLaxWkkHLCAr9A0tAVPEeBZVCQccpo8VfHfsboxeu7kewvtj7B+szLzILaao
Dr1BVlPthejE1ovIWC3AJTS/EZuqxGf1vnhhQvW0rSeCVQZB1jzrmywHpsKgKDXQ
aH8vLUpX3uv1w/yht8pDg9kLNdTHDRyF5WWzLqHUzDS5rWN2A03TzNuWEML8yMBu
OCox48jONA+NZuAfoiuk0w6Wd9m26Nof7iEJ4skXYq4WGO8Dnqb9LWH0ikFSZgS2
1J7Dd6AZxN9wQz5zsWqfuIFInl9xlIjv8KSuBEHXBViW/D4owcLqU2/L7+dH+WZr
LdF908nXK/4chePC5/dcyaPXSwU9NgCawPBY99GPJ2KY/zvpQTg=
=JCJ1
-----END PGP SIGNATURE-----

--2G6E7HkfnmgXShJZ--
