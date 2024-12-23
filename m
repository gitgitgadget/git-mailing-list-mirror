Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476219E98B
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952193; cv=none; b=gxC6W7WDDVSVp+z2VUv+4DgG39acHsPhQxKf7UEF7OqWEp/SLYgxtrB2BOWiurIx2QZG5/fTycd0FtB/VBe5I9V29CoUeuqmyOe6SARAokhFhuXorBAlSy1x0r3yiBHy4S8404fnjDHF+D/WB4a69uMA794JEUce/QG1cilh1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952193; c=relaxed/simple;
	bh=zaKEjxO6/Q1NBsSP4Pi9PCM5WxcoejkpCMRkXnMjOms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h54Y9PzCNtHu3J1M8hZHNr2UqAC2SIAVwfxu0o37bmnW6XWgUOgBFFZtAJ5HHIvPqpdtRB/VJXnkRRJrCMa0q435J5A900GHKa16ow8MLTbP/XdBV+fhlGZdQE4+oq2dMkqYPkqQucSrmkTVeZJAqkW60/dOdWpnRyRT4ZvSLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=s2Kf7alY; arc=none smtp.client-ip=195.4.92.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="s2Kf7alY"
Received: from [195.4.92.126] (helo=sub7.freenet.de)
	by mout0.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tPgEf-0042k6-PW
	for git@vger.kernel.org; Mon, 23 Dec 2024 12:04:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lkkDaHelX2wTe/2PGgnm4qXgdU3e6K2YPpcG0dFcnaU=; b=s2Kf7alYRp7ldgDZ5GGCgpqxAS
	Byw73nL6Cdc39R8Ye0X2puMGzTuBcdh+vS2V9QZKwtysuxblWdVFaIj79ZUmDx9aMrNtIr3jQatpt
	muWqgh+14AOk9tUa6yN18HA3eO4W1DjOD1X55xfq2UosNmlGBKX+1EwP3KBfD1OtCH2kO01xXpF/p
	2RYmSXAuYS8V0W1aP5f1nGH8VDL7ky7xKyckN2EFD8aW212EHVuzJZZaKrox6vy0MVedY+oZv6i1W
	7GD8oGTDAwXjwwCfElrLJ9H5od3vDn2q9AcZeYCYsWu5bKT01hz0+i2nt098X8OfRwSJQtVrwgvgN
	oBaw2Bnw==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:53566 helo=soren-pc.lan)
	by sub7.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1tPgEf-00BYML-Fi; Mon, 23 Dec 2024 12:04:29 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH 3/4] apply.c : Fix type missmatch warings from msvc
Date: Mon, 23 Dec 2024 12:04:06 +0100
Message-Id: <20241223110407.3308-4-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241223110407.3308-1-soekkle@freenet.de>
References: <20241223110407.3308-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 17349518693F917CCDD974O
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!53566
X-Scan-TS: Mon, 23 Dec 2024 12:04:29 +0100

Fix compiler warings from msvc in date.c for value truncation from 64
bit to 32 bit integers.

Also switch from int to size_t for all variables with result of strlen()
which cannot become negative.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 apply.c | 37 +++++++++++++++++++------------------
 apply.h |  6 +++---
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/apply.c b/apply.c
index a3fc2d5330..5bb0b0e78e 100644
--- a/apply.c
+++ b/apply.c
@@ -413,9 +413,9 @@ static int read_patch_file(struct strbuf *sb, int fd)
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
@@ -687,7 +687,7 @@ static char *find_name_common(struct strbuf *root,
 	 * or "file~").
 	 */
 	if (def) {
-		int deflen = strlen(def);
+		size_t deflen = strlen(def);
 		if (deflen < len && !strncmp(start, def, deflen))
 			return squash_slash(xstrdup(def));
 	}
@@ -1087,7 +1087,7 @@ static int gitdiff_index(struct gitdiff_data *state,
 	 */
 	const char *ptr, *eol;
 	int len;
-	const unsigned hexsz = the_hash_algo->hexsz;
+	const size_t hexsz = the_hash_algo->hexsz;
 
 	ptr = strchr(line, '.');
 	if (!ptr || ptr[1] != '.' || hexsz < ptr - line)
@@ -1130,7 +1130,7 @@ static int gitdiff_unrecognized(struct gitdiff_data *state UNUSED,
  */
 static const char *skip_tree_prefix(int p_value,
 				    const char *line,
-				    int llen)
+				    size_t llen)
 {
 	int nslash;
 	int i;
@@ -1157,7 +1157,7 @@ static const char *skip_tree_prefix(int p_value,
  */
 static char *git_header_name(int p_value,
 			     const char *line,
-			     int llen)
+			     ssize_t llen)
 {
 	const char *name;
 	const char *second = NULL;
@@ -1312,15 +1312,15 @@ static int check_header_line(int linenr, struct patch *patch)
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
@@ -1377,7 +1377,7 @@ int parse_git_diff_header(struct strbuf *root,
 			break;
 		for (i = 0; i < ARRAY_SIZE(optable); i++) {
 			const struct opentry *p = optable + i;
-			int oplen = strlen(p->str);
+			size_t oplen = strlen(p->str);
 			int res;
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
@@ -1429,7 +1429,8 @@ static int parse_num(const char *line, unsigned long *p)
 static int parse_range(const char *line, int len, int offset, const char *expect,
 		       unsigned long *p1, unsigned long *p2)
 {
-	int digits, ex;
+	int digits;
+	size_t ex;
 
 	if (offset < 0 || offset >= len)
 		return -1;
@@ -1464,7 +1465,7 @@ static int parse_range(const char *line, int len, int offset, const char *expect
 	return offset + ex;
 }
 
-static void recount_diff(const char *line, int size, struct fragment *fragment)
+static void recount_diff(const char *line, size_t size, struct fragment *fragment)
 {
 	int oldlines = 0, newlines = 0, ret = 0;
 
@@ -1474,7 +1475,7 @@ static void recount_diff(const char *line, int size, struct fragment *fragment)
 	}
 
 	for (;;) {
-		int len = linelen(line, size);
+		size_t len = linelen(line, size);
 		size -= len;
 		line += len;
 
@@ -1542,11 +1543,11 @@ static int parse_fragment_header(const char *line, int len, struct fragment *fra
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
@@ -2131,7 +2132,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
  *   the number of bytes consumed otherwise,
  *     so that the caller can call us again for the next patch.
  */
-static int parse_chunk(struct apply_state *state, char *buffer, unsigned long size, struct patch *patch)
+static int parse_chunk(struct apply_state *state, char *buffer, size_t size, struct patch *patch)
 {
 	int hdrsize, patchsize;
 	int offset = find_header(state, buffer, size, &hdrsize, patch);
@@ -2490,7 +2491,7 @@ static int match_fragment(struct apply_state *state,
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

