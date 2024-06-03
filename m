Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585ED84D1D
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408125; cv=none; b=bxDA66QmxMyFg7KovlrX/U54MdQfACSW7z53T1q2mS7KH0Aj/nK3++0XMKK0HQDB5N0/tF5f9huKBCd02aa+i5Z9++lpuTorRCctThkKwmKGP/+vCf+sXVi/IT0OKG/Y4+VGzPYsl82BSWV35URYrK1NPMCCnAkVIdif7cVLEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408125; c=relaxed/simple;
	bh=PKNHYe4P4bvi1i4sIyiwUxzkKuQJZQnaK58CQ4vpzgs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saol8Tt2aXx0L5xGjfvGfZdVEkHHIQcPaqVc1VjMwq+gqo/N1fSXH1XMgIzrUXSXwaSiqS54HPO379+UcegJkWHvHtdU+KZ3qaS2INSRdEHWmd4aQivdB/0NnqVjRFV6u+CqBJ0s9MQPHZZ9aj07YC7BgPRh2H2Yuh9TPJPE6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b1f68Qhd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NvzEmnw8; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b1f68Qhd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NvzEmnw8"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id B0F0A1800083
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:48:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Jun 2024 05:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408123; x=1717494523; bh=Fay5aAalt4
	9nJ9/2ztK8egGN3C+3a0lPblwOCLoyMX4=; b=b1f68QhdZawVPHgfHrGuO40Ihq
	Jvo12hc8BrQHRRby9t7LNx73fhQgubp5NeWLBOEPHbaJSsQkJCG9rjkUS9j7auPa
	fcPwXFqgvSs6BDg6e+sxzYvu2qzvaUmAYpeMMcDIVEzh0SjGYRgmdNTthBIAeL1i
	5g0ZKCbQ0ta+PpRMpLGKxVEZb5rP69hpJsyJNezlSMkx7wwiQeidM8+9EDPeWiCz
	6twDzE/CG2saKJMotQR+P3aZcrAq0GZrL7JnAoGqTNAr6x1HXQ8Idyd96py3q0o9
	uKHQPW3Ci9L0IpFMEYcCDa0/g7q/hBCrCEbrSxZhijlvNTGBBuF3SDlBcC9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408123; x=1717494523; bh=Fay5aAalt49nJ9/2ztK8egGN3C+3
	a0lPblwOCLoyMX4=; b=NvzEmnw80JF1IDq7/Ktontdh0Lfd6cRzWloggxnWLj/q
	EYKTSpbwko4bFpvaLnssS358TRUMLysoS0KZVzf5KpZWKTdt+LmdT+BHQh6vfERG
	Ulz5u3zcAJpaiIaWtm7KWtr2T9eW7mY5+S/5YqhYdo63gSNpeOGw63ELaiQ1307N
	WAb4DhSY2rkqi7w4okKuoX93XGyWZaGPUbNfSECsXfdXr7VW1cob/9eL3wATyRqP
	GPvtAK4MGeVCko0ii4Wjdxse5jK/tETkLpw/O0MxDu0+uE3bTDs5JvmfcxKWXuU6
	Q3w3Z9/Q9eJP32ID0Idx4mWKZcC7Z9dQRd/O5FNz+A==
X-ME-Sender: <xms:e5FdZr0QW3TTVS_Sr_wx6dIpbxZjLTXaC90bVT6rgYBqhQiFpV4C1g>
    <xme:e5FdZqEKAviJ_BA4NciQjbbjhAWs4Qg10gpJmdfy8pn4dABWye2Ho2RkXNCkc4kO8
    c1-SR50rOh9_0w_nw>
X-ME-Received: <xmr:e5FdZr6EN9Cu4OalwMKXNNzMamURg29uEwKZCGQo159vnQFJFB5Fxi2bftkCsAsfWJW9VvsAWa984r4Mdnq1tMxKHPksF2mZDs1V1c52055J-3s2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:e5FdZg2l8fBFUZYtI90IzwN4q245kH7kB4k04cBnb9OlU2vKKJZJdg>
    <xmx:e5FdZuG4bFuh0f6b_ELVSDZHjyiGKS50po6q2qdVutE7h7azZM5jSw>
    <xmx:e5FdZh96t6mfybYCyj617hTQ9uGHKvnXrntu-qMNmNBNkeQKB5Ag3Q>
    <xmx:e5FdZrlqCAQaxreuUn2MDf3P6vyzXbJjDO-2_xyVrQW8o1XGbWNScA>
    <xmx:e5FdZgNl4S32XYiLpj2X2ljomylTpLc65ai6jkaz-6zW1LLEZClwgh8K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:48:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d96881c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:48:17 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:48:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 28/29] builtin/blame: fix leaking prefixed paths
Message-ID: <7ee87344377cecb8744698d9690191b156fe9b2d.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VcNC90LoT63Wz1Eg"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--VcNC90LoT63Wz1Eg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `cmd_blame()` we compute prefixed paths by calling `add_prefix()`,
which itself calls `prefix_path()`. While `prefix_path()` returns an
allocated string, `add_prefix()` pretends to return a constant string.
Consequently, this path never gets freed.

Fix the return type to be `char *` and free the path to plug the memory
leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c               | 5 +++--
 t/t6130-pathspec-noglob.sh    | 2 ++
 t/t7010-setup.sh              | 1 +
 t/t8003-blame-corner-cases.sh | 1 +
 t/t8008-blame-formats.sh      | 2 ++
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e09ff0155a..17694410ed 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -687,7 +687,7 @@ static unsigned parse_score(const char *arg)
 	return score;
 }
=20
-static const char *add_prefix(const char *prefix, const char *path)
+static char *add_prefix(const char *prefix, const char *path)
 {
 	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
 }
@@ -865,7 +865,7 @@ static void build_ignorelist(struct blame_scoreboard *s=
b,
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	const char *path;
+	char *path =3D NULL;
 	struct blame_scoreboard sb;
 	struct blame_origin *o;
 	struct blame_entry *ent =3D NULL;
@@ -1226,6 +1226,7 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
 	}
=20
 cleanup:
+	free(path);
 	cleanup_scoreboard(&sb);
 	release_revisions(&revs);
 	return 0;
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index ba7902c9cd..82de25d549 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test globbing (and noglob) of pathspec limiting'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'create commits with glob characters' '
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index 520f96d09f..d9add2162e 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'setup taking and sanitizing funny paths'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 731265541a..6288352f57 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -4,6 +4,7 @@ test_description=3D'git blame corner cases'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 pick_fc=3D's/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index ae4b579d24..fb5d225a67 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'blame output in various formats on a simple case'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.45.1.410.g58bac47f8e.dirty


--VcNC90LoT63Wz1Eg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkXcACgkQVbJhu7ck
PpSeWw//W2YNasRWXb6uT8j9xr/kRv+BLpbFvme9C09YF+BCFYA+5ilK88xqlFRT
HBZb60r/4eDv2x3mjf4vEYFyWRWYwJubYbN89THbiYXgqeMz2ym5/YedosmVannm
l0UwLeMkI8A/LtNI1Qa5V0B75vmWLRSZMhYH0nwWOO5GrYYCkrLADuK8igAebNez
A0xpKggnH1wewMr9lfAmGwo0ubnJWjd9gRfEa371R0/h5f8btv7kIPmkXrlKtitB
mfQd+Xztx2cxzn3TE6HNFDUtrO8pZm47LIUfIAJVPoSXdUJI98a3rvUh2fOfo3Ij
+T/advGaVKWr3s11KdfRBCwMBjbDZWh+685BLgO/xBkjCRnqJXVHzwl5WEo74qa0
IqUsKFwH9/2zBSx8SWTVNtZ+gtgSPl11AWPHeFmZZSSyupEKrwZYh9+ONsqQdX1y
wsJLyzQuPSOvNyeyfudfTrRs7MXyBtU2SSDpTvcnKbrXYTzVcUx9TFRdcAnpMB2K
tyqEH7g7D60GH2k/AQ2JPcN+A9ZNZgD4oUA6Gi4xJK/caEssjmENNUF2dbMqofIC
zHRxNtpMhcZT49nxM8xsgDGlyGtuyjY3LSbvtAwSfmFtPhiUqsO8uZDoTmfQR19F
bZwP1IlWF8wrr4oG8rwxQxQa8GeZphMM9/5kFdM5K71cLCGfmJ0=
=F0DA
-----END PGP SIGNATURE-----

--VcNC90LoT63Wz1Eg--
