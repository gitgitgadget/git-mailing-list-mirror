From: David Barr <davidbarr@google.com>
Subject: [PATCH 3/7] vcs-svn: fix signedness warnings
Date: Fri, 25 May 2012 00:04:15 +1000
Message-ID: <1337868259-45626-4-git-send-email-davidbarr@google.com>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 24 16:05:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYfZ-0003mX-Fo
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093Ab2EXOFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:05:33 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60207 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab2EXOFc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:05:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so302227pbb.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=avlCCe1+iBuNcM3ooCIT3U8ix6XcNGzUas5sh0rfeRY=;
        b=iTLcWiWQCiIP6hs4CAFJQA3uvLGE8e9IYgQZR8cn/hpkqi+Ir/l9CPCd4QNx/NIJZL
         p2lF5xoPKyro+rYSjK+4RvGsT9JvgE7yfH+CFyUebAI9ssfppcB9OiJUH4PbPkn3rFbr
         Vg0XQMZ5smmfkhR7IZCLx8vCq1QuS/3YSoIBRwkm/7fRGAVAckstA2AqR7QYkZMHw8Nm
         kFutRp1HDsBsKI1TcM37GsLELLX6fe1DdMht+yzgFz3qfheUraf8Z8NMnOM/vPBEgxcA
         LwcplGyoSGIhMmUMnSrRJOndUIH3gHjsZz85LldRs7xg3NDS6XRIEbJqrzCfqj7rDWTA
         USHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=avlCCe1+iBuNcM3ooCIT3U8ix6XcNGzUas5sh0rfeRY=;
        b=dGAiJm57JbO3HkLtlgdZJPjNIbg+lK3p5hAUZ0ob4Xw/gcZnCoQ0u8o/sbz9NFFyf2
         5dwu41ChK0W/j5up5y+J/kRJn6XmAIPXZMds9M/Hgq4uxWsogewDkoO53J3Wc8aAWNVt
         +Es7sEPuHF8ZwetM9PZEChiPq3JTUhcNnZ9S8GODyoy2jGP1Datv0aYrf2lmxA/ZAFtC
         gY0yLXWhNbFrmCyBJ3tP0wACsprLvOpNzGdhs3TV7xBycO/L/AJ0NkQxmeZlCf/3Q0EZ
         QB3XgPVoCdioa3wXllnzmFh6bexoQxNRrmgX1bUPLpdGtYxRPhTbFZCrjeKfxndEmiAP
         6xVA==
Received: by 10.68.135.229 with SMTP id pv5mr21814152pbb.70.1337868331656;
        Thu, 24 May 2012 07:05:31 -0700 (PDT)
Received: by 10.68.135.229 with SMTP id pv5mr21814123pbb.70.1337868331483;
        Thu, 24 May 2012 07:05:31 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id rv8sm5565332pbc.64.2012.05.24.07.05.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:05:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337868259-45626-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQmh9PKcacFFx6kzywnLhAWUF1iqnI4Yq7mEVay5G4bj/XY+XQQm1xVT+cwR8kScQd/HLGbLzy2rk1Bm9Xc4QOdlXOeIX2r+YBvp8/taJRPgBLP2n5/8A2OX9tEaAXanfpPcwZtHKlH0waa6CSWznxSYiGqs/cnlGMyglb0ECHooQnp2cM8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198379>

Stop mixing off_t and size_t.

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/fast_export.c    |    4 ++--
 vcs-svn/line_buffer.c    |    3 +--
 vcs-svn/line_buffer.h    |    2 +-
 vcs-svn/sliding_window.c |    6 +++---
 vcs-svn/sliding_window.h |    4 ++--
 vcs-svn/svndiff.c        |   18 +++++++++---------
 vcs-svn/svndump.c        |    2 +-
 7 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index cda37dd..7396a91 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -259,7 +259,7 @@ static int parse_ls_response(const char *response, uint32_t *mode,
 	}
 
 	/* Mode. */
-	if (response_end - response < strlen("100644") ||
+	if (response_end - response < (off_t) strlen("100644") ||
 	    response[strlen("100644")] != ' ')
 		die("invalid ls response: missing mode: %s", response);
 	*mode = 0;
@@ -272,7 +272,7 @@ static int parse_ls_response(const char *response, uint32_t *mode,
 	}
 
 	/* ' blob ' or ' tree ' */
-	if (response_end - response < strlen(" blob ") ||
+	if (response_end - response < (off_t) strlen(" blob ") ||
 	    (response[1] != 'b' && response[1] != 't'))
 		die("unexpected ls response: not a tree or blob: %s", response);
 	response += strlen(" blob ");
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 01fcb84..b4104af 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -91,8 +91,7 @@ char *buffer_read_line(struct line_buffer *buf)
 	return buf->line_buffer;
 }
 
-size_t buffer_read_binary(struct line_buffer *buf,
-				struct strbuf *sb, size_t size)
+off_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, off_t size)
 {
 	return strbuf_fread(sb, size, buf->infile);
 }
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 8901f21..bf9a053 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -23,7 +23,7 @@ long buffer_tmpfile_prepare_to_read(struct line_buffer *buf);
 int buffer_ferror(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 int buffer_read_char(struct line_buffer *buf);
-size_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, size_t len);
+off_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, off_t len);
 /* Returns number of bytes read (not necessarily written). */
 off_t buffer_copy_bytes(struct line_buffer *buf, off_t len);
 off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index ec2707c..e67e85a 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -43,11 +43,11 @@ static int check_offset_overflow(off_t offset, uintmax_t len)
 	return 0;
 }
 
-int move_window(struct sliding_view *view, off_t off, size_t width)
+int move_window(struct sliding_view *view, off_t off, off_t width)
 {
 	off_t file_offset;
 	assert(view);
-	assert(view->width <= view->buf.len);
+	assert(view->width <= (off_t)(view->buf.len));
 	assert(!check_offset_overflow(view->off, view->buf.len));
 
 	if (check_offset_overflow(off, width))
@@ -68,7 +68,7 @@ int move_window(struct sliding_view *view, off_t off, size_t width)
 		strbuf_setlen(&view->buf, 0);
 	}
 
-	if (view->buf.len > width)
+	if ((off_t)(view->buf.len) > width)
 		; /* Already read. */
 	else if (read_to_fill_or_whine(view->file, &view->buf, width))
 		return -1;
diff --git a/vcs-svn/sliding_window.h b/vcs-svn/sliding_window.h
index b43a825..d21473a 100644
--- a/vcs-svn/sliding_window.h
+++ b/vcs-svn/sliding_window.h
@@ -6,13 +6,13 @@
 struct sliding_view {
 	struct line_buffer *file;
 	off_t off;
-	size_t width;
+	off_t width;
 	off_t max_off;	/* -1 means unlimited */
 	struct strbuf buf;
 };
 
 #define SLIDING_VIEW_INIT(input, len)	{ (input), 0, 0, (len), STRBUF_INIT }
 
-extern int move_window(struct sliding_view *view, off_t off, size_t width);
+extern int move_window(struct sliding_view *view, off_t off, off_t width);
 
 #endif
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 1647c1a..97d6967 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -75,7 +75,7 @@ static int error_short_read(struct line_buffer *input)
 }
 
 static int read_chunk(struct line_buffer *delta, off_t *delta_len,
-		      struct strbuf *buf, size_t len)
+		      struct strbuf *buf, off_t len)
 {
 	strbuf_reset(buf);
 	if (len > *delta_len ||
@@ -123,7 +123,7 @@ static int read_int(struct line_buffer *in, uintmax_t *result, off_t *len)
 	return error_short_read(in);
 }
 
-static int parse_int(const char **buf, size_t *result, const char *end)
+static int parse_int(const char **buf, off_t *result, const char *end)
 {
 	size_t rv = 0;
 	const char *pos;
@@ -165,9 +165,9 @@ static int read_length(struct line_buffer *in, size_t *result, off_t *len)
 }
 
 static int copyfrom_source(struct window *ctx, const char **instructions,
-			   size_t nbytes, const char *insns_end)
+			   off_t nbytes, const char *insns_end)
 {
-	size_t offset;
+	off_t offset;
 	if (parse_int(instructions, &offset, insns_end))
 		return -1;
 	if (unsigned_add_overflows(offset, nbytes) ||
@@ -180,10 +180,10 @@ static int copyfrom_source(struct window *ctx, const char **instructions,
 static int copyfrom_target(struct window *ctx, const char **instructions,
 			   size_t nbytes, const char *instructions_end)
 {
-	size_t offset;
+	off_t offset;
 	if (parse_int(instructions, &offset, instructions_end))
 		return -1;
-	if (offset >= ctx->out.len)
+	if (offset >= (off_t)(ctx->out.len))
 		return error("invalid delta: copies from the future");
 	for (; nbytes > 0; nbytes--)
 		strbuf_addch(&ctx->out, ctx->out.buf[offset++]);
@@ -201,9 +201,9 @@ static int copyfrom_data(struct window *ctx, size_t *data_pos, size_t nbytes)
 	return 0;
 }
 
-static int parse_first_operand(const char **buf, size_t *out, const char *end)
+static int parse_first_operand(const char **buf, off_t *out, const char *end)
 {
-	size_t result = (unsigned char) *(*buf)++ & OPERAND_MASK;
+	off_t result = (unsigned char) *(*buf)++ & OPERAND_MASK;
 	if (result) {	/* immediate operand */
 		*out = result;
 		return 0;
@@ -216,7 +216,7 @@ static int execute_one_instruction(struct window *ctx,
 {
 	unsigned int instruction;
 	const char *insns_end = ctx->instructions.buf + ctx->instructions.len;
-	size_t nbytes;
+	off_t nbytes;
 	assert(ctx);
 	assert(instructions && *instructions);
 	assert(data_pos);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 8d0ae9c..73706ae 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -34,7 +34,7 @@
 #define NODE_CTX 2	/* node metadata */
 #define INTERNODE_CTX 3	/* between nodes */
 
-#define LENGTH_UNKNOWN (~0)
+#define LENGTH_UNKNOWN (~0u)
 #define DATE_RFC2822_LEN 31
 
 static struct line_buffer input = LINE_BUFFER_INIT;
-- 
1.7.10.2
