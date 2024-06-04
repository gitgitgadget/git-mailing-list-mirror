Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83459145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504641; cv=none; b=bFYnBMf88NzFp0Yy1qPMlmcZFjorQYSKOxpYOJAoKp5Yh7wadpD9rbqEAgm5sJX3D0cW3euFxKcP5lYIPwwg8BSJMIFvCfwm7ZQjkhGxNvhfQ2fMLS5accZGh7y2d9mKAtx2qN+EfhxF5fRVehRdjYhnZdzeMNCLvl3uoGxllF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504641; c=relaxed/simple;
	bh=BCmgcxe/imepad8Ht4e2R75FBbduwGGaweZeMaQ5Kgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcUgODkweBIXW/GPXSp9u3bs/by8mJaxpVwpLXSWds1Vef3OytmeRhVXyo00NXBCL/r3WhdTx64D1sL0KMNOzxiIb3+2kI7QhNwZAPnNjuUgJuq1yfsEzF87Gfmfkqotkz4q0XtH/ctPuvqfmjIcCHfnPG36kSOgRFX0JnzJBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jBv7+wPP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ESFFSpgl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jBv7+wPP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ESFFSpgl"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A72FD1380152;
	Tue,  4 Jun 2024 08:37:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 08:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504638; x=1717591038; bh=oyCn8t1nGj
	kgROPxOnXtKwme2ttdm7ivG+IpjVrjchY=; b=jBv7+wPPxhqRTL5xGGX8/rlonQ
	BHlGvKJbUZqKdQ6NxlOpBFPIVJxf+tDACa5cxRvH9gz3lqCqCK0dbN2AvbsOyLuT
	47edPP2Vr4BzPh2FQZaGa+7o2c8zx2W1vwxj4d7K9TDJEOtBKwSgqjjZDw0/Vm9g
	2fjMVAm2w5KyDhWf7Fy+zNPWTw4iBGhO8MbxxKtNNZZaOMrGhHzEuTpdOCl8tVUQ
	bPSnyun7rrvdfn5caY9aHmoU62HGKSCU1uwQevP7fu9QCt+ggYHLCSY+JA74fUcB
	PZ+oXTcj1ePb2WMYuXpZJ/RRMYOzjWwNnrs8EHHXdTel+8qpt2BmJc1UnGyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504638; x=1717591038; bh=oyCn8t1nGjkgROPxOnXtKwme2ttd
	m7ivG+IpjVrjchY=; b=ESFFSpgldTfno559UZK/i5Ortq01knwJNo0kb/TCD/Ts
	u9FUJE7g0D1rvzccduuRDDSqACzhZoZsCMimGrq5Ti4jMlase0/AEc5tvsx9Lc1G
	/c6gyMKtCFL0ognFxED1/5pBgdF7IAXGeoPqlBCep9SF4r38f8DTw4KKtEF/Ew4K
	yHpiCZ2lztFld9Vu0sDYGFw0rIUbsESNfP8Sdk/ZTO+v1JMRLWBbF9ZjupCm4Gg3
	ucv/66Q/y+YboFUk9bTP1Kon3faxRPxFOWzjNByMRK3LK+XiUnmMkzE/bt0UcbLH
	REkMQHUhiiXrVLSOGc/oq05rE2Amh/q2CjMlcfxrgQ==
X-ME-Sender: <xms:fgpfZqshtUuq43xKM0eEDq-wZEZRaFFS-WrKhw1qpNbjmBgMohzSOQ>
    <xme:fgpfZvcT-ZMFAvnLqKdsSdWt2Leqwb5SIqoyDT4VHlXyGND776DIY9vSqNRoAYiX-
    -ts1kwUyQVVp5yLlA>
X-ME-Received: <xmr:fgpfZlzCEVqGpo8DZRR7jP3Zk1EaFgGaIc9fmsev2SfRWSVii7VofPIOyHQvsM26zjxODwAiShECbwcVVn4Hvpur-TVFVnDjrtDJACA-Rcs_IU1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:fgpfZlPV4Yemz3h8bP7RSNtcAeCp1DeHOpc7NOmiKshwF9tjul8GZQ>
    <xmx:fgpfZq8qmJ8dXdp0dIuTH4s1LZ7Y00rDT-AjRZXE3NFoH-vGA9CXvg>
    <xmx:fgpfZtUCXkZST2kGFcSwA5ystC6eBUMYoXeY6PmxSc0rBMY9ecZ-sQ>
    <xmx:fgpfZjckjDFhjc2A-8QxLXer3owb4RRyaYsUM_ctZTscxynEYZjykw>
    <xmx:fgpfZuZicyeE-aSww_QzLnHex3eHybGSy_1693dtyYJBmZ81i0cn_VEq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f334442c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:36:50 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 05/27] refspec: remove global tag refspec structure
Message-ID: <ead27d3d978701966cdc2884dab2db77fae5d031.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2MCqc/RQ33AOp5be"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--2MCqc/RQ33AOp5be
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
2.45.1.410.g58bac47f8e.dirty


--2MCqc/RQ33AOp5be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCnkACgkQVbJhu7ck
PpTUVg//T3R3VXEtHqURtWmUyeuQCYPhKU+Rz9vnylZ/Dg4R1ogrdVqaxY/kyxO3
xJVOdan59kiOzrC+dNq8Nr50syVpSmsl2dnrIW6okEhvn7INUO1Ut4h47P6FMvjZ
tGKL0TiEbFhjKqXfNHcECUPnB0C68OWysGLXu9J1grx7DAs6EfkdSz55ZhcOtSLl
V350GrDBg1jF5Dvuacns6+oMAv1gxMxw1iX89n64FjnHz5bTyjGg3EMYzROIBnb3
yA9J0nITgMt48wg4UgyNVxZiTLFrK3W87vupwsiESNaCgJMvJWbO+gVOgs5J5NOP
cImXWAL+HQVEDunH/1A9r/U+smSWHQ5XtqG1dBXCjcZC7NGSZxyAwpx7sEa85q/r
pSrXug4VMdhSO7lls86LxTIsSLTAFP43pFCrW8Wh7oeOYKXdJfgSTLyZND86YZjv
uLM7h7Jm3RjV2CfRPpZo87CtzfMbXdRlXbim5LzrNJq+jpWfM+PVyWzoZib+IxXF
ZtX4jXJDdZK2wIuhg0KOLe/fyl5jP587cCJm4q0+ltQrbeI/lF2qF1fdBvFEyyx4
r+12ROUqUPTue4FGpNteWjb3Ah0x9T8HrbsG3t3uHsKmPT8laXQTX/C7Mhszgx8x
fYjQLaH4PjFgwxTytuVdKbKQcEed7/bZ170hVYNuEnq8dobhgec=
=aChB
-----END PGP SIGNATURE-----

--2MCqc/RQ33AOp5be--
