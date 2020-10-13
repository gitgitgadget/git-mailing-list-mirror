Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB23C43457
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51CEB20BED
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rsig7VPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgJMTRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJMTRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:17:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA6C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:17:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v4so879789ybp.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5juivkZ5jlo3u09VQrufzxjUkil38qmJ5lRnAGAw3Nc=;
        b=Rsig7VPHkKp94qgTL1N14WCh4UKptQ6MBxXubysA5kDK76WknXzJvNTQR9EMPcmLC6
         5Kp3BqT3eyj1lI2Nde8G3mZ8SlomXhD2MBecvB3NAlvML9rYXf/4y2P6B+n73pjT/0CW
         JyNwOhBxkWve7MFs+1wsXs4jFCJ3/hRmIZHZVldESie5etqKlyNjZqCKxaGef8TVxk6O
         0UfFRr94nDOhveD5UFA0v8SOwjutW39RksxnIW65d+7LRS0uK4/LMmvtszDXV+6ErAWD
         1OiiKuKWI/+NcUlPOLYVCYQSqJAL9mPpTX2TwK4VoROoUySydTeJhVP8KaZYwwgrUsi8
         6J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5juivkZ5jlo3u09VQrufzxjUkil38qmJ5lRnAGAw3Nc=;
        b=aupFRC8QIbuuuuxzLRVqPCkkIab9lQ1J/VqRt8uNQKEkznWetrYlI1uQOv1/fieorx
         mJfBN3K0Pp7Oc9pbuIUw5UPzg88aQ6PlmrS2jbXp7HqjN36lvSA2U1e1BoE02jyOAJAR
         a9/IR73HWct6eCMXe5v/QkII5SonDbz0DZlpnUdfmDOZMaG2jarhnjr9SxlKXq7Aj6XF
         tQC21EmDey7dj6l5rIk36/fM8equqScTc1F9DHd+zNGVf8BPA4Z0SH2vdhZwnJg6rXjr
         yg7Wb41s9VpHO3s1ZPLTZcUv0Ka450aRR8IBXaP2XVnfI84+MAtxhlNIQ08v8JQIx72O
         rTFQ==
X-Gm-Message-State: AOAM532QSekpdH4hJsUQVVs44Ln+9z761+O41PTcuki4oZcJUKgJutYX
        s7VogxAI8UspO5d+ntdYiHx6Ew6kDed1BFSVwzjDS/raKTizbWgTpFw3b8GBl7chgjpz/ZIndaq
        tvSk1x8QC/HoIKDkRR2NoL5aOezD12LhQu6zWyn7KYOES6uIlFvAsR+Yd9uYDWy4=
X-Google-Smtp-Source: ABdhPJyvhZT4UzD4sBGF23HNQWHl2R4Wcuzqw9GaV5dYwxqJBeX8pLYzHjDBuL0eBQhw6ja8UfjT8lnfONrH4Q==
Sender: "smcallis via sendgmr" <smcallis@smcallis.bld.corp.google.com>
X-Received: from smcallis.bld.corp.google.com ([2620:15c:183:200:a6ae:11ff:fe11:fc5d])
 (user=smcallis job=sendgmr) by 2002:a25:c287:: with SMTP id
 s129mr2062346ybf.489.1602616663243; Tue, 13 Oct 2020 12:17:43 -0700 (PDT)
Date:   Tue, 13 Oct 2020 13:17:28 -0600
In-Reply-To: <20201013191729.2524700-1-smcallis@google.com>
Message-Id: <20201013191729.2524700-2-smcallis@google.com>
Mime-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 2/3] replace CURLOPT_FILE With CURLOPT_WRITEDATA
From:   Sean McAllister <smcallis@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        masayasuzuki@google.com, jrnieder@gmail.com
Cc:     Sean McAllister <smcallis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CURLOPT_FILE has been deprecated since 2003.

Signed-off-by: Sean McAllister <smcallis@google.com>
---
 http-push.c   | 6 +++---
 http-walker.c | 2 +-
 http.c        | 6 +++---
 remote-curl.c | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/http-push.c b/http-push.c
index 6a4a43e07f..2e6fee3305 100644
--- a/http-push.c
+++ b/http-push.c
@@ -894,7 +894,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	slot->results = &results;
 	curl_setup_http(slot->curl, url, DAV_LOCK, &out_buffer, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
 
 	lock = xcalloc(1, sizeof(*lock));
 	lock->timeout = -1;
@@ -1151,7 +1151,7 @@ static void remote_ls(const char *path, int flags,
 	curl_setup_http(slot->curl, url, DAV_PROPFIND,
 			&out_buffer, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -1225,7 +1225,7 @@ static int locking_available(void)
 	curl_setup_http(slot->curl, repo->url, DAV_PROPFIND,
 			&out_buffer, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
diff --git a/http-walker.c b/http-walker.c
index 4fb1235cd4..6c630711d1 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -384,7 +384,7 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	alt_req.walker = walker;
 	slot->callback_data = &alt_req;
 
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url.buf);
 
diff --git a/http.c b/http.c
index 8b23a546af..b3c1669388 100644
--- a/http.c
+++ b/http.c
@@ -1921,7 +1921,7 @@ static int http_request(const char *url,
 		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
 	} else {
 		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-		curl_easy_setopt(slot->curl, CURLOPT_FILE, result);
+		curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, result);
 
 		if (target == HTTP_REQUEST_FILE) {
 			off_t posn = ftello(result);
@@ -2337,7 +2337,7 @@ struct http_pack_request *new_direct_http_pack_request(
 	}
 
 	preq->slot = get_active_slot();
-	curl_easy_setopt(preq->slot->curl, CURLOPT_FILE, preq->packfile);
+	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEDATA, preq->packfile);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
@@ -2508,7 +2508,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 
 	freq->slot = get_active_slot();
 
-	curl_easy_setopt(freq->slot->curl, CURLOPT_FILE, freq);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
diff --git a/remote-curl.c b/remote-curl.c
index 32cc4a0c55..7f44fa30fe 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -847,7 +847,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
 
 	err = run_slot(slot, results);
 
@@ -1012,7 +1012,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	rpc_in_data.slot = slot;
 	rpc_in_data.check_pktline = stateless_connect;
 	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state));
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &rpc_in_data);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &rpc_in_data);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
 
-- 
2.28.0.1011.ga647a8990f-goog

