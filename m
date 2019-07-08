Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CCD21F4B6
	for <e@80x24.org>; Mon,  8 Jul 2019 16:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfGHQiE (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:38:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46522 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbfGHQiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:38:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so13241385wru.13
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9Ry3Zo4zxEby1ZExhKlJuGseE+5GTYe7uDjz1FQhgQ=;
        b=rNEk70a5UmmrrU3C1sfCAyk3zaDmk/pV6hURJ1xbxLy6xl8D50rIx0y4DZoZJJfwyE
         FbuEfxpLAGwTexn1C658t3Kdvktes3doa8MotxZj8gK7UCJ94mctV9k2MoE3PstU3ukN
         4CuLKVDP1CS/BS0f1XHu7jWpOUe+H3/lYkiA9UlW2vQhgyKKHU90m8vpxFD4JqPgXpRm
         zLenyiYbNB/UpAXBZ/bCWuokN2IIE6/IFeHGC3lkTj7d91Xut4beiB7tZdz8nOIWM2wL
         eUi2gZvAsp5pRM1l9QqwA9v2/qt6ijLZ1T31Ws7gkl3aMUxkWItbulTRVpPbOim+H/vA
         Oi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9Ry3Zo4zxEby1ZExhKlJuGseE+5GTYe7uDjz1FQhgQ=;
        b=iu2pIcKxTbGcJyg3+hQm9W0FOKLjndi73wDMj92VCq5w6actVSNcHv4v6htivslMwl
         BGFjDPH4IiYDTzcJldNYpw7rGJWYC1T4i+k9zYYm/sCLvmOkzbPRzxqkvqKbyyVfhGmB
         w/SL4NMhq6cqvvvu8dhjbGQP3S8p6dsyhUMoJnkrtKkVE1oggozYYDC1NUlM/LOvMuSr
         H+Ic4KcKcoHNIAkfUGc5gQqcA1FvajKjVHkSIv8bR4M7r8GCSxDl+xbIn1jCugxeMMQc
         Wex2i8BzHnE/JQEQAnckJulNSCtiy67JyqLgJUm9fCJAtZMSIp55BRV8D8PenuVlOOll
         OqJQ==
X-Gm-Message-State: APjAAAVnmU93FZsDj2xLj2W3dnpqXwcR3tdzjPNzTriJKMWhU2dso2es
        MG835UGmhHZANtAh+pvyZF4G+zS+
X-Google-Smtp-Source: APXvYqxyMSjwBhiQbyIeZKy8nPKZWfkk1+m9YCzI1n5sx7twK21W1vEA8cgpleGprZyIE4YO8oYbCQ==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr20522389wrp.292.1562603880837;
        Mon, 08 Jul 2019 09:38:00 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id c78sm117611wmd.16.2019.07.08.09.37.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:38:00 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 07/14] apply: make parse_git_header public
Date:   Mon,  8 Jul 2019 17:33:08 +0100
Message-Id: <20190708163315.29912-8-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make parse_git_header a "public" function in apply.h, so we can re-use
it in range-diff in a subsequent commit.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 69 ++++++++++++++++-----------------------------------------
 apply.h | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 50 deletions(-)

diff --git a/apply.c b/apply.c
index 468f1d3fee..32b5b072ee 100644
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
 	struct parse_git_header_state parse_hdr_state;
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
 			int (*fn)(struct parse_git_header_state *, const char *, struct patch *);
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
index 5948348133..ade50f66c5 100644
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
+ * Parse a get header, starting at line.  Fills the relevant metadata
+ * information in 'struct patch'.
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

