Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B31C43217
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 06:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiKKGue (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 01:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiKKGuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 01:50:25 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4CC7830F
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 22:50:19 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 738493200937;
        Fri, 11 Nov 2022 01:50:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 11 Nov 2022 01:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668149418; x=1668235818; bh=PvB38zTEMO
        H/6CBIhegdDch3qeD4WkVZF1MV4VZh0Q8=; b=Vz3kHiWcFgDA1YJT2QRQt2tdEE
        yTK2knUAUFEyKnrUKkWkPGkXRyoUeVMyuPR6otytwOWW0+Vj3xbu0ZVy8gzmq1ub
        rA9UpfA0z2HMirTvVGa9MfM4WAkmwRdpWyGlO01pvd1Pk1a2x9u3LhX7yj/dqUhF
        s0PeUzKPTFzmnJ0vypnYc+nVySCcp0a9i1SWMrIKuXILdT5+hnAxQp+1tEvzb3rX
        O9uAsWTSjeQjCUc8Erz8lpm8qgDdobtDOASEEpx2dFRbHuOKBPaUsbhS/Y7P8/Hn
        +TKPewX1A/WJpbd34MCG2V3DjNY3vre1NSsCZYH48GDpk8yWGBxpkJvRqkFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668149418; x=1668235818; bh=PvB38zTEMOH/6CBIhegdDch3qeD4
        WkVZF1MV4VZh0Q8=; b=o+rgEL1ztIlPw/OeqLo8Rhg/9HmxxeThxoo1HdIKK9yl
        lVIl0sjRA7hrKQbVuerJ/zN/j3IhqpJ2ddDztjbqY4yugRDfTA63Gy4CewPxvNec
        cTpPIzLG0epifO7bkhd2GA6l8gS8b3eJzzRGX4bTXGUAzmNonTdPQTrkh0axToIB
        Qr6m71TMruCc/6x8k7HA5HGKE7q0o4neyGwUVmQSxyLc8GK2gJvKFaVHxyCJaTrL
        GsGmS99NXGG2NK/bACQFQeJRaAbmp0uw3MjH5Tfp5EcyA66GfZNrV+/mFecKpXWA
        pc7nvqAAxw4H83aLAYd1QFheLrM2AywwKv5g7AkDxA==
X-ME-Sender: <xms:qfBtY7QK-xMfdlqlkc19AJduGa8xghatnuethNme0m7Tw0pklBPLgw>
    <xme:qfBtY8xiZ0v1OBvQ_jbmA5B-WzlZWjw5isDZNwCpm5jJhxixapIbU3yEFxBPYK5F6
    Z5VAJw53yk8XLTUfg>
X-ME-Received: <xmr:qfBtYw2xOPFds6PEgbvNB3tnRUHvW_P0AetdtihmqjHJ_HuJpuBh6HqFYGd9tV42QXmR778YUC2NAOUGfRQ48wHtm0trGyMforOFC8sje7eBUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeehgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:qfBtY7B8FGfnNb9f-Obi2PQ3V4WMXTswCueeZ4tpSJC6rnpXYhlXoA>
    <xmx:qfBtY0j7QhpCEUlx9CLetpe3FohuWya4FGsISGCh4CdTTawj1EMlIw>
    <xmx:qfBtY_pJjvMXpi0hTu9ShrUcyygxhngXbWx-1s-fvd89rVDKfcxGHg>
    <xmx:qvBtY9s0FKILCLY8hnOqR_S40PUWBdLwoW6R3PJeDT6RkXnRodGlEw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 01:50:16 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 3f2958ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Nov 2022 06:50:14 +0000 (UTC)
Date:   Fri, 11 Nov 2022 07:50:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 6/7] rev-parse: add `--exclude-hidden=` option
Message-ID: <2eeb25eef0cdf6c5f9f01058326d8b0a9992c461.1668149149.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxfLr16n+bsd6/Ub"
Content-Disposition: inline
In-Reply-To: <cover.1668149149.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wxfLr16n+bsd6/Ub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a new `--exclude-hidden=3D` option that is similar to the one we just
added to git-rev-list(1). Given a seciton name `uploadpack` or `receive`
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


--wxfLr16n+bsd6/Ub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNt8KYACgkQVbJhu7ck
PpSQLhAAriEa16ErpNYqIwbvWUwgj8AV1QlpOU3aHopXgAyyGMTHLA8D0/fa2sCT
ozw84QMjoGTFbweA3Y3pDXEjm5ieB0P4PU7l8fQphcJvxVuKYUGIja4DHQt3XCFB
c7D1w+V1LIOlGrTskzw2K061kY2i5szycpbj8tj9ySEWH7q1963dLlYwfc89YaFF
bPiCAEqYmalUr3AKng8Rx0hexRdhNvJwWrskwBJfz8yUki1a39vZiQNvYm6H+avX
wNaYPFO04UimD3ilfsTcf0eYr96W7Kwm4JcnmCXfe84lf7ZKawFL6sGPjTsRgj10
6tMgX013xKbT8qh3i2pPkDvFIc3eAml1kdV8Eyy6iRcRGpXM9uGsOgOiEq3R6/vd
fJmDm6LKK/VNd4dRFVOhR9tF/2JrrjBVobjCYPmhUWzF9OSDNjJdojEmV1rAuA6p
27wwUcjChRvvGQF8oDjXNw/Zgn7DCGw2YzVNFnXvBN9vJ3IqB1SzX6fPO4ipf5BD
01+Xh7QG0iRGn+zo02l79XhYQHIBUEvMp2g75h6jMpK8vV+BE84lvr7fhU/XX5eT
wg+eoyMlvAjpOSanABJCJ+AxnKJuUoCqr1RigPXXprcXszt+dq/kRTrYrI3/0FPa
Y7Dp0rHadRoFlexWAfMa65gYNyrJQ0/BAeBWMJTewkqbZYpnzVI=
=UYCz
-----END PGP SIGNATURE-----

--wxfLr16n+bsd6/Ub--
