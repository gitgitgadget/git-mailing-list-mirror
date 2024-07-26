Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69F1779AB
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996173; cv=none; b=Dg6ajkvAn7i0d1ZhOyg3mo/P8hdqp9r/vyN7bdHXQqur0pafr/mzThEN57LQrzXDeAltxXMZ+B9Hb4cYB5CDAS2Mhsbbr9U1ilZuvJeVNtjI+m9aaiaZj2IIvc5BbD7rnsBipKMykI6R1d7pZh5c8Ckp6I9e8uKP6rI+vbcm/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996173; c=relaxed/simple;
	bh=ifvIybvW+8+mBUanM2WBANyiE3EyJeL+dDXMFMlHTT4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqD8VdsP99ByAbOdeMVz0t77qDO+IvnlXMXlBvIMP3zHw6ng1ZKaZFSwA7wTgJ39KA/1BIxMqNak2kpBND2RZkOiJMH0vRvj6U6y8V0VGw8Zpjk+R/5G0QvF3abtAkSN65bE6No/ku0IBIM0Cyy9OcqVB4XZIx5vxMvcSanPjg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FhBpQpu/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u9taFOvW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FhBpQpu/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u9taFOvW"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1BE90138063E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:16:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2024 08:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996170; x=1722082570; bh=2CDH8UDvpr
	PAQeHxye1SDi7LHtIhY7wNuJlLKyJX494=; b=FhBpQpu/ySibQOrsqgPfzxeFZd
	644+PK8GsYkU6wdRpOTfIeHcJQisDJSoP107BM9egsJmTXLRTWHPLZMMO+dYSOdr
	vlfU/rRGSwSgsjww4OfJeZoy0DRkZ6O4fz+NZaNmnWzBspv9vf1cAfPfzR0w2jO+
	DSlfJl7+h10/RypBgEk3Na3qs4pjNfW1lhZoDh1iKGLw1c5cf8xsNJWtB3h8Nb+e
	1JFVZTvRpq1w+pHuleO7WwnxvUMCLO12HIz9d04Nwa75ZU4fKaczorKkcBM3iUE9
	WWT5iRvbcRzrMOF2wrgfc+CDSbP/hADQnL3POBcOubDrn/kJF1+CXrcURxpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996170; x=1722082570; bh=2CDH8UDvprPAQeHxye1SDi7LHtIh
	Y7wNuJlLKyJX494=; b=u9taFOvWEYghLDSiIt1a1TrhmLaaQGQwYHdpWraVqhJu
	65jhD8N2O0xVC1r7oDUzfqTr87RZEIWSRVPfbUduvOmcLiwR+/Zp5bDx0pqOr2CS
	W4lLa3ZhabmFrO+wy2W2TC14t7dCDPfPhhshNgFoXsOFigVn65FPs2e13QUDmf03
	EUOquRud5iWzkNClaV+Qsg4Swryh/EVqoJ+liPRExKzZ9LJO2JNEMl5dpdMYP8Dm
	KejYKZyhnPZoTd6AOUy+H7cSIbFU31P6seGM2mLxtMsVLkC1wRuKkdkPntdq1/CK
	84QPpnk7GBKhg1xPu4ryUzNufBwbk6m7IT3iCkshrQ==
X-ME-Sender: <xms:iZOjZlvQMGSwg4tetI12MAy5v-XoK3ocPMh64WG6R1zyR5_7-h2ZNA>
    <xme:iZOjZueU1MmLWQH8mG3rwJ1QugjQ8Nxw9FXnOlarcp3gSPcR3reBUusjmXk21JeFz
    aQlb7Asz70huE1U8g>
X-ME-Received: <xmr:iZOjZoxIn3uQnTZMDwPaQFW4Hse1_IHRa30r_GhUf9w87aNzSJSMSIrN5-1I47NNA5uiZ3A2XdLXGd-PS_RPRV0qvJq-1kcHCxzYrfqvr6C0cZmr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:ipOjZsMX80sMnBw8u03vv0SNYx6-RfcvszCZ9KnajIELMoR04W-MSA>
    <xmx:ipOjZl8U4vtmh2-hsNP7k1YcITuzo7_iztLERY1Lchtem3Hlp3_7-Q>
    <xmx:ipOjZsWiCgiFVLd1ZPzJL-xQ8p5YnqbH_aJHPMHsdUm0QWih36TH2A>
    <xmx:ipOjZmfd_VAk3McAaurwerR52Q0TPH1A471PRXvp2GkxHyxc_jg2UQ>
    <xmx:ipOjZnk4nm3OR8v89Th7FNfz5Cygal0CZY2XfaxJhhIyddftqvSuzM9L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:16:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f2d9530d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:14:46 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:15:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/23] builtin/remote: fix various trivial memory leaks
Message-ID: <8bedcfdad80c19dbb98e1407e4cef985a066c714.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6J9V1x2ymoMpTVEm"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--6J9V1x2ymoMpTVEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are multiple trivial memory leaks in git-remote(1). Fix those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c          | 39 ++++++++++++++++++++++++++++++++-------
 t/t5512-ls-remote.sh      |  1 +
 t/t5514-fetch-multiple.sh |  1 +
 t/t5520-pull.sh           |  1 +
 t/t5528-push-default.sh   |  1 +
 t/t5543-atomic-push.sh    |  1 +
 t/t5570-git-daemon.sh     |  1 +
 7 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 303da7f73f..9d54fddf8c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -555,13 +555,16 @@ static int add_branch_for_removal(const char *refname,
 	refspec.dst =3D (char *)refname;
 	if (remote_find_tracking(branches->remote, &refspec))
 		return 0;
+	free(refspec.src);
=20
 	/* don't delete a branch if another remote also uses it */
 	for (kr =3D branches->keep->list; kr; kr =3D kr->next) {
 		memset(&refspec, 0, sizeof(refspec));
 		refspec.dst =3D (char *)refname;
-		if (!remote_find_tracking(kr->remote, &refspec))
+		if (!remote_find_tracking(kr->remote, &refspec)) {
+			free(refspec.src);
 			return 0;
+		}
 	}
=20
 	/* don't delete non-remote-tracking refs */
@@ -668,7 +671,11 @@ static int config_read_push_default(const char *key, c=
onst char *value,
 static void handle_push_default(const char* old_name, const char* new_name)
 {
 	struct push_default_info push_default =3D {
-		old_name, CONFIG_SCOPE_UNKNOWN, STRBUF_INIT, -1 };
+		.old_name =3D old_name,
+		.scope =3D CONFIG_SCOPE_UNKNOWN,
+		.origin =3D STRBUF_INIT,
+		.linenr =3D -1,
+	};
 	git_config(config_read_push_default, &push_default);
 	if (push_default.scope >=3D CONFIG_SCOPE_COMMAND)
 		; /* pass */
@@ -688,6 +695,8 @@ static void handle_push_default(const char* old_name, c=
onst char* new_name)
 			push_default.origin.buf, push_default.linenr,
 			old_name);
 	}
+
+	strbuf_release(&push_default.origin);
 }
=20
=20
@@ -785,7 +794,7 @@ static int mv(int argc, const char **argv, const char *=
prefix)
 	}
=20
 	if (!refspec_updated)
-		return 0;
+		goto out;
=20
 	/*
 	 * First remove symrefs, then rename the rest, finally create
@@ -851,10 +860,15 @@ static int mv(int argc, const char **argv, const char=
 *prefix)
 		display_progress(progress, ++refs_renamed_nr);
 	}
 	stop_progress(&progress);
-	string_list_clear(&remote_branches, 1);
=20
 	handle_push_default(rename.old_name, rename.new_name);
=20
+out:
+	string_list_clear(&remote_branches, 1);
+	strbuf_release(&old_remote_context);
+	strbuf_release(&buf);
+	strbuf_release(&buf2);
+	strbuf_release(&buf3);
 	return 0;
 }
=20
@@ -945,12 +959,21 @@ static int rm(int argc, const char **argv, const char=
 *prefix)
=20
 	if (!result) {
 		strbuf_addf(&buf, "remote.%s", remote->name);
-		if (git_config_rename_section(buf.buf, NULL) < 1)
-			return error(_("Could not remove config section '%s'"), buf.buf);
+		if (git_config_rename_section(buf.buf, NULL) < 1) {
+			result =3D error(_("Could not remove config section '%s'"), buf.buf);
+			goto out;
+		}
=20
 		handle_push_default(remote->name, NULL);
 	}
=20
+out:
+	for (struct known_remote *r =3D known_remotes.list; r;) {
+		struct known_remote *next =3D r->next;
+		free(r);
+		r =3D next;
+	}
+	strbuf_release(&buf);
 	return result;
 }
=20
@@ -983,8 +1006,10 @@ static int append_ref_to_tracked_list(const char *ref=
name,
=20
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst =3D (char *)refname;
-	if (!remote_find_tracking(states->remote, &refspec))
+	if (!remote_find_tracking(states->remote, &refspec)) {
 		string_list_append(&states->tracked, abbrev_branch(refspec.src));
+		free(refspec.src);
+	}
=20
 	return 0;
 }
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 42e77eb5a9..d687d824d1 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -5,6 +5,7 @@ test_description=3D'git ls-remote'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 generate_references () {
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 25772c85c5..579872c258 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -5,6 +5,7 @@ test_description=3D'fetch --all works correctly'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 setup_repository () {
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 47534f1062..1098cbd0a1 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -5,6 +5,7 @@ test_description=3D'pulling into void'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 modify () {
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 14f7eced9a..bc2bada34c 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -4,6 +4,7 @@ test_description=3D'check various push.default settings'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup bare remotes' '
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 04b47ad84a..479d103469 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -5,6 +5,7 @@ test_description=3D'pushing to a repository using the atomi=
c push option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 mk_repo_pair () {
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index f9a9bf9503..c5f08b6799 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -4,6 +4,7 @@ test_description=3D'test fetching over git protocol'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
--=20
2.46.0.rc1.dirty


--6J9V1x2ymoMpTVEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk3QACgkQVbJhu7ck
PpRWwA/9FWg6XzqyguPhO9CngFXejkqKyZmnQHk36KOukW3KBcXxlwq6NaLoFB6a
H11qsw+ZsMKn0coup6So6n+a+0nuA6gxNVqiA2mkzB0FVtm5sApN4v4o3HI0sNio
j9peUrMOkfMDlhLujJPn5g8ELIrP6qt+Tf0tdOLyL/rwLl4BYASBKukidJwhiihm
6Jt8ZC4u96C8SUUu8eg7wHDPozMX3IS55Xri+E8MQYecR5g321b3RnpyAbmHLYki
ifm7x3PVn/b0H88O2nfPm8ZP3NRE/jMX5pwxre0SV6XgFseI3pTQGQl2QzUMQuTD
fvluUmIB4qGVog0vB9X67MrL1Ea/8kWXLF4jaxzCEScVEE1iat+fsuBBjAgImoNZ
QpIDog38UKGpGiuDz+w0Gm8M1dY0dmx+jRWqrie2P0sPcfD7X3ydMSLK1MWOg9S/
b+T1j8ZreB0w/rVaWFcxYm6pScczJK56K6SOC0adTlOqxYbJkxMopZPV3s8UoQ3l
0uFjHskooAECnTYwI5uWORSJALy8kJlKWaiR3Y8HWAToIvulby9kCrY2omeW18Wf
54CJdAL3qtv92dOynmAPxxxPLm7uyTkMqGA4P8u61O8GRKmey5f9dHE7AVnOx+2T
cTR0rwv29sW8M2uaZ/zz4AdI4kMxGi3+nQq10bIcA0ITv0kgwTk=
=mzUp
-----END PGP SIGNATURE-----

--6J9V1x2ymoMpTVEm--
