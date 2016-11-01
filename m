Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2152022A
	for <e@80x24.org>; Tue,  1 Nov 2016 20:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932215AbcKAUIk (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:08:40 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36695 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754575AbcKAUIi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:08:38 -0400
Received: by mail-pf0-f181.google.com with SMTP id 189so46904114pfz.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CTfo1ULDPWZB8fbBG7GEmnhR6yaRgvj/VFSF2P/siH8=;
        b=QtuNgylZ7N8kpMNKxZu4P7frchCvUjMQpvN0yfNEYEQLRKa9lqLF0KiLKDlfnYIlwe
         4zwt46zjjvLTjCkJyUAqsoQOGw10av0/zCQMnvRBQ2AQfMu62nWHBNJ8LvRaBR9Q4kR1
         MpkFhE2uWBhU/KC9Spx7wyjbWcLX+akuoB9c3Df7sMOwDe1Yk6MlHOpt5+KrpP7hcG86
         rpEtk0Lx6lvWGAvUsaABzhsY9SmB6NzglazT7/Nj3JdNpF7YdujvzRx5YniDTlPrsG31
         baJuilxHjHQrC2mENeaPbWBnwGpyqLu5DHC4WhGNipOhSGxo4F1Iwx4uOjAuRzgf+fFW
         Mwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CTfo1ULDPWZB8fbBG7GEmnhR6yaRgvj/VFSF2P/siH8=;
        b=Di0rD/ToXpZunbo3aVPNyjn6jGB32reJ/03IZpLpt1CNZNgzmc7qX3oHqq/6nsUtuY
         7QnL9DF1qsPvr2Gt2q4Ywobj/AbDlkrjngAIxR6xOGLnQxx490Qd91qyYPx2cwkl7NW6
         gP0CURrTXq+rFUvhFxmiGYHKbej1GJRyDZNxHAjGW2KJB9FapOLZbCsOuvPe0XLauD1V
         xtNyXQ3eRs1cT6lvR71jW4puLW55gK/gn0RMWZj9zksJXxcUeDyvllL5xaDpRkf3VYsx
         zolE9w+Ggr3m+d/xDg0GbG0pQSK9305Auotn7TQjOccQ8vXfiP9Tr2L2MlKJJ9OIthFG
         KxSg==
X-Gm-Message-State: ABUngvfIH4b9ZRRmxM0rAO4MdiBZ9G27Z0vSzOSzjM6XZsjS86CFxMpbhr5LYWX3BjP4ujF2
X-Received: by 10.98.93.83 with SMTP id r80mr62239139pfb.17.1478030917638;
        Tue, 01 Nov 2016 13:08:37 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id v4sm44093272pfb.52.2016.11.01.13.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Nov 2016 13:08:36 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        christian.couder@gmail.com
Subject: [PATCH v2 4/5] trailer: have function to describe trailer layout
Date:   Tue,  1 Nov 2016 13:08:24 -0700
Message-Id: <7104681617f0214af77a218120658e51144aaac2.1478028700.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1478028700.git.jonathantanmy@google.com>
References: <cover.1478028700.git.jonathantanmy@google.com>
In-Reply-To: <cover.1478028700.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com> <cover.1478028700.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a function that, taking a string, describes the position of its
trailer block (if available) and the contents thereof, and make trailer
use it. This makes it easier for other Git components, in the future, to
interpret trailer blocks in the same way as trailer.

In a subsequent patch, another component will be made to use this.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 118 +++++++++++++++++++++++++++++++++++++++++++-------------------
 trailer.h |  25 +++++++++++++
 2 files changed, 107 insertions(+), 36 deletions(-)

diff --git a/trailer.c b/trailer.c
index f5427ec..7265a50 100644
--- a/trailer.c
+++ b/trailer.c
@@ -46,6 +46,8 @@ static LIST_HEAD(conf_head);
 
 static char *separators = ":";
 
+static int configured;
+
 #define TRAILER_ARG_STRING "$ARG"
 
 static const char *git_generated_prefixes[] = {
@@ -546,6 +548,17 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	return 0;
 }
 
+static void ensure_configured(void)
+{
+	if (configured)
+		return;
+
+	/* Default config must be setup first */
+	git_config(git_trailer_default_config, NULL);
+	git_config(git_trailer_config, NULL);
+	configured = 1;
+}
+
 static const char *token_from_item(struct arg_item *item, char *tok)
 {
 	if (item->conf.key)
@@ -870,59 +883,43 @@ static int process_input_file(FILE *outfile,
 			      const char *str,
 			      struct list_head *head)
 {
-	int patch_start, trailer_start, trailer_end;
+	struct trailer_info info;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
-	struct trailer_item *last = NULL;
-	struct strbuf *trailer, **trailer_lines, **ptr;
+	int i;
 
-	patch_start = find_patch_start(str);
-	trailer_end = find_trailer_end(str, patch_start);
-	trailer_start = find_trailer_start(str, trailer_end);
+	trailer_info_get(&info, str);
 
 	/* Print lines before the trailers as is */
-	fwrite(str, 1, trailer_start, outfile);
+	fwrite(str, 1, info.trailer_start - str, outfile);
 
-	if (!ends_with_blank_line(str, trailer_start))
+	if (!info.blank_line_before_trailer)
 		fprintf(outfile, "\n");
 
-	/* Parse trailer lines */
-	trailer_lines = strbuf_split_buf(str + trailer_start,
-					 trailer_end - trailer_start,
-					 '\n',
-					 0);
-	for (ptr = trailer_lines; *ptr; ptr++) {
+	for (i = 0; i < info.trailer_nr; i++) {
 		int separator_pos;
-		trailer = *ptr;
-		if (trailer->buf[0] == comment_line_char)
-			continue;
-		if (last && isspace(trailer->buf[0])) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addf(&sb, "%s\n%s", last->value, trailer->buf);
-			strbuf_strip_suffix(&sb, "\n");
-			free(last->value);
-			last->value = strbuf_detach(&sb, NULL);
+		char *trailer = info.trailers[i];
+		if (trailer[0] == comment_line_char)
 			continue;
-		}
-		separator_pos = find_separator(trailer->buf, separators);
+		separator_pos = find_separator(trailer, separators);
 		if (separator_pos >= 1) {
-			parse_trailer(&tok, &val, NULL, trailer->buf,
+			parse_trailer(&tok, &val, NULL, trailer,
 				      separator_pos);
-			last = add_trailer_item(head,
-						strbuf_detach(&tok, NULL),
-						strbuf_detach(&val, NULL));
+			add_trailer_item(head,
+					 strbuf_detach(&tok, NULL),
+					 strbuf_detach(&val, NULL));
 		} else {
-			strbuf_addbuf(&val, trailer);
+			strbuf_addstr(&val, trailer);
 			strbuf_strip_suffix(&val, "\n");
 			add_trailer_item(head,
 					 NULL,
 					 strbuf_detach(&val, NULL));
-			last = NULL;
 		}
 	}
-	strbuf_list_free(trailer_lines);
 
-	return trailer_end;
+	trailer_info_release(&info);
+
+	return info.trailer_end - str;
 }
 
 static void free_all(struct list_head *head)
@@ -973,9 +970,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 	int trailer_end;
 	FILE *outfile = stdout;
 
-	/* Default config must be setup first */
-	git_config(git_trailer_default_config, NULL);
-	git_config(git_trailer_config, NULL);
+	ensure_configured();
 
 	read_input_file(&sb, file);
 
@@ -1002,3 +997,54 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 
 	strbuf_release(&sb);
 }
+
+void trailer_info_get(struct trailer_info *info, const char *str)
+{
+	int patch_start, trailer_end, trailer_start;
+	struct strbuf **trailer_lines, **ptr;
+	char **trailer_strings = NULL;
+	size_t nr = 0, alloc = 0;
+	char **last = NULL;
+
+	ensure_configured();
+
+	patch_start = find_patch_start(str);
+	trailer_end = find_trailer_end(str, patch_start);
+	trailer_start = find_trailer_start(str, trailer_end);
+
+	trailer_lines = strbuf_split_buf(str + trailer_start,
+					 trailer_end - trailer_start,
+					 '\n',
+					 0);
+	for (ptr = trailer_lines; *ptr; ptr++) {
+		if (last && isspace((*ptr)->buf[0])) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
+			strbuf_addbuf(&sb, *ptr);
+			*last = strbuf_detach(&sb, NULL);
+			continue;
+		}
+		ALLOC_GROW(trailer_strings, nr + 1, alloc);
+		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
+		last = find_separator(trailer_strings[nr], separators) >= 1
+			? &trailer_strings[nr]
+			: NULL;
+		nr++;
+	}
+	strbuf_list_free(trailer_lines);
+
+	info->blank_line_before_trailer = ends_with_blank_line(str,
+							       trailer_start);
+	info->trailer_start = str + trailer_start;
+	info->trailer_end = str + trailer_end;
+	info->trailers = trailer_strings;
+	info->trailer_nr = nr;
+}
+
+void trailer_info_release(struct trailer_info *info)
+{
+	int i;
+	for (i = 0; i < info->trailer_nr; i++)
+		free(info->trailers[i]);
+	free(info->trailers);
+}
diff --git a/trailer.h b/trailer.h
index 36b40b8..65cc5d7 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,7 +1,32 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
+struct trailer_info {
+	/*
+	 * True if there is a blank line before the location pointed to by
+	 * trailer_start.
+	 */
+	int blank_line_before_trailer;
+
+	/*
+	 * Pointers to the start and end of the trailer block found. If there
+	 * is no trailer block found, these 2 pointers point to the end of the
+	 * input string.
+	 */
+	const char *trailer_start, *trailer_end;
+
+	/*
+	 * Array of trailers found.
+	 */
+	char **trailers;
+	size_t trailer_nr;
+};
+
 void process_trailers(const char *file, int in_place, int trim_empty,
 		      struct string_list *trailers);
 
+void trailer_info_get(struct trailer_info *info, const char *str);
+
+void trailer_info_release(struct trailer_info *info);
+
 #endif /* TRAILER_H */
-- 
2.8.0.rc3.226.g39d4020

