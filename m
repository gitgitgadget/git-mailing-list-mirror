Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1C1990DB
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952186; cv=none; b=qWg9hhmCZSN7ZoDrihlxXfijB/CfBOnMKWhgr+sV7ivTmYcyTGti2sNIBysNKO+VefQ1qVJlWbUfdEEGV6KusoDlyybErF0QNUzu2QGawfU2h0g8kgQEupSVJ6onN/GtQbdOGn9nuN/eGvFtXqwqBZABACPkJ0jo1/N8cuYlllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952186; c=relaxed/simple;
	bh=WbnE62eIMQY31ZpRU6F4icQ2avB/aHQyMil4+b3hM3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNAfl9F4rHpdBdc8XvFBW8Lors2axPymC5DpEOJQ7B+HfNPBpVwGqB9mGHd8caSrYbuiKzH4cSKf/P1NHXQNCXO2LMSvhvxQvwMIkeKEaa+ii9iy2TqH/YWfWL8fliE2UjQVIg3NqbzB4fh/fIiAql78eqvmE1OP5+tbDwBrrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=aIGAwG9S; arc=none smtp.client-ip=195.4.92.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="aIGAwG9S"
Received: from [195.4.92.126] (helo=sub7.freenet.de)
	by mout0.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tPgEf-0042kM-Sp
	for git@vger.kernel.org; Mon, 23 Dec 2024 12:04:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wlG6Dd4NQp0emPL8kA+L+lok4vOM7hf5bTyKLSZ2e3E=; b=aIGAwG9SemAtfYUsqfQ+O9ztR5
	+UL8HSuZrwuvmUecLaTdOihvW6STqrbfmnjkWTykiEFLHkBFzma9/OoJu7RzxU/pMNt6uTGUnF4Jb
	eluRNP28I0enuexAbEGlQ5rfuU5GsuGazz2hkU1z/YtTsL/sSOTLFNucUIMppwAt3c1YtExYc2ABP
	LDDhcgpxNWWneZo/KELxXctYUWjncUe8EfycbeYI4HUL8KI7LtnUHVRBZYeJ681Rctlgm1HFFV4Ng
	F6/ozX4a1kiITSdC1aA9Ktz7yCuTOl4vfFVH8bL7Xm5v1hnoWnNVnEpFCWmSmxx0Cgj4VTA9uKj5U
	qwnrnw4Q==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:53566 helo=soren-pc.lan)
	by sub7.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1tPgEf-00BYML-Jh; Mon, 23 Dec 2024 12:04:29 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH 4/4] commit.c: Fix type missmatch warings from msvc
Date: Mon, 23 Dec 2024 12:04:07 +0100
Message-Id: <20241223110407.3308-5-soekkle@freenet.de>
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
X-FN-MUUID: 1734951869E1D2075964CFO
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!53566
X-Scan-TS: Mon, 23 Dec 2024 12:04:29 +0100

Fix compiler warings from msvc in date.c for value truncation from 64
bit to 32 bit integers.

Also switch from int to size_t for all variables with result of strlen()
which cannot become negative.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 commit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 35ab9bead5..3d363260f3 100644
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
-- 
2.39.5

