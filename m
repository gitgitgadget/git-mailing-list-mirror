Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678245CDC8
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682480; cv=none; b=OO1Ok/5WnRqJGUPz2pR3RMYab8mTmTwY8OPXgVu5yShMmxsIBabhjn0RmpalfEBpslf6wzhoS2U+f50bQqP9wwNHxhoQJTWaaeDo69BJmQ+2e0VWJtnqGCklV0VCQDLjgSsifmr/ZBQU/JtXNcvQSzxOZH8wMn270+Yw+QVvhuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682480; c=relaxed/simple;
	bh=/UC8m98p2A6Iuis+M9UpX9n+e0cGMugjGTtPwmuK9bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh+ISFWvtJsbbliDuKBnTOok5EOu+uiVdtMR/GwqxuDPXVQaPcW6xjM4WgSj3GyRLlEeyR9dvdfXJsofI11FylUTMNhq+AOiSq7MEedvBygKtY1NnsL9eDjpl4z9bKjyq32Fjjmf9nZL8McV8ypLTXn2Bhp1T6oUFDdCf+hLKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSrSw27X; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSrSw27X"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28a6cef709so97255666b.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 02:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708682476; x=1709287276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLci9HvkWOXl3KGa4jwEUCOBemtvMOfW4b3H/u3nhFo=;
        b=bSrSw27X0+ogRiInXvgyUzldzqNyxe9YhnSayyHUZNFoYlA5vgNAGFnDDd7uJnLBrJ
         GOICnfH8ieFxqqgw+Pgq/AtQWQyQRv5EToH1B2m115Lawx5Bzf8jgBGS2ocApQQ2SdcZ
         oRKO6cdGggtJnNgdyYbgfwYOTQN1XlPGYRmgDZf3r/6j3QNT4LexJ4M6LJkSXlq9fTmX
         D5mP2/DDtcE+fOxbViKLE3+eX1M18q10PWg0T25vweXY/qMVqlq/qQbP7pQQOIOa1fb9
         DuLuFTepn8fJuKqnyZeX6GGg5A1YXyY7SpMXWj2HznLp83NGL8NLYQSEqMrqXUJulsMV
         ncCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708682476; x=1709287276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLci9HvkWOXl3KGa4jwEUCOBemtvMOfW4b3H/u3nhFo=;
        b=AWvJjrAVjOPyiHK6OU/KIjTc9WyH2nX7bszB0RekdyqHFlxaplNGD37TASMYrZLyK/
         wYHAdIBldqBGTYX4Z1nGt8kbVLGJXt9m2jv3c2o83p/IjxffWWRnrsLxjeZPSR+HCmKl
         4vcMenLWva/lk0S2WbWLv4yOIma0PfdNVCsf46ItY+b57LoO6Fm/wI6VJB2xKVqDB0jw
         RQRZNz20SG5gEpmaagJLPrb8sSYheYQ8se4wm8Y/PKZX51YWlsYQbiapWbLEuKBECzom
         IMKgtQCQkhTZFpI4Ha6WWSUC/nw+YA/7Y0jPR6VA7fT9UvDPZb1BsB3hYjZmaH+sjzfr
         w3Ug==
X-Gm-Message-State: AOJu0YzqFKiYrZIzcLR8VdRD5GbW2kAaO/vgCjJXbgKvlR7CKyS9pAl2
	W0MSBjvvHeQYd2Jenmwu19V5OqbmIbzfkgzi4SLcKOhz10BywWJj7qCVt2ds9zY=
X-Google-Smtp-Source: AGHT+IEUeMxopQPa0oOOLwgpHig6+DbT7apAaG1n8itbU5TwTuxhn9D1mnGRP58RfuBtxZFvXK8c+w==
X-Received: by 2002:a17:906:f253:b0:a3f:78e1:259e with SMTP id gy19-20020a170906f25300b00a3f78e1259emr838258ejb.5.1708682475817;
        Fri, 23 Feb 2024 02:01:15 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:660d:e728:4b64:50ff])
        by smtp.gmail.com with ESMTPSA id ha1-20020a170906a88100b00a381ca0e589sm6734917ejb.22.2024.02.23.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:01:15 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/5] for-each-ref: add '--include-root-refs' option
Date: Fri, 23 Feb 2024 11:01:07 +0100
Message-ID: <20240223100112.44127-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119142705.139374-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the fifth version of my patch series to print root refs
in git-for-each-ref(1).

With the introduction of the reftable backend, it becomes ever
so important to provide the necessary tooling for printing all refs
associated with a worktree.

While regular refs stored within the "refs/" namespace are currently
supported by multiple commands like git-for-each-ref(1),
git-show-ref(1). Neither support printing root refs within the worktree.

This patch series is a follow up to the RFC/discussion we had earlier on
the list [1].

The first 4 commits add the required functionality to ensure we can print
all refs (regular, pseudo, HEAD). The 5th commit modifies the
git-for-each-ref(1) command to add the "--include-root-refs" command which
will include HEAD and pseudorefs with regular "refs/" refs.

[1]: https://lore.kernel.org/git/20231221170715.110565-1-karthik.188@gmail.com/#t

Changes from v4:
1. Fixed erratic whitespace
2. Remove braces from single line block
3. Starting the comments with a capital and also adding more context.
4. Removed a duplicate check.

Thanks for the reviews.

Range diff against v4:

1:  98130a7ad7 ! 1:  6016042965 refs: introduce `is_pseudoref()` and `is_headref()`
    @@ refs.c: static int is_pseudoref_syntax(const char *refname)
     +
     +	if (ends_with(refname, "_HEAD")) {
     +		refs_resolve_ref_unsafe(refs, refname,
    -+   					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    -+   					&oid, NULL);
    -+   		return !is_null_oid(&oid);
    ++					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    ++					&oid, NULL);
    ++		return !is_null_oid(&oid);
     +	}
     +
     +	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
     +		if (!strcmp(refname, irregular_pseudorefs[i])) {
     +			refs_resolve_ref_unsafe(refs, refname,
    -+   						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    -+   						&oid, NULL);
    ++						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    ++						&oid, NULL);
     +			return !is_null_oid(&oid);
     +		}
     +
2:  060ab08af5 = 2:  acaa014841 refs: extract out `loose_fill_ref_dir_regular_file()`
3:  40d2375ad9 = 3:  f51c5bc307 refs: introduce `refs_for_each_include_root_refs()`
4:  b4b9435505 = 4:  7c004db6e7 ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
5:  ee99ac41ae ! 5:  53f6c0a6db for-each-ref: add new option to include root refs
    @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const
      		filter.name_patterns = argv;
      	}
      
    -+	if (include_root_refs) {
    ++	if (include_root_refs)
     +		flags |= FILTER_REFS_ROOT_REFS;
    -+	}
     +
      	filter.match_as_path = 1;
     -	filter_and_format_refs(&filter, FILTER_REFS_REGULAR, sorting, &format);
    @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
      				       void *cb_data)
      {
     +	if (filter->kind == FILTER_REFS_KIND_MASK) {
    -+		/* in this case, we want to print all refs including root refs. */
    ++		/* In this case, we want to print all refs including root refs. */
     +		return refs_for_each_include_root_refs(get_main_ref_store(the_repository),
     +						       cb, cb_data);
     +	}
    @@ ref-filter.c: static struct ref_array_item *apply_ref_filter(const char *refname
      
      	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
      	kind = filter_ref_kind(filter, refname);
    +-	if (!(kind & filter->kind))
     +
     +	/*
    -+	 * When printing HEAD with all other refs, we want to apply the same formatting
    -+	 * rules as the other refs, so we simply ask it to be treated as a pseudoref.
    ++	 * Generally HEAD refs are printed with special description denoting a rebase,
    ++	 * detached state and so forth. This is useful when only printing the HEAD ref
    ++	 * But when it is being printed along with other pseudorefs, it makes sense to
    ++	 * keep the formatting consistent. So we mask the type to act like a pseudoref.
     +	 */
     +	if (filter->kind == FILTER_REFS_KIND_MASK && kind == FILTER_REFS_DETACHED_HEAD)
     +		kind = FILTER_REFS_PSEUDOREFS;
     +	else if (!(kind & filter->kind))
    -+		return NULL;
    -+
    - 	if (!(kind & filter->kind))
      		return NULL;
      
    + 	if (!filter_pattern_match(filter, refname))
     @@ ref-filter.c: static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
      			ret = for_each_fullref_in("refs/tags/", fn, cb_data);
      		else if (filter->kind & FILTER_REFS_REGULAR)


Karthik Nayak (5):
  refs: introduce `is_pseudoref()` and `is_headref()`
  refs: extract out `loose_fill_ref_dir_regular_file()`
  refs: introduce `refs_for_each_include_root_refs()`
  ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
  for-each-ref: add new option to include root refs

 Documentation/git-for-each-ref.txt |   5 +-
 builtin/for-each-ref.c             |  10 ++-
 ref-filter.c                       |  30 ++++++-
 ref-filter.h                       |   7 +-
 refs.c                             |  48 +++++++++++
 refs.h                             |   9 ++
 refs/files-backend.c               | 127 +++++++++++++++++++++--------
 refs/refs-internal.h               |   6 ++
 refs/reftable-backend.c            |  11 ++-
 t/t6302-for-each-ref-filter.sh     |  31 +++++++
 10 files changed, 237 insertions(+), 47 deletions(-)

-- 
2.43.GIT

