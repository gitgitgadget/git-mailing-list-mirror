Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7D9C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 11:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbjD0LNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbjD0LNj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 07:13:39 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227344B9
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 04:13:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AFC3D5C01ED;
        Thu, 27 Apr 2023 07:13:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 27 Apr 2023 07:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682594016; x=1682680416; bh=Wk
        5xUhK6Ey2dS/9v4sBBQMtiDo0SF6wA2rIjgkeuxfU=; b=UwQTDckpMDAdfSivuP
        +5HwTTFB2fM9Iwsu0lkYNysfVNZJYsYpe7bWMCM+qeMp/F6TmkvsvSkc7eNLSKyq
        ZDty6+6hJGxkOItYva8YIGd0vdxtLVoTKs7RuAhfIVdZknP7Rd0/gnrGefg8g/sS
        4FaW5hJuzC/6AZGqIDirgbpFX6uHICTiROrTIZlHz669FgIY8DMqipDE6ncXp1+t
        z+ZP10CZKlC1usXj/cVfjRZV6GJEFVnFYHw2UjNFbTRMcgAdcNSj/pWuBvxwA0cP
        yYQhsOAu+E56BRYHLvzeYvzGYWUJbqAn+6m7miI2Nvh9GtTey/7IKch5tIBwrB0o
        Eu6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682594016; x=1682680416; bh=Wk5xUhK6Ey2dS
        /9v4sBBQMtiDo0SF6wA2rIjgkeuxfU=; b=gGYBW27N3ICIQBjS5G7iroix5TV8H
        OmR9c6OA2vnyQYskR/yZoe4ISq4vAEOkbZv2dPFr36M+U38kVcWBg9i6rlnMkP4s
        wTutMCLna7IVFv/cGvZNxrp4c0vKDC7hmipm7caQzN+UR+fPY+pOVtvsaObEQ7cf
        /AcevifjPIqdHx6+EJS9k7as2JmDPmvd6Lrjy7Tai6WQtz9WbIXOME6afJARGF+c
        /No7ERQWISXWbRVFUOLtKgphmNk04Z6UJ59aYF5ODA3c1720pdYus111WCFfSLRY
        Hd+6t/oxvOS0Bx7L9LBpIWFqOTbET+1ilomI6v58gZgsmnpzBevR0hAAg==
X-ME-Sender: <xms:4FhKZIzgqSZEkCguXDOqoMQE9OBN8PM9PT27AYBKpuu5vk8-V03A-g>
    <xme:4FhKZMR_GMfEN9l1cHl_yfFXkv0DVFGHA1sXYw0awrgUbMHg8dkMicCzj4U7AHxJR
    pIU-RDs1sGlEhgetw>
X-ME-Received: <xmr:4FhKZKXWSICwdj6G5TMGn-QN_2fl7V8tAupU8XbVdn2AGlZsaEWV9AS48EZHawrf14HG06XLg3nZkWUYdbIaA7dE-VD50IKGmXrr6pbNVi3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:4FhKZGgO20r2Hr4Sm1sliKFvm0PTmQc36oTOC__a2KGJlubd6FysUA>
    <xmx:4FhKZKBWWmLNnhXf1j6Rd7Fw4NthJpNA8Lss6KY17VsygyloodOGAw>
    <xmx:4FhKZHI-sSbx-yM9mBORePe6EjRAHAgdoDVIcrlCnQWbGcTVSTQbHQ>
    <xmx:4FhKZN-UcaD5BK3lAd3lXKV9yeZujlC09PykBOSwFDNkJdM9Cpx1kw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 07:13:35 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e25ea291 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 11:13:06 +0000 (UTC)
Date:   Thu, 27 Apr 2023 13:13:33 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 7/8] fetch: introduce new `--output-format` option
Message-ID: <0335e5eeb4ded336c5ff7c8888c8aab9dfed2505.1682593865.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lhvRqRaFFVcfK022"
Content-Disposition: inline
In-Reply-To: <cover.1682593865.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lhvRqRaFFVcfK022
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is only possible to configure the output format that git-fetch(1)
uses by setting it via a config key. While this interface may be fine as
long as we only have the current "full" and "compact" output formats,
where it is unlikely that the user will have to change them regularly.
But we're about to introduce a new machine-parseable interface where the
current mechanism feels a little bit indirect and rigid.

Introduce a new `--output-format` option that allows the user to change
the desired format more directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/fetch-options.txt |  5 +++
 builtin/fetch.c                 | 48 ++++++++++++++++++----
 t/t5574-fetch-output.sh         | 72 +++++++++++++++++++++++++++------
 3 files changed, 106 insertions(+), 19 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.=
txt
index 622bd84768..654f96f79d 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -78,6 +78,11 @@ linkgit:git-config[1].
 --dry-run::
 	Show what would be done, without making any changes.
=20
+--output-format::
+	Control how ref update status is printed. Valid values are
+	`full` and `compact`. Default value is `full`. See section
+	OUTPUT in linkgit:git-fetch[1] for detail.
+
 ifndef::git-pull[]
 --[no-]write-fetch-head::
 	Write the list of remote refs fetched in the `FETCH_HEAD`
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 97a510649c..30099b2ac3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -52,6 +52,13 @@ enum display_format {
 	DISPLAY_FORMAT_UNKNOWN =3D 0,
 	DISPLAY_FORMAT_FULL,
 	DISPLAY_FORMAT_COMPACT,
+	DISPLAY_FORMAT_MAX,
+};
+
+static const char * const display_formats[DISPLAY_FORMAT_MAX] =3D {
+	NULL,
+	"full",
+	"compact",
 };
=20
 struct display_state {
@@ -1879,7 +1886,8 @@ static int fetch_finished(int result, struct strbuf *=
out,
 	return 0;
 }
=20
-static int fetch_multiple(struct string_list *list, int max_children)
+static int fetch_multiple(struct string_list *list, int max_children,
+			  enum display_format format)
 {
 	int i, result =3D 0;
 	struct strvec argv =3D STRVEC_INIT;
@@ -1894,6 +1902,9 @@ static int fetch_multiple(struct string_list *list, i=
nt max_children)
 		     "--no-write-commit-graph", NULL);
 	add_options_to_argv(&argv);
=20
+	if (format !=3D DISPLAY_FORMAT_UNKNOWN)
+		strvec_pushf(&argv, "--output-format=3D%s", display_formats[format]);
+
 	if (max_children !=3D 1 && list->nr !=3D 1) {
 		struct parallel_fetch_state state =3D { argv.v, list, 0, 0 };
 		const struct run_process_parallel_opts opts =3D {
@@ -2050,6 +2061,29 @@ static int fetch_one(struct remote *remote, int argc=
, const char **argv,
 	return exit_code;
 }
=20
+static enum display_format parse_display_format(const char *format)
+{
+	for (int i =3D 0; i < ARRAY_SIZE(display_formats); i++)
+		if (display_formats[i] && !strcmp(display_formats[i], format))
+			return i;
+	return DISPLAY_FORMAT_UNKNOWN;
+}
+
+static int opt_parse_output_format(const struct option *opt, const char *a=
rg, int unset)
+{
+	enum display_format *format =3D opt->value, parsed;
+
+	if (unset || !arg)
+		return 1;
+
+	parsed =3D parse_display_format(arg);
+	if (parsed =3D=3D DISPLAY_FORMAT_UNKNOWN)
+		return error(_("unsupported output format '%s'"), arg);
+	*format =3D parsed;
+
+	return 0;
+}
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	const char *bundle_uri;
@@ -2102,6 +2136,8 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 		OPT_BOOL(0, "dry-run", &dry_run,
 			 N_("dry run")),
+		OPT_CALLBACK(0, "output-format", &display_format, N_("format"), N_("outp=
ut format"),
+			     opt_parse_output_format),
 		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
 			 N_("write fetched references to the FETCH_HEAD file")),
 		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
@@ -2181,11 +2217,9 @@ int cmd_fetch(int argc, const char **argv, const cha=
r *prefix)
 		const char *format =3D "full";
=20
 		git_config_get_string_tmp("fetch.output", &format);
-		if (!strcasecmp(format, "full"))
-			display_format =3D DISPLAY_FORMAT_FULL;
-		else if (!strcasecmp(format, "compact"))
-			display_format =3D DISPLAY_FORMAT_COMPACT;
-		else
+
+		display_format =3D parse_display_format(format);
+		if (display_format =3D=3D DISPLAY_FORMAT_UNKNOWN)
 			die(_("invalid value for '%s': '%s'"),
 			    "fetch.output", format);
 	}
@@ -2339,7 +2373,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			max_children =3D fetch_parallel_config;
=20
 		/* TODO should this also die if we have a previous partial-clone? */
-		result =3D fetch_multiple(&list, max_children);
+		result =3D fetch_multiple(&list, max_children, display_format);
 	}
=20
=20
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index b9dcdade63..662c960f94 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -24,14 +24,37 @@ test_expect_success 'fetch with invalid output format c=
onfiguration' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'fetch with invalid output format via command line' '
+	test_must_fail git fetch --output-format >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	error: option \`output-format${SQ} requires a value
+	EOF
+	test_cmp expect actual &&
+
+	test_must_fail git fetch --output-format=3D origin >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	error: unsupported output format ${SQ}${SQ}
+	EOF
+	test_cmp expect actual &&
+
+	test_must_fail git fetch --output-format=3Dgarbage origin >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	error: unsupported output format ${SQ}garbage${SQ}
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'fetch aligned output' '
-	git clone . full-output &&
+	test_when_finished "rm -rf full-cfg full-cli" &&
+	git clone . full-cfg &&
+	git clone . full-cli &&
 	test_commit looooooooooooong-tag &&
-	(
-		cd full-output &&
-		git -c fetch.output=3Dfull fetch origin >actual 2>&1 &&
-		grep -e "->" actual | cut -c 22- >../actual
-	) &&
+
+	git -C full-cfg -c fetch.output=3Dfull fetch origin >actual-cfg 2>&1 &&
+	git -C full-cli fetch --output-format=3Dfull origin >actual-cli 2>&1 &&
+	test_cmp actual-cfg actual-cli &&
+
+	grep -e "->" actual-cfg | cut -c 22- >actual &&
 	cat >expect <<-\EOF &&
 	main                 -> origin/main
 	looooooooooooong-tag -> looooooooooooong-tag
@@ -40,13 +63,16 @@ test_expect_success 'fetch aligned output' '
 '
=20
 test_expect_success 'fetch compact output' '
-	git clone . compact &&
+	test_when_finished "rm -rf compact-cfg compact-cli" &&
+	git clone . compact-cli &&
+	git clone . compact-cfg &&
 	test_commit extraaa &&
-	(
-		cd compact &&
-		git -c fetch.output=3Dcompact fetch origin >actual 2>&1 &&
-		grep -e "->" actual | cut -c 22- >../actual
-	) &&
+
+	git -C compact-cfg -c fetch.output=3Dcompact fetch origin >actual-cfg 2>&=
1 &&
+	git -C compact-cli fetch --output-format=3Dcompact origin >actual-cli 2>&=
1 &&
+	test_cmp actual-cfg actual-cli &&
+
+	grep -e "->" actual-cfg | cut -c 22- >actual &&
 	cat >expect <<-\EOF &&
 	main       -> origin/*
 	extraaa    -> *
@@ -54,6 +80,28 @@ test_expect_success 'fetch compact output' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'fetch compact output with multiple remotes' '
+	test_when_finished "rm -rf compact-cfg compact-cli" &&
+
+	git clone . compact-cli &&
+	git -C compact-cli remote add second-remote "$PWD" &&
+	git clone . compact-cfg &&
+	git -C compact-cfg remote add second-remote "$PWD" &&
+	test_commit multi-commit &&
+
+	git -C compact-cfg -c fetch.output=3Dcompact fetch --all >actual-cfg 2>&1=
 &&
+	git -C compact-cli fetch --output-format=3Dcompact --all >actual-cli 2>&1=
 &&
+	test_cmp actual-cfg actual-cli &&
+
+	grep -e "->" actual-cfg | cut -c 22- >actual &&
+	cat >expect <<-\EOF &&
+	main         -> origin/*
+	multi-commit -> *
+	main       -> second-remote/*
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'fetch output with HEAD and --dry-run' '
 	test_when_finished "rm -rf head" &&
 	git clone . head &&
--=20
2.40.1


--lhvRqRaFFVcfK022
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKWNwACgkQVbJhu7ck
PpTa/g//Vb2XnrvWkQQ4+eqWCk9g8sdbSK1AS5Zr81AoL8VvJypDXpZP3vAOVh2X
vRDA+Q3FBbyVG6OUYpdC2RR8uyXRJEV6olBcAH7ChQa7nBkLdZeQG6zqLc2bTkgf
GBppruqg+us8rT6ngcQQaNAL51C/ybAsi9XbRH/ATu+Hjv7rPSGkHVtJuiuaBr/u
yj/iNrgcxHbyNZU4qKvUW0UpuSlKj3f+EVw1SPkLEqyrF0ssYGac/CjPDKY3R9p/
tB393wFWVWXv832J5Ig21AWEaD1dn/7QpFunGQNEa2HPZwdvDJUGYNC1J9sOQbjL
gCrPeh9QQfgUQTeZhFi8jE0yKG11LOJjeqThek3WMHFVcssdg6kpm9N5LcSamYM9
jt+BErSwhN/PusXIC45Pwcpif8+0WZnrnJ143gz4tGizZnm8M8kOUGBIIc5O6I1J
X1bMvLGUAXJ5zXD3GTikjj/+dgbCAc3a1zQiRlFgys0Wj+seyeFFVmfIhS4qzjXh
ae1K04oaMQO94BWCiil3l2K8uVjyTgiD6Xg6lhPydzB32eY5GH9mX9ezU1TgWQTP
R2rMfTKRYoQsYiLx3NH4KsZx1Hv4PKESqPI5GJCBksBZTdVrVGbj4BCq7MWVKdpn
Bz/1EFInD6EnCbSedK0PWK2B+wbMrfk4ymvG/fzdBth/1H68hWU=
=Fi8T
-----END PGP SIGNATURE-----

--lhvRqRaFFVcfK022--
