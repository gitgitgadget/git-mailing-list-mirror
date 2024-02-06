Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF67A737
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196375; cv=none; b=PHnHQuwmZVh2IsjRnwBUWyXlpaH2RwOG43ro48+2ibTkKfsXPycVgJn+PPqzd58ai+YdoFGu9Tm2rCCBR8s9ubWuJ4CR55bEXR2nb1lE0u4msCTfNjL2dn/aOGplUM0rjXlno4/GZMDz0bAjxbQkS873I+sejnmDOGWN3oOL53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196375; c=relaxed/simple;
	bh=Tvoc962DK84h7XfF7yeSpNbE+8NFwvB32afkrqbKmWQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OpnQH4lW+6azrurUTqi1u0kaDaWMReaAo08L6uI5THNI/scqdMdUy45G14Vw3jYgZ8qFMMi21YRe4kwdWWpJ5gs+7g9ZiK1tVN0sG9b2gKJQnEahLXxyVE1ouHWHxPjA1LjP19h2j7A/vOvCUGO6j2MxLqhfboqIEhwcFVQtF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byEBuUjF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byEBuUjF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fc654a718so32916145e9.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196371; x=1707801171; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6+NQd5nEV2eczt7YhKu1bosuM3eQgb4jedizSfu40Q=;
        b=byEBuUjF/ISZGM22BgQrt6dQcK3hN0zaQ9WB9tGhNOzGAgT/76ggtL4ZVWPEwiDNEz
         cV7hvKzhWmlWBsqdOs01vp3Rquko5HdTCzHoapd4s8D3DPwjsV5pLUSpo56RWp07dsZU
         mJAn1nxydwUPMInANbuMhoJg9f3/Fm9THgt0rpQndsgTfvDKsDLAmKAZkXGxIG69oZjM
         Qgdyyl8o1PYaJOOxIUkHRucQtcb+VSn/RjJar8oT4YQ9+syE0ozXtHUtxayDj8KIGmb1
         tCyLpjchjz/HSFbh1t5h86N8zEilHa7mtrAuV7gn7OqxGP5Jv7vqHr3wc3SYuqwA4ohY
         f7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196371; x=1707801171;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6+NQd5nEV2eczt7YhKu1bosuM3eQgb4jedizSfu40Q=;
        b=FcHoqPzHcWBAoL2//c2D+6wEBEiojo+qQ/dLyDJPvRpzPMxoLSJ5boFJCdH4It6P8g
         h+gbgcYb7o5xdn1/Xd2gM7LwSlmwnTXQO66xrxi0VIFD5wRfLHIuaDJzKH6wCIGjzXYp
         9NeaJ1XzmU4L1iviwkIEQP465VxbqXMhm+ZazQwxyNVgpNsmH84aU1usaJsTa8BpGiUM
         +TWp45wiqQG9bH4wdN+/d685UfzyxIU3i37Bnj4q0BeQT9hCNDcxnXGK6U/4Zgivm/47
         QnrqOj0CpT8seO9AoobSUpEKppfZmMFtCVJ5LgLwCi5CjEHUqnSAvE2kZXQ6Zh98DRsU
         RnqQ==
X-Gm-Message-State: AOJu0YxL/efoNr/VJdVZFPhMD465Dq0i4o8mcSmMZZcTeiyVZkUz5EXl
	fwBeYX0ZMocxKjfrewfNSe0Qx4v+tXxbPa9UFGcctc0dN5HECc821DKBy33/
X-Google-Smtp-Source: AGHT+IGvadSFOuQU9a2UtKEBxhCF2XPtFxEqNXaU+NfleMDKZXtk+tvvYw6R4Zv34p8i4sXCHIIJoA==
X-Received: by 2002:a05:600c:4f54:b0:40f:dc51:1882 with SMTP id m20-20020a05600c4f5400b0040fdc511882mr1237560wmq.8.1707196371539;
        Mon, 05 Feb 2024 21:12:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXwzzUgqL7ob/r4BFIskt6377vcv9kBRwN4+HAjjawIxtmaPkOIv3+7KhL7y6bbwBPydP1/kCZQLKaW1wxL0V1rAVayzTrdqzpiHdTuEpIxcUNPLPHlvSFaAFA37TZ7IbRIEb5v7/E0IUYADCRWiFb1P9eAM1thiObsA1L6b9FU6giJq3Gn8w8MXFZtKLpwvBBS+bfI4Gi0Nw==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b0040ee8765901sm641415wmo.43.2024.02.05.21.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:51 -0800 (PST)
Message-ID: <3bfe4809ecbc5aa0ea52daee7684289398cb88d4.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:23 +0000
Subject: [PATCH v4 23/28] trailer: add new helper functions to API
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

This is a preparatory refactor for deprecating "new_trailer_item" from
the API (which will let us deprecate
parse_trailers_from_command_line_args()).

Expose new helper functions from the API, because we'll be calling them
from interpret-trailers.c soon when we move
parse_trailers_from_command_line_args() there.

Move free_new_trailers() from the builtin to trailer.c because later on
we will adjust it to free arg_item structs, which are private to
trailer.c.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 12 ---------
 trailer.c                    | 49 ++++++++++++++++++++++++++++++++++++
 trailer.h                    |  8 ++++++
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index f674b5f4b9e..9169c320921 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -45,18 +45,6 @@ static int option_parse_if_missing(const struct option *opt,
 	return trailer_set_if_missing(opt->value, arg);
 }
 
-static void free_new_trailers(struct list_head *trailers)
-{
-	struct list_head *pos, *tmp;
-	struct new_trailer_item *item;
-
-	list_for_each_safe(pos, tmp, trailers) {
-		item = list_entry(pos, struct new_trailer_item, list);
-		list_del(pos);
-		free(item);
-	}
-}
-
 static int option_parse_trailer(const struct option *opt,
 				   const char *arg, int unset)
 {
diff --git a/trailer.c b/trailer.c
index 3b8f0ba103c..9b8cb94c021 100644
--- a/trailer.c
+++ b/trailer.c
@@ -66,6 +66,11 @@ static LIST_HEAD(conf_head);
 
 static char *separators = ":";
 
+const char *trailer_default_separators(void)
+{
+	return separators;
+}
+
 static int configured;
 
 #define TRAILER_ARG_STRING "$ARG"
@@ -424,6 +429,29 @@ int trailer_set_if_missing(enum trailer_if_missing *item, const char *value)
 	return 0;
 }
 
+void trailer_set_conf_where(enum trailer_where where,
+			    struct trailer_conf *conf)
+{
+	conf->where = where;
+}
+
+void trailer_set_conf_if_exists(enum trailer_if_exists if_exists,
+				struct trailer_conf *conf)
+{
+	conf->if_exists = if_exists;
+}
+
+void trailer_set_conf_if_missing(enum trailer_if_missing if_missing,
+				 struct trailer_conf *conf)
+{
+	conf->if_missing = if_missing;
+}
+
+struct trailer_conf *new_trailer_conf(void)
+{
+	 return xcalloc(1, sizeof(struct trailer_conf));
+}
+
 void duplicate_trailer_conf(struct trailer_conf *dst,
 			    const struct trailer_conf *src)
 {
@@ -434,6 +462,15 @@ void duplicate_trailer_conf(struct trailer_conf *dst,
 	dst->cmd = xstrdup_or_null(src->cmd);
 }
 
+void free_trailer_conf(struct trailer_conf *conf)
+{
+	free(conf->name);
+	free(conf->key);
+	free(conf->command);
+	free(conf->cmd);
+	free(conf);
+}
+
 static struct arg_item *get_conf_item(const char *name)
 {
 	struct list_head *pos;
@@ -1076,6 +1113,18 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
+void free_new_trailers(struct list_head *trailers)
+{
+	struct list_head *pos, *tmp;
+	struct new_trailer_item *item;
+
+	list_for_each_safe(pos, tmp, trailers) {
+		item = list_entry(pos, struct new_trailer_item, list);
+		list_del(pos);
+		free(item);
+	}
+}
+
 size_t trailer_block_start(struct trailer_block *trailer_block)
 {
 	return trailer_block->start;
diff --git a/trailer.h b/trailer.h
index f80f8f7e63f..a2569c10451 100644
--- a/trailer.h
+++ b/trailer.h
@@ -46,8 +46,14 @@ struct new_trailer_item {
 	enum trailer_if_missing if_missing;
 };
 
+void trailer_set_conf_where(enum trailer_where, struct trailer_conf *);
+void trailer_set_conf_if_exists(enum trailer_if_exists, struct trailer_conf *);
+void trailer_set_conf_if_missing(enum trailer_if_missing, struct trailer_conf *);
+
+struct trailer_conf *new_trailer_conf(void);
 void duplicate_trailer_conf(struct trailer_conf *dst,
 			    const struct trailer_conf *src);
+const char *trailer_default_separators(void);
 void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
 			  const struct trailer_conf *conf,
 			  const struct new_trailer_item *new_trailer_item);
@@ -98,6 +104,8 @@ void format_trailers(const struct process_trailer_options *,
 		     struct list_head *trailers,
 		     struct strbuf *out);
 void free_trailers(struct list_head *);
+void free_new_trailers(struct list_head *);
+void free_trailer_conf(struct trailer_conf *);
 
 /*
  * Convenience function to format the trailers from the commit msg "msg" into
-- 
gitgitgadget

