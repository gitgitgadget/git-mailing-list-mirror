Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE0127B67
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408003; cv=none; b=Qoo24PWYxC4Hs2AZqzX/JvUR1ZR08OYDxF+yGGxfBH/m4e+IrVf9du6ylD1EfXKvR8MJf/WbXFpUuAMZpYDlV9rwA4QIsC+FnHX68vrgyx+k/5r8K5FP0sL9bRr6G4uBLEiaPJD79vegyeGjGBa+93D6f3B4nzNdqGhWoF7gNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408003; c=relaxed/simple;
	bh=7OcRvs4ODLoQT/Fiqp6N2ufPGHJh1u0srE4wYrHqAV4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1oWCOFFJG/hfUrsc/A+xP50/kdK5cxTwa4aDwNEW6TjysmMvkpbSZ4afFS4evQmtNdMN8Xzz6aCA7tbco5KcgHrST/qZ6vpA0vn9HNjamA70/4ITTayZiInfVH+85i+OeynO059p8fMs/dHHhlUvMWX5S0ea8Tlj5xAxfQ1MBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JCFV+omn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4jC21nM; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JCFV+omn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4jC21nM"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 9F93B1C0010F
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:46:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408001; x=1717494401; bh=NkF6twfE3U
	HrVXDGjLf5IoyU1Pnywa7qXkGqAikbi3A=; b=JCFV+omn3SJlfVy26aJa4/rGUb
	cJAWxLtID7A3rglmexJVJctjgCpkcwHv90Ay4cDye+6KZnbSOy0iwSbhL/eLpRY7
	0Suh+qxuWvPTVsPiDw060VoSt2Hn0nCYjyOsHDK/OfPg9QvH7djRphEAT1pRHzyV
	QuCqWkAdOEdVvUKyIm3Y5kvgs9o70isCCNM0j5NcitRw4WLu9MUdJ/ThZADheFmo
	gOEawKPCFqTCQT075OknsxfOKe8ZIjGfjbkMqZ+TvIBH5s/H8PAlM8nWIeAtao/Y
	Y6ui1OMF2o1i5u3wIqJfVtU3GWUn4HwVKHb7PsqnSZEpy4Lgb1JifVWq2/4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408001; x=1717494401; bh=NkF6twfE3UHrVXDGjLf5IoyU1Pny
	wa7qXkGqAikbi3A=; b=j4jC21nM0FG3G9sR2JHguLCZEp6gT5xOAP3BNpYCS4oq
	Vw6B84vLX+KZ67A9gV8prNUvGik9lbNxQFTKp18AeLd2E/jpunGsvInO20/6Mxhe
	adCAM/Im60BkZkfHEqWXpxM1qY5/71BdMRA2yAAoK3o0hd6BDQkrPXZw0LDhZHkj
	YWq9rvRP54iHuM64Q+oT08iWwRpOBH9yzP5eWyRihwXtYBvedZG959EZ6LRvisjw
	RmdH1YJjkWSm7ER8a0VK8usDpd/qqeZEZi+beImABBgmYLxTIvz9Ya3wDpRh8EXU
	TJyyeYu+5Z0PNNg+zSTnPNcJa7u7GdtPGtI7Wl88Cw==
X-ME-Sender: <xms:AZFdZoxRFox3Jqkz8H6AgtyiSk5hColGp39fArygKEdDnK36ycVcjQ>
    <xme:AZFdZsScyo8BCgN1CCMfIZLaJFRZ3KXAdqZYqFVIzdNAKtBE6Y3IuJCC60Byt7Xf2
    8xuw88g4mv1Jqlrwg>
X-ME-Received: <xmr:AZFdZqUvLbZgcVhXZWhaRmtl27RddzCjYG7bB3adb45nsW8a_M-oILdgwN6LCrR40kHyuyllZ90dSAgx9GrQQ0G8W2-Lg41VAhZHmE71GtLRji8K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:AZFdZmjzCnEBg3zb1wYvpng43ZxaDrAYuGzjLVz0Lw7FF0PmZI2ePA>
    <xmx:AZFdZqDXfMi3PITAEZNjO-cidfRTBUe1zNPYT3frZCStwucEpFBwFQ>
    <xmx:AZFdZnIrSI-eUJTGvO7b_iGcE8ImBcb4nZBjVz5RDGEu22gX0EA1gg>
    <xmx:AZFdZhB9eDQBMcQcASq0iJcbk2wAiRSsSlH00HTn21DPXlM_HF39dw>
    <xmx:AZFdZr4D9kBQzjV4ApJhQHkdKfndf_hE6nmW9wZyh5kFLWPsPv5BADkr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:46:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a5903f23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:15 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:46:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/29] notes-utils: free note trees when releasing copied
 notes
Message-ID: <17a8f532752e005601b1cff5690a4dae16096b8b.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NWonvy2QRZnilILq"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--NWonvy2QRZnilILq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we clear most of the members of `struct notet_rewrite_cfg` in
`finish_copy_notes_for_rewrite()`, we do not clear the notes tree. Fix
this to plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 notes-utils.c                         | 1 +
 t/t3400-rebase.sh                     | 1 +
 t/t7501-commit-basic-functionality.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/notes-utils.c b/notes-utils.c
index e33aa86c4b..671d1969b1 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -187,6 +187,7 @@ void finish_copy_notes_for_rewrite(struct repository *r,
 	for (i =3D 0; c->trees[i]; i++) {
 		commit_notes(r, c->trees[i], msg);
 		free_notes(c->trees[i]);
+		free(c->trees[i]);
 	}
 	free(c->trees);
 	free(c);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index e1c8c5f701..ae34bfad60 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -11,6 +11,7 @@ among other things.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 GIT_AUTHOR_NAME=3Dauthor@name
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-f=
unctionality.sh
index cc12f99f11..52f5e28154 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -9,6 +9,7 @@ test_description=3D'git commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-diff.sh"
=20
--=20
2.45.1.410.g58bac47f8e.dirty


--NWonvy2QRZnilILq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkP0ACgkQVbJhu7ck
PpRGqA/+Pi1n0LvjC5cQeBVhXYXmdKaILe5Wx4S9Cpyli7yWF1dJ4KgyPRlV3dX2
QP7lnq4YdMIPkQ+R8nRf9f4KlNyuVCV3t/BKdqfWTI84YWoCUlTpfrpibJKc35nh
/3L0wMutJKGhvd4NQwWv3/oqexW16raWYhNb9yl11OnxZRdthiK8A+CFbJ3jSG7d
m5EpVl0aq3de6i1oLcQw0QGAywHM8TqjyDXSmxnyBKGVQRVQZ6SBFd+NVWHb4Icb
LHCj3xU3flEjbOO0QAr3mmCVmvMPl3QwQcpl3E6q4GLC6xjzt+qlCMTvqgE1Usgt
4upxt/9gqYP4ZtgRlagVZ+FLeK09U/kGaZDl5YriHsE3swOff/I55VbXIW++e2AQ
8sf0/OK2r1hgmV9kX6k/oxGeRuXxFj8WAJvOJQwR1ZiL5750kBDCZY6LD/3+rIta
NaAMuxMeKs/Wx08N9kbkBzQJ33kpNwXpYLHJWltxjjLCZGgnBi8ZRbcGB4PTimcN
QPBSc96wE9BXRbOVGLlFT4OP45FjSGXDg3Z3+CkiQD/a6myzqGiphBr8IjXzPf6N
3p4QZWPeW4CWn5E9t9i6LY3FM6rlb1dh4xmwzOx9iKermD74Q2vSs/Jt4Iy5xtkw
XhcChUG08RzJ7xhHnrpfy9dmIWtE9IuniTwLoetotVY5mAPFNS4=
=uZbc
-----END PGP SIGNATURE-----

--NWonvy2QRZnilILq--
