Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137851016
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452737; cv=none; b=GZba6y58xKRKsN0hUKEtCxlGdKH1QwhGeTrkKqzW8G4x9hitwY5b+KFktL6Bsda2JGQYY/eKY4qQI5C9SsZvL0w+qEFgPhoWx4mRvMH7SMXYEnFtRC42slLBrAZ/RfDo1gapenTY3YwOLrhLcIOfeOOSQG+CCxMwbXJcMrJLRc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452737; c=relaxed/simple;
	bh=WUMcBdTptasiA453TUGGUssiVVD6W56UZGyX+GwlIxc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aeir1HNUJcHdINjpLGlMC82L98UDeLzPZ9KxiPWFtzSIXM/qiDemP9q/WJsS+ST0shwssnW6+kJdfjqPVteQlGeDBz9er8KGwDjisUvFItsuKT/jYOkfh7vQZNAMHC3MbUSGWU/Mg3fTvh3XhoL49E7D48c/TMSsY4IodM6Vuug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XbyBaA8t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j6eUxJ0Y; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XbyBaA8t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j6eUxJ0Y"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id D50F81C000FC
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:25:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 May 2024 04:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716452734; x=1716539134; bh=KHlJsPleOg
	z851XAB4dKFT0IPCvXhZJd5KiQsFbzuiQ=; b=XbyBaA8t0Z/qrhpZXaJ+5oLlx/
	6vMX7LilfxJgzXQGNlGM+T82uVWbzFFRtD33q71Z876cIG+UWxs/3n44aMEVpcBx
	zFqyChR/sTjYdnamlkDuFpIgOXFRDEXlfK2NzjKHq6/JLbmidzmSLyb4U8rzzurD
	8du0McttuhINyWUjVlsTvJfyMwcZBMB/6xX678lY9aFhJ8QI/wCljOKlL1+nUdMf
	AhD7WBFbp7EEZgbSpB3YsfA1lQK508+M29LkNdxofFsfZHiFp8PNE7Aj6F3eJ/lL
	YYDvciI5a5ok1ms8Hv5C33kfi9cmiaMfQO/2TVGd/McvN85635bkKmFbYnUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716452734; x=1716539134; bh=KHlJsPleOgz851XAB4dKFT0IPCvX
	hZJd5KiQsFbzuiQ=; b=j6eUxJ0YKWWi2SGsI/EN4GN2OhtndPEyq07A157v1nAL
	cRQJEbud4CFdOycR7yf/1q9i/zH1y/42OjSbe0AQbemp1jYb0Wb7TiW7frm2/nST
	J5n+fP887jEnkekB9q7k4LrMc5V7EEO1alyMJvWtFuRmLyiWSE+OKwkdxVg6F2gV
	Y5Mm+VEynMXIUu8oLi3IEw3+yYGZuMeVvAaXEIqVvfjpFXKFZQVNGAkUxWr/PkPA
	Q48HhnSpL0I1F1VvF/QzSSJNMmtdMlDPNg29jhaVuM6sLXN+Or8WO7HTHQtT8s4i
	mJw3IHeLzXjnQqAAyTkVbCKnQvpQB8fZogcJohsehQ==
X-ME-Sender: <xms:fv1OZhK72D1YNTfzXS_sIWN_3aJD-GDR9plByvrLUEOdhOxVNtOUkQ>
    <xme:fv1OZtLu52XHhYAliIEtUixhYn-yj_d5JhmgART6je3i4YuwHesegsnlsmPz6mheS
    IuSMp29RlTGQ2qarQ>
X-ME-Received: <xmr:fv1OZpuzSQHa1w6tZ9-s1JNDQz79fNmPYAU_VTessQwYghqxY8MgONInHOM0kuu3S5SSecezfIuXMEHmDHB3JTr6I2phsjg2X_mDFN5AOcIbumMCFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:fv1OZiYnhgUsZPEBjxP2KBcfNb6oW8X3ccDe0XFfmcom3FcZnu3yOQ>
    <xmx:fv1OZoaTlihiojz9-qLRzRSxCPvfepJOlCc-9M-TYHEfyQCYEHbgBg>
    <xmx:fv1OZmDQFUUQcGpmrwT59sZGcufBOkLzoMtsNYbiw9jYfMn5YZKkzw>
    <xmx:fv1OZmaKnc7RBVgKAWlfgjfNhtgdkIkakppliIRSqhmaZ6mPtFFWLA>
    <xmx:fv1OZjyxcGZdH0ri5yQWgLooGm2JbkDaScD5YmQFdaM3FePe4EELaJzq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 04:25:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f7491a40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 08:25:27 +0000 (UTC)
Date: Thu, 23 May 2024 10:25:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/9] refs: allow to skip creation of reflog entries
Message-ID: <03f4ac6ee7143f6b38e1eb95fb139c8e454136f5.1716451672.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GfpuGO8clzrJ7ayd"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--GfpuGO8clzrJ7ayd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ref backends do not have any way to disable the creation of reflog
entries. This will be required for upcoming ref format migration logic
so that we do not create any entries that didn't exist in the original
ref database.

Provide a new `REF_SKIP_CREATE_REFLOG` flag that allows the caller to
disable reflog entry creation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                    | 6 ++++++
 refs.h                    | 8 +++++++-
 refs/files-backend.c      | 4 ++++
 refs/reftable-backend.c   | 3 ++-
 t/helper/test-ref-store.c | 1 +
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 7c3f4df457..66e9585767 100644
--- a/refs.c
+++ b/refs.c
@@ -1194,6 +1194,12 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
 {
 	assert(err);
=20
+	if ((flags & REF_FORCE_CREATE_REFLOG) &&
+	    (flags & REF_SKIP_CREATE_REFLOG)) {
+		strbuf_addstr(err, _("refusing to force and skip creation of reflog"));
+		return -1;
+	}
+
 	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
 	    ((new_oid && !is_null_oid(new_oid)) ?
 		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
diff --git a/refs.h b/refs.h
index a7afa9bede..50a2b3ab09 100644
--- a/refs.h
+++ b/refs.h
@@ -659,13 +659,19 @@ struct ref_transaction *ref_store_transaction_begin(s=
truct ref_store *refs,
  */
 #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
=20
+/*
+ * Skip creation of a reflog entry, even if it would have otherwise been
+ * created.
+ */
+#define REF_SKIP_CREATE_REFLOG (1 << 12)
+
 /*
  * Bitmask of all of the flags that are allowed to be passed in to
  * ref_transaction_update() and friends:
  */
 #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS                              =
    \
 	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION | \
-	 REF_SKIP_REFNAME_VERIFICATION)
+	 REF_SKIP_REFNAME_VERIFICATION | REF_SKIP_CREATE_REFLOG)
=20
 /*
  * Add a reference update to transaction. `new_oid` is the value that
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 73380d7e99..bd0d63bcba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1750,6 +1750,9 @@ static int files_log_ref_write(struct files_ref_store=
 *refs,
 {
 	int logfd, result;
=20
+	if (flags & REF_SKIP_CREATE_REFLOG)
+		return 0;
+
 	if (log_all_ref_updates =3D=3D LOG_REFS_UNSET)
 		log_all_ref_updates =3D is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_=
NORMAL;
=20
@@ -2251,6 +2254,7 @@ static int split_head_update(struct ref_update *updat=
e,
 	struct ref_update *new_update;
=20
 	if ((update->flags & REF_LOG_ONLY) ||
+	    (update->flags & REF_SKIP_CREATE_REFLOG) ||
 	    (update->flags & REF_IS_PRUNING) ||
 	    (update->flags & REF_UPDATE_VIA_HEAD))
 		return 0;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f6edfdf5b3..bffed9257f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1103,7 +1103,8 @@ static int write_transaction_table(struct reftable_wr=
iter *writer, void *cb_data
=20
 			if (ret)
 				goto done;
-		} else if (u->flags & REF_HAVE_NEW &&
+		} else if (!(u->flags & REF_SKIP_CREATE_REFLOG) &&
+			   (u->flags & REF_HAVE_NEW) &&
 			   (u->flags & REF_FORCE_CREATE_REFLOG ||
 			    should_write_log(&arg->refs->base, u->refname))) {
 			struct reftable_log_record *log;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index c9efd74c2b..ad24300170 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -126,6 +126,7 @@ static struct flag_definition transaction_flags[] =3D {
 	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
 	FLAG_DEF(REF_SKIP_OID_VERIFICATION),
 	FLAG_DEF(REF_SKIP_REFNAME_VERIFICATION),
+	FLAG_DEF(REF_SKIP_CREATE_REFLOG),
 	{ NULL, 0 }
 };
=20
--=20
2.45.1.216.g4365c6fcf9.dirty


--GfpuGO8clzrJ7ayd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO/XoACgkQVbJhu7ck
PpS/YA/9Em1Xxyi7p5GrcdJhqfdNWZFeRatPscshtbiTAT/MCGAZszILrATPJxNH
EYMmDnzeCNtYMpyHe2VWOddhNFVeQjeLnjB3g72IRNLxf6iIFlkZiSEXGt1dGR1t
9zXWDy3kCRoK9IEMkkiux7UjZTKs1+q/ThaJqei1hlDjWK94LoPkIpARiM8DppEE
EDbfp6RkqZLCH9Curo4AnitP1YxUXbnstutBmIOaW17xKGXZbWr9H+EkqRkySQNv
C9HMuW/6/XTLmbxynL5W5xOugxYmxwhlPdnu94Cy/xCjWG175QZzU5rIY1bFYjhG
Z9NSCWTzFDiKgpOgroJ4Kre4ILZfTB4LtLQUCWmnUkthHqgkNJr2wCdfj2n+bNex
+MC59Fqji2PLCKFlhD+Eau1UcXygdL39/4AwxIyD6HTOLM74ObGBYno51pDw0M9J
6Ts3Fh8AatdpRXFRIo6MyyGUpKH2HXYC/OG9ijUSDup9vH5Nfm4MrGp1xp50t8g1
CKRjJuSw21rA/38h2jxPbNMWtl7/VXfuy9tBOLNd570sl6FpfydM6I0yJPij/jqp
R9FRVO+rPd//FPqGUm6eIzHOuMWzGqzA6hYD5RhVeJagNzSGYfy5RGr1/XwXeLfz
aZti+24+J+JrbWKg7lmAj4NKLYQM1ZG8leEuBa5ljyH+oHjZaFs=
=9rLc
-----END PGP SIGNATURE-----

--GfpuGO8clzrJ7ayd--
