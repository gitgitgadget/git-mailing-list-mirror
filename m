Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759510A0D
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710570441; cv=none; b=TmWiVJjxPq3/03MbrbRpQJGRmizl9LEPmFP2yBvjvnW6IAPVoLeCulMU6byGSj1eyUlZSCmbzn4noDV6aBn+ZVKqKO2dAoQ2QtMQkfUpBt358fkvzACxM1G3YMANO7M42GqsQfMgQJS1Stx6G4LLOgDzns+ZhlszQYv4tlO28ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710570441; c=relaxed/simple;
	bh=yX6rb+UiEB1astWPY1iRzrTuD7QPl8KVlv1oC88H+4s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=h8yL+xbt5CcXffdctXm+g5nwggmmMCiO4fnH84eJ13AIdQXYD54oHsCRB4in6tD13aOqcHPNg3h/qAFhHc5T93j9krT0Hw90QvG1rgpcO5V+WqzUF0a5+N0eh3g66s09+pb2HvBgMuTQZEQqeeRhMYI1pBu9NuaKRsIwwJOanGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnGu0q6+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnGu0q6+"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ec8f13c62so1755527f8f.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710570436; x=1711175236; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yELVRQ8ZDtDc4lZA2exN72FHqFJ0qjVHYEiiVMabbG4=;
        b=TnGu0q6+SbBh0vs6v1a/HO4R/J9yL//Pfe88WnkDzi83jzwUp9+iuGOxuGfDeEiyAK
         agBmMpqmqMr87/BQsgBCID5+8+KTatO1yMbv9CcsHwUwc79JSbeuGMWTuGVmWVIZtaAW
         +nXH9OZYACnZTo5f1wEekUortEPTd/2+1Kk6STwAerpZQGg1baed10Xj5Ve+6tmlmM68
         pWvTWIVb2HAbCYEM3jYch9Iyxj8fplxVUTboT6GO59txnFDEwObxpF9Oq7Eah4xVsySv
         IWQux7MG5GH5nA9u2HTte7P+1Sns0MI3qZsm+v4NvhXTnMsoBm/CU0oUwELZ8qnL0Q/Z
         OCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710570436; x=1711175236;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yELVRQ8ZDtDc4lZA2exN72FHqFJ0qjVHYEiiVMabbG4=;
        b=t38dR5X10KXEKAiXi2CKjbLk+4RnAToj3HCeBv7SYH06x2zAZwJ/QQv4VBfmp/AOTa
         //py6bEndvtGYp7eapz7CQqqlsmcrx/YNZVC7zPew2m9lyfXQHmgFyP9co9K03NDVDCx
         +rAp0XDbKQRietzGZJ52tk0uofPmfWVQlQRJ9JqCVdsVqv9+PCX74Y2RimCTxAq+AN9E
         ET4xkVlv/tD+APrrWHpYiOWAMfE1vnDMGb/7MRha8o8bEFxB5FPBrnVW6WbAlu1H2Jfc
         XcPyQc6ldetfpvb9QMj2ZOxjLfpAcNolBJCPNfjBTojt0vaihz4rDmtKbV/du+CFM7A1
         JDdQ==
X-Gm-Message-State: AOJu0YwllHY7J3wJ0bCjTIBo7k3lp9a4BySeYz2FhZ/82j8fX2q0bV3i
	MTg+2X8E2+Re+vRf/qbpne8EAVpCvlLk88bG4ZLN5mM9gvVs6tMkZja4c6QC
X-Google-Smtp-Source: AGHT+IFvIcs+2MevlA91A13W7X5VH+KQYPCszhZcfjdvn9hwVMg829xhyxPnFZJsHOxgFNghVTDzDA==
X-Received: by 2002:a05:6000:bc7:b0:33e:c6a1:1a39 with SMTP id dm7-20020a0560000bc700b0033ec6a11a39mr3673642wrb.65.1710570436597;
        Fri, 15 Mar 2024 23:27:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d6b88000000b0033ec8739918sm4688904wrx.41.2024.03.15.23.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 23:27:16 -0700 (PDT)
Message-ID: <19de7c64171668503b3676bee9fa9e8660671b17.1710570428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 06:27:08 +0000
Subject: [PATCH 6/6] trailer: retire trailer_info_get() from API
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Make trailer_info_get() "static" to be file-scoped to trailer.c, because
no one outside of trailer.c uses it. Remove its declaration from
<trailer.h>.

We have to also reposition it to be above parse_trailers(), which
depends on it.

Signed-off-by: Linus Arver <linusa@google.com>
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
