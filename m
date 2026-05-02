Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870C2EB5A1
	for <git@vger.kernel.org>; Sat,  2 May 2026 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777699733; cv=none; b=SQhyHHzQ3Peu/mW4Xu6olIKlc6Abx6yhRaqXycKEGKObXDY6RK2XdWdoGvXuqqAy5iovYVM39rrvBhks7wv5LX3ZGo6eCj6S57zlmIk9i6EIyiZuswkx4FVgq+UcMw44K1HdZTclNGqnSjjjN3aP2gROZ+HV+szADbQdn0BBHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777699733; c=relaxed/simple;
	bh=xOc3ixtvifsRbiNTpqbKOasQvxiq6AL0C/ruih0HFT0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qopuVEQKr2NO/wPcs9hdn8VOGZdbo4F13lwE0H+/7uYwd8TZqxXbBDoIbI8RxaOwGFf3vG6oQPlKiWgNWJ3NddZrN3k4IDpGd+kYDwWEv5M9+byas0xIP28gxhshb0ioDOxnP1tGuiQVMwAEk3v1ppEGlHnqpUjPsIAvj/LCrSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haDW7Ezj; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haDW7Ezj"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8aca4e14411so26759106d6.3
        for <git@vger.kernel.org>; Fri, 01 May 2026 22:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777699730; x=1778304530; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1FcgKCPtp8aMtVy2VuU03D6lZFtPAQ/96elesR+jbo=;
        b=haDW7Ezj2oARKO1HNjpgpCRYyoe+X8YZfcxNhHi7aW3zUzpaIOhlYMJxvwfJEzl29K
         fNmWrL5xdrwiQIl3BMRVwtjXu+yMvpA59u1jnx1VquiAUzZ7Pgk3kUKVQF4VRTlDT4yZ
         4XCbbz1fIe/o457Tr6Pji0tVfMdK7HwnYT+Ow+jT6z2dHg59/XyFkdyqliUge/dWsvQi
         K5e/9Rn7LJJQvEX38KAuuhMUv4DaiPU8ALBb2VsEx5mjfupMpgQY4Cw/FnHmSSl0Hwjb
         JNrzgWi9tzMEXiwJicOhjRHe7OjVzp9kn6E+SssHJ4PHz1RA3pyy60cAltMZLQqkY51B
         b/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777699730; x=1778304530;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l1FcgKCPtp8aMtVy2VuU03D6lZFtPAQ/96elesR+jbo=;
        b=VfNXslDgEGGzOk6aBWGVHSgHyThfwaPhwetXscUn1k0EqdHIKtFLEmMfICI9GOijbI
         XqOTVWykLQqgBT5bgFScMImcUm2B7b6959vfq0RfvXauzt9pH5FtAvDp3/IFwxaYkkp9
         p0/JWvxQiZ4iUIW98K6kpg5oWS2UVHg7iQV9WYCp93YzKlIwpxXvlfS/sMcTlq5w7Sho
         lgMBELWKHxI/mnzKtPwnw66ztSz2XftnQu1VfNGf7oYUnMBCUvDeb4wEnJomXmu224gT
         cXsR8FCVZMQ5SoEKQbk0CBNV8A1h+eTpg2pOUd9+NAA5nlIDExpMKGf7JuJLyh3KKI0q
         dFjw==
X-Gm-Message-State: AOJu0Yx6y3cjsz4d7rpvwFsO7mDQkf6RHlnGHyPLvn1GW1543h0DrbH/
	m/tqg0CHNxiZw3tXKpNylFh0KumY5wwkwd88a9TlygUj66Fzy5C7cGGYOrxMuw==
X-Gm-Gg: AeBDietYZntHav0NMcs8meUruho46T3ahmuQdFoofl/gKQFUCdabk3YSr6J78qqCTKG
	dtTxr6ThV8Tm4U8cCgNjOZg9TAEa3Q0xtwfHXyhNDI/sd4lvl7AFIZRd+4iRX3JPRPalViF5qsQ
	Hka8p3E/e5Fe6H7b1A+bMcRdhWwSD8nNm7OM3YwmAryt6o/oLxGNUdPYPY9ngGTgiYiczpD7977
	4DGmGdfrOl6+eGzV1tUU9UkRsNIwaZ/+HfseF5+cIC610KOaLNbQKdsCbhR318JD2wI0H/F4v4q
	DMSv2DeHRXoy8o9YacT+59joxeUGw1uDGd/eUTxhjOSHJdjNgTmtsXE1EUtjsbKqPUU3F/Ql5Wa
	LAuwbla3ekSOiOeciKXkHPDK2YRMnpWeNL9hXCgg2jh4eow9ejO5gpBO3bsR5dj2VtR8H40oYqI
	JirgAocdlnfnOA20PEi54OgiQ+j+eKC6sGHAczG8cdedoRee5arg==
X-Received: by 2002:a0c:e001:0:b0:89c:d50e:b57 with SMTP id 6a1803df08f44-8b6665f1489mr33063246d6.15.1777699730123;
        Fri, 01 May 2026 22:28:50 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8398sm51658596d6.37.2026.05.01.22.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:28:49 -0700 (PDT)
Message-Id: <89932a70f3ace6ff1198628873df702f40f1442a.1777699722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
	<pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 05:28:39 +0000
Subject: [PATCH v3 5/8] urlmatch: define url_parse function
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Define url_parse, a general parsing function that supports all Git URLs
including scp style URLs such as hostname:~user/repo.

It is adapted from the algorithm in connect.c's parse_connect_url
and reuses the shared enum url_scheme and url_get_scheme function
that previous commits made available in url.h. The new parser and
the connect path agree on scheme classification. url_parse has the
same interface as url_normalize and uses the same data structures.

Both functions accept the same URL forms with one deliberate
exception. Bare local paths such as "/abs/path", "./rel"
or "repo" are accepted by parse_connect_url as URL_SCHEME_LOCAL,
but rejected by url_parse because url_normalize requires a URL
with a scheme://host form. A consumer that wants to handle both
URLs and local paths needs to dispatch on url_is_local_not_ssh
before calling url_parse, just as the connect path does internally.

The duplication with parse_connect_url is intentional.
The two functions have different contracts:

  - parse_connect_url

    Calls die() on an unknown scheme
    and returns NUL-terminated host/path
    strings for the connect path

  - url_parse

    Returns NULL on failure while populating
    out_info->err, and exposes components
    as offset/length pairs into the normalized
    URL buffer, matching url_normalize.

Reconciling both is possible, but not in the scope
of the current patch set.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 t/unit-tests/u-urlmatch-normalization.c |  45 +++++++++
 urlmatch.c                              | 127 ++++++++++++++++++++++++
 urlmatch.h                              |   1 +
 3 files changed, 173 insertions(+)

diff --git a/t/unit-tests/u-urlmatch-normalization.c b/t/unit-tests/u-urlmatch-normalization.c
index 39f6e1ba26..3595d893a2 100644
--- a/t/unit-tests/u-urlmatch-normalization.c
+++ b/t/unit-tests/u-urlmatch-normalization.c
@@ -245,3 +245,48 @@ void test_urlmatch_normalization__equivalents(void)
 	compare_normalized_urls("https://@x.y/^/../abc", "httpS://@x.y:0443/abc", 1);
 	compare_normalized_urls("https://@x.y/^/..", "httpS://@x.y:0443/", 1);
 }
+
+static void check_parsed_path(const char *url, const char *expected_path)
+{
+	struct url_info info;
+	char *parsed = url_parse(url, &info);
+	char *path;
+
+	cl_assert(parsed != NULL);
+	path = xstrndup(parsed + info.path_off, info.path_len);
+	cl_assert_equal_s(path, expected_path);
+	free(path);
+	free(parsed);
+}
+
+void test_urlmatch_normalization__parse_scp(void)
+{
+	check_parsed_path("host:path", "/path");
+	check_parsed_path("user@host:path", "/path");
+	check_parsed_path("host:~user/repo", "~user/repo");
+	check_parsed_path("user@host:~user/repo", "~user/repo");
+	check_parsed_path("[host]:src", "/src");
+	check_parsed_path("[host:123]:src", "/src");
+	check_parsed_path("[::1]:repo", "/repo");
+	check_parsed_path("user@[::1]:repo", "/repo");
+}
+
+void test_urlmatch_normalization__parse_url_form(void)
+{
+	check_parsed_path("ssh://host/repo", "/repo");
+	check_parsed_path("ssh://host/~user/repo", "~user/repo");
+	check_parsed_path("git://host:9418/repo", "/repo");
+	check_parsed_path("git://host/~user/repo", "~user/repo");
+	check_parsed_path("ssh://[::1]:1234/repo", "/repo");
+	check_parsed_path("http://[2001:db8::1]/repo", "/repo");
+}
+
+void test_urlmatch_normalization__parse_strips_query_and_fragment(void)
+{
+	check_parsed_path("ssh://host/~user/repo?q", "~user/repo");
+	check_parsed_path("ssh://host/~user/repo#frag", "~user/repo");
+	check_parsed_path("git://host/~user/repo?q", "~user/repo");
+	check_parsed_path("user@host:~user/repo?q", "~user/repo");
+	check_parsed_path("https://host/repo?q", "/repo");
+	check_parsed_path("https://host/repo#frag", "/repo");
+}
diff --git a/urlmatch.c b/urlmatch.c
index eea8300489..bf8cce6de9 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -5,6 +5,7 @@
 #include "hex-ll.h"
 #include "strbuf.h"
 #include "urlmatch.h"
+#include "url.h"
 
 #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
 #define URL_DIGIT "0123456789"
@@ -440,6 +441,132 @@ char *url_normalize(const char *url, struct url_info *out_info)
 	return url_normalize_1(url, out_info, 0);
 }
 
+char *url_parse(const char *url_orig, struct url_info *out_info)
+{
+	struct strbuf url;
+	char *host, *separator;
+	char *detached, *normalized;
+	char *url_decoded;
+	enum url_scheme scheme = URL_SCHEME_LOCAL;
+	struct url_info local_info;
+	struct url_info *info = out_info ? out_info : &local_info;
+	bool scp_syntax = false;
+
+	if (is_url(url_orig))
+		url_decoded = url_decode(url_orig);
+	else
+		url_decoded = xstrdup(url_orig);
+
+	strbuf_init(&url, strlen(url_decoded) + sizeof("ssh://"));
+	strbuf_addstr(&url, url_decoded);
+	free(url_decoded);
+
+	host = strstr(url.buf, "://");
+	if (host) {
+		/*
+		 * Temporarily NUL-terminate the scheme name
+		 * so we can pass it to url_get_scheme(),
+		 * then restore the ':' so the buffer
+		 * is intact for url_normalize() below.
+		 */
+		char saved = *host;
+		*host = '\0';
+		scheme = url_get_scheme(url.buf);
+		*host = saved;
+		host += 3;
+	} else {
+		if (!url_is_local_not_ssh(url.buf)) {
+			scp_syntax = true;
+			scheme = URL_SCHEME_SSH;
+			strbuf_insertstr(&url, 0, "ssh://");
+			host = url.buf + strlen("ssh://");
+		}
+	}
+
+	/*
+	 * Path starts after ':' in scp style SSH URLs.
+	 *
+	 * The host portion can begin with an optional "user@",
+	 * and the host itself can be wrapped in '[' ']' brackets.
+	 * The bracket form is git's legacy way of supporting:
+	 *
+	 *   - IPv6 literals: [::1]:repo
+	 *   - host:port pairs in the short form: [myhost:123]:src
+	 *   - Plain hostnames that happen to need bracketing: [host]:path
+	 *
+	 * Treat '[' followed by 0 or 1 inner colons as the host:port
+	 * or plain hostname form and strip the brackets so url_normalize
+	 * sees host[:port] natively. Two or more inner colons mark an
+	 * IPv6 literal: keep the brackets for url_normalize to recognize.
+	 *
+	 * The scp path separator is the ':' that follows the host part,
+	 * and we must skip over user@ and any '[...]' before searching.
+	 */
+	if (scp_syntax) {
+		char *user_at;
+		char *host_start;
+		char *bracket_end;
+
+		user_at = strchr(host, '@');
+		host_start = user_at ? user_at + 1 : host;
+
+		if (*host_start == '[') {
+			char *p;
+			int inner_colons;
+
+			bracket_end = strchr(host_start, ']');
+			inner_colons = 0;
+			for (p = host_start + 1; bracket_end && p < bracket_end; p++)
+				if (*p == ':')
+					inner_colons++;
+
+			if (bracket_end && inner_colons <= 1) {
+				size_t close_off = bracket_end - url.buf;
+				size_t open_off = host_start - url.buf;
+				strbuf_remove(&url, close_off, 1);
+				strbuf_remove(&url, open_off, 1);
+				separator = url.buf + close_off - 1;
+			} else if (bracket_end) {
+				separator = strchr(bracket_end + 1, ':');
+			} else {
+				separator = strchr(host_start, ':');
+			}
+		} else {
+			separator = strchr(host_start, ':');
+		}
+
+		if (separator) {
+			if (separator[1] == '/')
+				strbuf_remove(&url, separator - url.buf, 1);
+			else
+				*separator = '/';
+		}
+	}
+
+	detached = strbuf_detach(&url, NULL);
+	normalized = url_normalize(detached, info);
+	free(detached);
+
+	if (!normalized)
+		return NULL;
+
+	/*
+	 * Point path to ~ for URLs like this:
+	 *
+	 *     ssh://host.xz/~user/repo
+	 *     git://host.xz/~user/repo
+	 *     host.xz:~user/repo
+	 */
+	if (scheme == URL_SCHEME_GIT || scheme == URL_SCHEME_SSH) {
+		if (normalized[info->path_off + 1] == '~') {
+			info->path_off++;
+			info->path_len--;
+		}
+	}
+
+	return normalized;
+}
+
 static size_t url_match_prefix(const char *url,
 			       const char *url_prefix,
 			       size_t url_prefix_len)
diff --git a/urlmatch.h b/urlmatch.h
index 5ba85cea13..6b3ce42858 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -35,6 +35,7 @@ struct url_info {
 };
 
 char *url_normalize(const char *, struct url_info *);
+char *url_parse(const char *, struct url_info *);
 
 struct urlmatch_item {
 	size_t hostmatch_len;
-- 
gitgitgadget

