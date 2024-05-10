Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850616E860
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340308; cv=none; b=rzBdKUkSGnULsCN/bAwC6IDvaq+jqGYVKw6dV1eNqWyaqgLS3DV8o2TQtAqiwd/VTy4/U3v1vjMsvOsdYi0NAmDYzp0iS0V57Y/5QnDkyGMA5ftUUuYF02cHWJ8Vr0xqIcwUzlBWISa00zdSMHIpNE536Gjy5/P177dewmqYGGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340308; c=relaxed/simple;
	bh=lFCryF3X0vJ8ri0I1ZNnfJze2xDUvX9RbTxn6avgh7A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC81hNpJ69YUwyGNxnmxOne4LixuQsjMPTLvkhZclb/XyyNAu0IED8FyWQA5uieFvSJiWL2I9LZloVfYaFot1jvzPHgJvBk50QSLT8cxPOEAXT5SbGKfcfEHm9yLj9+PHJOo6ed/IL2Cjlig2vG6iYFdpV3SYR/CNv3EqzhHRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RiT8oSvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UT1FckdG; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RiT8oSvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UT1FckdG"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7AE4C180006D
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 May 2024 07:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340306; x=1715426706; bh=sAi23loKSz
	wmYyfRULjFsY3fPKe2U0fL6L1zDfM2JKc=; b=RiT8oSvF9RK+ziHv+tP69eZXZM
	Ty2q9PApOaHZoqe1Sdi/0xHWHCaHWOLMF8E2D2TZFgI9oy+KvQe2g43AQzaCGK41
	mYc6eK5CFt7wDwnAb4SROdZ7/8dtrxUjety1pEbwuMhqKKi4UBgOhct0o3/X7CXo
	aApd7uv75esI4Lyye3Actm/eFHcjU/Txd/pjl3D6FwGffRSUZzan/JVHfhRbM7Uh
	3qzxoXL3PEvH+C0naX4NG04uIQPMYj/2ixt4L/QavQq7oRp6eZ1IuQZcxirq2HCN
	D/FVn0XMLYpgi5t2PTpnsPmoB0hSnO8Nng4i/LZbyH2ignYZuNJ/EXJjgu1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340306; x=1715426706; bh=sAi23loKSzwmYyfRULjFsY3fPKe2
	U0fL6L1zDfM2JKc=; b=UT1FckdGvuzFcFjxvq2/UzKX/0cdFbxDBYyi83y5lpWp
	4qoJ8fnubm7fM4HFRdGYgbl2UbjiNJi/qnFtZ3tpF9GUpr1PNj2tUt4u243+w/2h
	957TXxdlsgB0glstALmxTc0T8ar31BEhc6odgqTmIWpxi9Wdy5G4pzn83qaiYQmy
	9AGDz/iWvWyZ/gWrtg5G/iLmAi4aZG6pTHfCPW8LoIewMf1Fw6FCm6mVMgsBcEh6
	ntnJ4DCtXZJzjCG2PNjxeDw7JRK4Evi2mnqCD4P2YqM6M/CiHKeLKnJNMwwu/iI5
	CzjT76Y4n8j+oTE1yoCFg8TIH1yW0xr9GaxYKy7jvQ==
X-ME-Sender: <xms:EQQ-Zk5j1KhY4o9EAEhKbJ0Q58xW7DCGlcrwysg-LBwb9wdN1PTHPg>
    <xme:EQQ-Zl54hCsaTGr21jOuou4wYp2zKFlqZuwpNQpfQ3O17wH7qHXsgteC0XBFu7xQ5
    jxT9Ev_jZcdpfOA4g>
X-ME-Received: <xmr:EQQ-ZjcMlP1XyUsduu8QZ58d9az-lC7NZtOK4PwUbOuLWjqYqaFfnX3nlgA9rbsCcAkCU1hO__5Z1JA_0w_WGS3WKfXqHcc2dsv-1VnGIG65KI7gSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:EQQ-ZpIJmjTCKXzqyiS4jHhoIY51v-yJpIfCl1RGl2-DD_B5JtZTxQ>
    <xmx:EQQ-ZoIDC3UuOWNYM4yrWxh1CNrHzN7z3KTPUM7Bbw-jFVAH6j3jFQ>
    <xmx:EQQ-ZqzmlTPry5RQyPMhe2CwisXRFiJJOKpFAmm8-nascXeEW4O_gQ>
    <xmx:EQQ-ZsJQP-WVcAtEov4OdDMY0GslccYfq2y8XIeEf_ePtpgDBX4goQ>
    <xmx:EgQ-Zij1PZ-UoEeiaum8z5XbUkwaK2wyXARCoY1mooylATkyTJHnU_AJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 26f70fa2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:24:52 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/21] builtin/config: refactor functions to have common exit
 paths
Message-ID: <6bff0410e99d59de8cc302f6b788af851b5e005a.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1EDPANfpv5ntbjQJ"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--1EDPANfpv5ntbjQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor functions to have a single exit path. This will make it easier
in subsequent commits to add common cleanup code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 64 ++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 9295a2f737..9b90eda328 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -798,6 +798,7 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
 		OPT_STRING(0, "default", &default_value, N_("value"), N_("use default va=
lue when missing entry")),
 		OPT_END(),
 	};
+	int ret;
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_get_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -816,8 +817,11 @@ static int cmd_config_get(int argc, const char **argv,=
 const char *prefix)
 	setup_auto_pager("config", 1);
=20
 	if (url)
-		return get_urlmatch(argv[0], url);
-	return get_value(argv[0], value_pattern, flags);
+		ret =3D get_urlmatch(argv[0], url);
+	else
+		ret =3D get_value(argv[0], value_pattern, flags);
+
+	return ret;
 }
=20
 static int cmd_config_set(int argc, const char **argv, const char *prefix)
@@ -888,6 +892,7 @@ static int cmd_config_unset(int argc, const char **argv=
, const char *prefix)
 		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparing=
 values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
 		OPT_END(),
 	};
+	int ret;
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_unset_usa=
ge,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -900,12 +905,14 @@ static int cmd_config_unset(int argc, const char **ar=
gv, const char *prefix)
 	check_write();
=20
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern)
-		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], NULL, value_pattern,
-							      NULL, flags);
+		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+							     argv[0], NULL, value_pattern,
+							     NULL, flags);
 	else
-		return git_config_set_in_file_gently(given_config_source.file, argv[0],
-						     NULL, NULL);
+		ret =3D git_config_set_in_file_gently(given_config_source.file, argv[0],
+						    NULL, NULL);
+
+	return ret;
 }
=20
 static int cmd_config_rename_section(int argc, const char **argv, const ch=
ar *prefix)
@@ -926,11 +933,13 @@ static int cmd_config_rename_section(int argc, const =
char **argv, const char *pr
 	ret =3D git_config_rename_section_in_file(given_config_source.file,
 						argv[0], argv[1]);
 	if (ret < 0)
-		return ret;
+		goto out;
 	else if (!ret)
 		die(_("no such section: %s"), argv[0]);
+	ret =3D 0;
=20
-	return 0;
+out:
+	return ret;
 }
=20
 static int cmd_config_remove_section(int argc, const char **argv, const ch=
ar *prefix)
@@ -951,11 +960,13 @@ static int cmd_config_remove_section(int argc, const =
char **argv, const char *pr
 	ret =3D git_config_rename_section_in_file(given_config_source.file,
 						argv[0], NULL);
 	if (ret < 0)
-		return ret;
+		goto out;
 	else if (!ret)
 		die(_("no such section: %s"), argv[0]);
+	ret =3D 0;
=20
-	return 0;
+out:
+	return ret;
 }
=20
 static int show_editor(void)
@@ -1195,41 +1206,41 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
 	}
 	else if (actions =3D=3D ACTION_GET) {
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1], flags);
+		ret =3D get_value(argv[0], argv[1], flags);
 	}
 	else if (actions =3D=3D ACTION_GET_ALL) {
 		do_all =3D 1;
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1], flags);
+		ret =3D get_value(argv[0], argv[1], flags);
 	}
 	else if (actions =3D=3D ACTION_GET_REGEXP) {
 		show_keys =3D 1;
 		use_key_regexp =3D 1;
 		do_all =3D 1;
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1], flags);
+		ret =3D get_value(argv[0], argv[1], flags);
 	}
 	else if (actions =3D=3D ACTION_GET_URLMATCH) {
 		check_argc(argc, 2, 2);
-		return get_urlmatch(argv[0], argv[1]);
+		ret =3D get_urlmatch(argv[0], argv[1]);
 	}
 	else if (actions =3D=3D ACTION_UNSET) {
 		check_write();
 		check_argc(argc, 1, 2);
 		if (argc =3D=3D 2)
-			return git_config_set_multivar_in_file_gently(given_config_source.file,
-								      argv[0], NULL, argv[1],
-								      NULL, flags);
+			ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+								     argv[0], NULL, argv[1],
+								     NULL, flags);
 		else
-			return git_config_set_in_file_gently(given_config_source.file,
-							     argv[0], NULL, NULL);
+			ret =3D git_config_set_in_file_gently(given_config_source.file,
+							    argv[0], NULL, NULL);
 	}
 	else if (actions =3D=3D ACTION_UNSET_ALL) {
 		check_write();
 		check_argc(argc, 1, 2);
-		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], NULL, argv[1],
-							      NULL, flags | CONFIG_FLAGS_MULTI_REPLACE);
+		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+							     argv[0], NULL, argv[1],
+							     NULL, flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions =3D=3D ACTION_RENAME_SECTION) {
 		check_write();
@@ -1237,7 +1248,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		ret =3D git_config_rename_section_in_file(given_config_source.file,
 							argv[0], argv[1]);
 		if (ret < 0)
-			return ret;
+			goto out;
 		else if (!ret)
 			die(_("no such section: %s"), argv[0]);
 		else
@@ -1249,7 +1260,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		ret =3D git_config_rename_section_in_file(given_config_source.file,
 							argv[0], NULL);
 		if (ret < 0)
-			return ret;
+			goto out;
 		else if (!ret)
 			die(_("no such section: %s"), argv[0]);
 		else
@@ -1263,9 +1274,10 @@ static int cmd_config_actions(int argc, const char *=
*argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		if (argc =3D=3D 2)
 			color_stdout_is_tty =3D git_config_bool("command line", argv[1]);
-		return get_colorbool(argv[0], argc =3D=3D 2);
+		ret =3D get_colorbool(argv[0], argc =3D=3D 2);
 	}
=20
+out:
 	free(comment);
 	free(value);
 	return ret;
--=20
2.45.GIT


--1EDPANfpv5ntbjQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BA0ACgkQVbJhu7ck
PpTLzhAApNDSlow4max1QmDJmNxJSLF802BiEDI87XXSBzEA1r2HgNEgBFVtssqY
M/TLVFr+fY6XhpiglgtWJTi/jqWm1I8+N+TdspB6IH8rXvDZJNbLkxSGKaqATuUo
FKmzY/iSa6BsYQZECgHPeYGzMlc7WJDDxbIF9bRBzil0djB3m2AcS5mOe8HHEUpE
OVawOf/rHiJlUJlnMfGPzT5R86074dFoFGXZqbO8AaFV1Pc1zUwvORhKTbw0zSGg
903o40lrVmEvGDEUoLrLxqyOK63EBVI+S0RMGoza47NiozTQPy4VggYlmIwfsAqf
+OEyc4W68B6jyBnzy7o4LejfbSbmRfUdH52Ud9MxEXqBZCcJGutj91yHmIgZkZks
gnMY207s9bAlF99hpks9/b/40enKSYELsYZu0D3/MSkB1mFeaEPXLx/jRtIdDwXi
mQ1OcIXRDaGa0/x0m7XdlOUuV9QvYjDo0dEc7ClkAQy0Vov+3ib/DVIgXVxQ0oPh
HK8j73zWiK0ysVmn1oYq/LjU0avvramaA9qMCi/Y8jL9mqtwd1BLijOk0Y1nh9jp
lkYziAHAig+nMFiHeAwVh2S6ditcBjVbe8lDaVn4kYFPUcPzydArqPVOjt6agVBC
5qiHrXzKpAG3b2ftqbgIR696jch/wBk2oJ0v/jCbBSDgaeE6kcI=
=5diy
-----END PGP SIGNATURE-----

--1EDPANfpv5ntbjQJ--
