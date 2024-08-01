Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84453183CDC
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508823; cv=none; b=XF5IZGtF5728fXzKBzlOqntLOPNN0bt3IHT4ONQWhu4Hl9vEupfAHQqKXo/f+LLPAo8CXBgCmU/UD00PxVahVB1wa8WBGG08i4301+SEcDA2+Zr1FQ/P0Ei9ijqOmI3EbijPvgOUSV6BOL1o1Nev58Hnp+xKiBNRPdry0urjGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508823; c=relaxed/simple;
	bh=M34b48uDZ7XPsZEuq1vnBRsDePuXDZZz4vF8PuXzEg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMh9V/cOTVkC0adZLwN/5Na2SoBaxqXTk49xqymippLOir6KfGCI7f7iSonr5CTuWWx+OAdFpU9wzhvYFDOkPPw8YPbmZVXOhzSUQ4zHDeb18lGymwzMUMy7R3+OWkWTm78yEe2r/Te8unk70f6DRPBETOltbsESv0B2l8ZFlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mIRbLCzj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ci+/ll06; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mIRbLCzj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ci+/ll06"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A7AC8114821F;
	Thu,  1 Aug 2024 06:40:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 01 Aug 2024 06:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508820; x=1722595220; bh=rYxIf2yhOv
	HPzGVS/W9w61FPdBbXoPgokTfc3Jpussk=; b=mIRbLCzjtARxrZCZf7h1gNimHE
	cTRbR2C5zBaZOYwApKl0JjdbwfMuKFHdwqJahJVyTE72iYtjlXYJ8m+cibNiwT8y
	cQGWvxv2QfUjdUcjQXXAP+Ozw6IoG9hIe5hTWBq/K3TClDEQD1Kx6omlEhx3Ilyj
	M3fWzi/iuh0ET4XpXWJV5Lqm403INxCEh0TbesA/9o+HXmEdpR89QnoeWwOvuQ3e
	87PIcb8brPbR3GhBuRJp5VWByO2r/QSwEuPt7fuC275hb2CkKM6PkzKIWTZNFvSM
	AnKCxM5mT6i6/s9PjOnh4Ikfzn6hZ892WI1uNDvlEvnw1XkkBxVsoJOlp/fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508820; x=1722595220; bh=rYxIf2yhOvHPzGVS/W9w61FPdBbX
	oPgokTfc3Jpussk=; b=ci+/ll06D7YOk1SHAm2zvNpz47+BozrpaETUI8Jed4fz
	BvmzhgV4CL+AtFRmc2KQjBSdciMAwSr+EUtfmsqeQjErxvnyvGp42rKJx2BN0nbj
	v/6qlc2DI+GFLQmwRoQVkvYWJJNSfTQRB1f0hqzAWtbp8CCY+bpW7tVDtwl0ephf
	tYEBKtUkw7R3b27yI7VO2MggFSfzo64s3F+wBGCqLyZ3+SBv6SsTIKajtM+98s4s
	8B+oQrIJSgZZEsoJml+dl99LgUHqL1FnP7jh+LCEcgPNGTmuhhsaGRd/XbtH7BeF
	k1ZSj+jR0HTTnDjLPn3VzEUIcsyWlzQXxMW0tgRiDA==
X-ME-Sender: <xms:FGarZm6C5kTqIFGoubpSSSAOPVezWhFA0XPgEkWDvLqEa2vBrVP2jg>
    <xme:FGarZv54sliJzGT2dH-1HC3uS9kLC2RUAgWqOPdCMdzCIFQ49QOZ7KDFIX8hF1X1O
    QBKfznkE6kIpw9ejg>
X-ME-Received: <xmr:FGarZlcQOuKnENlzz_taFBEmx0hskY5v4UNuxuf6dSSdrKgMThRjUGXBRNi9injxTrxJlDGEDjLpLt5fui7fZpyzHFe1lYxP9T4HqMy_uHRKkWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:FGarZjKLfkS2PzsHgkFyiwcRdpn5dDv8SAbIcRFufN3MZSR7O73hbA>
    <xmx:FGarZqL0S8UjhhgF30bSPx0RQqMiySdz3Dpqmf5-6lEMscJYxfn6wg>
    <xmx:FGarZkxRX8FmCt5S6MBuwPc-deim1JXeOnfZHdQk-3ZDvjXihEhHgQ>
    <xmx:FGarZuJ2TUXF_-xrOOTLi6CUKusTvWVACpONoLI858-HMO_04isOvw>
    <xmx:FGarZsi12EkcIWpBEltooEboAuPtn5JOe7hm3u5V6dklUYV5nuxj9vNl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f264a754 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:38:47 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 12/24] builtin/stash: fix various trivial memory leaks
Message-ID: <b7c0671797ecf3e19c7a8ef1941b920b1c2566e9.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brmNl2GepuUK81hF"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--brmNl2GepuUK81hF
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
2.46.0.dirty


--brmNl2GepuUK81hF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZhAACgkQVbJhu7ck
PpQ5sQ/8C3K3tcbaNSeV8QNu8SVuhrPqj75Kc95wuD8jGN26+VwKm1wwJBWGwbfc
JhPm3SiCAICM2fN1XN9NTb/flY6aDecNzf1f1Tk2gyyqU1ewuP3F87CI5d2UCiAQ
e5wUUZt8gZasGV3tNLPSosifqmub/BJlAtoGMFlfO4qP/AJ7Kgn9vPoBNDAB6YwQ
qOjb6OFezOBo4D53BPyAHfyaudpxlp60VTVPX5ynvhNjoLUttAFANVAX9PmsICeV
Oy89g/gwqCNskX73Fui0TQRomTEsG5qGLlD8a+NkYQyRBFmxi+PwOa2o4MfdyNYz
Rub0U+l/g+MZBXoECGiec/2lD5rPHy9L8mCpg2GD7c1KcGzfa4+TVdKy9/XZXoNG
bQWqH45MbF87+X4T14V04onIUQGlY8PMrXp8+pZvQq2oSM2nhKmC47zlhUIhV2k7
Rn2mwKAnnRgwsopZ826mUSMGalTgT4q8gVbD59hqlxa8A/sznI5Xov5kyzs9v9lS
TGGIvoO6jyxxMdJ6XEqjWHkXNHhW99MK4KuZL738bzpkl4vle/xbo6yfquTF4sOY
vza1Q0MPwXPskxP9wuwYjmF+BRAcF8tz8ZNczWH2xiNmhja3IH7+qQes4TbWMi/C
1rCIgaqkUxcapGoAv+N+c9gwGEKRn8uybOPPRlZs3ZRXeru8GBg=
=0qmk
-----END PGP SIGNATURE-----

--brmNl2GepuUK81hF--
