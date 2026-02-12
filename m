Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A654774
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770911648; cv=none; b=Ck8c+pKqYBATcP/ARpTyf4M+2TZ5T4B6R0IYCUsoHdM96Q0eGznZgtfTvGZxGu5c0cFym/yCoFTY13Qy6Ccuy5aWP4VuPvjMZv3bMsIBfcZu7Tgp3l9WNP7v98F7xOT3pn87CfOeJGhBWOjx5eRpSXe6um7cVSLjIVh3WYLNkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770911648; c=relaxed/simple;
	bh=oKJGxe95ZETUlmAuHRNLohFRxGLEAuKBE4hM4GAGHYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZ6o5xGQgSJTBEwnXhaaVCSB+33x7wvIqnuJT3ETWROvuaE1WO6JcBsarMRCZVsYLe/uBCW/eIqTwzGz3Ta7lNXDcKceokpx0cCshMHfk7VKlywcD3Za3q1pHbKZZWo18Pn4/Q0G67SAB6b8UZj3MKN5xVCZSWRGrsrUlL6HyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoPMM0WH; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoPMM0WH"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-480706554beso72368605e9.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770911645; x=1771516445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2leyJd05UC3/DjrYpectRoQOSkWbANCm1zct1+KIoys=;
        b=CoPMM0WHUxa2Qs1nmk0X/a4ykmYMGq/3iDOPFP6ZqJnIOh92aBGwE6heZArwkUBNw1
         XJb9AAfMhMvQG+EGVZLX4lyivvPT1dJRrerUBddsqu2d/j0DTOouWbxYVRw0gy2SWtOO
         l8uOJRUL8IzSzikcZqXM5zAzwRGXQAdmCBwDNfzlU87rcIWiEAssQ48sFFyvp2NuUNO5
         8zH+/OotGFEKNvbajxrWWqERBeo4d6Eg4TVaqMEdWA7pr/idvC3PqJ3tHq4FVlTXxGGW
         ZhkN2YHb4Wid1bcfiF2QtCow53xaoCOiPTXCUViumtAdGTjGevl/I+WQeshXCrLFTAlS
         Fb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770911645; x=1771516445;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2leyJd05UC3/DjrYpectRoQOSkWbANCm1zct1+KIoys=;
        b=s3mmNnLr1RntYawcL6XAdPQla+DMlPo+OJ9Y5Z2JTIaT8cuSyQgkZ3QVkSl9+bCDS1
         PO1AHn8Vv1NOfE/3RJ/0O+4W1ozAoJaCc7rVNh5+rSjxd1Np+Df/w+3zhNw2oN/yjjnJ
         KU9Q4IgKw95QCv81R+Fi83F9yjhhmgo8aCtNc32MrG4QEciY8PkYPpeMeZLbJSSDQ0sQ
         YwWju9uQmvH2UIhsNpwGqnvaOLnoN8ilJVGmbGrpw7x8S1hB9bRQsahPIms/W7ltZk4R
         2mQRCYk3SYe8qY0xEZq9EFX0ghqSb7o3k44SxtCvZsctAfIEaDBGp0Np/2aje8kQ38ak
         lLTA==
X-Gm-Message-State: AOJu0YwRNOZk3DlDn5otr9wdSchyxyW2Go3lillZBBGXDQFjlOydCtbU
	GEG7SpRCjSsrsl8LtyX1972zJ9UaWQwJ/+VrPAYsC8hvnkPYaAk41dXAynv+I8MK
X-Gm-Gg: AZuq6aLs1wVAnni8zi0oDIdLS62AdTVsfMwNjaaTU1e3CJqfwWFN/5zyiZotr/Kpnsv
	oVoxeH6vHe0GIj/M4axJJGJQWjX557qNUfGw7A+STHcgVw+q2dEr+j4t26og0bY9qRnHIlpVfh6
	bhl1Ux4ep1whw+l+kY7uV1PRLSi//9GdbzvRQHUnp7yf0Xb1nM8ecwRA6bE8ILGZioZTh06WWI0
	GBj1RHmFppzi/miuDm0Tn+301Bp0RpFfP3wzae7N7ikapWiTwgBjT5JV39IeFF98V83tbLb3KSX
	6oD2yrk9n7V3d7Gjr2vX2PbDH+HHKkVOFO0IF/okLjONu7PIdtvbaDNQgf04F7lMKlXspaDrbHG
	CaTtpPKTFswJvi6BUov1UNr51MudqFhPLuJqL5efedjt9JzPN8yncUx6Ry3cdCJ0Y+rjlxYGGxq
	pzpygGToARdBOsMV+noxJaPShjiI6x9ekPyxUp/w==
X-Received: by 2002:a05:600c:4e14:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-483656b0dfemr45010255e9.3.1770911645117;
        Thu, 12 Feb 2026 07:54:05 -0800 (PST)
Received: from berwick ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d77f9sm218346145e9.3.2026.02.12.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 07:54:04 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] diff --anchored: avoid checking unmatched lines
Date: Thu, 12 Feb 2026 15:53:50 +0000
Message-ID: <2a8cc2d6c37f25a58823b501500165d597321749.1770911599.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

For a line to be an anchor it has to appear in each of the files being
diffed exactly once. With that in mind lets delay checking whether
a line is an anchor until we know there is exactly one instance of
the line in each file. As each line is checked at most once, there
is no need to cache the result of is_anchor() and we can drop that
field from the hashmap entries. When diffing 5000 recent commits in
git.git this gives a modest speedup of ~2%. In the (rather extreme)
example below that consists largely of deletions the speedup is ~16%.

    seq 0 10000000 >old
    printf '%s\n' 300000 100000 200000 >new
    git diff --no-index --anchored=300000 old new

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
Base-Commit: ea24e2c55433012a0a6c4ae947a87bc66404e484
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fxdiff-simplify-anchor%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/ea24e2c55...2a8cc2d6c
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/xdiff-simplify-anchor/v1

 xdiff/xpatience.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 9580d180320..7953490ed0d 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -61,12 +61,6 @@ struct hashmap {
 		 * initially, "next" reflects only the order in file1.
 		 */
 		struct entry *next, *previous;
-
-		/*
-		 * If 1, this entry can serve as an anchor. See
-		 * Documentation/diff-options.adoc for more information.
-		 */
-		unsigned anchor : 1;
 	} *entries, *first, *last;
 	/* were common records found? */
 	unsigned long has_matches;
@@ -85,8 +79,7 @@ static int is_anchor(xpparam_t const *xpp, const char *line)
 }
 
 /* The argument "pass" is 1 for the first file, 2 for the second. */
-static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
-			  int pass)
+static void insert_record(int line, struct hashmap *map, int pass)
 {
 	xrecord_t *records = pass == 1 ?
 		map->env->xdf1.recs : map->env->xdf2.recs;
@@ -121,7 +114,6 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 		return;
 	map->entries[index].line1 = line;
 	map->entries[index].minimal_perfect_hash = record->minimal_perfect_hash;
-	map->entries[index].anchor = is_anchor(xpp, (const char *)map->env->xdf1.recs[line - 1].ptr);
 	if (!map->first)
 		map->first = map->entries + index;
 	if (map->last) {
@@ -153,11 +145,11 @@ static int fill_hashmap(xpparam_t const *xpp, xdfenv_t *env,
 
 	/* First, fill with entries from the first file */
 	while (count1--)
-		insert_record(xpp, line1++, result, 1);
+		insert_record(line1++, result, 1);
 
 	/* Then search for matches in the second file */
 	while (count2--)
-		insert_record(xpp, line2++, result, 2);
+		insert_record(line2++, result, 2);
 
 	return 0;
 }
@@ -194,6 +186,8 @@ static int binary_search(struct entry **sequence, int longest,
  */
 static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 {
+	xpparam_t const *xpp = map->xpp;
+	xrecord_t const *recs = map->env->xdf2.recs;
 	struct entry **sequence;
 	int longest = 0, i;
 	struct entry *entry;
@@ -220,7 +214,7 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 		if (i <= anchor_i)
 			continue;
 		sequence[i] = entry;
-		if (entry->anchor) {
+		if (is_anchor(xpp, (const char*)recs[entry->line2 - 1].ptr)) {
 			anchor_i = i;
 			longest = anchor_i + 1;
 		} else if (i == longest) {
-- 
2.52.0.362.g884e03848a9

