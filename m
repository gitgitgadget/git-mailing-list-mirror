Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820FE1DFD85
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190888; cv=none; b=g/9YpskqlKm+pMNujBerKqtXTRagMs0LQjEgA1T9W7mQIZN+NFC3IVx8CDzHksHO8zs8dbM+QzX3/9CATBu5VtSLotJWURXhXekpA+A70WVr1JzPxLzALL0NM4mZznvANkpPU1AYHWntyxz+9vToID117Ne8VSnknY5jhkmyPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190888; c=relaxed/simple;
	bh=8PAa18Y3Q3NKMjaPLVW7AQbssy0YRo6cbZVKtXBFIFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eueJbiEdOUnwmJuru/wVXU9zjNbRjGq816ylkkto+GFgy+nXai6Q4DYtTx5NrM9KFcw77EaoGioEEyUmYN9Ti8hBM6GlbCFuRgm4tjKd9p50xMaMz2F8Agh+HKx38PHopr+V1YQ2AuxnRuVi2vmQTWHux1OUy9nVEtUChY14qEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=PGySRvbV; arc=none smtp.client-ip=195.4.92.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="PGySRvbV"
Received: from [195.4.92.126] (helo=sub7.freenet.de)
	by mout3.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tUsTd-003JI2-Hs; Mon, 06 Jan 2025 20:09:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1w80BtQ+ed/z1mH1FpbC172tIShkMQjpooQm+jJ+VHw=; b=PGySRvbV095do2Awpj5bffT7JZ
	ijLDP7ogwSvYYgH64lz1uN1Zhn0fnvef83in/PEbjR0oftOidfnDB2DQVumu0pFyYpNmW0bO+L1d+
	a7BDgKiqT9d3FM2JhB7h/FZeaYC4YItkphDkWQWzZx4vpTPJyWQYGz2B+AL7cWoOrsn490C9wne/X
	hVJdQAawxobLdx1q0YjgOEyeeujdwUsCc57oegLjC04MzWgKCCphpRZn90lSaZ3tp/vX1LIMLlL/v
	p8uR6zI3Y5bMwW6UNFQmoJfYjQ/MuUgFL4+3kv0ddMWSPqZ+tE6pcfmaN7LMAkJuT5PBFCX/IbkDM
	UQJmXAxg==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:46380 helo=soren-pc.lan)
	by sub7.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1tUsTd-00Brik-80; Mon, 06 Jan 2025 20:09:25 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCHv2 4/4] commit.c: Fix type missmatch warings from msvc
Date: Mon,  6 Jan 2025 20:08:55 +0100
Message-Id: <20250106190855.3098-5-soekkle@freenet.de>
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
X-FN-MUUID: 1736190565F64ABA71F9A5O
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!46380
X-Scan-TS: Mon, 06 Jan 2025 20:09:25 +0100

Fix compiler warings from msvc in date.c for value truncation from 64
bit to 32 bit integers.

Also switch from int to size_t for all variables with result of strlen()
which cannot become negative.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 commit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index a127fe60c5..78993395e6 100644
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

