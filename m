Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E49170897
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340283; cv=none; b=PIiFNzjFxL4DqLyyIMBm8plLf0qeLT1WA9xkfIA61kDLJ5EOC3tEscbL7bb93H+4qegCk19wi5ScJz3ZqpBHi2p+H+Y9Lg7v2GBPwI/eBuhtWIe1RDw8rNpriPi9YXVPfLVXG+lQ/qIRuDKe5BseSI3Na+g01sosKXeIfULhelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340283; c=relaxed/simple;
	bh=34umLqZHvQA3rdsIHYdM/Ra1sku3O73VV/85C1NSKtI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF96v/mjDJCsLEjGbHgqOQDuS+zxXIfsxPsJkvOQmkcCvo12xvTr1vunyEgv0zi7/DkCqyNCBKvwG0LUeTvtCYv1zhBhzylK2R2vECS4rNvHrOgQ5KLYPTwX7kEZOucPYBD6CHHyzj1VGc49ZQbvPTX0oI9oJxmm/Nwa24T8++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NuRQdEXE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSTCYDQT; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NuRQdEXE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSTCYDQT"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 01EEC180012E
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:24:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 07:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340280; x=1715426680; bh=jEeCMaeqQk
	jdJD1wuMS1u5hX3B5hi1xwp0M7j1qNc88=; b=NuRQdEXEX8igcAQwsi1ijJxW0q
	zg6/Xv5x17TQOAW9TalF7yhACpeMmCNOmGpNRbdgZsEDwOXmC3HeszP1vFDws3wh
	CWZezKfJY8g6+nGF7E6Fm2irLZplpGso33DI6ax7pRKj9Afr36LZPtJhYJev7Acg
	0qC5oPqTBG9c5IMdOoywQ/Q2IWEoZamGoBo4UeaGQ4PRAf0vxOWl2cdrYwJztOF4
	GQTK4SAJFeLOgmtgloAnJWeGgQYbf0HOWhf2ZYe2pJSplMFnwEPqp/yTvQmN2WV7
	mAyqT/Qcz1HsQi3QODe4NpJLrXmEmPiEZtHK2J0Rai/woORuqG9eJ9jqhQow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340280; x=1715426680; bh=jEeCMaeqQkjdJD1wuMS1u5hX3B5h
	i1xwp0M7j1qNc88=; b=bSTCYDQT3nvRZIO+EMmMPrXRlco1QoENtVWD4c2ED1ec
	gnLWaGNY1aKMdDRuQRCLEH8ZOw5LtPRXKBVP9KG8RgGVBcKuGOthXG8dHl6qtVQM
	YmTd4p50OeRtGTNF0foEDdr5QnuFQ0T2egrBdTJ+BmjomA/hxUDtOEgUwEifpvWs
	YC3MBGoUM4WpTZKR29EpJ8K9OqYCIeSF7m2NJoDEOU6AutEhM77pBrlICBI9hk3/
	Ngp/G0xOpue7z05ZLpIR6u4seiSdOjCUSwtPXIyydR4wgqhTJ9FzaqizYu064uhB
	WodaoNwQUNrotICarmRAdn96seUc0qOOsjTdGwTETw==
X-ME-Sender: <xms:-AM-ZsWA9Lqh3sBSJVzo3tAZSLXIcG8kQlkbXv_bLnxOAdGBjXUozA>
    <xme:-AM-ZgnuXRmNWJ93l-ZrENWuhNxFAdZINyDZ_ZL0iwTekW2q-bEinlxeARDOMDn3W
    SpUUVNBmL_P_HfozA>
X-ME-Received: <xmr:-AM-ZgbIhmY1bfJKesjZ7a0naA-IafOQrofFwsbIszsRBlw9vVnJtx1jIer9d1j9oCve18XANONvTV10I-eKbmn0VfDYQoS7sh-LfSgfKFh0iuxovA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-AM-ZrX6g52wXagWLwBuLnPa0lIkDkbMSUeNnL-x8YI1_VyXrPOyYg>
    <xmx:-AM-ZmkhkPXGD_LmWEv3DGv19nXd2zXKuu6inMMkMlXVdbFNrZZ0wQ>
    <xmx:-AM-ZgcsFWgxCrZ1YWuHAZ_fyjGz-ji-XlXxIfgZ7KoU8IK1dIVWrA>
    <xmx:-AM-ZoGao3E3Z6CSQ5XEg9CMMvdKdrqQXhNWGR4LGPVaf81Ee6SJlQ>
    <xmx:-AM-ZqvHOQn5TnN3hxv3uSlydTJIIgJfTNDyqsrX38oSNQR41RHTGS4R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:24:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4a7ba4e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:24:27 +0000 (UTC)
Date: Fri, 10 May 2024 13:24:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/21] builtin/config: move subcommand options into
 `cmd_config()`
Message-ID: <1239c151d08448f5782cdd12c5cf10fd5d2719d4.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yefQM0xgocyuFzie"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--yefQM0xgocyuFzie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move the subcommand options as well as the `subcommand` variable into
`cmd_config()`. This reduces our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index f6c7e7a082..58c8b0abda 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -75,7 +75,6 @@ static char delim =3D '=3D';
 static char key_delim =3D ' ';
 static char term =3D '\n';
=20
-static parse_opt_subcommand_fn *subcommand;
 static int use_global_config, use_system_config, use_local_config;
 static int use_worktree_config;
 static struct git_config_source given_config_source;
@@ -1058,17 +1057,6 @@ static int cmd_config_edit(int argc, const char **ar=
gv, const char *prefix)
 	return show_editor();
 }
=20
-static struct option builtin_subcommand_options[] =3D {
-	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
-	OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
-	OPT_SUBCOMMAND("set", &subcommand, cmd_config_set),
-	OPT_SUBCOMMAND("unset", &subcommand, cmd_config_unset),
-	OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
-	OPT_SUBCOMMAND("remove-section", &subcommand, cmd_config_remove_section),
-	OPT_SUBCOMMAND("edit", &subcommand, cmd_config_edit),
-	OPT_END(),
-};
-
 static int cmd_config_actions(int argc, const char **argv, const char *pre=
fix)
 {
 	char *value =3D NULL, *comment =3D NULL;
@@ -1291,6 +1279,18 @@ static int cmd_config_actions(int argc, const char *=
*argv, const char *prefix)
=20
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
+	parse_opt_subcommand_fn *subcommand =3D NULL;
+	struct option subcommand_opts[] =3D {
+		OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
+		OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
+		OPT_SUBCOMMAND("set", &subcommand, cmd_config_set),
+		OPT_SUBCOMMAND("unset", &subcommand, cmd_config_unset),
+		OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
+		OPT_SUBCOMMAND("remove-section", &subcommand, cmd_config_remove_section),
+		OPT_SUBCOMMAND("edit", &subcommand, cmd_config_edit),
+		OPT_END(),
+	};
+
 	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
=20
 	/*
@@ -1301,10 +1301,10 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 	 * line in case no subcommand was given, which would otherwise confuse
 	 * us when parsing the legacy-style modes that don't use subcommands.
 	 */
-	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, bu=
iltin_config_usage,
+	argc =3D parse_options(argc, argv, prefix, subcommand_opts, builtin_confi=
g_usage,
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_=
UNKNOWN_OPT);
 	if (subcommand) {
-		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, b=
uiltin_config_usage,
+		argc =3D parse_options(argc, argv, prefix, subcommand_opts, builtin_conf=
ig_usage,
 		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
 		return subcommand(argc, argv, prefix);
 	}
--=20
2.45.GIT


--yefQM0xgocyuFzie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+A/UACgkQVbJhu7ck
PpS8cxAAi8ApxA2YlstbJSfRjzxjWwF+v1WdH1Oh91oMSgBOltVZDGpnoFCpkPYS
SnaKXorkBNzLVGUJmcZsiIOqnGSlyDrwrZtpPwy2M3Ohqjp7AVxHbzjxdqZ6LbsG
oWvCcalGKHUZgIsfJVNOKmrZAx2kj3tkEkxAKtZl7wwF6XqglypzpfikWnC4FEfq
LWsnvInPEzyGRslLie9b/mZD0k7U+Z3na4bs62ed7ox8ju6mgNm9wL9W0pI1/bXd
lhgf7W3HhRdXrJkwO79eaSmTWRoAtq0nYgO7s6cackMkDEZHhTShgx4+nlliEl2l
5w+VzU3uFEi3bVAfTnAxi8245hH9nmgWAMNhRIchfEiLKvV1tkC9zIV5yTNF7h9/
N5dO5q/Ij19/UE0kkcT3VHrRTQ+xdRhA6TTd3iZkCbiZ2S0AHhEzo5fKripCcSFk
8jQs9jHmEiNIhqTKWAXNtzzqhaIo6lyDF+c84hiRkKxkFlKpUGH49Z0a2TOrcbKY
hmF0vlaX2rLxiuz4cqTHlj4sYG31zeOSio0vWPiOx2MrSwNUPUQWk7oa85liPoya
LgkMGTd4l2B1beP90B9pQ4D9pQJ/+A3SeJ9Oq/hguvD/xy4qplAnY1oYIlyWX76A
mnbKzAuIt8+uVmHDqJIZco2/hxXwPppe5KpunwmkP2+OsvQqG1k=
=C2Wo
-----END PGP SIGNATURE-----

--yefQM0xgocyuFzie--
