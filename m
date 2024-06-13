Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D6137901
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259246; cv=none; b=JSs1m8weKUgG00SF+LK3nvWNesStPIlxM7ggKbzymsvUQFrhuRlW+VTuI8q4pMSR7EKjtC4fh/XplrdNCN7kzO7Jjyug6A6uTh1G0qSzBAM1lVqwLbX9j1tQmmIaqmgCxQjUk88cyrSGWalUb4bbDa1uuJ2Fh7otoVeSPZCZeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259246; c=relaxed/simple;
	bh=AUkrV8cmwIem/g6/30Vck+0PICB/ijQprNDKAt0NfoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBGcbll1jP9tsGbn8XIXy5JgnRu0yEszZC3numGmQcWh+CLHr79tNcFRk3OD6BPDnQKRGIHAdN0GRRp4VlJNUmsIjR/dQnqbLTIhiIHpppGUBA8gxzWmmpSTkGNGpc2WKypbUS3HNIbFhLxi/eyo8oD6i3ZP0Jz7MMx+4QtCzIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HwIepGal; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hqe9XFZI; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HwIepGal";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hqe9XFZI"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 54B5218000AC;
	Thu, 13 Jun 2024 02:14:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 Jun 2024 02:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259243; x=1718345643; bh=Zo9VrJAZqv
	yQiYaqCvKV6miLnMxA9YVCtsAPlTV1c/Q=; b=HwIepGalueqf/NnndsK8NHyPqA
	WROoPNYGp6Y0IrbLvDLp/oy+VdlUVxUk3GbLR4ZJT00Y1k26E0aP0WvPnzPCoiCO
	lXJAaZH8BXmaTaagTXI51SJZHpmmr2gUX//WxJlEojfrQtN5gPkbtkxcTBvXBCUi
	1f2ZGfNbXBGba846MUgLUWEu/R6jYz8D7kM842lC28Zx4Yz1xLXHh8yyczvr9VSo
	ihhTarvfJ+pldVKT6YzkZqho0FDzB44yYf85+VHSAaY9LL6fVBlMj+W/+U1m1V/8
	Mua24CGHz2hG/6fd2dNuQtjccEy4p3QM4PljV047TPBE+mWRpKFfVXIC2TjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259243; x=1718345643; bh=Zo9VrJAZqvyQiYaqCvKV6miLnMxA
	9YVCtsAPlTV1c/Q=; b=Hqe9XFZI+FXeASnzRNN1uTuRLD1jM54QaeHgd8yFc33g
	u92O/5lgXCGi4j+C18qVvdjkZIpQtC+bDh/WGf0pMM+FkOrdNSx/5FziO2SBchOJ
	vcWJK7JWDltCjYIwiwj7BsBnhTNE7VHY//ib5O5cVLO3MwPjSPSz2HxWGAn2Z5Z4
	UL8kCgTdzFAy1Q6098FaYoiVQxakLYRuWFEnJlKcPor5WqoD39XN9zmxbURF26lC
	GEvNvshmQ3XcgVTJR6iLmGeGY4iFSlYNRdkaNIXXr4wYk9e91iVbgHgQ3vfkwFj+
	8QVLABDzJP5uUf99JZbdKZVqVLNrUWBlANVxVkHy6A==
X-ME-Sender: <xms:K45qZlJgZ7TubpQ8ZYPFXF_51Vmn-AZO1Z01rC0pnK7Ftwl-v79q7Q>
    <xme:K45qZhLLG-BtSLQ4xhfwISTAiULLx5DuiF8Znn99bjUkGgAaSjIDHAWYeUjoQehtD
    -0rTSmpM6uWWvrgIQ>
X-ME-Received: <xmr:K45qZtv6PywIGk2nT_jSEH4SHBDHcdB_Hy0NPd_uwugzZXjkMSUdzUWRNUsLusG8IiNRX1uz1UVdH0Yb7FpeHOvWtVB41Jp8JTo8dhUasEzCv3znOtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:K45qZmb9ZcNsu7bzp9b8OJUdt9cPq_zBj5Wdy28jvjwWF1RWu0KReA>
    <xmx:K45qZsZMYh6JYbofClVFE8GPOGc1gQEeNFqKDwBHti5OZr52mhvJgg>
    <xmx:K45qZqAwQzx9Wn-KqRo974dMOaiB3y5tiiqNIMmvwiKXCDF_mMnzKQ>
    <xmx:K45qZqYFaQyRg_wSsShpRZ5DdhSPFgY4WagREn4bLEkeGUEmjjLwyw>
    <xmx:K45qZkEKpcwjJJZii1CWfK7aa1j_4EoucZ6tKXtuMI_P4OVGn7vci3PO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f7779475 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:13:49 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 08/20] hash: require hash algorithm in
 `empty_tree_oid_hex()`
Message-ID: <4858cca25fe9e57c984fc3181fe8498d0b7222b0.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NQyq38OyHlRhXY9r"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--NQyq38OyHlRhXY9r
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


--NQyq38OyHlRhXY9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjicACgkQVbJhu7ck
PpTMAA//Us3kVl76clrmXc72eadAoZXYK2AQRUnwu30grvo0P3bYYUNzMib0fTvE
DtN5SKXNGvvTJaqvxlWo6Y1NDGSQrOg5vAwtfJI5HXDAzPFzN4s6UrcnRLnhoELs
BOrC74kI9GSvy99o2NXrQw8pa+cfoYTtWGwIaBFl92I55rMprbgsu+LN4Bl9X0QB
rOin8WM9xqjaJX/FZnP0mJS8ku/KQyWr4//4ZoJOnW3qBAfT6uvVRuwmIzYyMyry
ljsqfV/IPvq9Sz90zmHKvE5q2VKMiuilaCEEM7TMdgIDzpBeSji4pmfyZMFB8hQa
i8nxrM7b8FugSEaXElskg32XEKGIFnhRplxVycAR+FBFT8APUG8AQEoW+TQuD8hu
EDLvoSkFLTXf/CSR0hKyhSBfYG+87cwB1vuU0vl2CVRfH2fOru7xoAs2Ra3DyXuo
xLMUfI98JxXaRYW2oS4GINYIiePdjnMipJVSvT2ed5DYp0V+RSnBd+qzlNSNMqd9
ZYio+8/FGiNHoB742KbrGIucDLWk1NUQxqoMFpUqmToeKmeV4M74TZBQlQKb0Ryo
zqeixeTs7LtZTKSBJTeye+I0vQbfCm1Rb6Jm0EY2ZZqDyPSOd/sAORSfGPeWILzf
tRhBhhPzWiUbk392u1XhFOKByOrKs+1jZ6naTS5j7qvQiecQ85s=
=sD3P
-----END PGP SIGNATURE-----

--NQyq38OyHlRhXY9r--
