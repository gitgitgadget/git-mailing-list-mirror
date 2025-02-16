Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79423B672
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739690951; cv=none; b=iQUpvBXoyjozBP+17fzGvRV0+hsXsAZfeoKTvJpCIy3gTdaQEKmX5fDcL2nSak2HjjT+oXFWeaZ6n0yaRQRrqf1NxGRP+PVy0hpcdUnsCgAso6qkH9TVofYzCuo3nUU9VYIZMdQega2OlGJTuleg1PYdKLBHq3teSokjSqOiuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739690951; c=relaxed/simple;
	bh=L97uqd3sLNBKo+FK6c0iNgYNqP06wPSm1B2I1F3/cMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkL59EeViZ4eMzR/01v37AQGWUZPYiNoa+P+aGbnfh0qGxS38R4dpugboG7TKYY2HDQSrV3vv1amUSt0tQ4qUnoMSpPGMS25a7Ksp1L8l2CDyTdmfFS2MYqtzwlFEXJR8pWst5x69Y7M7AZkGosATcKkpaZsTUssUP0U34rqgmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHi23qnY; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHi23qnY"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-221057b6ac4so13904705ad.2
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 23:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739690949; x=1740295749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW3GJL1w1YE4b66b05X6/VtLklfMes5sdCAOsRfsWBo=;
        b=CHi23qnYULN3FArE+OXT5O4kOwQH4hSFR58PKL8tvlVOXJbCcLngqW7n4tevghJB0O
         ffhxMOr0WPzfD3TGu3FjQ/Xq6S2XeueR/J9Iy7Lk7/lu31rfflRqHSDI1oAA9ijVrE+B
         RXf1oTvAh2HZ1sCUAKll7J+PrRgtSkLJLdtdW+SmeXxCY2WFdc6Yp+iXhJf+10+Vvt19
         t5iFOI7crFlnQwTFfEDLi83KSjzWhQC8wxl906yJr093us7FMHkKVnGvgozEe3ggPrRH
         DVIG8PYaqIy7sWh4Kv+Q8MtP2/Fs0J5OuxXBSDYRlbMeFo9X0kd1Glwwt4gb9YkrerMF
         QU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739690949; x=1740295749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gW3GJL1w1YE4b66b05X6/VtLklfMes5sdCAOsRfsWBo=;
        b=oo4kmkZlN92qb3x6eY0ACNHTZf0uPaLF52Ise1anzDqAt0svSIOQrX//UIOP8n5vWs
         j0F4yiWzOq5Kd6W0j9ec9+0TrwvwAFnwxZ4MbLgg/m9d7zwRyxS49TECJzv5jm8LybFs
         td1FGlW6/5H2l72k6N5KFUGMmCjZlo+r9oGdSdKSg9cHY+ap1H2r4eGkrkDak6TsVzUC
         TUmnfKXcW8KoSIus+yIAwKe8XSXQI3rGJnkN9PxPi1zGvHZV9pSfrHIn3TvQPx8dS0Nb
         lMNy4zFftHHGK75Wxb/rBTa0zcjJKjgkJqeXoEqLCHihuEtukZQQuJH+6YZAp1eFGEmh
         pegg==
X-Gm-Message-State: AOJu0YxVPSS9+m4sl1CEm453A1lWgXCHfo3k01Z435T8lhxHTOIQyJ+h
	9eiGI9D5p6ru1Q8GBupFMb/bcfdhx/DnfP6kI2mPklqwBHH4G/EKdpUt34OzmlWQLEXOgdk=
X-Gm-Gg: ASbGnctPYZ4Mw4FkFqvkUKvC4a+AStrpFw27fCQdXbhh93898s3qHvYYVFdc/9po2vQ
	jlaOE+xNRqxzSlkA5Gozmnqm5rd9KcrW2uAYRoMV5tCQZ8U9rG5kXeBfX6Wu/dP1Hlt/NMfFEH0
	Ox7h76hEw3h4bvXAVVmvLQLxKLLMwa7Mhew8Fxl1d5xdyk9HT40H3OB2rvVQQFQf+WI/uepCWS8
	J29LcNiXbXk3/VlRw40bikpTPH0AZzta45/qyzWKSeSzxVrg9DiUUY5GCpzK0MOXe0TDxh08bCI
	/Qjgu2ONCtnY/Z4soU56wzWop9azIJSmXqTUnGCwbV7Wpb8LqiYW1biY8z3Z9NqxwhjtJTGVEkh
	bxoa5FFclt3Nmj0PJKSF0yV9rd4HIt2o6Vw==
X-Google-Smtp-Source: AGHT+IFz1x2LvBE1ApS08GvpjYSHtYYMH4qy0G0/4ffgFVLgXwJq9rRXoCBNxzMX/t0J2TcTfeegOw==
X-Received: by 2002:a17:903:22c7:b0:21f:45b:6a4c with SMTP id d9443c01a7336-22103efb4f5mr78636145ad.7.1739690948622;
        Sat, 15 Feb 2025 23:29:08 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-18-166-75-244.ap-east-1.compute.amazonaws.com. [18.166.75.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc327a9d68sm4483243a91.1.2025.02.15.23.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 23:29:08 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com
Subject: [GSOC][PATCH v3 0/6] apply: address -Wsign-comparison warnings
Date: Sun, 16 Feb 2025 07:28:37 +0000
Message-ID: <20250216072843.72385-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the v3 of this patch set.

Changes from v2:

  - change `patch::lines_added/deleted` to unsigned

  - use `unsigned int` instead of `unsigned`

  - separate irrelevant changes from the "loop counter" commit

Below are the cover letter from the v2.

There are several -Wsign-comparison warnings in "apply.c", which can be
classified into the following three types:

  1. comparing a length of `size_t` type with a `ptrdiff_t` value

  2. comparing a length of `size_t` type with a length of `int` type

  3. comparing a loop counter `i` of `int` type with an unsigned loop
  bound

Fix these warnings following one basic principle: do not touch the
relevant logics and keep the behaviors of the code. Adopt three
different strategies for each of the above three types:

  1. cast the `ptrdiff_t` values to `size_t` type

  2. try to change the type of the `int` length to `size_t` (may fall 
  back to Strategy 1 if the variable is not guaranteed to be unsigned)

  3. use a loop counter `i` of `size_t` type

Zejun Zhao (6):
  apply: correct type misuse in `apply.h`
  apply: change some variables from `int` to `size_t`
  apply: do a typecast to eliminate warnings
  apply: cast some ptrdiff_t's to size_t's
  apply: use `size_t` loop counters
  apply: enable -Wsign-comparison checks

 apply.c | 69 +++++++++++++++++++++++++++------------------------------
 apply.h |  6 ++---
 2 files changed, 36 insertions(+), 39 deletions(-)

Range-diff against v2:
1:  16ee2f93a3 ! 1:  a5985e0e16 apply: change fields in `apply_state` to unsigned
    @@ Metadata
     Author: Zejun Zhao <jelly.zhao.42@gmail.com>
     
      ## Commit message ##
    -    apply: change fields in `apply_state` to unsigned
    +    apply: correct type misuse in `apply.h`
     
    -    `.max_change` and `.max_len` of `apply_state` are only used as unsigned
    -    integers. Misuse of `int` type would cause -Wsign-comparison warnings.
    +    There are a few `int` fields of structs in `apply.h` that are only used
    +    as unsigned integer and are only assigned unsigned integer value. Some
    +    of these misuse of `int` type would cause -Wsign-comparison warnings.
     
         Fix this by
     
    -      - change `.max_change`'s type to `unsigned` since it's just a counter
    +      - change `apply_state::max_change`'s type to `unsigned int` since it's
    +        just a counter of lines
     
    -      - change `.max_len`'s type to `size_t` since it's a length
    +      - change `apply_state::max_len`'s type to `size_t` since it's storing
    +        a length
     
    -      - change the types of relevant variables in function `show_stats`
    +      - change `patch::lines_added/deleted`'s types to `unsigned int` since
    +        they are just counters of lines
    +
    +      - change the types of relevant variables in function `show_stats` and
    +        `patch_stats`
     
         Note that `printf`'s format string requires us to do some typecast
         (from `size_t` to `int`) on `max` in function `show_stats`. This is
    @@ apply.c: static void show_stats(struct apply_state *state, struct patch *patch)
      	char *cp = patch->new_name ? patch->new_name : patch->old_name;
     -	int max, add, del;
     +	size_t max;
    -+	unsigned add, del;
    ++	unsigned int add, del;
      
      	quote_c_style(cp, &qname, NULL, 0);
      
    @@ apply.c: static void show_stats(struct apply_state *state, struct patch *patch)
      
      	if (state->max_change > 0) {
     -		int total = ((add + del) * max + state->max_change / 2) / state->max_change;
    -+		unsigned total = ((add + del) * max + state->max_change / 2) / state->max_change;
    ++		unsigned int total = ((add + del) * max + state->max_change / 2) / state->max_change;
      		add = (add * max + state->max_change / 2) / state->max_change;
      		del = total - add;
      	}
    +@@ apply.c: static void summary_patch_list(struct patch *patch)
    + 
    + static void patch_stats(struct apply_state *state, struct patch *patch)
    + {
    +-	int lines = patch->lines_added + patch->lines_deleted;
    ++	unsigned int lines = patch->lines_added + patch->lines_deleted;
    + 
    + 	if (lines > state->max_change)
    + 		state->max_change = lines;
     
      ## apply.h ##
     @@ apply.h: struct apply_state {
    @@ apply.h: struct apply_state {
      	 */
     -	int max_change;
     -	int max_len;
    -+	unsigned max_change;
    ++	unsigned int max_change;
     +	size_t max_len;
      
      	/*
      	 * Records filenames that have been touched, in order to handle
    +@@ apply.h: struct patch {
    + 	int is_new, is_delete;	/* -1 = unknown, 0 = false, 1 = true */
    + 	int rejected;
    + 	unsigned ws_rule;
    +-	int lines_added, lines_deleted;
    ++	unsigned int lines_added, lines_deleted;
    + 	int score;
    + 	int extension_linenr; /* first line specifying delete/new/rename/copy */
    + 	unsigned int is_toplevel_relative:1;
2:  962ab421cf ! 2:  b73f3e9fae apply: change some variables from `int` to `size_t`
    @@ Commit message
     
         some of which will trigger -Wsign-comparison warnings.
     
    -    Change some of them to `size_t`/`unsigned`.
    +    Change some of them to `size_t`/`unsigned int`.
     
         Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
     
    @@ apply.c: static void update_pre_post_images(struct image *preimage,
      	const char *fixed;
      
      	/*
    +@@ apply.c: static int line_by_line_fuzzy_match(struct image *img,
    + 				    struct image *postimage,
    + 				    unsigned long current,
    + 				    int current_lno,
    +-				    int preimage_limit)
    ++				    size_t preimage_limit)
    + {
    + 	int i;
    + 	size_t imgoff = 0;
     @@ apply.c: static int match_fragment(struct apply_state *state,
      	struct strbuf fixed = STRBUF_INIT;
      	char *fixed_buf;
    @@ apply.c: static void update_image(struct apply_state *state,
      
      	/*
      	 * If we are removing blank lines at the end of img,
    -@@ apply.c: static void summary_patch_list(struct patch *patch)
    - 
    - static void patch_stats(struct apply_state *state, struct patch *patch)
    - {
    --	int lines = patch->lines_added + patch->lines_deleted;
    -+	unsigned lines = patch->lines_added + patch->lines_deleted;
    - 
    +@@ apply.c: static void patch_stats(struct apply_state *state, struct patch *patch)
      	if (lines > state->max_change)
      		state->max_change = lines;
      	if (patch->old_name) {
3:  09f42cbd5a = 3:  85938a18b1 apply: do a typecast to eliminate warnings
4:  1142213871 = 4:  ba31e9406d apply: cast some ptrdiff_t's to size_t's
5:  8e27fb9c08 ! 5:  351e561843 apply: use `size_t` loop counters
    @@ apply.c: static void update_pre_post_images(struct image *preimage,
      
      		if (!(postimage->line[i].flag & LINE_COMMON)) {
     @@ apply.c: static int line_by_line_fuzzy_match(struct image *img,
    - 				    struct image *postimage,
    - 				    unsigned long current,
      				    int current_lno,
    --				    int preimage_limit)
    -+				    size_t preimage_limit)
    + 				    size_t preimage_limit)
      {
     -	int i;
     +	size_t i;
6:  60155b1aeb = 6:  cdb3e806a1 apply: enable -Wsign-comparison checks
-- 
2.43.0

