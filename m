Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE921FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 15:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426862AbdD2PfC (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 11:35:02 -0400
Received: from mout.web.de ([217.72.192.78]:51581 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166930AbdD2PfA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 11:35:00 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJl1M-1d3OT623T2-0017ew; Sat, 29
 Apr 2017 17:34:56 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC 1/1] t0027: Some tests are not expensive
Date:   Sat, 29 Apr 2017 17:34:54 +0200
Message-Id: <20170429153454.16879-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:LxWE8kSVb9ZLNfZhMHt3WRTl/ys51eXeEUveZqPGtJ1dFXeJBlK
 qTEvHZorfbZCy6uKnlyDwuhzyor06TJ/qxzxqXZvsyHjYSa0etlqCXUOqZFJPdq4JyqM5RM
 t9Hb3udqBQAjLgh4A3tfvmHD25Bq/+CBBaJMaj1ABsqQy74O4S+HkMTEr1CdeDarj1Dbp1o
 tEfUqbZOgHWSHL4TnwBNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SetREpbAeSE=:hIujS9gQueV0OPZKw3+DkI
 VNngVKvXAAU9nm5rugav5KLVxEVuDdgpmklQZx/XeIJV4pHFO8Yo5OpdWrcYkujxBemgFk8gp
 GYHkmbgb3XYVb/K+vnIkG1IzAVm+3y6s68lTuMD07jAyqdVSfE83bvOV9/yiVcLfMDuQVhMiw
 1MfKJ1qvZ6LpZxsusrJmFzl03Z1Hv1QFjFWybxqwWAedBrYJRpspK6lbzQo3WWjbqnbWDhrM0
 mTEUjeE4mpjRR36BH4JT1ja1r1R+vUYzfANfpTdawrPHsbNEzmRB/793STxanRMmarlYVyiqT
 pDa+ib3FT5ZARAIH+zJ8ZEcVfUrd44EsYSdIEjmbQ1Y3nNMxN6sRQ4X+cu3mxBIg12FZhr7s2
 ZbhTVP/9+Vz3pXqFbmcL4dAbDPPn6tIF8tu7xmD+CQ6HHkxTdEXqRBokGaee5PTMj42w9E9v+
 Y/8geWnQp4EPQo2Zqf3SHB/S3r9HW6Raj7YeaeTLHzXSeq5VEznNo5ZFBmCn0ELZ6rdOgmXBe
 2Y83ajDSkypNaANtuuRXh1cj6rW64kM3t9Ii+6rtOmA5+6SBxqZ3sQRWXX5sIJt4mcCeaRoTU
 2gPxbffhDsVUVScrAbEnQeI6shEwPdhE6BRYMgFMXz0bugo0hvfPHa4oes+l/N4zOOXlWZDg7
 omD2bzyyRGtH5oI/QTH06EF4BFnyW6cJ1RN+b3Xr+pNfA+39GpIVvIKXsGQ7VFpI+E9cbIZBp
 C9rUEpct2RR0J4ZgWgIbsKoP6mskaVTGX2+rM/am97exScVofBH2w5d6upgHfeJcblDOIwjWG
 6tZXc3H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

The purpose of t0027 is to test all CRLF related conversions at
"git checkout" and "git add".

Running t0027 under Git for Windows takes 3-4 minutes, so the whole script
had been marked as "EXPENSIVE".

The source code for "Git for Windows" overrides this since 2014:
"t0027 is marked expensive, but really, for MinGW we want to run these
tests always."

Recent "stress" tests show that t0025 if flaky, reported by Lars Schneider,
larsxschneider@gmail.com

All tests from t0025 are covered in t0027 as well, so that t0025 can be
retired later.

Split the tests in t0027 into 2 groups: expensive and not expensive.
Expensive are all tests which check the CRLF conversion warnings and
all tests which activate the Git internal "ident" filter.

All other test are now run under all platforms, which allows to remove
the flaky t0025 in the next commit.

The execution time for the non-expansive part is 6..8 seconds under Linux,
and 32 seconds under Mac Os X.

Running the "expensive" version roughly doubles the time.

And in case you ask, things are not going significantly faster using a SSD
instead of a spinning disk.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
PS: The removal of t0025 is not included (yet)
---
 t/t0027-auto-crlf.sh | 100 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 41 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 90db54c..2c5aff6 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -4,10 +4,12 @@ test_description='CRLF conversion all combinations'
 
 . ./test-lib.sh
 
-if ! test_have_prereq EXPENSIVE
+if ! test_have_prereq EXPENSIVE && ! test_have_prereq MINGW
 then
-	skip_all="EXPENSIVE not set"
-	test_done
+	say "# EXPENSIVE or MINGW not set, skipping ident and warning tests"
+else
+	EXPENSIVE0027=t
+	export EXPENSIVE0027
 fi
 
 compare_files () {
@@ -95,11 +97,14 @@ commit_check_warn () {
 		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
 	done &&
 	git commit -m "core.autocrlf $crlf" &&
-	check_warning "$lfname" ${pfx}_LF.err &&
-	check_warning "$crlfname" ${pfx}_CRLF.err &&
-	check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err &&
-	check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err &&
-	check_warning "$crlfnul" ${pfx}_CRLF_nul.err
+	if test "$EXPENSIVE0027" = t
+	then
+		check_warning "$lfname" ${pfx}_LF.err &&
+		check_warning "$crlfname" ${pfx}_CRLF.err &&
+		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err &&
+		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err &&
+		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
+	fi
 }
 
 commit_chk_wrnNNO () {
@@ -122,24 +127,27 @@ commit_chk_wrnNNO () {
 		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
 	done
 
-	test_expect_success "commit NNO files crlf=$crlf attr=$attr LF" '
-		check_warning "$lfwarn" ${pfx}_LF.err
-	'
-	test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf CRLF" '
-		check_warning "$crlfwarn" ${pfx}_CRLF.err
-	'
-
-	test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf CRLF_mix_LF" '
-		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
-	'
-
-	test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf LF_mix_cr" '
-		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
-	'
-
-	test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf CRLF_nul" '
-		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
-	'
+	if test "$EXPENSIVE0027" = t
+	then
+		test_expect_success "commit NNO files crlf=$crlf attr=$attr LF" '
+			check_warning "$lfwarn" ${pfx}_LF.err
+		'
+		test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf CRLF" '
+			check_warning "$crlfwarn" ${pfx}_CRLF.err
+		'
+
+		test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf CRLF_mix_LF" '
+			check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
+		'
+
+		test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf LF_mix_cr" '
+			check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
+		'
+
+		test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf CRLF_nul" '
+			check_warning "$crlfnul" ${pfx}_CRLF_nul.err
+		'
+	fi
 }
 
 stats_ascii () {
@@ -250,21 +258,24 @@ checkout_files () {
 		fi
 	done
 
-	test_expect_success "ls-files --eol attr=$attr $ident aeol=$aeol core.autocrlf=$crlf core.eol=$ceol" '
-		test_when_finished "rm expect actual" &&
-		sort <<-EOF >expect &&
-		i/crlf w/$(stats_ascii $crlfname) attr/$(attr_ascii $attr $aeol) crlf_false_attr__CRLF.txt
-		i/mixed w/$(stats_ascii $lfmixcrlf) attr/$(attr_ascii $attr $aeol) crlf_false_attr__CRLF_mix_LF.txt
-		i/lf w/$(stats_ascii $lfname) attr/$(attr_ascii $attr $aeol) crlf_false_attr__LF.txt
-		i/-text w/$(stats_ascii $lfmixcr) attr/$(attr_ascii $attr $aeol) crlf_false_attr__LF_mix_CR.txt
-		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crlf_false_attr__CRLF_nul.txt
-		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crlf_false_attr__LF_nul.txt
-		EOF
-		git ls-files --eol crlf_false_attr__* |
-		sed -e "s/	/ /g" -e "s/  */ /g" |
-		sort >actual &&
-		test_cmp expect actual
-	'
+	if test "$EXPENSIVE0027" = t
+	then
+		test_expect_success "ls-files --eol attr=$attr $ident aeol=$aeol core.autocrlf=$crlf core.eol=$ceol" '
+			test_when_finished "rm expect actual" &&
+			sort <<-EOF >expect &&
+			i/crlf w/$(stats_ascii $crlfname) attr/$(attr_ascii $attr $aeol) crlf_false_attr__CRLF.txt
+			i/mixed w/$(stats_ascii $lfmixcrlf) attr/$(attr_ascii $attr $aeol) crlf_false_attr__CRLF_mix_LF.txt
+			i/lf w/$(stats_ascii $lfname) attr/$(attr_ascii $attr $aeol) crlf_false_attr__LF.txt
+			i/-text w/$(stats_ascii $lfmixcr) attr/$(attr_ascii $attr $aeol) crlf_false_attr__LF_mix_CR.txt
+			i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crlf_false_attr__CRLF_nul.txt
+			i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crlf_false_attr__LF_nul.txt
+			EOF
+			git ls-files --eol crlf_false_attr__* |
+			sed -e "s/	/ /g" -e "s/  */ /g" |
+			sort >actual &&
+			test_cmp expect actual
+		'
+		fi
 	test_expect_success "checkout attr=$attr $ident aeol=$aeol core.autocrlf=$crlf core.eol=$ceol file=LF" "
 		compare_ws_file $pfx $lfname    crlf_false_attr__LF.txt
 	"
@@ -494,6 +505,13 @@ export CRLF_MIX_LF_CR MIX NL
 # Same handling with and without ident
 for id in "" ident
 do
+	if ! test "$EXPENSIVE0027" = t
+	then
+		if test "$id" = ident
+		then
+			continue
+		fi
+	fi
 	for ceol in lf crlf native
 	do
 		for crlf in true false input
-- 
2.10.0

