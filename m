Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9901F1F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 18:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbdH2SYd (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 14:24:33 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34690 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdH2SYc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 14:24:32 -0400
Received: by mail-pg0-f45.google.com with SMTP id y15so13123271pgc.1
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iBTjEr97YcMDiovOYBvj0EPVNq1Qyr71uXMZLxUanRQ=;
        b=bFNa+auD+E1rCp+TRZUG4Xh8QkHoMdxu2r2NeQMmgKEFCCCg1adbN6pYSZAbb66eWu
         u/CoR54hFntgHTIG1T+Tbq4h5Sk1O+WKoQuEGxQ72iDCqB0EjSJPJU40eHrc+2dgyFTj
         8x0650h9Ow5ycxIXTMpiXA4KmBjf8xyrY+ktYf85k/H4L9hdY22UGC5bN0BzVMLxvdC9
         hBgq2pkOZUmIjZDI4XWsMLvkzogRsz7yMqSBbpmjcNq5xHoJUW91DvEOjuHBpo7rcRFv
         0K3gaajnqNvSJYJ1+AWOoDvjcJmFwL1YKSz9+mMitoyUjIuy87cQCVrrM/QFDd9Bs88O
         TkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iBTjEr97YcMDiovOYBvj0EPVNq1Qyr71uXMZLxUanRQ=;
        b=SOw24LXPAEMSsGnIRC02m7auix0O4wIEPgoiMEXdh7dLBmFUc0GEh3bxwJJC1sXWHK
         s2jIKq3fJJPotOFuUG9+6nWIrvkeSBbstjRfrkY2Nh8tZke8RBxYFwAMTVfaoHdyXi44
         DZc3/7Axy24dHzSYVPjuSf63KfOXvsUxAoqwIg/zxRCpsxVL/QgVNz0AIU/wB6f+1Xhg
         7Vc6OUbQevX7s+zEXMJ453RHbpRFyfMuGzXTAqDbHont7SMJxR7V1u0qF3O7+E5hdwho
         61UMcNAGA/aKGChQbpQ4xyXMvjEUQswBcWoCKejgAZ53H0wBegm2tdIvLMQueCiy1ej4
         fkMg==
X-Gm-Message-State: AHYfb5i6tATG2uhvs/cETrNdeEldJbx9/vU7Xm59KFpF7qaORH51qp9U
        fmdmX4CPQBBUkSkV
X-Google-Smtp-Source: ADKCNb7eZY49m0Vdgissjy1pWN+YBCUvf8b0cpjpzuBNpSXur14Lg6/c7Z84gwoXUnqHd31ZSttOLw==
X-Received: by 10.98.98.69 with SMTP id w66mr1213358pfb.282.1504031071015;
        Tue, 29 Aug 2017 11:24:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:7c99:20b:3f53:fc88])
        by smtp.gmail.com with ESMTPSA id p21sm5946390pfk.123.2017.08.29.11.24.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 11:24:30 -0700 (PDT)
Date:   Tue, 29 Aug 2017 11:24:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 09/10] packed-backend: rip out some now-unused code
Message-ID: <20170829182428.GB131745@google.com>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <824ad441f8531f1bbcc8800a14fe71466721066d.1503993268.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <824ad441f8531f1bbcc8800a14fe71466721066d.1503993268.git.mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/29, Michael Haggerty wrote:
> Now the outside world interacts with the packed ref store only via the
> generic refs API plus a few lock-related functions. This allows us to
> delete some functions that are no longer used, thereby completing the
> encapsulation of the packed ref store.

Love seeing patches which only remove old code :)

> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/packed-backend.c | 193 --------------------------------------------------
>  refs/packed-backend.h |   8 ---
>  2 files changed, 201 deletions(-)
> 
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 83a088118f..90f44c1fbb 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -91,19 +91,6 @@ struct ref_store *packed_ref_store_create(const char *path,
>  	return ref_store;
>  }
>  
> -/*
> - * Die if refs is not the main ref store. caller is used in any
> - * necessary error messages.
> - */
> -static void packed_assert_main_repository(struct packed_ref_store *refs,
> -					  const char *caller)
> -{
> -	if (refs->store_flags & REF_STORE_MAIN)
> -		return;
> -
> -	die("BUG: operation %s only allowed for main ref store", caller);
> -}
> -
>  /*
>   * Downcast `ref_store` to `packed_ref_store`. Die if `ref_store` is
>   * not a `packed_ref_store`. Also die if `packed_ref_store` doesn't
> @@ -321,40 +308,6 @@ static struct ref_dir *get_packed_refs(struct packed_ref_store *refs)
>  	return get_packed_ref_dir(get_packed_ref_cache(refs));
>  }
>  
> -/*
> - * Add or overwrite a reference in the in-memory packed reference
> - * cache. This may only be called while the packed-refs file is locked
> - * (see packed_refs_lock()). To actually write the packed-refs file,
> - * call commit_packed_refs().
> - */
> -void add_packed_ref(struct ref_store *ref_store,
> -		    const char *refname, const struct object_id *oid)
> -{
> -	struct packed_ref_store *refs =
> -		packed_downcast(ref_store, REF_STORE_WRITE,
> -				"add_packed_ref");
> -	struct ref_dir *packed_refs;
> -	struct ref_entry *packed_entry;
> -
> -	if (!is_lock_file_locked(&refs->lock))
> -		die("BUG: packed refs not locked");
> -
> -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
> -		die("Reference has invalid format: '%s'", refname);
> -
> -	packed_refs = get_packed_refs(refs);
> -	packed_entry = find_ref_entry(packed_refs, refname);
> -	if (packed_entry) {
> -		/* Overwrite the existing entry: */
> -		oidcpy(&packed_entry->u.value.oid, oid);
> -		packed_entry->flag = REF_ISPACKED;
> -		oidclr(&packed_entry->u.value.peeled);
> -	} else {
> -		packed_entry = create_ref_entry(refname, oid, REF_ISPACKED);
> -		add_ref_entry(packed_refs, packed_entry);
> -	}
> -}
> -
>  /*
>   * Return the ref_entry for the given refname from the packed
>   * references.  If it does not exist, return NULL.
> @@ -592,152 +545,6 @@ int packed_refs_is_locked(struct ref_store *ref_store)
>  static const char PACKED_REFS_HEADER[] =
>  	"# pack-refs with: peeled fully-peeled \n";
>  
> -/*
> - * Write the current version of the packed refs cache from memory to
> - * disk. The packed-refs file must already be locked for writing (see
> - * packed_refs_lock()). Return zero on success. On errors, rollback
> - * the lockfile, write an error message to `err`, and return a nonzero
> - * value.
> - */
> -int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
> -{
> -	struct packed_ref_store *refs =
> -		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
> -				"commit_packed_refs");
> -	struct packed_ref_cache *packed_ref_cache =
> -		get_packed_ref_cache(refs);
> -	int ok;
> -	int ret = -1;
> -	struct strbuf sb = STRBUF_INIT;
> -	FILE *out;
> -	struct ref_iterator *iter;
> -	char *packed_refs_path;
> -
> -	if (!is_lock_file_locked(&refs->lock))
> -		die("BUG: commit_packed_refs() called when unlocked");
> -
> -	/*
> -	 * If packed-refs is a symlink, we want to overwrite the
> -	 * symlinked-to file, not the symlink itself. Also, put the
> -	 * staging file next to it:
> -	 */
> -	packed_refs_path = get_locked_file_path(&refs->lock);
> -	strbuf_addf(&sb, "%s.new", packed_refs_path);
> -	if (create_tempfile(&refs->tempfile, sb.buf) < 0) {
> -		strbuf_addf(err, "unable to create file %s: %s",
> -			    sb.buf, strerror(errno));
> -		strbuf_release(&sb);
> -		goto out;
> -	}
> -	strbuf_release(&sb);
> -
> -	out = fdopen_tempfile(&refs->tempfile, "w");
> -	if (!out) {
> -		strbuf_addf(err, "unable to fdopen packed-refs tempfile: %s",
> -			    strerror(errno));
> -		goto error;
> -	}
> -
> -	if (fprintf(out, "%s", PACKED_REFS_HEADER) < 0) {
> -		strbuf_addf(err, "error writing to %s: %s",
> -			    get_tempfile_path(&refs->tempfile), strerror(errno));
> -		goto error;
> -	}
> -
> -	iter = cache_ref_iterator_begin(packed_ref_cache->cache, NULL, 0);
> -	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> -		struct object_id peeled;
> -		int peel_error = ref_iterator_peel(iter, &peeled);
> -
> -		if (write_packed_entry(out, iter->refname, iter->oid->hash,
> -				       peel_error ? NULL : peeled.hash)) {
> -			strbuf_addf(err, "error writing to %s: %s",
> -				    get_tempfile_path(&refs->tempfile),
> -				    strerror(errno));
> -			ref_iterator_abort(iter);
> -			goto error;
> -		}
> -	}
> -
> -	if (ok != ITER_DONE) {
> -		strbuf_addf(err, "unable to rewrite packed-refs file: "
> -			    "error iterating over old contents");
> -		goto error;
> -	}
> -
> -	if (rename_tempfile(&refs->tempfile, packed_refs_path)) {
> -		strbuf_addf(err, "error replacing %s: %s",
> -			    refs->path, strerror(errno));
> -		goto out;
> -	}
> -
> -	ret = 0;
> -	goto out;
> -
> -error:
> -	delete_tempfile(&refs->tempfile);
> -
> -out:
> -	free(packed_refs_path);
> -	return ret;
> -}
> -
> -/*
> - * Rewrite the packed-refs file, omitting any refs listed in
> - * 'refnames'. On error, leave packed-refs unchanged, write an error
> - * message to 'err', and return a nonzero value. The packed refs lock
> - * must be held when calling this function; it will still be held when
> - * the function returns.
> - *
> - * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
> - */
> -int repack_without_refs(struct ref_store *ref_store,
> -			struct string_list *refnames, struct strbuf *err)
> -{
> -	struct packed_ref_store *refs =
> -		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
> -				"repack_without_refs");
> -	struct ref_dir *packed;
> -	struct string_list_item *refname;
> -	int needs_repacking = 0, removed = 0;
> -
> -	packed_assert_main_repository(refs, "repack_without_refs");
> -	assert(err);
> -
> -	if (!is_lock_file_locked(&refs->lock))
> -		die("BUG: repack_without_refs called without holding lock");
> -
> -	/* Look for a packed ref */
> -	for_each_string_list_item(refname, refnames) {
> -		if (get_packed_ref(refs, refname->string)) {
> -			needs_repacking = 1;
> -			break;
> -		}
> -	}
> -
> -	/* Avoid locking if we have nothing to do */
> -	if (!needs_repacking)
> -		return 0; /* no refname exists in packed refs */
> -
> -	packed = get_packed_refs(refs);
> -
> -	/* Remove refnames from the cache */
> -	for_each_string_list_item(refname, refnames)
> -		if (remove_entry_from_dir(packed, refname->string) != -1)
> -			removed = 1;
> -	if (!removed) {
> -		/*
> -		 * All packed entries disappeared while we were
> -		 * acquiring the lock.
> -		 */
> -		clear_packed_ref_cache(refs);
> -		return 0;
> -	}
> -
> -	/* Write what remains */
> -	return commit_packed_refs(&refs->base, err);
> -}
> -
>  static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
>  {
>  	/* Nothing to do. */
> diff --git a/refs/packed-backend.h b/refs/packed-backend.h
> index 7af2897757..61687e408a 100644
> --- a/refs/packed-backend.h
> +++ b/refs/packed-backend.h
> @@ -23,12 +23,4 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
>  void packed_refs_unlock(struct ref_store *ref_store);
>  int packed_refs_is_locked(struct ref_store *ref_store);
>  
> -void add_packed_ref(struct ref_store *ref_store,
> -		    const char *refname, const struct object_id *oid);
> -
> -int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err);
> -
> -int repack_without_refs(struct ref_store *ref_store,
> -			struct string_list *refnames, struct strbuf *err);
> -
>  #endif /* REFS_PACKED_BACKEND_H */
> -- 
> 2.14.1
> 

-- 
Brandon Williams
