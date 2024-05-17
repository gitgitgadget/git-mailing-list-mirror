Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C992E62C
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933965; cv=none; b=SOvp6gzhk7A0BvxhKTfQeDG7nT78Kj7w6abUhgR1683Yrnp7rOexaaKPd5EdQMhuvSCU7Mcf8kMM2Sga1Z9XLQHRIxMdl5ULPX3TXyfPQ8xnPHx8HsQUSRzDf+6x9bF3ViVMm4WYBErBQnjyw6aonIuM9bIKh7sPJbhKLNX81UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933965; c=relaxed/simple;
	bh=K2c/6rNIPhFfnR6j/MfIUUtxHQMCT8vRRzDPuAHq5ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyazQHOmCp8SabRo287Wo60C7aB8afLuGEhLaqTTfuHKwhR5Vh765vrN7hRjzmmyM1kH69cj7phZSYk+4GKrh+jVJU+CLduKgH+sate7auh6qnYBPkLuzCkDr8v37UKQ3qFYPNkvUlFI04FJQnOR+F3QjhfKIHZRcEtWExMbPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ESs7jXDE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KnrLzxIP; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ESs7jXDE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KnrLzxIP"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id DD75F1C000CD;
	Fri, 17 May 2024 04:19:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 May 2024 04:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933962; x=1716020362; bh=3x9HGTG7Ko
	li/1M7B6L3Es+kgO/eSGGRhNhLT3yWrys=; b=ESs7jXDEKa7qZfF6aOy4APTBrF
	eYk+MSDNzIQhATXwkfIS/XUaVGr9u8cLo6wBFNuW5HlsjEaxk/ztU3FhQMTMhBv6
	6Nj87+pB0KmaurmD5QwR7JYqL0M13zhiULk3MCtamxxTa9jdPRC0h49zd0Aza60u
	62+Hdo3/ZE0TTSo9gmBifucC2vGkifNfJeCJZ7EMd2FAv6rwMaTw6GJTrBHaCNFX
	22Iymddw7QNfu3hYCIc9bS6TFwrw4+ZgTSAg73Cvi1+21tg4nlacVVJ1QjrQmKGb
	2iEPO7YdnQGywbF4XgHT5KrT8q1ewfAPaNt2//pQchAtSuAz7MDRbXvtfS+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933962; x=1716020362; bh=3x9HGTG7Koli/1M7B6L3Es+kgO/e
	SGGRhNhLT3yWrys=; b=KnrLzxIPrZfdN1a5cEwGVzI4fbyKnNASd2R+kHn0P7fn
	hDtUVGtrItBvzDqPLOv/NixYkbuDHQ1YwLLkJ9CG0sF7bZXjUxnSOGZg1zj9ulOE
	ELnn7CVM+YLx4SllXm32e50AXQnwlTwtWFwSLS2zQ/TlWyv5ggceO1kzzuZSUh7I
	+eSeqw/7fSsLTDUHeiXAOxvTW8XF4ZoG0ANfQ97cDQPuLzDd7ug8cg08+adNVaxR
	WUmrEDQ8nRE7Rfp2BUWUe8pSbQwGuFzgqnhrBgcnJtYiglI9mPOXT1H33qoY/z4q
	/X8NXhyEHGBXY84QbeSCco4MzZFdKBll+B2vhSB1Ew==
X-ME-Sender: <xms:ChNHZg2hKCg1jxJkFaYGtzJ-xKsJj5k7WN8GfYuRF6KxvmmwH3eeJA>
    <xme:ChNHZrFc8J9WY3Nv0ED7DbmuJL4pkesatsxPtOTuQWgml_GYSETwMNiuGh06pvdTN
    ydW9Ow-m2F9Cz7rbg>
X-ME-Received: <xmr:ChNHZo7VKvX2wjB-r2dFhFL53bxIk3bcDtNGtngPQTYhEdxFd5SdSJUJOB9kZzCMrWe6DB7cZj61LiXBzS0dYQdm68qOAapLASlBUznzmcKQvVqBRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ChNHZp3t5SbZF2_W6ZCu2q2L60TSncf7q8sfsnY-k9qDBMf9LuAy9g>
    <xmx:ChNHZjH-YJLFXwLKAZZfZ6LI2PuzgsLhWWvD8MrzIhT3aarquBF2Tg>
    <xmx:ChNHZi_dvsuUFBEp4vCn-cP1GBDqjJhB-Nnfs2kwmu9YVcMj-n_BpQ>
    <xmx:ChNHZon47VbmdmjffGJ6sy-1cXJ8x3ThCcPpqRKB3G2BQ1HWFFyUBA>
    <xmx:ChNHZrAZbt1ZuKb25En0p7ziE_gXou983o2xyijGG0tGp15Na0vnrmrW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:19:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1a58a555 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:54 +0000 (UTC)
Date: Fri, 17 May 2024 10:19:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/16] refs/files: use correct repository
Message-ID: <c1a2dc4e6923b660b05a4aea006fba0559da13ed.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r3rE6JZxlKkehirX"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--r3rE6JZxlKkehirX
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
index 62acd2721d..235c8580d1 100644
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


--r3rE6JZxlKkehirX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEwYACgkQVbJhu7ck
PpQujg/+Oah7K/wYweJeexNrn0ugoFPxPtJh51zje80FoIddwfEDdCDR1FfHVT+Y
FBay40nEmygNhOpZ20fqCP61giql8cMB9WIqWhmjVhX6XMkvG3CGtw1F+uf8w2Je
xNuczpsndr+0Pj08W5VeO0tLj7GavaHpf1mrgbBGJEHdFAJp18v1cwNEi5Y35LYI
CJOs8RG3Egk91IqgVYH+cvdaWAnZjoenzM9sbH1pfzbQzwqugzm2FMkHvaUAYLCH
/Pyw0SvusE/pIRHqdzMnmAz5f97zDZPZzIbqjmw9bPVnDsIXLvvMKlRgVXxaZRxD
aL57+OCzolQ/kPrYCvvvRklNKtSyzIUPsDX8g+mcKPcPaHp3gni7hG7CvopaJt0j
XOipr3fS7fvrdyRrK5CVo5FfgIqgTx6n1km5OzKEfbqD08RhIAFhwIrmDugtMuLM
t7VQ4YmANBJ83knBpUCbv7puKbu8d7HpnBFTdBpo0PfbUXj508yIwqj5N2sRpHa/
+LTLhy2QcZtD78KjZcomiUAK3KiZEYx+jnLJBf2xwQLmo+64BmNTQfgewAnJA3av
9V2aLaUE8d7jhZHi6QpJzrF7UmyIK+wdUL3PkgBc4qvIEDSGLxXgEiZs3zneMAtT
fnh5REQZXFrLhxpSSKcf4Bgp9CL2Tlh6XQDEpz01E3U1wDUzq9c=
=3j1n
-----END PGP SIGNATURE-----

--r3rE6JZxlKkehirX--
