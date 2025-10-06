Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B41C07C4
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732347; cv=none; b=tiet1ZaaHt395DxQG2lk3AmGoKGk2hmGgeNe1IT+ZJ+7Yu4xrg2gWFKY6difTE8GhGeXy31niEf+Y2uDvZUA8ZE5cIxLwevsA/4ywLePyKl/Rd64A1dxpfezfAL4PSkjaD0l/er8AYlxs4vVIBacR7zk9nvhDcXTrUJQ7eTq5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732347; c=relaxed/simple;
	bh=0tLlsZ+1WB6al7V20AvAiTzdE5MDOAiI5yYpl6jCZHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkTp1Y5G+nNdAmBm6DlWUGtk5goIrHKMGH02gLe/ShCVHE3iiVP3t1e9J2bdOgzE6NQ71ZMvLkNeZg17GM7u/QC+mfeI7iVtnDpmCxYmVLLcDDqQVpuerg9LHG6Z7yv4MmVzp3p6COt+0PyWadxULetlZeLi3dwAvev1VprrJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHXa19PB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHXa19PB"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b54a74f9150so3831940a12.0
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 23:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759732344; x=1760337144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d42ZU0Qt6mKdlNuXvDITuNWkm5PL7fsRM+Dp4KHw/S4=;
        b=lHXa19PBf4JIo5Zb7h0zG1E76wuVWd52+6OFrJ/RwO2eKeyB/TD8ubFIkS2imk4aR4
         HMdvmSuo4y8WMvVVGAzIlJnB3bQNhzgasIFvrBeJZUEY2yLeveuXK3aP9BAJL0Vx1RW2
         Wz60pHyl3kI6qwraNgyM6v9KdEu3ZTLzxrb1lYbQ4fnPHw1oArbKd+D9bC/StO+o5iYZ
         fGDurGjYZ2ColvY0hWLslFTLXjK6H9K0wuyeE0T05HsAr5d5EdWldmvLdgicFKrhkyFy
         G4RIySFu+8nMAgneJQSwHnkTiFlXDJfRFm44R8g0ppKVJCQq2b7MEYkYZkWvmmNdc2LN
         SnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759732344; x=1760337144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d42ZU0Qt6mKdlNuXvDITuNWkm5PL7fsRM+Dp4KHw/S4=;
        b=YLeqsZ49aiU3ohMvZDl+I/JbqO6BcpWQaFzJE7taVgbV5IltHNJySLANI3Q2ASvVln
         0p+xCexmRHo63HF2j6ZIt2BT7SC0nXk5mbzmbo6flP8SKrbYy6KPxtQug+DIzBWrWchy
         oiz3BqITrrQ9tq8E09/yh0LA3A5I/F45wq1ALHf12N8mjSXtauyMS99KF8kCLY4PUq8O
         aOz+HhISzK6X6zuZOhgjVYnaqpnsPW6OtiMe22jd85o3HRi1x0PQCyXXV15cGehYHxU8
         2UA76T2Bu8kYBZVWpG6gVKUE4h+PZHr/Jg9zRpt8uDy2Hvdlil85vf6CNe8/Uv0chEHR
         4Z/A==
X-Gm-Message-State: AOJu0YxnHPIDQk1tiKzxM9ape0o6CWLml+KDtRIhGopYn13JHrHgc9mp
	zjC+4R872o6uuqf1pOAIX7oSDzLhRITsXt+6xxvreBqzTJgTv2j21ZDdudHBiQ==
X-Gm-Gg: ASbGncsdjDbXhDD68V0DBY0kNoqgjEcJfZg2L9NNwEn8X05m3qKP6xF4HsY+s2jaKfL
	y99juKJBr4JpArktjuV3bKLivruj8fTJQ7V27aJbe+sZ5j2pR+z/QCaighsB6alM5rAd4dJp3RY
	4sf9YoUtEgkFpbWXru1mgzrPuHhuahr07Kyn+fFceQdC/vYUxn8ZgHbgSc0nTVs+bH+U7Pm6EHF
	SPELthVXJ1tUHHuInKkyyC10Tv7gCoBantNMyQOoPN7WK08rFiMxBZtULCNzAvgi75TLbktw3TC
	ei4Vk/v/GtUWwWTXeWsIehFvr/NlC0QoTMJkdDaRAd/4eTe9makl/SVu3Qwr0EGK5VTWSFBm9Qp
	2/gQErfj1PNmRAQPcGW/EG+/mdvF19/YEAlFDsOjXCZtC/1vCyA7l
X-Google-Smtp-Source: AGHT+IHM5OFm5NKN1X6MoVoKP5XTiyanva4mm6BzKMTqDwxgaPm+20kCUjwNEIW+jfMpmXtnaP/4Bw==
X-Received: by 2002:a17:903:1a0d:b0:27e:eb98:9a13 with SMTP id d9443c01a7336-28e9a596db3mr120781275ad.22.1759732344336;
        Sun, 05 Oct 2025 23:32:24 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1280a1sm121537665ad.51.2025.10.05.23.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 23:32:23 -0700 (PDT)
Date: Mon, 6 Oct 2025 14:32:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 1/4] string-list: use bool instead of int for "exact_match"
Message-ID: <aONid6ZhaRFx2mgP@ArchLinux>
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

