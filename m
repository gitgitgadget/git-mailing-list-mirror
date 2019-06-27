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
	by dcvr.yhbt.net (Postfix) with ESMTP id 927541F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfF0Wyl (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:54:41 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45003 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfF0Wyl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:54:41 -0400
Received: by mail-pf1-f202.google.com with SMTP id 5so2472073pff.11
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eU/6vmDcEgz0Mza8pmxvvwqg4Td0kO5wtPJdy8PrWFM=;
        b=c1CUzd2jia793SEZO7xQOYIs25z0oMpkx16yZFJW4+6TTbeyeWVON1CbcmjzMVih78
         I6FBUt/ePZaChxKFeiyTP75Y5V/WYQ8h6mF9b+mBH/CIJndPZEECblLw6bRL93WgKXgq
         upszl45FaSHTd9nS69z2w+3fL3/7zLpUZAbZySFz082uvv847ndRT6wkMwzEamz3MrJI
         PghipdmcraoIpndKyJibgk3QKNhTYcpx4R7tNp1oTOq+W3igOit3h6omNdamZjau+BSP
         DEND988LkyZXeN/849yGUX010/2Yt1SlLNkIq5wZ4eor4L38nR7I0ppHFjMWwTMiLbP3
         6vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eU/6vmDcEgz0Mza8pmxvvwqg4Td0kO5wtPJdy8PrWFM=;
        b=t4YUXEXQl72ECUlyNs6iaausKmuEVVN4T7loaPYfMKl0HdHlcIJpmk4b02HuM6I4Zn
         WDJ2QxIXOVCE+FQKOaxxaTnt1QndAMpvhNuBr3m5vzgFqXyGcYQ/2mrSYCrSxI4Oxd7A
         niqFsoS24if4e+gMfTaTZ0CXgIlViQ+16CYXetW8d1MmYnoQVIAX/FZNGZKxNq2J4j9p
         ICRT79KEypHJV+2enhx2iz+m9ceoNk8Zw0zjEhSP0KlZkAQ2OOEL71GAvh+m7mMIrOQ6
         iSkC1cwT6G3R2VYlf6XPPKnhO44nGD+tzLoHiQwB7eDfx0/U1wCNSMQFJYa32cy16I3h
         W6qw==
X-Gm-Message-State: APjAAAVWAozKY+aRJH9sFvRY5yEl/1MJHnhlYqSPv5XPrGTI0cfgtzgT
        piMjD/LwsnrlwRl2910vGCZJzcwmHYCYJsRg4GKaXvsZJHgrNLcPIsBdx1fmJlJpOEQXg2fgb67
        Um/qKz9MNGKd/rh3rqxc/aoEtS3kSXOS6/cNkpxMYU49FZMzvBkSTTkh2V0M=
X-Google-Smtp-Source: APXvYqwU8y5DgjKfvY9RplS6TZTHVEnvMlixD3+ThqGBG0Gfx6IXEHFvfb/t7m5+fjYpWtAKDrzPdC7Ljn/P
X-Received: by 2002:a63:78ca:: with SMTP id t193mr6056955pgc.10.1561676080234;
 Thu, 27 Jun 2019 15:54:40 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:54:11 -0700
In-Reply-To: <cover.1561675151.git.matvore@google.com>
Message-Id: <dfa8f5bc8d7d18b7305b97e41cdb25737aaf0baf.1561675151.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1561675151.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 07/10] strbuf: give URL-encoding API a char predicate fn
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Johannes.Schindelin@gmx.de
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

