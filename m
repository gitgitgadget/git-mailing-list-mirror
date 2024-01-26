Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFF1B7EA
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263757; cv=none; b=djxaDIaH6aT8tUGeTkJyG/e36Lfzg1QieQI0BRecEoL+rlXLTvdXd9YTRRko6eZHfSQE+A6qwWbyhlNySQWIEb/tcZ9quEhqMAACtRQxvEexmPF15YdGHIsx/5YJdxNNKP+N449lVXqPbnk3erg1GBN6YoufoBJdLJayTmm5dbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263757; c=relaxed/simple;
	bh=vPBSartrkCnvHJ2EEw1vyzbkNrYovAhFTThlk6XfwdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU69bMCXkE49wQ4rOSsgk7O2rgx88/MsC8R0Qj65tWnzsTBQ6M0RX8M98EsKXk6qkG3zH093IK8AZE1eQh75BWK0lOoYhXXofkLS61K0GcjCvSk2MZaQzD1/lOXy4BifQY5ObOHUCINWS8S6ySdBUxl7dqe5D80Eyz/7fX9JPlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LF/FE8QV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSb35CMk; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LF/FE8QV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSb35CMk"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id A94FE5C005A;
	Fri, 26 Jan 2024 05:09:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 26 Jan 2024 05:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706263754; x=1706350154; bh=xhZsOKFa9/
	9POOonOM2Ua2Jz0b1s9Tx3esq37MqOW4I=; b=LF/FE8QVIQ0yNuSKqrJ+qtBefM
	XdB+BB+Kc1nR49qpPBp6FDt/+g5GHZQizuu4/A9Y2SxVU3ferTNU3UQ+9mmIwffs
	pS2f1KEjY1yFPWpTaonaAor1mR6GUQBwmmLxDch8kd2Y8u4gURTFPcs6mW7LTnQr
	5YrHXVY8BUBoA4wNCeNywWqYNm9Luof9wAod1mpVf85lK79NQW0p/7EQWMjY4HYg
	C9XyqRxDqggh3CsufDfE9YufOaldogkjI2CpCFQK9X14CkXu65/nazy69HcqWo5H
	Z6t51s/DIfeoHFogiCUzt1dfbn/bKQ1E66saqI6mcTX7j5/kWVXrdtzk0oCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706263754; x=1706350154; bh=xhZsOKFa9/9POOonOM2Ua2Jz0b1s
	9Tx3esq37MqOW4I=; b=SSb35CMk7t/VzzfesV8+oLoh4N2JZuokcBrAoJ01/wvd
	mxmmpiNGNgbTJgM54V8uwrY2et5yjXCZISgri6l9hCdBVfbI519uq70CdtyX3hep
	IAhfbjzJkER/M8EH2SNW2LtGfvcO1a5L+8dvZIreudZES6riI3nMPkQir7hFMSPx
	tTJfiIvMrz2sVZ+AZ7hrRvTOh4bhsJObW7jcDZeOFmgE5oN82rhUbGhyly1Po0mb
	Hii3LQHqb5AIzKiaRiNOFqBXF/4HidvRo2IvHKmhrOr1m2thorX/rWVOD9rHGuIh
	l9YFzX1ZlsSH//1hpjekScMw95JJq0QuQLJaFiUlEg==
X-ME-Sender: <xms:yoSzZYFbhsTr2MsDBcTbQY3dXRcio9R88EP7Kf9nFKWMKZOL7GK5wg>
    <xme:yoSzZRX4TOR5g442Y5NROkdduoZ8LuN-W79j8xw6dKFA5ryEnLO3O7pgOetvdIxzb
    MbTQWK7wXKwFQxAnw>
X-ME-Received: <xmr:yoSzZSLXZDxGYnl16cxGNJn1mHpDBB8KF40FgHH2Jl7nCIFebFdJs02mnpjRyaru-9t7HSVHfELNChkvzMcZ0IyRkRDPx0U-IF3J8rPrynhcs79lBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yoSzZaGRc2TLoOVIrfmN5qiBfAXy47BUkSgEV2E9jVkSAp7kc2Nk2w>
    <xmx:yoSzZeVru7QjfT1CJVQrQgT4F85REQXPGz9p_2nZYwCpA1g21OIWNw>
    <xmx:yoSzZdNKv-TkKvVjBVT8Q-IhF0xPPeukr1oheQ9FuoZAYSne8pUo-g>
    <xmx:yoSzZRfQ9OBFQ_QqPEgY7Q8L9bzI0c7i-sZusnr7gyR64CLgYRRCoQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jan 2024 05:09:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50c58aca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Jan 2024 10:06:02 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:09:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3] reftable/stack: adjust permissions of compacted tables
Message-ID: <a211818108053754aca002726d0206623a347952.1706263589.git.ps@pks.im>
References: <cover.1706099090.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="veBjRLSuQyCisLwJ"
Content-Disposition: inline
In-Reply-To: <cover.1706099090.git.ps@pks.im>


--veBjRLSuQyCisLwJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When creating a new compacted table from a range of preexisting ones we
don't set the default permissions on the resulting table when specified
by the user. This has the effect that the "core.sharedRepository" config
will not be honored correctly.

Fix this bug and add a test to catch this issue. Note that we only test
on non-Windows platforms because Windows does not use POSIX permissions
natively.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Changes compared to v2:

  - Extended the commit message to say why we don't test on Windows
    systems.

  - Renamed the `scratch` variable to `path`.

Thanks!

Patrick

 reftable/stack.c      |  6 ++++++
 reftable/stack_test.c | 25 +++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 7ffeb3ee10..38e784a8ab 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -731,6 +731,12 @@ static int stack_compact_locked(struct reftable_stack =
*st, int first, int last,
 	strbuf_addstr(temp_tab, ".temp.XXXXXX");
=20
 	tab_fd =3D mkstemp(temp_tab->buf);
+	if (st->config.default_permissions &&
+	    chmod(temp_tab->buf, st->config.default_permissions) < 0) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
+	}
+
 	wr =3D reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
=20
 	err =3D stack_write_compact(st, wr, first, last, config);
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 289e902146..5089392f7b 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -443,15 +443,16 @@ static void test_reftable_stack_add(void)
 	int err =3D 0;
 	struct reftable_write_options cfg =3D {
 		.exact_log_message =3D 1,
+		.default_permissions =3D 0660,
 	};
 	struct reftable_stack *st =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-
 	struct reftable_ref_record refs[2] =3D { { NULL } };
 	struct reftable_log_record logs[2] =3D { { NULL } };
+	struct strbuf path =3D STRBUF_INIT;
+	struct stat stat_result;
 	int N =3D ARRAY_SIZE(refs);
=20
-
 	err =3D reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
 	st->disable_auto_compact =3D 1;
@@ -509,12 +510,32 @@ static void test_reftable_stack_add(void)
 		reftable_log_record_release(&dest);
 	}
=20
+#ifndef GIT_WINDOWS_NATIVE
+	strbuf_addstr(&path, dir);
+	strbuf_addstr(&path, "/tables.list");
+	err =3D stat(path.buf, &stat_result);
+	EXPECT(!err);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+
+	strbuf_reset(&path);
+	strbuf_addstr(&path, dir);
+	strbuf_addstr(&path, "/");
+	/* do not try at home; not an external API for reftable. */
+	strbuf_addstr(&path, st->readers[0]->name);
+	err =3D stat(path.buf, &stat_result);
+	EXPECT(!err);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+#else
+	(void) stat_result;
+#endif
+
 	/* cleanup */
 	reftable_stack_destroy(st);
 	for (i =3D 0; i < N; i++) {
 		reftable_ref_record_release(&refs[i]);
 		reftable_log_record_release(&logs[i]);
 	}
+	strbuf_release(&path);
 	clear_dir(dir);
 }
=20

base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
--=20
2.43.GIT


--veBjRLSuQyCisLwJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWzhMUACgkQVbJhu7ck
PpRkWg//WF42D8LNzVEWlenH7yMzrG4HgDr4zluyfjJAjpA9wNEzHLOneqQzNzk5
U9R2vGowPp+vGi7Xh2wN09DCzZvQzjMIwV+UCryvkdihqMuDMjJsrQBEx9uyvyEw
nzdlc9tIwAPKc3E7Ara1LDLaj+X4AAJ7LXaQTu40K2W12uMQMCHUQjXo+UznJ4Bg
/k1nl+ya0ilypjsFSO1IHhN9ZVzBVZEZY1Z1xRVSccdNcRBlBLPLyUoiy4iMeUhS
gpxFbLsFJZ5zxhN6ChQXaW0KRrfMp0nP1+JAGEgjEzzlA69PSx24DIU2R3PKKUkM
Kr2rP6Y4pHtsOWLkNeDNWBU+ENs9Z5Ls4KMWWqkq4sBeeAhf4ypp5K3Yg5oXdyjj
jf1NuQDk3Njj/5phaSAXMtbfVLH3ti1/OpVF1ZjGQp2Fm/UY1wOopX67LvwBlCEy
ajiUjFWVn1hHfnmOfH0O+aWq0xt3b4a4eHiV4xEkUolZXmf574V9bVI0O6Paw0rF
SBGKtvjuvX+z5CNG7SEo9MDJtjVEFPlbnFy6qePgGosr4BC89GoNG2+CWAl2VGls
f5HPZk2/qCVXORasnfNBA9yLudJPL38t8n3A3l3R9a2W0UA280VI2Wo1Dgcy20Y6
CVlQBKtQAu/02UTEwJzOX4G0xCcCf3uOUD0TOjvYw4GEkdkWU24=
=6cgw
-----END PGP SIGNATURE-----

--veBjRLSuQyCisLwJ--
