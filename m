Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D64C65
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664151; cv=none; b=MgmZrfbrOHcyD2cEjrJvqoJwKwwQfSm5NzRS8l65A3wqM2r5Ry+TFRjUAPn7cn3K+GwjG8Qr49IuXwcuM8ZS8sXkZRgewxQI0527/yAOqpyD4Z3IyPUV620bl/vN1DLeg2J+iPK8Oiq+f77CmG7ksuO30kQsIQfAZtoVg94Tma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664151; c=relaxed/simple;
	bh=41r7PyiCZ1fDLegsVKVWLPkEUtwrHbG/GjkW2IVO+wI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=evlBEjJMwNtL9GhmIfTt2FYg5JlIkIgJbTIi8+TFT0kGShmzj+1HPZZ7pEYSg83iCJeRvwKZy5AJ5KOGxd7+Koss17xBuOCLYLnmBJiS0zYGQJ1dw8F+3KaQD7FS8a21ylcZldrWN1DuSDGBNGpL5KAX5L7H8R4apidiWNDk61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5jEGBTo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5jEGBTo"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so52122775e9.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 17:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706664147; x=1707268947; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDdnOUpJoMEuaedPN4FKCmqtCLWzz2GOErCRujlaI1M=;
        b=T5jEGBTofIfQY12EFlxSwB3QycxHacGxmIdaH2e0yIb4+21cG6+jBXDtyN23t7S0Z1
         gWBOcwWWlB4Y3xOjBFRN/nIV3RNHi+00w6eH4xS2V2pYvFoZVhgNn7k1lM1aW4gc4+ZA
         Mq0uSzzgttwND2XaX8QxVKPJFBMlQngZio5W7/Ya9xGFgzUP3LJ7HwxIfRRHJ6qPEp1h
         GW+hGMNxxqEvn9oAYAQEAvhPGtiehwXX3wFOkzIORPluR3lsiGCEn/EcLAWDhcRBiGUh
         6JBlK1qlLBz3/mxVEa0RXb5cBYXJSHRO9zvK81nxYiat7k7CVLuzWEUVXBpvqB9m8XY1
         5e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706664147; x=1707268947;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDdnOUpJoMEuaedPN4FKCmqtCLWzz2GOErCRujlaI1M=;
        b=P7MydjExSAGt3Obfs4nTqVoiyD21nNbCkCF+EHh/Nx+hkOAQ2ICY7fIkJ7dO0C6DUd
         YVgzI7Lo6Nz+Q4DruYxAkrdfrefTUwHBE3UUxdRhtYicVc6FopWHs+48A9dnu99AIQi9
         Rq/Of+Y74RW4eYwFPRYeLgns5G8U5g/pjf8P9TrWj2Xyoedt5sS0wX4fWyvCzIammmA7
         /etkXvfpIu4ccSW9BlDmsL3okROyhvPdFPAKScjH7xBiY9CGX/mcVN5DrV7rYdjbBrh0
         NiuS3AzzUPFH+3lDA+nb2eIvbhtPZcaKCWqA+QPB6+ocP+ZtQ8NV0SPR8x4CyiJII3dw
         ygLg==
X-Gm-Message-State: AOJu0YwYos+leQ1EypQQ1fN5ikW/p+ma/8IC//Bt746fjWDJ1tjAXWCY
	Ef2tIuBtSVG7PkGyQc0RKIcFlLGHwPnf2aDt5xgjxLkjKf9M97W1Yb06WZF1
X-Google-Smtp-Source: AGHT+IHlSXExND+Nw1c2uvLr7q3LHWCrATIes/3P3cqMPy3IxU/vPxZN9YElDQtbMtgGJUc9wWAf6g==
X-Received: by 2002:a05:600c:558a:b0:40f:5c3a:bbb0 with SMTP id jp10-20020a05600c558a00b0040f5c3abbb0mr121821wmb.23.1706664147518;
        Tue, 30 Jan 2024 17:22:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cx16-20020a056000093000b00337d5cd0d8asm11950585wrb.90.2024.01.30.17.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:22:27 -0800 (PST)
Message-ID: <72cc12a306660dde0a09c042160df20b624f785a.1706664145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 01:22:15 +0000
Subject: [PATCH v3 01/10] trailer: prepare to expose functions as part of API
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

Take the opportunity to start putting trailer processions options (opts)
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

