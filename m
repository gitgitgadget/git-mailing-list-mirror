Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04112176FB6
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097663; cv=none; b=FSqPyTbxHDfG8+gZUPAMMhFxwVWLbwy28+VQhxuKGO7DdgTfxjSWc1c2IxJbsMNjjysWQZlN2AHCOZsDXdVQW7qm2coqUQPiQPSLhAC8xIeVr76V9e4XkYuWthvjeUmvMdWxUDxFkWTGuGPqoS+dU8aKg7ggqPaIIuiObpFNsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097663; c=relaxed/simple;
	bh=RhUTVrW/Dc70fN1pBK2iLqME9m5AKmGVOnjm1hQUP1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh9uHMbWO7NsbiH//gnQYcEjgg/bHZyj6rV1AX1XEwaaebNju3Y8AC9/18eiLkW7RaM/cPIJr3I7rbQW+7kWbVc6Nh461Ez+e+rnu5BNTmNcNvBhToeQdAjpuE6AfJXbxT4yQo9dNBsEdkApUndCMBFWAsOYB2LBM4pjAPs/BX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qa+0JcsZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z9k2eyvR; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qa+0JcsZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z9k2eyvR"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 575621C00133;
	Tue, 11 Jun 2024 05:21:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 05:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097660; x=1718184060; bh=iFbkRz3s7p
	UYnYR/nvCEbfi2L86U3Rc6FnXwgjSIJyk=; b=Qa+0JcsZtjw/Ek4e1d1TeyDJjK
	dmnnEm08A6mR2Za4nho0HdTJv/k9CDPeOFJIZWba+SPoD5Tl4pl3ZJT2Qc0osN3H
	vuDZDdo6Jqltk600V2Xbz8NG38K39c8okFlLoF0SHR0l4oNSgOquDhDb91fNr4Wn
	wpQoASp2i5j1wHjw6mN8awR31IFzwWZzAWII84YYFh754vCoAoDprPWRVF5Fkimz
	y7MzEOiVHxJwntPUmNu2yYGDzEhuAqk/dZwRud8pyBgTuT2G45aR3e3R/4lbKUMu
	uap76ldjk+izsPS76DOjCXSWHI9xSFqjQ3/g+lO7HQnSzs0wYDSb4wWIPIgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097660; x=1718184060; bh=iFbkRz3s7pUYnYR/nvCEbfi2L86U
	3Rc6FnXwgjSIJyk=; b=Z9k2eyvRrNkfZs8nusamyqbfbOA7U3q9kasDaUrkot2F
	4g0ZH7sEqMn4V6TlMGWK+BfHK3hadMJuP8Zxs/hNTV8wubN3j/MnceTDBqrUWGko
	WPPK1zG2Kld/S1HPXi1xR9OtIU1E4RFdJVS3r2cMRVLSeIUeFBO9zYDCMub8hyvi
	PK4q/uRSJBo1CwHEA2XUezh+dcqmMNDIDOEDJkKXBGVlLL4IBibWH0tiaqHrNZIA
	Gj5tFeCqHivl5AoV1iXPgc8WTA6YBeXQEmezJI8i7qOGyZcnzIm7DzBJ5D8Ot78S
	15e4iATiFxCVdSO6Zv0VrA4AQaePAQ0pmpt3tgJyvA==
X-ME-Sender: <xms:_BZoZj4eVoFYkYTP-cunViOAzPOYjCWsyUu6I3s951ZnrtwwxSX7Qg>
    <xme:_BZoZo6w9F1Ycnw4jOD2dqNXgI9newc_AVB7bO4e-ziKg0Iobr78bgzFY0JHIJcuC
    WntDsneOXUrvaL1YA>
X-ME-Received: <xmr:_BZoZqcYF7Z2tI3y_7FdY7lcSwMamBiYHvaiBFEaGFL2aK-0zJ0QQzfGztug7HpsTKVUgGSy8OMQ0wa1zRC8ysT3U0pHpIh0M-gUE-sQeq9FXUImLUlj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_BZoZkL10hhzqeNhZVYy7kibeoRaN4pRwJlZzIpuX7YI0z8456eXOQ>
    <xmx:_BZoZnJ9R6t1J_kYWl6QqD2R-iEMcZZGmCQlSd-6st2ypuISfhNtkg>
    <xmx:_BZoZtxxIyrhJLsesXJqH2G5-CmPQmsb6krKxJ14HvnuOam3mtDH4A>
    <xmx:_BZoZjK00PpASDwJjjz6YSti93PKyslk1o0gxoDIKWHZCIZQ9XKYzA>
    <xmx:_BZoZv22vXCsw9BmsxEerhkkn7MH7TMWpGDo4vMuIw8niJeFBEBXWwAJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eaa467c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:50 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 22/29] builtin/clone: plug leaking HEAD ref in
 `wanted_peer_refs()`
Message-ID: <8090891bd048234b34dbe9c8384a815540e3d45d.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EIAMUwXcjiwfRsY/"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--EIAMUwXcjiwfRsY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `wanted_peer_refs()` we first create a copy of the "HEAD" ref. This
copy may not actually be passed back to the caller, but is not getting
freed in this case. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c          | 3 ++-
 t/t5300-pack-object.sh   | 4 ++--
 t/t5305-include-tag.sh   | 1 +
 t/t5612-clone-refspec.sh | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 730b3efae6..ae9863ed47 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -530,7 +530,8 @@ static struct ref *wanted_peer_refs(const struct ref *r=
efs,
 		if (!option_branch)
 			remote_head =3D guess_remote_head(head, refs, 0);
 		else {
-			local_refs =3D NULL;
+			free_one_ref(head);
+			local_refs =3D head =3D NULL;
 			tail =3D &local_refs;
 			remote_head =3D copy_ref(find_remote_branch(refs, option_branch));
 		}
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 61e2be2903..4ad023c846 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -3,9 +3,9 @@
 # Copyright (c) 2005 Junio C Hamano
 #
=20
-test_description=3D'git pack-object
+test_description=3D'git pack-object'
=20
-'
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index 44bd9ef45f..dc8fe55c82 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -4,6 +4,7 @@ test_description=3D'git pack-object --include-tag'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 TRASH=3D$(pwd)
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 3126cfd7e9..72762de977 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -4,6 +4,7 @@ test_description=3D'test refspec written by clone-command'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.45.2.436.gcd77e87115.dirty


--EIAMUwXcjiwfRsY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFvgACgkQVbJhu7ck
PpQ6HA/+Nf1MvHvlkkdH3Re4T2zjsYIGrJEee7lt69twUK8hVSm8+TBWa0izJ4TW
3+RYCFEhUwelolRXag+FqZnKMZHHe6zXGuRQZEVy02lUvAsHfAYNvar9ifBfYn3/
EucFPHj7SITY2ZyLTrNbekroAeZCPtNwydnkvX+ukQ45MwO+oQcke8/lSh1a7/0C
8hFKIT1ufQU8KeO8E0qbfZbAXfEqfwpOsQjIVFziR9JQVXjdO3p+UEppaFKlK5LH
JB/hPuSTllVuRapxp1MP+YG/l93kMguWtH7NJSOMYIHIo3DQC/CKeSY56oneqPU5
CDDtMR9MHIbmJPojuZbHHftcvrlW7R4W7C4nZvRWg8ozbKioGH/EO+FcKL63eOUD
Ibvx+AQu3ulsmGbmRBUjATpcmGWitzw2eC6hI9a3S8X3nvJ6oX/SV8lHKuP9yv1i
ZYUNN1/9vE4VRrOAFl7E77wy3Q56Cot8Av3EyfvBpOmWGFqsjzhoC97A6JKQgz8b
bEBS+dVbMJtFG8BCHJTZ+Xc8+gHPblP7NF/eQgaMzG7fE7ufDgVnQ95bcfVyfzii
xdbeoTh6vSmebuWncgWvxEapiDNk3jZakrxlbR0Ts5FB9TNQb/sMSAnDqpWADE+5
L0DJFNOdbIOZqOd0Pj3jqPR1BVCMwx0xgcVDPjQjVClLufAZQeI=
=6oX/
-----END PGP SIGNATURE-----

--EIAMUwXcjiwfRsY/--
