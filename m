Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93591F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeJOR7U (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:59:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41601 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJOR7U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:59:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so9072120plr.8
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XPR6UWqsjqif9jAgEp08erZbJ04slvH4snftfy0ci7Q=;
        b=UL5MK6GVO0U/0QIB6d39tWH6NkIuz/pocupMt/F4wBcc6zq9vxlP5pCPthBC1iJG5U
         E5ItFYzkPAuRtZ3/CqKKR5K4VhF+GmGuVmU6MUfCoKBLdGORyjMovlvAwJsonzda8ARX
         tOQpjgL9vTjGta2oh3PCWbmpGH0ozI837XUag2DR7d+WYRUtcR89sNNbW7uNch3bRc8T
         kcPiiYYke+TEat0Cjj/PRaStxFIiLGc6nS/9hfNzQGn26si4NsFnPbnmcAShEQGVIBsg
         MCTx6i6rj3zkdRIxLw4uCXGK0EAvc80DbcAWcOUfqI3P9/s38ZKHBwZE1PLLbnP7n4P5
         1AbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XPR6UWqsjqif9jAgEp08erZbJ04slvH4snftfy0ci7Q=;
        b=r6vo9CWp172ukXnh5Rh72A3QL3joCMNGjvVjd1pfUPhOPQJVViSLfq6nbpeLU0jaKq
         UQaDbEDspiuX87tFjsQDcxFckhY8acw1nXvT6wsFMUYXDls5DPJFEquqXo++P7NWyAVO
         01X4D0W8wWEtRvUXe6x//vSCxFK35VDpfXw6EX1dxqx/qu6fM31tVo3AGv2tDVD/B71U
         qC+VZoByqOTipyUsi+Zb1AZAjGng8lPEmqC+Yd2Wj9G3qSeHDOzpuxM6fN2uUrTIolx8
         9MnO2Kt2FtE3EH2Gv5KTKr/P6MCngaDvALRNDYsxzIXgBZVKNKMf7woFfo5RtXlg5JKT
         c8RA==
X-Gm-Message-State: ABuFfogW5PjUiMk6VCNNRNr6VUNXwoflRMAqfcsIVCG6ufV0qLK4A+3J
        JelH1yYRzFsJG6ufXeGsgqW52OOn
X-Google-Smtp-Source: ACcGV63QywO+eTpYyStjESRZDjR+PQLPfGXFbHcE9CWLmIl7D+yCrw01wyp/uQHGdnXvcFvAQlG8ZQ==
X-Received: by 2002:a17:902:1004:: with SMTP id b4-v6mr1289568pla.172.1539598484467;
        Mon, 15 Oct 2018 03:14:44 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h6-v6sm12976366pgn.84.2018.10.15.03.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:14:43 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:14:43 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:14:38 GMT
Message-Id: <8c5ecdb6c9a73405036672db8bc1e36c5c6c6951.1539598481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.46.git.gitgitgadget@gmail.com>
References: <pull.46.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] http: add support for selecting SSL backends at runtime
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of version 7.56.0, curl supports being compiled with multiple SSL
backends.

This patch adds the Git side of that feature: by setting http.sslBackend
to "openssl" or "schannel", Git for Windows can now choose the SSL
backend at runtime.

This comes in handy on Windows because Secure Channel ("schannel") is
the native solution, accessing the Windows Credential Store, thereby
allowing for enterprise-wide management of certificates. For historical
reasons, Git for Windows needs to support OpenSSL still, as it has
previously been the only supported SSL backend in Git for Windows for
almost a decade.

The patch has been carried in Git for Windows for over a year, and is
considered mature.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  5 +++++
 http.c                   | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1546833213..7d38f0bf1a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1984,6 +1984,11 @@ http.sslCAPath::
 	with when fetching or pushing over HTTPS. Can be overridden
 	by the `GIT_SSL_CAPATH` environment variable.
 
+http.sslBackend::
+	Name of the SSL backend to use (e.g. "openssl" or "schannel").
+	This option is ignored if cURL lacks support for choosing the SSL
+	backend at runtime.
+
 http.pinnedpubkey::
 	Public key of the https service. It may either be the filename of
 	a PEM or DER encoded public key file or a string starting with
diff --git a/http.c b/http.c
index 98ff122585..7fb37a061b 100644
--- a/http.c
+++ b/http.c
@@ -155,6 +155,8 @@ static struct active_request_slot *active_queue_head;
 
 static char *cached_accept_language;
 
+static char *http_ssl_backend;
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -302,6 +304,12 @@ static int http_options(const char *var, const char *value, void *cb)
 		curl_ssl_try = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp("http.sslbackend", var)) {
+		free(http_ssl_backend);
+		http_ssl_backend = xstrdup_or_null(value);
+		return 0;
+	}
+
 	if (!strcmp("http.minsessions", var)) {
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
@@ -995,6 +1003,33 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	git_config(urlmatch_config_entry, &config);
 	free(normalized_url);
 
+#if LIBCURL_VERSION_NUM >= 0x073800
+	if (http_ssl_backend) {
+		const curl_ssl_backend **backends;
+		struct strbuf buf = STRBUF_INIT;
+		int i;
+
+		switch (curl_global_sslset(-1, http_ssl_backend, &backends)) {
+		case CURLSSLSET_UNKNOWN_BACKEND:
+			strbuf_addf(&buf, _("Unsupported SSL backend '%s'. "
+					    "Supported SSL backends:"),
+					    http_ssl_backend);
+			for (i = 0; backends[i]; i++)
+				strbuf_addf(&buf, "\n\t%s", backends[i]->name);
+			die("%s", buf.buf);
+		case CURLSSLSET_NO_BACKENDS:
+			die(_("Could not set SSL backend to '%s': "
+			      "cURL was built without SSL backends"),
+			    http_ssl_backend);
+		case CURLSSLSET_TOO_LATE:
+			die(_("Could not set SSL backend to '%s': already set"),
+			    http_ssl_backend);
+		case CURLSSLSET_OK:
+			break; /* Okay! */
+		}
+	}
+#endif
+
 	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
 		die("curl_global_init failed");
 
-- 
gitgitgadget

