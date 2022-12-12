Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D220C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiLLVgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiLLVgc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:36:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1DD25E9
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso761694wmb.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oppsb8WsLbEUxkPzx/oHb/EanaXnzcdNH3JS2XbniwU=;
        b=SIeb3jGdUp/n7SXESrkwlVURMSMU88LPhAaKoZHi7TBM6U1lr1M0Ezn1KlrXkDDn5p
         P2HQYQBPxuV6yPEP4erM9qXbyi4k9iDxZ8eBXDqgfnbF9VU+Cx3qqVg16WlxNNsafkiq
         JhMozByKv1uF8dR2iFrpzyvMt6ndgheKh8n5VWoW5zqI6nTr5dvu93sAvPh78WYRcdEi
         Kb1+b64fF5JlPJ9ZIYp/J4QbJWR3sYfgK9jqEmLuokFE5RFHLnh9tnBOlTx779szIdkg
         +GtlvT+I2Sj1E3CIk3pzgMqu9mEs2J9VMHW3fASW1af11GYsqV4u9JHSq4c4EoyEEIeB
         VYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oppsb8WsLbEUxkPzx/oHb/EanaXnzcdNH3JS2XbniwU=;
        b=E+tUZjfQBnviJvocCfTMSJjf2QbFxPtCE8Wk9RLfKalUWQgA1GC0+MmiO5jyTWLbF+
         yIAY1+WzvQDMjWyD0O+TGvlwNFIYX4K0Zmg+l06B25dIXU6NX0Zjy2v6/YwYFPUE4Mxc
         MGTizRWOBlTl3Yr3QDIV5vgvxo1VbS8fx1WB79v8cbahpKWJjfTgh8d/8xemsDbZtAJT
         m+XGiHNfuFP9rBxb16/3akugz1NXGvx7gXevCP21a4pam6SECR1CZylltW7lCh6NV9FQ
         TFBsxQ2EHN63kNbmN1xNxLc8ZY2J/XlRPpbFzLLM14NziRn0wzEVib06Ys7D2rrNt8m+
         T3YA==
X-Gm-Message-State: ANoB5pn2w1XRjp1YLRrBwmLxJINLLsscZTCsWSo1bFvfyITBpCZ7vVn4
        2xBCP8sBKR1wskP21l2Z2pFL5rUKtCU=
X-Google-Smtp-Source: AA0mqf59c9/2zzO4ZukAmL3nAJz10YesJeQztPX+gLPJDTTQABH9xnfk2r06Tve2HnEowWPLeOC1wg==
X-Received: by 2002:a05:600c:1d9f:b0:3cf:a80d:69ab with SMTP id p31-20020a05600c1d9f00b003cfa80d69abmr13755284wms.31.1670880990324;
        Mon, 12 Dec 2022 13:36:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d46c4000000b00228d52b935asm9859938wrs.71.2022.12.12.13.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:36:29 -0800 (PST)
Message-Id: <98dd286db7c95b6401167c4a9b5e2336843d2629.1670880984.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
        <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:36:19 +0000
Subject: [PATCH v4 4/8] test-http-server: add HTTP error response function
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

