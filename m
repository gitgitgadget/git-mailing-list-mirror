From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/13] refs: introduce an iterator interface
Date: Tue, 31 May 2016 01:29:25 -0400
Message-ID: <CAPig+cSjzZGUjdgkz1y7brGNb1M2gHfW0UG-wgBc00beNDQmnA@mail.gmail.com>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
	<89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 31 07:29:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7cFB-0005Ge-Fm
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 07:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbcEaF31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 01:29:27 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38677 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbcEaF31 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 01:29:27 -0400
Received: by mail-it0-f44.google.com with SMTP id i127so21445509ita.1
        for <git@vger.kernel.org>; Mon, 30 May 2016 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=CgrXNBi9k1rG85NgZTBLJv/IzKYgBwWK3Iriuyfdt0k=;
        b=EiJaGhVplpEkxmkCfgLTd4EGQszrxJimJrdLCjp/XPbdYvcWsApthh9KaKO56kNBSH
         f7I21F2rJgEW6SI6UOab5L1zr1DHdFH3uz15/Ew0Fvh4DjgcC88m3HVhl8TKbVYThnc5
         4e7G2yA288qg1BOuHCtr1l+yEy9fD/x9qMjJsB23auL1NhdkHO1AcmGshIdPcYkNMSyh
         RpumEshegWj3mHXiWbiotdkLaDhrdZ1dXFzBkX+VR2YThLq3CrvG71Aa7hJGySLB9W5G
         3628SEnYPjnEpoXbd6L5kCc8Gv2Y3uOoDhmWX+wxVdOcWjLeag8ZBdn7+gLRCxhD0Pca
         4pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CgrXNBi9k1rG85NgZTBLJv/IzKYgBwWK3Iriuyfdt0k=;
        b=WonxIw2RZk2aDPDxC2yao2xOsRXSGM126WlYuthk3zAckI7NasazBZrdrpw7vCxHUf
         zBJgVSbVpQyckGRJN0T4TfbKPmJ/6ToZbrf6kFvk6QdKJjmUK2Q8MtuFjtGi5zqWQ7TR
         WK6oA9N3U38de//VF7Pp487YiTrjqgKEHuvzL3bLI1k9W3l8Wy3mJm4dier4VKQ+8+uf
         ooClJ/1DgjBod790qm8QnMc9vbK0V8M8uaL/40LuBH6c1WQtf1/+g/+lCCqh9jmv0plf
         nJYCaUwpvya1EHnZn/7pxmoXs3BNtw6mstrwn6WTMes4NSOPt3nrCIVnTfvM0bxy09gH
         xZQQ==
X-Gm-Message-State: ALyK8tLM25sRgnnlnfi413r8Exs3vrsgmt/1Fhh79SUNx4RVqfBV66A8CFwY98O23biFva59TJI2WrezI25A/A==
X-Received: by 10.36.55.13 with SMTP id r13mr11340467itr.73.1464672565925;
 Mon, 30 May 2016 22:29:25 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Mon, 30 May 2016 22:29:25 -0700 (PDT)
In-Reply-To: <89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: LQsGpH-i3Loa_mMN-YoHFXECW7k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295951>

On Mon, May 30, 2016 at 3:55 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> [...]
> This commit introduces a new iteration primitive for references: a
> ref_iterator. A ref_iterator is a polymorphic object that a reference
> storage backend can be asked to instantiate. There are three functions
> that can be applied to a ref_iterator:
>
> * ref_iterator_advance(): move to the next reference in the iteration
> * ref_iterator_abort(): end the iteration before it is exhausted
> * ref_iterator_peel(): peel the reference currently being looked at
> [...]
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> @@ -249,6 +249,199 @@ int rename_ref_available(const char *oldname, const char *newname);
> +/*
> + * Advance the iterator to the first or next item and return ITER_OK.
> + * If the iteration is exhausted, free the resources associated with
> + * the ref_iterator and return ITER_DONE. On errors, free the iterator
> + * resources and return ITER_ERROR. It is a bug to use ref_iterator or
> + * call this function again after it has returned false.
> + */

Either:

    s/false/something other than ITER_OK/

or:

    s/false/ITER_DONE or ITER_ERROR/

> +int ref_iterator_advance(struct ref_iterator *ref_iterator);
> +
> +/*
> + * An iterator over nothing (its first ref_iterator_advance() call
> + * returns 0).
> + */

s/0/ITER_DONE/

> +struct ref_iterator *empty_ref_iterator_begin(void);
> +
> +/*
> + * Return true iff ref_iterator is an empty_ref_iterator.
> + */
> +int is_empty_ref_iterator(struct ref_iterator *ref_iterator);

I can see that you used this function as an optimization or
convenience in overlay_ref_iterator_begin(), but do you expect it to
be generally useful otherwise? Is it worth publishing? Do you have
other use-cases in mind?

Also, can you explain why the merge iterator doesn't also perform the
optimization/convenience of checking if one iterator is an empty
iterator?

> +/*
> + * Iterate over the intries from iter0 and iter1, with the values

s/intries/entries/

> + * interleaved as directed by the select function. The iterator takes
> + * ownership of iter0 and iter1 and frees them when the iteration is
> + * over.
> + */
> +struct ref_iterator *merge_ref_iterator_begin(
> +               struct ref_iterator *iter0, struct ref_iterator *iter1,
> +               ref_iterator_select_fn *select, void *cb_data);
> +
> +/*
> + * An iterator consisting of the union of the entries from iter0 and
> + * iter1. If there are entries common to the two sub-iterators, use
> + * the one from iter1. Each iterator must iterate over its entries in
> + * strcmp() order by refname for this to work.
> + *
> + * The new iterator takes ownership of its arguments and frees them
> + * when the iteration is over. As a convenience to callers, if iter0
> + * or iter1 is_empty_ref_iterator(), then abort that one immediately
> + * and return the other iterator directly, without wrapping it.
> + */
> +struct ref_iterator *overlay_ref_iterator_begin(struct ref_iterator *iter0,
> +                                               struct ref_iterator *iter1);

When reading about the overlay iterator (both code and documentation),
my expectation was that iter0 would shadow iter1, not the other way
around as implemented here. Of course, that's entirely subjective, but
the generic names don't provide any useful clues as to which shadows
which. Perhaps giving them more meaningful names would help.

> +/*
> + * Wrap iter0, only letting through the references whose names start
> + * with prefix. If trim is set, set iter->refname to the name of the
> + * reference with that many characters trimmed off the front;
> + * otherwise set it to the full refname. The new iterator takes over
> + * ownership of iter0 and frees it when iteration is over. It makes
> + * its own copy of prefix.
> + *
> + * As an convenience to callers, if prefix is the empty string and
> + * trim is zero, this function returns iter0 directly, without
> + * wrapping it.
> + */
> +struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
> +                                              const char *prefix,
> +                                              int trim);

Minor: Similarly, when reading the code and documentation, I wondered
why this was named 'iter0' when no 'iter1' was in sight. Perhaps name
it simply 'iter'.
