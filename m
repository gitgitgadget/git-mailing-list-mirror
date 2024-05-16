Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F11369BE
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846725; cv=none; b=XcOdv8Vu+zIQzYRxtxdlQc2V/BFZxA470ChYG9zGkIi2GIVlo3Y9MwV91GU/YiVDRx4epudanY/mtL6qyDjD62yItIOOZqBYf3bJhs/8vqOpusgQMz3cydtH2a1jUKbxN+xk6Pq7sH8wDuHCBrVzBZ5eyDcYuCYd4P6zEQDr9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846725; c=relaxed/simple;
	bh=of00KeCKh7fit4FFaqUli0Wg/xyngjgewbW7g2JqDK0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTJdLseAU//hrNhLGrzl0Upx0sH/ApCRAfxACmfCtDl47YMYH8GRymvRLhagRJrAtGP/LgMtE4b9T2vTMf2/bxxk/DbY0jQlWxyHB6LQZcVoKQ1vFcSXLkzDSxDP/4f3GL1D2zmLvz1km5XgGZf6JP6JgcjEgdJHxyoEx/VR++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t9OTaFpf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJ5Hp9P8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t9OTaFpf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJ5Hp9P8"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CE9D61140065
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:05:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 May 2024 04:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846722; x=1715933122; bh=h8Cb57n7dG
	j7zYyVt/pKAMSSElzsL2Jhj1AjSpo5R7o=; b=t9OTaFpftHF0NtGM0PaHkeX7M2
	Z+XkK/pNxhi+DYL1kcmVbI6DSexDRT4vcUZ1xHk65LcIl/U/0oaxOjKiNO4rBH1K
	sejV0CF3lW5CbRFlQCG/Oi0oH//U/nnl2UcxoGeRmlvPqtHPFJrW5hTUoa57hpRt
	RTigC19Cb/ThYbBBuwdcKGQ4ZBAMbQfeGL6LaAozhmxiC2nUUIfhpGLrNvVnLlvp
	02n6yCdAg/P9YG8twAvcZZLef4TT2Tk2A5mBT1ZQb4XegnkoJL7F2K54Tsx71vNT
	JqHoCLGzhjVXG8Q9NNAPQ/Y/MAvEaDezsoMHxP2KKT2ACztNgDrbs5ou5qbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846722; x=1715933122; bh=h8Cb57n7dGj7zYyVt/pKAMSSElzs
	L2Jhj1AjSpo5R7o=; b=MJ5Hp9P8sTIejFBkvMfUH74/7fDfycWyuhhgoL6TjCgZ
	8B44/NjDxkbghH5h7DOzv+BYiYi8Yi1hA2bWRGmcwmiAD5UfW3c4wBR82AU6s/LJ
	/PawhveS2gBSXUqdvK1DBLzuTDsfS421P6656lorER6DNfZgWKTRPzAWGtBrCEOc
	VXcrHZ62to7G0Hjo9ZGLQNoNS0A0JhFxZdZUpiGxX1UnBORI4cYMhFftpQEOw6BV
	pNWCjbNz3c0e7DE79Qcrf6XbTzrXHgqwT3pbav4fcV/sxAhoj0tZdIIPK/JU/Pp2
	ZIToThReGM1b3BCkkoXvecriKgloVvsYAwY8PfCMsw==
X-ME-Sender: <xms:Qr5FZtdYD9XuELMaQV6Zbz3wegjfNGpy5BKgvI4MPAokpAAfCoEChg>
    <xme:Qr5FZrMZhCE06wu24ZuoYR9CJmhb2Czp7BscyFSvf4eb0yv2kAfEBQbiyYyq06RNh
    BhOV8Gv-DZ5tD06Hg>
X-ME-Received: <xmr:Qr5FZmgbutamKQ514-O_Ufm4YWayUEc1pvX1b1v7HrAN5jzeqEuQSzVP0MM0-oc1mZM-I1jdNOx68hfbAcoGiA67DlZdHEoHqNIVAJOffU9phIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Qr5FZm-HoFr900JA8aBi7LwlnjOOKMaZjey0dS7bO76tDJPx6D9iUQ>
    <xmx:Qr5FZpsonyjyro41m08LYinv8NAxy-cictwOBOElJjXtN5abWO0yZg>
    <xmx:Qr5FZlEoCqS9kp0N6HSWJVNVuSYNquZqFJ9kb654As50xmQik9JKWg>
    <xmx:Qr5FZgOC1dM2dATJ0eOKvmTUOezk87dJEg6P3KwKOAlw-rj7UA-bZw>
    <xmx:Qr5FZqVxMQI7HtYnnDHnqEtWl4De1hjL9AMwnSY9KXXNj32-PGhS1lMI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:05:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ef70aece (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:57 +0000 (UTC)
Date: Thu, 16 May 2024 10:05:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/16] refs/files: use correct repository
Message-ID: <7ce6b7454df672610da001186949e54672895ae0.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k8hXz3BxzTmEOTZ1"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--k8hXz3BxzTmEOTZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are several places in the "files" backend where we use
`the_repository` instead of the repository associated with the ref store
itself. Adapt those to use the correct repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 368df075c1..5294282770 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1237,7 +1237,8 @@ static void prune_refs(struct files_ref_store *refs, =
struct ref_to_prune **refs_
 /*
  * Return true if the specified reference should be packed.
  */
-static int should_pack_ref(const char *refname,
+static int should_pack_ref(struct files_ref_store *refs,
+			   const char *refname,
 			   const struct object_id *oid, unsigned int ref_flags,
 			   struct pack_refs_opts *opts)
 {
@@ -1253,7 +1254,7 @@ static int should_pack_ref(const char *refname,
 		return 0;
=20
 	/* Do not pack broken refs: */
-	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
+	if (!ref_resolves_to_object(refname, refs->base.repo, oid, ref_flags))
 		return 0;
=20
 	if (ref_excluded(opts->exclusions, refname))
@@ -1285,14 +1286,14 @@ static int files_pack_refs(struct ref_store *ref_st=
ore,
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
=20
 	iter =3D cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
-					the_repository, 0);
+					refs->base.repo, 0);
 	while ((ok =3D ref_iterator_advance(iter)) =3D=3D ITER_OK) {
 		/*
 		 * If the loose reference can be packed, add an entry
 		 * in the packed ref cache. If the reference should be
 		 * pruned, also add it to refs_to_prune.
 		 */
-		if (!should_pack_ref(iter->refname, iter->oid, iter->flags, opts))
+		if (!should_pack_ref(refs, iter->refname, iter->oid, iter->flags, opts))
 			continue;
=20
 		/*
@@ -1389,7 +1390,8 @@ static int rename_tmp_log(struct files_ref_store *ref=
s, const char *newrefname)
 	return ret;
 }
=20
-static int write_ref_to_lockfile(struct ref_lock *lock,
+static int write_ref_to_lockfile(struct files_ref_store *refs,
+				 struct ref_lock *lock,
 				 const struct object_id *oid,
 				 int skip_oid_verification, struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
@@ -1537,7 +1539,7 @@ static int files_copy_or_rename_ref(struct ref_store =
*ref_store,
 	}
 	oidcpy(&lock->old_oid, &orig_oid);
=20
-	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
+	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1557,7 +1559,7 @@ static int files_copy_or_rename_ref(struct ref_store =
*ref_store,
=20
 	flag =3D log_all_ref_updates;
 	log_all_ref_updates =3D LOG_REFS_NONE;
-	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
+	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1791,7 +1793,8 @@ static int files_log_ref_write(struct files_ref_store=
 *refs,
  * Write oid into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and return -1.
  */
-static int write_ref_to_lockfile(struct ref_lock *lock,
+static int write_ref_to_lockfile(struct files_ref_store *refs,
+				 struct ref_lock *lock,
 				 const struct object_id *oid,
 				 int skip_oid_verification, struct strbuf *err)
 {
@@ -1800,7 +1803,7 @@ static int write_ref_to_lockfile(struct ref_lock *loc=
k,
 	int fd;
=20
 	if (!skip_oid_verification) {
-		o =3D parse_object(the_repository, oid);
+		o =3D parse_object(refs->base.repo, oid);
 		if (!o) {
 			strbuf_addf(
 				err,
@@ -2571,7 +2574,7 @@ static int lock_ref_for_update(struct files_ref_store=
 *refs,
 			 * value, so we don't need to write it.
 			 */
 		} else if (write_ref_to_lockfile(
-				   lock, &update->new_oid,
+				   refs, lock, &update->new_oid,
 				   update->flags & REF_SKIP_OID_VERIFICATION,
 				   err)) {
 			char *write_err =3D strbuf_detach(err, NULL);
--=20
2.45.1.190.g19fe900cfc.dirty


--k8hXz3BxzTmEOTZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvj4ACgkQVbJhu7ck
PpSK+xAAq9b7BIKFsNdbKusDMb4N2Bc7iX9yYhBWsfp84KMAnPJwBIB5KlXj8ofT
vgC08PzlM3kwqibPP71BM5KTAn9m08+I22ILRB8AJb4IOhh7L/e989+cUiDEkfTh
bzbBndIVnRBI1L7aqcpDIes8Gve9tEyOMyJlLyCjZ9XNQ4xgOu05auob56m7T1z9
9NfDnwZsIiko6vVhnDnrY9ufdjPkRB1HwnQJpX/wVVSpBY0SRfo3EZOtOJZibhv1
9Ah1OQgEE3pW19qMWSzD1j3wKZ/fN+GTKbWNwrrM2Cmrv3oIYbs9PFkutAj2ZNGH
9CbQWQXHen3vE21YknAbPUAriQ1NO5d2oLFIf8r2VIaLSf2f9ojxIlYV5wNOF4aB
JY1c5+UUgycGq4H3M8SnIWz0N8r5C8JfMQG0gPGF8s0tVWzT3Qj3yl1lJvt4cGxg
PN819kgu5iAzufSWYiuhup3XNZA9G6iGir8Iay3WaIvCViGAdMujpJsTxlaUr2vi
ZJ8VNqu0jqYOfnsnZMng2e1WP2axuJklEPK8PiO4HqkDMJo4shepn7ywQMvgVCAb
wGdc8hEIrpvFkRSiMVvnIy+uvnhdGky5hjoHXNhtIczC1vFqaiztZgtqwk1zmr3O
qTPXEGM0zj61+O0RHoDorsGnmVPSUv5alQ3gSUIjCSse44nljUg=
=+qZl
-----END PGP SIGNATURE-----

--k8hXz3BxzTmEOTZ1--
