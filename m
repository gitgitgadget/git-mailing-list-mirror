Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54726262A6
	for <git@vger.kernel.org>; Sun, 18 May 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747583825; cv=none; b=FjE2iJ8axSavLd9iClh4KmKERXZ4+YCKkzcXiwQjKzeujfVxw4SbtDfWpqlOMvtL6RqhG2kwvPeQRdjQOI33Wn4Fmj6cRigNEM7mhw3gcFL7RJdSSgJyRyn53FvE7njHgoKcywp8jkrokR2jpjxckyeZhVHnvMF9FilQtzOc0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747583825; c=relaxed/simple;
	bh=sFky+Fj+XIM6S8jdJkJGBLS+rNoEx/yTfA9eb5cds5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZLdWC2Q8g3EVsuwAP1ryYCzo91ybjxGGfiHdVDm6egRKRl4inMJ+5PV0d8FY77Ubfezqranc0UOP+bX0c+R8fr1+pF/U3c7dzmBPEqz8h6obdEXKY+1dZaChqkUwdkPMZVblnyBlut2VjdhHlnvk6MQSC9FGoO5vtQ+aSRUXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIXlcUd4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIXlcUd4"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c7a52e97so327472b3a.3
        for <git@vger.kernel.org>; Sun, 18 May 2025 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747583823; x=1748188623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OifgTVFTIvLuybp7gYTAB0GOsvujw7dTXUa4y7hjeuo=;
        b=aIXlcUd4z8AWFRWy9moRq9S3z6usa34VAdZR9ApDxsTWWzY/4ddYgE8+QFdTKJ748I
         Xe3P49qhN+/EKJek7x+E+jZo3HXPm7XN/iQNpm2CJuNpBl5RqNt2spI9Vnk8EiTj9/Cs
         77qOoh+ugfLaQDZeO/oic3Gjxt3isQsLDwrEjC2reL+ixGX+n44glwvJA08sKQMJ2fqC
         tAb+Dc6+gvOIUjyuCaSI4hULcTHom+JHsLtLT9YX27O5m6XAXOkV66jKgak0VxsWRg6Y
         U1UkFe9eWLulvN53ipCsEpPg8Oq2Gm9Z8SdGwMmBDJVHbatsLuAXBz+5OyJw6P8qJRW1
         lCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747583823; x=1748188623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OifgTVFTIvLuybp7gYTAB0GOsvujw7dTXUa4y7hjeuo=;
        b=hFVBMlF/dVn61iOVI8mqDwYhtY2+b/uTrY3BW6RaWU2dyGT6w/KujtrrzEAm/ArEs1
         2tbaF89wzmodZgoJUkrQ/Fub3bu28x9GBNE1gW9HNnkw8TXXnSJZ4haswABLo8+O43qP
         fzglr7wT+LFXXlyF2Uq2Km/7rLpWGg8F/Pv8txD+GgGTeOq0vvwDpVgnIooXV5HUmCw/
         d1X9mlQjFdlhqhVFoyFoCBjwuXHprOZTqhJaDxYcmPlJcWQJyaXsj9cZxwxjUcEtqNIW
         wVP1OnZ+KPjAayjhW6+YlVKNOXK9bjsdiv2rpIACmMxRp77C+Dxktb88IYHhqqwHbfbk
         ZrIw==
X-Gm-Message-State: AOJu0YwMlYXL6rr5bcWIiAXzerat1GUo/KFKdps1Na/bL2sYkmlqkJJF
	FbcuhTR161EubHdiYduZ76w+KgjVWEpwrLxgtpp3hYfHgdHGNmjhYf/nZrB5OHy8It4=
X-Gm-Gg: ASbGncvVbVTDx2Lx+xlQ680xW8c33SprYTQ1HtU3ff0I090Gauc4j5ATXxszogW1QIs
	64Z6piOUfBZLuq35duZdTivjaHgn/DLOpYaXRtSwAVGGPPNbDg4bh1+UAxGtJWyw07Zp1720H49
	EFWDqTbvSmaQvJfA+HP/dXJZVLNW2wmQhhyrXZLX57ODffCUu45d8ug+Blrv+8cVUUDo98TwKpn
	uh/Uzl6JaJzPQ9aHHR0Ov8uerRpbS5Z0bwg0YrUBx0oK52jABhYaq+hhqG2mjXyyvYztuRZWMBV
	Y11IP3hMqEMvFUr54Os5+l5KWOmkSDK85odXFVxgueriZU+DUfVyYl9+fA==
X-Google-Smtp-Source: AGHT+IHpd3mfCtVn6SY5GjLjaWTRSq+paw3wkzUoyh195aYrTskdPIm5ApFHBV21c6rD1nMadXC1Eg==
X-Received: by 2002:a05:6a00:2d0a:b0:740:6f69:8d94 with SMTP id d2e1a72fcca58-742acba67c1mr12304826b3a.0.1747583822944;
        Sun, 18 May 2025 08:57:02 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a96defa1sm4815021b3a.12.2025.05.18.08.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 08:57:02 -0700 (PDT)
Date: Sun, 18 May 2025 23:56:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/8] string-list: fix sign compare warnings for loop
 iterator
Message-ID: <aCoDSyycHNvFCT93@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDB9P5XV1lHMil@ArchLinux>

In "string-list.c", there are six warnings which are emitted by
"Wsign-compare". And five warnings are caused by the loop iterator type
mismatch. Let's fix these five warnings by changing the `int` type to
`size_t` type of the loop iterator.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 string-list.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/string-list.c b/string-list.c
index bf061fec56..801ece0cba 100644
--- a/string-list.c
+++ b/string-list.c
@@ -116,9 +116,9 @@ struct string_list_item *string_list_lookup(struct string_list *list, const char
 void string_list_remove_duplicates(struct string_list *list, int free_util)
 {
 	if (list->nr > 1) {
-		int src, dst;
+		size_t dst = 1;
 		compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
-		for (src = dst = 1; src < list->nr; src++) {
+		for (size_t src = 1; src < list->nr; src++) {
 			if (!cmp(list->items[dst - 1].string, list->items[src].string)) {
 				if (list->strdup_strings)
 					free(list->items[src].string);
@@ -134,8 +134,8 @@ void string_list_remove_duplicates(struct string_list *list, int free_util)
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t fn, void *cb_data)
 {
-	int i, ret = 0;
-	for (i = 0; i < list->nr; i++)
+	int ret = 0;
+	for (size_t i = 0; i < list->nr; i++)
 		if ((ret = fn(&list->items[i], cb_data)))
 			break;
 	return ret;
@@ -144,8 +144,8 @@ int for_each_string_list(struct string_list *list,
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data)
 {
-	int src, dst = 0;
-	for (src = 0; src < list->nr; src++) {
+	size_t dst = 0;
+	for (size_t src = 0; src < list->nr; src++) {
 		if (want(&list->items[src], cb_data)) {
 			list->items[dst++] = list->items[src];
 		} else {
@@ -171,13 +171,12 @@ void string_list_remove_empty_items(struct string_list *list, int free_util)
 void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
-		int i;
 		if (list->strdup_strings) {
-			for (i = 0; i < list->nr; i++)
+			for (size_t i = 0; i < list->nr; i++)
 				free(list->items[i].string);
 		}
 		if (free_util) {
-			for (i = 0; i < list->nr; i++)
+			for (size_t i = 0; i < list->nr; i++)
 				free(list->items[i].util);
 		}
 		free(list->items);
@@ -189,13 +188,12 @@ void string_list_clear(struct string_list *list, int free_util)
 void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc)
 {
 	if (list->items) {
-		int i;
 		if (clearfunc) {
-			for (i = 0; i < list->nr; i++)
+			for (size_t i = 0; i < list->nr; i++)
 				clearfunc(list->items[i].util, list->items[i].string);
 		}
 		if (list->strdup_strings) {
-			for (i = 0; i < list->nr; i++)
+			for (size_t i = 0; i < list->nr; i++)
 				free(list->items[i].string);
 		}
 		free(list->items);
-- 
2.49.0

