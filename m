Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBD5A114
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308744; cv=none; b=YDJaj5HZcqnAwhVYFYJ9Nphee7vP8x8CCq20z29aLrBZESrDxKSY93xkSY/wySc22hrHUm3GuA0wCy0QLNo5QJxZedjEREWCA1AQ7mYKrhjMFhKxxmGfbltWGndyTb+cuZU7aKLT9N4/LFgcuy9vqZGzeAkuGRxELHzHAQJLCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308744; c=relaxed/simple;
	bh=KMW1tqjXZbth0lWetno8Vmnfqr0/CaaAJxAZ8SfCCzU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oOBR5qI6UGN05LtKflPTUctuCkhvEJOjy+rXwai8Zd3AodTkSmVUUK0+CdxTaBlaURtFW7L+R4rI9yS80FaddQHfmnbT+FCBPbdFWfkt/Rs0eKBcZP2n1sM0VUzXtq54B3kBOWSgc5wbqelE1YFE5o8WgGanHpo6lQJXD6rVX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeCtEDTq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeCtEDTq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso13754365e9.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706308740; x=1706913540; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMYYWuGCHsrryvcyEzP3kmo0QRvFaMyqF3XKpAYLOvo=;
        b=DeCtEDTqdHksgZzrtuclvWbjhxKcA/FOVtlWnvH8PrXegBCDzg8HCurC7LHXovFGcr
         +LSK+p2pwIJlSPUNqJ2d0TEmHPPs7KTbQIMiXJKV1RP/Qr3ofqWRNgIsXa8nSmS0lwpz
         CR9s4D8ZxgS++tjnsGN8cAJ6p7FKuzf4kMyrdvWkq7cZN0ZOHWCsr/slykX4YYkwOYlE
         q1x9E7RgC300UyZg/x5H062XBsMQJsN1icx/MM4NUs8mXdgZeDs/u8Rq5WVL8mnS0Qb+
         vXx2RtDEeZ7DAPM6LUc5RW8bF8kTSQkX2c5+Cnza8BqRUtm294ZyK4wHoGfuo45cKolN
         xx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308740; x=1706913540;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMYYWuGCHsrryvcyEzP3kmo0QRvFaMyqF3XKpAYLOvo=;
        b=uwhdhDpBMj4hl+y4sEf+U5bm7953aPFY7R5Qtz5gsqQCvAKfnVlf4hNw8HcOb2Wz2j
         g4/DcIgAx4ktszdjSxCn0FF3JBnI6potnjFQyCyXWN9OGOV77SSkgz42ZoXuDTrxTCHA
         XdWZTsU8s+sYDTN4cRxSFsbY7YsV7LJUTm34qsyZrhuzJZeMu22qfpCWm73aX2NljDyd
         wYXwRRKAPU2VI7l8/3ZR37x9xM2nfO2R4FZXeP18bXgkmLWNuCQSYtb5d5Pi54QWqXnR
         T/Z8EfinHCITmFhArtNUVfiVzxDxxrrxSt/1UxwzyBhN+7gKmJEd7jS4gLoULTVeCpSY
         8L8w==
X-Gm-Message-State: AOJu0YyWoJgTexulcDdcZUlYSiziOVeYfgEgTEBxalG25N5Qt6/gCmiR
	3eme1o7IlRi7IceIEz3UupX5CrXrYBZtqKTXXZhzZs+FQMzROqfNJytkFx4Z
X-Google-Smtp-Source: AGHT+IGgle1El6pzSuZGE21IwdmBrLVjDuDZkj/URaL0lYmleWUYoEZlflA8iNXbumFGZ2ILFKL6BA==
X-Received: by 2002:a1c:7c0b:0:b0:40e:e4d3:473e with SMTP id x11-20020a1c7c0b000000b0040ee4d3473emr319778wmc.64.1706308740134;
        Fri, 26 Jan 2024 14:39:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c1c1600b0040e7306f655sm3034010wms.22.2024.01.26.14.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:38:59 -0800 (PST)
Message-ID: <e2d3ed9b5b6d67273c22671374daf7695c67709f.1706308737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 22:38:48 +0000
Subject: [PATCH v2 01/10] trailer: prepare to expose functions as part of API
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

In the next patch, we will move "process_trailers" from trailer.c to
builtin/interpret-trailers.c. That move will necessitate the growth of
the trailer.h API, forcing us to expose some additional functions in
trailer.h.

Rename relevant functions so that they include the term "trailer" in
their name, so that clients of the API will be able to easily identify
them by their "trailer" moniker, just like all the other functions
already exposed by trailer.h.

The the opportunity to start putting trailer processions options (opts)
as the first parameter. This will be the pattern going forward in this
series.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  4 ++--
 trailer.c                    | 26 +++++++++++++-------------
 trailer.h                    |  6 +++---
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 033bd1556cf..85a3413baf5 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -132,11 +132,11 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
-			process_trailers(argv[i], &opts, &trailers);
+			interpret_trailers(&opts, &trailers, argv[i]);
 	} else {
 		if (opts.in_place)
 			die(_("no input file given for in-place editing"));
-		process_trailers(NULL, &opts, &trailers);
+		interpret_trailers(&opts, &trailers, NULL);
 	}
 
 	new_trailers_clear(&trailers);
diff --git a/trailer.c b/trailer.c
index 3a0710a4583..66b6660f5a4 100644
--- a/trailer.c
+++ b/trailer.c
@@ -163,12 +163,12 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void print_all(FILE *outfile, struct list_head *head,
-		      const struct process_trailer_options *opts)
+static void format_trailers(const struct process_trailer_options *opts,
+			    struct list_head *trailers, FILE *outfile)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
-	list_for_each(pos, head) {
+	list_for_each(pos, trailers) {
 		item = list_entry(pos, struct trailer_item, list);
 		if ((!opts->trim_empty || strlen(item->value) > 0) &&
 		    (!opts->only_trailers || item->token))
@@ -589,7 +589,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	return 0;
 }
 
-static void ensure_configured(void)
+static void trailer_config_init(void)
 {
 	if (configured)
 		return;
@@ -1035,10 +1035,10 @@ static void parse_trailers(struct trailer_info *info,
 	}
 }
 
-static void free_all(struct list_head *head)
+static void free_trailers(struct list_head *trailers)
 {
 	struct list_head *pos, *p;
-	list_for_each_safe(pos, p, head) {
+	list_for_each_safe(pos, p, trailers) {
 		list_del(pos);
 		free_trailer_item(list_entry(pos, struct trailer_item, list));
 	}
@@ -1075,16 +1075,16 @@ static FILE *create_in_place_tempfile(const char *file)
 	return outfile;
 }
 
-void process_trailers(const char *file,
-		      const struct process_trailer_options *opts,
-		      struct list_head *new_trailer_head)
+void interpret_trailers(const struct process_trailer_options *opts,
+			struct list_head *new_trailer_head,
+			const char *file)
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct trailer_info info;
 	FILE *outfile = stdout;
 
-	ensure_configured();
+	trailer_config_init();
 
 	read_input_file(&sb, file);
 
@@ -1110,9 +1110,9 @@ void process_trailers(const char *file,
 		process_trailers_lists(&head, &arg_head);
 	}
 
-	print_all(outfile, &head, opts);
+	format_trailers(opts, &head, outfile);
 
-	free_all(&head);
+	free_trailers(&head);
 	trailer_info_release(&info);
 
 	/* Print the lines after the trailers as is */
@@ -1135,7 +1135,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 	size_t nr = 0, alloc = 0;
 	char **last = NULL;
 
-	ensure_configured();
+	trailer_config_init();
 
 	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
 	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
diff --git a/trailer.h b/trailer.h
index 1644cd05f60..37033e631a1 100644
--- a/trailer.h
+++ b/trailer.h
@@ -81,9 +81,9 @@ struct process_trailer_options {
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
 
-void process_trailers(const char *file,
-		      const struct process_trailer_options *opts,
-		      struct list_head *new_trailer_head);
+void interpret_trailers(const struct process_trailer_options *opts,
+			struct list_head *new_trailer_head,
+			const char *file);
 
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts);
-- 
gitgitgadget

