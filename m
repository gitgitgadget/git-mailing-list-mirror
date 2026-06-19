Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22440D59E
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877944; cv=none; b=eOlnytn0ETi69seeyVikR54FV2BCmdttUfZsaZbbPqxoTXrEzrJiMvY4lIYTbqip9CamEYDcwFNlZju/2gehSC1xPzpJZ4xIgbnF/Cs19CUxw9gGxoEZAymywLSVdQXM6zRqp61fNV59egLjLpopjXOaPZeVB9NjdqDjJVCc2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877944; c=relaxed/simple;
	bh=LaDOvoAVOkHNg/dPI80OcSsdxlHMHinIXH0dC2c6g0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUi5T46TK7zGIYDgF6SIAiZEZXGqoXge820Y+zFiLlMTcaeePoQBMeW9DsSsQ9Aibk+XQ96RiAgjZ/NR7KGUqUf7tO9i0kd9otug5EW/UB/Or47gydEL4f7zXFvMQF5kUODtxG7Ceqwyc/WJTkB0BftIoYiX0fEe/z1EUcweb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=L7P7ih7Z; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="L7P7ih7Z"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6603d8697d2so2429625d50.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781877942; x=1782482742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eC7TUgxJkVOYXpqm6VIBjasCKsNMRdTr8hwByW/BVzw=;
        b=L7P7ih7Z9MXDSPG4KBjPA6Dlyl5/jfv5mjAWQs/6Yu5iblOJh/79z14qU4rd7tt71T
         J3nxp1vmPDDSdxPCAkWA1gRDHL+ZlYu9IVofYISzdaXf4sbMDutdpLmxsiinHE9lceey
         rOeNuyo+YS5BXhmn5DzMBFlKGZMxYCPf8sDWgp4XHc09Z9lDUs9Dih8zuCeb3wAE0BHA
         285r/eYV7cwyrR05ZWmOAGHe79us95mMc0KcxUR74dXj5XVlvG9Sz+tmi47xiGvxlPu+
         y4+AqkTM4/9qB6Sxlky8cKXGRhqXUKlaIG4mmTwSwqQbQ0CyUCvqIdUdK55tka0qOOK9
         AI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781877942; x=1782482742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC7TUgxJkVOYXpqm6VIBjasCKsNMRdTr8hwByW/BVzw=;
        b=lQhfNPSZ1vTSf+N79wpfwpYH+VpHCUO3B1BqwkjnC11zPpBUR64ykRA0If351ayGEL
         vkM/OAp8e92blv++6D/o9NivOIdW8ji96ryy5cu7s1FhD/H/kYhEgUJNQYZoV3TnUO7O
         ULOsXTyxThD7sOlhGz5H04nvbuUPV3OEsLduQ1nFs5kn52q300bIRxsl5OYRdGI7f/FL
         Dj/BGyJ3mYifal6+BBATO9o3vYtvOZSQinbdFPnj9zxF1MA17t2hkqCk2yCsZrt+GBr/
         fta85PRqMonf7DM/t+e8ie4vrF/hr1SLrP1jKuLhN7+vsBqN0x0pNHri+PetXAwF6fpz
         E9zQ==
X-Forwarded-Encrypted: i=1; AFNElJ8069gFE9aldeY6Vt7DXn4d8B3SqBuQWofF28LXPs7kAllsKl7AIsyCiBCwAdES9raH2Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjB4K+6NzIkruHJdvFQPdso4DYIAZ11X7/H3bIkzAARR08ZlNF
	BPCsyiXR2D+EmNqXdApUqmIJPHC7ENUO5zBQ56uYow3qUYIgFxdbAAibrYXbA79Jdtpsks/hn4T
	PIOLC
X-Gm-Gg: AfdE7cn+KGm3inhk82jeru5Q9FJAaTp/lc9TqoVZiBUYvlmN85L6BGWQ5pT++JLGBpN
	gfSDr3GzMY1zbu34/+STL1Zyq2BxFVy9+pOQKlbu/yg10dE9MQlrgcMfMUvNTKlEy+bGd1plReg
	eWBS4HsJh6sgj1o9Gal9+wM0dhVFCQNeqIj56HnqRPtqVaviaT5c7QOxBQHPSUaZI+F/08PFwfl
	sju/AigMPhfckU8QhrrZ97tpfWayWen1j5xg+i/XFXxAF22Cuhx5O/kTM9Yj8SyTyf0ZQYkzcA5
	3rYhYcCKmunjx9USx2wdvmFXkFYdShHwNSxKH3K5Ncxb+F2HRKmqJqWzWsDJm6Htr5IOAQZhFW2
	9jS4xmxYzhD5nNpzIglU1Ioz7qYrNs7I/uQIpigM4UiiHQxsdhOTj0TVhsUOj74Ql8OnLZmZoxo
	CLt88PRmJk/UAHo9cBFy7r6q8Fkn5vwUFinQB5WwE6zcvCYf1dhYnfaNUILf6+zYbuAatq1ud0Z
	GzGNyrDXGHJ0hAgSlGd+9aGqqtxhSbr6MnBJYEo1qYaFniy5rQerb3sOmAbbBk8dlfHoNsDP8si
	0ndQ/iYivOVEaJAy
X-Received: by 2002:a53:b1c4:0:b0:662:b984:a5c0 with SMTP id 956f58d0204a3-662fc91c8afmr2949981d50.18.1781877942151;
        Fri, 19 Jun 2026 07:05:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662fdf2361esm1335728d50.13.2026.06.19.07.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:05:41 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:05:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] commit-graph: use timestamp_t for max parent generation
 accumulator
Message-ID: <ajVMtJ73EdBI52sz@nand.local>
References: <pull.2148.git.1781420271100.gitgitgadget@gmail.com>
 <ai-zzWn9Ls6-j9h8@pks.im>
 <09e50180-e165-48d8-a9d0-485283342f5c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09e50180-e165-48d8-a9d0-485283342f5c@gmail.com>

On Mon, Jun 15, 2026 at 07:44:19AM -0400, Derrick Stolee wrote:
> On 6/15/26 4:11 AM, Patrick Steinhardt wrote:
> > On Sun, Jun 14, 2026 at 06:57:50AM +0000, Elijah Newren via GitGitGadget wrote:
> > >      commit-graph: use timestamp_t for max parent generation accumulator
> > >      We found a few repositories in the wild with commits whose authors were
> > >      apparently on a computer in the year 2120 when they recorded their
> > >      commits. Apparently, in a century from now, some folks are going to have
> > >      a really weird timezone as well (-13068837), though the timezone doesn't
> > >      factor into this patch at all.
>
> > > @@ -1669,7 +1669,7 @@ static void compute_reachable_generation_numbers(
> > >   			struct commit *current = list->item;
> > >   			struct commit_list *parent;
> > >   			int all_parents_computed = 1;
> > > -			uint32_t max_gen = 0;
> > > +			timestamp_t max_gen = 0;
> > >   			for (parent = current->parents; parent; parent = parent->next) {
> > >   				repo_parse_commit(info->r, parent->item);
> >
> > This looks obviously correct.
>
> I agree. I was surprised this was the only necessary change, but
> your message clearly describes how the timing of the patch that
> delivered this change contributed to the mismatch.

Ditto. I reviewed a version of this patch before Elijah sent it to the
list, but this LGTM and is

    Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
