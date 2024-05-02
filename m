Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F124208A5
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625685; cv=none; b=lhAulL3wvVYda1lzhn8uVU6BZ64lepa51fiDywsnqoXEp2WhxK0EG+I/Kja80xX0rgdf6IP4t08jQBdsdXaJD112o1Awk/ln4InZWSZD12Dktv+rtzKjLyUL2bKpBQLmm6YYjImAOjSEgsbk3CvELXh5uqaClK29FFiYD2FXONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625685; c=relaxed/simple;
	bh=yYeQ7AAR3Yfte32t8sr7Txt2T8nA3wjmDCJC29ojBw8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aYWV1NsKZ0LrnU4j+0D24sqNJsvvgAnXw9aZ1PzyKPba1pkQGVavROEWyPzcpvHy3K1HHNUfadBpuYLD+xd6QYddsOpH1gnvsPXGz3pj63R5cFMNosBwLFw8FdXZuIfNMyfl26LpLzmWUHt/kffXOO6Cv56WX2zNPEyYIPOjlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEuU8nsM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEuU8nsM"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso72669641fa.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625681; x=1715230481; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHy3w/jmb5rVyFsJuV+a2Zva6f4ZiFgRqNbnWmxj/vg=;
        b=mEuU8nsMXtlTeHIwxY3PzFvwzdNkxrKISHNunuFfZ19SRhjnBDFjT/i82U5j7pasRK
         Cnq5x7zr+p16Amoh8L66jGvA3qAfDI5xpwbswF/5tgbKO6tJLLt1tRVAwW5N/dhRYKRA
         gR6TWp4Lm7W9MH8quMyVTUKNqUOKJm1g4mKPDyq/gSaj9/G6ILmOTCW8smSaLTkhKcyl
         ffPw9knLitolOjGKIovoKU1ODJNFe3HIYX/lPCbVSYOdUV+ea00zj4u7s1qWhUOaKefX
         ntnJPGoZNA7Y+NgWLXqYGF7z0GxsL/7NWkljzLafx8wFm3YV2MJkpFOKDzVUSLYHfn3i
         U6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625681; x=1715230481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHy3w/jmb5rVyFsJuV+a2Zva6f4ZiFgRqNbnWmxj/vg=;
        b=m3ASpe4UwF8WzmlTTjtqneiCC2IrIPscrsrSryXSn4OPhrTVXnok09uBamao6Y6KQo
         HyGDNrYUp+Z/5Qn4SWMnAi5XAtSkZNUngkYDzE1p7y6w0L6Fync20wjMBERFGPsU72ND
         S7Gr06CWCqnyJGlwCzaPCB346iDiNB6nSjuaXRpRBXTNf2lNRC1JNu21jSoalgFlml5+
         WtEHLEGLwOa9OlwhA6QkaDgA8s3K/3PRObQDeSUESLf8RGimhS6TK9SHcNajkwgeDGCo
         Y5ixJStmyGqjECp1P28IItIeFVpK1qqjKi8cZcA7e/u6WV6bDNvJg9pnZWk+xx3qBOtV
         yVSw==
X-Gm-Message-State: AOJu0YyGXC0cOB4v1x3s8IcshlZqHyKFTLy6CQnt6fEgx2pyps5ApAn2
	qu5nk6vQOQqchG/MJ8mYalF42SvLbVGaNlKdoVXjqw5oqKnX9VuEYL+iNw==
X-Google-Smtp-Source: AGHT+IEOypnWKRFznf5MUEJGExBEy8xl2jNGs7KIndCO50bpBRRjJt6+tMxJ/WVSz+25ssoG/vNQWQ==
X-Received: by 2002:a05:651c:515:b0:2e0:2891:c75e with SMTP id o21-20020a05651c051500b002e02891c75emr834829ljp.51.1714625680975;
        Wed, 01 May 2024 21:54:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b0041563096e15sm4275084wms.5.2024.05.01.21.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:39 -0700 (PDT)
Message-Id: <c1a0f1bed043ee00b6aaf0a65aa3f8aa3b396497.1714625668.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:26 +0000
Subject: [PATCH v4 09/10] trailer: document parse_trailers() usage
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

Explain how to use parse_trailers(), because earlier we made the
trailer_info struct opaque. That is, because clients can no longer peek
inside it, we should give them guidance about how the (pointer to the)
opaque struct can still be useful to them.

Rename "head" struct to "trailer_objects" to make the wording of the new
comments a bit easier to read (because "head" itself doesn't really have
any domain-specific meaning here).

Signed-off-by: Linus Arver <linus@ucla.edu>
---
 trailer.c |  8 ++++----
 trailer.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/trailer.c b/trailer.c
index 33b6aa7e8bd..406745264aa 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1026,12 +1026,12 @@ static struct trailer_info *trailer_info_get(const struct process_trailer_option
 }
 
 /*
- * Parse trailers in "str", populating the trailer info and "head"
+ * Parse trailers in "str", populating the trailer info and "trailer_objects"
  * linked list structure.
  */
 struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
 				    const char *str,
-				    struct list_head *head)
+				    struct list_head *trailer_objects)
 {
 	struct trailer_info *info;
 	struct strbuf tok = STRBUF_INIT;
@@ -1051,13 +1051,13 @@ struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
 				      separator_pos);
 			if (opts->unfold)
 				unfold_value(&val);
-			add_trailer_item(head,
+			add_trailer_item(trailer_objects,
 					 strbuf_detach(&tok, NULL),
 					 strbuf_detach(&val, NULL));
 		} else if (!opts->only_trailers) {
 			strbuf_addstr(&val, trailer);
 			strbuf_strip_suffix(&val, "\n");
-			add_trailer_item(head,
+			add_trailer_item(trailer_objects,
 					 NULL,
 					 strbuf_detach(&val, NULL));
 		}
diff --git a/trailer.h b/trailer.h
index b0ec7658c67..82104912d70 100644
--- a/trailer.h
+++ b/trailer.h
@@ -70,14 +70,63 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
+/*
+ * Given some input string "str", return a pointer to an opaque trailer_info
+ * structure. Also populate the trailer_objects list with parsed trailer
+ * objects. Internally this calls trailer_info_get() to get the opaque pointer,
+ * but does some extra work to populate the trailer_objects linked list.
+ *
+ * The opaque trailer_info pointer can be used to check the position of the
+ * trailer block as offsets relative to the beginning of "str" in
+ * trailer_block_start() and trailer_block_end().
+ * blank_line_before_trailer_block() returns 1 if there is a blank line just
+ * before the trailer block. All of these functions are useful for preserving
+ * the input before and after the trailer block, if we were to write out the
+ * original input (but with the trailer block itself modified); see
+ * builtin/interpret-trailers.c for an example.
+ *
+ * For iterating through the parsed trailer block (if you don't care about the
+ * position of the trailer block itself in the context of the larger string text
+ * from which it was parsed), please see trailer_iterator_init() which uses the
+ * trailer_info struct internally.
+ *
+ * Lastly, callers should call trailer_info_release() when they are done using
+ * the opaque pointer.
+ *
+ * NOTE: Callers should treat both trailer_info and trailer_objects as
+ * read-only items, because there is some overlap between the two (trailer_info
+ * has "char **trailers" string array, and trailer_objects will have the same
+ * data but as a linked list of trailer_item objects). This API does not perform
+ * any synchronization between the two. In the future we should be able to
+ * reduce the duplication and use just the linked list.
+ */
 struct trailer_info *parse_trailers(const struct process_trailer_options *,
 				    const char *str,
-				    struct list_head *head);
+				    struct list_head *trailer_objects);
 
+/*
+ * Return the offset of the start of the trailer block. That is, 0 is the start
+ * of the input ("str" in parse_trailers()) and some other positive number
+ * indicates how many bytes we have to skip over before we get to the beginning
+ * of the trailer block.
+ */
 size_t trailer_block_start(struct trailer_info *);
+
+/*
+ * Return the end of the trailer block, again relative to the start of the
+ * input.
+ */
 size_t trailer_block_end(struct trailer_info *);
+
+/*
+ * Return 1 if the trailer block had an extra newline (blank line) just before
+ * it.
+ */
 int blank_line_before_trailer_block(struct trailer_info *);
 
+/*
+ * Free trailer_info struct.
+ */
 void trailer_info_release(struct trailer_info *info);
 
 void trailer_config_init(void);
-- 
gitgitgadget

