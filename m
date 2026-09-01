Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686BC431A44
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276391; cv=none; b=OM0p/jGlbxvuoqqULm5U0KGoUqSz5bTex5rr6o7TQrUUckyOxashD34QBdwrh9SZn5E0oq7PjfcQRK+q4KfdmlMyusRrdFFRbm1Rd9IIgDDQqMeLrxmtFsifRO5E4hE2ZScSnQAG9YlmnrxqvNwisr+E4ymnfKChMMY58IQL470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276391; c=relaxed/simple;
	bh=Y542N8bmoJ9CC7DYuiBTHDnVRMEATIxZoL6hQTrb/j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqX+zpQM0U04AQF6ofjEgR+jPmW77peBVVku1SUtz3G1O3MFxmOEyP3Nxdgug6sGZe54QEVXshPh3I51beenlpQHcA4B92vdlGm5FJpANS8JXbHpMnSwxvQ+I7kDKD8lwI2HZmI/ZWoctiE5l8mMmbAHFOm1dSSTSGxmu8fFvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG+Sff9f; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG+Sff9f"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9382fbb1208so5103285a.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788276388; x=1788881188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6ib0Bo6pxYE1coFXg6hDZLRghWMV+KcnOqb70W/lRc=;
        b=EG+Sff9fgUvbkyJaAWq38isEovBNQHBieTZ/wAoCA5F4u6UDJ5JXRTtlFXb/vrNF4J
         JejfcGKLMV7eKTRQORoOYXSUJBJosePEcwgFT6C8PhHSG2qrgI7H/yegitqkSZsBcZbm
         wRrs43fLrZH/UslVlSfcx0HGYtrxhSfccBcJuDmxY2MY/h0ztDFGITcqvBXLk10/SZLO
         ccKx6CwmevBx9Whi/Q124JBnx9JFMCWStMJOokrux5VPE3f7QE8dnZHvk22ZpowymCN4
         ajVBrkD4r4F6cW4H5TYSD//n4Ak/qzHmcS1Xs+kEJnRTo38uVdO2nzuOM6yrE3lE3peH
         qvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276388; x=1788881188;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/6ib0Bo6pxYE1coFXg6hDZLRghWMV+KcnOqb70W/lRc=;
        b=Jmz+eHwSSM9I8UbeYrg5QaFXPxqpca7j7Ro7EY0rf+K0D9tYLEbxnPErI6tEJR8lTY
         2Ne05dX6OYj9QNbGMqDYgZoAd8xaocBtiLaUwxyn58erSSbznvuunaJvmd3IT9eZd2ze
         UG+8Ov9bJe54ofEeUw+RSeqll89/gjTzg4go6ogofi6UzVr+MrhFGFGJHSLDbztiAb/U
         DSkng37qVBsUOkYzBuCuKChq6a7xlWhf3j7DuXvnvvv1Hu9thpeFM4tAST7ft3uyReLo
         CX43QyWmhruSqo0zR1WfS0UgLd56yqKP7YlgvrtW9E3X3R+90tPZDLP9mG3RQyoNHA5h
         gMbg==
X-Forwarded-Encrypted: i=1; AHgh+Rp8tzVfD79jT9p56G+LvpSvhbpGNwbM9MqWOFZh8wW2zWbqDuH0DOgYqveSSw9WHzrFvIk=@vger.kernel.org
X-Gm-Message-State: AFuF++nLHmN6F9tHFe9nNv991kbPaONq6tH9gTPxxFOqaQ6F/flxikJf
	egfLYSFgVTc2fiEQR8zmbiDmnKhoSMShNcNa0qJRH0O9UgYlbwgZaF/Y
X-Gm-Gg: AR+sD11uzBjH5hzVgq/ogiFV2QLes3oYrkscVnASjPRNpi2AcEOpsKW50XuQZu+ENmO
	KmeQeFxUIzhdPfOAJJrhMxddwz1IGsH0u6MfDGQDJ/1nzLpxe/DMgxsxQHgmybWzBnYjevUljnB
	H8FIsadx5Bw7z9VFIzFnjPyJGjFl0N7h3XlXZqszD+jn+K4/NcPNa+mj9Jb8Vigu40uagW4/SnU
	b71J7jldJAkPinI2qH52B+rYiaYT/Q0esJ4zVVK1RtCfsmgn4HUYiZW5/dQ20wynVFc0ifZFYwh
	smHEGO3/DLeF0N7ON5RcbW/7oe/zwA/X2Z4vhZ4vkdxg4NhLHLOCWC86N6S2t7mSVw2EiLGY3W/
	UMm23ybVFL+7UnShCQxukbSDek4cBEB+/9Frdj+DUFm11/UAi6xSCuyikTNiij/U1cCUn5Voq7c
	GYGrrnQJMyrM/anGqvxaSd9kowztO54NhVT21UyyalYWdK60YuPfKW8ts9YQri2JoWsjA648t2Y
	c2gmmmjH4N5LfksNJPFa9HNeGGrd29bQJiP0xN/x5LGACBQ2JHIPymHnrEBwERmcIx482P860UU
	mwiwBDBEcQWKFas=
X-Received: by 2002:a05:620a:4873:b0:939:5ba5:28c5 with SMTP id af79cd13be357-9395ba55cc4mr132018985a.17.1788276388048;
        Tue, 01 Sep 2026 08:26:28 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173a4254sm1045791285a.25.2026.09.01.08.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 08:26:27 -0700 (PDT)
Message-ID: <944945ab-dde7-41e5-af92-fc520485fc53@gmail.com>
Date: Tue, 1 Sep 2026 11:26:25 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] packfile: recover when a multi-pack-index names a
 removed pack
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
 <9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/2026 3:00 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

I'm late in reviewing this patch, so forgive me responding inline as
I discover how it works.

tl;dr: Good patch. LGTM.

> Teach find_pack_entry() to recover.  The MIDX lookup now returns a
> tri-state, distinguishing an object absent from the MIDX from one it owns
> via a pack that can no longer be opened; in the latter case, once the
> regular fallback has also missed, scan the MIDX's packs directly for a
> surviving copy.  Because the return value is no longer a boolean, rename
> fill_midx_entry() to midx_fill_entry() so callers must reckon with the
> new enum rather than silently treat MIDX_FILL_OWNER_UNAVAILABLE as a hit.

This tri-state is valuable!
 
> Do the scan only on the second read (OBJECT_INFO_SECOND_READ): by then
> the cheaper on-disk reload has run, so an object merely relocated into a
> new (uncovered) pack has already been found by the regular fallback, and
> only a genuine hidden duplicate reaches the rescan.  A QUICK caller that
> skips the second read simply accepts the false negative, as QUICK is
> designed to.
> 
> Reloading the stale MIDX would be a more complete fix but is much more
> involved (the borrowers above need proper invalidation), so leave that
> for later.

> -		if (m && fill_midx_entry(m, oid, &e, NULL)) {
> +		if (m && midx_fill_entry(m, oid, &e, NULL) == MIDX_FILL_HIT) {

One major benefit to the rename is that we can guarantee that
all callers are updated to reflect the new tri-state response.

It also has a better naming convention, overall.

(reordered header file diff up)
> +/*
> + * Result of looking an object up in a multi-pack-index.  MIDX_FILL_HIT means
> + * "e was filled in"; the two miss variants distinguish an object the midx does
> + * not know about (MIDX_FILL_MISS) from one it does know about but whose owning
> + * pack we can no longer open (MIDX_FILL_OWNER_UNAVAILABLE -- the signature of a
> + * concurrent repack having removed that pack).  A known-bad (corrupt) object
> + * reports MIDX_FILL_MISS but also sets *bad_pack, if provided, to the owning
> + * pack so the caller can tell "corrupt" apart from "absent".
> + */
> +enum midx_fill_result {
> +	MIDX_FILL_MISS = 0,
> +	MIDX_FILL_HIT,
> +	MIDX_FILL_OWNER_UNAVAILABLE,
> +};
> +
> +enum midx_fill_result midx_fill_entry(struct multi_pack_index *m,
> +				      const struct object_id *oid,
> +				      struct pack_entry *e,
> +				      struct packed_git **bad_pack);

This is good documentation that will help future uses know how to
react to the different modes.

> -int fill_midx_entry(struct multi_pack_index *m,
> -		    const struct object_id *oid,
> -		    struct pack_entry *e,
> -		    struct packed_git **bad_pack)
> +enum midx_fill_result midx_fill_entry(struct multi_pack_index *m,
> +				      const struct object_id *oid,
> +				      struct pack_entry *e,
> +				      struct packed_git **bad_pack)
>  {
>  	uint32_t pos;
>  	uint32_t pack_int_id;
>  	struct packed_git *p;
>  
>  	if (!bsearch_midx(oid, m, &pos))
> -		return 0;
> +		return MIDX_FILL_MISS;

Obviously correct: this OID isn't in the sorted list.

>  	midx_for_object(&m, pos);
>  	pack_int_id = nth_midxed_pack_int_id(m, pos);
>  
>  	if (prepare_midx_pack(m, pack_int_id))
> -		return 0;
> +		return MIDX_FILL_OWNER_UNAVAILABLE;

Obviously correct: we tried to open the pack index but failed.

>  	p = m->packs[pack_int_id - m->num_packs_in_base];
>  
>  	/*
> @@ -616,19 +616,19 @@ int fill_midx_entry(struct multi_pack_index *m,
>  	* loaded!
>  	*/
>  	if (!is_pack_valid(p))
> -		return 0;
> +		return MIDX_FILL_OWNER_UNAVAILABLE;

Same: Pack is invalid somehow, likely that the .pack disappeared.

>  	if (oidset_size(&p->bad_objects) &&
>  	    oidset_contains(&p->bad_objects, oid)) {
>  		if (bad_pack && !*bad_pack)
>  			*bad_pack = p;
> -		return 0;
> +		return MIDX_FILL_MISS;

This one is tricky, but makes sense: we have marked this as a
"bad" object so we should act like it doesn't exist. Good.

>  	}
>  
>  	e->offset = nth_midxed_offset(m, pos);
>  	e->p = p;
>  
> -	return 1;
> +	return MIDX_FILL_HIT;

finally: success!>  }


>  static int find_pack_entry(struct odb_source_packed *store,
>  			   const struct object_id *oid,
>  			   struct pack_entry *e,
> +			   enum object_info_flags flags,
>  			   struct packed_git **bad_pack)
>  {
>  	struct packfile_list_entry *l;
> +	enum midx_fill_result midx_result = MIDX_FILL_MISS;
>  
>  	odb_source_prepare(&store->base, 0);
> -	if (store->midx && fill_midx_entry(store->midx, oid, e, bad_pack))
> -		return 1;
> +	if (store->midx) {
> +		midx_result = midx_fill_entry(store->midx, oid, e, bad_pack);
> +		if (midx_result == MIDX_FILL_HIT)
> +			return 1;
> +	}

This looks good. On a hit, we return. Act like a MIDX-miss if we
don't have a midx.

Outside of the patch context is the "reprepare packfiles" to pick
up a copy from a packfile that doesn't exist within the current
(stale) midx.
> +	/*
> +	 * Recovery for a concurrent-repack race: a stale MIDX may still name a
> +	 * vanished owning pack even though the object survives in another pack
> +	 * the same MIDX covers.  The regular fallback above skips MIDX-covered
> +	 * packs, and repreparing the on-disk pack set does not reload the
> +	 * borrowed, cached MIDX, so scan its packs directly for the survivor.
> +	 *
> +	 * Do this only on the second read, by which point repreparing packs has
> +	 * already had a chance to find an object merely relocated into a new,
> +	 * uncovered pack; only a genuine hidden duplicate reaches here.
> +	 */

This comment does a lot of important context-setting to show
that we are in a very narrow case: the stale MIDX has multiple
packs that contain the requested object, but the "newer" one
was deleted without creating a new packfile, so we need to
look at each contained pack for the object from its pack-index.

> +	if (midx_result == MIDX_FILL_OWNER_UNAVAILABLE &&
> +	    (flags & OBJECT_INFO_SECOND_READ)) {
> +		struct multi_pack_index *m = store->midx;
> +		uint32_t i;
> +
> +		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
> +			struct packed_git *p;
> +
> +			if (prepare_midx_pack(m, i))
> +				continue;
> +			p = nth_midxed_pack(m, i);
> +			if (p && packfile_fill_entry(p, oid, e, bad_pack))
> +				return 1;
> +		}
> +	}
> +

This is hopefully a very rare case, but it's good to have
this "fall back to O(num packs)" situation.

> +test_expect_success 'lookup recovers object whose midx-owning pack was removed' '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		# "keep" ends up only in the big pack; "dup" is deliberately
> +		# placed in two packs so the midx has to choose an owner.
> +		test_commit keep &&
> +		echo duplicated-content >dup &&
> +		git add dup &&
> +		git commit -m dup &&
> +		dup_oid=$(git rev-parse HEAD:dup) &&
> +
> +		# Roll every object, including dup, into a single big pack.
> +		git repack -adq &&
> +
> +		# Build a second, "moderate" pack that also contains dup, so dup
> +		# now lives in two packs that the midx will cover.
> +		moderate=$(echo "$dup_oid" |
> +			git pack-objects --quiet $objdir/pack/pack) &&
> +
> +		# Attribute dup to the moderate pack in the midx.
> +		git multi-pack-index write \
> +			--preferred-pack="pack-$moderate.idx" &&

This use of preferred pack is a good way of getting around mtimes
that could be equal. We could also consider updating mtimes, but
this works so don't change it.

> +		# Simulate a concurrent "git repack" retiring the moderate pack:
> +		# its files disappear, but the now-stale midx still names it as
> +		# the owner of dup.  A valid copy of dup survives in the big pack.
> +		rm -f $objdir/pack/pack-$moderate.* &&
> +
> +		# The midx routes the lookup to the deleted pack, and the regular
> +		# pack fallback skips midx-covered packs, so without recovery dup
> +		# would appear missing even though it is physically present.
> +		echo blob >expect &&
> +		git cat-file -t "$dup_oid" >actual &&
> +		test_cmp expect actual
> +	)
> +'
Thanks for adding this test so we can keep this narrow case
working in perpetuity.

Thanks,
-Stolee

