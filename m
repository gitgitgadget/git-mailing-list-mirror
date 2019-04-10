Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D5C20248
	for <e@80x24.org>; Wed, 10 Apr 2019 02:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfDJCNP (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 22:13:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36378 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJCNP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 22:13:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so390608plb.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 19:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QHITU3saHrz6FKalxeyHDbDq0zATq6MwsUSWFfoZ3Fs=;
        b=cDCI81w/nKDI+G+nB6sado1p8pBbqTEpofkrsFdk1IDlT/q6sIwHUn6x7CL4FTNqD9
         57L12ffkr9wBLnm+l4wjNE4X8UE3et+Cb/LLuEHRjQhwz045TgGdiIhJ8deKt74aK6X5
         4SP8i7nHEIv//Gl1WRhylZW31kDe952DyfwRbAqrfJhFzv66w2+asTWp9c0XkrKuNgiq
         O7+E+fYkhjVMXDSUgUJwqzfdGea8G6mKL8bCVvvQ1OvJwGNHMm+pGoEBEqf7DrXN/5yX
         n2caZJ3Sh/CAPjsBUej/wifp6AYs6UkF0FrSxDWLPodcDPxXukOFbFHgdaUwze6OA7BO
         ONLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QHITU3saHrz6FKalxeyHDbDq0zATq6MwsUSWFfoZ3Fs=;
        b=izBnrM5Q/UGPuS8oTpMhfuFoUw86HqjvAHUERxG0+ZIzwGwBooGljFE4BUghUrMgJc
         buQmwMQy2e+V8Xa5sznT7vMj+tTEKiInfr0uqzMuPUV2g7x6DFcabfxioMGkO/UdH4AI
         J9eEFCNGAC9mpXHy2Qa820FwFGWpEWcOz58Zl2ecHRO284Ty8laYAjIhV5xnWZy/MH4M
         meHPfFH9sGF+6p7MUeNI07TsMToW2xDc9jvuvQ1ua/ro032jjdERIi92xKfeoW00zKQg
         ho0bNqcoDG9yUkkMgamO3pSrQjgW5lOR5bW7kVGhb0gmZE5gscEGV34yv8DfkH1xxw5k
         hGIg==
X-Gm-Message-State: APjAAAWlkn5lvgmFPHd1/CIluTuUP3CcrnVTBnyJ6uZl8mq743IxE/Kf
        yEfp2cGYPzYI/mNrVBKOJLQLVFS1LlrB8dci
X-Google-Smtp-Source: APXvYqwYCIWuCnGlDwE1LeOifz7tsMAcJ8Ea2N/0o5Sc2N4ycvvJXIpg4Iv5Vy04rUx1Ta1SFHKCNg==
X-Received: by 2002:a17:902:820e:: with SMTP id x14mr40774954pln.207.1554862392830;
        Tue, 09 Apr 2019 19:13:12 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:c47d:9491:9418:887])
        by smtp.gmail.com with ESMTPSA id y37sm48546862pgk.78.2019.04.09.19.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:13:12 -0700 (PDT)
Date:   Tue, 9 Apr 2019 19:13:11 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2 1/7] t: move 'hex2oct' into test-lib-functions.sh
Message-ID: <f09c374557070b286391f1f69c4288d7d0769851.1554861974.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
 <cover.1554861974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554861974.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The helper 'hex2oct' is used to convert base-16 encoded data into a
base-8 binary form, and is useful for preparing data for commands that
accept input in a binary format, such as 'git hash-object', via
'printf'.

This helper is defined identically in three separate places throughout
't'. Move the definition to test-lib-function.sh, so that it can be used
in new test suites, and its definition is not redundant.

This will likewise make our job easier in the subsequent commit, which
also uses 'hex2oct'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t1007-hash-object.sh  | 4 ----
 t/t1450-fsck.sh         | 4 ----
 t/t5601-clone.sh        | 4 ----
 t/test-lib-functions.sh | 6 ++++++
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index a37753047e..7099d33508 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -199,10 +199,6 @@ test_expect_success 'too-short tree' '
 	test_i18ngrep "too-short tree object" err
 '
 
-hex2oct() {
-    perl -ne 'printf "\\%03o", hex for /../g'
-}
-
 test_expect_success 'malformed mode in tree' '
 	hex_sha1=$(echo foo | git hash-object --stdin -w) &&
 	bin_sha1=$(echo $hex_sha1 | hex2oct) &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 49f08d5b9c..0f268a3664 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -256,10 +256,6 @@ test_expect_success 'unparseable tree object' '
 	test_i18ngrep ! "fatal: empty filename in tree entry" out
 '
 
-hex2oct() {
-	perl -ne 'printf "\\%03o", hex for /../g'
-}
-
 test_expect_success 'tree entry with type mismatch' '
 	test_when_finished "remove_object \$blob" &&
 	test_when_finished "remove_object \$tree" &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d6948cbdab..3f49943010 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -611,10 +611,6 @@ test_expect_success 'GIT_TRACE_PACKFILE produces a usable pack' '
 	git -C replay.git index-pack -v --stdin <tmp.pack
 '
 
-hex2oct () {
-	perl -ne 'printf "\\%03o", hex for /../g'
-}
-
 test_expect_success 'clone on case-insensitive fs' '
 	git init icasefs &&
 	(
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 80402a428f..349eabe851 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1202,6 +1202,12 @@ depacketize () {
 	'
 }
 
+# Converts base-16 data into base-8. The output is given as a sequence of
+# escaped octals, suitable for consumption by 'printf'.
+hex2oct () {
+	perl -ne 'printf "\\%03o", hex for /../g'
+}
+
 # Set the hash algorithm in use to $1.  Only useful when testing the testsuite.
 test_set_hash () {
 	test_hash_algo="$1"
-- 
2.21.0.203.g358da99528

