Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA54C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiKBWJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKBWJn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:09:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC032BC
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:09:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so2192381wms.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oppsb8WsLbEUxkPzx/oHb/EanaXnzcdNH3JS2XbniwU=;
        b=GWO8yH+T5l6sTEOx2qOA9E7ldOtnwdzowZVX5DJRU3twdE7F3XhIuvC/lZLn7LJZ7n
         L8whCeHnFWq8n12xWXqPBvJ7C+1JMvEJl231TavInpC+xoWIadxMaJnl/cRErZx0KUb/
         rIg+yu0JgqI7RAo35FnqCxbkkALoYRv1Ff5WxQH8vS2TaR3C28ZSPfoNnWeIG72V/wAN
         6ACu0I0TwNOWBJrKY/p28pUPiK7cjM+XL25T/QylTLXoRbkqoTP0hvQrsIa2+gRDykft
         aoN7bcF1jpNqwCEJLHg8J8qD8EymDBMYUUHU+jQmuo/ZeNmlV0HtFnHIJvutKiKTU6rh
         Upcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oppsb8WsLbEUxkPzx/oHb/EanaXnzcdNH3JS2XbniwU=;
        b=28BTf8El0YO98GdspporVzrNSL6xxdIl6XTuqXVhKOrONjo7OKHVoZTyHtnPPakQJ1
         gys5cp073JjoUJ7nDsrGSbAEaMi47WawqfmL5FfqX6IH+CXFrzdB6mcIQD7dedIYOFKH
         6sBwC6fsngJlLTUM7OGEiccOq2yXgOCuIps1asc79t5AYfskaZMTd3p7WIX7TRUDfRLL
         oWE+pki2IQIJ6Q4s8/bC0oukeM4Ldafn5884BkXI6ZZM8T4AXNjKSkUS9d+U1kq0+9zk
         U13xlPLDFsNHl9ygbK8vKtFREha5K2UW4WFJBdKETD6CoFNDgJKYAOlbZHzniB7eAOCx
         3lvg==
X-Gm-Message-State: ACrzQf2+hAwDdgpsjkGNtYccwDvidMXnlsyPtDbEnBq6GWWyiHdr01K2
        m4UiSR9BLFpYfnqrQReF1viKHBoDPxg=
X-Google-Smtp-Source: AMsMyM6+5ZiNUucV8mMhLjRZaj77Mcs2v0ANWMbZXAZyY/j4yp1pqK7Y82YSh0Zb423616t99iDyDg==
X-Received: by 2002:a05:600c:4394:b0:3cf:75a8:ecc6 with SMTP id e20-20020a05600c439400b003cf75a8ecc6mr10970638wmn.74.1667426980212;
        Wed, 02 Nov 2022 15:09:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b0023691d62cffsm13732521wrz.70.2022.11.02.15.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:09:39 -0700 (PDT)
Message-Id: <93bdf1d7060301d3794f83a927fe72e09274e8ab.1667426970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
        <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 22:09:25 +0000
Subject: [PATCH v3 07/11] test-http-server: add HTTP error response function
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

Introduce a function to the test-http-server test helper to write more
full and valid HTTP error responses, including all the standard response
headers like `Server` and `Date`.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 59 +++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 18f1f741305..53508639714 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -97,9 +97,59 @@ enum worker_result {
 	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
 };
 
+static enum worker_result send_http_error(
+	int fd,
+	int http_code, const char *http_code_name,
+	int retry_after_seconds, struct string_list *response_headers,
+	enum worker_result wr_in)
+{
+	struct strbuf response_header = STRBUF_INIT;
+	struct strbuf response_content = STRBUF_INIT;
+	struct string_list_item *h;
+	enum worker_result wr;
+
+	strbuf_addf(&response_content, "Error: %d %s\r\n",
+		    http_code, http_code_name);
+	if (retry_after_seconds > 0)
+		strbuf_addf(&response_content, "Retry-After: %d\r\n",
+			    retry_after_seconds);
+
+	strbuf_addf  (&response_header, "HTTP/1.1 %d %s\r\n", http_code, http_code_name);
+	strbuf_addstr(&response_header, "Cache-Control: private\r\n");
+	strbuf_addstr(&response_header,	"Content-Type: text/plain\r\n");
+	strbuf_addf  (&response_header,	"Content-Length: %d\r\n", (int)response_content.len);
+	if (retry_after_seconds > 0)
+		strbuf_addf(&response_header, "Retry-After: %d\r\n", retry_after_seconds);
+	strbuf_addf(  &response_header,	"Server: test-http-server/%s\r\n", git_version_string);
+	strbuf_addf(  &response_header, "Date: %s\r\n", show_date(time(NULL), 0, DATE_MODE(RFC2822)));
+	if (response_headers)
+		for_each_string_list_item(h, response_headers)
+			strbuf_addf(&response_header, "%s\r\n", h->string);
+	strbuf_addstr(&response_header, "\r\n");
+
+	if (write_in_full(fd, response_header.buf, response_header.len) < 0) {
+		logerror("unable to write response header");
+		wr = WR_IO_ERROR;
+		goto done;
+	}
+
+	if (write_in_full(fd, response_content.buf, response_content.len) < 0) {
+		logerror("unable to write response content body");
+		wr = WR_IO_ERROR;
+		goto done;
+	}
+
+	wr = wr_in;
+
+done:
+	strbuf_release(&response_header);
+	strbuf_release(&response_content);
+
+	return wr;
+}
+
 static enum worker_result worker(void)
 {
-	const char *response = "HTTP/1.1 501 Not Implemented\r\n";
 	char *client_addr = getenv("REMOTE_ADDR");
 	char *client_port = getenv("REMOTE_PORT");
 	enum worker_result wr = WR_OK;
@@ -110,11 +160,8 @@ static enum worker_result worker(void)
 	set_keep_alive(0);
 
 	while (1) {
-		if (write_in_full(1, response, strlen(response)) < 0) {
-			logerror("unable to write response");
-			wr = WR_IO_ERROR;
-		}
-
+		wr = send_http_error(1, 501, "Not Implemented", -1, NULL,
+			WR_OK | WR_HANGUP);
 		if (wr & WR_STOP_THE_MUSIC)
 			break;
 	}
-- 
gitgitgadget

