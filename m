Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C3EC48BE8
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 09:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1E961055
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 09:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhFPJMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 05:12:10 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47849 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231336AbhFPJMJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Jun 2021 05:12:09 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 37F3510ED
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 05:10:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 16 Jun 2021 05:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm1;
         bh=biI/dN0BwaxJ7McLo0nJ5SSH/yOrxExkcbp/ZWcfASI=; b=J28AxMBluKuQ
        HbfxojdM3H/xF5UzkP4b3Y4jCx2++GxjY0YWUIBAv7kltInwmqI+TEfntKuq7T0K
        R5DhQfPXPoQX5Tcg36DKRMEiDA0yflwI5haTSvZipr+1i+rTZtSs76V83HC3XOwH
        uhK7pH6srqkh6gUuY5Fg1Hfvny2pXoDKUbU8ZjDYEF7NuvTWB+UsDCJhqqM7hanm
        XJ8HPQ3okzvN/398jEIerza14VgSJPsU5v4UpgdwTRv4Mljjvgpb1KQJrsGdGbMQ
        P6g/x25akjTtK9uFuFYeQuDT22zJBwGvOzlSkL53to8WnM8GbJiN8MgZwjskwapl
        nC2aRrFxDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=biI/dN0BwaxJ7McLo0nJ5SSH/yOrx
        Exkcbp/ZWcfASI=; b=SHGVu26MCEDaTv4l6mNhV6Xo9/8YQ3bq05+85hXnttGrs
        QthYNnnddxnGiaYS9w9Rt0IZMkzy3Z7MD1INMQkEYOLUOa6x+bwIIDb+cfxzPWmY
        SFRLgZ0fDOt4Qnva2H2KFDWKX2vWNRvliNeXV7RJ4gAj8H+vpcw7Hk9/8lLwX6oE
        ntdCF0KWgt4NjxUWOHYa7DhdFFxJI1tXW1aQS0TeRc1l9mS2kg8QbDuDy/8eoEs5
        VQ1OWKqQpbhlIhmnYC/kNjFpniX5BfNVs4lSNbvPTE5EtK0taRreaWLRtdCWHLTe
        O4xog+MXP5ncdxtmQDoey609d9zGJrh5eFbVKpj2Q==
X-ME-Sender: <xms:6r_JYH0n-ZWDrJ0XzXxypxck0m3KZLmVyu-Jg5DyqezGuzCwSPKXmg>
    <xme:6r_JYGE6wsk-b6QWsmSKjViN7-bErsQpaZP5881z-DpXGDd8UutAWDnGMWMbAQVxm
    a4YGY8DAIN8VKbjkg>
X-ME-Received: <xmr:6r_JYH5Z8k7gw3fDFmofgBdWlp76roQDYa8uD4Lja77-pIAD4DZMbYS6KxFPPCPTzujncEwDXJRpqz0XpsoCTWfN7NDqgifY-St23zd4nxd5PeLfJ5d_D88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6r_JYM26omKu5qMcZX7TAArzBAuHIRJri5JzsbwFO6bxlMLlrmF1wA>
    <xmx:6r_JYKF7XWqwz8vTPFRKJ9b6paC7AY9oSCkYCdNHDEg2LC9GLyNMjg>
    <xmx:6r_JYN_lMl5E6UwiY80l2DVSbxUnNz3LBgMsTGTMXNpYTsR7_2uJOQ>
    <xmx:6r_JYFz4FMMJJaq_Y5C77JQc7FKMHVzRVho94MZHz0BSmL37TWUVBA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 16 Jun 2021 05:10:01 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 570d1359 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 16 Jun 2021 09:09:57 +0000 (UTC)
Date:   Wed, 16 Jun 2021 11:12:05 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] perf: fix when running with TEST_OUTPUT_DIRECTORY
Message-ID: <005cc9a695f7f9b17190293821369763e9bae662.1623834515.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0suJC432mWjKjELm"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0suJC432mWjKjELm
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
2.32.0


--0suJC432mWjKjELm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDJwGQACgkQVbJhu7ck
PpRwjw//UKNKv3sZLg+nRfcnCML9K8XFozgWk09tavdCPacFThlGLsJZbs/xiV62
dulOm60vSoLxv8fpmgUMgSHETaUJRlJJnjhy5mWzwpFUw6ON3sSiMfT42GYlQvN2
2aRzGIVyFit1NIaAyepHxD55oPTr5QAN9fV0As1Amud9WBhbF5bmnNoLLFr9NzIC
hXhiUtFrHwljw3+mEsv5wtkrXVCIzQh9E6gQc1G9e8Zp2KGO57BHIjnvF19+4UBo
8k/r7eKwVSQwm+bG7gE0ZXk/DhnYyeoPWobWVYS8yH8q61FtdpcPTdD1NNYcYvAi
HTj0GkwAlghTD88dmv6jBaMhnJsChLrSceIfMGhvw8NVgXepxri+jfWsLnTZ1pJT
WF+bB4B6MyLqAVRbZIEwlAtkq82bOTRqi+Ol13BMPyKs5fcZXc9VokOm6pMySKFl
DKQAYc6JBsaeuxRDVbO+Qeq55tDzBJcI8O1eByeuqQcjplYGzXl84ZLkzEHqcC4O
i0C4fYCxvhrAyQUTBjbw4n7axhrpYoYLzM9trDAo5Taau6RCVfbv9BP+PjORX8Fj
VEMe8xSWV4xEdbiBqEZ2w7/PEz6zZgNobwxGAO7d3txxtJBuEMZDIoI4nrLX6Hym
iUJHFmf3glUCSJmpAmpS1N7XgiuLfehXOipT+eFT1rUFSGWYZ/A=
=sFKp
-----END PGP SIGNATURE-----

--0suJC432mWjKjELm--
