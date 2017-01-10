Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8748C1FEB3
	for <e@80x24.org>; Tue, 10 Jan 2017 01:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161942AbdAJBqC (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 20:46:02 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36282 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031991AbdAJBpz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 20:45:55 -0500
Received: by mail-pf0-f178.google.com with SMTP id 189so24727151pfu.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 17:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bMMJ38o765WqIsMT7QLpvKZ8xTr4ktKPLz88TwsOwyc=;
        b=o1jC819kxwZYRPUpXecLcmNkzDo6Pe68tmBhvYR1b2ufyfzbC+P3ptkDde4/7LURd3
         5OtF5UW2kHm4jV8tZltXyzRc6ajH1xdSbtlvuR0j/fdsDJAatPPSEGbZbY0873XFLaxX
         f9HaC48+ZtznKv3GrVz00Hc42uWqxclS5o0KujKG6Zkr8rgUaEXEUjOihUQOuDcrnAUS
         6yuRmtID398/5vKl0X26JBV08dmvRmVpe3i8ljX6wX0ddFGvh+HqhuQudnz/Ta5VdI7p
         lQqDmFuGxchGQEfzm/ybGC2WkzbVMr/TIHhSdMXACPgcr4vlGYztrrowA0j0lEuNVyWt
         rrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bMMJ38o765WqIsMT7QLpvKZ8xTr4ktKPLz88TwsOwyc=;
        b=mLM2rF2gZTE2Um1XFGEjztaUV9eg3FsFfl6/0OkgJkS7yIw6gVWogXKpfzHW/Uhk+i
         5rsknheWSuxpPZB4ViOOXhI2OQcaiHWwegZ88Iovdi6UWYQeiowQOkQ0HLpssX6qwLT8
         Wm0WJgq1HQimsRhtanBspxDP2FpaszzzM52F3gyJYTH3GGYaB0Xdxu2HGaW4Sy2zZK7l
         MIIUHgeyOGxF9uHxoLQr6GSKy6c3Fa0CDiQHR7JjjxxPtP3PPz+yYTmskU08CT4rNDhu
         9EDxGYxhXqMHUQbFdGqSfUreEXU0E0FczQfTG2+yDc7ITTRZo0nGNcsiYCw0cYIluauA
         sdPQ==
X-Gm-Message-State: AIkVDXJGnje4Nz/R8twFLVzzYvMgCm3QaZtMoz0J6IJGlgFpE3kmAWw9lxwkzjmZL01iWE7/
X-Received: by 10.98.75.156 with SMTP id d28mr817688pfj.59.1484012754718;
        Mon, 09 Jan 2017 17:45:54 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1e2:be00:4066:92e5])
        by smtp.gmail.com with ESMTPSA id d69sm403709pfd.11.2017.01.09.17.45.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 17:45:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, novalis@novalis.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] t1000: modernize style
Date:   Mon,  9 Jan 2017 17:45:40 -0800
Message-Id: <20170110014542.19352-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
In-Reply-To: <20170110014542.19352-1-sbeller@google.com>
References: <20170110014542.19352-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The preferred style in tests seems to be

test_expect_success 'short description, ended by 2 single quotes' '
	here comes the test &&
	and chains over many lines &&
	ended by a quote
'

Or going by the numbers:
    $ git -C t/ grep "' '$" | wc -l
    9796
    $ git -C t/ grep test_expect_ |wc -l
    11861

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t1000-read-tree-m-3way.sh | 648 +++++++++++++++++++++-----------------------
 1 file changed, 315 insertions(+), 333 deletions(-)

diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index a0b79b4839..3c4d2d6045 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -128,29 +128,29 @@ cat >expected <<\EOF
 EOF
 
 check_result () {
-    git ls-files --stage | sed -e 's/ '"$_x40"' / X /' >current &&
-    test_cmp expected current
+	git ls-files --stage | sed -e 's/ '"$_x40"' / X /' >current &&
+	test_cmp expected current
 }
 
 # This is done on an empty work directory, which is the normal
 # merge person behaviour.
-test_expect_success \
-    '3-way merge with git read-tree -m, empty cache' \
-    "rm -fr [NDMALTS][NDMALTSF] Z &&
-     rm .git/index &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
+test_expect_success '3-way merge with git read-tree -m, empty cache' '
+	rm -fr [NDMALTS][NDMALTSF] Z &&
+	rm .git/index &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
 
 # This starts out with the first head, which is the normal
 # patch submitter behaviour.
-test_expect_success \
-    '3-way merge with git read-tree -m, match H' \
-    "rm -fr [NDMALTS][NDMALTSF] Z &&
-     rm .git/index &&
-     read_tree_must_succeed $tree_A &&
-     git checkout-index -f -u -a &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
+test_expect_success '3-way merge with git read-tree -m, match H' '
+	rm -fr [NDMALTS][NDMALTSF] Z &&
+	rm .git/index &&
+	read_tree_must_succeed $tree_A &&
+	git checkout-index -f -u -a &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
 
 : <<\END_OF_CASE_TABLE
 
@@ -208,322 +208,304 @@ DF (file) when tree B require DF to be a directory by having DF/DF
 
 END_OF_CASE_TABLE
 
-test_expect_success '1 - must not have an entry not in A.' "
-     rm -f .git/index XX &&
-     echo XX >XX &&
-     git update-index --add XX &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '2 - must match B in !O && !A && B case.' \
-    "rm -f .git/index NA &&
-     cp .orig-B/NA NA &&
-     git update-index --add NA &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B"
-
-test_expect_success \
-    '2 - matching B alone is OK in !O && !A && B case.' \
-    "rm -f .git/index NA &&
-     cp .orig-B/NA NA &&
-     git update-index --add NA &&
-     echo extra >>NA &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B"
-
-test_expect_success \
-    '3 - must match A in !O && A && !B case.' \
-    "rm -f .git/index AN &&
-     cp .orig-A/AN AN &&
-     git update-index --add AN &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '3 - matching A alone is OK in !O && A && !B case.' \
-    "rm -f .git/index AN &&
-     cp .orig-A/AN AN &&
-     git update-index --add AN &&
-     echo extra >>AN &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B"
-
-test_expect_success \
-    '3 (fail) - must match A in !O && A && !B case.' "
-     rm -f .git/index AN &&
-     cp .orig-A/AN AN &&
-     echo extra >>AN &&
-     git update-index --add AN &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '4 - must match and be up-to-date in !O && A && B && A!=B case.' \
-    "rm -f .git/index AA &&
-     cp .orig-A/AA AA &&
-     git update-index --add AA &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '4 (fail) - must match and be up-to-date in !O && A && B && A!=B case.' "
-     rm -f .git/index AA &&
-     cp .orig-A/AA AA &&
-     git update-index --add AA &&
-     echo extra >>AA &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '4 (fail) - must match and be up-to-date in !O && A && B && A!=B case.' "
-     rm -f .git/index AA &&
-     cp .orig-A/AA AA &&
-     echo extra >>AA &&
-     git update-index --add AA &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '5 - must match in !O && A && B && A==B case.' \
-    "rm -f .git/index LL &&
-     cp .orig-A/LL LL &&
-     git update-index --add LL &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '5 - must match in !O && A && B && A==B case.' \
-    "rm -f .git/index LL &&
-     cp .orig-A/LL LL &&
-     git update-index --add LL &&
-     echo extra >>LL &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '5 (fail) - must match A in !O && A && B && A==B case.' "
-     rm -f .git/index LL &&
-     cp .orig-A/LL LL &&
-     echo extra >>LL &&
-     git update-index --add LL &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '6 - must not exist in O && !A && !B case' "
-     rm -f .git/index DD &&
-     echo DD >DD &&
-     git update-index --add DD &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '7 - must not exist in O && !A && B && O!=B case' "
-     rm -f .git/index DM &&
-     cp .orig-B/DM DM &&
-     git update-index --add DM &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '8 - must not exist in O && !A && B && O==B case' "
-     rm -f .git/index DN &&
-     cp .orig-B/DN DN &&
-     git update-index --add DN &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '9 - must match and be up-to-date in O && A && !B && O!=A case' \
-    "rm -f .git/index MD &&
-     cp .orig-A/MD MD &&
-     git update-index --add MD &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '9 (fail) - must match and be up-to-date in O && A && !B && O!=A case' "
-     rm -f .git/index MD &&
-     cp .orig-A/MD MD &&
-     git update-index --add MD &&
-     echo extra >>MD &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '9 (fail) - must match and be up-to-date in O && A && !B && O!=A case' "
-     rm -f .git/index MD &&
-     cp .orig-A/MD MD &&
-     echo extra >>MD &&
-     git update-index --add MD &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '10 - must match and be up-to-date in O && A && !B && O==A case' \
-    "rm -f .git/index ND &&
-     cp .orig-A/ND ND &&
-     git update-index --add ND &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '10 (fail) - must match and be up-to-date in O && A && !B && O==A case' "
-     rm -f .git/index ND &&
-     cp .orig-A/ND ND &&
-     git update-index --add ND &&
-     echo extra >>ND &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '10 (fail) - must match and be up-to-date in O && A && !B && O==A case' "
-     rm -f .git/index ND &&
-     cp .orig-A/ND ND &&
-     echo extra >>ND &&
-     git update-index --add ND &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '11 - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' \
-    "rm -f .git/index MM &&
-     cp .orig-A/MM MM &&
-     git update-index --add MM &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '11 (fail) - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' "
-     rm -f .git/index MM &&
-     cp .orig-A/MM MM &&
-     git update-index --add MM &&
-     echo extra >>MM &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '11 (fail) - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' "
-     rm -f .git/index MM &&
-     cp .orig-A/MM MM &&
-     echo extra >>MM &&
-     git update-index --add MM &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '12 - must match A in O && A && B && O!=A && A==B case' \
-    "rm -f .git/index SS &&
-     cp .orig-A/SS SS &&
-     git update-index --add SS &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '12 - must match A in O && A && B && O!=A && A==B case' \
-    "rm -f .git/index SS &&
-     cp .orig-A/SS SS &&
-     git update-index --add SS &&
-     echo extra >>SS &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '12 (fail) - must match A in O && A && B && O!=A && A==B case' "
-     rm -f .git/index SS &&
-     cp .orig-A/SS SS &&
-     echo extra >>SS &&
-     git update-index --add SS &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '13 - must match A in O && A && B && O!=A && O==B case' \
-    "rm -f .git/index MN &&
-     cp .orig-A/MN MN &&
-     git update-index --add MN &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '13 - must match A in O && A && B && O!=A && O==B case' \
-    "rm -f .git/index MN &&
-     cp .orig-A/MN MN &&
-     git update-index --add MN &&
-     echo extra >>MN &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '14 - must match and be up-to-date in O && A && B && O==A && O!=B case' \
-    "rm -f .git/index NM &&
-     cp .orig-A/NM NM &&
-     git update-index --add NM &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '14 - may match B in O && A && B && O==A && O!=B case' \
-    "rm -f .git/index NM &&
-     cp .orig-B/NM NM &&
-     git update-index --add NM &&
-     echo extra >>NM &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '14 (fail) - must match and be up-to-date in O && A && B && O==A && O!=B case' "
-     rm -f .git/index NM &&
-     cp .orig-A/NM NM &&
-     git update-index --add NM &&
-     echo extra >>NM &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '14 (fail) - must match and be up-to-date in O && A && B && O==A && O!=B case' "
-     rm -f .git/index NM &&
-     cp .orig-A/NM NM &&
-     echo extra >>NM &&
-     git update-index --add NM &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-test_expect_success \
-    '15 - must match A in O && A && B && O==A && O==B case' \
-    "rm -f .git/index NN &&
-     cp .orig-A/NN NN &&
-     git update-index --add NN &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '15 - must match A in O && A && B && O==A && O==B case' \
-    "rm -f .git/index NN &&
-     cp .orig-A/NN NN &&
-     git update-index --add NN &&
-     echo extra >>NN &&
-     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
-     check_result"
-
-test_expect_success \
-    '15 (fail) - must match A in O && A && B && O==A && O==B case' "
-     rm -f .git/index NN &&
-     cp .orig-A/NN NN &&
-     echo extra >>NN &&
-     git update-index --add NN &&
-     read_tree_must_fail -m $tree_O $tree_A $tree_B
-"
-
-# #16
-test_expect_success \
-    '16 - A matches in one and B matches in another.' \
-    'rm -f .git/index F16 &&
-    echo F16 >F16 &&
-    git update-index --add F16 &&
-    tree0=$(git write-tree) &&
-    echo E16 >F16 &&
-    git update-index F16 &&
-    tree1=$(git write-tree) &&
-    read_tree_must_succeed -m $tree0 $tree1 $tree1 $tree0 &&
-    git ls-files --stage'
+test_expect_success '1 - must not have an entry not in A.' '
+	rm -f .git/index XX &&
+	echo XX >XX &&
+	git update-index --add XX &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '2 - must match B in !O && !A && B case.' '
+	rm -f .git/index NA &&
+	cp .orig-B/NA NA &&
+	git update-index --add NA &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '2 - matching B alone is OK in !O && !A && B case.' '
+	rm -f .git/index NA &&
+	cp .orig-B/NA NA &&
+	git update-index --add NA &&
+	echo extra >>NA &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '3 - must match A in !O && A && !B case.' '
+	rm -f .git/index AN &&
+	cp .orig-A/AN AN &&
+	git update-index --add AN &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '3 - matching A alone is OK in !O && A && !B case.' '
+	rm -f .git/index AN &&
+	cp .orig-A/AN AN &&
+	git update-index --add AN &&
+	echo extra >>AN &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '3 (fail) - must match A in !O && A && !B case.' '
+	rm -f .git/index AN &&
+	cp .orig-A/AN AN &&
+	echo extra >>AN &&
+	git update-index --add AN &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '4 - must match and be up-to-date in !O && A && B && A!=B case.' '
+	rm -f .git/index AA &&
+	cp .orig-A/AA AA &&
+	git update-index --add AA &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '4 (fail) - must match and be up-to-date in !O && A && B && A!=B case.' '
+	rm -f .git/index AA &&
+	cp .orig-A/AA AA &&
+	git update-index --add AA &&
+	echo extra >>AA &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '4 (fail) - must match and be up-to-date in !O && A && B && A!=B case.' '
+	rm -f .git/index AA &&
+	cp .orig-A/AA AA &&
+	echo extra >>AA &&
+	git update-index --add AA &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '5 - must match in !O && A && B && A==B case.' '
+	rm -f .git/index LL &&
+	cp .orig-A/LL LL &&
+	git update-index --add LL &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '5 - must match in !O && A && B && A==B case.' '
+	rm -f .git/index LL &&
+	cp .orig-A/LL LL &&
+	git update-index --add LL &&
+	echo extra >>LL &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '5 (fail) - must match A in !O && A && B && A==B case.' '
+	rm -f .git/index LL &&
+	cp .orig-A/LL LL &&
+	echo extra >>LL &&
+	git update-index --add LL &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '6 - must not exist in O && !A && !B case' '
+	rm -f .git/index DD &&
+	echo DD >DD &&
+	git update-index --add DD &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '7 - must not exist in O && !A && B && O!=B case' '
+	rm -f .git/index DM &&
+	cp .orig-B/DM DM &&
+	git update-index --add DM &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '8 - must not exist in O && !A && B && O==B case' '
+	rm -f .git/index DN &&
+	cp .orig-B/DN DN &&
+	git update-index --add DN &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '9 - must match and be up-to-date in O && A && !B && O!=A case' '
+	rm -f .git/index MD &&
+	cp .orig-A/MD MD &&
+	git update-index --add MD &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '9 (fail) - must match and be up-to-date in O && A && !B && O!=A case' '
+	rm -f .git/index MD &&
+	cp .orig-A/MD MD &&
+	git update-index --add MD &&
+	echo extra >>MD &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '9 (fail) - must match and be up-to-date in O && A && !B && O!=A case' '
+	rm -f .git/index MD &&
+	cp .orig-A/MD MD &&
+	echo extra >>MD &&
+	git update-index --add MD &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '10 - must match and be up-to-date in O && A && !B && O==A case' '
+	rm -f .git/index ND &&
+	cp .orig-A/ND ND &&
+	git update-index --add ND &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '10 (fail) - must match and be up-to-date in O && A && !B && O==A case' '
+	rm -f .git/index ND &&
+	cp .orig-A/ND ND &&
+	git update-index --add ND &&
+	echo extra >>ND &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '10 (fail) - must match and be up-to-date in O && A && !B && O==A case' '
+	rm -f .git/index ND &&
+	cp .orig-A/ND ND &&
+	echo extra >>ND &&
+	git update-index --add ND &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '11 - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' '
+	rm -f .git/index MM &&
+	cp .orig-A/MM MM &&
+	git update-index --add MM &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '11 (fail) - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' '
+	rm -f .git/index MM &&
+	cp .orig-A/MM MM &&
+	git update-index --add MM &&
+	echo extra >>MM &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '11 (fail) - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' '
+	rm -f .git/index MM &&
+	cp .orig-A/MM MM &&
+	echo extra >>MM &&
+	git update-index --add MM &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '12 - must match A in O && A && B && O!=A && A==B case' '
+	rm -f .git/index SS &&
+	cp .orig-A/SS SS &&
+	git update-index --add SS &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '12 - must match A in O && A && B && O!=A && A==B case' '
+	rm -f .git/index SS &&
+	cp .orig-A/SS SS &&
+	git update-index --add SS &&
+	echo extra >>SS &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '12 (fail) - must match A in O && A && B && O!=A && A==B case' '
+	rm -f .git/index SS &&
+	cp .orig-A/SS SS &&
+	echo extra >>SS &&
+	git update-index --add SS &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '13 - must match A in O && A && B && O!=A && O==B case' '
+	rm -f .git/index MN &&
+	cp .orig-A/MN MN &&
+	git update-index --add MN &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '13 - must match A in O && A && B && O!=A && O==B case' '
+	rm -f .git/index MN &&
+	cp .orig-A/MN MN &&
+	git update-index --add MN &&
+	echo extra >>MN &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '14 - must match and be up-to-date in O && A && B && O==A && O!=B case' '
+	rm -f .git/index NM &&
+	cp .orig-A/NM NM &&
+	git update-index --add NM &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '14 - may match B in O && A && B && O==A && O!=B case' '
+	rm -f .git/index NM &&
+	cp .orig-B/NM NM &&
+	git update-index --add NM &&
+	echo extra >>NM &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '14 (fail) - must match and be up-to-date in O && A && B && O==A && O!=B case' '
+	rm -f .git/index NM &&
+	cp .orig-A/NM NM &&
+	git update-index --add NM &&
+	echo extra >>NM &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '14 (fail) - must match and be up-to-date in O && A && B && O==A && O!=B case' '
+	rm -f .git/index NM &&
+	cp .orig-A/NM NM &&
+	echo extra >>NM &&
+	git update-index --add NM &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '15 - must match A in O && A && B && O==A && O==B case' '
+	rm -f .git/index NN &&
+	cp .orig-A/NN NN &&
+	git update-index --add NN &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '15 - must match A in O && A && B && O==A && O==B case' '
+	rm -f .git/index NN &&
+	cp .orig-A/NN NN &&
+	git update-index --add NN &&
+	echo extra >>NN &&
+	read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
+	check_result
+'
+
+test_expect_success '15 (fail) - must match A in O && A && B && O==A && O==B case' '
+	rm -f .git/index NN &&
+	cp .orig-A/NN NN &&
+	echo extra >>NN &&
+	git update-index --add NN &&
+	read_tree_must_fail -m $tree_O $tree_A $tree_B
+'
+
+test_expect_success '16 - A matches in one and B matches in another.' '
+	rm -f .git/index F16 &&
+	echo F16 >F16 &&
+	git update-index --add F16 &&
+	tree0=$(git write-tree) &&
+	echo E16 >F16 &&
+	git update-index F16 &&
+	tree1=$(git write-tree) &&
+	read_tree_must_succeed -m $tree0 $tree1 $tree1 $tree0 &&
+	git ls-files --stage
+'
 
 test_done
-- 
2.11.0.rc2.30.g7c4be45.dirty

