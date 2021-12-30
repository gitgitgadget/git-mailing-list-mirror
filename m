Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F6C433FE
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242392AbhL3XgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbhL3XgS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:36:18 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0085C061748
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g132so16500970wmg.2
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IeCaokV21WwmKlTbQFYsTB+0f/HLRZxfp5F1AXst2gA=;
        b=Asg2yMrWsviidyaiAjETkCApeDO2gsTMgSbOfe+4v+siFZUsOK4Kpnbc/PuqyTWgV1
         1nb2a+W4vDg1li5AK5AU/4SPw23FL4xLR73IWORF7LuZtSbKn/SUKUE4Dw89BrGgy5D9
         Cc4goC6t17rXAu102e2XgPi5N/67xpz2KVpGeimUboYZ8Ll3YfWIe6PhL5TSngUKqhlu
         U88PkBjImDc0iKnhEoXGZpzqiF6gt8t32fscVfGVJPpOLydKUeUhn73UGR+c2167rimr
         WpSNvNqdVrQ4CTYpxjXuWUS6bvNDGwaTn07VfTooQr9CJ0jGam+HGcyp+ybx+R51zDF7
         5O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IeCaokV21WwmKlTbQFYsTB+0f/HLRZxfp5F1AXst2gA=;
        b=nHvzxeS9Kz2r7UoWjAxSGBNPneY1LT5KoNvm5WF8oOU4DUjYS2KLFJnAZQ2Sw+COon
         /Kh7oUJneH+sJ3eC4dK8eZ9tgVK/QwAvqV+EzrpvFvUjaT9ZrhwE/Xfmhw7651j1VcQI
         lm6uGrbqegiosOqCQ5uNix5RYGBm9x/vbB/JOAljcmXiv5cMDYWZM17CBKfyU6vwSSXd
         F3zwRZrJB9TVeDZwZK0j1Y53zckQTZLOGF1cZ5BbJ7IPpUIzKhbm0pnGBP+GWu07wzMp
         4WvhXx8ydAHXrX8D1+owL2xovsVANsjjElAaeSCikEZGOfCx92MppCR+WtsfyCwutH5w
         lvvg==
X-Gm-Message-State: AOAM530VrLj5h+lQwVe7qmnLtHJ51BUKVHbubz4cy5wJHBLcFAhMRBI0
        iiK5sZmqScLVYm8DyCBjpV5JJ+peAiM=
X-Google-Smtp-Source: ABdhPJz3n5YL1hcWp8M8GfKTy2AeWI9rvdKWqAP6TA//ewirJ2AaYd9d/x+DDp1MAsWxZLgGTCdIOg==
X-Received: by 2002:a05:600c:3589:: with SMTP id p9mr28344687wmq.109.1640907376286;
        Thu, 30 Dec 2021 15:36:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3sm25340162wro.22.2021.12.30.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:36:15 -0800 (PST)
Message-Id: <5000a94aa9881751e887728cf4a7fb4d9eb8aacb.1640907369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
        <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 23:36:07 +0000
Subject: [PATCH v3 7/9] diff: add ability to insert additional headers for
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When additional headers are provided, we need to
  * add diff_filepairs to diff_queued_diff for each paths in the
    additional headers map which, unless that path is part of
    another diff_filepair already found in diff_queued_diff
  * format the headers (colorization, line_prefix for --graph)
  * make sure the various codepaths that attempt to return early
    if there are "no changes" take into account the headers that
    need to be shown.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c     | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 diff.h     |   3 +-
 log-tree.c |   2 +-
 3 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 861282db1c3..aaa6a19f158 100644
--- a/diff.c
+++ b/diff.c
@@ -27,6 +27,7 @@
 #include "help.h"
 #include "promisor-remote.h"
 #include "dir.h"
+#include "strmap.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -3406,6 +3407,31 @@ struct userdiff_driver *get_textconv(struct repository *r,
 	return userdiff_get_textconv(r, one->driver);
 }
 
+static struct strbuf *additional_headers(struct diff_options *o,
+					 const char *path)
+{
+	if (!o->additional_path_headers)
+		return NULL;
+	return strmap_get(o->additional_path_headers, path);
+}
+
+static void add_formatted_headers(struct strbuf *msg,
+				  struct strbuf *more_headers,
+				  const char *line_prefix,
+				  const char *meta,
+				  const char *reset)
+{
+	char *next, *newline;
+
+	for (next = more_headers->buf; *next; next = newline) {
+		newline = strchrnul(next, '\n');
+		strbuf_addf(msg, "%s%s%.*s%s\n", line_prefix, meta,
+			    (int)(newline - next), next, reset);
+		if (*newline)
+			newline++;
+	}
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -3464,6 +3490,17 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
+	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
+		/*
+		 * We should only reach this point for pairs from
+		 * create_filepairs_for_header_only_notifications().  For
+		 * these, we should avoid the "/dev/null" special casing
+		 * above, meaning we avoid showing such pairs as either
+		 * "new file" or "deleted file" below.
+		 */
+		lbl[0] = a_one;
+		lbl[1] = b_two;
+	}
 	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
@@ -4328,6 +4365,7 @@ static void fill_metainfo(struct strbuf *msg,
 	const char *set = diff_get_color(use_color, DIFF_METAINFO);
 	const char *reset = diff_get_color(use_color, DIFF_RESET);
 	const char *line_prefix = diff_line_prefix(o);
+	struct strbuf *more_headers = NULL;
 
 	*must_show_header = 1;
 	strbuf_init(msg, PATH_MAX * 2 + 300);
@@ -4364,6 +4402,11 @@ static void fill_metainfo(struct strbuf *msg,
 	default:
 		*must_show_header = 0;
 	}
+	if ((more_headers = additional_headers(o, name))) {
+		add_formatted_headers(msg, more_headers,
+				      line_prefix, set, reset);
+		*must_show_header = 1;
+	}
 	if (one && two && !oideq(&one->oid, &two->oid)) {
 		const unsigned hexsz = the_hash_algo->hexsz;
 		int abbrev = o->abbrev ? o->abbrev : DEFAULT_ABBREV;
@@ -5852,12 +5895,22 @@ int diff_unmodified_pair(struct diff_filepair *p)
 
 static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 {
-	if (diff_unmodified_pair(p))
+	/*
+	 * Check if we can return early without showing a diff.  Note that
+	 * diff_filepair only stores {oid, path, mode, is_valid}
+	 * information for each path, and thus diff_unmodified_pair() only
+	 * considers those bits of info.  However, we do not want pairs
+	 * created by create_filepairs_for_header_only_notifications() to
+	 * be ignored, so return early if both p is unmodified AND
+	 * p->one->path is not in additional headers.
+	 */
+	if (diff_unmodified_pair(p) && !additional_headers(o, p->one->path))
 		return;
 
+	/* Actually, we can also return early to avoid showing tree diffs */
 	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
-		return; /* no tree diffs in patch format */
+		return;
 
 	run_diff(p, o);
 }
@@ -5888,10 +5941,14 @@ static void diff_flush_checkdiff(struct diff_filepair *p,
 	run_checkdiff(p, o);
 }
 
-int diff_queue_is_empty(void)
+int diff_queue_is_empty(struct diff_options *o)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
+
+	if (o->additional_path_headers &&
+	    !strmap_empty(o->additional_path_headers))
+		return 0;
 	for (i = 0; i < q->nr; i++)
 		if (!diff_unmodified_pair(q->queue[i]))
 			return 0;
@@ -6325,6 +6382,54 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(_(rename_limit_advice), varname, needed);
 }
 
+static void create_filepairs_for_header_only_notifications(struct diff_options *o)
+{
+	struct strset present;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	int i;
+
+	strset_init_with_options(&present, /*pool*/ NULL, /*strdup*/ 0);
+
+	/*
+	 * Find out which paths exist in diff_queued_diff, preferring
+	 * one->path for any pair that has multiple paths.
+	 */
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		char *path = p->one->path ? p->one->path : p->two->path;
+
+		if (strmap_contains(o->additional_path_headers, path))
+			strset_add(&present, path);
+	}
+
+	/*
+	 * Loop over paths in additional_path_headers; for each NOT already
+	 * in diff_queued_diff, create a synthetic filepair and insert that
+	 * into diff_queued_diff.
+	 */
+	strmap_for_each_entry(o->additional_path_headers, &iter, e) {
+		if (!strset_contains(&present, e->key)) {
+			struct diff_filespec *one, *two;
+			struct diff_filepair *p;
+
+			one = alloc_filespec(e->key);
+			two = alloc_filespec(e->key);
+			fill_filespec(one, null_oid(), 0, 0);
+			fill_filespec(two, null_oid(), 0, 0);
+			p = diff_queue(q, one, two);
+			p->status = DIFF_STATUS_MODIFIED;
+		}
+	}
+
+	/* Re-sort the filepairs */
+	diffcore_fix_diff_index();
+
+	/* Cleanup */
+	strset_clear(&present);
+}
+
 static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
@@ -6337,6 +6442,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	if (o->color_moved)
 		o->emitted_symbols = &esm;
 
+	if (o->additional_path_headers)
+		create_filepairs_for_header_only_notifications(o);
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
@@ -6413,7 +6521,7 @@ void diff_flush(struct diff_options *options)
 	 * Order: raw, stat, summary, patch
 	 * or:    name/name-status/checkdiff (other bits clear)
 	 */
-	if (!q->nr)
+	if (!q->nr && !options->additional_path_headers)
 		goto free_queue;
 
 	if (output_format & (DIFF_FORMAT_RAW |
diff --git a/diff.h b/diff.h
index 8ba85c5e605..06a0a67afda 100644
--- a/diff.h
+++ b/diff.h
@@ -395,6 +395,7 @@ struct diff_options {
 
 	struct repository *repo;
 	struct option *parseopts;
+	struct strmap *additional_path_headers;
 
 	int no_free;
 };
@@ -593,7 +594,7 @@ void diffcore_fix_diff_index(void);
 "                show all files diff when -S is used and hit is found.\n" \
 "  -a  --text    treat all files as text.\n"
 
-int diff_queue_is_empty(void);
+int diff_queue_is_empty(struct diff_options*);
 void diff_flush(struct diff_options*);
 void diff_free(struct diff_options*);
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
diff --git a/log-tree.c b/log-tree.c
index d4655b63d75..33c28f537a6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -850,7 +850,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 	opt->shown_dashes = 0;
 	diffcore_std(&opt->diffopt);
 
-	if (diff_queue_is_empty()) {
+	if (diff_queue_is_empty(&opt->diffopt)) {
 		int saved_fmt = opt->diffopt.output_format;
 		opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
 		diff_flush(&opt->diffopt);
-- 
gitgitgadget

