Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711E92EF2A9
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250727; cv=none; b=A16zNjyJNfRf+LXPVvAOoIZDsa3zJNy/iKlVl+I+Bwl2JFz7FusftnkToqM4Acdg1LlxFe8BhseHYRV3kix4i9xiF3xewXTpf06xX5/pWjNB9q3Tp7nc+zv7dcmHVVw+WPEqAp2NCGt/na20E9+nFibUqviztHUlL8NvvpG1ieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250727; c=relaxed/simple;
	bh=ARKDSomGgZE0kb2rM4ZwPU31SLjytQsbcShHZu0U/vw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=a3hNyVfpZzq9fJ8GJhyCB04j10c2r0IyLOqhM4YAQH5SguPKMCrtRcmzIK49g7kLm/tM5SiafC87pek2F+7W+ihLvI9RLgqx99ivdCEx/VYgES+/Ysr6wie9L3rb6ikLSqV2f9aGgn6Q0oSZIA3bH1lVA1apHeQzBP+qi1bgMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT/RnloU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT/RnloU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a54690d369so2178953f8f.3
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752250724; x=1752855524; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dr5l+EwDyTjWXPqm42TGjV3jX3At5zIA8J03lDkuTtk=;
        b=bT/RnloUUtldSEa1VfyXRe6huWQUqSogYxAdDnPNnY7QyKJrwQ8InoQUhnqKI4OdbV
         35VGYVGyPcWViaiy07BcFJdQxzNp8Z633UvbdHFiKSGn/Zl+rHPkFQVOn69nNriIo4pN
         VSKeGfOQyMiqZ9ok+QXZrm2KZf5nvsGeCGgMSuMDlD4FB8NxJDrURscyvGdykZtbsIpi
         M05hYuDDFqP7VJnPPESgALgVyvkC1i57PjctIeFJLhdfbiRRw4sRQAxvT+giVOx4/w2M
         U8QL5GbfnlGYVrIiJqSW5gDExSOnAGbBAhULLGcDAdljDDD0cotNW/zOxdeyvY+aTBiD
         kBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250724; x=1752855524;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dr5l+EwDyTjWXPqm42TGjV3jX3At5zIA8J03lDkuTtk=;
        b=nCXVjLjOCmK/cOv+MMs2ZpiYdnNU19mnXbEH6vvQpzy8H2sKnSmTwZ9f9g3DtXEcmG
         yGlncnGheeLdmqrd2d/2NsuWIFuUFW6SbAUkRfk2EOcO5FXTlli6EKNZQSPF+BikkoJ2
         E7ysMF5x62oL361KZMywRXVtkzLZDMLMsK+tjbkmTB/XzL2zxRGIwVNMQls/ey2B0H2e
         TKkmTQ2kQGH/bOuw6JdyXSmi05mf34WZxipgGopM2zrkRdN+ZGte0+Zyfc7FUlET+Wpl
         tMKyt9V4+Ari4rSW8zFFo+WODnUEvyMzoACD/0H5Ee8wkS9XQKT+s/X8QIytSA4rN2ai
         GzNA==
X-Gm-Message-State: AOJu0YwgDlfOQ5Hn6QtfpmMvaQ/vQ+pQGqt0d6SikHoWirC/CtLEW7Sq
	S/xrB/KUxXpIC+ImBrgPHfx4SETahq/ES1Bhl4yBOA0fdVo4rmtewvfp
X-Gm-Gg: ASbGncsZdLyLchSNB85a9DvUBZkMIV6QtcF3Jf1Qg2cjJrcnqDE35ZxOzPMZXyLtE0i
	e4dS1L69doy5Vb61jLuFjqDT1nroh7zkJ2qYz3uPJfNI6LPtr2ZEg7GwhBcQ2UYY4SSlgBJFUML
	zhPu38vSbpJ6vgiCll8cjc0Vf1znsh8O/SqefID9ixhPcHwp+EF3GufLIql9SlJhneQdjITZpT1
	qUNBOC/cuFcVYFmUi0sW0YCT2V3hCMW2QswpNikC1xFC++8TTB63q6B9L+ra0FT5k4o4wOZHKC5
	rA49+/BuRlnE5/SGd2Ti+WiMTezk415e8nuoriUB5INK7WCMbX9GLjl39DnAKeE8uXxf3eN0phI
	Q6U9R/g==
X-Google-Smtp-Source: AGHT+IEiRkgg0uZHAcECm71wqV+57oZjKVB6V+kwp5nDK1lw7J98/EvxVlrmB7S9c3J/hYPRXZkL7Q==
X-Received: by 2002:a5d:5f88:0:b0:3a4:dd8e:e16d with SMTP id ffacd0b85a97d-3b5f2dc2ad0mr2961751f8f.15.1752250723430;
        Fri, 11 Jul 2025 09:18:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5049:80b7:8726:cf1e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd55b0e4sm51293955e9.39.2025.07.11.09.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:18:42 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/4] for-each-ref: introduce seeking functionality via
 '--start-after'
Date: Fri, 11 Jul 2025 18:18:36 +0200
Message-Id: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFw5cWgC/4XNQQ6CMBAF0KuYrh0zLbVWV97DuBjKFCZRIIUQj
 eHuVt0QNyz/TP77LzVwEh7UafNSiScZpGtzsNuNCg21NYNUOSuDZo8O91Cgg1pGiF0CptBA4gg
 91dLSmLuAJXkyR2JnncpKn//y+C5crjk3Moxden4HJ/25/uwD6lV70oBgIxIfAjrv47m+k9x2o
 burjz2ZpWfXPZO9MlSsLYWq8vrfK5aeX/eK7PkQS9LosWS79OZ5fgNLkIt9bgEAAA==
X-Change-ID: 20250605-306-git-for-each-ref-pagination-0ba8a29ae646
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=17916;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=ARKDSomGgZE0kb2rM4ZwPU31SLjytQsbcShHZu0U/vw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhxOWFmfZJF+fvsP9+KB34zhCEjGSQdpIBTq
 QszrZoA1kUyeIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJocTlhAAoJED7VnySO
 Rox/pxwMAIHzRM8sZsmLhLywh2s0sl9No1RC+dE/QWfW+PTLzFJjX/3Puk4ZEvOkVtcktexQAOQ
 e371hGc7aNZeYa4fGUh4/KETUNNxbEP9Y1oyl2AoUim3T/PuNu6ePEstw5BrQTq3Slz+oXG/HkF
 NtIY2QDcnG4xRNcH0kyy310R41X5XfB0NgMtgjBkr86nLdGWWwld4HIHMF8nzIGliz5cTpZdxYb
 ROGunzvjyh9XiJRtue7m7/mI/cxXg1Dm1Xz+i/4gAyBB6Nh5WnuJkUyFuurxxED3tgpwawam1bh
 21ZhXPli5mHo6RecRc8SEcKrgRZDonWoXoTrz6BQ/FPg3A0nTEmQI/ogfzkaiXMcAWW3bY+m2lT
 OSBS0xempDOGAhzo8D/FhtIh49ljrI4SQC1u2jkZGg7paxQOaztGbJY764T/shfV40AbvWQD2PV
 k1xhkbpzGIE0v+cEUVJU1S4X45uqhX+0grnGIzrepm917oto5wmAeUg0VcMVC4iP5P7omprI+26
 AY=
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
 ref-filter.c                        |  80 +++++++++++----
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
 15 files changed, 564 insertions(+), 226 deletions(-)

Karthik Nayak (4):
      refs: expose `ref_iterator` via 'refs.h'
      ref-cache: remove unused function 'find_ref_entry()'
      refs: selectively set prefix in the seek functions
      for-each-ref: introduce a '--start-after' option

Range-diff versus v3:

1:  eed39162f5 = 1:  9e6ecff291 refs: expose `ref_iterator` via 'refs.h'
2:  b9db49d31b = 2:  22f5222e4f ref-cache: remove unused function 'find_ref_entry()'
3:  502e2696fd ! 3:  0e71d8ffd9 refs: selectively set prefix in the seek functions
    @@ refs.h: struct ref_iterator *refs_ref_iterator_begin(
      
     +enum ref_iterator_seek_flag {
     +	/*
    -+	 * Also set the seek pattern as a prefix for iteration. This ensures
    -+	 * that only references which match the prefix are yielded.
    ++	 * When the REF_ITERATOR_SEEK_SET_PREFIX flag is set, the iterator's prefix is
    ++	 * updated to match the provided string, affecting all subsequent iterations. If
    ++	 * not, the iterator seeks to the specified reference and clears any previously
    ++	 * set prefix.
     +	 */
     +	REF_ITERATOR_SEEK_SET_PREFIX = (1 << 0),
     +};
    @@ refs.h: struct ref_iterator *refs_ref_iterator_begin(
     - * passed when creating the iterator will remain unchanged.
     + * This function is expected to behave as if a new ref iterator has been
     + * created, but allows reuse of existing iterators for optimization.
    -+ *
    -+ * When the REF_ITERATOR_SEEK_SET_PREFIX flag is set, the iterator's prefix is
    -+ * updated to match the seek string, affecting all subsequent iterations. If
    -+ * not, the iterator seeks to the specified reference and clears any previously
    -+ * set prefix.
       *
       * Returns 0 on success, a negative error code otherwise.
       */
     -int ref_iterator_seek(struct ref_iterator *ref_iterator,
     -		      const char *prefix);
    -+int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
    ++int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *refname,
     +		      unsigned int flags);
      
      /*
    @@ refs/debug.c: static int debug_ref_iterator_advance(struct ref_iterator *ref_ite
      
      static int debug_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				   const char *prefix)
    -+				   const char *seek, unsigned int flags)
    ++				   const char *refname, unsigned int flags)
      {
      	struct debug_ref_iterator *diter =
      		(struct debug_ref_iterator *)ref_iterator;
     -	int res = diter->iter->vtable->seek(diter->iter, prefix);
     -	trace_printf_key(&trace_refs, "iterator_seek: %s: %d\n", prefix ? prefix : "", res);
    -+	int res = diter->iter->vtable->seek(diter->iter, seek, flags);
    ++	int res = diter->iter->vtable->seek(diter->iter, refname, flags);
     +	trace_printf_key(&trace_refs, "iterator_seek: %s flags: %d: %d\n",
    -+			 seek ? seek : "", flags, res);
    ++			 refname ? refname : "", flags, res);
      	return res;
      }
      
    @@ refs/files-backend.c: static int files_ref_iterator_advance(struct ref_iterator
      
      static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				   const char *prefix)
    -+				   const char *seek, unsigned int flags)
    ++				   const char *refname, unsigned int flags)
      {
      	struct files_ref_iterator *iter =
      		(struct files_ref_iterator *)ref_iterator;
     -	return ref_iterator_seek(iter->iter0, prefix);
    -+	return ref_iterator_seek(iter->iter0, seek, flags);
    ++	return ref_iterator_seek(iter->iter0, refname, flags);
      }
      
      static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
    @@ refs/files-backend.c: static int files_reflog_iterator_advance(struct ref_iterat
      
      static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
     -				      const char *prefix UNUSED)
    -+				      const char *seek UNUSED,
    ++				      const char *refname UNUSED,
     +				      unsigned int flags UNUSED)
      {
      	BUG("ref_iterator_seek() called for reflog_iterator");
    @@ refs/iterator.c: int ref_iterator_advance(struct ref_iterator *ref_iterator)
      
     -int ref_iterator_seek(struct ref_iterator *ref_iterator,
     -		      const char *prefix)
    -+int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
    ++int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *refname,
     +		      unsigned int flags)
      {
     -	return ref_iterator->vtable->seek(ref_iterator, prefix);
    -+	return ref_iterator->vtable->seek(ref_iterator, seek, flags);
    ++	return ref_iterator->vtable->seek(ref_iterator, refname, flags);
      }
      
      int ref_iterator_peel(struct ref_iterator *ref_iterator,
    @@ refs/iterator.c: static int empty_ref_iterator_advance(struct ref_iterator *ref_
      
      static int empty_ref_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
     -				   const char *prefix UNUSED)
    -+				   const char *seek UNUSED,
    ++				   const char *refname UNUSED,
     +				   unsigned int flags UNUSED)
      {
      	return 0;
    @@ refs/iterator.c: static int merge_ref_iterator_advance(struct ref_iterator *ref_
      
      static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				   const char *prefix)
    -+				   const char *seek, unsigned int flags)
    ++				   const char *refname, unsigned int flags)
      {
      	struct merge_ref_iterator *iter =
      		(struct merge_ref_iterator *)ref_iterator;
    @@ refs/iterator.c: static int merge_ref_iterator_seek(struct ref_iterator *ref_ite
      	iter->iter1 = iter->iter1_owned;
      
     -	ret = ref_iterator_seek(iter->iter0, prefix);
    -+	ret = ref_iterator_seek(iter->iter0, seek, flags);
    ++	ret = ref_iterator_seek(iter->iter0, refname, flags);
      	if (ret < 0)
      		return ret;
      
     -	ret = ref_iterator_seek(iter->iter1, prefix);
    -+	ret = ref_iterator_seek(iter->iter1, seek, flags);
    ++	ret = ref_iterator_seek(iter->iter1, refname, flags);
      	if (ret < 0)
      		return ret;
      
    @@ refs/iterator.c: static int prefix_ref_iterator_advance(struct ref_iterator *ref
      
      static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				    const char *prefix)
    -+				    const char *seek, unsigned int flags)
    ++				    const char *refname, unsigned int flags)
      {
      	struct prefix_ref_iterator *iter =
      		(struct prefix_ref_iterator *)ref_iterator;
    @@ refs/iterator.c: static int prefix_ref_iterator_advance(struct ref_iterator *ref
     +
     +	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
     +		free(iter->prefix);
    -+		iter->prefix = xstrdup_or_null(seek);
    ++		iter->prefix = xstrdup_or_null(refname);
     +	}
    -+	return ref_iterator_seek(iter->iter0, seek, flags);
    ++	return ref_iterator_seek(iter->iter0, refname, flags);
      }
      
      static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
    @@ refs/packed-backend.c: static int packed_ref_iterator_advance(struct ref_iterato
      
      static int packed_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				    const char *prefix)
    -+				    const char *seek, unsigned int flags)
    ++				    const char *refname, unsigned int flags)
      {
      	struct packed_ref_iterator *iter =
      		(struct packed_ref_iterator *)ref_iterator;
    @@ refs/packed-backend.c: static int packed_ref_iterator_advance(struct ref_iterato
      
     -	if (prefix && *prefix)
     -		start = find_reference_location(iter->snapshot, prefix, 0);
    -+	if (seek && *seek)
    -+		start = find_reference_location(iter->snapshot, seek, 0);
    ++	if (refname && *refname)
    ++		start = find_reference_location(iter->snapshot, refname, 0);
      	else
      		start = iter->snapshot->start;
      
    @@ refs/packed-backend.c: static int packed_ref_iterator_advance(struct ref_iterato
     +	FREE_AND_NULL(iter->prefix);
     +
     +	if (flags & REF_ITERATOR_SEEK_SET_PREFIX)
    -+		iter->prefix = xstrdup_or_null(seek);
    ++		iter->prefix = xstrdup_or_null(refname);
     +
      	iter->pos = start;
      	iter->eof = iter->snapshot->eof;
    @@ refs/ref-cache.c: static int cache_ref_iterator_seek(struct ref_iterator *ref_it
      }
      
     +static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
    -+				   const char *seek, unsigned int flags)
    ++				   const char *refname, unsigned int flags)
     +{
     +	struct cache_ref_iterator *iter =
     +		(struct cache_ref_iterator *)ref_iterator;
     +
     +	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
    -+		return cache_ref_iterator_set_prefix(iter, seek);
    -+	} else if (seek && *seek) {
    ++		return cache_ref_iterator_set_prefix(iter, refname);
    ++	} else if (refname && *refname) {
     +		struct cache_ref_iterator_level *level;
    -+		const char *slash = seek;
    ++		const char *slash = refname;
     +		struct ref_dir *dir;
     +
     +		dir = get_ref_dir(iter->cache->root);
     +
     +		if (iter->prime_dir)
    -+			prime_ref_dir(dir, seek);
    ++			prime_ref_dir(dir, refname);
     +
     +		iter->levels_nr = 1;
     +		level = &iter->levels[0];
    @@ refs/ref-cache.c: static int cache_ref_iterator_seek(struct ref_iterator *ref_it
     +			sort_ref_dir(dir);
     +
     +			slash = strchr(slash, '/');
    -+			len = slash ? slash - seek : (int)strlen(seek);
    ++			len = slash ? slash - refname : (int)strlen(refname);
     +
     +			for (idx = 0; idx < dir->nr; idx++) {
    -+				cmp = strncmp(seek, dir->entries[idx]->name, len);
    ++				cmp = strncmp(refname, dir->entries[idx]->name, len);
     +				if (cmp <= 0)
     +					break;
     +			}
    @@ refs/refs-internal.h: void base_ref_iterator_init(struct ref_iterator *iter,
       */
      typedef int ref_iterator_seek_fn(struct ref_iterator *ref_iterator,
     -				 const char *prefix);
    -+				 const char *seek, unsigned int flags);
    ++				 const char *refname, unsigned int flags);
      
      /*
       * Peels the current ref, returning 0 for success or -1 for failure.
    @@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(struct ref_ite
      
      static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
     -				      const char *prefix)
    -+				      const char *seek, unsigned int flags)
    ++				      const char *refname, unsigned int flags)
      {
      	struct reftable_ref_iterator *iter =
      		(struct reftable_ref_iterator *)ref_iterator;
    @@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(struct ref_ite
     +	iter->prefix_len = 0;
     +
     +	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
    -+		iter->prefix = xstrdup_or_null(seek);
    -+		iter->prefix_len = seek ? strlen(seek) : 0;
    ++		iter->prefix = xstrdup_or_null(refname);
    ++		iter->prefix_len = refname ? strlen(refname) : 0;
     +	}
    -+	iter->err = reftable_iterator_seek_ref(&iter->iter, seek);
    ++	iter->err = reftable_iterator_seek_ref(&iter->iter, refname);
      
      	return iter->err;
      }
    @@ refs/reftable-backend.c: static int reftable_reflog_iterator_advance(struct ref_
      
      static int reftable_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
     -					 const char *prefix UNUSED)
    -+					 const char *seek UNUSED,
    ++					 const char *refname UNUSED,
     +					 unsigned int flags UNUSED)
      {
      	BUG("reftable reflog iterator cannot be seeked");
4:  a571579886 ! 4:  e4e9dddd15 for-each-ref: introduce a '--start-after' option
    @@ Commit message
         'git-for-each-ref(1)'. When used, the reference iteration seeks to the
         lexicographically next reference and iterates from there onward.
     
    -    This enables efficient pagination workflows like:
    +    This enables efficient pagination workflows, where the calling script
    +    can remember the last provided reference and use that as the starting
    +    point for the next set of references:
             git for-each-ref --count=100
             git for-each-ref --count=100 --start-after=refs/heads/branch-100
             git for-each-ref --count=100 --start-after=refs/heads/branch-200
    @@ Documentation/git-for-each-ref.adoc: TAB %(refname)`.
      --include-root-refs::
      	List root refs (HEAD and pseudorefs) apart from regular refs.
      
    -+--start-after::
    ++--start-after=<marker>::
     +    Allows paginating the output by skipping references up to and including the
     +    specified marker. When paging, it should be noted that references may be
     +    deleted, modified or added between invocations. Output will only yield those
    -+    references which follow the marker lexicographically. If the marker does not
    -+    exist, output begins from the first reference that would come after it
    -+    alphabetically. Cannot be used with general pattern matching or custom
    -+    sort options.
    ++    references which follow the marker lexicographically. Output begins from the
    ++    first reference that would come after the marker alphabetically. Cannot be
    ++    used with general pattern matching or custom sort options.
     +
      FIELD NAMES
      -----------


base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
change-id: 20250605-306-git-for-each-ref-pagination-0ba8a29ae646

Thanks
- Karthik

