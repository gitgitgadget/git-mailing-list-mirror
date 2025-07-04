Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D82C158F
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634169; cv=none; b=PGwcbvFMyKVBsAVrnW7wFbIIS4673zXqUExH2bKBgiPUOnBh2mNAgshkkWjp3MM0nI+LEyPR0+mt2WgqtuQ3PbkyndYC8mdime4WsA/Ofyj7wwK1MntAHguEfrD+cldGnRwYuIxnHNC2ThX681o8CiaHhuqnUOaimMgpiaQKSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634169; c=relaxed/simple;
	bh=lWFvSuY1cJjmc0CbZvK10gAGbpLtZwCDlXwTrUUvPFY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=arhigpV6AkL06VtH2ts7jM7ntToOdgZ1sNud4+yJ91vDv08sBWIosUnMHeHwZAoI9lObgejkc7WoLs1sHH0s6t4iReUH+3mgZglm2XipUJQwthluqd5Uf5WF2JtHPH8vtaozlSz38tnUZw3UmN8JQCGAj3M5XlIDLaB9VAojj20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhccdET8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhccdET8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-454b1d0a115so2892305e9.2
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751634165; x=1752238965; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3U2BMgt+sImaNUBASilkAPTXUZRlIBz3eZu3u14AT0=;
        b=DhccdET8aIFK4+gZIJIxzWt6ygjmK/l+2k4uPXTLBNb46yVvC9Phi5H2li2/k/nSAB
         ol085Q4Mi8YFwhlHRkMVmExipcedVcoRLDcbqw49/jUkPp4C3I7GG3RA9bEx/swvz0Zs
         an1CjAIM2j+ToAYs80oPa9ISvWVdgKCjekQiquWzDQqoemAJeB5SIgPyV4m3uHJgyzlA
         MmIwZ6lIrsPe+YkQ34O1023pdlToMuDzwh6EmjfE3EzFZTtdoVl9BpPTILrQzjoECyL2
         J7l/13x+GswZgTzu/gBwa4C7oYoH6sVSLdsHqWxNBYdkEF+EU8DwoYwAftPTLqpWJPzJ
         aXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634165; x=1752238965;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f3U2BMgt+sImaNUBASilkAPTXUZRlIBz3eZu3u14AT0=;
        b=v/TnIWmD+AjFSVVCX6lcwryjjEvts3Aa+nGfTAjnEbXX6c7qg1/mp2qVZZh0lunR8S
         6rxxzIsun6uPt2MXrj3XzOWcneUfXS/E/StH/vDOTA+DWEEnhZ8tL7Aru+YRk22Vt6vc
         j1dRZq1VnYaWfVDLaV0DVnY0ay2z6O8CL+PtXIZrGkxpojHa+5P7l26qr3VZ6WteQY35
         qRolZ9x64fERa5dTLbyAtJ/z+Ip1sX0os7cHo3/pQh1oDAmgwZnkohE4XIQh+uQHGPiT
         4MYe+dYE4pcCDsFO4SGTJR2/LHlR7VdPM46EnO51fqj4+sGH3/X0CL3yHgrBKKXsc3Kj
         2BAg==
X-Gm-Message-State: AOJu0Yz2oPQ45NaUWMfEKAPFgkn6mqXiwxB/VPFc1m+Sd4mCsxgPw7vB
	UB0vJDXAaGQdVCOjitpzV6fJvlOOuIQTowmggiqqgIKMMldH+QJ4iKZznZfPIRcV
X-Gm-Gg: ASbGncuNOV1orMZImwWqQY7qP47sXtAUQGLicoL6kbTxux6U5FnlXpNL6az+pSRAPfn
	KWpxDCYp5qXnBqudSp6zPEQgE7tC/EkQ6zicOALocxSOi1D1bMftAh8JFFhWiepGqTf7isUltNL
	2jf1en6mRv2mceUJguunNpmp8LUlsEtdpOtct3Yht4rdmT+hedBDUeU9nOcNgBFMBpHtCuMd817
	7n9XcrkZlDJnzCPCkIE1vSFVrn9+qDQ6AY7jnVQrPoIhP1WakKw3qpFEj2BtaML0z9OjYkpsqXw
	rWLarvHyhImab0YzroKoBwOHSBr6F2e28sws5bc=
X-Google-Smtp-Source: AGHT+IGCJRe7Kxo08palaq7+5DS0KysTMmXJAx/tCx1K2wetqKUgGsruc7sUH63J9UqawzaY0qMWew==
X-Received: by 2002:a05:600c:a4b:b0:43e:bdf7:7975 with SMTP id 5b1f17b1804b1-454b4ebd799mr17267355e9.32.1751634164515;
        Fri, 04 Jul 2025 06:02:44 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba69sm2477687f8f.16.2025.07.04.06.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 06:02:44 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/4] for-each-ref: introduce seeking functionality via
 '--skip-until'
Date: Fri, 04 Jul 2025 15:02:28 +0200
Message-Id: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOTQZ2gC/4WNQQ6CMBBFr0K6dsxQoaAr72FYjHVaJhFKWkI0h
 Ltb8QAu3//5768qcRRO6lKsKvIiScKYQR8KZXsaPYM8MiuNukaDNZzQgJcZXIjAZHuI7GAiLyP
 NeQt4p5b0mdhURmXLlHt57Q+3LnMvaQ7xvR8u5Tf9uRss/7qXEhAqh8SNRdO27uoHkufRhkF12
 7Z9AHTuVAzOAAAA
X-Change-ID: 20250605-306-git-for-each-ref-pagination-0ba8a29ae646
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=23366;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=lWFvSuY1cJjmc0CbZvK10gAGbpLtZwCDlXwTrUUvPFY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhn0PIqTW7gKC+AlbBagH4CuEWwz5PFrKDc1
 zZgDF6EuW2ao4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoZ9DyAAoJED7VnySO
 Rox/pY4L/05y9deW8vjVT/J+t/GUKXkpJXKG7mbeyL3v9OxQtBUYP+PFvC5yZcm1xIgIPPKQEAT
 CAa7JR4vvNaaS2Cp892A6N0y4XYVpbdDoE5Qs7keveTSFCYYZSkXS6I9f1Mrph6BsN97hepeCiK
 b+9MDc9BZvCsR66UUVY+h9QFlDSX2fvyXJupspM48ikMHqpbZ+UmZ0icECxFmezWztoyzhh9OF6
 ZJGMCUi+eaaipR9NmJnaVvDo1DhfbO27EL+cQxuJKCxWgDutEFPvdEDRtQZtm/6ig4c24PjjqPX
 zhR1PSR4uGC6q6QYkbE9CI1NS0VDIuE/TZ2oNJcYXPSvugNR8pVi1aGdIDF/aM4Ag62rvtVIisU
 iieUdAX64n9KixaaSbubAagkuHMXcUTdqZM2UVXnLTMUgvo5sl3oJf243fEgurvoZ/mGQJGldOC
 pMSgO5k3GJPDnGLolGkt9QQiBA3vUJANEAsTSRAOH9CmXq8lTL0m8A5KXIitWPH+NPoNFDXT2g7
 ys=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git-for-each-ref(1)` command is used to iterate over references
present in a repository. In large repositories with millions of
references, it would be optimal to paginate this output such that we
can start iteration from a given reference. This would avoid having to
iterate over all references from the beginning each time when paginating
through results.

This series adds a '--skip-until' option in 'git-for-each-ref(1)'. When
used, the reference iteration seeks to the first matching reference and
iterates from there onward.

This enables efficient pagination workflows like:
    git for-each-ref --count=100
    git for-each-ref --count=100 --skip-until=refs/heads/branch-100
    git for-each-ref --count=100 --skip-until=refs/heads/branch-200

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
 Documentation/git-for-each-ref.adoc |   6 +-
 builtin/for-each-ref.c              |   8 ++
 ref-filter.c                        |  61 ++++++++----
 ref-filter.h                        |   1 +
 refs.c                              |   6 +-
 refs.h                              | 158 ++++++++++++++++++++++++++++++
 refs/debug.c                        |   7 +-
 refs/files-backend.c                |   7 +-
 refs/iterator.c                     |  26 ++---
 refs/packed-backend.c               |  17 ++--
 refs/ref-cache.c                    |  99 +++++++++++++++----
 refs/ref-cache.h                    |   7 --
 refs/refs-internal.h                | 152 ++---------------------------
 refs/reftable-backend.c             |  21 ++--
 t/t6302-for-each-ref-filter.sh      | 188 ++++++++++++++++++++++++++++++++++++
 15 files changed, 538 insertions(+), 226 deletions(-)

Karthik Nayak (4):
      refs: expose `ref_iterator` via 'refs.h'
      ref-cache: remove unused function 'find_ref_entry()'
      refs: selectively set prefix in the seek functions
      for-each-ref: introduce a '--skip-until' option

Range-diff versus v1:

1:  a20ef2c841 ! 1:  d19553c365 refs: expose `ref_iterator` via 'refs.h'
    @@ refs.h: int repo_migrate_ref_storage_format(struct repository *repo,
     + * The output is ordered by refname.
     + */
     +struct ref_iterator *refs_ref_iterator_begin(
    -+		struct ref_store *refs,
    -+		const char *prefix, const char **exclude_patterns,
    -+		int trim, enum do_for_each_ref_flags flags);
    ++	struct ref_store *refs,
    ++	const char *prefix, const char **exclude_patterns,
    ++	int trim, enum do_for_each_ref_flags flags);
     +
     +/*
     + * Advance the iterator to the first or next item and return ITER_OK.
    @@ refs.h: int repo_migrate_ref_storage_format(struct repository *repo,
     + */
     +int do_for_each_ref_iterator(struct ref_iterator *iter,
     +			     each_ref_fn fn, void *cb_data);
    -+
     +
      #endif /* REFS_H */
     
2:  96f3e6eb05 = 2:  1d3936132b ref-cache: remove unused function 'find_ref_entry()'
3:  fa19b53a37 ! 3:  aab2011494 refs: selectively set prefix in the seek functions
    @@ Commit message
         further iteration would only yield references which match the particular
         prefix. This is a bit confusing.
     
    -    Let's add a 'set_prefix' field to the function, which when set, will set
    -    the prefix for the iteration in-line with the existing behavior. But
    -    when the 'set_prefix' field is not set, the reference backends will
    -    simply seek to the specified reference without setting prefix. This
    -    allows users to start iteration from a specific reference.
    +    Let's add a 'flags' field to the function, which when set with the
    +    'REF_ITERATOR_SEEK_SET_PREFIX' flag, will set the prefix for the
    +    iteration in-line with the existing behavior. Otherwise, the reference
    +    backends will simply seek to the specified reference and clears any
    +    previously set prefix. This allows users to start iteration from a
    +    specific reference.
     
         In the packed and reftable backend, since references are available in a
         sorted list, the changes are simply setting the prefix if needed. The
         changes on the files-backend are a little more involved, since the files
         backend uses the 'ref-cache' mechanism. We move out the existing logic
         within `cache_ref_iterator_seek()` to `cache_ref_iterator_set_prefix()`
    -    which is called when `set_prefix` is set. We then parse the provided
    -    seek string and set the required levels and their indexes to ensure that
    -    seeking is possible.
    +    which is called when the 'REF_ITERATOR_SEEK_SET_PREFIX' flag is set. We
    +    then parse the provided seek string and set the required levels and
    +    their indexes to ensure that seeking is possible.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## refs.c ##
     @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
    - 			if (!iter) {
    + 		if (!initial_transaction) {
    + 			int ok;
    + 
    +-			if (!iter) {
    ++			if (!iter)
      				iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
      							       DO_FOR_EACH_INCLUDE_BROKEN);
     -			} else if (ref_iterator_seek(iter, dirname.buf) < 0) {
    -+			} else if (ref_iterator_seek(iter, dirname.buf, 1) < 0) {
    ++			else if (ref_iterator_seek(iter, dirname.buf,
    ++						   REF_ITERATOR_SEEK_SET_PREFIX) < 0)
      				goto cleanup;
    - 			}
    +-			}
      
    + 			while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
    + 				if (skip &&
     
      ## refs.h ##
     @@ refs.h: struct ref_iterator *refs_ref_iterator_begin(
    +  */
      int ref_iterator_advance(struct ref_iterator *ref_iterator);
      
    ++enum ref_iterator_seek_flag {
    ++	/*
    ++	 * Also set the seek pattern as a prefix for iteration. This ensures
    ++	 * that only references which match the prefix are yielded.
    ++	 */
    ++	REF_ITERATOR_SEEK_SET_PREFIX = (1 << 0),
    ++};
    ++
      /*
     - * Seek the iterator to the first reference with the given prefix.
     - * The prefix is matched as a literal string, without regard for path
    +- * separators. If prefix is NULL or the empty string, seek the iterator to the
     + * Seek the iterator to the first reference matching the given seek string.
     + * The seek string is matched as a literal string, without regard for path
    -  * separators. If prefix is NULL or the empty string, seek the iterator to the
    ++ * separators. If seek is NULL or the empty string, seek the iterator to the
       * first reference again.
       *
     - * This function is expected to behave as if a new ref iterator with the same
     - * prefix had been created, but allows reuse of iterators and thus may allow
     - * the backend to optimize. Parameters other than the prefix that have been
     - * passed when creating the iterator will remain unchanged.
    -+ * When set_prefix is true, this function behaves as if a new ref iterator
    -+ * with the same prefix had been created, setting the prefix for subsequent
    -+ * iteration. When set_prefix is false, the iterator simply seeks to the
    -+ * specified reference without changing the existing prefix, allowing
    -+ * iteration to start from that specific reference.
    ++ * This function is expected to behave as if a new ref iterator has been
    ++ * created, but allows reuse of existing iterators for optimization.
     + *
    -+ * This function allows reuse of iterators and thus may allow the backend
    -+ * to optimize. Parameters other than the prefix that have been passed when
    -+ * creating the iterator will remain unchanged.
    ++ * When the REF_ITERATOR_SEEK_SET_PREFIX flag is set, the iterator's prefix is
    ++ * updated to match the seek string, affecting all subsequent iterations. If
    ++ * not, the iterator seeks to the specified reference and clears any previously
    ++ * set prefix.
       *
       * Returns 0 on success, a negative error code otherwise.
       */
    - int ref_iterator_seek(struct ref_iterator *ref_iterator,
    +-int ref_iterator_seek(struct ref_iterator *ref_iterator,
     -		      const char *prefix);
    -+		      const char *seek, int set_prefix);
    ++int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
    ++		      unsigned int flags);
      
      /*
       * If possible, peel the reference currently being viewed by the
    @@ refs/debug.c: static int debug_ref_iterator_advance(struct ref_iterator *ref_ite
      
      static int debug_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				   const char *prefix)
    -+				   const char *seek, int set_prefix)
    ++				   const char *seek, unsigned int flags)
      {
      	struct debug_ref_iterator *diter =
      		(struct debug_ref_iterator *)ref_iterator;
     -	int res = diter->iter->vtable->seek(diter->iter, prefix);
     -	trace_printf_key(&trace_refs, "iterator_seek: %s: %d\n", prefix ? prefix : "", res);
    -+	int res = diter->iter->vtable->seek(diter->iter, seek, set_prefix);
    -+	trace_printf_key(&trace_refs, "iterator_seek: %s set_prefix: %d: %d\n",
    -+			 seek ? seek : "", set_prefix, res);
    ++	int res = diter->iter->vtable->seek(diter->iter, seek, flags);
    ++	trace_printf_key(&trace_refs, "iterator_seek: %s flags: %d: %d\n",
    ++			 seek ? seek : "", flags, res);
      	return res;
      }
      
    @@ refs/files-backend.c: static int files_ref_iterator_advance(struct ref_iterator
      
      static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				   const char *prefix)
    -+				   const char *seek, int set_prefix)
    ++				   const char *seek, unsigned int flags)
      {
      	struct files_ref_iterator *iter =
      		(struct files_ref_iterator *)ref_iterator;
     -	return ref_iterator_seek(iter->iter0, prefix);
    -+	return ref_iterator_seek(iter->iter0, seek, set_prefix);
    ++	return ref_iterator_seek(iter->iter0, seek, flags);
      }
      
      static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
    @@ refs/files-backend.c: static int files_reflog_iterator_advance(struct ref_iterat
      static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
     -				      const char *prefix UNUSED)
     +				      const char *seek UNUSED,
    -+				      int set_prefix UNUSED)
    ++				      unsigned int flags UNUSED)
      {
      	BUG("ref_iterator_seek() called for reflog_iterator");
      }
     
      ## refs/iterator.c ##
     @@ refs/iterator.c: int ref_iterator_advance(struct ref_iterator *ref_iterator)
    + 	return ref_iterator->vtable->advance(ref_iterator);
      }
      
    - int ref_iterator_seek(struct ref_iterator *ref_iterator,
    +-int ref_iterator_seek(struct ref_iterator *ref_iterator,
     -		      const char *prefix)
    -+		      const char *seek, int set_prefix)
    ++int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
    ++		      unsigned int flags)
      {
     -	return ref_iterator->vtable->seek(ref_iterator, prefix);
    -+	return ref_iterator->vtable->seek(ref_iterator, seek, set_prefix);
    ++	return ref_iterator->vtable->seek(ref_iterator, seek, flags);
      }
      
      int ref_iterator_peel(struct ref_iterator *ref_iterator,
    @@ refs/iterator.c: static int empty_ref_iterator_advance(struct ref_iterator *ref_
      static int empty_ref_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
     -				   const char *prefix UNUSED)
     +				   const char *seek UNUSED,
    -+				   int set_prefix UNUSED)
    ++				   unsigned int flags UNUSED)
      {
      	return 0;
      }
    @@ refs/iterator.c: static int merge_ref_iterator_advance(struct ref_iterator *ref_
      
      static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				   const char *prefix)
    -+				   const char *seek, int set_prefix)
    ++				   const char *seek, unsigned int flags)
      {
      	struct merge_ref_iterator *iter =
      		(struct merge_ref_iterator *)ref_iterator;
    @@ refs/iterator.c: static int merge_ref_iterator_seek(struct ref_iterator *ref_ite
      	iter->iter1 = iter->iter1_owned;
      
     -	ret = ref_iterator_seek(iter->iter0, prefix);
    -+	ret = ref_iterator_seek(iter->iter0, seek, set_prefix);
    ++	ret = ref_iterator_seek(iter->iter0, seek, flags);
      	if (ret < 0)
      		return ret;
      
     -	ret = ref_iterator_seek(iter->iter1, prefix);
    -+	ret = ref_iterator_seek(iter->iter1, seek, set_prefix);
    ++	ret = ref_iterator_seek(iter->iter1, seek, flags);
      	if (ret < 0)
      		return ret;
      
    @@ refs/iterator.c: static int prefix_ref_iterator_advance(struct ref_iterator *ref
      
      static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				    const char *prefix)
    -+				    const char *seek, int set_prefix)
    ++				    const char *seek, unsigned int flags)
      {
      	struct prefix_ref_iterator *iter =
      		(struct prefix_ref_iterator *)ref_iterator;
    @@ refs/iterator.c: static int prefix_ref_iterator_advance(struct ref_iterator *ref
     -	iter->prefix = xstrdup_or_null(prefix);
     -	return ref_iterator_seek(iter->iter0, prefix);
     +
    -+	if (set_prefix) {
    ++	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
     +		free(iter->prefix);
     +		iter->prefix = xstrdup_or_null(seek);
     +	}
    -+	return ref_iterator_seek(iter->iter0, seek, set_prefix);
    ++	return ref_iterator_seek(iter->iter0, seek, flags);
      }
      
      static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
    @@ refs/packed-backend.c: static int packed_ref_iterator_advance(struct ref_iterato
      
      static int packed_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				    const char *prefix)
    -+				    const char *seek, int set_prefix)
    ++				    const char *seek, unsigned int flags)
      {
      	struct packed_ref_iterator *iter =
      		(struct packed_ref_iterator *)ref_iterator;
    @@ refs/packed-backend.c: static int packed_ref_iterator_advance(struct ref_iterato
      
     -	free(iter->prefix);
     -	iter->prefix = xstrdup_or_null(prefix);
    -+	if (set_prefix) {
    -+		free(iter->prefix);
    ++	/* Unset any previously set prefix */
    ++	FREE_AND_NULL(iter->prefix);
    ++
    ++	if (flags & REF_ITERATOR_SEEK_SET_PREFIX)
     +		iter->prefix = xstrdup_or_null(seek);
    -+	}
     +
      	iter->pos = start;
      	iter->eof = iter->snapshot->eof;
    @@ refs/packed-backend.c: static struct ref_iterator *packed_ref_iterator_begin(
      	iter->flags = flags;
      
     -	if (packed_ref_iterator_seek(&iter->base, prefix) < 0) {
    -+	if (packed_ref_iterator_seek(&iter->base, prefix, 1) < 0) {
    ++	if (packed_ref_iterator_seek(&iter->base, prefix,
    ++				     REF_ITERATOR_SEEK_SET_PREFIX) < 0) {
      		ref_iterator_free(&iter->base);
      		return NULL;
      	}
    @@ refs/ref-cache.c: static int cache_ref_iterator_seek(struct ref_iterator *ref_it
      }
      
     +static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
    -+				   const char *seek, int set_prefix)
    ++				   const char *seek, unsigned int flags)
     +{
     +	struct cache_ref_iterator *iter =
     +		(struct cache_ref_iterator *)ref_iterator;
     +
    -+	if (set_prefix) {
    ++	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
     +		return cache_ref_iterator_set_prefix(iter, seek);
     +	} else if (seek && *seek) {
     +		struct cache_ref_iterator_level *level;
    @@ refs/ref-cache.c: static int cache_ref_iterator_seek(struct ref_iterator *ref_it
     +		level->index = -1;
     +		level->dir = dir;
     +
    ++		/* Unset any previously set prefix */
    ++		FREE_AND_NULL(iter->prefix);
    ++
     +		/*
     +		 * Breakdown the provided seek path and assign the correct
     +		 * indexing to each level as needed.
    @@ refs/ref-cache.c: struct ref_iterator *cache_ref_iterator_begin(struct ref_cache
      	iter->prime_dir = prime_dir;
      
     -	if (cache_ref_iterator_seek(&iter->base, prefix) < 0) {
    -+	if (cache_ref_iterator_seek(&iter->base, prefix, 1) < 0) {
    ++	if (cache_ref_iterator_seek(&iter->base, prefix,
    ++				    REF_ITERATOR_SEEK_SET_PREFIX) < 0) {
      		ref_iterator_free(&iter->base);
      		return NULL;
      	}
    @@ refs/refs-internal.h: void base_ref_iterator_init(struct ref_iterator *iter,
       */
      typedef int ref_iterator_seek_fn(struct ref_iterator *ref_iterator,
     -				 const char *prefix);
    -+				 const char *seek, int set_prefix);
    ++				 const char *seek, unsigned int flags);
      
      /*
       * Peels the current ref, returning 0 for success or -1 for failure.
    @@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(struct ref_ite
      
      static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				      const char *prefix)
    -+				      const char *seek, int set_prefix)
    ++				      const char *seek, unsigned int flags)
      {
      	struct reftable_ref_iterator *iter =
      		(struct reftable_ref_iterator *)ref_iterator;
    @@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(struct ref_ite
     -	iter->prefix = xstrdup_or_null(prefix);
     -	iter->prefix_len = prefix ? strlen(prefix) : 0;
     -	iter->err = reftable_iterator_seek_ref(&iter->iter, prefix);
    -+	if (set_prefix) {
    -+		free(iter->prefix);
    ++	/* Unset any previously set prefix */
    ++	FREE_AND_NULL(iter->prefix);
    ++	iter->prefix_len = 0;
    ++
    ++	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
     +		iter->prefix = xstrdup_or_null(seek);
     +		iter->prefix_len = seek ? strlen(seek) : 0;
     +	}
    @@ refs/reftable-backend.c: static struct reftable_ref_iterator *ref_iterator_for_s
      		goto done;
      
     -	ret = reftable_ref_iterator_seek(&iter->base, prefix);
    -+	ret = reftable_ref_iterator_seek(&iter->base, prefix, 1);
    ++	ret = reftable_ref_iterator_seek(&iter->base, prefix,
    ++					 REF_ITERATOR_SEEK_SET_PREFIX);
      	if (ret)
      		goto done;
      
    @@ refs/reftable-backend.c: static int reftable_reflog_iterator_advance(struct ref_
      static int reftable_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
     -					 const char *prefix UNUSED)
     +					 const char *seek UNUSED,
    -+					 int set_prefix UNUSED)
    ++					 unsigned int flags UNUSED)
      {
      	BUG("reftable reflog iterator cannot be seeked");
      	return -1;
4:  0cfc879a93 ! 4:  dc6ffa9002 for-each-ref: introduce a '--skip-until' option
    @@ Documentation/git-for-each-ref.adoc: TAB %(refname)`.
      	List root refs (HEAD and pseudorefs) apart from regular refs.
      
     +--skip-until::
    -+    Skip references up to the specified pattern. Cannot be used with
    -+    general pattern matching.
    ++    Skip references up to but excluding the specified pattern. Cannot be used
    ++    with general pattern matching or custom sort options.
     +
      FIELD NAMES
      -----------
    @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc,
      		OPT__COLOR(&format.use_color, N_("respect format colors")),
      		OPT_REF_FILTER_EXCLUDE(&filter),
      		OPT_REF_SORT(&sorting_options),
    +@@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc,
    + 	if (verify_ref_format(&format))
    + 		usage_with_options(for_each_ref_usage, opts);
    + 
    ++	if (filter.seek && sorting_options.nr > 1)
    ++		die(_("cannot use --skip-until custom sort options"));
    ++
    + 	sorting = ref_sorting_options(&sorting_options);
    + 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
    + 	filter.ignore_case = icase;
     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc,
      		filter.name_patterns = argv;
      	}
    @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
      
      /*
     @@ ref-filter.c: static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
    - 	if (!filter->kind)
    + 	init_contains_cache(&filter->internal.no_contains_cache);
    + 
    + 	/*  Simple per-ref filtering */
    +-	if (!filter->kind)
    ++	if (!filter->kind) {
      		die("filter_refs: invalid type");
    - 	else {
    +-	else {
    ++	} else {
     +		const char *prefix = NULL;
     +
      		/*
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	cat >expect <<-\EOF &&
     +	fatal: cannot use --skip-until with patterns
     +	EOF
    -+	test_must_fail git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot refs/tags  2>actual &&
    ++	test_must_fail git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot refs/tags 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'skip until used with custom sort order' '
    ++	cat >expect <<-\EOF &&
    ++	fatal: cannot use --skip-until custom sort options
    ++	EOF
    ++	test_must_fail git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot --sort=author 2>actual &&
     +	test_cmp expect actual
     +'
     +


base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
change-id: 20250605-306-git-for-each-ref-pagination-0ba8a29ae646

Thanks
- Karthik

