Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38325A642
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737896445; cv=none; b=Jg1PasRoNn6ESILwSFMyMgXe4D3AbxXKr1TsJzyeFNtK4MHFEEhuqXTkrZ7yXpYENn8mcKsK9vN/OeiZZfoYeCUXaRtDIVYlgj5lnwIMX5LPaZ8mHMJmLfiwfyJ32cF2JvOA0IvheI2qIPZWjJAsTEGMDFIwc6PWgnz+VHCWt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737896445; c=relaxed/simple;
	bh=+Uw5rig4DYr3NXDVPZebxujyy0Vp8L5oNk0h8kIaLVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EbbHgFdJPLCg/0c8zt0MMBAJBMsRSPxPa7arfZhOApWwZyme+cbDN8yQi545koNDrvUx1GAcPKEiBLO3xyKODdQUfGHkMlN22oArVuahLnb87txeKKskassda3+IOIC+FG+Lst9TfIIFCKdhczmlXO8NLB9CYZzTXrWnEcSa7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=IA7lNfa/; arc=none smtp.client-ip=195.4.92.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="IA7lNfa/"
Received: from [194.97.202.51] (helo=sub2.mail.fnrz.de)
	by mout3.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tc2Fl-00Eoc3-8d; Sun, 26 Jan 2025 14:00:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5YkF2cpLZJ+DrMjyWHRTkPQIOs3ftI6ohcQrRDFz1qE=; b=IA7lNfa/fSZzyzWdbWMQDKsK1K
	7GhiI/VPS2NWYk+ucsoFfYwiOOfUJ1VoeYf2TCIoByQHV2Vz9CkCtNonwx3WEwlJ2cMBTCxOz2S5F
	jP3+hG8zWeSGKAQnwyRZTEoDNoJx91KLZ4XOLVOefwC2t3B/1G+aGE0ZRLpmlAlJvlX2lRsLMgxKP
	2TGvQ9v1IOu1ojIh1PWVnrw3vKUWkLcOLjyjp0D8QQ53YxqUB9qzpXTTctZVYhhUDoDcHObd92ulS
	xJZn78zbW+GK5neNL5SAcDieDCpSNwLVhvBf9owhJp7asYH/8JlDRltMJzEnxuKPDV5QZJeEReKRf
	o23njlmw==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:53548 helo=localhost.localdomain)
	by sub2.mail.fnrz.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.96 #2)
	id 1tc2Fk-0095I2-39;
	Sun, 26 Jan 2025 14:00:41 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v3 4/4] commit.c: Fix type conversation warnings from msvc
Date: Sun, 26 Jan 2025 14:00:38 +0100
Message-Id: <20250126130038.3277-1-soekkle@freenet.de>
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
X-FN-MUUID: 1737896440E86B2E9076C8O
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!53548
X-Scan-TS: Sun, 26 Jan 2025 14:00:41 +0100

Fix compiler warnings from msvc in commit.c for value truncation from 64
bit to 32 bit integers.

Also switch from int to size_t for all variables with result of strlen()
which cannot become negative.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 commit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 540660359d..c9cc56bd9f 100644
--- a/commit.c
+++ b/commit.c
@@ -466,8 +466,8 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	struct object_id parent;
 	struct commit_list **pptr;
 	struct commit_graft *graft;
-	const int tree_entry_len = the_hash_algo->hexsz + 5;
-	const int parent_entry_len = the_hash_algo->hexsz + 7;
+	const size_t tree_entry_len = the_hash_algo->hexsz + 5;
+	const size_t parent_entry_len = the_hash_algo->hexsz + 7;
 	struct tree *tree;
 
 	if (item->object.parsed)
@@ -1114,10 +1114,10 @@ static const char *gpg_sig_headers[] = {
 
 int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo)
 {
-	int inspos, copypos;
+	ssize_t inspos, copypos;
 	const char *eoh;
 	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(algo)];
-	int gpg_sig_header_len = strlen(gpg_sig_header);
+	size_t gpg_sig_header_len = strlen(gpg_sig_header);
 
 	/* find the end of the header */
 	eoh = strstr(buf->buf, "\n\n");
@@ -1530,7 +1530,7 @@ int commit_tree(const char *msg, size_t msg_len, const struct object_id *tree,
 	return result;
 }
 
-static int find_invalid_utf8(const char *buf, int len)
+static int find_invalid_utf8(const char *buf, size_t len)
 {
 	int offset = 0;
 	static const unsigned int max_codepoint[] = {
@@ -1539,7 +1539,7 @@ static int find_invalid_utf8(const char *buf, int len)
 
 	while (len) {
 		unsigned char c = *buf++;
-		int bytes, bad_offset;
+		size_t bytes, bad_offset;
 		unsigned int codepoint;
 		unsigned int min_val, max_val;
 
-- 
2.39.5

