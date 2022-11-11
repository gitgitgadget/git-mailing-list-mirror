Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCBEC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiKKWfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiKKWfM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:35:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB513F47
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:35:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i10-20020a1c3b0a000000b003cfd36eff5fso1325502wma.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHv9+mjWu/oe9o3RH8VgVHQBexla88GGqc8EhEAON8I=;
        b=kKd+oMyzDfZLI+XlC9A2ySBgniEtMB5SOTPYpda4eC/7mlyAO912v6lp51d7IlsFlj
         H0E4CgHgX92VVuMkRpBRvwjg1J7x50lcUxxMWwg2piMBVQpIMiT0oTSCl92tKEyEnPII
         0qa/+5Gs5j2BZnqSvWcLNRvxTCXoVMn7LRCv2tMPMC31Gjbb3wiOfpaFN911xIYu50Fh
         2dXkNwfBLEaEEpv+mG58VsV0ObKeGOALuJaDXiQRmKk0BdkV8bCHGepYmxHcQ8anXd5z
         uGqLWQkUN/yrv7CLAqrXrpEv/y/kpMou/az5MIp5/3VxuZbp37LEkymX5naFn0G4ug19
         KWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHv9+mjWu/oe9o3RH8VgVHQBexla88GGqc8EhEAON8I=;
        b=ha/oGC0scZMhocBCktAbN2srQWdVJY46Pu6voU6jiTGRcZUw8vBOvuUgQWaRlLElyG
         /ZRlVQSJzXI2qdBI1gIat4+13sfG1hnbz293U0Ta2ZrqVKH+vyi4UG/kki+I7/mlyGRl
         jahKRL+xUMhrhdSUqTwYIVW9PBaCx5IQVbGo5l22Uw5n4aGkKQXuyEtiOGaLZUTf+eDx
         J7chAs2NEFNL3jmtMHULfABPmP4c+ZfV3G33afnE0qRO6fGib2B8CwquEC2ud0+2JJPl
         oTbImDPIhyxENNw4wE8rFc2vya+qvwGSQULWTWNOSh3mgSnqplICEjXLQ2skIx2yr1mg
         uKmQ==
X-Gm-Message-State: ANoB5pm1bcIID3garMRlTieGIrTk7phOZjzTnbidleAZ9/6eWq506iy7
        PFg9VtI0+m9D1nl58btx74uS3sU4ZeM=
X-Google-Smtp-Source: AA0mqf7/fnjakw6lg2YOTW8o2v+SjWG0PmHexMj9yl1AZ6AzJHdjHXMH95GxQ8wp+2XdRykFM/iAMQ==
X-Received: by 2002:a05:600c:5108:b0:3cf:735c:9d5a with SMTP id o8-20020a05600c510800b003cf735c9d5amr2523722wms.113.1668206109604;
        Fri, 11 Nov 2022 14:35:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d570b000000b0022ca921dc67sm2845740wrv.88.2022.11.11.14.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:35:09 -0800 (PST)
Message-Id: <bb5df1a48b98cb71826d53acb6c8f3b25d140b83.1668206106.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1377.v3.git.git.1668206106.gitgitgadget@gmail.com>
References: <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
        <pull.1377.v3.git.git.1668206106.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Nov 2022 22:35:06 +0000
Subject: [PATCH v3 2/2] http: redact curl h2h3 headers in info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

With GIT_TRACE_CURL=1 or GIT_CURL_VERBOSE=1, sensitive headers like
"Authorization" and "Cookie" get redacted. However, since [1], curl's
h2h3 module (invoked when using HTTP/2) also prints headers in its
"info", which don't get redacted. For example,

  echo 'github.com	TRUE	/	FALSE	1698960413304	o	foo=bar' >cookiefile &&
  GIT_TRACE_CURL=1 GIT_TRACE_CURL_NO_DATA=1 git \
    -c 'http.cookiefile=cookiefile' \
    -c 'http.version=' \
    ls-remote https://github.com/git/git refs/heads/main 2>output &&
  grep 'cookie' output

produces output like:

  23:04:16.920495 http.c:678              == Info: h2h3 [cookie: o=foo=bar]
  23:04:16.920562 http.c:637              => Send header: cookie: o=<redacted>

Teach http.c to check for h2h3 headers in info and redact them using the
existing header redaction logic. This fixes the broken redaction logic
that we noted in the previous commit, so mark the redaction tests as
passing under HTTP2.

[1] https://github.com/curl/curl/commit/f8c3724aa90472c0e617ddbbc420aa199971eb77

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 http.c                      | 47 ++++++++++++++++++++++++++++++++-----
 t/t5551-http-fetch-smart.sh |  6 ++---
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/http.c b/http.c
index 5d0502f51fd..8a5ba3f4776 100644
--- a/http.c
+++ b/http.c
@@ -560,13 +560,15 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
 
-static void redact_sensitive_header(struct strbuf *header)
+/* Return 1 if redactions have been made, 0 otherwise. */
+static int redact_sensitive_header(struct strbuf *header, size_t offset)
 {
+	int ret = 0;
 	const char *sensitive_header;
 
 	if (trace_curl_redact &&
-	    (skip_iprefix(header->buf, "Authorization:", &sensitive_header) ||
-	     skip_iprefix(header->buf, "Proxy-Authorization:", &sensitive_header))) {
+	    (skip_iprefix(header->buf + offset, "Authorization:", &sensitive_header) ||
+	     skip_iprefix(header->buf + offset, "Proxy-Authorization:", &sensitive_header))) {
 		/* The first token is the type, which is OK to log */
 		while (isspace(*sensitive_header))
 			sensitive_header++;
@@ -575,8 +577,9 @@ static void redact_sensitive_header(struct strbuf *header)
 		/* Everything else is opaque and possibly sensitive */
 		strbuf_setlen(header,  sensitive_header - header->buf);
 		strbuf_addstr(header, " <redacted>");
+		ret = 1;
 	} else if (trace_curl_redact &&
-		   skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
+		   skip_iprefix(header->buf + offset, "Cookie:", &sensitive_header)) {
 		struct strbuf redacted_header = STRBUF_INIT;
 		const char *cookie;
 
@@ -612,6 +615,26 @@ static void redact_sensitive_header(struct strbuf *header)
 
 		strbuf_setlen(header, sensitive_header - header->buf);
 		strbuf_addbuf(header, &redacted_header);
+		ret = 1;
+	}
+	return ret;
+}
+
+/* Redact headers in info */
+static void redact_sensitive_info_header(struct strbuf *header)
+{
+	const char *sensitive_header;
+
+	/*
+	 * curl's h2h3 prints headers in info, e.g.:
+	 *   h2h3 [<header-name>: <header-val>]
+	 */
+	if (trace_curl_redact &&
+	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
+		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
+			/* redaction ate our closing bracket */
+			strbuf_addch(header, ']');
+		}
 	}
 }
 
@@ -629,7 +652,7 @@ static void curl_dump_header(const char *text, unsigned char *ptr, size_t size,
 
 	for (header = headers; *header; header++) {
 		if (hide_sensitive_header)
-			redact_sensitive_header(*header);
+			redact_sensitive_header(*header, 0);
 		strbuf_insertstr((*header), 0, text);
 		strbuf_insertstr((*header), strlen(text), ": ");
 		strbuf_rtrim((*header));
@@ -668,6 +691,18 @@ static void curl_dump_data(const char *text, unsigned char *ptr, size_t size)
 	strbuf_release(&out);
 }
 
+static void curl_dump_info(char *data, size_t size)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_add(&buf, data, size);
+
+	redact_sensitive_info_header(&buf);
+	trace_printf_key(&trace_curl, "== Info: %s", buf.buf);
+
+	strbuf_release(&buf);
+}
+
 static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp)
 {
 	const char *text;
@@ -675,7 +710,7 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 
 	switch (type) {
 	case CURLINFO_TEXT:
-		trace_printf_key(&trace_curl, "== Info: %s", data);
+		curl_dump_info(data, size);
 		break;
 	case CURLINFO_HEADER_OUT:
 		text = "=> Send header";
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index ad0a0639e6b..a2ebce1787b 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -200,7 +200,7 @@ test_expect_success 'redirects send auth to new location' '
 	expect_askpass both user@host auth/smart/repo.git
 '
 
-test_expect_success !HTTP2 'GIT_TRACE_CURL redacts auth details' '
+test_expect_success 'GIT_TRACE_CURL redacts auth details' '
 	rm -rf redact-auth trace &&
 	set_askpass user@host pass@host &&
 	GIT_TRACE_CURL="$(pwd)/trace" git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
@@ -212,7 +212,7 @@ test_expect_success !HTTP2 'GIT_TRACE_CURL redacts auth details' '
 	grep -i "Authorization: Basic <redacted>" trace
 '
 
-test_expect_success !HTTP2 'GIT_CURL_VERBOSE redacts auth details' '
+test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
 	rm -rf redact-auth trace &&
 	set_askpass user@host pass@host &&
 	GIT_CURL_VERBOSE=1 git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth 2>trace &&
@@ -482,7 +482,7 @@ test_expect_success 'fetch by SHA-1 without tag following' '
 		--no-tags origin $(cat bar_hash)
 '
 
-test_expect_success !HTTP2 'cookies are redacted by default' '
+test_expect_success 'cookies are redacted by default' '
 	rm -rf clone &&
 	echo "Set-Cookie: Foo=1" >cookies &&
 	echo "Set-Cookie: Bar=2" >>cookies &&
-- 
gitgitgadget
