Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBE18CBF9
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122382; cv=none; b=JALvNimGrOr5vpd0vD1xO6q1S90oK2vRmQ5/rNEsJDwJq20VEqMcEOpOEdaM6orbrHbhsVlmUvPpEHja9J9XlW3Vu4U2sPnr4R5X2oyGSaS87FSlFEQsmBBPgnnVQHbXvAgTRoQc8QOwDz1wzZIeHldTuuUOsJ9OBGLaO1MPzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122382; c=relaxed/simple;
	bh=sByQKiqMXwbOhLp5TBIp6n09fxJvHvchZOtBqqmHxLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aECPlXBUOqa5Xu6ZOUg28Edq/rGeAtM1vZS8CQ+8VM5vEIxFhQppyycC4BZQro6cjt0gKg1S8zYAA8CyCLs8gKtfw6fOr5ajkk0eVL+LYkS21Q8IbeJMgNRUmXwYbIHoLGcBo/MJBrlJ8dZbeuknLtfBZSEDxmE0164NPL70wZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DiEYx6b8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TemR8VXN; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DiEYx6b8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TemR8VXN"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1F2151151AB9;
	Thu,  8 Aug 2024 09:06:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122380; x=1723208780; bh=U9wiXEcjQY
	UnPW3Dk3F3BRl+Z38bS3RBcyTVb4cWE10=; b=DiEYx6b8Opam/72hDGy6yH917W
	pB9fRbk2ilrAaFhRxodUV4/VsqLer0Yro+S79VMEMooHEMJgOk58zta5B1UtpjDy
	tT5VCJcrNnURWBw3CJP/8L/+Tv3UZXli7eFq4bZBjVxn6n307+4OXJ514QydUkN3
	p2xbyV4E2/7734MGOm6OKCXnrShQRIHicAI3fLmR/odF+jMeLTGnTsgfGyGhrr8E
	OwlyjADRq+Af++Su20cJnsjY0Q2kiVnoyWBXpZM+3tmGjr2lriuqxzzXedefe8yl
	PUuQ+og2lZH8lhUtnZqz/NsL8W/vJAvJ3cmXwPBlyzURu1tKtHs1tmM5NmnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122380; x=1723208780; bh=U9wiXEcjQYUnPW3Dk3F3BRl+Z38b
	S3RBcyTVb4cWE10=; b=TemR8VXNHfpOb4QfD2CJI6tif5xn0GY5hduwj/atqHyk
	cXKdV0mEpynBglsq1gFQmaELJbS7MavtRQPkFpjKkHRKVvvE2sZ2uWSahgmtoztl
	FqvQuSVl4VNHwZdSeAnhx+1u2eiTb+pbwNM4nNfVllnnt2A2LjMHb7zS98sxzOC8
	+CX/G1tBKhCp7X2ezXtq62AAgZJ/v0ZOiR5x9BF4M8HW9TptGh6K3MNF+ZYmqvpn
	Q1Kl2uZnApmrwSrpuVxtWzeWxMW7VJKFG/VFSRHOzjCvI82i+gxSeBS+dHg3WdFR
	s8K6yVczQPZ1L8Hj2MAhNjdyOGzPkkrQvjlwa7XxFQ==
X-ME-Sender: <xms:y8K0Zo02_cb6XLkKZQavJ-62rmyHOXs0qoYd7veZETXA3MnNhH77Ug>
    <xme:y8K0ZjEExRBEFd7PSSmb3wd9mXHAjFU149IQTqZaxZPUoNuX9NWYnsigpthxg0fib
    63RIB8MaGgUygbMXQ>
X-ME-Received: <xmr:y8K0Zg4nM3h7Al0QL6UpGOzLBbnnEHw-ipjVNaEYo0ev6HFvvgIJyUbJfxJ3II7lLRq_Q4Ml_1Tt9n6Hbn5uZXndWim_rMt8NrfVg1fI_o4-QG1y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeduudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:y8K0Zh2hqYxMCNgDFIaO-kF1zE6_glqXneOm1h8zOvxO6luubhhz4Q>
    <xmx:zMK0ZrFr-TM903c7Nj6bQUsxFze1hCvFe_mJIRSYBE6fRMwbkmhYSQ>
    <xmx:zMK0Zq98Bn6o-dxsuYF9RfTcvDR6KIiB-VrQHoh7jrHG7cw6OtyOqQ>
    <xmx:zMK0ZgniuaInh6JEfElg8XwNWNHZltFoVWWfezCC0czhkpwvGbLwBA>
    <xmx:zMK0ZjApOuLS8-VJ3g9e6sc0Kb2LHzg4pIc9bUl5_GGumUkHzxXO5hwy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:06:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eaa67808 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:06:11 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:06:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 22/22] builtin/diff: free symmetric diff members
Message-ID: <343ddcd17b3e13dc7b8ab89f9c9c427bb2ed101c.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k6lqcfqwmLK5rd40"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--k6lqcfqwmLK5rd40
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We populate a `struct symdiff` in case the user has requested a
symmetric diff. Part of this is to populate a `skip` bitmap that
indicates whihc commits shall be ignored in the diff. But while this
bitmap is dynamically allocated, we never free it.

Fix this by introducing and calling a new `symdiff_release()` function
that does this for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c                       | 10 +++++++++-
 t/t4068-diff-symmetric-merge-base.sh |  1 +
 t/t4108-apply-threeway.sh            |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 9b6cdabe15..f87f68a5bc 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -388,6 +388,13 @@ static void symdiff_prepare(struct rev_info *rev, stru=
ct symdiff *sym)
 	sym->skip =3D map;
 }
=20
+static void symdiff_release(struct symdiff *sdiff)
+{
+	if (!sdiff)
+		return;
+	bitmap_free(sdiff->skip);
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -398,7 +405,7 @@ int cmd_diff(int argc, const char **argv, const char *p=
refix)
 	struct object_array_entry *blob[2];
 	int nongit =3D 0, no_index =3D 0;
 	int result;
-	struct symdiff sdiff;
+	struct symdiff sdiff =3D {0};
=20
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -619,6 +626,7 @@ int cmd_diff(int argc, const char **argv, const char *p=
refix)
 		refresh_index_quietly();
 	release_revisions(&rev);
 	object_array_clear(&ent);
+	symdiff_release(&sdiff);
 	UNLEAK(blob);
 	return result;
 }
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-=
merge-base.sh
index eff63c16b0..4d6565e728 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -5,6 +5,7 @@ test_description=3D'behavior of diff with symmetric-diff se=
tups and --merge-base'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # build these situations:
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index c558282bc0..3211e1e65f 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -5,6 +5,7 @@ test_description=3D'git apply --3way'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 print_sanitized_conflicted_diff () {
--=20
2.46.0.46.g406f326d27.dirty


--k6lqcfqwmLK5rd40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wscACgkQVbJhu7ck
PpT6PxAAlj3W/OQE4zFdo0uvOSF//BKpegQDZHatxoQCIdXt7lBFTgxhhqnQUT8k
GKu16TTYQoWBS6uM0/m10fRohMUwQPAzMEXqZNdot6yO9x99TFGfZq1iP08R1y1H
FgXWwLTKff4HGWoRRNDjJsy08MFVJj/kkByyXiyIXljTupz4nro1MFlKLf0EwYf1
2pMIx7+NBRIG8uYzQHuXFQSOK4Ni62H/BMrs9gBLXmRZrJIsc46MWgR1iB7zOSpt
LstocH8l30Sr7yi9/mNoNPbQlPh4CLPuic1dLx0LMwGILuju0ilccdVHkx9bCl6I
UUZXj4NSLTUWHizpm2x97UaZ6VgvjvPjfu9vEaddMV/qvXly5JavgzCCgvlqEZwG
8T9FDOKZLP8hnijP6yqAobrod0MDYAYzqS6tZhNUWyefyLMKIZmdnV4VqWnCm2Jf
jGvgWeydLYqOLC7KXicvdguNajne/zk87oRXEuw88Kj8vYvoj2evlNKR/1d5waRk
scHskchjAEEfQ+6Ik4EVfWGoZcjf6TSqXhBCDKmFd7gYiTx9ZjAhVay8VXhYIFto
BM4fZwOj4K0UcNOi6mtyAebMQht+GOmG3m6tjlNNVKWVQNMn4iDMF4ZyGt0MREtb
zR8BXdVkBHlGzrCEqU9/EvtZR7J5X5mVnjAiNJMPzgzRdRlGSuw=
=D543
-----END PGP SIGNATURE-----

--k6lqcfqwmLK5rd40--
