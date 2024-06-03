Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476285658
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408047; cv=none; b=lZwjoKtw7yGN8T/Ztqx82RTV05Imqr9C5DkDxichpsumSBGGE34sLYd8qywQLDi46X/sfxSl65jBpbKgoCFPX7UgKQ47+gWsgIu/yeS8g4ITZd4b0QwtGm5679l9ynhogBFl494f8GvJgELvYIQ3FozqGBTnn3bxK+NHv3DOrps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408047; c=relaxed/simple;
	bh=yuiiy+rF51KTa9vgryJS0fNA+IHLHDvhiIhdOFbV5uk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mziqQwkqlYRbBQwH5iabMtQCOHp79T+rIrSFMdvaxqwhrQm+GE/fXz8OCjvp6cQjMSd/FisdH4Ud7Gy+XAd65E1c1xEoG0RR/1HK2Usn3kv7a+GFE11n9zCS+99V6cat30mZcN+tBbbhviSOwIb0Vu0XmVjZwbd3c1jUyrfIyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M/lpm5h4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9qhVYNN; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M/lpm5h4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9qhVYNN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 50C891C000EF
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408044; x=1717494444; bh=BEeJxDyLJk
	fSd4ul8tWGHJe0QCyzmmMi6Hbn9OqFWKY=; b=M/lpm5h4qHK9pfS4YhJp6ybIDD
	8KneT/pdxe8WWeAMdPv1LZGgXufdoozAplfT9BX03fJ9zg9Kf7KxpJSrIQFJt30G
	MbWzr43qvqa18sa7zcpicSOHxGUHvJ5aytA/Ysk006Bumt5NaeH/iuO1CjLTtCMS
	6w3xXHRpuJogTdjg5WvPHp7G/44VHKYkgNd2JktXheNks5JmvOGu8ffE+rvoTJoA
	Ibebp7ZBRJGUkDEOrfWZgOtyJ4287ckTLBB3RQoSPb/dwtFzjiBFKZHpPS8Bgvx4
	B7/MxAo0JDUGQAjZBmsNtj6GOMyz0k9U4VIiVDuKWvCZCDtMsaURXSLnguTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408044; x=1717494444; bh=BEeJxDyLJkfSd4ul8tWGHJe0QCyz
	mmMi6Hbn9OqFWKY=; b=H9qhVYNN1866zGwg1ILt8iMWzDEWr5Ltw/Vd84k7Q0tz
	lIg5Rfqi8ol7xiLpMvTsM37PmDJIr4tkYaoz9kTbfZw9KsKPihwBBV9LRk1YYKqH
	YEcycIdVhVUvW/CXnMS3Fp+SLRWP/YnjG780ICnciJiXXC9Vrg0zIhgJkJg0c0WW
	ut7TCZpOGw9nQWJOwkTWBp/HpGKBsdu+04MQ9zjNGSOK9fEL/cgDIfd+8ef4eHX+
	GrQkHjFdGXXqJ0ebJZrGp82WZe+5ZE1c2HEi58EI+yMiSTHEE9dbnT0vGA4chSe4
	OwSj4IGWbM8NJvh04gcKgh41ugL74XQ8llEjl1ZVRg==
X-ME-Sender: <xms:LJFdZsrl8sSmeVsCK7WkY_u2xn5-wgM1ciVcP86Dj_7ldEvEB4EEJA>
    <xme:LJFdZipvDWBOCNO1aO-zXsYw1o16U35rej1RnAoOXeXcO6LD4JcZ9hFY0Ke-ZxeCR
    ZOvpSuJqEfYRkJJ4A>
X-ME-Received: <xmr:LJFdZhNpsNU5atDB2AY-5RuUO9Odmqa3sM_ryaOWyd-KdtHQxcU-nZlkgLLrNoBqo5mAEkVC5wNf28Nm8GgZCYBn4KNRkNWoWbMf6u4mLAb33mQl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LJFdZj476xbaCHrK0dYyXj5ynkVLmYL8PrlA_e7mdpssVPwB_1p7Yw>
    <xmx:LJFdZr6xzbYK8s-8yO1nuVH84-77sKhJ7Gw5-0XzXFEAup91uSzjOw>
    <xmx:LJFdZjj-U8NilGwzx9TIty9ea_FWTFvqrsUXE-J2YiQWDLyy2gPlMQ>
    <xmx:LJFdZl4fZ_-ZGdmnJmv8I-q41xs-7BI15kVzPZiQm39-1e2xXp_e0g>
    <xmx:LJFdZlQwazs3NKsLsu-twR12ukBvgmzxHRuN0KR3ZF7vv2NlvYj82AaR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cc385dc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:59 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/29] builtin/merge-recursive: fix leaking object ID bases
Message-ID: <5d9fb78e6394af7956b69ba46ea4975a99958900.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1O+Pj5jIZ0gcAMOt"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--1O+Pj5jIZ0gcAMOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `cmd_merge_recursive()` we have a static array of object ID bases
that we pass to `merge_recursive_generic()`. This interface is somewhat
weird though because the latter function accepts a pointer to a pointer
of object IDs, which requires us to allocate the object IDs on the heap.
And as we never free those object IDs, the end result is a leak.

While we can easily solve this leak by just freeing the respective
object IDs, the whole calling convention is somewhat weird. Instead,
refactor `merge_recursive_generic()` to accept a plain pointer to object
IDs so that we can avoid allocating them altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/am.c                              | 6 +++---
 builtin/merge-recursive.c                 | 6 ++----
 merge-recursive.c                         | 8 ++++----
 merge-recursive.h                         | 2 +-
 t/t6432-merge-recursive-space-options.sh  | 1 +
 t/t6434-merge-recursive-rename-options.sh | 1 +
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 36839029d2..4ba44e2d70 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1573,8 +1573,8 @@ static int build_fake_ancestor(const struct am_state =
*state, const char *index_f
  */
 static int fall_back_threeway(const struct am_state *state, const char *in=
dex_path)
 {
-	struct object_id orig_tree, their_tree, our_tree;
-	const struct object_id *bases[1] =3D { &orig_tree };
+	struct object_id their_tree, our_tree;
+	struct object_id bases[1] =3D { 0 };
 	struct merge_options o;
 	struct commit *result;
 	char *their_tree_name;
@@ -1588,7 +1588,7 @@ static int fall_back_threeway(const struct am_state *=
state, const char *index_pa
 	discard_index(the_repository->index);
 	read_index_from(the_repository->index, index_path, get_git_dir());
=20
-	if (write_index_as_tree(&orig_tree, the_repository->index, index_path, 0,=
 NULL))
+	if (write_index_as_tree(&bases[0], the_repository->index, index_path, 0, =
NULL))
 		return error(_("Repository lacks necessary blobs to fall back on 3-way m=
erge."));
=20
 	say(state, stdout, _("Using index info to reconstruct a base tree..."));
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index c2ce044a20..82bebea15b 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -23,7 +23,7 @@ static char *better_branch_name(const char *branch)
=20
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix UN=
USED)
 {
-	const struct object_id *bases[21];
+	struct object_id bases[21];
 	unsigned bases_count =3D 0;
 	int i, failed;
 	struct object_id h1, h2;
@@ -49,10 +49,8 @@ int cmd_merge_recursive(int argc, const char **argv, con=
st char *prefix UNUSED)
 			continue;
 		}
 		if (bases_count < ARRAY_SIZE(bases)-1) {
-			struct object_id *oid =3D xmalloc(sizeof(struct object_id));
-			if (repo_get_oid(the_repository, argv[i], oid))
+			if (repo_get_oid(the_repository, argv[i], &bases[bases_count++]))
 				die(_("could not parse object '%s'"), argv[i]);
-			bases[bases_count++] =3D oid;
 		}
 		else
 			warning(Q_("cannot handle more than %d base. "
diff --git a/merge-recursive.c b/merge-recursive.c
index 8c8e8b4868..eff73dac02 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3866,7 +3866,7 @@ int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
 			    int num_merge_bases,
-			    const struct object_id **merge_bases,
+			    const struct object_id *merge_bases,
 			    struct commit **result)
 {
 	int clean;
@@ -3879,10 +3879,10 @@ int merge_recursive_generic(struct merge_options *o=
pt,
 		int i;
 		for (i =3D 0; i < num_merge_bases; ++i) {
 			struct commit *base;
-			if (!(base =3D get_ref(opt->repo, merge_bases[i],
-					     oid_to_hex(merge_bases[i]))))
+			if (!(base =3D get_ref(opt->repo, &merge_bases[i],
+					     oid_to_hex(&merge_bases[i]))))
 				return err(opt, _("Could not parse object '%s'"),
-					   oid_to_hex(merge_bases[i]));
+					   oid_to_hex(&merge_bases[i]));
 			commit_list_insert(base, &ca);
 		}
 		if (num_merge_bases =3D=3D 1)
diff --git a/merge-recursive.h b/merge-recursive.h
index e67d38c303..839eb6436e 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -123,7 +123,7 @@ int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
 			    int num_merge_bases,
-			    const struct object_id **merge_bases,
+			    const struct object_id *merge_bases,
 			    struct commit **result);
=20
 #endif
diff --git a/t/t6432-merge-recursive-space-options.sh b/t/t6432-merge-recur=
sive-space-options.sh
index db4b77e63d..c93538b0c3 100755
--- a/t/t6432-merge-recursive-space-options.sh
+++ b/t/t6432-merge-recursive-space-options.sh
@@ -14,6 +14,7 @@ test_description=3D'merge-recursive space options
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=3D-b
diff --git a/t/t6434-merge-recursive-rename-options.sh b/t/t6434-merge-recu=
rsive-rename-options.sh
index a11707835b..df1d0c156c 100755
--- a/t/t6434-merge-recursive-rename-options.sh
+++ b/t/t6434-merge-recursive-rename-options.sh
@@ -29,6 +29,7 @@ mentions this in a different context).
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 get_expected_stages () {
--=20
2.45.1.410.g58bac47f8e.dirty


--1O+Pj5jIZ0gcAMOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkSgACgkQVbJhu7ck
PpSDfQ/7BhrzuSO7T24U/nzkiftFDd0Rh/VZ64NowFfs4kK64yaCRwJgO9UbvA6F
A03/OLk7XNgIIvVkhlg48gHojxhKrnjMn1Oo9QmwITP8B9gbcQ0nTJsbFjrKpdbr
DQ5ZSIcvE5wKgFD2Qmxe//MnF3N24QEuH4yNLVMZnvPjsK5aihdLfXV0U4ClX6Ru
8m+g/liSxTTq+LvuoxB2YpOUf+h6S1GrCWiFBlYQ4d/1AuKM65OALPhOh4lSnlNa
Ch/mBTsWaAEB1Xb8LMcAvyRWYDfaZkd0QsdbuLAu4SXezkXU94b3JrJaizj4UB7C
R/wwE4CIjhH3BKrrhgfzB9B98ocyKRR5JeLWPxrDHucW8oRvOIR6c6CqobKigwaq
uu55y5rdT9ZnJNt/4YM87IOdJLNclYNqGVzTcf8ngfISFoCGptXcrhbvVlvqggof
zd3dpDM5aM+1SHEACzcuFlHYQd7XatCCD+NnCEubfk2idLczAoe1nrxsPUZ696iB
9RLWXSEb7AXZYFBqUdf3Qv4LQlhTZgaOBbEJbtflovw6eo/GnmdT0udFYrRVUAmG
FF4PeTNgU0zJI4z1gd0mYMbdsbKz0eKPUZgsAftj6wVFtNzxtRVznaJgVK5/k/WC
V1zgJridOmQm8fCK352HYt4ef5V8kJmr9tycliGmat1Lik99AqQ=
=eXR8
-----END PGP SIGNATURE-----

--1O+Pj5jIZ0gcAMOt--
