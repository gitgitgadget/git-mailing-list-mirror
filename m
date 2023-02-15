Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C1BC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 21:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBOVeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 16:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBOVeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 16:34:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E211B447
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 13:34:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r2so37634wrv.7
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 13:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVtyEdJgg6jMuglCgh+k28lCivZ8Qj3WdSNaJ6fojUw=;
        b=SNyHwfBOhj2OaR8XJePoCouKCT8Eomyy+qKQhHqnzT14q9x03N42/S4BlVdXIwzAJm
         7YcXZTAqbrVNkBnb7NwXKzBrGE9PpXA/55xfX4E9zWT0ISUD85Hm7OkHkM1TujemECcX
         Kt96HSColVxF4tMlZIaCmrd2c1KPjZx4hjs3h9t740TM4TLabrOEjoAjuouKmNmxdb69
         iEuUUDzm0gRoA+bUer645s/v+azeNjhV+X/wdni0vIs4dqNZ8To3eYzv5t02K7hsizFx
         x3kwITj06diwUjMGpYRps58UiUyRo5aAwKvt2HUusZLK82UKOUDQ0cbSnMzQbPp2/dEc
         LvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVtyEdJgg6jMuglCgh+k28lCivZ8Qj3WdSNaJ6fojUw=;
        b=rYirU/CdEsnRjZ6dDh4Tng8Ly3Jm6eFTOBgRmIrSENB2opkp6N/Ox1SZWNM09qi/sd
         6C3MEhjRP6Elqu//uDX7qdC6/9puWqCqjsFXalJGo6RPwgViTQXnaNm+8mlT43hhr9mv
         vaZ+IsKImWhF/KlpTlCoCIrp/MAysV7fNheucHSpLauXxQMWcALzlDFFTaLb+mLvsWEb
         ++346UjiSxWmkvRT0jYWTlyfg5AsVgN5LBQYopBanqTuyUn7qaube03q75DJ0NaSuKX6
         uh5o+u8NxmpWTWermHFivzq/+DZE9Vd1XZcOVk2uIENEbcSNieD9kKBCSsn2dt+ZYmkV
         NmNQ==
X-Gm-Message-State: AO0yUKVreCFgOO1XtLg4HAayHv+9x0HOHn1votFgWrHJ9hVq2hciQvKI
        UUjbQsPtN+fineWwf57rf6H1se+0vDw=
X-Google-Smtp-Source: AK7set/fVAYrGEPRUjjH7Vv53zRB2ZaGcpUft3Oxv+j3OWhhPIVHDFoAyy6dZLKClHmeRprAPlmG+g==
X-Received: by 2002:a5d:6988:0:b0:2c5:5ed5:2e6a with SMTP id g8-20020a5d6988000000b002c55ed52e6amr2123131wru.5.1676496849785;
        Wed, 15 Feb 2023 13:34:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13-20020a5d614d000000b002c5526234d2sm10677143wrt.8.2023.02.15.13.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:34:09 -0800 (PST)
Message-Id: <f3f28e508c1792cbc8f8d3bd56099c659743ed3e.1676496846.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
References: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
        <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Feb 2023 21:34:05 +0000
Subject: [PATCH v9 2/3] http: read HTTP WWW-Authenticate response headers
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

According to RFC2616 Section 4.2 [1], header field names are not
case-sensitive meaning when collecting multiple values for the same
field name, we can just use the case of the first observed instance of
each field name and no normalisation is required.

libcurl only provides us with the ability to read all headers recieved
for a particular request, including any intermediate redirect requests
or proxies. The lines returned by libcurl include HTTP status lines
delinating any intermediate requests such as "HTTP/1.1 200". We use
these lines to reset the strvec of WWW-Authenticate header values as
we encounter them in order to only capture the final response headers.

The collection of all header values matching the WWW-Authenticate
header is complicated by the fact that it is legal for header fields to
be continued over multiple lines, but libcurl only gives us one line at
a time.

In the future [2] we may be able to leverage functions to read headers
from libcurl itself, but as of today we must do this ourselves.

[1] https://datatracker.ietf.org/doc/html/rfc2616#section-4.2
[2] https://daniel.haxx.se/blog/2022/03/22/a-headers-api-for-libcurl/

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 credential.c      |   1 +
 credential.h      |  15 ++++++
 git-compat-util.h |  23 +++++++++
 http.c            | 120 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+)

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
index f430e77fea4..6f2e5bc610b 100644
--- a/credential.h
+++ b/credential.h
@@ -2,6 +2,7 @@
 #define CREDENTIAL_H
 
 #include "string-list.h"
+#include "strvec.h"
 
 /**
  * The credentials API provides an abstracted way of gathering username and
@@ -115,6 +116,19 @@ struct credential {
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
+	 * Internal use only. Used to keep track of split header fields
+	 * in order to fold multiple lines into one value.
+	 */
+	unsigned header_is_last_match:1;
+
 	unsigned approved:1,
 		 configured:1,
 		 quit:1,
@@ -130,6 +144,7 @@ struct credential {
 
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
index 8a5ba3f4776..7a56a3db5f7 100644
--- a/http.c
+++ b/http.c
@@ -183,6 +183,124 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return nmemb;
 }
 
+/*
+ * A folded header continuation line starts with at least one single whitespace
+ * character. It is not a continuation line if the line is *just* a newline.
+ * The RFC for HTTP states that CRLF is the header field line ending, but some
+ * servers may use LF only; we accept both.
+ */
+static inline int is_hdr_continuation(const char *ptr, const size_t size)
+{
+	/* totally empty line or normal header */
+	if (!size || !isspace(*ptr))
+		return 0;
+
+	/* empty line with LF line ending */
+	if (size == 1 && ptr[0] == '\n')
+		return 0;
+
+	/* empty line with CRLF line ending */
+	if (size == 2 && ptr[0] == '\r' && ptr[1] == '\n')
+		return 0;
+
+	return 1;
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
+	 * multiple lines as per RFC 2616 (even though this has since been
+	 * deprecated in RFC 7230). A continuation header field value is
+	 * identified as starting with a space or horizontal tab.
+	 *
+	 * The formal definition of a header field as given in RFC 2616 is:
+	 *
+	 *   message-header = field-name ":" [ field-value ]
+	 *   field-name     = token
+	 *   field-value    = *( field-content | LWS )
+	 *   field-content  = <the OCTETs making up the field-value
+	 *                    and consisting of either *TEXT or combinations
+	 *                    of token, separators, and quoted-string>
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
+	/* This is the start of a new header we don't care about */
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
@@ -1864,6 +1982,8 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
+
 	accept_language = http_get_accept_language_header();
 
 	if (accept_language)
-- 
gitgitgadget

