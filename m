Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14370376F1
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611585; cv=none; b=nvc3+uBfwvBmfHu/7V3+WcVo3zc9wVDkU/fDYL6avIqXB+I+dVZ61DaxrGpNpUpUA86ogi2BpKdO1td5oznrzrWMZ0Ijm8rKPwP99YdwULM3vsX+IGruHhX+cvBm94UhRtdBn12sx2NM248mLzjMyNcDvEzRaOd4BZwCDhmATsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611585; c=relaxed/simple;
	bh=TxUhlmlAt6XptHyEVujoy5VBgHjSKHTJyCSXZwWSvp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8wyhK9dkrjPgnTrZ8FvmtTYaa3gpHs8/uIiJGVV9C2APPCndhjukz4ioNIuBqlZbbRnxhLlU2feiUkCT5PQm20uatPuP8ulvwLgFTe1AHsemGryuKVaR8/njYhxsc8JD2sIgxL1Ef6oOIZFTqXfgCYNDcQUkrx2hrYhgCcfoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YCo6uaSI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YCo6uaSI"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3114560d74aso2020011a91.0
        for <git@vger.kernel.org>; Fri, 30 May 2025 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748611582; x=1749216382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BomwYVysf2R0Zv0im3wQJkIZlaBwcf3L/bz6hlsgrJc=;
        b=YCo6uaSI02tVD4Gp8+vhPZB/jgmekcWGox4jA3gb46n7sqQdHPRuWpUbWcKAVsb0cj
         N8mQZi0Sqw/MnTPanBW/1aw04mQR03QY2ZI3nk8bBgxiRKPQA+Ux3kI193efEyn16MEW
         hG5mS76zzdzCoN5iP2gAWOY0nnNI+8SoZgxIwe4j6dfZMS1hOBOw+DfS4H0mpVuHw7iW
         skkxwR33mNpQ2GqUoZ6Y23gqmyIKlUOgAw/4UjHYm3lwsPjnzK/9+Gpgzjm6/VFqPZE9
         pZ0sOlFgHyASdfcnvCOMO4y6l8dPrY9uvCNt823R+9lv/tFIrKzNDkCGVwdYpt8tF/8I
         Tvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748611582; x=1749216382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BomwYVysf2R0Zv0im3wQJkIZlaBwcf3L/bz6hlsgrJc=;
        b=WS3Ig8rTGigdxv7liZfHJvPx68QGGRZyB581D8pg8wvZOWVMMhiO/rRMKFN5JWAoGV
         i42BSYgXA3hVtHdV7myxKtPnWej0djEZLS1oIlOHopyspCLD/n8osoBZIhgUjiv5Ynch
         2/VkGOpbcbWNEbknmP6WzGQiRVUV7TU6eYZNCgxQDfjIgJiDLkFMP49BVWtqNROSPJxp
         E7Omsn5xYNBC22NVetvrrbMCh9TYsnW+j8jNJSsXpsLU+lJswe3//ELqSmIJeYv2PjKT
         H1TnjAlZWPrA2N24nai5eZ7ho9W+Kyl5HbjL2gPJ7FAgmoVB4QHX6EcmWV/C1YshMzlK
         bphQ==
X-Gm-Message-State: AOJu0Yw65Wgs63mJ451YR6PebChERz84/GGCF3bdwjKNUHlUBfw1uqeW
	f9ImriHbq3vho2tmbxtcE4HdWNEF34HKV6Ds5mmP3PrazYBtn3O+QdOg01y2bHOv8fcqXAd++Mr
	eoiUiehLAPwQsvOP4lCBSApXLGW1MJ9EnPKk5HIJthw==
X-Gm-Gg: ASbGnctK+UMqb0v8/q37psn7BXZYPRyGNsuKEePyN7gF1F7RgGMJFprevRXhJJQRCnc
	NabbLL+PQx4VWAboTdNcPP/VKfOeneQZmp5Cn1gX5e0uKDJ6D2n2ZmusmG5+8DVfwB/UtcPMPny
	JIqqKnsulDRO32dL6gU9Q9rxYBiAIn2XS03C4=
X-Google-Smtp-Source: AGHT+IEThIWxbRLatRpWbi428t/kvlK2NVIkGfqmCuecXjl4BajGcTKjw4fl7w/bsfAwoVpQy7oc2WeUeHb7dLXtoT0=
X-Received: by 2002:a17:90b:164b:b0:311:9c9a:58dd with SMTP id
 98e67ed59e1d1-312413f8d4cmr4996799a91.13.1748611582263; Fri, 30 May 2025
 06:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528095830.30306-1-hanyang.tony@bytedance.com> <xmqqplfrmoey.fsf@gitster.g>
In-Reply-To: <xmqqplfrmoey.fsf@gitster.g>
From: Han Young <hanyang.tony@bytedance.com>
Date: Fri, 30 May 2025 21:26:10 +0800
X-Gm-Features: AX0GCFtZ5VwV3mXFqA9cyG0y9avgZAmuvcobN8p0-gKXfWIjYK30q4ll9C8qUos
Message-ID: <CAG1j3zGhSQGii86Ysj3Wsuua2iwCUgyzg362NHutFT__F9dwdQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] promisor-remote: remove the promisor
 object check for failed fetch
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 11:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> So your "agonizingly slow" comes from just one
> single call to is_promisor_object() function is ultra slow?

That's correct, is_promisor_object() function constructs the promisor
objects oid set by iterating through every object in the promisor
packfiles and calling add_promisor_object() function for each object.
add_promisor_object() function parses the object, adds itself and the
objects it refers to to the oid set. For a very large partial clone
repository, the promisor packfiles will contain millions of objects.
Parsing each one takes a considerable amount of time.

> But at the same time, it sounds like is_promisor_object() seriously
> is wrong.  Perhaps we need to tell pack-objects to pre-compute the
> packfile.c:add_promisor_object() stuff and cache the result in an
> on-disk file, just like reverse index is stored in an auxiliary
> file?

As Calvin summarized in this thread [1], creating a promisor object set
is very expensive. The fact that a local object can become a
"promisor object" makes disk caching infeasible.
is_promisor_object() function is not inherently wrong, it's the definition
of "promisor object" that makes implementation difficult.

> What do the callers of the function use to "filter out local
> objects" to ensure that "all objects passed ... are promisor
> objects" do?  Have they already spent agonizingly large amount of
> time to do so?

They call oid_object_info_extended() function to check whether the object
exists in the local storage. Only objects that do not exist locally are
sent to promisor_remote_get_direct().

> So objects in the
> array are either promisor objects or missing due to repository
> corruption---we simply cannot tell.  I suspect that the claim
> "everything the caller calls the function with is a promisor object"
> is not exactly correct.

You are right that objects that are not present in the local repository
do not equal promisor objects. The array could contain missing objects
that are not promisor objects.

> The end-result when remaining_nr is not zero (i.e., some objects
> that the caller wanted us to be fetched) would not exactly be the
> same.  The function used to die only when the object we failed to
> obtain was what a promisor remote promised to give us.  With this
> change, we also die when an object the caller asked us to fetch is
> not promised by any promisor.  I do not know what the implication
> of this behaviour change would be.

I tested this patch with git-cat-file and git-diff on a repository
missing a normal object. The commands fail regardless of the patch,
but the error message is different. The message changed from
fatal: Not a valid object name
to
fatal: could not fetch ... from promisor remote

[1] https://lore.kernel.org/git/CAFySSZCyoaKCGycYgJjCJGJ2mV1yfg+gVFb7RytGKm=
kjupkNkQ@mail.gmail.com/
