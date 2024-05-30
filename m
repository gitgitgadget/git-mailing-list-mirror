Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2301132121
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073460; cv=none; b=TvIlVAHOu4x55I4ciY6OmQX4qFNd4/p2RhJvQHIOoHfN9Yp9xlaTqs+XeZ+pLtmpfpPj9xwhgOEl3uYqKdaMzJYSguwAmgKAZvJysNv53zu5h7spumbViddvRF7P8B2fwzfSk3VgbaLb2gf7w8OiYUOUOB4NyDyluow5njisFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073460; c=relaxed/simple;
	bh=eoFozxUJxm9iWK4neLfVnLSRSDwko06rzNTlvBKWHtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiWQoE5KBfePxRRgxwbpYK7/hznJq1pcPiLiDIXv3+XQteAvj/hTnoiixFxjb1DaKzVVISjGtuFtfX5ODyGQzCLMak2XNDzqCvKy40O+WFXEmS8PYBvEfPQ+NeGQlNiw0ZgeGiobIARTZyM2FM9cCNgCz7Y7f4CyIBBcP52zJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nwOlBTAP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VjvbytQA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nwOlBTAP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VjvbytQA"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 142431140150;
	Thu, 30 May 2024 08:50:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 30 May 2024 08:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073458; x=1717159858; bh=xezap3fEGR
	wg+779ydhRA2QIl2b+83PMCgILA9RlKaY=; b=nwOlBTAP70K6uG4w/rgZnC24Vc
	dJa9c29PGaBs6CujIYV9mrLF3FXlCGvCF68DzDCe42EXMXETMkGmGZVya4cIywff
	mmBOiNIGx8/WCsftoJQ8rVTT+9LxOYXNfmcIaTJCmW7uzkG+FTILMDmuizZboiJw
	Lj2MgTFSM1SUm82bwz6Tu5qyaqNaR9wT6ry6so2HdAFpC+ksg11mu6i0zNAlgG4C
	vPuKX8X0uNnFloe/QsOkncF+QcIvgPFQfJ1SjF+B2+ax5Qm5kaSFhyONIExiCJxY
	lzxt4rmRsCA3ARlQAQT8ohkBmY9zg41/fJcyypqFe5M84ax0JYZDB5n8TERA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073458; x=1717159858; bh=xezap3fEGRwg+779ydhRA2QIl2b+
	83PMCgILA9RlKaY=; b=VjvbytQAk/9drQhiwyekGEWpib9TFgHk524yswZhiyps
	dWlY6A1HYnpRZcvJ87G6ARLdAAa7kAwRhNRG2nAowi5uHW39Iiy5aIcwciCqNQOE
	nGgIN/8bm9YDQHpX7SMaQhZmLmXzpbEN+WVDbgtl3kSdHgiVR+ntBiomyUZXFieu
	UA7Z5vyHpz/7WR4DdgKC82d7Tvt4JwPoZhZ+EKeNWk6Z1VTalKnbssU7/kBJ9VB4
	Swg934Q14gpYNqqU6fAHoonBKml9Al+R+vOEcODb+Bl10BCgTB7mHqeXKNCe3q2O
	YGXTwE4WI4MdGZ2+s5PYuBcWx3OtuDfHZdz5wrWDRg==
X-ME-Sender: <xms:MXZYZnCSsWej1OiAkOc2LCWpt1LHRDxAxQVj4A3PF-WHB7VJYmW1hA>
    <xme:MXZYZtgVYhc9jsx1cEN9GNP-jYjE1z8vEYsJ_uZYua5-UkrEULYfrmojlpm1NFL9S
    3mYzyrX8umkcTpgWw>
X-ME-Received: <xmr:MXZYZim14342T14CmQb2pQMRutU8DHH6hIl65byUr4h1BQeGOQ-UvFl4mtz1UHs7EIP45BLAfFNWjSvJMs2K4PPbzuO4jAUGQViokgmpehXmlPeV9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MXZYZpxkZnBgZwWjbVD7X2yBzd7CLy2THyCTqkJ-AKbdzYovc3qFUw>
    <xmx:MXZYZsTCEB6BmbHArppa1BFJB30J66UDgSkf0GDy25HFjg4OVAyulQ>
    <xmx:MXZYZsahteENBZc_8oUzGvgvoqeanGZrs5aN8alhjSgZGbnxwo8bug>
    <xmx:MXZYZtRW05JCCCpS-6xFMU4JwlPveUcaVfVe1_BH290T2Uz-xs4qLw>
    <xmx:MnZYZic6KimpV3WWPWLfD5tBaRpvsd8GGrHsg6O_lYKsCVv69h-H3yV5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:50:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2ba817d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:50:40 +0000 (UTC)
Date: Thu, 30 May 2024 14:50:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/19] refspec: remove global tag refspec structure
Message-ID: <b73a45133b3984a810c6c5e46924e3eb517d0fb4.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pY1i1c5QVYT7//b2"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--pY1i1c5QVYT7//b2
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


--pY1i1c5QVYT7//b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdi0ACgkQVbJhu7ck
PpRRHg/8D6TDo0mNt3/NvT6dkwo6teEXkRt9yF9475xF9Fy/2kp7I5C4IajdGipH
6+JhlSBDZowT+wnSpj3JvFdB5aKGTaAKr3TCGqnZ1N/5iSI/WciK9IpvvsXSX4EH
Wygu8+Ws0UiHCrjXyVpHkW4xQiUvAUeU2ioWWWpanwvH/ACTf1YXBI062GFLzxLY
zkEIK2y5Do4eS8LtOklBORDXGFiqbw6wT/hTvuAMhjjxU9WpAq6bX0KqFpDr6RmB
IrnFd1ev94slDMC6roCT/vr/lAPWPI/gf+dkFdSoUy0mv6/kqmruKc3myeVvV2w0
FDpVDToYzSOZoX5aEY7NTfkXBTftxtCdrG3vB7Rbt0x3mU4n4k970JeJlyI4p3rf
cSbZf4JRh239f2v1Z3pUjli2BNAqdUel6eSprupkdub1cf1wGJ8Ad5q+se9eEHOb
90aVRriDgIW4IqOl6MbUhAlzMU0CDQ3Bsm+SAFaotEs9fzF3uuv9irxYINljmxo1
p+2sYaH/R6QCr02YUfqBtLAg6aYaHwzFf0gn/Xst+lhUqwANBYU2mzp0UyKaH8VE
wTRgKaGiWz09X4HNoF3lctIfYZNf08WCANzfVsKFMjqUZNRLdNHBO4WFlYQMNwL5
ATKqhUkp6aQjbuG9f4B7PEnST2B0f7zTraU8XwndGAKNUPAPCWM=
=kgeM
-----END PGP SIGNATURE-----

--pY1i1c5QVYT7//b2--
