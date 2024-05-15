Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88550283
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755338; cv=none; b=JxIVFi4wHFu2acAWhElbuZVx2S9UCGnLqXR+I9IsN05lKoGprHXimGnxblD/R9yQqAQy0CPf1Sr7Q8tOMAryboMee1kSg32RCR5v2VnErHV9nkZaYyZVxxraXZCecCkoxmKVm35sI9cMHBHvcUoCY9sBpHqKwnMbzSWRgQ8OD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755338; c=relaxed/simple;
	bh=+isIhaK1+bwKBmO+0QMz0zHOwfnUaX4B534J5d1V8bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8eZrxkakyhDGN65AZWO778a6vcZBrOuzMqmBPi2nCWg1WJpaFzhB4VyTYZZlc4bErJbXmU0KsdbfzxEpBfrexLgQFdgokg45HHG8cl92mO8J7pId0u2WDsYQzRfpiGuYYk7wQ3tAg3sB2I2FpSm6Lrg594BSc+u3aSUh13mlpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AYb8hK8u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JRA17mIl; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AYb8hK8u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JRA17mIl"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id AFBA51380222;
	Wed, 15 May 2024 02:42:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 May 2024 02:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755335; x=1715841735; bh=mKRjbtgyhN
	xLkxWyQ6BSMq36p5F1wZlKh8HuFDXaOlU=; b=AYb8hK8u1C7h+lbGbqjbLM5utB
	20YPNj2H1ONDZoaQNxWIImXNjWG53S9BNBlMH5Uu0WvDD4jivVFT5M5rKAsyvQao
	dGZ1H0BSMqLOSKmg3oVW4gCR4XB/WDkeCoFMGmMcd1xz6RMiOZzRFIrTNclIOJ4S
	yHSDHYRBbQWypUZtRU+mJmpkznwiGnzb2rV7kMqIcdXqbYSuhjy4naKR426RN5t/
	mbek1K+m5i2evULgHdyA2xZrkxiS/BdpNajDtrqBZZA2PfazUufka3s/NUXAio3p
	yuEsHF5eutY8agy4/4hwp8utn5KMT7k00uZoRfE37GaLwjt95CbrkDGXJ3kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755335; x=1715841735; bh=mKRjbtgyhNxLkxWyQ6BSMq36p5F1
	wZlKh8HuFDXaOlU=; b=JRA17mIlabxebZQWo2E0t7SHcr7mefC2nXr572CRbhj9
	0B9LBIW/6HNtuIUiLdEQWcNdW9atI/zmob5WLOS0hJe1OTPbTCADVs/beyOzYcri
	wBRJSmCdtXY02TgRRVB1uSmn7FFdj83ajzI/01pyJ1XzcNclzhGhle+xafVk8Syi
	G28Tv9EUc2ghfn9Qj8sZtUswKclXT7S9HivrgHmCXJ33mHmDF+/JOaXDr3Ea6MD0
	oWUskFdBEUWpqTcEGDg34i/dH+Y/BRDyxqtzhVtfPVuOqNtvOwY0ymItFumKdGup
	sfMHKemkbqJBArH+vk8Tk5/cEa+zvrvkgNUuCjHaQA==
X-ME-Sender: <xms:R1lEZvLu5mYe_5L1ULEaLfzaCs6WqLCnE8_39EOvPVJj-1lIkmN0kA>
    <xme:R1lEZjJFD7abpXt4y-OcXPd-cKsnEaFlAvXzxX75VsgRNFTosFt7bWj1r2PTm8ORF
    DovVRuyRlyuSrbKAw>
X-ME-Received: <xmr:R1lEZnu6I1o56mKn3kDFgANI6rvw_Lppu_v3j56E7LNpEOe7OXWzCudyG-crgn-SepDIGKwNZW0K2Aw3by31t9cGsNMZH35Ytr_mn2z3r3UWheXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:R1lEZoZUCFNNuHaD87Eu_s1SDGCdu5zUDXgoJ5R1BZ73_Er7bakc0Q>
    <xmx:R1lEZmYlSDJIdZvAej3RjeWo0j5-rzgGhS4NlHym3zatJ-bnOxI4WQ>
    <xmx:R1lEZsAsQKmknA1e-UD4JXD9nEPCL-oUXBQXLLfWbt7xYUExxrDYyQ>
    <xmx:R1lEZkYfJezJ9Jdul5mOFRQ8dZWFsklKnL00jsfRcnQ6CTIdUK5Zlw>
    <xmx:R1lEZtUQRdMCnfOckUVT82mNGL6AhgHA_Fs_qlzTRG0rSr_ZXmZw7UfE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:42:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e963f88e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:41:51 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 08/21] builtin/config: refactor functions to have common
 exit paths
Message-ID: <9dc1d00f715a6ded4d87ec3ffbd2a4546d6a59ac.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uygZWJf9PcL42Ek/"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--uygZWJf9PcL42Ek/
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
index 9866d1a055..155564b832 100644
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
@@ -1199,41 +1210,41 @@ static int cmd_config_actions(int argc, const char =
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
@@ -1241,7 +1252,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		ret =3D git_config_rename_section_in_file(given_config_source.file,
 							argv[0], argv[1]);
 		if (ret < 0)
-			return ret;
+			goto out;
 		else if (!ret)
 			die(_("no such section: %s"), argv[0]);
 		else
@@ -1253,7 +1264,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		ret =3D git_config_rename_section_in_file(given_config_source.file,
 							argv[0], NULL);
 		if (ret < 0)
-			return ret;
+			goto out;
 		else if (!ret)
 			die(_("no such section: %s"), argv[0]);
 		else
@@ -1267,9 +1278,10 @@ static int cmd_config_actions(int argc, const char *=
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


--uygZWJf9PcL42Ek/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWUIACgkQVbJhu7ck
PpTJLw/+JlbFY8D7CVgmlukTo9SNPVwaw9fWwwZDNGBze58uF70fFy0nDuLcN8FX
YLucrRuQOYwEbFwHgXzPqpR1/WfXROz0ReIG5vR4I4ZCE5zKcIgI5OTqZd6j+/0U
tra7fBNQKY92plPhX19dlinjoJolEfdq4OBcqRVL5tuku3UWL2Zku96j2TwmY1fJ
QfYQYmC6kNwoNuSX7hh9kCoZu9jS8k01IGtnxSLi/kH2/gHH1/a2fSbCZ7Ubp7g8
PmCNtQw9u5gj++31nFFBKUv8APLBy0tIDgB8KdLi6RyTsMhv/TlHnP7iT0KYXsgW
RyvArHqGACmJNAQLL7+BIVnVoJ9SafndQ3KImkSbittJ0/6vcFqxvbp43mYuajGh
+p/iMqCn7uK9UwUWlcFi96ws2FsnoQ/9XvdvoEDPPasI/N8q9FFEiANL3fehk+gH
PqFGxWCdff+88rcNXL8LTdWt3WrDhFIwIYcyIOK7kKClnM/aNBrakzxP3hBLrt+i
PRHPMfzDJGsOPP1N5jQxy8/nZ4ntOQZ40reoPaDXxKLWvw6Xboxmu6mH7Tcw/T5c
BIQsYzvUzbq+eDJAMEY5ZZRaIaiUa7OfwIf+LBbq8xLqyXzVimouWUvgWwC3x/SN
VQ+WqgJs7330tfIAoFt0HeQSIcx9ajTaJ+Bc5Vps770rzdf3Jj8=
=ghVp
-----END PGP SIGNATURE-----

--uygZWJf9PcL42Ek/--
