Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C27C43460
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D07961454
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbhDUO7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243722AbhDUO7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:59:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC48C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n4-20020a05600c4f84b029013151278decso1395874wmq.4
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7G1Mzbi4o74nyXO8mzA2M3o4XSGGiDAtZ8/sn4OkYQ=;
        b=ngQnG9zN+VQDxRFpdS+e87ywqM0vLVivFRcg5EnQWnf4CCrUWqHrP5t+GwFE5GBSPU
         QaqDHnJMcCgfnpoTn0W0AQJpnsCBw5GB865YFs9AkaFxNtavIuNsxquyA+7uEiYCRdDG
         TL8kSEv+UnhXHNiL6akvsa4Y8INMm9gpzwMb7qvea8MTS7Lhw1yDUwow6GPBs47oEbuA
         9CWOtCLFk40ta+CtKD+eB0GnAyh2P8rNzLH2eo2WX9vwO0nUGMzP9Or/JayjbtodCf3L
         3XIS6GXX1DnzD5CJP79SmCCSZrga8SmIcy5n7pxj7OJmIDtHR19WTeGzB4sAk5EDoEEj
         qHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7G1Mzbi4o74nyXO8mzA2M3o4XSGGiDAtZ8/sn4OkYQ=;
        b=h690Pt7q8DMhzG2AW2NvzRf0D0EYkp0M2A7idxe8j8oXZxYTknvKFzt0ZnvNb65KdM
         fIb1SB+iDnOEQwbXziVPaIYRpfPrb64M9tJCRvb82a83EzfvcFDNdQWuiQVLqJk2ZRz6
         FHRCJILkcq3eCn0QLxLcgFzFNkD1iVHPqmmwww3jg8I72HrJwI7g6xpyqmMXyrhkL6vT
         H3ZyQyN7I6MaBwr+5E+NhFYw6MR6yjAp325nCG5MYRkONXrZZAOTfIXkrZfxP8Du6G/y
         palfC8fsDe04lcUOXjHoqHxO5ymzLm2oRkCFztnCPN3a/A0uZAKsm2uM6jP+HbzisexJ
         ZXCQ==
X-Gm-Message-State: AOAM5304Aw9be1A6swIpU476rPsMg+hpfXMvSQHbxXN1LosLtGU5QbOT
        55LVDfbit3txrN8DRsxmutn9f0DSHFHdPw==
X-Google-Smtp-Source: ABdhPJyNVfwFelhFcaC4A2y2BU3qq6kqLky7wqX4gJySQRa0pI03HiEhx+PkkjRJulRQHe21vcWmKA==
X-Received: by 2002:a05:600c:3397:: with SMTP id o23mr10037322wmp.26.1619017122667;
        Wed, 21 Apr 2021 07:58:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm3394316wrd.69.2021.04.21.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:58:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] Revert and amend "test-lib-functions: assert correct parameter count"
Date:   Wed, 21 Apr 2021 16:58:35 +0200
Message-Id: <patch-2.5-5f8e5ad27f5-20210421T144921Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.g9a7f2f961d4
In-Reply-To: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com> <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts and amends my my own e7884b353b7 (test-lib-functions:
assert correct parameter count, 2021-02-12) in order to improve the -x
output.

The goal here is to get rid of the verbosity of having e.g. a "test 2
-ne 2" line for every "test_cmp". We use "$@" as an argument to "test"
to intentionally feed the "test" operator too many arguments if the
functions are called with too many arguments, thus piggy-backing on it
to check the number of arguments we get.

Before this for each test_cmp invocation we'd emit:

    + test_cmp expect actual
    + test 2 -ne 2
    + eval diff -u "$@"
    + diff -u expect actual

That "test 2 -ne 2" line is new in my e7884b353b7. As noted in
45a2686441b (test-lib-functions: remove bug-inducing "diagnostics"
helper param, 2021-02-12) we had buggy invocations of some of these
functions with too many parameters.

Now we'll get just:

    + test_cmp expect actual
    + eval diff -u "$@"
    + diff -u expect actual

This does not to the "right" thing in cases like:

    test_path_is_file x -a y

Which will now turn into:

    test -f x -a y

I consider that to be OK given the trade-off that any extra checking
would produce more verbose trace output. As shown in 45a2686441b we
had issues with these functions being invoked with multiple
parameters (e.g. a glob) by accident, we don't need to be paranoid in
guarding against hostile misuse from our own test suite.

While I'm at it change a few functions that relied on a "false" being
the last statement in the function to use an explicit "return 1" like
the other functions in this file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 59 +++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0232cc9f46d..f8f5bf9de1e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -756,41 +756,43 @@ test_external_without_stderr () {
 }
 
 # debugging-friendly alternatives to "test [-f|-d|-e]"
-# The commands test the existence or non-existence of $1
+# The commands test the existence or non-existence of
+# a given argument.
+#
+# The pattern of using "$@" to "test" instead of "$1" is not a bug. We
+# are counting on "test" to error on too many arguments if more than
+# one is given. Checking "$#" explicitly would lead to overly verbose
+# -x output.
 test_path_is_file () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -f "$1"
+	if ! test -f "$@"
 	then
-		echo "File $1 doesn't exist"
-		false
+		echo "File $* doesn't exist"
+		return 1
 	fi
 }
 
 test_path_is_dir () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -d "$1"
+	if ! test -d "$@"
 	then
-		echo "Directory $1 doesn't exist"
-		false
+		echo "Directory $* doesn't exist"
+		return 1
 	fi
 }
 
 test_path_exists () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -e "$1"
+	if ! test -e "$@"
 	then
-		echo "Path $1 doesn't exist"
-		false
+		echo "Path $* doesn't exist"
+		return 1
 	fi
 }
 
 # Check if the directory exists and is empty as expected, barf otherwise.
 test_dir_is_empty () {
-	test "$#" -ne 1 && BUG "1 param"
-	test_path_is_dir "$1" &&
-	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	test_path_is_dir "$@" &&
+	if test -n "$(ls -a1 "$@" | egrep -v '^\.\.?$')"
 	then
-		echo "Directory '$1' is not empty, it contains:"
+		echo "Directory '$*' is not empty, it contains:"
 		ls -la "$1"
 		return 1
 	fi
@@ -798,19 +800,17 @@ test_dir_is_empty () {
 
 # Check if the file exists and has a size greater than zero
 test_file_not_empty () {
-	test "$#" = 2 && BUG "2 param"
-	if ! test -s "$1"
+	if ! test -s "$@"
 	then
-		echo "'$1' is not a non-empty file."
-		false
+		echo "'$*' is not a non-empty file."
+		return 1
 	fi
 }
 
 test_path_is_missing () {
-	test "$#" -ne 1 && BUG "1 param"
-	if test -e "$1"
+	if test -e "$@"
 	then
-		echo "Path $1 exists!"
+		echo "Path $* exists!"
 		false
 	fi
 }
@@ -1012,7 +1012,6 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp () {
-	test "$#" -ne 2 && BUG "2 param"
 	eval "$GIT_TEST_CMP" '"$@"'
 }
 
@@ -1042,7 +1041,6 @@ test_cmp_config () {
 # test_cmp_bin - helper to compare binary files
 
 test_cmp_bin () {
-	test "$#" -ne 2 && BUG "2 param"
 	cmp "$@"
 }
 
@@ -1103,12 +1101,11 @@ verbose () {
 # otherwise.
 
 test_must_be_empty () {
-	test "$#" -ne 1 && BUG "1 param"
-	test_path_is_file "$1" &&
-	if test -s "$1"
+	test_path_is_file "$@" &&
+	if test -s "$@"
 	then
-		echo "'$1' is not empty, it contains:"
-		cat "$1"
+		echo "'$*' is not empty, it contains:"
+		cat "$@"
 		return 1
 	fi
 }
-- 
2.31.1.721.gbeb6a21927

