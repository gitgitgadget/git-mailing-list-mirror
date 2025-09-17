Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55232DE6E9
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100798; cv=none; b=baqBMD5UuFzvcRVjpWxNFN1ZF0mXiUXWZ31EjQyiOeEyYZphNCj6sbmGygYnz/2p8ZwT8kMlerDk/P6oEBN5cSRL3ETqVpOmBrAXDvS70ZjgAVQomTwGAUIZuKO560xo0wDzNzlyxSciEI5334SDTt3Zizz/6y+e4aRbXzyEmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100798; c=relaxed/simple;
	bh=8aA+EBL3OwfsC9bYddeFl+H+nqFLszdI3uU7NmVKEdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4CWsGbO6uvcBZ4f00bUq02hnRIA4d5Oyh0en/RLA3UXo2AM10jQlsaWJXfW1VFvdDOxH9TbjvH7W3ttdZotFts9tpRDYSPghpb0yqvZILEK2DXJeulp2vFSAi291x2QzZzRPeFE/Tz+hfF98KAhRs8zf+mZD9tIQcj+t5sUw2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWUx8jIt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWUx8jIt"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so1791723a91.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758100795; x=1758705595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uvsxS+JRPtLGpObJELeexCdHN87FTVnv1gdxrnLpDE=;
        b=UWUx8jItgVrTB5YrsvJPKvvXWPSJXQKMwzfLxHbS1h5kne+aJD3miHUIujncKGeNev
         Va5iG5Q/XWxKUhFl2KLJsxIF8sP2WajH1x4F/+IuPHZOhPPQdOs5Gs4E9p7+TOr6I1g/
         6Xw0TD4OuiyvoFcoenA+xeFXkxMQGkCIJvtYZwzWSxW5Mq6FfqrOLgYVdG3lKN/Jucmk
         5jDfNo2ER6wN8W4jHbsW1PapqAY7Rsf7jNawyUVRv6nsdFS8Ah7dRTU8V596tXYtTxMt
         D8k8TCCBl7bfdzhW5ziL4nVrsZbjoQDqStYZ5EhaW5+5lY2u+5wA2sixlDHjJ609zvE2
         ZCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100795; x=1758705595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uvsxS+JRPtLGpObJELeexCdHN87FTVnv1gdxrnLpDE=;
        b=O2VkkuykkKdO7GIi++I52fIjrq4knvLPBiKCQPOVqhc7f1QI9Nr0a7xx3xYdscqxkM
         JaRmkQYngX8l919ohrY7smzbiYenNHFxs9+NOj0MyW9tw4CbZvQInVsb6lxTG+CRsO4e
         ml6plfthE3VdKCXvw70WF9WbTApStytvX36AI5GAlgRHVNMBQtKwBlDaYPGHVQj1lH07
         aC5qMHccDYZM641KWsJeWsZC/5jyRyB5XnE3AiL6N2nwR7GE+9avgrI6bVDv7zvY0Dcu
         dcwlt8mrLq8jen5uIahXvmgFNWWwQcKMs4FDEhP8es44SFJsTDB/u7jJcCl9b8CjOTWY
         4A5g==
X-Gm-Message-State: AOJu0YxeXO7GK0zxPcqXtXxIJf+rp/AyaUXjyqFV9PwiotQplrACbVdJ
	NRX0CvlGeQB3XIyxdSTz7vQTKD9/Gv63zmlVJVbA7LTvVBPDvq3X1UBlOec5ZQ==
X-Gm-Gg: ASbGnctcm6ZsNF6R6PP507eDiGwq+31FQCi3EBtrqXwboKob0Z4HS6FDxLcEsMSzO4H
	k3wQ4+9ukv/r2LQgaR397bV/FDEMeAcwyEZLXgX2WOIZDDHZRLZp9DELoj53y3MyCtOAZix0r7C
	22/Hj50n9b3Fkogi7Heh98z99AV/+XONxSfJ9a6muH9jeJJ6YblIyQhaaaZJ/gdy2ETfsqCR10z
	cLpPrF/vmZda4EywiXHIvHs4HzMTZ4BXUkincl1UiV9UlUp4h1pZHnIJHRGB0uaaovS3bAtgRQi
	QoE9Hpe8akEQ1TGzGtH3LEXFg4NH0p3WxV1O1n8xNA1iogp62PJUWwY2gn4gP/JVG/IiuJfrFlg
	VC2iNhk2VXV0guHwoeQ==
X-Google-Smtp-Source: AGHT+IHBRSVzZ0B4Ue/Gv+7ZbLVcBg/5p8PF7sw4pMzwgGyuczcgUuKuCYrk91QwjgfKnPCwnzi47g==
X-Received: by 2002:a17:90b:33d0:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-32ee3ed39femr1690535a91.13.1758100795295;
        Wed, 17 Sep 2025 02:19:55 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32ea0fb679asm2397759a91.2.2025.09.17.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:19:54 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:20:02 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/4] string-list: change "string_list_find_insert_index"
 return type to "size_t"
Message-ID: <aMp9Qs2AHBax62LL@ArchLinux>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMp8yNFiXDyk2hP4@ArchLinux>

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
 add-interactive.c | 2 +-
 mailmap.c         | 5 ++---
 refs.c            | 4 +---
 string-list.c     | 4 ++--
 string-list.h     | 4 ++--
 5 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 7c0fd3d218..19def3168a 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -222,7 +222,7 @@ static void find_unique_prefixes(struct prefix_item_list *list)
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
index 8830ce671d..6b0a2f4752 100644
--- a/string-list.h
+++ b/string-list.h
@@ -173,8 +173,8 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
 
 /** Determine if the string_list has a given string or not. */
 bool string_list_has_string(const struct string_list *list, const char *string);
-int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  bool *exact_match);
+size_t string_list_find_insert_index(const struct string_list *list, const char *string,
+				     bool *exact_match);
 
 /**
  * Insert a new element to the string_list. The returned pointer can
-- 
2.51.0

