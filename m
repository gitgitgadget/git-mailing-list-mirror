Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AE374C9
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549364; cv=none; b=Neh3XEtouRm6FHbDc6x3FxVSk1sA8fBBXvP10Urfdn8HEZmrJx9aWaXZprBPHHmFFsiqRxyBZqfzxhQ7aNcFm/5DOlhrW66lomh4RA23BQ+hGuEGnsllCDLQH2w2MrM3dLqodHybS4q6M1mIABCENU7OP6K4Rr4qfu8gd9KvZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549364; c=relaxed/simple;
	bh=cV3UbxtQegkptN2RHDrMSaOaBXGNI1xfQWfiuIMjMSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzR3EHflZ4z2UOQ2TIPwOu3RjmlxpCNq1oEFMp1b6JaKjmBXYWrB6eEo//JrhhzLGCzr6qn09XhM34YANvOP0vN0ysCbgAzPo+Ard+xAPQax7uY0IL866PyGuG1OiX6lULTcuOo6jM4TFp51ieuSbalnd3UJlXxYvaRzH/vZ5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aLJeV74H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eMO7kIgy; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aLJeV74H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eMO7kIgy"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 815343200319;
	Mon,  4 Mar 2024 05:49:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Mar 2024 05:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549361; x=1709635761; bh=vZzISe3dIS
	K4MomJJtE2+9xFuKL98uvgRRfGCMQxRi8=; b=aLJeV74HVZSqpt1nZ1/YmyQT0E
	1CHp/9cbcNvHeQMaABNKZi92QPS/d37wOWYWshdt7wz/KFhwVYYL7pgBy7I2AckW
	V2hOAzXQekUudtK4opZAtffLXkQwXZwD+FUvL0mI+nlUlZ0xcBpkAhImUmw4MDOa
	ETYMjudf/R3dspGYg4K7C2397ZOUcz3W245VnhYaa7uJs+R9+Rkbse5pShaMv51f
	8WMQSciFTfecbZ/+Q298gKkl/FWPSsEpWipBjl+ns53lqVFKSl141p+aKeaDY+ge
	XiBcwSqcRWdRlbtbcaOYswpOZLiParQBifevE4YR4bLQKgelbMwWlIKfTa0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549361; x=1709635761; bh=vZzISe3dISK4MomJJtE2+9xFuKL9
	8uvgRRfGCMQxRi8=; b=eMO7kIgyuJkdJ2O7qecgHVDy/wFOQRIqxZ1voJwa0MVt
	iQOvKEKLurOpjQxdcEORk/Az3TZB6Skyx4Co6ulWkSU2uoNogNkv9T0Izi/9IDEa
	ThjitYbUm88/o7exUBUjNQ9HGlu1t6dd/xsrTqTYKgi22SLrgGRkMc2U3xYBxi0r
	gOH6JATfUv3i3Kz9ZL3dRxPSdysNsHqY7FOfaNEsL7G/dwZeMy/XI97VQnMlVgAw
	+Gfw+qTLLwEzy7UaWvgFOHv6BJ5syTcS4H+9zU4N1zPXT8h3ueJYfL9uTBx/yL/W
	PydXJKj2fwnefp+CAcWKYl8R4sR8bzBEVs3ydJ2H/A==
X-ME-Sender: <xms:MKflZbIhah9fbq7cy-QJuhtKBYUIaDRdmzlh9yFtpS6FlbL0NM6VzA>
    <xme:MKflZfJghG7-RPqYo5lWr-WpuQHhEqfuv8xONGoZcRW0HOcoeHkyodbIEVK-7sLwb
    zExdkEK7SdJuK9WTg>
X-ME-Received: <xmr:MKflZTsL7y_wc4KrmY-sR5JKddTcIEtyHLFQH2hhj9zYmjPxizwynEJvSaGMIDpVRzOtUOfagVj2eknRJacGHIrRQE-k3QyK50-FeJE3FFrkHkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:MKflZUY2JvYQSYZtEz082ief6S5B7kro4C4pnlZgNlgSRxHLMmlHwA>
    <xmx:MKflZSbE0xtUSujLYb-HQOaQxql9ulCoj53NhDhs1oYxjk1uskKbCA>
    <xmx:MKflZYBEU2MD1cE0fBCm1hOr_iGmzhFB_LNMGLQ4FOMG5uElWXxRvw>
    <xmx:MaflZRnwaM2S4ze0Fwm2h0qiUyW1XjABePE5HW8KIi8cxGTLb1JTrg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:49:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 23f204c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:44:55 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:49:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 08/13] reftable/merged: avoid duplicate pqueue emptiness
 check
Message-ID: <04435f515cfd9a1f86527d82e87bf7a27182d964.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N1OEXOEK2LU4M3C6"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--N1OEXOEK2LU4M3C6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `merged_iter_next_void()` we first check whether the iter
has been exhausted already. We already perform this check two levels
down the stack in `merged_iter_next_entry()` though, which makes this
check redundant.

Now if this check was there to accelerate the common case it might have
made sense to keep it. But the iterator being exhausted is rather the
uncommon case because you can expect most reftable stacks to contain
more than two refs.

Simplify the code by removing the check. As `merged_iter_next_void()` is
basically empty except for calling `merged_iter_next()` now, merge these
two functions. This also results in a tiny speedup when iterating over
many refs:

    Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     125.6 ms =C2=B1   3.8 ms    [User: 122=
=2E7 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   122.4 ms =E2=80=A6 153.4 ms    1000 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     124.0 ms =C2=B1   3.9 ms    [User: 121=
=2E1 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   120.1 ms =E2=80=A6 156.4 ms    1000 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.01 =C2=B1 0.04 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 29161a32cf..f85a24c678 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -148,27 +148,19 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 	return 0;
 }
=20
-static int merged_iter_next(struct merged_iter *mi, struct reftable_record=
 *rec)
+static int merged_iter_next_void(void *p, struct reftable_record *rec)
 {
+	struct merged_iter *mi =3D p;
 	while (1) {
 		int err =3D merged_iter_next_entry(mi, rec);
-		if (err =3D=3D 0 && mi->suppress_deletions &&
-		    reftable_record_is_deletion(rec)) {
+		if (err)
+			return err;
+		if (mi->suppress_deletions && reftable_record_is_deletion(rec))
 			continue;
-		}
-
-		return err;
+		return 0;
 	}
 }
=20
-static int merged_iter_next_void(void *p, struct reftable_record *rec)
-{
-	struct merged_iter *mi =3D p;
-	if (merged_iter_pqueue_is_empty(mi->pq) && mi->advance_index < 0)
-		return 1;
-	return merged_iter_next(mi, rec);
-}
-
 static struct reftable_iterator_vtable merged_iter_vtable =3D {
 	.next =3D &merged_iter_next_void,
 	.close =3D &merged_iter_close,
--=20
2.44.0


--N1OEXOEK2LU4M3C6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpy0ACgkQVbJhu7ck
PpSytw//Vsasuz9JYtjM6wllLP/4FxagegKqYLLvJwGqHSAvxiVFGwDC8R+OFZh8
gaDzSCI9hiBXuMKbHoTkc0oSwnYV228EmfAsP3jYKUJIzwswL6OJcz0U4S0potLs
qNw0EJzFunHpOHAtxw5lZLjdBnmA9W+3BaI4sFqEU4lK0Y3yTTiSrDxNuc8VxruZ
Mhni6ymF/iqNO1u7kdD9rI/6bwcmJfz5/gvh9zdDGI2xdv5QmOG6vnVSz95eGYlD
kknpklsa95hi98IWh0lemvX4ZZM+jBIjfrQ1w1OC0B1z8bCdRPUNiodHSyGQCuYT
BS05JuxKVT+zISyi7VmkRfb7qxM31dQKkdABfVx9cMAvcN01lyUPdB1CzYjik75P
FD8BB11HCWiIf4vCM4+aghbseB4IfSBYajzhRneIR1CzPGYrl5/1r6oO4v1um18E
P41dih1NBOININxpd5liT+BJWq7lkMRVPKDA40ltwfRESXPJJ+e6cRfJ0Bo0omTo
rdYCet+YK2Yzhse96Yw5JsxN3B/XAmjjAJTzYax++TzghLRHFOWEZ2RI1mR7GwPO
Tp6kpBei7HwrvPaGNyXm+tTHuvQdJocWrDvYutXFMeLoaLCoC+LxeR3H8Jz9+u32
+oCkVkH5lI86kXJk1dGood0GQdspm9G+9Op2VTIkptqy+3iZXwU=
=/dD7
-----END PGP SIGNATURE-----

--N1OEXOEK2LU4M3C6--
