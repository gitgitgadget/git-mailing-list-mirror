Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA41E86E
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641968; cv=none; b=O4wvprVIO3ulEF/KTdirHCPHe55hCpuLyn+1eY03Mw9wlERo1/+o6u7RDwaB+4fmCL/keloOGlKmmHdXu8KBcfSOOxp7p0yLDI6hGDpjEY/SoTNmhz1LTp0sFYiQCYUU5TKl8YcN5k6kOpik5Ph4TCAyK+H8Tpyemcb5pp+Z54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641968; c=relaxed/simple;
	bh=6xlJ1gGQKOI4xOs56kfeiYTAyONRIc7Iyg4hmv1GiDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ftwz+b2Nr6xuvcXq/USAK8h3VbjjdqHpNrmNFMJDCfrjKWlV4rWJBNC7v8s5Pj2tczL7cWk29IISYoIIUG9hBkoWREAoQdRwZVR/NKXqQ+jpW3BevJZvKcOyuXHPYwslmhuNLfwWyM2Vsm/ubhSpcVUDDfOpPvlgVUEiYI9hwlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtKHQj/5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtKHQj/5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f441904a42so8586499a91.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 20:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738641965; x=1739246765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBcfQ8xtF9dJ3pPWlAz6t2ayP8DV495Jxn2BMDhOA5M=;
        b=VtKHQj/5lfLEMCuHhqSN2wcoimIt8mxiPg+0EnaMj62Y4JtVcS8fEX5EWeJLVP6LXb
         9afehBIEgJF3yrS07WUa1iAgfzzMx/JfGIYez1wGIpMqFp27dP721AJ0wZ3D+TCdYn3d
         WQNkLSc5xKbnBeeZFL8wm8YdkYoFFCyzQDwoy7xdbPnkWpD0D35N+u5DyLzpjBBLBXyd
         /rkBjsxn15GiE5UIQZB9NpoN7NgrcxMnpN9RTN6yytAx+MeSZx9/giMfs7vguvd+H9+Q
         yW2uBGkJXlGjVGnsmV8UCq9w1SLERsEGL9BqM2RYRpliLxywrfOb+M0fYOLTKb3tSKC1
         4apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738641965; x=1739246765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBcfQ8xtF9dJ3pPWlAz6t2ayP8DV495Jxn2BMDhOA5M=;
        b=o1Igo1rSd8oFB94/WRwlLsxYwCcUDwqtw94bvY7Lj4OmsPO9Al150j72ETzey+NzkB
         8Zmp5xNy1fEUFsFN6gagiWo4hVazdOgQu0GjLoQmv1PM2+fqA68o8oU9j1DHu7k2uJQw
         AD9mTp+IboznC1ftbLdze6DYq2MvWE4U7iNcPPJsCgVufPCcvpohy/5gHqU142S2l+A5
         2e52KHXZF9NrM0faQD3M2vZD6cK1p9CaJDg4K6qnYN3031zp0eXzaBjPV8Wy3m+A59PX
         G4VpXrkYICLCZrZNp8CTSAEPzm00WdlTZAbpYgVXMgLfUSoEFWuL+XlhXMZ1Er5qe8Lm
         tmzQ==
X-Gm-Message-State: AOJu0YwbRQFSosEWqpCko1Isykw7fOyO74j8+znS+BCU2yzLawX8MEif
	BpcNp4v+tOaH1CMhkOV2d3X/StvjHP5kGYwRQ7sRcSEwQqIb/MTphoJrmg==
X-Gm-Gg: ASbGncsaQFEMOKT5RKcUf3bFM5/YXl1f3bKRNAsls4uXVPg8RIdfKE3y4v1hYxUfjC5
	hbVqpvsAn4gOq2KCIntIR0pghBFJtsU1CmJchbA3Lr4b6uwx3oJ7zuFs1Ew1SvqOX0VQcdFt7aF
	FeNAKaGETQJFGeM6MfdR2oKp+6ZYWsZmJQqP8Ru7NfyCkW+ak3iatAOHLvBe82bOrOpxfcMy4nq
	Vu3DG+ERf0AFtieKIGpAJObdqRaR0K6TxMRLNz6UHtcFeb0Do1pwHI8fCNe/ER1D8L2QbhkBfel
	kker6OYBIzUDpg==
X-Google-Smtp-Source: AGHT+IGIdk07zJ/8y3kLKQmks9JjsFJU59fm8caBp0aoWr1CfbVnTV394/OA0EEx+EbxkgwBuF6l8w==
X-Received: by 2002:a17:90b:2711:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-2f83ac5e592mr34086378a91.27.1738641964374;
        Mon, 03 Feb 2025 20:06:04 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bd09cb1sm12272583a91.21.2025.02.03.20.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:06:03 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v4 0/5] refspec: centralize refspec-related logic
Date: Tue,  4 Feb 2025 09:35:53 +0530
Message-Id: <20250204040558.34766-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201064202.76116-1-meetsoni3017@gmail.com>
References: <20250201064202.76116-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
    - updated commit message.
    - renamed functions as per review.
    - added GSoC mark , since the announcement has been made by google and
      we've started the discussion regarding the same.

Additional context of the series:
    Patrick pointed out in [1], the logic related to refspec is currently
    split across multiple headers. This patch series addresses that by
    renaming and relocating refspec-related logic from remote to refspec for
    improved cohesion.

    [1]: https://lore.kernel.org/git/ZysQvUyxgdRqjvj2@pks.im/

    Specifically, the following changes have been made:

        Refactoring and renaming functions: Functions such as
        omit_name_by_refspec() have been renamed to better reflect their
        functionality. 

        Relocation of functions: Functions that are primarily responsible
        for refspec related functionality, have been relocated from remote.c
        to refspec.c to maintain a clear separation of concerns.

Meet Soni (5):
  remote: rename function omit_name_by_refspec
  refspec: relocate refname_matches_negative_refspec_item
  remote: rename query_refspecs functions
  refspec: relocate matching related functions
  refspec: relocate apply_refspecs and related funtions

 builtin/push.c   |   2 +-
 builtin/remote.c |   2 +-
 refspec.c        | 203 ++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h        |  37 +++++++++
 remote.c         | 205 +----------------------------------------------
 remote.h         |  15 ----
 6 files changed, 244 insertions(+), 220 deletions(-)

Range-diff against v3:
1:  399e59ff67 ! 1:  1b8606ffcb refactor(remote): rename function omit_name_by_refspec
    @@ Metadata
     Author: Meet Soni <meetsoni3017@gmail.com>
     
      ## Commit message ##
    -    refactor(remote): rename function omit_name_by_refspec
    +    remote: rename function omit_name_by_refspec
     
         Rename the function `omit_name_by_refspec()` to
         `refname_matches_negative_refspec_item()` to provide clearer intent.
2:  4109b2bd1c = 2:  3da817839c refspec: relocate refname_matches_negative_refspec_item
3:  559224864f ! 3:  bad0c43c96 refactor(remote): rename query_refspecs functions
    @@ Metadata
     Author: Meet Soni <meetsoni3017@gmail.com>
     
      ## Commit message ##
    -    refactor(remote): rename query_refspecs functions
    +    remote: rename query_refspecs functions
     
    -    Rename `query_refspecs()` to `find_refspec_match` for clarity, as it
    -    finds a single matching refspec.
    +    Rename functions related to handling refspecs in preparation for their
    +    move from `remote.c` to `refspec.c`. Update their names to better
    +    reflect their intent:
     
    -    Rename `query_refspecs_multiple()` to `find_all_refspec_matches` to
    -    better reflect that it collects all matching refspecs instead of
    -    returning just the first match.
    +        - `query_refspecs()` -> `refspec_find_match()` for clarity, as it
    +          finds a single matching refspec.
     
    -    Rename `query_matches_negative_refspec()` to
    -    `find_negative_refspec_match` for consistency with the updated naming
    -    convention.
    +        - `query_refspecs_multiple()` -> `refspec_find_all_matches()` to
    +          better reflect that it collects all matching refspecs instead of
    +          returning just the first match.
    +
    +        - `query_matches_negative_refspec()` ->
    +          `refspec_find_negative_match()` for consistency with the
    +          updated naming convention, even though this static function
    +          didn't strictly require renaming.
     
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
    @@ builtin/push.c: static void refspec_append_mapped(struct refspec *refspec, const
      		};
      
     -		if (!query_refspecs(&remote->push, &query) && query.dst) {
    -+		if (!find_refspec_match(&remote->push, &query) && query.dst) {
    ++		if (!refspec_find_match(&remote->push, &query) && query.dst) {
      			refspec_appendf(refspec, "%s%s:%s",
      					query.force ? "+" : "",
      					query.src, query.dst);
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
      }
      
     -static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
    -+static int find_negative_refspec_match(struct refspec *rs, struct refspec_item *query)
    ++static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *query)
      {
      	int i, matched_negative = 0;
      	int find_src = !query->src;
    @@ remote.c: static int query_matches_negative_refspec(struct refspec *rs, struct r
      }
      
     -static void query_refspecs_multiple(struct refspec *rs,
    -+static void find_all_refspec_matches(struct refspec *rs,
    ++static void refspec_find_all_matches(struct refspec *rs,
      				    struct refspec_item *query,
      				    struct string_list *results)
      {
    @@ remote.c: static void query_refspecs_multiple(struct refspec *rs,
      
      	if (find_src && !query->dst)
     -		BUG("query_refspecs_multiple: need either src or dst");
    -+		BUG("find_all_refspec_matches: need either src or dst");
    ++		BUG("refspec_find_all_matches: need either src or dst");
      
     -	if (query_matches_negative_refspec(rs, query))
    -+	if (find_negative_refspec_match(rs, query))
    ++	if (refspec_find_negative_match(rs, query))
      		return;
      
      	for (i = 0; i < rs->nr; i++) {
    @@ remote.c: static void query_refspecs_multiple(struct refspec *rs,
      }
      
     -int query_refspecs(struct refspec *rs, struct refspec_item *query)
    -+int find_refspec_match(struct refspec *rs, struct refspec_item *query)
    ++int refspec_find_match(struct refspec *rs, struct refspec_item *query)
      {
      	int i;
      	int find_src = !query->src;
    @@ remote.c: int query_refspecs(struct refspec *rs, struct refspec_item *query)
      
      	if (find_src && !query->dst)
     -		BUG("query_refspecs: need either src or dst");
    -+		BUG("find_refspec_match: need either src or dst");
    ++		BUG("refspec_find_match: need either src or dst");
      
     -	if (query_matches_negative_refspec(rs, query))
    -+	if (find_negative_refspec_match(rs, query))
    ++	if (refspec_find_negative_match(rs, query))
      		return -1;
      
      	for (i = 0; i < rs->nr; i++) {
    @@ remote.c: char *apply_refspecs(struct refspec *rs, const char *name)
      	query.src = (char *)name;
      
     -	if (query_refspecs(rs, &query))
    -+	if (find_refspec_match(rs, &query))
    ++	if (refspec_find_match(rs, &query))
      		return NULL;
      
      	return query.dst;
    @@ remote.c: char *apply_refspecs(struct refspec *rs, const char *name)
      int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
      {
     -	return query_refspecs(&remote->fetch, refspec);
    -+	return find_refspec_match(&remote->fetch, refspec);
    ++	return refspec_find_match(&remote->fetch, refspec);
      }
      
      static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
    @@ remote.c: static int get_stale_heads_cb(const char *refname, const char *referen
      	query.dst = (char *)refname;
      
     -	query_refspecs_multiple(info->rs, &query, &matches);
    -+	find_all_refspec_matches(info->rs, &query, &matches);
    ++	refspec_find_all_matches(info->rs, &query, &matches);
      	if (matches.nr == 0)
      		goto clean_exit; /* No matches */
      
    @@ remote.h: int refname_matches_negative_refspec_item(const char *refname, struct
      struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
      
     -int query_refspecs(struct refspec *rs, struct refspec_item *query);
    -+int find_refspec_match(struct refspec *rs, struct refspec_item *query);
    ++int refspec_find_match(struct refspec *rs, struct refspec_item *query);
      char *apply_refspecs(struct refspec *rs, const char *name);
      
      int check_push_refs(struct ref *src, struct refspec *rs);
4:  13e49509fc ! 4:  9a5dc26731 refspec: relocate matching related functions
    @@ Metadata
      ## Commit message ##
         refspec: relocate matching related functions
     
    -    Move the functions `find_refspec_match()`, `find_all_refspec_matches()`
    -    and `find_negative_refspec_match()` from `remote.c` to `refspec.c`.
    +    Move the functions `refspec_find_match()`, `refspec_find_all_matches()`
    +    and `refspec_find_negative_match()` from `remote.c` to `refspec.c`.
         These functions focus on matching refspecs, so centralizing them in
         `refspec.c` improves code organization by keeping refspec-related logic
         in one place.
    @@ refspec.c: int refname_matches_negative_refspec_item(const char *refname, struct
      	return 0;
      }
     +
    -+static int find_negative_refspec_match(struct refspec *rs, struct refspec_item *query)
    ++static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *query)
     +{
     +	int i, matched_negative = 0;
     +	int find_src = !query->src;
    @@ refspec.c: int refname_matches_negative_refspec_item(const char *refname, struct
     +	return matched_negative;
     +}
     +
    -+void find_all_refspec_matches(struct refspec *rs,
    ++void refspec_find_all_matches(struct refspec *rs,
     +				    struct refspec_item *query,
     +				    struct string_list *results)
     +{
    @@ refspec.c: int refname_matches_negative_refspec_item(const char *refname, struct
     +	int find_src = !query->src;
     +
     +	if (find_src && !query->dst)
    -+		BUG("find_all_refspec_matches: need either src or dst");
    ++		BUG("refspec_find_all_matches: need either src or dst");
     +
    -+	if (find_negative_refspec_match(rs, query))
    ++	if (refspec_find_negative_match(rs, query))
     +		return;
     +
     +	for (i = 0; i < rs->nr; i++) {
    @@ refspec.c: int refname_matches_negative_refspec_item(const char *refname, struct
     +	}
     +}
     +
    -+int find_refspec_match(struct refspec *rs, struct refspec_item *query)
    ++int refspec_find_match(struct refspec *rs, struct refspec_item *query)
     +{
     +	int i;
     +	int find_src = !query->src;
    @@ refspec.c: int refname_matches_negative_refspec_item(const char *refname, struct
     +	char **result = find_src ? &query->src : &query->dst;
     +
     +	if (find_src && !query->dst)
    -+		BUG("find_refspec_match: need either src or dst");
    ++		BUG("refspec_find_match: need either src or dst");
     +
    -+	if (find_negative_refspec_match(rs, query))
    ++	if (refspec_find_negative_match(rs, query))
     +		return -1;
     +
     +	for (i = 0; i < rs->nr; i++) {
    @@ refspec.h: int refname_matches_negative_refspec_item(const char *refname, struct
     + * Queries a refspec for a match and updates the query item.
     + * Returns 0 on success, -1 if no match is found or negative refspec matches.
     + */
    -+int find_refspec_match(struct refspec *rs, struct refspec_item *query);
    ++int refspec_find_match(struct refspec *rs, struct refspec_item *query);
     +
     +/*
     + * Queries a refspec for all matches and appends results to the provided string
     + * list.
     + */
    -+void find_all_refspec_matches(struct refspec *rs,
    ++void refspec_find_all_matches(struct refspec *rs,
     +				    struct refspec_item *query,
     +				    struct string_list *results);
     +
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
      	return ref_map;
      }
      
    --static int find_negative_refspec_match(struct refspec *rs, struct refspec_item *query)
    +-static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *query)
     -{
     -	int i, matched_negative = 0;
     -	int find_src = !query->src;
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
     -	return matched_negative;
     -}
     -
    --static void find_all_refspec_matches(struct refspec *rs,
    +-static void refspec_find_all_matches(struct refspec *rs,
     -				    struct refspec_item *query,
     -				    struct string_list *results)
     -{
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
     -	int find_src = !query->src;
     -
     -	if (find_src && !query->dst)
    --		BUG("find_all_refspec_matches: need either src or dst");
    +-		BUG("refspec_find_all_matches: need either src or dst");
     -
    --	if (find_negative_refspec_match(rs, query))
    +-	if (refspec_find_negative_match(rs, query))
     -		return;
     -
     -	for (i = 0; i < rs->nr; i++) {
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
     -	}
     -}
     -
    --int find_refspec_match(struct refspec *rs, struct refspec_item *query)
    +-int refspec_find_match(struct refspec *rs, struct refspec_item *query)
     -{
     -	int i;
     -	int find_src = !query->src;
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
     -	char **result = find_src ? &query->src : &query->dst;
     -
     -	if (find_src && !query->dst)
    --		BUG("find_refspec_match: need either src or dst");
    +-		BUG("refspec_find_match: need either src or dst");
     -
    --	if (find_negative_refspec_match(rs, query))
    +-	if (refspec_find_negative_match(rs, query))
     -		return -1;
     -
     -	for (i = 0; i < rs->nr; i++) {
5:  891e01be93 ! 5:  f13ac6f11f refspec: relocate apply_refspecs and related funtions
    @@ refspec.c
      #include "strbuf.h"
      
      /*
    -@@ refspec.c: int find_refspec_match(struct refspec *rs, struct refspec_item *query)
    +@@ refspec.c: int refspec_find_match(struct refspec *rs, struct refspec_item *query)
      	}
      	return -1;
      }
    @@ refspec.c: int find_refspec_match(struct refspec *rs, struct refspec_item *query
     +	memset(&query, 0, sizeof(struct refspec_item));
     +	query.src = (char *)name;
     +
    -+	if (find_refspec_match(rs, &query))
    ++	if (refspec_find_match(rs, &query))
     +		return NULL;
     +
     +	return query.dst;
     +}
     
      ## refspec.h ##
    -@@ refspec.h: void find_all_refspec_matches(struct refspec *rs,
    +@@ refspec.h: void refspec_find_all_matches(struct refspec *rs,
      				    struct refspec_item *query,
      				    struct string_list *results);
      
    @@ remote.c: void ref_push_report_free(struct ref_push_report *report)
     -	memset(&query, 0, sizeof(struct refspec_item));
     -	query.src = (char *)name;
     -
    --	if (find_refspec_match(rs, &query))
    +-	if (refspec_find_match(rs, &query))
     -		return NULL;
     -
     -	return query.dst;
    @@ remote.c: void ref_push_report_free(struct ref_push_report *report)
     -
      int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
      {
    - 	return find_refspec_match(&remote->fetch, refspec);
    + 	return refspec_find_match(&remote->fetch, refspec);
     
      ## remote.h ##
     @@ remote.h: int resolve_remote_symref(struct ref *ref, struct ref *list);
    @@ remote.h: int resolve_remote_symref(struct ref *ref, struct ref *list);
     - */
     -struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
     -
    --int find_refspec_match(struct refspec *rs, struct refspec_item *query);
    +-int refspec_find_match(struct refspec *rs, struct refspec_item *query);
     -char *apply_refspecs(struct refspec *rs, const char *name);
     -
      int check_push_refs(struct ref *src, struct refspec *rs);
-- 
2.34.1

