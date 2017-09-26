Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9BF20281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032794AbdIZX5D (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:57:03 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:44035 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032788AbdIZX47 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:56:59 -0400
Received: by mail-pg0-f41.google.com with SMTP id j16so6782082pga.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5R7R+ThXzUbQKMIElVB3PspTYjzsbRUhLYiP8kyxI1M=;
        b=YftcLX3WHO5nCJ4CbvKxGHmD1lEdPH5GFzcurkOIui0N6/8QnhGyhYdduzxEw9+SXS
         oPeZnn+TI8aaBzJFFEYSL4owvj0PzWjDF/imgaVKv6d99xxPNAZCyDhD+RejQy5IZrTP
         mZeyYWmV07XBlwRFj3ExnuKb8euffqtEijABHmqtGdRks+6/AKI5ii6V9tUu8uxTBrr3
         CYCT+zFZwUgNnXoyqfi/Jls7nFgl9I4mPtHLZTIkhrxskegfEqo8teOzJkolvHPjYCJ8
         xeo71/gPrWkrn9NlDKd0VS5yMIMgveRlxYvQKg9I/2/BEB5YfLF8VCfL1bJ1yajASZ3W
         FzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5R7R+ThXzUbQKMIElVB3PspTYjzsbRUhLYiP8kyxI1M=;
        b=UnJPLEvkzsUMvSmBcb7OGc9mmj3mUpHlnsVb9mD5Hk88cE4hl0k3ETFV4Afn0iuG1A
         2qB6nOwvA4sDc4metM55/eR46lStiebhA6p1JYld9nQN0FT9t5U2bkiurW57ERfczQAm
         06FTUQPlhoVkgrRnMYzJi+mvD8LnT4e3t1Ri2Nxv/rmYCwYs416hACZL5LQDOvodmJHE
         E15XvHmbUoGjKXNkSnGdX4qLyiyWGYC1UFo7LiUe+faL0msTy77Vd36hLHkFqmSyv1NP
         2YJzWel+6iKuikjpB/Z6lQeRDiCLTTy1uvx3O15MrqXDrPiM4nauFLZMi6+tONora7VQ
         TlWw==
X-Gm-Message-State: AHPjjUhkV+xXaM0Vhe1YUV9fygl0FL5qY+9KvnjdfOACmU728TjmxP8q
        0neQljjzsVO+BIa99d1Q6dEj2Ttxcf4=
X-Google-Smtp-Source: AOwi7QBVYKcZiAEX1YO2QgdIqKmeuIsFdew3KRrdISztnMfAqG1lPei3PpnmXLF/6gmobQ42bQofyA==
X-Received: by 10.84.129.71 with SMTP id 65mr11981435plb.250.1506470218650;
        Tue, 26 Sep 2017 16:56:58 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id j2sm18071699pgn.26.2017.09.26.16.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:56:57 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 8/9] http: tell server that the client understands v1
Date:   Tue, 26 Sep 2017 16:56:26 -0700
Message-Id: <20170926235627.79606-9-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.992.g2c7b836f3a-goog
In-Reply-To: <20170926235627.79606-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
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
index 0c792545f..aaadac1f0 100644
--- a/cache.h
+++ b/cache.h
@@ -451,6 +451,8 @@ static inline enum object_type object_type(unsigned int mode)
  * 'key[=value]'.  Presence of unknown keys must be tolerated.
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
index 1988bbce6..222265127 100755
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
+	git -C http_child log -1 --format=%s FETCH_HEAD >actual &&
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
+	# Since the repository being served isnt bare we need to push to
+	# another branch explicitly to avoid mangling the master branch
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
2.14.1.992.g2c7b836f3a-goog

