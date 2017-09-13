Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58EA20286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbdIMVz0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:55:26 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:44173 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdIMVzL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:55:11 -0400
Received: by mail-pg0-f46.google.com with SMTP id j16so2814511pga.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MAgXXkfsfFCjmeMAaBlJDGahX4Q6hpPpcHa/TTNzsuE=;
        b=cgG26codioaIt3CSqeAGGkKU+h8wL03UcHpoMa93IkLE/zWnt/uc1eV+/1gUtr1k+z
         ZV/a8GCgADmDOBwOieF4UfT9YYLu98fCd9K57eWajMGv5DZhabmr9Fky9vCl+OGrY4Ra
         t2uvhRNteD4ZiT82DyUWbRfjkETCwF7vWhPiZe7dlNGmKCEM3F0IBKB5uIE5DesWV/5k
         D4Vkpu59hYeIP/8+GFA1cMAV6adhZ9NXy59hmMv3stv5mbe3G04yuojRYMSdK5zNZlvF
         sEECx32xKY8Lt1cBUUNQRLRjMU8hA5RkSzTGGnU9t+X+rqBipJRiMog8XgccS/4dKLLM
         +xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MAgXXkfsfFCjmeMAaBlJDGahX4Q6hpPpcHa/TTNzsuE=;
        b=p/X9ahZh24W/+5H1n+MB/cOfpfOtTr9FLXwegGZaQ1W9CwuypLNzp3Bk9KZxkZ95Po
         yvJ5HvcktYudgD+aLdzRDBIw8vt77nKGebLXQSztJ5UWiAJIsySpNJQ48H+ZztYHi74z
         JGbtFZDEhV+4t2wcDDDLbKM4+Dr1j3Bt7qBlMoe3tq9m8gfqeCQctzxd1kRfsL11DSEh
         CyF8e08/LyK16eIYgg8PpXvHA58stvhkHpvxosfhe+5bHhlaPd2KjoY6EXU9Q27mneah
         l3WcfPVlyeU4uYUXlc2Cp1VUJqNKxbrf9wB+sgHnpV77nEb47YgGkdZVoHnoGsainKBp
         yItg==
X-Gm-Message-State: AHPjjUgydrx6wqqcZCzUOhmhocPB4oVF5IzgzXRRxUWkeuLmFfvYOoij
        0XIX52pupTIcwjYazT+bKQ==
X-Google-Smtp-Source: AOwi7QC38ZYgnenn1XTQUMD7zr24PHvZLIM05rDkI8ajzyJIA0jo8VYiOLo2ogP8msaYzz7IVhggzQ==
X-Received: by 10.101.74.81 with SMTP id a17mr148510pgu.441.1505339710417;
        Wed, 13 Sep 2017 14:55:10 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q13sm23152639pgt.87.2017.09.13.14.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:55:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 7/8] http: tell server that the client understands v1
Date:   Wed, 13 Sep 2017 14:54:47 -0700
Message-Id: <20170913215448.84674-8-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.690.gbb1197296e-goog
In-Reply-To: <20170913215448.84674-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
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
index 8839b1ed4..82a643968 100644
--- a/cache.h
+++ b/cache.h
@@ -450,6 +450,8 @@ static inline enum object_type object_type(unsigned int mode)
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
2.14.1.690.gbb1197296e-goog

