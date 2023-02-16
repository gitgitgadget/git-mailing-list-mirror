Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62512C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 22:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjBPWet (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 17:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBPWes (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 17:34:48 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD4B5B8D
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 14:34:46 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bu23so3294206wrb.8
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 14:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEuyPX/nZrG27AxeuBTpO7uA0jRR/aN+X58rKTaTuOw=;
        b=PW39h9CmOQbf4mMS32Y+1LbOb6DTqjhxcFmnszLz2TNI9/vvCNyHJmsPk7VHa1WLwN
         lgNlECw01cVpo1o8ameGVIFu7quks+qoUH3SlXyFIjzOqzG7+yzFIiljzzy2j/lxglKq
         ZByTopzIEnR1ew7Z7wFwQH1WW71mTiyxl7u/pKTZhH9qoeQOdouhOxUFlw0+o71IRuCW
         QFME007ZH34RnlNvxGCwPyskjWXmDDJr6yL5lyZ6vtu/HPSba/gjF2WcTtJUYZZ2sobX
         9NHY4WXuxhNGndyKqqX/C1E7P5WZDz58d0AJk5iK7MOqDchu8WlLfOTJQWG8/cMYFV6G
         WGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEuyPX/nZrG27AxeuBTpO7uA0jRR/aN+X58rKTaTuOw=;
        b=dav+ZzClEiSkN3iaxuKaw6EI9B/kdZe1HUZfJ7t3UQZ1C/dtcp4FjRO7ma3/N2Bx8i
         rwSlmmGGzNxG44RbiSWMo9LLJIrpGAPQA5ZE7RwDWYbgutUGHeGs+5KIAsatMF1G+m7R
         G0Si78gRzz0n2i5CJT0vllE3kjV3cXrekvmEPrXeqn/ojn3sAkIKEIKQZ2F0MQUO6/R7
         zj972Gv77IDUqHrCrCs9RwYoB/33oN0I25JVK8/sHCTvMfevekAW/BcdKKu4YRQgU4SD
         YUgZOzQW5o+2y+AUK4Gslgt0JFu6JnPo5F1uvm4N3umWLKUS/LV8/3CByK4mLetXFxnP
         eHqA==
X-Gm-Message-State: AO0yUKUXQITI3bbjAeBwLZQn/StjoasYTiXbqe6L7aUOc4TQpeILRk9W
        +p7kGyG4yTk+goWEU2S3Ktsc9pyAz2c=
X-Google-Smtp-Source: AK7set8UdghHYhntPEfrLCtPCyxmA5C10i+093eK4ybiOQ64YmDHSEQfztMGDIvfErfwox6v7NGOvA==
X-Received: by 2002:a5d:6207:0:b0:2c4:80a:e845 with SMTP id y7-20020a5d6207000000b002c4080ae845mr4675874wru.2.1676586884400;
        Thu, 16 Feb 2023 14:34:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10-20020adffd0a000000b002c5801aa9b0sm2515233wrr.40.2023.02.16.14.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:34:43 -0800 (PST)
Message-Id: <703ac15222fdcfc98751b11af725cc1395134bd1.1676586881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
References: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
        <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Feb 2023 22:34:40 +0000
Subject: [PATCH v10 2/3] http: read HTTP WWW-Authenticate response headers
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
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Read and store the HTTP WWW-Authenticate response headers made for
a particular request.

This will allow us to pass important authentication challenge
information to credential helpers or others that would otherwise have
been lost.

libcurl only provides us with the ability to read all headers recieved
for a particular request, including any intermediate redirect requests
or proxies. The lines returned by libcurl include HTTP status lines
delinating any intermediate requests such as "HTTP/1.1 200". We use
these lines to reset the strvec of WWW-Authenticate header values as
we encounter them in order to only capture the final response headers.

The collection of all header values matching the WWW-Authenticate
header is complicated by the fact that it is legal for header fields to
be continued over multiple lines, but libcurl only gives us each
physical line a time, not each logical header. This line folding feature
is deprecated in RFC 7230 [1] but older servers may still emit them, so
we need to handle them.

In the future [2] we may be able to leverage functions to read headers
from libcurl itself, but as of today we must do this ourselves.

[1] https://www.rfc-editor.org/rfc/rfc7230#section-3.2
[2] https://daniel.haxx.se/blog/2022/03/22/a-headers-api-for-libcurl/

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 credential.c      |   1 +
 credential.h      |  16 +++++++
 git-compat-util.h |  23 ++++++++++
 http.c            | 111 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+)

diff --git a/credential.c b/credential.c
index f6389a50684..897b4679333 100644
--- a/credential.c
+++ b/credential.c
@@ -22,6 +22,7 @@ void credential_clear(struct credential *c)
 	free(c->username);
 	free(c->password);
 	string_list_clear(&c->helpers, 0);
+	strvec_clear(&c->wwwauth_headers);
 
 	credential_init(c);
 }
diff --git a/credential.h b/credential.h
index f430e77fea4..3756a54c74d 100644
--- a/credential.h
+++ b/credential.h
@@ -2,6 +2,7 @@
 #define CREDENTIAL_H
 
 #include "string-list.h"
+#include "strvec.h"
 
 /**
  * The credentials API provides an abstracted way of gathering username and
@@ -115,6 +116,20 @@ struct credential {
 	 */
 	struct string_list helpers;
 
+	/**
+	 * A `strvec` of WWW-Authenticate header values. Each string
+	 * is the value of a WWW-Authenticate header in an HTTP response,
+	 * in the order they were received in the response.
+	 */
+	struct strvec wwwauth_headers;
+
+	/**
+	 * Internal use only. Keeps track of if we previously matched against a
+	 * WWW-Authenticate header line in order to re-fold future continuation
+	 * lines into one value.
+	 */
+	unsigned header_is_last_match:1;
+
 	unsigned approved:1,
 		 configured:1,
 		 quit:1,
@@ -130,6 +145,7 @@ struct credential {
 
 #define CREDENTIAL_INIT { \
 	.helpers = STRING_LIST_INIT_DUP, \
+	.wwwauth_headers = STRVEC_INIT, \
 }
 
 /* Initialize a credential structure, setting all fields to empty. */
diff --git a/git-compat-util.h b/git-compat-util.h
index a76d0526f79..a59230564e8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1266,6 +1266,29 @@ static inline int skip_iprefix(const char *str, const char *prefix,
 	return 0;
 }
 
+/*
+ * Like skip_prefix_mem, but compare case-insensitively. Note that the
+ * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
+ * characters or locale-specific conversions).
+ */
+static inline int skip_iprefix_mem(const char *buf, size_t len,
+				   const char *prefix,
+				   const char **out, size_t *outlen)
+{
+	size_t prefix_len = strlen(prefix);
+
+	if (len < prefix_len)
+		return 0;
+
+	if (!strncasecmp(buf, prefix, prefix_len)) {
+		*out = buf + prefix_len;
+		*outlen = len - prefix_len;
+		return 1;
+	}
+
+	return 0;
+}
+
 static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 {
 	unsigned long ul;
diff --git a/http.c b/http.c
index 8a5ba3f4776..3ff570ee3a9 100644
--- a/http.c
+++ b/http.c
@@ -183,6 +183,115 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return nmemb;
 }
 
+/*
+ * A folded header continuation line starts with any number of spaces or
+ * horizontal tab characters (SP or HTAB) as per RFC 7230 section 3.2.
+ * It is not a continuation line if the line starts with any other character.
+ */
+static inline int is_hdr_continuation(const char *ptr, const size_t size)
+{
+	return size && (*ptr == ' ' || *ptr == '\t');
+}
+
+static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
+{
+	size_t size = eltsize * nmemb;
+	struct strvec *values = &http_auth.wwwauth_headers;
+	struct strbuf buf = STRBUF_INIT;
+	const char *val;
+	size_t val_len;
+
+	/*
+	 * Header lines may not come NULL-terminated from libcurl so we must
+	 * limit all scans to the maximum length of the header line, or leverage
+	 * strbufs for all operations.
+	 *
+	 * In addition, it is possible that header values can be split over
+	 * multiple lines as per RFC 7230. 'Line folding' has been deprecated
+	 * but older servers may still emit them. A continuation header field
+	 * value is identified as starting with a space or horizontal tab.
+	 *
+	 * The formal definition of a header field as given in RFC 7230 is:
+	 *
+	 * header-field   = field-name ":" OWS field-value OWS
+	 *
+	 * field-name     = token
+	 * field-value    = *( field-content / obs-fold )
+	 * field-content  = field-vchar [ 1*( SP / HTAB ) field-vchar ]
+	 * field-vchar    = VCHAR / obs-text
+	 *
+	 * obs-fold       = CRLF 1*( SP / HTAB )
+	 *                ; obsolete line folding
+	 *                ; see Section 3.2.4
+	 */
+
+	/* Start of a new WWW-Authenticate header */
+	if (skip_iprefix_mem(ptr, size, "www-authenticate:", &val, &val_len)) {
+		strbuf_add(&buf, val, val_len);
+
+		/*
+		 * Strip the CRLF that should be present at the end of each
+		 * field as well as any trailing or leading whitespace from the
+		 * value.
+		 */
+		strbuf_trim(&buf);
+
+		strvec_push(values, buf.buf);
+		http_auth.header_is_last_match = 1;
+		goto exit;
+	}
+
+	/*
+	 * This line could be a continuation of the previously matched header
+	 * field. If this is the case then we should append this value to the
+	 * end of the previously consumed value.
+	 */
+	if (http_auth.header_is_last_match && is_hdr_continuation(ptr, size)) {
+		/*
+		 * Trim the CRLF and any leading or trailing from this line.
+		 */
+		strbuf_add(&buf, ptr, size);
+		strbuf_trim(&buf);
+
+		/*
+		 * At this point we should always have at least one existing
+		 * value, even if it is empty. Do not bother appending the new
+		 * value if this continuation header is itself empty.
+		 */
+		if (!values->nr) {
+			BUG("should have at least one existing header value");
+		} else if (buf.len) {
+			char *prev = xstrdup(values->v[values->nr - 1]);
+
+			/* Join two non-empty values with a single space. */
+			const char *const sp = *prev ? " " : "";
+
+			strvec_pop(values);
+			strvec_pushf(values, "%s%s%s", prev, sp, buf.buf);
+			free(prev);
+		}
+
+		goto exit;
+	}
+
+	/* Not a continuation of a previously matched auth header line. */
+	http_auth.header_is_last_match = 0;
+
+	/*
+	 * If this is a HTTP status line and not a header field, this signals
+	 * a different HTTP response. libcurl writes all the output of all
+	 * response headers of all responses, including redirects.
+	 * We only care about the last HTTP request response's headers so clear
+	 * the existing array.
+	 */
+	if (!strncasecmp(ptr, "http/", 5))
+		strvec_clear(values);
+
+exit:
+	strbuf_release(&buf);
+	return size;
+}
+
 size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
 {
 	return nmemb;
@@ -1864,6 +1973,8 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
+
 	accept_language = http_get_accept_language_header();
 
 	if (accept_language)
-- 
gitgitgadget

