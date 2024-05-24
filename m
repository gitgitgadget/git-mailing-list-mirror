Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8C84E09
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545096; cv=none; b=b2p7HcPtKgtewMsihPiZmiZeFbclSWpLfoWAju8Sc9mutAGvZ4abM3Aqt+xKiyaaZnV8h0+gU1mpz7QeL1N0UQFlTYcuOulNfroWaOggBJ0zLr4GayZBnZWDWWkXX7KlPlpgzErka+QL/Qr/Rc2MLsEJl2VJq1qQFq5j9MthGO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545096; c=relaxed/simple;
	bh=k5oBH8CnpP6C6fm/5lT1suPe4ekyyacEGQ0SAgPEUxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF8o/QWh+9ocGwur/0zI8zk9oRhZGVODoih1rQb/yu8cYjwoMzUn1FoDU5Ay1MpeBkkXHsCVy7IcOJ1JXBfpupXIL2mdJHo/hNNZs9+Dd8kjLTC2NtOnUwzrEfnVPp9SKR20wb13e5+BHzGiQQM3BIEGT4ZJPsas6++Zhf0rnQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c8ogrGMF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0Du7Vgy; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c8ogrGMF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0Du7Vgy"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0B9B81140195;
	Fri, 24 May 2024 06:04:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 May 2024 06:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545094; x=1716631494; bh=yfAAGzZD11
	Bthdjri14nxEG0LnVXk3KBdRN48/nuuq8=; b=c8ogrGMFBHBMhZ1ZOIYmESsDC9
	xBOckgkfONeVGJS4eKXmbJRyaZj237Jm19yA4qbBaHH9LfhADTdZ+BHKqHhKL2bk
	IoPjaoVmxUVP7P4BNU0gollR6e5mrupdWE1B2qZ9jkaetu6ZptgCHhJtl8CCRQXd
	3P+ZY1Onw4rFKV+pdM8CVeHas9ld5Mx6Ay2Zsbh+9M8HKI0hs9eGFC4Bup8GoMye
	MJQ1xHXnVZg71u04Beeo5yLFQvXAVzV9tkEUv1lwxS/Zad0dUFCHOUfELvkOI1Xd
	rIpUG9BT2Z8mKFwr2ksh+cpk49mYJjytLSyAmq9xkzFOF7BAigaCkmw5Q0lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545094; x=1716631494; bh=yfAAGzZD11Bthdjri14nxEG0LnVX
	k3KBdRN48/nuuq8=; b=B0Du7VgyMmDHOh8rcEDHA7rfhGzcvYcboUPGR+Uyh5Sd
	iuZ3tz/NmBpmsVI/ehBcrd91Lwcbp90CxmxLg0LPCk2D7tzkq0tYyax+V2I+OOqK
	9a2wmHhAhnq4GBJW4k0rjFpFriR6gqmJDInMfK9LgMmg3OW3/WLfCvysbvjH2zDa
	pX8LIBbrPMNN4HUejMkT6qWq9uHItxU+589+dJVisdSMoHHlLp9iqE+ZdpWQ+fXv
	yfy4d/vwiVSvOA6i9hMWIKARFDuZOdOks/pVpQEGPbnO9qcAyBBQAV7vGSH1bMqH
	yXfks7Fe34Zu/cZmEqHs0OowBkTqepb3HDxhuI1oUA==
X-ME-Sender: <xms:RWZQZjh79DiurO46SOWOIPPySh5x5eI7r9ZoTxKdFoXNLiC5A3t1uw>
    <xme:RWZQZgDjYlYrYw3gB73g9DPovBbKyCmqlnsMdsV4UK-f4uLTm8J2yI78NsxmgxXgo
    -9VgF8GNjG6Tow4zw>
X-ME-Received: <xmr:RWZQZjH_bNu39wPOvNzcoTqU5cjUgAfVGFAJaRgOm16pMNzP1v-xwAnqmfTF05HUTusqoPmcgExXJcgjSuksfLt5he1HRrL8_aZbbSnt-7i3D1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:RWZQZgQavl5S6NusUgl7II2mQcxhVDsYtJ_0AGNE1-XMDawHp4Gbaw>
    <xmx:RWZQZgxwRNI4RsIdE3LAiSsf5OAFpGEb-s1pOisZmO2PLU2mkRK8Tw>
    <xmx:RWZQZm4ZxTcoQFAJBQM8n0c_mZZkwauT59euAJJLxSFUBR9fuAlbuA>
    <xmx:RWZQZlw5yhsP-k4HK_ZDWBj4jMf_JPmA_P94odmLmnnzOfgbLGSHXg>
    <xmx:RmZQZs_-wX9pyR0YpF-ek5MZMSd7aLmO6XS_hKaVYH98YSDYGY6bqAr4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:04:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7dd1efb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:04:49 +0000 (UTC)
Date: Fri, 24 May 2024 12:04:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 21/21] builtin/mv: fix leaks for submodule gitfile paths
Message-ID: <095469193c720b76fc793c0ab00be076caf227c1.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dLJ7ZtSPG99m25Zu"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--dLJ7ZtSPG99m25Zu
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
2.45.1.216.g4365c6fcf9.dirty


--dLJ7ZtSPG99m25Zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZkEACgkQVbJhu7ck
PpQkchAAqAX5+oCNm5pDwcYjW0OlT6EgZEdhX+8zUGYo1Zl1BM9dA0TkQc+TPcVc
jhZky0LTbcvbCPO0veHsU4bfxLbImWsYuAp1KvMxIdEblf4jF8OGdrIFXGygDVx1
ElxhP2AvvNwtZvb1VK3o4eKat2PEuQRMP7MJyRXgoDj3bt1LwK+TJQT0AlVYW6vl
lwyI/Qz3WGMJOdh8ztKgfc7bK3wL2Fqw1E2OlZfdp12u7IGviIdD1OtxwkhOUvcY
oTe7HEyIqPY8Frg9UKC52fyrFdxKWP0IWAwu64InuG1mbFez+1hvkazX6gHyZ864
ycWC4uHPPxztG65/+sUWIOZSvbB7l6Zu7joAVryIiptOnbOZ1kSRYntiCVy5lDu+
ffR555GDfDEQ674cLJ1ir/4WJp2i0hJLl/GsRWgqvwmxLOT81YGIJ+mqu8B1agF+
MMRu7LEZCHbKSRyB9PKII4nZ/v3XABeHzZiz97CZUgxWk6uAflw3jRpP6p0WXjJY
knn9anRlHyGIfHZrGu1o7p54Ae5zkJifq2GDm+YIJRiDettL3BKEUhpFDSLBIOhC
ho536clJfJROFmnXPCrgpNyGUrpN+rim463ji0hOgGPdc6wNwhji4aO9mzm+CCOm
a/soc2VxdR9KhACizkmw7tvp3BhQrMV7bnwPy2Gtak9ovPUH3Gw=
=2LcF
-----END PGP SIGNATURE-----

--dLJ7ZtSPG99m25Zu--
