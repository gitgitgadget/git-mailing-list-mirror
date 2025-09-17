Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50469248F40
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100781; cv=none; b=AYHMKXXVm1qAsEh4kuHSk7TtS+3QOd0cLnAt7Wn9IEnxUm4MCBow+O47bbrHljH681EbyiK0qQcU029qitXxmDpQs8Q6tkaqg4SHKxz0UUmKEcjhsU6cexEelQbchPlNMYCJHSQ7CrzYJaF2fq9r5s6KUPOaKw2s/8yv56kiDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100781; c=relaxed/simple;
	bh=0tLlsZ+1WB6al7V20AvAiTzdE5MDOAiI5yYpl6jCZHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urc8Aj1pqV0BWR27M3j4WiFiBcwQWrRu6cEGG2zxdHVAD9Rq6Q6fqfanBRAibY1eWRom0yHKOeRFlbOsWnoQb8dO5WAG4gzFaVgDp/wO0mJMksCR6VfsMwsDJ7iYMpeyeE5c08PNxIJQpn2eCRAmsohJf4y5KkIWeRdTUotDRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV6SZcy8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV6SZcy8"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b54f48ed1a5so241903a12.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758100779; x=1758705579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d42ZU0Qt6mKdlNuXvDITuNWkm5PL7fsRM+Dp4KHw/S4=;
        b=bV6SZcy8W6u3h6Z94t2g0lRS4rNRrXhoyC4sb+v2fm5UTIHGgRh4MavLrXCmyt+SBN
         LXyIsB4gkXD6Fiijg0gV0QwoZhbWr31peBM1CeIrK74zd1bKAa7CvUJX1ATXpwwbt53/
         eKFC6weSprKVAK80jlMxz3j0PQ1BQH0CzuONpJ/DQAH7rWjTNAJlbVKiF4ElNwktqfWw
         9QYPVSW9u21Mb5aUdcFvSJF2thck7vai9HnBJyKB7cAv+rVT56q4xL8iHW55nWbFJM2s
         yO1V9VM2DKrQLdO6EzKy1kfFifP3zPQB9k0+2yKc1Xe9rstkEufos2UkWbhYvfRwcm1M
         LahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100779; x=1758705579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d42ZU0Qt6mKdlNuXvDITuNWkm5PL7fsRM+Dp4KHw/S4=;
        b=n5IEaZuDPO+pIWHI5wltUKqsA8h2AttamBfrlo/nRGl+K4frDhyqByLsmu4wDJt/oZ
         3muPOHjjVJ+6zYt4nhuAGvTA0YbNB2bgSoN61MoWgGR9zPEGTfGs49ism4TtXA/8L/wE
         dvpscq/Ssqy7iXno3RvVCqs9sI/kcrFzJ09VgmVstK5NGea4C4IAUoDKu/snfa+hnZB5
         1oxLjFNpjLsBVjLdpJygM24/gO01hypjNajIqUSvndoDCBt7MNej5LFzrl9TNlC6I52r
         QOTv+ZROKf+Q+iXsYmD/H42bzNGNgFnKaAay7vzDngWHdblqzpXV6IUVG9ClC/yVhSAn
         xqnw==
X-Gm-Message-State: AOJu0YyYApVZhNTW5gabtO93x1wh6vOm3gGhd9XuGeEtgRDfiKSKdlRC
	7yqMaRJoo2S3qjMPlkpEJo8yjNkE1eoTpkxKcjeqNbMQ72Eilu2nL3lo3/1QcQ==
X-Gm-Gg: ASbGnctJ3KVp/Fff/tyh4ntHuRc6xG1GAZfRx91zOMYvcWUKJ88R8F4UvWG5qwMr7gV
	qt4zt5prjbnANu8ROGB0GPUq+ilguaNEGjbizXwZN8zB4pbvM3Fr8YRv/fdc11LmtLClMrt1Byf
	9rHUeumVaghlchZfcWBf6v9RA+m8+0Pehi/2uEMrQRwd/6EQVESZ8EFOVmVNBsAdClGZ5yjog3Q
	m6Cithfyz6/68rQW1Vy544FNSOoJz1ktondM7bLKsuW7zcgdKXHsAChDgH2gykdOJ0EfPLaDEbC
	jQkHwLCfqe9OAi/JqmUt1enJfmFurIvzl39r8Lm0yxTViTKIULmVWbJ9c86MH0k5cAAcG+stFoN
	cNP5MqfS97Bz1mxggbQ==
X-Google-Smtp-Source: AGHT+IH3P4D9Zbo/qAnxiDnKHNGL8cQw4L/577iyRsKk62U9Us54aGawUkHGoKmqESzS/VvVW5SzAA==
X-Received: by 2002:a17:903:1c3:b0:268:b8a:5a26 with SMTP id d9443c01a7336-26813cf3934mr22676785ad.54.1758100779085;
        Wed, 17 Sep 2025 02:19:39 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-267c5e5dfb6sm46828545ad.125.2025.09.17.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:19:38 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:19:46 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/4] string-list: use bool instead of int for "exact_match"
Message-ID: <aMp9Mmnt05Ns66R_@ArchLinux>
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

The "exact_match" parameter in "get_entry_index" is used to indicate
whether a string is found or not, which is fundamentally a true/false
value. As we allow the use of bool, let's use bool instead of int to
make the function more semantically clear.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 string-list.c | 19 ++++++++++---------
 string-list.h |  2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/string-list.c b/string-list.c
index 343cf1ca90..d8da3dd414 100644
--- a/string-list.c
+++ b/string-list.c
@@ -16,7 +16,7 @@ void string_list_init_dup(struct string_list *list)
 /* if there is no exact match, point to the index where the entry could be
  * inserted */
 static size_t get_entry_index(const struct string_list *list, const char *string,
-			      int *exact_match)
+			      bool *exact_match)
 {
 	size_t left = 0, right = list->nr;
 	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
@@ -29,18 +29,18 @@ static size_t get_entry_index(const struct string_list *list, const char *string
 		else if (compare > 0)
 			left = middle + 1;
 		else {
-			*exact_match = 1;
+			*exact_match = true;
 			return middle;
 		}
 	}
 
-	*exact_match = 0;
+	*exact_match = false;
 	return right;
 }
 
 static size_t add_entry(struct string_list *list, const char *string)
 {
-	int exact_match = 0;
+	bool exact_match;
 	size_t index = get_entry_index(list, string, &exact_match);
 
 	if (exact_match)
@@ -68,7 +68,7 @@ struct string_list_item *string_list_insert(struct string_list *list, const char
 void string_list_remove(struct string_list *list, const char *string,
 			int free_util)
 {
-	int exact_match;
+	bool exact_match;
 	int i = get_entry_index(list, string, &exact_match);
 
 	if (exact_match) {
@@ -82,9 +82,9 @@ void string_list_remove(struct string_list *list, const char *string,
 	}
 }
 
-int string_list_has_string(const struct string_list *list, const char *string)
+bool string_list_has_string(const struct string_list *list, const char *string)
 {
-	int exact_match;
+	bool exact_match;
 	get_entry_index(list, string, &exact_match);
 	return exact_match;
 }
@@ -92,7 +92,7 @@ int string_list_has_string(const struct string_list *list, const char *string)
 int string_list_find_insert_index(const struct string_list *list, const char *string,
 				  int negative_existing_index)
 {
-	int exact_match;
+	bool exact_match;
 	int index = get_entry_index(list, string, &exact_match);
 	if (exact_match)
 		index = -1 - (negative_existing_index ? index : 0);
@@ -101,7 +101,8 @@ int string_list_find_insert_index(const struct string_list *list, const char *st
 
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string)
 {
-	int exact_match, i = get_entry_index(list, string, &exact_match);
+	bool exact_match;
+	size_t i = get_entry_index(list, string, &exact_match);
 	if (!exact_match)
 		return NULL;
 	return list->items + i;
diff --git a/string-list.h b/string-list.h
index 2b438c7733..bc7f38022e 100644
--- a/string-list.h
+++ b/string-list.h
@@ -172,7 +172,7 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
 /* Use these functions only on sorted lists: */
 
 /** Determine if the string_list has a given string or not. */
-int string_list_has_string(const struct string_list *list, const char *string);
+bool string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
 				  int negative_existing_index);
 
-- 
2.51.0

