Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12312C27C76
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjATWJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjATWJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8319EA578D
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso6759596wmc.4
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svxIuOTb7q/EEc6/1OQt4zD+rbN5gnQd/ELeNNOs2Ec=;
        b=E4p2uGiPCY9aVmI4zXMihMLgR5KUbYHBXHIrmTMDc/EZYb8HGh+BDUcAPdGZ76mV0i
         cG5ccBobHTDk3g2Yfti/jrbAVaPP6BbCKL3sTaI+qQpjyCi+PvNovvPKtiy2WgowLJwF
         pq9RXlMORlDK8txoCqLeBDEZAufuu0u0uJFNdadnGqLGHS+8r0t8BXzmbQDZF+qFedWN
         5fOGdhAvxqJ0rZpWEykZbM3Kuopkd4kpraHnmj2+0Shzr/b1OL0/XMn3lAHaSIYZ7g36
         qJz1cJ8lxQXE+2YfX+RMbTod+FvH2jsx+Cc30HwWD9MFvADwvOwSZ+1yhn7u5UQt2XMN
         LilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svxIuOTb7q/EEc6/1OQt4zD+rbN5gnQd/ELeNNOs2Ec=;
        b=cV0P7w8FyOmos3qTDvWagEYMlPPErzRkn8WvlrQeCxUlmez6JO+ajTaLdO5VIPTCZJ
         rbs9mDO9PuH98viAaLY9tD0YSa8qXRDuZe4zOMHKnFxeRo95zY+BVZADq3yi0p13+3Ai
         mZjF1o/HwfakvpNn0T2YS9io91GG2eRoxHQ/2lfT30u7sjTWWWbYbr1Qnf6cX+RB6xP7
         0rbcYfqGMrfTnFXL4Cda47x91M3Or2UUb1uk/akaPV5r9wC2zxr6TzsYxcOQY3A6IaCF
         3yXa/TFFXXpIiV4vb3v9bVu18X+F3I+eHFxP9mjSSc+goru26baut0AXtJ9/ZX9Z+QHP
         z++g==
X-Gm-Message-State: AFqh2krmhZfYxwYa2OvtZsFHeMG35It1JxSwlYYRE2+QC7HO2a49qZR6
        Y0cyNvP1pivU8Z+JR8sKdSBK2erQsWI=
X-Google-Smtp-Source: AMrXdXtiyA8dPtQxRcUx8Nj9sWD84zUfrXs213gxe1yhO4MQMxs/oC9r9JARd5n935dEigDrg0zF1g==
X-Received: by 2002:a05:600c:540c:b0:3cf:7704:50ce with SMTP id he12-20020a05600c540c00b003cf770450cemr15090193wmb.38.1674252536965;
        Fri, 20 Jan 2023 14:08:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az41-20020a05600c602900b003dab77aa911sm3540428wmb.23.2023.01.20.14.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:08:56 -0800 (PST)
Message-Id: <6e70e304cfe6372444a8070d27c7bcdc40ade046.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:43 +0000
Subject: [PATCH v7 05/12] test-http-server: add HTTP error response function
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
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@outlook.com>,
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
 t/helper/test-http-server.c | 76 +++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 6e9a1c479ce..7ca4ddc7999 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -76,11 +76,75 @@ enum worker_result {
 	 * Exit child-process with non-zero status.
 	 */
 	WR_FATAL_ERROR = 1,
+
+	/*
+	 * Close the socket and clean up. Does not imply an error.
+	 */
+	WR_HANGUP = 2,
 };
 
+static enum worker_result send_http_error(int fd, int http_code,
+					  const char *http_code_name,
+					  int retry_after_seconds,
+					  struct string_list *response_headers,
+					  enum worker_result wr_in)
+{
+	struct strbuf response_header = STRBUF_INIT;
+	struct strbuf response_content = STRBUF_INIT;
+	struct string_list_item *h;
+	enum worker_result wr;
+
+	strbuf_addf(&response_content, "Error: %d %s\r\n", http_code,
+		    http_code_name);
+
+	if (retry_after_seconds > 0)
+		strbuf_addf(&response_content, "Retry-After: %d\r\n",
+			    retry_after_seconds);
+
+	strbuf_addf(&response_header, "HTTP/1.1 %d %s\r\n", http_code,
+		    http_code_name);
+	strbuf_addstr(&response_header, "Cache-Control: private\r\n");
+	strbuf_addstr(&response_header, "Content-Type: text/plain\r\n");
+	strbuf_addf(&response_header, "Content-Length: %"PRIuMAX"\r\n",
+		    (uintmax_t)response_content.len);
+
+	if (retry_after_seconds > 0)
+		strbuf_addf(&response_header, "Retry-After: %d\r\n",
+			    retry_after_seconds);
+
+	strbuf_addf(&response_header, "Server: test-http-server/%s\r\n",
+		    git_version_string);
+	strbuf_addf(&response_header, "Date: %s\r\n", show_date(time(NULL), 0,
+		    DATE_MODE(RFC2822)));
+
+	if (response_headers)
+		for_each_string_list_item(h, response_headers)
+			strbuf_addf(&response_header, "%s\r\n", h->string);
+	strbuf_addstr(&response_header, "\r\n");
+
+	if (write_in_full(fd, response_header.buf, response_header.len) < 0) {
+		logerror("unable to write response header");
+		wr = WR_FATAL_ERROR;
+		goto done;
+	}
+
+	if (write_in_full(fd, response_content.buf, response_content.len) < 0) {
+		logerror("unable to write response content body");
+		wr = WR_FATAL_ERROR;
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
@@ -91,10 +155,8 @@ static enum worker_result worker(void)
 	set_keep_alive(0, logerror);
 
 	while (1) {
-		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
-			logerror("unable to write response");
-			wr = WR_FATAL_ERROR;
-		}
+		wr = send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1,
+				     NULL, WR_HANGUP);
 
 		if (wr != WR_OK)
 			break;
@@ -103,8 +165,8 @@ static enum worker_result worker(void)
 	close(STDIN_FILENO);
 	close(STDOUT_FILENO);
 
-	/* Only WR_OK should result in a non-zero exit code */
-	return wr != WR_OK;
+	/* Only WR_OK and WR_HANGUP should result in a non-zero exit code */
+	return wr != WR_OK && wr != WR_HANGUP;
 }
 
 static int max_connections = 32;
-- 
gitgitgadget

