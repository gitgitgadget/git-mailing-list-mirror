Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36111C38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 03:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjARDay (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjARDad (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:33 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E9539B0
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z5so31554884wrt.6
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mza3bVH56jY8ViF4P8N6fixUf8LkOvX8UaGasQaTaZ8=;
        b=Y7YAnksMudhhcTLeGDSMwDRfPXnOxD94CeDY8roa4IZ4Nj1e0tCi+UZDidFPEE7lw3
         vE+Cl18CDwjrWbJ2NpEBN4OVLh9ibmWW80mZwzgnPmEJ6f7jHWJFQz6TjLEAUahzBiY7
         PXmXEN5GO3kFt3+eIV/fQJ+pTVK73fKP1XFCHLkAvCcyNI8Jo2kwa1ko69b5EW4568qT
         pop7Rvbg/NJc2y9LT5W6XpiBfgajmaoRrOor5Wt/b85wY5K1XNPfKVyhays0MCIUOEZt
         3BkLiMg/SBaXEoYfWZ9cgg5K5e89kJ4qjT4+fZlB3dI6w6NJjt8CUqkG9MshhsiWdZ65
         ShHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mza3bVH56jY8ViF4P8N6fixUf8LkOvX8UaGasQaTaZ8=;
        b=vYTZB+hwcokMS5jdxzi7KTBb0PfgR1NeBaE7nAVX/6gJ0kZr6p/chCp33ku6+BpDbh
         DbuekkKTvPJNG+6SR/pa1mNSax4+5b3zhbavKWu2HZ/WrkYe5vLqfYkuOb4iSZMw/+fS
         jf0+Rw3QT+PHCp6kdS63IZY86Qr1ddH1TQK2uI+DhW1ZJLXBD/UJzz3Q6RDAgRLioCWm
         GmiCTuYwJb6ahqKiWANCxEl3wKFYfsh3p2SfnQHQ+OjBx5kCNqxPGJR2/JEbCBNhgJCt
         MyswdY8jgkHELm8QV81xvjKQ9NAa+Zgij384Oz0uSi4NFf+bYZhWu7mpkVE4PS37dTKe
         SE+Q==
X-Gm-Message-State: AFqh2kqPMiutR5Gldgan8Hrdxqsb/PrX9lCVHPNsTfnIEfaj8ev2wwqo
        nBiCc9m9RuMoT8tDgbesQpYD1WiIklg=
X-Google-Smtp-Source: AMrXdXt/I1qkrLICSGqYgiZDHhFdWwUiByMDn0ACS/crB39OHR339BB/qNsfe0dR0St/dqvYyDGSpA==
X-Received: by 2002:a05:6000:104a:b0:2bb:4b40:2d18 with SMTP id c10-20020a056000104a00b002bb4b402d18mr4303237wrx.62.1674012625294;
        Tue, 17 Jan 2023 19:30:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b0025e86026866sm35630015wrs.0.2023.01.17.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:30:24 -0800 (PST)
Message-Id: <252098db219574527c587bc601565eab81b40c2c.1674012618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 03:30:11 +0000
Subject: [PATCH v6 06/12] test-http-server: add HTTP request parsing
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
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add ability to parse HTTP requests to the test-http-server test helper.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 175 +++++++++++++++++++++++++++++++++++-
 1 file changed, 173 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 6cdac223a55..36f4a54fe6d 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -83,6 +83,42 @@ enum worker_result {
 	WR_HANGUP   = 1<<1,
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
@@ -134,8 +170,136 @@ done:
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
+		/* also store common request headers as struct req members */
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
+	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
+			       WR_OK | WR_HANGUP);
+}
+
 static enum worker_result worker(void)
 {
+	struct req req = REQ__INIT;
 	char *client_addr = getenv("REMOTE_ADDR");
 	char *client_port = getenv("REMOTE_PORT");
 	enum worker_result wr = WR_OK;
@@ -146,9 +310,16 @@ static enum worker_result worker(void)
 	set_keep_alive(0, logerror);
 
 	while (1) {
-		wr = send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1,
-				     NULL, WR_OK | WR_HANGUP);
+		req__release(&req);
+
+		alarm(timeout);
+		wr = req__read(&req, 0);
+		alarm(0);
+
+		if (wr != WR_OK)
+			break;
 
+		wr = dispatch(&req);
 		if (wr != WR_OK)
 			break;
 	}
-- 
gitgitgadget

