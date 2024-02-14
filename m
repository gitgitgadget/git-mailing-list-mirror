Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA212E50
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896768; cv=none; b=PQdfPSVo6MY/QQI8MDESzJ/RQTv+GUJ/KVp+w73LiY7Hp1vsW5OrK3UwLbv6fdQZGih0vrFOyD3KFMoGvlomKloqQU6Zm89aovP5jocnBXRXpTRzPkTUVE4XgJv8geX8l8SE59zzzyj7CgF+H4G1dGH0n+zKljr0GwWvXNhi8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896768; c=relaxed/simple;
	bh=mJkPpMIYAuBU1ZyIxtCPyVrvPjKQIesCgXC15nrN1Ro=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfsCxZlw51PvUS3V9OL2OrnS1Op+P2esfSddY0fhIQfLqY2Lw7M3p3Wv6aPyFK3sxcmU6Dwo3dLsyaNiS4rtUBxsWrBL3bX5WaBKIIdrIPF5ZfOtIDx/rtYhm7YzS99NlQc3QooAmWpHiLiwZy4RQdOJyihST4EO3l4522oOltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RIy4VDym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+gGujwT; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RIy4VDym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+gGujwT"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 689A918000B6
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 14 Feb 2024 02:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896765; x=1707983165; bh=TNkvZ3MKBq
	5ux9qI69ZzlOVt3vR+Ps6mJQCLj0g1JS0=; b=RIy4VDymVgCYrVOzsJwf0mLCVx
	J7tlhfJP9YDjQI1uAaiwyT/lzZTPswUaneBAiwRxCMPufIPZaq/B55WM9Ebbf+iz
	Y8b+RqSDVDr+3utUyi7fK5JJIQHLqNy6OMYCAqqFh4u/kDcSclIAZmihG2a/rJp1
	psZuDj85y18AQED/BE5wUMb3Z15b2fL0BVUx0wDHBPUtDrZVNhH+o5j7Np6U4Z3J
	M/uy11nqxFa4iBa5JeUAju4dVTGCPrHs77jCHANV1yMLkP0pQGVZYT+5Kyc1XKCc
	9NGTLLqaQm3I637GYY8S+QbVTOSBpHq9Z0f0hoNPPzGJkOIVGiaym3XxzLaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896765; x=1707983165; bh=TNkvZ3MKBq5ux9qI69ZzlOVt3vR+
	Ps6mJQCLj0g1JS0=; b=W+gGujwTuQgVwfqaf5mPBP8jeugZkkF5AMOftgbreiLi
	qDI9RSUX/9XXQvkNrDNVCpRjp9b4O6SaXpQddef21NyAUB3FDBjDlj1T6re4UFqa
	u6t8GLREveABvxuVEXTLTREfsBdm3WqJpElg9gmlo5Irx1rTjXIQAu222AbGR8Pm
	gh2FKFNKqVkZJ8NIE26dc4XasDLrYEg8J1P0CBmTlYUE3ha5abVmtDOf9XJSqUDk
	X3PHAOi5UZqzNdiTcm7V5VSiG8tp3t2c/qf43LSEnoGV5YiZagoM7kUeo/4Ml3Vt
	ZlazptfpGJCT0NbNh3vkfmFA8okJCOs7CniwB6jh6g==
X-ME-Sender: <xms:vW_MZYGUv8KUgxmWbpI9ADH0tAoh0N1DmtqMk6aqp7JuPM7bMdWmiA>
    <xme:vW_MZRU94Beof4yLAJntgDkisvrS7-946fRZSBO5L7qUaDtelxj5xqWZ2hLfxYgdP
    EPR-LxptQAtKIargg>
X-ME-Received: <xmr:vW_MZSI4Fx5fEFBRTVUl3lCgUpmv3GCm9CDWv3t8QsS0VzjwhxXEn-qnRY-TDuSfpz185T3jNzsM8Y9LrOHr2Eq6310x5KKufzJg5VodFawY_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:vW_MZaHejCyq7vs14rYYDu9CdR3PZ0JdPu0_lXp0R-8_RqAUIVgT6g>
    <xmx:vW_MZeU0r54UWI3KAzd1OH7keuGIfXXGpJL1VwMVM-eatpMU8uX_Yg>
    <xmx:vW_MZdPfIdSH3mnPECwtLo42cH8cBndqtbETcuvbkATQTlcGQH1X5Q>
    <xmx:vW_MZRe9CoSSM039T-OrqDOupBo27HaoPNPp_TmDyMUJkrehjD5xLw7jil4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb2c42f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:42:15 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:46:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/12] reftable/merged: handle subiter cleanup on close only
Message-ID: <4e50ac655064481691b71f70a9265185976ccbeb.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3kexGlBEQE+9Gi7F"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--3kexGlBEQE+9Gi7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When advancing one of the subiters fails we immediately release
resources associated with that subiter. This is not necessary though as
we will release these resources when closing the merged iterator anyway.

Drop the logic and only release resources when the merged iterator is
done. This is a mere cleanup that should help reduce the cognitive load
when reading through the code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 29ad09f3d8..d9ed4a19dd 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -46,11 +46,8 @@ static int merged_iter_init(struct merged_iter *mi)
 				    &mi->subiters[i].rec);
 		if (err < 0)
 			return err;
-		if (err > 0) {
-			reftable_iterator_destroy(&mi->subiters[i].iter);
-			reftable_record_release(&mi->subiters[i].rec);
+		if (err > 0)
 			continue;
-		}
=20
 		merged_iter_pqueue_add(&mi->pq, &e);
 	}
@@ -79,13 +76,8 @@ static int merged_iter_advance_subiter(struct merged_ite=
r *mi, size_t idx)
 	int err;
=20
 	err =3D iterator_next(&mi->subiters[idx].iter, &mi->subiters[idx].rec);
-	if (err < 0)
+	if (err)
 		return err;
-	if (err > 0) {
-		reftable_iterator_destroy(&mi->subiters[idx].iter);
-		reftable_record_release(&mi->subiters[idx].rec);
-		return 0;
-	}
=20
 	merged_iter_pqueue_add(&mi->pq, &e);
 	return 0;
--=20
2.43.GIT


--3kexGlBEQE+9Gi7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb7oACgkQVbJhu7ck
PpRtqRAAolSHeLNoyEIiz/qanhLPVALANJWBSkbdNK1o0YhpVlKpif5w8TuR9A98
0mmDp02MNzfXM4TFacS6OGEEH+CA4av0fRVuGH9V3Xy5HGhrRSquzx5bQjsqSOkj
nk5I/BMx7oSa0QOPD0MQ8RpfqzCDUvagAdOg7suzGNAXjbk8o73Rw4FTmpd7O1qt
JKzsi9ryNecmOlkDkeuQr/A5OHVHoxVqpPNzijatZ/EJOTvFdQ8bX3w8DMNjrypm
kDJk9T7QxGsoPYO7XqDyQSap49s0Jk84bKsnLYlmtincA4rMNNTdQXmJFspEZyhp
BnJT0N5Fc/WE6G3MQ5s5KTR3rDXs4zIH8W3VS1vizys0/brwG3+tkoYuRyW29ete
VygsWU8jD4dJp1j70t3l7kdHNBFKlAd+DZjHDSj1yWizaMJ8hvx3wTIt9ruZJNqU
PIxZWf+SGWwv3hGxAt/SStDrXA4azEj+nhBy837rOp3QCh3xS5oJRWjr1LseZfee
xLvqI3ikW7nZPMizUxsoNVOugw08z/3Id8UJuerD3vi9uF5OMDSL2LNvYLcskuEy
0148Du1kNH6/G8sPt3wRto41GPGDLHwVNI1XnW/6M/RNcC8zNvuU2KltxZdoPLoI
up7ESS47RYl5aBCpktqaVCAev9yk4bKJZkCcP7un/P8bUIf4EM8=
=pgL+
-----END PGP SIGNATURE-----

--3kexGlBEQE+9Gi7F--
