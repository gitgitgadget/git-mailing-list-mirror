From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/8] submodule-config: remove name_and_item_from_var
Date: Tue,  2 Feb 2016 09:51:32 -0800
Message-ID: <1454435497-26429-4-git-send-email-sbeller@google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 02 18:52:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQf7S-00023T-F9
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 18:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbcBBRvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 12:51:53 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34628 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290AbcBBRvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 12:51:50 -0500
Received: by mail-pf0-f169.google.com with SMTP id o185so103972302pfb.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 09:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GnHJW0B4bDfIzCOPzCNOLKoW4P33Rb5eGozuZIhB8qg=;
        b=dpk6FkihF48o1ES5WvYnv6XWxcRjMdWohsxW7ste5x0h592LYnXJgNCxE8IW0z00Of
         kmOjW3/Avmya4lNbbKoMW1QTJKBOQjGnqyBvguwm/QQEfYfgr8lISl6MYuQGDtco5AJc
         Vc5uzWmTHa5QMeoRGdmQY3k9+6fmqJRa4iCswFvsVAhau/pio2sJ/Ey4HDsokHxK0LnN
         YyA29nGrnTmhDn9zkmLWxV4iqETxV+krucJ1112mQDhQwsOJEAGRh4xcUFkk4mIMKR3R
         k/G1wEy0zSztbG7lIG33wmk7u6LDKXztK7M1+Mt46h30YIA2Wm2WAdz0gFSLALMoHoae
         BWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GnHJW0B4bDfIzCOPzCNOLKoW4P33Rb5eGozuZIhB8qg=;
        b=mgX5fEIYhHnxqsOOyDcj1gnWzLFHpmM5ncEwB7l4yfKyTL9Uzff8B3DNy1zBy7hpFm
         K9t16XXSlhxEfHnbt6Qk/jWoLK7M6QGkoujyPtzXp97SIH7YcPhg0XI2kD1uqk+63cFq
         th3bqMAYOOhLgANqVPZQFgtv5rFJYQhZKQ+QESo7X4QmpeW5UY+eYzsrbwSHhUqfDSgP
         2q72g/ZgOT3rEL1EvY19lSHo2s3CGdmoWQpqUphtPryfBTTHkmy94tH3rU4yUxwVDJXH
         ppyTRZXUY4KgKYS/cOoMzpRvyvyZpjLYw24h8TbtdwLIIwB9slpMYtnBtO2dlsOnrCfU
         VfmQ==
X-Gm-Message-State: AG10YOSNNQcfN4sBYOp28YFgYkEaGw3xJvOGsKEcgaOr/j3oJ3BiDbnzjTK10c3SyhVlZhqK
X-Received: by 10.98.72.215 with SMTP id q84mr1329138pfi.152.1454435509435;
        Tue, 02 Feb 2016 09:51:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:11e1:ff63:6d72:465a])
        by smtp.gmail.com with ESMTPSA id cf6sm4013154pad.41.2016.02.02.09.51.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 09:51:48 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.ge5f5e2d
In-Reply-To: <1454435497-26429-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285287>

`name_and_item_from_var` does not provide the proper abstraction
we need here in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.7.0.rc0.42.ge5f5e2d
