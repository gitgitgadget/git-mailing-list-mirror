Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FFF81F858
	for <e@80x24.org>; Wed,  3 Aug 2016 16:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758123AbcHCQnp (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36558 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757596AbcHCQnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so37153422wma.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/pQJNzRbWGWv0gnP6omZd1JSFK9zw9YYav9rpjFgFpc=;
        b=z6UZ5hs/b6I8aWrZ97fetxlIVhna+xZFLv7nSuNyCZ0IULOnatugJsbwPd4YT+hlPo
         c8g6sF/MNB/FavhpuVbN6b10ASVjmRZCgbE4Ko+0zR6JdeGNpiC2hfPkGbSkta8SMh+v
         aFn9ekmw6CSZMr2BdXo8WDBj7TbXLJkt6DboxZ0S21nPBRH0IAdwGaqciWWRK7zkyQCb
         YvIKc5vMqEaR5RK7+mI7CMzKB+/9FRaugbDI9WD0PkWqjR5WmxFmnAGCwow+KiNE1/2z
         7cFjgF+yXH14ppRfOUaK+d16Aa4VNjqRLU6dSuGQoJ/U+j+zfVHro+tB8BMxUnqVOhkE
         LatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/pQJNzRbWGWv0gnP6omZd1JSFK9zw9YYav9rpjFgFpc=;
        b=BMFV4ppE2d9TjKF5hDcDo8RTa2gBaD5NBTZJS//Ukz00kaDRplIggJGcyFSwHvRuwu
         TbGRl7TRRwQKWQ05a3P575U5AvFg6iDMhXSqHKwvDq/G2p9RxnZyNIvkOQrtnhMCSv5S
         GGyzRC8ZYqowZ6ELYzgL29QTfbKG/J4qY8um5Rzg/+5GiMXDstgBYGqK9QCDzK50943D
         L3a5Md/xX96d9KO78LbOro+xNBLi/ZEm4ADqAqj21dqqkPq3OWOOjiDhuaxNO+PEEikn
         Fm5QWET7ymlVUJli9cjZjShIrIO/BM8o94kJ+uuJkZkfhAkEMZKwxU9JVc1tqnSzt4At
         5a6Q==
X-Gm-Message-State: AEkooutW6FWITaj2BIOt+i8gPx/eHPXkSk+URENjdYhwiNEsVzPW7zDnlAvY6LLAsGoezg==
X-Received: by 10.28.37.194 with SMTP id l185mr53767180wml.82.1470242557003;
        Wed, 03 Aug 2016 09:42:37 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:36 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 09/12] convert: modernize tests
Date:	Wed,  3 Aug 2016 18:42:22 +0200
Message-Id: <20160803164225.46355-10-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.9.0

