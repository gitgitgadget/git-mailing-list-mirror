Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1308C54EBC
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbjAKWOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjAKWNY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:13:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DEB431A5
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:22 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bn26so16444948wrb.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sti4/YXuRxJdTVRBK4qF5FuZujpVj+P/dob0ruiB2Vw=;
        b=H4Ggie1RTCH65FW0JOkfA/KwIeZuX9tKMzOZmgC5F4qVQxZm8E8bfpD9/5uOEUhll3
         DJ1yl2oulHm0v/qWMNMSYW/hQnjLPD6GaFsuvibCfjOeymyYZUcdmfQiDjlNOXXrDiRn
         28LGsTVewVd72ooht9wPBRY41qAOsyJbWeaY9+vOsD316uYY2iH2gBKFb6TccXIJ54oQ
         sbTYTuLyhL7vd206LNMd+JuginXzN7mGyyCPGOb8TUG3eVVEQdtsmg7iLQKw1H7oTG7S
         Fy2bZ3AxdY/OQpVr/5yJf2Lz9YeCKl3eL2F5mPP2ht9MqY05iWcqXjsh/zzCH8p238Jh
         aXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sti4/YXuRxJdTVRBK4qF5FuZujpVj+P/dob0ruiB2Vw=;
        b=OROJf+fGZKw8X9+uv3q9JQFfKOv4wfG9XsjZ7TSnGJS3lVlgMIPYntLLPJn8WUP0c1
         JN6zB2FjTxPsXNrcRMTPuV8yySH1YVHvo+vCBcON0DjxFq//wmdA40XR5cz5DStIHBCZ
         s5vFdmP/9dNOEPD1Vy4yabGge7hX2gLHUB77fv5cPNCWeE6UKR3q2zmfT5XkOlKfTofx
         xbqJeoOsl6+KXXcnrBT2ipCv/ht5TUObNNAcjfukeNJSeCAGxCN31hYOCjsxJ2xthuu+
         rUGHg9JUs751wVrooxteNRLN/SlwJ9OGqslJZXB0NqidwoJgRXqxeAmfs6mVHxgyC6Ix
         g9ng==
X-Gm-Message-State: AFqh2kqSj1LwSkaQe5WvDiRE/fb9EzLdNZxVLV1uyv1l2bMbrbMfS6IN
        EFOcREoq1ES6cTEI8+eZh/Awu0X1KzI=
X-Google-Smtp-Source: AMrXdXutMIaLnk9UEvzeLfY1PBtTvwzCWUhhY3HppQi7UdX/YFbz+/1iB/DUs6engF9lmXKFcWhy9A==
X-Received: by 2002:adf:e449:0:b0:27c:fdb:cfef with SMTP id t9-20020adfe449000000b0027c0fdbcfefmr36254934wrm.49.1673475201147;
        Wed, 11 Jan 2023 14:13:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l24-20020a1ced18000000b003d99da8d30asm24012663wmh.46.2023.01.11.14.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:13:20 -0800 (PST)
Message-Id: <bcfec529d9581db3181cc6f3b3d4b4b8d315ca0c.1673475190.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 22:13:09 +0000
Subject: [PATCH v5 09/10] http: read HTTP WWW-Authenticate response headers
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
        Matthew John Cheetham <mjcheetham@github.com>,
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
 credential.c |  1 +
 credential.h | 15 ++++++++
 http.c       | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

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
diff --git a/http.c b/http.c
index a2a80318bb2..10882034145 100644
--- a/http.c
+++ b/http.c
@@ -183,6 +183,102 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return nmemb;
 }
 
+static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
+{
+	size_t size = st_mult(eltsize, nmemb);
+	struct strvec *values = &http_auth.wwwauth_headers;
+	struct strbuf buf = STRBUF_INIT;
+	const char *val;
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
+	strbuf_add(&buf, ptr, size);
+
+	/* Strip the CRLF that should be present at the end of each field */
+	strbuf_trim_trailing_newline(&buf);
+
+	/* Start of a new WWW-Authenticate header */
+	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
+		while (isspace(*val))
+			val++;
+
+		strvec_push(values, val);
+		http_auth.header_is_last_match = 1;
+		goto exit;
+	}
+
+	/*
+	 * This line could be a continuation of the previously matched header
+	 * field. If this is the case then we should append this value to the
+	 * end of the previously consumed value.
+	 * Continuation lines start with at least one whitespace, maybe more,
+	 * so we should collapse these down to a single SP (valid per the spec).
+	 */
+	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
+		/* Trim leading whitespace from this continuation hdr line. */
+		strbuf_ltrim(&buf);
+
+		/*
+		 * At this point we should always have at least one existing
+		 * value, even if it is empty. Do not bother appending the new
+		 * value if this continuation header is itself empty.
+		 */
+		if (!values->nr) {
+			BUG("should have at least one existing header value");
+		} else if (buf.len) {
+			const char *prev = values->v[values->nr - 1];
+			struct strbuf append = STRBUF_INIT;
+			strbuf_addstr(&append, prev);
+
+			/* Join two non-empty values with a single space. */
+			if (append.len)
+				strbuf_addch(&append, ' ');
+
+			strbuf_addbuf(&append, &buf);
+
+			strvec_pop(values);
+			strvec_push_nodup(values, strbuf_detach(&append, NULL));
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
+	if (istarts_with(buf.buf, "http/"))
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
@@ -1864,6 +1960,8 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
+
 	accept_language = http_get_accept_language_header();
 
 	if (accept_language)
-- 
gitgitgadget

