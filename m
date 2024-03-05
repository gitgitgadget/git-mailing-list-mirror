Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A359B70
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640672; cv=none; b=Ean3QP4h4wmRnI5U8E3ajE0CzoAPIgOjNBWFoghpA8xK8rNYVQhOJaV/xW5GGnRiR4fjSmXhV5Vl+GJ2gU8wf1RoNc7QPXDiALPZk6/wde50mSbMNnoz37/FkAbcugmypt29uMhYvu7hvB5JQNu1zERBE4HIopvM2aoFzStm7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640672; c=relaxed/simple;
	bh=tRbbwOBvydSdzec4rx2WP+Xun9FCK2CVI5qa3vF9kdo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO2wQMdpJp/PuHViyY9AR8o/eUVepZ3C6YzzjqxwYgvuKsgQZUEJWOMKUiRB+ado4D3IGA1kFBnpgf+MUKwKfz3jgfKvN2hqrtRYo+unw5lkkindLki0bdv+zkAoo7lj0vjPeQyQYH0PrvOioiMTEiN4PZQ46QwY5QdBX1iWoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EfUksEC1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=McXTYmZB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EfUksEC1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="McXTYmZB"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E55251140194
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 07:11:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 07:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709640669; x=1709727069; bh=vItQCISr3E
	v5De+EyHHmUOXn5iEsq8CRO4f81NUfses=; b=EfUksEC1ZFzAlZICajo63ZVoHa
	hHk7202s6Mn2C+5MQNVm9xfVleFc6iuThxKQmtH6E/jT5QK3P09yE18ppZDImGcH
	Cbqg9ww16US3oR0XbtrptUzMTSkhZ4GBqjDDO4E7ecuqL/sTKDM7xeuN2hCZ8VTZ
	Q5RoFh607F1aDG4tNRUxmDGqJSP89XCT8FS8/eVfryc5ZOOrmf1Y9Fgp8CnkVIlI
	zIxI3fWX49tB/KJfM2hnu9KqKyaMGDxD4VusSGhEUpTxJ7FuOdxumfs98rKM1opa
	uo794Z/oOhnbjEpxq3lIpkOAzageEQC9nLyDLj8+YBXBPGNaClSlotkMDOIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709640669; x=1709727069; bh=vItQCISr3Ev5De+EyHHmUOXn5iEs
	q8CRO4f81NUfses=; b=McXTYmZB19sm/FitBJZufInH465A3ngcVpBzaZjMCscq
	jd08E0ncH/lUpfjuCrkR+iHrI5mK83gj5Wr0Sg39uF/P7+yshAgKLZPJ1pB1iTlE
	SEP4sS9HLsjcgFRzmeKLmNfRCTvgvDOc3M1dVSYmxBh1DX2KiwMuBFsthye+n/cd
	JIkgvbq/GICPmqletEotmtlesvVnMEDJ9XPchRwywkr/ILQWMr0uHuB76ITMdz9e
	NkbM393jS5jigX09tjYvaLdIRIC8iUtwA2tveKF4sXWo+4IE/ECdMNjFBtWqLJ1k
	+NoLfcwHgTLQlYNl7J79wHlKSqQ/Outs/rcrfU052A==
X-ME-Sender: <xms:3QvnZeOaoxlqOaVGVfoJodpiC75IpbRTobjdcpUAHr69mTxrehGPrA>
    <xme:3QvnZc8AC9NiofP1PwY30G46hgdJPnX_lYYTOwphlKeJal6aX2gP3BSlrI-CynT6X
    2msKXNPzwEK7oRPoQ>
X-ME-Received: <xmr:3QvnZVSqnfYf2KZPyyCvfwxIIiSTciKzL-lr9WTfcROQCzi4TFY8yr3UXm-VV_hJ-IpeQkLf3WzJcJiLS9B26WjuYT6R6PoV60UEYKo5NsXRoxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:3QvnZetpfMqoLJ5HXj7TXzFe9TWb9Vv8rv4qy5R52aJNOXhKUw_ohg>
    <xmx:3QvnZWf_Cak7XnL6ha7G6cTUit_CxYS0kiP8xQ35t_QAKy8h_Du5HQ>
    <xmx:3QvnZS3lkjq81c0W0Gt0TFwT9iVHy-swXGMugst7PUmBEEfBLNbhoA>
    <xmx:3QvnZaGnIL9J6yCtuVBDtOkn8WH2Q-dEljBouRKJcsrI62JPcvUhPg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 5 Mar 2024 07:11:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 695b2f70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 5 Mar 2024 12:06:42 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:11:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/7] reftable/record: reuse refnames when decoding log records
Message-ID: <f2b59e58a4e54e2a3d1df2c73c4f7acd92a57604.1709640322.git.ps@pks.im>
References: <cover.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nwhFMudoYwOVZZic"
Content-Disposition: inline
In-Reply-To: <cover.1709640322.git.ps@pks.im>


--nwhFMudoYwOVZZic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When decoding a log record we always reallocate their refname arrays.
This results in quite a lot of needless allocation churn.

Refactor the code to grow the array as required only. Like this, we
should usually only end up reallocating the array a small handful of
times when iterating over many refs. Before:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 4,068,487 allocs, 4,068,365 frees, 332,011,793 byte=
s allocated

After:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 3,068,488 allocs, 3,068,366 frees, 307,122,961 byte=
s allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c          | 2 +-
 reftable/reftable-record.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/reftable/record.c b/reftable/record.c
index d816de6d93..82780b2d06 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -861,7 +861,7 @@ static int reftable_log_record_decode(void *rec, struct=
 strbuf key,
 	if (key.len <=3D 9 || key.buf[key.len - 9] !=3D 0)
 		return REFTABLE_FORMAT_ERROR;
=20
-	r->refname =3D reftable_realloc(r->refname, key.len - 8);
+	REFTABLE_ALLOC_GROW(r->refname, key.len - 8, r->refname_cap);
 	memcpy(r->refname, key.buf, key.len - 8);
 	ts =3D get_be64(key.buf + key.len - 8);
=20
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index 2659ea008c..d28f38175c 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -74,6 +74,7 @@ int reftable_ref_record_equal(const struct reftable_ref_r=
ecord *a,
 /* reftable_log_record holds a reflog entry */
 struct reftable_log_record {
 	char *refname;
+	size_t refname_cap;
 	uint64_t update_index; /* logical timestamp of a transactional update.
 				*/
=20
--=20
2.44.0


--nwhFMudoYwOVZZic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXnC9sACgkQVbJhu7ck
PpQJdQ/+M08NM0qkKiJno8c0Q4z/iyZjVjlB9Mu4Z0238i7/PAu8jRDL0LcIjrBl
x2npCZpYSihHPwCQQ5rhIzDJEOpDDupB697SE8gup/5RKXKAq+xo5iSP3YMp3hiX
HsBkwR+XVTtL7Rw8AAymJVgWYtMo4x7CQOjCHFbM70xnvClOA4kbDPAntyxFp+Q5
8qBnI7wzKca6woBEBLfLzj2+yWg/qw/q/vMl2exv96Ok6BhyaqA5udd8NeA4ogXw
2i3D8j8mYiMiKH7Rd6HC8IClcABJnzQwPUAlbS7bGHZV2dunzbrcyA0WI7t3UVp0
vGUGDRHTyGp7F1ufPtLQev4RKPDYB12b5S+sD/bD6MZXouuXH6G+bRbnO+R4939G
T6i4y55HS3Or2Vl2cn5Imy3g1dHN/i0JEdVItdZ3DkQ11OG4Rt62Mjq6ZwExL+pj
Z1JBd08J574IgiLGhx2QwvNHT5CMvtJIj1IB2hStenoon5yAc1KwczhS2iWoMWri
F28t4obi6OETBbtwvgbwmCgUI5ULCODL3bUjkFemuO7bY7lne0cY44EC37YBLU9g
cxSYfSG4wQCTe+aHJBGMcvCzIofvySIyPpnfWCmXqO8Xbo7hBk9vp/WCS4YUY4oM
ngzKLmSyAm9El3qEHVtoorqHEz4tTI2nJDUXcUzQ0soyOGxsCzA=
=0SOl
-----END PGP SIGNATURE-----

--nwhFMudoYwOVZZic--
