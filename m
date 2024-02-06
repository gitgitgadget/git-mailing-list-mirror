Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADCE7E77D
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196372; cv=none; b=LRgDOTPFxTPQMPwsZhjWLlt+tJNo7NvKzBrXywuzEnZ22BanelNC+QWDgKGVTD4mt6WB5wkZufL39kvZ3x/wO9ko9Iqp2aZCh6hYGJabGW9eoHT/gPEm8ygXOfTiyJHH+YX8HYq897Qp+L9qSYx5MH4fDNUmTYKfy+j7OH69WfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196372; c=relaxed/simple;
	bh=L/PfwCBDS3iBUexjSiaprzNAGD5mnvdV6fBrBWMlh3w=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cipyZl2GtWESnI/6/+XvjhKNLCehQLElVd3bBVC+S3DLUGhm6p2uLNrRJcx+mBAyW7tCKS42LI9gMsEA999PBornSlQD4NJnJaeGAtAqF/9NyjP++dSI/r/dMI688PUZOyZGH3Agp7giiUS8DMe2pR0rggcjMgjQOW9vNap4iIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7j0no80; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7j0no80"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b466bc363so161932f8f.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196369; x=1707801169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ77xYvtQ4dxzJ/uMX/TtwFJK9uq0GF7IwJD2rw/TAk=;
        b=k7j0no80//kFkwMLOLzkV0I7F7Z/qLRLPt67I9c6tyVqnyJK7K1C2sFsz5BjTOO5s6
         pzaczIR6nwYaoL1rpomK13AFeWpSivAx7GgUGv/mRy8FElH4vICbXfJzXrgYKLXBB55r
         9pcvZqlw/Kr2mC5y+3WwP8s1JofmIU3FvIMRbbWJnLjglTN2Di4BP82+FDkUeWPYzFHR
         VOpiWpEfcBji2nzSOwIAXrR4uHZuqq9+Lgb+dAudfqvtvxNkSEJQ+2f8eH9j0vZbeb2w
         8v2NrKe4sClyhMVemQY2ah53ZaxOQHKBNY+Yq3TCvUlgDqdLKx8X8jzJs0Q8R0TcVUNN
         5Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196369; x=1707801169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJ77xYvtQ4dxzJ/uMX/TtwFJK9uq0GF7IwJD2rw/TAk=;
        b=v2VvoyYEQUX4MgfnYtUOjFkD9xmlJYSwaQgsixOypW1BpW3LOqtOcf9FgOwWQQolwl
         2DowZUgSv0DsWInmIenatn5kcy1FsoQ0aZpTgiayw3gXUaAzllEcs5Cdq6ws0qWs6niw
         uBYO1tbJZcjRWwGwPb/v33QlPE60kvJV0llqvQjM9dXPSHPWV4REZdoPsKtr734El7ZN
         giBHLpjNOAHLHJcSn/kpnyJBmlsbfoF6s7KVJ/+7ZA96lUs4B60XvrutKjKJt7pHYkNC
         3JBK5BSevl0Z5mSNTeiQyvT6UNmquOVGf9LCMlHfKprsQatJzK1egTts4CFHARbxRKZy
         eovA==
X-Gm-Message-State: AOJu0YzFfW6Y6uLUNbLvekqscuPnJ1rAPhMe9h+kytUnbKCNvMqeITr9
	ZwCaw95cXojOIo8Ozzh825KQbr2vBk5yFWwH7ZNxVh7nvb/hzEU/jmfjqQnF
X-Google-Smtp-Source: AGHT+IHOBSpETwCSsCKIpFYfn2aRkd4JMWQjVzfIMMeXYL3apsjAaMdxW/hOCLL5oU6WGehamSRyOw==
X-Received: by 2002:a5d:4051:0:b0:33b:27cf:21f4 with SMTP id w17-20020a5d4051000000b0033b27cf21f4mr280142wrp.48.1707196368865;
        Mon, 05 Feb 2024 21:12:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXT9Pn3sZ6+II5nn0Y7qWF4TT+wvVa/605YB5f1Jt4xUp8ir5HhySHDALHkRPtGwQRp+MNhQghUfD8g+bDbUYuW98lkBIZEc6TZgYNouRxVsBMETFrhRYmtIdL+EvEb7miTvzKDs0woZPIIZPuVYSOpcjWL9pA5SBLWuKme5U/vCqi/4iRvKyke9b7D+ZKOYIo/2TyBkkUMMQ==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3-20020a5d5743000000b0033b41af645asm1056533wrw.108.2024.02.05.21.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:48 -0800 (PST)
Message-ID: <607ae7a90cd9a2e69733c62ef44bb6c0893e0079.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:20 +0000
Subject: [PATCH v4 20/28] trailer: retire trailer_info_get() from API
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Make it "static" to be file-scoped to trailer.c, because no one outside
of trailer.c uses it. Remove its declaration from <trailer.h>.

We have to also reposition it to be above parse_trailers(), which
depends on it.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 92 +++++++++++++++++++++++++++----------------------------
 trailer.h |  2 --
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/trailer.c b/trailer.c
index cc211dfeeae..36e49ab7cf5 100644
--- a/trailer.c
+++ b/trailer.c
@@ -980,6 +980,52 @@ static struct trailer_info *trailer_info_new(void)
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
@@ -1045,52 +1091,6 @@ int blank_line_before_trailer_block(struct trailer_info *info)
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
index a63e97a2663..1b7422fa2b0 100644
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

