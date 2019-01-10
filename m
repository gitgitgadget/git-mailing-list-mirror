Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508E21F803
	for <e@80x24.org>; Thu, 10 Jan 2019 19:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfAJTee (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 14:34:34 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43820 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfAJTed (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 14:34:33 -0500
Received: by mail-pg1-f202.google.com with SMTP id v72so6906117pgb.10
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 11:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=il3+uivG+vJ9y6BdcZtTQmgkQA325QFRMf7WaVuyBis=;
        b=t+4Blm2G1+QWMcUmqYR/FPfW50HjxGntHWZtxYYDu6yA0Mnq7yPtdb5Fq/4ZwD54vj
         t04mZCdRp9YpSm/XXB+ntqOB3D6nEY4iqq8GJDZKXPFSudOuaighIzdIBrdaGbR9nMBX
         dfIy3a9iITQNE4g6QI87pV1C0lNr9e0G3T8OAleBlUUwJFw7NsWNUl97+Zg/lsTDcOKC
         dYcLI7SUPuvliyZC27LGLEiZIXLQuToLC8AQ+Fwq+h3tIVCT2vU87TXZWF27xF4caYKV
         UjyRvayMI08+R+rzwA5u0o4EaAk7tpdy3NdFinmtqj17V0cg2g8Pi6/TSZzeLgZelfED
         1P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=il3+uivG+vJ9y6BdcZtTQmgkQA325QFRMf7WaVuyBis=;
        b=jg4NydgRV07/IgXXBfi1kqOP7+qoHqomtEVSuFPtXFArWjaUp/f2hfDeOP8p2VCeQJ
         u/rkBFEZKJnyifIlufjb25hRIJ306fIeL859uPKrkl+kkL9OyQxYsX3nZezUbzR4P4H0
         aDMulaRR9NBOuChlanIYAevsN28oaYXjRPTkfUYUkysdZC5d6qP99RCxwQUHqbMhEbOP
         9CBOdPEpK3ZlIftYt/LHfiwwGW5jmcnbYdYAUhPlZL/2vPbMVtoKjt2rtaxSofWs87Fc
         5qsLmf9JDoO/vJqp2fYhPDiBji9GLkUE3hE2tda+1ttzttLBNeRwi3AIsb6469Sp5+lI
         8NaA==
X-Gm-Message-State: AJcUukfwDdbRKyjfWudbD84TkCwW586GXv5WPmdatKHXpoxfrgqXms0H
        nb4QSNAZRUdWMIXaVull0MeEoN9whklB7NE+02k=
X-Google-Smtp-Source: ALg8bN6NJvzDD8kz7qAxlWDdq2V2XE3PV2fCuUL6qLZr+apQ+n6l5+6Q5da2hyJQk/6QV3RknLvWyDC7+R29JhkqQGc=
X-Received: by 2002:aa7:81cc:: with SMTP id c12mr3007076pfn.69.1547148872622;
 Thu, 10 Jan 2019 11:34:32 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:33:50 -0800
In-Reply-To: <20190110193350.213327-1-masayasuzuki@google.com>
Message-Id: <20190110193350.213327-6-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20190108024741.62176-1-masayasuzuki@google.com> <20190110193350.213327-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v4 5/5] test: test GIT_CURL_VERBOSE=1 shows an error
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tests GIT_CURL_VERBOSE shows an error when an URL returns 500. This
exercises the code in remote_curl.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 t/lib-httpd/apache.conf      |  1 +
 t/t5581-http-curl-verbose.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100755 t/t5581-http-curl-verbose.sh

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 581c010d8f..cc4b87507e 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -115,6 +115,7 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
+ScriptAliasMatch /error_git_upload_pack/(.*)/git-upload-pack error.sh/
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error/ error.sh/
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
new file mode 100755
index 0000000000..cd9283eeec
--- /dev/null
+++ b/t/t5581-http-curl-verbose.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='test GIT_CURL_VERBOSE'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'setup repository' '
+	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" --bare init &&
+	git config push.default matching &&
+	echo content >file &&
+	git add file &&
+	git commit -m one &&
+	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public master:master
+'
+
+test_expect_success 'failure in git-upload-pack is shown' '
+	test_might_fail env GIT_CURL_VERBOSE=1 \
+		git clone "$HTTPD_URL/error_git_upload_pack/smart/repo.git" \
+		2>curl_log &&
+	grep "< HTTP/1.1 500 Intentional Breakage" curl_log
+'
+
+stop_httpd
+
+test_done
-- 
2.20.1.97.g81188d93c3-goog

