Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FDAF4F1
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743229060; cv=none; b=C0/krn9dZmVhxZKZqvbKuBSnqnlBAUWHb3bfaChkiRFTkDqvFnY0sj0d0P0eemM6XDLz23rjTPiTmCz67xfsfr6LuEavwnPL6eHpqNv/IpdZoACD9bXlL8yh0PCVddfjy91aYjlzUsq6ybUNOVi0ee40DzI9o+rgNs85Tt6yanY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743229060; c=relaxed/simple;
	bh=zojvQx0v4aNKl5U3aFEhYUGjzeh5kV70l1ARer24IXM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=EmxwUinmDWKTz74TrNqvf2eRHV79ngsKVeAJzSuGgXoKTJgxv2rb6wqFN18+nFgHh0kpwIXXFSSna/p0l8q4prIYxK4C/1kELm1HEIl6Uy1EoWqgpOJVatzettWvr1osLshzwRNwBM+6Q0hIYQHineAVt/N+kkLA8hP4r1s9VUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAR3DHOA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAR3DHOA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2239c066347so67790345ad.2
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 23:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743229057; x=1743833857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VM8JIQzAY4/J7+QR/djO6hVteQA1eSZLnTIV429YhQY=;
        b=XAR3DHOAotgkgfStkwS8N32oNQSlVH7E1EGQPJphy8q6+OgAxRAm0T5FEYCK/mC+4r
         Wry+W+82Yvd5u/UTL+l2M5GuN1f/E0lrux2pNoLH9hFaCN8fRn6c7XGnPREfmMLEAiva
         i16tPS1z91Dr4Fx4hClWu7IWBFtzdMOqoeW67ck/rsWVrFnKeWnBa7Gx+ZFigu1ujqhh
         QgNd1iZ0QUn4ueUGCrvN6ZNQdIdbvbIvep5GSfpHq4Zkhb2go3dncJTJnx5BJCTbNuHb
         CLDAKVNiSpNHcCS0Xc5m4plMM9Ca0CdTG34y+CDfE0g0xaELKWDCFfgUfQORrbI6iU1L
         NRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743229057; x=1743833857;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VM8JIQzAY4/J7+QR/djO6hVteQA1eSZLnTIV429YhQY=;
        b=nnSFGaB6/mJAYV2CVV4APjRZcpoGoTVtEjz7LhT4PrMQdthuhgx9vgmk3vUBLXTYo8
         2SPd1ifCyyR3ON/47aK2waMmWv+luz70GYBge+KmOOU/yGUcqCzU9gDzz6Sw0KwpbV/2
         O4VeJ1eFF9zqOZ4TWmUgWSCQ3wl4vylWlchpLSNL/54gHC5IFsq1ba7HrcTsSYKg44Eo
         HuYXeiuiggs7jf/q6Qnqzh9dljwZM8RSeHX/dfH9ASly/oeQhnhT0dgFd2IFa+8cUr1P
         7IW77dwB340ye9hCl4PExZEgdsuMgX7o+rAhEp1EWpp1iWK5uWVwmBabPMMYoDBgn05O
         181g==
X-Gm-Message-State: AOJu0YzJYSrv2N0DlfWql/pWTXfTFP7+w7/SIPgEsuJkeoO4zo3aHHOv
	rMiPtapeYP8K4Q5Q5K6VxdpbvaYZVelYflNRELx6Jdl4wY/Av3sSy/9rfg==
X-Gm-Gg: ASbGncvP0zKHRIOLt5qO7jD7uE86beB5ymeoI/qlWdl/U+bqByyIHzRWF9eulO0O5yC
	oJvk72KDlL8NmuhqAY40SSiypkI6GoohxiQ3Z0Rv534LCQ7iXEuGc0j26rBlQnaS6wv9lEfMucq
	9qBFdxV9OIXbFwEAk5wru4/GiLbf6nJy0LoRVky+EWZq5qGzXi8zFT4B45OH5ccD+ebvdO7mjFb
	SyFmmUpD+6EO1gj0emLyTdwVpuZUoVUZjIl+lHe0Tm213zrETypRZzxgBOh03L/b10wcztZ8T9S
	E+G1YQyd80AOpNWYeM6lGYOvmnGNRDQiA+eFFrAG428iTnl7BMQ=
X-Google-Smtp-Source: AGHT+IGduB8CIk7cpRtQevs0lOjSkGUjJEOTUMehQ4x720Riek8XbXU5G9T6WQI+AO6R8mbriGr8Xg==
X-Received: by 2002:a17:902:e887:b0:223:f408:c3f8 with SMTP id d9443c01a7336-2292f960348mr30098775ad.14.1743229057343;
        Fri, 28 Mar 2025 23:17:37 -0700 (PDT)
Received: from [10.61.238.175] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ded45sm28625335ad.163.2025.03.28.23.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 23:17:36 -0700 (PDT)
Message-ID: <aa7753f2-27f5-4a7a-830d-780bd21191f7@gmail.com>
Date: Sat, 29 Mar 2025 11:47:36 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GSoC PATCH v2] pathspec: fix sign comparison warnings
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
References: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
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
 pathspec.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 89663645e1..c5b38278fc 100644
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
@@ -845,7 +844,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
 			 * - not-in-cone/bar*: may need expanded index
 			 * - **.c: may need expanded index
 			 */
-			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
+			if (strspn(item.original + item.nowildcard_len, "*") == (unsigned int)(item.len - item.nowildcard_len) &&
 			    path_in_cone_mode_sparse_checkout(item.original, istate))
 				continue;
 
@@ -860,7 +859,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
 				 * directory name and the sparse directory is the first
 				 * component of the pathspec, need to expand the index.
 				 */
-				if (item.nowildcard_len > ce_namelen(ce) &&
+				if ((unsigned int)item.nowildcard_len > ce_namelen(ce) &&
 				    !strncmp(item.original, ce->name, ce_namelen(ce))) {
 					res = 1;
 					break;
-- 
2.49.0
