Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D567E2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034285AbcJ1S4E (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:04 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33404 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030840AbcJ1Szz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:55 -0400
Received: by mail-pf0-f182.google.com with SMTP id 197so41757870pfu.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9tRS7E01mFmqz7GwZ/U1WU1wStoaoMUMVXHSJeF4K8Q=;
        b=pX5JqlIvEVQ6d7cXhzoPrw4GTARYA2LuK4sDeHLxHE3OsQqcRK14n8xMX9LAn8NeWM
         JGHoskglLFiIabYWiHGuvx5szCL2iLjVgVnxaSXfNY+R6H9hssW+y9O7xacPhAg5aonl
         EVNOu7cjAg/BSsh3+e05Y5VDjwFjmzIg3u6Sxzf3PVvHD+VsCY8cpYLpHCZm5neC8u1t
         G6olvCIyKzdMjk5SRBiRjtrZhRkuQ0kF3+ISU13KfwwjLV3TJRf8kum7J+b7oWcNl9U5
         KmP8RMAQ/5a5EC/cfZub2On3qRC/W1q5pD0HmN90+oqUqnwLXJJ6bi4NhUhs0tgVpi88
         leIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9tRS7E01mFmqz7GwZ/U1WU1wStoaoMUMVXHSJeF4K8Q=;
        b=gtwYEnqWvqZHx6SczfaQsdPTblgCtn1AOFr1QqPc1KkiLGZ4cg9QYDUdFCPQm7HJfB
         xcz5SCAfpATv+Gfoj5pvo0YsjSYcVENWgd/7d7ecTm4Vrj5XcNxd67BQ3XKT21tWyIaQ
         UJt3iCuU62ZfWV9HXZgyGfNpLztXybVKN8v+Cutny7ovS98QkXojs3/EyhNd5glL7oCJ
         lIR7exBOy3f21J0wQmBeDesjHkYvc2s8W19yCe/NZo4wBKYA+Z97beToJn++Y74HTSRc
         r+9OjXf1sZoSDYG2XgZ7dlPoxqytCOXLBISzovnpkhqvplBXIQMH05k4E9LZqawJEb+E
         1QeQ==
X-Gm-Message-State: ABUngvcmKzWWqTFPjduI5PYad5hxjeA9LYRmZ9To53BydDLT8TYlQDV13lUCUpq7KxBG43U1
X-Received: by 10.99.42.80 with SMTP id q77mr22781267pgq.3.1477680953603;
        Fri, 28 Oct 2016 11:55:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id w15sm20590400paj.33.2016.10.28.11.55.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 18/36] attr: support quoting pathname patterns in C style
Date:   Fri, 28 Oct 2016 11:54:44 -0700
Message-Id: <20161028185502.8789-19-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
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
---
 Documentation/gitattributes.txt |  8 +++++---
 attr.c                          | 15 +++++++++++++--
 t/t0003-attributes.sh           | 26 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 7aff940202..8a061af0cc 100644
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
index 33021cc857..c8c4936f36 100644
--- a/attr.c
+++ b/attr.c
@@ -13,6 +13,7 @@
 #include "attr.h"
 #include "dir.h"
 #include "utf8.h"
+#include "quote.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -225,12 +226,21 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
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
@@ -250,7 +260,6 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	else
 		is_macro = 0;
 
-	states = name + namelen;
 	states += strspn(states, blank);
 
 	/* First pass to count the attr_states */
@@ -293,9 +302,11 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
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
index f0fbb42554..f19ae4f8cc 100755
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
2.10.1.714.ge3da0db

