Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086214AD3D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078995; cv=none; b=uS+jsxk7G5VBKR6tTeANdpvkz2jLgcrMmBjlpoacYitUUc9SkSV5HzHdkrIY+d3o9G+xvlRnTp35qbr5W1OU5wng+R501xbGRuLHtJDussbD+ql1BKEt1sZi2f5F4XLQ/AjxCqEmC7UhawiddhMHeOWzw1IleqlKVPT/Za7VX0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078995; c=relaxed/simple;
	bh=+s7V/HozxnzruDvHtqw2TuSYlNRN2DKCpwUr6RlOwq0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X5xlGYibJxBqHYu8mk2GfMH4TqqVDDDkmMXye/9MHyBEUfxRksCsFlnEGcYkn+VBr5a3bxv7V5b4YYgtg/+NAPTPmSMA9oxE38rA0BAm0tP4L1JcIyBtEr9h5dT2HPvvnyee4ZNoICtzNQ6XBfhXtDPTeCiw599ZaO3TGZ+a0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BsPfVeYS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPkNyFuO; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BsPfVeYS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPkNyFuO"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id CC0EF18000EE
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:29:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Apr 2024 13:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1712078992; x=1712165392; bh=ifd+vfvJjeQAPOy2FQoz8l8LdPOm6R14
	zUY2PDOSmIA=; b=BsPfVeYScVhb5VJw+50UmX6d57wv52vljMhohsWNdLoeRSLi
	+bN/0kf1ca4By9fE3ld2C/CW3kpnsTvJzoLSqNSKOdSL1230bBhjTmlV+wYjsMvV
	+nBG/ElW5dn6PFcvu7dktJwFJE/eWkOZVv3TzXVD1fr17M3uV3TMjhUChwdpB9n2
	9DCY+VMYgI6cbzcnSKiwgvonUqmJczkWfQpFtgFOypH55CFd0GBYn1lfFMpcBzi0
	UtCHbjNecJWCS+bkrhQmu6w0sWFFyY6C43X00GWf0AKsqjduVsSTH7ykNLym+XGV
	1OZtYfz9b0MOQH3oy5t4g0kMPV2e/cQDIEamqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1712078992; x=1712165392; bh=ifd+vfvJjeQAPOy2FQoz8l8LdPOm6R14zUY
	2PDOSmIA=; b=gPkNyFuOxqtuhzCHNXdX79u8sYQKUFkgtdmAKQlKB+xnL/qLMzh
	JkOLJXdUMZ3DiwgWXnDgYaSiLiOc4DhY1trsXdUBmlt6719cjrN7zlazq0VJ/oih
	0gJdQyT7qRxqkyFMSEs4WDZ5rzni3PA3Q8bUguk5CHe+U5SLMIHvTIJ7pf+VFnrF
	9Ed5ZmY0XHHN9gtsL4rnGmiSKRwqDjtQ/lWIYEQYmlkIOvV87sfcYdinYQqtSvC4
	lnBuQl3MFtIDGk1lMT1z3PM9TOvVxv8PNKW9XE5QRXa2vq+Q1ivP9jYe514EsvFg
	IiH5IGWCbRNaAPho84lzBmUJZFgJeKm71aQ==
X-ME-Sender: <xms:kEAMZjuDORtHdL8gr7vQmcxHEuaKfvEMEfxrQTWr6FiT5tR2Ct6vbw>
    <xme:kEAMZkf-va_nPfkXc7MOG4D1xNKKbW_5BZp3M8BWZ5bCEC2ZZ7a50asiD6IK-00QM
    SfdFLeNyXURsmMctw>
X-ME-Received: <xmr:kEAMZmxmLXk34jiY44pzuhah1l8D-apWh72Jg0fpDdGxxFE2yt5lkFHvHdpf-XdGo-El9MMecNvBm2BU2L8zkxXA-0UmDXqYBbogoF4fvl299DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejtdefffetudfgvedvjedtheejgfdtvddvte
    ehieetudeutdetieelteekhfefueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:kEAMZiMQzboEa4c3d1uKJy3zfdzvOkw6vd62ksm51lIkcmOYxJthkg>
    <xmx:kEAMZj8VVzzP9PxOqvkNJvH7gCJMtnvM2BwU-kGadM7y0fnMV8nZxA>
    <xmx:kEAMZiVCJacfR3lcLVFg11pmml9hHNhHOeGwxdg-zJbZ8XQhqRr4bA>
    <xmx:kEAMZkf5Ayd1eXYre3ihecSwp0DKjlnvzs7udz2vNYmi5y3n52A5Xw>
    <xmx:kEAMZlLrUc0NV2A0KlZ3-LAWE6SzWv0juHGkYWIr5EmCAXunofZwvHcK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:29:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01aecd58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:29:41 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:29:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/9] reftable: optimize write performance
Message-ID: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="laCcn0+I+GwrkoNm"
Content-Disposition: inline


--laCcn0+I+GwrkoNm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is my first patch series taking an actual look at write performance
for the reftable backend. This series addresses two major pain points:

  - Duplicate directory/file conflict checks when writing refs.

  - Allocation churn when compressing log blocks.

Overall though I found that there is not much of a point to investigate
write performance in the reftable library itself, at least not right
now. This is mostly because the write performance is heavily dominated
by random ref reads. And while past patch series have optimized scanning
through refs linearly, seeking random refs isn't well-optimized yet. So
once all in-flight series relating to reftable performance have landed I
will focus on random ref reads next.

For the bigger picture, the following benchmarks show perfomance
compared to the "files" backend after applying this patch series.

Writing many refs in a single transaction:

  Benchmark 1: update-ref: create many refs (refformat =3D files, refcount =
=3D 100000)
    Time (mean =C2=B1 =CF=83):     10.085 s =C2=B1  0.057 s    [User: 1.876=
 s, System: 8.161 s]
    Range (min =E2=80=A6 max):   10.013 s =E2=80=A6 10.202 s    10 runs

  Benchmark 2: update-ref: create many refs (refformat =3D reftable, refcou=
nt =3D 100000)
    Time (mean =C2=B1 =CF=83):      2.768 s =C2=B1  0.018 s    [User: 1.381=
 s, System: 1.383 s]
    Range (min =E2=80=A6 max):    2.745 s =E2=80=A6  2.804 s    10 runs

  Summary
    update-ref: create many refs (refformat =3D reftable, refcount =3D 1000=
00) ran
      3.64 =C2=B1 0.03 times faster than update-ref: create many refs (reff=
ormat =3D files, refcount =3D 100000)

And for writing many refs sequentially in separate transactions:

  Benchmark 1: update-ref: create refs sequentially (refformat =3D files, r=
efcount =3D 10000)
    Time (mean =C2=B1 =CF=83):     40.286 s =C2=B1  0.086 s    [User: 22.24=
1 s, System: 17.912 s]
    Range (min =E2=80=A6 max):   40.166 s =E2=80=A6 40.410 s    10 runs

  Benchmark 2: update-ref: create refs sequentially (refformat =3D reftable=
, refcount =3D 10000)
    Time (mean =C2=B1 =CF=83):     44.046 s =C2=B1  0.137 s    [User: 23.79=
0 s, System: 20.146 s]
    Range (min =E2=80=A6 max):   43.813 s =E2=80=A6 44.301 s    10 runs

  Summary
    update-ref: create refs sequentially (refformat =3D files, refcount =3D=
 10000) ran
      1.09 =C2=B1 0.00 times faster than update-ref: create refs sequential=
ly (refformat =3D reftable, refcount =3D 10000)

This is to the best of my knowledge last area where the "files" backend
outperforms the "reftable" backend. This is partially also due to the
fact that writes perform auto-compaction with the "reftable" backend.

Patrick

Patrick Steinhardt (9):
  refs/reftable: fix D/F conflict error message on ref copy
  refs/reftable: perform explicit D/F check when writing symrefs
  refs/reftable: skip duplicate name checks
  refs/reftable: don't recompute committer ident
  reftable/writer: refactorings for `writer_add_record()`
  reftable/writer: refactorings for `writer_flush_nonempty_block()`
  reftable/block: reuse zstream when writing log blocks
  reftable/block: reuse compressed array
  reftable/writer: reset `last_key` instead of releasing it

 refs/reftable-backend.c    |  80 ++++++++++++++++++-------
 reftable/block.c           |  83 ++++++++++++++++----------
 reftable/block.h           |   4 ++
 reftable/writer.c          | 119 ++++++++++++++++++++++++-------------
 t/t0610-reftable-basics.sh |  35 ++++++++++-
 5 files changed, 227 insertions(+), 94 deletions(-)

--=20
2.44.GIT


--laCcn0+I+GwrkoNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMQIoACgkQVbJhu7ck
PpTEjQ/9FogqSyrVO7fa0zMMsq2zVf/aBc+hciGpRQDzopEE+5afU2D90ncooCd4
lTvT8YKJWeei1Prjo3nwmNWkhESq3KayrzY0dw1zhpR828mtNv8vke3u6wwomLym
hF1O74CzlVk0oJnqfcp9iaa79d2IJt1yyEdYvi47977CEF/dT0baxJPIScpKc3Zw
N7sYV3i84bYgJpXiJHja+H++ZHHHGp9M39e8rP66oZhEl6zS/hFONGDU4G1qyqZ0
W8AXFqqxCzaq5WVaZ9dbw0/A/A1hxKoIbDJnXmZydjw52lULEv9Os48vmuMRetGT
Rv6wz6lu5T/3txZms0CSHO+q+x0uEqFgBC5gKHobJtX+abMnz2QwXoSsQzXze6H+
yJnbYyfXBDKfRXN8R/IMEh1VS1kTQjeQYSQV4LXr7TsZ5crLfB5KFno4mJQFMNzX
KKKs2+t4oqWGYTbhAg9mo+5lmjjAaCdJNZkt67puYwAe0UwmUUd47Kcp/P/iv/zr
RCey+EOuwRE/agewYqxQFq5QM4+XfxLIGMvuIm6FYYQm3wzUziRoeJOy6PbB83D8
QijYYaQ0riPJlgSlP5r9l3/Ntiq0luBjo9uiq+KMuiE7pV0QFXVCwtv9JtuVbEDQ
8Te8jlo7E6XdVHQh4Kj2sSIfL+FdS1b3yS0zEcYKNo4tsRyMjQw=
=owpF
-----END PGP SIGNATURE-----

--laCcn0+I+GwrkoNm--
