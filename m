Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB0120188
	for <e@80x24.org>; Wed, 10 May 2017 14:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbdEJOG2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 10:06:28 -0400
Received: from mout.web.de ([212.227.15.3]:52779 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdEJOG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 10:06:27 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEVQ1-1dEmz113DF-00Fmel; Wed, 10
 May 2017 16:06:22 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, larsxschneider@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/1] t0027: tests are not expensive; remove t0025
Date:   Wed, 10 May 2017 16:06:19 +0200
Message-Id: <20170510140619.22808-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:l4zFzpKslCzi4cLrGOW13prGcA+79b0LQm8d+4Tvhdgwg7A5RFF
 AdUppWpabo9bwMV438fbUvfq4N7ExyHMb4TUM51KhcH0Ka2YUFBxwk9g+dm1/iqvmGqQq4j
 faXkD7xntPRKOLTeTThMwsnx1zK/Qu4zkR9kdFr87WCg8OTXNlpt9sd0hD9MHClpy8rlN/U
 ZvMNaBjcmQEB+BcdQ5kTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fzEsVJmLcwg=:hpsRIsS+sprbIRGNJT2TzK
 rZPT0zIk3Ggv3m39XF5TFewV6pwXoBqTIUUigSzswpqrDMo0QGpH3GXH/SHTktJglt2mBeqef
 AvmXDgL6opOUGmVvj/Y8kDTid2sirb85BMGWUusW/yw7P9xPgeRIug0LkfmC+xjDktK1MIJI1
 XhVqCAicqLwHTCt+9+/ofI//q6YbdKEUomMq/zvgmcMchGmzmsTziNYASD2NdsJLfehaZyNCb
 R8Ln9R56ARk8ttYlRm9fIRH8rNor6rTJ7vPxF3HgGDKb+t/J+COGTLyUAFNr6W+SP9XJlljws
 OJ4xXSHnKfm8K2FFKRr/2sw+wIi1tKMxX6ZEL4y5klHq/ezGAHLbSFgPFFWNGLeES7f2N8WBt
 jt6xdU3qIHD2tnEE2iyoBStDrmRZoM63Txb7zk2afOd8h6akRNmD82yfKJ5JA1GWLRqiH42v0
 7SKf7R9B7Wx3NxqCgxZjXYRzDCWBoD7obHxXH8dc5VMSWvZ1mKYENLTI9fl/ARJcRSesvJXOX
 vgQ73RqpYlKmFkCVR+WezjH2gaDO1F11vS3udRI/ADrT/Q36fLO21fgULWPet74uVr+9/4fpw
 3AcAwN5f9PjF7sOtFGlJrzA1SvYX8SuQTwNt/EOD+2zF6zdLfZiRYSCNuCU5Yi+ADDVcfghH0
 rNvwOyodyaaIXr9s6NA69KaI9L0FpOeiyIxjSUKkSnVXlMKdoYu3mnKDEBreLxzwT3ez5FUPh
 n83sGSKYun0P4HwzU1CM51qlgfgG288sSR8YZx3Jl9/qzxgl6QT6GU4YC8VUxumzcWHk3tdOX
 qedwvVs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

The purpose of t0027 is to test all CRLF related conversions at "git checkout"
and "git add".

Running t0027 under Git for Windows takes 3-4 minutes, so the whole script had
been marked as "EXPENSIVE".

The source code for "Git for Windows" overrides this since 2014:
"t0027 is marked expensive, but really, for MinGW we want to run these
tests always."

Recent "stress" tests show that t0025 if flaky, reported by Lars Schneider,
larsxschneider@gmail.com

All tests in t0025 are covered by t0027 already, so that t0025 can be retired.
t0027 takes less than 14 seconds under Linux, and 63 seconds under Mac Os X,
and this is more or less the same with a SSD or a spinning disk.

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 t/t0025-crlf-auto.sh | 181 ---------------------------------------------------
 t/t0027-auto-crlf.sh |   6 --
 2 files changed, 187 deletions(-)
 delete mode 100755 t/t0025-crlf-auto.sh

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
deleted file mode 100755
index 89826c5..0000000
--- a/t/t0025-crlf-auto.sh
+++ /dev/null
@@ -1,181 +0,0 @@
-#!/bin/sh
-
-test_description='CRLF conversion'
-
-. ./test-lib.sh
-
-has_cr() {
-	tr '\015' Q <"$1" | grep Q >/dev/null
-}
-
-test_expect_success setup '
-
-	git config core.autocrlf false &&
-
-	for w in Hello world how are you; do echo $w; done >LFonly &&
-	for w in I am very very fine thank you; do echo ${w}Q; done | q_to_cr >CRLFonly &&
-	for w in Oh here is a QNUL byte how alarming; do echo ${w}; done | q_to_nul >LFwithNUL &&
-	git add . &&
-
-	git commit -m initial &&
-
-	LFonly=$(git rev-parse HEAD:LFonly) &&
-	CRLFonly=$(git rev-parse HEAD:CRLFonly) &&
-	LFwithNUL=$(git rev-parse HEAD:LFwithNUL) &&
-
-	echo happy.
-'
-
-test_expect_success 'default settings cause no changes' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git read-tree --reset -u HEAD &&
-
-	! has_cr LFonly &&
-	has_cr CRLFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	CRLFonlydiff=$(git diff CRLFonly) &&
-	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
-'
-
-test_expect_success 'crlf=true causes a CRLF file to be normalized' '
-
-	# Backwards compatibility check
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	echo "CRLFonly crlf" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	# Note, "normalized" means that git will normalize it if added
-	has_cr CRLFonly &&
-	CRLFonlydiff=$(git diff CRLFonly) &&
-	test -n "$CRLFonlydiff"
-'
-
-test_expect_success 'text=true causes a CRLF file to be normalized' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	echo "CRLFonly text" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	# Note, "normalized" means that git will normalize it if added
-	has_cr CRLFonly &&
-	CRLFonlydiff=$(git diff CRLFonly) &&
-	test -n "$CRLFonlydiff"
-'
-
-test_expect_success 'eol=crlf gives a normalized file CRLFs with autocrlf=false' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf false &&
-	echo "LFonly eol=crlf" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	has_cr LFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	test -z "$LFonlydiff"
-'
-
-test_expect_success 'eol=crlf gives a normalized file CRLFs with autocrlf=input' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf input &&
-	echo "LFonly eol=crlf" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	has_cr LFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	test -z "$LFonlydiff"
-'
-
-test_expect_success 'eol=lf gives a normalized file LFs with autocrlf=true' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf true &&
-	echo "LFonly eol=lf" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	! has_cr LFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	test -z "$LFonlydiff"
-'
-
-test_expect_success 'autocrlf=true does not normalize CRLF files' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf true &&
-	git read-tree --reset -u HEAD &&
-
-	has_cr LFonly &&
-	has_cr CRLFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	CRLFonlydiff=$(git diff CRLFonly) &&
-	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
-'
-
-test_expect_success 'text=auto, autocrlf=true does not normalize CRLF files' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf true &&
-	echo "* text=auto" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	has_cr LFonly &&
-	has_cr CRLFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	CRLFonlydiff=$(git diff CRLFonly) &&
-	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
-'
-
-test_expect_success 'text=auto, autocrlf=true does not normalize binary files' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf true &&
-	echo "* text=auto" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	! has_cr LFwithNUL &&
-	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFwithNULdiff"
-'
-
-test_expect_success 'eol=crlf _does_ normalize binary files' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	echo "LFwithNUL eol=crlf" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	has_cr LFwithNUL &&
-	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFwithNULdiff"
-'
-
-test_expect_success 'prepare unnormalized' '
-	> .gitattributes &&
-	git config core.autocrlf false &&
-	printf "LINEONE\nLINETWO\r\n"     >mixed &&
-	git add mixed .gitattributes &&
-	git commit -m "Add mixed" &&
-	git ls-files --eol | egrep "i/crlf" &&
-	git ls-files --eol | egrep "i/mixed"
-'
-
-test_expect_success 'normalize unnormalized' '
-	echo "* text=auto" >.gitattributes &&
-	rm .git/index &&
-	git add . &&
-	git commit -m "Introduce end-of-line normalization" &&
-	git ls-files --eol | tr "\\t" " " | sort >act &&
-cat >exp <<EOF &&
-i/-text w/-text attr/text=auto         LFwithNUL
-i/lf    w/crlf  attr/text=auto         CRLFonly
-i/lf    w/crlf  attr/text=auto         LFonly
-i/lf    w/lf    attr/text=auto         .gitattributes
-i/lf    w/mixed attr/text=auto         mixed
-EOF
-	test_cmp exp act
-'
-
-test_done
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 90db54c..effc3db 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -4,12 +4,6 @@ test_description='CRLF conversion all combinations'
 
 . ./test-lib.sh
 
-if ! test_have_prereq EXPENSIVE
-then
-	skip_all="EXPENSIVE not set"
-	test_done
-fi
-
 compare_files () {
 	tr '\015\000' QN <"$1" >"$1".expect &&
 	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
-- 
2.10.0

