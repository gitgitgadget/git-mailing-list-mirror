Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4612E75
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625679; cv=none; b=Yl7g/Rx4gWgy+tijIeVmw79v+kSjkiZl0CBwsNQtxmxzWvqyUAOYZMty818JoBJlVVZaG+MFwWV0TK1HrqdmRMFJGBFJ3pHCnTJQQaes/zhoDWWJbPKF9nVdgkxAvFTcbCNMvuQg2XqDg0i0yas8WGp5lBP8FFgO+njx092zQ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625679; c=relaxed/simple;
	bh=1gS6Qf9nAbSzGm6Baz/stRHb7AwJhNW2IjtWOYmElqI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YPJxtTb2ws8dDXHd4U96nCOons6nXZbO9PMQCJip7EzasnvUvLjSWWwmLb455q2GZYvxONxhAHdmDDdXwS72GJ9G6Grgu3/jrS1Whd/H2VPBzoK6GiowapPSHhN6R2xEFrmNYZGH3C9iLQaPAC74AYxC8YIEz4mkktmAa8SA0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfDZnjH2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfDZnjH2"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so39386855e9.3
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625675; x=1715230475; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmgpG1H0BarOmPn+1t/bIn9KW+Z0AyYuKOS83PwezFk=;
        b=VfDZnjH2+54TXU1xjEn0fU7yNvJcu9TDhPEJTarJqFfJ/H4qTcVERHFIeoN9U0qcTe
         8viQR+y/5J2bKvlcyF5J7GPQ8p0KBv1zY9YnQBbKGce6+aREbFEVfEUCMU2zcY2BGFpt
         1pI+UdAYeaEYUhhFfSBK8z17Bm/QFTOsDgkDyf0g6FL4C/s5NPgM6sK5LO9mBTiA2W++
         Q1R/hNH2G2G3sT4qbCuELKDpDo+GbZRhFmDQPPmI+BYNuPJy28XgQtpI1DCshFv+ZXpl
         mdMQBY6DpWYUHCecN+TMVgeTll8cNbpDWKNyHwQoiV6KlH5jvLRTwrpfIxvuFk0y1ZWW
         sAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625675; x=1715230475;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmgpG1H0BarOmPn+1t/bIn9KW+Z0AyYuKOS83PwezFk=;
        b=otFYY8wwGhBUtmEypLBot8nEjhzdmybZsG8WhEJCkJtuDlKi8AV9yg/ohtGHM0gwyd
         y4o8wGP4IpxbnMYWZLeqjbPBsSHXg9UAGPxb/25NM7VF8G5aD2R8hDbWGWkgnu20aCQ2
         v5Kdh2CGxFCmkNn9Nb1QE9arFsK9RPvjwH+jHUFWxpKFQuNrBOlcLqu1jIeAkY+D31MC
         2bgKDjVxaPaHJtwWVKbzQLgaC2Az/cQsgYawnI8mRP/cLIeJZQzhFe7+K9JaVyY7409Y
         6yvASA1CMsB8xl3JwQLgLKp74pvZKiQRepXOhuEZCEFAZgUZ6gTAS6Qon0yRmqvzqmwb
         1q8A==
X-Gm-Message-State: AOJu0Yzl1mwlse8NOvXEx0dr72tqTAhXL5u8wMLUCIt2NiZeqnVXk+xD
	A01ySVx0DZo7//PjrTjT2CRCIcO/YnvjU+ooIpoJ9I7pAn0N7VWVy7TSNA==
X-Google-Smtp-Source: AGHT+IG48BNMxUOnRJi4qZqkb8SVbuS6au/0uU8TWJXJk1MK52xL9cAbw3Ef01cCs7/Wiug503IfkQ==
X-Received: by 2002:a05:600c:474e:b0:41b:f28a:a0c6 with SMTP id w14-20020a05600c474e00b0041bf28aa0c6mr3176234wmo.38.1714625675297;
        Wed, 01 May 2024 21:54:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b0041bf45c0665sm4233155wmq.15.2024.05.01.21.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:34 -0700 (PDT)
Message-Id: <44df42ca503a6007e897f8b5b7c6a8c7d7c27f6e.1714625668.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:22 +0000
Subject: [PATCH v4 05/10] interpret-trailers: access trailer_info with new
 helpers
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

Instead of directly accessing trailer_info members, access them
indirectly through new helper functions exposed by the trailer API.

This is the first of two preparatory commits which will allow us to
use the so-called "pimpl" (pointer to implementation) idiom for the
trailer API, by making the trailer_info struct private to the trailer
implementation (and thus hidden from the API).

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Linus Arver <linus@ucla.edu>
---
 builtin/interpret-trailers.c | 12 ++++++------
 trailer.c                    | 21 +++++++++++++++++++++
 trailer.h                    |  4 ++++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 11f4ce9e4a2..f3240682e35 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -141,7 +141,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf trailer_block = STRBUF_INIT;
-	struct trailer_info info;
+	struct trailer_info *info = trailer_info_new();
 	FILE *outfile = stdout;
 
 	trailer_config_init();
@@ -151,13 +151,13 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
-	parse_trailers(opts, &info, sb.buf, &head);
+	parse_trailers(opts, info, sb.buf, &head);
 
 	/* Print the lines before the trailers */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+		fwrite(sb.buf, 1, trailer_block_start(info), outfile);
 
-	if (!opts->only_trailers && !info.blank_line_before_trailer)
+	if (!opts->only_trailers && !blank_line_before_trailer_block(info))
 		fprintf(outfile, "\n");
 
 
@@ -178,8 +178,8 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
-	trailer_info_release(&info);
+		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
+	trailer_info_release(info);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
diff --git a/trailer.c b/trailer.c
index 4700c441442..95b4c9b8f19 100644
--- a/trailer.c
+++ b/trailer.c
@@ -952,6 +952,12 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
+struct trailer_info *trailer_info_new(void)
+{
+	struct trailer_info *info = xcalloc(1, sizeof(*info));
+	return info;
+}
+
 /*
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
@@ -1000,6 +1006,21 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
+size_t trailer_block_start(struct trailer_info *info)
+{
+	return info->trailer_block_start;
+}
+
+size_t trailer_block_end(struct trailer_info *info)
+{
+	return info->trailer_block_end;
+}
+
+int blank_line_before_trailer_block(struct trailer_info *info)
+{
+	return info->blank_line_before_trailer;
+}
+
 void trailer_info_get(const struct process_trailer_options *opts,
 		      const char *str,
 		      struct trailer_info *info)
diff --git a/trailer.h b/trailer.h
index 7e36da7d13c..9ba96721398 100644
--- a/trailer.h
+++ b/trailer.h
@@ -97,6 +97,10 @@ void parse_trailers(const struct process_trailer_options *,
 void trailer_info_get(const struct process_trailer_options *,
 		      const char *str,
 		      struct trailer_info *);
+size_t trailer_block_start(struct trailer_info *);
+size_t trailer_block_end(struct trailer_info *);
+int blank_line_before_trailer_block(struct trailer_info *);
+struct trailer_info *trailer_info_new(void);
 
 void trailer_info_release(struct trailer_info *info);
 
-- 
gitgitgadget

