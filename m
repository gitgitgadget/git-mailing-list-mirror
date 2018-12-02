Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6653C211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 02:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725733AbeLBCkL (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 21:40:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43304 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeLBCkK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 21:40:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so4659794pfk.10
        for <git@vger.kernel.org>; Sat, 01 Dec 2018 18:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xl5f+uFZhjicXRrK7FKE43jjPn4Dr3kwqNTiU+/7jw=;
        b=ipoJ+WDSLRFW9GQRPKZ5ayyfL5PydgOzAGx80qE6j97FTWMJBr7XcWVSmEEER9rVGg
         4/GyJOGjvRZjUdeaiHtQ7H4e8rMw+qIqs9dEs5VUA3GQuQ7JjrotLtUCGDskMSgXK2SB
         pjZtUHdM6+uTvwmYb6WgbglLP+xZ/i1PLnBQK2ZzYs8oiPt/ZJEgWok/8O1WlQqTK0iw
         wqJBc45DjwrERBiOfwKyW1elQEdJC/TYXB7bl0BItwD+lHa2qMsgFpAHxupiVAfV3yOU
         i2bMg3IGPI3sZkNDhENrKT3+oQ8I9lgB75gRDB+6lwWHBG2uzjK/s7Mztqbp3xaa5erS
         ewvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xl5f+uFZhjicXRrK7FKE43jjPn4Dr3kwqNTiU+/7jw=;
        b=bXq+Z8qsAyDAoD1BJN33CvHp6O850P1kONK1rTrDFAL6N5P9+Zq7w3I45tPC1fLl8+
         V2vDit4r8Jb7HWRtfLgUeXL7KinzqBfpRPb7Ju+SOjk8e1AYMuCLxUqEOAqD7jUMS0DD
         /8nl49ozW+p1YU5wJr110LJhFMTBYVdUiES+MQ1EIWaDPWuKjtFUbZC6hYaAxEz3DXjW
         Zxw2kP0bOIQCHnyMXG/Inw/EootDD6/bhhD8tN6kor4Pc7llo94NFMLCU3g7KzdUNVyd
         rhAmeZPg7dc7vQlnr4rBZDr8YWZfdwZpkwA4rz+bgWMPevOufQEPFY5UnkM2nsMJJUeY
         zgiA==
X-Gm-Message-State: AA+aEWbf7jY9Z4fGQ51OAyiPo3tcAAUcOF0jIkjj1sNL7FDwU39YW7py
        za0eUnBGIqgLvoKlAYnDEEI66mkf
X-Google-Smtp-Source: AFSGD/UslL/yJOi7P/TKFuMqwQqpg8rqsRumy++b1wcqg6FBzVFXC4FtMWpJdZEvTBHgpMimGJWHjw==
X-Received: by 2002:a63:235f:: with SMTP id u31mr9258813pgm.122.1543718406957;
        Sat, 01 Dec 2018 18:40:06 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id k63sm17865425pfc.76.2018.12.01.18.40.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 18:40:06 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] t5004: avoid using tar for empty packages
Date:   Sat,  1 Dec 2018 18:40:03 -0800
Message-Id: <20181202024003.65103-1-carenas@gmail.com>
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

