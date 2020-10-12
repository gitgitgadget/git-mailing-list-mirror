Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C06C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753D720878
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMsqTLST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgJLSsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgJLSsS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 14:48:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBD6C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:48:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k9so7660102ybf.18
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5juivkZ5jlo3u09VQrufzxjUkil38qmJ5lRnAGAw3Nc=;
        b=EMsqTLSTSCkyyT+7V4R2Wt5WCYpNgcZacc4PSP+9J4XrvO0az2uJi+gQ1vQl04AZxh
         TK/c1ptntk0EzSg0caf2ivTf+Xv8OJgR25jZ34k9qUXC/LL2SiuaMG0Mrs/Z0E1vAZ1T
         MoNGBUoLRdqxQs9KnhSu4Ky0YuZF1Q+A9zkhPpVlcI2IyTP99gheeQhLAeub6QViFurs
         6apoKtozbDLaBnCqzheL1HsaC5YqVLnhFgwKE+A92eer/sCq6iNvrkwRd5go3IWlWUQB
         s8CkAd8c6hV1xOYfOuiOXgWJGx1xf9dn9HL6jfg4LBXTcyfH3rQU8OJ2VaKyy1NUGYae
         mB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5juivkZ5jlo3u09VQrufzxjUkil38qmJ5lRnAGAw3Nc=;
        b=kX3sjkShfyLL/IBh5hhbXOYJ4+CCvLoQrRuaHgtGBeGpGOk+N+4XJIhWaMp8kD78pL
         cLAwDZsJUiMHck4rzO9QjZhxDOwTdkznj/go60EzxcemSGTt/FwS482IAggVCDD1ou+O
         BRE7VlU8sEstnIXqIWx5hmQ0s6rEEsbq5bs29kVAQ9pLoaFa6JNGV6LAne+CCvhLoalk
         3qGmyuHl0E0ba9vk5fy4Av3BOGT01JXmPxiBfW3grX7+8dVxvBhzQqNwlHz0CzdOYrV6
         FCm26OPyPGZl47TCpcOJKfLXioQhFANIjFnKhhPVXmhezKLIw/2d9IFtOgEpUnEihTbe
         XXSw==
X-Gm-Message-State: AOAM530HwuAERfoqViPz4K6GUWbSQhK7hLA/dty0S1UNxXd1EYhITqJs
        8fZ5ycWHvOhoUJ8p283E13S8QZBvEz+D+NEm7lUo+khBOh7vy78yBuFNHDCWptomZM+DExwcCRG
        az3K8AjdrJwgFKbnYRchxr1GIsO2ney7lDe56tPLSe2Tp/hlQH3M/8kWZPvue8Xo=
X-Google-Smtp-Source: ABdhPJyKAwmi3M5KsIg90WDL0+aL3U5VC9lNR4gXTxbn1gC388g4uDDeGc6SodvGzyQoyxG8VCy90ecJUqBNGQ==
Sender: "smcallis via sendgmr" <smcallis@smcallis.bld.corp.google.com>
X-Received: from smcallis.bld.corp.google.com ([2620:15c:183:200:a6ae:11ff:fe11:fc5d])
 (user=smcallis job=sendgmr) by 2002:a5b:88b:: with SMTP id
 e11mr35669690ybq.202.1602528497142; Mon, 12 Oct 2020 11:48:17 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:48:05 -0600
In-Reply-To: <20201012184806.166251-1-smcallis@google.com>
Message-Id: <20201012184806.166251-2-smcallis@google.com>
Mime-Version: 1.0
References: <20201012184806.166251-1-smcallis@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH 2/3] replace CURLOPT_FILE With CURLOPT_WRITEDATA
From:   Sean McAllister <smcallis@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        masayasuzuki@google.com
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

