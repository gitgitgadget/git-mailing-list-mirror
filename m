Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887A32027C
	for <e@80x24.org>; Thu, 18 May 2017 08:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbdERIWR (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 04:22:17 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34824 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753712AbdERIWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 04:22:14 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so4794663qtb.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 01:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uFgogS5gKvure/lnRTdvfhevhv9YYJk5aTTfHFyCwA0=;
        b=J6p4qezH82RtXkF7LZLluzOP6IMAWLrnUNk13Lw5Or6CyZCyOivCHrDgrlF9dK5UQ4
         sedxC9/858BuCEeH9lX5zqer01mfb4JMMD2wXv02uWXLmOdJvMlTXjQooz8qtW+J19ai
         3KWM0v8714gZmL8xpBMXM21aBWNgsfzFYfaDsl+krz+hAK6WHH4L/j8WzIiPwU5iLpsd
         2zuOI9xjTyJ9nGZh5rsrNn6u08rTDUA8iyibwOObVelFVfIAJd3Db+36i23UBGpXiUlA
         a4EOjsCosJOpr13CNmIRiWkMYsKirjAmR8m9UlCdiUvgH3mCU8dqWHiRtylzKwzkubuw
         y2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=uFgogS5gKvure/lnRTdvfhevhv9YYJk5aTTfHFyCwA0=;
        b=HbST3pnG3gyATQlnlmQNHTuncwDspVQlyf9yvy3c8bMaAIcj/E0A+KUY6R7KKUzBpe
         /O7qd/O+P3/UOCygiB144XOZLGo3+RvXlsgUNFMSQi2TmgRIGyoMZnpKtgKCO3WPqrxJ
         ZPw12gnNY24zW6TjyILBW6lC8UTp3c4TXcXirkvXSsOIoDj4zMBqa2N5PNdIxhrtEHYe
         61nE2IANDhxd9UM/6d3nCKdSdwG7vpoq7jb+DzVncoVCee6p0aMUB92ZjtmHFM1kRUoS
         c3VqgH7EoYwNt0R7X13PWn8/75vwb24sjvoDxfsoT75PgVCwmhzdWfJlQ2uEBvoukcIg
         wXHg==
X-Gm-Message-State: AODbwcDF3kn4J0/41gIFJ1m9SZmXRU47gUYad1bc28/dpMdQR8+84TFK
        WUmeurRGmfT0kXolQQo=
X-Received: by 10.237.62.136 with SMTP id n8mr2694172qtf.0.1495095732621;
        Thu, 18 May 2017 01:22:12 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id k36sm2999604qte.65.2017.05.18.01.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 01:22:11 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 5/6] dir: expose cmp_name() and check_contains()
Date:   Thu, 18 May 2017 04:21:53 -0400
Message-Id: <20170518082154.28643-6-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to use cmp_name() and check_contains() (which both compare
`struct dir_entry`s, the former in terms of the sort order, the latter
in terms of whether one lexically contains another) outside of dir.c,
so we have to (1) change their linkage and (2) rename them as
appropriate for the global namespace. The second is achieved by
renaming cmp_name() to cmp_dir_entry() and check_contains() to
check_dir_entry_contains().

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 dir.c | 11 ++++++-----
 dir.h |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 4b0a99323..2c520f17a 100644
--- a/dir.c
+++ b/dir.c
@@ -1842,7 +1842,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	return dir_state;
 }
 
-static int cmp_name(const void *p1, const void *p2)
+int cmp_dir_entry(const void *p1, const void *p2)
 {
 	const struct dir_entry *e1 = *(const struct dir_entry **)p1;
 	const struct dir_entry *e2 = *(const struct dir_entry **)p2;
@@ -1851,7 +1851,7 @@ static int cmp_name(const void *p1, const void *p2)
 }
 
 /* check if *out lexically strictly contains *in */
-static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
+int check_dir_entry_contains(const struct dir_entry *out, const struct dir_entry *in)
 {
 	return (out->len < in->len) &&
 		(out->name[out->len - 1] == '/') &&
@@ -2071,8 +2071,8 @@ int read_directory(struct dir_struct *dir, const char *path,
 		dir->untracked = NULL;
 	if (!len || treat_leading_path(dir, path, len, pathspec))
 		read_directory_recursive(dir, path, len, untracked, 0, pathspec);
-	QSORT(dir->entries, dir->nr, cmp_name);
-	QSORT(dir->ignored, dir->ignored_nr, cmp_name);
+	QSORT(dir->entries, dir->nr, cmp_dir_entry);
+	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
 
 	/* if DIR_SHOW_IGNORED_TOO, read_directory_recursive() will also pick
 	 * up untracked contents of untracked dirs; by default we discard these,
@@ -2084,7 +2084,8 @@ int read_directory(struct dir_struct *dir, const char *path,
 
 		/* remove from dir->entries untracked contents of untracked dirs */
 		for (i = j = 0; j < dir->nr; j++) {
-			if (i && check_contains(dir->entries[i - 1], dir->entries[j])) {
+			if (i &&
+			    check_dir_entry_contains(dir->entries[i - 1], dir->entries[j])) {
 				free(dir->entries[j]);
 				dir->entries[j] = NULL;
 			} else {
diff --git a/dir.h b/dir.h
index 650e54bdf..edb5fda58 100644
--- a/dir.h
+++ b/dir.h
@@ -327,6 +327,9 @@ static inline int dir_path_match(const struct dir_entry *ent,
 			      has_trailing_dir);
 }
 
+int cmp_dir_entry(const void *p1, const void *p2);
+int check_dir_entry_contains(const struct dir_entry *out, const struct dir_entry *in);
+
 void untracked_cache_invalidate_path(struct index_state *, const char *);
 void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
-- 
2.13.0

