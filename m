Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139C1DA2A
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707676770; cv=none; b=LibKHS/meWbAKAEhfS9o6mx2MlxE1f7eEAFrtL5qeZJiD3LF8j+6iintAvvhuSLCe2adwY7go3cbYA8fgE6IcXdAkJl+cGc5sZDM98qZ6EOlV790U0iftrkRR0nVvkYEEM9gA/9WJ0sBjrqdYpbvfNgGMj9dRJErBdkNV6zO/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707676770; c=relaxed/simple;
	bh=RZubw7kf0sbEYO6mROaokkSezLx/kvdQdxz4nzJRFdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gliNy34oR9MU/KfCa9aHxM9XHHtxQsCjPqqwjwhhi1m8QJIfeDCjFMGds6UbQlF2dVSAXBpAY8xPOHUZoaT1lFnjO33S9xa+z5UVtJAQnV2mDl7wIdUdUBijBvZvMLyWMxHbOqYeeViMQ4sBIxsTbgFNrWN+8HKmzEbhQq3S6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQbk3uNu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQbk3uNu"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0aabed735so33556141fa.0
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 10:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707676766; x=1708281566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcscRHd5PcP9gqXm6SYfFSr4dGemj0Pw738WB8v7DlM=;
        b=kQbk3uNuxCdusoO5AQbu9zTDYfwmffXe9ECySxR0UcKJQRYC8iQBc7YdV1jB4eiXA+
         FyxdPOeFsm5BOYZ3Vd4+F9Q7z7J2zhW8TGtYmJALiVpaF0lv0xW6dTlgbUX7wKxEaA5d
         +d/NmkJ9ryZn/4KtEy8sDs5QRSotx2vleIxTXDdLMJ5wGnN9tnShnmPIsf3eT4hylHnz
         jCJAXTwTSNhGLn7prIPm2SNZgbQAE6mziHda0kcPn+30Ip8pzGlBHutLDVa8gbg9hMoY
         nELMeksiV1385eFkdZbAQBH2IzjxmnO+p1VYI4t3nGb8F9jgqveh/H59gF4mlA6dxO82
         YjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707676766; x=1708281566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcscRHd5PcP9gqXm6SYfFSr4dGemj0Pw738WB8v7DlM=;
        b=PUQ5ph3xlYVihc5gi1vwtVi0W0ItBR8OCt1t73U3ZFoEzdTKhWuOpgIeci3K+nAL0j
         AvcqP4HX60JrkofCP2OOxB7dFKV3gEw0hCnxxLtMFhPeCN+0wNtC2pqBSkz8bK4mgsre
         QKIzfkh+NUrn4t9ko/DP9SaCjqbBQzYB/6193FzAC186YUi/5lbqoKUx3ORI79lPoFWp
         HEpE2aY8LeI/4jF3jhYKGIjE6C+2DE77KAofVN3tIvfh5JdVc0kRiA6GGCZe3nPNQk6I
         uXHakWQqB73fnmXVq2RyREOAhqFwwPyQnRxsW+SGpD9IATqvMgwKTAV6SQeMTWQnOx87
         n6Rw==
X-Gm-Message-State: AOJu0Yzqzdo8EmB+1wLPkZYJrvTtROGZxiRJkHm22DMcgVeR1Iyy1cEv
	VPNTyK9oQMvLamY3NJJsTDWIyYW8tn+7q+0YZfs4r14Dwc8j6i4Vh07jVKX2
X-Google-Smtp-Source: AGHT+IEhyELc8ulRfEBi943tm6fuqNrtclytYk0B984AKwMAi5R9UVKwv/c06DYlOBIngBlhmvpTRA==
X-Received: by 2002:a05:6512:3d15:b0:511:4fec:b976 with SMTP id d21-20020a0565123d1500b005114fecb976mr4018340lfv.51.1707676765944;
        Sun, 11 Feb 2024 10:39:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFcD5MTlvrpk1R1Z0FUJ3ozceMMZuNmduxW4zkEQzKxbnMNWr0uM4wQFU/tCF7hWLDcDmrToGhhu9Qb3jBPy9oYcC3V7TPyVXKmwXAq5E0PZEDOfPHsKvXCqUmfdWdQhEx5CPgQRIS5ojb4w==
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id w12-20020a170906130c00b00a3716299b40sm3069808ejb.155.2024.02.11.10.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 10:39:25 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/5] for-each-ref: add '--include-root-refs' option
Date: Sun, 11 Feb 2024 19:39:18 +0100
Message-ID: <20240211183923.131278-1-karthik.188@gmail.com>
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

This is the forth version of my patch series to print root refs
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

Changes from v3:
1. Move from using 'git for-each-ref ""' to print root refs to adding
the '--include-root-refs' option for git-for-each-ref(1). This provides better
UX for users.
2. Modify `is_pseudoref()` to use `refs_resolve_ref_unsafe`.
3. Includes reftable-backend changes and is now rebased on top of next (ed35d3359).  

Range-diff:

1:  2141a2a62b ! 1:  98130a7ad7 refs: introduce `is_pseudoref()` and `is_headref()`
    @@ Commit message
         related files like 'BISECT_START' to a new directory similar to the
         'rebase-merge' directory.
     
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## refs.c ##
    @@ refs.c: static int is_pseudoref_syntax(const char *refname)
     +		return 0;
     +
     +	if (ends_with(refname, "_HEAD")) {
    -+		 read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    -+		      &oid, NULL);
    -+		 return !is_null_oid(&oid);
    ++		refs_resolve_ref_unsafe(refs, refname,
    ++   					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    ++   					&oid, NULL);
    ++   		return !is_null_oid(&oid);
     +	}
     +
     +	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
     +		if (!strcmp(refname, irregular_pseudorefs[i])) {
    -+			read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    -+						  &oid, NULL);
    ++			refs_resolve_ref_unsafe(refs, refname,
    ++   						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    ++   						&oid, NULL);
     +			return !is_null_oid(&oid);
     +		}
     +
2:  c96f0a9c83 = 2:  060ab08af5 refs: extract out `loose_fill_ref_dir_regular_file()`
3:  d165358b83 ! 3:  40d2375ad9 refs: introduce `refs_for_each_all_refs()`
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: introduce `refs_for_each_all_refs()`
    +    refs: introduce `refs_for_each_include_root_refs()`
     
    -    Introduce a new ref iteration flag `DO_FOR_EACH_INCLUDE_ALL_REFS`, which
    -    will be used to iterate over all refs. In the files backend this is
    -    limited to regular refs, pseudorefs and HEAD. For other backends like
    -    the reftable this is the universal set of all refs stored in the
    -    backend.
    +    Introduce a new ref iteration flag `DO_FOR_EACH_INCLUDE_ROOT_REFS`,
    +    which will be used to iterate over regular refs plus pseudorefs and
    +    HEAD.
     
         Refs which fall outside the `refs/` and aren't either pseudorefs or HEAD
         are more of a grey area. This is because we don't block the users from
    -    creating such refs but they are not officially supported. In the files
    -    backend, we can isolate such files from other files.
    +    creating such refs but they are not officially supported.
     
    -    Introduce `refs_for_each_all_refs()` which calls `do_for_each_ref()`
    -    with this newly introduced flag.
    +    Introduce `refs_for_each_include_root_refs()` which calls
    +    `do_for_each_ref()` with this newly introduced flag.
     
         In `refs/files-backend.c`, introduce a new function
         `add_pseudoref_and_head_entries()` to add pseudorefs and HEAD to the
         `ref_dir`. We then finally call `add_pseudoref_and_head_entries()`
    -    whenever the `DO_FOR_EACH_INCLUDE_ALL_REFS` flag is set. Any new ref
    +    whenever the `DO_FOR_EACH_INCLUDE_ROOT_REFS` flag is set. Any new ref
         backend will also have to implement similar changes on its end.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    @@ refs.c: int for_each_rawref(each_ref_fn fn, void *cb_data)
      	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
      }
      
    -+int refs_for_each_all_refs(struct ref_store *refs, each_ref_fn fn,
    -+			   void *cb_data)
    ++int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
    ++				    void *cb_data)
     +{
     +	return do_for_each_ref(refs, "", NULL, fn, 0,
    -+			       DO_FOR_EACH_INCLUDE_ALL_REFS, cb_data);
    ++			       DO_FOR_EACH_INCLUDE_ROOT_REFS, cb_data);
     +}
     +
      static int qsort_strcmp(const void *va, const void *vb)
    @@ refs.h: int for_each_namespaced_ref(const char **exclude_patterns,
      int for_each_rawref(each_ref_fn fn, void *cb_data);
      
     +/*
    -+ * Iterates over all ref types, regular, pseudorefs and HEAD.
    ++ * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.
     + */
    -+int refs_for_each_all_refs(struct ref_store *refs, each_ref_fn fn,
    -+			   void *cb_data);
    ++int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
    ++				    void *cb_data);
     +
      /*
       * Normalizes partial refs to their fully qualified form.
    @@ refs/files-backend.c: static struct ref_cache *get_loose_ref_cache(struct files_
      
     +		dir = get_ref_dir(refs->loose->root);
     +
    -+		if (flags & DO_FOR_EACH_INCLUDE_ALL_REFS)
    ++		if (flags & DO_FOR_EACH_INCLUDE_ROOT_REFS)
     +			add_pseudoref_and_head_entries(dir->cache->ref_store, dir,
    -+										   refs->loose->root->name);
    ++						       refs->loose->root->name);
     +
      		/*
      		 * Add an incomplete entry for "refs/" (to be filled
    @@ refs/refs-internal.h: enum do_for_each_ref_flags {
      	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
     +
     +	/*
    -+	 * Include all refs in the $GIT_DIR in contrast to generally only listing
    -+	 * references having the "refs/" prefix. In the files-backend this is
    -+	 * limited to regular refs, pseudorefs and HEAD.
    ++	 * Include root refs i.e. HEAD and pseudorefs along with the regular
    ++	 * refs.
     +	 */
    -+	DO_FOR_EACH_INCLUDE_ALL_REFS = (1 << 3),
    ++	DO_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
      };
      
      /*
4:  a17983d0ba < -:  ---------- for-each-ref: avoid filtering on empty pattern
-:  ---------- > 4:  b4b9435505 ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
-:  ---------- > 5:  ee99ac41ae for-each-ref: add new option to include root refs

Karthik Nayak (5):
  refs: introduce `is_pseudoref()` and `is_headref()`
  refs: extract out `loose_fill_ref_dir_regular_file()`
  refs: introduce `refs_for_each_include_root_refs()`
  ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
  for-each-ref: add new option to include root refs

 Documentation/git-for-each-ref.txt |   5 +-
 builtin/for-each-ref.c             |  11 ++-
 ref-filter.c                       |  29 ++++++-
 ref-filter.h                       |   7 +-
 refs.c                             |  48 +++++++++++
 refs.h                             |   9 ++
 refs/files-backend.c               | 127 +++++++++++++++++++++--------
 refs/refs-internal.h               |   6 ++
 refs/reftable-backend.c            |  11 ++-
 t/t6302-for-each-ref-filter.sh     |  31 +++++++
 10 files changed, 238 insertions(+), 46 deletions(-)

-- 
2.43.GIT

