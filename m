Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01A15278F
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742283; cv=none; b=jDoO4CR4Vq3Sg9W2m78aIeLp61qcv1ugAvbeZgkaQyZE4A0G9IZDbV0WRLHBhDGXRuWb9tpU59DxZSVuhG63vQThk/Mx8Ifa/KJx8TIkDulT/gGwZVNggFI5PWY5Jxpr3Cxj6htp0bj8QpzBTIsxfD/K6Gs77Lj5l27UqNmr5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742283; c=relaxed/simple;
	bh=dVIC+3I92EgIUm/70ccNQnlxfoRlYOooUTbzRk9wceQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMMzn5FtaYBk2y3pXr2g2uE10Fu3Ij3l49RnJZ3MgpWccxO7RcgH9W+8Ves+40u+f939gxhPVm0w4tanBmFb312xoCr8nQRXIFJbX3DJcO9vEVy/jGuOrQsfNXRQyZ2HTnEW1O9hnQK1OD7o4X/PgM8br8ctG7BNnn9NOXCDpOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fCMi0UE3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ucmyn7Ul; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fCMi0UE3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ucmyn7Ul"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id E655013801DD;
	Fri,  7 Jun 2024 02:38:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 07 Jun 2024 02:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742280; x=1717828680; bh=fYEnNAHBf1
	M3kUIoHnmxt6Q0sHmtEsBd/fAfPU6U3P8=; b=fCMi0UE3PwOHo1/stt4UUOGRui
	yAT7sUKNqXRRGMw+wVdpxd5gigS2eby+TgPjZnrUwVBV4eDYZuw8yhtfmFLjZZie
	jh/Eh7QJSj2h7tkpSgrMe2fraj8rfHscY6ioRPCGSfkshxl03Cggyko8jxGAG2aB
	KuffFknaDxgL7GEiRoHJAbdwuQiLPH4XpERRmXyh3XaXRwYpET7hD6Q3ecF3jOY0
	JpqH3hQ24hZcWgppU3FaRpN1bgg52avzrGn0XHLa1dmdO/apmtn8WUSo1rDB5NPh
	xqMow/bIn2kZTcAwQwUxm2WMRkPtM5Hd0glNVHq3Wld17yXOhXEBS/ShkHug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742280; x=1717828680; bh=fYEnNAHBf1M3kUIoHnmxt6Q0sHmt
	EsBd/fAfPU6U3P8=; b=Ucmyn7UltUz6e3G7zsGdSyontv4a5TxJuxnkLEcoTTyN
	VyT0UqkI28Y7sZAKkKarz6XVIx24usI3DahmoL6BpC11FTUN+6MmjiHFweDt4jrQ
	xyb5D6Jq54gtsys4gREFJhgabdW3vl+lYyjJmVq6eeBX12ToWJV2KyqQ+M63IyJe
	wdKmYMRHl37pz5tfdGVRAnM4f8a8RMqQ6HaQAhVCpjxzd2JyiTGSBtFUj3J2B64l
	Ak503leGtp8Xc2ENu7/oDPuw6H/miGotD6cS08mKbeASoxF+sXpMi4c9Pwe3YVWN
	q2epg1pvKDzHZ0Ez4LlOug09kfVw0g1KW3PQSWLCUw==
X-ME-Sender: <xms:yKpiZh573wWhUEi4ohtLhmyAEltW-xn0lpEWv00E7lg1njl5Oq2idg>
    <xme:yKpiZu57YhRVQELFhwbqj9JBaV07bRfc5qBpJA9RyJ8nWaL1H0THw7LZDVsmcFYVK
    H7qXDi3w6pOmxGIEw>
X-ME-Received: <xmr:yKpiZofwDsQS_JSzdnov73syHwS2YzfevRkRUdKMh1F0kAP2CnXKMDUrL6kB7PvGjoQCPCiY10uzTGjgReNxd4J-B38Ui7k95DH5W5xfPq9C8-eT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:yKpiZqIfzfnCDPjFrQJumfwNeDY8GJRdJ8tH5C8rEoCSE9KS_7s6BA>
    <xmx:yKpiZlLIXYi9lWIWkIc02tct5VB-mhJIYf348gcExN8JbNRaHj5nNQ>
    <xmx:yKpiZjyTZppZN-uL_Zy2uXmqoCfwKhQtTHATWI4oKafhfpT_2VY8jg>
    <xmx:yKpiZhIq4hsrINDVIH-eYLVXnfXaXKiLDC6jUI9I_06NAI8Em4B1YA>
    <xmx:yKpiZiEp1Kfi3L_pkO5kJAfzXqDBpMLtBMXQjEGyPXfVM-cWLstobTmd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:37:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e3d6f734 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:37:59 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:37:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 05/27] refspec: remove global tag refspec structure
Message-ID: <d10566e0a94c3580ab57bc228a0b6ca0371b3a12.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NEPqGDQlAuIHhaXD"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--NEPqGDQlAuIHhaXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have a global tag refspec structure that is used by both git-clone(1)
and git-fetch(1). Initialization of the structure will break once we
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
2.45.2.436.gcd77e87115.dirty


--NEPqGDQlAuIHhaXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqsQACgkQVbJhu7ck
PpRnlg//T+XeYJCd/twFkFE7fa1WEqwsi54xqZ0KOavAgMakFLSjlEJZkdEugCv1
NIGChJAq7UyhHZqK4WfjiB5H62T1HA3th0wt7MV13eTiWkkJvY3f6v0fJbSAsG0f
lw1YUXcxz9Nd/vFi0nEGavcloHVChDon5eFzJEU+Cy7KLttHwbF6NORvP7Iac4nJ
phlS+o0YSRaPKvDW1Z9A8qKY1kQGJUyEnDcfUXLBDTcFpk0FbFVJ9cb+TzF2hgS9
y+44bB0mPeIFMyTmHCH23AX9JO4wDz2FFIUb9sDn1Ye5D9jj3kyo55R1IhqoELK7
ms+vts553V4ZB5frHIy8M+IvaXKablnHiPO5/VuLYcYnK8jsAJo11my6PvAsxscF
VwxvRbrvKIGBMsZ/D55aadjSe6+vIATqSat5CIPkRuiBATxDKQKYNyCEyCQdD2of
chuTLzTi9drRm3rknpyNAaKYP94kW4+6P6jzfBTQnbQpnBnCjGF3HH/IT0S/Vycs
6eE1w/nENP1Qb43IDnKFmDM8xU6Gj54V3QdXTYtUFA7QFZZ0JYNmn8h06vA7TUGD
DoHqjY0Vp4rjwtpt8N4ZP7hiexnokmOy8bUW9A725Jn97m6LJcA3XTRWf1hC6voH
JbR72zQqq4WgHyxEXoGr2gh91g7LLY6ugYtwSJZtR2BL6dvfTGk=
=3i8/
-----END PGP SIGNATURE-----

--NEPqGDQlAuIHhaXD--
