Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEF3271EB
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768741672; cv=none; b=C6dkMwYGGho1luHzIyBvepkh+w0dTjIgSH4hKfm719QxaDbfdSwZt4KYVXhcVml6tuXU8Bc7sV6Tuxlw1qfR8CzKY4mYTUbtmR8cXfogPmm9x36VDCsshbLLChhBEyUFZEoaL9TIRXSsEcK4oPW4do6CWuSJpixAQe8J8YmvNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768741672; c=relaxed/simple;
	bh=DdeQtw/aFvaJXuAx+1FBC+WwMT5n0nMlLyayh9kXG6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BA0NRAHaSjMhxCIHZTqXiDYQLP6phKJ8wonU6H8H8mdUDEZrKj56arIjZBnIunwOaxNCW88FiOsWH4O3hKwVgKfLjZVc/2JYZdlnt2ieqJCVGI/6Xjz2CZHpRv78od5o1pwldDx+9azN6crhpdPeHvNwKpEHYJHKtuLncFu8vSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9RAJ/Eb; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9RAJ/Eb"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649166a96a9so2701570d50.3
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 05:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768741670; x=1769346470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0KrGrDKXzMH7Sal/bt1TFo8/MLMcdNwMYEM8OcxfBdk=;
        b=g9RAJ/EbxzXP82sEQNOoNOH8rqqDnmNI4Ypsqraxe6r1G361cdwEJSt58fCc4m0IOM
         jywR++hRh/YfS5eZx4/pIpbF5GPLt6L9SsjojiMD7Dwb47gXOSynzLOSnlnijGN3JlNZ
         Z7XndxBeaFLqygHxuS39Q7KSLaLcJagFKCD9C7zhnkjBsmsALwFAQCuze2bs8TXMm3CG
         kkpUZxRHmSmf1orqcDzeK6W4y7dy5OJwer/EL8qQvinf/FWgXONQMtSW/JlNBLqm5s8J
         cb7e9uk76eCxewBM87i/oVEsqt8UN6H/L09d+Gld18xG/8vP5FPYkBJLvvmvDf6kJykq
         vHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768741670; x=1769346470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KrGrDKXzMH7Sal/bt1TFo8/MLMcdNwMYEM8OcxfBdk=;
        b=QG7Fjvz+lQVZmfy7cmqJSnwYpu9ga+W1FUcpRb+bUIY/8xPjkwVTVSnajNAbvuhQuW
         gYcmNwr6u/xYadknA+Rd/ztyLiN+j6PX22isAPTBuhZwILaF2vQfnHNkkrAFUbs3Aneo
         3P5kiUAlIa6hTGLNz5qrvOAWh50//U0LLQQ5mCrmxYpuGLrrkpPNWtLNF/h/hfGLGwWB
         QAYi6Njk/1fbQu3h7WfdUEA8ntsGeS+QZKbtkOc0bd/6UgANHeSxJnAhINADkuEDANIy
         8+PGaUmtUm8i0t39hTaZMutmWHfZWwBtlPS9YL0lRF1oE6VYWg1ll82wubJ7pwfMxoA2
         2mGg==
X-Gm-Message-State: AOJu0Yw6+ubTA4h6QY4jq3myre3zLjrBMQWdD67z6Wfe4IW/cnoXL3yd
	H7OdOceukiPPToLdUa2f5UsIyFAETKqYHFJmF5n7vcCUaQlcCDltdluzud2OUBPn6aOMaM+rYA7
	HJi3rlR2ESnIpxoSzwymTZEtLRef1kek=
X-Gm-Gg: AY/fxX47Saeph61umCCjDl4I75qGkTb+9yRoZBf9kcUr9JiZCNNpPkp2maTsjCAJ6e6
	9WjMGGoIyn3NWZ5AxfNp+C75Ml72G+2zCeMKNsBwdNU48RUmNcwzPeXqfGcotxX2B16896JcC9c
	Z705zCHVKyLhg2xJX6kgkmNnEoZuIPOGkxQiNTMHYVvTuma0GUhXZAvjb6JZ3WMlobIKWcznnr/
	UVPodEGBwmpTD8HIpYRSqzSgsFRNrHM2x8eOhocvE0vtkG6XX+GU19WTR7p7hZDbvRlP2OQSNk6
	emfpcoBGIrLieTK/m9HQ8C44Buy3
X-Received: by 2002:a05:690e:1389:b0:644:79fb:7db7 with SMTP id
 956f58d0204a3-6491647733dmr7083800d50.13.1768741669691; Sun, 18 Jan 2026
 05:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114192803.4852-1-amishhhaaaa@gmail.com> <20260116165003.95314-1-amishhhaaaa@gmail.com>
 <xmqqqzrp74q3.fsf@gitster.g>
In-Reply-To: <xmqqqzrp74q3.fsf@gitster.g>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Sun, 18 Jan 2026 18:37:38 +0530
X-Gm-Features: AZwV_QgAQ95rnv-IcQEuT9k_54aLwnlECUApyTwOW4RCo4PkNz5-gQy0UTyYE64
Message-ID: <CAPvEtrceTDtZ2HdHnETRsKd0KTeeoVaiHy-K1O_+Qiuk6XAKcw@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout: optimize string_list construction
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, stolee@gmail.com, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Jan 2026 at 00:41, Junio C Hamano <gitster@pobox.com> wrote:
>
> amisha <amishhhaaaa@gmail.com> writes:
>
> > Subject: Re: [PATCH] sparse-checkout: optimize string_list construction
>
> It would have been nice to see [PATCH v2] or whatever that signals
> that there is an earlier iteration.
>
> > From: Amisha Chhajed <amishhhaaaa@gmail.com>
> >
> > Improve O(n^2) complexity to O(n log n) while building a sorted
> > 'string_list' by constructing it unsorted then sorting it
> > followed by removing duplicates.
>
> By the way, do we have t/perf/ that substanticates the performance
> claim here (in other words, how much improvement are we expecting in
> practice)?

After running different perf tests i was not able to find any
substantial improvement in the results output before and after this
patch, after going through some perf tests i came to conclude that for
the results of this commit to shine we need a perf test that tests it
with many duplicates, thanks to inputs by Derrick for further
confirming this and giving me a starting point.

> Also, have you found out why the previous round that did not remove
> duplicates saw no failed tests?  Perhaps it is a good idea to add
> some test that would notice if we failed to add calls to
> remove_duplicates in this patch?

Yes!, actually we don't have a test that covers the line which removes
duplicates. I wrote a test locally which fails if duplicates are found
in the output with duplicates in input, very similar to what Jeff
wrote for reproducing. I will create a patch sh

> This is an unrelated tangent, a possible #leftoverbits material, but
> should not be part of this patch (or even in the same series as this
> patch).  I notice that string_list_remove_duplicates() almost always
> immediately follow a call to string_list_sort() of the same
> instance, which makes me wonder if we would be better off if we had
> a variant of string_list_sort(), and call it string_list_sort_u()

 After running command git grep -n -e "string_list_sort" -e
"string_list_remove_duplicates" -- clone.c fast-export.c fetch.c
help.c pack-objects.c sparse-checkout.c
from builtin/
i got the output

clone.c:1139:           string_list_sort(&option_recurse_submodules);

clone.c:1140:
string_list_remove_duplicates(&option_recurse_submodules, 0);

fast-export.c:1121:     string_list_sort(&extra_refs);

fast-export.c:1122:     string_list_remove_duplicates(&extra_refs, 0);

fetch.c:1370:           string_list_sort(&refnames);

fetch.c:2587:   string_list_remove_duplicates(&list, 0);

help.c:159:     string_list_sort(&keys);

help.c:199:     string_list_remove_duplicates(&keys_uniq, 0);

pack-objects.c:3852:    string_list_sort(&include_packs);

pack-objects.c:3853:    string_list_remove_duplicates(&include_packs, 0);

pack-objects.c:3854:    string_list_sort(&exclude_packs);

pack-objects.c:3855:    string_list_remove_duplicates(&exclude_packs, 0);

pack-objects.c:3899:     * string_list_item's ->util pointer, which
string_list_sort() does not

pack-objects.c:4141:    string_list_sort(&discard_packs);

pack-objects.c:4142:    string_list_sort(&fresh_packs);

sparse-checkout.c:97:           string_list_sort(&sl);

sparse-checkout.c:98:           string_list_remove_duplicates(&sl, 0);

sparse-checkout.c:296:  string_list_sort(&sl);

sparse-checkout.c:297:  string_list_remove_duplicates(&sl, 0);

sparse-checkout.c:320:  string_list_sort(&sl);

sparse-checkout.c:321:  string_list_remove_duplicates(&sl, 0);


There are many places where string_list_rmeove_duplicates is directly
next to string_list_sort, so it is a very common pattern

Thank you.
