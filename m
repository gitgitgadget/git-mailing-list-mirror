Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF11208973
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593893; cv=none; b=dxnDYiUIAmTA7kj6WxgDgGCTTT79zV+EPhoHgQxQBsZr8KVOmpjnvuU0Os2o7Lo0dX5Wl3S+DpPaNXy/tU5pY1oJDDtTfYDWGiXew7tClxtU5JEjLnpfhWOlpdE8Ditx2vnNufCqQ9MOJg5DVZfTq5112JYMj+LGE5TV5veIQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593893; c=relaxed/simple;
	bh=pkRaa99Y7v7/A0Q42m+Wkp2r6959gRcIOOvQVW9H/Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJmXNUhVFat3b/jl52q86uqz08o91Cu+lG+tYjDn1F+UE46k4NMRY0b3/H3FX68uwymrs2owaK7OsV77GorucfsD05u0PMuG7PSLan10en1VmLKQ0IdBubnaz2pD/Uqr7lmwE0IvFdrQgFjI7qbcktBF0e74joePDLtCG4yBIok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0V8TLrU; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0V8TLrU"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5ae3fc15acso2137123276.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 06:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738593891; x=1739198691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPh3oZsRrFALMoikNZlwRO937ddeVQwO4w7tHN6QAcA=;
        b=g0V8TLrUwz2bErBhE4Bu5hW9O0xlx8iVg2o25AW8LELmScj8ykKteXQhztzJSzCeYP
         ar2vKkMjZhNUwNozR52+qYaSxOvYjzYOQrR0z7BugDVKU1Q0JjHewT3/iN8z8aBqNdp2
         kBT2T4Nsr2rPt9ljV8fN5DJ4/p+QuLsqXZnY35H6w7vFWfXO9ZvsY3BUvFp9EcsBQ7EC
         5tYg6AHlE7kuYVnZrc9NycpcbJMyd1lfR2zbvgC9W3B1fIq3cug52l51eB7rlQJgwkcy
         CbMaJwJu4QFH++HWSKx/eDg0i8s1tRWA2WPQHesQnEDh5AyR7aQRmixXm6cx+iqPmehj
         +Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593891; x=1739198691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPh3oZsRrFALMoikNZlwRO937ddeVQwO4w7tHN6QAcA=;
        b=IGB2mY5DXPANt0qdvCs5yedT/9liobodTIrvcUrXcwwQvNqSTtS/VtTGNNbjELHN5b
         eK33VwoxUCERws7mI15y5cAMj+VHI7gNtexUwGX8VZUYIHOixx1j+gOsHQ2yfxcXfKbI
         PRkyZB8AAoV7H37g4Nfptnxvkgi4yVPYU/Yrqi1G8bN6VQYNxomnTKkG8jAdz20Lmxl0
         eIhIDnh9GWgvosnGsbObRXknjUGwMDzw4kZ2flADwfvlw1+qU43CIg8hsn/O16vbd6sy
         Y9O760srLwuRS75iS9VLxc6ac+ZAGvx8kNM3cYUzz4iWuHGl1Z5qzrO/gXYH0fE/SNsV
         P4Pg==
X-Gm-Message-State: AOJu0YzhURIFuW6B4RzeIvR0Jq8j2hSmODy34IJeL7VdnLwx/1xtMaHT
	X+fA7npSfPYCOUQg0GiNI4ZAl7GoAQ+oFhFURh4Rr0H9eOpzqgeT
X-Gm-Gg: ASbGnctPL1jooMfUBr6uEP6EjwKbanjS2XYlVKMe4R2wxrjtydeHPlQiij4WA9i1sXZ
	UXcJsIwBzefaXeqy4ldoUHW7zlY1DbGc9T97nOWouvGJtR6F2SFYTO7v64EHThsxY3dpkMqI5D8
	wnhZDgJPPQD0dSE6II+fKGZ9m3ojR6Earcz77cZqeVGku6TGGP+NLI0/I7UpIVwIed5lgC6KlPQ
	7tjaDfcSPmBR2lo9K64EatbdPL3ldOyU1qdXjNK/6a2FAUxSpL/AMWtzYkvYXfARm/u/XtxJjpg
	rYIM95ss25ZuL/1Z2MyZRbpfn+fcF7feUUgEyAsNF0A487F1dPbWQm4sga1bOf3pVtl+gPNMmRt
	27gE=
X-Google-Smtp-Source: AGHT+IEzOu2WfZsgE5l2RwTWBNNrUqZbVc1giSMy8SvaLvs36e5OK9mdtY41K1hbjbf90hxALaQMtQ==
X-Received: by 2002:a05:6902:2d03:b0:e57:8991:be39 with SMTP id 3f1490d57ef6-e58a4bc53bdmr13577516276.32.1738593890919;
        Mon, 03 Feb 2025 06:44:50 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:2dfe:af96:f238:f6f1? ([2600:1700:60ba:9810:2dfe:af96:f238:f6f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f8c4a7e46fsm21120137b3.116.2025.02.03.06.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 06:44:50 -0800 (PST)
Message-ID: <718583a4-31e6-45d4-9807-c5a07050b28f@gmail.com>
Date: Mon, 3 Feb 2025 09:44:49 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] backfill: basic functionality and tests
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com, karthik.188@gmail.com,
 Derrick Stolee <derrickstolee@github.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
 <e4e88794cae7edc568dd054b1376caac7fd30076.1734712193.git.gitgitgadget@gmail.com>
 <Z4jY3EQbC42scEIF@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z4jY3EQbC42scEIF@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/25 5:01 AM, Patrick Steinhardt wrote:
> On Fri, Dec 20, 2024 at 04:29:50PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/builtin/backfill.c b/builtin/backfill.c
>> index 38e6aaeaa03..177fd4286c7 100644
>> --- a/builtin/backfill.c
>> +++ b/builtin/backfill.c
> [snip]
>> +static int fill_missing_blobs(const char *path UNUSED,
>> +			      struct oid_array *list,
>> +			      enum object_type type,
>> +			      void *data)
>> +{
>> +	struct backfill_context *ctx = data;
>> +
>> +	if (type != OBJ_BLOB)
>> +		return 0;
>> +
>> +	for (size_t i = 0; i < list->nr; i++) {
>> +		off_t size = 0;
>> +		struct object_info info = OBJECT_INFO_INIT;
>> +		info.disk_sizep = &size;
>> +		if (oid_object_info_extended(ctx->repo,
>> +					     &list->oid[i],
>> +					     &info,
>> +					     OBJECT_INFO_FOR_PREFETCH) ||
>> +		    !size)
> 
> So this is the object existence test? Is there a reason why we don't use
> `repo_has_object_file()`, or its `_with_flags()` variant if we need to
> pass `OBJECT_INFO_FOR_PREFETCH`?

You make a good point, but I also notice that repo_has_object_file() has
the following comment:

  * These functions can be removed once all callers have migrated to
  * has_object() and/or oid_object_info_extended().

so I'll use has_object().

>> +			oid_array_append(&ctx->current_batch, &list->oid[i]);
>> +	}
>> +
>> +	if (ctx->current_batch.nr >= ctx->batch_size)
>> +		download_batch(ctx);
>> +
>> +	return 0;
>> +}
>> +
>> +static int do_backfill(struct backfill_context *ctx)
>> +{
>> +	struct rev_info revs;
>> +	struct path_walk_info info = PATH_WALK_INFO_INIT;
>> +	int ret;
>> +
>> +	repo_init_revisions(ctx->repo, &revs, "");
>> +	handle_revision_arg("HEAD", &revs, 0, 0);
>> +
>> +	info.blobs = 1;
>> +	info.tags = info.commits = info.trees = 0;
> 
> Nit: this should be unnecessary as PATH_WALK_INFO_INIT already
> initialized those fields for us, right?

The info.blobs is redundant, but is helpful for context. The
other line is necessary as PATH_WALK_INFO_INIT is defined as:

#define PATH_WALK_INFO_INIT {   \
	.blobs = 1,		\
	.trees = 1,		\
	.commits = 1,		\
	.tags = 1,		\
}

>> +	info.revs = &revs;
>> +	info.path_fn = fill_missing_blobs;
>> +	info.path_fn_data = ctx;
>> +
>> +	ret = walk_objects_by_path(&info);
>> +
>> +	/* Download the objects that did not fill a batch. */
>> +	if (!ret)
>> +		download_batch(ctx);
>> +
>> +	backfill_context_clear(ctx);
> 
> Nit: I think it's a bit funny that we're cleaning up the context over
> here rather than in the caller.
Cleaning up in the caller makes the "return do_backfill(&ctx);" line
slightly more complicated, but you are right that we shouldn't be
cleaning up something that the method "doesn't own".

Thanks,
-Stolee

