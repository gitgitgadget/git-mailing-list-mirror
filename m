Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE47F7CE
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196378; cv=none; b=YE/+TJdfWnpLcXf1litVG+JwTGft2JY4f8mcHY9YfrmVUTjV7io8nx7ycHVa1zPmnS8fwJxHBAPL+IVF2dsPkGdVQmDdl6sUxcOU9lo6Ux21WBmzOFvcEypcdAEMPYOYlTXU4sluIdJbHWl+5c26Dt2RRJOPxwYK+U5bc1Gn2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196378; c=relaxed/simple;
	bh=BuQAR+jkxrONEeSjMqIA8PGIumwHlVSGcCn9KO9rHo4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CkqWanChyJSk+rZc8cXNneVy9utxDFYMgxZVgX9fpu7bMXaOJkaBrk2vJBEuYOpky3KJ6E/Yx9d5omJN5R0e5FCr/3OtSBznUju4QkM61ksA8yghe0A/0lSAx5lQzr6lm+1uMkoi2XDEdx4bnY3qKL/bktOiO36J7VppIcMUnAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXVv2uY5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXVv2uY5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fd280421aso22400475e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196375; x=1707801175; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbYSM0cx3UEb9I9IhPru1zYtRMz/t9vgM512SrneoUg=;
        b=hXVv2uY5wfKj93BukmxIxXBRw64qyu9ONjbtoETM8vSTMGf/PyiFDbkly7FrW9AsLB
         /QkxsXoBF3ReDXH3Q+e8+ha4BLE/pjp1V0ba/LoVUQePWF3/LgqtTcT5bniCeP5JQW/P
         mdsOCCF7Gm6dTEDnZEMW6qZYO5S/LQzljocYfjLtq0RhLxV1UAETP2FLwXNHB8Jy9Cyd
         aR1s3iWhh9hXMf/chgCOqghaRwfBtZPu8dLXOx5Cpw5uh+XkxYtFXwlxIAv/cmsp57oE
         a5N39kGMtxkRJTOsxm0s9G26d+3tFjjaUTy/+MneDjpJeuB0OOVntyNpB6VPsidjr5jB
         7gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196375; x=1707801175;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbYSM0cx3UEb9I9IhPru1zYtRMz/t9vgM512SrneoUg=;
        b=kutXuDmHdIZHVxB3Eq5dYKTwmsrdUe+/XoO00JYT9C8bdWSGpRft2XIuqwGS/dpdf0
         KxgKb03counEDktGq9/q5RNnbZJ5kLw4SgNuzcvlb/+nERNmmLXLjXR5J96QMOAu0ARt
         lBYxVsHS9jmJuezp4KBFJis3xayCvaXH5KWq9VIC52QmIdXYsGkY3Q+UqAHEkkUEQmQd
         WRcqfz+B45+jULbbOIFQcZMpI+2iz9XS2J3ZwCKBAuuXGX4xpFa8512qyM6K6hFYQ7XD
         CkL4QObVJcvslzZOoDgLTqqjdHHmVbD1uwF1mNQjcKQxaz7fH7Yh9TjDmSAuPiy43Bvq
         8W2Q==
X-Gm-Message-State: AOJu0YwnktTqD6OUec1bishCF6gXyZuvCNNsXsf05YwYsOaF99NMT/HS
	v4V/ys0DKN3L7Dak6uj8L9/x2JnTGUhCZ28qUWZKew+CxxI7kCsyD9wFbV19
X-Google-Smtp-Source: AGHT+IG4tL5o7udfnYJgR5/j5fPzdtgipXdWMS23amvibMvTgyJb+NnvRdIs+eb5vZTPQs7ANHpp1g==
X-Received: by 2002:a05:600c:5254:b0:40f:d2f7:6e34 with SMTP id fc20-20020a05600c525400b0040fd2f76e34mr1129082wmb.33.1707196374566;
        Mon, 05 Feb 2024 21:12:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWAfjsOa/jz54c1Iwbve2ToiTdOJ/Wz01pWjEYz7ccuVs6h9HcerpPchkNn/iYT6liQmVkrrjzd+8w2FmWQjVXPPHgq/Wp4rNeszGcuL04LxkuRk/xJ3M3ensSuaP/Tc5U08bT1c6WZ0FiIfakv2AdJ/LSVwhr5CE7fVRF2v45KiwCOJstACqZgbG0TvbEO1H5zmwp5e0PJ5Q==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b0040fd3d8ce5csm638823wmb.16.2024.02.05.21.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:54 -0800 (PST)
Message-ID: <9720526dd8a63b916c75fe9d6322ee13c8b36621.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:26 +0000
Subject: [PATCH v4 26/28] trailer: unify "--trailer ..." arg handling
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

Move the logic of parse_trailer_from_command_line_arg() into
option_parse_trailer(), because that is the only caller and there's no
benefit in keeping these two separate.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 42 +++++++++++++++++++++++++++++-
 trailer.c                    | 50 ------------------------------------
 trailer.h                    |  6 -----
 3 files changed, 41 insertions(+), 57 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 943be5b360e..9657b0d067c 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -49,6 +49,11 @@ static int option_parse_trailer(const struct option *opt,
 				   const char *arg, int unset)
 {
 	struct list_head *trailers = opt->value;
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	const struct trailer_conf *conf;
+	ssize_t separator_pos;
+	static char *cl_separators;
 
 	if (unset) {
 		free_new_trailers(trailers);
@@ -58,7 +63,42 @@ static int option_parse_trailer(const struct option *opt,
 	if (!arg)
 		return -1;
 
-	parse_trailer_from_command_line_arg(arg, where, if_exists, if_missing, trailers);
+	/*
+	 * In command-line arguments, '=' is accepted (in addition to the
+	 * separators that are defined).
+	 */
+	cl_separators = xstrfmt("=%s", trailer_default_separators());
+	separator_pos = find_separator(arg, cl_separators);
+	free(cl_separators);
+
+	if (separator_pos == 0) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, arg);
+		strbuf_trim(&sb);
+		error(_("empty trailer token in trailer '%.*s'"),
+			(int) sb.len, sb.buf);
+		strbuf_release(&sb);
+	} else {
+		struct trailer_conf *conf_current = new_trailer_conf();
+		parse_trailer(arg, separator_pos, &tok, &val, &conf);
+		duplicate_trailer_conf(conf_current, conf);
+
+		/*
+		 * Override conf_current with settings specified via CLI flags.
+		 */
+		if (where != WHERE_DEFAULT)
+			trailer_set_conf_where(where, conf_current);
+		if (if_exists != EXISTS_DEFAULT)
+			trailer_set_conf_if_exists(if_exists, conf_current);
+		if (if_missing != MISSING_DEFAULT)
+			trailer_set_conf_if_missing(if_missing, conf_current);
+
+		trailer_add_arg_item(trailers,
+				     strbuf_detach(&tok, NULL),
+				     strbuf_detach(&val, NULL),
+				     conf_current);
+		free_trailer_conf(conf_current);
+	}
 
 	return 0;
 }
diff --git a/trailer.c b/trailer.c
index 0893175553a..b0b067ab12c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -754,56 +754,6 @@ void parse_trailers_from_config(struct list_head *config_head)
 	}
 }
 
-void parse_trailer_from_command_line_arg(const char *line,
-					 enum trailer_where where,
-					 enum trailer_if_exists if_exists,
-					 enum trailer_if_missing if_missing,
-					 struct list_head *arg_head)
-{
-	struct strbuf tok = STRBUF_INIT;
-	struct strbuf val = STRBUF_INIT;
-	const struct trailer_conf *conf;
-
-	/*
-	 * In command-line arguments, '=' is accepted (in addition to the
-	 * separators that are defined).
-	 */
-	char *cl_separators = xstrfmt("=%s", trailer_default_separators());
-
-	/* Add an arg item for a trailer from the command line */
-	ssize_t separator_pos = find_separator(line, cl_separators);
-	free(cl_separators);
-
-	if (separator_pos == 0) {
-		struct strbuf sb = STRBUF_INIT;
-		strbuf_addstr(&sb, line);
-		strbuf_trim(&sb);
-		error(_("empty trailer token in trailer '%.*s'"),
-		      (int) sb.len, sb.buf);
-		strbuf_release(&sb);
-	} else {
-		struct trailer_conf *conf_current = new_trailer_conf();
-		parse_trailer(line, separator_pos, &tok, &val, &conf);
-		duplicate_trailer_conf(conf_current, conf);
-
-		/*
-		 * Override conf_current with settings specified via CLI flags.
-		 */
-		if (where != WHERE_DEFAULT)
-			trailer_set_conf_where(where, conf_current);
-		if (if_exists != EXISTS_DEFAULT)
-			trailer_set_conf_if_exists(if_exists, conf_current);
-		if (if_missing != MISSING_DEFAULT)
-			trailer_set_conf_if_missing(if_missing, conf_current);
-
-		trailer_add_arg_item(arg_head,
-				     strbuf_detach(&tok, NULL),
-				     strbuf_detach(&val, NULL),
-				     conf_current);
-		free_trailer_conf(conf_current);
-	}
-}
-
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
diff --git a/trailer.h b/trailer.h
index 2848a0d086c..af55032625d 100644
--- a/trailer.h
+++ b/trailer.h
@@ -62,12 +62,6 @@ struct process_trailer_options {
 
 void parse_trailers_from_config(struct list_head *config_head);
 
-void parse_trailer_from_command_line_arg(const char *line,
-					 enum trailer_where where,
-					 enum trailer_if_exists if_exists,
-					 enum trailer_if_missing if_missing,
-					 struct list_head *arg_head);
-
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-- 
gitgitgadget

