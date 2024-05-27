Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB715DBD8
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810416; cv=none; b=WjAqYztK6fZW32wmd1mvKoeDZcONzWmKZI51D/lP51Bl5umXd4KJyp3FxQakCWni0J+yu3OSesHnFd/ZBc88duycwm5LEvw6H1kemy+Vrh08EcnXQO8P6gJhnfHfg3nMF+ETOIaRvetmLmmwtVkVo1+84UW/SocDx6ReYnsA7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810416; c=relaxed/simple;
	bh=7R5ZlvTNCXKGEJXrFExF+bgnI/w9LJxPq7rLO+oRnyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZntVrMh3O/9g06UQZ1CBTzQv0ajUdznfZYTlTpw1hvB85nXzLOmz7mr98BIiNfctlPL31gej1v2eUyRJX1bXryXjywpgTGF8F/SZNWk2mlnPtB9NxPXe/rzm3AKSMcMpaE7704r/PZCfY4gdUpcISHyPuHCvDohjzWoZKzoUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jQbeyBbT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HXS5KBhg; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jQbeyBbT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HXS5KBhg"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id F29CB1800097;
	Mon, 27 May 2024 07:46:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 27 May 2024 07:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810413; x=1716896813; bh=xlTExEJObo
	4eH8b/JdHQW2kZvXikME6x3CW4Y1CEEok=; b=jQbeyBbTpilWsPvTuaKm7WH8fz
	tm32r7JnbG/a88T9Yx7ptpMpZQ5y97QzlKZRbtsU+dRobJkKjIAQsp3A6brx3oLD
	mUX/MfjrWKZL5QlTpXkh9CvDVY1V8yk5lNTmAXqs/F6T79ZrvzGJVoNMJsZBVkEL
	3IXswR0+TeBEeOCk8NqMXx8qgs8sCloXi4KEN9wUbIHma/+cypZ1ay8zkC//NNad
	JoAlbPPQkoNNLjgpF8sV+pwJWmolW/RfV4rhbUubqWSmDKMh0DT6ytSLx2McScYU
	lMXIYHLBJw7VQZzikpLjpXfCO1BCMDncAcg7/fs6mI2Bku9XiCLe/zFaK3JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810413; x=1716896813; bh=xlTExEJObo4eH8b/JdHQW2kZvXik
	ME6x3CW4Y1CEEok=; b=HXS5KBhgZQ1eA9fibIntZGNfRmElVbpetu7SE7px/Feq
	0KtgahUz76hnKyGSkl2Yb9Z4AredD4RslujGnEC4ifuEhm2StRKyLlPVwMAyf07i
	7Y6vGt8qGi665oCjoqGQrUfPp1FAnExvA6Ok1cwexNGwgGsOP3j+A9ynmato4Pqv
	dP81kKC7/7y9zpun6Ep7tXdGf95b4lmbuxu1V6OLqHeN1X/5eK4mP4z6zdVSPT2W
	4CXvStTIL9qG39nTByA+eOhhqoEcwL3J+kMqg5BNmaFDBIugA0U+moUk69BX6DFh
	eP2lczGtBT7HiL5AwxWK7USxsejditF/Jppbi6O+rA==
X-ME-Sender: <xms:rXJUZuQq2KW99fxajxETwAQXKgkyj7k1_0wGhsnccWWN1EuUVFksrA>
    <xme:rXJUZjw3uV1hV1hFhkmtPRQpUyiALTYp1HVTII8eTW0tJWBNQCreMo-Aii0FkpObP
    tkT3O5uKkInrXahFA>
X-ME-Received: <xmr:rXJUZr3ELDrpUAzA3kS7Ct3pJaMo-t07i5OoxIabp0xEol2i7Zg24SWijmjMGR0g0KDy-OKG_Od1xN0mewf3PeC8JzKsDIKhJkqNcK8nSAUiEDCyve4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:rXJUZqD-8IbDdUPvV4__zu6qtq7V_X7fViQr3kKMOvo9H8kIWESwmA>
    <xmx:rXJUZnjuI7HjQDwFzlRSrz5k3UXFJzTg6kevzhhJ-GcbHADkys9F0A>
    <xmx:rXJUZmr1EhyRVFPYMsU1QANci8tPA_TvsESG8Z0TOYmpqO_Y2jG1Jg>
    <xmx:rXJUZqhL5ZgA4faPH2ExRZUfXKCmEeXBlZGAQCh1Tz3OjgKvCfXTxg>
    <xmx:rXJUZtYtmk_LthJOoRA-R1-ul546F5KePY8ZOuBWapAgh5E-hb5BFilr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:46:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 765db800 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:46:41 +0000 (UTC)
Date: Mon, 27 May 2024 13:46:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 14/21] builtin/credential: clear credential before exit
Message-ID: <265665fe6cb7dc56bb637624910369f2bd0525e8.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ymVMg5F85oph3Fkl"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--ymVMg5F85oph3Fkl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never release memory associated with `struct credential`. Fix this
and mark the corresponding test as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential.c   | 2 ++
 t/t0300-credentials.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/credential.c b/builtin/credential.c
index 5100d441f2..b72e76dd9a 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -39,5 +39,7 @@ int cmd_credential(int argc, const char **argv, const cha=
r *prefix UNUSED)
 	} else {
 		usage(usage_msg);
 	}
+
+	credential_clear(&c);
 	return 0;
 }
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 432f029d48..6a76b7fdbd 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'basic credential helper tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
--=20
2.45.1.246.gb9cfe4845c.dirty


--ymVMg5F85oph3Fkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcqgACgkQVbJhu7ck
PpRxeBAAnoVKmGs8j0VcsUmvD0j++Kqz/rVvIykPi3O6ULhxGtZgdhsQieG3k5HS
Z3gip+xf6h6qchOmMzshsHkydSkB7QNkDo70npurbkoc136CKSS2Dv8/E44BIRXG
0E3V12r13cv63EO17gLzamcGPrvyVWnc4l0fvAs7FHba9AiNeEPvzyMoZJayMfM3
i5jrXmenLqMqLsRclt3qv62IXuTsG3FoVkZ4DfPcjLFqxZPJ9esrsIxcg9y2fzUZ
HUIC4eczx0Cz/utc/jV014um44CG4JfeKc+UjaAxVUWIOOZUzi5128iJkBEF0MBt
J357RmKuuI0z/H2IGCjvsqp2fOIRloGOadxKQe5gMB8IfHpxTlEQuZVrIy9FGjUe
Md7ryy6DVVLucSc5aQ4ej69RHfY5lP/VnJzuMrH+ciMtMHWxkLBsLUd6zFwNmFSN
Idmn0X8A9P6XWwpci+n9HNlmkA0mt45KaL1g8YRH2egi2xAYjGkW9mqAkjpdJ3Mw
nHjIKaVej5S9P8R1/g9AeCXXJDJKyuKbEmYW8rAOtCwO4HkFeAJDSMp6zwETOJSv
LCUcnmGiqs6fg4Nf9jBFQkKYRSNWTRsuO978paPft9tBpvoGTVX4lrDKjYbsJt4t
kg1ektFYQ2WMnaGIUAi0WYrPI1F89zPB1FRV6+nB5ZQQLrGFeN0=
=VZHq
-----END PGP SIGNATURE-----

--ymVMg5F85oph3Fkl--
