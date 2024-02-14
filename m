Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A5125A1
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896747; cv=none; b=kCDuofHqVjDspOalKsaFuF3zhECUkO463qN73D75yh3ehHsoedoAyBJbIB0mthmeOEnzXuS0h7Ge52P9RAFit/CT9WAQwyQJOD/z7CTYvzXQZJ7L4fKR5UwEtSp2vHGg3CCxyeXcKWT0THTjaD5POA37R0GX3qyk/m88YhMrbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896747; c=relaxed/simple;
	bh=FbGYlfFFXv9SZy26GrBcCK03+sdAos36d+qDegTV3qM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EH4INPulzO7TloT+2XsIHnGdVNC+8HeudC/uGveAbB4+wCzkzP/1J7avZSi3v5FgnTtF70/eZ1L59z0qxkj6A189Ailsx/PU1/1p8/HKHo9AUFT01t21p14KLo/REzcU2/8YUamjYEBVU8P91KV/02M1zSrdpcucbwuKrC/dPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IqGHIAXV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZ5Dw03o; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IqGHIAXV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZ5Dw03o"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id CC8001800096
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:45:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 14 Feb 2024 02:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1707896742; x=1707983142; bh=D+5dDzRl7LhI45N0Hu5vFwqjzMjxqbiu
	tJahD9gW4c8=; b=IqGHIAXVtBx8N7+U7HQfzbIEBOFv7CIeaywDa6zQbqHMhSVz
	HH+5MvF6CsoVxI9d03ZJhy+XUv5iNEXD4Sw6/XIN6jS2EQW0x7bf0vXpPnCXlypr
	TSH7CERSM/l8zsMREsoKA83G0ZyvOB7tJLz+pRgpy444x7CrYicMDs1J4gNn9iEd
	Um4VXJVHGxCHLWd77rlZuRkwWdTO/IHNEVIMubjJihKmWMFJBp6Q3E0LztRU4RUC
	9LUAOmRvWNIxBjqzhwKp0RTq3F3X43q4GmkHTchPJvHwFyYVwbo+WjobUI2J6Abx
	dU3k5mm9vF7WLVKyjyTCnkK59Y2SvH3xS+7lSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707896742; x=1707983142; bh=D+5dDzRl7LhI45N0Hu5vFwqjzMjxqbiutJa
	hD9gW4c8=; b=kZ5Dw03ozeo6WSu34f3/jVoIRG61YEoxPmDRHNafkhmHyjTByUJ
	oJX7VkQrPUfamHVp/ghGP058W14fh8Egn+pvoSxzt3VtdCkFCCvsxMnUoQL52z9W
	780b4Mb4MjuGF7Tp6muzp2N9ItYaf3ZAHWBXxp8sqNq2VdbDIpZBLKJW4EO8OhbZ
	EJO29HKtn4VkzlP+FDMuSJB3GzMuE5nSJXD4/dJRZgJtQ0u7SDuJ6IMXLlq5ubde
	OY2kn02eLOIIk2qDasx9nou+qfjgQcAAaB+kNVFyjya4JSNijbMio8BTOHfay0LB
	T2RWcDrcpFLkgwv2QEd8bEVehIB9dh/21JA==
X-ME-Sender: <xms:pm_MZdgpUWuT4ehv0jVwoEI8EZ9j2ZHJ2Lm9i8rE1vMRstiXGTlQpw>
    <xme:pm_MZSD9PMgUNbWjxmga-XxsFwFY62ViDQkCMULWPL2BbgGUjMJq0c1eEPmjmw8iU
    vj6kNLcE32VBgvIJw>
X-ME-Received: <xmr:pm_MZdHeQh6XSRnQ1X16wdiVDhCZtNeH4wR1wGLgwARBiYNuEZ8vNa7YW2PAgmp99xQkAzOOP0gAlzXU93nWKotXDFe2ZsAfRSF8UWc7a36Fxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjedtfefftedugfevvdejtdehjefgtddvvdethe
    eiteduuedtteeileetkefhfeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:pm_MZSQROOJRAFI155HaSfGqfyv3HXcK9UhWBKfa1jInmiMUvnR69Q>
    <xmx:pm_MZaxoufLdIXnfbt1QJwdGezgElGD1shKrio4iPt9N4-t0TcNwdg>
    <xmx:pm_MZY61chTI4hIuRERS5n9_ifJRdHFyVWQruJ1f6HM0qqG6ryvw9A>
    <xmx:pm_MZfqcau2nimsotIpEFwhYcFjq14RW6poRYrIP1cFGiB_P86av5efQa70>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:45:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f5491e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:41:49 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:45:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/12] reftable: improve ref iteration performance (pt.2)
Message-ID: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Uu4XtHvYIQ+prNW"
Content-Disposition: inline


--0Uu4XtHvYIQ+prNW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second part of my patch series that aim to improve raw ref
iteration performance with the reftable backend. The target of this
series was to get the reftable backend performant enough to match the
files backend. This was achieved via two angles:

  - Refactorings of the merged iterators that allow us to skip copying
    and allocating records from the sub-iterators to the caller. This is
    implemented by the first 8 patches.

  - Refactorings of how we decode reftable records so that we reuse
    allocated memory. Like this the number of allocations don't scale
    with the number of iterated records anymore, but instead with the
    number of blocks which we're iterating over.

Combined, these refactorings lead to a sizeable speedup when iterating
over 1 million refs:

```
Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
  Time (mean =C2=B1 =CF=83):     146.1 ms =C2=B1   4.2 ms    [User: 143.2 m=
s, System: 2.8 ms]
  Range (min =E2=80=A6 max):   140.7 ms =E2=80=A6 180.2 ms    1000 runs

Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
  Time (mean =C2=B1 =CF=83):      97.6 ms =C2=B1   3.2 ms    [User: 94.8 ms=
, System: 2.7 ms]
  Range (min =E2=80=A6 max):    94.6 ms =E2=80=A6 122.1 ms    1000 runs

Summary
  show-ref: single matching ref (revision =3D HEAD) ran
    1.50 =C2=B1 0.07 times faster than show-ref: single matching ref (revis=
ion =3D HEAD~)
```

With this, the reftable backend is now on par with the files backend:

```
Benchmark 1: show-ref: single matching ref (refformat =3D files)
  Time (mean =C2=B1 =CF=83):      97.8 ms =C2=B1   3.4 ms    [User: 87.6 ms=
, System: 10.0 ms]
  Range (min =E2=80=A6 max):    95.0 ms =E2=80=A6 121.3 ms    1000 runs

Benchmark 2: show-ref: single matching ref (refformat =3D reftable)
  Time (mean =C2=B1 =CF=83):      97.4 ms =C2=B1   3.2 ms    [User: 94.5 ms=
, System: 2.7 ms]
  Range (min =E2=80=A6 max):    94.1 ms =E2=80=A6 126.3 ms    1000 runs

Summary
  show-ref: single matching ref (refformat =3D reftable) ran
    1.00 =C2=B1 0.05 times faster than show-ref: single matching ref (reffo=
rmat =3D files)
```

There are still optimization opportunities left, but given that the
original target has been fulfilled I decided to stop so that the patch
series remains somewhat reasonably sized.

The patch series is based on `master` at 2996f11c1d (Sync with 'maint',
2024-02-12) and depends on ps/reftable-iteration-perf at c68ca7abd3
(reftable/reader: add comments to `table_iter_next()`, 2024-02-12).

Patrick

Patrick Steinhardt (12):
  reftable/pq: use `size_t` to track iterator index
  reftable/merged: make `merged_iter` structure private
  reftable/merged: advance subiter on subsequent iteration
  reftable/merged: make subiters own their records
  reftable/merged: remove unnecessary null check for subiters
  reftable/merged: handle subiter cleanup on close only
  reftable/merged: circumvent pqueue with single subiter
  reftable/merged: avoid duplicate pqueue emptiness check
  reftable/record: reuse refname when decoding
  reftable/record: reuse refname when copying
  reftable/record: decode keys in place
  reftable: allow inlining of a few functions

 reftable/block.c           |  25 +++----
 reftable/block.h           |   2 -
 reftable/iter.c            |   5 --
 reftable/iter.h            |   4 --
 reftable/merged.c          | 139 +++++++++++++++++++------------------
 reftable/merged.h          |   9 ---
 reftable/pq.c              |  18 +----
 reftable/pq.h              |  16 +++--
 reftable/pq_test.c         |  41 +++++------
 reftable/record.c          |  64 +++++++++--------
 reftable/record.h          |  21 ++++--
 reftable/record_test.c     |   3 +-
 reftable/reftable-record.h |   1 +
 13 files changed, 170 insertions(+), 178 deletions(-)


base-commit: 2996f11c1d11ab68823f0939b6469dedc2b9ab90
--=20
2.43.GIT


--0Uu4XtHvYIQ+prNW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb5wACgkQVbJhu7ck
PpRE4g//ZN9ddqilUGQ7ng9ni5p4wAG1RgVbRQ9o2Y51uIzy5m+aiy37cJDrLms3
Wm6hL4uBmIFyki8KmM5lj5fwtcLO8Poo5COj46XSVYLV9RtCRJNJu4Z+rq5hxMIA
rexJeZazlWHvzE+q7s0knrISTq1ze4c7nSkmTT7KESVjC9Os9v7+U74Ed8FYff1r
/DDZ71HY5lIKU7k7hWFCt4Q3GL2TrkvL/GU2J4cgjxhxw9WhcDe1s86tZIIZj2CL
LSxeKd+L+Rykon/qtgdeyYp8sr/6BoPYB4tmAEgBa57MlViuuI1XB5vAl9+Gtz1W
Saoy2R3dcDsUIy7GYLmxoJAKmi8A5PYXdhwREO+GUKiW8WC5YM74HEKY8+N/yLoT
/oB34efuMVfEhg/8A5XBnJ7gISScyZF1a3MjPtdvtR3uJP3xsQo4Rgx2Po/wleAh
L0U8EBdIBXD9KrjRNDJE9V4Gcj26KNoOy21pNB37uq24xsH6Lyp7qEsPl0ZZ/WjR
GQHcWxosB5kiMDS03Fjza8HczAbuQ2I3FXws4fCjIwEGqiA29eqDDB58yTvjtJcE
0lmLjxJkl+lUpSd8PYLg198yi6Te2Yo2+5fCrpwcTIA+QSBdGduZWQD48viGA8Rd
bu22Fd/fDsESljG/sbbBo/hfTOH73Yw0lIMfqfyFxN/7/ktQhPc=
=eNIT
-----END PGP SIGNATURE-----

--0Uu4XtHvYIQ+prNW--
