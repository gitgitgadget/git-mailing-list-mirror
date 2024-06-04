Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA6146595
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504735; cv=none; b=FIESnogxkg93a7uIKKHQ6xNfBRhoKDafkGwRvb2LyQwWxXgkHwXmpZI4svH2EpnGuoM+7x23ZrY/JGI5wYpaJY4DyaqRMsiOh1PjHgH+Zq0AVTaOs6kBhpFbpi0mcGaZOrgeNlwxO+KUEOihhfa1MaLUQwbY27vK/o2akdGeqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504735; c=relaxed/simple;
	bh=SoCRlUgnDX5eeLmkvrRY0jdxkMwvbwfufyEuGsfTCss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWuBo6YpMDSFsHPrINJyZmcVY3vTzgJxFO24+CJUa1Q3ZJ8hvn8Ccz3EpwHjquQyorBPIAVVIfiumAHdQh95IIZNXQSXXaVWIEkY9G5cA3iwDzMegxrK5NxByvvCEE63XAJlL8WIrsdf1g0ircAMsy5xMv9dCRzYKATEKlIxozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R25iQlAp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SI4Ro7AS; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R25iQlAp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SI4Ro7AS"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 719901140092;
	Tue,  4 Jun 2024 08:38:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 08:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504733; x=1717591133; bh=jY0YAUXDcZ
	H/x5QF9Zt8G4Ow7qjxuBCjnU6rqh/LVeY=; b=R25iQlApGFJjZTS8RGSKazRZkS
	+BhcUXHk3U42oP52SqlpWDTeBxHLjMeA2XgKOomONsj/k8GIE2AKlOQdoF32x5lz
	xUK67dMfu8lDSS3MDOq/+fWqWF7pjlOovlijYVprf7SefSTV87Hzs/OZfzNZmGqw
	5v6g/pCAxpBdNf2Aeg9cR5iFSOvrdD9ElcBsxxm285PGWMjQpGstAm5Ee6vIAzUy
	PC00GeGHAHzuR3wu+Yyn4H3HkgZinL8C4VVQSu/jZjtAF+e9mD//AHnz1SKkyjjY
	NTDlDkERnFU2njYMMy8l5BVcYuYlqjWX+4kOqYVS+0w1trdubMvXE0qF3L6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504733; x=1717591133; bh=jY0YAUXDcZH/x5QF9Zt8G4Ow7qjx
	uBCjnU6rqh/LVeY=; b=SI4Ro7AS5NWJd4h3RQHj+xcWmg+TCBJQ9oa/CA3UsjcI
	yw9ySL4iApEC/cmwFSgyB+6y04EIUmmnbbLogI8/vOAAbNFp91MD+lUWKJDkg10F
	36vgcIyfZAWG2okJfb3B5d9n8tUqCvSrDY3mX10i9v26C2e9rmbs1m+0/5/10a4p
	zcEzaD7bn2sLVLf7gkvqjhN6XJyBFG25YEkMEpwPR6+D9PbRWpfzmbABYN4WRPSA
	nlfzM+90BSF/C6x+1oy0v+byLnvm5vDHM9RMObhuCN6boChVcMNTT2KxrOHnNqDc
	/BmaKu2LM1SgxDljkBhcdp3Ob6gbOv7vHxQFSmCmDg==
X-ME-Sender: <xms:3QpfZu9ETYH8DY1X53X8HpgTv1yfsLMtjl5NolPtZYtWY5tOYbHIsg>
    <xme:3QpfZusvH5CoDqjsgFm-mjsCQXjq3an6sEHiRZ406guVLqceB_Tsz-YEmfTreHz05
    6m58dZ1sTfprztbSg>
X-ME-Received: <xmr:3QpfZkDhWFDPxQdCcizd3K1w1PRpiPGjpNJSA_iWL3zIRItVoqDepSX0-2qahAQpDnmxxHLcvv-edeA5zlU50DIfPc1qOBYT0Uf4S83vytPaK2sW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3QpfZmfUGny8Eci2d9WzjwlvvY8e_qcRVQkRZhgYMIIoEzN7xe7A0g>
    <xmx:3QpfZjO-eE_BebrK-B7FJgTAPtXk-669U0wNDpBhkDrWbyDUHSJExw>
    <xmx:3QpfZglqNWMNWHCbZjfszNDX597H6cNOR5OA7EEFRAnZ0JqEiBPGIQ>
    <xmx:3QpfZlvN6zuQ0eu36C60DBr38am5j1R5TSns1hFCglNk76UieORQfg>
    <xmx:3QpfZoqMCbZqFYS9PLIvYxIH20V9ZEtP1SlURw-duzb8Tsd5Qx2ZwdX0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 50077b55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:38:25 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 24/27] builtin/rebase: do not assign default backend to
 non-constant field
Message-ID: <e19457d20c80f9ce332f2d890a5089972e28f0cf.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D3VPnGRUrxYQx26r"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--D3VPnGRUrxYQx26r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct rebase_options::default_backend` field is a non-constant
string, but is being assigned a constant via `REBASE_OPTIONS_INIT`.
Refactor the code to initialize and release options via two functions
`rebase_options_init()` and `rebase_options_release()`. Like this, we
can easily adapt the former funnction to use `xstrdup()` on the default
value without hiding it away in a macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 67 ++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 14d4f0a5e6..11f276012c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -131,25 +131,40 @@ struct rebase_options {
 	int config_update_refs;
 };
=20
-#define REBASE_OPTIONS_INIT {			  	\
-		.type =3D REBASE_UNSPECIFIED,	  	\
-		.empty =3D EMPTY_UNSPECIFIED,	  	\
-		.keep_empty =3D 1,			\
-		.default_backend =3D "merge",	  	\
-		.flags =3D REBASE_NO_QUIET, 		\
-		.git_am_opts =3D STRVEC_INIT,		\
-		.exec =3D STRING_LIST_INIT_NODUP,		\
-		.git_format_patch_opt =3D STRBUF_INIT,	\
-		.fork_point =3D -1,			\
-		.reapply_cherry_picks =3D -1,             \
-		.allow_empty_message =3D 1,               \
-		.autosquash =3D -1,                       \
-		.rebase_merges =3D -1,                    \
-		.config_rebase_merges =3D -1,             \
-		.update_refs =3D -1,                      \
-		.config_update_refs =3D -1,               \
-		.strategy_opts =3D STRING_LIST_INIT_NODUP,\
-	}
+static void rebase_options_init(struct rebase_options *opts)
+{
+	memset(opts, 0, sizeof(*opts));
+	opts->type =3D REBASE_UNSPECIFIED;
+	opts->empty =3D EMPTY_UNSPECIFIED;
+	opts->default_backend =3D xstrdup("merge");
+	opts->keep_empty =3D 1;
+	opts->flags =3D REBASE_NO_QUIET;
+	strvec_init(&opts->git_am_opts);
+	string_list_init_nodup(&opts->exec);
+	strbuf_init(&opts->git_format_patch_opt, 0);
+	opts->fork_point =3D -1;
+	opts->reapply_cherry_picks =3D -1;
+	opts->allow_empty_message =3D 1;
+	opts->autosquash =3D -1;
+	opts->rebase_merges =3D -1;
+	opts->config_rebase_merges =3D -1;
+	opts->update_refs =3D -1;
+	opts->config_update_refs =3D -1;
+	string_list_init_nodup(&opts->strategy_opts);
+}
+
+static void rebase_options_release(struct rebase_options *opts)
+{
+	free(opts->default_backend);
+	free(opts->reflog_action);
+	free(opts->head_name);
+	strvec_clear(&opts->git_am_opts);
+	free(opts->gpg_sign_opt);
+	string_list_clear(&opts->exec, 0);
+	free(opts->strategy);
+	string_list_clear(&opts->strategy_opts, 0);
+	strbuf_release(&opts->git_format_patch_opt);
+}
=20
 static struct replay_opts get_replay_opts(const struct rebase_options *opt=
s)
 {
@@ -796,6 +811,7 @@ static int rebase_config(const char *var, const char *v=
alue,
 	}
=20
 	if (!strcmp(var, "rebase.backend")) {
+		FREE_AND_NULL(opts->default_backend);
 		return git_config_string(&opts->default_backend, var, value);
 	}
=20
@@ -1045,7 +1061,7 @@ static int check_exec_cmd(const char *cmd)
=20
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
-	struct rebase_options options =3D REBASE_OPTIONS_INIT;
+	struct rebase_options options;
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress =3D 0;
 	int keep_base =3D 0;
@@ -1178,6 +1194,8 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 	};
 	int i;
=20
+	rebase_options_init(&options);
+
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
@@ -1833,14 +1851,7 @@ int cmd_rebase(int argc, const char **argv, const ch=
ar *prefix)
 cleanup:
 	strbuf_release(&buf);
 	strbuf_release(&revisions);
-	free(options.reflog_action);
-	free(options.head_name);
-	strvec_clear(&options.git_am_opts);
-	free(options.gpg_sign_opt);
-	string_list_clear(&options.exec, 0);
-	free(options.strategy);
-	string_list_clear(&options.strategy_opts, 0);
-	strbuf_release(&options.git_format_patch_opt);
+	rebase_options_release(&options);
 	free(squash_onto_name);
 	free(keep_base_onto_name);
 	return !!ret;
--=20
2.45.1.410.g58bac47f8e.dirty


--D3VPnGRUrxYQx26r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCtgACgkQVbJhu7ck
PpSgUw/8CcL7C5pvBaDYzOySWDIVMUBnb/y1ttz9klLn7vctNFdmpY4tXHRexyME
AoHXdGqr7DRVlUvX4N+CLElmce18+r9dqT7AfDh9hg+8JdeZfeioaXsG3e/wNFAb
1rBnjhaWcvrbLheQofv0tYmdCEDJPnsACO3FVLZwZRFCxnu9VxNov6XQazJUmoEk
DZbxMVZKZ3c6lzPYOtgynUSoolpSFW+XARFyzdwWa/UoOvqD+rbWvGxpXIAfgYXt
mQLJCe9AIs33oB4VL5Lo4DyenJl3ImHwcGRJINFBTq9FYMT6OKeEEqrVQT8JrtLr
peDsTJHdO4MDz2SnLaeK+4upDs1gMZ37c7hnyALe2CmViHs0JWBFXl9oTYQLKT3u
nGUw6fH7YpTYMmtAjuVxRbRKvax0fxHkuDwsmDblSmmoE/M+Jg8mCL4ibrRDAKDr
jKY79irQm2fxymsg2wYTd9S3a1JThhC5WXbLz1QqqybJ4mws8zXCV+am8VBnL+N2
pdwlNhAYOmeDMXVOEsjs3QbkNh4v+TcGxWAl6tLEuQiDpZI5CbBo1OMaVls1hYiA
VN7Cp/Io1I+/MbEb/V1CrFrIcESxj+Ke8T/9IqunSMoopIpSfa3oVdAGUt8lFpQ4
CH8tqHe0QWYIyWLTz8umHAF9IZQJRUmjzrb0gd5PmJUj9QsmbPs=
=wAxY
-----END PGP SIGNATURE-----

--D3VPnGRUrxYQx26r--
