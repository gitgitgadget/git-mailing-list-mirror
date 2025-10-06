Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BA1C07C4
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732363; cv=none; b=HdGLDNl4BJO3qcEMQTla+A81zRbBGBh4PPhTDr7AF8zaB6y6ky0LFgA/j+mt+X3jHoREfMxZndthJ2e5E0pTSs6i8bCSbtZSaS6f8NQTalqhoS6+0xxgqViuR5OrPxj8xi0OzzznXab0y1TFkOvcCKvTgFtCOoK5N3rFiRQX5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732363; c=relaxed/simple;
	bh=dqJopOA2pk4QKpC4vhxqfma5e3CYZRv8U+3pR6ZOzcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/FGq0340iVDzLk09gHbZkxHFptewC/H7fNrZOnYXVhxILSh6pylfMsuMhkwlkL8IRJLxPTMhR5mNBV/8YqwZ+qO/wx3COG/lZwN8oVXPprSoPrQCHRoAhkn0w26pRpDuKhDfK8z05AVUobpzVStocdhciZfXwix61gO9Ycpbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH7udpDm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH7udpDm"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so3964895a91.0
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759732361; x=1760337161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1i1/dC/Eq/Ej/1gI9GRKTs9HNIOjsH9KrUfHqULofXk=;
        b=bH7udpDmfAImWWqL1y/s7mo+b8IJ3p2BGdAXejqlCsezoYieQoAar22aCN1wb+p8mh
         WH65iKidtoaGKc3/HZsCYwAC3sHBaQWEuVQykfYmMYKRIx6KzyyIdh8FVGW2/Y4m5yIi
         2aSbi2USgb8p5CHJgYOxhkcoXYrPblkH3llL8yjhUdDaj1k3V9hvm+PXBXlpXDD/3n/c
         M4rn+hHrCiImOHcghg15F+o7ia7MRhOw6hzTAvyO7MHZcg4itS5hkXiN40PMIyLuci9F
         gyJn3OQ12arU6mJSiKzNqLtHipaMJSGch/D2WSHzS8gXDzKPK1lRe4Ws+j6tpxGmzXBL
         DQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759732361; x=1760337161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i1/dC/Eq/Ej/1gI9GRKTs9HNIOjsH9KrUfHqULofXk=;
        b=eGLOav2lFcGyoUDuJ1nIZ0+2ht/yp7m6fRobY1HEAd0zuRPHkzb6swBeaa++U/URtb
         SRiFIHgID9iB+IgsaRd4AAu1Rbl+/tBJkzdyoqBBp3d/2ppXf4m7XSIuf5di9inVXrYX
         u/djV7tvBNZv7cVjCMH4IWevBLJ5Y1aVAg1pThKm6NlpnKChPnhXDjP0nBi/yWBJWejo
         s9t2OaTygHUpEMu+BDUn+VRkaP/gBLqNFIkOmCzvSU6sdxjadWDgdVCrEaQBVMCGiGKo
         Hs+sY95ZFFb+nJ4eUEyHBj8dZlLre5egt9ww6Lykc2DbC6cCVQu5UxOKSGIWIW1PgRNZ
         CiSA==
X-Gm-Message-State: AOJu0Yze9RRz2oVjkhuEfo307I/zV5jrKzEWLCfDt68Sd+1gb5R5PRTJ
	fZfffRe1ZEJTwCo/8tiWu7Q89Wr/0HVh6xrzeHHd5CQ62/FUmuojGrCQbEqfSw==
X-Gm-Gg: ASbGncuRR6NH4QHmBxYKM9Unml0QOG+5nKExcfSPGxbhqwcla/hrBDP++K57TS4QywK
	MjZTdXyjeb00W4JeO9fWUyI7pMkzoY3EqRQOZ6v1yy6bhks6Hv4R6vbW7mVp3nq4NdpJmbDlj5p
	cDxTs/SRYNwj4/nBjQu4KUYwHBpkxKKCjyVKqAVxvg6W/xK2QBFWrZNIAGsnLGoTKiOpNofZNvM
	F5LT9k4m+1kOKkB16hnmXB2Qs81KxxLNL4dVhzNxInGJ/QRFcKr78gk2qJN9rwANNcn968/84DL
	ngjQJhZqWl5vCzqDRzywBGwLwmDFMXojOOqupOCxl8Tsfgla4i/F86AASlcJswA67WDCUHf1tsz
	/QGK0jrXeBL73R/zqwgaCU7ZPMGLJNbA3WECANTCizWcxeY4N+kd5VH+p6g0qxK4=
X-Google-Smtp-Source: AGHT+IHIobq8xOAldn/uLqzjZcpIA+MBuAo+G2cMiYI70+0amn6RZLoQt5hA5ry+N0cIxF9/UB2xqQ==
X-Received: by 2002:a17:90b:1e10:b0:32e:6019:5d19 with SMTP id 98e67ed59e1d1-339c27bf6c3mr12170788a91.34.1759732360696;
        Sun, 05 Oct 2025 23:32:40 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b6099f729c3sm11232823a12.46.2025.10.05.23.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 23:32:39 -0700 (PDT)
Date: Mon, 6 Oct 2025 14:32:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 3/4] string-list: change "string_list_find_insert_index"
 return type to "size_t"
Message-ID: <aONiiGlaUfT5cJpd@ArchLinux>
References: <aONhmrE0otiyZ16f@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aONhmrE0otiyZ16f@ArchLinux>

As "string_list_find_insert_index" is a simple wrapper of
"get_entry_index" and the return type of "get_entry_index" is already
"size_t", we could simply change its return type to "size_t".

Update all callers to use size_t variables for storing the return value.
The tricky fix is the loop condition in "mailmap.c" to properly handle
"size_t" underflow by changing from `0 <= --i` to `i--`.

Remove "DISABLE_SIGN_COMPARE_WARNINGS" from "mailmap.c" as it's no
longer needed with the proper unsigned types.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 add-interactive.c |  2 +-
 mailmap.c         |  5 ++---
 refs.c            |  4 +---
 string-list.c     |  4 ++--
 string-list.h     | 10 ++++++++--
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 21bc3dca96..68fc09547d 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -245,7 +245,7 @@ static void find_unique_prefixes(struct prefix_item_list *list)
 static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 {
 	bool exact_match;
-	int index = string_list_find_insert_index(&list->sorted, string, &exact_match);
+	size_t index = string_list_find_insert_index(&list->sorted, string, &exact_match);
 	struct string_list_item *item;
 
 	if (list->items.nr != list->sorted.nr)
diff --git a/mailmap.c b/mailmap.c
index 58a4484963..37fd158a51 100644
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
 	bool exact_match;
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
+	while (i-- && i < map->nr) {
 		int cmp = strncasecmp(map->items[i].string, string, len);
 		if (cmp < 0)
 			/*
diff --git a/refs.c b/refs.c
index 74266e6392..b7c0aff85e 100644
--- a/refs.c
+++ b/refs.c
@@ -1710,8 +1710,6 @@ const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
 {
-	int pos;
-
 	if (!extras)
 		return NULL;
 
@@ -1721,7 +1719,7 @@ const char *find_descendant_ref(const char *dirname,
 	 * with dirname (remember, dirname includes the trailing
 	 * slash) and is not in skip, then we have a conflict.
 	 */
-	for (pos = string_list_find_insert_index(extras, dirname, NULL);
+	for (size_t pos = string_list_find_insert_index(extras, dirname, NULL);
 	     pos < extras->nr; pos++) {
 		const char *extra_refname = extras->items[pos].string;
 
diff --git a/string-list.c b/string-list.c
index c589ab5a2c..08dc00984c 100644
--- a/string-list.c
+++ b/string-list.c
@@ -91,8 +91,8 @@ bool string_list_has_string(const struct string_list *list, const char *string)
 	return exact_match;
 }
 
-int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  bool *exact_match)
+size_t string_list_find_insert_index(const struct string_list *list, const char *string,
+				     bool *exact_match)
 {
 	return get_entry_index(list, string, exact_match);
 }
diff --git a/string-list.h b/string-list.h
index 8830ce671d..fa6ba07853 100644
--- a/string-list.h
+++ b/string-list.h
@@ -173,8 +173,14 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
 
 /** Determine if the string_list has a given string or not. */
 bool string_list_has_string(const struct string_list *list, const char *string);
-int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  bool *exact_match);
+
+/**
+ * Find the index at which a new element should be inserted into the
+ * string_list to maintain sorted order. If exact_match is not NULL,
+ * it will be set to true if the string already exists in the list.
+ */
+size_t string_list_find_insert_index(const struct string_list *list, const char *string,
+				     bool *exact_match);
 
 /**
  * Insert a new element to the string_list. The returned pointer can
-- 
2.51.0

