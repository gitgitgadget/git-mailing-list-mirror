Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D2381F462
	for <e@80x24.org>; Sat,  1 Jun 2019 00:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfFAAgj (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 20:36:39 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:41501 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFAAgi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 20:36:38 -0400
Received: by mail-ot1-f74.google.com with SMTP id z1so5342570oth.8
        for <git@vger.kernel.org>; Fri, 31 May 2019 17:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qiiN5fs489IzftRbt2WCr2seLgQznoLRsCHpc6K/kbQ=;
        b=YuJtg2dpZn9NphL5+k7iGUgTOuRAaicMX7A3WvvEpwl3ykedgWUfwZ+sMmr701us/1
         5TwHvko1vJZSMXDqIrt6N0wDhTNTJ5Nt9YBi4x4b8IaJmuswqLS4YT2ROyxPy+Kz5+Cr
         yICtD0kwa2dAcacyYj19L8Yq5bpJCzIslKdYK2/cvBgRNgSGDv8jbM4AKrCn/5PvuVMt
         8Vw4LqFce3XJ4Rf84vw18gdhUmHQyqqcQNp4YiCll0Iyr9/OYkQ9bWKXuRme9r2ynjBj
         3/+gbzCA1PvHGM3oj6ZQuiMt2rQFM3HZFATxmeI5zCE+vkXhXPUKfRQrGI5IAGM+mGhz
         dzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qiiN5fs489IzftRbt2WCr2seLgQznoLRsCHpc6K/kbQ=;
        b=A6Y+dXfTUEzedpjHIFYXajDORVL3JDHU5Uspo45MrTcZ7Nnq0lwHyJ/ZnpP0m9UYMj
         a7mquMkNk/Kr3hT0NS9FH/NnioQGTMwZV1oqbNB84jk9ZtkewKzq/mF3wNnlM2L9NT8b
         2eYxYACVlUW1CtPgzyFAUVgR7ClKauexZzaKgAO6Q6O5sVUC6FXeJkDXvAwHujDeAC5Q
         hfD2CEif63nJY1spIyI6HqCBWqoWYBdRZmHsqZ6RwISLPLXie3ilt+LapYNsxgnIwx+s
         ww6nB9fHMCicHl5m044qS5LtFMPx2k+I1aOt3VH46DPZHgl7k3giH2FHOmoRQTWasN6Y
         6Rtg==
X-Gm-Message-State: APjAAAUcMvXHPL7x9V1v62BfOPwa4HSIEaIfDPoU2HhYONCSyGN3yb9O
        CdcXrJyTjOFh+DjI2/NeGI0lLq+PdAROTl0OveggS3eXHk+ctKyy12u2x6P/BEAUI57prPzv6h7
        ylUNn069ws/rDSBaCdLyt/y5osC0nhdmIT9cbMtDdRGd1OjFWVepHQcoTDx4=
X-Google-Smtp-Source: APXvYqxJ7/WTb1MRdwkhycyZ57q6zdM7Tic4yjcsJ2xBY55EfJ5XjyoKReXpA0xhNVqOBX2CSThVDbAeslik
X-Received: by 2002:aca:5209:: with SMTP id g9mr91242oib.35.1559349398139;
 Fri, 31 May 2019 17:36:38 -0700 (PDT)
Date:   Fri, 31 May 2019 17:36:03 -0700
In-Reply-To: <20190601003603.90794-1-matvore@google.com>
Message-Id: <20190601003603.90794-10-matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2 9/9] list-objects-filter-options: make parser void
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function always returns 0, so make it return void instead.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 12 +++++-------
 list-objects-filter-options.h |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index d8abe6cfcf..ed02c88eb6 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -247,21 +247,21 @@ static void transform_to_combine_type(
 	strbuf_release(&filter_options->sub[0].filter_spec);
 }
 
 void list_objects_filter_die_if_populated(
 	struct list_objects_filter_options *filter_options)
 {
 	if (filter_options->choice)
 		die(_("multiple filter-specs cannot be combined"));
 }
 
-int parse_list_objects_filter(
+void parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg)
 {
 	struct strbuf errbuf = STRBUF_INIT;
 	int parse_error;
 
 	if (!filter_options->choice) {
 		strbuf_init(&filter_options->filter_spec, 0);
 		strbuf_addstr(&filter_options->filter_spec, arg);
 
@@ -280,34 +280,32 @@ int parse_list_objects_filter(
 			     filter_options->filter_spec.buf);
 		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 			      filter_options->sub_alloc);
 
 		parse_error = gently_parse_list_objects_filter(
 			&filter_options->sub[filter_options->sub_nr - 1], arg,
 			&errbuf);
 	}
 	if (parse_error)
 		die("%s", errbuf.buf);
-	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
 
-	if (unset || !arg) {
+	if (unset || !arg)
 		list_objects_filter_set_no_filter(filter_options);
-		return 0;
-	}
-
-	return parse_list_objects_filter(filter_options, arg);
+	else
+		parse_list_objects_filter(filter_options, arg);
+	return 0;
 }
 
 void expand_list_objects_filter_spec(
 	const struct list_objects_filter_options *filter,
 	struct strbuf *expanded_spec)
 {
 	strbuf_init(expanded_spec, 0);
 	if (filter->choice == LOFC_BLOB_LIMIT)
 		strbuf_addf(expanded_spec, "blob:limit=%lu",
 			    filter->blob_limit_value);
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index f8c8a624e4..2c0ce6383a 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -67,21 +67,21 @@ void list_objects_filter_die_if_populated(
 	struct list_objects_filter_options *filter_options);
 
 /*
  * Parses the filter spec string given by arg and either (1) simply places the
  * result in filter_options if it is not yet populated or (2) combines it with
  * the filter already in filter_options if it is already populated. In the case
  * of (2), the filter specs are combined as if specified with 'combine:'.
  *
  * Dies and prints a user-facing message if an error occurs.
  */
-int parse_list_objects_filter(
+void parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg);
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
 	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
 	  N_("object filtering"), 0, \
 	  opt_parse_list_objects_filter }
-- 
2.17.1

