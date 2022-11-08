Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A93C4321E
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 10:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiKHKE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiKHKEC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 05:04:02 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE57A8
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 02:04:02 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 919B05C01FC;
        Tue,  8 Nov 2022 05:04:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 08 Nov 2022 05:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667901841; x=1667988241; bh=cL8Bu8U7IB
        G0eSW2AzVBwq/WUhaJGIA0pr3e2EVZkdw=; b=bijzGknkUtwlXpM9NcCsU4JsKc
        MvYFzov++SaiGWQ7fYMrhkyUozzLLbUkA19Rx9LlFwczLzDgbiytylQhJdveri9S
        FzwndtekGSPsPm8DLSe9yEnouP0jXfKTVJCSe6wVWpfR8C3WeSDdn0AghBdFncVk
        +ME1PrVlJGQ4D07xdpWVcn6L/tGfU+GQ5nTAjDUKbNL8Q1Znq254HR1roF8cSI9I
        ZSLwv40UjovYC97JlpHS/KWxaRrmlFSdTyFmras6zH2wsY/lnlZeg42j7nALieYi
        5F6DV0FUpPxKxShaqwsf2OHkXZxyWsZEr+bdSECVBVvS76lXLJTQecqlcfCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667901841; x=1667988241; bh=cL8Bu8U7IBG0eSW2AzVBwq/WUhaJ
        GIA0pr3e2EVZkdw=; b=dM3ZqD4PvTqCTMW8eO1EVGvcm3mmFlutaw5/3oOETAsy
        5rwOGuU3vjOWa1hs8yTr4NALqKZsVmCLzCEr0KCgYVAX414In/2/Wl2yxAAKl6Hb
        ttle111uj1aJ7GkXNdO2HLGLIGniG6Rx1YNhhyPCatrK0LIv24AGnr8quC5UCZGD
        ouGDUpucsqAZOQb0CcTVOfL3Vbs4YrBQvDDxAQKDXClfxmSR6KC4zrXsWJ00R6yZ
        TjW2FOWfah6Hn6U6v7SVdpKXMxxjXEgcqkTKd9bkgJsnYuBqdIy6o9BXfkwyFZui
        6gEE5boOPPb4vTKnc6hLkZ0PnqgCyUJUsbt3pIHbfA==
X-ME-Sender: <xms:kSlqYy10wYtMZTtvd1JgPW7zh44owNSP3jAU9JbI3Xz7MScLOYdx9w>
    <xme:kSlqY1EBMbcTAKTyqNIL0lyPkPh7zZ90Gnbagy-hAD9Y3tTsWg0bSb0fbYmkJRf-Z
    gG_wWiBIij9p-tb2A>
X-ME-Received: <xmr:kSlqY66tGHM-88W4MZ80vaf4tgggGafsCtnffb4jZ7NgctIWXGE0NO3AXWxTCag9Bp19GmLZ5qS8S3VRCWp8osXWcuxSYQUmU-8D0r2U6ptD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:kSlqYz2z13LOpjFIKixGOEVTCXZ9u74L14Ulgc4wtziQ_t19RhoG5g>
    <xmx:kSlqY1HjXw8dYgkJKl2zesBAY2zAGLv4qFcDEGW-BeWjDFLYM6Y-Wg>
    <xmx:kSlqY88rof84H8mk0rgRjWqn8BKinxBPyASAwrSFWP57p3TrQXbWJg>
    <xmx:kSlqY1Ccj9nc0XSMHjzM0yoMyslL4RpCEc0CR7wpzmLP52fC7_bgew>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 05:04:00 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 6253fbed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 10:03:55 +0000 (UTC)
Date:   Tue, 8 Nov 2022 11:03:58 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 5/6] rev-parse: add `--exclude-hidden=` option
Message-ID: <79c5c64a803b67ccfecc57328e565a2fa9563507.1667901510.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3dmmna/EcgQke/gr"
Content-Disposition: inline
In-Reply-To: <cover.1667901510.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3dmmna/EcgQke/gr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a new `--exclude-hidden=3D` option that is similar to the one we just
added to git-rev-list(1). Given a seciton name `uploadpack` or `receive`
as argument, it causes us to exclude all references that would be hidden
by the respective `$section.hideRefs` configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-rev-parse.txt |  7 +++++++
 builtin/rev-parse.c             |  4 ++++
 t/t6018-rev-list-glob.sh        | 11 +++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.=
txt
index 6b8ca085aa..393aa6e982 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -197,6 +197,13 @@ respectively, and they must begin with `refs/` when ap=
plied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
=20
+--exclude-hidden=3D[receive|uploadpack]::
+	Do not include refs that have been hidden via either one of
+	`receive.hideRefs` or `uploadpack.hideRefs` (see linkgit:git-config[1])
+	that the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob`
+	would otherwise consider. This option is cleared when seeing one of
+	these pseudo-refs.
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
index e1abc5c2b3..af0c55cbe7 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -187,6 +187,17 @@ test_expect_success 'rev-parse --exclude=3Dref with --=
remotes=3Dglob' '
 	compare rev-parse "--exclude=3Dupstream/x --remotes=3Dupstream/*" "upstre=
am/one upstream/two"
 '
=20
+for section in receive uploadpack
+do
+	test_expect_success "rev-parse --exclude-hidden=3D$section with --all" '
+		compare "-c transfer.hideRefs=3Drefs/remotes/ rev-parse" "--exclude-hidd=
en=3D$section --all" "--branches --tags"
+	'
+
+	test_expect_success "rev-parse --exclude-hidden=3D$section with --all" '
+		compare "-c transfer.hideRefs=3Drefs/heads/subspace/ rev-parse" "--exclu=
de-hidden=3D$section --all" "--exclude=3Drefs/heads/subspace/* --all"
+	'
+done
+
 test_expect_success 'rev-list --exclude=3Dglob with --branches=3Dglob' '
 	compare rev-list "--exclude=3Dsubspace-* --branches=3Dsub*" "subspace/one=
 subspace/two"
 '
--=20
2.38.1


--3dmmna/EcgQke/gr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqKY0ACgkQVbJhu7ck
PpSBVBAAkbkDZYcMilXt6L7X/gjI6FSVWhRFGn2azW6lZ0j8SJdFS49aUq3CFvKO
09l7XbqWoCax2CVPzcAme1+8UvjBhgOj15UScOtW0sSySFShp/dX0GZslqzmOKRV
NzM/g7kNEfiseCmCuKccV/C+/XmmwJ1dhBup5tDsYG+PoCNQRBt15XWSx4xOCHP2
xhLzKKSZvyWRU70pe3VjPN1smrz63ODzJeJfsPpN22CulfvwalLhFWyeuRDffzLB
z8l6dCLEK1B2q58p4jtF2ErcRUUvUYjB2t2j00dMOLNZyUvHAh+WNdk51+vO4F4C
TYhI9rIbI3nqA7UXYwmtsBjxLd94nJiOm7MeEujJb2fepzpowFx7Gc1hi/RCDDWc
uZCyN/9fgo8UYY/UImbLwRmNKtAfBP9sItb9vWYrXrD7fxMBSxFjFP4VaMWUKrrS
WDUFvivkuGKSl90vg1Oaz24scpHkqAYLzzzS5+8GGJPVXsH0zBqk29OBqwU72Dmp
TUKPT5Nw50XR0Eg2W31bFmX/2g0MOXI2y1tVIUWGn+Y4FFts6oQN4uoNPsrzdpxx
XdDRJuvcATcuf70MAoLzno4hIEJ9+L0VtCsmIMZ9pUxMq4Dz+r+5vdLH7OohJcgn
PWMAP3jEAA3Vsf0ak7bcdGkLtrW5uBQ/XEenbzBRmNOfagudaO0=
=MthY
-----END PGP SIGNATURE-----

--3dmmna/EcgQke/gr--
