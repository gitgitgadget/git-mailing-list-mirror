Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03634147C9B
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263362; cv=none; b=GewCqXwy0GTtRY2TevEr752eyvXMGEx6cIYnJeiPJ583e8IPHFfW/x5wGSIjMF9YaBfAZPzkQAtvlFBfC4xauWAIb5M8Uy+oCuiTW3zcUPJMP8oDQZ4GvngEWcVI4URZ8Z2ErJ2+5BZEQMgT++PuMayMWZIN/0tnQdc7vDcyX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263362; c=relaxed/simple;
	bh=cPrAuPfV5k5OJI2m35+ZMnbQl+l33u6QGBNg5GWqPxc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbnpUOb7n403+Dad+OToQNISF+eC5efdpPqIvdS6p2lwf5vKKMLoHRN/K0n+WEKRay9+fSY1rskc7Qx17wyz/EhhiOLcjG3xpB8xATDxY3jQCAw7NOdXETavcZ74GcclNscK4cbZkAtQjGXIvgNTeS1wyQT7YnW55ijl+Je2XAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXdoV8Rh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXdoV8Rh"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso3860008b3a.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757263360; x=1757868160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVhJiGokpFB9wLcvOuvW6oaEB4+iKla7lX6XplvHjoM=;
        b=DXdoV8RhGckqOaa4TzVpCfytuPjIBFw2XZopS9umuGWiYfiybBLFtWhTZGjpTebYPU
         rIc0tZ0K71XvNycZO1PEV++pIEnnbz6jf2uXq8MoNWKE1oat1jM1yv3/naJTp2b4IbZz
         T6c9+DrIWgGLvelS+H5meP9UzfPsRrH3npWPYSRLuV2BXR4w/ib9l4UXa1FsGz1wXNSp
         kqdWn7RbCCvmnWf24MsFpH4T3ytNBs7ieVYCr7eK60cAb3eHf5Fhdb4eRQTCQyNVMX/h
         pmwNpvTCscxaOEPAfp08iKrPr6U+z9bAOXbOkTcI1xTXn0P4fswcSm2+9/aUJ15yHY6h
         o+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757263360; x=1757868160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVhJiGokpFB9wLcvOuvW6oaEB4+iKla7lX6XplvHjoM=;
        b=hbC5nV/+826U8E0nzCR/JHus7VUjq/ktXNg4jI0HojWyC0y3l1+b5lUrXUTb5LFJ6m
         NBQZhvaNwhumSEYhJaiTEAWpsHdWnxRTRypIr+nhb+ZB9hcMGNE0HxCSHHVr3XVKcXLP
         pAx7WMg+liAQcxzgcjqxdaOBikQNYYFeyuru5WJjLv8y/FxFCea+v2HxC8S024OlacxR
         ulYHRvOIx3dA25e0aIVepNRyuSPSYaS6Zm8CDE1xa4poVjgcADswkEQbd0nE5CjPH3PM
         a+O8V79y6wV2RfqyRkwM+97D8NmNToRK8V12rk/P5BTiBxluCjSVcRn1lTf+8jq0yJN3
         wb6g==
X-Gm-Message-State: AOJu0YyLSxCFTWjKZqnQKpD7iKradTnDWGkH1tdJ04gbnX4X7wNSSG9x
	NKX0yuomtN23dULNBBQBo5/cNUEWy9fx0TvGeDcm0qbJRtaUX7/JnoR+/6mfzgBi
X-Gm-Gg: ASbGnct0TEoSXEcHECQ2BOdXAMMnsJlGXeSF2zFP5hWGpwsYAOLqw3mTN8u04HlOogN
	hYEvABGnmIc1lHk35T/J0/2Sby/LKJGaU2RHxQNlO4iHw2ZBpzWcL1YF0dTELRTeUFm6z/Azr97
	zjJ5UzyWHJcWCAkvZGiMvdc/Y2V2q+i/HqJ6N4+iuF2kLTuq7f00pczI596oRwNvpEGR4un15PR
	babZTGZPoF/BasL8p+EkIMOu+UWMfj0WsIdgLOw6szWDjlEi6pwsKB9LJv1PGyT0a1VWrTq49yE
	z85GbG1xNBEqyLnz/Vfezyzl79G1C7z2q5SPmsWZIwFiBpSurEYmA1y+PZli6fwGse1e23SzfMa
	6seKg1HO+sajeIOJ0Nw==
X-Google-Smtp-Source: AGHT+IE789REuYRN0/bFJewxakViJz+8IkNARaOlPWZxweYSPcsDJ4Mo6CbShyoVW2eU3CLs20oErg==
X-Received: by 2002:a05:6a21:998d:b0:24e:e270:2f5d with SMTP id adf61e73a8af0-2534547a6fbmr7987050637.43.1757263359776;
        Sun, 07 Sep 2025 09:42:39 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4e673ad423sm21086089a12.50.2025.09.07.09.42.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:42:39 -0700 (PDT)
Date: Mon, 8 Sep 2025 00:42:37 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 3/4] string-list: change "string_list_find_insert_index"
 return type to "size_t"
Message-ID: <aL21_e9B8aCpPRyX@ArchLinux>
References: <aL21cEM0OcnrKtBW@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL21cEM0OcnrKtBW@ArchLinux>

As "string_list_find_insert_index" is a simple wrapper of
"get_entry_index", we could simply change its return type to "size_t".

Update all callers to use size_t variables for storing the return value.
The tricky fix is the loop condition in "mailmap.c" to properly handle
"size_t" underflow by changing from `0 <= --i` to `i-- > 0`.

Remove "DISABLE_SIGN_COMPARE_WARNINGS" from "mailmap.c" as it's no
longer needed with the proper unsigned types.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 add-interactive.c | 2 +-
 mailmap.c         | 5 ++---
 refs.c            | 4 +---
 string-list.c     | 4 ++--
 string-list.h     | 4 ++--
 5 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 9a42b3b38b..2005f56b69 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -222,7 +222,7 @@ static void find_unique_prefixes(struct prefix_item_list *list)
 static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 {
 	int exact_match;
-	int index = string_list_find_insert_index(&list->sorted, string, &exact_match);
+	size_t index = string_list_find_insert_index(&list->sorted, string, &exact_match);
 	struct string_list_item *item;
 
 	if (list->items.nr != list->sorted.nr)
diff --git a/mailmap.c b/mailmap.c
index 253517cdf6..0168342650 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -244,7 +243,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
 					      const char *string, size_t len)
 {
 	int exact_match;
-	int i = string_list_find_insert_index(map, string, &exact_match);
+	size_t i = string_list_find_insert_index(map, string, &exact_match);
 	if (exact_match) {
 		if (!string[len])
 			return &map->items[i];
@@ -266,7 +265,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
 	 * overlong key would be inserted, which must come after the
 	 * real location of the key if one exists.
 	 */
-	while (0 <= --i && i < map->nr) {
+	while (i-- > 0 && i < map->nr) {
 		int cmp = strncasecmp(map->items[i].string, string, len);
 		if (cmp < 0)
 			/*
diff --git a/refs.c b/refs.c
index f1ff5bf846..a8f06b9a0a 100644
--- a/refs.c
+++ b/refs.c
@@ -1688,8 +1688,6 @@ const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
 {
-	int pos;
-
 	if (!extras)
 		return NULL;
 
@@ -1699,7 +1697,7 @@ const char *find_descendant_ref(const char *dirname,
 	 * with dirname (remember, dirname includes the trailing
 	 * slash) and is not in skip, then we have a conflict.
 	 */
-	for (pos = string_list_find_insert_index(extras, dirname, NULL);
+	for (size_t pos = string_list_find_insert_index(extras, dirname, NULL);
 	     pos < extras->nr; pos++) {
 		const char *extra_refname = extras->items[pos].string;
 
diff --git a/string-list.c b/string-list.c
index 224bc182ff..e69923cd88 100644
--- a/string-list.c
+++ b/string-list.c
@@ -91,8 +91,8 @@ int string_list_has_string(const struct string_list *list, const char *string)
 	return exact_match;
 }
 
-int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  int *exact_match)
+size_t string_list_find_insert_index(const struct string_list *list, const char *string,
+				     int *exact_match)
 {
 	return get_entry_index(list, string, exact_match);
 }
diff --git a/string-list.h b/string-list.h
index 03c7009472..f6be2bd5c7 100644
--- a/string-list.h
+++ b/string-list.h
@@ -173,8 +173,8 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
 
 /** Determine if the string_list has a given string or not. */
 int string_list_has_string(const struct string_list *list, const char *string);
-int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  int *exact_match);
+size_t string_list_find_insert_index(const struct string_list *list, const char *string,
+				     int *exact_match);
 
 /**
  * Insert a new element to the string_list. The returned pointer can
-- 
2.51.0

