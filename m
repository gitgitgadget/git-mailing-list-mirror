Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307A1E9B0A
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740865651; cv=none; b=mb/GW6hUZ+HotbOxlq6XjEJxk138OvFBHkfWYSpUM+1zcXVNXPK3rsz+ZRtnHgu5GvWcCNq75ASdW3Edk4gvE3CKU8go/AUsJfVumaNTxJufCSuXkcA2mdRydFW11pdtY+3yZWPY62m6qfUo2RclgUrQL5QHZMiVwXfKv3Z7+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740865651; c=relaxed/simple;
	bh=DSA4WwIXRUon4Zi9zyI/wwj9nfPK72Nj07VWd+h2ewQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2rMNiLydq3kMDU6hmkrk7UzdoRexAXXx+SSfGgv9SciCT8hHYffEQ197PgnZXWrieyLZUpjwuk/zaMNifyQ8dz8Lza5fQ0LswC3lW4VsU5clNdtsaZbrucN98FQwP0KeOLg4fmlZG6JwmH4s1NJq+Bul+18cPVOgI+jCd3yK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlzsAwf/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlzsAwf/"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso2959308f8f.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 13:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740865647; x=1741470447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqcG+CP2VMCuVXsQ/1qF7Np/3463d9uxBk/J52K9WGM=;
        b=SlzsAwf/Bh0EGCzDt36p0enK3QtKXnbvge3kYJE9IKwNusFd/sxy6w+AE5fR/i+hd3
         XgMIt3+v11eMFRnCrLIy2ecpuDARmzHaWPBNgTcZbGBVp8tV245VMTuwDyVPkHDjdlhD
         6oRNlnr2zoYgrnNYB0aKtuwQ/HBR0dmWvLyMMuXr1uP+KiLBfsULQnOOfB3rsQBpabIC
         +soRbhU3AqOHOf9eoLLDdxyZ83bNWDuvEQcyMwIf27H1S/2h78nMFUF3zbxgSPhKLUK4
         h/gZCHnipB3ih6PC4/WNeJCaYfOYRsr8dTfu84OzM81Viw0IK8UdNWYE45IBvQ6IS6X5
         Rddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740865647; x=1741470447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqcG+CP2VMCuVXsQ/1qF7Np/3463d9uxBk/J52K9WGM=;
        b=C94BIC8NsqhGUFylQKOx02bYxZRrshC4XYMy2ze3wQzEJBdE1x98dEGOLMmnIlgCLk
         ATvIOytZ2lPDYss+GLLfF/1xjY84gj+pzoC7g9H96LN6pbJw20uzILsGhz2Cf3qDsmj0
         DTeBjHqIGqB3rBXwrazKpXegVZcR1D4udA+WTVkpHwYFt3gMZA9VzdM0G3J+hhtUUb/u
         hxE0AeryybKGAG0tXNMGrNFeYejOi7dNytfSAc13TzyjlPhTzR5oUtxlicv79lnXIfg+
         YRC6wmGDZ6ssRZCnyAshi4Mw713oYr6XRu/d9SkgmLobNB88oDNTQui4JxtLasPQdWye
         hUPQ==
X-Gm-Message-State: AOJu0Yy411cMvpVaVj8EwVrPM3W6d+15GYnRcC/DFB6xlTfY7jfepM6m
	lrpB94s4SdqRR/zrjSk9q37DglzpE6t55UzLOrCt5dXqp0NcO2/1nwvrV7QF
X-Gm-Gg: ASbGncsJvXKts+lJnckldCWn7O45+dHfmjVcbwOJQPHF8as0BcP+KmwReSayw48088y
	BhSPkVMBnltpDsbHfRcQz2RwLknd1ZEAubpIrf+gkhtCp9+CJP4ANbv3uqsU+FOdOS8cdU+T/Q+
	ilIKsDHC674GLPf+0LCISiIEVIPmvsnibkDGkF1D4UUtgXI3r1ex2SDfUFAiKyKyr3Sv2jHiO8g
	96fnoX8mXu/YBoamAyOothrjxbiED8uvuYA3xGNAVd/jkEo4R1Y6La7C11KuiKTYIyHL+GaGnH3
	3vdE4JefvZLCC6XmoUSuXFXHg56Aj+Em/k15WrXOJJdVVMiVjSPqfY4nCRwA2/xE6UEbzlsia9v
	u9Ga3
X-Google-Smtp-Source: AGHT+IHsO8S1OFC95cwSFaXK7Avm3rsUkSHvC0NNAZEkLz5hZ132f00QlRr1PXU43w9DyqeqUfoLrg==
X-Received: by 2002:a5d:64cf:0:b0:390:e535:8750 with SMTP id ffacd0b85a97d-390ec12eff3mr7530319f8f.9.1740865647064;
        Sat, 01 Mar 2025 13:47:27 -0800 (PST)
Received: from aleksbgbg.communityfibre.co.uk ([103.205.25.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm9603474f8f.31.2025.03.01.13.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 13:47:26 -0800 (PST)
From: Aleks Todorov <aleks.todorov.1337@gmail.com>
To: git@vger.kernel.org
Cc: Aleks Todorov <aleks.todorov.1337@gmail.com>
Subject: [PATCH 4/7] builtin/blame: Expand format when available
Date: Sat,  1 Mar 2025 21:45:03 +0000
Message-ID: <20250301214652.536439-5-aleks.todorov.1337@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
References: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user-specified format string is available, expand the string by
filling in the details and emit.

We can therefore now emulate the default format with the following
command:

  git blame builtin/blame.c -F '%h %<(17,trunc)%F (%<(20,trunc)%an %ai %>(4)%L) '

Signed-off-by: Aleks Todorov <aleks.todorov.1337@gmail.com>
---
 builtin/blame.c | 112 ++++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 47 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 891ac017f7..d2b605f7a9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -489,63 +489,81 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 		if (color)
 			fputs(color, stdout);
 
-		if (suspect->commit->object.flags & UNINTERESTING) {
-			if (blank_boundary) {
-				memset(hex, ' ', strlen(hex));
-			} else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
-				length--;
-				putchar('^');
-			}
-		}
-
-		if (mark_unblamable_lines && ent->unblamable) {
-			length--;
-			putchar('*');
-		}
-		if (mark_ignored_lines && ent->ignored) {
-			length--;
-			putchar('?');
-		}
-
-		printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length : GIT_MAX_HEXSZ), hex);
-		if (opt & OUTPUT_ANNOTATE_COMPAT) {
-			const char *name;
-			if (opt & OUTPUT_SHOW_EMAIL)
-				name = ci.author_mail.buf;
-			else
-				name = ci.author.buf;
-			printf("\t(%10s\t%10s\t%d)", name,
-			       format_time(ci.author_time, ci.author_tz.buf,
-					   show_raw_time),
-			       ent->lno + 1 + cnt);
+		if (format) {
+			struct strbuf sb = STRBUF_INIT;
+			struct pretty_print_context context = {
+				.fmt = CMIT_FMT_USERFORMAT,
+				.abbrev = abbrev,
+				.is_blame = true,
+				.filename = suspect->path,
+				.line = ent->lno + 1 + cnt,
+			};
+			repo_format_commit_message(the_repository,
+						   suspect->commit, format, &sb,
+						   &context);
+			printf("%s", sb.buf);
+			strbuf_release(&sb);
 		} else {
-			if (opt & OUTPUT_SHOW_SCORE)
-				printf(" %*d %02d",
-				       max_score_digits, ent->score,
-				       ent->suspect->refcnt);
-			if (opt & OUTPUT_SHOW_NAME)
-				printf(" %-*.*s", longest_file, longest_file,
-				       suspect->path);
-			if (opt & OUTPUT_SHOW_NUMBER)
-				printf(" %*d", max_orig_digits,
-				       ent->s_lno + 1 + cnt);
+			if (suspect->commit->object.flags & UNINTERESTING) {
+				if (blank_boundary) {
+					memset(hex, ' ', strlen(hex));
+				} else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
+					length--;
+					putchar('^');
+				}
+			}
 
-			if (!(opt & OUTPUT_NO_AUTHOR)) {
+			if (mark_unblamable_lines && ent->unblamable) {
+				length--;
+				putchar('*');
+			}
+			if (mark_ignored_lines && ent->ignored) {
+				length--;
+				putchar('?');
+			}
+
+			printf("%.*s",
+			       (int)(length < GIT_MAX_HEXSZ ? length :
+							      GIT_MAX_HEXSZ),
+			       hex);
+			if (opt & OUTPUT_ANNOTATE_COMPAT) {
 				const char *name;
-				int pad;
 				if (opt & OUTPUT_SHOW_EMAIL)
 					name = ci.author_mail.buf;
 				else
 					name = ci.author.buf;
-				pad = longest_author - utf8_strwidth(name);
-				printf(" (%s%*s %10s",
-				       name, pad, "",
+				printf("\t(%10s\t%10s\t%d)", name,
 				       format_time(ci.author_time,
 						   ci.author_tz.buf,
-						   show_raw_time));
+						   show_raw_time),
+				       ent->lno + 1 + cnt);
+			} else {
+				if (opt & OUTPUT_SHOW_SCORE)
+					printf(" %*d %02d", max_score_digits,
+					       ent->score, ent->suspect->refcnt);
+				if (opt & OUTPUT_SHOW_NAME)
+					printf(" %-*.*s", longest_file,
+					       longest_file, suspect->path);
+				if (opt & OUTPUT_SHOW_NUMBER)
+					printf(" %*d", max_orig_digits,
+					       ent->s_lno + 1 + cnt);
+
+				if (!(opt & OUTPUT_NO_AUTHOR)) {
+					const char *name;
+					int pad;
+					if (opt & OUTPUT_SHOW_EMAIL)
+						name = ci.author_mail.buf;
+					else
+						name = ci.author.buf;
+					pad = longest_author -
+					      utf8_strwidth(name);
+					printf(" (%s%*s %10s", name, pad, "",
+					       format_time(ci.author_time,
+							   ci.author_tz.buf,
+							   show_raw_time));
+				}
+				printf(" %*d) ", max_digits, ent->lno + 1 + cnt);
 			}
-			printf(" %*d) ",
-			       max_digits, ent->lno + 1 + cnt);
 		}
 		if (reset)
 			fputs(reset, stdout);
-- 
2.43.0

