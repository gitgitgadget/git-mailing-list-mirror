Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5BC1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfFMVwE (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:52:04 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:39213 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMVwD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:52:03 -0400
Received: by mail-qt1-f202.google.com with SMTP id o16so380004qtj.6
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aYRjU+VtLAT4CwguiRL6c0SmVrJoxBeFMrrCc2kau/U=;
        b=AJhbtnWinlwua/HYfo9MQh7HbsBFrxLOPCuTsbT/32u4SUpKxOBUfDJ+SfY8xHdrTa
         WNw8RF8eew//LqtTDWe+idEjiJ5IOBRheQlfkg4xpbujfX59GjMxqwocl6MB6PQrfzzz
         9DCoH/mBMiY6iLHN2Tx3gK4NSGFVOT7L2Ll57W1pQH6UnVVeDrh5o3f2oTMk5NjxVi2o
         WYMuuHNMPou1nF4djs+Gd+TK0ijX68yfp6FTMoJGXwCrvQXgmejIdHQJ2nAyW99JIO6T
         3jzQu5D/KhUy37Nsrz7PVQq2CHjFGqRnHH6S/0/VtV0I9v2eAU8drXQSQ3vF01AF+7Hs
         Ywlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aYRjU+VtLAT4CwguiRL6c0SmVrJoxBeFMrrCc2kau/U=;
        b=byA0SIfmoAIypuowUkpLGHNK2hVYCAfj52kXYjwZGvFAe+KI5soZdLrfSpm7TKHhKv
         ph60QwKof+as5S/Uwyr5T+68c+LMyQ1zIvTFAxVEBuNGpTUenDOCQKoCeZhcL4i3vUtO
         8VJRKObljU4cKcTYE8xYMoAPV0c4QfK5p/U7DFAy8XL4pM1XEfz+4Rx5CVjqhwyzblxJ
         ayUUw0DQhBy4W1ToltQLYaw7LJJa/XHDL7ptz/3JITZHvF6LkPJN5F18l32fuKoAB21B
         biQWGyMPdYW86kEHAfJ6Xp+muYoWiRzSHzs5tbZiWf1A/ukJStivHA29Qa+aZs6zfXxC
         /mnw==
X-Gm-Message-State: APjAAAXUtvL7HGW5y6jDwZ37EnYNcwexCNtMJd34np8MTQUhJEOkIOa4
        HvxaEH53iioFKSu21WAqe32ImXKiHRVEDivfS5rw5VCXUEJcTfuTUmWqT4HwGO39wt2+xQEzNKn
        goxlZbTyo6nY4fMPzW9nlszihCSP+tuXgAjTkd63y3zqO7ZxPArIM0freVEQ=
X-Google-Smtp-Source: APXvYqzoYVfYn2a3/MR/BmlGKp3TMfBxhWZlc+VbFHyIP26I44lUwjMczIxarfLyhSA4vlwP6e8cmzeirTQd
X-Received: by 2002:ac8:279b:: with SMTP id w27mr5510741qtw.159.1560462722373;
 Thu, 13 Jun 2019 14:52:02 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:51:32 -0700
In-Reply-To: <cover.1560462201.git.matvore@google.com>
Message-Id: <148f0936a7a9156b95a8aa71e0a96aeddcccef96.1560462201.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560462201.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v3 09/10] list-objects-filter-options: clean up use of ALLOC_GROW
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new macro ALLOC_GROW_BY which automatically zeros the added
array elements and takes care of updating the nr value. Use the macro in
code introduced earlier in this patchset.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 cache.h                       | 22 ++++++++++++++++++++++
 list-objects-filter-options.c | 17 +++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index b4bb2e2c11..48fb0f63c2 100644
--- a/cache.h
+++ b/cache.h
@@ -653,33 +653,55 @@ int init_db(const char *git_dir, const char *real_git_dir,
 void sanitize_stdfds(void);
 int daemonize(void);
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /*
  * Realloc the buffer pointed at by variable 'x' so that it can hold
  * at least 'nr' entries; the number of entries currently allocated
  * is 'alloc', using the standard growing factor alloc_nr() macro.
  *
+ * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
+ * added niceties.
+ *
  * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
  */
 #define ALLOC_GROW(x, nr, alloc) \
 	do { \
 		if ((nr) > alloc) { \
 			if (alloc_nr(alloc) < (nr)) \
 				alloc = (nr); \
 			else \
 				alloc = alloc_nr(alloc); \
 			REALLOC_ARRAY(x, alloc); \
 		} \
 	} while (0)
 
+/*
+ * Similar to ALLOC_GROW but handles updating of the nr value and
+ * zeroing the bytes of the newly-grown array elements.
+ *
+ * DO NOT USE any expression with side-effect for any of the
+ * arguments.
+ */
+#define ALLOC_GROW_BY(x, nr, increase, alloc) \
+	do { \
+		if (increase) { \
+			size_t new_nr = nr + (increase); \
+			if (new_nr < nr) \
+				BUG("negative growth in ALLOC_GROW_BY"); \
+			ALLOC_GROW(x, new_nr, alloc); \
+			memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
+			nr = new_nr; \
+		} \
+	} while (0)
+
 /* Initialize and use the cache information */
 struct lock_file;
 void preload_index(struct index_state *index,
 		   const struct pathspec *pathspec,
 		   unsigned int refresh_flags);
 int do_read_index(struct index_state *istate, const char *path,
 		  int must_exist); /* for testting only! */
 int read_index_from(struct index_state *, const char *path,
 		    const char *gitdir);
 int is_index_unborn(struct index_state *);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index ce274b1f35..9f08390628 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -109,28 +109,26 @@ static int has_reserved_character(
 	}
 
 	return 0;
 }
 
 static int parse_combine_subfilter(
 	struct list_objects_filter_options *filter_options,
 	struct strbuf *subspec,
 	struct strbuf *errbuf)
 {
-	size_t new_index = filter_options->sub_nr++;
+	size_t new_index = filter_options->sub_nr;
 	char *decoded;
 	int result;
 
-	ALLOC_GROW(filter_options->sub, filter_options->sub_nr,
-		   filter_options->sub_alloc);
-	memset(&filter_options->sub[new_index], 0,
-	       sizeof(*filter_options->sub));
+	ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
+		      filter_options->sub_alloc);
 
 	decoded = url_percent_decode(subspec->buf);
 
 	result = has_reserved_character(subspec, errbuf) ||
 		gently_parse_list_objects_filter(
 			&filter_options->sub[new_index], decoded, errbuf);
 
 	free(decoded);
 	return result;
 }
@@ -245,27 +243,26 @@ int parse_list_objects_filter(
 			filter_options, arg, &errbuf);
 	} else {
 		/*
 		 * Make filter_options an LOFC_COMBINE spec so we can trivially
 		 * add subspecs to it.
 		 */
 		transform_to_combine_type(filter_options);
 
 		string_list_append(&filter_options->filter_spec, xstrdup("+"));
 		filter_spec_append_urlencode(filter_options, arg);
-		ALLOC_GROW(filter_options->sub, filter_options->sub_nr + 1,
-			   filter_options->sub_alloc);
-		filter_options = &filter_options->sub[filter_options->sub_nr++];
-		memset(filter_options, 0, sizeof(*filter_options));
+		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
+			      filter_options->sub_alloc);
 
 		parse_error = gently_parse_list_objects_filter(
-			filter_options, arg, &errbuf);
+			&filter_options->sub[filter_options->sub_nr - 1], arg,
+			&errbuf);
 	}
 	if (parse_error)
 		die("%s", errbuf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
-- 
2.21.0

