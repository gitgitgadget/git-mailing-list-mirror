Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72C2066E2
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488994; cv=none; b=On0+2RyG22TbOcFa8PFi0Ik7DbF/bwbKGj63Bb7AvRPyjSs5GBQT8u5VZe1/FZ+uOOqhwFTXQTcCc+6il36+H5NH2SpM+FC8gOXs9J85l0/WF9jHNBvT5VJ1CjjOmoI3XzGGPw9oTJMljYgQV07S3Fo1lYAr8c5YCTt8UL8k5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488994; c=relaxed/simple;
	bh=h5Ujg4TvBzOI1DoAa3pdEpCkrl67TZ1WnYiXeHXujm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH753CE1QJyn34iLEBxfFHCECuLv++zPAoWtFjyv7IKn+wg52bLkXeE+Ysls/3aQs1+mvcsMvGqIZDr8FR1EDZ+zjp5MJJ8myRFlbhWM05E3pO1cxgbBFNsih6sk9PMJtHUQY+y6xiZZ27DoRrEcGNkzBqpQ8jQgu4Xpz1klSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh072ZcL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh072ZcL"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa62f0cb198so209806666b.2
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 04:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733488990; x=1734093790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvuy2LexqVQOKGFHw2pGQOzHXlUxKpe6JWZ2AST6r1s=;
        b=Bh072ZcLsJhfMjn/3d9CQ+iUKtvAu6uUx8FHxHlkDk7IGugFbWJHNqb9zc0OaFcXev
         nNmufrpWhS53hqFMYIItxtsFMBaY4twbpcf0wmBLL7z/gUcY5klXkkdc9NgPxdWXs9oL
         ebTxjG46EUfPh9JJR4MUQNN3vibzTxVLEMK8J/dUjf+az1gTMAYGYoYXIkHb4GrNqx7y
         lYth5M2DSrryPZGmHFpPJbZTipvG04l7EjVzpVqgcy340DHfDhgmAWNaLr7Zot2H02CB
         tmH0Q5Vb9NqZJcgJDovyRFAl0OLl+7j4/G5eApSwtbsYMQNjJL8EHG6BS1qLi3QWP8id
         RRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733488990; x=1734093790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvuy2LexqVQOKGFHw2pGQOzHXlUxKpe6JWZ2AST6r1s=;
        b=QHK1YIT4729xpMnuVfKzcXpdBmSARzobf4XVUNngUczjkZvKFBhdtLdM1i+eT/gpJb
         +CqEVjRw8y8ZsbcvKmTAto5AVjUWZA7yES/5lhZhXwNUyMPiNPzSfsZj6nkrp5Vwl+dN
         j3jJUv1ZA1b0A20QgLG95vWxNkeicjgQ+NmzFSYQG/ySbmZ+8BUyk7LTtAQRraNaxESA
         WJrp15tn5JYFt7MnExH3hebs/I9Pn58HZh/CIeCpJm6amq2R4wXOp7sJ0MrgkwNQT8R+
         JBxsRIQBJUQIK+XJxUEvuJXKPUeSC8FRiQkQxhPHDkW0oeczRXLhX4MmJ0730pvcHjH9
         edvA==
X-Gm-Message-State: AOJu0YzXm5mr+NZIoCMm+cCsrWSzA6GsifD2GOt+Wae2MSBu/d/cqQm+
	TrYjH+JrN/xLB9yEj3E2OUaWzY7FOFrl+ZsLY3oCPKNdMUg5NXcAPa9kqw==
X-Gm-Gg: ASbGncuFcr3cJw/n3y/hTa8oY9sCoJA4SBerJodZClqnejAhQIle2SjRm4seoo2rVcj
	uJnqb34gxFzUfwKLsB7oo9CtciVI5nrrHr2fSW6fmt/ZaC4xV1DAl8npon3B0SfrsoDvy/M0Ayk
	dHQLZBYJEThxW7ciBWDYi+IJM6PnIXgYLIElpHP2hu1l0FM8SjP96d5gJYbV5RWrM8hRu0hqEHA
	8hKvSgAxRM/l+T/qTzX+6zFGyIIr8x1scbENcLTtUG4acXvxgdGOf4o/gZu32yh+pQRici38Db9
	l5L4AAHGOrG1nBZnE8ckJ+U/h8dSMtT0
X-Google-Smtp-Source: AGHT+IHmrg+n2BvQu4diXgvunW5+gk6r27RfF9oLxrGwIFfVxQWZ84KFboCLbNxfKo6IfcVIVimrwg==
X-Received: by 2002:a17:906:3191:b0:aa6:273f:452b with SMTP id a640c23a62f3a-aa63a005dfdmr171327166b.16.1733488990206;
        Fri, 06 Dec 2024 04:43:10 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4da51sm236527266b.37.2024.12.06.04.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 04:43:08 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/5] strbuf: refactor strbuf_trim_trailing_ch()
Date: Fri,  6 Dec 2024 13:42:45 +0100
Message-ID: <20241206124248.160494-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.47.1.402.gc25c94707f
In-Reply-To: <20241206124248.160494-1-christian.couder@gmail.com>
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We often have to split strings at some specified terminator character.
The strbuf_split*() functions, that we can use for this purpose,
return substrings that include the terminator character, so we often
need to remove that character.

When it is a whitespace, newline or directory separator, the
terminator character can easily be removed using an existing triming
function like strbuf_rtrim(), strbuf_trim_trailing_newline() or
strbuf_trim_trailing_dir_sep(). There is no function to remove that
character when it's not one of those characters though.

Let's introduce a new strbuf_trim_trailing_ch() function that can be
used to remove any trailing character, and let's refactor existing code
that manually removed trailing characters using this new function.

We are also going to use this new function in a following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 strbuf.c         |  7 +++++++
 strbuf.h         |  3 +++
 trace2/tr2_cfg.c | 10 ++--------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index cccfdec0e3..c986ec28f4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -134,6 +134,13 @@ void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_trim_trailing_ch(struct strbuf *sb, int c)
+{
+	while (sb->len > 0 && sb->buf[sb->len - 1] == c)
+		sb->len--;
+	sb->buf[sb->len] = '\0';
+}
+
 void strbuf_trim_trailing_newline(struct strbuf *sb)
 {
 	if (sb->len > 0 && sb->buf[sb->len - 1] == '\n') {
diff --git a/strbuf.h b/strbuf.h
index 884157873e..5e389ab065 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -197,6 +197,9 @@ void strbuf_trim_trailing_dir_sep(struct strbuf *sb);
 /* Strip trailing LF or CR/LF */
 void strbuf_trim_trailing_newline(struct strbuf *sb);
 
+/* Strip trailing character c */
+void strbuf_trim_trailing_ch(struct strbuf *sb, int c);
+
 /**
  * Replace the contents of the strbuf with a reencoded form.  Returns -1
  * on error, 0 on success.
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 22a99a0682..9da1f8466c 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -35,10 +35,7 @@ static int tr2_cfg_load_patterns(void)
 
 	tr2_cfg_patterns = strbuf_split_buf(envvar, strlen(envvar), ',', -1);
 	for (s = tr2_cfg_patterns; *s; s++) {
-		struct strbuf *buf = *s;
-
-		if (buf->len && buf->buf[buf->len - 1] == ',')
-			strbuf_setlen(buf, buf->len - 1);
+		strbuf_trim_trailing_ch(*s, ',');
 		strbuf_trim_trailing_newline(*s);
 		strbuf_trim(*s);
 	}
@@ -74,10 +71,7 @@ static int tr2_load_env_vars(void)
 
 	tr2_cfg_env_vars = strbuf_split_buf(varlist, strlen(varlist), ',', -1);
 	for (s = tr2_cfg_env_vars; *s; s++) {
-		struct strbuf *buf = *s;
-
-		if (buf->len && buf->buf[buf->len - 1] == ',')
-			strbuf_setlen(buf, buf->len - 1);
+		strbuf_trim_trailing_ch(*s, ',');
 		strbuf_trim_trailing_newline(*s);
 		strbuf_trim(*s);
 	}
-- 
2.47.1.402.gc25c94707f

