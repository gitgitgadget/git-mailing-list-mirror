Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C551FA373E
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJURIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJURIL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:08:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0338F280800
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bv10so5992261wrb.4
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZS+vJncVOAy2CYmx4D6/h8tcRsGlPjDDfC+97kQiBFE=;
        b=q0A9sLNu+c8MdyDCPMtTHNhMp7KNCgxQDu9tLdv14BnlfH43M/FVh5UZ8dkCGlDKt4
         0YsiuSG9n1hZmwTimYg0OmELNyL2kRfj8/4l2sHvpVJ/kCRpxUMrEebx09jIB/9keD/D
         MR56TPS4ouhaYmSjUGBlHWQB/mjYeEqjTJhtuI4iBVCxSbpzaAh6NoEl9vz8/QFhoauZ
         iMzTZ6SymuFZgrcDWGwjQckKAAVDGzJgsLCEDpD6aMZLQas0BGEnz+A12y4nb4GXje0Y
         HzXzCSPHCIfnP/eEK0LTCj5w8raQMpyyPHFhLrYzpHh1vnJ7ohD4UB6lIbQ1z6KHjMz9
         qd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZS+vJncVOAy2CYmx4D6/h8tcRsGlPjDDfC+97kQiBFE=;
        b=RqsNYGGQR1qYonud4PMDhekRXepuexqylzmCKUunzre9Kvu/FR5GTuHNoVBoj/s5Np
         aapBNAgkV0gQzCS9QsU7NJyLxHhmuerBlQVG0BdThr4GJBPaR0TAJHM62bJKdsWRu/Jy
         2U9RyEW2507ywgF2o/3GOR7BQbFM1wdrMEsadyUx40h0BMfdPTisILJB2civ9I+7OXeB
         u1hrfc6ZI6rBpOFUhtfehdEBwGGo+KBeD1PxDpdEOCp+02iCz7NXLfVu9upbtrJ32jao
         olTykYqoEoHIl5+dbBJnLLIusPbepNNYYBpkwOd92JiA0UqBltn5r91U2+MBdfsHmL50
         Xchw==
X-Gm-Message-State: ACrzQf31Q2VItuMQ2vX73MpQPkLw4G6jYOnLcW0G6Zub/+tmqfvXdNIc
        rEX+UGrewxpFwn/bmnULNIX+ewmgVVc=
X-Google-Smtp-Source: AMsMyM4X7umMFKK15t5sZfEjNhetMLrRtVw+QtOSk+qy5dvhmIrL4MlLzuQuROdH3Bex+qzgG8tHaQ==
X-Received: by 2002:a05:6000:1e18:b0:235:e8f7:564f with SMTP id bj24-20020a0560001e1800b00235e8f7564fmr6453983wrb.153.1666372088188;
        Fri, 21 Oct 2022 10:08:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d6290000000b0022ae4f8395dsm18773752wru.96.2022.10.21.10.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:08:07 -0700 (PDT)
Message-Id: <f297c78f60a6996c2d2e5397b05efa6b94fd2ae0.1666372083.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
        <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 17:07:58 +0000
Subject: [PATCH v2 1/6] http: read HTTP WWW-Authenticate response headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
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
 credential.h | 15 ++++++++++
 http.c       | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

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
index 5d0502f51fd..03d43d352e7 100644
--- a/http.c
+++ b/http.c
@@ -183,6 +183,82 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return nmemb;
 }
 
+static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
+{
+	size_t size = eltsize * nmemb;
+	struct strvec *values = &http_auth.wwwauth_headers;
+	struct strbuf buf = STRBUF_INIT;
+	const char *val;
+	const char *z = NULL;
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
+	 */
+	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
+		const char **v = values->v + values->nr - 1;
+		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);
+
+		free((void*)*v);
+		*v = append;
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
+	if (skip_iprefix(buf.buf, "http/", &z))
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
@@ -1829,6 +1905,8 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
+
 	accept_language = http_get_accept_language_header();
 
 	if (accept_language)
-- 
gitgitgadget

