Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507946BF
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737896396; cv=none; b=MlfY83RbFxPA+aiuf08q13JA8++7vt5FNoYtFrr5FoneZQajwWZqXb87if3MkqttMh88gPH81uh7F5JpL4KB7evWi2gArmFUn5ncTOSA7G03Kcvy05WLtgl0kHbaJ6B0AiYkfjhNQmBb5itFKss0clkx8Q4uEuhrp7pZyET4H94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737896396; c=relaxed/simple;
	bh=9M5r7VlJvbsl/CqatIX23Oj8CrONDdbND/ihf6qd+30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EeUDavJ+JB9SWSbor4iWiWFNAY2WqLGGrXInJbewif9PBs4VJQofA4xvi4GV4K8S8x5+BOHQ4BAv05t6BvnatHlBnKmefSRKocn9xBlyMb9xYV6ljKhNfDpWrxlHbcAWO6umDeeaY6bylllk8hpsh7wpzP8J31J2BpkR5EJW2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=bUkEiT4C; arc=none smtp.client-ip=195.4.92.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="bUkEiT4C"
Received: from [194.97.210.52] (helo=sub6.mail.fnrz.de)
	by mout3.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tc2Ev-00EnWg-5P; Sun, 26 Jan 2025 13:59:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AN9cdzo6TIIqIQmHVxUvUo5XR54I66z7FM3heGpfDM0=; b=bUkEiT4Chus79EM0fDP0qiqUbo
	ZQ1+jDA8alWGAVGfCcodUSndkWHqNKmImyZ3OH83VpNHvnfAmFq4g3K//7+FTjmbZ3t5Pqzr1+Mn0
	0XybwI3HHqawvHfnOrqOa22R/33eJcUdyqb9DzhASy1vZd1jkZYdaUx3u/JZhUE8EvvIHCyXFpIOk
	pvTQ0JiPoQ8bnl9KNEnOnh3++n926PjuLvr+GANQDe+AdPYl/xYRXXFwsBIpAamh+Xuya+PBajanT
	PmJHaK+1s5VSM/qxmwBoFKEJDo3uRFF6RPg0hfsqiri9C3StLxmLd0ictLiZ/3CpFljT2DT3KjvAH
	iHbJa8Vg==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:58466 helo=localhost.localdomain)
	by sub6.mail.fnrz.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.96 #2)
	id 1tc2Eu-009NhH-2r;
	Sun, 26 Jan 2025 13:59:49 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v3 3/4] apply.c : Fix type conversation warnings from msvc
Date: Sun, 26 Jan 2025 13:59:45 +0100
Message-Id: <20250126125945.3241-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
Reply-To: 20250126125638.3089-1-soekkle@freenet.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 173789638876D03EF0E756O
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!58466
X-Scan-TS: Sun, 26 Jan 2025 13:59:48 +0100

Fix compiler warnings from msvc in apply.c for value truncation from 64
bit to 32 bit integers.

Also switch from int to size_t for all variables with result of strlen()
which cannot become negative.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 apply.c | 37 +++++++++++++++++++------------------
 apply.h |  6 +++---
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/apply.c b/apply.c
index 4a7b6120ac..b896889505 100644
--- a/apply.c
+++ b/apply.c
@@ -414,9 +414,9 @@ static int read_patch_file(struct strbuf *sb, int fd)
 	return 0;
 }
 
-static unsigned long linelen(const char *buffer, unsigned long size)
+static size_t linelen(const char *buffer, size_t size)
 {
-	unsigned long len = 0;
+	size_t len = 0;
 	while (size--) {
 		len++;
 		if (*buffer++ == '\n')
@@ -688,7 +688,7 @@ static char *find_name_common(struct strbuf *root,
 	 * or "file~").
 	 */
 	if (def) {
-		int deflen = strlen(def);
+		size_t deflen = strlen(def);
 		if (deflen < len && !strncmp(start, def, deflen))
 			return squash_slash(xstrdup(def));
 	}
@@ -1088,7 +1088,7 @@ static int gitdiff_index(struct gitdiff_data *state,
 	 */
 	const char *ptr, *eol;
 	int len;
-	const unsigned hexsz = the_hash_algo->hexsz;
+	const size_t hexsz = the_hash_algo->hexsz;
 
 	ptr = strchr(line, '.');
 	if (!ptr || ptr[1] != '.' || hexsz < ptr - line)
@@ -1131,7 +1131,7 @@ static int gitdiff_unrecognized(struct gitdiff_data *state UNUSED,
  */
 static const char *skip_tree_prefix(int p_value,
 				    const char *line,
-				    int llen)
+				    size_t llen)
 {
 	int nslash;
 	int i;
@@ -1158,7 +1158,7 @@ static const char *skip_tree_prefix(int p_value,
  */
 static char *git_header_name(int p_value,
 			     const char *line,
-			     int llen)
+			     ssize_t llen)
 {
 	const char *name;
 	const char *second = NULL;
@@ -1313,15 +1313,15 @@ static int check_header_line(int linenr, struct patch *patch)
 	return 0;
 }
 
-int parse_git_diff_header(struct strbuf *root,
+size_t parse_git_diff_header(struct strbuf *root,
 			  int *linenr,
 			  int p_value,
 			  const char *line,
-			  int len,
-			  unsigned int size,
+			  size_t len,
+			  size_t size,
 			  struct patch *patch)
 {
-	unsigned long offset;
+	size_t offset;
 	struct gitdiff_data parse_hdr_state;
 
 	/* A git diff has explicit new/delete information, so we don't guess */
@@ -1378,7 +1378,7 @@ int parse_git_diff_header(struct strbuf *root,
 			break;
 		for (i = 0; i < ARRAY_SIZE(optable); i++) {
 			const struct opentry *p = optable + i;
-			int oplen = strlen(p->str);
+			size_t oplen = strlen(p->str);
 			int res;
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
@@ -1430,7 +1430,8 @@ static int parse_num(const char *line, unsigned long *p)
 static int parse_range(const char *line, int len, int offset, const char *expect,
 		       unsigned long *p1, unsigned long *p2)
 {
-	int digits, ex;
+	int digits;
+	size_t ex;
 
 	if (offset < 0 || offset >= len)
 		return -1;
@@ -1465,7 +1466,7 @@ static int parse_range(const char *line, int len, int offset, const char *expect
 	return offset + ex;
 }
 
-static void recount_diff(const char *line, int size, struct fragment *fragment)
+static void recount_diff(const char *line, size_t size, struct fragment *fragment)
 {
 	int oldlines = 0, newlines = 0, ret = 0;
 
@@ -1475,7 +1476,7 @@ static void recount_diff(const char *line, int size, struct fragment *fragment)
 	}
 
 	for (;;) {
-		int len = linelen(line, size);
+		size_t len = linelen(line, size);
 		size -= len;
 		line += len;
 
@@ -1543,11 +1544,11 @@ static int parse_fragment_header(const char *line, int len, struct fragment *fra
  */
 static int find_header(struct apply_state *state,
 		       const char *line,
-		       unsigned long size,
+		       size_t size,
 		       int *hdrsize,
 		       struct patch *patch)
 {
-	unsigned long offset, len;
+	size_t offset, len;
 
 	patch->is_toplevel_relative = 0;
 	patch->is_rename = patch->is_copy = 0;
@@ -2132,7 +2133,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
  *   the number of bytes consumed otherwise,
  *     so that the caller can call us again for the next patch.
  */
-static int parse_chunk(struct apply_state *state, char *buffer, unsigned long size, struct patch *patch)
+static int parse_chunk(struct apply_state *state, char *buffer, size_t size, struct patch *patch)
 {
 	int hdrsize, patchsize;
 	int offset = find_header(state, buffer, size, &hdrsize, patch);
@@ -2491,7 +2492,7 @@ static int match_fragment(struct apply_state *state,
 	struct strbuf fixed = STRBUF_INIT;
 	char *fixed_buf;
 	size_t fixed_len;
-	int preimage_limit;
+	ssize_t preimage_limit;
 	int ret;
 
 	if (preimage->line_nr + current_lno <= img->line_nr) {
diff --git a/apply.h b/apply.h
index 90e887ec0e..bb01ce7dbc 100644
--- a/apply.h
+++ b/apply.h
@@ -166,12 +166,12 @@ int check_apply_state(struct apply_state *state, int force_apply);
  *
  * Returns -1 on failure, the length of the parsed header otherwise.
  */
-int parse_git_diff_header(struct strbuf *root,
+size_t parse_git_diff_header(struct strbuf *root,
 			  int *linenr,
 			  int p_value,
 			  const char *line,
-			  int len,
-			  unsigned int size,
+			  size_t len,
+			  size_t size,
 			  struct patch *patch);
 
 void release_patch(struct patch *patch);
-- 
2.39.5

