Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED2D5A796
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526441; cv=none; b=tCXZGXhBMIQ7O8aCzJLwpX6Q4/Ca/juUJi+jfhyloKRowQWjI8XMB685ytLFZ1twVkTx5mDXLI96rKtuQBuxk/BD5QuNe+0djQkXR0zO/TVWiQ/+/ocVOqZQt/dKZYdriICnwBy/X9iR/y5iIW+ZCmT8HlGI1NNXsYu+JqwrnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526441; c=relaxed/simple;
	bh=h8ZbjDpTslR69DZX4AhUYOJOvVX70px6z/SMxvxZhhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZM+mV4j4QpsN59bIQhZwzxrBt11BJaA74CeWbBwFZch1FeVF817lVSefvvgs5MU0+uekFl1DOWlVGg5wJQBfeVsdX5F8e7KlbPYnyWcPR7Qsb4aYevBLSa7atcESAxhQIbiOZQe/FtbHV+QB69IzVia3Kwsqwg+wyDMCM9iYOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=paYOrsqM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3Vb8hoX; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="paYOrsqM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3Vb8hoX"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E33625C00C0;
	Mon, 29 Jan 2024 06:07:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 06:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706526437; x=1706612837; bh=5c/LSq5JWl
	qk++VNLgMDOAP2y+9UiXY7tfgnDa2yPo4=; b=paYOrsqMbDP9r+E0B/P5QaOkxn
	+kSzblp1As2ys5RXHTOk3sxwlGR/q2Dm7MuWeS6BkCByH2bW8QXlAkU5ZWlY1DEJ
	rnFyW1LfPdPz1jvIZ9QTRC5xyZ4EXBFN1vTF1+CAARGX9oNJQg15Hu9An8358QX9
	0hcfxnvb1gwGYhmog7enFMMzVOECuWU9YbS/k8nyGPmFyD3vyRhMcC7e7bTGSe3G
	Lg6FD3L+qnaWMCaPH617sJtQ9yIrkNsNZuLs/YlIjO4AoHe+MacaiKa/BNIKVs5b
	MC5rtW9D7obkdMOdKfsEzNuNow65xf2tFeeITMS3y2bXWirIWuguV0aDvNMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706526437; x=1706612837; bh=5c/LSq5JWlqk++VNLgMDOAP2y+9U
	iXY7tfgnDa2yPo4=; b=T3Vb8hoX0B7isrxl6GZLe5VSmucK4w6RusDpREgfO5S8
	yWOAESbQqJXCPFPgvL3YSTXfsO25oPZrUC+RfSEOycKWRdT1BxkTA2ZRMuQM4DsK
	3wdtPQc0FhW/0ys/K6+ZFIs2QpRc1dzKTHKSCnMUCUCV5r7k1G1fFg5t+ElCIOqX
	VY3h/44jD4HwVBdM5BXoL/NV3flnH2NBgZJyieHXOCNdPsBealzo0OVzVKWB3UIp
	7vhK+DEFlBXsiifiAv5bPdKoQa3IUls1jUIpwDXsz0BtWs325lESgInksTpce+zs
	WiU9QIuo+HzAhFnkuDG2dHVyfkoMeiF1WKMFqoOD6A==
X-ME-Sender: <xms:5Ya3ZVUtkoL-OjmpdVDSq5yUgtxeYfRFqj4t5TlrhgYSLHihMHU7rQ>
    <xme:5Ya3ZVnHSbWTpKkcEXmOOkuER2aMlgLry74r7Ut019eq4Ns9bMJSvseAuTFBfrrmj
    EifnbcucKMQvpyiLw>
X-ME-Received: <xmr:5Ya3ZRYv8GRL9Yiyjn7_Gbul9EfM_oc1MXWErdPve2ruE644yHKez26X8gqolXSflDUTkvYdrpEq31zVnyo4A-Nf701rtt0-apLGX_JzrCWh5Bh4sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5Ya3ZYU8vYWRCii3NvfnUmPUshkVewmeafqBdxEQVgZIF21UTXPLYg>
    <xmx:5Ya3ZfkG0lK6F4GxRW34t8wtCI0Zp2ZDYOrHKXlnbU8LQYeDBeu_ig>
    <xmx:5Ya3ZVdKI9KoKm60yv-JIb1f_KLkCkXM3DD-QafpYdne43o1ai7Xrw>
    <xmx:5Ya3ZasWFKnnFv9PZYh8NVDgZJ4i_oT6QJL78c9JD-4auRd2HOVVpQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:07:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b53cb49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:03:58 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:07:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/6] t: mark "files"-backend specific tests
Message-ID: <cover.1706525813.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fn1ymzG2yUxpjgBe"
Content-Disposition: inline
In-Reply-To: <cover.1704802213.git.ps@pks.im>


--Fn1ymzG2yUxpjgBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series that addresses tests which
are specific to the "files" backend. There is only a single change
compared to v3, which is an improved commit message for the first patch.

Thanks!

Patrick

Patrick Steinhardt (6):
  t1300: make tests more robust with non-default ref backends
  t1301: mark test for `core.sharedRepository` as reffiles specific
  t1302: make tests more robust with new extensions
  t1419: mark test suite as files-backend specific
  t5526: break test submodule differently
  t: mark tests regarding git-pack-refs(1) to be backend specific

 t/t1300-config.sh             | 78 ++++++++++++++++++++++-------------
 t/t1301-shared-repo.sh        |  2 +-
 t/t1302-repo-version.sh       | 23 +++++++----
 t/t1409-avoid-packing-refs.sh |  6 +++
 t/t1419-exclude-refs.sh       |  6 +++
 t/t3210-pack-refs.sh          |  6 +++
 t/t5526-fetch-submodules.sh   |  2 +-
 7 files changed, 85 insertions(+), 38 deletions(-)

Range-diff against v3:
1:  a57e57a7c3 ! 1:  80a74bbb56 t1300: make tests more robust with non-defa=
ult ref backends
    @@ Commit message
         t1300: make tests more robust with non-default ref backends
    =20
         The t1300 test suite exercises the git-config(1) tool. To do so, t=
he
    -    test overwrites ".git/config" to contain custom contents. While th=
is is
    -    easy enough to do, it may create problems when using a non-default
    -    repository format because this causes us to overwrite the reposito=
ry
    -    format version as well as any potential extensions. With the upcom=
ing
    -    "reftable" ref backend the result is that Git would try to access =
refs
    -    via the "files" backend even though the repository has been initia=
lized
    -    with the "reftable" backend, which will cause failures when trying=
 to
    -    access any refs.
    +    test overwrites ".git/config" to contain custom contents in several
    +    places with code like the following:
    =20
    -    Refactor tests which access the refdb to be more robust by using t=
heir
    -    own separate repositories, which allows us to be more careful and =
not
    -    discard required extensions.
    +    ```
    +    cat > .git/config <<\EOF
    +    ...
    +    EOF
    +    ```
    +
    +    While this is easy enough to do, it may create problems when using=
 a
    +    non-default repository format because this causes us to overwrite =
the
    +    repository format version as well as any potential extensions. Wit=
h the
    +    upcoming "reftable" ref backend the result is that Git would try to
    +    access refs via the "files" backend even though the repository has=
 been
    +    initialized with the "reftable" backend, which will cause failures=
 when
    +    trying to access any refs.
    +
    +    Ideally, we would rewrite the whole test suite to not depend on st=
ate
    +    written by previous tests, but that would result in a lot of chang=
es in
    +    this test suite. Instead, we only refactor tests which access the =
refdb
    +    to be more robust by using their own separate repositories, which =
allows
    +    us to be more careful and not discard required extensions.
    =20
         Note that we also have to touch up how the CUSTOM_CONFIG_FILE gets
         accessed. This environment variable contains the relative path to a
2:  fd6dd92c23 =3D 2:  4359d3ffa8 t1301: mark test for `core.sharedReposito=
ry` as reffiles specific
3:  ec90320ff1 =3D 3:  b72d85df60 t1302: make tests more robust with new ex=
tensions
4:  d0d70c3f18 =3D 4:  1faa8687ae t1419: mark test suite as files-backend s=
pecific
5:  066c297189 =3D 5:  4b95277e20 t5526: break test submodule differently
6:  7b8921817b =3D 6:  53aea8236d t: mark tests regarding git-pack-refs(1) =
to be backend specific

base-commit: b50a608ba20348cb3dfc16a696816d51780e3f0f
--=20
2.43.GIT


--Fn1ymzG2yUxpjgBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3huAACgkQVbJhu7ck
PpQFvBAAntsIOpEDoS3N74TtaUWQ/X1hVTZ/74CT+dcdGln8K62oNtG62MAfUw1f
9JLdxxNmKLpn4eVXCcQm69IzzZXukOBlyMuN3dvJNX9NPQnK9ROMHS0PWFJEFhmQ
iYBddeLtXqutyWqEFsyRaaDxuUEkPFy/LNZNugqLa1cgEB/VltXqyGJRQEkZB0F5
oKTSRxLvbdsIqObX6qITeafhIyuSBmC4HL49rmLTy0io+ATwPBFyg6zpl+8VqVPU
9AfD+dKPpTy62NEXSqJg2tvr3crzGyvshxJyNkGWrM7K4o1XpGwocbRSuNZ7Kobb
HdDAP7r3Q1ZeQWK/rc8FM7oqEqT2QW2V+0athPHeR5O6VpqSpXqTqFlVu2m2dUwA
Z2UWEcJQxTiMmiGVegCCQRfmbrdVwQDNPTPHXQPwOcuaJs/P65M41x8wvlSjGXKf
jHp39bG7GFsHsDpZDUsn/RLtCj/2CxeX5aCYNr/OQGN3DrLF4EE1YBxvklaO9zsy
9/UTGPQDV0Cl13xbhA2T7jNQ1W7yqpWtNLlCAxyr8oZ7np7BmBFRf3aIaWEnBIgY
P/yOeavP+a71xaEBUHMflMDGzsDzv7oDk3xMq8Z9nmlvrNxSUIpE1mG4meGQ74aj
nU7xTO2zfTXjVEt8iecjnDyB1tvehpp2ayqQneb0xeGapN1Ozns=
=df4O
-----END PGP SIGNATURE-----

--Fn1ymzG2yUxpjgBe--
