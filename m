Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B915CD41
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783112; cv=none; b=cJD8DZ16MHRzbwijYOuOGiQSTM4mh+pOxrAmKyL839rRyHoWmz+OOKOBfCQNJDHpDsWYHwxqEGc2NAHRdzA3hmXjNI3d6sHPnXkwuXk2V+GLLDm8irWRD87awSrpwhdPsO5WktW0pojgWX/r4eJd0klTMZqHrcaaDHJgB/kzums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783112; c=relaxed/simple;
	bh=q07VK1G7ghTfSbM8ha7oMYJsMjU1/IS6+YHOuvAh9lA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIMuYkmoSf5nAyv9CiANer45FTIgmx57djopoVZKNlBEpqGlMWoeX7yxEJWLHz2j4ZQNjXihNu0404sGEC6lFIS0Ly05ICO8Wrzz3P9+J9i5K5KcDjgXJc5t1ig5FzAzQDgG72MbfkBNRgYk4mNLuOSW3Zq3S5vFDJsKkfz0mY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TVV8Jlpm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlF2Qgm4; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TVV8Jlpm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlF2Qgm4"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2B8F91800089
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 05:25:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 05:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706783108; x=1706869508; bh=IDlrT2Tn3h
	FqGEzl+OPSrJ8Pqa/MpCdct8/W6QvvLnQ=; b=TVV8JlpmKzLHZMiBpAktNi5Lpx
	AzPx7oBb6IFSQe+K20pCrFVHdLAoI+k3TXU8JqGL4tJzPqcuqd+pY5jeHiyarRQ3
	Td3ScgXbPHbs8WZHrS0qQ1mbQcxYh0mdzAce1rcuqyZVU7WJX2SxX/0cYlN15Xdu
	QUAFueWhMgEu3ussuFmcbW8qLjiOZ6+9QEd5x1SdMX0G8FdWgxlRwPZ4FZUZVfJA
	KhvHENb5UuqTlBQmSld+6fb+hlIHAFA355cojFerNT68N7GU7SBWa5DBlxW71SUj
	l68MtDQOnssbfPDlCzXGW7BNa1aF2DZe1Eqf4WXrG/UTs2Cg7TmoMhT1031Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706783108; x=1706869508; bh=IDlrT2Tn3hFqGEzl+OPSrJ8Pqa/M
	pCdct8/W6QvvLnQ=; b=TlF2Qgm4K5riOO1Ueu0ttSy+9Ag9RPMqLoqzu6ZhCH9r
	sXmXyFGZKBpPd9sENgvCVgriCeGfDp43fgkRmnpcFbMDA0J4300CkVu11Abs+zt5
	woXfHpWZSPH/pE9nGxm3W3FxmQTDZ5EfAWu1j1z+LsU2XjGVMDHhzSKYnrHUkkgk
	jPNZKTMyu53wYn6aC3t4PQGtAFal0m33yYDT2/6gfRReakSMkiwvU0DyHAAPNY+s
	wueKe4vLgb61hhBbZ047LYmFRpAzD/zAMulRvzoaxmPQ3FR8IchYXfypNh+w5MR9
	uuxKhH3tDOWPqvpO6M5Kp4NLnKxWBMpbqnz0Mq7HPw==
X-ME-Sender: <xms:hHG7ZXlBNFIUDJgqEx53w7i7O5ZRdYUAg_6R4XmtdfzH0AFVQT1k_A>
    <xme:hHG7Za2ylIRltROjF8XVWuE_0Ch0S7qhP2HMeSQMMG3Rz6-GQjtBz98F19UCcF9QA
    LbWdsG7e3E7-UEEUg>
X-ME-Received: <xmr:hHG7ZdrZs8Aefiw1k8so_NmgkLB4wDZGvdK8xhRp09Q-O5USBVeIl6CqBT7xMfZ6mr3Z4JFqDTTYQ_hKa9oTl9-MOm8gvHyETcoPMCj-dgcmug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hHG7ZfkJKchS8N0rGila3fwEgB8Qb1v-Ov8IZ6T3kBDuMc_VDj7g5Q>
    <xmx:hHG7ZV25PnSIXgLQECLiTeHAlKtKwBxjeGpgIDv7pvi5_kCQxphGrQ>
    <xmx:hHG7ZesW4eEcCDp_2KyZ2SerQIqKyaoa2Z_GA-8_inQEzw8Nkpg2-w>
    <xmx:hHG7ZW_7z32Fa0zLVyh6iQ070Yx6aOORJqvk4BqdMaXq-XACpigQk23ztks>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Feb 2024 05:25:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0257954a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Feb 2024 10:21:45 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:25:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/7] reftable/merged: skip comparison for records of the same
 subiter
Message-ID: <0ca86eba710895f0e22fc15fe5221f5487031f64.1706782841.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yUymu7qFTl7PQVo9"
Content-Disposition: inline
In-Reply-To: <cover.1706782841.git.ps@pks.im>


--yUymu7qFTl7PQVo9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When retrieving the next entry of a merged iterator we need to drop all
records of other sub-iterators that would be shadowed by the record that
we are about to return. We do this by comparing record keys, dropping
all keys that are smaller or equal to the key of the record we are about
to return.

There is an edge case here where we can skip that comparison: when the
record in the priority queue comes from the same subiterator than the
record we are about to return then we know that its key must be larger
than the key of the record we are about to return. This property is
guaranteed by the sub-iterators, and if it didn't hold then the whole
merged iterator would return records in the wrong order, too.

While this may seem like a very specific edge case it's in fact quite
likely to happen. For most repositories out there you can assume that we
will end up with one large table and several smaller ones on top of it.
Thus, it is very likely that the next entry will sort towards the top of
the priority queue.

Special case this and break out of the loop in that case. The following
benchmark uses git-show-ref(1) to print a single ref matching a pattern
out of 1 million refs:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     162.6 ms =C2=B1   4.5 ms    [User: 159.0=
 ms, System: 3.5 ms]
    Range (min =E2=80=A6 max):   156.6 ms =E2=80=A6 188.5 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     156.8 ms =C2=B1   4.7 ms    [User: 153.0=
 ms, System: 3.6 ms]
    Range (min =E2=80=A6 max):   151.4 ms =E2=80=A6 188.4 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.04 =C2=B1 0.04 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/reftable/merged.c b/reftable/merged.c
index fb9978d798..0f74a14a77 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -107,6 +107,14 @@ static int merged_iter_next_entry(struct merged_iter *=
mi,
 		struct pq_entry top =3D merged_iter_pqueue_top(mi->pq);
 		int cmp;
=20
+		/*
+		 * When the next entry comes from the same queue as the current
+		 * entry then it must by definition be larger. This avoids a
+		 * comparison in the most common case.
+		 */
+		if (top.index =3D=3D entry.index)
+			break;
+
 		cmp =3D reftable_record_cmp(&top.rec, &entry.rec);
 		if (cmp > 0)
 			break;
--=20
2.43.GIT


--yUymu7qFTl7PQVo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7cYEACgkQVbJhu7ck
PpSGjg/+Ny7pvlDnnA+Jf6/vSXU3RIsYarcl5UsMSJH9Ux+/EkLPDxDvIQx5pIfN
5JWnaQVGUQgb2CDkbrlUMj8b9Ahr0+pCvHLHDWxzIsq0EMc/qxTB+MLUuLQONdRa
SHvHOUnzy6xcZhe0LE7g/nshBtFyK7uRJdQ6BeeBAAUx0gDlWeThoZCMOI4LhCJX
eeNyAir4Rmpy+Vofa0swOFLnRiLG0CjPSz3d2gamNqCFlrlkKzfvk8tGh1GsLC6q
ePrEdb6enGLBkCJ1wK9bELR4L5GTaraK+fcEjtiZqLNMXZ/vB4IpRbNEB9s0nbXH
9TKLghbfIAj1hz3wvs/bhTAiK5NSFSyBHmfocmv90ck9kvqGLsJo+RagCxC85+od
GHI9xLEbroMwEkUXrhJIsrhshB0Y2/tECRzdmNFEmdBF96OhOBj3Pme9B0+auihC
gKrFGnxjAdMEZT7RtEQlCqk37nxmnzLCxJVu6qL4tq1dvjyapVJTQTk+pFaeEaCl
HiVsxUMOOj0o7iZxxg5/bCPw2dkpLSv+WHMP+q895St+RiEKTSRfQj/hA/7cZBak
45HBNc36YMxeMSeOuHY51x7ZRk3GuQh6bVnfEMjEaqNQw5SmwTtDkyqSZqz3azGT
/82YiQLMZw/61ruHoW5IubCeRmfGxPhaaUYNWHapbCtGEYEEblo=
=CjQj
-----END PGP SIGNATURE-----

--yUymu7qFTl7PQVo9--
