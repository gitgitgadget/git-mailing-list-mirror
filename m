From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/8] submodule config: remove name_and_item_from_var
Date: Wed, 28 Oct 2015 16:21:39 -0700
Message-ID: <1446074504-6014-4-git-send-email-sbeller@google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
 <1446074504-6014-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 00:22:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zra2p-00030j-2s
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401AbbJ1XWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:22:06 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34938 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312AbbJ1XWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 19:22:03 -0400
Received: by pasz6 with SMTP id z6so20295608pas.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pb+yYDyQtWK4tA0adTBD0yYpo7YOG+NOp8l6bNAXpXc=;
        b=WSQ9lhLRpw/Rxa+Q9vLSNRxJm5vXsJheR+6Nac46qKkIEkJt86JOonWR68SOnYbvnr
         YZhlAW07IC70g3LMhT0lnV44TwLqJOucCM6YcAaf/Z2oNLjJcQbZcWC1fIH31hyn/qpj
         n4kxBcee4NGyIEPOE39ieh9/vb22LEWQtFvI1ltxocEMW6gA4S5Vxz6wA2G7+G6iN6Qc
         2UU5SAZlyqYF+PNKDTq0ZOraGuaaFTzYUOse65YTI+ItJ5iYIL1LMXyYbo7UXPWd9ezT
         +ABb+JxeR1Im9yNWYhemsmHh/AMQ0L9HUojIjqdjdqgkWFAGig1ZRzwZG1Cqeckj+egl
         t+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pb+yYDyQtWK4tA0adTBD0yYpo7YOG+NOp8l6bNAXpXc=;
        b=So3UKHNAIUBwt2uZ1clYKZ7DNO7IFVRK+i5rCpMvsobJNAb3Gh0T6lOmYCR2oo4Z/A
         aWfzadwCJ4hJxHGHUbqDmk75SKzxGXM8L+spGnn9Q/mvEA0kWG8N+S7bHCNvKpiVYYcb
         0YOJ5rwlRxhVjC09kTD8jzu6z1iJR+ebvJasNegVyHW/uhZGG4u82Z3obtKbLjBO0Y91
         mAPBYbZ+/9Fb9qbxBnthwojz1W9WAN5aoUseHSayh6xfI2z+ME27mcrLIKJtDTEeHYbo
         TeuNu/+/j9bE/MrejC7SSETl/+QZ6oS311hCEvtIyy4n8qySYKUydzJ+iDH12xWqbXoc
         9a3w==
X-Gm-Message-State: ALoCoQkM+GDlCVc+R348UDs+ZkVywM+OCLFqWriOo+7eEeBN4WFVeXg++SCdh2sW02b82btdArJr
X-Received: by 10.68.68.233 with SMTP id z9mr56392763pbt.132.1446074523130;
        Wed, 28 Oct 2015 16:22:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:202f:ecb0:ea3e:b8f7])
        by smtp.gmail.com with ESMTPSA id l16sm47420448pbq.22.2015.10.28.16.22.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 16:22:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.281.g4ed9cdb
In-Reply-To: <1446074504-6014-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280426>

By inlining `name_and_item_from_var` it is easy to add later options
which are not required to have a submodule name.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 8b8c7d1..4d0563c 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -161,22 +161,6 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
 	return NULL;
 }
 
-static int name_and_item_from_var(const char *var, struct strbuf *name,
-				  struct strbuf *item)
-{
-	const char *subsection, *key;
-	int subsection_len, parse;
-	parse = parse_config_key(var, "submodule", &subsection,
-			&subsection_len, &key);
-	if (parse < 0 || !subsection)
-		return 0;
-
-	strbuf_add(name, subsection, subsection_len);
-	strbuf_addstr(item, key);
-
-	return 1;
-}
-
 static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 		const unsigned char *gitmodules_sha1, const char *name)
 {
@@ -251,18 +235,25 @@ static int parse_config(const char *var, const char *value, void *data)
 {
 	struct parse_config_parameter *me = data;
 	struct submodule *submodule;
-	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
-	int ret = 0;
+	int subsection_len, ret = 0;
+	const char *subsection, *key;
+	char *name;
 
-	/* this also ensures that we only parse submodule entries */
-	if (!name_and_item_from_var(var, &name, &item))
+	if (parse_config_key(var, "submodule", &subsection,
+			     &subsection_len, &key) < 0)
 		return 0;
 
+	if (!subsection_len)
+		return 0;
+
+	/* subsection is not null terminated */
+	name = xmemdupz(subsection, subsection_len);
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
-					     name.buf);
+					     name);
+	free(name);
 
-	if (!strcmp(item.buf, "path")) {
+	if (!strcmp(key, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->path != NULL)
@@ -275,7 +266,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->path = xstrdup(value);
 			cache_put_path(me->cache, submodule);
 		}
-	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
+	} else if (!strcmp(key, "fetchrecursesubmodules")) {
 		/* when parsing worktree configurations we can die early */
 		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
@@ -286,7 +277,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->fetch_recurse = parse_fetch_recurse(
 								var, value,
 								die_on_error);
-	} else if (!strcmp(item.buf, "ignore")) {
+	} else if (!strcmp(key, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->ignore != NULL)
@@ -302,7 +293,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->ignore);
 			submodule->ignore = xstrdup(value);
 		}
-	} else if (!strcmp(item.buf, "url")) {
+	} else if (!strcmp(key, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
 		} else if (!me->overwrite && submodule->url != NULL) {
@@ -312,7 +303,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
-	} else if (!strcmp(item.buf, "update")) {
+	} else if (!strcmp(key, "update")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->update != NULL)
@@ -324,9 +315,6 @@ static int parse_config(const char *var, const char *value, void *data)
 		}
 	}
 
-	strbuf_release(&name);
-	strbuf_release(&item);
-
 	return ret;
 }
 
-- 
2.5.0.281.g4ed9cdb
