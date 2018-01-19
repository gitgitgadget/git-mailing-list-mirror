Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF431FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755254AbeASA20 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:28:26 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45592 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755191AbeASA2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:28:14 -0500
Received: by mail-pf0-f196.google.com with SMTP id a88so22055pfe.12
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k9pjBZpACYWMh+cVEV1d7JuhKfSt2BQA9bMOJmD5yjs=;
        b=T2Tzi4Onv1bkENtUnBuPK6Lw7pve3vjZiUeryVEUW5SB/oVQYWeJoGNLEaEUBGlCoR
         7etclWuYjdM8hXCMQlG+gPdyZaw+NV/dLq5MczjRvfXVBkHwXoBSyUn+JdgFLx+AGWEX
         KH7RLYq6Thcn46jwPHR8MIN7OME1a4/LNG1Up7AQCwbWS1/6x15Nvn2/q7JCdk1oWQW0
         ybubcE/D5YeSFYNV8URSW6YPcz+TYD1tfsgwacr14X9aX/ncpfw72M+jWfp/DROS9Qf+
         vw2Cv/GuP16AFWS/DQOGdHxAX6FfkxQGMxsme/w7rrqM1H9COzM1m9JPqluycf7nTylW
         q8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k9pjBZpACYWMh+cVEV1d7JuhKfSt2BQA9bMOJmD5yjs=;
        b=lxGMkTW4FrFAEewguP/flVpFzIJDh/Tp+Zd3X42epdqr8onHMxgogKmztWr8uprr1e
         ECf6a/4lSSzNSEH7x0xS3DUOwLyN44bzeytW3wSQ9wU7Isia+SIME3vfGjVZJpgxamWl
         Y5LHYxIr0AFSzZ05XrdZg7TszJZrjnhdOmGrQ2BcmMlBL8zEnngRNX3PO7f/NpRNHU/z
         apgMpJSD6cEYbAY7ojsgQJ4hQ5R83ZBerhcRSyRdKcaVMmpUZhsqOADfqHpobZJbRUnT
         1z8I/7KpDxfueVEhm3SiiLsK9RGuvdkt0uRVCE79+QxwN5hKxImnJx4XxRAp3L++2Ohq
         7Z5w==
X-Gm-Message-State: AKwxyteoFLedfkwUD/mnNbGJeC08MRMgrsBmDv9vQoaPczhCt4zYhhaR
        4T2krUqDllsia2bovG0ovbDkTI9nP3g=
X-Google-Smtp-Source: ACJfBour/PVHspKsLpSvgXXSTJPrD+7vlGpovkJ4EekTjnuqPzgSueXXGi493KhZdDb6FM29DuTTrA==
X-Received: by 10.98.108.130 with SMTP id h124mr28185810pfc.33.1516321693496;
        Thu, 18 Jan 2018 16:28:13 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id t1sm13571469pgs.73.2018.01.18.16.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:28:12 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sunshine@sunshineco.com
Subject: [PATCH v2 2/2] http: support omitting data from traces
Date:   Thu, 18 Jan 2018 16:28:02 -0800
Message-Id: <42366886098655a6bf712f55c6c0246e31218f6f.1516321355.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc2.37.ge0d575025.dirty
In-Reply-To: <cover.1516321355.git.jonathantanmy@google.com>
References: <cover.1516321355.git.jonathantanmy@google.com>
In-Reply-To: <cover.1516321355.git.jonathantanmy@google.com>
References: <cover.1516235197.git.jonathantanmy@google.com> <cover.1516321355.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GIT_TRACE_CURL provides a way to debug what is being sent and received
over HTTP, with automatic redaction of sensitive information. But it
also logs data transmissions, which significantly increases the log file
size, sometimes unnecessarily. Add an option "GIT_TRACE_CURL_NO_DATA" to
allow the user to omit such data transmissions.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git.txt       |  4 ++++
 http.c                      | 27 +++++++++++++++++++--------
 t/t5551-http-fetch-smart.sh | 12 ++++++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5446d2143..8163b5796 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -646,6 +646,10 @@ of clones and fetches.
 	variable.
 	See `GIT_TRACE` for available trace output options.
 
+`GIT_TRACE_CURL_NO_DATA`::
+	When a curl trace is enabled (see `GIT_TRACE_CURL` above), do not dump
+	data (that is, only dump info lines and headers).
+
 `GIT_REDACT_COOKIES`::
 	This can be set to a comma-separated list of strings. When a curl trace
 	is enabled (see `GIT_TRACE_CURL` above), whenever a "Cookies:" header
diff --git a/http.c b/http.c
index 088cf70bf..32a823895 100644
--- a/http.c
+++ b/http.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
+static int trace_curl_data = 1;
 static struct string_list cookies_to_redact = STRING_LIST_INIT_DUP;
 #if LIBCURL_VERSION_NUM >= 0x070a08
 long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
@@ -695,24 +696,32 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 		curl_dump_header(text, (unsigned char *)data, size, DO_FILTER);
 		break;
 	case CURLINFO_DATA_OUT:
-		text = "=> Send data";
-		curl_dump_data(text, (unsigned char *)data, size);
+		if (trace_curl_data) {
+			text = "=> Send data";
+			curl_dump_data(text, (unsigned char *)data, size);
+		}
 		break;
 	case CURLINFO_SSL_DATA_OUT:
-		text = "=> Send SSL data";
-		curl_dump_data(text, (unsigned char *)data, size);
+		if (trace_curl_data) {
+			text = "=> Send SSL data";
+			curl_dump_data(text, (unsigned char *)data, size);
+		}
 		break;
 	case CURLINFO_HEADER_IN:
 		text = "<= Recv header";
 		curl_dump_header(text, (unsigned char *)data, size, NO_FILTER);
 		break;
 	case CURLINFO_DATA_IN:
-		text = "<= Recv data";
-		curl_dump_data(text, (unsigned char *)data, size);
+		if (trace_curl_data) {
+			text = "<= Recv data";
+			curl_dump_data(text, (unsigned char *)data, size);
+		}
 		break;
 	case CURLINFO_SSL_DATA_IN:
-		text = "<= Recv SSL data";
-		curl_dump_data(text, (unsigned char *)data, size);
+		if (trace_curl_data) {
+			text = "<= Recv SSL data";
+			curl_dump_data(text, (unsigned char *)data, size);
+		}
 		break;
 
 	default:		/* we ignore unknown types by default */
@@ -857,6 +866,8 @@ static CURL *get_curl_handle(void)
 	if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
 	setup_curl_trace(result);
+	if (getenv("GIT_TRACE_CURL_NO_DATA"))
+		trace_curl_data = 0;
 	if (getenv("GIT_REDACT_COOKIES")) {
 		string_list_split(&cookies_to_redact,
 				  getenv("GIT_REDACT_COOKIES"), ',', -1);
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 21a5ce860..f5721b4a5 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -385,5 +385,17 @@ test_expect_success 'GIT_REDACT_COOKIES handles empty values' '
 	grep "Cookie:.*Foo=<redacted>" err
 '
 
+test_expect_success 'GIT_TRACE_CURL_NO_DATA prevents data from being traced' '
+	rm -rf clone &&
+	GIT_TRACE_CURL=true \
+		git clone $HTTPD_URL/smart/repo.git clone 2>err &&
+	grep "=> Send data" err &&
+
+	rm -rf clone &&
+	GIT_TRACE_CURL=true GIT_TRACE_CURL_NO_DATA=1 \
+		git clone $HTTPD_URL/smart/repo.git clone 2>err &&
+	! grep "=> Send data" err
+'
+
 stop_httpd
 test_done
-- 
2.16.0.rc2.37.ge0d575025.dirty

