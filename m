Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858B133406
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272900; cv=none; b=Yo4SutGFHXD4H1g2TPtQMRqCwUmhOvmV6ywcrfH1YtFIgALKOStP43MbYROavDMvp+0P/9CXGKxwMNAfT/pimgohlTINj+ypO/25LwK/gzC0ycetzRU59Gjafa4jSAX++0jb0F8zZNrCuoILkVo6/X+A8z44RPvg5NRJS38aSRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272900; c=relaxed/simple;
	bh=ZLxoQJ/7WjaaxgFh/CPlPf6CbomBVCS67KSzPtRbK50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frmhdabGfbrgd5IjX5rZC7bZmJvXfC0rqW5Oqm/pZkHFMrzOKjDiR1Bl8VlvZzoT36r2KASvNwFkzf+uqN09MBs6a8VQZZ0KMMn5dJ/Tn2R8J4bBU7RBUcuyOQN0RAYTb6NlnDhFIyIdKrixLlPbgSmSTHvsR6BzW8uDXf3eByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVyZUg5Z; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVyZUg5Z"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5295e488248so978365e87.2
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718272897; x=1718877697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C6EYadT3LHhQeiBAAultJBEV3FGsNlhH/iKOsI6v3sE=;
        b=aVyZUg5ZgtVgDIA8q8wyNiv2+XQAP2ve3zMSo4aqPd/VY8H/5EFcR95/Zz9JhKhcoe
         uqKxxVX7wY3oNO5jHAkm8aB65EYMEM2IfQ71mJWkLs4bqRi68KDSpIc+7pRTD82HWGs+
         LOd01n10maEHmLeNtjqiHchhe5NA0SZPRuE8imT/5X1YQe/8LIoDcuwxMYIgasS8qY7K
         0d9clvB8+USinP5hAxeENwO6tOxjrscm0TPvBq450HF/QH7QMR+O4eDhDqC2xraMZAvo
         xqRRQZ+QjoqpiZagbjsM4h1UE/ybCmMrnQ6cghsiIpJApYCG9NRFeUJ04l6Vbwko4Dya
         V7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718272897; x=1718877697;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6EYadT3LHhQeiBAAultJBEV3FGsNlhH/iKOsI6v3sE=;
        b=iz/y/Bep3bvjFbY8O80ddNut3wkgECde2GENEiEJcYZ1XQISIUw0hk8X13z0KX93CH
         O13YjPkUyzylbRM1nuRE671zH8oGbbYvirIa6DDV/Eahfx3TMKCJDWc/cYDSnhZ4dDmg
         E7l6XHrPy04j30LmKicQeV6evwi+6sCRDyUVu4UNv8muskLUbIqWY2RtVgqsbrxHkSSg
         w5UrQKaLF0dOFgfdduWWaRspmrTq3dYYqv6actQeQvPokLmP89nYBtfOfge0i7x9ELjI
         GSLXUYfbtzGHUlWgcVEjCG5+xOQnJh606qBc7/R2h1FzdonDU9gCOmEVG/y2BJJUTVw6
         lVhw==
X-Forwarded-Encrypted: i=1; AJvYcCXT+rLTYpd1TY4usVKR2h+OnwQiJ58sIHdi6ejAA9s2r1nFeE1azHe1rJ1dNZ+EQ4QLPCG9auJ35Nzqdo19d4qP78Ka
X-Gm-Message-State: AOJu0YzQRI5wuyXaz78hT3kDWsGwI082pJ/mEgwXamu39cb1paMR8Jp6
	AdckRWwivsnHp/4juRyTX8vuZe9p0R/2p6ASgNEkXLSP4CrevM8N
X-Google-Smtp-Source: AGHT+IHNVPQL41ZND8rvu04FCBbiT1xPfcH0oWVVRxa9+7Vgzo/3emQrscjadO/c+QvwAxyEcQ0kFA==
X-Received: by 2002:a05:6512:3b27:b0:52c:9731:479c with SMTP id 2adb3069b0e04-52c9a342e47mr3298585e87.0.1718272896548;
        Thu, 13 Jun 2024 03:01:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-422f641a666sm17916645e9.45.2024.06.13.03.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 03:01:36 -0700 (PDT)
Message-ID: <66763b5a-3ea6-481f-b4d3-5fad76f5da0c@gmail.com>
Date: Thu, 13 Jun 2024 11:01:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 08/20] hash: require hash algorithm in
 `empty_tree_oid_hex()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1718106284.git.ps@pks.im> <cover.1718259125.git.ps@pks.im>
 <4858cca25fe9e57c984fc3181fe8498d0b7222b0.1718259125.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <4858cca25fe9e57c984fc3181fe8498d0b7222b0.1718259125.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2024 07:14, Patrick Steinhardt wrote:
> The `empty_tree_oid_hex()` function use `the_repository` to derive the
> hash function that shall be used. Require callers to pass in the hash
> algorithm to get rid of this implicit dependency.

Many of these call sites already have a repository instance available so 
don't need to use "the_repository". I haven't checked but with these 
changes it might be possible to remove some of these files from the next 
patch.

I've only really looked at this patch in this series as I was just 
checking for changes to the sequencer code. As for the series as a whole 
I think adding USE_THE_REPOSITORY_VARIABLE is a good direction.

> While at it, remove the unused `empty_blob_oid_hex()` function.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   add-interactive.c      |  2 +-
>   add-patch.c            |  2 +-
>   builtin/merge.c        |  3 ++-
>   builtin/receive-pack.c |  2 +-
>   hash-ll.h              |  3 +--
>   object-file.c          | 10 ++--------
>   sequencer.c            |  2 +-
>   submodule.c            |  6 +++---
>   wt-status.c            |  4 ++--
>   9 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/add-interactive.c b/add-interactive.c
> index b5d6cd689a..a0961096cd 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -557,7 +557,7 @@ static int get_modified_files(struct repository *r,
>   		s.skip_unseen = filter && i;
>   
>   		opt.def = is_initial ?
> -			empty_tree_oid_hex() : oid_to_hex(&head_oid);
> +			empty_tree_oid_hex(the_repository->hash_algo) : oid_to_hex(&head_oid);

The hunk fragment shows that we already have a struct repository 
instance in this function which we should use instead of "the_repository"

> diff --git a/add-patch.c b/add-patch.c
> index 814de57c4a..86181770f2 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -420,7 +420,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>   			    /* could be on an unborn branch */
>   			    !strcmp("HEAD", s->revision) &&
>   			    repo_get_oid(the_repository, "HEAD", &oid) ?
> -			    empty_tree_oid_hex() : s->revision);
> +			    empty_tree_oid_hex(the_repository->hash_algo) : s->revision);

It's not obvious from this hunk but there is a repository instance in 
"s->s->r" which we should use instead of "the_repository"

> diff --git a/sequencer.c b/sequencer.c
> index 68d62a12ff..823691e379 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2263,7 +2263,7 @@ static int do_pick_commit(struct repository *r,
>   			unborn = 1;
>   		} else if (unborn)
>   			oidcpy(&head, the_hash_algo->empty_tree);
> -		if (index_differs_from(r, unborn ? empty_tree_oid_hex() : "HEAD",
> +		if (index_differs_from(r, unborn ? empty_tree_oid_hex(the_repository->hash_algo) : "HEAD",

The hunk fragment shows that we already have a struct repository 
instance in "r" which we should use instead of "the_repository" here.

> diff --git a/wt-status.c b/wt-status.c
> index ff4be071ca..5051f5e599 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -641,7 +641,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>   
>   	repo_init_revisions(s->repo, &rev, NULL);
>   	memset(&opt, 0, sizeof(opt));
> -	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
> +	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;

The context line above shows us that we have a repository instance 
available so we should use "s->repo" instead of "the_repository"

> @@ -1136,7 +1136,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
>   	rev.diffopt.ita_invisible_in_index = 1;
>   
>   	memset(&opt, 0, sizeof(opt));
> -	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
> +	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;

We should use "s->repo" here as well

Best Wishes

Phillip

