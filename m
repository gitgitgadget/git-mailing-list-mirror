Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF54BC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKBWJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiKBWJn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:09:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C02AA
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:09:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j15so231361wrq.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pys0iYEZZUGF1uUgWPkThf6R1S5uxxZxLTtL9ZuAB7M=;
        b=iGh+3TY6zUIl32oBkO525lOXqiGjCRV7lK2NozPhOYxmWeRiukAldEjisbm07iVqv2
         z8YsYxUJJ5u08XkomNToMZtDLymFdmvWpdzEwg9lj7AcHERcVhNZ2Vpujl65qrLlHJk7
         gJYkmClGisOnwU8nPA8fSliNuriEtXEt2B11EH/GKsMbZB89+vjrUpxCp4TS0GYvoCFU
         8s/h8D2sU8oGcDecftNc5Z7d6X3QSYm2CBGmaAhRNq5uc/jHnaCSybZ4G9DnLRDwHYQ0
         mnVzhGWMa8SFo0zhl01AWb6k5LQ1nJ45NadhA7ehl/TrClZDktFYw9J86y/dspwgCHa4
         IKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pys0iYEZZUGF1uUgWPkThf6R1S5uxxZxLTtL9ZuAB7M=;
        b=38EzuutO1O6GWM3po/a3DP6U6qPK5acrQB2cMmcV9GgTtj/QVu8PISrBdRkpngVg3p
         gc/S6vv3DtA48WciNHKCdvaft8qCiJHfo1f2OsNWL3P9MPhnZMmVNUv5gdV0Gv2QCPzL
         CgmxfNG0Rskoz03oPQIf1J671T+WDTEzuBW9CHJSEVvmmboqN5d+edt5Iu33FE5jxeMR
         gpcbGGHTDU0TjsI9lfDMf95QYwoiO+vfKX3+lu+hJnKS21Sj6qmYEwzBiXWJMNBP92St
         WTZ8J3VguwzKlnYmJeFZ6+T/o1QY439iAPwug6DBDc123E5vfu1dQtJdvtTSwN9JF0iy
         9OSQ==
X-Gm-Message-State: ACrzQf1bKzbqfr91rGZD48Z6DLVfhIqamJe3t3GCWitAyeHtNkUQYJPE
        hIsrCzlKsXeO5gW9mGEdO3SiBwdKjlc=
X-Google-Smtp-Source: AMsMyM5qDjrrdKNNvB+wDLSzM/1JoKd4MqynpblDe86t6Dd9m86pEkFBWJsG4R8iF60L6b6gxGimjA==
X-Received: by 2002:a5d:6688:0:b0:238:3e06:9001 with SMTP id l8-20020a5d6688000000b002383e069001mr361729wru.308.1667426981683;
        Wed, 02 Nov 2022 15:09:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003c6c5a5a651sm3340000wmd.28.2022.11.02.15.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:09:40 -0700 (PDT)
Message-Id: <b3e9156755fa4d4d1b83b6b6e1816ca54e40218a.1667426970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
        <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 22:09:26 +0000
Subject: [PATCH v3 08/11] test-http-server: add HTTP request parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add ability to parse HTTP requests to the test-http-server test helper.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 176 +++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 53508639714..7bde678e264 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -97,6 +97,42 @@ enum worker_result {
 	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
 };
 
+/*
+ * Fields from a parsed HTTP request.
+ */
+struct req {
+	struct strbuf start_line;
+
+	const char *method;
+	const char *http_version;
+
+	struct strbuf uri_path;
+	struct strbuf query_args;
+
+	struct string_list header_list;
+	const char *content_type;
+	ssize_t content_length;
+};
+
+#define REQ__INIT { \
+	.start_line = STRBUF_INIT, \
+	.uri_path = STRBUF_INIT, \
+	.query_args = STRBUF_INIT, \
+	.header_list = STRING_LIST_INIT_NODUP, \
+	.content_type = NULL, \
+	.content_length = -1 \
+	}
+
+static void req__release(struct req *req)
+{
+	strbuf_release(&req->start_line);
+
+	strbuf_release(&req->uri_path);
+	strbuf_release(&req->query_args);
+
+	string_list_clear(&req->header_list, 0);
+}
+
 static enum worker_result send_http_error(
 	int fd,
 	int http_code, const char *http_code_name,
@@ -148,8 +184,136 @@ done:
 	return wr;
 }
 
+/*
+ * Read the HTTP request up to the start of the optional message-body.
+ * We do this byte-by-byte because we have keep-alive turned on and
+ * cannot rely on an EOF.
+ *
+ * https://tools.ietf.org/html/rfc7230
+ *
+ * We cannot call die() here because our caller needs to properly
+ * respond to the client and/or close the socket before this
+ * child exits so that the client doesn't get a connection reset
+ * by peer error.
+ */
+static enum worker_result req__read(struct req *req, int fd)
+{
+	struct strbuf h = STRBUF_INIT;
+	struct string_list start_line_fields = STRING_LIST_INIT_DUP;
+	int nr_start_line_fields;
+	const char *uri_target;
+	const char *query;
+	char *hp;
+	const char *hv;
+
+	enum worker_result result = WR_OK;
+
+	/*
+	 * Read line 0 of the request and split it into component parts:
+	 *
+	 *    <method> SP <uri-target> SP <HTTP-version> CRLF
+	 *
+	 */
+	if (strbuf_getwholeline_fd(&req->start_line, fd, '\n') == EOF) {
+		result = WR_OK | WR_HANGUP;
+		goto done;
+	}
+
+	strbuf_trim_trailing_newline(&req->start_line);
+
+	nr_start_line_fields = string_list_split(&start_line_fields,
+						 req->start_line.buf,
+						 ' ', -1);
+	if (nr_start_line_fields != 3) {
+		logerror("could not parse request start-line '%s'",
+			 req->start_line.buf);
+		result = WR_IO_ERROR;
+		goto done;
+	}
+
+	req->method = xstrdup(start_line_fields.items[0].string);
+	req->http_version = xstrdup(start_line_fields.items[2].string);
+
+	uri_target = start_line_fields.items[1].string;
+
+	if (strcmp(req->http_version, "HTTP/1.1")) {
+		logerror("unsupported version '%s' (expecting HTTP/1.1)",
+			 req->http_version);
+		result = WR_IO_ERROR;
+		goto done;
+	}
+
+	query = strchr(uri_target, '?');
+
+	if (query) {
+		strbuf_add(&req->uri_path, uri_target, (query - uri_target));
+		strbuf_trim_trailing_dir_sep(&req->uri_path);
+		strbuf_addstr(&req->query_args, query + 1);
+	} else {
+		strbuf_addstr(&req->uri_path, uri_target);
+		strbuf_trim_trailing_dir_sep(&req->uri_path);
+	}
+
+	/*
+	 * Read the set of HTTP headers into a string-list.
+	 */
+	while (1) {
+		if (strbuf_getwholeline_fd(&h, fd, '\n') == EOF)
+			goto done;
+		strbuf_trim_trailing_newline(&h);
+
+		if (!h.len)
+			goto done; /* a blank line ends the header */
+
+		hp = strbuf_detach(&h, NULL);
+		string_list_append(&req->header_list, hp);
+
+		/* store common request headers separately */
+		if (skip_prefix(hp, "Content-Type: ", &hv)) {
+			req->content_type = hv;
+		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
+			req->content_length = strtol(hv, &hp, 10);
+		}
+	}
+
+	/*
+	 * We do not attempt to read the <message-body>, if it exists.
+	 * We let our caller read/chunk it in as appropriate.
+	 */
+
+done:
+	string_list_clear(&start_line_fields, 0);
+
+	/*
+	 * This is useful for debugging the request, but very noisy.
+	 */
+	if (trace2_is_enabled()) {
+		struct string_list_item *item;
+		trace2_printf("%s: %s", TR2_CAT, req->start_line.buf);
+		trace2_printf("%s: hver: %s", TR2_CAT, req->http_version);
+		trace2_printf("%s: hmth: %s", TR2_CAT, req->method);
+		trace2_printf("%s: path: %s", TR2_CAT, req->uri_path.buf);
+		trace2_printf("%s: qury: %s", TR2_CAT, req->query_args.buf);
+		if (req->content_length >= 0)
+			trace2_printf("%s: clen: %d", TR2_CAT, req->content_length);
+		if (req->content_type)
+			trace2_printf("%s: ctyp: %s", TR2_CAT, req->content_type);
+		for_each_string_list_item(item, &req->header_list)
+			trace2_printf("%s: hdrs: %s", TR2_CAT, item->string);
+	}
+
+	return result;
+}
+
+static enum worker_result dispatch(struct req *req)
+{
+	return send_http_error(1, 501, "Not Implemented", -1, NULL,
+			       WR_OK | WR_HANGUP);
+}
+
 static enum worker_result worker(void)
 {
+	struct req req = REQ__INIT;
 	char *client_addr = getenv("REMOTE_ADDR");
 	char *client_port = getenv("REMOTE_PORT");
 	enum worker_result wr = WR_OK;
@@ -160,8 +324,16 @@ static enum worker_result worker(void)
 	set_keep_alive(0);
 
 	while (1) {
-		wr = send_http_error(1, 501, "Not Implemented", -1, NULL,
-			WR_OK | WR_HANGUP);
+		req__release(&req);
+
+		alarm(init_timeout ? init_timeout : timeout);
+		wr = req__read(&req, 0);
+		alarm(0);
+
+		if (wr & WR_STOP_THE_MUSIC)
+			break;
+
+		wr = dispatch(&req);
 		if (wr & WR_STOP_THE_MUSIC)
 			break;
 	}
-- 
gitgitgadget

