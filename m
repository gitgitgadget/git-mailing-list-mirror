Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBBA1474C0
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347824; cv=none; b=IysxB3vRSI0dMY5StCSFBWTE1IZrnAdpwhO1VXiWftF7xu2MZ9nn1mFXPJjMchWRNZRt5AV9unKE/z+FV2SZoSi/fAadKNU6HxwwFW0v5i55i/PpWGMMtfJ0B0cOOQDQobJJ3y6IcTJDOTZ/E6KaQX1h/07UnsL68lKmKBAE74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347824; c=relaxed/simple;
	bh=KhrbSF6tALB0eWJaorm8z2mTgzIXAEVrFsZi158D9gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtqduaDo+tH8tUpbWhbxuAu6769L/SmALDZmwuug9XLfTqw8W4hgBLclLBRfTIbR9PTvvejkvx4cowLk3eTc5wjnVEku/kb7YbK4AVSs40rymxb1KEjonhvJbt65A0jjCVli6segYSJ0IvQPhH/pgn5znraFTTGx7+2EwrQsdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bxDFG9xU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=clXwyJPI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bxDFG9xU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="clXwyJPI"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2EC851140258;
	Fri, 14 Jun 2024 02:50:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 14 Jun 2024 02:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347822; x=1718434222; bh=dDLDGE9ene
	G/uzFh7uAhSijALQOVqZ0HOIilqzohXrk=; b=bxDFG9xUqaYDosQmFM336Opc5a
	UWBhQCVv1cNrwL/fAHMJQ8CwdsSqp59Un+BXhiuPcI4pOz2K7c+rkzMHOc68/483
	U4WzLyIdFolk6RtmS2aP6DSt4Bnvb5kGcqbGsB+OP483Dn1SNQhKjNMwqah0xI+n
	vx74w+WX07LZb5PR7TEW6EiKwOgdzP/lBIo02z09Pbzj500wjheTJGxqmC/liApU
	kozUpniGbngGdL3lwQ6/DpXeyOgBrlG+0u5CqGDLYrnIsEovqY57zGGW9+/Qo96a
	iIQssoxDYL2xn3FdgklmjE4CiCqmeo7iTzhJn2mf8mzh6aK93u0xpoFYNE0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347822; x=1718434222; bh=dDLDGE9eneG/uzFh7uAhSijALQOV
	qZ0HOIilqzohXrk=; b=clXwyJPI8bSRPdYJbfMMusMju80MFl62Z6knJPJoT1jb
	JRWHPf0ItHXEtumelJtFsJ31mVSgILsr/8ISAjG6+Q3YfYsQIPywsRDu+E0YrFI4
	NVRIZFPWgE4wr5jLUf1Oo3FKTPMO7rQEgRbrrPBpGUmM+k/BxWAvJ8aa1yqcdR3f
	fLnni5P6bg0i654FOImC/IlDH/qXiNl8InpdXI32x/0iwDJ/3NSbPgZ+oslYFWii
	yMK8LxK86pZRhjzSk/vAxs0wCaDKMuZ4dF0PbMUH3xoAVXdAXfE9Z8RYyj6rldys
	Uw4flZlbeB6MHuAWHryaNgUyPtrsq0ARfc6zsnjVSg==
X-ME-Sender: <xms:LehrZsh8oEmiXaiDNdsVWqykMtkMAmFzM19hIfundhCgp9E9mzT0PQ>
    <xme:LehrZlDtxkmUkqwMPFtKQcqLxJxIzUnRchSDsfgWARSor4b3fSjN0Fs-J6BSTPG1q
    Z3TCCH5z3IABVdR7g>
X-ME-Received: <xmr:LehrZkFDCUDhpjl5JZOC1WkzotNiXYFidTshoqf5CepqJEIhN-MBeZgzxBo9wLYD55Zn6at9aSzc-HoCJJcOb0I2-sFeWe79H1k9a2PNXMYgMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:LuhrZtR0LTm2BL0l4AUZOdu7SZEhCPzM403VEwunRU1H7mFjagIHCw>
    <xmx:LuhrZpz6BPef6E1vFRu3Ku2ULvdYbSLjKCwFiIZGOiJgHj3nAxCF4g>
    <xmx:LuhrZr54_XaPUq96koUKYr3CdgP2NtYvB8YDYoClnU2_wLcxTzRU_g>
    <xmx:LuhrZmyuLOpT6Hdjd43vOt4gWqS9bJkT469LKDQaCexw_cN1ItxvFg>
    <xmx:LuhrZsoNl8juw7TUppMmXWKFNG4gZeQmR1DzlN_cxBFm06d3vP9CRNFN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 065d9c32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:05 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/20] hash: require hash algorithm in
 `empty_tree_oid_hex()`
Message-ID: <1cf25bec3eef9f590abc7ae2a84845a8312e9a4b.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S8x4K9OMqE/QUY8H"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--S8x4K9OMqE/QUY8H
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
2.45.2.457.g8d94cfb545.dirty


--S8x4K9OMqE/QUY8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6CkACgkQVbJhu7ck
PpSK1Q//f2DTfzIO2BswMnM/nlr2T0aeIbpUiZ+a2R1maeWQbvPVDzJT2bGCXdsy
3tcju/yhnQk0CMDp3IoAOQLYgfj+CFxXM0s7VeL0y72byTWzy45/Qt1iwJNnNyWh
BVhi3oV7GHm/oxN+N5yFOIHO7ceow0JHj5UHMsnK9fkuT7SPsiKZL3Sv3A0H4yuc
EKHQwbuON9oKbf1MnvMg5ziwECY9z8zf7UwFSUmCj81BBxXpKTD23kq3gu48RgFc
9r5f6CBdIqEJtjLBH167Ryv6jfKiNmeqnV++lgOcYpvURSLdBqsV/zXORd77qG+v
T6LYiqNZIMS/JfgQFjnfkCO9xmU7R2Uz9aJraRg+jbtAoVgAr18P9aWctBruGNiy
46yzCL5G8q1bDuv3DyRNTG5qn+4kYocpFLTp60SUpx+W+HW+5CmqMAxcQQNONazf
FS3Mdc6WnzNUVvbsPAlp6Y3+YgVjN1Vvxz4bkLTQlPRFJkDvYkMQ0UCAqZaadCbx
sEk9krKpUQcVU6imUydiUzNe0AxI6hLZbC+YowENZ3E8HVgz98bGGSlsH57FGAv3
qiwx51H7/9/+W3BkWtQY/L0C5pjPzSYFVYRVx47cjOm14M7CHMnt9k9gZpIm2aOn
e5zzTE7nmjRwyuk2Dyg7ziqVaRs1x5qRMqEw2diNOzb6onJxTCw=
=L8P+
-----END PGP SIGNATURE-----

--S8x4K9OMqE/QUY8H--
