From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 3/8] submodule-config: remove name_and_item_from_var
Date: Mon, 11 Jan 2016 11:41:56 -0800
Message-ID: <1452541321-27810-4-git-send-email-sbeller@google.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 11 20:42:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiME-000520-3y
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934629AbcAKTmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:42:19 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36744 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934625AbcAKTmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:42:17 -0500
Received: by mail-pf0-f180.google.com with SMTP id n128so49341143pfn.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C/YI/HenPPapL95OqCYcFz50hcqLXtsajVCEkq8tI1U=;
        b=UjSceCxShugcySxpqx8eclYMdiCJGsSeqNczQUfqvQ0PSKQimP8ODWvLUg/qbg57mp
         LoYkhvXcPgTbTff8KYOZeTS5NubAy3CtEDBYA5z7PWQxKIVGRisghLvq0tkXKC1uLMji
         mmhUcy8eSsmdthXXbzQVeh7YOx4P4Alo+zHAK5QOJRT3vg8JDeCXlUO/h3BRXVs89YYL
         YYEc+u3yLrIPPznEqUuJx+NjQ9uadMSeSeOlo4LOHQjWbIVcyjBfpS+5fAU0ZgwUT5zF
         o8oZbA/vn3GE4i4BXnGS5/ETONnwQfODda0i2vkAwjwCnUehhOIUoTvY5WsWfP62JXBH
         Afjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C/YI/HenPPapL95OqCYcFz50hcqLXtsajVCEkq8tI1U=;
        b=NCoDHmEFVaLoEl1n0b34cyzbtzOUQo9oFY+rvpSjGKBpBcNMrtxLeZn3anr+cxNVuK
         lF7mP3Ds3o/FyBIaYjtzTndWSrk85al/qXNC4nFnpWLg3Evi+0h0wHjyq7rr/ReWaz52
         Th45k3vgqsxU1k/A9T5UImW/X5fwltbnoxc6MX/B+EZJkhPWKLAwuSIv6m83BjhMz4AF
         +h8lMHCB1C3sqVf3corcilT+orB4wYvb18eoVlmecBgFU+MRz4iGRFAOrkBL0hVA/0hK
         M7yMH8p4SddS5wVyn8bO1lhF2Rp7rzUcpRhhQnuBGBzQLJRaHgFYpOW0+/llY1ND53kn
         aoaQ==
X-Gm-Message-State: ALoCoQmiZEpdq+TCEnmUTM5SIBUlEUIh3o3txlm3UjxlBpEt1nHdxY/Jd+OwHIxIv/eDFChOsqhHPgaEv3fZTocIexshrqtYdQ==
X-Received: by 10.98.80.135 with SMTP id g7mr19262146pfj.132.1452541337144;
        Mon, 11 Jan 2016 11:42:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8d8c:9316:e7e7:6f4f])
        by smtp.gmail.com with ESMTPSA id 17sm25060496pfq.51.2016.01.11.11.42.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Jan 2016 11:42:16 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.7.gf4541cb.dirty
In-Reply-To: <1452541321-27810-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283706>

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
2.7.0.rc1.7.gf4541cb.dirty
