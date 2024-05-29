Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF366142E68
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986676; cv=none; b=MAX/IPyeiay4P0Bxa+z7yKUz/Hk4ZYEu48QJA2h9Jtl3yaqCKPKA13Sa+/Quw+7ajPQGy67Pihvtio1iQoKoA2xLxKHaY7wwAEsE9cQo2FCyNAODoj3fjGHHAye+BOGOAuxfcI32N72JeGYIUjnjhuDhxTQvc/ASpUWbQb/CEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986676; c=relaxed/simple;
	bh=YmVWCIFaSLTAvV/QiWxj8sJGnfJct3b5OGqw+BXQoY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLvQ7RmTmpLHPqglK+QqT8N+IfkhJW5zx/llCNt5hk/3uPykfM+dk/oDJl8siolyDhlrfvYCZoHdLi+xhU7qMCamSkp0FvDNV/iQzNtQcxS1GAo3cJLIfo1PLxOhk0NnDhIK4RThFqwBlhXWja2RaAhHd8bPkg/hxulOyVseZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iyuRUt2U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qcQlii1E; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iyuRUt2U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qcQlii1E"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 20D7D1C0012A;
	Wed, 29 May 2024 08:44:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 May 2024 08:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986673; x=1717073073; bh=nF00AtPZei
	D2DwHxgHD/ylPYerJzbwTT5k8ZRwiAnlQ=; b=iyuRUt2Ud1XiE4KKHfzvUqns3V
	SxuFJ58LUQKY2MEhYjMVkhnFsdFLXKbhIvUH63KsfOy6R+GVUsrUCvnJgXUUYbPd
	4vDfeGgX9Q6mBi/tMftmmZ2LGVe8qRQMbrojdDSxCrS8G54oqBKxxS0g5t4Vw1nN
	nkTj4h3XBqPdvUA6AEOb4nhdsJ8YxHWO+gRJLrIB7PiJt1DMFABkPBCEQ327Q1gf
	fx9g3EZFAMniLSWELgrOTwWKoOGEw4YS7pQcRM4vPqJTsDeehBO1cTTTktNLRQKJ
	DYB+eSxQ2FyGqt6MuXD4PUf2nUZuI22G5gUkyXaPC3v3JazPnuE/w7IKIBGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986673; x=1717073073; bh=nF00AtPZeiD2DwHxgHD/ylPYerJz
	bwTT5k8ZRwiAnlQ=; b=qcQlii1EUoG+kGyHcibBSfFRYCz1QaY3mhCiL5fnPEtQ
	L2RaYL2FFRbkQjepjzDfONeOrYX3Fm1YnIIMmLDnw+ap6CEQZC0zHm/MrBQGZFh2
	uVBGWFF0enGpaM3RrAd5m7U3OFaR7qkRGEq+OeBZertd/KM7MZMQHV6JtpuCI/Qc
	f+yHfF6rasEEca1vcdJGiQoz1zfvOyiurXwUNrJ45Y5caSs4q2mWQV4sPTcwZ/92
	lfi7LNRp3xrWlHouAupqykBBj1f3XWeMkDxXXaBIDyxaQ2dzCERNYYNhGWtxvcaE
	RAZndCBJKWmA5ZCflKwnJlcB3k+uinWNeOLo8RcXdg==
X-ME-Sender: <xms:MSNXZlBjSO61QyPwbWSkEcCRJ2NpsEziDnosVln_yc9y3SC22XkDHQ>
    <xme:MSNXZjhFwrM6rX2IZ38eBXfdfymAsfcnSvGTpBHgJj97E3uJM9Mj_Frc80aPLqa1c
    UK_lZT8MwM7ar-rmg>
X-ME-Received: <xmr:MSNXZgkh6Go0TJE6ORl0rFdMPoht-kMkxaW9yRixmF5jQGOCqAfRrdBnpGZI8vr1pDm_kDCOVez0ppnL3YQbNBDLtyhbdwnX8JWO-Esc4U6TB7t2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MSNXZvySs5l2jwYlVCZYWsP9PwTIcnFQ_34zyI60OWFbxedmWeDztw>
    <xmx:MSNXZqTBFwyjFEGB3debZZ2WGDuwsRFylY1ttj2u5zxA0dUhfKMltw>
    <xmx:MSNXZiZnLbpm_b-Fm6JVdpWERcv1x-nRePcW5efSpRDSc8ByqyBERQ>
    <xmx:MSNXZrSgpo3VJ4fJ_T6yps1pumueKHsBfIMmhPw4nV-hGBvl9HiliA>
    <xmx:MSNXZlff0-Vow3rnYt4gVh_86f6TXKJ0hnk2CsVb9cT85e04Jhtp9aO1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9f47b0a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:18 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 06/19] refspec: remove global tag refspec structure
Message-ID: <0eaa73c109198b332e348921bc0a0dc49c687f98.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w1kRwsUY+qfp2Yh5"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--w1kRwsUY+qfp2Yh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have a global tag refspec structure that is used by both git-clone(1)
and git-fetch(1). Initialization fo the structure will break once we
enable `-Wwrite-strings`, even though the breakage is harmless. While we
could just add casts, the structure isn't really required in the first
place as we can simply initialize the structures at the respective
callsites.

Refactor the code accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c |  8 ++++++--
 builtin/fetch.c | 11 ++++++++---
 refspec.c       | 13 -------------
 refspec.h       |  1 -
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 92ab7d7165..bde1d284a2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -523,6 +523,9 @@ static struct ref *wanted_peer_refs(const struct ref *r=
efs,
 	struct ref *head =3D copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs =3D head;
 	struct ref **tail =3D head ? &head->next : &local_refs;
+	struct refspec_item tag_refspec;
+
+	refspec_item_init(&tag_refspec, TAG_REFSPEC, 0);
=20
 	if (option_single_branch) {
 		struct ref *remote_head =3D NULL;
@@ -545,7 +548,7 @@ static struct ref *wanted_peer_refs(const struct ref *r=
efs,
 					      &tail, 0);
=20
 			/* if --branch=3Dtag, pull the requested tag explicitly */
-			get_fetch_map(remote_head, tag_refspec, &tail, 0);
+			get_fetch_map(remote_head, &tag_refspec, &tail, 0);
 		}
 		free_refs(remote_head);
 	} else {
@@ -555,8 +558,9 @@ static struct ref *wanted_peer_refs(const struct ref *r=
efs,
 	}
=20
 	if (!option_mirror && !option_single_branch && !option_no_tags)
-		get_fetch_map(refs, tag_refspec, &tail, 0);
+		get_fetch_map(refs, &tag_refspec, &tail, 0);
=20
+	refspec_item_clear(&tag_refspec);
 	return local_refs;
 }
=20
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 75255dc600..06b60867f5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -582,11 +582,16 @@ static struct ref *get_ref_map(struct remote *remote,
 		}
 	}
=20
-	if (tags =3D=3D TAGS_SET)
+	if (tags =3D=3D TAGS_SET) {
+		struct refspec_item tag_refspec;
+
 		/* also fetch all tags */
-		get_fetch_map(remote_refs, tag_refspec, &tail, 0);
-	else if (tags =3D=3D TAGS_DEFAULT && *autotags)
+		refspec_item_init(&tag_refspec, TAG_REFSPEC, 0);
+		get_fetch_map(remote_refs, &tag_refspec, &tail, 0);
+		refspec_item_clear(&tag_refspec);
+	} else if (tags =3D=3D TAGS_DEFAULT && *autotags) {
 		find_non_local_tags(remote_refs, NULL, &ref_map, &tail);
+	}
=20
 	/* Now append any refs to be updated opportunistically: */
 	*tail =3D orefs;
diff --git a/refspec.c b/refspec.c
index d60932f4de..1df5de6c2f 100644
--- a/refspec.c
+++ b/refspec.c
@@ -7,19 +7,6 @@
 #include "refspec.h"
 #include "strbuf.h"
=20
-static struct refspec_item s_tag_refspec =3D {
-	.force =3D 0,
-	.pattern =3D 1,
-	.matching =3D 0,
-	.exact_sha1 =3D 0,
-	.negative =3D 0,
-	.src =3D "refs/tags/*",
-	.dst =3D "refs/tags/*",
-};
-
-/* See TAG_REFSPEC for the string version */
-const struct refspec_item *tag_refspec =3D &s_tag_refspec;
-
 /*
  * Parses the provided refspec 'refspec' and populates the refspec_item 'i=
tem'.
  * Returns 1 if successful and 0 if the refspec is invalid.
diff --git a/refspec.h b/refspec.h
index 8c0c446993..754be45cee 100644
--- a/refspec.h
+++ b/refspec.h
@@ -2,7 +2,6 @@
 #define REFSPEC_H
=20
 #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
-extern const struct refspec_item *tag_refspec;
=20
 /**
  * A struct refspec_item holds the parsed interpretation of a refspec.  If=
 it
--=20
2.45.1.313.g3a57aa566a.dirty


--w1kRwsUY+qfp2Yh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXIy0ACgkQVbJhu7ck
PpQKkBAAp0PZGXaS/rsGhYIuuWVaMdGGIzTYA/vjX+AFBe+AwUfXIweRtWgiYunk
TBOmxSgBKOysW2/Qga9CruMthnRducSBcXBVNzdi70Em/WhfUsnddwgCfZRo17u7
s/26K+29NNxfn5hjCp8wHZ0ZloC2/Ct4EfmAKdfhCUXEsjiTv4WABgBX6nfXuIMl
A5xwAneFAeVwethpi7WCeB1FQf+miyf8P1Kc9CvRcy/bvkXcrVPy2G8t91n1amTx
MCNGx1nhtZGYmBT+0eFoHpVD92yttJfCTjKZGxIGYXWIBaVUndOWhvgv69dU2eKP
v+ndExVc8I4sdiP0mtEnIer4gr4RY1cCWXSj+OM2Lxm+m1RTOOkum1bzLrIlEQuV
SND2ou4pkkmd8o8ffH/tawsH+WmeHs0oOhXUOpWYRihLI/njIIDhmcw45XWYI8OH
WFm0U15DmeaOjpiKahK+hXVA7OzUZe3HWxmtHxdwDE/syjmQ4+WHsIstiiSfYyVH
a8cNZcUuLuPPQoBHK+XhetEjiCYY7xHNVtDV0CoFyoPAMk+h8oMzXCfe7WIWL0jQ
8UhUdp8YIW03deAkXkr/TaTd9s3JKOfah9M7pipv2/btK7bmA+bo8k1kX1gQcA/m
8e4O71psnBT/2eOn857/Ow+fYR070M+oAdgwS5eCMy4TXwnymAY=
=BwRc
-----END PGP SIGNATURE-----

--w1kRwsUY+qfp2Yh5--
