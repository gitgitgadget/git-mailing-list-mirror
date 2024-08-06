Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1B18D637
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953681; cv=none; b=Jbb6gKHWCRcbZ9OyVbC97gTCpeVItA92n/PTbkWu6RrpJ6c67fSqr4+KfJuY5w6ao3iJr0g9YlS6ehKQgyg1MpckhndqNyOwMKku1BU/IhJP0qhjAtaJE03Pg6O+ZIO+D5GQ2hbPoh5/zqqgdh9vxPjDnEFKCoTsqhtyYIhi6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953681; c=relaxed/simple;
	bh=ynKGghvxnQCblZM1ugB6JH5Zk9dzr8HWVWD5VPHboA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5vrnJggJMJEGhmy5vpGPL5M7eYqPtz9LSFkf9MKn/skHqHmBq+jeq6FPq0kap5hhimOadUqbox2ZrW63+ulrhNHOgDlNDqrXw0t+Lzpf8/u4c8JrEv7kk1mJ/IE+QuNlcATgLkdGRt4O0ELjIhuLoKDGeZX5sXeV270M6eXNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h44okuqs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pYvmDbJt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h44okuqs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pYvmDbJt"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 911D0138DBA8;
	Tue,  6 Aug 2024 10:14:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 06 Aug 2024 10:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722953678; x=1723040078; bh=CQxjmf2xl8
	63CL5ixot29dBBTA2ca3v9xEVLijmGILc=; b=h44okuqstzYqxP3wK1l6WcCFqN
	BWusod9FVraTVRn5SFE1J2tEEGRRK1PofsZ2jnoi/t/KaDO7SOpOjT5IKKEPAcNc
	zQAYaj8gRlPBnDodcDoCmdHZ9jDZg2Uyspl+B96n+c5WIdatFdIjz/6MhBFlJ9nc
	BzeXcLwPVLyzzItVtJABUs1L6/cSZt34psw55WQHafLU80x+F2Hu3KGN+ZtZcHAP
	ghv7TDt7YSvQWunSJCTlT6ICs5ulGR5oWwRf0n7LBX07pE3Vv8qddER7E+Vmjslk
	leoaF99TqMHumIBgNcxhY2QnlNfyEl71HPVbJSNCLPM4wVF9Fx14FAnPbdBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722953678; x=1723040078; bh=CQxjmf2xl863CL5ixot29dBBTA2c
	a3v9xEVLijmGILc=; b=pYvmDbJtlCU4inW8Gn9Wg8BRC50qvCuIxy0wtpHgV5Xm
	aUU3oPe6clbgso66gaaYrDDkomocACc7edHW57KMnSVyAYx0Fp8a9VrOczDOOA/2
	CP6Rpv+///FWwOEfkfr8/gx2AP0vjiMky6rIBI338gkhv9qdQ5W+CQGdCd1S3NBV
	DjfbTDm+GwtSZ9HHwK0/TDbz122fBGDxIdzVetxHbzEgBJ1rd5aYDUZTE/Opk99m
	TcHEsbnQdk87Jhk2aywQ/XG5YZMK/n+1Ug6MIZxLqIr0F9L4jPxVMJIGSCz6JDBn
	7doTaI07y6H3xex4nxq1EzohQTrGHfDZFYOgyhuVKQ==
X-ME-Sender: <xms:zi-yZmikD0r1z9N6W3diD9rDqOw_6DufDRrFhlx3rfRkj42spkPn-w>
    <xme:zi-yZnCMNJ5yRSk95H-UIvBQrsDPTSrbSQ58ui0sw5FWRdKOHCJtoE86MrGY55KD7
    BFEngvGjnsYJpds-g>
X-ME-Received: <xmr:zi-yZuHDLCFpEds5b1NMuRdJYlzwf6MGwCw20EhjxTjzkbwCyPPHvVbrCLrn1GFtZ_5JrBxp2_VgHTMHvn9bvxLsl2HUaaiuI3FYuWh4okyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:zi-yZvT4Wk48iXVn21grXJABxssNtiGoknmFq_aQpZcZSclguVaDXA>
    <xmx:zi-yZjz8mm3FIEDt3iE2am0nEby_0sumrhE_7EiN1OAdu-xYJIOHWQ>
    <xmx:zi-yZt7p0fmrxPvGmUcC_VNze7O4DGn96H0zWLn3rowbzLzM1Tus8w>
    <xmx:zi-yZgyZw4WAM-OI1guRzMezuU7GASHiyxgidTRmR5SLPymPChdMKQ>
    <xmx:zi-yZqlmiB9mCi79joy0Pvd8fFJKStmwpWa4htzbGIt66ccecKBfVFBk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 10:14:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1faec0f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 14:14:34 +0000 (UTC)
Date: Tue, 6 Aug 2024 16:14:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v2 1/7] t: do not pass GIT_TEST_OPTS to unit tests with
 prove
Message-ID: <78a9cc116253c8c638cc430bd0a842805105648b.1722952908.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1722952908.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P9Fb+jycEn20Q66K"
Content-Disposition: inline
In-Reply-To: <cover.1722952908.git.ps@pks.im>


--P9Fb+jycEn20Q66K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When using the prove target, we append GIT_TEST_OPTS to the arguments
that we execute each of the tests with. This doesn't only include the
intended test scripts, but also ends up passing the arguments to our
unit tests. This is unintentional though as they do not even know to
interpret those arguments, and is inconsistent with how we execute unit
tests without prove.

This isn't much of an issue because our current set of unit tests mostly
ignore their arguments anyway. With the introduction of clar-based unit
tests this is about to become an issue though, as these do parse their
command line argument to alter behaviour.

Prepare for this by passing GIT_TEST_OPTS to "run-test.sh" via an
environment variable. Like this, we can conditionally forward it to our
test scripts, only.
---
 t/Makefile    | 3 ++-
 t/run-test.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 4c30e7c06f..d2212de0b7 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -68,7 +68,8 @@ failed:
 	test -z "$$failed" || $(MAKE) $$failed
=20
 prove: pre-clean check-chainlint $(TEST_LINT)
-	@echo "*** prove (shell & unit tests) ***"; $(CHAINLINTSUPPRESS) TEST_SHE=
LL_PATH=3D'$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE=
_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
+	@echo "*** prove (shell & unit tests) ***"
+	@$(CHAINLINTSUPPRESS) TEST_OPTIONS=3D'$(GIT_TEST_OPTS)' TEST_SHELL_PATH=
=3D'$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) =
$(T) $(UNIT_TESTS)
 	$(MAKE) clean-except-prove-cache
=20
 $(T):
diff --git a/t/run-test.sh b/t/run-test.sh
index 13c353b91b..63328ac630 100755
--- a/t/run-test.sh
+++ b/t/run-test.sh
@@ -10,7 +10,7 @@ case "$1" in
 		echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
 		exit 1
 	fi
-	exec "${TEST_SHELL_PATH}" "$@"
+	exec "${TEST_SHELL_PATH}" "$@" ${TEST_OPTIONS}
 	;;
 *)
 	exec "$@"
--=20
2.46.0.dirty


--P9Fb+jycEn20Q66K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmayL8oACgkQVbJhu7ck
PpQP7Q/9H77w3+FBr/iZWEKQeG12wSubCXprYsLu7NMfVsWxTEoKxPF4BHhQBX2p
cE6QURtpbmKq2Xy3L93ytHBeEgwc6L+DSGg+Lpbb1SRWLX7UMx8OXSCQT/rzlF0b
YMMIMjKsT4QqkhnKpV6sXmoezKFus7bmH4TS6WHWZks4cu9qVjBw/wnqseXJXMeP
ojrK4TniJXz7KUe5Psj8vgVvIgjL82rHcDW3y9AVHkQRcAhDb9FP35BsR9XaCrDs
qS6CMQK1umxH4/ou62bQq705XifcfloJqUR8phhDnOIvlcHCAA16VRpz8i+/XLNi
5qG82z7PexzVTaok0tFhCrdVVfIkO/GpimDFfDXgD1fb0Gjr+QVqxfXY070aM3FI
GGZZrHn5iHouxtf+9Rb9HHF0y7PQFgFFdzmUTrLE5kHMs7J22ysDvyl81PVHlgJj
bSaUTJ5MxUEXZrof9mG6eXaEXE2SkcNhBxrl2U7xHriQTGtF+53yw7rWwAXkFmv9
+m9+bokCWCGl6SpgxjwmYMEkhl6V8+TRGc4vQi/eVWyO0obaTc7+KQKQ+t3T+C0H
W0nYWM6IKz9ruymkNzoGWXIT0nrYgtqCJGbb6vM9kobocXk3SLvcSvO9mhW+Tsoe
COfpufECtVg4L5xp7vLqJgloqbI6MqrfBDysKB7KkjMhSn6S71Y=
=dqjc
-----END PGP SIGNATURE-----

--P9Fb+jycEn20Q66K--
