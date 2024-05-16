Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B5134CE3
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846704; cv=none; b=hsni4gsRtBM6URkYB598iPr81U+0H0QKIzGYL6mdGAms1/M1B5EP8DA9gWVEOnCuzUHWWTVygCBoozXb+uwCdf75ppPOotUO5+OIYA826OT07Sz5GuXSURW4qrtU+2Ny7L+0VsnyPZOHIitkkn4eWUc5fKf7szubQEq6Lw15iZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846704; c=relaxed/simple;
	bh=taiIa1uxzmIo04QS9ZMbJcjKUKj1ucXpnvpLb9A4Xq0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEh3TQJKg9yCfVCVXfRTDRL9q5GSe1X5sgQsWQck7ubrsHTp9WlIbo+1uNGqjfipyaxcGZLjusAIalh0uLC7mcSDorhErrKuQZPCMcTzlS+1zKK+6b2NuQl62SsbgrmvNnP54QPerk6e8ELcZ1Runtw595BVnBDe/v4f1y/TX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eq1YYjVV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vf53g9b9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eq1YYjVV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vf53g9b9"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id EE6A11380282
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:05:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 May 2024 04:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846701; x=1715933101; bh=MYxq+RI37q
	mZTPEZKWLVxaFj83GuyWwEamZLdGg5saw=; b=eq1YYjVVKZOk/b6rx42YzG7+oO
	wMy1Bs3aNsqZTzErcQoQeMBINGA7ZMNyJkq9hecnA1boI9Jv59I7FX8chLeIPzT4
	UKs2sN0ZXHdYADMH/N/0/RJZXezPfu71P0BTMi5ZcbennPiMsCZsWqqomVN31ESG
	s5bKA/pbEvIZMw8hM7r0Pa7xQoLjmuWC2RI0Gj2BWgI2bL0dMpB58GcVUp1gjfbz
	nGmltbwUoCVWn+cCl0HDm9aKtXRb8HjDEQ5OoY1G4jnJnjCGVkXJ6/kgrqwW05km
	XfS24PVwN+gtMIAZX0VAxx++RoC6+kW3Y3LyQaaRAmfBejK5vLLYt8mBLynQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846701; x=1715933101; bh=MYxq+RI37qmZTPEZKWLVxaFj83Gu
	yWwEamZLdGg5saw=; b=Vf53g9b9Mian8VNijs4dVBzrVTiWy37wUD+8aFfso3qb
	yArZNXWuJKF1r8v4adkRJWHzdgZeProSS+ICIr78p9L376qlEBWorU3zEFNhWVqA
	ItAeqzFWTfsalX4fA2gDU0e03Ty+kxV5/fU49lHOi8VKEQk6ldbiJrDcGiHHqGOB
	BSuElu6dEBdM/4YVHWYIo0Oa5GxBnXupKdWOtpODrX+D08W9SeMX9GbLtnfVBH4Y
	sVLHlAly2wCXtjIkSPhchkp3HloF+lUtan+IoucTr2xBwwOdj9DfdY6EBNr1ahDw
	2QOF7mfFpfpe/1RKoU1GYcxEpcN+7GZtTzLwovkhQg==
X-ME-Sender: <xms:Lb5FZrX0nZJl6sV3pBFIQp5_4nk44tEU4ibICQvtlk-c-SrkZutWpQ>
    <xme:Lb5FZjnr7St3aRdIrs4MN52TYUdfZARVHMbhliKZrpvvySKBqzKsBIO9CG2W9Zy1d
    p_2HGhIm-Gc9M1Nhg>
X-ME-Received: <xmr:Lb5FZna1jrM6Dwfkv1nEWAArQJRWlydqe9XS14G_5VLDy0tGrav65g_PA1GhypkT8pPsX5HGw-koZwsXCJPWs2rptdN8QOL4vypylcfbdfWLYWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Lb5FZmWzdozkmHGpol_bKjh5v7OoDnBAFZpgs5EkGwpasWpxjAWe_Q>
    <xmx:Lb5FZlnkFqeUsyHyawx4FFgz8hpt-9s2kgK6iwyItoS3ZCiTITC1Rw>
    <xmx:Lb5FZjfM2easKJNgK_04OFRYEnCmx8dLzAdgZrTSijDEywA2KhfR8A>
    <xmx:Lb5FZvHuhl8JiyeKhZzgGKi7FmSCRi8W4AZidbliMGE1dCaoFJX3wQ>
    <xmx:Lb5FZlvmqJij6IHRebV2NEcXFyqVYTV2dBtfqPUoSeabUad2m8EXYcsP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:05:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3280460f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:36 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/16] refs: move object peeling into "object.c"
Message-ID: <f03626ac0025050e49cad4057e6f3b3e7c7c141c.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T5rJbPgkiAdSiV7K"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--T5rJbPgkiAdSiV7K
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
index e6bae9d52c..02d756f24f 100644
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
index fc77240c93..df9b16a872 100644
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


--T5rJbPgkiAdSiV7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvikACgkQVbJhu7ck
PpRrFA/7B/r6bYgMiHpkWx26l5V2JyeT6mDZ97gLsxbktcAShffbULIzgazfy3v6
kddv+soIDuWy1LrzWeWwpjM8llwIO9A/u2hjXeexasLZ9auog4piZeTby3CsFKU3
JSlrwNfSvrpI6lMBL45M8TmJb4ywdgsjPoXdf6roGqe5YOB4IxQLfkcQreW+B49F
OpiAQbSNUKPSFdma7GCH3NY2/tVTMReOyo1tbvUt9eckpwc0O9C06R09IU24paxc
QaOnfD/TYlLs+0Sn1aAfo75h3XL1GDsmwYVvggfJ8+hjsADb1aYcCyzeX80VBr8D
DC4DMhEr5R535rmK+FfANw+ym2OPtRDM+7YJdPAm5t2EEy58Mu2ZmIx5Kkl7ttQw
zNuWz/RagMAaTNSMN9lpDJt5pJ1C0z0UNgTAbr1TS2q+wFatOzHAI+vtLXUahLHp
3JGTwYHm4RVXV7pxm6xTIrgrADmI7BxAWx+gj4sXNBdR2FDhEehQeYZQD8R8tR/X
VJFFdsfDhAKLwztdYZpTYmaEu2/X6QMTPvED7Rb6lF+8+g/LLIqbFVct+o0UAQY+
wuOBJoOm5R4Y9dX1O+7g/p3SXOZUUcOJphcot/oOWR6QjldRrKgcErt6CZBbo6OV
rRoce1t/lzvfal/tr/8bOFRORTjFp5191yIGHWISKAn1+BGvXZA=
=PrPP
-----END PGP SIGNATURE-----

--T5rJbPgkiAdSiV7K--
