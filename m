Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0884B1FF30
	for <e@80x24.org>; Tue, 23 May 2017 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935541AbdEWJSw (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 05:18:52 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:32921 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760211AbdEWJSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 05:18:42 -0400
Received: by mail-qk0-f193.google.com with SMTP id o85so22135394qkh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 02:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2MxOvNpU08x1PNwyu4eOxFoCCDPljewOgdkTJODEARY=;
        b=SS/J2moyPKJCU9RGiQcdKL/mYsf6COZbyY5+a11Xyv7Dc7tYUGgrFb51CfB9OmrYfW
         5WqpmUritI5LRf/SOtojZhbFj12RnYCKPd0wEF6MNGLCwrBn8ECCWHYiZA7GGbnBHRaP
         LhgW40oOOqj4M1FUOZPtA/WJ38N0SADUwP1q6jWjzqKCMVAe4GkVBf5QlpZuE+M05dSv
         AB9up2HKoySxIB3nnWC92cs0JN4FNbPy8zwGX/W55jMM7Q5totybSOKFZRwf++3guW76
         TppF5NPuQ73aWDV1hIb/BQUMzq5LTjId2v90dmsq1mWjLY5c4dMS7qJ8gh1E7573T8fF
         HH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2MxOvNpU08x1PNwyu4eOxFoCCDPljewOgdkTJODEARY=;
        b=h+2x176hgd1T60I1IXFax67ykEVahrGlh5oXyVyICrV/uaZbo+5trdFGECvlaPFlUm
         txtQxiGdH1U/58OzX0xXprt2nYJ54HReRl1D4JPfmcHBj1OSw7Vbd9yDZqMDHj8lzvM7
         TAAucAYS7ewQm2tusguxSQEMEMVdn2bpj8ua+Mn1veaY3Yj7sLexKbuvo3PDRdTiJ/ex
         jIGFXq5dt8sZ13g3LQNGNv/Vp1eg6iqKQjWiVsQTgxF8TAuGNW7Y1x8s8oWyLi1L1gZD
         fTnmzN02QqHGFw11AVSZojM3btFiqCxm9sR9SboqG54PVLqdxwLWYSdLoCF1ozzqDkN7
         CjPQ==
X-Gm-Message-State: AODbwcCyzhwaghbDF+DTDynFni8bgtFWo1BL9sJwgD4E1YQpUg1n0H1z
        ZRGaqeorRHv0jgOt7DE=
X-Received: by 10.55.139.134 with SMTP id n128mr24255324qkd.60.1495531121738;
        Tue, 23 May 2017 02:18:41 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id a45sm83105qta.39.2017.05.23.02.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 02:18:41 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v5 5/6] dir: expose cmp_name() and check_contains()
Date:   Tue, 23 May 2017 05:18:28 -0400
Message-Id: <20170523091829.1746-6-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
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
index ba5eadeda..aae6d00b4 100644
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
 
 	/* 
 	 * if DIR_SHOW_IGNORED_TOO, read_directory_recursive() will also pick
@@ -2085,7 +2085,8 @@ int read_directory(struct dir_struct *dir, const char *path,
 
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

