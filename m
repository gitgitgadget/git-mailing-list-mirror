Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89A142036B
	for <e@80x24.org>; Tue,  3 Oct 2017 20:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdJCUPr (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:15:47 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:56769 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdJCUPh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:15:37 -0400
Received: by mail-pf0-f171.google.com with SMTP id g65so5122129pfe.13
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0n1MERtfnzjyDDwQbucMQRto0fAb3eno+4pqLZF5AJA=;
        b=wWgEU/opMuTOzaEaRgiYO+kg3ESvhJ42YRRpMkE5oG77dd/Iz3vc6Y8qtx/mVAmctz
         Sh3S0mKCWKVmXGlW+Rus2lnYMDe2bBfWOeLDE+ocZIlwWI8tkYY60ilvg/AJr4Q9eNo8
         e0hyEqng6R328jr7MVVSZ/7YnfGNdBwtgoER1P6yxL1rmO1nf8DhbDsKVZ40G0yRM/w0
         XHKX6pxTL12LXMn6QfMuO+LyQ8ipwXYUfXKf/S87YlPNqx3LU0NnJ4sepjRB+WMzIAGw
         BUYm5hvQLgEjPZSSMHOEQKnMY8biKpWVa5gMLhPAmBhUkYLWqlaEAso5RRT/jjlM1AVs
         KzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0n1MERtfnzjyDDwQbucMQRto0fAb3eno+4pqLZF5AJA=;
        b=rGF8yhFKzhnIjZRnclH03aSlXYL5A5nAZuYXPbe/T7DEb4fGEGfpi3pIws2/AFgO1f
         Mia6qtC0mqZGdvvtqZlAskMVqIZNl5GKEc+l2scPCFRN6YUdQQW8csEexpu7lRPw779p
         dMUlR0FOHmdkO85YJEqF2XcJ2frkWYxXB3FhnkU84SBz8M2r/pjj674LrZCVdmPykt91
         KPLy565oMrkC6K51BdHYuAAxLfvbzKpaG+1zQE8nkExgcNy319D1JARs+VMiXeFVU1jK
         8x9XNx7s7M0aj3VHPtUL+gVayRCDcKsxgCQGC5xurTZco076EMOUHwBovpbnffyYFchg
         9Z+Q==
X-Gm-Message-State: AMCzsaX849X7qJr8oY4VpntuFXGjCWnOKwFzfz6EmkVuCieKvxQNdFFm
        aLClnoeLr2u8xj+c+qAmO4tgjmSFX0A=
X-Google-Smtp-Source: AOwi7QBzEuQLlKXF/7jlNYZkr7MzsNp+HGruKZracZuH0QDPLBC/Vni4UjTzTrTSoRGItr6Qrl5BAQ==
X-Received: by 10.101.85.136 with SMTP id j8mr11287393pgs.129.1507061736165;
        Tue, 03 Oct 2017 13:15:36 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 184sm3846262pfd.88.2017.10.03.13.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 13:15:34 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 08/10] http: tell server that the client understands v1
Date:   Tue,  3 Oct 2017 13:15:05 -0700
Message-Id: <20171003201507.3589-9-bmwill@google.com>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c-goog
In-Reply-To: <20171003201507.3589-1-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tell a server that protocol v1 can be used by sending the http header
'Git-Protocol' indicating this.

Also teach the apache http server to pass through the 'Git-Protocol'
header as an environment variable 'GIT_PROTOCOL'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h                 |  2 ++
 http.c                  | 18 +++++++++++++
 t/lib-httpd/apache.conf |  7 +++++
 t/t5700-protocol-v1.sh  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/cache.h b/cache.h
index c74b73671..3a6b869c2 100644
--- a/cache.h
+++ b/cache.h
@@ -452,6 +452,8 @@ static inline enum object_type object_type(unsigned int mode)
  * ignored.
  */
 #define GIT_PROTOCOL_ENVIRONMENT "GIT_PROTOCOL"
+/* HTTP header used to handshake the wire protocol */
+#define GIT_PROTOCOL_HEADER "Git-Protocol"
 
 /*
  * This environment variable is expected to contain a boolean indicating
diff --git a/http.c b/http.c
index 9e40a465f..ffb719216 100644
--- a/http.c
+++ b/http.c
@@ -12,6 +12,7 @@
 #include "gettext.h"
 #include "transport.h"
 #include "packfile.h"
+#include "protocol.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 #if LIBCURL_VERSION_NUM >= 0x070a08
@@ -897,6 +898,21 @@ static void set_from_env(const char **var, const char *envname)
 		*var = val;
 }
 
+static void protocol_http_header(void)
+{
+	if (get_protocol_version_config() > 0) {
+		struct strbuf protocol_header = STRBUF_INIT;
+
+		strbuf_addf(&protocol_header, GIT_PROTOCOL_HEADER ": version=%d",
+			    get_protocol_version_config());
+
+
+		extra_http_headers = curl_slist_append(extra_http_headers,
+						       protocol_header.buf);
+		strbuf_release(&protocol_header);
+	}
+}
+
 void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
@@ -927,6 +943,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (remote)
 		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
 
+	protocol_http_header();
+
 	pragma_header = curl_slist_append(http_copy_default_headers(),
 		"Pragma: no-cache");
 	no_pragma_header = curl_slist_append(http_copy_default_headers(),
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0642ae7e6..df1943631 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -67,6 +67,9 @@ LockFile accept.lock
 <IfModule !mod_unixd.c>
 	LoadModule unixd_module modules/mod_unixd.so
 </IfModule>
+<IfModule !mod_setenvif.c>
+	LoadModule setenvif_module modules/mod_setenvif.so
+</IfModule>
 </IfVersion>
 
 PassEnv GIT_VALGRIND
@@ -76,6 +79,10 @@ PassEnv ASAN_OPTIONS
 PassEnv GIT_TRACE
 PassEnv GIT_CONFIG_NOSYSTEM
 
+<IfVersion >= 2.4>
+	SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
+</IfVersion>
+
 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
 
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 6551932da..b0779d362 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -220,4 +220,73 @@ test_expect_success 'push with ssh:// using protocol v1' '
 	grep "push< version 1" log
 '
 
+# Test protocol v1 with 'http://' transport
+#
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'create repo to be served by http:// transport' '
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receivepack true &&
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one
+'
+
+test_expect_success 'clone with http:// using protocol v1' '
+	GIT_TRACE_PACKET=1 GIT_TRACE_CURL=1 git -c protocol.version=1 \
+		clone "$HTTPD_URL/smart/http_parent" http_child 2>log &&
+
+	git -C http_child log -1 --format=%s >actual &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v1
+	grep "Git-Protocol: version=1" log &&
+	# Server responded using protocol v1
+	grep "git< version 1" log
+'
+
+test_expect_success 'fetch with http:// using protocol v1' '
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" two &&
+
+	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
+		fetch 2>log &&
+
+	git -C http_child log -1 --format=%s origin/master >actual &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "git< version 1" log
+'
+
+test_expect_success 'pull with http:// using protocol v1' '
+	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
+		pull 2>log &&
+
+	git -C http_child log -1 --format=%s >actual &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "git< version 1" log
+'
+
+test_expect_success 'push with http:// using protocol v1' '
+	test_commit -C http_child three &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
+		push origin HEAD:client_branch && #2>log &&
+
+	git -C http_child log -1 --format=%s >actual &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s client_branch >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "git< version 1" log
+'
+
+stop_httpd
+
 test_done
-- 
2.14.2.920.gcf0c67979c-goog

