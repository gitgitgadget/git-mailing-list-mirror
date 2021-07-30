Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF17FC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 18:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B554660F6B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 18:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhG3SAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 14:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhG3R77 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 13:59:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E88C0613C1
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:59:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so9714032wmh.3
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6o5kUgFHhpTrHI4BOk551Bv21+1Ku1BIvQtXSC3b/Zk=;
        b=vdXTAbqT60bbKyaCm6YUHoG/SCzuu4dfFK6lThE8IJxamlkYYv+UbvL31eIAgj63oG
         lfprdjtRZqIbS4gq5q7MSRnsUYFKliV+d2wH4vgXZqL5gGY+vFS0UGmQUc40DqNyEhx6
         VpjjgRHwfm8F5bSGDevBRi+AoTiFm7en5iHd5U/SPwEb0wl/jO1H7SniFwJyrTGJMxQ8
         sYjkt/0eXo3fTej8zVxwl9jtdLOmaB7Gs/po/DrBJ6jnRJkXYHHbr5W/UPb2VGuQjCtk
         Eqrb4RIUBm1SwTXXRiiNwqgOD4w9K2YWUcWpPxKlDnc0CMfe+eUiODuELnye26rnN7SI
         zXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6o5kUgFHhpTrHI4BOk551Bv21+1Ku1BIvQtXSC3b/Zk=;
        b=ZvQM/zTM6D2XzhMHV+jXVlSSKXRoByXM0/pctbci09bc4v+xp99i+cqH6ONBoZ88+6
         6zcusa5bd0vvCg0cvYIc3GVkTw7C0M8xNmsRBDqC677g6j1A5QvQWMnoghMtxOS1pwiY
         7jxTHcpChFGzipf0YIw1Dk+kOElr3ws+aKTseH+tKTSUv/X7uZdAMgINZ8ZBdM9Igdxg
         gJMin3TXv1H7NW6t8bQMbOPTUwuV2+ac2xg075l15m5B1MD/XtWPWVxRvfyn5PkUA6w7
         olj/vo3mmYiPYkG1p+2SLO3hegSWp+4U4LlsatL0NqsTFyX8og28YWc9zUkJddbzmhsJ
         UXlQ==
X-Gm-Message-State: AOAM533mlvBlsV8u1VpX8zI5tFKsbk4CRVTGmcUHosv7z4GXBKgzVQfs
        TEMIWONRkg6l2NjZo1INrAsCvGKA11PKkw==
X-Google-Smtp-Source: ABdhPJxNePWXJxZv7Mwc8EUiyD+i8NxrBQBOQeStOW483KbH1O5pH2/fTlrEEFxoQzFwhVC/z/2C3w==
X-Received: by 2002:a1c:1bcd:: with SMTP id b196mr4069463wmb.160.1627667991357;
        Fri, 30 Jul 2021 10:59:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i186sm2540311wmi.43.2021.07.30.10.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 10:59:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/5] http: drop support for curl < 7.19.4
Date:   Fri, 30 Jul 2021 19:59:44 +0200
Message-Id: <patch-v4-3.5-fba5560a3ba-20210730T175650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1071.g36f34456314
In-Reply-To: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In the last commit we dropped support for curl < 7.16.0, let's
continue that and drop support for versions older than 7.19.3. This
allows us to simplify the code by getting rid of some "#ifdef"'s.

Git was broken with vanilla curl < 7.19.4 from v2.12.0 until
v2.15.0. Compiling with it was broken by using CURLPROTO_* outside any
"#ifdef" in aeae4db174 (http: create function to get curl allowed
protocols, 2016-12-14), and fixed in v2.15.0 in f18777ba6ef (http: fix
handling of missing CURLPROTO_*, 2017-08-11).

It's unclear how much anyone was impacted by that in practice, since
as noted in [1] RHEL versions using curl older than that still
compiled, because RedHat backported some features. Perhaps other
vendors did the same.

Still, it's one datapoint indicating that it wasn't in active use at
the time. That (the v2.12.0 release) was in Feb 24, 2017, with v2.15.0
on Oct 30, 2017, it's now mid-2021.

1. http://lore.kernel.org/git/c8a2716d-76ac-735c-57f9-175ca3acbcb0@jupiterrise.com;
   followed-up by f18777ba6ef (http: fix handling of missing CURLPROTO_*,
   2017-08-11)

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http.c | 50 --------------------------------------------------
 http.h |  4 ----
 2 files changed, 54 deletions(-)

diff --git a/http.c b/http.c
index ef00e930232..1f0d7664d35 100644
--- a/http.c
+++ b/http.c
@@ -28,9 +28,7 @@ static int min_curl_sessions = 1;
 static int curl_session_count;
 static int max_requests = -1;
 static CURLM *curlm;
-#ifndef NO_CURL_EASY_DUPHANDLE
 static CURL *curl_default;
-#endif
 
 #define PREV_BUF_SIZE 4096
 
@@ -440,24 +438,8 @@ static void init_curl_http_auth(CURL *result)
 
 	credential_fill(&http_auth);
 
-#if LIBCURL_VERSION_NUM >= 0x071301
 	curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
 	curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
-#else
-	{
-		static struct strbuf up = STRBUF_INIT;
-		/*
-		 * Note that we assume we only ever have a single set of
-		 * credentials in a given program run, so we do not have
-		 * to worry about updating this buffer, only setting its
-		 * initial value.
-		 */
-		if (!up.len)
-			strbuf_addf(&up, "%s:%s",
-				http_auth.username, http_auth.password);
-		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);
-	}
-#endif
 }
 
 /* *var must be free-able */
@@ -471,22 +453,10 @@ static void var_override(const char **var, char *value)
 
 static void set_proxyauth_name_password(CURL *result)
 {
-#if LIBCURL_VERSION_NUM >= 0x071301
 		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
 			proxy_auth.username);
 		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
 			proxy_auth.password);
-#else
-		struct strbuf s = STRBUF_INIT;
-
-		strbuf_addstr_urlencode(&s, proxy_auth.username,
-					is_rfc3986_unreserved);
-		strbuf_addch(&s, ':');
-		strbuf_addstr_urlencode(&s, proxy_auth.password,
-					is_rfc3986_unreserved);
-		curl_proxyuserpwd = strbuf_detach(&s, NULL);
-		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
-#endif
 }
 
 static void init_curl_proxy_auth(CURL *result)
@@ -748,7 +718,6 @@ void setup_curl_trace(CURL *handle)
 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
 }
 
-#ifdef CURLPROTO_HTTP
 static long get_curl_allowed_protocols(int from_user)
 {
 	long allowed_protocols = 0;
@@ -764,7 +733,6 @@ static long get_curl_allowed_protocols(int from_user)
 
 	return allowed_protocols;
 }
-#endif
 
 #if LIBCURL_VERSION_NUM >=0x072f00
 static int get_curl_http_version_opt(const char *version_string, long *opt)
@@ -906,19 +874,11 @@ static CURL *get_curl_handle(void)
 	}
 
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
-#if LIBCURL_VERSION_NUM >= 0x071301
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
-#elif LIBCURL_VERSION_NUM >= 0x071101
-	curl_easy_setopt(result, CURLOPT_POST301, 1);
-#endif
-#ifdef CURLPROTO_HTTP
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
 			 get_curl_allowed_protocols(0));
 	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
 			 get_curl_allowed_protocols(-1));
-#else
-	warning(_("Protocol restrictions not supported with cURL < 7.19.4"));
-#endif
 	if (getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(result);
@@ -1012,11 +972,9 @@ static CURL *get_curl_handle(void)
 			die("Invalid proxy URL '%s'", curl_http_proxy);
 
 		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
-#if LIBCURL_VERSION_NUM >= 0x071304
 		var_override(&curl_no_proxy, getenv("NO_PROXY"));
 		var_override(&curl_no_proxy, getenv("no_proxy"));
 		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
-#endif
 	}
 	init_curl_proxy_auth(result);
 
@@ -1147,9 +1105,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 			ssl_cert_password_required = 1;
 	}
 
-#ifndef NO_CURL_EASY_DUPHANDLE
 	curl_default = get_curl_handle();
-#endif
 }
 
 void http_cleanup(void)
@@ -1167,9 +1123,7 @@ void http_cleanup(void)
 	}
 	active_queue_head = NULL;
 
-#ifndef NO_CURL_EASY_DUPHANDLE
 	curl_easy_cleanup(curl_default);
-#endif
 
 	curl_multi_cleanup(curlm);
 	curl_global_cleanup();
@@ -1248,11 +1202,7 @@ struct active_request_slot *get_active_slot(void)
 	}
 
 	if (slot->curl == NULL) {
-#ifdef NO_CURL_EASY_DUPHANDLE
-		slot->curl = get_curl_handle();
-#else
 		slot->curl = curl_easy_duphandle(curl_default);
-#endif
 		curl_session_count++;
 	}
 
diff --git a/http.h b/http.h
index cb092622a73..19f19dbe74c 100644
--- a/http.h
+++ b/http.h
@@ -12,10 +12,6 @@
 
 #define DEFAULT_MAX_REQUESTS 5
 
-#if LIBCURL_VERSION_NUM == 0x071000
-#define NO_CURL_EASY_DUPHANDLE
-#endif
-
 /*
  * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
  * and the constants were known as CURLFTPSSL_*
-- 
2.32.0.1071.g36f34456314

