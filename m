Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3102BD59A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189012; cv=none; b=a5z0sE3ElY4DAi7zpVxo19S3lrezNqQ2d3LzMM67fESoXAShnMqC1e8b1d4zl/MKfX6FxWP6p4dm5ERV+UQCorhvNV51O0g6Ac7l+dcLgzP8XWUOwlrHlXmUHmfuWSIlVJh7BMFKjQHqCF4bdMYlUIC7/W/uk1gVaRj2ihYTNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189012; c=relaxed/simple;
	bh=btGLW6FTFzs1ARq6w1JiG4cFc2XaD4YY2NuHFtIwfB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTwWBvFoehfnIkzLN+4BT2mI6zvlPcbRcCaAnGiSrSSkqw1DZd/EFZFuo50g3D1he9IQBl4ouGpOojKyxlqTlB/FdiMHhCJIHBW3fE1fwIBYihwz/j1Q+alIQ8/N/y6ocQ1HsxxCTtlwokhjUGfTr2qC8kuudiVJKVHDGAS6024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IxEMeGM8; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IxEMeGM8"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e73e9e18556so1650396276.0
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752189009; x=1752793809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKcRD/5K3R8djOA0zQ5ew80IOauMKn37Ujrppb5d6Wo=;
        b=IxEMeGM88HRflcNk9jPyk1iQV/wgoZxzz+Xtsdfu7NudX4/UP+rrRnkO7iljWm/+Hc
         gZAR+2CRXtEurGxmSCJFsLXs3SCtLp1LALl8ZUiDeynDS0YZv36FE6d/TolPNAMm1KSW
         pvobTbyoD3zdkFriYMqojwLFGHukIaWA4WREL4FI6Nq2RhLxJTtavr3JKPgOdfxcDb4Y
         nxhOYmDRShEc1dfzt45WhkQNDUY9qy/uok5JLu5Uwg2JrppRngpzJbzr3IX+5103Z87G
         tJusMaQTar2eux9AVMX5SuFg+LLBDon/ZnAJi3g4OeGG7xtLe/mADJtNxY6UjF7C+a5j
         L4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752189009; x=1752793809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKcRD/5K3R8djOA0zQ5ew80IOauMKn37Ujrppb5d6Wo=;
        b=jwifsF34g/9/3oosnGmwD5GMn0DW1IBAF3mtQMdvSff/6BY59MkMSqScOnZP7qd8Pg
         9c7osrl59R4BbKC9ODgeNbgvhwrE6EGGgqRA7b9FZbaSu50Sa5k8S+f9lO8tL7733KIf
         2KWQqepwidwgkJOvqwo5oY6IzfHSshr4QbJq7Em8tI3e8k2dXfdA46HtQJ7sXrcSED/p
         IunHcvx1UlJC3fSg1Hc/kPxlOARkXN1QCpq/d3BnmDOquMXjlk86faNf3HGlJS3e0R68
         KNMp6HgVWUPSh9DXuTF/odP/5xavuGm6nbICqT6gPYsDCnSflcuJHHM6gc+IGwBLPJY3
         IJzw==
X-Gm-Message-State: AOJu0YybOkLLzN6paFCkul7IqI89ipRVh/T0UrCtR5BIm7HjMz6DxjsV
	5Qk8qDKjLXjzdGxb/W1/k5bdWcQWWZCssBvXMjo+lAWzJz8G8BwQUliDqrTf/DeKNLEldVjWwY2
	GBpQz574=
X-Gm-Gg: ASbGncsl5BrMS8Fbe5yzU0xXrQDw9epvoLTp6AF1swHYEPRL3694Zt3HHX3l6Fr36/y
	ESpCOVXb7z1SYkvN7fUv4N52yGctBqwnlf9yiRa4nAJvVRD4AFG1886AyABIN+OqvpmTx593L5U
	4JY5v5RtMF1WuakQS3z0jfDF4PqlG1oKrZH5N+nns9JA3FVCtESL5Fmw83wQv66Bc5kAcLZXulS
	G6iubQ22jKOtdWnFHP1iqpiQVjt218ArkwLKdRj95PNaPDMLSVNOSm719EHStFAasm9Y8YumtWV
	8Muy92qfbBpltQbAvXp8D3r455IQknb92vpAFRj7xgT1Mo/MDhCBrqEnbGp0H2eclZ8bpmi+kER
	qEGDLyUuqYPGToryAT5guqBEEQXIF61FVqlDQfCbOmth5eSpVXZCJWEMAixqNy5d+fxDzsQ==
X-Google-Smtp-Source: AGHT+IG3M4P4iBJtvqWqq0HTnOE+ASanXoS09P3m+Fsr3RUnIK5ZeK4sWlIYY0ZgQ4SUqtY7iGvCbw==
X-Received: by 2002:a05:6902:2b92:b0:e84:4722:1853 with SMTP id 3f1490d57ef6-e8b8521ba76mr1548357276.17.1752189008582;
        Thu, 10 Jul 2025 16:10:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8b7ae29ac3sm731752276.5.2025.07.10.16.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:10:08 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:10:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] midx: start tracking per object database source
Message-ID: <aHBISjW/OErOy3Cp@nand.local>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-1-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-1-f31150d21331@pks.im>

On Wed, Jul 09, 2025 at 09:54:49AM +0200, Patrick Steinhardt wrote:
> Multi-pack indices are tracked via `struct multi_pack_index`. This data
> structure is stored as a linked list inside `struct object_database`,
> which is the global database that spans across all of the object
> sources.
>
> This layout causes two problems:
>
>   - Multi-pack indices aren't global to an object database, but instead
>     there can be one multi-pack index per source. This creates a
>     mismatch between the on-disk layout and how things are organized in
>     the object database subsystems and makes some parts, like figuring
>     out whether a source has an MIDX, quite awkward.

This is a little confusing to me. What do we consider to be an "object
database", and what do we consider to be a "source"?

For instance, if I have a repository with one or more alternates, I
would imagine that each alternate is a separate "source", and the
sources together comprise the object database. Does that match the way
you're thinking about it?

If so, that makes sense. But if not (i.e., we consider all alternates to
belong to the same object database and share a single source), then I
don't know how this will interact with the existing MIDX alternates
mechanism.

Some clarification here would be helpful, I think.

> Refactor `prepare_multi_pack_index_one()` so that it works on a specific
> source, which allows us to easily store a pointer to the multi-pack
> index inside of it. For now, this pointer exists next to the existing
> linked list we have in the object database. Users will be adjusted in
> subsequent patches to instead use the per-source pointers.

OK.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  midx.c     | 19 +++++++++++--------
>  midx.h     |  7 ++++---
>  odb.h      | 11 +++++++++--
>  packfile.c |  4 +++-
>  4 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 3c5bc821730..a91231bfcdf 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -724,28 +724,29 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
>  	return 0;
>  }
>
> -int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local)
> +int prepare_multi_pack_index_one(struct odb_source *source, int local)

OK, so the combination of a repository and "object_dir" path becomes a
new "struct odb_source", which makes sense. But shouldn't "local" also
be a property of the odb_source?

I am not familiar enough with the odb_source work thus far to know
whether that is a good idea or not, but just something that stood out
to me while reading.

>  {
> +	struct repository *r = source->odb->repo;
>  	struct multi_pack_index *m;
> -	struct multi_pack_index *m_search;
>
>  	prepare_repo_settings(r);
>  	if (!r->settings.core_multi_pack_index)
>  		return 0;
>
> -	for (m_search = r->objects->multi_pack_index; m_search; m_search = m_search->next)
> -		if (!strcmp(object_dir, m_search->object_dir))
> -			return 1;
> -
> -	m = load_multi_pack_index(r, object_dir, local);
> +	if (source->multi_pack_index)
> +		return 1;

This makes sense. The old code was walking along the linked list of
MIDXs across alternates to see if we have already loaded one for the
given object_dir. But since there is a one-to-one relationship between
odb_source and object_dir, it suffices to see whether or not we have
loaded the MIDX for a given source at all.

> +	m = load_multi_pack_index(r, source->path, local);
>  	if (m) {
>  		struct multi_pack_index *mp = r->objects->multi_pack_index;
>  		if (mp) {
>  			m->next = mp->next;
>  			mp->next = m;
> -		} else
> +		} else {
>  			r->objects->multi_pack_index = m;
> +		}

I am glad that we are cleaning these up (since our style guide says that
if one or more if/else branch(es) has braces, they all should), but it
does make reading this patch a little more difficult. Not a big deal,
but I would have rather seen this as a separate cleanup patch.

> +		source->multi_pack_index = m;

As an aside, I see that we're calling this new field "multi_pack_index".
I wonder if it would be better to call it "midx", since typing out
"multi_pack_index" is a little verbose, and "midx" is a common
abbreviation that I don't think we would cause any confusion with.

> @@ -837,6 +838,8 @@ void clear_midx_file(struct repository *r)
>  	if (r->objects && r->objects->multi_pack_index) {
>  		close_midx(r->objects->multi_pack_index);
>  		r->objects->multi_pack_index = NULL;
> +		for (struct odb_source *source = r->objects->sources; source; source = source->next)
> +			source->multi_pack_index = NULL;

Makes sense.

> diff --git a/midx.h b/midx.h
> index 9d1374cbd58..b1626a9a7c4 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -3,11 +3,12 @@
>
>  #include "string-list.h"
>
> +struct bitmapped_pack;
> +struct git_hash_algo;
>  struct object_id;
> +struct odb_source;
>  struct pack_entry;
>  struct repository;
> -struct bitmapped_pack;
> -struct git_hash_algo;

(I'm nit-picking, but a similar note here that the unrelated changes
make it harder to see what is actually going on in this hunk, which is
adding a declaration for "struct odb_source".)

> diff --git a/odb.h b/odb.h
> index e922f256802..8e79c7be520 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -9,10 +9,11 @@
>  #include "string-list.h"
>  #include "thread-utils.h"
>
> +struct multi_pack_index;
>  struct oidmap;
>  struct oidtree;
> -struct strbuf;
>  struct repository;
> +struct strbuf;

(Same here.)

Thanks,
Taylor
