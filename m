Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8718893C
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132936; cv=none; b=k0myBSXObOshdeDGopauhy80Q0Pv0faavF7KaRrMDmn8qX++ro0aHDm279SCmZOn1omAK+1I6lKu8ETNxp53MVVCXcI3pvmQ3pvGuJU0bqtVBtqMayhszeZL9YAvbTqkuKaHNPDQKO1nY8U26d4jqnaKUKWjZelwYQsMVEjarKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132936; c=relaxed/simple;
	bh=K/HRup7pda3NRsvxFWPwi/2ZylE6vzA65t+GERyfnr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBtSNnvtfC1vsz/roHUhWyuJPHV1RB8Xk8llhR4AVRfItUz//2dbrwT2IR3gtmF8mmRNXQzBlDgQEVO/Xjy7EZaa315s9Ct72guzO1wfHhgIra16jAel4E67pbqgRjBdoT/MHi9hUSnuRZhN14giryUeT6rb9ZiEGupK4dykmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=R4USPBbb; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="R4USPBbb"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e9f8dec3daso10053967b3.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730132933; x=1730737733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eVeNPKj1SM+500Gwy8CWS7Z3ERfmd4loyglryC2Ybo=;
        b=R4USPBbbJpJavpF1KV5mMY4GK/uOt4c+0TukiyTXT6uZqI34dQJkB8k0AykHbIt3/S
         z1FzgGXReHNQxOC0TvLRirW/MPPAAlS5XMPC6IMb4aggnkKmJw1ev3eGJbq/viVumZh+
         qL5V+QxzHF+WDaL7wVy45UM/jiJLHPAuBVEUUO6Bs4So4jBjWSU4+4JGzWlgawdsmlu3
         w0oo+D8mxbxhsoODZDbxJV/BRNexv1dbql3O5non8fL44NY+cOs+aSmEzZMw5dc1OOqD
         IbXaFKiAwmFXVN99sLYDs/c90UBoIX64WammKx+t80fYHGaJkMXjx/gpQLkzHAzpyAKY
         fBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730132933; x=1730737733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eVeNPKj1SM+500Gwy8CWS7Z3ERfmd4loyglryC2Ybo=;
        b=GMCZfiL7ULNwCvrC1xAEICJRqFuTe3KrjMAxdbhgTW8CF1jTE1RDJ9pGCefpUoq4tF
         xjzc/Qfn6I9oDWlN7SkhN8FgLwKDJtEzsiwEgsFBMQxcMneUqXlfekhggl1g7PHEBq7+
         sjPCzAZAO3XuLM1nswYRkZgLKCy8ofWYTbfIT8DqVfG/UUIVjUe4SkW00ZGbNK7UQJqm
         JcZgLmpAeAh+i241dEDzLK6tABqaF2advgOObGRdj25U6lPaDmlykXoPoNNelCuPrGR0
         7FWJr5OvtKTi+fS9vsh2yBewL0k/FbFWV6V8kPyGP3qKu5BoF3CA/hXE1fzZFqXoaU+F
         8Hhw==
X-Gm-Message-State: AOJu0YwiBAOegvrRp8ANQM2D1i4IkwygmHC6JMfK2dNRPAvr0a25nu9o
	sp1aitH4p1Hv4yR2lDxlZbNslN1eIEE3KUmMZZ546rHMKAUrx21ICctsAEcBo+k=
X-Google-Smtp-Source: AGHT+IF4Q83wtYHk5vF2B18aQMw5aOo1sX+bjA0V867qKpjcDAn5mIWGUtKxsjDYYyJSscJL14yYhQ==
X-Received: by 2002:a05:690c:93:b0:6e2:c962:75e with SMTP id 00721157ae682-6e9d8aa4138mr84816257b3.32.1730132932672;
        Mon, 28 Oct 2024 09:28:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c7b4efsm14937767b3.89.2024.10.28.09.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:28:52 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:28:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/8] packfile: pass down repository to
 `has_object[_kept]_pack`
Message-ID: <Zx+7wTYEkrKGIIR1@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <4e883a4d1ccabb35cc6d122f23a475fca0d71ce1.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e883a4d1ccabb35cc6d122f23a475fca0d71ce1.1730122499.git.karthik.188@gmail.com>

On Mon, Oct 28, 2024 at 02:43:43PM +0100, Karthik Nayak wrote:
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 0800714267..2b2816c243 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1529,7 +1529,7 @@ static int want_found_object(const struct object_id *oid, int exclude,
>  			return 0;
>  		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
>  			return 0;
> -		if (has_object_kept_pack(oid, flags))
> +		if (has_object_kept_pack(the_repository, oid, flags))

Do we want to use p->repo here instead of the_repository? I think the
answer is "yes" since in this function we are given a pack "p" and want
to determine if the given object contained in "p" is useful to pack. If
not, we want to search for it among other packs here, likely within the
same repository.

(Again, probably a moot point here since this is all going to be
the_repository anyway, but just thinking aloud...).

>  	}
>
> @@ -3627,7 +3627,7 @@ static void show_cruft_commit(struct commit *commit, void *data)
>
>  static int cruft_include_check_obj(struct object *obj, void *data UNUSED)
>  {
> -	return !has_object_kept_pack(&obj->oid, IN_CORE_KEEP_PACKS);
> +	return !has_object_kept_pack(the_repository, &obj->oid, IN_CORE_KEEP_PACKS);

Here we don't know what pack "obj" is contained in, which makes sense
since this is a traversal callback, not something that is iterating over
the contents of a particular pack or similar. So using the_repository is
right here.

Although... should we be using to_pack->repo here over the_repository
(in builtin/pack-objects.c)? The rest of the code definitely does *not*
do that, but I think probably should.

>  static int cruft_include_check(struct commit *commit, void *data)
> diff --git a/diff.c b/diff.c
> index dceac20d18..1d483bdf37 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4041,7 +4041,8 @@ static int reuse_worktree_file(struct index_state *istate,
>  	 * objects however would tend to be slower as they need
>  	 * to be individually opened and inflated.
>  	 */
> -	if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
> +	if (!FAST_WORKING_DIRECTORY && !want_file &&
> +	    has_object_pack(the_repository, oid))
>  		return 0;
>
>  	/*
> diff --git a/list-objects.c b/list-objects.c
> index 985d008799..31236a8dc9 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -41,7 +41,8 @@ static void show_object(struct traversal_context *ctx,
>  {
>  	if (!ctx->show_object)
>  		return;
> -	if (ctx->revs->unpacked && has_object_pack(&object->oid))
> +	if (ctx->revs->unpacked && has_object_pack(ctx->revs->repo,
> +						   &object->oid))
>  		return;
>
>  	ctx->show_object(object, name, ctx->show_data);
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 4fa9dfc771..d34ba9909a 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1889,7 +1889,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
>  		bitmap_unset(result, i);
>
>  	for (i = 0; i < eindex->count; ++i) {
> -		if (has_object_pack(&eindex->objects[i]->oid))
> +		if (has_object_pack(the_repository, &eindex->objects[i]->oid))

Interesting. I think the_repository in practice is fine here, but I
might have expected something like bitmap_git->p->repo, or the
equivalent for the MIDX case.

So I was going to suggest something like:

    static struct repository *bitmap_repo(const struct bitmap_index *bitmap_git)
    {
        if (bitmap_is_midx(bitmap_git))
            return bitmap_git->midx->repo;
        return bitmap_git->pack->repo;
    }

and then rewriting this as:

    if (has_object_pack(bitmap_repo(bitmap_git), &eindex->objects[i]->oid))

, but we can't do that, because the MIDX structure does not know what
repository it belongs to, only the object_dir it resides in!

And I think that causes wrinkles earlier in your series that I didn't
think of at the time when reviewing, because it seems odd in retrospect
that, e.g. we have something like:

    load_multi_pack_index(the_repository->objects->odb->path, ...);

where we pass in the object_dir path directly, but other functions like
prepare_midx_pack() that take in a 'struct repository *'.

I wonder if we should be initializing the MIDX with a repository
pointer, so that it knows what repository it belongs to. I suspect that
we will still have to pass in a separate string indicating the
object_dir, likely because of the --object-dir quirk I mentioned
earlier.

But my main thought here is that we should be able to infer from a
'struct bitmap_index *' what repository it belongs to instead of using
'the_repository' here directly.

The rest all looks quite reasonable to me.

Thanks,
Taylor
