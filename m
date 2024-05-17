Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C862729437
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933945; cv=none; b=kJm8wji93lGXMNlYLIqcXvYiWc+YlNEX7la4LuPhF7Up4JctU5eMvxQJ98YqGlTSIFtZHvt4+Kc81avkb3XON3PL/vQNUTQ1PKWMuwsDwKNdf7v9xQIJkZB6BvdhmzRf0ShX8A09A6FSiVt7gcPQmcgkLQoM2CDatB69p8fR4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933945; c=relaxed/simple;
	bh=UcgA1plcJi5FmBk5C1wi22taKka3Vdo8vph8ZPC3pTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU2xqiBv4Cczzb8HK/uoqxJQ25I7StdFwtiktBFW8o4Oj8Dr4s6spfixLW85lPUYoxul8m+b6GK4wjXuDe4NT6eEnAi2udI29NQdhLMAD+yUdMvQX45+WWwcHFDk4eNRCsfEU0wh5BuMKH9zURweL/kAS5WgTLDKo6bZluBKzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ItvjLG4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVBLVuAp; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ItvjLG4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVBLVuAp"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 111761C000BB;
	Fri, 17 May 2024 04:19:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 17 May 2024 04:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933942; x=1716020342; bh=PPJC9hhIn3
	/yni5DFUMKrBXyOxnz3eFLOoR4yNmpyz8=; b=ItvjLG4pYiEnlQhGdg+80LChYl
	va0n+eyMa8oGFWol+ANGDaD4J0PEy48Ssmcn74aGLXl/FPPxq95//KhK9IU1IqDF
	YFYvVaik1O5ve4MNKPdLXCXtgv0GLMXrKFWT8Pcds0hkwm3YBDHC1xtDKGAhNU2m
	uF6/yNtOQkA2COB3Ht6QzZknTyNjYwS9/CLjeg8T45ZWaqOB2IewBWDRq0YnElDu
	BYqcxYwSDMyp8cdd97Dz8Gbst8Zoc9S1uBU/YAKkLuOScHD1VooI1DAxo/Kewe41
	cz6hwrmdEFXSZjowTehjTIaTObBL7WBovgT2qVU1rXbEpGT87GOXwhr3WR+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933942; x=1716020342; bh=PPJC9hhIn3/yni5DFUMKrBXyOxnz
	3eFLOoR4yNmpyz8=; b=RVBLVuApfi4YTFRC7IiLlWdhqW9E7OVhds9CbTHd8P0e
	AeBvSbRH4M+CDFF5x0xpjh9p3PeBPFqFlDWXPDA8WbdjQyTQHIu00u6TFGY/7O+E
	jAJDaGBc1tNkJRlLu8rqw09zzTWnGoo1f+xQ1DVZx1XiYS6aWa1kPv0YaOpN5Sqe
	0tu08MhpBK738c1fzS2XkbC8BMp20Xaw84SLQLT1hI20tf4PsUnOapy3tkvyK6/6
	rrl8r0tz3FDO9KkoapBO+yKgL18TV6aAk8bAUW3ylmeN9ficwUo24AGGehrOGFuW
	5pAOlWSiVgzzR97SbkkyknjGd9Zjc2oFTTgyMfBXUg==
X-ME-Sender: <xms:9hJHZirxlwdW-uTvd6JtvBnbsLaxTgYWALHEeXv0fr1-NtV1nWqE3A>
    <xme:9hJHZgqHC8XLh9ajtajDo1pWNdnNvBXtbonCFANidIjoxZfNwH0EaYSzph06Xxj73
    rLcp62WurPgZg48OQ>
X-ME-Received: <xmr:9hJHZnPT02FD163Bqwt-bymIEW7JfGRfV1NjGxzfdcCghC1jU8ky-aABxqZIqtQ0aujQRrgSLp5dALeRg9SdH7uaCRlKSTbLfzumgXrFt2B0xODnkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9hJHZh7GEeRNqR8bjVjsWv7cElr81-SMt_-7GtdLtngEvai4lHej4Q>
    <xmx:9hJHZh4TfPf1RiVHDVvg9w2OpnNPExOXy8dsuUETLsUURiw_obmVRQ>
    <xmx:9hJHZhi0j_1R-4Xl0GnvXxUrGmg7qOQ6aIu4YcvxK1jKZLGsO_Kriw>
    <xmx:9hJHZr7Pulr8Zb1efUDB4PliXBSIn0rNDngw_deVhJShOBGL8MkVEg>
    <xmx:9hJHZrmEgcW8WvDKcC2A52w2sNTQx-t9A1KRi5lFsuBdtoM8LudiOSfd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:19:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7ec647e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:34 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/16] refs: move object peeling into "object.c"
Message-ID: <3c6f814158bd9f6ab78362181614f3e2112e4a19.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mFrMcgQ/x86aDvy"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--5mFrMcgQ/x86aDvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Peeling an object has nothing to do with refs, but we still have the
code in "refs.c". Move it over into "object.c", which is a more natural
place to put it.

Ideally, we'd also move `peel_iterated_oid()` over into "object.c". But
this function is tied to the refs interfaces because it uses a global
ref iterator variable to optimize peeling when the iterator already has
the peeled object ID readily available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object.c             | 21 +++++++++++++++++++++
 object.h             | 34 ++++++++++++++++++++++++++++++++++
 refs.c               | 22 ----------------------
 refs/refs-internal.h | 34 ----------------------------------
 4 files changed, 55 insertions(+), 56 deletions(-)

diff --git a/object.c b/object.c
index 51e384828e..995041926a 100644
--- a/object.c
+++ b/object.c
@@ -207,6 +207,27 @@ struct object *lookup_object_by_type(struct repository=
 *r,
 	}
 }
=20
+enum peel_status peel_object(const struct object_id *name, struct object_i=
d *oid)
+{
+	struct object *o =3D lookup_unknown_object(the_repository, name);
+
+	if (o->type =3D=3D OBJ_NONE) {
+		int type =3D oid_object_info(the_repository, name, NULL);
+		if (type < 0 || !object_as_type(o, type, 0))
+			return PEEL_INVALID;
+	}
+
+	if (o->type !=3D OBJ_TAG)
+		return PEEL_NON_TAG;
+
+	o =3D deref_tag_noverify(o);
+	if (!o)
+		return PEEL_INVALID;
+
+	oidcpy(oid, &o->oid);
+	return PEEL_PEELED;
+}
+
 struct object *parse_object_buffer(struct repository *r, const struct obje=
ct_id *oid, enum object_type type, unsigned long size, void *buffer, int *e=
aten_p)
 {
 	struct object *obj;
diff --git a/object.h b/object.h
index 9293e703cc..31ccd1bb10 100644
--- a/object.h
+++ b/object.h
@@ -256,6 +256,40 @@ struct object *lookup_unknown_object(struct repository=
 *r, const struct object_i
 struct object *lookup_object_by_type(struct repository *r, const struct ob=
ject_id *oid,
 				     enum object_type type);
=20
+enum peel_status {
+	/* object was peeled successfully: */
+	PEEL_PEELED =3D 0,
+
+	/*
+	 * object cannot be peeled because the named object (or an
+	 * object referred to by a tag in the peel chain), does not
+	 * exist.
+	 */
+	PEEL_INVALID =3D -1,
+
+	/* object cannot be peeled because it is not a tag: */
+	PEEL_NON_TAG =3D -2,
+
+	/* ref_entry contains no peeled value because it is a symref: */
+	PEEL_IS_SYMREF =3D -3,
+
+	/*
+	 * ref_entry cannot be peeled because it is broken (i.e., the
+	 * symbolic reference cannot even be resolved to an object
+	 * name):
+	 */
+	PEEL_BROKEN =3D -4
+};
+
+/*
+ * Peel the named object; i.e., if the object is a tag, resolve the
+ * tag recursively until a non-tag is found.  If successful, store the
+ * result to oid and return PEEL_PEELED.  If the object is not a tag
+ * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
+ * and leave oid unchanged.
+ */
+enum peel_status peel_object(const struct object_id *name, struct object_i=
d *oid);
+
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
=20
diff --git a/refs.c b/refs.c
index 48323dd28d..d1b530679f 100644
--- a/refs.c
+++ b/refs.c
@@ -19,7 +19,6 @@
 #include "object-store-ll.h"
 #include "object.h"
 #include "path.h"
-#include "tag.h"
 #include "submodule.h"
 #include "worktree.h"
 #include "strvec.h"
@@ -425,27 +424,6 @@ static int for_each_filter_refs(const char *refname,
 	return filter->fn(refname, oid, flags, filter->cb_data);
 }
=20
-enum peel_status peel_object(const struct object_id *name, struct object_i=
d *oid)
-{
-	struct object *o =3D lookup_unknown_object(the_repository, name);
-
-	if (o->type =3D=3D OBJ_NONE) {
-		int type =3D oid_object_info(the_repository, name, NULL);
-		if (type < 0 || !object_as_type(o, type, 0))
-			return PEEL_INVALID;
-	}
-
-	if (o->type !=3D OBJ_TAG)
-		return PEEL_NON_TAG;
-
-	o =3D deref_tag_noverify(o);
-	if (!o)
-		return PEEL_INVALID;
-
-	oidcpy(oid, &o->oid);
-	return PEEL_PEELED;
-}
-
 struct warn_if_dangling_data {
 	struct ref_store *refs;
 	FILE *fp;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 07e24c8481..8d85589081 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -69,40 +69,6 @@ int ref_resolves_to_object(const char *refname,
 			   const struct object_id *oid,
 			   unsigned int flags);
=20
-enum peel_status {
-	/* object was peeled successfully: */
-	PEEL_PEELED =3D 0,
-
-	/*
-	 * object cannot be peeled because the named object (or an
-	 * object referred to by a tag in the peel chain), does not
-	 * exist.
-	 */
-	PEEL_INVALID =3D -1,
-
-	/* object cannot be peeled because it is not a tag: */
-	PEEL_NON_TAG =3D -2,
-
-	/* ref_entry contains no peeled value because it is a symref: */
-	PEEL_IS_SYMREF =3D -3,
-
-	/*
-	 * ref_entry cannot be peeled because it is broken (i.e., the
-	 * symbolic reference cannot even be resolved to an object
-	 * name):
-	 */
-	PEEL_BROKEN =3D -4
-};
-
-/*
- * Peel the named object; i.e., if the object is a tag, resolve the
- * tag recursively until a non-tag is found.  If successful, store the
- * result to oid and return PEEL_PEELED.  If the object is not a tag
- * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
- * and leave oid unchanged.
- */
-enum peel_status peel_object(const struct object_id *name, struct object_i=
d *oid);
-
 /**
  * Information needed for a single ref update. Set new_oid to the new
  * value or to null_oid to delete the ref. To check the old value
--=20
2.45.1.190.g19fe900cfc.dirty


--5mFrMcgQ/x86aDvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEvIACgkQVbJhu7ck
PpRYQg//dZ3zTDKJey/3DMHuRLZhGj6M9FKjn9W7Fvz8Nsb1C5d7x1HwLZ9Ef22i
fMWH4zqtfAl70eTbTu053yg9OjkiO6r/YTkdX1DNWjWSomG1MDNW7fz6ZN2qrD5z
Gpt+QsQHFZn6b4wrWbzELriV6aUC+lTsnbkRJQ/uM8a9PyfZWZMcl66Uiewt5il6
B8j1YAPrN1pEbcSw12TyB1dLZwkzizdivPJfr5FRMHg1OqfVh12T67u663/MpDWG
3d5hJIlWZXihDPo7grYgh6NYdJha7OHk9FZnGdPW9Q0drSw0FXWjIR8UGGuMcMzd
S2Z169m9gYlib4CRa0kJgk7jnbQBLE/958ozix/YgtYpAwZLYARNVnE7agxzGSCU
tM/veJrH5Ib/sBLaFvG3Qo+oSZYbr5FbYeKA8LGl/mfyjOIjWh0bKBYxsJwYwtjr
54A30p+DabFZlfGj5BJyTHQQaA+nBm1YnnB0mKU4mpXztuEavIdxdcT1/RqEMpkG
XhHRpmnpzrb6BnaCv30LVi9t7gAftCDtegkGNXlQKSVFg8FB6jofO5rooJrDqG45
xgsZHnNWv+1f7oQXSuqpE38LTcdglFzTRvQeZ5gW8UY8UwWYzsTMJmyBZbu3pfop
VCQc6/FPvQfY35xGGug7bZOdYrhxxZ4Fx7WXS8AMHq0Mh94Gd0M=
=crl3
-----END PGP SIGNATURE-----

--5mFrMcgQ/x86aDvy--
