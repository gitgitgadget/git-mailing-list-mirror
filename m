Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F6E20193
	for <e@80x24.org>; Wed,  2 Nov 2016 17:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756644AbcKBR3n (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 13:29:43 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35066 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756610AbcKBR3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 13:29:35 -0400
Received: by mail-pf0-f176.google.com with SMTP id i88so15272062pfk.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=a0pTLHW/z40lbiwcrUPV0M9U06SP1JsyTOo0tzTe4XE=;
        b=R3LHffwutWcK6Q8d2M1CcoZFna7yQG9KS5Ca4InVWVNlm5WgouD03mA6Rd3r6UHPT5
         iTdLpRJH0WShaQWyp8tJ8A4nFJzARDsYpBVfWhsUvBjozj5zCAHYASJRClLuXQt1OL2D
         7eHbgeV1fcsH88Qoox3oBJ5LgMQeKS4ibOEkb+wKTY+0Ho6P3MX538S2dnFR2zZtMwbP
         /ObuxANB4z9dtZ4U0xfSKXpz8JIciW4Z5oz0jJt8936w7weF3UMUluSa1BVr099FLX+I
         y5YVwB4UmoWsDVt+JMlU8xR4Rdw02w1tGG1aPAdlhs/iZr74+Odi5EnDn1KqQtPcHlqO
         aiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=a0pTLHW/z40lbiwcrUPV0M9U06SP1JsyTOo0tzTe4XE=;
        b=fDf13LVNTmZtAXUUXS0+4iUf3tSSrDFWnmZLJO6JlR3/HiDj48Zqee219BnukRDe6u
         pDItNhTCAq5GBl3xhP8lv+BaHqr1psy/tlYnqk2BNPvxUGdtrkKC+yd0uvpX500SijSE
         tQuy4VGJQBBgWqaSGbBPkDOML2R2O9MW6sSCVRafXm25jTiaUvJ6oC+UxRbEQuW1UEmv
         F/f8ZoA4EofOd1j9nQ38YK8P6SRb6CksM+ieVJEE/WJbB/vyi6t3p2cvu0dYpd0GBilv
         eDSDt6Ubt3vxHNIDOyJr8usH7YxpaF0zopXrjTXIvqgt4mIDMtS/ee/P2kyiQEi05dPX
         3FcA==
X-Gm-Message-State: ABUngvdA1KcgbeAkGXYtLBONmi1u1PAJaZNcn/zmABEhyBWW3IaRt/AI3rQsFRLPREIntdMa
X-Received: by 10.99.104.68 with SMTP id d65mr1270220pgc.52.1478107775014;
        Wed, 02 Nov 2016 10:29:35 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id f23sm6185167pff.59.2016.11.02.10.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 10:29:33 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 4/5] trailer: have function to describe trailer layout
Date:   Wed,  2 Nov 2016 10:29:19 -0700
Message-Id: <c64edee1f44562f38e4e92f1efb0c2267ef3222a.1478107666.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1478107666.git.jonathantanmy@google.com>
References: <cover.1478107666.git.jonathantanmy@google.com>
In-Reply-To: <cover.1478107666.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com> <cover.1478107666.git.jonathantanmy@google.com>
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
index afbff4b..bc6893b 100644
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
@@ -873,59 +886,43 @@ static int process_input_file(FILE *outfile,
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
@@ -976,9 +973,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 	int trailer_end;
 	FILE *outfile = stdout;
 
-	/* Default config must be setup first */
-	git_config(git_trailer_default_config, NULL);
-	git_config(git_trailer_config, NULL);
+	ensure_configured();
 
 	read_input_file(&sb, file);
 
@@ -1005,3 +1000,54 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 
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

