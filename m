Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B57179652
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996273; cv=none; b=KA9HAb7D3D2fdMpsS8T68P8TiNFwkDvch2XnMNODROber1BRVnTDsT/cjpS8Qwlhyjm38snhKy/y7n0bEYIY3RsgnZ57AAdzUVLc3r3p7KLLqqVreJNVpf7xKIaAgYlWBE5T1q0bcnkWGdy3zGI94oiTWHEYnFtyWTbW7CmA0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996273; c=relaxed/simple;
	bh=AF9ZiNGG7vJNey1lFBa/JfRU7z8XNp18sHxdqYIV0pQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLm8WaqBUx0qD18yGoSMUtq7kc2k7npiXtmesIMcs7c34cgtn7RU64ltn3h0ylTMV2B6PC60RyXqY34TaLX0Pf4J2IEF5oQ+EhHbNtfSak1eSmT05NY0hDnZmh3G6ZaUgIYxB6RENE7sJ4QDWWs+LFtu2cwlB5Qi9HCybiu8uH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VxuV+64O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLYOVjoq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VxuV+64O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLYOVjoq"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A3F0F1380602
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2024 08:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996271; x=1722082671; bh=nj3cpbyaCL
	PTXFxQ2U0P3OipQ02VdlkoMGA8clTMt0A=; b=VxuV+64OXl2f2MuG/x5pRArlb+
	HvvYBkcpFGtIMLgXu+m5dxnC10G5r2p6VtrdG5ktDXtJnv7lkaIOhcS8oPGwHivF
	IXWZ/iNhjjnkWmcGyRbHk4d9MJYb82Q+Br4Xba3w2Z5jkiAbMy2Wd/mgQu+LSRj0
	swDP0rT7hhS3TOC8VsBgugzDdkxrd4wnfjsOdAXT3uqjAHcVfbSSSL2OFvWMJ1cV
	bABqdifiM/KFTnio+UaD/ZgrlN0VNvxfOprngP1Mzq+RvFE2UYTOwmgvvwgRoPNL
	UgerIRzaUKZIdHQtXPZ9Ek0XU/qa4cVhu59XmZHKNj1VMIIMKDfkx/d9j90w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996271; x=1722082671; bh=nj3cpbyaCLPTXFxQ2U0P3OipQ02V
	dlkoMGA8clTMt0A=; b=mLYOVjoqhoWL8oOczJNZyNmDlDEkEm3uqqJUG8xAMfs5
	148PZvLWh6kGnAlssn4qmd8SmJ4Rjrz6vQ+e4u92x8V7gSgITqxH3aXY6hQN3jSz
	6xGfvUT9Rwb/MOvzaSQHI/csN5oKxzqc+9ak9m4bvJ/lID9UFRArRbzINBcmorrk
	PlZH8EIMx7w8ksopRhV7/TUzM385+mwOefGL4tYsz4B1fhXyxLyKfv1yD3DhHr/W
	2XP1tFLkjhtoXkMPcQ9Ylkra0R+qUvbjU1r+lrpribsJP9D3tPze2jY8/ldjS5zi
	jytr5O+pmQ9U2JlE0P7LurFyFdtkSxOdyr2+W48reg==
X-ME-Sender: <xms:75OjZo6TKbEjR-CyVR7-q8fw9TdBfRfR93Y9eicb8MnL4-L7TFG0IQ>
    <xme:75OjZp6DIzyyCt6xFC1B0xaYYdiMJT8asj_RAqVYuoLOOgS7QSPUeuBTUbqh9v5Bo
    qUMW52NaGkeZV8zuQ>
X-ME-Received: <xmr:75OjZndWZ9TtlAemBttx15F7wi36WOx5-60uLvl1MjtbYgrALg0LlIrzdohzCpor2S10PqyY0up9SUFfQLH2CmAs4hFCmG0SoXFIIHUfgOVhfF0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:75OjZtImRnTde9e2ZKztHNJ8H3jPZWrm6kEsc2yFw32gGthil722AA>
    <xmx:75OjZsL3mqqetkduAs2_yS4zadLKzBxiNfVDj-eNzhmuPrNk5WT9zA>
    <xmx:75OjZuxlUgJGVZXANw7ABFN-5oo_r2z_LCz8J1RgKOFtvuLcvHOAVw>
    <xmx:75OjZgL_1BSR0R3JIh7Fdkd8JIqRvezbO15Tk3DkNGAgjId-N04CXQ>
    <xmx:75OjZmh62LQjuqnIpPod25CFTJYZ8uRCiDS4QdrvkrtB7MVL4oEzbMy6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4fe00da8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:16:28 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:17:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/23] builtin/worktree: fix leaking derived branch names
Message-ID: <8a649bf7ed38297c9a2d3ec856368603e31adb7a.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xb0U8GxZFFM8HkPg"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--xb0U8GxZFFM8HkPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are several heuristics that git-worktree(1) uses to derive the
name of the newly created branch when not given explicitly. These
heuristics all allocate a new string, but we only end up freeing that
string in a subset of cases.

Fix the remaining cases where we didn't yet free the derived branch
names. While at it, also free `opt_track`, which is being populated via
an `OPT_PASSTHRU()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/worktree.c      | 7 ++++---
 t/t2400-worktree-add.sh | 1 +
 t/t9902-completion.sh   | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1d51e54fcd..cec3ada6b0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -769,7 +769,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 	char *branch_to_free =3D NULL;
 	char *new_branch_to_free =3D NULL;
 	const char *new_branch =3D NULL;
-	const char *opt_track =3D NULL;
+	char *opt_track =3D NULL;
 	const char *lock_reason =3D NULL;
 	int keep_locked =3D 0;
 	int used_new_branch_options;
@@ -846,7 +846,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 	if (opts.orphan && !new_branch) {
 		int n;
 		const char *s =3D worktree_basename(path, &n);
-		new_branch =3D xstrndup(s, n);
+		new_branch =3D new_branch_to_free =3D xstrndup(s, n);
 	} else if (opts.orphan) {
 		; /* no-op */
 	} else if (opts.detach) {
@@ -875,7 +875,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 			remote =3D unique_tracking_name(branch, &oid, NULL);
 			if (remote) {
 				new_branch =3D branch;
-				branch =3D remote;
+				branch =3D new_branch_to_free =3D remote;
 			}
 		}
=20
@@ -923,6 +923,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
=20
 	ret =3D add_worktree(path, branch, &opts);
 	free(path);
+	free(opt_track);
 	free(branch_to_free);
 	free(new_branch_to_free);
 	return ret;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index ba320dc417..cfc4aeb179 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -6,6 +6,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 TEST_CREATE_REPO_NO_TEMPLATE=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 932d5ad759..cc6aa9f0cd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -16,6 +16,7 @@ test_untraceable=3DUnfortunatelyYes
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-bash.sh
=20
 complete ()
--=20
2.46.0.rc1.dirty


--xb0U8GxZFFM8HkPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk+MACgkQVbJhu7ck
PpQZXQ/8CKb1dxnz6zj5801ko5fe16MELY7OisDB3W2vDOQ7cym5pPOqudtBR7tS
b2tKn7si4JBJdAVFCzFWHxDyqPFwpLuB7obKR/8DpneLxn0+8+xsnLMaZvY/+4j5
7yzLGnwluklvQAn0HR7RCIk5F18MeENV75ZSKMOPATUe3Tsku8+VetaVLyPcA6ZD
CB/33I5r7j//yR0il6rtCmZzYwJy/+vviwF8xKoqCbotbXVNdI8vN9DBZdbMelhH
cr9I4Y6UQGNax876pn3TjDEz8wPCVHA3rV02ZsB0f8buIuhG/7/dV2VBAZSICmK4
7/s0Oq+6LzdB+x4/TFhI9podXwQaNTrZNZTmNtYIbJib+GuJch0rnDjNEwkFi6FD
RAuNE07s11wvv1in3wIUDvUBrWAXIdXnJfQSGPWlkBQYkXohV3mD3HQwHrXpNdYr
rZcwBguVWLI0mS9miOgRRvednsz/GvXIkNQAVOQMtWuwHV+ZXeGM5GKFIFS6GKgF
4fZz/OR4hyr6aLdQulys3jkjdeCKX8kmkMde5o5LMS6kxHnha88vKUFxhJWQ75Uo
/Q6RzRcVmftdaEnnimfHVNfiTtDHFEaQvEBj8Huo++/6F3lkwCM3jw1CTKqRCZR2
zp0Pol1iWyR5DMGlhiGfdoOxaOq6fZlgSqXglVIcPy5rmGG1GyI=
=hY2N
-----END PGP SIGNATURE-----

--xb0U8GxZFFM8HkPg--
