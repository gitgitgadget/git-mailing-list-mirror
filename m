Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F89F15B119
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783123; cv=none; b=AXBxRj0rjXD9u386m9mqJbB15C4wNY+Xge1V9tbXZ3DDB1E1EUYhypAGUXWEKujDha4cIiotMLtQ5YUBS0ty9gbBmNHJLSfCOQs470q81m/RUzktxFU2KgRRKbiae/KsZDCNPiNlJEalb/uJ3GRJc3eGSQtAMgOBMSgxUxfUoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783123; c=relaxed/simple;
	bh=1CoiM0BAo4Y14MB2O4BLRomN+MVAgQbWGoI0OhPSRXE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY8EFUejliuDQNWEiZE1pIxbKCIVZYNSkG2SDFrA756hUsnL3KEvvslODP1WSugHYlvR8EPc2XqiTM94Wr/kmOKOAakipIeIj+hJDugmukUMMfzN49YX49h1vCgQyKtL/cWMtm7uNhNeL+V+ryX+nDFVAg02gbsfi4GGzp0YZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eMwvvJpk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4RPy9Dr; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eMwvvJpk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4RPy9Dr"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 45717180007A
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 05:25:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Feb 2024 05:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706783120; x=1706869520; bh=rLG/PQ52GT
	PDY3nbMdNRAcnoU6z9+a2r/rMNHTfxskM=; b=eMwvvJpkvr437wAlPsx/IIOyRW
	ZekYcH9btI+tM0M4G2c6F4oiaKA/LaYsFFXTw8ux5rw5J2xEGZOxmtc7n2yNwmWv
	A51Pqmnx+bwBNHP96S8yWz7cTx14WuLzKp9ScFp7xzPJ4omgzla48RT1VDTA0kFN
	AtqDTmQlZTE2t4FpeZYTs/kWRombCwQzjCxUCwgta5war4gJY6dvBxEfOB6rGffK
	KV9PY24T0XdJUKHWTki8q18jIEiDfQvfZFnQ410FlyX2GRqGbVFa17VghFafvF52
	gRWY5gavpZ+90EF2TVt0tDGrHHkNdrr2ZUbpZtnELKUmG9KfZCUNRtjtQV2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706783120; x=1706869520; bh=rLG/PQ52GTPDY3nbMdNRAcnoU6z9
	+a2r/rMNHTfxskM=; b=c4RPy9DrfYHk/iwM0A+1WBZhPy5fEFFfx3ztWZ3EjXJb
	8EyPhvuzxg5iI8eC02F0Yi4+Y2SedRF78zESaAZQqe4rNoJE3c9WdYC3dcma484s
	Vof7KlGE6RLrITtyLWE6MrJJ0Fy9aH4gCrm5DsBD8pCQwY9/U1xE2PgzXakOsSqZ
	Q78vDA4TYZw3k3QOhvOTO878CcNvM0Prf3NUwDuEy+ssoKn0z5PeJcEerkDgZR0m
	A+B1SNYr/D/eqTG2MdpW7VW7+/JE4UYbTaX7QA6UOsxJxU9oASr3XphMZPLiowRf
	draaGfIeZylfY6+Y8duKdWjoflLsAS1PHzcuoNTk1Q==
X-ME-Sender: <xms:kHG7Zc-Kyyk2w0dq1JsXdeycPdPDt8d0wsMMxWeWlDM9Cy4Pm9xlKg>
    <xme:kHG7ZUswKmveTHTXo4S1d3GmtOTqOVuUE755uneDAi2xgdCIpVHPeiyA1RIPVFfSg
    6ebMtTKsDSrOWDgew>
X-ME-Received: <xmr:kHG7ZSBK3g45W7N0L4v9IDUjFMoDpeX3KX5j7Ursk1jOmDucmX72bbvud3Zqn8qYz5RtDXhnIu6-RQy9l-9oefSyuOXG2wEOELInepAX0jLOkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:kHG7Zce7oWV3h7L05gLrrRiSPfFEvyiXHO1ynwBWQ38EsUvazqVWKw>
    <xmx:kHG7ZROCSX5W0i3tADeKX10e_seay7cja76Eu_nV52lMbU5z_oCxWA>
    <xmx:kHG7ZWkQlLQmBSQWrvd4Ip7m1YI-TpEMmy70t1hspUCpmaDqFbHRPw>
    <xmx:kHG7Zf3Yk2XubTYzL0eE4ZVZzCVYzBsnWXnK85XKVgoPhVvELFdDuA2ECVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Feb 2024 05:25:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4752ee0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Feb 2024 10:21:57 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:25:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/7] reftable/record: don't try to reallocate ref record name
Message-ID: <41dff8731c308c6d72ebd0066be8963bda725ea2.1706782841.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tqj6nEZMXlA4Bfyb"
Content-Disposition: inline
In-Reply-To: <cover.1706782841.git.ps@pks.im>


--Tqj6nEZMXlA4Bfyb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When decoding reftable ref records we first release the pointer to the
record passed to us and then use realloc(3P) to allocate the refname
array. This is a bit misleading though as we know at that point that the
refname will always be `NULL`, so we would always end up allocating a
new char array anyway.

Refactor the code to use `REFTABLE_ALLOC_ARRAY()` instead. As the
following benchmark demonstrates this is a tiny bit more efficient. But
the bigger selling point really is the gained clarity.

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     150.1 ms =C2=B1   4.1 ms    [User: 146.6=
 ms, System: 3.3 ms]
    Range (min =E2=80=A6 max):   144.5 ms =E2=80=A6 180.5 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     148.9 ms =C2=B1   4.5 ms    [User: 145.2=
 ms, System: 3.4 ms]
    Range (min =E2=80=A6 max):   143.0 ms =E2=80=A6 185.4 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.01 =C2=B1 0.04 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Ideally, we should try and reuse the memory of the old record instead of
first freeing and then immediately reallocating it. This requires some
more surgery though and is thus left for a future iteration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index f1b6a5eac9..6465a7b8f4 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -377,10 +377,11 @@ static int reftable_ref_record_decode(void *rec, stru=
ct strbuf key,
=20
 	assert(hash_size > 0);
=20
-	r->refname =3D reftable_realloc(r->refname, key.len + 1);
+	r->refname =3D reftable_malloc(key.len + 1);
 	memcpy(r->refname, key.buf, key.len);
-	r->update_index =3D update_index;
 	r->refname[key.len] =3D 0;
+
+	r->update_index =3D update_index;
 	r->value_type =3D val_type;
 	switch (val_type) {
 	case REFTABLE_REF_VAL1:
--=20
2.43.GIT


--Tqj6nEZMXlA4Bfyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7cY0ACgkQVbJhu7ck
PpRK+A//enPmi/UCJzmy2E9zuVL7qioBhzGdYswZzefQ/rjKq0WgTZwWeJ/DMP8g
kHMou3JC9P+iYMYOIBYy2PgQX9JeyEne4kj/YO9nK7unK0tG6Jc3IQWZgAu6BHjQ
xOW2262shnkZHnSglBWXgIvyBECS2LGX/IHzjviwDZAbjU4OAWcnwtHMlsyvOibb
iBdFkLu0+VIVueLhGsq5c405fR4NQAuv+sRH2Np+8EQxYPRD9tFGmmhHnBNg3l4+
XRLbybz5JdIb3bsvHqkpSW7zFv5uXp2+q6wfhyd7X/5/xtfqe9RM5dlnTY4txvpo
/f4m54UIHVrDj3vGr02rJRB/WOtfMWO5Acjml4YTgG8Axf44kkv8vZQrWipKE5KG
tv9bWG2FnxkPBTozKIW1TKpK9lqLU9Z2j+oj3kQRoR4Q2DGwZqd5NaUS75/DRowj
DB1hpp2V2lYNlGt4xgldk9GNcmz8NPhk4bfbPJrWcxY3WfJ/B9k1zmEyWMvQRRDk
CIPWlqW7c+K5VzRtTTJN4gXuOVx3tTqx3AMkUPnrxTHZP/pqdLNhNnN9SSe1G3mb
DUkZseyFQ+pzlOM7UD2+oP1Hus/v/PgUPxy6UvD3XPRMBEbuQs+MFPNRFdX9H74i
QfnoPlhWem0cXyX1QayA0kookFSlOOxkmCHpANq8WO2CyoSumVo=
=JDbY
-----END PGP SIGNATURE-----

--Tqj6nEZMXlA4Bfyb--
