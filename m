Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB681DF244
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190887; cv=none; b=jikm95oE4dA5UrIrBf9eFpTfnTpgEQlF1h8AQePJFSyM7GTzR45f9M99uq2bggRN5jamMfy9LPks0KIz/UvK7/tpxloMy98oF5z+CY8waLP2YLpUU4Jc3aiNqiKCK8R/c5mioTej72UlY77gL1W1aR4N8Lt2p7kD74repdiBaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190887; c=relaxed/simple;
	bh=D1vs9+R/dwP5lC4I8kKXXTYBZauu0GBNIsBXT7kgpSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pv5yMWBd6ZlUgynpmg1kA0w3/n68lwky2sTIS8Im3XlKn5PxV6A5RmkoaDn3ZpF2gaWZSaVCAnLadL4HzIrBkK2f2vsXJpiqcNXjgg33Te+pe332M+dxNuIp2Pxqu4lWGdh7OLB2sHAngE1tctssRAS+CKZdbZ3VI38QS3xpu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=q/73I+/y; arc=none smtp.client-ip=195.4.92.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="q/73I+/y"
Received: from [195.4.92.126] (helo=sub7.freenet.de)
	by mout3.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tUsTc-003JGo-W3; Mon, 06 Jan 2025 20:09:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bCs8PDXtCYzvJUSezVTcGg/6LZNUJ9tgAe+ytGp4tm4=; b=q/73I+/ygVQhw0EmxWlaiFWREi
	RnNtizBVEWXjU11amwbI7ztcv6bdB6ZH9NuaUjZP5TXujZkcq7DNix9B9v4hQq5uhauicNEAtvHHH
	AjCfJapmhOQ3biFAw2BgM9jQ7TYbopVXD0tCNjnzLkuTLcmIA2lAjqgF5U220acBvrEV+eFkVfx35
	WxJ6bxGsFUnTGGDy8zpaWOG0FW/fmSb3C4sQrvkHf0jgctk9HcIH3QIVibdQOumB+V7q/nOv8+zHr
	Ojn3W1UmCjuAQK79rxkDQBbAeMNpUNHlkqRXHNrFX8dhAk/yI9wGOKYKU3OTyT8FUGvRNdFvyqdRK
	VSSNycVQ==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:46380 helo=soren-pc.lan)
	by sub7.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1tUsTc-00Brik-Km; Mon, 06 Jan 2025 20:09:24 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCHv2 1/4] add-patch: Fix type missmatch rom msvc
Date: Mon,  6 Jan 2025 20:08:52 +0100
Message-Id: <20250106190855.3098-2-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106190855.3098-1-soekkle@freenet.de>
References: <20250106190855.3098-1-soekkle@freenet.de>
Reply-To: <xmqqfrm9t6up.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1736190564B0D8969A13E6O
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!46380
X-Scan-TS: Mon, 06 Jan 2025 20:09:24 +0100

Fix some compiler warings from msvw in add-patch.c for value truncation
form 64 bit to 32 bit integers.Change unsigned long to size_t for
correct variable size on linux and windows.
Add macro strtos for converting a string to size_t.
Test if convertion fails with over or underflow.

Signed-off-by: Sören Krecker <soekkle@freenet.de>

Uses strtouq

impove linux support

Change Macro name
---
 add-patch.c       | 53 +++++++++++++++++++++++++++--------------------
 gettext.h         |  2 +-
 git-compat-util.h |  6 ++++++
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 7b598e14df..67a7f68d23 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -242,7 +242,7 @@ static struct patch_mode patch_mode_worktree_nothead = {
 };
 
 struct hunk_header {
-	unsigned long old_offset, old_count, new_offset, new_count;
+	size_t old_offset, old_count, new_offset, new_count;
 	/*
 	 * Start/end offsets to the extra text after the second `@@` in the
 	 * hunk header, e.g. the function signature. This is expected to
@@ -322,11 +322,12 @@ static void setup_child_process(struct add_p_state *s,
 }
 
 static int parse_range(const char **p,
-		       unsigned long *offset, unsigned long *count)
+		       size_t *offset, size_t *count)
 {
 	char *pend;
-
-	*offset = strtoul(*p, &pend, 10);
+	*offset = strtos(*p, &pend, 10);
+	if (errno == ERANGE)
+		return error("Number dose not fit datatype");
 	if (pend == *p)
 		return -1;
 	if (*pend != ',') {
@@ -334,7 +335,9 @@ static int parse_range(const char **p,
 		*p = pend;
 		return 0;
 	}
-	*count = strtoul(pend + 1, (char **)p, 10);
+	*count = strtos(pend + 1, (char **)p, 10);
+	if (errno == ERANGE)
+		return error("Number dose not fit datatype");
 	return *p == pend + 1 ? -1 : 0;
 }
 
@@ -673,8 +676,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		 */
 		const char *p;
 		size_t len;
-		unsigned long old_offset = header->old_offset;
-		unsigned long new_offset = header->new_offset;
+		size_t old_offset = header->old_offset;
+		size_t new_offset = header->new_offset;
 
 		if (!colored) {
 			p = s->plain.buf + header->extra_start;
@@ -700,12 +703,14 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
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
@@ -1066,11 +1071,13 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
 
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
@@ -1354,9 +1361,10 @@ static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
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
@@ -1625,10 +1633,11 @@ static int patch_update_file(struct add_p_state *s,
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
diff --git a/git-compat-util.h b/git-compat-util.h
index e283c46c6f..4c33990a05 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -291,6 +291,12 @@ static inline int _have_unix_sockets(void)
 #ifdef HAVE_BSD_SYSCTL
 #include <sys/sysctl.h>
 #endif
+#if defined _WIN64
+# define strtos strtoull
+#else
+#define strtos strtoul
+#endif
+
 
 /* Used by compat/win32/path-utils.h, and more */
 static inline int is_xplatform_dir_sep(int c)
-- 
2.39.5

