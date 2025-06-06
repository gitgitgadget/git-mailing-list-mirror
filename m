Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F492868A7
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202175; cv=none; b=iqkzqGTXpRsRDcUWj5AUl6+4u/guKtCrMdYYDxNt52xlcxZjVqxccxsS/MfObyY0wl21jGJCbmOjb+b+9oXvF6uFyMQCgKz7I3CKdwATu52vLEI7daQkFaNXKIS6kxeTGiYfL461MOEkGJRYwFhjyRFym32vpOyVxtuuWjyyFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202175; c=relaxed/simple;
	bh=7MkglDJTAt2z2YVd9yYMm4ceeIG71Ak7E+55FqdQEMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iJ1KUW33VNXYg8JkXmaEQ8U/aJxp7j1tVcThE0YgpLRxhMqavZkACgVgXFYeUo8NS+c+nBsZ6r7btj5umnPLxuA3ydcyk2B/Hq9/TZruSGvWGzcH8yhapvdhM5kfwqeCmi6mhfvrtnqoMEG/WxzBQrth4migzEBcHFiu0I4rzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J65MCbII; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J65MCbII"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a361b8a664so1561962f8f.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749202170; x=1749806970; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vK6OY6A6YhqcZTXUP1E4/9sMipAtyuj7xNieRvCDfM=;
        b=J65MCbIIajmcarFYqV8moo3Vixv3F8D8aUt/bVrkMEAXlMlC5MG4DZi3pnJsNbzOQn
         w6IEeBLsEWdv876XGJteGlum8YzzPMv8m8KrkmeTSDyOK9bvIaXusdC//pIcjZFOAk/l
         ZPNElIYkJniW+zWJ6XM9eEcLe2iFthzxAgVSIxDjx55mChqs4zDMbq/V356/k9dnv1H5
         oc1Vy4Czv6aUqr53lgdTnfnxTVzZve/j1jGAgHdtGaa6sa4VcuSQVwjTedsS5AscZuKf
         RuPCuFsmeyQSxXzHRzKw3cUNAzLzrC7tVIwq5JVuZIoCFE/BfIH4NFPqDyenOHrnYAME
         OJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202170; x=1749806970;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vK6OY6A6YhqcZTXUP1E4/9sMipAtyuj7xNieRvCDfM=;
        b=summpLtoR4SqqIa6QIARMIdXMcxe4k2z0RzbBwe6gFUf2AAFsky7nKP45mU1CT5v9Q
         YtzF85WAS4w8vp8N6VGkIrxcOH92662j3TZYa17b14rLVX7Bo2zJLZYV78s7KeANkffw
         0o8XWqUL8FWCSqrJ1736gzHr2JHMzp0zM6f5IJzLYZGLPDotUAjPLrHSQCJv09RFjgsb
         HqhU9TZoKJ8AR8M6C4FbjS5o0n4NX9rjbWisVBRRzz/jwfFjWjR9TMGpA26vFOMo33lh
         Wm8CidDg70KEjHPHvFs3g97loLGmGC66k0a7m7dob4kV0uqwBg+yqeeVWK95S73ytwW/
         KgqQ==
X-Gm-Message-State: AOJu0YzYfpIVS6QiqiU663aC1QsHHc1wigVexQLRJwHMZPvViFkw5Eg0
	eQ1nalWP5PSAHM9Z27wMULfQf8vcTfUAsKm3ygq5BFWgp2BTmnxTj5DEIsnjig==
X-Gm-Gg: ASbGnct3ko1EfWH+Qox6wRdJT2PDDtEnu5SaPEa9GpzkL9h/spxC5PvznLyeXQBeDb/
	zqwcU+XH/j+3hXEun4Jef9sMpZ9ucoZKIwOpbrt6G8ELeaJxMQJjMiTOX59HMD8MFznf7tEhTMT
	FNo7be7tDDEoI9jruczG05Zodh3dfELcPmpG2z0u/EiHXDdiPtFPHaYeLbN5TyKFNzd0sXplTfa
	ADbjIljI0sv6Lc5XUS2MLU4x7oKAUUgeIFm9li2KWVkQufbseSESlrQYi3LhbSMss6aGVu1W8ta
	FTMiRko6MjjvEHyDCfKqZbRyqP9QnDGrE3jhm+PFbvKMPLRzLzI5Ae5s2bxFdBM=
X-Google-Smtp-Source: AGHT+IHTg55m+61lXMnqOf9F8Z2uVHLEUPQzXx25qTA8SEqoClpO3mWRStj9j6LY43GcXLBYEl5eHw==
X-Received: by 2002:a05:6000:22c4:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3a5318abba0mr1995976f8f.26.1749202169715;
        Fri, 06 Jun 2025 02:29:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229ddebsm1335696f8f.17.2025.06.06.02.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:29:29 -0700 (PDT)
Message-Id: <80de7491d24fb51c6b2c3b2fc1728db30e2477f7.1749202164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
	<pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Jun 2025 09:29:24 +0000
Subject: [PATCH v2 4/4] curl: pass `long` values where expected
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of Homebrew's update to cURL v8.14.0, there are new compile errors to
be observed in the `osx-gcc` job of Git's CI builds:

  In file included from http.h:8,
                   from imap-send.c:36:
  In function 'setup_curl',
      inlined from 'curl_append_msgs_to_imap' at imap-send.c:1460:9,
      inlined from 'cmd_main' at imap-send.c:1581:9:
  /usr/local/Cellar/curl/8.14.0/include/curl/typecheck-gcc.h:50:15: error: call to '_curl_easy_setopt_err_long' declared with attribute warning: curl_easy_setopt expects a long argument [-Werror=attribute-warning]
     50 |               _curl_easy_setopt_err_long();                             \
        |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /usr/local/Cellar/curl/8.14.0/include/curl/curl.h:54:7: note: in definition of macro 'CURL_IGNORE_DEPRECATION'
     54 |       statements \
        |       ^~~~~~~~~~
  imap-send.c:1423:9: note: in expansion of macro 'curl_easy_setopt'
   1423 |         curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
        |         ^~~~~~~~~~~~~~~~
  [... many more instances of nearly identical warnings...]

See for example this CI workflow run:
https://github.com/git/git/actions/runs/15454602308/job/43504278284#step:4:307

The most likely explanation is the entry "typecheck-gcc.h: fix the
typechecks" in cURL's release notes (https://curl.se/ch/8.14.0.html).

Nearly identical compile errors afflicted recently-updated Debian
setups, which have been addressed by `jk/curl-easy-setopt-typefix`.

However, on macOS Git is built with different build options, which
uncovered more instances of `int` values that need to be cast to
constants, which were not covered by 6f11c42e8edc (curl: fix integer
constant typechecks with curl_easy_setopt(), 2025-06-04). Let's
explicitly convert even those remaining `int` constants in
`curl_easy_setopt()` calls to `long` parameters.

In addition to looking at the compile errors of the `osx-gcc` job, I
verified that there are no other instances of the same issue that need
to be handled in this manner (and that might not be caught by our CI
builds because of yet other build options that might skip those code
parts), I ran the following command and inspected all 23 results
manually to ensure that the fix is now actually complete:

  git grep -n curl_easy_setopt |
  grep -ve ',.*, *[A-Za-z_"&]' \
    -e ',.*, *[-0-9]*L)' \
    -e ',.*,.* (long)'

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-push.c   |  6 +++---
 http.c        | 22 +++++++++++-----------
 remote-curl.c |  6 +++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/http-push.c b/http-push.c
index 591e46ab260d..f5a92529a840 100644
--- a/http-push.c
+++ b/http-push.c
@@ -205,7 +205,7 @@ static void curl_setup_http(CURL *curl, const char *url,
 		const char *custom_req, struct buffer *buffer,
 		curl_write_callback write_fn)
 {
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
 	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
@@ -213,9 +213,9 @@ static void curl_setup_http(CURL *curl, const char *url,
 	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, seek_buffer);
 	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
-	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(curl, CURLOPT_NOBODY, 0L);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 }
 
 static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
diff --git a/http.c b/http.c
index ecbc47ea4b3f..d88e79fbde9c 100644
--- a/http.c
+++ b/http.c
@@ -1540,9 +1540,9 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, -1L);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0L);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1L);
 	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
 
 	/*
@@ -1551,9 +1551,9 @@ struct active_request_slot *get_active_slot(void)
 	 * HTTP_FOLLOW_* cases themselves.
 	 */
 	if (http_follow_config == HTTP_FOLLOW_ALWAYS)
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
 	else
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0L);
 
 	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
@@ -2120,12 +2120,12 @@ static int http_request(const char *url,
 	int ret;
 
 	slot = get_active_slot();
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
 
 	if (!result) {
-		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1L);
 	} else {
-		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
 		curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, result);
 
 		if (target == HTTP_REQUEST_FILE) {
@@ -2151,7 +2151,7 @@ static int http_request(const char *url,
 		strbuf_addstr(&buf, " no-cache");
 	if (options && options->initial_request &&
 	    http_follow_config == HTTP_FOLLOW_INITIAL)
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
 
 	headers = curl_slist_append(headers, buf.buf);
 
@@ -2170,7 +2170,7 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0L);
 
 	ret = run_one_slot(slot, &results);
 
@@ -2750,7 +2750,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	freq->headers = object_request_headers();
 
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0L);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
diff --git a/remote-curl.c b/remote-curl.c
index 6183772191f2..b8bc3a80cf41 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -970,8 +970,8 @@ retry:
 
 	slot = get_active_slot();
 
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 
@@ -1058,7 +1058,7 @@ retry:
 	rpc_in_data.check_pktline = stateless_connect;
 	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state));
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &rpc_in_data);
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0L);
 
 
 	rpc->any_written = 0;
-- 
gitgitgadget
