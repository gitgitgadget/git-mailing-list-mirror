Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29D183980
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073514; cv=none; b=hAc3w384NoJuhwqG+OgVXZAqAulRKjqXagSkkkWBZj7StwBrrJ6LyHq10jALWsnxDzehAzE8tDRPvg2qe08WiWNZ5knX07ZzLnT6Lx/zt1wgN0/MtRG08bWbpzUfrF03hkV2/6Neo68SrSXSR3hC7HGwce/hrMk+oClhK+aOUFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073514; c=relaxed/simple;
	bh=jcEJzlGJqnFfHSv556k2aQTmvGJDBagBgx42CPRjB/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1OBRivdWk/L7rOdNbGD/BEcfZ78+GmY1XuFD+4/8gF0Ns+ekYBtrHJ1HZVIx7Ca4FtCfhbZ6ECQrFJHZCj3JKhhLgVlye4NibNvfGLaxn49JK68aLxyYIMbAOnUgsX8d0A8/6u27tsKkix+0MXzV4W3M4/1V+GKCSdFAskseV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BoOTE6M0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZzJ/VhEC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BoOTE6M0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZzJ/VhEC"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D8D3E13800D8;
	Thu, 30 May 2024 08:51:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 30 May 2024 08:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073511; x=1717159911; bh=J2CWK+/Okc
	C2V2enrJhjEesPiGjKfAdqmcDJOBNpRCo=; b=BoOTE6M09XnEtOhaaeomJ6DXWG
	r4p3ORbpS/KC9LgFb/oZ3V1IjNs7xKNi90ebbCHkA+XsI7vPQNzwNSxc5vgWyuiA
	DEi5usQUxh2xQCLJgSjipjK9KAH3fQ3Ci3AXJ+wiYexva/Pg4w1+6fVm7Yi/zjH8
	Jx5m5pACRLWyU8f2hThkT4WmmnpVSUb+Fxke+jvGc9ghl6ZjXcjm2jTt8jIp/TpS
	tsFaIGCKUiOKmc29KH8Q8fCG5vXoHPyNhjB39PRy3QQK2/D67FGpAKeAeDvxKuLY
	8ZBDF7LUowLhgwy7xegDwH8YP6Ma1OvblkElysNNMDzA+30KU5E0LmC9mfyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073511; x=1717159911; bh=J2CWK+/OkcC2V2enrJhjEesPiGjK
	fAdqmcDJOBNpRCo=; b=ZzJ/VhECHpBALHcGBnCuyuuG5S/HdCFprlfZ4GjXKH/9
	JozB5zkkAEWOm1CG59ztXxxQnet7GOubfjx5K29zEn0gsFQ4GpNkEhNDjqsiKRFE
	ESdPEhDKyiCGqFVhitw/Uh6o5qKHWL2gqPMQ5G4+dbDqcy1sVo8YpEUNqUXkj+Fn
	jxZy7I8+zDi364I8z2/oxpQbjtab9+vRdhLbkPNQlHQUT7CB3QOMklWpKcv94W7u
	C6NgvA+lYQiJ6dpGEM65bDEhuKTQ6rSIoSSUNrarsOOkan2N+J2suzSvJDGUM5DZ
	JtSt6KZjbCYakiB2XB+FYYOSu5HOZvKZUAfYv8hF3Q==
X-ME-Sender: <xms:Z3ZYZpixq_fUsau0WwvQ2brQLvPQq7YJ_UyD1XhkuyKS0pyJav0HTw>
    <xme:Z3ZYZuBJv4V-3C-Vs2_HWghPgzWSia2NszXmIa1yOf0Ogkfr8ms9PNnYUQH2yWoO5
    pWbNQ215v_cwfvafw>
X-ME-Received: <xmr:Z3ZYZpEMsiCrOe_mTT-MUy0CefXTculgYH1kbxU7XU5mxZmwM65ZzvtLIzBxVOXksvpeMbLNS14iRyPxJIBL7TaQKIWlUA53h1gA82OntQIuiGHEUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Z3ZYZuQLqXvPG2DmwLxHwSIBj6Wp6MMby8amg9bZhhSpXcV5JDegRA>
    <xmx:Z3ZYZmysHHLkHOuGqjk3yDlJmlIG164yeiS7oFubpdMjec1s6eO3yg>
    <xmx:Z3ZYZk4OlXV_p7K_ADcGcnPHS_byYGQNs6ncjdNB0voxKKWWv597Fg>
    <xmx:Z3ZYZry81kEjiK5RszhY4Rzl_gNtFnaeC_72oIjBg4FB0LhsoTNBDw>
    <xmx:Z3ZYZq-vByV28kqQPd4rdWCBs0IVrhEV93SluHO02hG_4BbdyCxDsQ4r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2928d956 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:51:34 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/19] builtin/rebase: do not assign default backend to
 non-constant field
Message-ID: <36a7b0a4b074e71dc07412d6d7c509dd4d90723e.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pfB5pI4Rm2HFeHlq"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--pfB5pI4Rm2HFeHlq
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
2.45.1.313.g3a57aa566a.dirty


--pfB5pI4Rm2HFeHlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdmMACgkQVbJhu7ck
PpRANA/9FtNFAqdC7m5RwTA6VAdumBCtqfB82cSS2OTimn/04fv0J7EUVzhKMTqW
G37SeUzYhsfBrXmY3y4plz3Tg8qDLEPloy53S0CTuceyAVvrYzouLjLf8JbUXBeW
2GEHdCPm1ENUsuXlTdPPMIxsFpIhzERF28wh9GUgSBnxoCooZcSh+OoUr9ggRAlu
V8rh4++NlZxA7d+N+SnorI7HOtK9/OwBxb6XDsaW/E8vZYZqhKOANQ82js9mg3lg
caoMxt5sfjhNQN6Nge3r3UnLoEiw6Fw9bfmLll5WKhtamdeu66LVI5OxYdr4trQJ
pbtRQngW++fltRvH+v2H1ae+jYA0Sp4LDC7dUSw8/DVY1Ff28GUzsY9jZMVbm4uj
9QVLGneH8XH2AuAInhBoadK/PdoejJ8Cmg/WRopXCnr8oQ4cMcOC8fZko+k9pP0Z
yzy0qu/MuBD8UObW6qtgV4fz/7YqHR89cwmAt8B/5rJXFpXKzMCHBFqk/hr1dGUT
cqQNn8CF6mfBJzZYnMt1lzM5pyNpcboYWaeJo8mCLP4nTBF3NnmXbc15ZfXrK4ux
XMFBYX78iKwoaJfjixjFUHCXMX1SxkyXiBv6VDnxJ1q/hjyQTm8x9jTOR74J0O60
VFOx9cx/VhIXDdsVodO+EJl0oZNHeB0qSqyJrO25tU7ZG7wqRf8=
=OyHc
-----END PGP SIGNATURE-----

--pfB5pI4Rm2HFeHlq--
