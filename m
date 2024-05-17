Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D261AAA5
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933950; cv=none; b=CnM3IOh5qAeZM+xhcuGoa4ZYyUv473XEqXk8o4U1hmJuPmKWh07OiYRBLtfbqKSnk0N4c7e4PN3AJgQO3mJy+uETGasB3/hWDu1NVppEKQ8MZEFsSOwIFHEMw/HXpXG2RIJ7v77BUDOLcye8wtYOI4HPnoynzOy5GhC4yBjqi78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933950; c=relaxed/simple;
	bh=2wwuHSs2rpICHQxzIZXYyAJPe2kRf1eb0tuOYtApbls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGLuKOGFHolbsrQebpQ3fGYPsP0cB+P49/P07H1oUoLZ6rO0KBZkFCo0pgE8PY9D/bzcJQdplpHedPjUu9+4Vd5yf8U5i7koqqg4qfSOO6Gd2qUiL2XjtcJodKP/Z+SOPAfdfXL5UI8c7+Ix22C4hOK/SV2mJq9LU4LgAagWjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NQW4quFt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NgBDu7et; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NQW4quFt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NgBDu7et"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 099511C00092;
	Fri, 17 May 2024 04:19:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 May 2024 04:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933947; x=1716020347; bh=Uy1XoKP+/c
	dhIJZMoIBhK50aUuQkiO2B1AjUidPCPlE=; b=NQW4quFt6smYdetvyw/o1z8D37
	nHr86baFbmbl289A7DgP64A5iDNiOtXIAKgMQ0F//EuGNBKBMsKif28vzpf2oKVy
	P+ud07tFHEtBoxNu6xo1yimO0ZeQMOF9mk8FX5GRBxpBgaY7I4ev+E849QeEn09c
	IRkmCs3ISCcDaIsb40knquCBw29qn+7epOcLIN2RQ3QwfZ44wAFg7CGyU6HXE2qG
	yEMPs1WhWqI/HCNC6ENE7PciVDdZ/q/BQYWNDFdmCqKnANBlNnXk/WkGJ67Uv34B
	ha+EVuAioAgYKdSUfZDbtAQD33Cz3ETmBLOdUGFIhDHwjPBVtKx5Pv+WTu0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933947; x=1716020347; bh=Uy1XoKP+/cdhIJZMoIBhK50aUuQk
	iO2B1AjUidPCPlE=; b=NgBDu7etQ5/tfxzSFFYrBSgticUvOdtkGr+vUpHOYJtn
	Ze0B8+z1YsPpAFrrCdhX+x0VHVw/cWKi2VdguUSJeE00tOn1asrzmSDr887by78E
	HNHxwoEZyzzOnZ89T00/VFueMjPvJT4h4P09m8Bog6AB2zp4RAGY8SdNfVL6CiRD
	hDrQ/pGBuz6sSC5T/fhR1VTc8a92aOLhXEkG2GscNPBzdmsejCzcgZ5K03JIxSBE
	RDSEL792EJhTS6AJ1C/XZuVNCu3qyFpKbkVPrx/y62DvCku6ymN5rLzi/PKlNvJp
	nLCB0z7ptnqaH6WUOXOli5FtcN+eVkSqLSPBMX/m0A==
X-ME-Sender: <xms:-xJHZuNNJfpRLx8noEELjL-8hREVnca31BXHlPmV2k-JmWWCR9Cfng>
    <xme:-xJHZs83FvU96u0mZMmRZZWOFPqzrFUYxbGenRBMrgpIJtGLMMl3GFEQIsxvVOme2
    2SOzmukFuARIJegsw>
X-ME-Received: <xmr:-xJHZlQVzjyLVKSDYtEwKxDZkJeoh7ZO59EEsSRlkNdX7Xl9KtSUJvWsK9pogiJxMtYtIJwKDrDvxOWZywQ5d6eAdPb7FjvCC31Nio9WEcokg7SX0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheejffdufeekjeehkeefgfeuvddtheetgfeigfevleeggfehkefhvdejfedvkedu
    necuffhomhgrihhnpehvrghlvddrthgrrhhgvghtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-xJHZuv4O9HvGlX536g0I2TH8dK5PKHbKX-_n_VxhE7axV9rjeB6Yg>
    <xmx:-xJHZmfiE3d9Q8pBvmlX3MMqDAxth--pXbigtq5cxbrBHAyzNNbe0w>
    <xmx:-xJHZi2MuhorJPESGJgaT2-iIpDCm6SjwhOPXYc_ojgPxuLF-TtWTQ>
    <xmx:-xJHZq-ud61EWFfXFoU9eFPGhEgSjjSfBjoy6OX5lCJPabi54jEHJw>
    <xmx:-xJHZm5qRWq98rDFVEI-DeEzc6SA55IR3r3j2OUqXdH9aCoXy3JZHDjz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:19:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 81308310 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:39 +0000 (UTC)
Date: Fri, 17 May 2024 10:19:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/16] refs: pass repo when peeling objects
Message-ID: <272cd49357b33e4df9a53fd76ee1011b840570fb.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dNapDmqRC4ulu4OS"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--dNapDmqRC4ulu4OS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both `peel_object()` and `peel_iterated_oid()` implicitly rely on
`the_repository` to look up objects. Despite the fact that we want to
get rid of `the_repository`, it also leads to some restrictions in our
ref iterators when trying to retrieve the peeled value for a repository
other than `the_repository`.

Refactor these functions such that both take a repository as argument
and remove the now-unnecessary restrictions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/describe.c      |  2 +-
 builtin/gc.c            |  2 +-
 builtin/pack-objects.c  |  6 +++---
 builtin/repack.c        |  2 +-
 builtin/show-ref.c      |  2 +-
 commit-graph.c          |  2 +-
 ls-refs.c               |  2 +-
 midx-write.c            |  2 +-
 object.c                | 10 ++++++----
 object.h                |  3 ++-
 ref-filter.c            |  2 +-
 refs.c                  |  4 ++--
 refs.h                  |  5 +++--
 refs/packed-backend.c   |  8 +++-----
 refs/ref-cache.c        |  5 +----
 refs/reftable-backend.c |  6 ++++--
 t/helper/test-reach.c   |  2 +-
 tag.c                   |  4 ++--
 tag.h                   |  2 +-
 upload-pack.c           |  2 +-
 20 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 82aca00c80..e5287eddf2 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -200,7 +200,7 @@ static int get_name(const char *path, const struct obje=
ct_id *oid,
 	}
=20
 	/* Is it annotated? */
-	if (!peel_iterated_oid(oid, &peeled)) {
+	if (!peel_iterated_oid(the_repository, oid, &peeled)) {
 		is_annotated =3D !oideq(oid, &peeled);
 	} else {
 		oidcpy(&peeled, oid);
diff --git a/builtin/gc.c b/builtin/gc.c
index 054fca7835..72bac2554f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -846,7 +846,7 @@ static int dfs_on_ref(const char *refname UNUSED,
 	struct commit_list *stack =3D NULL;
 	struct commit *commit;
=20
-	if (!peel_iterated_oid(oid, &peeled))
+	if (!peel_iterated_oid(the_repository, oid, &peeled))
 		oid =3D &peeled;
 	if (oid_object_info(the_repository, oid, NULL) !=3D OBJ_COMMIT)
 		return 0;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cd2396896d..62ddf41f84 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -779,7 +779,7 @@ static int mark_tagged(const char *path UNUSED, const s=
truct object_id *oid,
=20
 	if (entry)
 		entry->tagged =3D 1;
-	if (!peel_iterated_oid(oid, &peeled)) {
+	if (!peel_iterated_oid(the_repository, oid, &peeled)) {
 		entry =3D packlist_find(&to_pack, &peeled);
 		if (entry)
 			entry->tagged =3D 1;
@@ -3125,7 +3125,7 @@ static int add_ref_tag(const char *tag UNUSED, const =
struct object_id *oid,
 {
 	struct object_id peeled;
=20
-	if (!peel_iterated_oid(oid, &peeled) && obj_is_packed(&peeled))
+	if (!peel_iterated_oid(the_repository, oid, &peeled) && obj_is_packed(&pe=
eled))
 		add_tag_chain(oid);
 	return 0;
 }
@@ -4074,7 +4074,7 @@ static int mark_bitmap_preferred_tip(const char *refn=
ame,
 	struct object_id peeled;
 	struct object *object;
=20
-	if (!peel_iterated_oid(oid, &peeled))
+	if (!peel_iterated_oid(the_repository, oid, &peeled))
 		oid =3D &peeled;
=20
 	object =3D parse_object_or_die(oid, refname);
diff --git a/builtin/repack.c b/builtin/repack.c
index 43491a4cbf..58ad82dd97 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -673,7 +673,7 @@ static int midx_snapshot_ref_one(const char *refname UN=
USED,
 	struct midx_snapshot_ref_data *data =3D _data;
 	struct object_id peeled;
=20
-	if (!peel_iterated_oid(oid, &peeled))
+	if (!peel_iterated_oid(the_repository, oid, &peeled))
 		oid =3D &peeled;
=20
 	if (oidset_insert(&data->seen, oid))
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 151ef35134..3114bdc391 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -50,7 +50,7 @@ static void show_one(const struct show_one_options *opts,
 	if (!opts->deref_tags)
 		return;
=20
-	if (!peel_iterated_oid(oid, &peeled)) {
+	if (!peel_iterated_oid(the_repository, oid, &peeled)) {
 		hex =3D repo_find_unique_abbrev(the_repository, &peeled, opts->abbrev);
 		printf("%s %s^{}\n", hex, refname);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index c4c156ff52..e5dd3553df 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1821,7 +1821,7 @@ static int add_ref_to_set(const char *refname UNUSED,
 	struct object_id peeled;
 	struct refs_cb_data *data =3D (struct refs_cb_data *)cb_data;
=20
-	if (!peel_iterated_oid(oid, &peeled))
+	if (!peel_iterated_oid(the_repository, oid, &peeled))
 		oid =3D &peeled;
 	if (oid_object_info(the_repository, oid, NULL) =3D=3D OBJ_COMMIT)
 		oidset_insert(data->commits, oid);
diff --git a/ls-refs.c b/ls-refs.c
index 8e3ffff811..398afe4ce3 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -110,7 +110,7 @@ static int send_ref(const char *refname, const struct o=
bject_id *oid,
=20
 	if (data->peel && oid) {
 		struct object_id peeled;
-		if (!peel_iterated_oid(oid, &peeled))
+		if (!peel_iterated_oid(the_repository, oid, &peeled))
 			strbuf_addf(&data->buf, " peeled:%s", oid_to_hex(&peeled));
 	}
=20
diff --git a/midx-write.c b/midx-write.c
index 9d096d5a28..86173abdb9 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -664,7 +664,7 @@ static int add_ref_to_pending(const char *refname,
 		return 0;
 	}
=20
-	if (!peel_iterated_oid(oid, &peeled))
+	if (!peel_iterated_oid(the_repository, oid, &peeled))
 		oid =3D &peeled;
=20
 	object =3D parse_object_or_die(oid, refname);
diff --git a/object.c b/object.c
index 995041926a..93b5d97fdb 100644
--- a/object.c
+++ b/object.c
@@ -207,12 +207,14 @@ struct object *lookup_object_by_type(struct repositor=
y *r,
 	}
 }
=20
-enum peel_status peel_object(const struct object_id *name, struct object_i=
d *oid)
+enum peel_status peel_object(struct repository *r,
+			     const struct object_id *name,
+			     struct object_id *oid)
 {
-	struct object *o =3D lookup_unknown_object(the_repository, name);
+	struct object *o =3D lookup_unknown_object(r, name);
=20
 	if (o->type =3D=3D OBJ_NONE) {
-		int type =3D oid_object_info(the_repository, name, NULL);
+		int type =3D oid_object_info(r, name, NULL);
 		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
 	}
@@ -220,7 +222,7 @@ enum peel_status peel_object(const struct object_id *na=
me, struct object_id *oid
 	if (o->type !=3D OBJ_TAG)
 		return PEEL_NON_TAG;
=20
-	o =3D deref_tag_noverify(o);
+	o =3D deref_tag_noverify(r, o);
 	if (!o)
 		return PEEL_INVALID;
=20
diff --git a/object.h b/object.h
index 31ccd1bb10..83fcc035e9 100644
--- a/object.h
+++ b/object.h
@@ -288,7 +288,8 @@ enum peel_status {
  * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
  * and leave oid unchanged.
  */
-enum peel_status peel_object(const struct object_id *name, struct object_i=
d *oid);
+enum peel_status peel_object(struct repository *r,
+			     const struct object_id *name, struct object_id *oid);
=20
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
diff --git a/ref-filter.c b/ref-filter.c
index 31cc096644..79e7d3910d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2520,7 +2520,7 @@ static int populate_value(struct ref_array_item *ref,=
 struct strbuf *err)
 	 * If it is a tag object, see if we use the peeled value. If we do,
 	 * grab the peeled OID.
 	 */
-	if (need_tagged && peel_iterated_oid(&obj->oid, &oi_deref.oid))
+	if (need_tagged && peel_iterated_oid(the_repository, &obj->oid, &oi_deref=
=2Eoid))
 		die("bad tag");
=20
 	return get_object(ref, 1, &obj, &oi_deref, err);
diff --git a/refs.c b/refs.c
index d1b530679f..5f1819b33e 100644
--- a/refs.c
+++ b/refs.c
@@ -2064,14 +2064,14 @@ int refs_pack_refs(struct ref_store *refs, struct p=
ack_refs_opts *opts)
 	return refs->be->pack_refs(refs, opts);
 }
=20
-int peel_iterated_oid(const struct object_id *base, struct object_id *peel=
ed)
+int peel_iterated_oid(struct repository *r, const struct object_id *base, =
struct object_id *peeled)
 {
 	if (current_ref_iter &&
 	    (current_ref_iter->oid =3D=3D base ||
 	     oideq(current_ref_iter->oid, base)))
 		return ref_iterator_peel(current_ref_iter, peeled);
=20
-	return peel_object(base, peeled) ? -1 : 0;
+	return peel_object(r, base, peeled) ? -1 : 0;
 }
=20
 int refs_create_symref(struct ref_store *refs,
diff --git a/refs.h b/refs.h
index 56d9714293..e043b6cfa3 100644
--- a/refs.h
+++ b/refs.h
@@ -127,13 +127,14 @@ void ref_store_release(struct ref_store *ref_store);
  * Return the peeled value of the oid currently being iterated via
  * for_each_ref(), etc. This is equivalent to calling:
  *
- *   peel_object(oid, &peeled);
+ *   peel_object(r, oid, &peeled);
  *
  * with the "oid" value given to the each_ref_fn callback, except
  * that some ref storage may be able to answer the query without
  * actually loading the object in memory.
  */
-int peel_iterated_oid(const struct object_id *base, struct object_id *peel=
ed);
+int peel_iterated_oid(struct repository *r,
+		      const struct object_id *base, struct object_id *peeled);
=20
 /**
  * Resolve refname in the nested "gitlink" repository in the specified
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 9c98e6295f..dfdd718eb9 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -953,16 +953,13 @@ static int packed_ref_iterator_peel(struct ref_iterat=
or *ref_iterator,
 	struct packed_ref_iterator *iter =3D
 		(struct packed_ref_iterator *)ref_iterator;
=20
-	if (iter->repo !=3D the_repository)
-		BUG("peeling for non-the_repository is not supported");
-
 	if ((iter->base.flags & REF_KNOWS_PEELED)) {
 		oidcpy(peeled, &iter->peeled);
 		return is_null_oid(&iter->peeled) ? -1 : 0;
 	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
 		return -1;
 	} else {
-		return peel_object(&iter->oid, peeled) ? -1 : 0;
+		return peel_object(iter->repo, &iter->oid, peeled) ? -1 : 0;
 	}
 }
=20
@@ -1421,7 +1418,8 @@ static int write_with_updates(struct packed_ref_store=
 *refs,
 			i++;
 		} else {
 			struct object_id peeled;
-			int peel_error =3D peel_object(&update->new_oid,
+			int peel_error =3D peel_object(refs->base.repo,
+						     &update->new_oid,
 						     &peeled);
=20
 			if (write_packed_entry(out, update->refname,
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 9f9797209a..b6c53fc8ed 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -441,10 +441,7 @@ static int cache_ref_iterator_peel(struct ref_iterator=
 *ref_iterator,
 {
 	struct cache_ref_iterator *iter =3D
 		(struct cache_ref_iterator *)ref_iterator;
-
-	if (iter->repo !=3D the_repository)
-		BUG("peeling for non-the_repository is not supported");
-	return peel_object(ref_iterator->oid, peeled) ? -1 : 0;
+	return peel_object(iter->repo, ref_iterator->oid, peeled) ? -1 : 0;
 }
=20
 static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 7b73f73f59..850466da4b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1144,7 +1144,7 @@ static int write_transaction_table(struct reftable_wr=
iter *writer, void *cb_data
 			ref.refname =3D (char *)u->refname;
 			ref.update_index =3D ts;
=20
-			peel_error =3D peel_object(&u->new_oid, &peeled);
+			peel_error =3D peel_object(arg->refs->base.repo, &u->new_oid, &peeled);
 			if (!peel_error) {
 				ref.value_type =3D REFTABLE_REF_VAL2;
 				memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);
@@ -2045,6 +2045,7 @@ static int reftable_be_delete_reflog(struct ref_store=
 *ref_store,
 }
=20
 struct reflog_expiry_arg {
+	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
 	struct reftable_log_record *records;
 	struct object_id update_oid;
@@ -2073,7 +2074,7 @@ static int write_reflog_expiry_table(struct reftable_=
writer *writer, void *cb_da
 		ref.refname =3D (char *)arg->refname;
 		ref.update_index =3D ts;
=20
-		if (!peel_object(&arg->update_oid, &peeled)) {
+		if (!peel_object(arg->refs->base.repo, &arg->update_oid, &peeled)) {
 			ref.value_type =3D REFTABLE_REF_VAL2;
 			memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);
 			memcpy(ref.value.val2.value, arg->update_oid.hash, GIT_MAX_RAWSZ);
@@ -2235,6 +2236,7 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
 	    reftable_ref_record_val1(&ref_record))
 		oidread(&arg.update_oid, last_hash);
=20
+	arg.refs =3D refs;
 	arg.records =3D rewritten;
 	arg.len =3D logs_nr;
 	arg.stack =3D stack,
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 1e3b431e3e..1ba226f1f9 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -62,7 +62,7 @@ int cmd__reach(int ac, const char **av)
 			die("failed to resolve %s", buf.buf + 2);
=20
 		orig =3D parse_object(r, &oid);
-		peeled =3D deref_tag_noverify(orig);
+		peeled =3D deref_tag_noverify(the_repository, orig);
=20
 		if (!peeled)
 			die("failed to load commit for input %s resulting in oid %s\n",
diff --git a/tag.c b/tag.c
index fc3834db46..52bbe50819 100644
--- a/tag.c
+++ b/tag.c
@@ -91,10 +91,10 @@ struct object *deref_tag(struct repository *r, struct o=
bject *o, const char *war
 	return o;
 }
=20
-struct object *deref_tag_noverify(struct object *o)
+struct object *deref_tag_noverify(struct repository *r, struct object *o)
 {
 	while (o && o->type =3D=3D OBJ_TAG) {
-		o =3D parse_object(the_repository, &o->oid);
+		o =3D parse_object(r, &o->oid);
 		if (o && o->type =3D=3D OBJ_TAG && ((struct tag *)o)->tagged)
 			o =3D ((struct tag *)o)->tagged;
 		else
diff --git a/tag.h b/tag.h
index 3ce8e72192..c49d7c19ad 100644
--- a/tag.h
+++ b/tag.h
@@ -16,7 +16,7 @@ int parse_tag_buffer(struct repository *r, struct tag *it=
em, const void *data, u
 int parse_tag(struct tag *item);
 void release_tag_memory(struct tag *t);
 struct object *deref_tag(struct repository *r, struct object *, const char=
 *, int);
-struct object *deref_tag_noverify(struct object *);
+struct object *deref_tag_noverify(struct repository *r, struct object *);
 int gpg_verify_tag(const struct object_id *oid,
 		   const char *name_to_report, unsigned flags);
 struct object_id *get_tagged_oid(struct tag *tag);
diff --git a/upload-pack.c b/upload-pack.c
index 8fbd138515..bbfb04c8bd 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1269,7 +1269,7 @@ static void write_v0_ref(struct upload_pack_data *dat=
a,
 		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities =3D NULL;
-	if (!peel_iterated_oid(oid, &peeled))
+	if (!peel_iterated_oid(the_repository, oid, &peeled))
 		packet_fwrite_fmt(stdout, "%s %s^{}\n", oid_to_hex(&peeled), refname_non=
s);
 	return;
 }
--=20
2.45.1.190.g19fe900cfc.dirty


--dNapDmqRC4ulu4OS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEvcACgkQVbJhu7ck
PpSvaw//c1oDEjVbhtzcpQBkWelHHFG6hPqVb38y8vh/juMi+ssholfrfjuSM575
NaTj40sryVOw8dSkcN+QkJZTAkLXbOntaZ9IhALhkFFu61iDGZaGmqkyK4GS3Czn
wYa/nwqIDJr/2ucaqf9D1nGLIUpv/dDqr6ddmqhxEqbwtcbVlD1H5bFWALF5phI2
cHDq5JtVJsZVhzImBRuE1hrFQ2VXnN0iZ6fq2TihP8zJsxXrR9VHpO3AepnPhO/0
NoDc76PQwg00nbVJqZQAS7uHrFXCs20XuPK3mKjacpbBtvhnU80P+o1ia3s+0x3F
y/lEkOe03HKQZdCQCqefhrbKDjPh/PRCStySqzhA+z80nP57g3pMwto+GYAuAdVx
ioaKhIIR80Za4WiyYAC4c2d5e6hpfFDT3Fhpgy00iTr4qB6HWdiBGk16lZkcIc6B
FqHhuKT8D1EJEIGcIa1U1HPDKUTNj+YjLr/WptXEuLiJXn4hAT7MC8uK1ShBBWaX
D2ImhSn4i29ysUxPyyLjB2dTyrIsf77R9taXxKT0I30jzGpAEgcTBiPUOi6n75IJ
Au3iS+tG3pNsEblEUq4r+I9teRsHm8ytbXFbvpxu0dva3sxTJecoH1XBcl93pDMW
bz3cSqZMk6MKBGJFNHcV6cfNIBqbw1AScrpzuPzXJv0DhrLKz5g=
=Rolz
-----END PGP SIGNATURE-----

--dNapDmqRC4ulu4OS--
