Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A517B424
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996316; cv=none; b=l9qYje5h3VhcRRdnamufSEDbXILDU6Rf9iUF9juigi4gcWW/VBG/AYhLzttqTQnhWXr9oVr70hMt2RpwAacGbvlljj89JkgPgBTcL07s4WV3EKOX67TtIdC/Ld6bNupcdZ031aKmLNhl4ZXDqCpvb65hQdV3apBO2P5+v4CLK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996316; c=relaxed/simple;
	bh=Gx8tvAXvFncz9+cp9P9DSw79WyMamNxqcpyHmL49eg4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5xLNwXZ5hPdxoyXkD0LXAzK4bx92LgpKWWwIsTYp3X7FKIQprBC3xE6VdZnXv0ot2B/F9rUr3nZOhKG6fWDW1jE9NtG4v6tsIVhilsIz0QkL5cINrRDJBARbL78bc2Y+n8eRQ2elIEOMY3Ivc5Pcza1H0VYsI8PTLm4bU3QJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kbXtVVzB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lwoGAaA/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kbXtVVzB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lwoGAaA/"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6C8C213805F4
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:18:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 26 Jul 2024 08:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996314; x=1722082714; bh=wL+D0RVhQn
	yuTIhNTHmcvNKnOTeVtyC5PuFO7AVRZTk=; b=kbXtVVzBAvv0pJfmabkWiktk+f
	coBhUvs+vLpCZXdDh5zfWtFW3EdouVRMWhL2MfxFQNtctaccvjIojuKvRk3K5HlK
	mDdMOz2kt05SHQ/cbwVcatW/djM6TJybMLTbmoc6vaJohXBsUwjczFqPGfu//VRQ
	nHuIE2qKo9lmejQ9ODbkJSwgkim3pzB6CgH6zq+h0LJpKbqWPX0Mnh9os+28uHoY
	xvS6WHE5gLN/gTikSF9TiJNmt9rGNdaYwBedlxPE87lSt+sKxvwRenThS438Ot5D
	4N+/zmrAZJ7iicQ9y/IKxL/3zuBSipAkPXriQH/SXITYO8NF1N8D3P+n7uXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996314; x=1722082714; bh=wL+D0RVhQnyuTIhNTHmcvNKnOTeV
	tyC5PuFO7AVRZTk=; b=lwoGAaA/4CiCBxlM/8tmAOPj1lLzHWsK+6z0zwyF4AiN
	64LRz+YuGyBW9w2DzLMNdiIpG9gtr/MAqdWzBfxFkt4k4K4AMshELRYJAQeHJn43
	nRmel26laGDaqd+pwgf+I0TIXUoJ3ocNA11ZbDmJMu5wp5S/qa3ghCHE+ghCjrSC
	oz3gjRu7j5lGXSvoVwtoxJUrRYHWiKnJhqWuzkJ8Do39D7J5KDFmgD2nLhvwMpbI
	uV1Bd3WPFbcc1QZ+Ip6JEt9hmUq7Nqn6zbdNn0UpRNoeModI+z4flG2t1g9aVgD5
	fEr6dpX7Mn5NcI9GGBdXI9SWklBAs5W6KymjCKihMA==
X-ME-Sender: <xms:GpSjZgqKWrdSfr6LcUOucCRubrqfTrnExpx_f_x3TqyQYeXOpbSN2Q>
    <xme:GpSjZmrev54toN9Tv9_ivk1zRK39X6wPxZmSEDu1ceFvqzblZp6YKsAmzmnRbBaIC
    kxw59VvD6IIUuiX4Q>
X-ME-Received: <xmr:GpSjZlNHneY84C9PdH0XZGUH6PvI-_OtyP_mVFnPoANEywEytRSmB1SCdkhLc9AKAc1KEFNuWJr3I6TJOzU9ZkhJOFOkSF2Ab2LIuJAKpg1vWs9v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:GpSjZn5cc34tjC35E2Qooq-bjfRwCuuqJU-4Jh5mItQ9kSYhtzNsPg>
    <xmx:GpSjZv5Zo0D7H-NTi-6fOmVLtTmTvirgjZmYlao7VPCWVcNDEf4uNA>
    <xmx:GpSjZnghdgNu5acFJ8a-xHRPMPPknSEoZmQMHhEpryGO6_cOJa_6Tw>
    <xmx:GpSjZp6hm_gtWQKxM4erKbnhD0zaXvD6wIEb58uUuSV5MDWcEzC-yA>
    <xmx:GpSjZpQ53q6-I2MqIJ_Kv9PrvYK-UX_uJXq_2PjpzQxNCD_B3-6VWC_V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:18:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ec540b50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:17:14 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:18:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/23] object-name: fix leaking commit list items
Message-ID: <e3dbf9116baaf3cf519a9c3cb78026ede566e3f4.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cWbwojUi6z5oHGwY"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--cWbwojUi6z5oHGwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `get_oid_oneline()`, we pass in a `struct commit_list` that
gets modified by the function. This creates a weird situation where the
commit list may sometimes be empty after returning, but sometimes it
will continue to carry additional commits. In those cases the remainder
of the list leaks.

Ultimately, the design where we only pass partial ownership to
`get_oid_oneline()` feels shoddy. Refactor the code such that we only
pass a constant pointer to the list, creating a local copy as needed.
Callers are thus always responsible for freeing the commit list, which
then allows us to plug a bunch of memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c                | 26 ++++++++++++++++----------
 t/t1511-rev-parse-caret.sh   |  1 +
 t/t6133-pathspec-rev-dwim.sh |  2 ++
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/object-name.c b/object-name.c
index 527b853ac4..240a93e7ce 100644
--- a/object-name.c
+++ b/object-name.c
@@ -27,7 +27,8 @@
 #include "date.h"
 #include "object-file-convert.h"
=20
-static int get_oid_oneline(struct repository *r, const char *, struct obje=
ct_id *, struct commit_list *);
+static int get_oid_oneline(struct repository *r, const char *, struct obje=
ct_id *,
+			   const struct commit_list *);
=20
 typedef int (*disambiguate_hint_fn)(struct repository *, const struct obje=
ct_id *, void *);
=20
@@ -1254,6 +1255,8 @@ static int peel_onion(struct repository *r, const cha=
r *name, int len,
 		prefix =3D xstrndup(sp + 1, name + len - 1 - (sp + 1));
 		commit_list_insert((struct commit *)o, &list);
 		ret =3D get_oid_oneline(r, prefix, oid, list);
+
+		free_commit_list(list);
 		free(prefix);
 		return ret;
 	}
@@ -1388,9 +1391,10 @@ static int handle_one_ref(const char *path, const st=
ruct object_id *oid,
=20
 static int get_oid_oneline(struct repository *r,
 			   const char *prefix, struct object_id *oid,
-			   struct commit_list *list)
+			   const struct commit_list *list)
 {
-	struct commit_list *backup =3D NULL, *l;
+	struct commit_list *copy =3D NULL;
+	const struct commit_list *l;
 	int found =3D 0;
 	int negative =3D 0;
 	regex_t regex;
@@ -1411,14 +1415,14 @@ static int get_oid_oneline(struct repository *r,
=20
 	for (l =3D list; l; l =3D l->next) {
 		l->item->object.flags |=3D ONELINE_SEEN;
-		commit_list_insert(l->item, &backup);
+		commit_list_insert(l->item, &copy);
 	}
-	while (list) {
+	while (copy) {
 		const char *p, *buf;
 		struct commit *commit;
 		int matches;
=20
-		commit =3D pop_most_recent_commit(&list, ONELINE_SEEN);
+		commit =3D pop_most_recent_commit(&copy, ONELINE_SEEN);
 		if (!parse_object(r, &commit->object.oid))
 			continue;
 		buf =3D repo_get_commit_buffer(r, commit, NULL);
@@ -1433,10 +1437,9 @@ static int get_oid_oneline(struct repository *r,
 		}
 	}
 	regfree(&regex);
-	free_commit_list(list);
-	for (l =3D backup; l; l =3D l->next)
+	for (l =3D list; l; l =3D l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
-	free_commit_list(backup);
+	free_commit_list(copy);
 	return found ? 0 : -1;
 }
=20
@@ -2024,7 +2027,10 @@ static enum get_oid_result get_oid_with_context_1(st=
ruct repository *repo,
 			refs_for_each_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			refs_head_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
-			return get_oid_oneline(repo, name + 2, oid, list);
+			ret =3D get_oid_oneline(repo, name + 2, oid, list);
+
+			free_commit_list(list);
+			return ret;
 		}
 		if (namelen < 3 ||
 		    name[2] !=3D ':' ||
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index 6ecfed86bc..e7e78a4028 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -5,6 +5,7 @@ test_description=3D'tests for ref^{stuff}'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t6133-pathspec-rev-dwim.sh b/t/t6133-pathspec-rev-dwim.sh
index a290ffca0d..6dd4bbbf9f 100755
--- a/t/t6133-pathspec-rev-dwim.sh
+++ b/t/t6133-pathspec-rev-dwim.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test dwim of revs versus pathspecs in revision parser'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.rc1.dirty


--cWbwojUi6z5oHGwY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajlBMACgkQVbJhu7ck
PpSp0Q//YzSdqjNBFoGjMbYuOuQxtOvG2Vmk75J2suFinf0hVdJEO7fxMPyHscXD
SH7Car8rg/N0WV79Dqbsq/089PIQ2ThrtnTqAx6LG0o26rCeZfa2afpiC5RMwRdj
7yY3TbHHLv2tZEj3ftIBBtu+aXS6EZSVzNMg3GHansYEiNAlUqd1eEBXzKajlR2Z
WHq4p4c35Gb7MRHzF2W2vH/0CkvFqxfUtipHlMPeA+fFARqBLRsA6L7n4gkrtWER
bQ4S6f/wE53CR1yhvnteIw9Ld4rxk+tpzQm399rH/ivqj2Ymz2xtCOjwPHPjkj85
hsxhdMrOM348cJAO3qqXJlbfoVR0TC2gMELs/2rlpCcfL1C2XlDhOcjwTQjMuu+X
MPqdEXMMwJ9G6mQe9y9Cqmv/FMRVb8VL7yt6XUYrzuirJUWpiP1XNbygzkNjsufo
NW45+PqbWZmtqbsz3Alou5NMdFrpMSI3Qeircsi4roZK05QE/+9xweHDo75Lpz2i
AOmgV3GbF/ocbSRVGmLQ/wbtIlk53iQyFCPQMCwOK/A/TSR7vquwRs/4iq4b5ID2
0ejVmGH458KngeRXAj9epi0azuz6bOVNx/hvqbiKjSuD+2Ap2pwpFvtSM84JDc0Y
92BhMlhGI1+LIoe3l9T9OEaWVmwBZa7QdHa/QIU7yCWX6LiB7yU=
=BzAe
-----END PGP SIGNATURE-----

--cWbwojUi6z5oHGwY--
