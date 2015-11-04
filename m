From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 06/11] submodule-config: remove name_and_item_from_var
Date: Tue,  3 Nov 2015 16:37:09 -0800
Message-ID: <1446597434-1740-7-git-send-email-sbeller@google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:37:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztm55-0002qW-Uv
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 01:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbbKDAha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 19:37:30 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36259 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbbKDAhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 19:37:25 -0500
Received: by pacdm15 with SMTP id dm15so9425217pac.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 16:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9O78fjqUGyU9ICcjXY0c7u5bHFNu1+Zppdd6QvDR6yo=;
        b=XBOY/z+aV9ujAx6DGadV9V7nRdSVtqqv/wV7bSSTDQH+eAh4Y3xUosopBQUz0eIE/J
         a+FcxcX5D17qtpCZtgJ8M7wCvfRT1vCz7XV0DUFwzcyAfkdIKdUteLk9m4vNJXDVHPT7
         KI1N0vlJzgI3wTC1UISCn4id82Q9ibCI1Hsn1qojFSv5WrkcaRlsiMWqob2OEZr6s5tC
         BJSr8WCEGNDgPIngTp6e+shKmn4fmWgT9gNeyhxHAGSk1TdEltW8QZw8r1tA2vqOIdmU
         RpSTyGBygOi9RgvEc+uA+D4Di94xHj66mh7sm938UHT1jsuJ84gFplz35o6nLxRO5KcW
         VhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9O78fjqUGyU9ICcjXY0c7u5bHFNu1+Zppdd6QvDR6yo=;
        b=m1bRmoOf24r3YBBDHF9kwwitkGcApO3av+llcXCyMcZODWqHkSPEMh9s9daC20p1i4
         H5bQnQ8t7IqMSHVqEah7FM8QQBNb+78yxUw0H/JfPrAEBVa0nq8CiQa//eqyiFQibHeD
         rakTZgcXh3UWDZZdsSWFWc9coy9IhMr98Uzc6+PTsAEEAHVsFKrnEOna3DNBZS6bN5c4
         tp9AuahpG7wSd8o6bf7Q4IVJANjmNVP5PD11tVHrEj2XSK+Yzxf12QyjkvE9m9oOcuWE
         iN6QmIeNnWcEoCGy8Dq/scEYB0CoJkJkCX1MUFTZasT/HWpGiIFQv5sNjEbu7hhcm2N2
         epFA==
X-Gm-Message-State: ALoCoQlNhhPTiQ6sHf+xAGceku5VW97G8TfohOb+DUEkj4RH0cCZvuZOAOA1beWikbYdDwdK9w28
X-Received: by 10.66.248.137 with SMTP id ym9mr37678454pac.157.1446597445393;
        Tue, 03 Nov 2015 16:37:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:799e:c67e:2702:f55])
        by smtp.gmail.com with ESMTPSA id uy1sm26762624pac.39.2015.11.03.16.37.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 16:37:24 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446597434-1740-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280834>

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
2.6.1.247.ge8f2a41.dirty
