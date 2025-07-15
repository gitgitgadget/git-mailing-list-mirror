Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DC1547C9
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578914; cv=none; b=DFV8D55bGmXfaoykPOAI43QyFXtqXUyJtGqS+8GfsdHHHWlIgmSp5ntgE1dH7t91Uua9yQAcpTIZ6PeyzaVfyroZ1SsqsxAzXUhOg5sBGUiUeXAi+EvhsBHNG1xj90lHSSCo4MS+u4WzGb1b/54uO9Jo00S8DDGQtHZzktcBRxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578914; c=relaxed/simple;
	bh=p5MEHjX5luWfAKFl0MLx41KUWAsdnuWsJpzSlnLg8ZM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ag6HnFsE4I68ia2gtB7C0/qdvy6AUEjNyya4McQJTtPlm6yjnpPMgaLdbmqp5vaiRqcBCQyRfZZhow+MfXhr0QcJuCjIMTyFLBZ6xMbEUsnfZBZ8U815Vy+bZyO2n3+GrQZN3iOOQyaRP5NRVxZiJyqgPUa3UoOPJN5q5rZBkbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDASdDxV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDASdDxV"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so8872355a12.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752578911; x=1753183711; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ha9LqsfimhLRymGFrx/4YchuuVGiBiAEf5Gdi2TtBEs=;
        b=IDASdDxVUxR6zkf1nT+JXNa7OnhHL1RDSM59mNj/Bn0DVReGFjAqw/UGJMZX4AYvIy
         r+lsqMmP1bkTTFznVeh0YjC4OIIYvtk2ar3c/vgPp8UqGjNkBzIZkrrA3CadtmRDcbwF
         QoKbL9+GWtirjRgEdZ6lifyUbiaUhNViVFsCfYv16aGP0o/NXOBL7/uydeIoxvt08T3L
         CnzLAu+7wHU6iqIQ/c8qNQa3radBT+oftK3RxNrwgfi5Xnfnm+TRrl1lrYEKSA9Knq8m
         kU0427Aw4t3ielrRsosUdEVEhBxDybTpmmdoIE5TKc1YxsBY1jSBebYYWJGeE4mQggH7
         gHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578911; x=1753183711;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ha9LqsfimhLRymGFrx/4YchuuVGiBiAEf5Gdi2TtBEs=;
        b=uouFqMVpOOM1EaONs7zBAKocTZ3dvrtPfURp7njjTlblqUipUzJPLn6nefKZjIRf6G
         A6cdXgBVWqMaSox3CE9DiUXIORnXNIuMaK+RGstGIyDiZ3B7WU54e/FUIEIjbKjtfk11
         lSIgZTcWV10UZVx/IiOHJ6dYDbZMglF8mEnqJe/0CozYZk1Le6acGNVvdi8Q3IYEH7Dw
         /9jQaSteu27NIUQpv5qIbe3zLUWwSJYSa5QgOf9HktatPKSZMYWE3t6AkXn5fqGOo5tb
         ORWcZGjdzEGzzsT/v7OigL2fIPExD2sdgOa7OAkLX0eTsRjZY9gsL3BP5BjnMGEe7rT9
         yUhg==
X-Gm-Message-State: AOJu0YwoT/cj875TmM957t0FhVCnlM5mEIiniKp+0lhB3XCvFu+k8Xgs
	F0KcO+tZZvcqHJys6RGckc76K76LTm0hWTE0qqojTh2xmzLi+H4OdwYT
X-Gm-Gg: ASbGncuhMkcwTU+NZ+35LCDReuRuOUuaWVqjwbuazMzjGxxacEpmXCxRP8ecCbWdGr/
	GvCF4C9EHHuYDAkfWIsqt/g1W6X8PDcgfl2FNB5rXNk8yguc8cuO5flaYqYEC/EgNKvcZsFpZ6V
	BZ3jZxiQZOPuCJs4YcwYqUFH0W+GLicjnZcf9xGbftUDvNo9VsPcsEmBgDISwlJ64fiSKGl2bzG
	3Ynb29QgCfakCC1J3jI1qYTuXOH5nb36P+F38ICXXsrBqEeQ6f3HMTXnmcK81uzXxdHU//anZ0+
	Dv7Dww6zIANEt1v8J+0WbhLDUSi3OJhotNV0mClPUI6UJarkDS45fWJL3UUveabNocfFIZ0RbIu
	5E6L8
X-Google-Smtp-Source: AGHT+IFNfijdrCYy1K+0C5/UCzinKgrbJ6dgZ9iyVWL4UeTV70Lv32CGvyFuaubdjrM/zQ5Tsp07qA==
X-Received: by 2002:a05:6402:34d5:b0:607:e83a:d698 with SMTP id 4fb4d7f45d1cf-611e760c177mr13969366a12.2.1752578910329;
        Tue, 15 Jul 2025 04:28:30 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:624:7896:99ce:d9ca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976dc62sm7206596a12.59.2025.07.15.04.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:28:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via
 '--start-after'
Date: Tue, 15 Jul 2025 13:28:25 +0200
Message-Id: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFk7dmgC/43PTY7CMAwF4KugrDFyfhrCrOYeIxZO4rSRoEVpV
 Q1CvfsEZlOxKctny9+TH2LkknkUX7uHKDznMQ99Dc1+J0JHfcuQY81CoWrQYgMaLbR5gjQUYAo
 dFE5wozb3NNVbQE+O1InYGiuqcqv7/Ptq+DnX3OVxGsr9VTjL5/TfPqLctGcJCCYh8TGgdS59t
 1fKl0MYruJpz2rtmW1PVc+HyNJQiNHJd0+vPbft6eq5kDxJdOjZvHtm5ckP/jXV46g1aoqNd6e
 1tyzLH0HH366+AQAA
X-Change-ID: 20250605-306-git-for-each-ref-pagination-0ba8a29ae646
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14266;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=p5MEHjX5luWfAKFl0MLx41KUWAsdnuWsJpzSlnLg8ZM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGh2O1uv7rYthnWzOFSlMxw/HhckNle1SGYX1
 DOMlPK4lobiLokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJodjtbAAoJED7VnySO
 Rox/Q98L/0Gy6MfBIuRv93ieE8JxQWrpnmQ+SoWf1igiIFDC+GvobSQUW+0/aJuAYbdqgWDXZ08
 YPQBXknJQ5262oDoYClOyyqcXMlOIfxwHlfGBU8+2u52IKneGmRbnk/pCFs1Aa+AV+Wxle/6vGu
 RnrRxe/z0LHXETxxNG53jo11cfcHD7WuAIQxI1izxo5yXdpeqB+J4cTk70Nl6F4DHFVe+EVliYr
 C+OOmFhWv6aok4Kn1y2no0Qp2XQalu9iieoaGlAIkabgq/XMXXhmHQJGhEqgxAd43Y2+F+Jif/T
 qDUERyKdPbliYGGLY+lgQOYP9+j4NkltD9cOu9xJksrWhKE2gz41E7XWNY4t/2x3dg8DV+mXRvo
 pW5aQkUg/0NTM7F9GULBwWHy47HhOa2NsGyJdSN6T+gyN2LyXjeeXV65a/UwDWTQBKuU1AhIxY3
 v8YVub01lbLdVLFyIg/iIhGyXvf9cIW2kZvHZULVWK5JmdmoPiQMexwnHd5AmmjCRZh6XMA9m93
 h0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git-for-each-ref(1)` command is used to iterate over references
present in a repository. In large repositories with millions of
references, it would be optimal to paginate this output such that we
can start iteration from a given reference. This would avoid having to
iterate over all references from the beginning each time when paginating
through results.

This series adds a '--start-after' option in 'git-for-each-ref(1)'. When
used, the reference iteration seeks to first reference following the
marker alphabetically. When paging, it should be noted that references
may be deleted, modified or added between invocations. Output will only
yield those references which follow the marker lexicographically. If the
marker does not exist, output begins from the first reference that would
come after it alphabetically.

This enables efficient pagination workflows like:
    git for-each-ref --count=100
    git for-each-ref --count=100 --start-after=refs/heads/branch-100
    git for-each-ref --count=100 --start-after=refs/heads/branch-200

To add this functionality, we expose the `ref_iterator` outside the
'refs/' namespace and modify the `ref_iterator_seek()` to actually seek
to a given reference and only set the prefix when the `set_prefix` field
is set.

On the reftable and packed backend, the changes are simple. But since
the files backend uses 'ref-cache' for reference handling, the changes
there are a little more involved, since we need to setup the right
levels and the indexing.

Initially I was also planning to cleanup all the `refs_for_each...()`
functions in 'refs.h' by simply using the iterator, but this bloated the
series. So I've left that for another day.

Changes in v5:
- Changes to the comments to refer to the flag
  'REF_ITERATOR_SEEK_SET_PREFIX' instead of a variable used in older
  versions. Also other small grammar fixes.
- Added a commit to remove an unnecessary else clause.
- Move seeking functionality within `for_each_fullref_in_pattern` to its
  own function.
- Fix incorrect naming in the tests.
- Link to v4: https://lore.kernel.org/r/20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com

Changes in v4:
- Patch 3/4: Move around the documentation for the flag and rename the
  seek variable to refname.
- Patch 4/4: Cleanup the commit message and also the documentation.
- Link to v3: https://lore.kernel.org/r/20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com

Changes in v3:
- Change the working of the command to exclude the marker provided. With
  this rename the flag to '--start-after'.
- Extend the documentation to add a note about concurrent modifications
  to the reference database.
- Link to v2: https://lore.kernel.org/r/20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com

Changes in v2:
- Modify 'ref_iterator_seek()' to take in flags instead of a
  'set_prefix' variable. This improves readability, where users would
  use the 'REF_ITERATOR_SEEK_SET_PREFIX' instead of simply passing '1'.
- When the set prefix flag isn't usage, reset any previously set prefix.
  This ensures that the internal prefix state is always reset whenever
  we seek and unifies the behavior between 'ref_iterator_seek' and
  'ref_iterator_begin'.
- Don't allow '--skip-until' to be run with '--sort', since the seeking
  always takes place before any sorting and this can be confusing.
- Some styling fixes:
  - Remove extra newline
  - Skip braces around single lined if...else clause
  - Add braces around 'if' clause
  - Fix indentation
- Link to v1: https://lore.kernel.org/git/20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com/

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.adoc |  10 +-
 builtin/for-each-ref.c              |   8 ++
 ref-filter.c                        | 116 ++++++++++++++-------
 ref-filter.h                        |   1 +
 refs.c                              |   6 +-
 refs.h                              | 155 ++++++++++++++++++++++++++++
 refs/debug.c                        |   7 +-
 refs/files-backend.c                |   7 +-
 refs/iterator.c                     |  26 +++--
 refs/packed-backend.c               |  17 ++--
 refs/ref-cache.c                    |  99 ++++++++++++++----
 refs/ref-cache.h                    |   7 --
 refs/refs-internal.h                | 152 ++--------------------------
 refs/reftable-backend.c             |  21 ++--
 t/t6302-for-each-ref-filter.sh      | 194 ++++++++++++++++++++++++++++++++++++
 15 files changed, 583 insertions(+), 243 deletions(-)

Karthik Nayak (5):
      refs: expose `ref_iterator` via 'refs.h'
      ref-cache: remove unused function 'find_ref_entry()'
      refs: selectively set prefix in the seek functions
      ref-filter: remove unnecessary else clause
      for-each-ref: introduce a '--start-after' option

Range-diff versus v4:

1:  dde167f421 = 1:  f9c9a7fdd9 refs: expose `ref_iterator` via 'refs.h'
2:  e392e93520 = 2:  83bee35517 ref-cache: remove unused function 'find_ref_entry()'
3:  711ffcac00 ! 3:  3b6019a1e7 refs: selectively set prefix in the seek functions
    @@ refs/refs-internal.h: void base_ref_iterator_init(struct ref_iterator *iter,
      /*
     - * Seek the iterator to the first reference matching the given prefix. Should
     - * behave the same as if a new iterator was created with the same prefix.
    -+ * Seek the iterator to the first matching reference. If set_prefix is set,
    -+ * it would behave the same as if a new iterator was created with the same
    -+ * prefix.
    ++ * Seek the iterator to the first matching reference. If the
    ++ * REF_ITERATOR_SEEK_SET_PREFIX flag is set, it would behave the same as if a
    ++ * new iterator was created with the provided refname as prefix.
       */
      typedef int ref_iterator_seek_fn(struct ref_iterator *ref_iterator,
     -				 const char *prefix);
-:  ---------- > 4:  3f89eeef26 ref-filter: remove unnecessary else clause
4:  3a0c89acbe ! 5:  7ee7d83cf0 for-each-ref: introduce a '--start-after' option
    @@ ref-filter.c: static int filter_exclude_match(struct ref_filter *filter, const c
     +	strbuf_release(&sb);
     +	return ret;
     +}
    ++
    ++static int for_each_fullref_with_seek(struct ref_filter *filter, each_ref_fn cb,
    ++				       void *cb_data, unsigned int flags)
    ++{
    ++	struct ref_iterator *iter;
    ++	int ret = 0;
    ++
    ++	iter = refs_ref_iterator_begin(get_main_ref_store(the_repository), "",
    ++				       NULL, 0, flags);
    ++	if (filter->start_after)
    ++		ret = start_ref_iterator_after(iter, filter->start_after);
    ++
    ++	if (ret)
    ++		return ret;
    ++
    ++	return do_for_each_ref_iterator(iter, cb, cb_data);
    ++}
     +
      /*
       * This is the same as for_each_fullref_in(), but it tries to iterate
       * only over the patterns we'll care about. Note that it _doesn't_ do a full
     @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
    - 				       each_ref_fn cb,
    - 				       void *cb_data)
      {
    -+	struct ref_iterator *iter;
    -+	int flags = 0, ret = 0;
    -+
      	if (filter->kind & FILTER_REFS_ROOT_REFS) {
      		/* In this case, we want to print all refs including root refs. */
     -		return refs_for_each_include_root_refs(get_main_ref_store(the_repository),
     -						       cb, cb_data);
    -+		flags |= DO_FOR_EACH_INCLUDE_ROOT_REFS;
    -+		goto non_prefix_iter;
    ++		return for_each_fullref_with_seek(filter, cb, cb_data,
    ++						  DO_FOR_EACH_INCLUDE_ROOT_REFS);
      	}
      
      	if (!filter->match_as_path) {
    @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
      		 */
     -		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
     -						"", NULL, cb, cb_data);
    -+		goto non_prefix_iter;
    ++		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
      	}
      
      	if (filter->ignore_case) {
    @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
      		 */
     -		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
     -						"", NULL, cb, cb_data);
    -+		goto non_prefix_iter;
    ++		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
      	}
      
      	if (!filter->name_patterns[0]) {
      		/* no patterns; we have to look at everything */
     -		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
     -						 "", filter->exclude.v, cb, cb_data);
    -+		goto non_prefix_iter;
    ++		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
      	}
      
      	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
    - 						 NULL, filter->name_patterns,
    - 						 filter->exclude.v,
    - 						 cb, cb_data);
    -+
    -+non_prefix_iter:
    -+	iter = refs_ref_iterator_begin(get_main_ref_store(the_repository), "",
    -+				       NULL, 0, flags);
    -+	if (filter->start_after)
    -+		ret = start_ref_iterator_after(iter, filter->start_after);
    -+
    -+	if (ret)
    -+		return ret;
    -+
    -+	return do_for_each_ref_iterator(iter, cb, cb_data);
    - }
    +@@ ref-filter.c: void filter_is_base(struct repository *r,
      
    - /*
    -@@ ref-filter.c: static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
    - 	init_contains_cache(&filter->internal.no_contains_cache);
    + static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref_fn fn, void *cb_data)
    + {
    ++	const char *prefix = NULL;
    + 	int ret = 0;
      
    - 	/*  Simple per-ref filtering */
    --	if (!filter->kind)
    -+	if (!filter->kind) {
    - 		die("filter_refs: invalid type");
    --	else {
    -+	} else {
    -+		const char *prefix = NULL;
    -+
    - 		/*
    - 		 * For common cases where we need only branches or remotes or tags,
    - 		 * we only iterate through those refs. If a mix of refs is needed,
    + 	filter->kind = type & FILTER_REFS_KIND_MASK;
     @@ ref-filter.c: static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
    - 		 * of filter_ref_kind().
    - 		 */
    - 		if (filter->kind == FILTER_REFS_BRANCHES)
    --			ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
    --						       "refs/heads/", NULL,
    --						       fn, cb_data);
    -+			prefix = "refs/heads/";
    - 		else if (filter->kind == FILTER_REFS_REMOTES)
    --			ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
    --						       "refs/remotes/", NULL,
    --						       fn, cb_data);
    -+			prefix = "refs/remotes/";
    - 		else if (filter->kind == FILTER_REFS_TAGS)
    --			ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
    --						       "refs/tags/", NULL, fn,
    --						       cb_data);
    --		else if (filter->kind & FILTER_REFS_REGULAR)
    -+			prefix = "refs/tags/";
    + 	 * of filter_ref_kind().
    + 	 */
    + 	if (filter->kind == FILTER_REFS_BRANCHES)
    +-		ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
    +-					       "refs/heads/", NULL,
    +-					       fn, cb_data);
    ++		prefix = "refs/heads/";
    + 	else if (filter->kind == FILTER_REFS_REMOTES)
    +-		ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
    +-					       "refs/remotes/", NULL,
    +-					       fn, cb_data);
    ++		prefix = "refs/remotes/";
    + 	else if (filter->kind == FILTER_REFS_TAGS)
    +-		ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
    +-					       "refs/tags/", NULL, fn,
    +-					       cb_data);
    +-	else if (filter->kind & FILTER_REFS_REGULAR)
    ++		prefix = "refs/tags/";
     +
    -+		if (prefix) {
    -+			struct ref_iterator *iter;
    ++	if (prefix) {
    ++		struct ref_iterator *iter;
     +
    -+			iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
    -+						       "", NULL, 0, 0);
    ++		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
    ++					       "", NULL, 0, 0);
     +
    -+			if (filter->start_after)
    -+				ret = start_ref_iterator_after(iter, filter->start_after);
    -+			else if (prefix)
    -+				ret = ref_iterator_seek(iter, prefix, 1);
    ++		if (filter->start_after)
    ++			ret = start_ref_iterator_after(iter, filter->start_after);
    ++		else if (prefix)
    ++			ret = ref_iterator_seek(iter, prefix, 1);
     +
    -+			if (!ret)
    -+				ret = do_for_each_ref_iterator(iter, fn, cb_data);
    -+		} else if (filter->kind & FILTER_REFS_REGULAR) {
    - 			ret = for_each_fullref_in_pattern(filter, fn, cb_data);
    -+		}
    ++		if (!ret)
    ++			ret = do_for_each_ref_iterator(iter, fn, cb_data);
    ++	} else if (filter->kind & FILTER_REFS_REGULAR) {
    + 		ret = for_each_fullref_in_pattern(filter, fn, cb_data);
    ++	}
      
    - 		/*
    - 		 * When printing all ref types, HEAD is already included,
    + 	/*
    + 	 * When printing all ref types, HEAD is already included,
     
      ## ref-filter.h ##
     @@ ref-filter.h: struct ref_array {
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --start-after=refs/lost >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after=refs/odd/ >actual &&
     +	test_cmp expect actual
     +'
     +
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --start-after=refs/odd/ >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after=refs/lost >actual &&
     +	test_cmp expect actual
     +'
     +


base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
change-id: 20250605-306-git-for-each-ref-pagination-0ba8a29ae646

Thanks
- Karthik

