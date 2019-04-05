Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD8220248
	for <e@80x24.org>; Fri,  5 Apr 2019 03:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfDEDho (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 23:37:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44520 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfDEDho (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 23:37:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so2241411pll.11
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 20:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QHITU3saHrz6FKalxeyHDbDq0zATq6MwsUSWFfoZ3Fs=;
        b=yPly15uiTvRfAIcYFf4yHFtKFJFLMr7b6raIvSyNw8lMBNwkpYVist3uG7AZObyOEG
         jhq1pWcHvoHtCwrj0Dwb6Hvsl5mOivB270e5JvxhzOuMkWk9MmjDcZ+m6uRrVv/7jXl3
         HF8r/9+e2hUINuiqyEH6WSWP5rtVWt9rQGg+7RvkmkUEVuCe+9j7rra8Rgb5yu+iWsW+
         xc62ozWuYgzV/+bOOQTPObD9WOF/pTlc8V3lCqu7vcjadFB6KcUfwJ10RTjQM+aICgbt
         QQGb5F0lVxsHXJvCXW6riUkn1MNekrDvCGnY7eFICPvnlb0jBCQ21scUuN6O5VMdbQve
         COVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QHITU3saHrz6FKalxeyHDbDq0zATq6MwsUSWFfoZ3Fs=;
        b=PQOlo4PafPu1o0Vj4tYbUkMCfLE6hYTq3jHiHsxG+MSdICXP+wbxlXZoqaX3Qf/7h4
         hjfoyXkqDAkMNKGyzLURZQ7ObF4zdJJSIOa/5pdqiuIiEdB59e0OjtVhgdqvHvGUk+a+
         z/npJKkUiYhM3WBTix5hatJwFsYVkStzEFp1UJzLo4vmvN4xZNMu9BYGrFvX3guRu8DN
         ArfoVdsqGkY+j2b0FN4l0z6KuiOm8TMfvm9FkpghzlX7m8FWxg+UR2vN3p+Tf7HL5tmp
         q5u/ORrbZZ0Yz4EOcRKobaCNoQV4aE4otFg6hRnSOEc2RHSh96G54rmmahPqFXNekFpf
         KPtg==
X-Gm-Message-State: APjAAAU/ot/14LkKOJUjJ94cQS8i4cbedUi1KXMhCQX0YdnBwuM1IBKt
        Tv1N+y9rnb6lBam1zFabRaU8EDYX83VNfA==
X-Google-Smtp-Source: APXvYqw7Phj92JS/ifXP69+BdLsl6GR9012VX0n/joOR+yr/QtIOlyyEynrhtwosQ+CrP9CPS2av0g==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr10655437plb.102.1554435463416;
        Thu, 04 Apr 2019 20:37:43 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:9900:4016:ceb4:1574])
        by smtp.gmail.com with ESMTPSA id l69sm27661879pga.73.2019.04.04.20.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 20:37:42 -0700 (PDT)
Date:   Thu, 4 Apr 2019 20:37:42 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH 1/7] t: move 'hex2oct' into test-lib-functions.sh
Message-ID: <f09c374557070b286391f1f69c4288d7d0769851.1554435033.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554435033.git.me@ttaylorr.com>
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

