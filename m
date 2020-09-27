Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB21C4741F
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18C023976
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA53YT8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgI0NQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0NQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 09:16:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354A5C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so6103824ljd.10
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WiR7Hb4i3YmxO4bXLMHG8A8PTI3jQ/wOd4ke80+KSQo=;
        b=MA53YT8c/9QAOKCdWKJR9icDqRbpvBj6Fsl+kpcFxWJYl9UT+7HOvOzeewm3UIc1RR
         Io2xm0lHundsOIZLRrqb+GlzijcTsq9Yd/5U/zV2YHY7OMhTzKA2ezbAjupv82xZH0bY
         /r5wgGtb8YN1igKuy45rjHQ836VyH/gGR2ECu9wpuKG989RVGgR/NLYV5bXdO9pzGmVt
         yvAflw9KVeieN7PZFRl4KbwssxwIFexLW1g9xC+6hpB1YYSC0dvVWWxuyxWvakwT5Irl
         VYZ005NSnCx8kgnVBCsNSegQgde3RT1k/9+mcUf+AYnnK76ELDvlD8jS75msqVHfbhN3
         hPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WiR7Hb4i3YmxO4bXLMHG8A8PTI3jQ/wOd4ke80+KSQo=;
        b=T5ZeqaGi2R5Js65j6oVSOZmgnUhQsmAUBf0StRKtrg4GhyCTX7n7TLcSNmVxygwNXH
         cU/cViGaq02p1LFbCpZ9gr+wBA6WQeBRjoRvZYlmohuG5j6/DFMkhEkrs+tQeQ+6J0bd
         tWV4Lz5QAnHGdnnIMyUaeDJ8ycIoz3Ug7v9DmwcilsNUGz1BvBTSewM2P84obx6mukDy
         C6gNC208N+E/q3a4CkoafS/irstBcI3KzNt1GijEI7fASmmxPCvQdHxx8DtPFdbZWJkA
         4B+SrGMTM8O9YFBOIvO1tBZfB0AvKQ0whRLCMmMYlN0k69+uifWSgYgZ4q1EhADyT6Dz
         /rrg==
X-Gm-Message-State: AOAM530l/VdZVb6D1U8r1oZcj/ZZ1I/Vo9ioaNAdey+JHJMK6wEWE+SO
        43g1rJcxtx6NlIMlqMqrIn5PyXDXliM=
X-Google-Smtp-Source: ABdhPJyIDOZijgdsEdBU3XbePqRlRf9voUsLDmQnACzjflQpSq4Wg/hGgb0dO4WALD8ANfCoPHoVzQ==
X-Received: by 2002:a2e:575d:: with SMTP id r29mr1453483ljd.183.1601212568172;
        Sun, 27 Sep 2020 06:16:08 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o8sm2487616lfa.44.2020.09.27.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 06:16:07 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 2/7] wt-status: print to s->fp, not stdout
Date:   Sun, 27 Sep 2020 15:15:42 +0200
Message-Id: <7ada884d7c61b4ae6fd002d93a5ac982a63071b7.1600281351.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1600281350.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com> <cover.1600281350.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pass around a `FILE *` in the `struct wt_status` and almost always
print to it. But in a few places, we write to `stdout` instead, either
explicitly through `fprintf(stdout, ...)` or implicitly with
`printf(...)` (and a few `putchar(...)`).

Always be explicit about writing to `s->fp`. To the best of my
understanding, this never mattered in practice because these spots are
involved in various forms of `git status` which always end up at
standard output anyway. When we do write to another file, it's because
we're creating a commit message template, and these code paths aren't
involved.

But let's be consistent to help future readers and avoid future bugs.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 wt-status.c | 57 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 59be457015..3e0b5d8017 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1806,29 +1806,36 @@ static void wt_longstatus_print(struct wt_status *s)
 			; /* nothing */
 		else if (s->workdir_dirty) {
 			if (s->hints)
-				printf(_("no changes added to commit "
-					 "(use \"git add\" and/or \"git commit -a\")\n"));
+				fprintf(s->fp, _("no changes added to commit "
+						 "(use \"git add\" and/or "
+						 "\"git commit -a\")\n"));
 			else
-				printf(_("no changes added to commit\n"));
+				fprintf(s->fp, _("no changes added to "
+						 "commit\n"));
 		} else if (s->untracked.nr) {
 			if (s->hints)
-				printf(_("nothing added to commit but untracked files "
-					 "present (use \"git add\" to track)\n"));
+				fprintf(s->fp, _("nothing added to commit but "
+						 "untracked files present (use "
+						 "\"git add\" to track)\n"));
 			else
-				printf(_("nothing added to commit but untracked files present\n"));
+				fprintf(s->fp, _("nothing added to commit but "
+						 "untracked files present\n"));
 		} else if (s->is_initial) {
 			if (s->hints)
-				printf(_("nothing to commit (create/copy files "
-					 "and use \"git add\" to track)\n"));
+				fprintf(s->fp, _("nothing to commit (create/"
+						 "copy files and use \"git "
+						 "add\" to track)\n"));
 			else
-				printf(_("nothing to commit\n"));
+				fprintf(s->fp, _("nothing to commit\n"));
 		} else if (!s->show_untracked_files) {
 			if (s->hints)
-				printf(_("nothing to commit (use -u to show untracked files)\n"));
+				fprintf(s->fp, _("nothing to commit (use -u to "
+						 "show untracked files)\n"));
 			else
-				printf(_("nothing to commit\n"));
+				fprintf(s->fp, _("nothing to commit\n"));
 		} else
-			printf(_("nothing to commit, working tree clean\n"));
+			fprintf(s->fp, _("nothing to commit, working tree "
+					 "clean\n"));
 	}
 	if(s->show_stash)
 		wt_longstatus_print_stash_summary(s);
@@ -1851,12 +1858,12 @@ static void wt_shortstatus_unmerged(struct string_list_item *it,
 	}
 	color_fprintf(s->fp, color(WT_STATUS_UNMERGED, s), "%s", how);
 	if (s->null_termination) {
-		fprintf(stdout, " %s%c", it->string, 0);
+		fprintf(s->fp, " %s%c", it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		one = quote_path(it->string, s->prefix, &onebuf);
-		printf(" %s\n", one);
+		fprintf(s->fp, " %s\n", one);
 		strbuf_release(&onebuf);
 	}
 }
@@ -1869,16 +1876,16 @@ static void wt_shortstatus_status(struct string_list_item *it,
 	if (d->index_status)
 		color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%c", d->index_status);
 	else
-		putchar(' ');
+		fputc(' ', s->fp);
 	if (d->worktree_status)
 		color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%c", d->worktree_status);
 	else
-		putchar(' ');
-	putchar(' ');
+		fputc(' ', s->fp);
+	fputc(' ', s->fp);
 	if (s->null_termination) {
-		fprintf(stdout, "%s%c", it->string, 0);
+		fprintf(s->fp, "%s%c", it->string, 0);
 		if (d->rename_source)
-			fprintf(stdout, "%s%c", d->rename_source, 0);
+			fprintf(s->fp, "%s%c", d->rename_source, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
@@ -1886,20 +1893,20 @@ static void wt_shortstatus_status(struct string_list_item *it,
 		if (d->rename_source) {
 			one = quote_path(d->rename_source, s->prefix, &onebuf);
 			if (*one != '"' && strchr(one, ' ') != NULL) {
-				putchar('"');
+				fputc('"', s->fp);
 				strbuf_addch(&onebuf, '"');
 				one = onebuf.buf;
 			}
-			printf("%s -> ", one);
+			fprintf(s->fp, "%s -> ", one);
 			strbuf_release(&onebuf);
 		}
 		one = quote_path(it->string, s->prefix, &onebuf);
 		if (*one != '"' && strchr(one, ' ') != NULL) {
-			putchar('"');
+			fputc('"', s->fp);
 			strbuf_addch(&onebuf, '"');
 			one = onebuf.buf;
 		}
-		printf("%s\n", one);
+		fprintf(s->fp, "%s\n", one);
 		strbuf_release(&onebuf);
 	}
 }
@@ -1908,13 +1915,13 @@ static void wt_shortstatus_other(struct string_list_item *it,
 				 struct wt_status *s, const char *sign)
 {
 	if (s->null_termination) {
-		fprintf(stdout, "%s %s%c", sign, it->string, 0);
+		fprintf(s->fp, "%s %s%c", sign, it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		one = quote_path(it->string, s->prefix, &onebuf);
 		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
-		printf(" %s\n", one);
+		fprintf(s->fp, " %s\n", one);
 		strbuf_release(&onebuf);
 	}
 }
-- 
2.28.0.277.g9b3c35fffd

