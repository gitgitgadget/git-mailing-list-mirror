Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE44194C63
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669695; cv=none; b=T1USI/ntccCKPOT0TnTy6FA9Ac5CH0Niatm+a5RLMv3t5I2vuzFoOZ6eYlENXcfuUe78cNzzMka6iPTnI2FDVImnbirKU/lu2iezRKPhiCAww9Sqp7u/xM/FUIunxdcauTcCqCEGW2Gc8xC8tOuToz9YENormmYTJjAFkwsFoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669695; c=relaxed/simple;
	bh=PkoBPcR5ZtuOZ9/Wic/Y4nVLgabVMLLcP+nNYEMN5p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az8qlKUgj5MClZ0L72GiwPyNeZl/8brxoUxVqTt2ZIzZ22mNyFN94okITMNdbfBkMVW+dNDkwL9ZxpfTJFg51JGSlarNzBzu/QLgK5k0fYgSvOdeGoePCv8nPHaZGZux5MRuKjJ60L/aAEsc9H7oDO6CDkC9dHg3Q4zNMiplT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JiGLO7tf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hG2M9+du; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JiGLO7tf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hG2M9+du"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F09871140138;
	Thu,  6 Jun 2024 06:28:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 06:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669692; x=1717756092; bh=UUr1YGBuId
	fItbfQPIxQwI8i76LnWQyoOLntFgbDR9U=; b=JiGLO7tfBaxtbBH6ICTZ6a4Hif
	EKlgeISCV0rHk7IjH57sl99cRALW1B9Zd8KG593aVowUmaGvs1PuVZxSrKWSdSkK
	qKLEWHbgcbTRU7fSLBk6Dpd406dt6CKBZBcfdW+w2L5DgURLGbANOxBnfXe6/4Pd
	HzDdLHkjTOWOVKMbFjB+CwbXrZwOcnN1qVIJZsCHegTST5RiHFqSyromlnsJpALy
	oz2nwYj0JIRRlqwS9341nqwxb9Dq9pUQ0xqF5E+rju6Vh2o3AKBxHViyjf9FQZbg
	U9CUJSACrsJWIo2F6aq4xQd/qCqQ7eTk15F5oKAh851aloKBgeRek87zhZdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669692; x=1717756092; bh=UUr1YGBuIdfItbfQPIxQwI8i76Ln
	WQyoOLntFgbDR9U=; b=hG2M9+duN4Nh1EnOrx7hvJ2hw7/6Voir+r/E08Myj2Mf
	CGnxT6NQvP4ikPwqcf8Xk6zcCQynbamzwXYDRhXDkHqa4HdhhHWZH+F/fEEUPj4X
	Zd5GLJw3hi/ECsnCd8JxLTmP5oDIYPj/hIaoKXpoKHH5dlUfaEDNRjN5Mygs45xW
	IaiHS9YIBGL+Q2aLJoNACSYCNLZUV8tfZ7Vw2NEPTnSLr8nx98KbWXkUat9iqT66
	2Gkc6dnjEX4mwxXTSZRi98vWbnHsah3vMv/NCYQ+XoQam3y/OWGb7RopCM9L2yG+
	qfmOgrA17HNfhcJd8oL2CykzrDSEELu+u1pCApi5iw==
X-ME-Sender: <xms:PI9hZl5hHRPS5cC4gWL8j6E5rUX1nSD-BuJBkWO3ejs7lrtCORO_tg>
    <xme:PI9hZi4FmxfjNI-ocDzU8cg1oVN2fih2d8JsfKK6tOaXT6Dg_CEggo92hCancbShG
    ueuUje4j3zWf-l1Jw>
X-ME-Received: <xmr:PI9hZsfgcPXbn7WxHreGkUhDlo4RJhC9FWS2LTDLGkV0v3wda6ZycKPPr57UId-l3cpcAxoZYX2n6Ss83pMZmac6k4AVVMiQSW5nLTR2VCjX2xrc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PI9hZuLqWfmQ6FOMUg1cBglHLGqgm86DIGPLdPx4ZYUCCjtBoIQKaA>
    <xmx:PI9hZpLS67SaYDgilLWhSOhnzs8Oelg8Kq-GDG6Wz32Of2W0vPqFdw>
    <xmx:PI9hZnxwFiP58BThbSzCHQiq-NReNend-rX-tyLJbkHug9TCUZ9GdQ>
    <xmx:PI9hZlLeisaGweVw6bJxAAAJ07yeHcnXA12f-d-Ow5dDn9O6l-0UuA>
    <xmx:PI9hZmElxzworCwk3ZdMVCFv1g1h-YjjN7CIM1va46XCdx1IwlDtgDN1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 259eedf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:27:40 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 05/27] refspec: remove global tag refspec structure
Message-ID: <ead27d3d978701966cdc2884dab2db77fae5d031.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Skavd7TaSx1fcXAj"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--Skavd7TaSx1fcXAj
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
2.45.2.409.g7b0defb391.dirty


--Skavd7TaSx1fcXAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhjzgACgkQVbJhu7ck
PpTupQ//bZ0TgKs0eU2V0NygAlKTOpm5Da/vZYOzPq/5DBn1y8xH+JhSUE3LgG9W
cnE/w6TlNmzsh0HVY7zgPv9Az+5hI8utgUa+sk6JjLS3/7ujVXd1eLfr265qoXS3
ilJ8nrACthyzPJ6Csh5wSUOpbJdZhIQ6B7qD4OJRznqoBROxwj1vq2NAW1NuqPv9
Z+/pIGi5ezxc5sTTbZYJL6KLMa6rekyAr/5kOiSCUSYCrui0TZHBb2Wj1Q/4xn+y
Rwlz2PAoVcusO7vrSkrFj+aXphXZV8LbgnMx39YBGoqZqgVSNalbec7HCZJnS0RU
Sm86RxcGKgS3A4j+qcDkG8RZ/HtN4Z5XUzGJ23cbZGL259n42rBXqrnlDfxYq2k1
GijvVr1lNrd/+pK4p8JVhBV14uSNZQ2G2lA1ilNnDWu9vUzr6QDLEdnvt7oFijYu
g/6OJzh+VIqlqRfjGz1xc8RHdowtY0BBy2ZFG6vOQUn7//rL6ARf5hBjNZKBZP1k
JrBmOY3dvWzylcEcdRRb49SrhUr51+niKiQAHX0UgUUE5zqfPKHireQiyPRs04PO
waOKlldHeuJFoLFznNQVJlWZZXBonYYsG8cZMBlpks341Z04l0MUJOvBVWLzZfBu
cdDXaIQhvtYaBuhUMNY6myjPTvcN0eAeR/md6yu3gy8Axmstgy4=
=HZyz
-----END PGP SIGNATURE-----

--Skavd7TaSx1fcXAj--
