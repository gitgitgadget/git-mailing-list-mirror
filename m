Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A62DD5F0
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982485; cv=none; b=c4Pa78sWVGyDWeDxcddzUPRezj+rQ8NQvTOcwv1i8JO016udc09qJuBF3un3hkam/DrXh72VL8w8Owgx5a47tYkgMlOTHgp9nM3NNPZsYU8z4jLuJfb0U1rbGzXdlfRLgq0dVlZMk2e+N9ZvAuW5aNQXrXH6YU/HeVhFJ1b30lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982485; c=relaxed/simple;
	bh=NFVjd7kh+sIrlBQoVtxIs7E5IiH2HEGxRBqf/fPaS8o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=AK5Pw6txSlwdYAgFPZWa6WLaaZA7EWqa2YYZ3BtEpDDaDiMCdu+6BSXXcoB5LaZVkESq50QOFTILasuF3oKSRjp1QXvOppxougjsol7p6xxwXEw4q6w2AlmkV2v0Av1eCUBTG1peoI4vgGl0DO5Z5vwcgL/VhyE9WssReI389dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwZmKkP0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwZmKkP0"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so9627763a12.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982482; x=1752587282; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=289Cv1iuCLVHE7wzzgzVzH4kTnksMDPj10knSH7RN1Q=;
        b=OwZmKkP0wz/463jGRSjeb4nVtpI0D0q3DD912CSNJtpqVUEyc6Gl/oUBzFfNRWfJwr
         GmQQ2mWsglyywCQiUXvzdEsfDM2S9rhwtdfdt050IW9KCJUaphG9QJ0OuH8Jcp/RdeyE
         UBjwQn3hoXbw2UhZ2yLQSttQgw+Tr9/I2WzaFwX79wMK2Y6rl9ezMemCS0xZa1yJKKWi
         9Td4EmN59lXklemk0kGtHXj77jkDar++s7kRbnlawG1VyKiC36jjM4NBoiXLv+ySk8GU
         24B4l9luemsPwJr+gm1XBRZld2EL+BJH62togFG41hnrB99/tB4JBxwzRROmidwUPLuv
         ABFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982482; x=1752587282;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=289Cv1iuCLVHE7wzzgzVzH4kTnksMDPj10knSH7RN1Q=;
        b=gs398Ks4iY7A82ORFSGp9o5UZamVRRNHwn6J1Pjxh2Cuq34TUdpYjXrHOh+zd9DNWX
         FqVaHrrDHCxB2Tc7t4wp4zXmaAeF2SDAgNToZnzqHmPa5LJwlaGd3PzfLmYIeB5PsTzq
         CsQQto/W4uB72y5CCad0N2h+/6vFoBWL+V4Vcif+w4uVFIoXRiTj/Z7SSna5qnwL4Pcq
         wLz+Iv1SY2rQ4A4gzLM9hVjzcCOGN0aezzLlMbSunLn5DL59AbxATb4kNIelqVjWAE5v
         7HPFn9hi1sFrWKIH8vqTiQ7/5ljlSNEnn8VYRFTBYy1uv3D1zy04mhQFe2VKTcJq3LG3
         2YjQ==
X-Gm-Message-State: AOJu0YzhRYdk+lLh1+DdMECAyql9FVcKUv27dBm99XTYzcmhXv9YjLgS
	tnDeAIf190QhRnLqrsozCzroEHfgZULsel3IRyKHiKfU3OZmM79r6xKx
X-Gm-Gg: ASbGncslXyYZp2QoRwFmV2e+pAzED1W6h2kHJssS74SY9sse/w6Ncjn5h3uEniZF9HB
	b0OXSBH2ASSi9zMneKsNIuxTgermYmS6cXUHxn6D2f6p+eN58q4qRjLfac81XA3/1igQqLaK1E3
	q1q4FyZ0yh8zhRxSvna9xMqJRb2RpDp5dvq94l9FDnzS16HaiOauKumAOQiZm7Wdy8xmRzKQIRY
	hdeKDEVPfHuL5GaRj2TpdYzNp+vVVqeRVH+oWL+bfhnO2UMC+Vin0WtYAcjVDbmU+SSBmZkbG7F
	G870LBqYO5uYsfUM04uUSHoW4gPn0amJvJlZQ2sI06hrra/B2BA=
X-Google-Smtp-Source: AGHT+IHslIL8iUdIzuQKpmW5Qgrt4atWib08vb5VZsYS8lKmsbl1feZGnvcYAJI/Qi/E0zVjHrttlQ==
X-Received: by 2002:a17:907:720b:b0:ade:198c:4b6f with SMTP id a640c23a62f3a-ae6b0b1f475mr331811466b.1.1751982481268;
        Tue, 08 Jul 2025 06:48:01 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b03032sm886575466b.124.2025.07.08.06.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:48:00 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/4] for-each-ref: introduce seeking functionality via
 '--start-after'
Date: Tue, 08 Jul 2025 15:47:45 +0200
Message-Id: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEhbWgC/4XNPQ6DMAwF4KugzHXlBAi0U+9RdTDBgKXyo4BQK
 8TdG+jCxvhsve8tamQvPKp7tCjPs4zSdyHEl0i5hrqaQcqQlUGTosUUYrRQywRV74HJNeC5goF
 q6WgKXcCCcjI3YptYFZQh/OWzLzxfITcyTr3/7oOz3q5/O0N9as8aEJIKiTOHNs+rR92SvK+ub
 9Vmz+boJeeeCV7hStYJubLM9dFb1/UHSDSh5B4BAAA=
X-Change-ID: 20250605-306-git-for-each-ref-pagination-0ba8a29ae646
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19336;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=NFVjd7kh+sIrlBQoVtxIs7E5IiH2HEGxRBqf/fPaS8o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhtIY4eBQgLF63FCBn1ykSL/tk9iQXxaldwv
 /2IHOuHUbynA4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJobSGOAAoJED7VnySO
 Rox/5/8L/iTIZu2E2q1fifLYPxkVDZK21Xxe2xG4rpMT8G5s8bEZlB7hcNOfCkT/H1DloTyjP93
 N4gQw9UmHDJgbDuGNxehJ/ObD6QiaFFDnnivc746F3ZgDRuA7lSZwWkOGcA+ChqJQHYjZ3UZeIM
 HAxZ1NS1VZ4B4VXe5h++TRXXIewnlswQfzH+5zSWhCl7doK0DIbck9iqQUi+XW2dIZQSx5kgftu
 lkziaOpdqe8A6H8/GqJexX278udBP9JJAfwb4HWkmhutsIXNRQfMOQEVsJt3VLaYu4OYSXb6thp
 PS3S4R+nlr2JIDmSTs3SzzE3hrcnhkRxHS1UcsxLipeElr1DHcBeV/g7Pl8LFxBZN8uxpTz3ioV
 iYtYlJARhNSZNuKOLLz3txsU/Fgf1qTs0xDUbRj4+dUGaj8DbrOnQRfbm+4juht7sp/r44eXcZe
 8flgSfhShY6HzOcb+BZuziracXJA5lBw+71V5onyM4lzHQJN+dJj+I324AEb0Bx9SW8js3PX456
 LE=
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
 Documentation/git-for-each-ref.adoc |  11 +-
 builtin/for-each-ref.c              |   8 ++
 ref-filter.c                        |  80 +++++++++++----
 ref-filter.h                        |   1 +
 refs.c                              |   6 +-
 refs.h                              | 158 +++++++++++++++++++++++++++++
 refs/debug.c                        |   7 +-
 refs/files-backend.c                |   7 +-
 refs/iterator.c                     |  26 +++--
 refs/packed-backend.c               |  17 ++--
 refs/ref-cache.c                    |  99 ++++++++++++++----
 refs/ref-cache.h                    |   7 --
 refs/refs-internal.h                | 152 ++--------------------------
 refs/reftable-backend.c             |  21 ++--
 t/t6302-for-each-ref-filter.sh      | 194 ++++++++++++++++++++++++++++++++++++
 15 files changed, 568 insertions(+), 226 deletions(-)

Karthik Nayak (4):
      refs: expose `ref_iterator` via 'refs.h'
      ref-cache: remove unused function 'find_ref_entry()'
      refs: selectively set prefix in the seek functions
      for-each-ref: introduce a '--start-after' option

Range-diff versus v2:

1:  c0ce873c35 = 1:  dbb03c2aa9 refs: expose `ref_iterator` via 'refs.h'
2:  2c50d1eba2 = 2:  fa5a0cb722 ref-cache: remove unused function 'find_ref_entry()'
3:  fae849749f = 3:  9940d390cc refs: selectively set prefix in the seek functions
4:  a0725a6647 ! 4:  ebe864095a for-each-ref: introduce a '--skip-until' option
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    for-each-ref: introduce a '--skip-until' option
    +    for-each-ref: introduce a '--start-after' option
     
         The `git-for-each-ref(1)` command is used to iterate over references
         present in a repository. In large repositories with millions of
    @@ Commit message
         through results.
     
         The previous commit added 'seek' functionality to the reference
    -    backends. Utilize this and expose a '--skip-until' option in
    +    backends. Utilize this and expose a '--start-after' option in
         'git-for-each-ref(1)'. When used, the reference iteration seeks to the
    -    first matching reference and iterates from there onward.
    +    lexicographically next reference and iterates from there onward.
     
         This enables efficient pagination workflows like:
             git for-each-ref --count=100
    -        git for-each-ref --count=100 --skip-until=refs/heads/branch-100
    -        git for-each-ref --count=100 --skip-until=refs/heads/branch-200
    +        git for-each-ref --count=100 --start-after=refs/heads/branch-100
    +        git for-each-ref --count=100 --start-after=refs/heads/branch-200
    +
    +    Since the reference iterators only allow seeking to a specified marker
    +    via the `ref_iterator_seek()`, we introduce a helper function
    +    `start_ref_iterator_after()`, which seeks to next reference by simply
    +    adding (char) 1 to the marker.
    +
    +    We must note that pagination always continues from the provided marker,
    +    as such any concurrent reference updates lexicographically behind the
    +    marker will not be output. Document the same.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ Documentation/git-for-each-ref.adoc: SYNOPSIS
      		   [--merged[=<object>]] [--no-merged[=<object>]]
      		   [--contains[=<object>]] [--no-contains[=<object>]]
     -		   [--exclude=<pattern> ...]
    -+		   [--exclude=<pattern> ...] [--skip-until=<pattern>]
    ++		   [--exclude=<pattern> ...] [--start-after=<marker>]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-for-each-ref.adoc: TAB %(refname)`.
      --include-root-refs::
      	List root refs (HEAD and pseudorefs) apart from regular refs.
      
    -+--skip-until::
    -+    Skip references up to but excluding the specified pattern. Cannot be used
    -+    with general pattern matching or custom sort options.
    ++--start-after::
    ++    Allows paginating the output by skipping references up to and including the
    ++    specified marker. When paging, it should be noted that references may be
    ++    deleted, modified or added between invocations. Output will only yield those
    ++    references which follow the marker lexicographically. If the marker does not
    ++    exist, output begins from the first reference that would come after it
    ++    alphabetically. Cannot be used with general pattern matching or custom
    ++    sort options.
     +
      FIELD NAMES
      -----------
    @@ builtin/for-each-ref.c: static char const * const for_each_ref_usage[] = {
      	N_("git for-each-ref [--points-at <object>]"),
      	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
      	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
    -+	N_("git for-each-ref [--skip-until <pattern>]"),
    ++	N_("git for-each-ref [--start-after <marker>]"),
      	NULL
      };
      
    @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc,
      		OPT_GROUP(""),
      		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
      		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
    -+		OPT_STRING(  0 , "skip-until", &filter.seek, N_("skip-until"), N_("skip references until")),
    ++		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-start"), N_("start iteration after the provided marker")),
      		OPT__COLOR(&format.use_color, N_("respect format colors")),
      		OPT_REF_FILTER_EXCLUDE(&filter),
      		OPT_REF_SORT(&sorting_options),
    @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc,
      	if (verify_ref_format(&format))
      		usage_with_options(for_each_ref_usage, opts);
      
    -+	if (filter.seek && sorting_options.nr > 1)
    -+		die(_("cannot use --skip-until custom sort options"));
    ++	if (filter.start_after && sorting_options.nr > 1)
    ++		die(_("cannot use --start-after with custom sort options"));
     +
      	sorting = ref_sorting_options(&sorting_options);
      	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
    @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc,
      		filter.name_patterns = argv;
      	}
      
    -+	if (filter.seek && filter.name_patterns && filter.name_patterns[0])
    -+		die(_("cannot use --skip-until with patterns"));
    ++	if (filter.start_after && filter.name_patterns && filter.name_patterns[0])
    ++		die(_("cannot use --start-after with patterns"));
     +
      	if (include_root_refs)
      		flags |= FILTER_REFS_ROOT_REFS | FILTER_REFS_DETACHED_HEAD;
      
     
      ## ref-filter.c ##
    +@@ ref-filter.c: static int filter_exclude_match(struct ref_filter *filter, const char *refname)
    + 	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
    + }
    + 
    ++/*
    ++ * We need to seek to the reference right after a given marker but excluding any
    ++ * matching references. So we seek to the lexicographically next reference.
    ++ */
    ++static int start_ref_iterator_after(struct ref_iterator *iter, const char *marker)
    ++{
    ++	struct strbuf sb = STRBUF_INIT;
    ++	int ret;
    ++
    ++	strbuf_addstr(&sb, marker);
    ++	strbuf_addch(&sb, 1);
    ++
    ++	ret = ref_iterator_seek(iter, sb.buf, 0);
    ++
    ++	strbuf_release(&sb);
    ++	return ret;
    ++}
    ++
    + /*
    +  * This is the same as for_each_fullref_in(), but it tries to iterate
    +  * only over the patterns we'll care about. Note that it _doesn't_ do a full
     @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
      				       each_ref_fn cb,
      				       void *cb_data)
    @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
     +non_prefix_iter:
     +	iter = refs_ref_iterator_begin(get_main_ref_store(the_repository), "",
     +				       NULL, 0, flags);
    -+	if (filter->seek)
    -+		ret = ref_iterator_seek(iter, filter->seek, 0);
    ++	if (filter->start_after)
    ++		ret = start_ref_iterator_after(iter, filter->start_after);
    ++
     +	if (ret)
     +		return ret;
     +
    @@ ref-filter.c: static int do_filter_refs(struct ref_filter *filter, unsigned int
     +			iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
     +						       "", NULL, 0, 0);
     +
    -+			if (filter->seek)
    -+				ret = ref_iterator_seek(iter, filter->seek, 0);
    ++			if (filter->start_after)
    ++				ret = start_ref_iterator_after(iter, filter->start_after);
     +			else if (prefix)
     +				ret = ref_iterator_seek(iter, prefix, 1);
     +
    @@ ref-filter.h: struct ref_array {
      
      struct ref_filter {
      	const char **name_patterns;
    -+	const char *seek;
    ++	const char *start_after;
      	struct strvec exclude;
      	struct oid_array points_at;
      	struct commit_list *with_commit;
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
      	test_cmp expect actual
      '
      
    -+test_expect_success 'skip until with empty value' '
    ++test_expect_success 'start after with empty value' '
     +	cat >expect <<-\EOF &&
     +	refs/heads/main
     +	refs/heads/main_worktree
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --skip-until="" >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after="" >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'skip until to a specific reference' '
    ++test_expect_success 'start after a specific reference' '
     +	cat >expect <<-\EOF &&
    -+	refs/odd/spot
     +	refs/tags/annotated-tag
     +	refs/tags/doubly-annotated-tag
     +	refs/tags/doubly-signed-tag
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after=refs/odd/spot >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'skip until to a specific reference with partial match' '
    ++test_expect_success 'start after a specific reference with partial match' '
     +	cat >expect <<-\EOF &&
     +	refs/odd/spot
     +	refs/tags/annotated-tag
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/sp >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after=refs/odd/sp >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'skip until just behind a specific reference' '
    ++test_expect_success 'start after, just behind a specific reference' '
     +	cat >expect <<-\EOF &&
     +	refs/odd/spot
     +	refs/tags/annotated-tag
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/parrot >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after=refs/odd/parrot >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'skip until to specific directory' '
    ++test_expect_success 'start after with specific directory match' '
     +	cat >expect <<-\EOF &&
     +	refs/odd/spot
     +	refs/tags/annotated-tag
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --skip-until=refs/odd >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after=refs/odd >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'skip until to specific directory with trailing slash' '
    ++test_expect_success 'start after with specific directory and trailing slash' '
     +	cat >expect <<-\EOF &&
     +	refs/odd/spot
     +	refs/tags/annotated-tag
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --skip-until=refs/lost >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after=refs/lost >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'skip until just behind a specific directory' '
    ++test_expect_success 'start after, just behind a specific directory' '
     +	cat >expect <<-\EOF &&
     +	refs/odd/spot
     +	refs/tags/annotated-tag
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/ >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after=refs/odd/ >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'skip until overflow specific reference length' '
    ++test_expect_success 'start after, overflow specific reference length' '
     +	cat >expect <<-\EOF &&
     +	refs/tags/annotated-tag
     +	refs/tags/doubly-annotated-tag
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/spotnew >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after=refs/odd/spotnew >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'skip until overflow specific reference path' '
    ++test_expect_success 'start after, overflow specific reference path' '
     +	cat >expect <<-\EOF &&
     +	refs/tags/annotated-tag
     +	refs/tags/doubly-annotated-tag
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	refs/tags/three
     +	refs/tags/two
     +	EOF
    -+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot/new >actual &&
    ++	git for-each-ref --format="%(refname)" --start-after=refs/odd/spot/new >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'start after, last reference' '
    ++	cat >expect <<-\EOF &&
    ++	EOF
    ++	git for-each-ref --format="%(refname)" --start-after=refs/tags/two >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'skip until used with a pattern' '
    ++test_expect_success 'start after used with a pattern' '
     +	cat >expect <<-\EOF &&
    -+	fatal: cannot use --skip-until with patterns
    ++	fatal: cannot use --start-after with patterns
     +	EOF
    -+	test_must_fail git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot refs/tags 2>actual &&
    ++	test_must_fail git for-each-ref --format="%(refname)" --start-after=refs/odd/spot refs/tags 2>actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'skip until used with custom sort order' '
    ++test_expect_success 'start after used with custom sort order' '
     +	cat >expect <<-\EOF &&
    -+	fatal: cannot use --skip-until custom sort options
    ++	fatal: cannot use --start-after with custom sort options
     +	EOF
    -+	test_must_fail git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot --sort=author 2>actual &&
    ++	test_must_fail git for-each-ref --format="%(refname)" --start-after=refs/odd/spot --sort=author 2>actual &&
     +	test_cmp expect actual
     +'
     +


base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
change-id: 20250605-306-git-for-each-ref-pagination-0ba8a29ae646

Thanks
- Karthik

