Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997A210F8
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812199; cv=none; b=BVf9W+2SDX4Ue+dFJbNLttWwXFisI7oLPYQmzwaZZhR0mNoyiK8W+wFtmyHc4FGARivOW3TlrdIQ99qs6b82RhpjvUPnEUcfpQxP3ceDgyXlfFB4wIZDjzCHL0plp5abjGpmGpHIhkBOENz4cfsXGRcGoVUZpUZ5VIrB23H0W8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812199; c=relaxed/simple;
	bh=Ve8QLpWMOV1K6jCyG9sFpyYty4t4IdEfk1+PLEftXWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kcUX9mfoO0jz/vLFAVtOqEc+MrkK3H3CaA3Ly1CTPOk+yXxUTokcobXzpr3uHTVPzX373BPsAZQ/6rQL0FZqaQ5CyrkhxCXNv87hFeZPdU69XjsW480uss7MKsMAByUOasZqKJ9zNBfhy3QepOxuXuwucAF+RKOizcjxpCuRmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZBQ36RS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZBQ36RS"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60788151153so5120177b3.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707812196; x=1708416996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QBk0mhaKAjS9xpLCk+XzCgHI6VR/pcqTfPFgl4Fl9Q=;
        b=lZBQ36RSOKr9RVm3ES3GqnotK+9tNFGZsMYFOQwoKP4kPaM/HDVV7GA2tYpeJqK6o5
         kgdTxN7X9NpHtqhlTR9JiatWkRRwS0/TDVli4Jj7f4HQn3h62lit3ygCx8tiVbFPRPoA
         Rkl7LK2si2q1RTbDOapihx0wC4xEEqppA7vlMM72h/zGqEkCR2N9qCW+v+DWXoUEPKf2
         zwdJpm17wdjRYpyvqQKVJd9QW60Tk+DRrQcLTIG1lri8+wCHytqLsfvdgUnFgwyrGqW/
         OJ4vD9J7LjdEYVjNkS8lfwtwHhO5Ecsy6qI0cm50BvVMMAjOtMcMMCXz/s+G4QDy0n7M
         Zjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812196; x=1708416996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QBk0mhaKAjS9xpLCk+XzCgHI6VR/pcqTfPFgl4Fl9Q=;
        b=Frl46S4IMFAn36PbNT+ddIh49CwjVqaECWv4fYGsAZyKHwpis5nAFZHxmid6Zr//fO
         AL/lEOopvh+nfWM6lst8NXeXDjRI8VWivW3eyoitLxMBflch2GKEsIWk2qMX0Gl2x5Fr
         1xb9cA1fkf8/8kXApXZtpIMsah/E0K6dOkGTKGV3XH5VOUNqv11GsUELfw/Gw/XGfUj1
         6pTaHgzBIFIKNavyPy1L+FxZiWdG1ycCMzPsD/XPTfnxIr1QLw90PiBWLF5JDLy5U4OI
         vWaHdPj9HiJ5wstg1wLdBuh4MGX08M0dZxNPG80PCz1VfnekIRLdIXcSI4a6RGXJM7Ns
         IwQg==
X-Gm-Message-State: AOJu0YxEb+zPZH4nKF/NzusAnCL2Z4O37n2ca45cZMFPAHxut8HPl+vb
	Fyh3I0VxwQxx2yLMD0n5jB0CiQVsSTu93OQ2Z6yXLyisY8fUeTDQxKsY6iT0ql9ABMevvNS+q+Z
	eGA==
X-Google-Smtp-Source: AGHT+IHQAaXdHTmFbWyDXIGAzBiUp0UKbffjTfaxapl9wA+zBqvkQyOxIOF+8qWJRl9VTG+XwnA5kLFVxLk=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:690c:360d:b0:5fb:5605:494a with SMTP id
 ft13-20020a05690c360d00b005fb5605494amr1571224ywb.7.1707812196381; Tue, 13
 Feb 2024 00:16:36 -0800 (PST)
Date: Tue, 13 Feb 2024 00:16:34 -0800
In-Reply-To: <20231002024034.2611-2-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org> <20231002024034.2611-2-ebiederm@gmail.com>
Message-ID: <owlya5o4dbj1.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 02/30] oid-array: teach oid-array to handle multiple
 kinds of oids
From: Linus Arver <linusa@google.com>
To: "Eric W. Biederman" <ebiederm@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Eric Sunshine <sunshine@sunshineco.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> While looking at how to handle input of both SHA-1 and SHA-256 oids in
> get_oid_with_context, I realized that the oid_array in
> repo_for_each_abbrev might have more than one kind of oid stored in it
> simultaneously.
>
> Update to oid_array_append to ensure that oids added to an oid array

s/Update to/Update

> always have an algorithm set.
>
> Update void_hashcmp to first verify two oids use the same hash algorithm
> before comparing them to each other.
>
> With that oid-array should be safe to use with different kinds of

s/oid-array/oid_array

> oids simultaneously.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  oid-array.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/oid-array.c b/oid-array.c
> index 8e4717746c31..1f36651754ed 100644
> --- a/oid-array.c
> +++ b/oid-array.c
> @@ -6,12 +6,20 @@ void oid_array_append(struct oid_array *array, const struct object_id *oid)
>  {
>  	ALLOC_GROW(array->oid, array->nr + 1, array->alloc);
>  	oidcpy(&array->oid[array->nr++], oid);
> +	if (!oid->algo)
> +		oid_set_algo(&array->oid[array->nr - 1], the_hash_algo);

How come we can't set oid->algo _before_ we call oidcpy()? It seems odd
that we do the copy first and then modify what we just copied after the
fact, instead of making sure that the thing we want to copy is correct
before doing the copy.

But also, if we are going to make the oid object "correct" before
invoking oidcpy(), we might as well do it when the oid is first
created/used (in the caller(s) of this function). I don't demand that
you find/demonstrate where all these places are in this series (maybe
that's a hairy problem to tackle?), but it seems cleaner in principle to
fix the creation of oid objects instead of having to make oid users
clean up their act like this after using them.

>  	array->sorted = 0;
>  }
>  
> -static int void_hashcmp(const void *a, const void *b)
> +static int void_hashcmp(const void *va, const void *vb)
>  {
> -	return oidcmp(a, b);
> +	const struct object_id *a = va, *b = vb;
> +	int ret;
> +	if (a->algo == b->algo)
> +		ret = oidcmp(a, b);

This makes sense (per the commit message description) ...

> +	else
> +		ret = a->algo > b->algo ? 1 : -1;

... but this seems to go against it? I thought you wanted to only ever
compare hashes if they were of the same algo? It would be good to add a
comment explaining why this is OK (we are no longer doing a byte-by-byte
comparison of these oids any more here like we do for oidcmp() above
which boils down to calling memcmp()).

> +	return ret;

Also, in terms of style I think the "early return for errors" style
would be simpler to read. I.e.

    if (a->algo > b->algo)
        return 1;

    if (a->algo < b->algo)
        return -1;

    return oidcmd(a, b);

>  }
>  
>  void oid_array_sort(struct oid_array *array)
> -- 
> 2.41.0
