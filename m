Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F48370ACA
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182735; cv=none; b=XqmYdSMwx1Y0HXIrzkkmfPx8AIgIeRwXy2Cflib4zKXYuVjh6heZ0WAo1DtP5REh/c8NewNEFq22R+QYjctuvwy35Ua+8YiLqaU48ElH7gHe252bBL7elBNpJpmmAhhafEOS/mUo2mGGCTPnOPzDZHMrpT7C4VgXJTl8biy/YBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182735; c=relaxed/simple;
	bh=bMquPTK+nKJZgAuOPMQEhkxltqTFkBSsqC+DciZAau0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzFUupgZt5tM6O6k7u2YZARDspmC9MjIrZ9Mnl/qGjLNBrnnmdEukdjHqKKiT+6v+sz+vzU/c8Uu7pknVQc7Bw59mIQU+LVELpWyO9b5thboTCePxmUrGTz4M+K7DUEw3xc17oOkrLgs7N1FPfAKLw+OAcEAf7DQpj5dk6YDmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Tw1plIzl; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Tw1plIzl"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81f52945098so5201227b3.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785182731; x=1785787531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QRSCqh8utfLdA4JziNxgOhK5qQr1OpnjIaf8xIAoAzk=;
        b=Tw1plIzln5ewICipim1wY0W7KjYUCMY21R2uIFUW50Reta5VkABylwocmItZBUo6k3
         GnXVV6XJzIglYQ4vMCMtXCkNsP2d5alEAYzwLUSVu/bHcGgWNDnVGFvjqeNyQLLnQ+v1
         7L3PUOsvFzU++0qIpIkkCeZPNBLYUn+B9tM9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182731; x=1785787531;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRSCqh8utfLdA4JziNxgOhK5qQr1OpnjIaf8xIAoAzk=;
        b=YkWbnQEjFk4UYa6epkVT0BGdbr2KSKZl/pkQTcYYgbNNI7VMUvxom5QOynZOGLxSf1
         boLyo3Wn8MHKnCmgiv0DbjEszgF+/UiXQGKGXpzNbGSxWTn7S9TA9KwbaUeyzrWwQjuG
         PAiVum8LhWLvo5yGjDJWhQUtxpojom9uFV8hmBZCHJg95CcbTBSuoLf5WbrhsKvtnCsw
         omvpIfml8hdW3vyrgQKEZbJDhAhDZgVvhoec4zzpH3rJ0ObY9LSv1mXf4LTuciWAH1Ax
         mlDJ9SioMMzJEwDWWfwCT0FFTvWAUxOQuOEzqp3nMQM674Pw1Hv5e03+p8QWP/K8oML0
         /wgg==
X-Gm-Message-State: AOJu0YwDDd+hI/Lmgg3MhfppXFgLMG/hiG42oSUHHPcyVQ/vDu3DUcpH
	rPEpjOkT9WkhEkATBAzCMybb+vgPH0bmeqBs2tnbOJOTiAlkYorVKpXcs/5DOLozjkU=
X-Gm-Gg: AR+sD10BrNeztNrNpvpAnRqhzZK8CbgOAfVfTRehaGKpaZiqRe8I1gUxsiU65hNxgwZ
	c2eGvpo8fWGCxYaW4L9J9RzdiXusrz0+AQV8uRm7ewU9S1OZ8mHBWvlcZcLmW6u2kWloRRFz2Je
	Fg1czxIEw3z8TWlDi23/Jd4nQ+Mf1oiXZRsiXLELkqZNyjo+x0cvz/Bb1k/RXP5hzLgmhYXozOl
	5pkXFICNvNFAClSqup5upmFeLFxnh+IdtA/fQydRU+aYeokWZzncLik+1KI+sKyDpd1WSznIyut
	Qhuy56q9pB3J8zKuJUnK9WD6sUNOqCavM5/iO4V2w87UZuipK8vlsveNysrBDSBQfqIUSPLlfzE
	KBbQbWUrvKDA3FZ8e1zX1N+ZJJW/PDZpB+x5gW92/jUv4M8IEyHirngljpfOgpzrNdxIivEb9bO
	WR+mvGs3UyeZwMdS1M6KKiGoXpLPFFcT9rJTBkCDGRn2yCxsb3U12JQ+j9UKMWS1TMd/0Rw0w=
X-Received: by 2002:a05:690c:6112:b0:81e:c510:caf0 with SMTP id 00721157ae682-81f96248500mr941127b3.32.1785182730766;
        Mon, 27 Jul 2026 13:05:30 -0700 (PDT)
Received: from com-79390 ([172.190.114.39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f658d3082sm36879447b3.31.2026.07.27.13.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:05:30 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:05:27 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: David Lin <davidzylin@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	David Lin <davidlin@stripe.com>
Subject: Re: [PATCH] pack-bitmap: handle objects at bitmap position zero
Message-ID: <ame6B7pHSvXekdPZ@com-79390>
References: <20260727171331.21088-1-davidlin@stripe.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727171331.21088-1-davidlin@stripe.com>

On Mon, Jul 27, 2026 at 01:13:31PM -0400, David Lin wrote:
> In `find_objects()`, we have added a check in 11d45a6e6a to avoid
> processing a root whose reachability is already represented by the
> base bitmap, but accidentally uses `pos > 0`. Consequently, it never
> performs the membership test for an object at position zero.

Makes sense. The commit message here and below looks reasonable, but
please wrap it at a maximum of 72 characters per line.

> If that object has an individual reachability bitmap, we unnecessarily
> load and OR that bitmap into the base again. Otherwise, we add the
> object to the not-mapped list, only for the subsequent pass to
> recognize that it is already present. The latter pass correctly treats
> all non-negative positions as valid, so this does not change the
> resulting object set, but an off-by-one edge case.

At this point, "load" is a fairly cheap operation. We have already
loaded the bits off of disk in a previous step. If the bitmap was
stored as an XOR against a neighbor, we have already XOR'd it against
that neighbor and stored the result.

More importantly, you're right that this does not change the result we
get from the bitmap machinery. `find_objects()` works as follows:

 1. We first start with a "roots_bitmap" (which is non-zero *only* in
    the positions specified by the given "roots", and *not* their
    reachability closure).

 2. We then apply pseudo-merges to that bitmap of roots, OR-ing that
    into the "base" bitmap if we were able to apply a non-zero amount of
    pseudo-merge bitamps.

 3. We then loop over all supplied "roots". If we have a "base" bitmap,
    we try and mark the given root as SEEN if its corresponding bit
    position is set. If it isn't, then we try and call the function
    `add_commit_to_bitmap()`, which ORs in a stored bitmap to "base".

 4. Finally, if that fails, mark the object as `not_mapped`.

So in the case there are pseudo-merge bitmaps, and if one of our
supplied "roots" is stored at bit position zero, then we will only fall
through to the `add_commit_to_bitmap()` case (incrementing the "hit"
count further than necessary), but othewrise marking the object as SEEN
and continuing. This also sets "existing_bitmaps", which involves one
extra pseudo-merge cascade.

In the case where there aren't any pseudo-merge bitmaps, the reasoning
is similar, except that we must have (a) at least one "root" which has a
stored bitmap, and (b) that we see the root at bit position zero *after*
one or more stored bitmaps. Note that (a) and (b) can refer to the same
root here, so something like:

    $ git rev-list --objects --use-bitmap-index HEAD HEAD

should do the trick.

> Treat position zero as valid by changing the condition to `pos >= 0`.

I briefly wondered whether other callers of `bitmap_position()` would
have similar issues. There are a total of twelve `bitmap_position()`
callers, and all of them except the one in this patch handle the return
value correctly.

As an aside, we could consider doing something like changing the return
value of `bitmap_position()` to indicate non-zero on failure, and zero
on success, and fills the result through a uint32_t pointer. I roughed
this out locally, but the patch is mostly noisy and not really worth
sending.

The important part of the change is the following:

--- 8< ---
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d8dc4ae8d1..4e86aa15dd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1064,7 +1064,8 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 }

 static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
-					   const struct object_id *oid)
+					   const struct object_id *oid,
+					   uint32_t *bitmap_pos)
 {
 	kh_oid_pos_t *positions = bitmap_git->ext_index.positions;
 	khiter_t pos = kh_get_oid_pos(positions, *oid);
@@ -1078,39 +1079,44 @@ static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 }

 static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
-					   const struct object_id *oid)
+					   const struct object_id *oid,
+					   uint32_t *bitmap_pos)
 {
-	uint32_t pos;
 	off_t offset = find_pack_entry_one(oid, bitmap_git->pack);
+
 	if (!offset)
 		return -1;

-	if (offset_to_pack_pos(bitmap_git->pack, offset, &pos) < 0)
-		return -1;
-	return pos;
+	return offset_to_pack_pos(bitmap_git->pack, offset, bitmap_pos);
 }

 static int bitmap_position_midx(struct bitmap_index *bitmap_git,
-				const struct object_id *oid)
+				const struct object_id *oid,
+				uint32_t *bitmap_pos)
 {
-	uint32_t want, got;
+	uint32_t want;
+
 	if (!bsearch_midx(oid, bitmap_git->midx, &want))
 		return -1;

-	if (midx_to_pack_pos(bitmap_git->midx, want, &got) < 0)
-		return -1;
-	return got;
+	return midx_to_pack_pos(bitmap_git->midx, want, bitmap_pos);
 }

 static int bitmap_position(struct bitmap_index *bitmap_git,
-			   const struct object_id *oid)
+			   const struct object_id *oid,
+			   uint32_t *bitmap_pos)
 {
-	int pos;
+	int ret;
+
 	if (bitmap_is_midx(bitmap_git))
-		pos = bitmap_position_midx(bitmap_git, oid);
+		ret = bitmap_position_midx(bitmap_git, oid, bitmap_pos);
 	else
-		pos = bitmap_position_packfile(bitmap_git, oid);
-	return (pos >= 0) ? pos : bitmap_position_extended(bitmap_git, oid);
+		ret = bitmap_position_packfile(bitmap_git, oid, bitmap_pos);
+
+	if (!ret)
+		return 0;
+
+	return bitmap_position_extended(bitmap_git, oid, bitmap_pos);
 }

 static int ext_index_add_object(struct bitmap_index *bitmap_git,
--- >8 ---

> The existing pseudo-merge traversal test exercises this case. Its
> position-zero commit is presented through multiple roots. Before this
> change, each occurrence is counted as a bitmap hit; afterwards, only
> the first occurrence loads the bitmap. Assert the resulting hit count
> to cover the boundary condition.

Exactly.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index d8dc4ae8d1..e85bd69ba4 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1569,7 +1569,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
>
>  		if (base) {
>  			int pos = bitmap_position(bitmap_git, &object->oid);
> -			if (pos > 0 && bitmap_get(base, pos)) {
> +			if (pos >= 0 && bitmap_get(base, pos)) {

OK, this is obviously good.

> diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
> index 305d677108..2a6c0e2318 100755
> --- a/t/t5333-pseudo-merge-bitmaps.sh
> +++ b/t/t5333-pseudo-merge-bitmaps.sh
> @@ -85,6 +85,10 @@ test_expect_success 'bitmap traversal with pseudo-merges' '
>
>  	test_pseudo_merges_satisfied 8 <trace2.txt &&
>  	test_pseudo_merges_cascades 1 <trace2.txt &&
> +
> +	# Position zero is named by HEAD, its branch, and its tag, but its
> +	# bitmap should only be loaded once.
> +	test_trace2_data bitmap bitmap/hits 1 <trace2.txt &&
>  	test_cmp expect actual
>  '

This is good, though it is a little bit fragile in the sense that we
rely on the pack ordering to place HEAD as the first object in the pack.
I'm comfortable with it given the comment, which effectively documents
that fragility.

However, I think it's worth covering the non-pseudo-merge case as I
described above, too.

Thanks,
Taylor
