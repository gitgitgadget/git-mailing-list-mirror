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
	by dcvr.yhbt.net (Postfix) with ESMTP id AF480201A4
	for <e@80x24.org>; Tue, 16 May 2017 07:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbdEPHgU (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 03:36:20 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35798 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbdEPHgP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 03:36:15 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so19367121qtb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DKnQ1eVo1pzeJGTGvGtx5cZyJfh3B0M5hTUz0khO8ls=;
        b=EBqTePFP9eqOid9hWkwB7c15wD3KaG1nApatlFS/FVvlJw4YcAxRe89ChwUXhWoTHv
         RsI2lzcKUAJ6wr+EAOSBteL0e2JOJwy3nPxW0c9Zd1kYlwa0BaEEM8UAb9l+mxqu4i2i
         oWUGc7ea1j8kObxxlwqhiYu+9+dosvSFNLEugb8CX8vb8X6UR5FjNc4lzwqzgihGu0e7
         IWXJRqKRfwFVkhf8u3uiGsdNU+Kx5xIDI/rgcPWFNH9Jkd68l0t/ZOktEUALZ8Yrmsko
         nBttMCk3QPjPzWG1lxRR+j5ri2ITatjBFdZ8ZkcjD+ofL+A77hlLXGDsWhF8L7MpCuQH
         OJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DKnQ1eVo1pzeJGTGvGtx5cZyJfh3B0M5hTUz0khO8ls=;
        b=SLutOxJpLq5lpMm6FvdH51ecr4WKaJlzJVXZLMjdKFm04F+lwfURDiVsLFXESL5TQm
         BsLQlDZjYQjqJhWaqLC/C2+VOAZTK04LZlpHjZNrezXSsSwqNjVFn2lSMO20b9mAAPDm
         SEfZgRjbVqu7Qtu+y153byPSWBZo2KbDMp9v/szDVMbakmj9az+5fKx3lnhhd9zbjKrl
         FmW5FjKyULdDUy4AxAqLvhn2Wv9+wBI0O2A/p3zoRB9mHAqfPgPzJtJ0E6/Fl35ccN78
         vS2Dnp7S/JtyXe/LGYTE+dAEAuoL5gOy3sDvTtsryo5y65gvaAfLA5qTXPfWdYxvs8NK
         KRmw==
X-Gm-Message-State: AODbwcDAsmcH331m4ul9gNUvpakMQDdHV2Kfqcq1u0nY4Uo6zru4IS/o
        5D4QvLeR4OmUEpDQaB4=
X-Received: by 10.200.41.247 with SMTP id 52mr8600785qtt.168.1494920174019;
        Tue, 16 May 2017 00:36:14 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id i51sm10374103qte.28.2017.05.16.00.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 00:36:13 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 4/8] dir: hide untracked contents of untracked dirs
Date:   Tue, 16 May 2017 03:34:19 -0400
Message-Id: <20170516073423.25762-5-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we taught read_directory_recursive() to recurse into untracked
directories in search of ignored files given DIR_SHOW_IGNORED_TOO, that
had the side effect of teaching it to collect the untracked contents of
untracked directories. It doesn't always make sense to return these,
though (we do need them for `clean -d`), so we introduce a flag
(DIR_KEEP_UNTRACKED_CONTENTS) to control whether or not read_directory()
strips dir->entries of the untracked contents of untracked dirs.

We also introduce check_contains() to check if one dir_entry corresponds
to a path which contains the path corresponding to another dir_entry.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 dir.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dir.h |  3 ++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 6bd0350e9..214a148ee 100644
--- a/dir.c
+++ b/dir.c
@@ -1852,6 +1852,14 @@ static int cmp_name(const void *p1, const void *p2)
 	return name_compare(e1->name, e1->len, e2->name, e2->len);
 }
 
+/* check if *out lexically contains *in */
+static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
+{
+	return (out->len < in->len) &&
+			(out->name[out->len - 1] == '/') &&
+			!memcmp(out->name, in->name, out->len);
+}
+
 static int treat_leading_path(struct dir_struct *dir,
 			      const char *path, int len,
 			      const struct pathspec *pathspec)
@@ -2067,6 +2075,52 @@ int read_directory(struct dir_struct *dir, const char *path,
 		read_directory_recursive(dir, path, len, untracked, 0, pathspec);
 	QSORT(dir->entries, dir->nr, cmp_name);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_name);
+
+	// if DIR_SHOW_IGNORED_TOO, read_directory_recursive() will also pick
+	// up untracked contents of untracked dirs; by default we discard these,
+	// but given DIR_KEEP_UNTRACKED_CONTENTS we do not
+	if ((dir->flags & DIR_SHOW_IGNORED_TOO)
+		     && !(dir->flags & DIR_KEEP_UNTRACKED_CONTENTS)) {
+		int i, j, nr_removed = 0;
+
+		// remove from dir->entries untracked contents of untracked dirs
+		for (i = 0; i < dir->nr; i++) {
+			if (!dir->entries[i])
+				continue;
+
+			for (j = i + 1; j < dir->nr; j++) {
+				if (!dir->entries[j])
+					continue;
+				if (check_contains(dir->entries[i], dir->entries[j])) {
+					nr_removed++;
+					free(dir->entries[j]);
+					dir->entries[j] = NULL;
+				}
+				else {
+					break;
+				}
+			}
+		}
+
+		// strip dir->entries of NULLs
+		if (nr_removed) {
+			for (i = 0;;) {
+				while (i < dir->nr && dir->entries[i])
+					i++;
+				if (i == dir->nr)
+					break;
+				j = i;
+				while (j < dir->nr && !dir->entries[j])
+					j++;
+				if (j == dir->nr)
+					break;
+				dir->entries[i] = dir->entries[j];
+				dir->entries[j] = NULL;
+			}
+			dir->nr -= nr_removed;
+		}
+	}
+
 	if (dir->untracked) {
 		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
 		trace_printf_key(&trace_untracked_stats,
diff --git a/dir.h b/dir.h
index bf23a470a..650e54bdf 100644
--- a/dir.h
+++ b/dir.h
@@ -151,7 +151,8 @@ struct dir_struct {
 		DIR_NO_GITLINKS = 1<<3,
 		DIR_COLLECT_IGNORED = 1<<4,
 		DIR_SHOW_IGNORED_TOO = 1<<5,
-		DIR_COLLECT_KILLED_ONLY = 1<<6
+		DIR_COLLECT_KILLED_ONLY = 1<<6,
+		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
-- 
2.12.2

