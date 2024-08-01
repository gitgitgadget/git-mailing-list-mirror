Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8DC170A33
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508716; cv=none; b=TjWHicY9lL+pAlWeMgzohRzhkUmvhwdCl8QXWhQsBL9hl2zhSPOcY6yOUFZIJnF0En3JQ4H5Z3vdoWvbn0CnJqzyqiZZu45VcKRvn1VEKfu3z5imIzH97ZW6k3mlc0K143nKKAFNriRWpe1QUYHxdyiA29+oDMsJGkDRXG9HD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508716; c=relaxed/simple;
	bh=uMXS4ZDGtRn2npjYLU1Hf6wryCrN6ryHqh68Znoss6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5uCbLAlIyZC6iI87ejQ58vsI4nmAFHFpgf958S4EahOl3JNPmAnhIrVa2xZz+yKFdkWGIJnJRxQuRR6sejX5OlLvF4il4gnsUgfYiK2dGH5iL3zt6ugxHs+CJja5H71s7M5SnBILZsA7u6eOXVBj+r7peJHvbecYFne05A2K5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n74L809v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUV/ENi6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n74L809v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUV/ENi6"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8CB181388012;
	Thu,  1 Aug 2024 06:38:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 01 Aug 2024 06:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508713; x=1722595113; bh=WqQz/r8eUV
	G5acOxYvOKLNinczBnV7Jqpwj8zkTQ3Ec=; b=n74L809v2MXHcvSJibSWMxrd2s
	MJcMH58XMpCDCT0Ugg7it49q/fTWxiSTM/xNLrbBkNS7aoq/zyY2TCQsZlyhJzGB
	gIm62e+S9axM3i5gHT72rPJ8irO82o/FNlg8EDjzON5vAaj/8R6PdhHP9QExw4AO
	xnQASGoD4rLNrXzDxZMCl7zqJUNFh11ftyJz/MHbG6nkesqHlZPC8aah0pYC1meA
	TVVFjsco2VtksR1iOE2JvPIzSw/z3mz+qvUBBnIQGsUD80CrXe4BnH1bbgbOQ0f8
	TgqBVY86yckzdk9Rcx4TsInbVIo6r6MqGzadfHN2hnZ3iLZlpz/Tt0pEhfhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508713; x=1722595113; bh=WqQz/r8eUVG5acOxYvOKLNinczBn
	V7Jqpwj8zkTQ3Ec=; b=AUV/ENi6R1Ojakr0FcGLGm3H1cZp0RnEttd13NdzAQrs
	+/zWTxa7L+xthB5I79cB+1EBapnnXDfElcRfJNPf8Xdak271M0TJGhKazcNb1jlw
	2aHbaK0udUHF4q9ma67TC/gEmBmWwvHKKqOSL7RUy2QKULBESvIkV9+PcrIxvg8b
	RQBKawVlBzs2DFcvBN9mMaRtMLMKMe0zMVepa9ZgVeEO19QqFsBIbX32grkLRhJn
	oCOiltzj96gQ3SS3/+CxV10pU4IL8+kAguUbW0gXLkXckJslxty5CyfprM5qXFOp
	OG0tG+1rOxtcV0MYEqdaWYM1CxXUgMJ22LZbQN4Tgg==
X-ME-Sender: <xms:qWWrZnzsldN9Bz5uG-AJKDYCpHrCT8QOfSCOBxZF0mKAgZ28NsNVRQ>
    <xme:qWWrZvQ0k5sXWNg6AeASBMcltdtOvGDqG7C0sh1R11iMuOOJnbRThUR3XyyYM8gnL
    0hkkewAFo-TDIORjg>
X-ME-Received: <xmr:qWWrZhUckd8FvTZ62RkDXWout48_mEMhYlSHoVxHFw3Amrl563cTdKYnzquMc-P3DLh3uef2PKdMoY3h1suIMMkYfs6R35afHqFdZRlQzdkEDoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:qWWrZhg_Q-47CKXYDZVlV83AnS_KIaEwkaEEc6V78AQSMU7SH9eHKg>
    <xmx:qWWrZpAxtRMZmiV7t12VWRTmQHVUiqfHL3y1M7bLFrSbk66csppO2g>
    <xmx:qWWrZqIWVEBbp58Q5dE6eauXDQh4lxRPx9TnpcK7Dmpm5ghL3IJHXw>
    <xmx:qWWrZoDAGLw33P6NBsWyRnnyRWwpOyLfBn6JDKNYwvPVrBbxIrh5Ug>
    <xmx:qWWrZs4E-kRH2EKJs1p-Vt4YCD4FlraLS84doLQla4CD6B74sxRTDdUe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:38:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 592ffea1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:37:00 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:38:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 05/24] builtin/describe: fix trivial memory leak when
 describing blob
Message-ID: <6deacb8667bfe94cdb5995302490b977b7fd2e8a.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="swW747Lu7FpP3bn2"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--swW747Lu7FpP3bn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never free the `struct strvec args` variable in `describe_blob()`,
which thus causes a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/describe.c     | 1 +
 t/t9903-bash-prompt.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 2957ff7031..954929c514 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -529,6 +529,7 @@ static void describe_blob(struct object_id oid, struct =
strbuf *dst)
 	traverse_commit_list(&revs, process_commit, process_object, &pcd);
 	reset_revision_walk();
 	release_revisions(&revs);
+	strvec_clear(&args);
 }
=20
 static void describe(const char *arg, int last_one)
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index d667dda654..95e9955bca 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -8,6 +8,7 @@ test_description=3D'test git-specific bash prompt functions'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-bash.sh
=20
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
--=20
2.46.0.dirty


--swW747Lu7FpP3bn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZaUACgkQVbJhu7ck
PpQ1IQ/6As4DK+996O1+aa6aDmdJU1UONlWKFc09LezS881r5qXJGGUJvKmPSRvG
cSYn0dD3rxKCgNCHHcSo43l7kxHU1hxNBUvwxwApBls7Sn+ZCBYgSw0hKiwMRhS9
2GaTVB5pfVc6zQEjmMntSU1wTUroArhmefni4M741j1UrwcWAsPJFxcIw26MB7ns
xbZYFckKscFz4CHHcLIkWoxg5IRS0vHm0x5Q651DtUS18Ar1EnyU+V597t42rbF3
hmVcZLVpUeOTOAvhVna5gmlkpGm7m99HAwhPptu1NC3B7YiaDIxlOb/2bzkZG0e6
qHkRWuw8SawmMlNsx9iV3m7voRm6Vx9IXjLE9f9xhW37+bDXVoGpXho1zMBNjKcQ
Fd0A4pYPQWIRwY4rfCjHWiRLdX0DdoLMXll3BzHOFHav1YFmhrxhwudlIY8rJC4Y
WWNGGwW4S7W9qMayPb/8z8rfxR/DILDP5AQEFyTTTD5CAU2F91/46+360/ogrsuY
NrpM13o4640mo/zum1gJ4deYM33pj+HFaGeWyqW0aN8COgWdp/m+XcbwepZzhT7+
l+XlR4cb3pl3kEj0h8nwI3/Udh7wTXZAMomahU6Yt0LOMrMWVwUhACJi1Z616o2H
Tz8NCG10WUseDpgXKG+M+NmUvR158vk1a57cU7nvXD0w5sCOAR0=
=Tqkl
-----END PGP SIGNATURE-----

--swW747Lu7FpP3bn2--
