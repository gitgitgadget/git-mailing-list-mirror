Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A914C1FAAD
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdA1CC4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:56 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35616 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdA1CCo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:44 -0500
Received: by mail-pg0-f53.google.com with SMTP id 194so85529057pgd.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8AclS5Yr/ayzoJKwXwIAgkpFAG3mkJFELI91DfHeTI=;
        b=u3HG/lJom9KqbjN32qIFTNgDj92jaaTAphRBl0wszZ//beMezbUx5yr/kkq5FkLMzG
         ZulfZEgCQ8nfKWkpZfIVnzCZYXG1B1S5vK2U2IXGkUrL4QaCSALC+grupHa6LJKvq7et
         lcM+ACzgE131hH2PZbHVnGgZnMcDlRYf5o/sr4OfM2zubGOaXQdlNtnAPh80J57rgQB/
         kA3U9d6FX9/RXSNPjsJhKJpeqpMW+GmzuGSd/sPa021nH7SR1XcGkvPFBFFdUXHF6sry
         PnDP/8wCjbxmWXtZHRlL8DzkIN+37bx1dSzrzCZwFtdg9e8b0bI6XmOtlLNC+fxpayh8
         caFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8AclS5Yr/ayzoJKwXwIAgkpFAG3mkJFELI91DfHeTI=;
        b=YdNYVeyPbQdGs2ghhel1qhlJe1xm+e73InDX6dmPoJeIUJeXokr0SUVOTsqAUcGh8E
         tfhPQEwynwqEbdCzPAb28xD8btZyWxwbPsa1ogkaPVZSuw/Rg1n/ylqNJXPmV8SRXKvA
         dAHgX6URqHFORYedE92qLsIffXZfP37rRES3ZY0QcdI0Vm7Dpu7y/R06royJIK2HdbT8
         u7oQ3dpnob5pz+/pAcULcoh0TLbDKrzHRuPTIDTgOfYtRE9dAq2hr1KtBAj9/wxKmFYR
         k00q0kstWzRPKCmotRg7w9/Ar2+CK8RUfkkRm+S2hTOg9GK3EgJvzjSgK8B4IVNNK9qO
         8sUA==
X-Gm-Message-State: AIkVDXK7pn7EfSEtT/ODCMpH1t+LkqIuBfZsi3dYxJvfawbU8GJtYeUTCkK05JrLjqaVU7xC
X-Received: by 10.98.131.136 with SMTP id h130mr12394079pfe.4.1485568963551;
        Fri, 27 Jan 2017 18:02:43 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:42 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, sbeller@google.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 10/27] attr: support quoting pathname patterns in C style
Date:   Fri, 27 Jan 2017 18:01:50 -0800
Message-Id: <20170128020207.179015-11-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Full pattern must be quoted. So 'pat"t"ern attr' will give exactly
'pat"t"ern', not 'pattern'. Also clarify that leading whitespaces are
not part of the pattern and document comment syntax.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/gitattributes.txt |  8 +++++---
 attr.c                          | 15 +++++++++++++--
 t/t0003-attributes.sh           | 26 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e0b66c122..3173dee7e 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -21,9 +21,11 @@ Each line in `gitattributes` file is of form:
 	pattern	attr1 attr2 ...
 
 That is, a pattern followed by an attributes list,
-separated by whitespaces.  When the pattern matches the
-path in question, the attributes listed on the line are given to
-the path.
+separated by whitespaces. Leading and trailing whitespaces are
+ignored. Lines that begin with '#' are ignored. Patterns
+that begin with a double quote are quoted in C style.
+When the pattern matches the path in question, the attributes
+listed on the line are given to the path.
 
 Each attribute can be in one of these states for a given path:
 
diff --git a/attr.c b/attr.c
index d180c7833..e1c630f79 100644
--- a/attr.c
+++ b/attr.c
@@ -13,6 +13,7 @@
 #include "attr.h"
 #include "dir.h"
 #include "utf8.h"
+#include "quote.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -212,12 +213,21 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	const char *cp, *name, *states;
 	struct match_attr *res = NULL;
 	int is_macro;
+	struct strbuf pattern = STRBUF_INIT;
 
 	cp = line + strspn(line, blank);
 	if (!*cp || *cp == '#')
 		return NULL;
 	name = cp;
-	namelen = strcspn(name, blank);
+
+	if (*cp == '"' && !unquote_c_style(&pattern, name, &states)) {
+		name = pattern.buf;
+		namelen = pattern.len;
+	} else {
+		namelen = strcspn(name, blank);
+		states = name + namelen;
+	}
+
 	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
 	    starts_with(name, ATTRIBUTE_MACRO_PREFIX)) {
 		if (!macro_ok) {
@@ -239,7 +249,6 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	else
 		is_macro = 0;
 
-	states = name + namelen;
 	states += strspn(states, blank);
 
 	/* First pass to count the attr_states */
@@ -282,9 +291,11 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 			cannot_trust_maybe_real = 1;
 	}
 
+	strbuf_release(&pattern);
 	return res;
 
 fail_return:
+	strbuf_release(&pattern);
 	free(res);
 	return NULL;
 }
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f0fbb4255..f19ae4f8c 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -13,10 +13,31 @@ attr_check () {
 	test_line_count = 0 err
 }
 
+attr_check_quote () {
+
+	path="$1"
+	quoted_path="$2"
+	expect="$3"
+
+	git check-attr test -- "$path" >actual &&
+	echo "\"$quoted_path\": test: $expect" >expect &&
+	test_cmp expect actual
+
+}
+
+test_expect_success 'open-quoted pathname' '
+	echo "\"a test=a" >.gitattributes &&
+	test_must_fail attr_check a a
+'
+
+
 test_expect_success 'setup' '
 	mkdir -p a/b/d a/c b &&
 	(
 		echo "[attr]notest !test"
+		echo "\" d \"	test=d"
+		echo " e	test=e"
+		echo " e\"	test=e"
 		echo "f	test=f"
 		echo "a/i test=a/i"
 		echo "onoff test -test"
@@ -69,6 +90,11 @@ test_expect_success 'command line checks' '
 '
 
 test_expect_success 'attribute test' '
+
+	attr_check " d " d &&
+	attr_check e e &&
+	attr_check_quote e\" e\\\" e &&
+
 	attr_check f f &&
 	attr_check a/f f &&
 	attr_check a/c/f f &&
-- 
2.11.0.483.g087da7b7c-goog

