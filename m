Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43199366061
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345931; cv=none; b=oDXsYNvFbLASSFPMM6tjzTMQx7n5ynmys4oXKrN6+NxGh9xLStB8u7PN0u2U/OEpWXWijerHdtxt4J8ftaLTuKkAkQPK1MdTGwra9QvxP7r0NncZ3qfyVUCWeEa3/aZxrXEnYz9GG6cvv0EgHdqKU/4aWG+1bs3mrZ7XwmpmBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345931; c=relaxed/simple;
	bh=fXAXNr4UM6tQpLaz4XTYa7idgGFFwZAgvqximlRSX9o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssEbYObehc4v4Sd7ZJZHc/UtoEJDp1eo2PmF2+JVKp02PMz0QDAehwuONWxnEBzQkIYtmFGZ6rO2rqJHSa1cJUaE+5NqccO+LVnrhUEadRs9JTb1Em9Ln4jLjwZcZkwqawvUf5ccSvDyMqOuc5V5L2EEHTpcyjU1PEatdjUUMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=juf4UIKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PDeRuGKV; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="juf4UIKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PDeRuGKV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 917D17A01A0;
	Wed, 29 Jul 2026 13:25:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 29 Jul 2026 13:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785345929; x=
	1785432329; bh=X9h1sXuUsTPKyPvC1yH0rNY0gUAYrcD0szsTITAsQak=; b=j
	uf4UIKaRaBGpZds4SRrE+BjshsIMisUc7KkFtBfQeZ2o4H4Jx7agyF7rlsdFanCj
	50LkVgz6WiHBSsc5FFKTwbLQ0VKiLrOIRJIKd5w4NnWYvPGn3S+tiq1aAvS6v9Va
	bR1Gz2LEVsqAAuzMbZ3b5zGKI4m2lJ6jB+VL1Xp3ZENmRT4bjGxH9zmJ8LfbukVp
	cmeCY1bdajNJUZVlkw7bQPeZtO9zAY7KXFEzsFDs4eZjXDXwALJp3XE1vUfqntkW
	zkPzamwzub9LpifKtFLOPMHry19kMZzMmqwvprZoCzr5yq4WQvqSdFbTzxPSaWvY
	MNQKIKiMkpuRiIXw9F/aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785345929; x=1785432329; bh=X9h1sXuUsTPKyPvC1yH0rNY0gUAY
	rcD0szsTITAsQak=; b=PDeRuGKV/f5+VgeAHD1jGta3b6o2jizTpFbeiPYcYpCG
	xzia4Fl8fOOj4DbNyUqCQlWX/exyQ0bVy10x9PgCigDww+A2BNw7vu5PnH/LneBB
	n2A+TM6lmbXoWJH+Orw1R9Et1cFeb16qk8LZ3nMKiqnI+6qlIp58eQKZu41p0opa
	/bpow1r+1+r/gPYMJlB0JUXqEmfaW0/L39CF3eVdvwmHSzedvAdH54wbdI0YbiDU
	Av84GY9EIQXEE1zfqS0kO1wASOfsQhjeSMQb8kJdfH7PAMtotmivbEMwrQCCQdlQ
	tNlVATFRR2+YsblBhfaPBUfQtIKI0LQRbia/hWFbzg==
X-ME-Sender: <xms:iTdqasLzt5S2dd2JZYQMYK54slPhBxHJBZPp3pT40dhxtpKrBvNUfA>
    <xme:iTdqaiK1vmKxF_uc35KFmcKpr-jpwFzPnFWDFfu9J4yNoPdBLHbqcZ6y95w4wQ1gi
    i-3NwMbXAZUKZCRNgPRLyjtXnhT2s4CA4TQvMUgeto9AbfoOZDigE4>
X-ME-Received: <xmr:iTdqaqWhkA2F8utDtNWQZw5uZ4HqutUFgzF-SL8S-U74Pt91MDmyxP5MpfdFBtuIbCv8jR9RneFaGTSKykHPcS1bjXF7vjMIoQ>
X-ME-Proxy-Cause: dmFkZTEOfrxFAlxrNocGwlX9Xe58YtJfVauubty3vKotQlHg8Vw2q2OJt9XOFRZZYTr565
    5WtY/QemwnB0ZyDulj27iwXkMZOrM1UffTnbCAUxXs2Tm8u85QfYb9kxP3/JVrVS1RGTmH
    cdIr5Cic8dMxnMn56/iAGNeLbUQwWBwmMYMlQOXheawcTKkp2+RVke1UCGPa1Vo98WBLc6
    rrcCnmGhzYDGPE1n4v6RHXS9oxU2Tt7to0zgsvUDRmhx4b85fdmJ0DkWtgRijbdMoUG2w0
    3gAhXzHrcRuzC/Vqh1RHRyBBUtSxi/UbQaQobNR1ucf2gObAjalSVz2Nd6RSNrS5dT/FkK
    KwpSJTkgAL2x5Re9+TYMMYlsJJpTLqqazhnB+klH4wl5Cv+ueWxQl3GPpbjdXK4+KrPi3L
    6IBLv45Kg0ZUsJe8jbG+ZuA4cjxoqkfj+rM0JWpU6zzSBnvKF5DAwR/qYOc5URAIvdWTEt
    Yjl983Yk/jApYWAulMUrI6GY2Q4juolH+S7q7D+pUhLlpxs9/ZCQuRg3e4AfVge4CKoVXD
    Wt7bFTU/pyw57EHWviYQCp0BdtdJqCZLRFUEU/nFjrjVmiayhbTv+ibQrGKWSJh5P+39+7
    P/J4atzVYR3jmDkVAoaUYUe2HT9vE00F3S3v+Xee5o17fS/Ec+pfOpjtXS9Q
X-ME-Proxy: <xmx:iTdqakhaxfkWxwnOAX_lGOywBxVZf-DsRzyfEjiL9SwEMQZm5PFi2g>
    <xmx:iTdqal-eSjwm64xGuwftXc_sHhwg7oUmACfjlz8HLQ5yscb4zrZUrQ>
    <xmx:iTdqauCzOrW7Wtv85UCwqAWChDTJFfR25-6CQ3xKCVZGMTgBvSyxeQ>
    <xmx:iTdqaiKJrtWqLuU0gTzrjm48Go7q5fe2lM-allOtVqshQzgbQF0n8Q>
    <xmx:iTdqavgKrLSvHHrZkSwpUmzcSXW8Tvuwz5Xjag-3yuXCgDJk_HsNb2Jq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:25:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/4] merge-ll: consolidate conflict marker scanning logic
Date: Wed, 29 Jul 2026 10:25:22 -0700
Message-ID: <20260729172524.4022621-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-609-g9a17695db7
In-Reply-To: <20260729172524.4022621-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
 <20260729172524.4022621-1-gitster@pobox.com>
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
index 216100925a..924a1f2e30 100644
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
2.55.0-609-g9a17695db7

