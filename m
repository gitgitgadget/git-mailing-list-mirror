Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D0C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 06:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4BB610FB
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 06:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhGTFv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 01:51:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56263 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242070AbhGTFvv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Jul 2021 01:51:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 06F115C0101;
        Tue, 20 Jul 2021 02:32:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Jul 2021 02:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=VC6n4DDgg07nJiU+YOqijBbpjxh
        AgAF4/dz25xrO8xE=; b=oat7RJrDG2YL3maVAGe53E2w8XPmdFpxq0+WaW2zKjU
        Tm42gBlLyOOCW2kj8GUV0zrNk9E4JWJ6S+GVaExvuK45wbnSuHYznTvaCNUEafQI
        yUV1Ev2hXueDfAwnKyZVG9WVSTOtK90BxbrJqSoBJDqmC/Y06FoafTU/07Ho/hTw
        aJdq/2k7zezVu25gM4B6FjsHcC04OP1HrgPF+fLwap9AlQot+3cDTsgrSWySa2ho
        pAuDA2cyhNM0/j0Nwj4Gv0oPrciXZJLUiZoFdBKvT0mP5Ct9rGNebtlF7k9LfhcL
        RHIz9UkAZ6uUI7h1p/278HRalzrWNKhKyNo9W5sl3hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=VC6n4D
        Dgg07nJiU+YOqijBbpjxhAgAF4/dz25xrO8xE=; b=e7hxuqbgFnY4FZQ8LgbSlY
        ikZQx/P8579ha4FidFKdjrXu88kFYtdI9WMFqzH0BDwZJgfdhTODVUhkyRkapzED
        gJZt2zDRgJ6EuPxPWaGbC6hl1vO3UOAXsvF09FENBzlt5nk8XQLhy8d6urzbXf5+
        9LAoOW7GvocStinj7sikxzoIInqZjTFAgCWnV1mSassAobwhSVAp+/zJKt8hYANt
        t1jrs3wiofpUjpNwSbjmZIjg0dm8utFqmrwGSgEb9kpPwMqXnm7aO9EYoSXFWuXy
        /T31SZAMhscEKMroGfWlBb5Q5vrOzWFyP9ap6LjXjzausDsgHHrGAuRsbHc4t1eg
        ==
X-ME-Sender: <xms:_W32YM1O2praQBK50SpVdoZA8MJ72qh74bS7l7HYWhBbpcdO_9c8hw>
    <xme:_W32YHHXscQK80h9x15-PACizykDRwzy1AL32qqWWeQIhIjb9qw6uySxFmYEX4HAb
    XQDGMSlNDPppTtyMg>
X-ME-Received: <xmr:_W32YE6Z1BgjdtPiUEpD1SbROpZmfgb-8ph2r7zlr3c2WBv-w3fUCHdJPsSiT9TBQMx27IpALLv_sYXsHI0ocU_qSu7_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedugddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefggffgfeeigefhuedtgeefjeffkefghedvfedtfeelkeeileevkeeguefgkeffieen
    ucffohhmrghinhepmhgrkhdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_W32YF3GDNEkgIojNiCoTf_O7jOznrpwWd2-PGu9AF2HDTple_Abnw>
    <xmx:_W32YPHHpzwAjuZxr3BO7LXn-9BhwhgKCCQ8fGpTCzNY4798WJ_RQQ>
    <xmx:_W32YO9DJWKxAtu4rANmjB2IbOU-yS7a-FKZ_PZLEQPEqxIe26PQaw>
    <xmx:_m32YESCb1hTYsypowdpfk169b-poAX-B1qb2VJBpdsel02ROIbD2w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 02:32:28 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a3563063 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 20 Jul 2021 06:32:28 +0000 (UTC)
Date:   Tue, 20 Jul 2021 08:32:26 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] t0000: fix test if run with TEST_OUTPUT_DIRECTORY
Message-ID: <44006e7b0bdda50dc51153cc2efb6ae954d4eecb.1626762728.git.ps@pks.im>
References: <60f5d923848d3_145c71208cc@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cx5feGvLsbDIlbMg"
Content-Disposition: inline
In-Reply-To: <60f5d923848d3_145c71208cc@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cx5feGvLsbDIlbMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Testcases in t0000 are quite special given that they many of them run
nested testcases to verify that testing functionality itself works as
expected. These nested testcases are realized by writing a new ad-hoc
test script which again sources test-lib.sh, where the new script is
created in a nested subdirectory located beneath the current trash
directory. We then execute the new test script with the nested
subdirectory as current working directory and explicitly re-export
TEST_OUTPUT_DIRECTORY to point to that directory.

While this works as expected in the general case, it falls apart when
the developer has TEST_OUTPUT_DIRECTORY explicitly defined either via
the environment or via config.mak. In that case, test-lib.sh will
clobber the value that we've just carefully set up to instead contain
what the developer has defined. As a result, the TEST_OUTPUT_DIRECTORY
continues to point at the root output directory, not at the nested one.

This issue causes breakage in the 'test_atexit is run' test case: the
nested test case writes files into "../../", which is assumed to be the
parent's trash directory. But because TEST_OUTPUT_DIRECTORY already
points to to the root output directory, we instead end up writing those
files outside of the output directory. The parent test case will then
try to check whether those files still exist in its own trash directory,
which thus must fail now.

Fix the issue by adding a new TEST_OUTPUT_DIRECTORY_OVERRIDE variable.
If set, then we'll always override the TEST_OUTPUT_DIRECTORY with its
value after sourcing GIT-BUILD-OPTIONS.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0000-basic.sh | 7 +++++--
 t/test-lib.sh    | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2c6e34b947..09d2202748 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -89,8 +89,11 @@ _run_sub_test_lib_test_common () {
 		EOF
 		cat >>"$name.sh" &&
 		export TEST_DIRECTORY &&
-		TEST_OUTPUT_DIRECTORY=3D$(pwd) &&
-		export TEST_OUTPUT_DIRECTORY &&
+		# The child test re-sources GIT-BUILD-OPTIONS and may thus
+		# override the test output directory. We thus pass it as an
+		# explicit override to the child.
+		TEST_OUTPUT_DIRECTORY_OVERRIDE=3D$(pwd) &&
+		export TEST_OUTPUT_DIRECTORY_OVERRIDE &&
 		sane_unset GIT_TEST_FAIL_PREREQS &&
 		if test -z "$neg"
 		then
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9e26860544..da13190970 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -57,6 +57,15 @@ fi
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 export PERL_PATH SHELL_PATH
=20
+# In t0000, we need to override test directories of nested testcases. In c=
ase
+# the developer has TEST_OUTPUT_DIRECTORY part of his build options, then =
we'd
+# reset this value to instead contain what the developer has specified. We=
 thus
+# have this knob to allow overriding the directory.
+if test -n "${TEST_OUTPUT_DIRECTORY_OVERRIDE}"
+then
+	TEST_OUTPUT_DIRECTORY=3D"${TEST_OUTPUT_DIRECTORY_OVERRIDE}"
+fi
+
 # Disallow the use of abbreviated options in the test suite by default
 if test -z "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS}"
 then
--=20
2.32.0


--cx5feGvLsbDIlbMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmD2bfoACgkQVbJhu7ck
PpSlfxAAlGMThKKqJvSXylExTUxyRAeJdvHdeCFUc2+78vnmqpCicIWhkUHzb1la
7umeVdFNWICTcY3dalfuCUDBs/BUBGAT3zTEoN6exofxvgovx4Ej4TPd1RC8b39p
Jf2V86sez1FE62Bc3o5qD6nzQPuF4sFggEy9Z3mbWhWWCGsjlpiLHHXvYIRcxTG4
GCfNZcKOyJIWtXSpWB/TRWtNfXJdPXGSgQr2ZlCT9QUDiEZiqkvYOqyLiUCc8weE
mr51fPXe1VbaWaw9s8cvsaeJSmbXw1JwDEvdM8tA82tA8Zqn+RxWjY0SEHh9UpLJ
UEV5V9C/tjfmsAGqkagSl9lfMvgp36p17FcrZ79/V34q30Y6ZzB6Cah30cUppIpL
XScCV04zUM7QFugcdVO/9h2tFrrXZu5F4jSKRjIxBozPBIFgCUQ84nynII0rfKbe
e0gz7u5dRcdyy3SiWcauDszaJaZAbjBIX4UAor4BdN1eIvkD+Z4lbIreOAM+yILB
Hw4jXtIYoaYH8k2PqqPb8c0itfjtvrxDj0NT9bITGJjspREb8AuI2+jEpK2tqw0o
Mavu3XL8qOpERDPLpm89lE8Gz48zH4EtHpm+l5HvpAdQgLC8Fe6TKmMyIIeyo2E4
NCpBx2qJ2MVgEjTeSXXoG5M1ldtV/RuT9oEAjK0OHoPzQOzEkFg=
=ARLu
-----END PGP SIGNATURE-----

--cx5feGvLsbDIlbMg--
