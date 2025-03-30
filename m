Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5FF3EA83
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743356713; cv=none; b=a0iWMq4EkT1G1yNrAkiAU9aGwKNfcjgvBZCrvaeUiEqfEG4dvJGHFb+Vk2gaGRhf88mTbZeKSm22cy0K2rg+FkmdREaF8T9ZLpPN8DxtzudgXmnty1DxAVjsNC1lqe+esYsjw8o2IK1U2H6YG1fXTQBS7zEMVuSJ559C7VdzRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743356713; c=relaxed/simple;
	bh=mOQTt+ZJLc1SkqVNxl0jZFmrbdzQf34pd2sio8xjroU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuf+/BZXf1q3LiBRCTals33zA6j8Gv/fQtlpan+Zy40gWhiDhum3fbjp2+0KrQ37QFCZdKirh7NxQBAnet25snyklXTsoz/Z1WGJD+/1EvQ8EqeR8C1u66yG6yuak9GmF/ASkhNOOR/SYJnzqqVrhH4vOb647QiQC9KeBJGNjtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msGedCwN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msGedCwN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225df540edcso89607805ad.0
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743356711; x=1743961511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIbdR4ryvBQpUYMpaqoMKFX1svyJ6Fw7ZhVLTmaExbU=;
        b=msGedCwNoyaPq9IUYC4FKxNROfO1e4d7NVozznochEvyGxCV2P0Xh2kl8h2sGguUcC
         9OBGthk8lFRzB0vmLnZ6QK2wbelgXB9XLyjX850lhKlX1qhzsRz7Tv7ee/3eaf6Zjpza
         w07BJyiY5YR8JfT2sqAMHs6V56raPPtYUkX1jk6knqkbZSkCQMayhkPIgBuJCDlpjxNK
         o3/oixBnZZV/2pE3ge0sHT1GWi2Qio88VO6xwuHBJXJX8I7op3ggG2NGM4WVLspi7X8w
         9z5p6084yCwEnwS26WojYjyWQLnQU0ajFNh1BDEF7+wMatbkF+xC4eOJC8O2wTnNhup4
         rjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743356711; x=1743961511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIbdR4ryvBQpUYMpaqoMKFX1svyJ6Fw7ZhVLTmaExbU=;
        b=KRxt3TvmC4t0t2i1NF/oLa1x61cwa/4rK6hKiUVLHUkeksCKxW+GNVFmFTAdP3vaa2
         pq+5/fcQm4Kh271BEuKanVxurJlhsvunUQQVhn/lDpXvl1JDZIIGfFfc7WLpJ9BpK1Bp
         +A05gepyzCLOuy6thMQPOMNvVr7qNXExbCqWmcf19AkiDA8G1Z482YLCKNvu9E7+/Vso
         Un2+o8ns5nlePrJjlJaPAr71ji2VYzP52RCaEccXguzdF1eaAGpvAtCh99ZuYbfA1h7O
         oMU30huDzCf5f0SqpfKKBWaV20KE6f3EPIjnQAUqgz5SFmh82XPqAuA+TdFISfIcx+J/
         +74w==
X-Gm-Message-State: AOJu0YylByjQEbg6dn6rZU5we3Y2VrQmtGJv/cgg2aqqHWBXdzdkF7Mx
	ug3RZOJkZFp93m2p9H8PjvRnoXStRan7snfOQ+BEtImeacQT268q
X-Gm-Gg: ASbGncsNuza8lqycOWXthtYZBV7pYn3qgU274VJgQVodbgaM3APu8yWnWU5N01qUV3C
	QZtr+PzRA9/+7uwImYDglJcJKeYfS/79H6dJD08HE8sJP1jQadMMeAQu0rn3fZ5T9mO2CO9MeiD
	da5qAUPRZD/dHODKfKDV7A/61Gxdao99USrnGZVeF6MpJLE69EE4ofDeTn1ZBLhwRiAlIRVA/ZS
	VT2pKinpXazB75jsV2jdHiu0H5NlD7CoTYnSzF/U879T9oVbeLGo/evOibBfj1FZ0rjdiIRrBhT
	D9ESNgg7Q8+GN/ReVVOfeMvVMjBeW0/VHicrAGj+yzZjDaNheD1PuO4nWdGhHJMjpxovRNwFs2V
	B2tnIhYrGJ7nZOV/GNg==
X-Google-Smtp-Source: AGHT+IG/6TnwBJZSvGPfrPky47F722QI9Jz/4aA4Joa7HsmfeaUT9rz5Hf/JN0RxKvzq/eghsb7Ydw==
X-Received: by 2002:a05:6a00:8c04:b0:725:4a1b:38ec with SMTP id d2e1a72fcca58-739725f3a3amr19023141b3a.3.1743356711017;
        Sun, 30 Mar 2025 10:45:11 -0700 (PDT)
Received: from ?IPV6:2400:1f00:2:3a32:8d7f:a0e2:2b6e:8935? ([2400:1f00:2:3a32:8d7f:a0e2:2b6e:8935])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e1f8c1sm5618296b3a.53.2025.03.30.10.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 10:45:10 -0700 (PDT)
Message-ID: <127c3010-4b23-436e-a07d-e6031e746113@gmail.com>
Date: Sun, 30 Mar 2025 23:15:06 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GSoC PATCH v3] pathspec: fix sign comparison warnings
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
 <aa7753f2-27f5-4a7a-830d-780bd21191f7@gmail.com> <xmqqr02fd6pu.fsf@gitster.g>
Content-Language: en-US
From: Arnav Bhate <bhatearnav@gmail.com>
In-Reply-To: <xmqqr02fd6pu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are multiple places, especially in loops, where a signed and an
unsigned data type are compared. Git uses a mix of signed and unsigned
types to store lengths of arrays. This sometimes leads to using a signed
index for an array whose length is stored in an unsigned variable or
vice versa. In some cases, where both signed and unsigned data types
have been used to store lengths of arrays in the same function, only
one variable was used to iterate over both types.

Replace signed data types with unsigned data types and vice versa
wherever necessary. Where both types of iterators are required, move
the declaration inside the for loop. In cases where this is not
possible, add appropriate cast.

Remove #define DISABLE_SIGN_COMPARE_WARNINGS.

Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
---
 pathspec.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 89663645e1..2b4e434bc0 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
@@ -35,7 +34,7 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					char *seen,
 					enum ps_skip_worktree_action sw_action)
 {
-	int num_unmatched = 0, i;
+	int num_unmatched = 0;
 
 	/*
 	 * Since we are walking the index as if we were walking the directory,
@@ -43,12 +42,12 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 	 * mistakenly think that the user gave a pathspec that did not match
 	 * anything.
 	 */
-	for (i = 0; i < pathspec->nr; i++)
+	for (int i = 0; i < pathspec->nr; i++)
 		if (!seen[i])
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (unsigned int i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
 		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
@@ -78,7 +77,7 @@ char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
 {
 	struct index_state *istate = the_repository->index;
 	char *seen = xcalloc(pathspec->nr, 1);
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
@@ -130,7 +129,7 @@ static void prefix_magic(struct strbuf *sb, int prefixlen,
 	if (element[1] != '(') {
 		/* Process an element in shorthand form (e.g. ":!/<match>") */
 		strbuf_addstr(sb, ":(");
-		for (int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+		for (unsigned int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if ((magic & pathspec_magic[i].bit) &&
 			    pathspec_magic[i].mnemonic) {
 				if (sb->buf[sb->len - 1] != '(')
@@ -341,7 +340,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 
 	for (pos = elem + 2; *pos && *pos != ')'; pos = nextat) {
 		size_t len = strcspn_escaped(pos, ",)");
-		int i;
+		unsigned int i;
 
 		if (pos[len] == ',')
 			nextat = pos + len + 1; /* handle ',' */
@@ -354,7 +353,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 		if (starts_with(pos, "prefix:")) {
 			char *endptr;
 			*prefix_len = strtol(pos + 7, &endptr, 10);
-			if (endptr - pos != len)
+			if ((size_t)(endptr - pos) != len)
 				die(_("invalid parameter for pathspec magic 'prefix'"));
 			continue;
 		}
@@ -400,7 +399,7 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 
 	for (pos = elem + 1; *pos && *pos != ':'; pos++) {
 		char ch = *pos;
-		int i;
+		unsigned int i;
 
 		/* Special case alias for '!' */
 		if (ch == '^') {
@@ -564,7 +563,7 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 
 void pathspec_magic_names(unsigned magic, struct strbuf *out)
 {
-	int i;
+	unsigned int i;
 	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 		const struct pathspec_magic *m = pathspec_magic + i;
 		if (!(magic & m->bit))
@@ -803,8 +802,8 @@ int match_pathspec_attrs(struct index_state *istate,
 int pathspec_needs_expanded_index(struct index_state *istate,
 				  const struct pathspec *pathspec)
 {
-	unsigned int i, pos;
-	int res = 0;
+	unsigned int pos;
+	int i, res = 0;
 	char *skip_worktree_seen = NULL;
 
 	/*
@@ -845,7 +844,8 @@ int pathspec_needs_expanded_index(struct index_state *istate,
 			 * - not-in-cone/bar*: may need expanded index
 			 * - **.c: may need expanded index
 			 */
-			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
+			if (strspn(item.original + item.nowildcard_len, "*") ==
+				    (unsigned int)(item.len - item.nowildcard_len) &&
 			    path_in_cone_mode_sparse_checkout(item.original, istate))
 				continue;
 
@@ -860,8 +860,10 @@ int pathspec_needs_expanded_index(struct index_state *istate,
 				 * directory name and the sparse directory is the first
 				 * component of the pathspec, need to expand the index.
 				 */
-				if (item.nowildcard_len > ce_namelen(ce) &&
-				    !strncmp(item.original, ce->name, ce_namelen(ce))) {
+				if ((unsigned int)item.nowildcard_len >
+					    ce_namelen(ce) &&
+				    !strncmp(item.original, ce->name,
+					     ce_namelen(ce))) {
 					res = 1;
 					break;
 				}
-- 
2.49.0
