Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138D7E77B
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407566; cv=none; b=cpV/5kegLtIitZ6DzU4/WPSiheAatGHeCYX0C7vfqA+Ou2jPqTHFMIvkfGhwzLPheOBP8CvanusQHWeR025fXs1nnJ4SlEyNBAgcc7NDho+Fvw931jRnKyxVx3HvmBTL10HVGxOUcuAUI5+OhR8JZKWe4mL0Wxygz71nQk3SunA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407566; c=relaxed/simple;
	bh=YO16aJufTm1qIXBzd91gYtPotVHa5+b1l1fKeLiLRnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiTZBrG+HPZpsGQVusvDVMxvYcfbHAxkTG9AZCOgfBdNbBmF4otcEtiKyMzBht5QOWCUM1aN7c/IheOvRXUwPmtjWyLN5GCgIPrEBefwEBNFemdrEjNoW5MN50lAoW7DBt2HYDEauDgrPtBxYIKi0f0hR+OQMO206XxJTylVkjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d1tX69kf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OdKZOrK5; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d1tX69kf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OdKZOrK5"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 762731C000CF;
	Mon,  3 Jun 2024 05:39:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Jun 2024 05:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407564; x=1717493964; bh=fNhifOCad8
	IMg2BcO3DTh9dns5968pRL5gHMHzNVUok=; b=d1tX69kfpdjTeYjx8fNYoTN9Ha
	M3uoOmRiXriEl+mvzhh+lZ8ev86527HYx+tBEQd9K3YUfCXvWX+xzwqg2tnabdBD
	Nk03FxxkO4nKQZFQDUQY0j4fVHLaqoVvJRyVw0AQBRvJrNDbQNvCP25oysZQ/e21
	lWCDJYTPDmYQmy251+2hhCZ/U8ifVFNfIEqzXkV1s6UOhZkAkgxesdFZyBK0Cpjb
	IJKrJw0xZ91OeJ7l0MW0G1anxBZv+ChptyjU/jDscWnFcc/Yk4aRNu5lcwcctDuK
	v3TJy454B70ebkYZti3jrTuILgHCKV0b1bniS3KJA+Fwgzvb2fhGwU73YnWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407564; x=1717493964; bh=fNhifOCad8IMg2BcO3DTh9dns596
	8pRL5gHMHzNVUok=; b=OdKZOrK5dfE9vNyGfrJ2pCkkvN+ZPd/NFjULXqlbC/1I
	5ahA8txF/1WxJ1AQDYvRO9UwTzq6Ru5qVzOdhULmhda9qGzwGOtilKYun8VzhQ37
	wEDBtF+U6fQMoPABoVWH1g6lvGOkCIt+N0/3pMdT8G34zDUUQW9XxdhTVAG2Yon0
	KQ6BS8Ro7tGBQ9PLAxU56hJ0ZDp5vVMHfRUbMap+/sGk/1zBaowF7Cp8/bl4Nzxz
	yxlgNjk0XMMzvx2rO1hkFxDcshFINy9nVR7yNdF+/d7EAo97yAH19+MfFdMgCiji
	6Q/LMRRk8voCV0wvNSChBnoWiHF4IxY0yT4y/Y+S/g==
X-ME-Sender: <xms:S49dZgZTPrJggCD_IMzqy8vEtivXrkFX32yW9TOvS9r4zTdpYkxUIg>
    <xme:S49dZrbZnujZ2cenO-iN_CUs_4xJFWNiGWo5qNZ-nXyujCX8bX2_tY6mXhxcDgyh7
    6SYBnOx8OFAJ-gO7A>
X-ME-Received: <xmr:S49dZq-OZEKOejZtUksMphG3vXmNUn_F_65h5UUJf5_WZdO-nhquf5ijRd42Xwethu5c8vM55kqnt14mzPggGfARUmtN3BVXsghN1pOz-eHIatSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:S49dZqpmOS2E7C0APSV3HifshtJwpq9_51t8cuCtynkuf7HWlU0w-A>
    <xmx:S49dZro2qSBoH2SA2NRyHXdfanoFdCSgSgYkg_d2FK1H6XlNqqXuUQ>
    <xmx:S49dZoQFli-1s99gN3K9y_iPOzt-ha9LuHW03zKClvPDsNI-88dHOw>
    <xmx:S49dZrqCIgwxxb1Iqw1LuZBSgEdGwJ0UnOlFko4fkpTa7keBGn2Mgw>
    <xmx:TI9dZqUXgP1w4z220E4DtVp0X7DKBqDyAbiirh_gY4QYVijl-6_iHvW8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fce4731e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:38:58 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/27] refspec: remove global tag refspec structure
Message-ID: <db4d0620146fdf7acd59c649d93c0da68289a3d7.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xzMkXiALJmGuhkhd"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--xzMkXiALJmGuhkhd
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
2.45.1.410.g58bac47f8e.dirty


--xzMkXiALJmGuhkhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj0cACgkQVbJhu7ck
PpQ/Kg//f16iafVdT73dowSbZ8RIgt89BjEJ81Pr9knwGINEwITZqf7NwHykGB8t
6HnlykRCwjFRHSaeb29nN9bhWLTSI4WuAmCPAdzB+TGelAzr5RfVKOW0wjr3PFUe
T6D1eLdzwZ5+Apq0IloN7f7dos3Fzn7LBWNqucmmic4xUJpmB79YUUTyj3uJDRD3
w3e7W7v/mgOsNxW0GYsBuh2BT1ZXB+v737R/GNPkPGrp5jhvR/vFBI51URfA0s93
kRHBKPxmTn6o5MAYOkkixwk+WAQ586+m935XFkgTvJdnnDzQWXGoMBvgoUZBFCXY
K292+n41KN/qVg/f/aB0kwQukMcmKWDtDF7pR4RkFKi+fUpktUfF0STrN70dCBcS
KoR401hlcn4hDJpFRON7ipSa3AJuQRS+GhdJCO1M/tn9OZ+iGAMqJ4cRNLPdZt42
Y9uF5fUlU4RYhap6CbwaO2LASw6EURg2/wgOXvs5WFHByiU+ZfikOes7iG+egmQg
GE9slKOz+masowfVU5FSZ0nDYYQU9nYbfqvv9LAIjIA3+dHz+wyLJ+yNH3XYNXzJ
rv+A2jqizBUFx6xkMk9mNNhwjsrQsSDYki4emQmlVuy49vYEFpRerNY5yhtS+X2/
PUQH/ZkJOHjMIgtaM4V4RBjFKnFkXZrj79IOWCrMVjlRWoQQYbI=
=s+mv
-----END PGP SIGNATURE-----

--xzMkXiALJmGuhkhd--
