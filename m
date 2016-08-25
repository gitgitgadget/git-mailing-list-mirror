Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1373C1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 12:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbcHYMF6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 08:05:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32835 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbcHYMF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 08:05:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so7131960wme.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+mk4deWAIrv1GVkuavCViKnJi3yYXJ/OvgXoExhYALQ=;
        b=XxrlC0KXeYER5FzqDFC8nr4Q1U70avpY7MVyZ8laXXIa6nCIDjgG5I4vUrwqf1mQhS
         NKc+5xu+0vow3nqI1jBota0QTGWKgH10AqfGlVGo0o3GCrU5l7PE1e4k2Me2MOY4FOTt
         Rc5vcdrjoqMSHG//uqpA4LSomRlCkk3QsOQgDqwYYzCO2jE04hxMA99TCTwRmTx6T4SB
         nrtk0JNQgLv4nlyTdrYA3EX+28IbjbHq2QkubH0sZnOY27TrzeD+CTWBVpyoYsi+JJux
         9B5tBm3vOv1M2lc6rbly8n1dFrfbTN8sJW1rAHBGwHBEAjtTCVsW1umzqfMG80p6FFgF
         MCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+mk4deWAIrv1GVkuavCViKnJi3yYXJ/OvgXoExhYALQ=;
        b=EytITYT8T37ICSG2dbJGFuT1zW65U+2J7Imu8jSCLQ8MBJKVid42AwI9xVTPnKQRP9
         TRqIlofbQG/bCv70LDUKFpymEf24Tq+EtL+OUyMhVp5l3RlC25mD1DcLoxSOJKq2xYat
         KcBFl7QB9WR2+Rf+Pf4dK6SBPnXQsQX85nxqG5nu7nXg9eeUcsCIWKuOUvWwuGXGQxOA
         vR6XsaScuAvC4XqxlIfF7mZV4jiv1Gp/r0fOtCfCqR5Rpudg4uX0pQ7/qsJrUFNE28C1
         W9IHDgJPSEHD/MoGHBDw0euu0bUQPz+IiTtfS0twCwzPhGLHPYXtxxSojEkwcxmHkdwZ
         rlaQ==
X-Gm-Message-State: AEkoouvQMY9SxNAk+m8fnawapNvNFIYNKzlB8MzFNOFqFPySAaMrDDJ1snFofJOHHp4Mng==
X-Received: by 10.28.170.72 with SMTP id t69mr27965465wme.115.1472123289074;
        Thu, 25 Aug 2016 04:08:09 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.08.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:08:08 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 09/13] convert: modernize tests
Date:   Thu, 25 Aug 2016 13:07:48 +0200
Message-Id: <20160825110752.31581-10-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Use `test_config` to set the config, check that files are empty with
`test_must_be_empty`, compare files with `test_cmp`, and remove spaces
after ">" and "<".

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh | 62 +++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 7bac2bc..7b45136 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -13,8 +13,8 @@ EOF
 chmod +x rot13.sh
 
 test_expect_success setup '
-	git config filter.rot13.smudge ./rot13.sh &&
-	git config filter.rot13.clean ./rot13.sh &&
+	test_config filter.rot13.smudge ./rot13.sh &&
+	test_config filter.rot13.clean ./rot13.sh &&
 
 	{
 	    echo "*.t filter=rot13"
@@ -38,8 +38,8 @@ script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
 
 test_expect_success check '
 
-	cmp test.o test &&
-	cmp test.o test.t &&
+	test_cmp test.o test &&
+	test_cmp test.o test.t &&
 
 	# ident should be stripped in the repository
 	git diff --raw --exit-code :test :test.i &&
@@ -47,10 +47,10 @@ test_expect_success check '
 	embedded=$(sed -ne "$script" test.i) &&
 	test "z$id" = "z$embedded" &&
 
-	git cat-file blob :test.t > test.r &&
+	git cat-file blob :test.t >test.r &&
 
-	./rot13.sh < test.o > test.t &&
-	cmp test.r test.t
+	./rot13.sh <test.o >test.t &&
+	test_cmp test.r test.t
 '
 
 # If an expanded ident ever gets into the repository, we want to make sure that
@@ -130,7 +130,7 @@ test_expect_success 'filter shell-escaped filenames' '
 
 	# delete the files and check them out again, using a smudge filter
 	# that will count the args and echo the command-line back to us
-	git config filter.argc.smudge "sh ./argc.sh %f" &&
+	test_config filter.argc.smudge "sh ./argc.sh %f" &&
 	rm "$normal" "$special" &&
 	git checkout -- "$normal" "$special" &&
 
@@ -141,7 +141,7 @@ test_expect_success 'filter shell-escaped filenames' '
 	test_cmp expect "$special" &&
 
 	# do the same thing, but with more args in the filter expression
-	git config filter.argc.smudge "sh ./argc.sh %f --my-extra-arg" &&
+	test_config filter.argc.smudge "sh ./argc.sh %f --my-extra-arg" &&
 	rm "$normal" "$special" &&
 	git checkout -- "$normal" "$special" &&
 
@@ -154,9 +154,9 @@ test_expect_success 'filter shell-escaped filenames' '
 '
 
 test_expect_success 'required filter should filter data' '
-	git config filter.required.smudge ./rot13.sh &&
-	git config filter.required.clean ./rot13.sh &&
-	git config filter.required.required true &&
+	test_config filter.required.smudge ./rot13.sh &&
+	test_config filter.required.clean ./rot13.sh &&
+	test_config filter.required.required true &&
 
 	echo "*.r filter=required" >.gitattributes &&
 
@@ -165,17 +165,17 @@ test_expect_success 'required filter should filter data' '
 
 	rm -f test.r &&
 	git checkout -- test.r &&
-	cmp test.o test.r &&
+	test_cmp test.o test.r &&
 
 	./rot13.sh <test.o >expected &&
 	git cat-file blob :test.r >actual &&
-	cmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'required filter smudge failure' '
-	git config filter.failsmudge.smudge false &&
-	git config filter.failsmudge.clean cat &&
-	git config filter.failsmudge.required true &&
+	test_config filter.failsmudge.smudge false &&
+	test_config filter.failsmudge.clean cat &&
+	test_config filter.failsmudge.required true &&
 
 	echo "*.fs filter=failsmudge" >.gitattributes &&
 
@@ -186,9 +186,9 @@ test_expect_success 'required filter smudge failure' '
 '
 
 test_expect_success 'required filter clean failure' '
-	git config filter.failclean.smudge cat &&
-	git config filter.failclean.clean false &&
-	git config filter.failclean.required true &&
+	test_config filter.failclean.smudge cat &&
+	test_config filter.failclean.clean false &&
+	test_config filter.failclean.required true &&
 
 	echo "*.fc filter=failclean" >.gitattributes &&
 
@@ -197,8 +197,8 @@ test_expect_success 'required filter clean failure' '
 '
 
 test_expect_success 'filtering large input to small output should use little memory' '
-	git config filter.devnull.clean "cat >/dev/null" &&
-	git config filter.devnull.required true &&
+	test_config filter.devnull.clean "cat >/dev/null" &&
+	test_config filter.devnull.required true &&
 	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
 	echo "30MB filter=devnull" >.gitattributes &&
 	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
@@ -207,7 +207,7 @@ test_expect_success 'filtering large input to small output should use little mem
 test_expect_success 'filter that does not read is fine' '
 	test-genrandom foo $((128 * 1024 + 1)) >big &&
 	echo "big filter=epipe" >.gitattributes &&
-	git config filter.epipe.clean "echo xyzzy" &&
+	test_config filter.epipe.clean "echo xyzzy" &&
 	git add big &&
 	git cat-file blob :big >actual &&
 	echo xyzzy >expect &&
@@ -215,20 +215,20 @@ test_expect_success 'filter that does not read is fine' '
 '
 
 test_expect_success EXPENSIVE 'filter large file' '
-	git config filter.largefile.smudge cat &&
-	git config filter.largefile.clean cat &&
+	test_config filter.largefile.smudge cat &&
+	test_config filter.largefile.clean cat &&
 	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
 	echo "2GB filter=largefile" >.gitattributes &&
 	git add 2GB 2>err &&
-	! test -s err &&
+	test_must_be_empty err &&
 	rm -f 2GB &&
 	git checkout -- 2GB 2>err &&
-	! test -s err
+	test_must_be_empty err
 '
 
 test_expect_success "filter: clean empty file" '
-	git config filter.in-repo-header.clean  "echo cleaned && cat" &&
-	git config filter.in-repo-header.smudge "sed 1d" &&
+	test_config filter.in-repo-header.clean  "echo cleaned && cat" &&
+	test_config filter.in-repo-header.smudge "sed 1d" &&
 
 	echo "empty-in-worktree    filter=in-repo-header" >>.gitattributes &&
 	>empty-in-worktree &&
@@ -240,8 +240,8 @@ test_expect_success "filter: clean empty file" '
 '
 
 test_expect_success "filter: smudge empty file" '
-	git config filter.empty-in-repo.clean "cat >/dev/null" &&
-	git config filter.empty-in-repo.smudge "echo smudged && cat" &&
+	test_config filter.empty-in-repo.clean "cat >/dev/null" &&
+	test_config filter.empty-in-repo.smudge "echo smudged && cat" &&
 
 	echo "empty-in-repo filter=empty-in-repo" >>.gitattributes &&
 	echo dead data walking >empty-in-repo &&
-- 
2.9.2

