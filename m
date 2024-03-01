Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530CDED8
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252095; cv=none; b=MuwfiddD8IddB0CZuCcyfTjJrGZk9Sh5HRlPNd/5L2g0im+0PcwqqjU9tj5id1xAsDDi1jYNLnGb48T7yAEBwQgLsktGBoOiWWQpBwtPJ/Gc/tNo8Ropj1wSoBE0sFMztC3Js6pkoXdqU2PXXgE00JSpAaeguRZ3nMny/cz/8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252095; c=relaxed/simple;
	bh=KrgqE/DqtBdnF5UcVUcyQPPUaEPega7CNl+eGmY8ISs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZFS3FwJ5m/u8wi1MnhZ8eTj6FCC6h46u/oMz86A8KCscKcFhyzDdabFFWW/6kyUXqe0xYpBuisRVShQovUX04cNvpXRZhfkgLdGBwxBLJKsv011LUY625Wx9wTsS/ie1QE9kbeu5pXmHjLi3nZ7BddgfDNopfPHgXKLR9BrH01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4HIBtBD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4HIBtBD"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d220e39907so20125451fa.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252091; x=1709856891; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zubBGtsYBdmw3zY1wlEueEZhB+/ZFVqVRx3Jc2MCUBE=;
        b=H4HIBtBD2mG9V0v5WROkbqWpEmYuTfnRQBLK6YC3J9wPb9QZrIlDtNifecjRZ5/3L2
         XjmzEnlE52s6ijzwnvYI5B3rg4UfNKTz9ua8NVZ/SWjrZrfaxePtSH0scTiuEucelaKA
         rWiAT+N3xzK6ofH1hscsv9/38oeS2yLyzDGYavurS03YAtdsySe7gnxlvdPNfYKubjx0
         odWhW3mPQbvUKYF06HG8T7HXQwHR7Ek2F6cOC9J2u2HF7A/SklT/tna++RixPjmRVpUt
         D8ZvYACqqP63BPwz2ICnBumQhkbIPtbBFETgMysN3E8NNcSApcDPJKgM9OJKNRJZUkrB
         saLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252091; x=1709856891;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zubBGtsYBdmw3zY1wlEueEZhB+/ZFVqVRx3Jc2MCUBE=;
        b=qN1is+8kyswKSAdtk0wjUTAFPZfl9knxUHHe27kam0muelwsJXElCza1KznYqkMHIa
         uDwKcWAcrLK24MNGYR+ZoGqOVGHNqjXSWWMh3RXH89ADAkTzsgrO32BZeWhMJQeKqrWQ
         GTrIcVB6vAyCwCcDk3VinmBtRU1Gxpw/Zz4D99qZ0MkRLuHMT6oOSx29xhjLQZuIZlo3
         +m7+rTh+ebMmyjp6L/QcMONxSvK1kNd5yg5p67GOlJTpE5n+ZXNhL2kYVgAVOQTqf7x7
         0xWuZV5Y9FsIw6ZVBKaLzw9qETiTaZxHwJ5asNUk6MUr1iVjk8WJFhsWFqJVe3TR5N6e
         FeMA==
X-Gm-Message-State: AOJu0Yyzuk85f7wTQW2ebLgt/h2XsmqD7Jjce3RcNLNGIp2xrxWJ1hId
	8zIOxXzc2UVhHd7upf4gcQ+L3IBMavjCydpBTsLjL/EqwIYlLJyUQBIQ0Kq2
X-Google-Smtp-Source: AGHT+IF4wlug6PkQ5GBUlQyZ/jW/qhKOB8v+FHvFBcuDFQ779PD6ejTPXBe1VTOzTgXVWZDN/gxBqA==
X-Received: by 2002:a05:651c:507:b0:2d2:f5fa:f37e with SMTP id o7-20020a05651c050700b002d2f5faf37emr3121549ljp.51.1709252090603;
        Thu, 29 Feb 2024 16:14:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jj2-20020a05600c6a0200b004120537210esm6564678wmb.46.2024.02.29.16.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:14:49 -0800 (PST)
Message-ID: <7b1d739cddb3b7e974ccb8d05d99e5fc8df61910.1709252086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 Mar 2024 00:14:40 +0000
Subject: [PATCH v6 3/9] trailer: rename functions to use 'trailer'
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Rename process_trailers() to interpret_trailers(), because it matches
the name for the builtin command of the same name
(git-interpret-trailers), which is the sole user of process_trailers().

In a following commit, we will move "interpret_trailers" from trailer.c
to builtin/interpret-trailers.c. That move will necessitate the growth
of the trailer.h API, forcing us to expose some additional functions in
trailer.h.

Rename relevant functions so that they include the term "trailer" in
their name, so that clients of the API will be able to easily identify
them by their "trailer" moniker, just like all the other functions
already exposed by trailer.h.

Rename `struct list_head *head` to `struct list_head *trailers` because
"head" conveys no additional information beyond the "list_head" type.

Reorder parameters for format_trailers_from_commit() to prefer

    const struct process_trailer_options *opts

as the first parameter, because these options are intimately tied to
formatting trailers. Parameters like `FILE *outfile` should be last
because they are a kind of 'out' parameter, so put such parameters at
the end. This will be the pattern going forward in this series.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
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
index f74915bd8cd..916175707d8 100644
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
 
@@ -1110,8 +1110,8 @@ void process_trailers(const char *file,
 		process_trailers_lists(&head, &arg_head);
 	}
 
-	print_all(outfile, &head, opts);
-	free_all(&head);
+	format_trailers(opts, &head, outfile);
+	free_trailers(&head);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
@@ -1134,7 +1134,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
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

