Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47596A8AD
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579038; cv=none; b=OWeEuZJklYDITC3F5OmjLsD70B+DGX+JYSXcutr4WDhJlEO1WkUExK6ebLKaIhOtRjUcSDxghEWiQqR8v249JoSN7Y4vbXHJO7kzvNy6+AoOOeJ9HZwGX6gwqOxQETNIotFvGlY9jFWYLf10p9hEPV4axagesJAUXQT/u+s009M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579038; c=relaxed/simple;
	bh=xALB8ROpc8WleFGYIqMZX0NLRNkm7IhngodHrZd4P5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyfaim10dhgXy9ePNeBfYNwmUV+G2/Ala3Wmq5vbj6yrghjs7FpJDMQFJp96H6cJl0TrU+E5AuOA164M7Hg/W2UWVupRMVyyjBNdQ0q0cNR9kZMmI8ZgooPR9iVXatH9Ji59WLrVSxIj2v2gL1N2gc0i7r+Xpn6bbqXK41HbOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D5mNi6GN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFJlHy48; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D5mNi6GN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFJlHy48"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EF8111140112;
	Mon,  8 Apr 2024 08:23:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 08 Apr 2024 08:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579035; x=1712665435; bh=YrnkX2gvdT
	rBRJ6mq3fMg1CMCFkS5ZChUk0SDm2zSAU=; b=D5mNi6GNv2LIGfcSiMsOLOMdWU
	z3Ckb0QTqXKnVqwK/TvRnf7vknf4Ancs8TIX9wzNezrjTl5P9yM389jAj/rP8Ail
	esXh7Z4PUroJRElpSjZT1GsoYFXFAxRaDPAJJ/Kv+fWA/1bjBEPcClGQPSH8OJC+
	sj7bXJVGfupnQ3aMTt6eSz1k10R6NiCR+vHvWCE/APbadk8l51Y6ReqA1b5jkmYG
	ElurYxGiW7ymytqgnpshnceAF07kGc4UNfvnIyOdwptr6N7maFYpadqgDrxZYdiy
	uzZZzFR5z+AyLCT49n2pI/klgYN/psmjqyinJ2L7FJkkKQq5DFcpU34C+WFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579035; x=1712665435; bh=YrnkX2gvdTrBRJ6mq3fMg1CMCFkS
	5ZChUk0SDm2zSAU=; b=ZFJlHy48EZNoHdJuigJGLpxwvaeGbPoHxIS70SPpy6ds
	jxS918FBawdB7hHXwK/UINPwTcv5BKoid9Ez3fv3oX1JUxkF2HzUkBvC4BQbqLoh
	OvpyEnZyumnmYptispe5SQqZsDr2aExNcTbrJ+QMNPq5lAVQ7cyZvdnEkHTXZzIl
	DYC70pkjiV5vgwO1DaNkgctaoRMFLXOBwu2t1vsdkQGS4eFEUhR+yN5Tx5sAx0iM
	zQMlREGiQeG0ojx1yU/dDy76BK1EA4ww4XXPybUqWQ10LTo8/UuAgAgSY3wNXysX
	7M10cEb6zA4Mg+w9pctyaQNUETaGzDXpBVOQU59ftw==
X-ME-Sender: <xms:2-ETZn_l-M1JrhLSFTv4tingstk70ldrjmnP07iAlJz1XEKhwHpIxw>
    <xme:2-ETZjvtM0yek9ZOSpmZwEEEHoAF2mii8_0V_UT7c_dy5rl9-BNL1cBCiljb6JyMo
    WtiYMId6Xtb6OjKJw>
X-ME-Received: <xmr:2-ETZlBcA-2rGPZ6zhhcHNYtsHbh6j9l4oICFwBXE5G-R5D0nv-hsA6P-TdeBbC0e_x0El6q016m55G4E7kHNNjztc47uxOvreSSNldo7i2Wk647vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:2-ETZjeaAa6hogbjh4skj3SG8bO7sIpd9gYmUBBvF3k9MMjeGlYLIw>
    <xmx:2-ETZsPXM6C0X4fZ1aJn7HGmvNqBja9uy8bnlcaKNM_oyUSNsWHL3A>
    <xmx:2-ETZlmslkxojiGvAjzg1mWaCT5Xp3IOfrQD39pGm_EmPpjQuW_iVg>
    <xmx:2-ETZmvpqH0DkeXx5htsvfssqxYpqOMKiWRh-j9CEommeNoAK_LmJw>
    <xmx:2-ETZhrk_Ikv1yoQjqWfrPEZqWbY51kGQ3cTydJkfSz0aatvUG_oDqbL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:23:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 120ce5c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:23:48 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:23:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 01/11] refs/reftable: fix D/F conflict error message on
 ref copy
Message-ID: <bb735c389a234b5b90524212f0123d7404fe3d29.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i4o5E/NVsvpbE42m"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--i4o5E/NVsvpbE42m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `write_copy_table()` function is shared between the reftable
implementations for renaming and copying refs. The only difference
between those two cases is that the rename will also delete the old
reference, whereas copying won't.

This has resulted in a bug though where we don't properly verify refname
availability. When calling `refs_verify_refname_available()`, we always
add the old ref name to the list of refs to be skipped when computing
availability, which indicates that the name would be available even if
it already exists at the current point in time. This is only the right
thing to do for renames though, not for copies.

The consequence of this bug is quite harmless because the reftable
backend has its own checks for D/F conflicts further down in the call
stack, and thus we refuse the update regardless of the bug. But all the
user gets in this case is an uninformative message that copying the ref
has failed, without any further details.

Fix the bug and only add the old name to the skip-list in case we rename
the ref. Consequently, this error case will now be handled by
`refs_verify_refname_available()`, which knows to provide a proper error
message.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  3 ++-
 t/t0610-reftable-basics.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e206d5a073..0358da14db 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1351,7 +1351,8 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	/*
 	 * Verify that the new refname is available.
 	 */
-	string_list_insert(&skip, arg->oldname);
+	if (arg->delete_old)
+		string_list_insert(&skip, arg->oldname);
 	ret =3D refs_verify_refname_available(&arg->refs->base, arg->newname,
 					    NULL, &skip, &errbuf);
 	if (ret < 0) {
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 686781192e..055231a707 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -730,6 +730,39 @@ test_expect_success 'reflog: updates via HEAD update H=
EAD reflog' '
 	)
 '
=20
+test_expect_success 'branch: copying branch with D/F conflict' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git branch branch &&
+		cat >expect <<-EOF &&
+		error: ${SQ}refs/heads/branch${SQ} exists; cannot create ${SQ}refs/heads=
/branch/moved${SQ}
+		fatal: branch copy failed
+		EOF
+		test_must_fail git branch -c branch branch/moved 2>err &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'branch: moving branch with D/F conflict' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git branch branch &&
+		git branch conflict &&
+		cat >expect <<-EOF &&
+		error: ${SQ}refs/heads/conflict${SQ} exists; cannot create ${SQ}refs/hea=
ds/conflict/moved${SQ}
+		fatal: branch rename failed
+		EOF
+		test_must_fail git branch -m branch conflict/moved 2>err &&
+		test_cmp expect err
+	)
+'
+
 test_expect_success 'worktree: adding worktree creates separate stack' '
 	test_when_finished "rm -rf repo worktree" &&
 	git init repo &&
--=20
2.44.GIT


--i4o5E/NVsvpbE42m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4dcACgkQVbJhu7ck
PpRzeg//VXsUSO3BpVacIDebK4ir9iE1BBqPiVEBpnohhKEaomTZGakOGHGOSKtB
8TUmJUy3IuVy1sJW8ZvcFeJs0Z4FPWC99i237CaythD3ik/SkwDrq/s/HOk3sS2q
hnkSixPRHkWTVYlQv9l3LOv2KoqiYERtzoS4MOH3sexHroJxZRJIYlDfb9aaMOxD
JFX2QFEwresy92WhpRb0xvDR+gBwDBOZ2Ew6RZMv2VpYHsJZQgc5gSc8M5zUqz+f
VJutNdSS4EHoS2f58FJe9SavYG/2e9HE85u3J6Dw4SrS348pucFi2hxoaNEx4K70
XH4S9OMysVwpG5pwY5YlddrtYSrtBhNVHpVxvNGb9N+CkYZYF0zjhDckj0ECa4sC
ryJj2jwW8z8OdZIl64zGAFcmlAT2dOmirofHkltfKVN4xbtC8GizES/x6yi4BQAS
ETwvV1pVSZrynW1Sxb6oirchig6RrPBp3Cke4ILdsPx1g3nufXefErRj8gJlwNQ3
aWT0Kr2LweIulO+QZJo3cX4QXWz6rQQj3hW+EtnuACp1nN/8qXIlRnT9chM6trQ/
ODrQMtfkQLyhWEWM1UI99kLU/0/0iT3CAepc4BGd6GqjEVpXkhlM5qxrBeW7uOTO
5icDXtS9vhx9bX6q4TQyrst/224EhzVrc7LQDeAEtRaXyBJkcw0=
=NJAf
-----END PGP SIGNATURE-----

--i4o5E/NVsvpbE42m--
