Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 862391F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfFMVv6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:51:58 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:51558 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMVv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:51:58 -0400
Received: by mail-vk1-f202.google.com with SMTP id s145so76181vke.18
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eU/6vmDcEgz0Mza8pmxvvwqg4Td0kO5wtPJdy8PrWFM=;
        b=BIsC+b4t3UN7PbbtNKlI1BguOmVu3/vzRYJHOttjudqPaxXkhhdTeRNu39N6l7ltnn
         mLBKIxEWUOcLfI3mEEAe0RLGroXKw5OUyjwRTFfSKWA6RFK0lJleB6ztA16phlyX/OMM
         wHNN8f4xPXEvWeJRolKre69MoZjj6LONhdJP/cbzEaTqkqo6T+xwfORnEAFseqml3STY
         4J6eTu6/UqdFZ0WlRPFYIFGTCx+5mbGpPg7kWAEAqnN0ERF8z5263fh1X4wFZwZuNpNa
         03yfjGXqcunzdCogd7JlatXCaBXgUOcftjoIBzCwwe0jrwLG1+NqwzbogUjNBqVkdxB/
         5slQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eU/6vmDcEgz0Mza8pmxvvwqg4Td0kO5wtPJdy8PrWFM=;
        b=tNZmb0zc+xIX6wnoA+SsTK/dK+dKperN9Z7BA3RDbX/16gGnaGxW0oikNumCYTL16N
         ZVFkE0d40aUfYGnXyZ9k7Mlht5Z6O6Vp/5giHJUtv3a1BY6Cku4K57o/MCKFTVGMztvo
         oTW6vLtvWn+a7SzmM0stNXPRVCTKBBzz7cXpycbVBNFRXZrHIqJawwKQmKrSGtB2BeQ1
         /O8ADWjQ54K+Ox4L3kiiRg3tdAR0jiOcAxJaEeijKvVB03MPVf816YQNbwCexClB5RV9
         4vpUnm3KHq0INyDUo3GSQ/D+KtbS+phM+qcsiqeCStVVYB5H+Qb25E/tqc/xGzPOryFW
         G2sQ==
X-Gm-Message-State: APjAAAXaZcFRIeXn31u5Wuvn6Lsr2eCO9FfjVjuvCFoIAbo9MQ89dkGE
        TY2F37m+O9DBZ823M+lzg5WfI0IXN+O+iXah3es297b20VPEgRLKhMwdJGw+KPvvPj9eFAwrs8K
        GfBPRiDWRT6acaR8SmPHJ982fioECXr0jnZ64H2OvPFNGKt0+51IjmkVq6Ds=
X-Google-Smtp-Source: APXvYqzAcslFmBQtlNtgiVaPPayZhdZC262MGt0FugvNsoDx6P6inAlZFM5AI2Jc1zs7lVir7N4PdeLAci7s
X-Received: by 2002:a9f:366b:: with SMTP id s40mr23093274uad.121.1560462717045;
 Thu, 13 Jun 2019 14:51:57 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:51:30 -0700
In-Reply-To: <cover.1560462201.git.matvore@google.com>
Message-Id: <e23b7c5ca92bfb23eba3c065b5cb20e9035b3a78.1560462201.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560462201.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v3 07/10] strbuf: give URL-encoding API a char predicate fn
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow callers to specify exactly what characters need to be URL-encoded
and which do not. This new API will be taken advantage of in a patch
later in this set.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 credential-store.c |  9 +++++----
 http.c             |  6 ++++--
 strbuf.c           | 15 ++++++++-------
 strbuf.h           |  7 ++++++-
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index ac295420dd..c010497cb2 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -65,29 +65,30 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 	parse_credential_file(fn, c, NULL, print_line);
 	if (commit_lock_file(&credential_lock) < 0)
 		die_errno("unable to write credential store");
 }
 
 static void store_credential_file(const char *fn, struct credential *c)
 {
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_addf(&buf, "%s://", c->protocol);
-	strbuf_addstr_urlencode(&buf, c->username, 1);
+	strbuf_addstr_urlencode(&buf, c->username, is_rfc3986_unreserved);
 	strbuf_addch(&buf, ':');
-	strbuf_addstr_urlencode(&buf, c->password, 1);
+	strbuf_addstr_urlencode(&buf, c->password, is_rfc3986_unreserved);
 	strbuf_addch(&buf, '@');
 	if (c->host)
-		strbuf_addstr_urlencode(&buf, c->host, 1);
+		strbuf_addstr_urlencode(&buf, c->host, is_rfc3986_unreserved);
 	if (c->path) {
 		strbuf_addch(&buf, '/');
-		strbuf_addstr_urlencode(&buf, c->path, 0);
+		strbuf_addstr_urlencode(&buf, c->path,
+					is_rfc3986_reserved_or_unreserved);
 	}
 
 	rewrite_credential_file(fn, c, &buf);
 	strbuf_release(&buf);
 }
 
 static void store_credential(const struct string_list *fns, struct credential *c)
 {
 	struct string_list_item *fn;
 
diff --git a/http.c b/http.c
index 27aa0a3192..938b9e55af 100644
--- a/http.c
+++ b/http.c
@@ -506,23 +506,25 @@ static void var_override(const char **var, char *value)
 static void set_proxyauth_name_password(CURL *result)
 {
 #if LIBCURL_VERSION_NUM >= 0x071301
 		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
 			proxy_auth.username);
 		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
 			proxy_auth.password);
 #else
 		struct strbuf s = STRBUF_INIT;
 
-		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
+		strbuf_addstr_urlencode(&s, proxy_auth.username,
+					is_rfc3986_unreserved);
 		strbuf_addch(&s, ':');
-		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
+		strbuf_addstr_urlencode(&s, proxy_auth.password,
+					is_rfc3986_unreserved);
 		curl_proxyuserpwd = strbuf_detach(&s, NULL);
 		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
 #endif
 }
 
 static void init_curl_proxy_auth(CURL *result)
 {
 	if (proxy_auth.username) {
 		if (!proxy_auth.password)
 			credential_fill(&proxy_auth);
diff --git a/strbuf.c b/strbuf.c
index 0e18b259ce..60ab5144f2 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -767,55 +767,56 @@ void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
 		case '&':
 			strbuf_addstr(buf, "&amp;");
 			break;
 		case 0:
 			return;
 		}
 		s++;
 	}
 }
 
-static int is_rfc3986_reserved(char ch)
+int is_rfc3986_reserved_or_unreserved(char ch)
 {
+	if (is_rfc3986_unreserved(ch))
+		return 1;
 	switch (ch) {
 		case '!': case '*': case '\'': case '(': case ')': case ';':
 		case ':': case '@': case '&': case '=': case '+': case '$':
 		case ',': case '/': case '?': case '#': case '[': case ']':
 			return 1;
 	}
 	return 0;
 }
 
-static int is_rfc3986_unreserved(char ch)
+int is_rfc3986_unreserved(char ch)
 {
 	return isalnum(ch) ||
 		ch == '-' || ch == '_' || ch == '.' || ch == '~';
 }
 
 static void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
-				 int reserved)
+				 char_predicate allow_unencoded_fn)
 {
 	strbuf_grow(sb, len);
 	while (len--) {
 		char ch = *s++;
-		if (is_rfc3986_unreserved(ch) ||
-		    (!reserved && is_rfc3986_reserved(ch)))
+		if (allow_unencoded_fn(ch))
 			strbuf_addch(sb, ch);
 		else
 			strbuf_addf(sb, "%%%02x", (unsigned char)ch);
 	}
 }
 
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
-			     int reserved)
+			     char_predicate allow_unencoded_fn)
 {
-	strbuf_add_urlencode(sb, s, strlen(s), reserved);
+	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
 }
 
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	if (bytes > 1 << 30) {
 		strbuf_addf(buf, "%u.%2.2u GiB",
 			    (unsigned)(bytes >> 30),
 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
 	} else if (bytes > 1 << 20) {
 		unsigned x = bytes + 5243;  /* for rounding */
diff --git a/strbuf.h b/strbuf.h
index c8d98dfb95..346d722492 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -659,22 +659,27 @@ void strbuf_branchname(struct strbuf *sb, const char *name,
 		       unsigned allowed);
 
 /*
  * Like strbuf_branchname() above, but confirm that the result is
  * syntactically valid to be used as a local branch name in refs/heads/.
  *
  * The return value is "0" if the result is valid, and "-1" otherwise.
  */
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
+typedef int (*char_predicate)(char ch);
+
+int is_rfc3986_unreserved(char ch);
+int is_rfc3986_reserved_or_unreserved(char ch);
+
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
-			     int reserved);
+			     char_predicate allow_unencoded_fn);
 
 __attribute__((format (printf,1,2)))
 int printf_ln(const char *fmt, ...);
 __attribute__((format (printf,2,3)))
 int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
 char *xstrdup_toupper(const char *);
 
 /**
-- 
2.21.0

