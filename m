Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3336117B50C
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097615; cv=none; b=t1jAWi/+QEwiJ9Ijt024h2z2oMWe42wOdj6Iev7u3Hc6wp0taqQJqaVdci+s+fA7Mf31h4SKDBxedGAxnsXxPdDlXP3iB8BV0u7NPzyTe7RtuyGdHZ61TS3Ew7k5wyczYnWk8oXRmpFml50tXiaUtgrSM1FP6t/rVbttVqTAUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097615; c=relaxed/simple;
	bh=upXq0FggX+ecLsfM5aXtv7wbQLrXKp+DZS9mOLzFmko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0rbjVG3x2UNQCdKMHVukakS/y7apxO9qjn6rVFm1QEOFgN/xUkUksOLMRRtStLrOL5e8sxZrXQbuFMEPI7BYOVCD36fIqraheT01mZHMXAXaDGRsxEwblt4xbRsh6l/fde424hIrn39Eu4fpqOkT+syrytKG/a0gHC/3WGRKY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XOBRovAE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J50z3jQF; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XOBRovAE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J50z3jQF"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 59D471C00124;
	Tue, 11 Jun 2024 05:20:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Jun 2024 05:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097612; x=1718184012; bh=CPRZxtwj/Q
	VoORkTq08HOobn6nZ5fI0ejkicoSqbcg8=; b=XOBRovAEKB2dJFUUB8CdOFCwiA
	wxyljJdbPnkj7qBsSY2hFFP8v/yYA/9Gb0kpCXzTylYbkuvPFq/kBCvcCTAExBgQ
	fPBssvTyBj67c9Wf+CvuLLtObCHP8N7mzphNdcQ6bdlY5KXOenPqjfjfyfLcTNLc
	Gg9RCd+hC3D+qKb7Dya4DncR5GoYNVzznTW7Pn5vQlUJMZAHQ2kARYcvtRYxFxIg
	yE+3bwATkdV5H7ZxibhJKOhEk1v9vBMcrhSlrBmUmPBLrZsEUnER3vGIevdG5mnX
	JJD0OkFPy7P39wLvTGK/8HoENz3n5GPsluMvNjvyIciMu0mBR6ukRrRrS+Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097612; x=1718184012; bh=CPRZxtwj/QVoORkTq08HOobn6nZ5
	fI0ejkicoSqbcg8=; b=J50z3jQF+kJlskfa6oKNN+ytKjcZHHNVr82ilOksqInw
	qZ+bz8C2zqh1lbW5bhXLR0SniFvz1DxGobucPyPuNQbaNknX4o/6jhoAeeaaiAiu
	ag+ASishRy0Y3/oAOCZnW7ou8/yTn0A16790gqwXIbmQKwYPP94oMhPUDeiuxXvr
	14xFnZruslswN5zXFwQDbFbKEccG3qe4rqqZFsQX/dSox5fJT1dPbU1doCjU0+P/
	q7z7s/+SkpaVf9gB/R29KdKqy0YgflPyYJrQpvEojehOWqUBtZTH97GBkGpr8AxX
	zPHWq/RlWlNbqs0GQA23gEOc/tVav4itC1JAB/ArRw==
X-ME-Sender: <xms:zBZoZpE3aikPn-bH7WrByMxaeItlqDHEhgnBbwqLn55aqQwSjWIVaA>
    <xme:zBZoZuUKyE--seYR10j1jAprknEmaYLjD4d3MrbQCBP1ejSIFSfqm37I5QwqqynlN
    c6rJXjKNCK8ntObUQ>
X-ME-Received: <xmr:zBZoZrK5ckrCZAf2cDlY902NeeGPY9C2qtPn5VF__5E1y4I2XLOFIBoJvauMtoJNjvzl1ZT8-4yAnQ8h8kFwOLjYwBOsA0lcjsyKTfC4u_KC_7u0wqkO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zBZoZvFoqpbhwYCBFZNSTc3BqU5d7WIDzuAf3fbAmpy77DXeYYf8mw>
    <xmx:zBZoZvX4Rjk_Fw-GvHQ3dgNMmgKcy0rz6GcBsR4xgeFEcG_cqGQdhg>
    <xmx:zBZoZqO6pp_JOzDLZvBsNpqlsmTZomjwgZcOGl2KAW3Kj0cg8IwmdA>
    <xmx:zBZoZu16jaDm4jy3NXz7sQK0wWKolNdhZJPRaznDFjyg5PUiDtcj3Q>
    <xmx:zBZoZqSxoD7KCYawC5hr9bGZGciYV3hbjUNONVD_Kt9BziU8jhr2dVUH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4d86654c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:02 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 12/29] builtin/merge-recursive: fix leaking object ID bases
Message-ID: <fb30a254abaf132aa3e44b1edea927cf91e1d86f.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P0nrNcNsUzytPhYm"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--P0nrNcNsUzytPhYm
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
2.45.2.436.gcd77e87115.dirty


--P0nrNcNsUzytPhYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFsgACgkQVbJhu7ck
PpRJMA//W+2cqWMQFxcWiDYdfkoaKTHUQkvP1moKx6SGEmtto/ieffei3UUtnHDg
tCwM5jIkIjnop5goBNmS4KJsJxkMxZVKchwyqKgcb4FSpI4kT+vNWlRaiAecdmxQ
F9xKdXHYt0k6hZo3UXJ/EqC6ZJI/8ggDxNzzpt3giBOwsJEiGfckUtgfp+AzNq3s
fF4eq0Ci/iBTLoTeYuKEH0kfFKJ2IeUU4MtAAHF0l2LtyD0AOlc1vrGA3cZ3ZFic
GVCyvTuiz3RwB5Yk5yMt9AfoKlPo3Q1/gfn8Jx61y2VjPWgmC0Sm8v0lqCB0UfZo
qgxG9rGwreJxaZod2r1CmYmX5VewxtHwYShUxSp3ImnvkbfFXdEwo5FCgu7gBI4G
JAKJoRdQWbur0wNld9wcAsSWuGmsmQGqL+R2PXYEsFvBDhOIX4o2CISK9W5FvhR3
6fgj808glNrUQ75dUAt4VZ+lJhH8oiFu0iCXwNdGo/9aZwdzUiobKJroPUVPs7Za
lwkA5touwq4Q5TCeC22yFKQkaIZekfVFzYFd42Y6qc7nfhN54G+9W8v13xtR8sMo
fYpWbF4y9rHCVcs2tldJZ5DuPcEiPqT4FBxLUwh4cpGqEppnTCmLQaEF8p7E6lei
nkcmsjSfOjAlYjURXoWMpYBIRCTNxvQlbfk09GDN6AtgJwwifSM=
=4TQT
-----END PGP SIGNATURE-----

--P0nrNcNsUzytPhYm--
