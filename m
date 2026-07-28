Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F54749C8
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275545; cv=none; b=hpBLoFw8opfTuD5m/ZAGMtdetf0aLeLnusarxF0CiRDgd6ECWKhWxbMCwQIfB7zla6ZUy715NSWFvNPT0m6gsLs3g9SfUqCKVCQ5b52KAJE/v02w9L9x55IcIPhmv9a1byJzkZeVz4Bx3lefh3O32XP8cAo8IT+UgMkOIuaNsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275545; c=relaxed/simple;
	bh=tjQH6SEMDR5YCMNAsy3rSaUr4mCCvizM7DDGEO/LiGE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwsNhRImHm0jG0Adxd/wC/y/mO/IO4oMruFt4q1vQs4sh5hhQiI+chyJSzZ3RdRBPLXd2LR/WXqKSqhy8gwLmR59VB4Hx/R8tYSbkTnGC1nkfFRuseXoBF+x5UNVYSxlrDx8hP+8EqD3akYX6LkZzFpIOvKKqNSMbAcO4t7alhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i5ZWjdmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lcutjLor; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i5ZWjdmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lcutjLor"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF9447A02A8;
	Tue, 28 Jul 2026 17:52:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jul 2026 17:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785275542; x=
	1785361942; bh=D1ivvM0jggMvMDzsbbAY8xzXc66q4CgpTfvxnHQ6kUs=; b=i
	5ZWjdmmgSyqZhk4+xfKeLeFcAm27ZsJMnqawi7r8QAiqizrv4/caadGx8BW4MBNO
	yMp48IFkbs3bZbJDIoYBvMvK0pQkfsUu/46tug8yo3kfOFFhNc5Rh8MPZCu88+QC
	R4pf6Njx2k5rzQrTlGIIG7khZMOdHBRXtS4uMfvC8noWJ8VUuH1mrIXPSkXKZzZY
	rFQUsWH/izlGNnDdG3fITX2LuA0XQ1jJwPFBCGdvgmlNrvwQ5X7KgSsU1/u+/+r0
	KQMHwZIw6xDWFhalhnrJjb7Tz6pJi4DBkuuL7ygO+HXq6Tz9jESzDHlvbxi5ar7S
	/hMcHTFudvTjQMXwSMytw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785275542; x=1785361942; bh=D1ivvM0jggMvMDzsbbAY8xzXc66q
	4CgpTfvxnHQ6kUs=; b=lcutjLorAoBuXIfVsuCIi2HRhd/u8AYf5JTNuZAcnlqg
	vfH6YyN2+1smMBeRAJLBwr6n+CXTTkkg5vkbS5F3WJQd68AnVaoidtYVGkk/4E+n
	utnVR/m9rrAgqSq57ej80D4G2HKL/0GhZTA0JDcvcmf6ixn6knc1BSnyIcbZ8KpD
	BtPVPR4sMIbCudZgAXPQBQ7fJ8dp/yLS9ukMdyXPawERn5biwqZBIAjfY0Qo8o0t
	H4RGcEF2BhkDMquAl71JsIzA0RhgfdcUWYP+pNz4/Jsk3Y59e58KohcB4dxX+1mD
	r5kxZbLhh5xqlYaBIjCnEO9ed1x1TFvDa1A1QHybdw==
X-ME-Sender: <xms:liRpasi7wkE_pg5yBUs0z5AYCrO7BRLcH1gQbaSkaZ5IQgPW2vDdZQ>
    <xme:liRpalOaSLXKQiCf4A7CeF6LdYdw6scLQunnDpDoBgnuLAdgW3bIuvmCJC42ADYi4
    9EjA0ECKVWThUPfQLAHnsjb_KovWTyG43Qc3E6tm1D-8WDtWe3NOA>
X-ME-Received: <xmr:liRpal6Q7tANow0UwgbWJ5HW6kSiNGmyzrmdm-R03ezERmF6BmdOBWWEYq4p6RTdwWqf5L9mX8hBKsOpkPrRUGcPUE3otKtf4Q>
X-ME-Proxy-Cause: dmFkZTFJ3B0lfd/c5BUcIK91mUYRgsN/tAgPTwSNjGI7153nfeszh1y2BIUqFotNEVsSzN
    H97AQOvf5SZLiQ6YEcSvMn1dRiPXaWJ94nO6mvNaqSMCpz3d2IPU3cPb+sh8mzDeZnTzaG
    0lRvViS9tvohxCNZFcxj6dNFpROXErihSqjAQCvl3tpOtVjMOt7zYjaZH4VtTx1fro5cBs
    nPvkfxNPpxz288kGK1MMnZrogzbGPM/Tm7Nft62wH0/3LtjIsKE2erW00Qkn2cYRH7Pxxg
    r9gdJ5ngvlJtNuBv7cb4Pf2JkNDcxDwptmJZMvak4XyN4USsoLIA7x8zDRwfIE0ULC0+S2
    7rE5PL4fA/SdxqW4o1FEWhmAGE/2elruNBd3YB1/18BH0liOMlR719N+HYweJzlFKMlHl1
    Fx4XNrw4yMDmAihZD6ALUZLd6YJcxJrRWJWZHOyei7muqq1Dz60wI5c3xN2IYMIP4gtGuY
    2u0mTG0jkJV76pGV607bfaAhISwVH+PGkOiED20ia/QOWW9WwPhrNvq4YBciT/z1cRO2Zq
    CF9tqr3lUjEFvsw2HJ77durQfLPjXVDa3+LazNI73yt0dNnqaizjkGgnAFs+KQLvHzEsWv
    ezL++YMfCKJjiDHlF2MPG85luWZ325cgFHciMSKQLqMWU1qpbLXOh0bTMi7g
X-ME-Proxy: <xmx:liRpar1pts8qdbIJD95f-cx2KatIGa1JXfsB2gLBcwGKLgzaKeTEdw>
    <xmx:liRpaua-flGPNeDEsEZy4-qf2mV6VVCtrfgN7tfpa_mYFhWnApXJ8g>
    <xmx:liRparCeFt7OQw6rlpttgth1hrYek1VO-DU3SAzQtfFccPDch_o2LA>
    <xmx:liRpao-oRX4HhE5JohgzPBedg9S5W7pYJ4HGt1SeaLbnXkOEr8-Mkw>
    <xmx:liRpanE7pQ9Nc-ICQv4e7Nd_bIlh3vhEyQkc9t0BPvmPdbyBpQGdRka1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 17:52:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/4] merge-ll: consolidate conflict marker scanning logic
Date: Tue, 28 Jul 2026 14:52:16 -0700
Message-ID: <20260728215219.753678-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-594-g42d2bf033e
In-Reply-To: <20260728215219.753678-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The diff.c:is_conflict_marker() and rerere.c:is_cmarker() functions
implement duplicate logic for identifying conflict marker lines
(lines that begin with a run of '<', '=', '>', and '|' characters).

diff.c's original version from 049540435f (diff --check: detect
leftover conflict markers, 2008-06-26) accepts any whitespace (such
as a newline) immediately following '<<<<<<<' and '>>>>>>>', whereas
rerere.c's version from 191f241717 (rerere: prepare for customizable
conflict marker length, 2010-01-16) strictly requires a space
character (' ') after them.

Implement is_conflict_marker_line() in merge-ll.c to serve as a
replacement for both, and update diff.c and rerere.c to use the new
helper.  The unified helper intentionally adopts rerere's stricter
rule, as the conflicts generated by Git always show the "ours" and
"theirs" labels after these markers separated by a space.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c     | 25 +------------------------
 merge-ll.c | 31 +++++++++++++++++++++++++++++++
 merge-ll.h |  1 +
 rerere.c   | 38 ++++++--------------------------------
 4 files changed, 39 insertions(+), 56 deletions(-)

diff --git a/diff.c b/diff.c
index 589c1969e4..cfe515af4e 100644
--- a/diff.c
+++ b/diff.c
@@ -3519,29 +3519,6 @@ struct checkdiff_t {
 	int last_line_kind;
 };
 
-static int is_conflict_marker(const char *line, int marker_size, unsigned long len)
-{
-	char firstchar;
-	int cnt;
-
-	if (len < marker_size + 1)
-		return 0;
-	firstchar = line[0];
-	switch (firstchar) {
-	case '=': case '>': case '<': case '|':
-		break;
-	default:
-		return 0;
-	}
-	for (cnt = 1; cnt < marker_size; cnt++)
-		if (line[cnt] != firstchar)
-			return 0;
-	/* line[1] through line[marker_size-1] are same as firstchar */
-	if (len < marker_size + 1 || !isspace(line[marker_size]))
-		return 0;
-	return 1;
-}
-
 static void checkdiff_consume_hunk(void *priv,
 				   long ob UNUSED, long on UNUSED,
 				   long nb, long nn UNUSED,
@@ -3571,7 +3548,7 @@ static int checkdiff_consume(void *priv, char *line, unsigned long len)
 	if (line[0] == '+') {
 		unsigned bad;
 		data->lineno++;
-		if (is_conflict_marker(line + 1, marker_size, len - 1)) {
+		if (is_conflict_marker_line(line + 1, len - 1, marker_size)) {
 			data->status |= 1;
 			fprintf(data->o->file,
 				"%s%s:%d: leftover conflict marker\n",
diff --git a/merge-ll.c b/merge-ll.c
index fafe2c9197..41c97fb90a 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -468,3 +468,34 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
 	}
 	return marker_size;
 }
+
+int is_conflict_marker_line(const char *line, unsigned long len, int marker_size)
+{
+	char firstchar;
+	int cnt;
+
+	if (len < marker_size + 1)
+		return 0;
+
+	firstchar = line[0];
+	switch (firstchar) {
+	case '=': case '>': case '<': case '|':
+		break;
+	default:
+		return 0;
+	}
+
+	for (cnt = 1; cnt < marker_size; cnt++) {
+		if (line[cnt] != firstchar)
+			return 0;
+	}
+
+	if (((firstchar == '<') || (firstchar == '>')) &&
+	    line[marker_size] != ' ')
+		return 0;
+
+	if (!isspace((unsigned char)line[marker_size]))
+		return 0;
+
+	return firstchar;
+}
diff --git a/merge-ll.h b/merge-ll.h
index d038ee0c1e..b348aee15d 100644
--- a/merge-ll.h
+++ b/merge-ll.h
@@ -109,6 +109,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 	     const struct ll_merge_options *opts);
 
 int ll_merge_marker_size(struct index_state *istate, const char *path);
+int is_conflict_marker_line(const char *line, unsigned long len, int marker_size);
 void reset_merge_attributes(void);
 
 #endif
diff --git a/rerere.c b/rerere.c
index 1dda246098..4b05850479 100644
--- a/rerere.c
+++ b/rerere.c
@@ -331,33 +331,6 @@ static int rerere_file_getline(struct strbuf *sb, struct rerere_io *io_)
 	return strbuf_getwholeline(sb, io->input, '\n');
 }
 
-/*
- * Require the exact number of conflict marker letters, no more, no
- * less, followed by SP or any whitespace
- * (including LF).
- */
-static int is_cmarker(char *buf, int marker_char, int marker_size)
-{
-	int want_sp;
-
-	/*
-	 * The beginning of our version and the end of their version
-	 * always are labeled like "<<<<< ours" or ">>>>> theirs",
-	 * hence we set want_sp for them.  Note that the version from
-	 * the common ancestor in diff3-style output is not always
-	 * labelled (e.g. "||||| common" is often seen but "|||||"
-	 * alone is also valid), so we do not set want_sp.
-	 */
-	want_sp = (marker_char == '<') || (marker_char == '>');
-
-	while (marker_size--)
-		if (*buf++ != marker_char)
-			return 0;
-	if (want_sp && *buf != ' ')
-		return 0;
-	return isspace(*buf);
-}
-
 static void rerere_strbuf_putconflict(struct strbuf *buf, int ch, size_t size)
 {
 	strbuf_addchars(buf, ch, size);
@@ -375,7 +348,8 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
 	int has_conflicts = -1;
 
 	while (!io->getline(&buf, io)) {
-		if (is_cmarker(buf.buf, '<', marker_size)) {
+		int marker = is_conflict_marker_line(buf.buf, buf.len, marker_size);
+		if (marker == '<') {
 			if (handle_conflict(&conflict, io, marker_size, NULL) < 0)
 				break;
 			if (hunk == RR_SIDE_1)
@@ -383,15 +357,15 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
 			else
 				strbuf_addbuf(&two, &conflict);
 			strbuf_release(&conflict);
-		} else if (is_cmarker(buf.buf, '|', marker_size)) {
+		} else if (marker == '|') {
 			if (hunk != RR_SIDE_1)
 				break;
 			hunk = RR_ORIGINAL;
-		} else if (is_cmarker(buf.buf, '=', marker_size)) {
+		} else if (marker == '=') {
 			if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
 				break;
 			hunk = RR_SIDE_2;
-		} else if (is_cmarker(buf.buf, '>', marker_size)) {
+		} else if (marker == '>') {
 			if (hunk != RR_SIDE_2)
 				break;
 			if (strbuf_cmp(&one, &two) > 0)
@@ -442,7 +416,7 @@ static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_siz
 		git_hash_init(&ctx, the_hash_algo);
 
 	while (!io->getline(&buf, io)) {
-		if (is_cmarker(buf.buf, '<', marker_size)) {
+		if (is_conflict_marker_line(buf.buf, buf.len, marker_size) == '<') {
 			has_conflicts = handle_conflict(&out, io, marker_size,
 							hash ? &ctx : NULL);
 			if (has_conflicts < 0)
-- 
2.55.0-594-g42d2bf033e

