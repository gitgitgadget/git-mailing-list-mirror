Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D8208BE
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8g0/Eqv"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38378D4C
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:01:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4083740f92dso9304655e9.3
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697828497; x=1698433297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWIlzatUj0yB3Mm8UszHb+wk6g8QnOKK3XsDQqGKZnc=;
        b=a8g0/EqvdVilnxnMUYywKRaPD1WM5r86GEOYvGe58ZVpvKSoQ2lMsf2BVGVY9Zd2k1
         Hhu7oLd+g6/ee0hmphiM+1R9CU8AQHkvGQp3EmsAGFdaMIhT01HfHFBhtFrGv/fW74Cn
         MbSAh21x+xakL9NBldpO6uOod3MI+xar5JAUzeLyZWscTteQm3l4EQKZyAH8LWDJm23l
         nyf10AvHdAni6tXu8DtaTuRkBZdDfOzAYxgM6W/kd6Yw8LAYvSg42dcgljn2XTfbUtVL
         WJ4afin11hTpQAxkXSt37XBwdFyUnOZVJ2M4DBvM5b0XQ0L8WbYShEYcAQE4PGhRDUox
         0OdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828497; x=1698433297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWIlzatUj0yB3Mm8UszHb+wk6g8QnOKK3XsDQqGKZnc=;
        b=aLsHS3+ZNnXwHAbLXEPSKHXnt4sYaQht0aarYF1cjAMi/YgEaiC2j0CvOr/PnHqo1K
         m5whkkgCvS7dvPUCdgM0ITYX8aJr+cb/6urUfAZFNYoiGkMT8UxsyW/+lPyQqAzzQNyR
         AD1iOwHyCCGRp+MCUl1ChKvzlLS9Km7ryCeOnDGRox2EpNSjTZ7XUhf8SGS8fDiy+3F8
         vTqY906hSk33Dp7DPq+ZwooZ+RKu6CG8Ym0MaFYDDXPJSeDz6pQh0yNvgtMNFgTOR4Dv
         7V5UItNTv8IONvgvmmGww/CK9TZ49EbTmqfquQNu2ZGZU2fjQ8LFBowi8rhIq+KZup9B
         L8wg==
X-Gm-Message-State: AOJu0Yxt4P8XefIEw597tsF4K4DC6cUIyPuQ0l1ZolNL3sDpJKnMzRXy
	7IZ41Fms2Y0zPizyNMo7qhh9mw6updM=
X-Google-Smtp-Source: AGHT+IHmMhbj88eRNIrHxI5GD/iHyofLLnaPPeQNeL6dnR1VWvevO/Pe+jD3dx8+n7p3vheONhM59g==
X-Received: by 2002:a5d:4147:0:b0:319:72f8:7249 with SMTP id c7-20020a5d4147000000b0031972f87249mr2249734wrq.66.1697828497204;
        Fri, 20 Oct 2023 12:01:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020adff587000000b0031fb91f23e9sm2234673wro.43.2023.10.20.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 12:01:37 -0700 (PDT)
Message-ID: <4ce5cf77005eb8c6da243777b3c29103add7ddbd.1697828495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>
References: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
	<pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Oct 2023 19:01:33 +0000
Subject: [PATCH v5 1/3] commit: ignore_non_trailer computes number of bytes to
 ignore
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
Cc: Glen Choo <glencbz@gmail.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

ignore_non_trailer() returns the _number of bytes_ that should be
ignored from the end of the log message. It does not by itself "ignore"
anything.

Rename this function to remove the leading "ignore" verb, to sound more
like a quantity than an action.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/commit.c | 2 +-
 builtin/merge.c  | 2 +-
 commit.c         | 2 +-
 commit.h         | 4 ++--
 trailer.c        | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7da5f924484..d1785d32db1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -900,7 +900,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strbuf_stripspace(&sb, '\0');
 
 	if (signoff)
-		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
+		append_signoff(&sb, ignored_log_message_bytes(sb.buf, sb.len), 0);
 
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
diff --git a/builtin/merge.c b/builtin/merge.c
index 545da0c8a11..c654a29fe85 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -870,7 +870,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 				_(no_scissors_editor_comment), comment_line_char);
 	}
 	if (signoff)
-		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
+		append_signoff(&msg, ignored_log_message_bytes(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
 	if (run_commit_hook(0 < option_edit, get_index_file(), NULL,
diff --git a/commit.c b/commit.c
index b3223478bc2..4440fbabb83 100644
--- a/commit.c
+++ b/commit.c
@@ -1769,7 +1769,7 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
  * Returns the number of bytes from the tail to ignore, to be fed as
  * the second parameter to append_signoff().
  */
-size_t ignore_non_trailer(const char *buf, size_t len)
+size_t ignored_log_message_bytes(const char *buf, size_t len)
 {
 	size_t boc = 0;
 	size_t bol = 0;
diff --git a/commit.h b/commit.h
index 28928833c54..1cc872f225f 100644
--- a/commit.h
+++ b/commit.h
@@ -294,8 +294,8 @@ const char *find_header_mem(const char *msg, size_t len,
 const char *find_commit_header(const char *msg, const char *key,
 			       size_t *out_len);
 
-/* Find the end of the log message, the right place for a new trailer. */
-size_t ignore_non_trailer(const char *buf, size_t len);
+/* Find the number of bytes to ignore from the end of a log message. */
+size_t ignored_log_message_bytes(const char *buf, size_t len);
 
 typedef int (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 				void *cb_data);
diff --git a/trailer.c b/trailer.c
index b6de5d9cb2d..3c54b38a85a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -928,7 +928,7 @@ continue_outer_loop:
 /* Return the position of the end of the trailers. */
 static size_t find_trailer_end(const char *buf, size_t len)
 {
-	return len - ignore_non_trailer(buf, len);
+	return len - ignored_log_message_bytes(buf, len);
 }
 
 static int ends_with_blank_line(const char *buf, size_t len)
-- 
gitgitgadget

