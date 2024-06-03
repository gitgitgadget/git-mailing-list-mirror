Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB58565A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407659; cv=none; b=LUbFVzHXPEcI1rtLI6VYOxPppDq8XqjwG24lC+KDa39z2gEH3Njfen53wtftRXQHJ43h5aQ9vYqeMOna/7Ovabd2EEW7MyIxaNbZ4P1zIE5DmkcDQSzaOLUtlgJ/ogMNhV/o+MbQ29O4+NWcdw546Fb9KyuH9+Xrel9IEd+mO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407659; c=relaxed/simple;
	bh=gSABFHU3qEEE1AM/xwml1VKAlh4sKBR4xHhmkVjPjmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF7D3pxUN7kj6afKSs+bxRZyPd/NxyKfrLlaGhsZxxk+Jvb2WQdMUiRgxZDwhWPh1lESLT+DFObkNouJ3XdH7YT4lNhY5VXGVMUqK1J4mceQcJYDTfymGinPlkXKt0yW1EKapDSH+FAhie4xfibzXzWn8HEMVVXfL53nKsfgwcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pQneYuCr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bh910Sv5; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pQneYuCr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bh910Sv5"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 9B9B01C000D9;
	Mon,  3 Jun 2024 05:40:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407657; x=1717494057; bh=PIhSsmpN2D
	bdHycRqSo6eX2QIxwomAU+bpr93CyHfJQ=; b=pQneYuCrIruKBDf8XDv8PqFVld
	p9TPTOlqGqC3b3+8KijksZm3cdC+pr/zH/Xw2KL6vEraA+7BC58Gb0jNM510v4Eh
	fSR6YMeqFgs1Is/ugVTxHHJcjHo18Fhe3lT64Pp4R40UyEwKTyxlKQs7TiCqzJuL
	NlJqIs4xHRFKMgiK2c5eZOPAUnHAD1c9EXYdtdnYZ3a6lsqlAPjUQ25ngNTRWuZc
	XBcwY8AY4Vcgat7NEYAAXN9Fbsces76e48skh7hOHaDtwacnYn+NumfM7SELPsB4
	AkcZSilgXl14xLAB4Hpn13Kecr7nA8cryfk4y3eSOCjq2kbhD+sjYyCOEhIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407657; x=1717494057; bh=PIhSsmpN2DbdHycRqSo6eX2QIxwo
	mAU+bpr93CyHfJQ=; b=Bh910Sv5dONc2OZnl6MVyGvNFe+a/feTLm0rje0ph6ab
	KNwalwBah+TIpGBzRm+imCFZgAEfE2NxDWylT/dDXIL1Yv897rKrPgajmG3I1UV9
	XIPYgDjxFSA9t+lTCfccN3AoflfdT+K+44UTiLl/frW8cAA0bkWDIkoLC+2FdKTd
	EhmOk/JWo6gWwJXdHwHACpo7uMPDYNgSMUKRgup8mopDC5wFn0XLwoqkZ6fZ3Hxn
	xmvmqt6ITvHexzC95YjcebJ53eNoFRhMWlgJLXXpfsfAsPziWuQRNsLP0tu6aoD3
	bFBWrT0eUNsoLbdaxZZNcSiDt1YJE377+EBwiujAwA==
X-ME-Sender: <xms:qY9dZuY4GjrAZfSwzIPZCAA6Io7iLK6IrB_B7B5-rkEqWvH1C0uLBA>
    <xme:qY9dZhb6RnwRa5Bhe1t9gMoMx-2tmmInh4g_19TZeJd9imjh8UzO9avpjrlN0w-F9
    BGiAz_-7F_TeHya-A>
X-ME-Received: <xmr:qY9dZo-XkEY_40xUBn931yXqA4-Ae-VZgF2AXa78dMiLXj6g4kOZhMCnTFIbDd9NQFRY7LXlqZfx_qIR5tkE70FjOzyAEqH6Sb6PCv-9obulD-79>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeegnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:qY9dZgpucvIzg36a4iMdgKVwcaMLsko3tZIRZe--Qbp3JCWiCo-ZIg>
    <xmx:qY9dZpqaEWNoZZhdNzSmQXE1I5NYKJquMcMPZ1ky1w98yNMSQf5f8g>
    <xmx:qY9dZuTLQ5KfHEbTUdQyDjKsIRnh7ZIdjys0Zj3CKah21C3M58PL-Q>
    <xmx:qY9dZpo52lAbKS0Ea9U47Xo00z5z7tWv2UCizpKVCKOsURyt4_dJWA>
    <xmx:qY9dZgVK_O8dxTTnaP0wUj02F0Grq6ChO2KYi2x9QJI5NiCZjwjJJmvJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f3f4ed40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:40:32 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 24/27] builtin/rebase: do not assign default backend to
 non-constant field
Message-ID: <0a84d66e68b185b792ac3b3925d1bf7394e03362.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZT7pqM7MbvEtXpF1"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--ZT7pqM7MbvEtXpF1
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


--ZT7pqM7MbvEtXpF1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj6UACgkQVbJhu7ck
PpRXYQ//eyyii8KbBh1A5CtDBs1SN+RAS0DAGJCTQripLrqPHYS+KtvOmV6MJhHl
HGzzsDk2nLW9qW4gqvxtL8k7F6qB4OjD/1TQ4jqJZ9R6zF7bwNwsoFpF4Aqt9hrc
9/n2LvwkhpxoLWTMoGTQ513gRu0M4P2v83YqNA/kQ8eGsdtpHQ1hLTBGG0igdVtV
0Fet7fgNJWMXa1tzUfAS2yMzR8l6xvLoOBG60OQXTQqRnD103XKJm8VSd/JiJbG2
QjuX8F/IdGhEoW5jeWEi4fFqBpVBMXvY3Vj2L04oxclN5nFWFz1S4dQ1M8MxEbtu
ZbITmYjb3qaE+zh4Srl10iL4/HIDcGnr0q+8KNR7e4f9O0/KC9qTlBXPRkhbzS4Q
cTw/AruZRsXBh5vB+cO7nRLBhJdp+i/3JbhjgZDeaovi3iOlZOjnrCR5ifYwLoYV
gh/WvAu//bkrrgoLEhCxeOV0g7oL6xcXyZgc31RyfbuSTy2afpe7UB1XNF0pYYAa
EnMEMxKl/geMPVokZg6ZzMJhyk54FlMzAVSMlMlMVYAl+eEHGiOhT5+02jFZVajg
lRxEc+cF5buhQutZ35kn5VzgRu5fIrPLxvtwGBSQSow5pe5TWu9YJbNDs54oOD88
t34V5jK0p33HpW6+qYNyJbX7kxoGGISiaW3ltXR6Gzn/QJ2zsR8=
=P683
-----END PGP SIGNATURE-----

--ZT7pqM7MbvEtXpF1--
