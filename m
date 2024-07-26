Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E73A3D
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996183; cv=none; b=EvLPNpIEF2miuFGC/jC9kiBQLnlPcKXiPlwbqPlFgJF+pHXLDz6dZ3grfM63YNkAtj+UUCdcxDAituOlIzkf3pKEf5PUiK8LSJhyx7sdB3iFIWE2yO59IRxTE4taxvhU7maSP9uKyX4jwQLLoDWmbOcBF1x2t8DBExU+1fxM07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996183; c=relaxed/simple;
	bh=WgO0V5fGsyLgT1c1omRgff6xxCugaXOa5zRtefyWaVM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN7LPhucBXl5Z9Gj4pDX6DqfnJj2izKtesCRddgyoYAoqbTM+lkFDMUaARbYhjOMMqdPb12auL8ujJUMDFdtWBfp7KGPuvuy3Ea7zHkUZm4qutQuN06JIKaQw2P1WLIAn6zYbDRRfylxQK5tJ9gwwEiWilcNcwciUTGEs/n2gng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XnkxU+4R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQCID0GI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XnkxU+4R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQCID0GI"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 42B4813805DD
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:16:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 26 Jul 2024 08:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996181; x=1722082581; bh=f6CX5wCoF2
	mM3a0adFOCvXdcDzOmI8zntGoaSeAwK3c=; b=XnkxU+4RpIoNE/oNDH5poh5a5T
	/BKQgz+7mFgP8ROUb+F4loi4WTOnV4+d9gSWXmUf5Ng0oRwUGMBWImeH8RbJZily
	Vx9p8EpFhXfcR+Qsgs3fV1wbCo5EgWhcv4jBcDoUSHsKSGrx6WssaaPmWihcuHd5
	VF54hlGLW6n24eIXK9IwjOTTu/bhv2lqBVQ4zOHKk9rR7pSAtR97zAgJcNzOl1O8
	3rwUUsyc3mxg+NazyECqnV97qQNwVdDu6YU1ltIGeg7w69r8Ao+d8tfxHSB3gGY/
	r/hebGe84TJo0pJxCIM6HJ4oT1hRpbBkAza3diQRkFVDhStRDby8y19a8qug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996181; x=1722082581; bh=f6CX5wCoF2mM3a0adFOCvXdcDzOm
	I8zntGoaSeAwK3c=; b=dQCID0GIIIuyFNV8dH+P81U8i7z9B1EbmZ7+6RQkQQMH
	d01R6/AFQ+juHilMKAD33KgUDj86Niug4ftzWivUyCPKqFucBTCdf/LjJr/KEMN8
	S9TD0Myio41dRpHTYspkOn7LXvkexa0q8XywFX5aPD99kPveXX4wzta1aZBml3Q6
	ua0+eGHsMbSPhaRmL7POyadqMl3QK2g0Vz7NIZC8soxbqOHtwqVuxKyyASLFbKCm
	dqSHK7Nz10VgGfjuIlMBKduyVewSUnQFwtcCIHGxTv+AkZTjvJwBFt4U3gTj1xSj
	TXTxv79c1S8qUaoG8Eq5rSu1W0/Im2zNDg0xY8ayZA==
X-ME-Sender: <xms:lZOjZnyiXPKIf_U9gv-vGnztcrf8v3ONNY0S9CSKHTn1DK7WJwUCfA>
    <xme:lZOjZvSysgUpVXKL7H7Gb4NccB8fv9HP_buNS5X2_Vlkg5dJkdG0qiuks-zzaUA-n
    jIUUXD_DDuEGRLeng>
X-ME-Received: <xmr:lZOjZhXCLYIgr9c_zsyYzyWeDBWE5mRqunLYtRdu0tiidu83SChshq21EcdYlHkAYvcR-uPsd5WrNDmQr5QI0wnn2sDZr8-vH8A-Xo-MirjXUnVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:lZOjZhjtGfDZygzrF-vFmh3ap5aFXUr5BEpGkCxpV7OWWXTMcnGA9g>
    <xmx:lZOjZpBHcSTwlJ5jQB-JFCbBcHgbFZSM_lMdzUiCc4LZovHZ98XEFA>
    <xmx:lZOjZqJ0LaTcyj9EtliEFzH2kT2sOvmfyrK3RMmOGSRCVLc6_p_lng>
    <xmx:lZOjZoDGGTLQd3H5v22Hie8hDq0fEkrr02VuynzDoGIe50ubbei_TA>
    <xmx:lZOjZm6DaFUGb5EWOn_x9WalvGnwAwvwq2NH3FlvcVvr7M85PdgCFQce>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:16:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5a1e786a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:14:59 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:16:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/23] builtin/stash: fix various trivial memory leaks
Message-ID: <a4b3ca49c9724b79ca695d0db8e45be663a46434.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kv01o715cE54Vdnr"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--kv01o715cE54Vdnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are multiple trivial memory leaks in git-stash(1). Fix those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/stash.c                    | 18 ++++++++++++++++--
 t/t2501-cwd-empty.sh               |  1 +
 t/t3903-stash.sh                   |  1 +
 t/t3904-stash-patch.sh             |  2 ++
 t/t3905-stash-include-untracked.sh |  1 +
 t/t7064-wtstatus-pv2.sh            |  1 +
 6 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 46b981c4dd..7f2f989b69 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1521,6 +1521,7 @@ static int do_push_stash(const struct pathspec *ps, c=
onst char *stash_msg, int q
 	struct strbuf patch =3D STRBUF_INIT;
 	struct strbuf stash_msg_buf =3D STRBUF_INIT;
 	struct strbuf untracked_files =3D STRBUF_INIT;
+	struct strbuf out =3D STRBUF_INIT;
=20
 	if (patch_mode && keep_index =3D=3D -1)
 		keep_index =3D 1;
@@ -1626,7 +1627,6 @@ static int do_push_stash(const struct pathspec *ps, c=
onst char *stash_msg, int q
 			struct child_process cp_add =3D CHILD_PROCESS_INIT;
 			struct child_process cp_diff =3D CHILD_PROCESS_INIT;
 			struct child_process cp_apply =3D CHILD_PROCESS_INIT;
-			struct strbuf out =3D STRBUF_INIT;
=20
 			cp_add.git_cmd =3D 1;
 			strvec_push(&cp_add.args, "add");
@@ -1718,6 +1718,7 @@ static int do_push_stash(const struct pathspec *ps, c=
onst char *stash_msg, int q
=20
 done:
 	strbuf_release(&patch);
+	strbuf_release(&out);
 	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
 	strbuf_release(&untracked_files);
@@ -1869,6 +1870,8 @@ int cmd_stash(int argc, const char **argv, const char=
 *prefix)
 		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
+	const char **args_copy;
+	int ret;
=20
 	git_config(git_stash_config, NULL);
=20
@@ -1892,5 +1895,16 @@ int cmd_stash(int argc, const char **argv, const cha=
r *prefix)
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
 	strvec_pushv(&args, argv);
-	return !!push_stash(args.nr, args.v, prefix, 1);
+
+	/*
+	 * `push_stash()` ends up modifying the array, which causes memory
+	 * leaks if we didn't copy the array here.
+	 */
+	DUP_ARRAY(args_copy, args.v, args.nr);
+
+	ret =3D !!push_stash(args.nr, args_copy, prefix, 1);
+
+	strvec_clear(&args);
+	free(args_copy);
+	return ret;
 }
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index f6d8d7d03d..8af4e8cfe3 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Test handling of the current working directory becomin=
g empty'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index a7f71f8126..e4c0937f61 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -8,6 +8,7 @@ test_description=3D'Test git stash'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-unique-files.sh
=20
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 368fc2a6cc..aa5019fd6c 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'stash -p'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-patch-mode.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-unt=
racked.sh
index 1289ae3e07..a1733f45c3 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Test git stash --include-untracked'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'stash save --include-untracked some dirty working dir=
ectory' '
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 11884d2fc3..06c1301222 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -4,6 +4,7 @@ test_description=3D'git status --porcelain=3Dv2
=20
 This test exercises porcelain V2 output for git status.'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
=20
--=20
2.46.0.rc1.dirty


--kv01o715cE54Vdnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk4sACgkQVbJhu7ck
PpRbIg//V9lLi3DZgBbPm7OM1FZp4MGD+vPbkKdScmtN5UuRBYLipq992D0EV0rw
qgFMBJtkN9Cc4ApJE2BOpAQRk/qIjbf9gYUtT4R0U2dtJJhJmwBpt7Nu3AoUfggL
gHWclZPvPcHDBFwl4MiFiYq9NWWEJbSFmXGCO/6WY2JNkkLOkdkER0m2ngiZ5cSr
ChEuCWG60hEVQmGH51N+ol+SduHCEuw8HGbjyctAEWQIizq39smra4cW+RZisEjj
4rzqv2aZUHICSaun5IIemb/SEwLC/e8sKXGMt5vi8bCe3wFE6zzHfsA/XZswX3kc
fflqTqe1+CIKWU2kwODCSJakZnH56AT/6t9DC9oWjf64BcxpRepjYU/E1BKmnlN+
ed9v5kQe/Cf+YXkTCsDFN7Swh5UjAQW4fNStmaE7RpYOEelZfn+Ssa37VW3BjVok
UKgZ5e3i5sco9elgiCwTzXOHO8e3oXEaWaGlI6cpQdrOsaU+A7gGunFrmXZen67g
9qyFttKYYAUHx7DHVWRaeXgmXnbQiKhhPHM56M/ahftixBDz8IvDan8hn3JXCQ6e
kYo0qCNWYMN5r7JOucZlZAY13Ce4kbGolsGZu5eoaHTgVOBMvPijUZcq2WWNepbp
Qwinfg6H+Zzl9F34wYZ9IR7iheIZVhQqqw61e9p8yncZuLoMwJg=
=xmgI
-----END PGP SIGNATURE-----

--kv01o715cE54Vdnr--
