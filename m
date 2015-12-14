From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/8] submodule-config: remove name_and_item_from_var
Date: Mon, 14 Dec 2015 14:54:20 -0800
Message-ID: <1450133665-3783-4-git-send-email-sbeller@google.com>
References: <1450133665-3783-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 14 23:55:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8c1t-0001H0-76
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbbLNWze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:55:34 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35448 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbbLNWzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:55:01 -0500
Received: by pff63 with SMTP id 63so18851429pff.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fB5m5Jv/lrR9wmtcijpwpv2bg4f2uKLS+zZC0fTgysg=;
        b=HGMlX9V/8MrUK0L+JLgcsKRXqv9wgwbVK0VaSOc5RLQvCrrET1U6nKE63D52OgLVKe
         vO1oGRQg6S+yRFGgdMT8FTdNiDsZpcyArPZV8tko83lSSvsnDzo0Cffbeb8dB4Yr0dMe
         tGNbmM/0/9vXq05MWWUIedgK5p0fH1xeu12qnkoq3tQK5fSF68Q0E6yvU6CQhR/Q4oK8
         jK9T+XvlHhHcvpgFxckAk7GszOSkwVy9ODfZj6WXlb8oH99cc02x+xkoJES/2JmAkGJk
         XVUKYMqm3G7rBuyLdzZk/cyJAQSYRdA254i+mGu5vBsU4MFVFnD7I6PTfqGFqXCKe0UC
         w6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fB5m5Jv/lrR9wmtcijpwpv2bg4f2uKLS+zZC0fTgysg=;
        b=XQRh3HG0C6NhnQwFP3TGrelGN4HltlU6HLR+VcDIPWXBWJDo4Rt0MLQ1OstH87sSwQ
         wZqNNOLa6aE5Brxa1tRWXQAE/B2ug6cm+3TBZd/8Pfh1haqPQc8CqCeX1iNKS+Z4ltYY
         8ARZktgzWuBqQSarnN4vd278HntbnbbDwwSANCe9uOgCSjjoSTmhi+8ytYK1KuQv7oK2
         OfuqDLHYn9wZMkZk7dI7mZfUPCcuXmxAzsAMh97CIl53a7wetzMiVsNWstithL1IeVYI
         9sWxKghEsgm3aGpi3Q9fCsz1kRjD3GmRm/+9XxV39Q+oGx7hL4ejp8BXv2aFwZPzj3Lj
         nSUA==
X-Gm-Message-State: ALoCoQm96YE9rN8wClyXcM5bGvFxpvnUB43RKlXr0DSfxeiFnmhc7RUy6D7RxNrxAcTSw8bKGHma2GnUEG13vd8Z4XMhiA32lw==
X-Received: by 10.98.71.217 with SMTP id p86mr40071275pfi.162.1450133700332;
        Mon, 14 Dec 2015 14:55:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e502:49aa:9791:cefa])
        by smtp.gmail.com with ESMTPSA id sy5sm45002001pac.5.2015.12.14.14.54.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 14:54:59 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450133665-3783-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282435>

`name_and_item_from_var` does not provide the proper abstraction
we need here in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 48 ++++++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 6d01941..b826841 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -161,31 +161,17 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
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
-		const unsigned char *gitmodules_sha1, const char *name)
+						  const unsigned char *gitmodules_sha1,
+						  const char *name_ptr, int name_len)
 {
 	struct submodule *submodule;
 	struct strbuf name_buf = STRBUF_INIT;
+	char *name = xmemdupz(name_ptr, name_len);
 
 	submodule = cache_lookup_name(cache, gitmodules_sha1, name);
 	if (submodule)
-		return submodule;
+		goto out;
 
 	submodule = xmalloc(sizeof(*submodule));
 
@@ -201,7 +187,8 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
 	cache_add(cache, submodule);
-
+out:
+	free(name);
 	return submodule;
 }
 
@@ -251,18 +238,18 @@ static int parse_config(const char *var, const char *value, void *data)
 {
 	struct parse_config_parameter *me = data;
 	struct submodule *submodule;
-	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
-	int ret = 0;
+	int subsection_len, ret = 0;
+	const char *subsection, *key;
 
-	/* this also ensures that we only parse submodule entries */
-	if (!name_and_item_from_var(var, &name, &item))
+	if (parse_config_key(var, "submodule", &subsection,
+			     &subsection_len, &key) < 0 || !subsection_len)
 		return 0;
 
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
-					     name.buf);
+					     subsection, subsection_len);
 
-	if (!strcmp(item.buf, "path")) {
+	if (!strcmp(key, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->path)
@@ -275,7 +262,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->path = xstrdup(value);
 			cache_put_path(me->cache, submodule);
 		}
-	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
+	} else if (!strcmp(key, "fetchrecursesubmodules")) {
 		/* when parsing worktree configurations we can die early */
 		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
@@ -286,7 +273,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->fetch_recurse = parse_fetch_recurse(
 								var, value,
 								die_on_error);
-	} else if (!strcmp(item.buf, "ignore")) {
+	} else if (!strcmp(key, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->ignore)
@@ -302,7 +289,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->ignore);
 			submodule->ignore = xstrdup(value);
 		}
-	} else if (!strcmp(item.buf, "url")) {
+	} else if (!strcmp(key, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
 		} else if (!me->overwrite && submodule->url) {
@@ -312,7 +299,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
-	} else if (!strcmp(item.buf, "update")) {
+	} else if (!strcmp(key, "update")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->update)
@@ -324,9 +311,6 @@ static int parse_config(const char *var, const char *value, void *data)
 		}
 	}
 
-	strbuf_release(&name);
-	strbuf_release(&item);
-
 	return ret;
 }
 
-- 
2.6.4.443.ge094245.dirty
