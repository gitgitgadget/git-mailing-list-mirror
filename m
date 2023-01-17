Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA584C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjAQVBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAQVAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:00:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901464A1CD
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:27:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l8so5964007wms.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UwCRvuePlHoCmLmrwvm7lRtCJ/FTOgAxgYkK1DkwH+0=;
        b=koT+IRqxKgXCRs9qDfsIkUrjJjHjwZ23iade93vcn37x/YHXEd8EfctZ4zFJFgpd4L
         MRQJ07PmSm7SewcPPqMO1PqB7CorbjJgQuFrJxCWi6JrQgxZgBKXgocS5oBFPe1P3e8F
         nkxYj545zLps8T31Z3MMFMhYYYPgmx3syyMKOueBCejKYbXiGUD4UVQURgI0xs+RmSx1
         iSiA4dwzkPHYbqDhyJqmjxo9NnQCR54osaU44BQPEsl1pdPoFOkZOjyICjljXng5yoGb
         ZUqwQG/QPpRLJnwfA/TbU912XYDSQoAAchKqoh8GD16lB0J1VBfyhc5shSVWzsyTWsO+
         sbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwCRvuePlHoCmLmrwvm7lRtCJ/FTOgAxgYkK1DkwH+0=;
        b=2jte/9NTbqc2EFZay7avXJ/ZsY4mPDktyag9o8NfO4T3NuoFOl0GQ9WOSqgQsGZOT0
         jfTwGLFHTG7MjSRgJs7tIGIDHb8eQ8XCsUmHSd1MueaO72QCQJwx2+gNh89tjOQPl/5V
         WSpLMpw8lyCHMFn4t6z6+QE+KyAwqXzVA0RHzl8Tf9SqhwkjIe4pc3KEwiTOewUHzpYq
         pqwJZeQ2QhBZvOWvAc1PaNdEMfLIqiyQv1b9Xe4HQJ0mND2s4EkRf9y/LNm13/TBHLWd
         OvswV9OW3bLmq69m2ArqOHqSS5mpg4xudG7OhCMmCpecFxjZFQsYFQhZHAtHq4+9fFJ6
         eoXg==
X-Gm-Message-State: AFqh2krI1XT6ArSIbQETUMiJS7SOU2aM8U/axtMlrDhsF7/1lLF7Z9CX
        tMGfGzmBJaMZGxgTtufSSuYe64no56I=
X-Google-Smtp-Source: AMrXdXuMAZI3LRvIlYt5jSh+442fwGXRBHrjULZMYEK1iAfuUnrXhf3RymnkqyzbycpvkECz8Ej5YA==
X-Received: by 2002:a05:600c:3ca6:b0:3d1:caf1:3f56 with SMTP id bg38-20020a05600c3ca600b003d1caf13f56mr13017142wmb.9.1673983641789;
        Tue, 17 Jan 2023 11:27:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003c70191f267sm46141015wmo.39.2023.01.17.11.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:27:21 -0800 (PST)
Message-Id: <pull.1435.git.git.1673983640663.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Jan 2023 19:27:20 +0000
Subject: [PATCH] curl: resolve deprecated curl declarations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Fix CI-Alpine build by replacing deprecated
declarations with their suggested replacements

Note that this required changing the
callbacks of functions because the replacement
for these deprecations require a different function
signature for the callback and different parameters.

Every change done was made as to minimize
changed behavior as well as get the CI to pass again.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    curl: resolve deprecated curl declarations
    
    Fix CI-Alpine build by replacing deprecated declarations with their
    suggested replacements
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1435%2FAtariDreams%2Fcurl-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1435/AtariDreams/curl-v1
Pull-Request: https://github.com/git/git/pull/1435

 git-curl-compat.h |  8 +++++
 http-push.c       |  6 ++--
 http.c            | 74 ++++++++++++++++++++++++++++++++++++++---------
 http.h            |  2 +-
 remote-curl.c     | 28 +++++++-----------
 5 files changed, 83 insertions(+), 35 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 56a83b6bbd8..a2e6ad79b09 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -127,3 +127,11 @@
 #endif
 
 #endif
+
+/**
+ * CURLOPT_REDIR_PROTOCOLS_STR was added in 7.83.0, released in August
+ * 2022.
+ */
+#if LIBCURL_VERSION_NUM >= 0x075500
+#define GIT_CURL_HAVE_OPT_REDIR_PROTOCOLS_STR 1
+#endif
diff --git a/http-push.c b/http-push.c
index 5f4340a36e6..ab458d4d062 100644
--- a/http-push.c
+++ b/http-push.c
@@ -198,13 +198,13 @@ static void curl_setup_http(CURL *curl, const char *url,
 		const char *custom_req, struct buffer *buffer,
 		curl_write_callback write_fn)
 {
-	curl_easy_setopt(curl, CURLOPT_PUT, 1);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
 	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-	curl_easy_setopt(curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
-	curl_easy_setopt(curl, CURLOPT_IOCTLDATA, buffer);
+	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, ioctl_buffer);
+	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
 	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
diff --git a/http.c b/http.c
index 8a5ba3f4776..60bc84ab9a3 100644
--- a/http.c
+++ b/http.c
@@ -157,21 +157,12 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return size / eltsize;
 }
 
-curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
+int ioctl_buffer(void *userp, curl_off_t offset, int origin)
 {
-	struct buffer *buffer = clientp;
+	struct buffer *buffer = userp;
 
-	switch (cmd) {
-	case CURLIOCMD_NOP:
-		return CURLIOE_OK;
-
-	case CURLIOCMD_RESTARTREAD:
-		buffer->posn = 0;
-		return CURLIOE_OK;
-
-	default:
-		return CURLIOE_UNKNOWNCMD;
-	}
+	buffer->posn = 0;
+	return CURL_SEEKFUNC_OK;
 }
 
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
@@ -765,7 +756,52 @@ void setup_curl_trace(CURL *handle)
 	curl_easy_setopt(handle, CURLOPT_DEBUGFUNCTION, curl_trace);
 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
 }
+#ifdef GIT_CURL_HAVE_OPT_REDIR_PROTOCOLS_STR
+static void get_curl_allowed_protocols(int from_user, char *protocol)
+{
+	unsigned int i = 0;
+
+	if (is_transport_allowed("http", from_user)) {
+		protocol[i++] = 'h';
+		protocol[i++] = 't';
+		protocol[i++] = 't';
+		protocol[i++] = 'p';
+	}
+
+	if (is_transport_allowed("https", from_user)) {
+		if (i != 0) {
+			protocol[i++] = ',';
+		}
+
+		protocol[i++] = 'h';
+		protocol[i++] = 't';
+		protocol[i++] = 't';
+		protocol[i++] = 'p';
+		protocol[i++] = 's';
+	}
+	if (is_transport_allowed("ftp", from_user)) {
+		if (i != 0) {
+			protocol[i++] = ',';
+		}
 
+		protocol[i++] = 'f';
+		protocol[i++] = 't';
+		protocol[i++] = 'p';
+	}
+	if (is_transport_allowed("ftps", from_user)) {
+		if (i != 0) {
+			protocol[i++] = ',';
+		}
+
+		protocol[i++] = 'f';
+		protocol[i++] = 't';
+		protocol[i++] = 'p';
+		protocol[i++] = 's';
+	}
+
+	protocol[i] = '\0';
+}
+#else
 static long get_curl_allowed_protocols(int from_user)
 {
 	long allowed_protocols = 0;
@@ -781,6 +817,7 @@ static long get_curl_allowed_protocols(int from_user)
 
 	return allowed_protocols;
 }
+#endif
 
 #ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
 static int get_curl_http_version_opt(const char *version_string, long *opt)
@@ -810,6 +847,9 @@ static int get_curl_http_version_opt(const char *version_string, long *opt)
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
+#ifdef GIT_CURL_HAVE_OPT_REDIR_PROTOCOLS_STR
+	static char protocol[20], redir_protocol[20];
+#endif
 
 	if (!result)
 		die("curl_easy_init failed");
@@ -923,10 +963,18 @@ static CURL *get_curl_handle(void)
 
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
+#ifdef GIT_CURL_HAVE_OPT_REDIR_PROTOCOLS_STR
+	get_curl_allowed_protocols(0, redir_protocol);
+	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS_STR, redir_protocol);
+	get_curl_allowed_protocols(-1, protocol);
+	curl_easy_setopt(result, CURLOPT_PROTOCOLS_STR, protocol);
+#else
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
 			 get_curl_allowed_protocols(0));
 	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
 			 get_curl_allowed_protocols(-1));
+#endif
+
 	if (getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(result);
diff --git a/http.h b/http.h
index 3c94c479100..0ec572d4a06 100644
--- a/http.h
+++ b/http.h
@@ -40,7 +40,7 @@ struct buffer {
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
-curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
+int ioctl_buffer(void *userp, curl_off_t offset, int origin);
 
 /* Slot lifecycle functions */
 struct active_request_slot *get_active_slot(void);
diff --git a/remote-curl.c b/remote-curl.c
index 72dfb8fb86a..ae69dcb70d5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -717,25 +717,17 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	return avail;
 }
 
-static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
+static int rpc_ioctl(void *userp, curl_off_t offset, int origin)
 {
-	struct rpc_state *rpc = clientp;
+	struct rpc_state *rpc = userp;
 
-	switch (cmd) {
-	case CURLIOCMD_NOP:
-		return CURLIOE_OK;
-
-	case CURLIOCMD_RESTARTREAD:
-		if (rpc->initial_buffer) {
-			rpc->pos = 0;
-			return CURLIOE_OK;
-		}
-		error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
-		return CURLIOE_FAILRESTART;
-
-	default:
-		return CURLIOE_UNKNOWNCMD;
+	if (rpc->initial_buffer) {
+		rpc->pos = 0;
+		return CURL_SEEKFUNC_OK;
 	}
+
+	error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
+	return CURL_SEEKFUNC_FAIL;
 }
 
 struct check_pktline_state {
@@ -959,8 +951,8 @@ retry:
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
-		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, rpc_ioctl);
-		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, rpc);
+		curl_easy_setopt(slot->curl, CURLOPT_SEEKFUNCTION, rpc_ioctl);
+		curl_easy_setopt(slot->curl, CURLOPT_SEEKDATA, rpc);
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (chunked)\n", rpc->service_name);
 			fflush(stderr);

base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
-- 
gitgitgadget
