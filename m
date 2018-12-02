Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0218C211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 02:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725732AbeLBCds (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 21:33:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38040 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeLBCdr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 21:33:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so4662136pfi.5
        for <git@vger.kernel.org>; Sat, 01 Dec 2018 18:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xl5f+uFZhjicXRrK7FKE43jjPn4Dr3kwqNTiU+/7jw=;
        b=BEYOeXFJgBI+s8Ov3ETsz4ZmSLZ2Re2pKc6rvegHvHJooh9Mb9hHyhbwstgfIe2jct
         RMceSza1cz15HRUYCcGBAz1BBKgY3O7fGPu18LJiahGGf5sDlh5reBd42igfxGmZHxdx
         zJbuMfI8RNxPK00UA5RLmI8EmH45T6kLRwlnhXk/EkKZVt2YwbmrZc2bVIwyhtzPqfKb
         3RDfhDlYpFQNKnwWFrdwATvcoO9HkwLrlWDtrvqcO1yqImiogra0YHAiQ88RLABt0QSz
         wXTPQ16jRjDoPPxUSNLLUHtYtSN1QtQD2i2/EQv/VKOdRLU2rjqc2AwBp0aVG24F+N6j
         rKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xl5f+uFZhjicXRrK7FKE43jjPn4Dr3kwqNTiU+/7jw=;
        b=XEEQndA66PSUFyfaVd744TGvXFBlgeW9cfxr1aV6qAqcrm1rvUQ85k8WbvmVjXsJpT
         CGPE07iEambB6CSsLzELdl+X06SCmdkDV3qA0QSTaTlNYnHTxYtGzY+9JwtUr8YgNRI3
         1lmuTfxXikpn9wGuTNNd3XiV3wVnfilZC3VJ2+ZuLsJl79MDAGK0LtAqXLxNh++eGaeD
         SsbX5RUWrkQzO/RNcdtRxFMcEzI52pgGjPpYhYzk4JlyAcm/mL/05tmdNUQt/9XrjCz2
         zJ7ppkMESziyOHZvP2UhgmzkTFObw/9On+OWJqk32Ap8258i7NMoxIVgPHLTkLP478/C
         1wXw==
X-Gm-Message-State: AA+aEWb2IEvpKMZOnj8ErEbAjV9CKhNfoshilyRo53/BF8TBPxqZ6b//
        A3MOoKaaRDu1Roo7RkmUfG9uDr9O
X-Google-Smtp-Source: AFSGD/WG009EhqHbp2+2QU3yPbcqRe6jBpEJ+W+RxnLIgqmSpT4QOt5cDDifxiNpRy7pyI7CUvZaqw==
X-Received: by 2002:a65:50c1:: with SMTP id s1mr9130724pgp.350.1543718024274;
        Sat, 01 Dec 2018 18:33:44 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id g5sm15992111pgu.57.2018.12.01.18.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 18:33:43 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, l.s.r@web.de
Subject: [PATCH] t5004: avoid using tar for empty packages
Date:   Sat,  1 Dec 2018 18:33:41 -0800
Message-Id: <20181202023341.65044-1-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ea2d20d4c2 ("t5004: avoid using tar for checking emptiness of archive",
2013-05-09), introduced a fake empty tar archive to allow for portable
tests of emptiness without having to invoke tar

4318094047 ("archive: don't add empty directories to archives", 2017-09-13)
changed the expected result for its tests from one containing an empty
directory to a plain empty archive but the portable test wasn't updated
resulting on them failing again in (at least) NetBSD and OpenBSD

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t5004-archive-corner-cases.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index ced44355ca..271eb5a1fd 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -3,8 +3,12 @@
 test_description='test corner cases of git-archive'
 . ./test-lib.sh
 
-test_expect_success 'create commit with empty tree' '
-	git commit --allow-empty -m foo
+# the 10knuls.tar file is used to test for an empty git generated tar
+# without having to invoke tar because an otherwise valid empty GNU tar
+# will be considered broken by {Open,Net}BSD tar
+test_expect_success 'create commit with empty tree and fake empty tar' '
+	git commit --allow-empty -m foo &&
+	perl -e "print \"\\0\" x 10240" >10knuls.tar
 '
 
 # Make a dir and clean it up afterwards
@@ -47,7 +51,6 @@ test_expect_success HEADER_ONLY_TAR_OK 'tar archive of commit with empty tree' '
 
 test_expect_success 'tar archive of empty tree is empty' '
 	git archive --format=tar HEAD: >empty.tar &&
-	perl -e "print \"\\0\" x 10240" >10knuls.tar &&
 	test_cmp_bin 10knuls.tar empty.tar
 '
 
@@ -106,16 +109,12 @@ test_expect_success 'create a commit with an empty subtree' '
 
 test_expect_success 'archive empty subtree with no pathspec' '
 	git archive --format=tar $root_tree >subtree-all.tar &&
-	make_dir extract &&
-	"$TAR" xf subtree-all.tar -C extract &&
-	check_dir extract
+	test_cmp_bin 10knuls.tar subtree-all.tar
 '
 
 test_expect_success 'archive empty subtree by direct pathspec' '
 	git archive --format=tar $root_tree -- sub >subtree-path.tar &&
-	make_dir extract &&
-	"$TAR" xf subtree-path.tar -C extract &&
-	check_dir extract
+	test_cmp_bin 10knuls.tar subtree-path.tar
 '
 
 ZIPINFO=zipinfo
-- 
2.20.0.rc2

