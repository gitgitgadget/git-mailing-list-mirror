Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4AA146D76
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595734; cv=none; b=KsBu3a6UUUoghf7dJnBnaXDamMZHROhzsVsR21UZX0SgzZFMTAVhm7RylUkT63xrgWzLZOlYLQNCP+226K97DIVzE5VJftleh0SLGRXqsehXEzFikOSOpJMAd5GT6B69pPhOvst6TrKjhOkLYrGfqh164S/18TJkIHOMjq8PjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595734; c=relaxed/simple;
	bh=xWJOfc864Bk7vru1mAPK8FXw8+h9n45qB4ToOyJz/A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtOYPkd5du6hyyh0J4QNO3G41htj8MvlINwotsKcc86LiUTOXIYTZ3WwR4yqjMKX1b8RivcolMrPbrOyRox5by+qLCwNIRRZVmji843jaRBYmMrZmHez2AFGTOc+1fd6ZqO2SYbVkI16oH7mXDAfxjVdJmdMO5GQBLRdtQwRG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LO3h1cRn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KkaPkKBK; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LO3h1cRn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KkaPkKBK"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1834B1800076;
	Mon, 13 May 2024 06:22:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 06:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595731; x=1715682131; bh=1q8INptvvm
	EodmPr7DQ/PNMt/0rC/CZE0a1/eh86yfk=; b=LO3h1cRnIZ2ZxEB0MPn4v0jt34
	NW2DNz8Rg0gtfbGMnPlg34OhY+vtkvxezPLQwdSbhsqamb801Gpnuy9YUCy/u/lK
	mddpl0K705FTVM4qKl/qB2mTq65TefeYdETTf4qN0C/2hVog05vIKUfUxuGATrWP
	GWO59OnSPo2dAu7tU4Pm0ZaD026DCC0nUHAypidMDnT6EWqeFHPn4fy/wRUiMelg
	gBvmCuRhJ+Y8y53dlS0yEiTSWsY4KhmWUN5Mccx1oYO6KTfvofWvoP8gC4h0fLin
	NDrgF9WmVzN/7VB6TF2JX7Qn2vZOSTB79WB9dMuDbmTXdR56yjxaa+HPK11g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595731; x=1715682131; bh=1q8INptvvmEodmPr7DQ/PNMt/0rC
	/CZE0a1/eh86yfk=; b=KkaPkKBKy7L4Xa7BNTd5a6jn7m4FOkg5mpNIlPfiG4sd
	7a1YLsSy36he9cy2jRs43aqsToK//Nggfkpcad6SLjwNVazZAOtjG7W+sJofa2lc
	bGuPMA8PDNistcBwLFhk2dHC8sIUWpCdH9YGnJowbkoZzKFAMq9Yb4U0zq+krS21
	AtSd9Oeit0byiPCV9xfIoFbeQgZhZEaXaGB042cNvl0DVVEERqIdNVoOKU/9oRuo
	B91pyVXiLjnkvY96qo8op2culcz2eaYYQwrnNsJEFd7o5EON2SPhdOpS4BrthDKQ
	/2vXXzijrOjSiou958kgOsJQ9KwHkds50yl7tpI0wA==
X-ME-Sender: <xms:0-lBZmcyRbpzKIyjdM7NuBvd5YKp8Rz4vaq4S9PiYRG29Wuko3jUKg>
    <xme:0-lBZgMcqYtTnn7dl0HTW_fX1TZXLcbGqWMtvgGhx93dl0XjNSDW0MI0nWblnhZQz
    m0Wx9JmMUB0xcRVgw>
X-ME-Received: <xmr:0-lBZnj3T8rKkratjmDPG-jPzhU9n22zH5cRPsSInDs5SVL5zCiXT_u-i8ZqTZ_FQ_fCZFs66pjMCdjxmHqrDGKCdOkMgdDw4WyYR0YCrnajexs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0-lBZj-a5XOrxHDfzCSZg8MZ4UH6T6wUaWh-KT3-wXzL48oScWbWSw>
    <xmx:0-lBZisLr7Fhtw94Xd-pvOPUzhIHg19P8MVavrUp6gh4rqLYk4UodQ>
    <xmx:0-lBZqH_GgJBZ80oQBfva2dhpFXQbEOi5OU7OBaERZVbqx6eZCaFLQ>
    <xmx:0-lBZhMPM-Cje54gadmoBO_g5S7s-hoXrsdcEGRZqLbJyHZoJFRw9w>
    <xmx:0-lBZkJNouxaoSdtaZeT9VK8NCIQ5hgJh6Khsia4mGnmkxHUPKcGBCj->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 58c8a9ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:21:52 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/21] builtin/config: move legacy mode into its own
 function
Message-ID: <663e1f74f82b8c1acdd0c35ad87736c071eafb33.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P1L2TQ8J5KqKO0Pc"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--P1L2TQ8J5KqKO0Pc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `cmd_config()` we first try to parse the provided arguments as
subcommands and, if this is successful, call the respective functions
of that subcommand. Otherwise we continue with the "legacy" mode that
uses implicit actions and/or flags.

Disentangle this by moving the legacy mode into its own function. This
allows us to move the options into the respective functions and clearly
separates concerns.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 3a71d3253f..f6c7e7a082 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1069,31 +1069,13 @@ static struct option builtin_subcommand_options[] =
=3D {
 	OPT_END(),
 };
=20
-int cmd_config(int argc, const char **argv, const char *prefix)
+static int cmd_config_actions(int argc, const char **argv, const char *pre=
fix)
 {
 	char *value =3D NULL, *comment =3D NULL;
 	int flags =3D 0;
 	int ret =3D 0;
 	struct key_value_info default_kvi =3D KVI_INIT;
=20
-	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
-
-	/*
-	 * This is somewhat hacky: we first parse the command line while
-	 * keeping all args intact in order to determine whether a subcommand
-	 * has been specified. If so, we re-parse it a second time, but this
-	 * time we drop KEEP_ARGV0. This is so that we don't munge the command
-	 * line in case no subcommand was given, which would otherwise confuse
-	 * us when parsing the legacy-style modes that don't use subcommands.
-	 */
-	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, bu=
iltin_config_usage,
-			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_=
UNKNOWN_OPT);
-	if (subcommand) {
-		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, b=
uiltin_config_usage,
-		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
-		return subcommand(argc, argv, prefix);
-	}
-
 	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -1306,3 +1288,26 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
 	free(value);
 	return ret;
 }
+
+int cmd_config(int argc, const char **argv, const char *prefix)
+{
+	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
+
+	/*
+	 * This is somewhat hacky: we first parse the command line while
+	 * keeping all args intact in order to determine whether a subcommand
+	 * has been specified. If so, we re-parse it a second time, but this
+	 * time we drop KEEP_ARGV0. This is so that we don't munge the command
+	 * line in case no subcommand was given, which would otherwise confuse
+	 * us when parsing the legacy-style modes that don't use subcommands.
+	 */
+	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, bu=
iltin_config_usage,
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_=
UNKNOWN_OPT);
+	if (subcommand) {
+		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, b=
uiltin_config_usage,
+		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
+		return subcommand(argc, argv, prefix);
+	}
+
+	return cmd_config_actions(argc, argv, prefix);
+}
--=20
2.45.GIT


--P1L2TQ8J5KqKO0Pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6c8ACgkQVbJhu7ck
PpR4ZQ/+MUcaKNPevqP4L8ApYudh7XvJsOAnogGf2ASdRpUpMoZVLiSf7lGtECb/
xNbIZPLt771gOWG48Y25KBQkLHPUGx9ZZ719rd2JfLqjkznwol+Puequdx28IwJz
NzCaKIO76bxi3gdsp+4+OijFgNDTDl7GTPx7UUfySNEpQ69mxQtYSfXbzPM5suDr
Hi/G7n9MGvgvOBqdptvnEqI7JE1B4/Milu1v9McbQ3mS1AnU5c88r7cObQPNIskG
9vcriMRDNpz/EQ40v7Lgd0NvRX4ehkgIZdkynhpprfzirCyf82iYTSQ/R5I3/fsa
yUBYlRNFOVvy/HihXY4ZYau1IYquNicnyYDT2PcLgY2fvFpIWg1qZB19LWzU+CR0
bOcmjZjzpjY+BTqWDZn04PsgqueMyBnfGKsoncx3sPrYvCW0bcaNARxejcs0d3i6
9zLa0XQtSjUfG2hXSAuCSh4vPjqxsJaWO7pG746eNqGM9rhGx0RG6EamV1LXqHGX
Uljf1QQ2pj3gGteCnX46OHOiFotdOk2cjonzAPUN2i0zEAmjIM2V60zsKZQKGJfi
59yG2lOUJu2RDCiei5plZevTmK080dAb1SrUHVt0YQVs6URtZmqqJvLobwM7s1Dg
qPGozlCfZ+79Km1aRDcIevt2UU92hr788ZIDp1+yUrrvpCE58zo=
=1pYQ
-----END PGP SIGNATURE-----

--P1L2TQ8J5KqKO0Pc--
