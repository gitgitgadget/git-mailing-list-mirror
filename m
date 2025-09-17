Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0B248F40
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100789; cv=none; b=QiBvCFa8xEAhrpdhpwNXrJP1qnxxQmQ9yI0JcHwXwMghJVP58EAweJHUzI2IBYDHCB9d+Y2STSxfA9owjaashb3dli+1dtv5YF/K6HKhoIDTHnHjOExoaEvd5yTzSbaKl3p5Ur3rA/2FkHj8y1mQHtIOhOd3+RdqdiwUB1zc930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100789; c=relaxed/simple;
	bh=4AQsmL+ylsUobpI3Ja8tk668mt4ge3oh2dTMN2k8iwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+XTAEmIyGtQnjRHbfdG2lFIAIOZA8Oxf62Z6kZJwh3NXJ02dgpZE3qycJWQFGBrub8NYr9VvAUXrpP7gVMJ72bKdt0AD5RG3Llnf6n+qnjI6n2ZdSxL7BM2Wl7PtvBkpbUspkEc6NPIhMogiYaKxS497XJlNr7iwzMCHc49JiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDwfLheF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDwfLheF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so1791580a91.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 02:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758100787; x=1758705587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/tDfpOGU7EbXTREUpDkEDcbkpNHlKMiceZy04cSOrg0=;
        b=HDwfLheFJMEo96UsNYFZtB3ygA9t6Ji005PfBZOIPewDwEbxxK+I4wJ37M+69JV/CH
         WmKEh8FBbgOkmP2q/4UVKVLnYB+EUEjIEGzkZ7CXG2GywuOHSZpOvL4LkTAAmJ9uSkt/
         z9uIiavwsEMLXLLOaXyXqKFRltUFTLLDKJ5flnjZyqtNMhzQJSR1BQYNSuV6WhvVmdtc
         crDp4YXa8QIWJouGZhL7ftiErlsfwAmhtMEthDdBv7oT1MSUqjWm/egXW9jxmAmFGzgW
         jAiELtRhQlKM/LNQ/msl8YGGVPE+3w+knSYZCqFSJHunUCXMKFaX/X/GsmerZ9P475Xj
         ozPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100787; x=1758705587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tDfpOGU7EbXTREUpDkEDcbkpNHlKMiceZy04cSOrg0=;
        b=JEOPouOoX5hGcpdiT8dFzAEBeW5UlG7xxQPHajI3UzHWuKV1k+5GaHS3e0ecDtMNzL
         G6+txzxpSI8CJYVGUEpGzRU4jsOpel6/e7G+OGw+e9iZlfIluDaRi/WOqdnP7DtKwWC5
         HYeL5/Fc/8OTm91kUU+x+ZZwevXZBELk68yuqHThEoaKyAz2syCo+nd0H9HeRVx4vYwM
         rO8xNBz4srnmDL2xbaidmP0cNp7EQNFB8FJFvE+gS5jaFj6fyMi6Htz5EX5WxzOG69SH
         67tFcTMpQ1a4/vhLAdw1LMeBElsxCprRzM+CTtVJgqzaVbkboTbxvq1Q11qQM9uTS137
         61IA==
X-Gm-Message-State: AOJu0YyNwzScIp+RPTGLc/cYONwHhIGATWhnE/PJz4XnBftEyc9AMt89
	ePD1BmVcaxDa3S231DWnSAFClnpObzUqeYrIg/JDF+kA7hEwVSK7KeZHb4rHCg==
X-Gm-Gg: ASbGncuY8Qi+ZOOPiMdgpvUgPSQJ8e9tNmSSMwXgo4U2oHV00VRhVVsJqO5mUTgPFBl
	SJ1ig2Pd63kIq1vqrq89s5wt3A06607xuGFH0YX9QpsguCvRYOYm38WwstVwB93bNBtnG3ORoa3
	oNVSut2/SSC2aZCIWppw+67K4Yt4wJnKuf0x1Iz4Yg4ezmd7OvnwJPNd4lZcZ776rnBS4Vfzox2
	wgAwCT7H84o9xtLrBgH7t6MAsVw6NjIUERMlIJnt0H2J5xsizP4YeSkHV5bRtpYnuBQYJf1NxEi
	4xx6yxou54QxIg2gyGZhLxz711BHttlD1Y7eaXbFaC+BQnveFMH6dUUZXwSURqXb2/ta/SGqS4J
	p2+3SS/JEQ5fW0YkWZw==
X-Google-Smtp-Source: AGHT+IEf8+Ywleh0G/SPpwmDs4ZvEp/Xu8EL/XgS2VFdvlezW3P/ExwQEdKqA0NTWy9EaJ324pAT6g==
X-Received: by 2002:a17:90b:5788:b0:32e:e150:8937 with SMTP id 98e67ed59e1d1-32ee3ebaf19mr1710891a91.6.1758100787046;
        Wed, 17 Sep 2025 02:19:47 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32ed257bbf8sm1882584a91.0.2025.09.17.02.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:19:46 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:19:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aMp9OtXLfRw7dEwA@ArchLinux>
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

We would return negative index to indicate exact match by converting the
original positive index to be "-1 - index" in
"string_list_find_insert_index", which requires callers to decode this
information. This approach has several limitations:

1. It prevents us from using the full range of size_t, which is
   necessary for large string list.
2. Using int for indices while other parts of the codebase use size_t
   creates signed comparison warnings when these values are compared.

To address these limitations, change the function to return size_t for
the index value and use a separate bool parameter to indicate whether
the index refers to an existing entry or an insertion point.

In some cases, the callers of "string_list_find_insert_index" only need
the index position and don't care whether an exact match is found.
However, "get_entry_index" currently requires a non-NULL "exact_match"
parameter, forcing these callers to declare unnecessary variables.
Let's allow callers to pass NULL for the "exact_match" parameter when
they don't need this information, reducing unnecessary variable
declarations in calling code.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 add-interactive.c |  7 ++++---
 mailmap.c         |  7 +++----
 refs.c            |  2 +-
 string-list.c     | 14 ++++++--------
 string-list.h     |  2 +-
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 3e692b47ec..7c0fd3d218 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -221,7 +221,8 @@ static void find_unique_prefixes(struct prefix_item_list *list)
 
 static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 {
-	int index = string_list_find_insert_index(&list->sorted, string, 1);
+	bool exact_match;
+	int index = string_list_find_insert_index(&list->sorted, string, &exact_match);
 	struct string_list_item *item;
 
 	if (list->items.nr != list->sorted.nr)
@@ -229,8 +230,8 @@ static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 		    " vs %"PRIuMAX")",
 		    (uintmax_t)list->items.nr, (uintmax_t)list->sorted.nr);
 
-	if (index < 0)
-		item = list->sorted.items[-1 - index].util;
+	if (exact_match)
+		item = list->sorted.items[index].util;
 	else if (index > 0 &&
 		 starts_with(list->sorted.items[index - 1].string, string))
 		return -1;
diff --git a/mailmap.c b/mailmap.c
index 56c72102d9..58a4484963 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -243,10 +243,9 @@ void clear_mailmap(struct string_list *map)
 static struct string_list_item *lookup_prefix(struct string_list *map,
 					      const char *string, size_t len)
 {
-	int i = string_list_find_insert_index(map, string, 1);
-	if (i < 0) {
-		/* exact match */
-		i = -1 - i;
+	bool exact_match;
+	int i = string_list_find_insert_index(map, string, &exact_match);
+	if (exact_match) {
 		if (!string[len])
 			return &map->items[i];
 		/*
diff --git a/refs.c b/refs.c
index 4ff55cf24f..f1ff5bf846 100644
--- a/refs.c
+++ b/refs.c
@@ -1699,7 +1699,7 @@ const char *find_descendant_ref(const char *dirname,
 	 * with dirname (remember, dirname includes the trailing
 	 * slash) and is not in skip, then we have a conflict.
 	 */
-	for (pos = string_list_find_insert_index(extras, dirname, 0);
+	for (pos = string_list_find_insert_index(extras, dirname, NULL);
 	     pos < extras->nr; pos++) {
 		const char *extra_refname = extras->items[pos].string;
 
diff --git a/string-list.c b/string-list.c
index d8da3dd414..c589ab5a2c 100644
--- a/string-list.c
+++ b/string-list.c
@@ -29,12 +29,14 @@ static size_t get_entry_index(const struct string_list *list, const char *string
 		else if (compare > 0)
 			left = middle + 1;
 		else {
-			*exact_match = true;
+			if (exact_match)
+				*exact_match = true;
 			return middle;
 		}
 	}
 
-	*exact_match = false;
+	if (exact_match)
+		*exact_match = false;
 	return right;
 }
 
@@ -90,13 +92,9 @@ bool string_list_has_string(const struct string_list *list, const char *string)
 }
 
 int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  int negative_existing_index)
+				  bool *exact_match)
 {
-	bool exact_match;
-	int index = get_entry_index(list, string, &exact_match);
-	if (exact_match)
-		index = -1 - (negative_existing_index ? index : 0);
-	return index;
+	return get_entry_index(list, string, exact_match);
 }
 
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string)
diff --git a/string-list.h b/string-list.h
index bc7f38022e..8830ce671d 100644
--- a/string-list.h
+++ b/string-list.h
@@ -174,7 +174,7 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
 /** Determine if the string_list has a given string or not. */
 bool string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  int negative_existing_index);
+				  bool *exact_match);
 
 /**
  * Insert a new element to the string_list. The returned pointer can
-- 
2.51.0

