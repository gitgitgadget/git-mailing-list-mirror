Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BD152DF2
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810426; cv=none; b=ajJRutKak/1UsoF61TilWKqHUH78iFV/1p8ijIZDdWHtucC5Nzwtp7q6zhzuRopUW5gj2cwGDNHsSoocxwFwg2SXseiHjmWXOEQIyKANMoY8llqJsFbHJAtnb6hZhN1SUsN6vvqOBr97NsZ+FrLyeeT6CnUnggAxKoikfeyJHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810426; c=relaxed/simple;
	bh=PmA316NJ/7qpKJ735+/ssBzNOrYrsDUhLCxl4zQjn+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXj6J0Im4HpElnNx4jixN/4+ASQLjxcszDmIJxU0guCMzxXnnZeLBWlm+vXJgo8pX+fhkBY+oF28l7RakUp3JbTV7h6iQXx8Z1iZrwfDTvw7lGvX3zEA5OARZhn+LFESW3ndAsygP4Ax3qcLWLCzPAu7sx0NHZwl0hMJxFKie0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b9UoFNVI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OOZcqsV+; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b9UoFNVI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOZcqsV+"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id BDFA41C000C8;
	Mon, 27 May 2024 07:47:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 27 May 2024 07:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810423; x=1716896823; bh=Q9oS7vY43z
	VrV0QFJDCvCT/EUmf36M0mkn4MXXLj+EE=; b=b9UoFNVIamb1qUmFN+cDBJx/tj
	MSUf6fQESwAgRPYdQR54HKmdHnb08o1oGsoKf3XVAp86FB0PDCzrPd1JUKnNoXPC
	83OWBlTVqA+2jnO8FnNupW7cjadxDYw8gc0aMGHa3P+M587Ti8N9bgAfoW7bTSNr
	WHfPn9qGqQJ/1TylFL9TPPfuikev4kuqDi7qYFqf53cc3KkGa8Qli5DZsf60Bh2U
	K+98v0zPHgA75Ee7md35RZlDDEqqazUYL2QIrUyvnhG0iJJCx+PMLL3BGHJnKeDc
	XOtlCpoSAclUhf8n7jjm0DKUJBOaMom1dl4ggtjKljttgKmiE7qt5jCRPPIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810423; x=1716896823; bh=Q9oS7vY43zVrV0QFJDCvCT/EUmf3
	6M0mkn4MXXLj+EE=; b=OOZcqsV+xhj3pKrtW1tb4b0StFox+k8tR8I2BGXqn6Hu
	XDOZIqnfj/6ih5ZJpvrLvZnDMv/u5JYhdUuDmgjPL0ukqbnsbdjn1RZ84BAivm1P
	VJD0lge9zl2+F4Sm8zRO27Ld4dFBTLyBt8F86kGYB3KtmpPDRVbNt4f5sxpRrDoc
	WN3AH15a/9t1e2sy1OaoRpBuJY9TDalzmAz0Qx1+Fg3VRn5j2CyFwh/251E61T0g
	xjHZJHQ3GaZSc4bAdhJZKF24DNJGROOTts8N0Vz+cbZCsYLZmzJ739xsiE2BxKir
	W0h396OJjxtTKnfXqGHbJMm/RbOVgXGN4+QIQP/XZw==
X-ME-Sender: <xms:t3JUZqwPOF6iD237_7bFpCjQ38zBGYOVj2AXuqIzMSD_0mSZohu47Q>
    <xme:t3JUZmRQeV6ZO5S9XA9gwdCPzfPfQOLSwzcRdk6TymifW40aoowzl4UFHaxmynPmw
    azuufMDL84PGbwfgQ>
X-ME-Received: <xmr:t3JUZsVqcQM8dHfULu0NbcsQBOacuQeb3Al6972cGYSWJdpp9XKFhVHmesffBwHrctt_2cv9PogL9_njFdK2xzJnhH_SeEmgLxQDNR9YmDg1vc4-Ang>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:t3JUZgjgtuUOqN7-a6v2ZqpXhkWZUOohFFAq5ahTYp8quz3MPPjiYg>
    <xmx:t3JUZsBXyM-HkekjeEN1fv19kT6eLGNUGYPME9rTrSnujrlIFfR1YA>
    <xmx:t3JUZhJ5Cl0naZ0ymXc0mNB82hIfZpcMVos9gT-0L1iUYYcXpeG1pg>
    <xmx:t3JUZjBKcbHFsjgVZR3oItL82zmz85ItVb9y9BLE-IDrlxMaIqJ9wg>
    <xmx:t3JUZr7SXklaBAPKw9Cahdt-dxUgae04VjjTAF2Zu7SeY5F1J-d41Iwg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:47:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cd60e62a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:46:51 +0000 (UTC)
Date: Mon, 27 May 2024 13:46:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 16/21] submodule: fix leaking memory for submodule entries
Message-ID: <7c75a94756c676a92a8dc719f270c692dc5a5c18.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yvdk05chfDrIs3x5"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--Yvdk05chfDrIs3x5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `free_one_config()` we never end up freeing the `url` and `ignore`
fields and thus leak memory. Fix those leaks and mark now-passing tests
as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule-config.c                     | 2 ++
 t/t1013-read-tree-submodule.sh         | 1 +
 t/t2013-checkout-submodule.sh          | 1 +
 t/t3007-ls-files-recurse-submodules.sh | 1 +
 t/t7112-reset-submodule.sh             | 1 +
 5 files changed, 6 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index 11428b4ada..ec45ea67b9 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -91,6 +91,8 @@ static void free_one_config(struct submodule_entry *entry)
 	free((void *) entry->config->path);
 	free((void *) entry->config->name);
 	free((void *) entry->config->branch);
+	free((void *) entry->config->url);
+	free((void *) entry->config->ignore);
 	free((void *) entry->config->update_strategy.command);
 	free(entry->config);
 }
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index bfc90d4cf2..cf8b94ebed 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'read-tree can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index b2bdd1fcb4..3c1d663d94 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'checkout can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recu=
rse-submodules.sh
index 61771eec83..f04bdc8c78 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -6,6 +6,7 @@ This test verifies the recurse-submodules feature correctly=
 lists files from
 submodules.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup directory structure and submodules' '
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index a3e2413bc3..b0d3d93b0b 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'reset can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
--=20
2.45.1.246.gb9cfe4845c.dirty


--Yvdk05chfDrIs3x5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcrIACgkQVbJhu7ck
PpT5Tg//SindZ7k/Jq/FC392t0KosrVuVKzIL3K9VZ3T9WquDTpnnxPJ4ZuFukkO
zPEYSx2mMFjXi6hCaPE7SoI9pRFBl1t7+DAnkGIil8BMMq6vaSaxRjKReByc/LYl
ZVybIL7XZMquIZsjdChLNLkxeb53n7CoEmFT8SbsScNFGfEcq85ZscSXONmWUU6U
zeza8FYTtwCPB1HHcbzkaTN/vUjESpPKdU+yXEkagM20M7ymmp9qHR6RYkHTTpZA
zTR821Ns5VI3pXf414LpF5QobEJYmyzwOZItJwU3XTt2nnciZWdvf4+kGcPi/WT9
BRuSrfO5xsY5GcJSGjEm46zA2WXmFheqfen/X7z+abQcAJ9m8xUz5VWI7aDXNHPF
YQIiwPhNcTc+y0EwXnDnbNB/SHsUGRdQvRBGsWyx4mXuzTVHBjfsoKBSCyny+xm3
Gqv/lueRUCKEpa9fra8aL7iUeij1W18R/FrjYvYW8F/Mc7JRFoCggSqRGXe4a7ki
bl5iEbbTY+xsHxSEOxGzUieg/3pTKS6zXrovArBCqpu3WU6pTl159qf2t4TDw3Wz
/BCiEaXj8PjcN9D212lcEHM9tEw4e+EUMHBGL0Rnidt1G9MoGhTz+EeRxSkrjg9O
A7KEKgEd+mUvMODwfs7cLSSXLx5Ixy36PCfOfLQ87SbmjDoRmV8=
=/WwD
-----END PGP SIGNATURE-----

--Yvdk05chfDrIs3x5--
