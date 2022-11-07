Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34F2C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 12:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiKGMRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiKGMRW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 07:17:22 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DF6246
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 04:17:21 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7B1553200988;
        Mon,  7 Nov 2022 07:16:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 07 Nov 2022 07:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667823402; x=1667909802; bh=hPgQwZl+eQ
        5j32YpCfjyDbO7oMTK58Pf4ETDVlNoaZo=; b=Y8c2dXJ6igfqXabuvVKGILuCp2
        hZvyT99kDOTpBjG1B1iL00pdLeY+jNHGGDyDS8vi3ctevN0e5EuKEClvCMv4mNfx
        pcpBHfUIXc9y0dVAE2XRzkndCKrZzlk9xw2ztd50SQ9T+9WANSSYziL/KuY7Xucx
        k/37go1q0iXMQAkXMLLicwB8HCFxm8zSurI7q44ORfmmN41qHaRxKvdHxI+M489s
        dy189QBnUu1In1SyHFUMMEajSoOd4O9Ba0cu41F0zRQ/bDeTSZKERfPMEnwR28DV
        q33Pn+rvNwcBvYYowNtt4vbV+L8zTFkan6lcj+PcBDXt7nyCyxzjiBhDAdkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667823402; x=1667909802; bh=hPgQwZl+eQ5j32YpCfjyDbO7oMTK
        58Pf4ETDVlNoaZo=; b=KZrQ6fFofAGlKCbNj++2SikEgJ5R2VFuEj8/4i4ivthE
        55sau1Qzo9KSF8sYxaoQrUuRe4BSmnCSOJHYN1xvjP7xt3qfK+T5LwwppaYg2I9+
        ZCa9nDrtmxzLjRWjtPvPN7CR9J+MuHFTWJpPj7B6ZaCyydyXgCnkP4rwzQVWgjMp
        rTdFXTzTHjuaG5oGMziUVgUi9m3EoUDAQgKCOENjO5155CBKiLJoUpGJVWxjyL/e
        7Q0sQGiQ/oyluKBwdR7EPrux/NJ0Raiotz0VWK6jKv2ha3Fl8SrX5LmkheOw8dnl
        XTQyJ1k/a916w5+wAB61+SJ05am/z3YLtKN/yDl+HQ==
X-ME-Sender: <xms:KfdoY_UZQi5C_8pr1ZiQBtE2_aFlrr6oRs0d9BALmLWBoheUySFGgg>
    <xme:KfdoY3lHScFy3YS5rEhAvhTrIQfZyjtBCImwr7GJCP8Dm_HNYYiuoumBhThVTjLuY
    eqKJG4URlkL4vaWUA>
X-ME-Received: <xmr:KfdoY7Z8VuusQywKfBdbPguEMoaEjbcECa73Ui2R0CvrM-7q_iw7RwyeTBTh7RXbyrrP97qsTw3OzgRP30zj3o-Y0eowFqehzAqNsD5dirIB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:KvdoY6UJivjv7rsXovPUL59d3UT4NKyi3dx1tFc9O-h5CS6wmgmROQ>
    <xmx:KvdoY5kd0A02oUR2UQ764YfZExIw6-y3nROfDlcbu-XL3YHr1gvFaw>
    <xmx:KvdoY3esJlTSFnJ1rxkbtO1K-7HZgvxRXGVFQWCiQTYlhvHBcGuGQA>
    <xmx:KvdoY_iJ9ZkoaCrwzAkaGttOqr34Rr31-64hjrYwMTQCkAAUuD5pxQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 07:16:40 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 382f98ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Nov 2022 12:16:38 +0000 (UTC)
Date:   Mon, 7 Nov 2022 13:16:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 5/6] revparse: add `--exclude-hidden=` option
Message-ID: <68a5e563045f1b3e6db7304206d95ebebcacbe6f.1667823042.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dLCjBEDvgcqdibUz"
Content-Disposition: inline
In-Reply-To: <cover.1667823042.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dLCjBEDvgcqdibUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a new `--exclude-hidden=3D` option that is similar to the one we just
added to git-rev-list(1). Given a seciton name `transfer`, `uploadpack`
or `receive` as argument, it causes us to exclude all references that
would be hidden by the respective `$seciton.hideRefs` configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-rev-parse.txt | 7 +++++++
 builtin/rev-parse.c             | 4 ++++
 t/t6018-rev-list-glob.sh        | 8 ++++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.=
txt
index 6b8ca085aa..a016cb5abe 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -197,6 +197,13 @@ respectively, and they must begin with `refs/` when ap=
plied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
=20
+--exclude-hidden=3D[transfer|receive|uploadpack]::
+	Do not include refs that have been hidden via either one of
+	`transfer.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs` that
+	the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob` would
+	otherwise consider.  This option is cleared when seeing one of these
+	pseudo-refs.
+
 --disambiguate=3D<prefix>::
 	Show every object whose name begins with the given prefix.
 	The <prefix> must be at least 4 hexadecimal digits long to
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 7fa5b6991b..49730c7a23 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -895,6 +895,10 @@ int cmd_rev_parse(int argc, const char **argv, const c=
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
index e1abc5c2b3..f92616de12 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -187,6 +187,14 @@ test_expect_success 'rev-parse --exclude=3Dref with --=
remotes=3Dglob' '
 	compare rev-parse "--exclude=3Dupstream/x --remotes=3Dupstream/*" "upstre=
am/one upstream/two"
 '
=20
+test_expect_success 'rev-parse --exclude-hidden=3D with --all' '
+	compare "-c transfer.hideRefs=3Drefs/remotes/ rev-parse" "--exclude-hidde=
n=3Dtransfer --all" "--branches --tags"
+'
+
+test_expect_success 'rev-parse --exclude-hidden=3D with --all' '
+	compare "-c transfer.hideRefs=3Drefs/heads/subspace/ rev-parse" "--exclud=
e-hidden=3Dtransfer --all" "--exclude=3Drefs/heads/subspace/* --all"
+'
+
 test_expect_success 'rev-list --exclude=3Dglob with --branches=3Dglob' '
 	compare rev-list "--exclude=3Dsubspace-* --branches=3Dsub*" "subspace/one=
 subspace/two"
 '
--=20
2.38.1


--dLCjBEDvgcqdibUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNo9yYACgkQVbJhu7ck
PpS/mBAAk2L7xSTmswUccSFMLdplkyjLKrrmoUo79n0eW0ArCrQ4syxX3+8b8L5f
0V1I8b6bqLHHGTPSk90JFkSgYbu7sVyaur5cw8BSBaFcYQvnuEZM3OcM8dY+fWhB
iL7rhjHPLM+4gfW/Vr5gsTZ93VEW5iiAOgnCHl9EiVAFZUDoQHL40zt1QRzI/Qij
shOfBv5kcxVW6StDGTOId0fA5YP3qTDwZIiwBDjLoM/HBwxcm0CfIprFEJfVfK+b
Q2V0BAikLamWtIhGRw0sR7uhiPrd+lQoDYXnTD6J+SSzkmLmTkKQpQgQcunLjd65
DTPZfLQitAq6GXuk2LL/ERILRMwiXXoUxzN1Ln1kRVgxtd6yrFQ79LSbhbkzHGDr
uzvYN5BrqhBkmlUevz12z0polxcLAUy9NzsKgFEB3COV6J/FpIcAmDZSD9TftIt/
4BxCbjn0a7fDr1kLlIsSdSm12+bn6B/INDD5HM4HDKLni5VN7q8zoSEmmCauM61U
+RWSj68XAMBjwwxDvv1pi/XDnjBruDA124L70qdYYdwbkj/gkcFOrZB0pDuQ6MeO
9IopPNWmCE15AA5BVIL2REAfX0y2h/x+vNvJk1b9MzjIvuIX+x5vwHZIfsvvvvtA
L7MQV5W4zrPrhm6zo1W4WyTOY6IrhssKLFWgZS150McmcvMSU1Q=
=pmlb
-----END PGP SIGNATURE-----

--dLCjBEDvgcqdibUz--
