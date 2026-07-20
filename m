Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC1449B32
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591639; cv=none; b=V0R/kU1bRHipupSHIM785poJXEQSzmglTYmoslOFFZGCq1wk31ezydwOFle7OuLX46iyrbT1mXZOTT/51Raplt27Sx/TT6+nKv81bXVjcgU+wT202+W0vrkRYTwMLjFDq4xfQxTRP7y3leYRkPqB49tOlp1ZxaBcrSPuNmJJ2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591639; c=relaxed/simple;
	bh=54TYQ6cVabKYiBWHREgct+AekWDik59QxpZJ9c/j5PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ1mTdXC/C3mCmx+KlJVxDnW2CLDFmF3m+65WztRZbswjVaPVyN8K7H4Mp8grVONc7ipjy8hNPYs/dUVORUqwl/GmlV6uub+AMOv2fGEFeKWuh+uR8wdPC+GJlxoKMgWLEoDVI1eYx6b7fW/ccqPq7b8oPMkVLuyNMQYjtlMB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=eGOZHDUM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="eGOZHDUM"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81ea0b7d137so88818287b3.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 16:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784591637; x=1785196437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ChPSi2iGFuka2IloqYiC8iXQmJjKm5hBjZpdOGEaidY=;
        b=eGOZHDUMjvSnGLvT7ZHY6BNPYc/B5lskAeBXB1Zf+CgLA5oZrYbIaCRXmF+MY+KuHU
         /HfIltSPqlSGQx4psKOvrpIRFihxrrpOs1RJ+hsNC22fMNnBgiRpov3jPXFID99903F4
         5G7EI5aQOJv9miMnAIAgPfe+rMVBkqTJaBxDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784591637; x=1785196437;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ChPSi2iGFuka2IloqYiC8iXQmJjKm5hBjZpdOGEaidY=;
        b=d/RZjt4VIuX0H7QhL+4JkaKw7og8aYoKEW6UZy2ZIi/5qF4eKxuXPIb3E7+bdsc22U
         4cXIofKHqUuDuuOEqiQHD7oXAPdfoiBhzW8waWiCLa9b1+nmXYF8luNkOTBol6RRuKgy
         YcYFfAPUrHbhmce3+EHzLK5coZjnIVMNf5PnsCzVgclaLXDdYv3EEFs+o4d57Dcw/uQb
         OdevP/OOCMG05HgeBPIZLs0EZ4EyKaWdrZSqjeF9IVjaIwJGLMvI0O38DxipzoirYv4a
         xRUJQ2dDYpMRpp2yHqGxsQVYQUB+bnMA16DSA02eJzvJlnzemMYg9NhMNOLhTzwz/CoI
         eAWQ==
X-Gm-Message-State: AOJu0YziKprdmFj52C2MpSojngncTB2msVASwfrzjVHcKkFn4hxrwH0E
	G5/5qbpYRF92nE008BME63xznnPvnhsocBV9XV5OxzH9NT392sAY+RH1HfBy4OJz9AA=
X-Gm-Gg: AR+sD10/iALXfNUuey6OlpYsf/5S8gaqGc3706BCSAfPebzLh8cx/yCSmoHYT8W8loS
	0bvWp+p7Hxad96SSA1/bSGK7Xid3HznXpUU2r4H/rXG9tsRNleUlJnaYrvXzSKto0mU/1ALN/sH
	oHRVp3GDtCBF9BJ3vFjnwUOesxwGC9+xC8Ko6qw0CVuDnGSX163TEBaDnp3QTtjsPrPl0B5OMy+
	HAuRBuMu/HCZCQs6cI9iCRcmmKd3W+zjVsVVAg6iyKcFPcwUc+FslxQdAeAdGD0nQLlIAu3UceE
	Lh6k51wIbhgbhmDQzq0ngDrZYuhCz3GNx/+ZVBLUymSVnuTqscqeE1aZ9QzjNt88thdD72G5Tn+
	hApP7ZPbLAYpgEFRB6FbW01O7eoEmt59tfP2w7cTlNnaav9t1qAMbdijJFyb+8pkTOaOuPJBw84
	IIQ1YhHbhUoJ+35gofXTmMQ9l00930YAWuP/1hJsEmRAv6sM6kkXEBnA6zpd+DbvIi4iem7w==
X-Received: by 2002:a05:690c:6d08:b0:80e:ff00:47a with SMTP id 00721157ae682-81ef2787970mr57383987b3.30.1784591637020;
        Mon, 20 Jul 2026 16:53:57 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42acf2esm56971537b3.33.2026.07.20.16.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 16:53:56 -0700 (PDT)
Date: Mon, 20 Jul 2026 18:53:53 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: tnyman@openai.com
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/2] pathspec: use match for sparse-index expansion checks
Message-ID: <al61ERa3fS2MerHp@com-79390>
References: <20260720223118.62821-4-tnyman@openai.com>
 <20260720223118.62821-5-tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720223118.62821-5-tnyman@openai.com>

On Mon, Jul 20, 2026 at 03:31:20PM -0700, tnyman@openai.com wrote:
> Using `item.original + item.nowildcard_len` in
> `pathspec_needs_expanded_index()` can therefore read past the end of
> the allocation. AddressSanitizer reports a heap-buffer-overflow for
> prefixed wildcard pathspecs passed to `git rm` and `git reset` with a
> sparse index.
>
> The mismatch dates back to 4d1cfc1351 ("reset: make --mixed
> sparse-aware", 2021-11-29), which introduced the helper using
> `item.original`. b29ad38322 ("pathspec.h: move
> pathspec_needs_expanded_index() from reset.c to here", 2022-08-07)
> later moved it to `pathspec.c` and preserved the affected comparisons.

Nice find. I can reliably reproduce the ASan failure you described above
like so:

    repo=$(mktemp -d /tmp/pathspec-asan.XXXXXX)
    trap 'rm -rf "$repo"' EXIT

    git init "$repo"

    cd "$repo"

    mkdir -p deep outside
    : >deep/a
    : >outside/file
    git add .
    git commit -q -m base

    git sparse-checkout init --cone --sparse-index
    git sparse-checkout set deep

    # From deep/, match is "deep/a*" while original is only "a*".
    git.compile -C deep reset HEAD -- 'a*'

(where 'git.compile' points at my build, which in this case was compiled
with "make SANITIZE=address"), and results in

    ==89470==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x602000001f36 at pc 0x000106a69430 bp 0x00016b07c530 sp 0x00016b07bce0
    READ of size 1 at 0x602000001f36 thread T0
        #0 0x000106a6942c in strspn+0x3f0 (libclang_rt.asan_osx_dynamic.dylib:arm64e+0x1942c)
        #1 0x0001054a35b0 in pathspec_needs_expanded_index pathspec.c:850
        #2 0x000104fe6c24 in read_from_tree reset.c:214
        #3 0x000104fe5774 in cmd_reset reset.c:495
    [...]

It made me wonder whether or not this bug was trigger-able back in
4d1cfc1351. After checking out that version, I re-ran the same script
and got an identical buffer overflow in the 'strspn()' call.

Applying your patch and repeating the same steps results in a clean
exit.

> diff --git a/pathspec.c b/pathspec.c
> index f78b22709ccb67..281858f21f9c59 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -847,9 +847,9 @@ int pathspec_needs_expanded_index(struct index_state *istate,
>  			 * - not-in-cone/bar*: may need expanded index
>  			 * - **.c: may need expanded index
>  			 */
> -			if (strspn(item.original + item.nowildcard_len, "*") ==
> +			if (strspn(item.match + item.nowildcard_len, "*") ==

OK. The comment above is elided from the diff context, but is useful
IMHO during review. Here we want to make sure that the remaining
wildcard-ed portion of the pathspec element is only "*", which may need
to expand the index only if we are not inside of the existing sparse
checkout.

But 'item.nowildcard_len' bytes ahead of 'item.original' may (at worst)
point into uninitialized memory, or (at best) point at a portion of the
string that is not in fact a wildcard (even if the pathspec item would
not otherwise require us to expand the sparse checkout).

So this makes sense.

>  				    (unsigned int)(item.len - item.nowildcard_len) &&
> -			    path_in_cone_mode_sparse_checkout(item.original, istate))
> +			    path_in_cone_mode_sparse_checkout(item.match, istate))

Likewise. Here I think we *might* actually be OK, but I haven't read
'path_in_cone_mode_sparse_checkout()' to know whether that's (a) true,
and (b) if so, whether it's true by accident or intention.

Regardless, 'item.match' makes sense here as well for the same reason.
Likewise with the rest of the patch.

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 9814431cd74aff..d0b42371663f9d 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2119,6 +2119,13 @@ test_expect_success 'sparse index is not expanded: rm' '
>  	ensure_not_expanded rm -r deep
>  '
>
> +test_expect_success 'sparse index is not expanded: prefixed wildcard pathspec' '
> +	init_repos &&
> +
> +	ensure_not_expanded -C deep rm --dry-run -- "a*" &&
> +	ensure_not_expanded -C deep reset base -- "a*"
> +'

Looks good, this is effectively the same thing as I ran in the
reproduction script above.

Thanks,
Taylor
