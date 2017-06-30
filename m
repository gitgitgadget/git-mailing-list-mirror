Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECC1201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbdF3Uxm (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:42 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34021 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753066AbdF3Uxk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:40 -0400
Received: by mail-pf0-f177.google.com with SMTP id s66so72368852pfs.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LGvK/MsH1uw+HT+9ILU0NqKNOJ/DxahuWHt/2ix5+9g=;
        b=X89NYcfyxchra97ChGfvLxoaTsVDssy9i5Hdf9Eb1/Rxu/FkkeVMo26VCwLbbqSmQD
         H8mknko/LAktC6RRwiZhyzk64AX8D6L4vbbElAyLixDsRxBmDLH3nXTwBvSn0riLZ42j
         FH5SoPj8C+KNzfTa1b+Megg8yQAWnOyvS5x16ZIhXUgezBmA540zerM3HkkYk/OjhuNm
         X2NTMbUERl6PZgLfgFzI+YC98nCMFDxIPgLKckqqoXm1p75RAzFLnF7uu2mfRyxKp2GL
         /Mn7hBkr6xN1yJwOjRvVyoAux73arAMeozzmT1/syK5xS007e1wVjW9fYEXKcR6xccHY
         XHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LGvK/MsH1uw+HT+9ILU0NqKNOJ/DxahuWHt/2ix5+9g=;
        b=h46bmZVza4V5tgP/xndTWb9BmIZkjWBdB0EIfiVLfmYd/kJfucsqy+h+NTzY9DJT0z
         RuF0Xj4ku2q8VejK2bgKvoDLo25q/pom9WC4+yp2llusv+iXcpvfENWAhh7+aDzLYomq
         eRMun2ZzZdJMupclyBsS7NCWJMY758QlfLioPFtm5UJPiFVzsWs3KDgbyY0qPjnLkI3y
         EnzplQqRk8DwMvlwjRvQjF3QnuOphnkzAoC6JOrBVIclmbRsg1WurJDswQDqzl1iXr48
         xidkfIW4XJienwi2S0AMsgDhrSxxCQ1ObBGnIFLH+5RgBxhtZz4ZfxE0EEckDIHSUSJt
         g5QQ==
X-Gm-Message-State: AKS2vOzkXsoCfpjXRCnVlQVjWosHMjQbokwzqRBErCwZOGIRnbYQwdvu
        yBCX7DIMM9tATu6j
X-Received: by 10.99.250.69 with SMTP id g5mr22325228pgk.11.1498856019663;
        Fri, 30 Jun 2017 13:53:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id e189sm18466842pfe.100.2017.06.30.13.53.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 20/25] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
Date:   Fri, 30 Jun 2017 13:53:05 -0700
Message-Id: <20170630205310.7380-21-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 71 ++++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 5a9c55736d..2db0d7c0f5 100644
--- a/diff.c
+++ b/diff.c
@@ -572,6 +572,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_STATS_LINE,
 	DIFF_SYMBOL_WORD_DIFF,
 	DIFF_SYMBOL_STAT_SEP,
+	DIFF_SYMBOL_SUMMARY,
 	DIFF_SYMBOL_SUBMODULE_ADD,
 	DIFF_SYMBOL_SUBMODULE_DEL,
 	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
@@ -648,6 +649,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_SUBMODULE_ERROR:
 	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
 	case DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES:
+	case DIFF_SYMBOL_SUMMARY:
 	case DIFF_SYMBOL_STATS_LINE:
 	case DIFF_SYMBOL_BINARY_DIFF_BODY:
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
@@ -4717,67 +4719,76 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 	}
 }
 
-static void show_file_mode_name(FILE *file, const char *newdelete, struct diff_filespec *fs)
+static void show_file_mode_name(struct diff_options *opt, const char *newdelete, struct diff_filespec *fs)
 {
+	struct strbuf sb = STRBUF_INIT;
 	if (fs->mode)
-		fprintf(file, " %s mode %06o ", newdelete, fs->mode);
+		strbuf_addf(&sb, " %s mode %06o ", newdelete, fs->mode);
 	else
-		fprintf(file, " %s ", newdelete);
-	write_name_quoted(fs->path, file, '\n');
-}
+		strbuf_addf(&sb, " %s ", newdelete);
 
+	quote_c_style(fs->path, &sb, NULL, 0);
+	strbuf_addch(&sb, '\n');
+	emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
+			 sb.buf, sb.len, 0);
+	strbuf_release(&sb);
+}
 
-static void show_mode_change(FILE *file, struct diff_filepair *p, int show_name,
-		const char *line_prefix)
+static void show_mode_change(struct diff_options *opt, struct diff_filepair *p,
+		int show_name)
 {
 	if (p->one->mode && p->two->mode && p->one->mode != p->two->mode) {
-		fprintf(file, "%s mode change %06o => %06o%c", line_prefix, p->one->mode,
-			p->two->mode, show_name ? ' ' : '\n');
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addf(&sb, " mode change %06o => %06o",
+			    p->one->mode, p->two->mode);
 		if (show_name) {
-			write_name_quoted(p->two->path, file, '\n');
+			strbuf_addch(&sb, ' ');
+			quote_c_style(p->two->path, &sb, NULL, 0);
 		}
+		emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
+				 sb.buf, sb.len, 0);
+		strbuf_release(&sb);
 	}
 }
 
-static void show_rename_copy(FILE *file, const char *renamecopy, struct diff_filepair *p,
-			const char *line_prefix)
+static void show_rename_copy(struct diff_options *opt, const char *renamecopy,
+		struct diff_filepair *p)
 {
+	struct strbuf sb = STRBUF_INIT;
 	char *names = pprint_rename(p->one->path, p->two->path);
-
-	fprintf(file, " %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
+	strbuf_addf(&sb, " %s %s (%d%%)\n",
+			renamecopy, names, similarity_index(p));
 	free(names);
-	show_mode_change(file, p, 0, line_prefix);
+	emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
+				 sb.buf, sb.len, 0);
+	show_mode_change(opt, p, 0);
 }
 
 static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 {
-	FILE *file = opt->file;
-	const char *line_prefix = diff_line_prefix(opt);
-
 	switch(p->status) {
 	case DIFF_STATUS_DELETED:
-		fputs(line_prefix, file);
-		show_file_mode_name(file, "delete", p->one);
+		show_file_mode_name(opt, "delete", p->one);
 		break;
 	case DIFF_STATUS_ADDED:
-		fputs(line_prefix, file);
-		show_file_mode_name(file, "create", p->two);
+		show_file_mode_name(opt, "create", p->two);
 		break;
 	case DIFF_STATUS_COPIED:
-		fputs(line_prefix, file);
-		show_rename_copy(file, "copy", p, line_prefix);
+		show_rename_copy(opt, "copy", p);
 		break;
 	case DIFF_STATUS_RENAMED:
-		fputs(line_prefix, file);
-		show_rename_copy(file, "rename", p, line_prefix);
+		show_rename_copy(opt, "rename", p);
 		break;
 	default:
 		if (p->score) {
-			fprintf(file, "%s rewrite ", line_prefix);
-			write_name_quoted(p->two->path, file, ' ');
-			fprintf(file, "(%d%%)\n", similarity_index(p));
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addstr(&sb, " rewrite ");
+			quote_c_style(p->two->path, &sb, NULL, 0);
+			strbuf_addf(&sb, " (%d%%)\n", similarity_index(p));
+			emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
+					 sb.buf, sb.len, 0);
 		}
-		show_mode_change(file, p, !p->score, line_prefix);
+		show_mode_change(opt, p, !p->score);
 		break;
 	}
 }
-- 
2.13.0.31.g9b732c453e

