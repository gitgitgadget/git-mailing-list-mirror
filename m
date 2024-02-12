Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BEFBF5
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726748; cv=none; b=SvKvZ17dc/P8e+dyv2jYDc2AZQchHSwyhJb5IHsp81h8Qxo5yNHS3OEZPpx/vHogWKQSGaeVZTmKohAujdCSsOLGZHLITuhNLj4lfjayq6zcoteDahTzyXOA53LkNeTqI+1xRwii2mbYw/Dbn0BjdGhaoqhXXm7Hbt37Lub5eF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726748; c=relaxed/simple;
	bh=bz5KIX9ymjvzSvPYGHh7dHaU/7Q8bBoTbJ/49KSD5oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBOh2Yz0c+t80hZfvVsH2YpdhQyAZCRXzEo/NbnnQFw8/sireawq/+0hnCYYD6v6Nlx3SgU4NZuVJF9WfOw//k7ALle0lroaY05nJ8NyYYP87FYBPrTDH2eKptMq4tcbwiK4AbIGyhJnrtiS9homb5bR89+fWEANB5chnwtK4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e9tlLluy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OYh8FsTz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e9tlLluy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OYh8FsTz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8FA221140091;
	Mon, 12 Feb 2024 03:32:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Feb 2024 03:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707726745; x=1707813145; bh=vuHgFN6/IK
	PwJCHmpnWoWKwOJgxQ3jkAEcNSFTW+Bw0=; b=e9tlLluyf20xs136RdF2pTy5/5
	CqLsAjNRY2loZv3VhLjPxy801+QYlrBIX7NNiQ2kXhADNM3vBnLkLvtq2+5lSVFw
	4pLwfzwJPNKu5FQFxWxEV4rLoebLXoForAWEPdQEkaUlMWTNxq7F8uMkcSSX60CF
	7Khj3LF6F9Mn/KC7gyMET0RKzKt1b8jE904hyvCfYgh0BTkLOeySkoVw2pbtBprQ
	tlAjNxF2EKLR6mKAEXUU/SLCVIe9fIG2Or6aaor1afgLvaf0FcekbXi8+70ZOKB7
	X1GFJzH2xEz4IhgWXQAQ79Kxj3zePILrZr7bG1j/TsjAmRXZLuML9fHcmDkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707726745; x=1707813145; bh=vuHgFN6/IKPwJCHmpnWoWKwOJgxQ
	3jkAEcNSFTW+Bw0=; b=OYh8FsTzPRwLNJv2urhYuHaN/Gw4jiVo9X3G3aEoPloU
	VxyQ4ZH7CrcIeICOaVLnAkUlRAhPEHwDx61VdDmMVCy7KANbrVsudOa53ygqz/gd
	ol4UmZrZDoZJmd4ozhoi1aLk0AlTF/Lf5znoAGhR13cT+k21SVDvPczSxGLwlb3F
	jbIFiza+vLpOeL8odZlpDCiTtgt3jjcg608ibWP8ypppR1jqPyp5rJwC85OzhYlC
	1UI7sh5+YUNpwbzNRyAdKtLgUpvDTFBDDCrSoyPrjnwoFiJOwDECO++MY6kkysyM
	px/7zzjdDQ5g9BIn6uqIhdCVuSMxXTpyGgy+hM6FTw==
X-ME-Sender: <xms:mdfJZe2oj-AT6OS7g6jRIQWRLweNkDqMadBPAeMZuDe0LidJx8zmTA>
    <xme:mdfJZRH3YTeqzWwcYBy3Q85f2Prk3BWeGX-dWR3bTcYlkZGWE580eGsQdKmMiSlju
    XmDxNDunAmYBAln0g>
X-ME-Received: <xmr:mdfJZW7QuxEPU3_LWKM0rGN6cCnrkYPq9VdLFUDUkkMaetTFasCS4-98ZIHXQcv5T2Rak4-fRsMCqO6TQr_oYZVwGLiDWGQYDxP1i3_WK3TMyCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mdfJZf3-hRiAz0VgW9wEF4gAAFtdKuo6AnqwA05r93dMMH5svmh_NQ>
    <xmx:mdfJZRGkpIeOa_bAEpEdSabClRHVo2rm4yO5MvYWSqT52N_m_FdKOg>
    <xmx:mdfJZY-9EytahSBoFIzvCSpreml6UJ11oOawS4r_7742d-PL5pxa2A>
    <xmx:mdfJZRCmmuxileE2Bp3NSjMax5AMul5Q_RNJ5fo1lInJfi2auoreTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 03:32:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b451d747 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 08:28:37 +0000 (UTC)
Date: Mon, 12 Feb 2024 09:32:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, John Cai <johncai86@gmail.com>
Subject: [PATCH v2 0/7] reftable: improve ref iteration performance
Message-ID: <cover.1707726654.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OhuhATT18V0T5dGe"
Content-Disposition: inline
In-Reply-To: <cover.1706782841.git.ps@pks.im>


--OhuhATT18V0T5dGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that improves ref
iteration performance. There are no code changes compared to v1, but a
few improvements to the commit messages.

Thanks!

Patrick

Patrick Steinhardt (7):
  reftable/record: introduce function to compare records by key
  reftable/merged: allocation-less dropping of shadowed records
  reftable/merged: skip comparison for records of the same subiter
  reftable/pq: allocation-less comparison of entry keys
  reftable/block: swap buffers instead of copying
  reftable/record: don't try to reallocate ref record name
  reftable/reader: add comments to `table_iter_next()`

 reftable/block.c  |  3 +--
 reftable/merged.c | 19 +++++++-------
 reftable/merged.h |  2 --
 reftable/pq.c     | 13 +--------
 reftable/reader.c | 26 +++++++++++-------
 reftable/record.c | 67 ++++++++++++++++++++++++++++++++++++++++++++---
 reftable/record.h |  7 +++++
 7 files changed, 100 insertions(+), 37 deletions(-)

Range-diff against v1:
1:  fadabec696 ! 1:  bcdb5a2bf0 reftable/record: introduce function to comp=
are records by key
    @@ Commit message
         In some places we need to sort reftable records by their keys to
         determine their ordering. This is done by first formatting the key=
s into
         a `struct strbuf` and then using `strbuf_cmp()` to compare them. T=
his
    -    logic is needlessly roundabout and can end up costing quite a bit =
fo CPU
    +    logic is needlessly roundabout and can end up costing quite a bit =
of CPU
         cycles, both due to the allocation and formatting logic.
    =20
    -    Introduce a new `reftable_record_cmp()` function that knows to com=
pare
    -    two records with each other without requiring allocations.
    +    Introduce a new `reftable_record_cmp()` function that knows how to
    +    compare two records with each other without requiring allocations.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
2:  576a96f2e5 =3D 2:  2364a0fa33 reftable/merged: allocation-less dropping=
 of shadowed records
3:  0ca86eba71 ! 3:  205e6b488b reftable/merged: skip comparison for record=
s of the same subiter
    @@ Commit message
         to return.
    =20
         There is an edge case here where we can skip that comparison: when=
 the
    -    record in the priority queue comes from the same subiterator than =
the
    +    record in the priority queue comes from the same subiterator as the
         record we are about to return then we know that its key must be la=
rger
         than the key of the record we are about to return. This property is
         guaranteed by the sub-iterators, and if it didn't hold then the wh=
ole
4:  1c9c19a3b3 =3D 4:  fd09ba70fe reftable/pq: allocation-less comparison o=
f entry keys
5:  ac3d43c001 =3D 5:  2317aa43b9 reftable/block: swap buffers instead of c=
opying
6:  41dff8731c =3D 6:  8c67491504 reftable/record: don't try to reallocate =
ref record name
7:  2f1f1dd95e ! 7:  167f67fad8 reftable/reader: add comments to `table_ite=
r_next()`
    @@ Commit message
         more obvious. While at it, touch up the code to conform to our code
         style better.
    =20
    +    Note that one of the refactorings merges two conditional blocks in=
to
    +    one. Before, we had the following code:
    +
    +    ```
    +    err =3D table_iter_next_block(&next, ti
    +    if (err !=3D 0) {
    +            ti->is_finished =3D 1;
    +    }
    +    table_iter_block_done(ti);
    +    if (err !=3D 0) {
    +            return err;
    +    }
    +    ```
    +
    +    As `table_iter_block_done()` does not care about `is_finished`, the
    +    conditional blocks can be merged into one block:
    +
    +    ```
    +    err =3D table_iter_next_block(&next, ti
    +    table_iter_block_done(ti);
    +    if (err !=3D 0) {
    +            ti->is_finished =3D 1;
    +            return err;
    +    }
    +    ```
    +
    +    This is both easier to reason about and more performant because we=
 have
    +    one branch less.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## reftable/reader.c ##

base-commit: c875e0b8e036c12cfbf6531962108a063c7a821c
--=20
2.43.GIT


--OhuhATT18V0T5dGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJ15QACgkQVbJhu7ck
PpSszQ/9HBYABlsHVCWVBbylapY/z2qZNKNDdSfCBPZDz0G8OfDstVix45ODEnZr
lRKqGCfYDfCtFiYthooQZLajk8avhffqE/nPUbcHT6rr1rTmjsqcw4eefPYOaazv
Z5wYX56ThC+6ijRdk+5GxsV3dRfsrEz+hzlkdVRmtM60e1psMe1FsB5mdHnWkjSb
QZ5g8QNiJvXsff5dKCspjbrTMF/t++z+iZyDnUfr5TUnQIZG1qQF+keuv+ZBq+1S
p5e4kUYwm1exCtEwmVBdVWo46DtYlJJ7YT+k4iQqMzoH0nDd9p9U7x3haK3sc/w8
Q6j/35XO6TSqTcRlopWtvJrnk9WuRR+fWmmVl9nSnHcYFjnZ7DF3YRoEK6RB7nDd
/AjINDTquwO62re0NWqVgaIHet7IsR7VAcDPzIK0eGgB2XnuNnEEKvGei+dGTZnY
+B3xQxORYn0yHIBGZKt7WQinj/tM2Spz6j1V3AhdiqemdYGseV4qBuNOFTKJxf7h
Ttqyo1BTnrExesPJ6+TEj6pgdLbRrig01fYWYA52qUa6BBJD5zMF8UyU1bpr+TAk
VhH657IFZhmOajc62nOJyPJYf6xPPic/mlMBErfmCXyt4EYFd5tdZWTibPUDjYDn
B5hSKJOZ2ZwxWvCDVzwinLSj7gw/EQ5FOR7cVOjsUK/7WxJTYjo=
=+oSr
-----END PGP SIGNATURE-----

--OhuhATT18V0T5dGe--
