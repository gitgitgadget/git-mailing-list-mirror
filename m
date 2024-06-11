Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C5176ACC
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107095; cv=none; b=b6xxaVpox3M/XU7tFWk//9wC947LXPUk106eKiZrRJI/PHIoTmeJtBgS+rDsR3fm7Wb+4QPwuoQ6QLC/5j2G1CIATy3AAn7BPdjbiIlAvBIoT6mOzB+YQO5noy1h7/kaX9lUXfImaNsNV2Wu48LCb1PJjaZuM2vOfQG9TG+52n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107095; c=relaxed/simple;
	bh=MwReKTs8T4IIB8SoUisImpdqJJcA9j12p3C00zrZECY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1WHJeZF95s+8KzmTKUteUEyInwk9JDZ6DT43x1zHLLoASKiVpqEN9ukvbe66mukgaEVRg9Lq800+mlceb4ceX2ZGk/BJR/bmK9QDCQT//kgPLrqTE6+Fng6WS+Khmco06+Qa3ekxmX+MupLnrqWkUsxv4YncIYV5hTkdV+t1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S/zJjC2x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uk86nYD+; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S/zJjC2x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uk86nYD+"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 559DE1C000E6
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Jun 2024 07:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107092; x=1718193492; bh=nyOUbk7N58
	u4YmBfCK6E69mfNUVMdfWjB3kfwh0aIgQ=; b=S/zJjC2xcOCz2l8gLL/nnaYycU
	Xw0sq7TV1jXbY0AHXqRXlRe9+6GaoAHTjUbT6wyNWmRErMpgHMcloedXelh5YC+e
	0Unx82FuB+S88oiFYx5wrdGAO9vB490XiddWogrRfwAxmZFK0EkNJEyJFuOJA2Vx
	UbMFKRRFkcv71f1f4cwXTA1dGk+29Jv/fubnDjdFDxgGg/Cw2xX/1ZhC9qcRicRV
	c0VYNzFJfUcjpHEz0Ajolo0CmDk1Kv656SX5u4zJgWmOK00vRDkqhmkWimeXhCKb
	NkjxSzo7So3CV95TYf/DF0cLC5gV6t9tTl3aB53cIRuPiJoaqo0wx1tYwG9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107092; x=1718193492; bh=nyOUbk7N58u4YmBfCK6E69mfNUVM
	dfWjB3kfwh0aIgQ=; b=Uk86nYD+4y/wjugRoyKHzY6kTuqeidv3mOUoTP95zo5V
	ZRqSrT2NA5rRKqwUQAP9dBJYk6NalJnG6ehT1E5fFfqIEzeeZWI8P96W4vN0Zmto
	SdLGZr/TSRaL0pHLJyQHU4AohFFFATxy3roN/fVNMN+uiDKfUDnWVqaXnNpLuN5c
	hvdvxvXjWfM17qJP6dcSVJDsvWk+68LUHKbkLx0pwYPS+tnqFwBQVytPXmqae+ho
	j/cNwHV3DvmS14+xw7JiU9pCXOHrG2c1zMyennOnU2Cih7xVF6ZWaRrb73MP02pV
	hWhXbdyPqyw63+d9cfzMrPIZTZJtKHL3gmfMetHoMA==
X-ME-Sender: <xms:1DtoZsgIIzzGvNEeOZalcN8qR6O9cfYB0jQB0-IEmXRlV5MY2bevCw>
    <xme:1DtoZlCJJOUtyj_LlTxqPYNNYn50lsIi4sRjdWuIswQhuL30cKJO8GzEBonjo56WE
    GT_DZ3QQIe7wIBxag>
X-ME-Received: <xmr:1DtoZkGvDFFZToc8QwEldJ_7WaA0TkX6FqygjMGDau4HAT-mhcxe40Wne9Hsxf-MxbBTOMa0WXcThiRhhpdUV9HzNhXQTfCTyIqjbdqgl6LmimWd0sAr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:1DtoZtRwqhqKwwV1S4zYNYw3rpS4600h0Hollphl5omIfFd1qNTZSw>
    <xmx:1DtoZpxGpJOugKdYjN0fM7kROZ_Lgq5FFWTp-1y35nqJyCECSMb2IA>
    <xmx:1DtoZr7UGFUXSyYxfz7oEronPhXiAFLb3I4LJcGzQ287ZZNVClnpsQ>
    <xmx:1DtoZmzaeuAV6POC5uyL3kcmrKlDRhOgobcXzMCVIvPk8zI95KJPgg>
    <xmx:1DtoZqpCB2LouJ1H6Tz5O-g2aCRqa-ybFwPCoFNc3cXsmQDyO-OHJDzs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5d7d7251 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:03 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/21] hash: require hash algorithm in `empty_tree_oid_hex()`
Message-ID: <3f091dd94abaea467f87408884b9e6fbda71941a.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U7dLzX7CM98mGBf9"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--U7dLzX7CM98mGBf9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `empty_tree_oid_hex()` function use `the_repository` to derive the
hash function that shall be used. Require callers to pass in the hash
algorithm to get rid of this implicit dependency.

While at it, remove the unused `empty_blob_oid_hex()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.c      |  2 +-
 add-patch.c            |  2 +-
 builtin/merge.c        |  3 ++-
 builtin/receive-pack.c |  2 +-
 hash-ll.h              |  3 +--
 object-file.c          | 10 ++--------
 sequencer.c            |  2 +-
 submodule.c            |  6 +++---
 wt-status.c            |  4 ++--
 9 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index b5d6cd689a..a0961096cd 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -557,7 +557,7 @@ static int get_modified_files(struct repository *r,
 		s.skip_unseen =3D filter && i;
=20
 		opt.def =3D is_initial ?
-			empty_tree_oid_hex() : oid_to_hex(&head_oid);
+			empty_tree_oid_hex(the_repository->hash_algo) : oid_to_hex(&head_oid);
=20
 		repo_init_revisions(r, &rev, NULL);
 		setup_revisions(0, NULL, &rev, &opt);
diff --git a/add-patch.c b/add-patch.c
index 814de57c4a..86181770f2 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -420,7 +420,7 @@ static int parse_diff(struct add_p_state *s, const stru=
ct pathspec *ps)
 			    /* could be on an unborn branch */
 			    !strcmp("HEAD", s->revision) &&
 			    repo_get_oid(the_repository, "HEAD", &oid) ?
-			    empty_tree_oid_hex() : s->revision);
+			    empty_tree_oid_hex(the_repository->hash_algo) : s->revision);
 	}
 	color_arg_index =3D args.nr;
 	/* Use `--no-color` explicitly, just in case `diff.color =3D always`. */
diff --git a/builtin/merge.c b/builtin/merge.c
index abe66311c7..bb94b7df21 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -330,7 +330,8 @@ static void read_empty(const struct object_id *oid)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
-	strvec_pushl(&cmd.args, "read-tree", "-m", "-u", empty_tree_oid_hex(),
+	strvec_pushl(&cmd.args, "read-tree", "-m", "-u",
+		     empty_tree_oid_hex(the_repository->hash_algo),
 		     oid_to_hex(oid), NULL);
 	cmd.git_cmd =3D 1;
=20
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index aa5ba27d17..41d5fb8e60 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1371,7 +1371,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	strvec_pushl(&child.args, "diff-index", "--quiet", "--cached",
 		     "--ignore-submodules",
 		     /* diff-index with either HEAD or an empty tree */
-		     head_has_history() ? "HEAD" : empty_tree_oid_hex(),
+		     head_has_history() ? "HEAD" : empty_tree_oid_hex(the_repository->ha=
sh_algo),
 		     "--", NULL);
 	strvec_pushv(&child.env, env->v);
 	child.no_stdin =3D 1;
diff --git a/hash-ll.h b/hash-ll.h
index 1000a9af22..3161c778b9 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -347,8 +347,7 @@ static inline int is_null_oid(const struct object_id *o=
id)
 	return !memcmp(oid->hash, null_hash, GIT_MAX_RAWSZ);
 }
=20
-const char *empty_tree_oid_hex(void);
-const char *empty_blob_oid_hex(void);
+const char *empty_tree_oid_hex(const struct git_hash_algo *algop);
=20
 static inline int is_empty_blob_oid(const struct object_id *oid,
 				    const struct git_hash_algo *algop)
diff --git a/object-file.c b/object-file.c
index bb97f8a809..72318c8dd4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -227,16 +227,10 @@ const struct object_id *null_oid(void)
 	return the_hash_algo->null_oid;
 }
=20
-const char *empty_tree_oid_hex(void)
+const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
 {
 	static char buf[GIT_MAX_HEXSZ + 1];
-	return oid_to_hex_r(buf, the_hash_algo->empty_tree);
-}
-
-const char *empty_blob_oid_hex(void)
-{
-	static char buf[GIT_MAX_HEXSZ + 1];
-	return oid_to_hex_r(buf, the_hash_algo->empty_blob);
+	return oid_to_hex_r(buf, algop->empty_tree);
 }
=20
 int hash_algo_by_name(const char *name)
diff --git a/sequencer.c b/sequencer.c
index 68d62a12ff..823691e379 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2263,7 +2263,7 @@ static int do_pick_commit(struct repository *r,
 			unborn =3D 1;
 		} else if (unborn)
 			oidcpy(&head, the_hash_algo->empty_tree);
-		if (index_differs_from(r, unborn ? empty_tree_oid_hex() : "HEAD",
+		if (index_differs_from(r, unborn ? empty_tree_oid_hex(the_repository->ha=
sh_algo) : "HEAD",
 				       NULL, 0))
 			return error_dirty_index(r, opts);
 	}
diff --git a/submodule.c b/submodule.c
index 759cf1e1cd..caf3aa5600 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2119,7 +2119,7 @@ static void submodule_reset_index(const char *path, c=
onst char *super_prefix)
 	strvec_pushf(&cp.args, "--super-prefix=3D%s%s/",
 		     (super_prefix ? super_prefix : ""), path);
=20
-	strvec_push(&cp.args, empty_tree_oid_hex());
+	strvec_push(&cp.args, empty_tree_oid_hex(the_repository->hash_algo));
=20
 	if (run_command(&cp))
 		die(_("could not reset submodule index"));
@@ -2229,9 +2229,9 @@ int submodule_move_head(const char *path, const char =
*super_prefix,
 		strvec_push(&cp.args, "-m");
=20
 	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
-		strvec_push(&cp.args, old_head ? old_head : empty_tree_oid_hex());
+		strvec_push(&cp.args, old_head ? old_head : empty_tree_oid_hex(the_repos=
itory->hash_algo));
=20
-	strvec_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
+	strvec_push(&cp.args, new_head ? new_head : empty_tree_oid_hex(the_reposi=
tory->hash_algo));
=20
 	if (run_command(&cp)) {
 		ret =3D error(_("Submodule '%s' could not be updated."), path);
diff --git a/wt-status.c b/wt-status.c
index ff4be071ca..5051f5e599 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -641,7 +641,7 @@ static void wt_status_collect_changes_index(struct wt_s=
tatus *s)
=20
 	repo_init_revisions(s->repo, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
-	opt.def =3D s->is_initial ? empty_tree_oid_hex() : s->reference;
+	opt.def =3D s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo)=
 : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
=20
 	rev.diffopt.flags.override_submodule_config =3D 1;
@@ -1136,7 +1136,7 @@ static void wt_longstatus_print_verbose(struct wt_sta=
tus *s)
 	rev.diffopt.ita_invisible_in_index =3D 1;
=20
 	memset(&opt, 0, sizeof(opt));
-	opt.def =3D s->is_initial ? empty_tree_oid_hex() : s->reference;
+	opt.def =3D s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo)=
 : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
=20
 	rev.diffopt.output_format |=3D DIFF_FORMAT_PATCH;
--=20
2.45.2.436.gcd77e87115.dirty


--U7dLzX7CM98mGBf9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO9EACgkQVbJhu7ck
PpSVAg/3TyztQGJHj4ANVCOUL84QSscjpfwuwRKNJAqA63ROKzPf8vRxdzLnRWbz
jqNCCOcbvNhCzH+UWd3UE35aQnY0yGTeN4VEZjogONxVb6nV4S5IPwJdZHfCxCrg
IVTl799cijhhsLq0FVJxiSJiPvcDMG85pLUV9Uz/KAKw7FG7hCr6YvGMsRJwuYBY
Ak7nhKmNiN+IBYQbtvU6PcVLeKpUUsA2GNzMLVqE03PoyftaS5c+uWlxS3ZhrbIA
ocLbzzW9pY24d4WxyVFqc+R/1mLwAzDPCa95ZjueQFChIdYDWQ1OlhpFMhMuJOop
ajywCfS3WbL8GMxJmjj01SS6ib6ym393bVoQtmgjm0zSh5s8ttFLaFLygalpllWJ
FUgafKRJFHv7bceqzzuqBrGfJNb8c3z2f4jN6qzF9/G59X/NR94EoT9aF9FDWtQM
/QoMp/4gd3+SoIT0Lh/jUvUB/2TqZyqvMUASanOZxtwwrrt6BazqiY6+KX8ve+U1
HCFYm3bvoaMuhOHtt49E/vVjarYlkqOw37mnbu9SX9rIkxVmbjgDOvzsEZHOXxK3
jjGnyluotNaQBeyWlqhbUbsXpcx0X+RAQIo5IGy4u5wjmdF6VmzUMzcQO1JSp+q0
q316OyOGXHhKXzto5CNZwFLM/ESXKpSvevo7CtbO/AaYfZ3Fmg==
=pWl1
-----END PGP SIGNATURE-----

--U7dLzX7CM98mGBf9--
