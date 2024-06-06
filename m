Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9514E2C4
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669764; cv=none; b=gSuycf2OpeMR7nE5vNXbJpfokjz/NRdvxLY16IQ+wfJs1ZyppU4SP/m/tA/uQvei8Tg07++K0P+XOXhje/n2HExI00iTf3FmOpACPmxmgWjD3k5gvsQ5BdzHmY6b6yV9y+RHSc7zdSq8BpyK301yPmar/PK5er9ovp7jyw/E9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669764; c=relaxed/simple;
	bh=RWyD4Us0rSRfPUl5L54Vsl+P8U2Ucl0CEsP7jqZtS9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEWSOA6uu4zFow7gZVd8iXcNrxyssIEjWNtFrwSf98PeiCfo302vYb8+FL+wQd4A0gIYoTzdCZi18FCV6FilgufSXnpKL9s0UrB4ymkJ+8Q+2HZZWVjf1sBFRVvqf+K9O8cHUE4fymWkeFgbJ53p8DtdP/55oTAZ0Wv1WYiadkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IB4nk6SE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZyNH+DzC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IB4nk6SE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZyNH+DzC"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 01A9011401AD;
	Thu,  6 Jun 2024 06:29:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 06:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669761; x=1717756161; bh=vNU9ABrkKa
	V+XbzzgyUfcSYAKJsi+LkEfGC4o7zAoNY=; b=IB4nk6SESchiwaHZ0hlt2coFoV
	8p8UDavhuTFD7/gbjhI+y5gVaPM4QmV0BgoHEM+rXTLWv1En427lmU6dzW4hEVyI
	lzi3rqh2LnRytjvS/RUkVHbnd2/NnjP2jBY6T8NEW80pBPQUmyNaACkXf7/RnGwq
	sfKlL4NG9YksLFlMGLrQn4CAnq7Z/y1LWWA+PrVxhmhaV+lSUpLOBvALmM1n6Kqn
	KDzfc03b/zi2FF3qIjh2G8ub0zIFTeSkOWI/QxhD5OraD2k/K9EzX7CdUgok9C44
	13POQbV6mQeaK+PW1pH5YGTAslWkfIkropfDpKzDJ7ojyu1WjmKJCQHYTzxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669761; x=1717756161; bh=vNU9ABrkKaV+XbzzgyUfcSYAKJsi
	+LkEfGC4o7zAoNY=; b=ZyNH+DzCDrUeYinOUk7fQzIUFjfjPNqrFtvXnTly5qxA
	r1niDsLFlXyuk1LAOHqif1PLZs6R/Jselx7LcnSpzIGcyp+Kp1VEqRDdUErezAvo
	+JJzM9DIIs5XFtBNa+lnIrxk61+BjapkC32/RgAQ9+DRtIkXy1HTB4Ix6sa0UHEP
	iDqLYSoet7bR70f2Et1ZOzL131KvSFPMt4QtL96OsSPeAjHvhYlWJ1ezS9uU2++M
	Batu3+SCCEVuqomQdihKFT9JZt3mH/KVTam96pu/YmRzBND4JW5ETo3xkN0UpMsL
	2vDZaEdaTNo0qO4TV+B5S93RmzJMKukj7CtnehmCxw==
X-ME-Sender: <xms:gY9hZr-mkfc5zyNFSMqcPD4_BlXI7iUlse4sAxLtPEOqsNwlnPi7tA>
    <xme:gY9hZnu13eYKCczFpNZLFPvEEHfAW33moy_XhEmH5NYjX9PzXLTl1DE4EyKoprdk_
    w0P_a44HenB9PsDRw>
X-ME-Received: <xmr:gY9hZpAfN2wJt68gE-8rEKZ6js6m_xb3414JQET6wR-nHhmywoVWLvla518Zqw-yms-DjcPkovsbIYMjTmDVlxHVE96wfU4a9-UvU3_0uRwe2mWm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:gY9hZnc8d9eyEzjawJL-UveXKQ4UYWh41jiNTsBLR2wheLLsnGOWCA>
    <xmx:gY9hZgNtDwoSiIBZJaUWWxlARCdUNbteXWGmzlm0vFbNknpGW15puQ>
    <xmx:gY9hZpm4LL5nbo7ZsCAAZUXRAfnAoCwdkQ8zlpZtBMhdaKA4BnbUjQ>
    <xmx:gY9hZqugjXQsvF9QW7S2LaY-TKJEZ6ZXmThyYJ7LHel8sjhhWBzypQ>
    <xmx:gY9hZtp5tL_wU85rwGBxaX7Mou3vjpiuIhEQzE2Ohr3ex4M-6-z1tv2b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c5d3bb45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:50 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 20/27] revision: always store allocated strings in output
 encoding
Message-ID: <38fcea2845b16a6c23a0496330c538501cbc76b3.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T9J0ePSDmFXFvUNq"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--T9J0ePSDmFXFvUNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `git_log_output_encoding` variable can be set via the `--encoding=3D`
option. When doing so, we conditionally either assign it to the passed
value, or if the value is "none" we assign it the empty string.
Depending on which of the both code paths we pick though, the variable
may end up being assigned either an allocated string or a string
constant.

This is somewhat risky and may easily lead to bugs when a different code
path may want to reassign a new value to it, freeing the previous value.
We already to this when parsing the "i18n.logoutputencoding" config in
`git_default_i18n_config()`. But because the config is typically parsed
before we parse command line options this has been fine so far.

Regardless of that, safeguard the code such that the variable always
contains an allocated string. While at it, also free the old value in
case there was any to plug a potential memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c             | 3 ++-
 t/t3900-i18n-commit.sh | 1 +
 t/t3901-i18n-patch.sh  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 7ddf0f151a..2ee6886078 100644
--- a/revision.c
+++ b/revision.c
@@ -2650,10 +2650,11 @@ static int handle_revision_opt(struct rev_info *rev=
s, int argc, const char **arg
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match =3D 1;
 	} else if ((argcount =3D parse_long_opt("encoding", argv, &optarg))) {
+		free(git_log_output_encoding);
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding =3D xstrdup(optarg);
 		else
-			git_log_output_encoding =3D "";
+			git_log_output_encoding =3D xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^=3D 1;
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index f27d09cfd9..db7b403bc1 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'commit and log output encodings'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 compare_with () {
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 4b37f78829..5f0b9afc3f 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -8,6 +8,7 @@ test_description=3D'i18n settings and format-patch | am pip=
e'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_encoding () {
--=20
2.45.2.409.g7b0defb391.dirty


--T9J0ePSDmFXFvUNq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj30ACgkQVbJhu7ck
PpR05w//TiUlmUBWpLUXledD4IUL+3wpKAXldoHH9o3bt1U0qoJ0HlB6/DWMsTbZ
qHolvB58uoW5laYk13KhQz7xIMmiEBBYSLUvzY9yrDxmz9Co+Y6wU/LODVUlap6u
LmggKWCCjZ9ro/S8/vL4jOIl6QSGzqVikCYWuVquut3l7/823OB8lLvIEuHhhy7M
8jdRRsit7Rpc+zMIz9ZkIKp1Hx14j9Z5FDDJqxodcfwCI/BYgPRpIc2Za2pWAWWS
aQB4IWr0lcNj9AGXK1VQuMDoe1Bq44jY3vMXsKJfQML/Qq1TYWQe+FAZ0Q0VWKQZ
1SRqPn18rtq9s+nmBA72VLXQbhKuz9KH9vKTTOrm63jNdWQQqd6d7U/WM1dnbNZL
abwWs56QpA6FmrBLI96QmCk0i5CdxFW+dSsJnOwJuPMAsXl8LgN+9qK/QUIOl4kX
5mwa/QD5JrYNXmSNB3rYEq/PIASWPMopoyfG0fvQ/+gVtRuifZtoof7n+NXqOb06
omJ54mai4iGcne+8y7tPZ3lkYcFxNDQbIaYZUY7u0J3clZBXIqNWK7zhYZE6S/XD
p/DfAGT09sMX350nXPF6h4MG7TkuKkXkXC3EOMWna9lnf76wfvepHttJCU/K4MXE
RbYV+T1hqQdOVNFcantfWCt7FwR+nQsKp89WGbRvqa88JkZGbV4=
=jhok
-----END PGP SIGNATURE-----

--T9J0ePSDmFXFvUNq--
