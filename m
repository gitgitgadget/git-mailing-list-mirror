Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A419E98B
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952189; cv=none; b=F4WU7DF/VYXapfBO04fQGusjzebQE2ssozgtkp8Cc+vvGfwo5Bl5FEQ4DgAzEhRkLnyvl4TjJOYigeffhpq6ihvYCNNbEtdhNaHe+0odw6xt8QzM3gZRGxn090rIkBhM5YBkLU7+wet7i72VSSa4shTEnMQEdH5qHDP64TI5p1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952189; c=relaxed/simple;
	bh=raavfDdC077toO5qPnU/xqgwY2dPKSWGhSVxvEffEfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0ENEZUvPRC6DQxZty+Ip4qM0x5/DruF8UycIHx03qm4n1fJihQwJCJ/XrANYIDWYtYyacJnnajWk6vlGEW1unG/F7gOGokZNmX2qCgFRp/1rPhoWrErrG+l/Wlx13G8o4r/EVE3y8shkgoe2l1fS90vvvM1tcOiEf+u9hiS2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=ubElE96O; arc=none smtp.client-ip=195.4.92.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="ubElE96O"
Received: from [195.4.92.126] (helo=sub7.freenet.de)
	by mout0.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tPgEc-0042dB-AE
	for git@vger.kernel.org; Mon, 23 Dec 2024 12:04:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=94JEfwm6F/c4RLXmO/TpXVtnnNbBuzqseUJJbgrAyHk=; b=ubElE96OGblI3e38LT4Jfti4c8
	tj7TQ3arSOaFpqGm/STUDUvhGIM2NCsO3JRqe7F7ZFFP9TxdhThgDdhWQMlSvuA3LpPqSZX+kwcCy
	0JF3z8qSVMyBqXm76dUXI6cheVX96Bt87Vytfxx3WDHzTUqD94O0lgdCWz9uNOpG+USXD12Nw988n
	pKb/Jxgd3VAhZI5XaBXfHWPOLLgqfLXoZUBoDTrbPBUD6C+iDb8DySR2RC40fz5tTDS4PpFXdZk3x
	fKNn/27H7n+qI3+9PJ91ud1ijZfClugim6Vk3VkyD6ovkL4Acq5ZYOIy5EyqMbLSjQde6EUydB2pr
	kvRNfMKg==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:53566 helo=soren-pc.lan)
	by sub7.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1tPgEc-00BYML-0n; Mon, 23 Dec 2024 12:04:26 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH 1/4] add-patch: Fix type missmatch rom msvc
Date: Mon, 23 Dec 2024 12:04:04 +0100
Message-Id: <20241223110407.3308-2-soekkle@freenet.de>
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
X-FN-MUUID: 173495186601ECAF0BD35CO
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!53566
X-Scan-TS: Mon, 23 Dec 2024 12:04:26 +0100

Fix some compiler warings from msvw in add-patch.c for value truncation
form 64 bit to 32 bit integers.Change unsigned long to size_t for
correct variable size on linux and windows

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 add-patch.c | 44 +++++++++++++++++++++++++-------------------
 gettext.h   |  2 +-
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 557903310d..1ea70ef988 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -241,7 +241,7 @@ static struct patch_mode patch_mode_worktree_nothead = {
 };
 
 struct hunk_header {
-	unsigned long old_offset, old_count, new_offset, new_count;
+	size_t old_offset, old_count, new_offset, new_count;
 	/*
 	 * Start/end offsets to the extra text after the second `@@` in the
 	 * hunk header, e.g. the function signature. This is expected to
@@ -321,7 +321,7 @@ static void setup_child_process(struct add_p_state *s,
 }
 
 static int parse_range(const char **p,
-		       unsigned long *offset, unsigned long *count)
+		       size_t *offset, size_t *count)
 {
 	char *pend;
 
@@ -672,8 +672,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		 */
 		const char *p;
 		size_t len;
-		unsigned long old_offset = header->old_offset;
-		unsigned long new_offset = header->new_offset;
+		size_t old_offset = header->old_offset;
+		size_t new_offset = header->new_offset;
 
 		if (!colored) {
 			p = s->plain.buf + header->extra_start;
@@ -699,12 +699,14 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		else
 			new_offset += delta;
 
-		strbuf_addf(out, "@@ -%lu", old_offset);
+		strbuf_addf(out, "@@ -%" PRIuMAX, (uintmax_t)old_offset);
 		if (header->old_count != 1)
-			strbuf_addf(out, ",%lu", header->old_count);
-		strbuf_addf(out, " +%lu", new_offset);
+			strbuf_addf(out, ",%" PRIuMAX,
+				    (uintmax_t)header->old_count);
+		strbuf_addf(out, " +%" PRIuMAX, (uintmax_t)new_offset);
 		if (header->new_count != 1)
-			strbuf_addf(out, ",%lu", header->new_count);
+			strbuf_addf(out, ",%" PRIuMAX,
+				    (uintmax_t)header->new_count);
 		strbuf_addstr(out, " @@");
 
 		if (len)
@@ -1065,11 +1067,13 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
 
 	/* last hunk simply gets the rest */
 	if (header->old_offset != remaining.old_offset)
-		BUG("miscounted old_offset: %lu != %lu",
-		    header->old_offset, remaining.old_offset);
+		BUG("miscounted old_offset: %"PRIuMAX" != %"PRIuMAX,
+		    (uintmax_t)header->old_offset,
+		    (uintmax_t)remaining.old_offset);
 	if (header->new_offset != remaining.new_offset)
-		BUG("miscounted new_offset: %lu != %lu",
-		    header->new_offset, remaining.new_offset);
+		BUG("miscounted new_offset: %"PRIuMAX" != %"PRIuMAX,
+		    (uintmax_t)header->new_offset,
+		    (uintmax_t)remaining.new_offset);
 	header->old_count = remaining.old_count;
 	header->new_count = remaining.new_count;
 	hunk->end = end;
@@ -1353,9 +1357,10 @@ static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
 	struct strbuf *plain = &s->plain;
 	size_t len = out->len, i;
 
-	strbuf_addf(out, " -%lu,%lu +%lu,%lu ",
-		    header->old_offset, header->old_count,
-		    header->new_offset, header->new_count);
+	strbuf_addf(out,
+		    " -%"PRIuMAX",%"PRIuMAX" +%"PRIuMAX",%"PRIuMAX" ",
+		    (uintmax_t)header->old_offset, (uintmax_t)header->old_count,
+		    (uintmax_t)header->new_offset, (uintmax_t)header->new_count);
 	if (out->len - len < SUMMARY_HEADER_WIDTH)
 		strbuf_addchars(out, ' ',
 				SUMMARY_HEADER_WIDTH + len - out->len);
@@ -1624,10 +1629,11 @@ static int patch_update_file(struct add_p_state *s,
 			else if (0 < response && response <= file_diff->hunk_nr)
 				hunk_index = response - 1;
 			else
-				err(s, Q_("Sorry, only %d hunk available.",
-					  "Sorry, only %d hunks available.",
-					  file_diff->hunk_nr),
-				    (int)file_diff->hunk_nr);
+				err(s,
+				    Q_("Sorry, only %"PRIuMAX" hunk available.",
+				       "Sorry, only %"PRIuMAX" hunks available.",
+				       (uintmax_t)file_diff->hunk_nr),
+				    (uintmax_t)file_diff->hunk_nr);
 		} else if (s->answer.buf[0] == '/') {
 			regex_t regex;
 			int ret;
diff --git a/gettext.h b/gettext.h
index 484cafa562..d36f5a7ade 100644
--- a/gettext.h
+++ b/gettext.h
@@ -53,7 +53,7 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 }
 
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
-const char *Q_(const char *msgid, const char *plu, unsigned long n)
+const char *Q_(const char *msgid, const char *plu, size_t n)
 {
 	if (!git_gettext_enabled)
 		return n == 1 ? msgid : plu;
-- 
2.39.5

