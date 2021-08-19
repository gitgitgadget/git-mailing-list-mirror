Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EC9C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 09:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BDD7610FE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 09:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhHSJPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 05:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbhHSJPV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 05:15:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C85EC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 02:14:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o10so3608169plg.0
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KSoNpPY+3m8vcI3uMv87aMIKwTpOP3ef572yWKlD8fE=;
        b=mHznF+4KYRVmeeH+Rm6OfnLdQHcqJ+HA0vQuhCtGhuKf8t/FsOR3ZEXkCzEaHtd8om
         RZPr2H6sncC7wTmOsocUWxvscevaAi2NIOL5Z7WuWR2eegzRryBoRsg1ZRpWBUmx9ePB
         XorbNUgY7f1N9RLJFQ3sV5d3OW2qdFX21BkLfaeuAj8UHrXgomIoHarAq2XTu1gg3bbd
         GY8VF7FW5NAa2mNuC2jM5LYeBieTYB1tzia4e+z8bJimf95Sajv9JfaNXneswo0Jjzb4
         Lhbbe8t5fDNXnajX34qjy6TUh0bb36w76L4MW6AMtT8ucMZFbIraUUIlccD7rzS1m+fF
         kVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KSoNpPY+3m8vcI3uMv87aMIKwTpOP3ef572yWKlD8fE=;
        b=DiEE/wwR5og3FQr8m/kSoAMXi+klRo4QcZtD4J9dSNo1xPNmCratvvFdgutwPGORvD
         7OESecJjDYU2nlxCsDpWyzNna05SQlUrvAFV/7FJJzWy+I2PLV4YjYdJlHS0mbcMg794
         feZ5cPPDv0s7SQ8lHYrlFF86Q0ZRbgbIOxtY97h7X3PvxEdaoYjd9IrrLU3alvmp5B2i
         mVS+wPNVLjRKDKpFoofLg/eRf8PBTAl3Gjz/a13geJhvRzco3jlq6Bp5G9ynNiuWkPak
         EuzK3B2XhpDDpm+SF42uK2jdO5SpVlySvAOTQ98BDyiJZVCqcfnr5LNCEEH4L9V1sQ4o
         Y+eg==
X-Gm-Message-State: AOAM530d1nbTo5u8qZ2QPeAhRo9VPs31bIjoZKJozPGrRPi31LEvG89R
        o5gfRITBICLATOjR1qUlV2e2PGgnmdql40fOsn8=
X-Google-Smtp-Source: ABdhPJxOKHqwYuAIVEiEjIIfC16UgqBgNIYjEQawM3TDhkGfJbcpsxnwf8hnqROaoAcsb38BzURjfw==
X-Received: by 2002:a17:90a:604e:: with SMTP id h14mr14108659pjm.181.1629364485023;
        Thu, 19 Aug 2021 02:14:45 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.145])
        by smtp.gmail.com with ESMTPSA id x20sm2535386pfh.188.2021.08.19.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 02:14:44 -0700 (PDT)
From:   Xia XiaoWen <haoyurenzhuxia@gmail.com>
X-Google-Original-From: Xia XiaoWen <chenan.xxw@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, worldhello.net@gmail.com,
        Xia XiaoWen <chenan.xxw@alibaba-inc.com>
Subject: [PATCH] add http.maxReceiveSpeed to limit git-receive-pack receiving speed
Date:   Thu, 19 Aug 2021 17:14:33 +0800
Message-Id: <20210819091433.348-1-chenan.xxw@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.29.g211eca0895.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes need to limit the receive speed of git `clone/fetch`
because of the limited network bandwidth, otherwise will prevent
other applications from using the network normally.

Add `http.maxReceiveSpeed` to limit `git-receive-pack` receiving
speed, Can be overridden by `GIT_HTTP_MAX_RECEIVE_SPEED` eivironment
variable.

The default is unlimited, same if the value is 0 or negative. The
default unit is Bytes/s, common unit suffixes of k, m, or g are supported.

this configuration is valid for `clone`, `fetch`, `pull` commands of the
https protocol, and only supports libcurl 7.15.5 and above.
---
 http.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 8119247149..12030cf3bc 100644
--- a/http.c
+++ b/http.c
@@ -83,6 +83,9 @@ static const char *ssl_pinnedkey;
 static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
+#if LIBCURL_VERSION_NUM >= 0x070f05
+static ssize_t curl_max_receive_speed = -1;
+#endif
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *http_proxy_authmethod;
@@ -361,7 +364,12 @@ static int http_options(const char *var, const char *value, void *cb)
 		curl_low_speed_time = (long)git_config_int(var, value);
 		return 0;
 	}
-
+#if LIBCURL_VERSION_NUM >= 0x070f05
+	if (!strcmp("http.maxreceivespeed", var)) {
+		curl_max_receive_speed = git_config_ssize_t(var, value);
+		return 0;
+	}
+#endif
 	if (!strcmp("http.noepsv", var)) {
 		curl_ftp_no_epsv = git_config_bool(var, value);
 		return 0;
@@ -974,6 +982,12 @@ static CURL *get_curl_handle(void)
 				 curl_low_speed_time);
 	}
 
+#if LIBCURL_VERSION_NUM >= 0x070f05
+	if (curl_max_receive_speed > 0)
+		curl_easy_setopt(result, CURLOPT_MAX_RECV_SPEED_LARGE,
+				 curl_max_receive_speed);
+#endif
+
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
 #if LIBCURL_VERSION_NUM >= 0x071301
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
@@ -1105,6 +1119,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
+#if LIBCURL_VERSION_NUM >= 0x070f05
+	char *max_receive_speed;
+#endif
 	char *normalized_url;
 	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
 
@@ -1196,6 +1213,11 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	low_speed_time = getenv("GIT_HTTP_LOW_SPEED_TIME");
 	if (low_speed_time != NULL)
 		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
+#if LIBCURL_VERSION_NUM >= 0x070f05
+	max_receive_speed = getenv("GIT_HTTP_MAX_RECEIVE_SPEED");
+	if (max_receive_speed && !git_parse_ssize_t(max_receive_speed, &curl_max_receive_speed))
+		warning("failed to parse GIT_HTTP_MAX_RECEIVE_SPEED: %s", max_receive_speed);
+#endif
 
 	if (curl_ssl_verify == -1)
 		curl_ssl_verify = 1;
-- 
2.28.1.49.gafcb914ae4.dirty.agit.6.3.1

