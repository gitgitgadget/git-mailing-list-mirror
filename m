Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013119004E
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316987; cv=none; b=cQeCRu5z1aZw4J3F7dOHhSeKt0I3NKGeM0wV46VaXlQzuA53U2oqwelVjpkXICSxDR9BFY2L+HyxhjPgrsrkIsWWQC0Mt9K3L8xRQiDJ8qL26aIEFL+UckEC0tPk+qQJ9xSahK6kgqjjUKptxvdxrtPPNt2SlzNRuuDGBPkhC6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316987; c=relaxed/simple;
	bh=7RnIvN6yNva92PD4iEA1aIr2vjZvr+VW4+rHgDzyMsc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLUItiKuPHWM9qrK3INykY/r/swK66zaLZ+LyymO2qsy21dbgUwpqg52UPMcQAgEyFR/cchyYmCSLJMow/seVz4IcGQcPo8ypDk1/NHjsrO1UBsh9YXL+c4aD0kKCr35uUM1wEZeJUxtSccve4z8TTIoWUIgOxC8lacm7K3PCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Prssf/Cg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O3se7qrr; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Prssf/Cg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O3se7qrr"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 48121138072A
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:23:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 30 Jul 2024 01:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722316984; x=1722403384; bh=cEo2I46n7W
	XN/U2kk3rjlf4PgqjeD10xph1rpTXNlMk=; b=Prssf/Cg74xgUoIXlZWYu3gU+W
	Q5i3esu8bZv2ill3C0EIvbg6IsT4+Z4Ghjks7C5ZMBMcvVMYSN2hRpZ5x5FceBR8
	r5Xb1ytTn2WoMmpCuZj+MYXZU1JngZzmT1asOLIPDtu9kmb9n/SKN5Xe3596q00h
	GP5m/3msCY8rL5HLoV6Xn45jxJzOh2plphhnmH5hnNnRDXcUYfVEnfV6ekBbO/AG
	cNzEe3Ub2Q6fgeG+/xRR7VDhu0xyWqDbXzOS5A5BlK1CiCs5drLIHbwHiO/KvT5d
	zjjJtvsvBzFCeYXgP6Nors8muTNAhrOl7nCVSfCx91506toMsKBI0wNuuO2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722316984; x=1722403384; bh=cEo2I46n7WXN/U2kk3rjlf4Pgqje
	D10xph1rpTXNlMk=; b=O3se7qrryhxY3gfRz1UDK1+IFobcY6qIEDMmAaZqKZAE
	2viUayRyc98rGyoysy8NoVT9Kh366YCCv9Mion9SXOBJj0XV75zAmWeNWP+TRNFT
	ulWx9QpkulTx/ZFDyfGx2dmssaUzjB5zFuY6jo9xdHydJmK97AIRtE8XkJCjFlE2
	ph4iCY8tKcgoacSuDzYCMvABf9grpAeXtR5zMbneD9BC6ES3K7sUYwFuHyALKtrz
	EwnFd0f9scx+z0u7qOQj1OqFdD/JGs/h3uBhd8C9HrvmcowIy3Ify8mN9AulgJLh
	sb+DCuxfEHhl4vkMqMaOD9vntPiSa6iy1i1zFir4aw==
X-ME-Sender: <xms:uHioZm_iAm0GxhHnS_6n0oL71G-LgyGv-4GMWL7vwDsJOeYK4iNNtw>
    <xme:uHioZms_9En8ewov-yyb_j5pF40f0InhDusc78h-jtorvvSWZWjo3wGdEiVvoqcGx
    5V8ZmNE2ClhxlRu9A>
X-ME-Received: <xmr:uHioZsB6_SXwC6vvfTpd2W3gVd7dYitHQfdlH_accGP6hkHssm2xUJ0W4e6oKKkkmwPuGyNW_tZLhsdadrKelTcjJc7gGGSNOEK4BIAB8jt-sVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:uHioZucvGdfVN2QXromAc-5HQ38Hsppl_4IdEOA0OtUvtTPwyIiuYg>
    <xmx:uHioZrOz-u1ibGi1tOO9MlXWxSrYrH14YHUcAQnkDQpzSZw0lTWnNA>
    <xmx:uHioZonxG_WfZpLilt21wskwhAg0-ik1JLsEILwAy8o69Dss1MtdEA>
    <xmx:uHioZtt-0GIYRGBNSyViP_1GSJqfB9JaLoMOl0wNiGUxtheZX5fVuw>
    <xmx:uHioZh2xud__xZO3es-b0jntKuWlc0PLu2fokYXIbAeacdkNUofWazot>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jul 2024 01:23:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ca3f248a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jul 2024 05:21:36 +0000 (UTC)
Date: Tue, 30 Jul 2024 07:23:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/5] refs/packed: stop using `the_repository`
Message-ID: <d164cd3aa12b67ba98c9b878543497482441ba2c.1722316795.git.ps@pks.im>
References: <cover.1722316795.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tASRDnDlIQAVlrXQ"
Content-Disposition: inline
In-Reply-To: <cover.1722316795.git.ps@pks.im>


--tASRDnDlIQAVlrXQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert the packed ref backend to stop using `the_repository` in favor
of the repo that gets passed in via `struct ref_store`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a0666407cd..89976aa359 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "../git-compat-util.h"
 #include "../config.h"
 #include "../dir.h"
@@ -794,7 +792,7 @@ static int packed_read_raw_ref(struct ref_store *ref_st=
ore, const char *refname,
 		return -1;
 	}
=20
-	if (get_oid_hex(rec, oid))
+	if (get_oid_hex_algop(rec, oid, ref_store->repo->hash_algo))
 		die_invalid_line(refs->path, rec, snapshot->eof - rec);
=20
 	*type =3D REF_ISPACKED;
@@ -879,7 +877,7 @@ static int next_record(struct packed_ref_iterator *iter)
 	p =3D iter->pos;
=20
 	if (iter->eof - p < snapshot_hexsz(iter->snapshot) + 2 ||
-	    parse_oid_hex(p, &iter->oid, &p) ||
+	    parse_oid_hex_algop(p, &iter->oid, &p, iter->repo->hash_algo) ||
 	    !isspace(*p++))
 		die_invalid_line(iter->snapshot->refs->path,
 				 iter->pos, iter->eof - iter->pos);
@@ -896,7 +894,7 @@ static int next_record(struct packed_ref_iterator *iter)
 		if (!refname_is_safe(iter->base.refname))
 			die("packed refname is dangerous: %s",
 			    iter->base.refname);
-		oidclr(&iter->oid, the_repository->hash_algo);
+		oidclr(&iter->oid, iter->repo->hash_algo);
 		iter->base.flags |=3D REF_BAD_NAME | REF_ISBROKEN;
 	}
 	if (iter->snapshot->peeled =3D=3D PEELED_FULLY ||
@@ -909,7 +907,7 @@ static int next_record(struct packed_ref_iterator *iter)
 	if (iter->pos < iter->eof && *iter->pos =3D=3D '^') {
 		p =3D iter->pos + 1;
 		if (iter->eof - p < snapshot_hexsz(iter->snapshot) + 1 ||
-		    parse_oid_hex(p, &iter->peeled, &p) ||
+		    parse_oid_hex_algop(p, &iter->peeled, &p, iter->repo->hash_algo) ||
 		    *p++ !=3D '\n')
 			die_invalid_line(iter->snapshot->refs->path,
 					 iter->pos, iter->eof - iter->pos);
@@ -921,13 +919,13 @@ static int next_record(struct packed_ref_iterator *it=
er)
 		 * we suppress it if the reference is broken:
 		 */
 		if ((iter->base.flags & REF_ISBROKEN)) {
-			oidclr(&iter->peeled, the_repository->hash_algo);
+			oidclr(&iter->peeled, iter->repo->hash_algo);
 			iter->base.flags &=3D ~REF_KNOWS_PEELED;
 		} else {
 			iter->base.flags |=3D REF_KNOWS_PEELED;
 		}
 	} else {
-		oidclr(&iter->peeled, the_repository->hash_algo);
+		oidclr(&iter->peeled, iter->repo->hash_algo);
 	}
=20
 	return ITER_OK;
--=20
2.46.0.rc1.dirty


--tASRDnDlIQAVlrXQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoeLQACgkQVbJhu7ck
PpT1wg/+N+Op0lNujazghdTEbntVuiUhPsIAMhMm/mCsQuspiVogzAQvBzZRiG3T
9r4EyHPnlHJuhqzSG5zZ0/KpRZ6nzjtVhEzNnIpsokB31OKvsTwpJfrcIryBHQtI
5I26RWm8R1j/q/IiJiUElg9Y8ce8mKuqLgeRRk8t5vb8FRhM+JQa/Gp834pnCI9J
oJKdp+0ywf7zlaAF2grcIn9GBOVwdIuRmBkL5Uu9tjlUUZ0Q2PCiIDXWao57xkcw
5JY4nCnn0myvgI1f04BO4/P3I4SWxNJ1G5ZMHpBE64lMn9JrJI69BYpJ0IDSPX/U
ndvc8lDWqWgMAsOoTZuO6Ixi1jEioVA04vaEkB9pasCONR07VQY9l5XP6lUT+2uN
4fwh8iIHKvn8sOsdEMgZpjePn0qJNlp5qLbVL+F603de8w0ph7XEU4XBvh2FtWvz
mWkeL6qzOLiqtFstY06h1bhgC7/iZP98Pzs07ripXX2C7vgSFWXlLW2S5HENfsRM
RjmaDP7kn6Rbg5VGYQeF2YdtZI16aZ6UJ9ueVIlv2/TKnHo0tZuSsOb7SYgrj2nc
udg744Ksz8xjr9IWFaZKM0yGjDwRCZz7a+BOe2frDvUoAwP6ojg1r1daxpPx/wUt
+SfPSTCUtysVFQFycYzHeUNu/vulEC7NNs5e0a3080hRGkHa0PM=
=bINQ
-----END PGP SIGNATURE-----

--tASRDnDlIQAVlrXQ--
