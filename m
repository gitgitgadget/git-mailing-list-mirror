Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20FDC77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjETQO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjETQOR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E21310A
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f41d087a84so13022975e9.1
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599246; x=1687191246;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1TGazJy898k5wxyTYl93NPRr+S0GZ3T/j5KJOKpJ/o=;
        b=E1tYhNvlz6fzxeSlw/g6Bjh8fu/dcOgaVTIjQqn6JErg/S18fJo04NEcBkrob8yJho
         N+gzFdSGQdn95xrwDUPDx3GJejNouX2vWru25VgW9se/o/qjaeqH7/V6vuIYdjjEPxOf
         WazFqUauZMc1cbvfs8uUgtS/kORjhvhq3PeoDf0dTXGDt1Z+Xf1khu8V0yCRKOPJuXVh
         xhcH0XDw19hQVcKjp3nT5hrxTu7cSAJh8pz5MVOggsX4eZy7CQa48HVolSBHAuVxhFma
         uOxVfdy/Hq/TuGvVAZL6arvAKjJ/U8Yp/Sz2RLqfU/oTbjYwhG3/+bRRxKbkXj6qcjgu
         cUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599246; x=1687191246;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1TGazJy898k5wxyTYl93NPRr+S0GZ3T/j5KJOKpJ/o=;
        b=XU3kFcruHB6YBZTfwQbRHM50YdoepHb5+4NsH/NX6/X+umqMniXJ4UxPTIdL3EQYdY
         GLmgIQUN/LWihWsfTqlS1LvsRI8CysbXc6Lg0/AyQ0QC56QHE8W/T6xa4iAYKr+XgvrF
         idc5IFnfPV5vRbcK6jopIlCS//ab+sfEiGkQC0DiAFcl5PxGy/FUkdKv3gHOpf8XAD0k
         SnueCYDjuobv/D4r+XP1sXzjMd0kyrk8o/eiCTFJ+TCFyv6w7KEQRN0wjD7UAjcHC5wD
         mqfPkSRJyskTM5R3djpXxQONSgYCiR3YXEvDc5b+XKoy8/cHbR4RBsjFf6iY7PRrvx1T
         KVcg==
X-Gm-Message-State: AC+VfDw0/oT0aCemGDCvMPsr//VHirRfxW0Yr8WqmJrkITyr932vQl+z
        3THgBia1Jx42JLJ1vXBgwzzupNb+2Nc=
X-Google-Smtp-Source: ACHHUZ5ak9l1dw0skxND5MNS2zcgH6XOtcXaYnjoyy3VgA2yspCFIhtdpYhqgr3YH+lZVpgg4Tk9IA==
X-Received: by 2002:a1c:7503:0:b0:3f5:e29:bcde with SMTP id o3-20020a1c7503000000b003f50e29bcdemr4208545wmc.17.1684599246417;
        Sat, 20 May 2023 09:14:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3-20020a7bc4c3000000b003f427687ba7sm2631108wmk.41.2023.05.20.09.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:14:05 -0700 (PDT)
Message-Id: <01f752d38c6fe38351410540514c1408948fe65e.1684599239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
References: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:57 +0000
Subject: [PATCH 09/10] t9200-git-cvsexportcommit: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t9200-git-cvsexportcommit.sh | 351 ++++++++++++++++-----------------
 1 file changed, 175 insertions(+), 176 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index c5946cb0b8a..a44eabf0d80 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -50,56 +50,56 @@ check_entries () {
 	fi
 }
 
-test_expect_success \
-    'New file' \
-    'mkdir A B C D E F &&
-     echo hello1 >A/newfile1.txt &&
-     echo hello2 >B/newfile2.txt &&
-     cp "$TEST_DIRECTORY"/test-binary-1.png C/newfile3.png &&
-     cp "$TEST_DIRECTORY"/test-binary-1.png D/newfile4.png &&
-     git add A/newfile1.txt &&
-     git add B/newfile2.txt &&
-     git add C/newfile3.png &&
-     git add D/newfile4.png &&
-     git commit -a -m "Test: New file" &&
-     id=$(git rev-list --max-count=1 HEAD) &&
-     (cd "$CVSWORK" &&
-     git cvsexportcommit -c $id &&
-     check_entries A "newfile1.txt/1.1/" &&
-     check_entries B "newfile2.txt/1.1/" &&
-     check_entries C "newfile3.png/1.1/-kb" &&
-     check_entries D "newfile4.png/1.1/-kb" &&
-     test_cmp A/newfile1.txt ../A/newfile1.txt &&
-     test_cmp B/newfile2.txt ../B/newfile2.txt &&
-     test_cmp C/newfile3.png ../C/newfile3.png &&
-     test_cmp D/newfile4.png ../D/newfile4.png
-     )'
+test_expect_success 'New file' '
+	mkdir A B C D E F &&
+	echo hello1 >A/newfile1.txt &&
+	echo hello2 >B/newfile2.txt &&
+	cp "$TEST_DIRECTORY"/test-binary-1.png C/newfile3.png &&
+	cp "$TEST_DIRECTORY"/test-binary-1.png D/newfile4.png &&
+	git add A/newfile1.txt &&
+	git add B/newfile2.txt &&
+	git add C/newfile3.png &&
+	git add D/newfile4.png &&
+	git commit -a -m "Test: New file" &&
+	id=$(git rev-list --max-count=1 HEAD) &&
+	(cd "$CVSWORK" &&
+	git cvsexportcommit -c $id &&
+	check_entries A "newfile1.txt/1.1/" &&
+	check_entries B "newfile2.txt/1.1/" &&
+	check_entries C "newfile3.png/1.1/-kb" &&
+	check_entries D "newfile4.png/1.1/-kb" &&
+	test_cmp A/newfile1.txt ../A/newfile1.txt &&
+	test_cmp B/newfile2.txt ../B/newfile2.txt &&
+	test_cmp C/newfile3.png ../C/newfile3.png &&
+	test_cmp D/newfile4.png ../D/newfile4.png
+	)
+'
 
-test_expect_success \
-    'Remove two files, add two and update two' \
-    'echo Hello1 >>A/newfile1.txt &&
-     rm -f B/newfile2.txt &&
-     rm -f C/newfile3.png &&
-     echo Hello5  >E/newfile5.txt &&
-     cp "$TEST_DIRECTORY"/test-binary-2.png D/newfile4.png &&
-     cp "$TEST_DIRECTORY"/test-binary-1.png F/newfile6.png &&
-     git add E/newfile5.txt &&
-     git add F/newfile6.png &&
-     git commit -a -m "Test: Remove, add and update" &&
-     id=$(git rev-list --max-count=1 HEAD) &&
-     (cd "$CVSWORK" &&
-     git cvsexportcommit -c $id &&
-     check_entries A "newfile1.txt/1.2/" &&
-     check_entries B "" &&
-     check_entries C "" &&
-     check_entries D "newfile4.png/1.2/-kb" &&
-     check_entries E "newfile5.txt/1.1/" &&
-     check_entries F "newfile6.png/1.1/-kb" &&
-     test_cmp A/newfile1.txt ../A/newfile1.txt &&
-     test_cmp D/newfile4.png ../D/newfile4.png &&
-     test_cmp E/newfile5.txt ../E/newfile5.txt &&
-     test_cmp F/newfile6.png ../F/newfile6.png
-     )'
+test_expect_success 'Remove two files, add two and update two' '
+	echo Hello1 >>A/newfile1.txt &&
+	rm -f B/newfile2.txt &&
+	rm -f C/newfile3.png &&
+	echo Hello5  >E/newfile5.txt &&
+	cp "$TEST_DIRECTORY"/test-binary-2.png D/newfile4.png &&
+	cp "$TEST_DIRECTORY"/test-binary-1.png F/newfile6.png &&
+	git add E/newfile5.txt &&
+	git add F/newfile6.png &&
+	git commit -a -m "Test: Remove, add and update" &&
+	id=$(git rev-list --max-count=1 HEAD) &&
+	(cd "$CVSWORK" &&
+	git cvsexportcommit -c $id &&
+	check_entries A "newfile1.txt/1.2/" &&
+	check_entries B "" &&
+	check_entries C "" &&
+	check_entries D "newfile4.png/1.2/-kb" &&
+	check_entries E "newfile5.txt/1.1/" &&
+	check_entries F "newfile6.png/1.1/-kb" &&
+	test_cmp A/newfile1.txt ../A/newfile1.txt &&
+	test_cmp D/newfile4.png ../D/newfile4.png &&
+	test_cmp E/newfile5.txt ../E/newfile5.txt &&
+	test_cmp F/newfile6.png ../F/newfile6.png
+	)
+'
 
 # Should fail (but only on the git cvsexportcommit stage)
 test_expect_success \
@@ -129,67 +129,67 @@ test_expect_success \
 
 # This test is here because a patch for only binary files will
 # fail with gnu patch, so cvsexportcommit must handle that.
-test_expect_success \
-    'Remove only binary files' \
-    'git reset --hard HEAD^^ &&
-     rm -f D/newfile4.png &&
-     git commit -a -m "test: remove only a binary file" &&
-     id=$(git rev-list --max-count=1 HEAD) &&
-     (cd "$CVSWORK" &&
-     git cvsexportcommit -c $id &&
-     check_entries A "newfile1.txt/1.2/" &&
-     check_entries B "" &&
-     check_entries C "" &&
-     check_entries D "" &&
-     check_entries E "newfile5.txt/1.1/" &&
-     check_entries F "newfile6.png/1.1/-kb" &&
-     test_cmp A/newfile1.txt ../A/newfile1.txt &&
-     test_cmp E/newfile5.txt ../E/newfile5.txt &&
-     test_cmp F/newfile6.png ../F/newfile6.png
-     )'
+test_expect_success 'Remove only binary files' '
+	git reset --hard HEAD^^ &&
+	rm -f D/newfile4.png &&
+	git commit -a -m "test: remove only a binary file" &&
+	id=$(git rev-list --max-count=1 HEAD) &&
+	(cd "$CVSWORK" &&
+	git cvsexportcommit -c $id &&
+	check_entries A "newfile1.txt/1.2/" &&
+	check_entries B "" &&
+	check_entries C "" &&
+	check_entries D "" &&
+	check_entries E "newfile5.txt/1.1/" &&
+	check_entries F "newfile6.png/1.1/-kb" &&
+	test_cmp A/newfile1.txt ../A/newfile1.txt &&
+	test_cmp E/newfile5.txt ../E/newfile5.txt &&
+	test_cmp F/newfile6.png ../F/newfile6.png
+	)
+'
 
-test_expect_success \
-    'Remove only a text file' \
-    'rm -f A/newfile1.txt &&
-     git commit -a -m "test: remove only a binary file" &&
-     id=$(git rev-list --max-count=1 HEAD) &&
-     (cd "$CVSWORK" &&
-     git cvsexportcommit -c $id &&
-     check_entries A "" &&
-     check_entries B "" &&
-     check_entries C "" &&
-     check_entries D "" &&
-     check_entries E "newfile5.txt/1.1/" &&
-     check_entries F "newfile6.png/1.1/-kb" &&
-     test_cmp E/newfile5.txt ../E/newfile5.txt &&
-     test_cmp F/newfile6.png ../F/newfile6.png
-     )'
+test_expect_success 'Remove only a text file' '
+	rm -f A/newfile1.txt &&
+	git commit -a -m "test: remove only a binary file" &&
+	id=$(git rev-list --max-count=1 HEAD) &&
+	(cd "$CVSWORK" &&
+	git cvsexportcommit -c $id &&
+	check_entries A "" &&
+	check_entries B "" &&
+	check_entries C "" &&
+	check_entries D "" &&
+	check_entries E "newfile5.txt/1.1/" &&
+	check_entries F "newfile6.png/1.1/-kb" &&
+	test_cmp E/newfile5.txt ../E/newfile5.txt &&
+	test_cmp F/newfile6.png ../F/newfile6.png
+	)
+'
 
-test_expect_success \
-     'New file with spaces in file name' \
-     'mkdir "G g" &&
-      echo ok then >"G g/with spaces.txt" &&
-      git add "G g/with spaces.txt" && \
-      cp "$TEST_DIRECTORY"/test-binary-1.png "G g/with spaces.png" && \
-      git add "G g/with spaces.png" &&
-      git commit -a -m "With spaces" &&
-      id=$(git rev-list --max-count=1 HEAD) &&
-      (cd "$CVSWORK" &&
-      git cvsexportcommit -c $id &&
-      check_entries "G g" "with spaces.png/1.1/-kb|with spaces.txt/1.1/"
-      )'
+test_expect_success 'New file with spaces in file name' '
+	mkdir "G g" &&
+	echo ok then >"G g/with spaces.txt" &&
+	git add "G g/with spaces.txt" && \
+	cp "$TEST_DIRECTORY"/test-binary-1.png "G g/with spaces.png" && \
+	git add "G g/with spaces.png" &&
+	git commit -a -m "With spaces" &&
+	id=$(git rev-list --max-count=1 HEAD) &&
+	(cd "$CVSWORK" &&
+	git cvsexportcommit -c $id &&
+	check_entries "G g" "with spaces.png/1.1/-kb|with spaces.txt/1.1/"
+	)
+'
 
-test_expect_success \
-     'Update file with spaces in file name' \
-     'echo Ok then >>"G g/with spaces.txt" &&
-      cat "$TEST_DIRECTORY"/test-binary-1.png >>"G g/with spaces.png" && \
-      git add "G g/with spaces.png" &&
-      git commit -a -m "Update with spaces" &&
-      id=$(git rev-list --max-count=1 HEAD) &&
-      (cd "$CVSWORK" &&
-      git cvsexportcommit -c $id &&
-      check_entries "G g" "with spaces.png/1.2/-kb|with spaces.txt/1.2/"
-      )'
+test_expect_success 'Update file with spaces in file name' '
+	echo Ok then >>"G g/with spaces.txt" &&
+	cat "$TEST_DIRECTORY"/test-binary-1.png >>"G g/with spaces.png" && \
+	git add "G g/with spaces.png" &&
+	git commit -a -m "Update with spaces" &&
+	id=$(git rev-list --max-count=1 HEAD) &&
+	(cd "$CVSWORK" &&
+	git cvsexportcommit -c $id &&
+	check_entries "G g" "with spaces.png/1.2/-kb|with spaces.txt/1.2/"
+	)
+'
 
 # Some filesystems mangle pathnames with UTF-8 characters --
 # check and skip
@@ -202,68 +202,68 @@ if p="Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö" &&
 then
 
 # This test contains UTF-8 characters
-test_expect_success !MINGW \
-     'File with non-ascii file name' \
-     'mkdir -p Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö &&
-      echo Foo >Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö/gårdetsågårdet.txt &&
-      git add Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö/gårdetsågårdet.txt &&
-      cp "$TEST_DIRECTORY"/test-binary-1.png Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö/gårdetsågårdet.png &&
-      git add Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö/gårdetsågårdet.png &&
-      git commit -a -m "Går det så går det" && \
-      id=$(git rev-list --max-count=1 HEAD) &&
-      (cd "$CVSWORK" &&
-      git cvsexportcommit -v -c $id &&
-      check_entries \
-      "Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö" \
-      "gårdetsågårdet.png/1.1/-kb|gårdetsågårdet.txt/1.1/"
-      )'
+test_expect_success !MINGW 'File with non-ascii file name' '
+	mkdir -p Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö &&
+	echo Foo >Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö/gårdetsågårdet.txt &&
+	git add Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö/gårdetsågårdet.txt &&
+	cp "$TEST_DIRECTORY"/test-binary-1.png Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö/gårdetsågårdet.png &&
+	git add Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö/gårdetsågårdet.png &&
+	git commit -a -m "Går det så går det" && \
+	id=$(git rev-list --max-count=1 HEAD) &&
+	(cd "$CVSWORK" &&
+	git cvsexportcommit -v -c $id &&
+	check_entries \
+	"Å/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/å/ä/ö" \
+	"gårdetsågårdet.png/1.1/-kb|gårdetsågårdet.txt/1.1/"
+	)
+'
 
 fi
 
 rm -fr tst
 
-test_expect_success \
-     'Mismatching patch should fail' \
-     'date >>"E/newfile5.txt" &&
-      git add "E/newfile5.txt" &&
-      git commit -a -m "Update one" &&
-      date >>"E/newfile5.txt" &&
-      git add "E/newfile5.txt" &&
-      git commit -a -m "Update two" &&
-      id=$(git rev-list --max-count=1 HEAD) &&
-      (cd "$CVSWORK" &&
-      test_must_fail git cvsexportcommit -c $id
-      )'
-
-test_expect_success FILEMODE \
-     'Retain execute bit' \
-     'mkdir G &&
-      echo executeon >G/on &&
-      chmod +x G/on &&
-      echo executeoff >G/off &&
-      git add G/on &&
-      git add G/off &&
-      git commit -a -m "Execute test" &&
-      (cd "$CVSWORK" &&
-      git cvsexportcommit -c HEAD &&
-      test -x G/on &&
-      ! test -x G/off
-      )'
+test_expect_success 'Mismatching patch should fail' '
+	date >>"E/newfile5.txt" &&
+	git add "E/newfile5.txt" &&
+	git commit -a -m "Update one" &&
+	date >>"E/newfile5.txt" &&
+	git add "E/newfile5.txt" &&
+	git commit -a -m "Update two" &&
+	id=$(git rev-list --max-count=1 HEAD) &&
+	(cd "$CVSWORK" &&
+	test_must_fail git cvsexportcommit -c $id
+	)
+'
+
+test_expect_success FILEMODE 'Retain execute bit' '
+	mkdir G &&
+	echo executeon >G/on &&
+	chmod +x G/on &&
+	echo executeoff >G/off &&
+	git add G/on &&
+	git add G/off &&
+	git commit -a -m "Execute test" &&
+	(cd "$CVSWORK" &&
+	git cvsexportcommit -c HEAD &&
+	test -x G/on &&
+	! test -x G/off
+	)
+'
 
 test_expect_success '-w option should work with relative GIT_DIR' '
-      mkdir W &&
-      echo foobar >W/file1.txt &&
-      echo bazzle >W/file2.txt &&
-      git add W/file1.txt &&
-      git add W/file2.txt &&
-      git commit -m "More updates" &&
-      id=$(git rev-list --max-count=1 HEAD) &&
-      (cd "$GIT_DIR" &&
-      GIT_DIR=. git cvsexportcommit -w "$CVSWORK" -c $id &&
-      check_entries "$CVSWORK/W" "file1.txt/1.1/|file2.txt/1.1/" &&
-      test_cmp "$CVSWORK/W/file1.txt" ../W/file1.txt &&
-      test_cmp "$CVSWORK/W/file2.txt" ../W/file2.txt
-      )
+	mkdir W &&
+	echo foobar >W/file1.txt &&
+	echo bazzle >W/file2.txt &&
+	git add W/file1.txt &&
+	git add W/file2.txt &&
+	git commit -m "More updates" &&
+	id=$(git rev-list --max-count=1 HEAD) &&
+	(cd "$GIT_DIR" &&
+	GIT_DIR=. git cvsexportcommit -w "$CVSWORK" -c $id &&
+	check_entries "$CVSWORK/W" "file1.txt/1.1/|file2.txt/1.1/" &&
+	test_cmp "$CVSWORK/W/file1.txt" ../W/file1.txt &&
+	test_cmp "$CVSWORK/W/file2.txt" ../W/file2.txt
+	)
 '
 
 test_expect_success 'check files before directories' '
@@ -290,21 +290,20 @@ test_expect_success 'check files before directories' '
 '
 
 test_expect_success 're-commit a removed filename which remains in CVS attic' '
-
-    (cd "$CVSWORK" &&
-     echo >attic_gremlin &&
-     cvs -Q add attic_gremlin &&
-     cvs -Q ci -m "added attic_gremlin" &&
-     rm attic_gremlin &&
-     cvs -Q rm attic_gremlin &&
-     cvs -Q ci -m "removed attic_gremlin") &&
-
-    echo > attic_gremlin &&
-    git add attic_gremlin &&
-    git commit -m "Added attic_gremlin" &&
+	(cd "$CVSWORK" &&
+	echo >attic_gremlin &&
+	cvs -Q add attic_gremlin &&
+	cvs -Q ci -m "added attic_gremlin" &&
+	rm attic_gremlin &&
+	cvs -Q rm attic_gremlin &&
+	cvs -Q ci -m "removed attic_gremlin") &&
+
+	echo > attic_gremlin &&
+	git add attic_gremlin &&
+	git commit -m "Added attic_gremlin" &&
 	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
-    (cd "$CVSWORK" && cvs -Q update -d) &&
-    test -f "$CVSWORK/attic_gremlin"
+	(cd "$CVSWORK" && cvs -Q update -d) &&
+	test -f "$CVSWORK/attic_gremlin"
 '
 
 # the state of the CVS sandbox may be indeterminate for ' space'
-- 
gitgitgadget

