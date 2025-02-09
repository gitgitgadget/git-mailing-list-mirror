Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E64288DB
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739088818; cv=none; b=V5NFyorWZtdl1cXe0VfEZeboAoJ+h9wn+QzRtA0V+rEUFGYr0sO8upVHigOYW3+oQMrptm7xNdKazk1ahRAVTK3DVljnjr7FvEIjnf0LeuP1+z1Ng2rM242uiQk3TzIDQxaLu1QfsnMeBXigeG6fCDljse7mEruZOtNpzj+SUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739088818; c=relaxed/simple;
	bh=0/3eSsWfMjhpw9FQS+Nj0sPH1rccMPdvo9Nbw3ZWoMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOWrVzUUEUPFDcfgbcrdAETkSS6b43QMRbE9R6moryjPKNw+cUYZi5lhAixSFPSZgIJwmpfyCgLDZ/2Qxj/YwqxNvQYm6J70+PsYtsVGrxKVgDRIZkbUkYVV7ICsFpbbW1I2WOnXAqXgcMgOKD+gpkAJtH+EOTCs3uEXv60xvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQbKs5hN; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQbKs5hN"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2fa2eb7eb45so2675707a91.1
        for <git@vger.kernel.org>; Sun, 09 Feb 2025 00:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739088816; x=1739693616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO/R53160RWn0GnpXvWnlIBN30qIt/TQWpLL1/oGE8Y=;
        b=fQbKs5hNDQ/uGcr5SQWeCVQYd91K2hFFsyCwkK2oP1NQ0qZnC610M5M1uzbOiZpRY5
         hv8NZDygeAH87gj/B17XY1RBj6UsIOWU+CeB9p3j1+DopdwI3f1bdd1jKx/TWztc/ZNp
         KhcW8xf0pe7HnLTWb+okzNi22EOBrpNDoZ6KH7/1EUOVcqroaAXWSnc6pSDagH27mlS4
         C2Nt5k2JQ37PgSxEdJJSBnIjsuE0eeykQXTu0VX45AwBdQoMtkuK7ebEOybdGbfw4I7h
         QIxUmm1YZ3lTfcMK4XS6/lKupRV54WFW8hNdSX/MCWnYHlZczry6FnV59pmhAdVbF2DJ
         R4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739088816; x=1739693616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bO/R53160RWn0GnpXvWnlIBN30qIt/TQWpLL1/oGE8Y=;
        b=JN2fySgZ/fwHGXw03ujcgx5pv3zpBDs98W/Zc64yT2spkMoIhIqXxwfukhRa3pHR78
         LDPomE8SeDExXmp5CufYpSMnzQ0WY0i1Zw3AkqEyXv2hIK/gHqSyn8jxzc1/2m+yuTGN
         Kq2OAju0pV6vcLZ8RawcUiX9EuFBAD1Pkee+AtxyXpS1ErQFlG/F0EBzttlx4aFjiaiH
         H+WFjUqe9AtYO8FjAQLk3FJz61+dY9moEorHV/KEGtzy+N0A/jIL1janJRydrsrrBkc3
         AH+d3bquwpLXU/feNU4OpJ6b5Z2PsvO16Fr9wUDWjJzmo9Sgb/AIkQQePnq0uGsFVbqM
         Eh5w==
X-Gm-Message-State: AOJu0YwifPxsyNiDhZW+j3jsNFz2DWxE/z4YYl7+UI2Rm55ELr5bxsjl
	1UfRneDlh5YzOHmPt6rR6d/gU+02EmXSGO6I4CdMTHe6XVrUGUn0
X-Gm-Gg: ASbGncuxM70NybaaT5VoaQzYNlN6JUiLmeBthY2qLIUXlNPrYLlhgaiD94UzD/zlnK2
	kGbvEcr4uoFOj8Hy2I9AaaN6gorYsFabl7qTUoogqy3vkC5hHvT835MOk83LN9Ra6XRd4ZYtGrc
	OCJ+u8416JTyebeZDilCp5P58WryQo7bBQbyibKVKtc3UNTJbhuW2G7jrCfvcN33L52FD0oU+o0
	xMhJdCXwTSeuayMLgZOPUFWQS8OGAmPF6YSGOl13Fg9vAR5heLi0/geUJ099So3oF+nCcgJ+BhR
	IiW3q/AXcjZgteYnMq9OP5sDfdWgy9LUcnBrsKkTY6VeMN9opgqYIQ==
X-Google-Smtp-Source: AGHT+IG0qja+J0joEhurj5CZx5FKaGs7cpEBCjK2lCwZ8azRlSlwfcmr3VCKcD63EaRXPW6aAzW3Zw==
X-Received: by 2002:a05:6a00:3910:b0:725:4915:c10 with SMTP id d2e1a72fcca58-73042cb59c1mr26936290b3a.10.1739088815714;
        Sun, 09 Feb 2025 00:13:35 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([103.116.72.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730889e0c5fsm466308b3a.119.2025.02.09.00.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 00:13:35 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im
Subject: [GSOC][PATCH v2 2/6] apply: change some variables from `int` to `size_t`
Date: Sun,  9 Feb 2025 08:12:12 +0000
Message-ID: <20250209081216.241350-3-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209081216.241350-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some assigned variables are mistyped as `int`, including

  - those whose values come from a system function returning `size_t`,

  - those that are used for array indexing,

  - those that represent length/size/distance,

some of which will trigger -Wsign-comparison warnings.

Change some of them to `size_t`/`unsigned`.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index 831b338155..b4ae74a5fb 100644
--- a/apply.c
+++ b/apply.c
@@ -1087,7 +1087,7 @@ static int gitdiff_index(struct gitdiff_data *state,
 	 * and optional space with octal mode.
 	 */
 	const char *ptr, *eol;
-	int len;
+	size_t len;
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	ptr = strchr(line, '.');
@@ -2185,7 +2185,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 			};
 			int i;
 			for (i = 0; binhdr[i]; i++) {
-				int len = strlen(binhdr[i]);
+				size_t len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
 					state->linenr++;
@@ -2320,7 +2320,8 @@ static void update_pre_post_images(struct image *preimage,
 {
 	struct image fixed_preimage = IMAGE_INIT;
 	size_t insert_pos = 0;
-	int i, ctx, reduced;
+	int i, reduced;
+	size_t ctx;
 	const char *fixed;
 
 	/*
@@ -2492,7 +2493,7 @@ static int match_fragment(struct apply_state *state,
 	struct strbuf fixed = STRBUF_INIT;
 	char *fixed_buf;
 	size_t fixed_len;
-	int preimage_limit;
+	size_t preimage_limit;
 	int ret;
 
 	if (preimage->line_nr + current_lno <= img->line_nr) {
@@ -2706,7 +2707,7 @@ static int find_pos(struct apply_state *state,
 {
 	int i;
 	unsigned long backwards, forwards, current;
-	int backwards_lno, forwards_lno, current_lno;
+	size_t backwards_lno, forwards_lno, current_lno;
 
 	/*
 	 * When running with --allow-overlap, it is possible that a hunk is
@@ -2791,7 +2792,7 @@ static int find_pos(struct apply_state *state,
  */
 static void update_image(struct apply_state *state,
 			 struct image *img,
-			 int applied_pos,
+			 size_t applied_pos,
 			 struct image *preimage,
 			 struct image *postimage)
 {
@@ -2803,7 +2804,7 @@ static void update_image(struct apply_state *state,
 	size_t remove_count, insert_count, applied_at = 0;
 	size_t result_alloc;
 	char *result;
-	int preimage_limit;
+	size_t preimage_limit;
 
 	/*
 	 * If we are removing blank lines at the end of img,
@@ -4288,19 +4289,19 @@ static void summary_patch_list(struct patch *patch)
 
 static void patch_stats(struct apply_state *state, struct patch *patch)
 {
-	int lines = patch->lines_added + patch->lines_deleted;
+	unsigned lines = patch->lines_added + patch->lines_deleted;
 
 	if (lines > state->max_change)
 		state->max_change = lines;
 	if (patch->old_name) {
-		int len = quote_c_style(patch->old_name, NULL, NULL, 0);
+		size_t len = quote_c_style(patch->old_name, NULL, NULL, 0);
 		if (!len)
 			len = strlen(patch->old_name);
 		if (len > state->max_len)
 			state->max_len = len;
 	}
 	if (patch->new_name) {
-		int len = quote_c_style(patch->new_name, NULL, NULL, 0);
+		size_t len = quote_c_style(patch->new_name, NULL, NULL, 0);
 		if (!len)
 			len = strlen(patch->new_name);
 		if (len > state->max_len)
-- 
2.43.0

