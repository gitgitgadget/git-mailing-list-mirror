Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0F47F7E
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755314; cv=none; b=QzlDVQ2z6cquGgn851oIhTLM68R1KJ2fa1jiZwqCx37hDs2IS/fzzA/Cidb/yN2jcAiSRN6fe6XBi5jjvzDpYjxGqa5ntxm0QrQDFIoVMeWsWR4uv0Gz9ut91cSTuJc8jVXSBzIY6h28l3LEw/kmYjyVycMiOfaDB/6TMNEkm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755314; c=relaxed/simple;
	bh=f7rCj2t19WxBdKNMwIhCalGlsYY6H5K3jpkbsViagjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh8jMkWww3D7A9mREbb5Cv3A10fgHqJuHYXMTzJsCNhBlfBg/GThsTOz5qq2XJ96nM9LjmyeWopvWwQfs0oD2Z0QDahsn6xAq6dJcEkQ4DyMdpjoSRCJV9hTEl/BVP4CUja0hRWVaA/NY7p/wb/jEfbKqcvh9lhz9qpDufswZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A0kbECu+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PgVYLi8S; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A0kbECu+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PgVYLi8S"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E565F11400FA;
	Wed, 15 May 2024 02:41:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 15 May 2024 02:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755311; x=1715841711; bh=EM7SACTZAq
	bmfIQZG1DH95ZawkaVqX5XFksjOD2yaNc=; b=A0kbECu+tLqPjv9ivu0Z4I07MH
	2wlbkj3nDI/PIDs0PE5gyPG65zmBp9PTi0aDgjKN0fSTag5cORLXRPXFKMh+ShUx
	2ZNG9upuKDWErz3b/WkxwNtSU9VbTVQJVTm+sKKZPYU2nvGNB3+WC9aWcyKYirwf
	8Kkz2gFa6FYIYCuyqJsMXHP/nnHsSlX6U7q/X5CCt2gv9SZ2LyqD219vm/+/zGux
	CxhxiBqo4PcnqiQAI+KW6MXE5g034mrDR/3uY3yaPg9KLRfXIdiGFBLkw1RntS/z
	3E5pB40N+1/iC9xBXrKFZm+3WrObomuQ0tiFqsmVrZGWTzOyUocvstmsXfUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755311; x=1715841711; bh=EM7SACTZAqbmfIQZG1DH95ZawkaV
	qX5XFksjOD2yaNc=; b=PgVYLi8S/iEaxLVK4RMjPNpSzPRzmXlqB88lcQrts11X
	uEB/idqLRUc5qJBum0iMfd9Txm17PZh/4G2Z8zCIa8PCUedGT/qe1/peFa2A/5je
	puKSkN4nwKkKc9hNTuUk57fz59J+4IesKQ+cVQYvQQPzNbLhT4wKTlrXSP7iYPd3
	YJ1faYU8Veyft3spETrcnUqyCS9QwuiG3Xa4DoL13LqjtomHxCiWQIuE1JtebdcT
	AYpWr22BWXklQe/sU7Q8mgekxvhtL9H53xNNrW6xGgRgQq7PPiBTXD6PZwIubyR2
	/wWQZj3Intyvd0ZrfmP9CgFNgilUG1JzHFRqcg8B/w==
X-ME-Sender: <xms:L1lEZqMds01ETSX8s85a2d4z5UN7Mj0Xk2I93URSsAMJqpBey-7fwg>
    <xme:L1lEZo8sHva5A9DNilPAH8iynfXW_9TH0rJIFwVGDl3OASBB-j4gANORjuWCuwCk3
    KgelPjgvCWYy1iU8w>
X-ME-Received: <xmr:L1lEZhTLFfRExeUyBUGRLB0hMrOt2-TpxxdnwSVLFdAUm6o3c0x_f4WSWPFU-uzrP9jMqoDkQa99eVq8dxjv1aWG03R2OX4t0YpWUcjCJ9w4PS53>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:L1lEZqvbDlWDseeI6AB0GUIj3sSW0iZWj18piCNKgyOtdvhfBXCE_g>
    <xmx:L1lEZifulpjN2-r3Sc7Xqz6aC7Lf7YZ32DBmLLxTSX9NKnhHeF9zow>
    <xmx:L1lEZu0MFXE4d2HWkdd77rikvZ6oxmOtthKwkZQaK8ov3aaUIXKzNQ>
    <xmx:L1lEZm8ArfJ8kjRZUifyfg3JzU0QIolIEdR7b5jIq6qRauKZtwpwRg>
    <xmx:L1lEZh6OjhFvFJ7HZNqHkWWKmMWBv0Bjc7LcYWCo7MVGO4IFu0RfbsM4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:41:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e95f6e7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:41:27 +0000 (UTC)
Date: Wed, 15 May 2024 08:41:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/21] builtin/config: move subcommand options into
 `cmd_config()`
Message-ID: <b1de0ff74d02bb01409bb97068b34fc1c11ccbea.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0AiT1s8Y+lbB6QTg"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--0AiT1s8Y+lbB6QTg
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


--0AiT1s8Y+lbB6QTg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWSsACgkQVbJhu7ck
PpS7Yw/9EviMBpHlRqAX9QhBIBF5FzFUhEaWuxPaNF0hOUhZbFo12AFYhN7oieb3
8pYQfyT313AKS6t7p2HRApjPdYYA0OcTtMi7x9xMEMeHzp83GBgQ+yKxzMLud8jM
V3wcyN4B+twLVeFRMnLad7ZgbZzcRzxGoybeRvWhQ7IjoHWfu3I6I6oLSONE9weq
jBt0lUo+jM0e1u/d/BDYprogA+CsCbuh5JkN9cg3R9/HODsmkbeZNWxL4X5yTrIr
ZKyn8FdTWLOmpzwNRo84IfvH38dYJB82RxfE5quroc+UT1ueAUdY3WWi/YX64K9f
krGykAoLmAKY9njMEElrcEwMF3BWjJYipS6EQyJIXQc/i2/54izgtAKN2JnAxBM6
UN7mz/3cgAmB1qCjJqgYwWvNIG9VAKa3vmen5Qs/4nCcsS6IZxzlfaV7pJTFljF3
ZsItfz8Ccs/eRZRyvAOu8mjsGWVhrIw0wHelrVke+MWvy0QSFJ12MNi2eCuSRw6s
DDifWs8TkTJSaQpqdWE2mWNXLFKc96Uy3hErlX9UTKGK5Mh4oba3U3fn4ovf88Xj
ndEs07kZymwy1EkSkyj14Ug6DnCKsx0y278MIB2kcdqqtJaU+NCjw9OqYqdPDoq2
8YlE+lOWfTtFKT9pA/QZZnzw44p6/3NcGC4bCwf/1vCNHlIBb4k=
=kV5U
-----END PGP SIGNATURE-----

--0AiT1s8Y+lbB6QTg--
