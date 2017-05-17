Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D578F2023D
	for <e@80x24.org>; Wed, 17 May 2017 03:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbdEQDLJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 23:11:09 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36461 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbdEQDLI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 23:11:08 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so28093pfg.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 20:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jvmdCgYA3hIeS8g6W3w8hRGMVHOcUOFNI24oGGvWkyg=;
        b=cWabi2pLm9VVD+ojVAlPj2gaeXI7MUbfkfZRgHdP6IOzycJYE6IGDhqKMJ90Y64vwd
         aF2P7+FJSj8hiC3+0fKFQmhUapf8+JDqYkFTeTozTfN4vR2fPzv4OmgY+U13U1QO0fax
         yIzAQb7YYP9zwZomKfAdNSRSdLD0Lx01GaCmzF4IwrCIG78SKL6lbZTrQo5nfYOMlF+W
         znbVfeqEHbbb97PIMZgtI6y9TzSfOTwjFvygSyLdeNmf7nY8CohisHUKijoMyMJNgvPo
         p7T19pPmn8bF6LbkKvx+Cq3BrUz7f+CSl5daXCIJR3IL1qKNVzBKJ7kJcOfdxOSYLlr2
         eIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jvmdCgYA3hIeS8g6W3w8hRGMVHOcUOFNI24oGGvWkyg=;
        b=E8nCDTxbPSGq08dvd4WJeLtxX0ma41zSfhj1F8QNzkzKO2xxNCuiL7+Oc02xs1qVku
         pa3O7WHNZ/TuADPIFDuA+UXOVOsuqt0yg1k7xS6DnK7Z50+nqadPXfFGEYE2wc6wwCb2
         8NHzZ/Y4SnomvVTLiMwWs0XKCCntv4rSITdLQGtuVNjAmU5aXPZJysJj1RzP5rTC4FD8
         Sm7BWNXYA8QZU2zFjIFv9LNdS4/E3b3KzR/KXKaBq01WTzK/cFQrZ2x/QMJ3ARXXFS3X
         ScPqxvnsmiDA7X46aMPisMSJytxHvURmD4hAaQic5juJna6hy5G69C650OgeNvb6haY2
         qd6Q==
X-Gm-Message-State: AODbwcDht5aAnO7GLJGKBxDMEgJsEF9JtgeH8unUoEQp7x6ErOt+0aAM
        pWE1GxVuvkutFQd3
X-Received: by 10.99.99.134 with SMTP id x128mr1359045pgb.46.1494990667424;
        Tue, 16 May 2017 20:11:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id k8sm703480pgp.59.2017.05.16.20.11.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 20:11:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     ramsay@ramsayjones.plus.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] t5545: enhance test coverage when no http server is installed
Date:   Tue, 16 May 2017 20:11:03 -0700
Message-Id: <20170517031103.4200-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <xmqqbmqsyzn7.fsf@gitster.mtv.corp.google.com>
References: <xmqqbmqsyzn7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 438fc68462 ("push options: pass push options to the transport
helper", 08-02-2017), the test coverage was reduced to run no tests at all
if you lack a http server.  Move the http initialization to the end,
such that only http tests are skipped when a http server is missing.

The test in between that tests submodule propagation is safe to run before
the http tests as it makes its own test directories `parent` and
`parent_upstream`.

Noticed-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5545-push-options.sh | 85 +++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index f9232f5d0f..90a4b0d2fe 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -3,8 +3,6 @@
 test_description='pushing to a repository using push options'
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-httpd.sh
-start_httpd
 
 mk_repo_pair () {
 	rm -rf workbench upstream &&
@@ -102,46 +100,6 @@ test_expect_success 'two push options work' '
 	test_cmp expect upstream/.git/hooks/post-receive.push_options
 '
 
-test_expect_success 'push option denied properly by http server' '
-	test_when_finished "rm -rf test_http_clone" &&
-	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
-	mk_repo_pair &&
-	git -C upstream config receive.advertisePushOptions false &&
-	git -C upstream config http.receivepack true &&
-	cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
-	git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
-	test_commit -C test_http_clone one &&
-	test_must_fail git -C test_http_clone push --push-option=asdf origin master 2>actual &&
-	test_i18ngrep "the receiving end does not support push options" actual &&
-	git -C test_http_clone push origin master
-'
-
-test_expect_success 'push options work properly across http' '
-	test_when_finished "rm -rf test_http_clone" &&
-	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
-	mk_repo_pair &&
-	git -C upstream config receive.advertisePushOptions true &&
-	git -C upstream config http.receivepack true &&
-	cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
-	git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
-
-	test_commit -C test_http_clone one &&
-	git -C test_http_clone push origin master &&
-	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify master >expect &&
-	git -C test_http_clone rev-parse --verify master >actual &&
-	test_cmp expect actual &&
-
-	test_commit -C test_http_clone two &&
-	git -C test_http_clone push --push-option=asdf --push-option="more structured text" origin master &&
-	printf "asdf\nmore structured text\n" >expect &&
-	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/pre-receive.push_options &&
-	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/post-receive.push_options &&
-
-	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify master >expect &&
-	git -C test_http_clone rev-parse --verify master >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'push options and submodules' '
 	test_when_finished "rm -rf parent" &&
 	test_when_finished "rm -rf parent_upstream" &&
@@ -182,6 +140,49 @@ test_expect_success 'push options and submodules' '
 	test_cmp expect parent_upstream/.git/hooks/post-receive.push_options
 '
 
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'push option denied properly by http server' '
+	test_when_finished "rm -rf test_http_clone" &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions false &&
+	git -C upstream config http.receivepack true &&
+	cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
+	git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
+	test_commit -C test_http_clone one &&
+	test_must_fail git -C test_http_clone push --push-option=asdf origin master 2>actual &&
+	test_i18ngrep "the receiving end does not support push options" actual &&
+	git -C test_http_clone push origin master
+'
+
+test_expect_success 'push options work properly across http' '
+	test_when_finished "rm -rf test_http_clone" &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
+	git -C upstream config http.receivepack true &&
+	cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
+	git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
+
+	test_commit -C test_http_clone one &&
+	git -C test_http_clone push origin master &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify master >expect &&
+	git -C test_http_clone rev-parse --verify master >actual &&
+	test_cmp expect actual &&
+
+	test_commit -C test_http_clone two &&
+	git -C test_http_clone push --push-option=asdf --push-option="more structured text" origin master &&
+	printf "asdf\nmore structured text\n" >expect &&
+	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/pre-receive.push_options &&
+	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/post-receive.push_options &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify master >expect &&
+	git -C test_http_clone rev-parse --verify master >actual &&
+	test_cmp expect actual
+'
+
 stop_httpd
 
 test_done
-- 
2.13.0.18.g7d86cc8ba0

