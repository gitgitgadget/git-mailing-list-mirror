Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6F7F7E3
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196379; cv=none; b=eojyPQxpGFv6WuSu7gMoQzAliyA0l1OxrE5poYJMHcv3nOFlGinBgWi6lMbChsRq1HteS9z3aaRVmduoHFeoOQ5T871So5HEK19vYZf0UTbHTXO2CbQdg9+uDpwOAq2K5YQYcHCFXnTwQJDTof5XDjAScOiMqbvfwNuB9jZP9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196379; c=relaxed/simple;
	bh=4ojxVCLvl/0BVMM4BAtn7SlHZ2bqCKXcmT1eehLO8qw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XUmd6MZi+d20DV9YdkbrZf2ygiY58ooC1a4rMjvYKwXanh3KDIE8SJxFx6qvrvPmLp9K6DTRWvXU6bMjXGuQlHudrND9z71+igxnoBVkkpcUZ1vWbWtuLoRQH6T5qy8DQ6oNjEy8qOQjle793oRBASNtFPnpKQ80EjFoxe0ovi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwA1O7uk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwA1O7uk"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fdb18ffc7so15725535e9.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196375; x=1707801175; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VV0U3+FYAd67IGQzkTU0p/Z66m/307SlJ71XzJ+kPw=;
        b=UwA1O7ukTHRQxC/Rzv7KTiN/65J7Pb3N6phVLZqjuff2kseUWx9jEf20G9H/5vrmTH
         ZnxvFbt88JlJPPdHSlVKWHLDekdvo7FU213WnZhC3p/EfqvAUBg9r2DGZCuvyEgH1xsg
         bYz+7RMxPosrREdxCYlp3B6y3EwTLjwModygjMfF1sEQtKc13R5kZIMieqp7q1EYtTUf
         xeHKWl4WIIGg0SY4jgHhj+DNRlENZv3mVsYAVI6OIiae6A1aTyBebRe5YkhiceGZsXO5
         WK7/bVTeVI4dXgn8qXJFyky3OsLAdI1Kw0M7uCs55UkIqdDn0gwBoEnk2jfvylq3t+vC
         5+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196375; x=1707801175;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VV0U3+FYAd67IGQzkTU0p/Z66m/307SlJ71XzJ+kPw=;
        b=ZVtIlA1Io8mwWI/nGPG5k99THKQ32CRey5pTzMF+uieSU+DMvfxw1f1wjXMrh9HkOK
         vPdjJb8Tu5L58sXZh/TJlEScMiodf066fZz72U6TrByBPsVAI9xyGqZ/n+qaCIZHt1xz
         02dX+lNEiSzFYmxYEHTmlaF0pVL/0vXbU5PozoXfQqyLE8iCqqggXEQNRaSm5eOvh5DN
         /OZry4pnnkq39tJKp3B1bLdMLyVBoQzPACSCU/MdGjW+ZCaQlSTdy6Fa7HDy10d/JfnO
         vSU2fu25Zx/SSuzkLayVc5FAdJN7jSqEvUsFVz4SIzbELcOceHxfmrCcgnBi5AyCHYGs
         lckw==
X-Gm-Message-State: AOJu0YxYPO0iwT1If7Aku28s5un0q/cZq8Z5LkxMT0q6e7yfy0SJ3jbv
	tuFQOcc3riKZwby5D74l3LC9OjlQE2CFtEh8Cta8QjyvjCatE+HwGUL1HMcV
X-Google-Smtp-Source: AGHT+IGm1wb5jBJ7DLClnzo8U1XPC2td2KQzlUioukiCQLUqi4wZCuQMBkjETMkPgV3h+eozCZaT6g==
X-Received: by 2002:a05:600c:4fcf:b0:40e:f111:f259 with SMTP id o15-20020a05600c4fcf00b0040ef111f259mr642254wmq.37.1707196375401;
        Mon, 05 Feb 2024 21:12:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVs7ht76je91G62MrWQA2lscBNKY6j58QZfSu6Kb5qDIw7OwnO183kNUtGVsnrWs7kxcXBgd3F/ZU7nsCDuAwm9Pe+FXbJ9hlubdwIjZwtDsRmJnziPW3XiqyGqup/XoOD7rtY5YPeMxOrFh5Rzx4rQseEDUJ6rkBuQTTBtebdqSr2hzf7TDzaAHKm1uyAuw5CVXwZ2qP6eHA==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c450900b0040fa661ee82sm653438wmo.44.2024.02.05.21.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:54 -0800 (PST)
Message-ID: <26df2514acbf4d51f40f4b1b9f33a357fa424ac7.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:27 +0000
Subject: [PATCH v4 27/28] trailer_set_*(): put out parameter at the end
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

The new trailer_config_set_*() functions which were introduced a few
patches ago put the out parameter (the variable being mutated) at the
end of the parameter list.

Put the out parameter at the end for these functions for these existing
trailer_set_*() functions for consistency. This also avoids confusion
for API users because otherwise these two sets of functions look rather
similar in <trailer.h> even though they have completely different out
parameters.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  6 +++---
 trailer.c                    | 24 ++++++++++++------------
 trailer.h                    |  6 +++---
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 9657b0d067c..d0c09d1d73b 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -28,21 +28,21 @@ static int option_parse_where(const struct option *opt,
 			      const char *arg, int unset UNUSED)
 {
 	/* unset implies NULL arg, which is handled in our helper */
-	return trailer_set_where(opt->value, arg);
+	return trailer_set_where(arg, opt->value);
 }
 
 static int option_parse_if_exists(const struct option *opt,
 				  const char *arg, int unset UNUSED)
 {
 	/* unset implies NULL arg, which is handled in our helper */
-	return trailer_set_if_exists(opt->value, arg);
+	return trailer_set_if_exists(arg, opt->value);
 }
 
 static int option_parse_if_missing(const struct option *opt,
 				   const char *arg, int unset UNUSED)
 {
 	/* unset implies NULL arg, which is handled in our helper */
-	return trailer_set_if_missing(opt->value, arg);
+	return trailer_set_if_missing(arg, opt->value);
 }
 
 static int option_parse_trailer(const struct option *opt,
diff --git a/trailer.c b/trailer.c
index b0b067ab12c..7b0bdfcb27e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -380,7 +380,7 @@ void process_trailers_lists(struct list_head *head,
 	}
 }
 
-int trailer_set_where(enum trailer_where *item, const char *value)
+int trailer_set_where(const char *value, enum trailer_where *item)
 {
 	if (!value)
 		*item = WHERE_DEFAULT;
@@ -397,7 +397,7 @@ int trailer_set_where(enum trailer_where *item, const char *value)
 	return 0;
 }
 
-int trailer_set_if_exists(enum trailer_if_exists *item, const char *value)
+int trailer_set_if_exists(const char *value, enum trailer_if_exists *item)
 {
 	if (!value)
 		*item = EXISTS_DEFAULT;
@@ -416,7 +416,7 @@ int trailer_set_if_exists(enum trailer_if_exists *item, const char *value)
 	return 0;
 }
 
-int trailer_set_if_missing(enum trailer_if_missing *item, const char *value)
+int trailer_set_if_missing(const char *value, enum trailer_if_missing *item)
 {
 	if (!value)
 		*item = MISSING_DEFAULT;
@@ -520,18 +520,18 @@ static int git_trailer_default_config(const char *conf_key, const char *value,
 	variable_name = strrchr(trailer_item, '.');
 	if (!variable_name) {
 		if (!strcmp(trailer_item, "where")) {
-			if (trailer_set_where(&default_trailer_conf.where,
-					      value) < 0)
+			if (trailer_set_where(value,
+					      &default_trailer_conf.where) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "ifexists")) {
-			if (trailer_set_if_exists(&default_trailer_conf.if_exists,
-						  value) < 0)
+			if (trailer_set_if_exists(value,
+						  &default_trailer_conf.if_exists) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "ifmissing")) {
-			if (trailer_set_if_missing(&default_trailer_conf.if_missing,
-						   value) < 0)
+			if (trailer_set_if_missing(value,
+						   &default_trailer_conf.if_missing) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "separators")) {
@@ -600,15 +600,15 @@ static int git_trailer_config(const char *conf_key, const char *value,
 		conf->cmd = xstrdup(value);
 		break;
 	case TRAILER_WHERE:
-		if (trailer_set_where(&conf->where, value))
+		if (trailer_set_where(value, &conf->where))
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	case TRAILER_IF_EXISTS:
-		if (trailer_set_if_exists(&conf->if_exists, value))
+		if (trailer_set_if_exists(value, &conf->if_exists))
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	case TRAILER_IF_MISSING:
-		if (trailer_set_if_missing(&conf->if_missing, value))
+		if (trailer_set_if_missing(value, &conf->if_missing))
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	default:
diff --git a/trailer.h b/trailer.h
index af55032625d..4193bedbae4 100644
--- a/trailer.h
+++ b/trailer.h
@@ -28,9 +28,9 @@ enum trailer_if_missing {
 	MISSING_DO_NOTHING
 };
 
-int trailer_set_where(enum trailer_where *item, const char *value);
-int trailer_set_if_exists(enum trailer_if_exists *item, const char *value);
-int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
+int trailer_set_where(const char *, enum trailer_where *);
+int trailer_set_if_exists(const char *, enum trailer_if_exists *);
+int trailer_set_if_missing(const char *, enum trailer_if_missing *);
 
 void trailer_set_conf_where(enum trailer_where, struct trailer_conf *);
 void trailer_set_conf_if_exists(enum trailer_if_exists, struct trailer_conf *);
-- 
gitgitgadget

