Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1853B35893
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788840559; cv=none; b=pxlhTsq5WkqK3AZdxgLZg1vx7WGb+9rsbjF9YsePw10BtV7yg59ql2mMejYH2potYDeSgPAQFoAg+5TYW9tdgT4XZaYW3cFOldLxb06Id+KjKphA1pU4iWNXLuXb7tJR3YPp9pn8PfTqnjK6QtcvQFGedZoxpRidmSreMOGqduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788840559; c=relaxed/simple;
	bh=PUilOqvxAVde/rr5aTcDrgQrIUJFnEwxjVoiepOWT8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajd+b7lSzZKue7+P7qVXiaKvgUP9aRvyjf+/N9Xo2LjWZ3PIz+dtqQrPKsSwCODooqsYw84dscAqYQyY8D3ozyZJWHzCmthq9VDn+9fw3hTONj6H4TUH18G67YDclmWXXQkg3xKf3t1R4JSKfbWnHJWXRKGVIUdRUkKQOskKVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=N0VDbYNe; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="N0VDbYNe"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5306baf6b53so39769001cf.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 21:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1788840557; x=1789445357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cdy9lQVszJdvfZwwf36VQy//4weSi/F/eOWtw1ujrcc=;
        b=N0VDbYNe07ck0VG9GGtdtIZCbjhFoHgF0c6RCPR1k0WCTzmu4/BJsPeOh8pFPDgPhV
         Nj9iFAiaTc5detjkX+/LSx10wwukvixU50M5RaWoJtrcNvFsbX/hM53lyG0xcxMOZWpQ
         z7xvVfQ0f1Qoe9Oujg1OsMBKVylV8gsz9pATc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788840557; x=1789445357;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cdy9lQVszJdvfZwwf36VQy//4weSi/F/eOWtw1ujrcc=;
        b=pMuk60TyjEtlKxyPitQIoiHhPmAPXF74gBsZwoRD629gSzJwjT72TkI7Up8yZMc0JS
         2elK8uoTnyYgcUEeBjLl4naZlM7trXKyGg2yRE+eAWLgolJMEjzR8wC9O/5CFe1GQkjs
         622QT6cPVXRcanfy4AEl2J6S9xtoLQDVfdFscksq5glQGsAKAXxX/AxMjfLotLe+J7cj
         rLstqGKaXts7PUPPZ0cyVxc7grZQdUypQXUGpEr7GAx05ALG/pubzwjvUu+0cbt4VCPk
         Br2vyAiq4G7IUjrI2Jfjm4ZvVFCJdfj1nKSHn0Jytx3ZIs0syyjNrmfUn26DLyehSBPx
         qifQ==
X-Gm-Message-State: AFuF++m3gkqWSqnjH8GH7GnCx+45iq49FZrx8Oq5ndY+O9jnWtY5PnN2
	asJt7d1XeDjvYPQNkiLwkKHDYSOTtRUr/p7OM5q1Bl4yZDPgk8FG+a0IvSAi5pD2gE4=
X-Gm-Gg: AYBFou2H3NZ6bvisuZfcE7ZYXRFc4AuChGrkF6yigqfUPrPfsiMSNNTRe9DJ8oYpBzm
	0fnKAeUZQTK7ZxmDJ0HwV6vjj88fXomRLzSze5RPFY6hxNE0LHbBRrKJC88C1fm3+qwVYNMhcbZ
	C6PAhF+3WYj88VK1GL6G1BnfvwrlyhWaB8DmxErve7iI7ejDbLZHxWWG7v92naGirYfhobwSpvy
	K99noJJ/LRXeDaLasE3EJVpM1uKKvvmRHOjAqdBIiSYFyHdQ/bNC+UohDNqdYu6LY6pwNsq0yPy
	/HIvXRur9vFYnUx2F3sQQdKj7ADipXCKXGH7HPMwDG0UayhhsBbhdJqwBCXBcyQeQwymktoN3NB
	1ay6d6t8YU9hDutRtMtL/LTSQBVpwiuV/UMges1BmejwdIPbTjyZUmFq3Mg/GTEm5Dypa6KBwiU
	L64IuLtjkCQsKvC9++heRWHbBL9uxjiyVBYe4d0cqlp2/BD20b0e5krNHR6xQgstoGKrKTeP7no
	Xu7Pkd15YQV7sVxCvaPqDgD+OBn0v00yALsAj9TktYEfA==
X-Received: by 2002:ac8:5a47:0:b0:52d:6c92:b5e1 with SMTP id d75a77b69052e-530548e5bc8mr313899221cf.27.1788840556891;
        Mon, 07 Sep 2026 21:09:16 -0700 (PDT)
Received: from com-79390 ([40.76.104.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305413d7f8sm102139771cf.14.2026.09.07.21.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:09:16 -0700 (PDT)
Date: Mon, 7 Sep 2026 23:09:06 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Pia Park <pia@pierre.co>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] midx-write: skip empty incremental layers
Message-ID: <ap-KYtsDXXwbBzDM@com-79390>
References: <20260908014720.19705-1-pia@pierre.co>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260908014720.19705-1-pia@pierre.co>

On Mon, Sep 07, 2026 at 06:46:40PM -0700, Pia Park wrote:
> An incremental MIDX write can find new packs without finding any new
> objects, either because the packs are empty or because their objects
> are already indexed by an earlier layer.
>
> The existing early exit checks the number of packs, so these cases

First, thanks for working on this :-).

Second, what you wrote makes sense. It may be worth saying "[...] checks
*only* the number of packs", or "[...] but not the number of objects".

> publish a zero-object layer without a reverse index. A subsequent
> incremental write with --bitmap fails when loading that reverse index.
>
> Reproducible on master as of
> b8242b093d9e941a34460d715e3ce616a34ac3fe (2026-09-07), using:

Nit: we typically would abbreviate this using the "reference" pretty
formatter, as in:

    b8242b093d (The 23rd batch, 2026-09-07)

, but I think that it would be more interesting to include the commit
that introduced this breakage, which I would guess (though haven't
bisected) that we've had this bug at least as long as we've been able to
write incremental MIDXs. Though see below for perhaps an earlier origin.

>
>     git init --bare --object-format=sha1 empty.git &&
>     (
>         cd empty.git &&
>         git config midx.version 2 &&
>         git pack-objects objects/pack/pack </dev/null &&
>         git multi-pack-index write --incremental --bitmap &&
>         git multi-pack-index write --incremental --bitmap
>     )
>
> The first write succeeds but publishes the empty layer
> 3c8853aad425100c5ee2ee22209bb0bb3df9ca37. The second exits with status
> 255, reporting "could not load reverse index for MIDX".

Right. This patch message suggests (and I agree with) the fact that the
first layer wrote anything at all is a bug.

It only happened to work because the first invocation did not require
loading the empty reverse index, and so did not read the corruption that
it just wrote. The second invocation notices the bug because we eagerly
read reverse indexes for pack(s) in previous layer(s) when writing
reachability bitmaps.

That makes me wonder whether this bug is unique to incremental MIDXs at
all. I tried testing this out locally with:

    git.compile init --bare empty.git &&
    (
      cd empty.git &&

      git.compile pack-objects objects/pack/pack </dev/null &&
      git.compile multi-pack-index write
    )

, and it happily wrote a MIDX.

> Return success through the existing cleanup path when
> compute_sorted_entries() finds no entries for a non-compacting
> incremental write. This prevents publishing an empty layer that causes
> subsequent incremental writes with --bitmap to fail with exit status
> 255. Exit before acquiring a lock or creating a temporary MIDX file,
> leaving the existing chain untouched.

So I wonder if we should apply the fix even earlier in
write_midx_internal(), perhaps like:

--- 8< ---
git rev-parse 2>/dev/null || cd ~/src/git; git: line 0: cd: /Users/ttaylorr/src/git: No such file or directory
diff --git a/midx-write.c b/midx-write.c
index 580724d21a..5b2aa9acc8 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1617,9 +1617,8 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	}

 	if (!ctx.entries_nr) {
-		if (opts->flags & MIDX_WRITE_BITMAP)
-			warning(_("refusing to write multi-pack .bitmap without any objects"));
-		opts->flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
+		error(_("no objects to index."));
+		goto cleanup;
 	}

 	if (ctx.incremental) {
--- >8 ---

(as an aside, we can probably rework those error messages to be a bit
more descriptive, perhaps, "cannot create a multi-pack-index without any
packs". But that is besides the point of your patch.)

> diff --git a/midx-write.c b/midx-write.c
> index 8537102254..cdb2ef0474 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1518,6 +1518,11 @@ static int write_midx_internal(struct write_midx_opts *opts)
>
>  	compute_sorted_entries(&ctx, start_pack);
>
> +	if (ctx.incremental && !ctx.compact && !ctx.entries_nr) {
> +		result = 0;
> +		goto cleanup;
> +	}
> +

Hmm. So we will avoid writing an empty MIDX when we have no object
entries, but only when doing a non-compact, incremental write? I imagine
that we would want similar treatment for both incremental and
non-incremental MIDXs, regardless of whether we are compacting.

> diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
> index f0b82b5f65..4bdfa61d38 100755
> --- a/t/t5334-incremental-multi-pack-index.sh
> +++ b/t/t5334-incremental-multi-pack-index.sh

I suspect that these tests will change a bit, so I'll avoid reviewing
them too carefully for the time being. I am glad, however, that you are
testing cases besides explicitly empty packs, e.g., dropping objects
which are represented in earlier layers.

Thanks,
Taylor
