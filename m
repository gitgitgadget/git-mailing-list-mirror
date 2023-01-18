Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1046CC38142
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 03:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjARDas (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjARDaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27B5357B
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:25 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d2so12483749wrp.8
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkCyGdRuFvoxQvnRn4u0Bc0mNZYPHa0MqDbP3iMoKyk=;
        b=QN+DJVk/8TJk85yUtEprV8bi7ZNlLN4AzbeI4JkLRGT/NkGK2d4kHtkJ3gJVmu+IPM
         QDEIKzgSk1n3E4oTw+YBpxLazUFXGUoVLK1n331wPtYvpnFpofV3k3h4m3DsmX4XYaLh
         BjAzkbcVeU+UKW+ijvezJPleR1dOfSZl5X1LKEwsGRyE9cebIDioGwLmpCPV/wQ1LiPH
         kV49TcUbSinrOnO2oVXiEUzPYR/VQspGDRK9HMzrTbV2aob2DiN3FM9cyeuRX5pIHNM5
         uJd58s2eTroeJwFnUXFLbIzyfQLsq5AA74A/uthm4lUatPg1YmLV/wktnYTdhzERAxvD
         1xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkCyGdRuFvoxQvnRn4u0Bc0mNZYPHa0MqDbP3iMoKyk=;
        b=l2qp6XatjlGjAfF83espcn/2hHCbhJvx6pJV2siPilf61m6jN7fbU9qi76bbuQOokB
         cFgrkHOO8ZG/a0Q+YPxKf+i1+2JMfE8vIt4jYdEI6hlu46fCdL1piJ/XfZGOXRjTO21h
         rBvsRMztyOuJmSbYkseoVglYlEjnSUvxKo2GdWcvmvhvr+nbg1UoNOBLEorxV9eArueb
         Ic6MnNerZkSXTH6UsEpAVkSpNz43LlHxEKcRO8WW/bn5TUdQdUN243Qp81UHoIsSaKSF
         LeWD63edJrP3kzTqvRhXZGJ/3VB6rJlI/LG5SyBIQHL+k7w6flmvQMG86CVSd8Wt7RRX
         SyIg==
X-Gm-Message-State: AFqh2kqizXeUyEoRHcHmiQx0KrdxnJ1w3cz7wwR//XPDWEmEY+iT/i36
        dAxtMArngm44tR7UpNrdxhqjZKsXrl8=
X-Google-Smtp-Source: AMrXdXtSDU01uh8/oVT2R8OXy9aXbCq3eZh4iSjACQq6VLGCO6rVWaTFLsjtzrF6bbMBJ2jvBiPcGw==
X-Received: by 2002:adf:f10d:0:b0:2bc:7e97:3d5f with SMTP id r13-20020adff10d000000b002bc7e973d5fmr4742236wro.0.1674012624476;
        Tue, 17 Jan 2023 19:30:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a0560001b0800b002423edd7e50sm29913366wrz.32.2023.01.17.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:30:24 -0800 (PST)
Message-Id: <79805f042b984bb8ca7c9aaf6a15f8101037c375.1674012618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 03:30:10 +0000
Subject: [PATCH v6 05/12] test-http-server: add HTTP error response function
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

Introduce a function to the test-http-server test helper to write more
full and valid HTTP error responses, including all the standard response
headers like `Server` and `Date`.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 58 +++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 11071b1dd89..6cdac223a55 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -83,9 +83,59 @@ enum worker_result {
 	WR_HANGUP   = 1<<1,
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
@@ -96,10 +146,8 @@ static enum worker_result worker(void)
 	set_keep_alive(0, logerror);
 
 	while (1) {
-		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
-			logerror("unable to write response");
-			wr = WR_IO_ERROR;
-		}
+		wr = send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1,
+				     NULL, WR_OK | WR_HANGUP);
 
 		if (wr != WR_OK)
 			break;
-- 
gitgitgadget

