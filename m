Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B635153BFC
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742344; cv=none; b=eambPpXCrY32zRliDLzb4UtJysAKBB+Ar2M6ktkmS47tSd36wG5JJ+whV6oTLJHubZxaelNDSHD5n+i+akd2DUp1l12AH+W/XahHY9YsHqV2SWl23H+ggRbE2ZU3lH3eckV37CyDKw/tXJ4TXkK6pMCel913QIJHp4vPbVF3ftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742344; c=relaxed/simple;
	bh=/p+WpLyng9nh+2AOLmIMmOijfdDLU/fUaOsYBfweZdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD/g2shkhxsPNsctJO6aO+9j69ERqJehpGf8Bww2Ie5MAl1vGUd3Ek7P7wI5Fsqzk5esbfkp/c4MK60L0WN50Jw8ZNgdHibSm3Zq4SEhD4r+LOk5Kj/dDxMlamXK0bTJ0v4aiVhx6M8zrvWcHAqDtp8Sq4QmdXgNElsOkFHJD58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UaNh7YDS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LWUNY94n; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UaNh7YDS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LWUNY94n"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id BB29B138021D;
	Fri,  7 Jun 2024 02:39:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 02:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742342; x=1717828742; bh=Ogiz0ah0Bh
	LxXHbYSR6T9Z7V2bTt6TV2QNsXT619+s8=; b=UaNh7YDSUxsuZCns+7CrwaOTxe
	Hf4jEHAK5MvxqzioGGAsVgA+Lxzr4ufHB4+S31gU8xXbh+uB/V1xjOgFq7V16QtX
	+HDhp9vXtXHw1YFkD5dVeqZW1aPmrR29Ip19LekF+xs65q/ayYRGqtry6xHDn6zb
	8nPkxgKPjVq0Wi0s3XomyLc7Dj6dYB2keA9r/NGs2xaEMK/boHdnxUKWHUyZhYw8
	j3xT0qFNnP1cNhTG7B0BIh/s3OLRz8jVsloJhE5FKzeCwvFhEwpFshUdliwEt56a
	mwBcPW61ZpRzfgzKj3dudT7hYKSuvzxs94IFsf/ryxg0bz6kFx3Lgab/M01g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742342; x=1717828742; bh=Ogiz0ah0BhLxXHbYSR6T9Z7V2bTt
	6TV2QNsXT619+s8=; b=LWUNY94nCFw4zLvHtmOoWWsn9UWYCrvSaHJ1nBfEGlle
	UtwplKw9OfFX9k9aGpivKK0FBvPNpkXAk+aO5TcncedCFmjfHa57DcdgdJtkeF2k
	RTBW+YhxoHxqlawUeJsi6NvQ++enk85gnLftGSq26XdQjUGqcBHTTs5P1HpXMRkh
	ZIGz4Z58kExBf57D4SV1Qy4BCGiIhMlwu5kNvRRES8ZEndFOkFLzrZILjobT7GBl
	UrNpj+Y2bpa1frTNV6KwR7+ghAXr8/F3TRGXB4Dc86zwh649GDsGq8icrWI8WKEg
	pB4C1sgfd6CdGx1ue+q8lLEZI5I7YKc8xoQZRSfWpg==
X-ME-Sender: <xms:BqtiZsOWcfsmI-HtvwKJUWGK0M7FWFn_kMcMt3715E03eigCrdlPKw>
    <xme:BqtiZi9_inoL4O_gzBx137p4kriWd_BrNt15WUhTpLwMnkt51jXdgj9Gys0ImMNMT
    NICVP-ZD38K6omBWw>
X-ME-Received: <xmr:BqtiZjS58JOYbK5m1SulSWdVHioh9Dgxb50RRmA8lIvF_McraNQ9xqrEjJ3S00n6liFxnyNpxmYw7B55GcnVUwBLU2NSUyKtro2EE1RwTHQDoIxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:BqtiZkv_tlyEzI6PVbHPkLjCG4dChihq1FmvwJxL1r41AqX62FuqFA>
    <xmx:BqtiZkfZr4Lf0DGfugNS5Sc71NUxIo3t-C5zylaUez5cE_55J3dNFA>
    <xmx:BqtiZo3pbwKt6U06sr5AuVl1aDiyXk9AaG-En6ut3KnMzJd74uN2JQ>
    <xmx:BqtiZo-wFJwKYufvgs4e7ppL-z865cAKun-ytfP_nMk6Xdk8VRlo1A>
    <xmx:BqtiZj4i8KKTNXVq8giSzYazrSGKs9X0jym3hpNh4D5mbO0ZKUjQhqBt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:39:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7fd3764a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:39:00 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 18/27] send-pack: always allocate receive status
Message-ID: <a46708b8984d7c1734c8b2f039f26ac2f9d63139.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HyjlCIcTpbRHQlVG"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--HyjlCIcTpbRHQlVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `receive_status()`, we record the reason why ref updates have been
rejected by the remote via the `remote_status`. But while we allocate
the assigned string when a reason was given, we assign a string constant
when no reason was given.

This has been working fine so far due to two reasons:

  - We don't ever free the refs in git-send-pack(1)'

  - Remotes always give a reason, at least as implemented by Git proper.

Adapt the code to always allocate the receive status string and free the
refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/send-pack.c | 2 ++
 send-pack.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 3df9eaad09..17cae6bbbd 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -336,5 +336,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)
 		/* stable plumbing output; do not modify or localize */
 		fprintf(stderr, "Everything up-to-date\n");
=20
+	free_refs(remote_refs);
+	free_refs(local_refs);
 	return ret;
 }
diff --git a/send-pack.c b/send-pack.c
index 37f59d4f66..88e96d000b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -259,7 +259,7 @@ static int receive_status(struct packet_reader *reader,=
 struct ref *refs)
 			if (p)
 				hint->remote_status =3D xstrdup(p);
 			else
-				hint->remote_status =3D "failed";
+				hint->remote_status =3D xstrdup("failed");
 		} else {
 			hint->status =3D REF_STATUS_OK;
 			hint->remote_status =3D xstrdup_or_null(p);
--=20
2.45.2.436.gcd77e87115.dirty


--HyjlCIcTpbRHQlVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqwEACgkQVbJhu7ck
PpQrHA//RUVpOJ5oHtORT+rIaQh1dAprgWWlEfGzIo6SMhCaEGQD2RM1L7QQonL2
PGnfb6C5p1cgiEJMw0xc9+WgBUI6Idu8e8U+xDmcgKs2A9D7gFQ1Oqr3T5HxVc2w
cOkMSMutiE/1KUUB0uZ3D2rgMHeRvUffmm5UZPpUURI/mTZDEmmHaepmAhuij9vu
Bh66P2sjbqrKwSRObq/8Bkb2m+B43pXfLZWJAzByflKHwMAqTeaSxYcodqodMxfd
J2A3zZNOGk9q1OFlmBpGREuTHO3/ntB1IaehKrTJFJV4FqHB+sZfxnMLXAFI+4F1
PyUToY7O1kbkct/VKrSmkLkLqOTWV25D6i+2zOPcyEg/O/JLdf6xt3yARGbreg8e
/FR0rmrdo0RaKI5tsrOpyYag/RE0PyOkG13Ai3gjmuvr6xBYcwf0vXOv2FjQOuKi
AE1RzGhlI0I9IKl/bzJBorkvd7OKp/H6/qPGEqaiOzVjrXk5If89+BwnIM1AE7yH
iiCxrvHp4ZiudvfC2mGwfYHKlHskscCX9RdwVikSub4GrD5SldYv2u7NxJoQxZ+r
cWMYI7wPgOvw1ekUnDiaI+rU+28JTPROjoSepyp0es2ItIYjmeUa0YB3E4QPQTDO
2l8KodIXxsTVKmfHzXqLBIHdYc5gF6vgn7YKOVcXaWrRuRljmWY=
=YBa/
-----END PGP SIGNATURE-----

--HyjlCIcTpbRHQlVG--
