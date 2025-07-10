Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95E18BC3D
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191793; cv=none; b=m+LpQBxXIsUyCdUqgR3hkL5+Ij4D/aQ5/j5cEpl63Gd/I2gV0i8/mtr3TyVNyfX/tw3avyLuL6KV3j4gAbDi/khW07Gl+28VvW/p2VwG+gBeYXMnvmIV8UreBQbM+QuxHuGg2pSFUBkv7x/Gl9bQonBAHYwdq228M7hDWD+zuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191793; c=relaxed/simple;
	bh=Ql9BHubipGQSKGgeWZ6JxtqlYoKc8zqGfuU9latNois=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBQ30eJ4CTgtwLjngsR+CXVyz4Gj/rQooxC1j9fTmHnOdObqWZt/0MH/+GSS0dzKQFBqpS5JovRGIuBXEZnR206/I3IZBn55IPGfMWrhAajfjI+B8dofvfTlDDqkPsAnRHk60e2Y2TY+lQ1kp8ou/+2AcFNojyb2X7UHQcFlQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=k006Emc+; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="k006Emc+"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e812fc35985so1336087276.0
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752191790; x=1752796590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb9NfbnsjbYwn1240S7mRLp2LjMVRCRhajz6ny0Ug64=;
        b=k006Emc+QaSAnosxaqs5SfEySQYLRtD3cYU0gt5CSWnR0plKLHldqLpPsOT5oAF9jZ
         ACgKrhk6uNTg96szx3NHKNAjb7cKORZFtcMkpUkJLNcDeOs+wjOjCMGW0wbrOpUDmC/2
         UEWVwKp+GIgQ/BVq/Zwjkynz+KqUDkPLiwFHakNXx82p1ccm3aEQ8ym2oGEIXLgX+8Zk
         eUDsZ3TiyvAThSMwnl4LGITHIBqhgGwQ+UOr8UOre1yxlsiEICXzYDWADznu0nHOBUpU
         B9dearYE9fMv3bTYqRTBmfbZhM/DafINSsU3puN5lHBjinyDSyGRFwKCQgKC3YbmlBSu
         ki6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191790; x=1752796590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mb9NfbnsjbYwn1240S7mRLp2LjMVRCRhajz6ny0Ug64=;
        b=Dwt5WcsP2iF0cMOb4SfbnuIraWP4wIhERHR4NqEWfUsX1eMaBNSlniApBkPF0yDnbo
         bDJEHgTHcEFmRrS+jO/BKTa/hgHsUhf26XbeindyQChHPA4prKaUdrBdACinZrwNFNTa
         motACQniOiY+3JpkF18WMA0//Kl68cMmaFyQ31eYOHEQsx7MrHxoc7EErNbCQtSgd5Vg
         b406WR9HAhqat8LlfVOGc125lRQM0X/t+I8owHSCXAepQsgMEG6ZoED7bJE72A9/Cact
         g9qOsL5ZpdJGr5zQDW+g8asqBchu2UhfY4naY+LhnTf0KJGPlS1kUu0pxyZ/1SjHmLfj
         MpNA==
X-Gm-Message-State: AOJu0Yy7BFkE3fqmOVFPbuBXCcfJz8Rwjc4LVaKMzmsutI5pojO4LiBx
	UNHifrAIdSX8lmXuee16NcXRJ6+oYwhXDvcbAwBinSysF00Uqbn1UFqhSK3Ba3VBpNU=
X-Gm-Gg: ASbGnctwn+cGOwsbF1+1Dl83S0REKeMXlrBtrio6EpVPm53T0NFAA/aMQYU/GEhmhuF
	xTmR99cjei8GHFwGXFLqNlIOJK5S/13D8WezEEUNmNzmxJXDZwiMUSDeMJYztDsoQWiYHpcLHI8
	n5N6SqueBJWxP2aJQkW1M+eqjGw0cYJ7XCGWx4QbYoauLdj0b0kPAbINkNIHzdrjBi2bpkfifiE
	Q1jirW6oeE4I2aSvbzbI7bVbI8WhhAZli/8CwgkS+SCAW3jzUNoF3dVMQZYOmAsDFlmmfxGFJPN
	XtdE52vDEGmgvvsoDV7fp+CLWDkgniPBz/whcZxV7BoIMLSz2PWNlMM6Y741DlLZgMM95Kk3J2Y
	ht7qHC+o1KClOYzbQ1vKwKbSck8PcdJg9g6KJDtideToeVYCFzfGFrbn8KW8xasoi/qZrjw==
X-Google-Smtp-Source: AGHT+IFYYYZL07Tc0Gqwung21yco9kEnzUxJevKlBTmLQaILd62ECd4TqNydRJS/Mr33D32G6ssFEA==
X-Received: by 2002:a05:6902:6a8a:b0:e84:4b7f:5b67 with SMTP id 3f1490d57ef6-e8b85a08f8amr1035344276.1.1752191790081;
        Thu, 10 Jul 2025 16:56:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8b7afccb9csm737365276.41.2025.07.10.16.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:56:29 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:56:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] packfile: refactor `get_multi_pack_index()` to work
 on sources
Message-ID: <aHBTLFvL+eQcw6J0@nand.local>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-5-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-5-f31150d21331@pks.im>

On Wed, Jul 09, 2025 at 09:54:53AM +0200, Patrick Steinhardt wrote:
> The function `get_multi_pack_index()` loads multi-pack indices via
> `prepare_packed_git()` and then returns the linked list of multi-pack
> indices that is stored in `struct object_database`. That list is in the
> process of being removed though in favor of storing the MIDX as part of
> the object database source it belongs to.
>
> Refactor `get_multi_pack_index()` so that it returns the multi-pack
> index for a single object source. Callers are now expected to call this
> function for each source they are interested in. This requires them to
> iterate through alternates, so we have to prepare alternate object
> sources before doing so.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/pack-objects.c |  9 ++++++---
>  builtin/repack.c       |  4 ++--
>  midx-write.c           | 22 ++--------------------
>  object-name.c          | 21 ++++++++++++++-------
>  pack-bitmap.c          | 20 ++++++++++++++------
>  packfile.c             | 30 +++++++++++-------------------
>  packfile.h             |  3 +--
>  7 files changed, 50 insertions(+), 59 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 5781dec9808..f889e69e07d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1701,7 +1701,6 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
>  {
>  	int want;
>  	struct list_head *pos;
> -	struct multi_pack_index *m;
>
>  	if (!exclude && local && has_loose_object_nonlocal(oid))
>  		return 0;
> @@ -1721,9 +1720,13 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
>  		*found_offset = 0;
>  	}
>
> -	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
> +	odb_prepare_alternates(the_repository->objects);
> +
> +	for (struct odb_source *source = the_repository->objects->sources; source; source = source->next) {
> +		struct multi_pack_index *m = get_multi_pack_index(source);

All makes sense up to this point. I would suggest adding the following
to the top of this function:

    struct repository *r = the_repository;
    struct odb_source *source;

to shorten up these lines a bit, but I'm nit-picking so if you feel
strongly that the existing patch is clearer, I won't object.

>  		struct pack_entry e;
> -		if (fill_midx_entry(the_repository, oid, &e, m)) {
> +
> +		if (m && fill_midx_entry(the_repository, oid, &e, m)) {

Good.

>  			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
>  			if (want != -1)
>  				return want;
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 9bbf032b6dd..5956df5d927 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -218,9 +218,9 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
>  static void remove_redundant_pack(const char *dir_name, const char *base_name)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	struct multi_pack_index *m = get_local_multi_pack_index(the_repository);
> +	struct multi_pack_index *m = get_multi_pack_index(the_repository->objects->sources);

Is the first source always guaranteed to be the local one? I assume that the
answer here is "yes", and there are certainly other places in the code
where we make a similar assumption. But just wanted to make sure as
this popped into my head while reading.

>  	strbuf_addf(&buf, "%s.pack", base_name);
> -	if (m && midx_contains_pack(m, buf.buf))
> +	if (m && m->local && midx_contains_pack(m, buf.buf))

...hmm, maybe not?

>  		clear_midx_file(the_repository);
>  	strbuf_insertf(&buf, 0, "%s/", dir_name);
>  	unlink_pack_path(buf.buf, 1);
> diff --git a/midx-write.c b/midx-write.c
> index f2cfb85476e..c1ae62d3549 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -916,26 +916,8 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
>  static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
>  							const char *object_dir)
>  {
> -	struct multi_pack_index *result = NULL;
> -	struct multi_pack_index *cur;
> -	char *obj_dir_real = real_pathdup(object_dir, 1);
> -	struct strbuf cur_path_real = STRBUF_INIT;
> -
> -	/* Ensure the given object_dir is local, or a known alternate. */
> -	odb_find_source(r->objects, obj_dir_real);
> -
> -	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
> -		strbuf_realpath(&cur_path_real, cur->object_dir, 1);
> -		if (!strcmp(obj_dir_real, cur_path_real.buf)) {
> -			result = cur;
> -			goto cleanup;
> -		}
> -	}
> -
> -cleanup:
> -	free(obj_dir_real);
> -	strbuf_release(&cur_path_real);
> -	return result;
> +	struct odb_source *source = odb_find_source(r->objects, object_dir);
> +	return get_multi_pack_index(source);

When I first read this I wondered what would happen if we passed in an
unknown object_dir such that odb_find_source() returned NULL. But that
function will never return NULL, and instead will die() if given a bogus
object_dir.

So this is fine, though I would have imagined that we'd return NULL
within odb_find_source() and let the caller die() (or not).

>  }
>
>  static int fill_packs_from_midx(struct write_midx_context *ctx,
> diff --git a/object-name.c b/object-name.c
> index ddafe7f9b13..1e7fdcb90a8 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -198,16 +198,19 @@ static void unique_in_pack(struct packed_git *p,
>
>  static void find_short_packed_object(struct disambiguate_state *ds)
>  {
> -	struct multi_pack_index *m;
>  	struct packed_git *p;
>
>  	/* Skip, unless oids from the storage hash algorithm are wanted */
>  	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] != ds->repo->hash_algo))
>  		return;
>
> -	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
> -	     m = m->next)
> -		unique_in_midx(m, ds);
> +	odb_prepare_alternates(ds->repo->objects);
> +	for (struct odb_source *source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
> +		struct multi_pack_index *m = get_multi_pack_index(source);
> +		if (m)
> +			unique_in_midx(m, ds);
> +	}
> +

Makes sense, though now having seen this pattern a few times, I am
wondering if it would be worth it to add a utility function that takes a
callback and iterates over the various MIDXs. But perhaps that is taking
DRY-ing things up a little too far ;-).

For what it's worth, I do think that what you wrote here makes more
logical sense: MIDXs are tied to individual alternate object DBs, which
here means that there is one MIDX per "struct odb_source". It just is a
little more verbose to type out.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 0a4af199c05..7b51d381837 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -692,14 +692,16 @@ static int open_midx_bitmap(struct repository *r,
>  			    struct bitmap_index *bitmap_git)
>  {
>  	int ret = -1;
> -	struct multi_pack_index *midx;
>
>  	assert(!bitmap_git->map);
>
> -	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
> -		if (!open_midx_bitmap_1(bitmap_git, midx))
> +	odb_prepare_alternates(r->objects);
> +	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
> +		struct multi_pack_index *midx = get_multi_pack_index(source);
> +		if (midx && !open_midx_bitmap_1(bitmap_git, midx))
>  			ret = 0;
>  	}

Makes sense.

> +

Stray diff?

> @@ -3307,9 +3309,15 @@ int verify_bitmap_files(struct repository *r)
>  {
>  	int res = 0;
>
> -	for (struct multi_pack_index *m = get_multi_pack_index(r);
> -	     m; m = m->next) {
> -		char *midx_bitmap_name = midx_bitmap_filename(m);
> +	odb_prepare_alternates(r->objects);
> +	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
> +		struct multi_pack_index *m = get_multi_pack_index(source);
> +		char *midx_bitmap_name;
> +
> +		if (!m)
> +			continue;
> +
> +		midx_bitmap_name = midx_bitmap_filename(m);

This one looks good as well.

> diff --git a/packfile.c b/packfile.c
> index e5d9d7ac8bc..e1ced050451 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -963,14 +963,17 @@ static void prepare_packed_git(struct repository *r);
>  unsigned long repo_approximate_object_count(struct repository *r)
>  {
>  	if (!r->objects->approximate_object_count_valid) {
> -		unsigned long count;
> -		struct multi_pack_index *m;
> +		unsigned long count = 0;
>  		struct packed_git *p;
>
>  		prepare_packed_git(r);

I was wondering where the odb_prepare_alternates() call was in this one,
but it is a byproduct of calling prepare_packed_git(). So this spot
looks OK as well.

> -		count = 0;
> -		for (m = get_multi_pack_index(r); m; m = m->next)
> -			count += m->num_objects;
> +
> +		for (struct odb_source *source = r->objects->sources; source; source = source->next) {
> +			struct multi_pack_index *m = get_multi_pack_index(source);
> +			if (m)
> +				count += m->num_objects;

Unrelated to your patch, I wonder if it makes sense to check for
overflow here. I think so, though presumably if we are overflowing
"unsigned long" then likely we have much bigger problems to worry about
;-).

The rest looks good to me.

Thanks,
Taylor
