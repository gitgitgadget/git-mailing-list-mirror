Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD881708B7
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340299; cv=none; b=dnuBfjhxm6cnYa/GN2MiKQEJ1vPqiImpwJDA59zs05iD70XwzLpc5zgTN/wtnOw2HlTVzKm6jkOCZ1LM5c5JUcSKZ30D/OV31+13mJ7vM7CNgr66l/CW65hFFA+iasFyrCrLwSjEg9ut8jO1gPcatY2MWtpKXjbp3dq0j7tiFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340299; c=relaxed/simple;
	bh=BHUQqySSHNFmrdsUpUoik7TcbOOpErpdyFp8NdWAbJU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrD80j6z5EgOymvtkUWgJWSN/m5UQ/GEbSLOHGTXl+bwrth7kn+8sTuy96xJUg2meMAOutbDqvofF8jUJHDgAV+KOhVlW2c18k/Q3KT4A2fvZLkflHf02qoJuaFPcKkVh9OgWajE38TQ8IH/fHUmD7FK12Bl0DaqPo3Ygx+RMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lfE9gskv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hNVzIQyq; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lfE9gskv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hNVzIQyq"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 7599E1C00095
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:24:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 May 2024 07:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340296; x=1715426696; bh=yXUUjlD/9Y
	tQZ9/5DOXjUVR3530sjI3w7Z8rW0/Sd1M=; b=lfE9gskvIlQ6pxX9zzBuxs/uFY
	bBRV9y0TjsKz3Ytbu46juyKq/p4+vh17w6Ig3ugb6CMBcpPqvN1/Jzpl/lAWUBE8
	wouP+A/VNZsM8nczcwe/cxoy1PHPzQE4SY+wtpe6tl43Q/q8QasFMZCGONnHGlO6
	rNnGblo8i21TKkpsrEyS/hPG536hvva+qfC0bfHJ7BdUVT4blkIVbA5irMKab9F0
	2jGYydJ8oqgaZjqPxZNVRaqIWNScEsvf4SNb7asFCvpafOHydjqdXu8CgV9wiKOR
	wA1Emu4NOrmW1PayzeYUhA09Xj1XitwYQulgpyTe5cVyHHs7+h1P+GxL6gQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340296; x=1715426696; bh=yXUUjlD/9YtQZ9/5DOXjUVR3530s
	jI3w7Z8rW0/Sd1M=; b=hNVzIQyq0/e5WMYVlRxzbMS4zfrk9zUOo58tCKGTkzmt
	U2fST4A2tS/WgzUR+pt0l+cDbepZGtdtfdSBJdy4QvYY0T7xo9/nBySvZWpfoNoA
	E83TZ+YDbEs3krrv6bVvHvCwu/SbbNRaNSJwRu42KpNXaGzMN9mLLJ4kFadvwwuh
	prkKpJtJuYyNi5miDHcLgEdAo8opMey3LSebUArU/Sh//xIusN/H1sRA9UQC8o5z
	noNhmEa7SbtJ+/DbPTTR+MuMG8AU3wQQ8bw/LSNQadgynJwCvENKJq7+8LoZmK2W
	p3JbtOyJclPQvtNXjcR2GUBIilnrWGSFp+lgP17k6g==
X-ME-Sender: <xms:BwQ-ZonrvzNlPktVab4ytz8M0V_IxjJ-vQAbNJFKv38YzZNU9p3PGg>
    <xme:BwQ-Zn17lq586_qFoSGgkq0Bp4SB_tk8ODassAGrAOUTrucHo3erv-EGGLCMKZ1HY
    OPu8HPbGhlq58BDDg>
X-ME-Received: <xmr:BwQ-Zmo6ob3ybJreiLVH61Mn_nMEFsAQnzW5UxmXFcoVmibUUE0M30cjCe_V6qvr6Xp-N2sz2YLRsNLuAK818GBkpqn92doQ3te39Ca9GhNvNKIQRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BwQ-ZkmHvKLZ0xStB3_N6n9NIyq7p1oJaK_TKw8lgbovoZoQrSYVmA>
    <xmx:BwQ-Zm30YO06Uy_kjJ1vQ_NqSP0zFZrdodaYkvSc-uVOvnTcN51-qA>
    <xmx:BwQ-ZrucRImxyFumhZGpe-vLrcFuar2u9QDY7fW1jS_ejg3gfcpRgQ>
    <xmx:BwQ-ZiVPCDBt0-Yj9vjrPkcEuC_BQQEwfy59oXgiWTrbzDtSB8ZgAQ>
    <xmx:CAQ-Zr_SNxLI_nybIE5XSGLZqCKu4L9uQ8VFhheYgr-muykXIhUVB3nN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:24:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b2e8a579 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:24:42 +0000 (UTC)
Date: Fri, 10 May 2024 13:24:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/21] builtin/config: check for writeability after source is
 set up
Message-ID: <edfd7caa39ab990faf5b49a6c572a612a35dbdd5.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dryo49d18D4N4Toq"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--dryo49d18D4N4Toq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `check_write()` function verifies that we do not try to write to a
config source that cannot be written to, like for example stdin. But
while the new subcommands do call this function, they do so before
calling `handle_config_location()`. Consequently, we only end up
checking the default config location for writeability, not the location
that was actually specified by the caller of git-config(1).

Fix this by calling `check_write()` after `handle_config_location()`. We
will further clarify the relationship between those two functions in a
subsequent commit where we remove the global state that both implicitly
rely on.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  | 10 +++++-----
 t/t1300-config.sh |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8f3342b593..9295a2f737 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -843,7 +843,6 @@ static int cmd_config_set(int argc, const char **argv, =
const char *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_set_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	check_write();
 	check_argc(argc, 2, 2);
=20
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
@@ -856,6 +855,7 @@ static int cmd_config_set(int argc, const char **argv, =
const char *prefix)
 	comment =3D git_config_prepare_comment_string(comment_arg);
=20
 	handle_config_location(prefix);
+	check_write();
=20
 	value =3D normalize_value(argv[0], argv[1], &default_kvi);
=20
@@ -891,13 +891,13 @@ static int cmd_config_unset(int argc, const char **ar=
gv, const char *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_unset_usa=
ge,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	check_write();
 	check_argc(argc, 1, 1);
=20
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
 		die(_("--fixed-value only applies with 'value-pattern'"));
=20
 	handle_config_location(prefix);
+	check_write();
=20
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern)
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
@@ -918,10 +918,10 @@ static int cmd_config_rename_section(int argc, const =
char **argv, const char *pr
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_rename_se=
ction_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	check_write();
 	check_argc(argc, 2, 2);
=20
 	handle_config_location(prefix);
+	check_write();
=20
 	ret =3D git_config_rename_section_in_file(given_config_source.file,
 						argv[0], argv[1]);
@@ -943,10 +943,10 @@ static int cmd_config_remove_section(int argc, const =
char **argv, const char *pr
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_remove_se=
ction_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	check_write();
 	check_argc(argc, 1, 1);
=20
 	handle_config_location(prefix);
+	check_write();
=20
 	ret =3D git_config_rename_section_in_file(given_config_source.file,
 						argv[0], NULL);
@@ -997,10 +997,10 @@ static int cmd_config_edit(int argc, const char **arg=
v, const char *prefix)
 	};
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_edit_usag=
e, 0);
-	check_write();
 	check_argc(argc, 0, 0);
=20
 	handle_config_location(prefix);
+	check_write();
=20
 	return show_editor();
 }
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index d90a69b29f..9de2d95f06 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2835,6 +2835,12 @@ test_expect_success 'specifying multiple modes cause=
s failure' '
 	test_cmp expect err
 '
=20
+test_expect_success 'writing to stdin is rejected' '
+	echo "fatal: writing to stdin is not supported" >expect &&
+	test_must_fail git config ${mode_set} --file - foo.bar baz 2>err &&
+	test_cmp expect err
+'
+
 done
=20
 test_done
--=20
2.45.GIT


--dryo49d18D4N4Toq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BAMACgkQVbJhu7ck
PpQnPBAAknj88yhd34hz74KtH3knKmFN/MqDvnAAzTkuMRrIBADgIuWZJwLWGrjA
1P/2sx5jHl8BNWRSDAWHAlYYwG6a4HI2G060pltGUhhNATysQPsLDEWCZVm00Wds
tSnAJUlaL8DyvGaedM8IC55WkalvSOtDjcVGsIdFx4YQ1dTsHEUo4vjatUqOWgFX
qfNiv1yCJajdLNB60LjQuTrgffXTfWFq0TXO2jFCSwvQE5VR8rcTHOcEygGyFyYk
nDgIjiCJAxzmSb9FNHZY/E7vjtMgamgDLo7kd5Y+P5U2c9aIzo2xkOIvo1bXtwqR
JoXvv/0LLK6yLEdYWJb7+zhpG7W07ZM6fQXvdKZnJlQ6pOa5/4UzOyMMIx7BCNEW
daNKxpXakoH4lcUTmi6EBBUZePrqa1bFdG2ekXi0Ykyz8asETvkN4jHbKvvVPeuL
7ue/pJjmTdXcRUSBNzT78gX6LTfZX+GjFhuMWdNfWYUTyoYY7Zlp/qgUhZOTJzww
XCv3i4qLTvoyQiJyey6FU4eeEJ6pRkiO3S42LjJ0NR4M8ut51QZihcYsE6PS32Wg
2yI+K50T5RsTvO074YBvUSngICh8FRNuYJ1FGBZ7u76WPWBM6QfAg6J3LGpaSRYS
1XkR3NOgcVJLFFy1n3t3avNUIN4aGnq9QQIyG5EmgEnMeiLZq/M=
=7H2O
-----END PGP SIGNATURE-----

--dryo49d18D4N4Toq--
