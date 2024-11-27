Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6F199E9D
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750560; cv=none; b=GmHsGe0u/F4msjmhn8YnARImEF33o6CvAuQEaLdz1hnxtRoMPXR4L6N2hM89D2kUZ2u8bKYs7UB+R8jl1VRrrc0oCNJdGAKcawOwOW/Erea70m/3ItoEdROSExja42IhWpOusB747680Tmw3b2LqcEHj3Seo1741mhpMG8uGfFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750560; c=relaxed/simple;
	bh=JWPYztCAk+Dse92p5aS/+CxWXANUxUsFUNr6ww4auoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQx5TQg0TjlUEQQyOz0IbEoSQJC5AV65I+rLLLXdazObBR6aaV+07kCdAaHEN0XRqgixK+tB/GwjNZBhgqZ9hUslrUbD8umvkCYn5/39p9c2cyVSRvXZNiOZpQtdoPZELUFFWOWtR2lCki5oySBEDjvlKTg4og2OxYM78Som/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX47vkSn; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX47vkSn"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29678315c06so187126fac.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 15:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732750557; x=1733355357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0ROPFKsVEUkfPPpJWkV5nAFRJudcOO8Luq6aaDwNfA=;
        b=jX47vkSnWXjleQMRFhuJTN8IX/7YawRclYntcz16On+cwJBjcjwZ5CW0B7XHaDvEg3
         VxPlArd4YUAw2OaFYgqYUfV3v379A6H+VPbbrRypA0+MmooxTE/hBw4WnKBYjyzGuxrb
         HH4y3gCykBDjPZmalc3MqbIQR1hB+ao0+AlFcUUKFxRbZCZVq2MDwQLGRNC+Q23wNL29
         2htAAT5zTbnHwxibtpmueaZCcCREwnkZl/sXfag9SHKRZz3txJGHPJL8e7d2JSCqWQkY
         iXm3BOHOWmXaHkoKNCRUhLjCVvnVyXsnwXMPF+P8FAawF7EA5KrZZmavwmMs4uVL5qf4
         K7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732750557; x=1733355357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0ROPFKsVEUkfPPpJWkV5nAFRJudcOO8Luq6aaDwNfA=;
        b=NIITshVzi3pJQ824BekCkitEpl9s821sgdUIMkSU5sS6kk6YuABx9zBYk/zxpvqOI0
         utuHXhYWFPJZGkVu7T+wv9PtUR/+4I5SDVoP5QX3rc4FkBa1J7WFwVYxBgnGJ7j5n1YR
         gwCKstuI1DAQjPWb60pboi9+OhLK8nOWepVHHrc+9JckJ+rD2RPA6OuMj7+oJhPXdloz
         KWCXyFSBalAfzQc/QUi08SUs2ygOamJibBU7V5QLYkVliwd8Vm3sMD0uz/jvBAJE8ds2
         jS6aGqT4nZUDSa33xZV8RAVqlVl9fTHyhqMR9q8V+ihfgW8WQsrZSjv0w9HFU8MguFp8
         R2pg==
X-Gm-Message-State: AOJu0YzHQEifJW+Bwtt9T6wSDlC5Oi97oab18AJKPUXHxjug8Ub//8d0
	/DE634qu2uSilwbkUDGy2bKsRpMWZv9S1Cuy+XlizPyyfs8i8Tf3daWKOA==
X-Gm-Gg: ASbGncvQLj0bHYaTIsuX8nETgdy/9TM+9+Xkntfl2vkC1TqDoReWAPqt1vrTjTZ/0Uf
	NQa/O2hNEAyPYz+xd8KkBRCPkKmwLXEOmMk6itDMhEKeEtkPnzpYdYtLnw7BsUizOYWCUBXyVs2
	aN2uiJQ06Nb7cn4N8FjzzIZPw6Z23roZv8AFwqKMkknggncF0C82YRtPEqD/FvV+cbmFE9Bk48A
	YAJtjH/eEm5JjbOivQhmt+/1IzEWyYv8D4p2lHY0mgWFWLF9iqhhr/D9w==
X-Google-Smtp-Source: AGHT+IEt8xL3hvGyfGfkIVSgkWmBaYfIxTSkSua6CgDCy/ASEnUcHSrdkoEFEatckefg5e8rW35lvA==
X-Received: by 2002:a05:6870:5d8f:b0:297:270c:575 with SMTP id 586e51a60fabf-29dc40097dbmr4622341fac.16.1732750557183;
        Wed, 27 Nov 2024 15:35:57 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de8f31cefsm109260fac.2.2024.11.27.15.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:35:56 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/4] fetch-pack: split out fsck config parsing
Date: Wed, 27 Nov 2024 17:33:11 -0600
Message-ID: <20241127233312.27710-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127233312.27710-1-jltobler@gmail.com>
References: <20241127005707.319881-1-jltobler@gmail.com>
 <20241127233312.27710-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `fetch_pack_config()` is invoked, fetch-pack configuration is
parsed from the config. As part of this operation, fsck message severity
configuration is assigned to the `fsck_msg_types` global variable. This
is optionally used to configure the downstream git-index-pack(1) when
the `--strict` option is specified.

The same parsed fsck message severity configuration is also needed
outside of fetch-pack. Instead of exposing/relying on the existing
global state, split out the fsck config parsing logic into
`fetch_pack_fsck_config()` and expose it. In a subsequent commit, this
is used to provide fsck configuration when invoking `unbundle()`.

For `fetch_pack_fsck_config()` to discern between errors and unhandled
config variables, the return code when `git_config_path()` errors is
changed to a different value also indicating success. This frees up the
previous return code to now indicate the provided config variable
was unhandled. The behavior remains functionally the same.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 fetch-pack.c | 26 ++++++++++++++++++--------
 fetch-pack.h | 11 +++++++++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index fe1fb3c1b7..c095f3a84b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1857,8 +1857,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	return ref;
 }
 
-static int fetch_pack_config_cb(const char *var, const char *value,
-				const struct config_context *ctx, void *cb)
+int fetch_pack_fsck_config(const char *var, const char *value,
+			   struct strbuf *msg_types)
 {
 	const char *msg_id;
 
@@ -1866,9 +1866,9 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 		char *path ;
 
 		if (git_config_pathname(&path, var, value))
-			return 1;
-		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
-			fsck_msg_types.len ? ',' : '=', path);
+			return 0;
+		strbuf_addf(msg_types, "%cskiplist=%s",
+			msg_types->len ? ',' : '=', path);
 		free(path);
 		return 0;
 	}
@@ -1877,14 +1877,24 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 		if (!value)
 			return config_error_nonbool(var);
 		if (is_valid_msg_type(msg_id, value))
-			strbuf_addf(&fsck_msg_types, "%c%s=%s",
-				fsck_msg_types.len ? ',' : '=', msg_id, value);
+			strbuf_addf(msg_types, "%c%s=%s",
+				msg_types->len ? ',' : '=', msg_id, value);
 		else
 			warning("Skipping unknown msg id '%s'", msg_id);
 		return 0;
 	}
 
-	return git_default_config(var, value, ctx, cb);
+	return 1;
+}
+
+static int fetch_pack_config_cb(const char *var, const char *value,
+				const struct config_context *ctx, void *cb)
+{
+	int ret = fetch_pack_fsck_config(var, value, &fsck_msg_types);
+	if (ret > 0)
+		return git_default_config(var, value, ctx, cb);
+
+	return ret;
 }
 
 static void fetch_pack_config(void)
diff --git a/fetch-pack.h b/fetch-pack.h
index b5c579cdae..9d3470366f 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -106,4 +106,15 @@ int report_unmatched_refs(struct ref **sought, int nr_sought);
  */
 int fetch_pack_fsck_objects(void);
 
+/*
+ * Check if the provided config variable pertains to fetch fsck and if so append
+ * the configuration to the provided strbuf.
+ *
+ * When a fetch fsck config option is successfully processed the function
+ * returns 0. If the provided config option is unrelated to fetch fsck, 1 is
+ * returned. Errors return -1.
+ */
+int fetch_pack_fsck_config(const char *var, const char *value,
+			   struct strbuf *msg_types);
+
 #endif
-- 
2.47.0

