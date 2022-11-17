Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D2C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 05:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiKQFsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 00:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiKQFrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 00:47:32 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC96DCC1
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 21:47:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 448973201B62;
        Thu, 17 Nov 2022 00:47:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Nov 2022 00:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668664023; x=1668750423; bh=7+dNLRcjiC
        hKa6QJUaJ5xTmN3a3Hatax6DUNpScAdPg=; b=veWZ5eQ63X4qZ3oUHtXfpv+vHo
        aZCmUmye4GqZB8j7CWZld1qtOWnUCLKNyZlFrAROS/CHAmYJ/bKRILGShkNtWesW
        rHHn2SU/F6YPjYxLLCC0AE0KcUbJ9/25ineBpe54ZFIYuY34wtEKOSvKxb9f5MC8
        Qm7DitOa7MmgEQUoAOQGrWqitYHDm1vdEJys8rjWFpT4d2miGfGF3mGhftuOKPn0
        JlQl9r1mwi5YuMAOmYJDibbV3uAiIp8eHc+O4l3tRTVIYdErNsBjGnfApIzBIJrW
        LVaOWPmu3sBcOF151hpsxedQtlgsDrtjre7asXbPequj26tpDrdjFot2koaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668664023; x=1668750423; bh=7+dNLRcjiChKa6QJUaJ5xTmN3a3H
        atax6DUNpScAdPg=; b=uOVNbRkXoHOqGY/bHb5Hwy5HiPJT2PEhajwv7rdC1Rfo
        LW3ihC1IJVvSUsEpae1rLX7GO8Y7mKd+H0aGHcdsJTDjXXkdrwwcun8+ZmOsAoux
        X4pmZu01owdcM2w/vAPtMsQFfQWL+IWySz7v1bcpLo3abjEn+b6fGYEJOkxzxD7x
        DqoC17M7fiNfPgUh6A5ZGtp2NKJUFQMeCKz/JuH2NlQ57l7HdSq4nB4AySARoBTw
        W4ovfzUKatKpDDOYzrIOOUi+wP9J4gPH6Ccp5c3eMLv+BdzC6bkSNVy2k5ooeKPg
        7TThCiHQATLIYS+CaDStZuLx6zEx8NlXe/1NePx/8g==
X-ME-Sender: <xms:18p1YxQIgIGL0HDBVxaIwqZbyU2zEGZ5-MO1jtowMhHMFP-Tz932Ow>
    <xme:18p1Y6yEKz2cDQKyiGKgT8UhxYx9JMP4gttdWwGnlHde1_oflDcWMtG_7qE6TG4Z4
    1ofBMvwc3WlXY3dcQ>
X-ME-Received: <xmr:18p1Y21dqpIKoLPV-5OJuXgwZeW-nJvwXi9HzL4zOk6xUInPwSE9z7R4feaeFhjIchhfnuzkRC6TjgbCMkrlawi3hOvNv-EhNI5YMxpiFKctg4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:18p1Y5Ah2W3dK4ugEJbnHy88uae2c45YF4WxusKVfycIjw_4TFPuow>
    <xmx:18p1Y6hunuZhVGcaw81X6O8w41HHt7mAjCRRrNh4qX0c8xUhzzyH1Q>
    <xmx:18p1Y9qpprxGQ-rB6wBmyav28__tf-3dUxHva_o91xiwkRrfJ5aFSw>
    <xmx:18p1Y7uwJK2WulzPa33JtTvBPZSaDWzpwTn1nWLCkNNHOBGWFhDyBA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 00:47:02 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ae95f700 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 05:46:48 +0000 (UTC)
Date:   Thu, 17 Nov 2022 06:47:00 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 6/7] rev-parse: add `--exclude-hidden=` option
Message-ID: <f8b5eb5a7eaca22da803c4672058a706ffe719ce.1668663796.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668663795.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HVWVC26pKUfWEVO+"
Content-Disposition: inline
In-Reply-To: <cover.1668663795.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HVWVC26pKUfWEVO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a new `--exclude-hidden=3D` option that is similar to the one we just
added to git-rev-list(1). Given a section name `uploadpack` or `receive`
as argument, it causes us to exclude all references that would be hidden
by the respective `$section.hideRefs` configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-rev-parse.txt |  7 ++++++
 builtin/rev-parse.c             | 10 +++++++++
 t/t6018-rev-list-glob.sh        | 40 +++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.=
txt
index 6b8ca085aa..bcd8069287 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -197,6 +197,13 @@ respectively, and they must begin with `refs/` when ap=
plied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
=20
+--exclude-hidden=3D[receive|uploadpack]::
+	Do not include refs that would be hidden by `git-receive-pack` or
+	`git-upload-pack` by consulting the appropriate `receive.hideRefs` or
+	`uploadpack.hideRefs` configuration along with `transfer.hideRefs` (see
+	linkgit:git-config[1]). This option affects the next pseudo-ref option
+	`--all` or `--glob` and is cleared after processing them.
+
 --disambiguate=3D<prefix>::
 	Show every object whose name begins with the given prefix.
 	The <prefix> must be at least 4 hexadecimal digits long to
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 7fa5b6991b..b5666a03bd 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -876,10 +876,14 @@ int cmd_rev_parse(int argc, const char **argv, const =
char *prefix)
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
+				if (ref_excludes.hidden_refs_configured)
+					return error(_("--exclude-hidden cannot be used together with --branc=
hes"));
 				handle_ref_opt(arg, "refs/heads/");
 				continue;
 			}
 			if (opt_with_value(arg, "--tags", &arg)) {
+				if (ref_excludes.hidden_refs_configured)
+					return error(_("--exclude-hidden cannot be used together with --tags"=
));
 				handle_ref_opt(arg, "refs/tags/");
 				continue;
 			}
@@ -888,6 +892,8 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 				continue;
 			}
 			if (opt_with_value(arg, "--remotes", &arg)) {
+				if (ref_excludes.hidden_refs_configured)
+					return error(_("--exclude-hidden cannot be used together with --remot=
es"));
 				handle_ref_opt(arg, "refs/remotes/");
 				continue;
 			}
@@ -895,6 +901,10 @@ int cmd_rev_parse(int argc, const char **argv, const c=
har *prefix)
 				add_ref_exclusion(&ref_excludes, arg);
 				continue;
 			}
+			if (skip_prefix(arg, "--exclude-hidden=3D", &arg)) {
+				exclude_hidden_refs(&ref_excludes, arg);
+				continue;
+			}
 			if (!strcmp(arg, "--show-toplevel")) {
 				const char *work_tree =3D get_git_work_tree();
 				if (work_tree)
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index e1abc5c2b3..aabf590dda 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -187,6 +187,46 @@ test_expect_success 'rev-parse --exclude=3Dref with --=
remotes=3Dglob' '
 	compare rev-parse "--exclude=3Dupstream/x --remotes=3Dupstream/*" "upstre=
am/one upstream/two"
 '
=20
+for section in receive uploadpack
+do
+	test_expect_success "rev-parse --exclude-hidden=3D$section with --all" '
+		compare "-c transfer.hideRefs=3Drefs/remotes/ rev-parse" "--branches --t=
ags" "--exclude-hidden=3D$section --all"
+	'
+
+	test_expect_success "rev-parse --exclude-hidden=3D$section with --all" '
+		compare "-c transfer.hideRefs=3Drefs/heads/subspace/ rev-parse" "--exclu=
de=3Drefs/heads/subspace/* --all" "--exclude-hidden=3D$section --all"
+	'
+
+	test_expect_success "rev-parse --exclude-hidden=3D$section with --glob" '
+		compare "-c transfer.hideRefs=3Drefs/heads/subspace/ rev-parse" "--exclu=
de=3Drefs/heads/subspace/* --glob=3Drefs/heads/*" "--exclude-hidden=3D$sect=
ion --glob=3Drefs/heads/*"
+	'
+
+	test_expect_success "rev-parse --exclude-hidden=3D$section can be passed =
once per pseudo-ref" '
+		compare "-c transfer.hideRefs=3Drefs/remotes/ rev-parse" "--branches --t=
ags --branches --tags" "--exclude-hidden=3D$section --all --exclude-hidden=
=3D$section --all"
+	'
+
+	test_expect_success "rev-parse --exclude-hidden=3D$section can only be pa=
ssed once per pseudo-ref" '
+		echo "fatal: --exclude-hidden=3D passed more than once" >expected &&
+		test_must_fail git rev-parse --exclude-hidden=3D$section --exclude-hidde=
n=3D$section 2>err &&
+		test_cmp expected err
+	'
+
+	for pseudoopt in branches tags remotes
+	do
+		test_expect_success "rev-parse --exclude-hidden=3D$section fails with --=
$pseudoopt" '
+			echo "error: --exclude-hidden cannot be used together with --$pseudoopt=
" >expected &&
+			test_must_fail git rev-parse --exclude-hidden=3D$section --$pseudoopt 2=
>err &&
+			test_cmp expected err
+		'
+
+		test_expect_success "rev-parse --exclude-hidden=3D$section fails with --=
$pseudoopt=3Dpattern" '
+			echo "error: --exclude-hidden cannot be used together with --$pseudoopt=
" >expected &&
+			test_must_fail git rev-parse --exclude-hidden=3D$section --$pseudoopt=
=3Dpattern 2>err &&
+			test_cmp expected err
+		'
+	done
+done
+
 test_expect_success 'rev-list --exclude=3Dglob with --branches=3Dglob' '
 	compare rev-list "--exclude=3Dsubspace-* --branches=3Dsub*" "subspace/one=
 subspace/two"
 '
--=20
2.38.1


--HVWVC26pKUfWEVO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmN1ytMACgkQVbJhu7ck
PpRcHQ/+P8VtmlOL4gU69hBnlIbNAc7jNBtZgUj7e02EhgYogrZ+qbKNCnjPgjuC
xeZuBoiJyjvGFGQ3p/jkDJi+lt1HP/iPLkg8eCfbHnXd4pZY2tmEviEnZ6XcWxDz
zho0lpYIlk38B6RyTULTB/kuX3urOyXS2lH+wwqCoc1lfKtrXN47XDsJSRGf0c+e
BNpHvvVQeRWwno22/pQo9orHu5kfcLBKwoCrBd5N4G1mR6Acz9vp3Zv/XEUWuoQ6
2krXuQhW4Zanzbr2TyeHDxz3eO+/GlKuknJjthRd92twisEAqeZ4kjkLvZYbFWSu
ezhhZgJEMhFtJnEW/Q4DHusektb0WJ25lcn4EImC75OkQiF/4vKQSQ3YoyP6oZaO
ebhKLtCvx0ojnyJVWwSpb6SEwPxn6LuIw7qaP7cLO3A7f+B0ImN6ZmOGIJJdoqDC
8vCcBOG2MgzSAxBS+82KK4OgE0p+DNIhuVLHLe6llZeaRXml9NWkXBXP4mj6JeOd
ZxEkSoRFRg8xnySf2udTQS1ioHpUiPFq3EypqjOEdK04OSHfLVTOCjW2Y3FxCOv5
5VpbEkV3mG7G5Z3UIZB80MWHONUlX38qTXbXrIJmHUtE3C81fOEt/hNU/wqSnaTS
S2wLVVEFD+vHe5UpxLt5vbYYFW//7PJjgUD4bBWQ3OHtRsFe+SU=
=6U3W
-----END PGP SIGNATURE-----

--HVWVC26pKUfWEVO+--
