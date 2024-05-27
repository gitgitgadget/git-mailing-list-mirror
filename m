Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F67A15DBBA
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810449; cv=none; b=TMC7q5f3PRM5Av94o2LL0nhKCsI5NiGVr1jxKIH8hqkpD9TcUf1bbPcpDvMtYHPCWw7+fQni5lttoZAD7E9lmPr1iqrQnawRGE9t0B2MDINIw/Ur3KgWbjpkRiOYaUjy7EA7I/rEM3Ti8lUgV47f1ROqfK4scNRfAA721nan3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810449; c=relaxed/simple;
	bh=XmXgW/7lu7WZGZ6htfDjawGBrh6IiEkLGYak7K4Lfb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7oeqnaDb7pKfCf6erptbmcr4P4gxIWOyVtedundO6bLsIfPddk+raV6To8UUPcUq6sS5fY4yXR3XI5p3+FRdox+7TIch8kXeFagnrCENXHK7uSAS63p40TCeIKqDHJemNgtMOulNvBqgb3oVIFC0AYPV5OSKicINwj5aaNEwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gfhbSLq+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V73BlRuq; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gfhbSLq+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V73BlRuq"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9BB7D180009D;
	Mon, 27 May 2024 07:47:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 27 May 2024 07:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810447; x=1716896847; bh=+MkkcJTIFU
	hHaGabDj71Ke+65SyieN1SBmpiPwcIl9U=; b=gfhbSLq+YDEVtSRpPbWxCNbIum
	5rfTMovdXT9XzJnRCYDToFwyW4agw0QkzN8E38B3yu3GB6YhgkILr4BNCJElAm3g
	8uFODHzqdHVWjzAgyx7q3PJ/Nh5wvsl+GAomHgkpXo7wLSyahB7ctNPY67V7dhii
	PHf2VvkbIkrg+598G4zyTtIXZ59trIe0WK5LskixyoqvStYbfz/XBXWzLXIfYdwB
	fhZRT9RzKJWQXLQ8A/ahWrUxUI1aGrK1GIqEb3qsl0erRKXfTuStqmRCDvK74ihv
	D/W77ocissWIuEhdjGTvPUMlsjw7ynGyeNR0PvTZ/RrixeHwSMNfewXf4/Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810447; x=1716896847; bh=+MkkcJTIFUhHaGabDj71Ke+65Syi
	eN1SBmpiPwcIl9U=; b=V73BlRuqPbYLImJLvTjzf9VuljvuQ+6VUVp1m1VPbQyV
	bFNpmlwZ4wqaVKVvgEmz1WT86jn/i6b1fHprCN8HCiJ3jgm9lqeekzU6UsI4so+a
	6S8kwynhOrDRsd27ihlqR60RlBhvfO+W+/UtgRDZsRyQ2W2stiE5VNoEJ7751CS4
	5rROAbB+6wNPXLoRLuJq6lom9JOybHbgvIhNT80UqePYj2xyUCzDyGMWBGOIN4DA
	OfeBUfN9oP8ZmE8aB6qGfBJ37rZ7NNOA1Ur/YD9/UkEIW22izAJokazeZG0l6+S5
	lk3GqhaEYFUDEphTlVEprVUqj5oxqDcrOCEaCWgLFQ==
X-ME-Sender: <xms:z3JUZidGe-j5_F69Zs1FsuFDFWn6-U0hT3jeQc3Ahy8Vnt53Sg7Vdg>
    <xme:z3JUZsMEboPZCu9fqFNSBi0--BmSxLjE2NvaMqI2b6pjVjHqSEuQETAJm0hGmhs7u
    gJnfyFRT8U97VW7EA>
X-ME-Received: <xmr:z3JUZjiRQ0MpC-iuxhNxohID_7atvkoSlc80xrZtfAsP6dCkrbvm3j-dl305yMy1xKG_pPqgi_nOFmO1cKVSxEOS78mTGB1nWq1eXvJiMSr9vSgPgO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:z3JUZv-QwAweD-H0Toq3KWIQNjadE-Xy0Y_0e8N9YXjalnXFnNxfyw>
    <xmx:z3JUZuuamnm2ntS5PiYA1xa4K4010QMmyBPW8DzlhRB6BimzvTPjQg>
    <xmx:z3JUZmG0jckkzca-SYnui08MwsUZ47-INdLJNSgUtothUdcsjPhn4g>
    <xmx:z3JUZtOEbvsTj5Uge-5XauDreAFt44O_S9w0by2hit3Zc4DH-Hfosw>
    <xmx:z3JUZgViCmBiNLBU9nmKMk3N_Xx47Bnowc5Bd6YP1CHiJGGGTonzoSwj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:47:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ade32d89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:47:15 +0000 (UTC)
Date: Mon, 27 May 2024 13:47:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 21/21] builtin/mv: fix leaks for submodule gitfile paths
Message-ID: <add7946446daab57b28454dda625c4c77ab6c745.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Kz0MXhKCNa29lo5"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--9Kz0MXhKCNa29lo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Similar to the preceding commit, we have effectively given tracking
memory ownership of submodule gitfile paths. Refactor the code to start
tracking allocated strings in a separate `struct strvec` such that we
can easily plug those leaks. Mark now-passing tests as leak free.

Note that ideally, we wouldn't require two separate data structures to
track those paths. But we do need to store `NULL` pointers for the
gitfile paths such that we can indicate that its corresponding entries
in the other arrays do not have such a path at all. And given that
`struct strvec`s cannot store `NULL` pointers we cannot use them to
store this information.

There is another small gotcha that is easy to miss: you may be wondering
why we don't want to store `SUBMODULE_WITH_GITDIR` in the strvec. This
is because this is a mere sentinel value and not actually a string at
all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/mv.c                              | 44 +++++++++++++----------
 t/t4059-diff-submodule-not-initialized.sh |  1 +
 t/t7001-mv.sh                             |  2 ++
 t/t7417-submodule-path-url.sh             |  1 +
 t/t7421-submodule-summary-add.sh          |  1 +
 5 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index e461d29ca1..81ca910de6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -82,21 +82,23 @@ static char *add_slash(const char *path)
=20
 #define SUBMODULE_WITH_GITDIR ((const char *)1)
=20
-static void prepare_move_submodule(const char *src, int first,
-				   const char **submodule_gitfile)
+static const char *submodule_gitfile_path(const char *src, int first)
 {
 	struct strbuf submodule_dotgit =3D STRBUF_INIT;
+	const char *path;
+
 	if (!S_ISGITLINK(the_repository->index->cache[first]->ce_mode))
 		die(_("Directory %s is in index and no submodule?"), src);
 	if (!is_staging_gitmodules_ok(the_repository->index))
 		die(_("Please stage your changes to .gitmodules or stash them to proceed=
"));
+
 	strbuf_addf(&submodule_dotgit, "%s/.git", src);
-	*submodule_gitfile =3D read_gitfile(submodule_dotgit.buf);
-	if (*submodule_gitfile)
-		*submodule_gitfile =3D xstrdup(*submodule_gitfile);
-	else
-		*submodule_gitfile =3D SUBMODULE_WITH_GITDIR;
+
+	path =3D read_gitfile(submodule_dotgit.buf);
 	strbuf_release(&submodule_dotgit);
+	if (path)
+		return path;
+	return SUBMODULE_WITH_GITDIR;
 }
=20
 static int index_range_of_same_dir(const char *src, int length,
@@ -170,7 +172,8 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 	struct strvec sources =3D STRVEC_INIT;
 	struct strvec dest_paths =3D STRVEC_INIT;
 	struct strvec destinations =3D STRVEC_INIT;
-	const char **submodule_gitfile;
+	struct strvec submodule_gitfiles_to_free =3D STRVEC_INIT;
+	const char **submodule_gitfiles;
 	char *dst_w_slash =3D NULL;
 	const char **src_dir =3D NULL;
 	int src_dir_nr =3D 0, src_dir_alloc =3D 0;
@@ -208,7 +211,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 		flags =3D 0;
 	internal_prefix_pathspec(&dest_paths, prefix, argv + argc, 1, flags);
 	dst_w_slash =3D add_slash(dest_paths.v[0]);
-	submodule_gitfile =3D xcalloc(argc, sizeof(char *));
+	submodule_gitfiles =3D xcalloc(argc, sizeof(char *));
=20
 	if (dest_paths.v[0][0] =3D=3D '\0')
 		/* special case: "." was normalized to "" */
@@ -306,8 +309,10 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
 			int first =3D index_name_pos(the_repository->index, src, length), last;
=20
 			if (first >=3D 0) {
-				prepare_move_submodule(src, first,
-						       submodule_gitfile + i);
+				const char *path =3D submodule_gitfile_path(src, first);
+				if (path !=3D SUBMODULE_WITH_GITDIR)
+					path =3D strvec_push(&submodule_gitfiles_to_free, path);
+				submodule_gitfiles[i] =3D path;
 				goto act_on_entry;
 			} else if (index_range_of_same_dir(src, length,
 							   &first, &last) < 1) {
@@ -323,7 +328,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
=20
 			n =3D argc + last - first;
 			REALLOC_ARRAY(modes, n);
-			REALLOC_ARRAY(submodule_gitfile, n);
+			REALLOC_ARRAY(submodule_gitfiles, n);
=20
 			dst_with_slash =3D add_slash(dst);
 			dst_with_slash_len =3D strlen(dst_with_slash);
@@ -338,7 +343,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
=20
 				memset(modes + argc + j, 0, sizeof(enum update_mode));
 				modes[argc + j] |=3D ce_skip_worktree(ce) ? SPARSE : INDEX;
-				submodule_gitfile[argc + j] =3D NULL;
+				submodule_gitfiles[argc + j] =3D NULL;
=20
 				free(prefixed_path);
 			}
@@ -427,8 +432,8 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 			strvec_remove(&sources, i);
 			strvec_remove(&destinations, i);
 			MOVE_ARRAY(modes + i, modes + i + 1, n);
-			MOVE_ARRAY(submodule_gitfile + i,
-				   submodule_gitfile + i + 1, n);
+			MOVE_ARRAY(submodule_gitfiles + i,
+				   submodule_gitfiles + i + 1, n);
 			i--;
 		}
 	}
@@ -462,12 +467,12 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 				continue;
 			die_errno(_("renaming '%s' failed"), src);
 		}
-		if (submodule_gitfile[i]) {
+		if (submodule_gitfiles[i]) {
 			if (!update_path_in_gitmodules(src, dst))
 				gitmodules_modified =3D 1;
-			if (submodule_gitfile[i] !=3D SUBMODULE_WITH_GITDIR)
+			if (submodule_gitfiles[i] !=3D SUBMODULE_WITH_GITDIR)
 				connect_work_tree_and_git_dir(dst,
-							      submodule_gitfile[i],
+							      submodule_gitfiles[i],
 							      1);
 		}
=20
@@ -573,7 +578,8 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 	strvec_clear(&sources);
 	strvec_clear(&dest_paths);
 	strvec_clear(&destinations);
-	free(submodule_gitfile);
+	strvec_clear(&submodule_gitfiles_to_free);
+	free(submodule_gitfiles);
 	free(modes);
 	return ret;
 }
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submo=
dule-not-initialized.sh
index d489230df8..668f526303 100755
--- a/t/t4059-diff-submodule-not-initialized.sh
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -9,6 +9,7 @@ This test tries to verify that add_submodule_odb works when=
 the submodule was
 initialized previously but the checkout has since been removed.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Tested non-UTF-8 encoding
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 879a6dce60..86258f9f43 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git mv in subdirs'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
=20
diff --git a/t/t7417-submodule-path-url.sh b/t/t7417-submodule-path-url.sh
index 5e3051da8b..dbbb3853dc 100755
--- a/t/t7417-submodule-path-url.sh
+++ b/t/t7417-submodule-path-url.sh
@@ -4,6 +4,7 @@ test_description=3D'check handling of .gitmodule path with =
dash'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-a=
dd.sh
index ce64d8b137..479c8fdde1 100755
--- a/t/t7421-submodule-summary-add.sh
+++ b/t/t7421-submodule-summary-add.sh
@@ -10,6 +10,7 @@ while making sure to add submodules using `git submodule =
add` instead of
 `git add` as done in t7401.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.45.1.246.gb9cfe4845c.dirty


--9Kz0MXhKCNa29lo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcsoACgkQVbJhu7ck
PpTvIA//Rtj/lUmbVOIQFF64Qy1kayhPdMgw68lWaXMW4pAB+9xoK6QsFuFljBZE
ARgz5aV+M8XeWFjsRGb6YdExR8WyAuoGsVudWxFlGywMTZjmzoZZug5nklt2Ir+Z
3YTzeNqgzHiMRjsODJMxZUsTIXp4tTaHV9QbJNRv5Tn8IILOye7Pn+brHQMvhdWY
vN7ORfG+uNdRVmV2ZJ71YEQzICbH2Ezre9lmaebp3g0nVVXBdCtDzaZudYxdBc4w
jtNDYfT8pLWL1QqkzjDemf3wl9y8KM8nay6IG+Ik8VoR29VRmBcoScXI6Z42ar5J
AwoOGQMHdHCNDLDN9Yuu9kfobKJlLFdz1h8xR/7V76M8mZxzVDLHk4ZHz577wO+W
3k0sJ0qw3Nh1b9SAyQX5wFMO7Ofs8hWhYIO/BT5Hd65jG7NREflH2k3srT8TwoH9
zNpaR91wSxwp3uEkat1oUE3Kp0XZgRpE8B3N8oUUGljICuLCI09/sEQyHoy3Hb0h
dGJFIhiXWLSikR7jJoVwZOb5Gdu+LJ8UaV1+v9vDZaGkWVXZm/JSm4OXTwq2vqL+
agl0d7M4owkeNNG000/k6OKPjEkOUqpqJQLZWI+1l/GIfz23o0KxJEN3yd0/+Z/G
vuTdK/Q6147uTr0LcnnmpAvuzvcKocgseEeqOSQI+qKwKnaLGoE=
=8ckz
-----END PGP SIGNATURE-----

--9Kz0MXhKCNa29lo5--
