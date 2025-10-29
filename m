Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE082F12CF
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779618; cv=none; b=NNfVoZVHlXgrvehLH8hlBb7IpFSTcxrpSKQSMjIJPN1edxD+Uzg6NDkwIpfUaWviPT9WECR0Oth14pE7NUAluEqqtd87p+uo5xX4X2RvGu48u8LDV6Oo+XFpGGhsp7fZdyTARa3JLeyh2iqyKAErUtEo7NsKd0f9XjAFPHaTGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779618; c=relaxed/simple;
	bh=rebjlmVqAJxvKwRWmimJj6X1rvTxXbxe5VENLrrx/VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8br3ZZpO3wgs7ZhT27f+BC8Ohy2H/4w2J9IjzH2W0ifPABjDt73YXLaxZDJOJAunbQADcQ1/wymCGdna/Vd3N/Zf0egzE++NCpZy45K2vsusxlcokVRftQ5qDAWnQ/WLcZvxIzZzDPTd3y0ZS2JqqEzIPp98EPCaQQ+Vs4tpbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=T+DVVkEu; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="T+DVVkEu"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f5c80eebdso623860d50.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761779615; x=1762384415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KG10oW37/ha9gDjzmBMHC7sErM+pjFXkQWisWR76TFs=;
        b=T+DVVkEuhQ3HcG5khVKAv6gVN+F28nGSttx3uOvmPwtbiTF7vjpU1AUV/gHBJuYEFQ
         VDDuf8Edd+qgn1UCLfurUvBMUyDEBNkOlBFmSfh9Rd8cfynxok/EdjS+B9sjhyBNKBVE
         VEiJLiO8EWQ0L48Em3vLV1LzP42hvDxF6sWzxwFlsZaxlE1ED5X22lYHAMxcqPvpGWQR
         1b5/+Q0GKlrL3CTr6Iha+0RFWuQ05b00em5pqnMXzO5GCmq43k8fwGKP32VGidWxKvYP
         SM0yVBIwvsOEm4qQGOvcefQA/1oZJO9U5RVuhl+lVZWdfY0w42/ZdMbaUW3qgZni4sGV
         pLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761779615; x=1762384415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG10oW37/ha9gDjzmBMHC7sErM+pjFXkQWisWR76TFs=;
        b=HPd939Pj4T44uYFtzL7I+kWFQ7RSB/oJUXfkCqSuWR6k8IUD/xIHPt7aFX1O+D6FnK
         AYJS/4HpyTwDDo67hekFnWL2IuBgomkzlpbbW+4YtQvt80/hdWYIxt8zlgmPq6sJSzFS
         SOcJCV7aXhlt6eeLzXTltJGUaqQJaDAta0kgePB/SRslku75eBT8VdnqaZWRrdXNtvHv
         FF0rN/7h0Oz7P4fQ+4cAnMq6EmrbMMeCji8eAaTzBjRjDt8tXuGaSQFjWhad/V3o21mJ
         53m+zmdRKr8qwPtsDoWxGztT29MHfw5ek7TeLMTPxjKq59BHjCut3rhsUw34Z/PkvGI8
         GWUg==
X-Gm-Message-State: AOJu0Yx1SiKzjrt6Zl7jiIjBn5NIqnsYwj/d5wOF5fexFI7zj733bsh3
	vf1nzmUrGabEakHw/4gs7pfXGAvyKIBRQxL9bgij6lkiQoNzKDs4SMlqUTcjLyUO5FSzQpowh91
	CnUT6KuE=
X-Gm-Gg: ASbGncvDJ92Y+Tp07hwvFMSEhfMPNcsnPvTgkxkHwxua2dReu++IY3lwIG2potJFYLL
	zYRtY5vh3nnlTnozTKRfHXynHeV7bR4dRITCx+UZOPwuOAzsEQr1Wt0DUv6h0UIg6W3cGsP6FyA
	AjlQibL5Zrgy9I8939EhGWw0UiOvYxUXmYAiMkduvO9JpH3n9GWYVfH86oH4xa4guqObhgV3zYE
	cxv8pfXvcnmCwc0yRJEgmbmTZpgf+WJti9rRgfiUe5qzs7aA4a02bDgZ4pJfWD3quspM30l1yow
	hcBTkl8ywSzcmNIpZFPymi/Ajn7V51oeibEp37IqUdr2bPTCz6vzWSzpHMqq+wq/BW81/vX314b
	JkT86m85tfWhbkEwRvQmeKsuyKAADuaS+qmA4R6cb2UpfP2WAPgW4rosXugCDPUBJa/44xPztYM
	lwFJDtaSVwpxD9jD9CLwLDi96F5bIOcPTbOE6v4Fb8Th59RypST0Q5DFCNicORo/QaYjCJa3kYe
	ZUKgJE=
X-Google-Smtp-Source: AGHT+IGrRATy1glXqSL+LCnf+eBUfJ5cmpkNBYEgNKjwlJJb7aF53TRjUF1ga3el2r5EMja9gu/hkg==
X-Received: by 2002:a05:690e:d44:b0:63e:1b46:280a with SMTP id 956f58d0204a3-63f76e182a2mr3339092d50.60.1761779615390;
        Wed, 29 Oct 2025 16:13:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7863258aa00sm7036507b3.38.2025.10.29.16.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:13:34 -0700 (PDT)
Date: Wed, 29 Oct 2025 19:13:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] builtin/pack-objects: simplify logic to find kept or
 nonlocal objects
Message-ID: <aQKfnd2gWS2T9GaD@nand.local>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>

On Tue, Oct 28, 2025 at 12:08:35PM +0100, Patrick Steinhardt wrote:
> @@ -4388,27 +4388,27 @@ static void add_unreachable_loose_objects(struct rev_info *revs)
>
>  static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
>  {
> -	struct packfile_store *packs = the_repository->objects->packfiles;
>  	static struct packed_git *last_found = (void *)1;
>  	struct packed_git *p;
>
> -	p = (last_found != (void *)1) ? last_found :
> -					packfile_store_get_packs(packs);
> +	if (last_found != (void *)1 && find_pack_entry_one(oid, last_found))
> +		return 1;

This all looks right to me, since we only assign last_found when a pack
meets the kept-or-non-local criteria, which is good.

>
> -	while (p) {
> -		if ((!p->pack_local || p->pack_keep ||
> -				p->pack_keep_in_core) &&
> -			find_pack_entry_one(oid, p)) {
> +	repo_for_each_pack(the_repository, p) {
> +		if ((!p->pack_local || p->pack_keep || p->pack_keep_in_core) &&
> +		    find_pack_entry_one(oid, p)) {
>  			last_found = p;
>  			return 1;
>  		}
> -		if (p == last_found)
> -			p = packfile_store_get_packs(packs);
> -		else
> -			p = p->next;
> -		if (p == last_found)
> -			p = p->next;
> +
> +		/*
> +		 * We have already checked `last_found`, so there is no need to
> +		 * re-check here.
> +		 */
> +		if (p == last_found && last_found != (void *)1)
> +			continue;

Can 'p' ever be (void *)1 here? I would imagine not since this is coming
from repo_for_each_pack(), so I think it would suffice to limit this
conditional to just "if (p == last_found)".

Otherwise looks good. I think you could make use of the kept_cache here
at least for the local-but-kept packs, but what you wrote is definitely
an improvement in readability.

    static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
    {
            static struct packed_git *last_found = (void *)1;
            uint32_t kept_flags = ON_DISK_KEEP_PACKS | IN_CORE_KEEP_PACKS;
            struct packed_git *p;
            struct pack_entry entry;

            if (last_found != (void *)1 && find_pack_entry_one(oid, last_found))
                    return 1;

            if (find_kept_pack_entry(the_repository, oid, flags, &entry)) {
                    last_found = entry.p;
                    return 1;
            }

            repo_for_each_pack(the_repository, p) {
                    if (p->pack_local || p == last_found)
                            continue;
                    if (find_pack_entry_one(oid, p)) {
                            last_found = p;
                            return 1;
                    }
            }
            return 0;
    }

You still end up looping over all of the packs in the worst case, but in
the case where you are going to pick up a copy of the object via a kept
pack, the above should be faster since it will focus the search on those
packs first.

I'm not sure that it matters all that much, since at worst we're
interspersing the search over kept packs with some non-local ones, and
skipping over the rest. But certainly you could imagine cases where the
number of non-local packs greatly outnumbers the local, kept ones, so in
a situation like that I think the above would help.

Probably micro-optimizing this case is not all that useful, since this
only comes up when we are unpacking unreachable objects like with 'git
repack -A', which should be using cruft packs anyway.

Thanks,
Taylor
