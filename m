Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04DC1C07C4
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732355; cv=none; b=fj24QUxko1tGIOFvTQ+E3u87GYl0qnFvIOviWfe7vRmaZIPHt2pFtobxR7iCZ784tOIo7Kuqp65gGhuUFiu//gW/mVG64FqKP2Hvgl3bO2CZp0v+v6C5PUM6BsMmah2U2jWSNElasKvmEmQjEFeP1gF2zHUukmErVezbbMpwNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732355; c=relaxed/simple;
	bh=ir2JfaHloFrUfrWv07NShCcPtfOEtiD06iT0ovCEe94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDKM3k3QDIV95MVHB9qDfm5KCuq0rnyVr2/1xwmFW12w5aMnSA5nriCTPBmOiCPLEQc+1ecRriQVtNnDS6tCHHJ7z5UzNsX1sghVOpSfBlIqDCPf/lkNML6HRWw3j1xvHRRceiCM0B7G80OkqBALRhrNXZRRykQGFWN2u6aQ19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAKT4NNS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAKT4NNS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33082aed31dso4999226a91.3
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 23:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759732353; x=1760337153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8ubvX1NpAQJVVmDN67QkuA9MTBdqLxZiWI6SvkIwMk=;
        b=VAKT4NNSZqkEXI0ZG8ZjJNKpIvREvZeKNdOR+ZEk0UaIq9vi9UII9AoiZMjAxMqtA6
         MdY21tg6u6k9T+17L/rGKGXW6kKP3IYXLrwMW6Jw26jdcKXsLSyBcp8vcZIcl1NNvuyq
         jrDx7HNpeC+Wyzypyd++fZltuJxuUK9Pi8SZivQFbyRbsk07+uLgCLovNhG2uWOhwl2O
         G8k9HhojieIZIFvNe2aUzaNTSNHXecObaVv0/MDBLkEtkWEJvhndySId+ul9xqenanhP
         kTNLJNJNkqLEshpL4Ktuuj8pPpWp/jr5Wrnl9cVuCGDroc2T7J6LS5AOc6emGi8mLN5s
         kL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759732353; x=1760337153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8ubvX1NpAQJVVmDN67QkuA9MTBdqLxZiWI6SvkIwMk=;
        b=qlUv/ThN3G7fN9+omHLr4dYyBSnfR/36lVpyxzkxxcCkX0m9MeUpvDYdUshxnrpSRt
         UqeE6fg0R7xlNKNnbKc06PlOhbbPHxs+yf0S6JdLpH/mibvoJFRb/qYrutKf/7bCEZ58
         Rm7jzJwyXTRUEX2Z6fFRDCpNvVGQBJm1pV4ASgwv5bDvyAhXE/NFeBb8vBj1EY+zE92Z
         reVI5yhi4gNsuEzscH59H9yT7e1EDk9R1A2Yq6SyIY8udSsqFsZDu88Mb1O1gXCu2PEL
         ztpCsFOgygYocZcJ+iAR+0Aa2Kg4kWyEBpnnUWjREBzRsdV4Go4hnnuf+mW5C0ZWHIzG
         XfdQ==
X-Gm-Message-State: AOJu0Yyy+xlacrKdwUr9CR2AuwlS9ShGRej9PRuJDTk4WhOwOG7lwwoJ
	m0Rxe/z7nPu98YMy1Qgtf8AzYdz4HaA+mS5DuejandcNa1XS7NT0iBxh5TKhpA==
X-Gm-Gg: ASbGnctKUHXy/h7zDo/g1DM+j/1pb/zhpIGPwDMKCW+9hcGHC7mQM5NQyuBsozXP+NS
	qI10RGoZpvHkaDVRxwWlo7LyU53JMwd1BedBZhyFr5m6uM76KnWUcPgsUVhRRX/SWIElQBSHjVk
	V9T6DBUEpQteoTgxKfC2kyLsbXl8KLuU/mHYNX85MH1C1NQ8jtRdrLWfPy8yXE8ELxbaiuO9obf
	UzLfIfb4SNFfMpz3INtScJ69R85OqjnNGenr7kTeJDi14kARCxFsXPvdw0j2DsUpzgnBh0dGwAY
	FbEgpOM8nU1DCcdffzpo7TZ5VG4+1nxRWmrSGqIEMnMklHp/Ve/wqUW8aE4GhvdJelY6/wh9cS2
	R2ixMmCjvgbd4laxBXaJIz9CwWooIlPgl2ts7g9yvGPYoD9lUXPnV
X-Google-Smtp-Source: AGHT+IG19vlvBYBBXP1RhMd49OmlLgyAj0gIeg1sSZn0qOmDkAGef7BCo3api8FyAvxuIyg0fIinmA==
X-Received: by 2002:a17:90b:1c0d:b0:32e:23e8:2869 with SMTP id 98e67ed59e1d1-339c27a18cdmr13987909a91.30.1759732352553;
        Sun, 05 Oct 2025 23:32:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b62e121e0afsm7876828a12.25.2025.10.05.23.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 23:32:31 -0700 (PDT)
Date: Mon, 6 Oct 2025 14:32:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aONif51bVNGWEnHI@ArchLinux>
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

The "string_list_find_insert_index()" function is used to determine
the correct insertion index for a new string within the string list.
The function also doubles up to convey if the string is already
existing in the list, this is done by returning a negative index
"-1 -index". Users are expected to decode this information. This
approach has several limitations:

1. It requires the callers to look into the detail of the function to
   understand how to decode the negative index encoding.
2. Using int for indices can cause overflow issues when dealing with
   large string lists.

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
index 6ffe64c38d..21bc3dca96 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -244,7 +244,8 @@ static void find_unique_prefixes(struct prefix_item_list *list)
 
 static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 {
-	int index = string_list_find_insert_index(&list->sorted, string, 1);
+	bool exact_match;
+	int index = string_list_find_insert_index(&list->sorted, string, &exact_match);
 	struct string_list_item *item;
 
 	if (list->items.nr != list->sorted.nr)
@@ -252,8 +253,8 @@ static ssize_t find_unique(const char *string, struct prefix_item_list *list)
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
index 750e5db077..74266e6392 100644
--- a/refs.c
+++ b/refs.c
@@ -1721,7 +1721,7 @@ const char *find_descendant_ref(const char *dirname,
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

