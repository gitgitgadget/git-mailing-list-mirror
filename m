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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EBBC201A4
	for <e@80x24.org>; Tue, 16 May 2017 07:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbdEPHgT (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 03:36:19 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33686 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdEPHgP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 03:36:15 -0400
Received: by mail-qt0-f195.google.com with SMTP id a46so19357246qte.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KLcsLnamFAEBtRDZMZ7Nv3aV7FDZCNJfOhwq+iopjZk=;
        b=j0TsaRB8uRirsw7kcu79MjuDthz/dnQNjUwE6ibRdeWrNCbwDWStxgMQi0Tnlxbtp8
         gqENAnYtQgg5/oTjKH45ATwF8Sq/M37BoGTIcjFQlMnBy0feWQYt/w9sMLH67COo4HyU
         OpiD3q5FjS9gvLRemBIfAm1t4GwaMFTsDikLzNR38jpaE2/9S0K4qNMfjX1DLuDwO/Sl
         0/esRltL+vv9RMxQE5hP0c8SDyTlawE1tY63/iNXz6EX7kdjX3alL0m3zydb06iFwN1Y
         6Hmyw9zeSu3b033O5ZH7UrzS7GdVOPACeX7xRbrW4Dt8XTTqHdy+fUBlLPi+LFKCJRQP
         g+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=KLcsLnamFAEBtRDZMZ7Nv3aV7FDZCNJfOhwq+iopjZk=;
        b=F+Qqf3b0BdAtjeR48vAM9AS9PE1YW9Ic4OVJNmkQyV+L4diKuL8XdNBCp0wP0bcqh2
         ymeWqHlmCnmkqD8nM4yPaKTtwTwJ+fds/rA5Uu3JRT8i7k26OynEE2zIQOpilyiz0RLr
         x1pIJa51rUjD7qjv0A/fSIgSgABAIuhrGRzuSfbFpbmgSSxvay3N2mZMYry6IgfEU5m/
         zcbAxHsRy9LHqLQPDySAuxc3CQhRF3EXH/xoUBp2tihMBRaiSfq5HHgfvqsHk8lVT07P
         2fM4H+952KaIQNxa2FbDrFooTd6/tjrdJfG0OmA1PNfR5Dhq5zLP1ahnIpwdiHZc68di
         V7DQ==
X-Gm-Message-State: AODbwcAcZTofbCD0HOJLNzU6GOiSllnse3nHP7E2/8KRHWblxighl1MS
        ByHkzHdlsPMasA==
X-Received: by 10.200.50.203 with SMTP id a11mr9002361qtb.201.1494920175018;
        Tue, 16 May 2017 00:36:15 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id i51sm10374103qte.28.2017.05.16.00.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 00:36:14 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 5/8] dir: expose cmp_name() and check_contains()
Date:   Tue, 16 May 2017 03:34:20 -0400
Message-Id: <20170516073423.25762-6-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
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
 dir.c | 10 +++++-----
 dir.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 214a148ee..1bf2d20e7 100644
--- a/dir.c
+++ b/dir.c
@@ -1844,7 +1844,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	return dir_state;
 }
 
-static int cmp_name(const void *p1, const void *p2)
+int cmp_dir_entry(const void *p1, const void *p2)
 {
 	const struct dir_entry *e1 = *(const struct dir_entry **)p1;
 	const struct dir_entry *e2 = *(const struct dir_entry **)p2;
@@ -1853,7 +1853,7 @@ static int cmp_name(const void *p1, const void *p2)
 }
 
 /* check if *out lexically contains *in */
-static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
+int check_dir_entry_contains(const struct dir_entry *out, const struct dir_entry *in)
 {
 	return (out->len < in->len) &&
 			(out->name[out->len - 1] == '/') &&
@@ -2073,8 +2073,8 @@ int read_directory(struct dir_struct *dir, const char *path,
 		dir->untracked = NULL;
 	if (!len || treat_leading_path(dir, path, len, pathspec))
 		read_directory_recursive(dir, path, len, untracked, 0, pathspec);
-	QSORT(dir->entries, dir->nr, cmp_name);
-	QSORT(dir->ignored, dir->ignored_nr, cmp_name);
+	QSORT(dir->entries, dir->nr, cmp_dir_entry);
+	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
 
 	// if DIR_SHOW_IGNORED_TOO, read_directory_recursive() will also pick
 	// up untracked contents of untracked dirs; by default we discard these,
@@ -2091,7 +2091,7 @@ int read_directory(struct dir_struct *dir, const char *path,
 			for (j = i + 1; j < dir->nr; j++) {
 				if (!dir->entries[j])
 					continue;
-				if (check_contains(dir->entries[i], dir->entries[j])) {
+				if (check_dir_entry_contains(dir->entries[i], dir->entries[j])) {
 					nr_removed++;
 					free(dir->entries[j]);
 					dir->entries[j] = NULL;
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
2.12.2

