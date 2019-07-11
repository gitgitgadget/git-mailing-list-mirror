Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23F3B1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfGKQJP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51001 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfGKQJN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so6256145wml.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuVebWK5oI4Mo7NW3DvUVzOVzu7xvxJpZthVHUaS+bc=;
        b=ewJ+lCiVT0Ix4XhYMx9sVGy3uvhGRt4i0YovRteqZeHs5DiPZ33ppxwWGQFC2U8sAT
         v+Nvy+UA4gnafxZMf+F+CGTxy3LyZsJGR5f24OKP1s43+i0Cs3CG1Gu7yMO+YivkfR6b
         XJrDrenh3TCFXgl51KW86qUp5sYEIX26hkAgFUyUymrnQUO0oKN/iZ/YDZTgEWqD9r4J
         MELs/RiPiOc2cz+yMbTk/2spSmGxh6b+YO8IPcg543oW/9BH3VlMw+DRlweBtrKWgvOy
         bCvwpoVuodkZTz4GsLnHdwE4D2gCPcw2zrKVwZ2YVRKusYnu5CZmcI2nwkqKt/6XOVbg
         XD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuVebWK5oI4Mo7NW3DvUVzOVzu7xvxJpZthVHUaS+bc=;
        b=RLDhyDGSqe9Gyh+COUoBQhwyD0LaVKYOnjM3XRE4CczselzChWdxAUA/3TENlTHYEg
         tYmHZ7nQjP4sj7/t4tZME/2PYqT2/Yo2jZ7dwnIvgePgA/hqPWbIKpkgrWv5h9/k2WEF
         Jfvi1QgVvyIIPzndjVpBg8DnVs9ubCEIb8mvKYcxCDhvPILpqihz+q2jvto7kJa5wYYZ
         C0YilF/Wkh0EymCKUgETAi9CjJCmlr3PXiG9Hx4HEIMTxhegq8hh4hPyccDSKaUBAh5U
         SmaLvzJVVbe0K/BctWMZFLUftOLpuc81r9/GtIR1WlGGcpCael1YypwXcqPH8IpZix5j
         tYjQ==
X-Gm-Message-State: APjAAAVniZd9Wv++z2eQcBN5GVi/B2tYTYVucx5/2weRwXGR6l4TcJvY
        uKMo43312ENJL/Q4PvV86JomWkgnOvo=
X-Google-Smtp-Source: APXvYqxegx7e9VIRxjBATHr+NWiHunRnnDH+s+uxMXjAoUmZQcrlKpMTTA72KstEHwoOcAqvcL5SWg==
X-Received: by 2002:a1c:18d:: with SMTP id 135mr4905040wmb.171.1562861350392;
        Thu, 11 Jul 2019 09:09:10 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id a67sm4842254wmh.40.2019.07.11.09.09.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:09:09 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 07/14] apply: make parse_git_diff_header public
Date:   Thu, 11 Jul 2019 17:08:44 +0100
Message-Id: <20190711160851.14380-8-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190711160851.14380-1-t.gummerer@gmail.com>
References: <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190711160851.14380-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make 'parse_git_header()' (renamed to 'parse_git_diff_header()') a
"public" function in apply.h, so we can re-use it in range-diff in a
subsequent commit.  We're renaming the function to make it clearer in
other parts of the codebase that we're talking about a diff header and
not just any header.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 69 ++++++++++++++++-----------------------------------------
 apply.h | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 50 deletions(-)

diff --git a/apply.c b/apply.c
index 034d134dd5..d68a6acad7 100644
--- a/apply.c
+++ b/apply.c
@@ -207,40 +207,6 @@ struct fragment {
 #define BINARY_DELTA_DEFLATED	1
 #define BINARY_LITERAL_DEFLATED 2
 
-/*
- * This represents a "patch" to a file, both metainfo changes
- * such as creation/deletion, filemode and content changes represented
- * as a series of fragments.
- */
-struct patch {
-	char *new_name, *old_name, *def_name;
-	unsigned int old_mode, new_mode;
-	int is_new, is_delete;	/* -1 = unknown, 0 = false, 1 = true */
-	int rejected;
-	unsigned ws_rule;
-	int lines_added, lines_deleted;
-	int score;
-	int extension_linenr; /* first line specifying delete/new/rename/copy */
-	unsigned int is_toplevel_relative:1;
-	unsigned int inaccurate_eof:1;
-	unsigned int is_binary:1;
-	unsigned int is_copy:1;
-	unsigned int is_rename:1;
-	unsigned int recount:1;
-	unsigned int conflicted_threeway:1;
-	unsigned int direct_to_threeway:1;
-	unsigned int crlf_in_old:1;
-	struct fragment *fragments;
-	char *result;
-	size_t resultsize;
-	char old_oid_prefix[GIT_MAX_HEXSZ + 1];
-	char new_oid_prefix[GIT_MAX_HEXSZ + 1];
-	struct patch *next;
-
-	/* three-way fallback result */
-	struct object_id threeway_stage[3];
-};
-
 static void free_fragment_list(struct fragment *list)
 {
 	while (list) {
@@ -1320,12 +1286,13 @@ static int check_header_line(int linenr, struct patch *patch)
 	return 0;
 }
 
-/* Verify that we recognize the lines following a git header */
-static int parse_git_header(struct apply_state *state,
-			    const char *line,
-			    int len,
-			    unsigned int size,
-			    struct patch *patch)
+int parse_git_diff_header(struct strbuf *root,
+			  int *linenr,
+			  int p_value,
+			  const char *line,
+			  int len,
+			  unsigned int size,
+			  struct patch *patch)
 {
 	unsigned long offset;
 	struct gitdiff_data parse_hdr_state;
@@ -1340,21 +1307,21 @@ static int parse_git_header(struct apply_state *state,
 	 * or removing or adding empty files), so we get
 	 * the default name from the header.
 	 */
-	patch->def_name = git_header_name(state->p_value, line, len);
-	if (patch->def_name && state->root.len) {
-		char *s = xstrfmt("%s%s", state->root.buf, patch->def_name);
+	patch->def_name = git_header_name(p_value, line, len);
+	if (patch->def_name && root->len) {
+		char *s = xstrfmt("%s%s", root->buf, patch->def_name);
 		free(patch->def_name);
 		patch->def_name = s;
 	}
 
 	line += len;
 	size -= len;
-	state->linenr++;
-	parse_hdr_state.root = &state->root;
-	parse_hdr_state.linenr = state->linenr;
-	parse_hdr_state.p_value = state->p_value;
+	(*linenr)++;
+	parse_hdr_state.root = root;
+	parse_hdr_state.linenr = *linenr;
+	parse_hdr_state.p_value = p_value;
 
-	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, state->linenr++) {
+	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, (*linenr)++) {
 		static const struct opentry {
 			const char *str;
 			int (*fn)(struct gitdiff_data *, const char *, struct patch *);
@@ -1391,7 +1358,7 @@ static int parse_git_header(struct apply_state *state,
 			res = p->fn(&parse_hdr_state, line + oplen, patch);
 			if (res < 0)
 				return -1;
-			if (check_header_line(state->linenr, patch))
+			if (check_header_line(*linenr, patch))
 				return -1;
 			if (res > 0)
 				return offset;
@@ -1572,7 +1539,9 @@ static int find_header(struct apply_state *state,
 		 * or mode change, so we handle that specially
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
-			int git_hdr_len = parse_git_header(state, line, len, size, patch);
+			int git_hdr_len = parse_git_diff_header(&state->root, &state->linenr,
+								state->p_value, line, len,
+								size, patch);
 			if (git_hdr_len < 0)
 				return -128;
 			if (git_hdr_len <= len)
diff --git a/apply.h b/apply.h
index 5948348133..a795193435 100644
--- a/apply.h
+++ b/apply.h
@@ -117,6 +117,40 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
+/*
+ * This represents a "patch" to a file, both metainfo changes
+ * such as creation/deletion, filemode and content changes represented
+ * as a series of fragments.
+ */
+struct patch {
+	char *new_name, *old_name, *def_name;
+	unsigned int old_mode, new_mode;
+	int is_new, is_delete;	/* -1 = unknown, 0 = false, 1 = true */
+	int rejected;
+	unsigned ws_rule;
+	int lines_added, lines_deleted;
+	int score;
+	int extension_linenr; /* first line specifying delete/new/rename/copy */
+	unsigned int is_toplevel_relative:1;
+	unsigned int inaccurate_eof:1;
+	unsigned int is_binary:1;
+	unsigned int is_copy:1;
+	unsigned int is_rename:1;
+	unsigned int recount:1;
+	unsigned int conflicted_threeway:1;
+	unsigned int direct_to_threeway:1;
+	unsigned int crlf_in_old:1;
+	struct fragment *fragments;
+	char *result;
+	size_t resultsize;
+	char old_oid_prefix[GIT_MAX_HEXSZ + 1];
+	char new_oid_prefix[GIT_MAX_HEXSZ + 1];
+	struct patch *next;
+
+	/* three-way fallback result */
+	struct object_id threeway_stage[3];
+};
+
 int apply_parse_options(int argc, const char **argv,
 			struct apply_state *state,
 			int *force_apply, int *options,
@@ -127,6 +161,20 @@ int init_apply_state(struct apply_state *state,
 void clear_apply_state(struct apply_state *state);
 int check_apply_state(struct apply_state *state, int force_apply);
 
+/*
+ * Parse a git diff header, starting at line.  Fills the relevant
+ * metadata information in 'struct patch'.
+ *
+ * Returns -1 on failure, the length of the parsed header otherwise.
+ */
+int parse_git_diff_header(struct strbuf *root,
+			  int *linenr,
+			  int p_value,
+			  const char *line,
+			  int len,
+			  unsigned int size,
+			  struct patch *patch);
+
 /*
  * Some aspects of the apply behavior are controlled by the following
  * bits in the "options" parameter passed to apply_all_patches().
-- 
2.22.0.510.g264f2c817a

