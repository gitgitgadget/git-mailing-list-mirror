Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CA26A0DB
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202171; cv=none; b=pf6z8J/aQuMazYrqHq782SNKlgzRQnaGwlCOiwHpSpMpm2S/zUp5UbKCT6iud7mu5P8QwbCAFN9ZFwXLJyVR//hviiQiQmEy4nvu7g7MdUPBlZj2xQbgm3gugjGHKosRmkh5P8Suw6440kewJdzMWiRl9C5lSeZ+QcKb1TwbBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202171; c=relaxed/simple;
	bh=Uqh9QyOQeMZGt8yhMTRoLg0zI4pFvjcxAHPnD89qIG8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WfSYEokI8zdJgVn+dR6F/PIhSQcVGurzPt4lqzBia65MU2B1BzCN3iH+OfGqaNtjNLD8LvKq9leV7bBv5voYVnzhsY4phFWrDBSD71NJ+OXlaAa1CKaf8bEtAhcjs6OjWvLWrQm9wQR72xfm9DD9BQwetxyWy9h9Bq2hhA0qXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoeB2GvZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoeB2GvZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450caff6336so11061115e9.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749202167; x=1749806967; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5xYyroevtw5+aVXWs//f6QLvP2oNYHUapqd4CzXFxU=;
        b=QoeB2GvZ9Izt0lOzu7w3/ZC99VHzzscWkCak16h+9HxwXohv2N6dtbxdDNAO2rQCjS
         0BKcXDNWJzoCv2DMkbtVY+6at/BmJhU0N6Hw+yWr6CL3LfYZR+ljrV8r6W3IdR17+JAP
         9WTLB7Bir6IqtL8qTE9J5mT32w1gn+FPGhlCnHrG4SBuVqp377HjhNRF7JjIKNt+Hqr/
         E7SnT1zAByT50uspp+7QOmyvRcJQD4j6Rb5z6M13qhdYZxKcEa1XiAlHaAn20jJWUPiS
         JMDJ1Nu1BkPyn1+cao361pj3CK/IS0PhqvLME8c2WO2SG2n/B4Syuge8EjMFNfS34XYX
         NVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202167; x=1749806967;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5xYyroevtw5+aVXWs//f6QLvP2oNYHUapqd4CzXFxU=;
        b=JLwjf/RK9JkUubsXnVscesDFITHSjv6gM7BIjBXL1aPB30AzhtF1LisCJiYLY6j8QU
         fu7IXodwVaSLixKmgKXP76IGug1E3g+283ot84kU//d1UsXVdBtDlDdv03eKnoY+DlQn
         nLRXghlCRR4bTHh41pa3g7bxjrm0e4Cjw8WF/n5MxmCSX9EMff02U1XXjNAntAT9nDS6
         DG0ZAz3MJVbT+JIihHS8hN1XyJ5Hrzttogp7lwjHzIN+/M4LEgRk1jthAUoCqiFUEhy3
         RgCSTLPaSUo4giwRJWy6ZUO2W9LiUfQJIil6tshuHXE7aSSNbrbkK32K1sZq7B38nC0b
         GZZg==
X-Gm-Message-State: AOJu0Yz3jFPoaC0xb/9kFvaff5DPJkZ3Bzbdd3egPFnb0ng+j/d2+3mF
	9zzIWuqGfGvKXIZ2PmKwv3W2YY7MqI9wVwbfbzJQK7bPf2I8giiTDC+fvz+kIw==
X-Gm-Gg: ASbGncuGFedTcnGH1v4zQteEo+pG3W7e4AFR2Ar5voCfFvtXNHgBKkscgElSrybxpSC
	X/AZgz2z2E3dIbyWq+E/HAkXQwxTaSEOBiyFCwGJ9TXeT/SxMn7th/Lhf+xoGOfdOqIVyDuGPUo
	NFfye1r9CDiONrNikrdeLpI5j1E6Fi0VoLpqQEKy4iSJHIV+YwsjljV1bF/CwyNpKxs5hBr9aXo
	PKbcryXvSFS8I3PmRh5KpbPnqIHjOo/afGyyhJHMqnJeC+ljmQEmzYGnINE8lxeakdOxMK24K1k
	40ejJzmCU3SVzuboFeLfadUu/mHvXJxSv8t1nhcObSk+v4BlISkm8HxVlpKlClY=
X-Google-Smtp-Source: AGHT+IF7LjDgdgMuQQ7/awgTbf/BU079Px1STzZmls0aaOx50qLX/SIst4EUvdxhr8EwFuBnYDb5Bw==
X-Received: by 2002:a05:600c:3482:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-4520138e5e0mr34322345e9.10.1749202167028;
        Fri, 06 Jun 2025 02:29:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730b9b3esm14775645e9.25.2025.06.06.02.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:29:26 -0700 (PDT)
Message-Id: <6f11c42e8edc5cf7d65156c9dd68e720f1b92229.1749202164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
	<pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
From: "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Jun 2025 09:29:21 +0000
Subject: [PATCH v2 1/4] curl: fix integer constant typechecks with
 curl_easy_setopt()
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
    Jeff King <peff@peff.net>

From: Jeff King <peff@peff.net>

The curl documentation specifies that curl_easy_setopt() takes either:

  ...a long, a function pointer, an object pointer or a curl_off_t,
  depending on what the specific option expects.

But when we pass an integer constant like "0", it will by default be a
regular non-long int. This has always been wrong, but seemed to work in
practice (I didn't dig into curl's implementation to see whether this
might actually be triggering undefined behavior, but it seems likely and
regardless we should do what the docs say).

This is especially important since curl has a type-checking macro that
causes building against curl 8.14 to produce many warnings. The specific
commit is due to their 79b4e56b3 (typecheck-gcc.h: fix the typechecks,
2025-04-22). Curiously, it does only seem to trigger when compiled with
-O2 for me.

We can fix it by just marking the constants with a long "L".

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http-push.c   |  2 +-
 http.c        | 14 +++++++-------
 remote-curl.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/http-push.c b/http-push.c
index f9e67cabd4be..591e46ab260d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -195,7 +195,7 @@ static char *xml_entities(const char *s)
 static void curl_setup_http_get(CURL *curl, const char *url,
 		const char *custom_req)
 {
-	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_null);
diff --git a/http.c b/http.c
index 3c029cf8947d..cce2ea728736 100644
--- a/http.c
+++ b/http.c
@@ -1019,13 +1019,13 @@ static CURL *get_curl_handle(void)
 		die("curl_easy_init failed");
 
 	if (!curl_ssl_verify) {
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0L);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0L);
 	} else {
 		/* Verify authenticity of the peer's certificate */
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1L);
 		/* The name in the cert must match whom we tried to connect */
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2L);
 	}
 
     if (curl_http_version) {
@@ -1117,7 +1117,7 @@ static CURL *get_curl_handle(void)
 				 curl_low_speed_time);
 	}
 
-	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
+	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20L);
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
 
 #ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
@@ -1151,7 +1151,7 @@ static CURL *get_curl_handle(void)
 		user_agent ? user_agent : git_user_agent());
 
 	if (curl_ftp_no_epsv)
-		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
+		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0L);
 
 	if (curl_ssl_try)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
@@ -1254,7 +1254,7 @@ static CURL *get_curl_handle(void)
 	}
 	init_curl_proxy_auth(result);
 
-	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1);
+	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1L);
 
 	if (curl_tcp_keepidle > -1)
 		curl_easy_setopt(result, CURLOPT_TCP_KEEPIDLE,
diff --git a/remote-curl.c b/remote-curl.c
index 590b228f67fc..6183772191f2 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -877,12 +877,12 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
 
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
-	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4L);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
-- 
gitgitgadget

