Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7704220281
	for <e@80x24.org>; Tue, 23 May 2017 19:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764908AbdEWTcN (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:32:13 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34093 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764905AbdEWTcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:32:10 -0400
Received: by mail-qt0-f195.google.com with SMTP id l39so23569147qtb.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2MxOvNpU08x1PNwyu4eOxFoCCDPljewOgdkTJODEARY=;
        b=Zny/TRRIyCQpdyy3gsHLCgUM8O8Jh1skQ7tnIlGJjSZIYqMaGwaCD5egibbj0JACII
         85N7WpraRXZISJMKQADwqOIM29b6w74IawrHW8vjkWgiFPEbGN1ujX+rnckEycpSBYve
         zUh8+HOPdHIBopIih3GkMg4UMLeOKSsKt28am47Cs89E1UdjAycsFu1qsGI3hgSQSEtU
         TJ65zT4kSsZ1q6PaJp9BKxwJbLsteyELatrD6Y9omBSRRDnoOEkhQfYQZL1V8wnoK6Ut
         f7kCyoJ1Euu6CIJs9OLEeb4vWKrZXZWrwSkaxXcIickRdBq0QV35jjVGDfIC8a2ekUAk
         fWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2MxOvNpU08x1PNwyu4eOxFoCCDPljewOgdkTJODEARY=;
        b=Xrd+ZYSQZIaJpbkPCejWIUisOrHxFLC5yQ2UJUQq/ArGoumh1+7WvRTMDNxlmi4ZzW
         MBb5DrTNNISEZ8x1FJ8aXC/AJTdgAbm1lUchJAd45POAxLfDCJcxGNTfWKb9IihiBUYf
         DqRnm7IwtmSHcMeHp+foHO2wOM0x0whlUbwW7//Aw3lCxrB7Ga5xy1vSQGxICA56wDFS
         kzKPyy4NjW0iEhUoGisET739zXY1S2E4nMfHkGTeI1m0I9Hausjw75l/qN5bSo+wO9gq
         qDNz0JQoyV62yZg0uhgBy3UEaWNic9MULIxpF1pG3Rr3dioCX7mg9RNYTekdS/VggDvh
         N8Ng==
X-Gm-Message-State: AODbwcCcFVb+C+3kyytYx1Ouj+wc+tVmioBSFdOLivHGFCj515jz6iMd
        u4NMK+sskpEa9CwKvkg=
X-Received: by 10.200.55.103 with SMTP id p36mr28188221qtb.64.1495567929543;
        Tue, 23 May 2017 12:32:09 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id f94sm1058506qtb.16.2017.05.23.12.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:32:08 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v6 5/6] dir: expose cmp_name() and check_contains()
Date:   Tue, 23 May 2017 06:09:36 -0400
Message-Id: <20170523100937.8752-6-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523100937.8752-1-sxlijin@gmail.com>
References: <20170523100937.8752-1-sxlijin@gmail.com>
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
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

