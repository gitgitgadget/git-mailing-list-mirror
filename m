Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MIME_HEADER_CTYPE_ONLY,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_TVD_MIME_NO_HEADERS
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1712520A93
	for <e@80x24.org>; Fri,  6 Jan 2017 01:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939191AbdAFBKz (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 20:10:55 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35719 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936912AbdAFBKh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 20:10:37 -0500
Received: by mail-qk0-f174.google.com with SMTP id u25so445897299qki.2
        for <git@vger.kernel.org>; Thu, 05 Jan 2017 17:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rFYHv0l5UXfkDhPq1yvGt5C2xL6HmIDNEX6+RZLbAtE=;
        b=jwt7wou9YBHoNw4Yhnm3zonKVuBafkkPfTDFuK2PbWzJLcBy9ugk9EELyP+FLU4zAt
         DriOd5OmKTaHcAHKh05vwc5MDPQ/8pbrvvbN39npJ++CqyKVU6gPYcVU3GsYaNgEru4J
         Fdl5so0U2koKZmSUPg3zM7WznXZJ8fB6JvqPP9H/ME0rmHowE5RtO8Q7ckNyL5SSN2Uw
         Hi4vfrkDePFUOu+0JrqIZc/SAA3jCP2Bl00wumZtXYfNrUgoGq3C6CDGUbJ4I+xJi/su
         a0s4yLcn61yl1d53VtDBH/dLv/wGJUfHgsLT822QwmCSgNR8WJtNS2BDRoL6y3gw7pEN
         vghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rFYHv0l5UXfkDhPq1yvGt5C2xL6HmIDNEX6+RZLbAtE=;
        b=bSGc7PcM0n8zLsrsKDkuf7501rvsQnuvSufJTTG6McB4Wzqrqw2l0eJT4SVUrt3+SH
         lRNCbdnTbAYPTYS8hlu7U0yqrV7boxHvqVjeyIhn7OrdDVPtPi/IZMK1VsdbCmTb7NwP
         dRfz8CtLIgXFNx2mX3Vo2+9a3mJmrGaXj4le9kpcXMVK4xZDVbdENj89tJFi1osnw/tY
         o2LwYGFXXLk7Z4owcjvSHJZ8/gqkzR7lUEHOuRrhoFVMgttIWyW0sbXQbHg3GZT5L/YX
         7e87pRCTTnKenlG6+O1rRtAKKPb4n7kauPFgjfHe2FwYDfKSo5tRZRtAq7BDjl4Mbvi+
         WpmA==
X-Gm-Message-State: AIkVDXKPeuIXg7sh2y9ZzcYPjZp50MWz2cROehrfhMet34iRcx1icXNbvimma1Dn37ln2dZC
X-Received: by 10.55.220.3 with SMTP id v3mr70683635qki.37.1483665036070;
        Thu, 05 Jan 2017 17:10:36 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id r24sm1385264qkl.5.2017.01.05.17.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jan 2017 17:10:35 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org
Subject: [PATCH v2 2/4] t7610: make tests more independent and debuggable
Date:   Thu,  5 Jan 2017 20:09:43 -0500
Message-Id: <20170106010945.79382-3-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170106010945.79382-1-hansenr@google.com>
References: <20170104005042.51530-1-hansenr@google.com>
 <20170106010945.79382-1-hansenr@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="94eb2c0cc0ce780472054562aff3"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--94eb2c0cc0ce780472054562aff3

Reduce how much a test can interfere other tests:

  * Move setup code that multiple tests depend on to the 'setup' test
    case.
  * Run 'git reset --hard' after every test (pass or fail) to clean up
    in case the test fails and leaves the repository in a strange
    state.
  * If the repository must be in a particular state (beyond what is
    already done by the 'setup' test case) before the test can run,
    make the necessary repository changes in the test script even if
    it means duplicating some lines of code from the previous test
    case.
  * Never assume that a particular commit is checked out.
  * Always work on a test-specific branch when the test might create a
    commit.  This is not always necessary for correctness, but it
    improves debuggability by ensuring a commit created by test #N
    shows up on the testN branch, not the branch for test #N-1.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 146 +++++++++++++++++++++++++++++----------------------
 1 file changed, 84 insertions(+), 62 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 14090739f..2c06cf73f 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -55,6 +55,22 @@ test_expect_success 'setup' '
 	git rm file12 &&
 	git commit -m "branch1 changes" &&
 
+	git checkout -b delete-base branch1 &&
+	mkdir -p a/a &&
+	(echo one; echo two; echo 3; echo 4) >a/a/file.txt &&
+	git add a/a/file.txt &&
+	git commit -m"base file" &&
+	git checkout -b move-to-b delete-base &&
+	mkdir -p b/b &&
+	git mv a/a/file.txt b/b/file.txt &&
+	(echo one; echo two; echo 4) >b/b/file.txt &&
+	git commit -a -m"move to b" &&
+	git checkout -b move-to-c delete-base &&
+	mkdir -p c/c &&
+	git mv a/a/file.txt c/c/file.txt &&
+	(echo one; echo two; echo 3) >c/c/file.txt &&
+	git commit -a -m"move to c" &&
+
 	git checkout -b stash1 master &&
 	echo stash1 change file11 >file11 &&
 	git add file11 &&
@@ -86,6 +102,23 @@ test_expect_success 'setup' '
 	git rm file11 &&
 	git commit -m "master updates" &&
 
+	git clean -fdx &&
+	git checkout -b order-file-start master &&
+	echo start >a &&
+	echo start >b &&
+	git add a b &&
+	git commit -m start &&
+	git checkout -b order-file-side1 order-file-start &&
+	echo side1 >a &&
+	echo side1 >b &&
+	git add a b &&
+	git commit -m side1 &&
+	git checkout -b order-file-side2 order-file-start &&
+	echo side2 >a &&
+	echo side2 >b &&
+	git add a b &&
+	git commit -m side2 &&
+
 	git config merge.tool mytool &&
 	git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	git config mergetool.mytool.trustExitCode true &&
@@ -94,6 +127,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'custom mergetool' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
@@ -112,6 +146,7 @@ test_expect_success 'custom mergetool' '
 '
 
 test_expect_success 'mergetool crlf' '
+	test_when_finished "git reset --hard" &&
 	test_config core.autocrlf true &&
 	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
@@ -129,11 +164,11 @@ test_expect_success 'mergetool crlf' '
 	git submodule update -N &&
 	test "$(cat submod/bar)" = "master submodule" &&
 	git commit -m "branch1 resolved with mergetool - autocrlf" &&
-	test_config core.autocrlf false &&
-	git reset --hard
+	test_config core.autocrlf false
 '
 
 test_expect_success 'mergetool in subdir' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
@@ -145,8 +180,13 @@ test_expect_success 'mergetool in subdir' '
 '
 
 test_expect_success 'mergetool on file in parent dir' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
 	(
 		cd subdir &&
+		test_must_fail git merge master >/dev/null 2>&1 &&
+		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../both >/dev/null 2>&1 ) &&
@@ -161,6 +201,7 @@ test_expect_success 'mergetool on file in parent dir' '
 '
 
 test_expect_success 'mergetool skips autoresolved' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
@@ -169,11 +210,12 @@ test_expect_success 'mergetool skips autoresolved' '
 	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
 	output="$(git mergetool --no-prompt)" &&
-	test "$output" = "No files need merging" &&
-	git reset --hard
+	test "$output" = "No files need merging"
 '
 
 test_expect_success 'mergetool merges all from subdir' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
 	test_config rerere.enabled false &&
 	(
 		cd subdir &&
@@ -190,6 +232,7 @@ test_expect_success 'mergetool merges all from subdir' '
 '
 
 test_expect_success 'mergetool skips resolved paths when rerere is active' '
+	test_when_finished "git reset --hard" &&
 	test_config rerere.enabled true &&
 	rm -rf .git/rr-cache &&
 	git checkout -b test$test_count branch1 &&
@@ -199,11 +242,11 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
 	( yes "d" "d" | git mergetool --no-prompt >/dev/null 2>&1 ) &&
 	git submodule update -N &&
 	output="$(yes "n" | git mergetool --no-prompt)" &&
-	test "$output" = "No files need merging" &&
-	git reset --hard
+	test "$output" = "No files need merging"
 '
 
 test_expect_success 'conflicted stash sets up rerere'  '
+	test_when_finished "git reset --hard" &&
 	test_config rerere.enabled true &&
 	git checkout stash1 &&
 	echo "Conflicting stash content" >file11 &&
@@ -231,7 +274,7 @@ test_expect_success 'conflicted stash sets up rerere'  '
 '
 
 test_expect_success 'mergetool takes partial path' '
-	git reset --hard &&
+	test_when_finished "git reset --hard" &&
 	test_config rerere.enabled false &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
@@ -239,26 +282,12 @@ test_expect_success 'mergetool takes partial path' '
 
 	( yes "" | git mergetool subdir ) &&
 
-	test "$(cat subdir/file3)" = "master new sub" &&
-	git reset --hard
+	test "$(cat subdir/file3)" = "master new sub"
 '
 
 test_expect_success 'mergetool delete/delete conflict' '
-	git checkout -b delete-base branch1 &&
-	mkdir -p a/a &&
-	(echo one; echo two; echo 3; echo 4) >a/a/file.txt &&
-	git add a/a/file.txt &&
-	git commit -m"base file" &&
-	git checkout -b move-to-b delete-base &&
-	mkdir -p b/b &&
-	git mv a/a/file.txt b/b/file.txt &&
-	(echo one; echo two; echo 4) >b/b/file.txt &&
-	git commit -a -m"move to b" &&
-	git checkout -b move-to-c delete-base &&
-	mkdir -p c/c &&
-	git mv a/a/file.txt c/c/file.txt &&
-	(echo one; echo two; echo 3) >c/c/file.txt &&
-	git commit -a -m"move to c" &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count move-to-c &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
 	! test -f a/a/file.txt &&
@@ -269,29 +298,32 @@ test_expect_success 'mergetool delete/delete conflict' '
 	git reset --hard HEAD &&
 	test_must_fail git merge move-to-b &&
 	! echo a | git mergetool a/a/file.txt &&
-	! test -f a/a/file.txt &&
-	git reset --hard HEAD
+	! test -f a/a/file.txt
 '
 
 test_expect_success 'mergetool produces no errors when keepBackup is used' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepBackup true &&
 	test_must_fail git merge move-to-b &&
 	: >expect &&
 	echo d | git mergetool a/a/file.txt 2>actual &&
 	test_cmp expect actual &&
-	! test -d a &&
-	git reset --hard HEAD
+	! test -d a
 '
 
 test_expect_success 'mergetool honors tempfile config for deleted files' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries false &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
-	! test -d a &&
-	git reset --hard HEAD
+	! test -d a
 '
 
 test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
+	test_when_finished "git reset --hard; git clean -fdx" &&
+	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries true &&
 	test_must_fail git merge move-to-b &&
 	! (echo a; echo n) | git mergetool a/a/file.txt &&
@@ -302,12 +334,11 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 	file_REMOTE_.txt
 	EOF
 	ls -1 a/a | sed -e "s/[0-9]*//g" >actual &&
-	test_cmp expect actual &&
-	git clean -fdx &&
-	git reset --hard HEAD
+	test_cmp expect actual
 '
 
 test_expect_success 'deleted vs modified submodule' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
@@ -372,11 +403,11 @@ test_expect_success 'deleted vs modified submodule' '
 	test "$(cat submod/bar)" = "master submodule" &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
-	git commit -m "Merge resolved by keeping module" &&
-	git reset --hard HEAD
+	git commit -m "Merge resolved by keeping module"
 '
 
 test_expect_success 'file vs modified submodule' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
@@ -448,6 +479,7 @@ test_expect_success 'file vs modified submodule' '
 '
 
 test_expect_success 'submodule in subdirectory' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
@@ -509,6 +541,7 @@ test_expect_success 'submodule in subdirectory' '
 '
 
 test_expect_success 'directory vs modified submodule' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	mv submod submod-movedaside &&
 	git rm --cached submod &&
@@ -559,34 +592,34 @@ test_expect_success 'directory vs modified submodule' '
 '
 
 test_expect_success 'file with no base' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool mybase -- both &&
 	>expected &&
-	test_cmp both expected &&
-	git reset --hard master >/dev/null 2>&1
+	test_cmp both expected
 '
 
 test_expect_success 'custom commands override built-ins' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	test_config mergetool.defaults.trustExitCode true &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool defaults -- both &&
 	echo master both added >expected &&
-	test_cmp both expected &&
-	git reset --hard master >/dev/null 2>&1
+	test_cmp both expected
 '
 
 test_expect_success 'filenames seen by tools start with ./' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp false &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
-	grep ^\./both_LOCAL_ actual >/dev/null &&
-	git reset --hard master >/dev/null 2>&1
+	grep ^\./both_LOCAL_ actual >/dev/null
 '
 
 test_lazy_prereq MKTEMP '
@@ -595,6 +628,7 @@ test_lazy_prereq MKTEMP '
 '
 
 test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToTemp' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp true &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -602,31 +636,17 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
 	test_must_fail grep ^\./both_LOCAL_ actual >/dev/null &&
-	grep /both_LOCAL_ actual >/dev/null &&
-	git reset --hard master >/dev/null 2>&1
+	grep /both_LOCAL_ actual >/dev/null
 '
 
 test_expect_success 'diff.orderFile configuration is honored' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
 	echo b >order-file &&
 	echo a >>order-file &&
-	git checkout -b order-file-start master &&
-	echo start >a &&
-	echo start >b &&
-	git add a b &&
-	git commit -m start &&
-	git checkout -b order-file-side1 order-file-start &&
-	echo side1 >a &&
-	echo side1 >b &&
-	git add a b &&
-	git commit -m side1 &&
-	git checkout -b order-file-side2 order-file-start &&
-	echo side2 >a &&
-	echo side2 >b &&
-	git add a b &&
-	git commit -m side2 &&
 	test_must_fail git merge order-file-side1 &&
 	cat >expect <<-\EOF &&
 		Merging:
@@ -635,13 +655,16 @@ test_expect_success 'diff.orderFile configuration is honored' '
 	EOF
 	git mergetool --no-prompt --tool myecho >output &&
 	git grep --no-index -h -A2 Merging: output >actual &&
-	test_cmp expect actual &&
-	git reset --hard >/dev/null
+	test_cmp expect actual
 '
 test_expect_success 'mergetool -Oorder-file is honored' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
+	echo b >order-file &&
+	echo a >>order-file &&
 	test_must_fail git merge order-file-side1 &&
 	cat >expect <<-\EOF &&
 		Merging:
@@ -662,8 +685,7 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	EOF
 	git mergetool -Oorder-file --no-prompt --tool myecho >output &&
 	git grep --no-index -h -A2 Merging: output >actual &&
-	test_cmp expect actual &&
-	git reset --hard >/dev/null 2>&1
+	test_cmp expect actual
 '
 
 test_done
-- 
2.11.0.390.gc69c2f50cf-goog


--94eb2c0cc0ce780472054562aff3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS6QYJKoZIhvcNAQcCoIIS2jCCEtYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBPMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BgEFBQcwAoY0aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NodnNtaW1lY2Ex
LmNydDAdBgNVHQ4EFgQUbPFPDSp3rGDbNu3Pb8jJO+QTw0AwHwYDVR0jBBgwFoAUyzgSsMeZwHiS
jLMhleb0JmLA4D8wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2h2c21pbWVjYTEuY3JsMA4GA1UdDwEB/wQEAwIFoDAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAG7GEcPrcRoMakd1
k8cdl7NUgGsEGoTzcS1ASh1ZaKlEzGR0uHyB7QwpX1hSHCvUKMRAqe5vXqZWhVhiPNPc0792yPHo
K+K5sV1W+pF66TlYY/9qlz0IDyKlMRKyCkc77PdrXubuJjauu2WGnbDpHvVwLTqwwlR5O0OLig48
m4YUSo869xADdrGrWJ7KzroFbucLZYh3niIjVICp7fh9wtLgbX7X/akdubehYhy/l+AIMml6Zlyu
GNGCGIleyQ0bAdjjG+dKrDErUlui8wd/YplvelaTAzSvNpxcrr+2YB8UBWcYkgULkp5GDCC2guKl
rMF1mTS6N6GMxUi30sZicbMxggJeMIICWgIBATBcMEwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAxAgwvfEOc
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFDpuai58tlkp2f/YxNR
GUfmYLg2Uz8zziXJDS0WMlmmMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwNjAxMTAzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAc0hebCO79paREq8uH/X8RDnCFa02aq3OjuuXS
+FiQJ0dfjEVb5OrmmXO+yHLQEuniETTicqXrQPDFZV0RQHzdlkQ9EdQWMD0CqLcVcPtWrhpAaVfr
ZLxhko9fNLqQVZ0aXm+OvNMObsZuh1ooOoqOqWnCYBAv9YNO8LtcN2qUnmDIS3xHXAK8S5tzK1sH
BmvIHvIdTqMtRq5Hy5pCaHBbVuU9bRxs1AO9jsvCJg58NgwL6aRjGiiZ9f0huqRg3PepvOg3RXud
8nEXmVFyL4/ZelelKx9nflnLpt0xpTEG1Mw2fs7xzD+lG2eXBs/MlpksWSSCkLJY3DXLIqIp03N9
--94eb2c0cc0ce780472054562aff3--
