Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4423AC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E7260E09
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhFRNxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:53:49 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44869 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233873AbhFRNxs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Jun 2021 09:53:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 66D495C00D9;
        Fri, 18 Jun 2021 09:51:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 18 Jun 2021 09:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Qmv6Hq1KWC0YHS922s7cPsZASe5
        ZgEw++heg6yA2AhU=; b=SO5CHgykTtmnMpQUtx/GS+6xTae2P2jymM1IL9OpBcy
        NbIUGWrkIzI1f65jIxqIJGafZyqfgD7Vxm3uglLPWMRodrHMs8Qa6bW9D0MlCZCT
        rArVfrPVQ0VrfHqJVMv3GNE0jrsJDvU901UyMUkwyocYO77G6/oc9UR1M5/XkMlD
        EKBzF7jnjOJoMdwm+4ASku/E1O5eYAhXMrlNanVEFgQX0YHi9zYUFTeyFf/YqVTY
        4xI/DGSCcCyP/gBImX4U3mOdJUSMOloqbpaEI+WszBK3nKBOINEPrTKPUdsQUWzW
        iaR+kcLEhc9bBpcazAZxWwCq4gevKgSDOKU6jFtERDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Qmv6Hq
        1KWC0YHS922s7cPsZASe5ZgEw++heg6yA2AhU=; b=dQYyfM650244cYj2N8sSDu
        hyB/pP0ZrfwQJhLB5aPXA32mrmMgpua5JuTU38Oaonzl2q8pbL9jjXd0J6MEgFei
        N1zVuwzMbsnUHsOayEKmCSFbtSB9y2Jan0IxYWRt4E+uElJh9YNBU0w62DgwexAH
        eqHxeBdWe7KMPDQpbA/NTk+UwVkR/FpAqekitMyEDHqPDG2RMSYvA/zBArBun8xt
        zVppn+Y3EKPqrFc+aC5dbFL+R7xfk77LuwwvRIVPWgPdPxVDScqG0JBSLPRlDdw5
        7uwy/jDZcK4Yule+cTOLtV+dpMrps2uvxomaGdeoFngzOFPWc5JkALYaRDrKYgqQ
        ==
X-ME-Sender: <xms:66TMYLw0uAWgX2LKr4mOAX45HqSU6NnGBabF9rBlWubHek5Bcao3SA>
    <xme:66TMYDR4FdygVismoaSffEEohlK51ozoBePOpJEkjxE8Tu9LCWqA83k79g5cPNd9w
    f3I-lRQhTS7YwdR-w>
X-ME-Received: <xmr:66TMYFU-c95B2hxiWNtQMj4-qvjzBPKxZTZMXHZ5uskAl7C1TuMf7GBv9QzWD5GZLGxEJXNTxIXkEJf-ojoreaIpzuVu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeffedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:66TMYFhUUbIaJv7mSctfIu6kCrBExSH7WLsGhmj-eJlC7b_ubxi7bQ>
    <xmx:66TMYNC9y0v9Km87CVbr6mL76MGWuJVAiEv8kqhB2j1klf7aKaCDTA>
    <xmx:66TMYOJN7y6Q09rBZwkcBQy6OMGsmtHitWRFd9SnAT9TrryWWDfzSg>
    <xmx:66TMYArxJzYrhxxd-iUs6i9PwEz00sA1z0ieZNFYrZqN2QB1saCyfQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jun 2021 09:51:38 -0400 (EDT)
Received: from localhost (xps [10.192.0.12])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 80052cdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Jun 2021 13:51:36 +0000 (UTC)
Date:   Fri, 18 Jun 2021 15:56:08 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2] perf: fix when running with TEST_OUTPUT_DIRECTORY
Message-ID: <cb9d948646e8181e9c9c8dc35b37d48c692a92fb.1624024532.git.ps@pks.im>
References: <005cc9a695f7f9b17190293821369763e9bae662.1623834515.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3CFyI2zQo3ax11vp"
Content-Disposition: inline
In-Reply-To: <005cc9a695f7f9b17190293821369763e9bae662.1623834515.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3CFyI2zQo3ax11vp
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
Range-diff against v1:
1:  8f73bd5d38 ! 1:  cb9d948646 perf: fix when running with TEST_OUTPUT_DIR=
ECTORY
    @@ t/perf/aggregate.perl: sub usage {
          --subsection  <str>  * Use results from given subsection
     =20
     @@ t/perf/aggregate.perl: sub sane_backticks {
    - }
     =20
      my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
    --    $codespeed, $sortby, $subsection, $reponame);
    -+    $codespeed, $sortby, $subsection, $reponame, $resultsdir);
    +     $codespeed, $sortby, $subsection, $reponame);
    ++my $resultsdir =3D "test-results";
     =20
      Getopt::Long::Configure qw/ require_order /;
     =20
    @@ t/perf/aggregate.perl: sub sane_backticks {
      }
     =20
     -my $resultsdir =3D "test-results";
    -+if (not $resultsdir) {
    -+	$resultsdir =3D "test-results";
    -+}
    -=20
    +-
      if (! $subsection and
          exists $ENV{GIT_PERF_SUBSECTION} and
    +     $ENV{GIT_PERF_SUBSECTION} ne "") {
    =20
      ## t/perf/perf-lib.sh ##
     @@ t/perf/perf-lib.sh: export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD=
_DIR GIT_TEST_CMP
    @@ t/perf/perf-lib.sh: test_size () {
      test_at_end_hook_ () {
      	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
     -		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl $(basename "$0") )
    -+		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl --results-dir=3D"$T=
EST_RESULTS_DIR" $(basename "$0") )
    ++		(
    ++			cd "$TEST_DIRECTORY"/perf &&
    ++			./aggregate.perl --results-dir=3D"$TEST_RESULTS_DIR" $(basename "$=
0")
    ++		)
      	fi
      }
     =20
    @@ t/perf/run: get_var_from_env_or_config "GIT_PERF_SEND_TO_CODESPEED" =
"perf" "send
     -get_subsections "perf" >test-results/run_subsections.names
     +if test -n "$TEST_OUTPUT_DIRECTORY"
     +then
    -+    TEST_RESULTS_DIR=3D"$TEST_OUTPUT_DIRECTORY/test-results"
    ++	TEST_RESULTS_DIR=3D"$TEST_OUTPUT_DIRECTORY/test-results"
     +else
    -+    TEST_RESULTS_DIR=3Dtest-results
    ++	TEST_RESULTS_DIR=3Dtest-results
     +fi
     =20
     -if test $(wc -l <test-results/run_subsections.names) -eq 0

 t/perf/aggregate.perl |  5 +++--
 t/perf/perf-lib.sh    |  7 +++++--
 t/perf/run            | 25 ++++++++++++++++---------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 14e4cda287..82c0df4553 100755
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
@@ -91,11 +92,13 @@ sub sane_backticks {
=20
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
     $codespeed, $sortby, $subsection, $reponame);
+my $resultsdir =3D "test-results";
=20
 Getopt::Long::Configure qw/ require_order /;
=20
 my $rc =3D GetOptions("codespeed"     =3D> \$codespeed,
 		    "reponame=3Ds"    =3D> \$reponame,
+		    "results-dir=3Ds" =3D> \$resultsdir,
 		    "sort-by=3Ds"     =3D> \$sortby,
 		    "subsection=3Ds"  =3D> \$subsection);
 usage() unless $rc;
@@ -137,8 +140,6 @@ sub sane_backticks {
 	@tests =3D glob "p????-*.sh";
 }
=20
-my $resultsdir =3D "test-results";
-
 if (! $subsection and
     exists $ENV{GIT_PERF_SUBSECTION} and
     $ENV{GIT_PERF_SUBSECTION} ne "") {
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 601d9f67dd..f5ed092ee5 100644
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
@@ -253,7 +253,10 @@ test_size () {
 # and does it after running everything)
 test_at_end_hook_ () {
 	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
-		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl $(basename "$0") )
+		(
+			cd "$TEST_DIRECTORY"/perf &&
+			./aggregate.perl --results-dir=3D"$TEST_RESULTS_DIR" $(basename "$0")
+		)
 	fi
 }
=20
diff --git a/t/perf/run b/t/perf/run
index c7b86104e1..d19dec258a 100755
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
+	TEST_RESULTS_DIR=3D"$TEST_OUTPUT_DIRECTORY/test-results"
+else
+	TEST_RESULTS_DIR=3Dtest-results
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


--3CFyI2zQo3ax11vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDMpfcACgkQVbJhu7ck
PpRKfg//b4ZW7KfWOUmKfP1sYId74C8JNe5hjt5yUNHNOs0mn3Fa7hP8D36V0C9m
bI9zA+E6AaBsRwv7l45jSSKIdX8jJy0zdNyWKmxItFhZ0zK/b/vyYF6SJvJXYzal
5HntY3wYn7jsi7ckiJaPR55ukm+jT4oeOH5E+lSbGJCE0WhrtIQsq6Dh/wuSgKz5
c2tS7OxrXvLCNOYvjI8IJR5peU7PVViHJIIoF9JzhhHxAXrRoou+6y/BLUTl4iTv
6+CdDxo9YuRMCyB0072Ehgk5xExdacrUo48ls3odDDYjZ+QE58jK0JvHg73WfIao
tcpj1viLc9EAhbK2TF3XHVd/j2zTPV7yF5Ye4pb48skEbzv0F5sOlDRMrApa/bV1
GFzUlt788m8pfHqbbzRrHA1J6eoyImHW7rnZ89p0OfbFZg48g5PUGHoFMrdKn1GT
12kkDFiywqOz8qc8k1fzDGkRzTYtnASFiLQc5njSgn3KQAo9ZsbZxWDY8bDUZ+bZ
k6LpcQoCTvyX2n20MkEVLSmGh/Z1rOqdg6w5xdJEN3JZ0gLZ3aAM8ZzHzcycWjZM
3GfLf/NZ4/FmMgEe+44riGoWoU2F22pMMj5QsJz7gGzsjn6lSrFESSoJhdpVAsv0
FzKjmec50z6MDN7W/jx6IgLwz6V6l7ai30UYpNehgIs7c/XhmjQ=
=8pti
-----END PGP SIGNATURE-----

--3CFyI2zQo3ax11vp--
