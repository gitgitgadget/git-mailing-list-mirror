Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33838446DB
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110165; cv=none; b=FZicla4gKSdYrN/oANAOfpO8bJrlHzxOJNmhKcb8FTlWBJ/dbNObF01Sc2TtQs8GIOWvDYi9gOsG5tYjPAh5etYNlVSYEtrEEU/pBDlWhTpp81PWhopONZ+xzO7DLxoJS5PXS1Xe7f80vRNh5ACFs85YkQJoyZuE41DNWDcyRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110165; c=relaxed/simple;
	bh=3aHD4qJdJg8ITYYJJJsvxNOrP2fUOB1b73JOMJbEDRo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuuPZeDq0yRnlYWVHwN6feDkIFMXmDlAgCHr5k4rgkY1hgWAjO8o9Grk9rxIsyqeakX9sPNBvOR/BQv4wbafJSscF3OlkKzXqlZNICN1jzqfUV9Yvm8uNiVyZm5o6P7vE725DqCX2PHmU5+Y7XP9OCAgfBXG3gj/OyHw3NxnxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bAKtWuIm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wSpB1eZi; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bAKtWuIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wSpB1eZi"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4F31C13800F7
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 22 Mar 2024 08:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711110162; x=1711196562; bh=42Pbfgda5c
	kYq5TiurrBvSIz/V+eiMQewuGOQn4u+JU=; b=bAKtWuImtGMW/3+s3nm3PBe+Mk
	QzaF1dOwiWWowA2KRkA7u1skwlpk9xX9a7dtVyYgoAMjG17ppTQFZnDVjsMKgC0K
	Yg4gdUo4MyyR2ScTl4rgdD5KhVjscR7ibpMGS6vxjrEHBw70feLBTo96bs6CB5Ct
	L4J8bok9ThrqD+wyY9vLluTAYsh01HxhTbvemdaEeTp3ArBo2VLeCOeGb8HjlbhC
	b+b1/GftmEx3EaBZBWqnsXNBdP510HA6x9ia+sPvLdcr5SpVn30JG5YCGhGOX6Er
	SMqjztjPgMTWnmvIheYn13IxOBT8CvRCBEbN4O9Sa/QN9Uycu2RAb1G/oS2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711110162; x=1711196562; bh=42Pbfgda5ckYq5TiurrBvSIz/V+e
	iMQewuGOQn4u+JU=; b=wSpB1eZin2eNF+xs7myDHJJfaelGjEwEFr13vLBfy3tV
	b4d5PiZYnLkVU5duVk97is+WQzl8EjE3Hfbhz5zNRsPwT+8IAgSBBBglZpU4it2F
	an8S9hp8F1Q4FjL03I/+BXCgAMILJThFJ5bcAJtDYXmBkMx6YxjHBjxFRQOCFq2V
	2iXtjFjG6t3jnXaGuupKDfdHpqrJeaa18t1HLWIg9aJr52iiUUJyKZqTjvZKYbOo
	QEs9r3TwfBQPC4LXj42P1O1elJD4AvkzQgNQpbCnbr5+fxI0S2jFS5bYjJDZquzR
	FWJbNuEF7bg48g4mc/3uk7sWVHr5Jn8HKmbXKGcJbw==
X-ME-Sender: <xms:Enj9ZT2s_OifcAOR60226YQvFzbYVkg-Fukz3IlEFUnnx65L8mrBQQ>
    <xme:Enj9ZSFAhix7DiX2FiYKsNPCSurTXkpWJK-EYQN-yg19zaAF2sYMR5lAI5XCZ947-
    Cfz91lTFBp2wceOng>
X-ME-Received: <xmr:Enj9ZT5Mk0b50kuABBaYlkTv9VvQhmlM7AUloJidBlNUl6wxy4EJH9G4iXU-d36wQRWCV7N69RnmrhRt2nMWgJGrPlhDyG9SA8TfNICIiQzH8k5AAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Enj9ZY2WQrVgi4Fp95SpOiR8W9DKF-lcNcJtp7COYl3LSkf17_8aPw>
    <xmx:Enj9ZWGM3EzMscpl2pONHKtBVNdfPKHqGIxg6zjtFciQ2t6JXoEEmg>
    <xmx:Enj9ZZ-HWejFRWPLLc8VE6fExmrjFewOCQVro6I4DnouQKbXZIBNxQ>
    <xmx:Enj9ZTkqKbkA8z2TP9HHE3Yd0mjNITG2Z5SE5g-_SfM29Mrr2c0pcw>
    <xmx:Enj9ZbRkbinkgzS7Gn3vXHJ0qO8pDeNWXLRr-geRZQu3OxrVnM_G1w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8fc589e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 22 Mar 2024 12:22:35 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:22:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/7] reftable/refname: refactor binary search over refnames
Message-ID: <44386818ce681da02f00a498acf66043aa55558e.1711109214.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LtE2ZQTN2raOHOvt"
Content-Disposition: inline
In-Reply-To: <cover.1711109214.git.ps@pks.im>


--LtE2ZQTN2raOHOvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is comparatively hard to understand how exactly the binary search
over refnames works given that the function and variable names are not
exactly easy to grasp. Rename them to make this more obvious. This
should not result in any change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/refname.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/reftable/refname.c b/reftable/refname.c
index 64eba1b886..9ec488d727 100644
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -12,15 +12,15 @@
 #include "refname.h"
 #include "reftable-iterator.h"
=20
-struct find_arg {
-	char **names;
-	const char *want;
+struct refname_needle_lesseq_args {
+	char **haystack;
+	const char *needle;
 };
=20
-static int find_name(size_t k, void *arg)
+static int refname_needle_lesseq(size_t k, void *arg)
 {
-	struct find_arg *f_arg =3D arg;
-	return strcmp(f_arg->names[k], f_arg->want) >=3D 0;
+	struct refname_needle_lesseq_args *f_arg =3D arg;
+	return strcmp(f_arg->needle, f_arg->haystack[k]) <=3D 0;
 }
=20
 static int modification_has_ref(struct modification *mod, const char *name)
@@ -29,21 +29,21 @@ static int modification_has_ref(struct modification *mo=
d, const char *name)
 	int err =3D 0;
=20
 	if (mod->add_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->add,
-			.want =3D name,
+		struct refname_needle_lesseq_args arg =3D {
+			.haystack =3D mod->add,
+			.needle =3D name,
 		};
-		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &arg);
 		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
 			return 0;
 	}
=20
 	if (mod->del_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->del,
-			.want =3D name,
+		struct refname_needle_lesseq_args arg =3D {
+			.haystack =3D mod->del,
+			.needle =3D name,
 		};
-		size_t idx =3D binsearch(mod->del_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &arg);
 		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
 			return 1;
 	}
@@ -71,11 +71,11 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
 	int err =3D 0;
=20
 	if (mod->add_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->add,
-			.want =3D prefix,
+		struct refname_needle_lesseq_args arg =3D {
+			.haystack =3D mod->add,
+			.needle =3D prefix,
 		};
-		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &arg);
 		if (idx < mod->add_len &&
 		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
 			goto done;
@@ -90,11 +90,11 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
 			goto done;
=20
 		if (mod->del_len > 0) {
-			struct find_arg arg =3D {
-				.names =3D mod->del,
-				.want =3D ref.refname,
+			struct refname_needle_lesseq_args arg =3D {
+				.haystack =3D mod->del,
+				.needle =3D ref.refname,
 			};
-			size_t idx =3D binsearch(mod->del_len, find_name, &arg);
+			size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &arg);
 			if (idx < mod->del_len &&
 			    !strcmp(ref.refname, mod->del[idx]))
 				continue;
--=20
2.44.0


--LtE2ZQTN2raOHOvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX9eA4ACgkQVbJhu7ck
PpR2yw//aL+95zX+gb0g4jww0D6gDj9BFv47yYUHvGE2jx5emuqFyc3UudJ3/YLO
Z4aeyL6NBIe8zr+IM1E14hQoOr/TRcf39cey9hjG6zzx1LxpyXoux+a1CCaZJwG6
1OOtrBPNXHH/wPDeyDgPgwOiknaaHIdeUAxBtk5klk489MOskZBc28GVt1NGWM/q
m6eKLaDacJ1b+nt11fldQaqukW/X4MlVluJAEj3IDRi0oe03Y6p+UQObFtQsKS54
ob5BhWTixrrtK1XvQgJ5CwTzBYEiemHAXDeo7202KiYA6v+Joofo0wY0jH42z5Lr
EzvcNAFwu+xqQYwuemX/BZ47p7XqNTepzjXsnwghUNcdUb/sc0FMmiGL9rl1gUyU
tBvtGLUqD0nXLU5TyCxWJpukA/BiIUiUGL81T7wbpGQpJ8EjfwDwppooTxIn/rcS
Nnvhh2rBJHYgdkBRtWSKhhM8GKKWN4T38ctObNipJRAGwtLCtZhh3SA6RlSZAmVu
M9LIzdVeRN719nVnt1Wc2VF7FdOOmKmlD39MWK6Fp4/huwCUJkBPkmwo/rehAJxU
Zra1Yb65jlqtwABBKU6rhKqX15EV3aCFQEF4g9JMd/D4XQvsggo2eZH9kwBhX276
ujVlSTJG5TyVCGBoym7w5ZMt/FOCPIi3o9m/JrloXGO5tkPI2Ys=
=7gmZ
-----END PGP SIGNATURE-----

--LtE2ZQTN2raOHOvt--
