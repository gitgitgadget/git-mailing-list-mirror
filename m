Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F77C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DCE233ED
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391403AbhATQHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391199AbhATQFF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:05:05 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696C8C0613ED
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:04:25 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j26so16578458qtq.8
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JmehTkwLKDr1VN96VYmKd3VUY+GszJGAnTjO7f0B5mI=;
        b=aiwkn24cDj+AlPgftx/D+MCfJQf7z0FZR05MU39ibS94ND/RUdPiQojZzy7c/QgWAj
         awuHHSPRp4mKdXyxqFQG0L8HYiynulatvBOnMyfwOGVcbfx4CwcUc3Yb0l1IuAoWJJUN
         2U4k19I464v2qswuUMSWUPf88iJCzdI3WyHfR5175G+XpGk5gaBq+xdSep+skK7i8URU
         lg/g/bSQvixpHCHnsDsZQ9cyHs3DC2YSgM1mD4B9inm4RQJJ+6zF4NIg9NMt+w/WEcVr
         jnDlemZbvL9EyteOsnoHC72AOJdaHjnChw/plX+2qvWgAp9K/2XbULnIgNZeBoYMutAF
         zooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JmehTkwLKDr1VN96VYmKd3VUY+GszJGAnTjO7f0B5mI=;
        b=Gzj3sq4mf6b57bXE9HgDW4l/5+7Mz54zbpy1Q9snFvulonbxXOhC4xV61F2INZY1J2
         85u5Fq5AXgoG6gItic17seiMHW3KST7XvWM8gz922pZLk2FNVU1jRnRcY5f9E+Wpi0IB
         NP3lN5qQjM4E0/jCSfofJkzNDHY3sD05+cAWd5hZtps4tCA28tIphDvXRdMoikIVTSYr
         2XLME9B14aE5ksXOia4sIb/6zA/1UxjvKT8z7NoO7km+3neBuXIhEHWFPW3c8SJJb7Oh
         xI/ZniMIExYNK3G8Z+TfDk7WzTM0DZQdGFkghzHPplG/x7sZ2PesraRY/ooWR5fFR/EC
         AzHg==
X-Gm-Message-State: AOAM5339b/PVIJ1WYAYpjCAYHFpR2rOQTLgVigJa9mMg3mA1ycTaGsu+
        NicEq1V4TrRokUWT8XgyeAhvwsn9GyRgPw==
X-Google-Smtp-Source: ABdhPJygmWd92z34TiHPsV2KP9KK1YZTuvGZMnIEpXpHduzIq4vInUKNxwkvikoqJag2ABeCaWZDug==
X-Received: by 2002:ac8:5e12:: with SMTP id h18mr9658578qtx.335.1611158664260;
        Wed, 20 Jan 2021 08:04:24 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id z16sm348362qtb.73.2021.01.20.08.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:04:23 -0800 (PST)
Date:   Wed, 20 Jan 2021 11:04:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@gitlab.com, peff@peff.net
Subject: [PATCH v2 1/3] refs: expose 'for_each_fullref_in_prefixes'
Message-ID: <bda314fe7ae1629ba068a0c4ada9b6adc20576eb.1611158549.git.me@ttaylorr.com>
References: <cover.1611080326.git.me@ttaylorr.com>
 <cover.1611158549.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611158549.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was used in the ref-filter.c code to find the longest
common prefix of among a set of refspecs, and then to iterate all of the
references that descend from that prefix.

A future patch will want to use that same code from ls-refs.c, so
prepare by exposing and moving it to refs.c. Since there is nothing
specific to the ref-filter code here (other than that it was previously
the only caller of this function), this really belongs in the more
generic refs.h header.

The code moved in this patch is identical before and after, with the one
exception of renaming some arguments to be consistent with other
functions exposed in refs.h.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c | 74 ++------------------------------------------
 refs.c       | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h       |  9 ++++++
 3 files changed, 98 insertions(+), 72 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index aa260bfd09..f918f00151 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1929,64 +1929,6 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 	return match_pattern(filter, refname);
 }
 
-static int qsort_strcmp(const void *va, const void *vb)
-{
-	const char *a = *(const char **)va;
-	const char *b = *(const char **)vb;
-
-	return strcmp(a, b);
-}
-
-static void find_longest_prefixes_1(struct string_list *out,
-				  struct strbuf *prefix,
-				  const char **patterns, size_t nr)
-{
-	size_t i;
-
-	for (i = 0; i < nr; i++) {
-		char c = patterns[i][prefix->len];
-		if (!c || is_glob_special(c)) {
-			string_list_append(out, prefix->buf);
-			return;
-		}
-	}
-
-	i = 0;
-	while (i < nr) {
-		size_t end;
-
-		/*
-		* Set "end" to the index of the element _after_ the last one
-		* in our group.
-		*/
-		for (end = i + 1; end < nr; end++) {
-			if (patterns[i][prefix->len] != patterns[end][prefix->len])
-				break;
-		}
-
-		strbuf_addch(prefix, patterns[i][prefix->len]);
-		find_longest_prefixes_1(out, prefix, patterns + i, end - i);
-		strbuf_setlen(prefix, prefix->len - 1);
-
-		i = end;
-	}
-}
-
-static void find_longest_prefixes(struct string_list *out,
-				  const char **patterns)
-{
-	struct strvec sorted = STRVEC_INIT;
-	struct strbuf prefix = STRBUF_INIT;
-
-	strvec_pushv(&sorted, patterns);
-	QSORT(sorted.v, sorted.nr, qsort_strcmp);
-
-	find_longest_prefixes_1(out, &prefix, sorted.v, sorted.nr);
-
-	strvec_clear(&sorted);
-	strbuf_release(&prefix);
-}
-
 /*
  * This is the same as for_each_fullref_in(), but it tries to iterate
  * only over the patterns we'll care about. Note that it _doesn't_ do a full
@@ -1997,10 +1939,6 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 				       void *cb_data,
 				       int broken)
 {
-	struct string_list prefixes = STRING_LIST_INIT_DUP;
-	struct string_list_item *prefix;
-	int ret;
-
 	if (!filter->match_as_path) {
 		/*
 		 * in this case, the patterns are applied after
@@ -2024,16 +1962,8 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_in("", cb, cb_data, broken);
 	}
 
-	find_longest_prefixes(&prefixes, filter->name_patterns);
-
-	for_each_string_list_item(prefix, &prefixes) {
-		ret = for_each_fullref_in(prefix->string, cb, cb_data, broken);
-		if (ret)
-			break;
-	}
-
-	string_list_clear(&prefixes, 0);
-	return ret;
+	return for_each_fullref_in_prefixes(NULL, filter->name_patterns,
+					    cb, cb_data, broken);
 }
 
 /*
diff --git a/refs.c b/refs.c
index 13dc2c3291..0b5a68588f 100644
--- a/refs.c
+++ b/refs.c
@@ -1546,6 +1546,93 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
+static int qsort_strcmp(const void *va, const void *vb)
+{
+	const char *a = *(const char **)va;
+	const char *b = *(const char **)vb;
+
+	return strcmp(a, b);
+}
+
+static void find_longest_prefixes_1(struct string_list *out,
+				  struct strbuf *prefix,
+				  const char **patterns, size_t nr)
+{
+	size_t i;
+
+	for (i = 0; i < nr; i++) {
+		char c = patterns[i][prefix->len];
+		if (!c || is_glob_special(c)) {
+			string_list_append(out, prefix->buf);
+			return;
+		}
+	}
+
+	i = 0;
+	while (i < nr) {
+		size_t end;
+
+		/*
+		* Set "end" to the index of the element _after_ the last one
+		* in our group.
+		*/
+		for (end = i + 1; end < nr; end++) {
+			if (patterns[i][prefix->len] != patterns[end][prefix->len])
+				break;
+		}
+
+		strbuf_addch(prefix, patterns[i][prefix->len]);
+		find_longest_prefixes_1(out, prefix, patterns + i, end - i);
+		strbuf_setlen(prefix, prefix->len - 1);
+
+		i = end;
+	}
+}
+
+static void find_longest_prefixes(struct string_list *out,
+				  const char **patterns)
+{
+	struct strvec sorted = STRVEC_INIT;
+	struct strbuf prefix = STRBUF_INIT;
+
+	strvec_pushv(&sorted, patterns);
+	QSORT(sorted.v, sorted.nr, qsort_strcmp);
+
+	find_longest_prefixes_1(out, &prefix, sorted.v, sorted.nr);
+
+	strvec_clear(&sorted);
+	strbuf_release(&prefix);
+}
+
+int for_each_fullref_in_prefixes(const char *namespace,
+				 const char **patterns,
+				 each_ref_fn fn, void *cb_data,
+				 unsigned int broken)
+{
+	struct string_list prefixes = STRING_LIST_INIT_DUP;
+	struct string_list_item *prefix;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0, namespace_len;
+
+	find_longest_prefixes(&prefixes, patterns);
+
+	if (namespace)
+		strbuf_addstr(&buf, namespace);
+	namespace_len = buf.len;
+
+	for_each_string_list_item(prefix, &prefixes) {
+		strbuf_addf(&buf, "%s", prefix->string);
+		ret = for_each_fullref_in(buf.buf, fn, cb_data, broken);
+		if (ret)
+			break;
+		strbuf_setlen(&buf, namespace_len);
+	}
+
+	string_list_clear(&prefixes, 0);
+	strbuf_release(&buf);
+	return ret;
+}
+
 static int refs_read_special_head(struct ref_store *ref_store,
 				  const char *refname, struct object_id *oid,
 				  struct strbuf *referent, unsigned int *type)
diff --git a/refs.h b/refs.h
index ff05d2e9fe..c5fd35487d 100644
--- a/refs.h
+++ b/refs.h
@@ -347,6 +347,15 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 			unsigned int broken);
 
+/**
+ * iterate all refs in "patterns" by partitioning patterns into disjoint sets
+ * and iterating the longest-common prefix of each set.
+ *
+ * callers should be prepared to ignore references that they did not ask for.
+ */
+int for_each_fullref_in_prefixes(const char *namespace, const char **patterns,
+				 each_ref_fn fn, void *cb_data,
+				 unsigned int broken);
 /**
  * iterate refs from the respective area.
  */
-- 
2.30.0.138.g6d7191ea01

