Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D5AC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8512261355
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhESTOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:14:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55749 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231131AbhESTOq (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 15:14:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 35AA35C01A4
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 19 May 2021 15:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=WPwqV4cbdXpdl3f66TQVRtKa4kULWTJ9FHmjBq0R
        X2A=; b=ZwlQ18ci/7qyNPbLRpfNshWZ6U3D3rl9gTITjyOUJ+DQnZc0CiY0MJOB
        XBhua0NsWQO6po77k4IHTN2+4T35/7hv46XHBrEx7gj07OdV+iHySITKS3qbY5ta
        eCuzEfk30g0R4MCS8d3ZmD2xvjEJMIPUGjF2ULA1ZH/YF31h3Ex4Iv3gx0k28jFS
        Fuf0Vxg2cyESrNfCnPozUzpssg50qFO/VtYVLc6UY8sxsr3Hb1n+84mFjQL23KBY
        r1EnjtYIP7/KxoAD6uF+4795caTQBsoDTpWKLJVvF9BpqtcfynHCDlSezo/zAhdB
        6OfCx3CQqa6EGlIkVuwaTz4hs4kvQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WPwqV4
        cbdXpdl3f66TQVRtKa4kULWTJ9FHmjBq0RX2A=; b=JULA/QwVatryDpB4BOiOhG
        G430lzZIKR6RsQHqv1RwnKPE+FDOrj3kmAU/xOPDeJTgvQD+o9jzD5gceys4leCZ
        xTvRbflQ1+olVlPkn5gsN7iIHzYOyfjEcBNAkpRSmrCpgheUsPAoWTK40omHUeAs
        azksnbYSM45YXOmLaYQLRuylscCY6hs6cX5whu+EqXwvMEiw0ofh5pwP3egX6CXd
        w4qqRV4HJoyO0y0gxjJ5cZGpu+zX5fJR9irpUyW1UsNc7Q25oun1a1GkptoTWHHR
        5nnJE4wiAhoCltgMz4MW4bhcHMoKufPUaR6Y9Qfpi0GAMoru2N0TiJkiYYekSC4Q
        ==
X-ME-Sender: <xms:VmOlYE5A_ppfG6Bs_b66alnzZGtT8YUHJ7s6L_SEAPYgX02t_dkp1A>
    <xme:VmOlYF6R5Z_MoI3K96ekkXBfvwEJor6lKsdLdn-F7cP-NbNcVthiD_PCaXnPX0l_F
    Cwo_OeQKDGjya58uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdefjedrudehieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:VmOlYDexYdPZi9r0oGmJhkcL-ViMLcj35ClYGFV43B7mD-j7REgunQ>
    <xmx:VmOlYJJKZxslHiFtufpHDY0JOBqCyWk8IqTj8id3DJX7FNp_HDxFFQ>
    <xmx:VmOlYIKw1Q5nMjkbVT4AH5n6a8FONT3FybuJODqQwq10BONrVE4bFA>
    <xmx:VmOlYNUmTS5S8fcTRAUporXpBEq2gDF0eXFKZspuLlZ8ZPSAnWlIAw>
Received: from vm-mail.pks.im (x4db7259c.dyn.telefonica.de [77.183.37.156])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:25 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id eb83acad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 19 May 2021 19:13:23 +0000 (UTC)
Date:   Wed, 19 May 2021 21:13:22 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/8] perf: fix when running with TEST_OUTPUT_DIRECTORY
Message-ID: <5488f0f4888fbc46378e2777d7daba1ec627b6c6.1621451532.git.ps@pks.im>
References: <cover.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="feyBF3uU7J+OAIXi"
Content-Disposition: inline
In-Reply-To: <cover.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--feyBF3uU7J+OAIXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the TEST_OUTPUT_DIRECTORY is defined, then all test data will be
written in that directory instead of the default directory located in
"t/". While this works as expected for our normal tests, performance
tests fail to locate and aggregate performance data because they don't
know to handle TEST_OUTPUT_DIRECTORY correctly and always look at the
default location.

Fix the issue by adding a `--results-dir` parameter to "aggregate.perl"
which identifies the directory where results are and by making the "run"
script awake of the TEST_OUTPUT_DIRECTORY variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/aggregate.perl |  8 ++++++--
 t/perf/perf-lib.sh    |  4 ++--
 t/perf/run            | 25 ++++++++++++++++---------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 14e4cda287..5d4964c5c6 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -58,6 +58,7 @@ sub usage {
   Options:
     --codespeed          * Format output for Codespeed
     --reponame    <str>  * Send given reponame to codespeed
+    --results-dir <str>  * Directory where test results are located
     --sort-by     <str>  * Sort output (only "regression" criteria is supp=
orted)
     --subsection  <str>  * Use results from given subsection
=20
@@ -90,12 +91,13 @@ sub sane_backticks {
 }
=20
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
-    $codespeed, $sortby, $subsection, $reponame);
+    $codespeed, $sortby, $subsection, $reponame, $resultsdir);
=20
 Getopt::Long::Configure qw/ require_order /;
=20
 my $rc =3D GetOptions("codespeed"     =3D> \$codespeed,
 		    "reponame=3Ds"    =3D> \$reponame,
+		    "results-dir=3Ds" =3D> \$resultsdir,
 		    "sort-by=3Ds"     =3D> \$sortby,
 		    "subsection=3Ds"  =3D> \$subsection);
 usage() unless $rc;
@@ -137,7 +139,9 @@ sub sane_backticks {
 	@tests =3D glob "p????-*.sh";
 }
=20
-my $resultsdir =3D "test-results";
+if (not $resultsdir) {
+	$resultsdir =3D "test-results";
+}
=20
 if (! $subsection and
     exists $ENV{GIT_PERF_SUBSECTION} and
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 601d9f67dd..8ca6dd0297 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -45,7 +45,7 @@ export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_T=
EST_CMP
 MODERN_GIT=3D$GIT_BUILD_DIR/bin-wrappers/git
 export MODERN_GIT
=20
-perf_results_dir=3D$TEST_OUTPUT_DIRECTORY/test-results
+perf_results_dir=3D$TEST_RESULTS_DIR
 test -n "$GIT_PERF_SUBSECTION" && perf_results_dir=3D"$perf_results_dir/$G=
IT_PERF_SUBSECTION"
 mkdir -p "$perf_results_dir"
 rm -f "$perf_results_dir"/$(basename "$0" .sh).subtests
@@ -253,7 +253,7 @@ test_size () {
 # and does it after running everything)
 test_at_end_hook_ () {
 	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
-		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl $(basename "$0") )
+		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl --results-dir=3D"$TEST_R=
ESULTS_DIR" $(basename "$0") )
 	fi
 }
=20
diff --git a/t/perf/run b/t/perf/run
index c7b86104e1..03128d440a 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -188,10 +188,10 @@ run_subsection () {
=20
 	if test -z "$GIT_PERF_SEND_TO_CODESPEED"
 	then
-		./aggregate.perl $codespeed_opt "$@"
+		./aggregate.perl --results-dir=3D"$TEST_RESULTS_DIR" $codespeed_opt "$@"
 	else
-		json_res_file=3D"test-results/$GIT_PERF_SUBSECTION/aggregate.json"
-		./aggregate.perl --codespeed "$@" | tee "$json_res_file"
+		json_res_file=3D""$TEST_RESULTS_DIR"/$GIT_PERF_SUBSECTION/aggregate.json"
+		./aggregate.perl --results-dir=3D"$TEST_RESULTS_DIR" --codespeed "$@" | =
tee "$json_res_file"
 		send_data_url=3D"$GIT_PERF_SEND_TO_CODESPEED/result/add/json/"
 		curl -v --request POST --data-urlencode "json=3D$(cat "$json_res_file")"=
 "$send_data_url"
 	fi
@@ -203,10 +203,17 @@ get_var_from_env_or_config "GIT_PERF_SEND_TO_CODESPEE=
D" "perf" "sendToCodespeed"
 cd "$(dirname $0)"
 . ../../GIT-BUILD-OPTIONS
=20
-mkdir -p test-results
-get_subsections "perf" >test-results/run_subsections.names
+if test -n "$TEST_OUTPUT_DIRECTORY"
+then
+    TEST_RESULTS_DIR=3D"$TEST_OUTPUT_DIRECTORY/test-results"
+else
+    TEST_RESULTS_DIR=3Dtest-results
+fi
=20
-if test $(wc -l <test-results/run_subsections.names) -eq 0
+mkdir -p "$TEST_RESULTS_DIR"
+get_subsections "perf" >"$TEST_RESULTS_DIR"/run_subsections.names
+
+if test $(wc -l <"$TEST_RESULTS_DIR"/run_subsections.names) -eq 0
 then
 	if test -n "$GIT_PERF_SUBSECTION"
 	then
@@ -222,10 +229,10 @@ then
 	)
 elif test -n "$GIT_PERF_SUBSECTION"
 then
-	egrep "^$GIT_PERF_SUBSECTION\$" test-results/run_subsections.names >/dev/=
null ||
+	egrep "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names=
 >/dev/null ||
 		die "subsection '$GIT_PERF_SUBSECTION' not found in '$GIT_PERF_CONFIG_FI=
LE'"
=20
-	egrep "^$GIT_PERF_SUBSECTION\$" test-results/run_subsections.names | whil=
e read -r subsec
+	egrep "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names=
 | while read -r subsec
 	do
 		(
 			GIT_PERF_SUBSECTION=3D"$subsec"
@@ -243,5 +250,5 @@ else
 			echo "=3D=3D=3D=3D=3D=3D=3D=3D Run for subsection '$GIT_PERF_SUBSECTION=
' =3D=3D=3D=3D=3D=3D=3D=3D"
 			run_subsection "$@"
 		)
-	done <test-results/run_subsections.names
+	done <"$TEST_RESULTS_DIR"/run_subsections.names
 fi
--=20
2.31.1


--feyBF3uU7J+OAIXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmClY1EACgkQVbJhu7ck
PpSkVhAAq/mGg97rH4aARlFKxRlbtzh3h11aOpyXz0uAOYP0JTbu/qOJbmSR7iYD
L2qfSQ/P1x1oyRcJjiP5uQLOU7VuFp6JAn9+lQ60za84qg1mcYjF1Bqg/zzEigS0
E2BCjklqbFXlnD3Z8mF8tuhCHO4bNj8y24B8jF7nsHnKDN5bE7dnO0Bpy7zdYpg7
xrFBBRADA+Umi8OOIVqWLRQrIkoHekkG+cEITYUbIxWnY5+BKiV4i4M5A024Q2Dl
wpRNALwJ9R+tBViaI4I88VKN7eFZtcnFPFvxR6Q3AEB9z4YXFuOHwmuPo4KtZcc4
3YWc9NHRnRdZXFs5WCOX3fDyydgzd0ZMpsfClL+oo7sB29ilmP4mN4BmMjFKX//t
RpLrvdbYw5bSMG14BISluRTWJGGb8jCdJy+6CRMitxyKYfIU1OVByLVEo5adT+rS
czeoWD/pcdKGzqFSzOOfwEfVE4FmkUMhjtcfGr2ItmVmGnDI0BWKabZAjvT/aa4B
cLuVnGtEJMqbUVir5a1m0fQN7/40PJoYkU83IXyjqxMFoavAJW0QcXx9E7qbOFfl
GyJL2S3xEe/BkuMCprxYZQFb5ZssmHTVs9tPIaonKc4ZwtSRxfdtdg+ZfQD12266
QHSSPLSp4yQr8V9Nkz0rLG1+RQb1EOJR2CywEWR1PplRPnCARJI=
=V1kx
-----END PGP SIGNATURE-----

--feyBF3uU7J+OAIXi--
