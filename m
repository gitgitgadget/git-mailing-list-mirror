Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382F4EB3D
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755328; cv=none; b=UMf2RSyrOIhl1cJVsFRe+AuPoOURpVrh7H5enOaJ5UBT34tsnFz6qFpQ/0fy6KsFUBBq184W6txbyUtkWX2LrJ5UKkvKWEWjXBBjlFA6F9zqJFdszeiml9pb7bbZpZXwgOMmdfHS/koJTPJZCIeSjovPFqdb1v2Jujjx4RvEMLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755328; c=relaxed/simple;
	bh=2Bb7TeC+CyOYgZtWaTAzAPKd+J/5nvxW/dDaMVfynBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEf5lHaiTnIYWZdgJvWxMWu58yXMlgalPUViStR8fj8vx7M3XZllUJte9Q7t1hNI/pFSIxxRU7V9f3EnEjksPIw7Ki3jm3+LimDDWuJCPAJWDOAtx1Mu3C5LOxG9eT9QcQupwkyFm5703k7RcRTE/3C9+Hhh3NvUcxFSgZWeKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZtUAnOEP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cl3RV9u4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZtUAnOEP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cl3RV9u4"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EA5381380234;
	Wed, 15 May 2024 02:42:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 May 2024 02:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755325; x=1715841725; bh=IsPuoGndHK
	yCnyq6Ct9ljc5nih4W5SjF6+PDt6awMSE=; b=ZtUAnOEPb83YLwo80vp8z8KLJG
	Jh6ukVpv7APTntGHqnwNAc1kAgcXvlrB0P4sW7G0qJipxvaiV1NpUY8x51M8y8Ad
	kw0YkVIWz8J+WTtlFP7AZy37V91Uxam+itFtVOmYG6p+Wd9mpC7PcKIURDXzL3qc
	z6dnjyfPJ9lKR6Du61HQaSIPywAr1WThOchg5PZV4Jp3r9V5OvEm08jvVJ9W4CDZ
	ev1A7ODoADbA/opbwaR38Yb990HAAscaB5D5HzJBznQ8FblcygeFk9pzdGQwm9UB
	ru/Dh5Zxvudvl9hIYBHcq5JcEQ3uGZICobxzGcO7KPj2PVGfOvKYEMmi0yjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755325; x=1715841725; bh=IsPuoGndHKyCnyq6Ct9ljc5nih4W
	5SjF6+PDt6awMSE=; b=Cl3RV9u47328jc/Q7P0Jzj2x36pgTNQs/ti22zhVT7cX
	AjsoLoTMbTKkDFO5erPHMIzc797Gj8ZcJrIvrtSAcgSFQnelFeyxrWbfEqBmlhhH
	KFSUtEd8KC/3pLOvUKRCaKCdXqTA8jdzeBU3lpO5s/tZTgjz+Ky2EO7zXHdp8q05
	l9F8vb1+vpukQPHYsluvLqm6hLxzIadAmcTqrOXHIVbkAeYo2MOZfs1YXHvk3RXY
	CYd0f1pLsVpc6lRuyHIf2G6rFG2FxPq0VxYqeKx5D4EfKTslDRfoKk8PxKv4kjsL
	54pcQUrIPCFu79qxnqYUD3W1qestEkTM02/dwlVCpw==
X-ME-Sender: <xms:PVlEZswDTLBZZzm9iyk3N6AvGa2RlqW0AcOs8Z1m4stwqtmo0AibIw>
    <xme:PVlEZgQCzQs2CyKsVJ79p2Spr893659TKyDR1mWyL3XTjyU6p4JejfC32CS5q6_KR
    U9CBqfUDk9_4daPVw>
X-ME-Received: <xmr:PVlEZuXLKYFAS_1Jaf55p1dzbzz_n6e_vdyvdXN62u8oprCQS8iFvJNgfynznZhyuoc7S1YU8yBnPy_IXroNJt9fpmz4d9BcNGn_tU6jNI9Bxnff>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:PVlEZqj6-l2L2O6xfVPdlkIxH7YTxuce4sdDt7Cwg7adQ7t1r9pBHw>
    <xmx:PVlEZuBtM4DG1s6BWmlfa5RBMO1RAgvudKJC043IdbZdtcXqzFpR7w>
    <xmx:PVlEZrKkA9YybwCu7K2bXFryLtpEeSB_ZmUkP_qoCgUPzXpPDdyJvQ>
    <xmx:PVlEZlCdOgj2ELV8OvgT_y-HrHjixBNa_DnkSvNyC6YXyrJa5B8UJA>
    <xmx:PVlEZh-GxDiHzch0EJHp4BhMKYOQD_QM5DoXUw5b3Am5_axlZi6lzIVE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:42:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7830cecd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:41:42 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 06/21] builtin/config: check for writeability after source
 is set up
Message-ID: <6de9097fb2c339be72aab3810abbccbfc39bd480.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T76IX+vK0Z0bYHqa"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--T76IX+vK0Z0bYHqa
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
index 0842e4f198..9866d1a055 100644
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


--T76IX+vK0Z0bYHqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWTkACgkQVbJhu7ck
PpQdNRAApBPS01LkmryHCAmnLuK9QslgPFNkvyl7B5rygkYH/Q1MaQvpZQxAsyOC
rf1dUIeM899j8ildTgIiYS1KiDUHNPHoiAYrjwJOtSD1Qkp6VyvSNiAS3Xf9chB6
CTQjCMYeVFDTy/y6uo2nOERlIeAhk4muJsrdmxk2ydgkjk4jWpbwIdVvBQ9GlgTY
IFTJdsqSHkah9D9DwUNIP9uslMVolW9eqnrmYycz7MXFaX+tA9NpdHHTfZJiTDeg
5rNf7l2Rx9g65B9Oxm8PlEtwZ3J2okg/yId2Pn/ixhdTG+ccpmNlQgRFfIxheLky
k7mZzvARF7Ec+V3QLS7dRsMYRSIYMZBI9Qy6wIk0fIcSaU1yeGR14698uvlTV4xK
Wbf8vH7oCMSQA9/NI/LTUGN4qIJtPKDKBET0XzjJIyp39pVPbnzmVVSh7I/Uq1Yx
i/As/MYDG9ZzuPyYN3wPGxf7XMDo4HOvr3CuRvRH9YUyq+gLg2mPGBs4ShJW4C3r
rOeotwLJqY9xSyy6Ck75sEHXvbzdFt6I7DiiTAToRihLUh6Wvu4tHHLzgeS2DESd
tKLXInKSrycfVZt542A7lg3/PD5wvqghVCfotySXz9yJa1DPzS0+YfZsXrl+ecdP
V3HlyfyQ0Khey9MVRIHND2Yv8RW4J2+cLJ7rZ0PFV4EYSdn9+9I=
=Cw13
-----END PGP SIGNATURE-----

--T76IX+vK0Z0bYHqa--
