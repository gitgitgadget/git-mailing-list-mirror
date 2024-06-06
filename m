Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA6328A0
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669782; cv=none; b=o2Tkm2Mz9qiCIDqT0ZTUH1hna++e9QNJBTWgg2dcA90tAs8k+crY21G87ssxgw4B9ejZii729pQIEikKNoGl9/Y8I9O23ytIo5uLREzNaZMjGYI0s9RXvat11onrlc9aWdFubijBTKK40woOpSSwfXelMsSO4TVdtsILd+p+hnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669782; c=relaxed/simple;
	bh=/AdVA6oi2gEFZOFJD0Z1gQgF+nfRg+Gt0mqT9VoEQ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7NWcEe4jVzwBIj8y52hHlXssCCibKanKKjmuTUZkpw/FloYiDdpgopY4FJAXuGLFddyKjmK1xBzPEqJvqd8fOHx3pmPyQPYAq+qgJ00F648fiapYPckar/ep2PS34+JqOOUEYJvR2MdtlLMkRnmcuaezGNo4FQI3EpKTt7iD+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZSc+leWc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fzArxOpz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZSc+leWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fzArxOpz"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7EA1911401AD;
	Thu,  6 Jun 2024 06:29:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 06:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669780; x=1717756180; bh=U9xvczMRvk
	Zge9hFefhIEXdxgI9RDORPck5qooUjVYY=; b=ZSc+leWcCJ2jvzV4WjnL4ZrYsA
	0+ndGiqqJNnJqTqYCgDiHN5/rRENX02z5q29ntdXmodyLhW1QglP5wEPpdY8eD1i
	YU2k9SECvn9epe8N3/Zzbnu+TZocV0xoF02BpVKL7g4WKOfx8Gr9H9DHCO8ZU8Wv
	tO+WwbAomK0xvOnpHfLngUGvb48cFP3EARR/2/GB4aA/U9p2AMDial4hA0mVvMY+
	2LU8hAh4RMrkO8kwWmbWlbZxlYtNUtLuyxwbxSeQOHic//L1PdVw+45a+i6dbBgK
	bX/3yTOwXPflzNfG68SsO6X4dbwdgIi/3mQdl1WUIys42yknb5qKG/z6azDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669780; x=1717756180; bh=U9xvczMRvkZge9hFefhIEXdxgI9R
	DORPck5qooUjVYY=; b=fzArxOpz5wBpTKKCt85ommyQ+URcKJOCpPSA+1OPOYg6
	SfAfT3lSMVfxkzCRuYyqvlPG2tDVDltnSnBSJyku3Zr8CpMrs0L/DX8NEBavKelx
	sftEWg9To5Hji+MPl+Ras9AEFHVa0FB1v82ZQ/9vQoKkiELHDHqgRHIcpwV1s9wl
	y8shk/L/8qkVZo1SuysYYsHvEtxMN2Grcospl5k4q2IWJc5O822ujLxxPe6KQVIX
	NQC2xU50+1ATZTGe72klF7xkA5buK5cxG3LrKOnibCcy4+t05YK083lxmxx9wUvC
	Zs1fGfXBbpELfxSkYqeL9zc/iHlNxSFPWuAC/e6k6w==
X-ME-Sender: <xms:lI9hZoo_NiVOS0RDA-oPE0fqWBCCj_lExngr4_UsIwLyXn8BQaThTA>
    <xme:lI9hZuolXRxxFMxfKiJUWii17nz532UFOv2EhYhhb_mOG7uvqzZ5TbOuRiYnhMl1O
    nVIU2kIZSLSKd2AIA>
X-ME-Received: <xmr:lI9hZtO40ZqqyhZk-KLeue1fjiNZ2J43XOoCjzmHbfgqmPVpTpFnUQMdFlw3am9F_qUyrJda-tj1SicUR-g-3hE7RHOnYL4T8AevSnnOelZC3nkn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lI9hZv6vwPi8pW67x8Fc672dfVEwh6GuOZbJbDXsIge3j1BMe4JXEA>
    <xmx:lI9hZn7nlMbOiUDyXoC-TZ8e1buVqv64ecwz4pkEIAszM80jtVuKaQ>
    <xmx:lI9hZvhgcIIofB29KNgYWWfThprnjOMxB-ioYoHYSdvP9adwZzLGAA>
    <xmx:lI9hZh6rNWhTaHcEw9UEYDz-zt0GLV8tQwEmcpVd2U91jQ_e03IxaA>
    <xmx:lI9hZq0_enZailBfs03m-mwUwVCh4-RWfLwy7iXMZXVdthAh7NyFNLks>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f2e6c6c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:29:08 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 24/27] builtin/rebase: do not assign default backend to
 non-constant field
Message-ID: <81c69da2e830d04d4fbb2108944d55c8711d4e8b.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4d+Q7tKnQq90XzMc"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--4d+Q7tKnQq90XzMc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct rebase_options::default_backend` field is a non-constant
string, but is being assigned a constant via `REBASE_OPTIONS_INIT`.
Fix this by using `xstrdup()` to assign the variable and introduce a new
function `rebase_options_release()` that releases memory held by the
structure, including the newly-allocated variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 14d4f0a5e6..adc990b55e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -135,7 +135,7 @@ struct rebase_options {
 		.type =3D REBASE_UNSPECIFIED,	  	\
 		.empty =3D EMPTY_UNSPECIFIED,	  	\
 		.keep_empty =3D 1,			\
-		.default_backend =3D "merge",	  	\
+		.default_backend =3D xstrdup("merge"),  	\
 		.flags =3D REBASE_NO_QUIET, 		\
 		.git_am_opts =3D STRVEC_INIT,		\
 		.exec =3D STRING_LIST_INIT_NODUP,		\
@@ -151,6 +151,19 @@ struct rebase_options {
 		.strategy_opts =3D STRING_LIST_INIT_NODUP,\
 	}
=20
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
+
 static struct replay_opts get_replay_opts(const struct rebase_options *opt=
s)
 {
 	struct replay_opts replay =3D REPLAY_OPTS_INIT;
@@ -796,6 +809,7 @@ static int rebase_config(const char *var, const char *v=
alue,
 	}
=20
 	if (!strcmp(var, "rebase.backend")) {
+		FREE_AND_NULL(opts->default_backend);
 		return git_config_string(&opts->default_backend, var, value);
 	}
=20
@@ -1833,14 +1847,7 @@ int cmd_rebase(int argc, const char **argv, const ch=
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
2.45.2.409.g7b0defb391.dirty


--4d+Q7tKnQq90XzMc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj48ACgkQVbJhu7ck
PpSAaA//WqzjWpwcn2ZCBILcpdC0zyzr+eItcdUZAS6lKmGQUXR9lu+8JaRHmiMm
Yz2gkfMCWL72toA7c5ALkUMCR3RDLZ53xSj2jIhdPdMAZ518mDgl1/1eVGSEIpum
cdxywGjjzTf5wssOn370LRkWBS0iaywJTbPEgkK3zoFoTZ/2NKh4gNYZ/Jtn+xsh
wsvE5lr31oQefu9C8hL3F3OP9jYeurDpllWkE7VZsxjdkzmhGu7Heet8rSrzkSLX
aOPv+54KH8TOSqht2H83PE0Db97Acn8jGu9e9cUQdCf60msiuu4h7Occ7dFNZdZ2
k1p8CrINafUQhk4zWZJNlzGm9eDSw+pXnW397r/FC3eDiaV4s8z3s9rFR6ZwX3Ty
X0u+fZs+OogPvsjlRRl20maTdAPNBC1CyugfxEDJgJf0Y9+aERZwjzZTIzuNj9NR
+h9etQ6WIiUWDkjcUS74Va57pargaOkuAIynxhnDmXMiGgdauIIE3IS3thFg8voA
6XO0rJfn7CdWWGNW168wDW6fmFwU3JrKHNhSvETnvOmYtux0BMEFBXR4GeHGmOpW
purwtgadiqXomkWJblHuK2InTuJuELAJ0XV6DQS2uDlZDwUbSiTDqALKZ0g+Sv2b
1suOrY9LX9Ilq+zI6AROFIE7bFx6sVrNroy7DqFQY7DhpeYd3dk=
=BV+O
-----END PGP SIGNATURE-----

--4d+Q7tKnQq90XzMc--
