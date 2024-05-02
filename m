Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135DE208B8
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625683; cv=none; b=Q9/ddnOXUItlcV8LcJleQTMKsZqeD7vpxg88Ua3jeUW4Hnxqs0uaFdPdWi6qOM5f1RbiPbSj4wgzAW9MeI/weZhJcFf7XlYGoiVY8/5ESpO+Z+8krTdtKeO5dbuJcw18C4Nj2mDKozVgiR3Ckv7PAxHnjnGoWrOvjEWVrDXdBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625683; c=relaxed/simple;
	bh=QqjBcXEgpyPQ71DrqyWwmGYHoR76c+5PLG9LmQyvn2w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l8OBwTiqTUm/9GGGCjLJPTWXBjIPzIM35X2SESecrf5pRU4Lb/mKJqANoawvx10Zs3azLPkfs8tU//UeW2RD67Fv9aE2RoHHQSeqIKSTHpVpSXUNXRfiSBE/TtURhFypLaTdpOSnwfJGSpnCRxpBJ660M9K/at+h1n7DPQ1YyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8dJYa0i; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8dJYa0i"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e1fa824504so501791fa.0
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625679; x=1715230479; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtlMUDRS1Qk/riYvm9ztz9w3nrPRqIvEExLXVjjshmg=;
        b=a8dJYa0iU10wXW7nu4XLWqdLEZ/8/4tWNgupaGiftOhc0h+DiDG5WX0XZVRqvaaJtw
         WrpHGVOga5sYLprebEWBhyK5vQRMQnnBcLcUVIndyHqBvfGOPm3UV69E4oPHdKWEFSth
         Bv8OEFPtOeK6cUIk5eUyCONK45NZ716x/TfUmqdxY0C6srLDEMavkgQQHGbsoNnJ6vAM
         1iMbAp/Xna9P5nyPjSfkh8c6noUnSV5yqN+1o7RTt3HsNAP1WX+PLGrug2NvhoOJnudg
         yEDqqa2u/gH+HS2IAywE7WXfrrsX3o2uV3YPm9yAOse+EOHQeV7Eu0T7yZhcusZklHU2
         SPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625679; x=1715230479;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtlMUDRS1Qk/riYvm9ztz9w3nrPRqIvEExLXVjjshmg=;
        b=sv95QUS1oWqLA2sASAH5CLHHsqBHaohcifuv3T7mM9aL0I+sGUCZR6fIjfI8xMZPI7
         tARhs6qZNoR2Svi8qktQtoGzgqSOLSo7YD2QNEjo3+y4DjrltmunrePD9NLE59QDxQSM
         P7CYJKvDwj6vA9zX7YF8f2UCS3dB1LAmn+dJzIoYxbHUIKJwjZlfB5UzwwKJa+KjtJDU
         Xj2wQNAET1M6BAAeriu0XnYzYRv/e7XhGC9kLWqD0v+6vUBgEXCzuvGpgR06ieKUPR4r
         eZtWQUdRwcQ2IalbzTzYqFUO4Mcp1tlar5FHAXhW7sn99ZGNoM3mJWvtjHunDO+qs7A7
         4syg==
X-Gm-Message-State: AOJu0YygRibGxf+QmbZEx38XpRbAKB81h0Ru80xE0/Km4zk00x7Go73h
	ZTE58StiLGcGKIKwFoUJw2JWohmXWLzpDo6smz0kAc1JtNhwLcozbQKsfQ==
X-Google-Smtp-Source: AGHT+IFK1SCeQQxIZ1etzxvQICWbacdY5PRrFjFC2k9pNysxWiYEnE9LCjToaKkx7Qvu5xEKJxFsbg==
X-Received: by 2002:a05:651c:1213:b0:2da:c3a:2546 with SMTP id i19-20020a05651c121300b002da0c3a2546mr2804431lja.21.1714625679316;
        Wed, 01 May 2024 21:54:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c501400b0041aa79f27a0sm498520wmr.38.2024.05.01.21.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:38 -0700 (PDT)
Message-Id: <ca6f0c4208c50bfb35af044e0a8962395eea9375.1714625668.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:25 +0000
Subject: [PATCH v4 08/10] trailer: retire trailer_info_get() from API
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linus@ucla.edu>

From: Linus Arver <linus@ucla.edu>

Make trailer_info_get() "static" to be file-scoped to trailer.c, because
no one outside of trailer.c uses it. Remove its declaration from
<trailer.h>.

We have to also reposition it to be above parse_trailers(), which
depends on it.

Signed-off-by: Linus Arver <linus@ucla.edu>
---
 trailer.c | 92 +++++++++++++++++++++++++++----------------------------
 trailer.h |  2 --
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/trailer.c b/trailer.c
index 6167b707ae0..33b6aa7e8bd 100644
--- a/trailer.c
+++ b/trailer.c
@@ -979,6 +979,52 @@ static struct trailer_info *trailer_info_new(void)
 	return info;
 }
 
+static struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
+					     const char *str)
+{
+	struct trailer_info *info = trailer_info_new();
+	size_t end_of_log_message = 0, trailer_block_start = 0;
+	struct strbuf **trailer_lines, **ptr;
+	char **trailer_strings = NULL;
+	size_t nr = 0, alloc = 0;
+	char **last = NULL;
+
+	trailer_config_init();
+
+	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
+	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
+
+	trailer_lines = strbuf_split_buf(str + trailer_block_start,
+					 end_of_log_message - trailer_block_start,
+					 '\n',
+					 0);
+	for (ptr = trailer_lines; *ptr; ptr++) {
+		if (last && isspace((*ptr)->buf[0])) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
+			strbuf_addbuf(&sb, *ptr);
+			*last = strbuf_detach(&sb, NULL);
+			continue;
+		}
+		ALLOC_GROW(trailer_strings, nr + 1, alloc);
+		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
+		last = find_separator(trailer_strings[nr], separators) >= 1
+			? &trailer_strings[nr]
+			: NULL;
+		nr++;
+	}
+	strbuf_list_free(trailer_lines);
+
+	info->blank_line_before_trailer = ends_with_blank_line(str,
+							       trailer_block_start);
+	info->trailer_block_start = trailer_block_start;
+	info->trailer_block_end = end_of_log_message;
+	info->trailers = trailer_strings;
+	info->trailer_nr = nr;
+
+	return info;
+}
+
 /*
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
@@ -1044,52 +1090,6 @@ int blank_line_before_trailer_block(struct trailer_info *info)
 	return info->blank_line_before_trailer;
 }
 
-struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
-				      const char *str)
-{
-	struct trailer_info *info = trailer_info_new();
-	size_t end_of_log_message = 0, trailer_block_start = 0;
-	struct strbuf **trailer_lines, **ptr;
-	char **trailer_strings = NULL;
-	size_t nr = 0, alloc = 0;
-	char **last = NULL;
-
-	trailer_config_init();
-
-	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
-	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
-
-	trailer_lines = strbuf_split_buf(str + trailer_block_start,
-					 end_of_log_message - trailer_block_start,
-					 '\n',
-					 0);
-	for (ptr = trailer_lines; *ptr; ptr++) {
-		if (last && isspace((*ptr)->buf[0])) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
-			strbuf_addbuf(&sb, *ptr);
-			*last = strbuf_detach(&sb, NULL);
-			continue;
-		}
-		ALLOC_GROW(trailer_strings, nr + 1, alloc);
-		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
-		last = find_separator(trailer_strings[nr], separators) >= 1
-			? &trailer_strings[nr]
-			: NULL;
-		nr++;
-	}
-	strbuf_list_free(trailer_lines);
-
-	info->blank_line_before_trailer = ends_with_blank_line(str,
-							       trailer_block_start);
-	info->trailer_block_start = trailer_block_start;
-	info->trailer_block_end = end_of_log_message;
-	info->trailers = trailer_strings;
-	info->trailer_nr = nr;
-
-	return info;
-}
-
 void trailer_info_release(struct trailer_info *info)
 {
 	size_t i;
diff --git a/trailer.h b/trailer.h
index 4e0a6789d7f..b0ec7658c67 100644
--- a/trailer.h
+++ b/trailer.h
@@ -73,8 +73,6 @@ void process_trailers_lists(struct list_head *head,
 struct trailer_info *parse_trailers(const struct process_trailer_options *,
 				    const char *str,
 				    struct list_head *head);
-struct trailer_info *trailer_info_get(const struct process_trailer_options *,
-				      const char *str);
 
 size_t trailer_block_start(struct trailer_info *);
 size_t trailer_block_end(struct trailer_info *);
-- 
gitgitgadget

