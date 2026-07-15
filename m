Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE92D0610
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097354; cv=none; b=aDhHG5Ev82qMpgdnxSH/J+SHW87DRJvyb9atMKkXOvYcEIK5J7qsRHacFn3ub2srx//oarhsUvaRrz1pee2mxIW47eY6CNC5N1i7IqDI3/DTV4NML09vuX4R4x2RsNq23zTRaZytELySomTb10rYUsME1CS0Rmmmfv7PiXLwhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097354; c=relaxed/simple;
	bh=1kN/Yx1J4nZoVYytknJnHUwwrlhXMLgSWgzVM/FpPSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMkoj5f4gWNUdVDp79z7rcxeI+PQhRo1muESgRnnS41zi6qf3RiM/Dq1uITa1Wwd2rDV65JfEpz8VgLzZ2VRvhsUX8mMzv3odDmOsCtR43wNcX3QaurvnQs3zdaB7VVCg0+33sQVfcHRp94Mopf8X8A8EU9lEYb1P35lbnAloYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I4PaQWVJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mF5HWG9Y; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I4PaQWVJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mF5HWG9Y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 835D81D00169;
	Wed, 15 Jul 2026 02:35:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jul 2026 02:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784097352; x=1784183752; bh=ptvZs3/tYQ
	f4HGyRkNBtCXARxR5g5f7NBKfwxqcwu6E=; b=I4PaQWVJlhCtlIvHVIIXljNKUF
	p/l1c2qD+uHJxsS5vQKxv+5aCZ7KhUMxojdBrnH1Y22B9VsX61ia10t4ADVYPSmO
	8aIiLQaOXkNAFz1gNfaJ4xoZtVIUhSlx3md3cSPRcw9NXoB+szMA3BbVHKjxQhKL
	S7AIxFuyzzTQCqsOKd47GycFsnVTUGaMoNGI+j6T8H4t0HTHxiqES6P7tGgf6jnt
	PQTVH9opxQfunsE1jFe3D1KxMoTpRM8a1ApO8RhrBT/8+Ljs9ni5D4hDilJlLC41
	FtaUEPfxZLD2500uiIibfUM2D7+2AK5mPXzc4xLvIljjNkxyNh9vD52u53tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784097352; x=1784183752; bh=ptvZs3/tYQf4HGyRkNBtCXARxR5g5f7NBKf
	wxqcwu6E=; b=mF5HWG9YCVfpcOAyjeVK1I0CWEyZmCjU41Z74+ly2E54DG2bzBB
	2pytqjzKTSCWZ2Fy85TxJcb21pzcYXTieiFtNBGZvwrwtr5Q/4Oqd9GTzLXbQXBD
	7VOCGSSQ97hXucdvI+in7oDSCXFy0/dBtWxNJV+h8Urpd+5h6ADkW3CMnbFXVwbY
	n/9gZ2TvuQULABBJmuDfu8DiszpBhbK9pGP1vw3fx9zfPg3jgsFP6ba0fUE5C57U
	UHeTm1b47ipzTOEehWXh/teWggdM1fvvMGVQIinyhkt3LRjlLSRkRHHasDb0G8Dp
	2nYN4vOTgQBmPnkjNxcyQbcyalxN08yGM9A==
X-ME-Sender: <xms:SCpXajNJXj8GfMmf5Sbem-Gdi8BgPDox9wshOU_KjuxiOWcM5U7sXw>
    <xme:SCpXagMBu2TbbtDibAm3AFcJdioq9MoJsPN5v32ou5oKjyem5uLDYHel2-7EUhW6j
    rR883Y1xvRFVojBri2RPkTXU0lCrGZBan042s9E92eI3Zc7SaWPTA>
X-ME-Received: <xmr:SCpXakj8j1qOFR6ZNwZfQ8IgUC74Wfj0sy-IwxRbrx5pnnA1veODrXmNfjLGadfMb69R5X9zXN3X03aUthwYJN5tlm0hFoclDfnoaG0-Uns>
X-ME-Proxy-Cause: dmFkZTFWhT92+MSvOgrteIifIKDhcyIGsuwcFk+iWeWTUs4IttsI+t+V467OCA7fF4EqyI
    h71gGUyHp6MSdL3XNOLWV6foCBY1++freVrcBm5cePt58Mth2Xsr8mhvBb8pZIb21dKni2
    gcic3bNTikoIl0cw0Lm1t++8KWMA9CvUdwwm1ULore0U+81dvWsuPnQql8HcWoRTCVK/2X
    VlURYcHT5DQyGeqLlFvlPLZ6svnOHZR6tlPk3YDkR+6WwwuTDmX7Whlv18v570w3RkMZmk
    /ecLLULYpjeRtTbL486w2djDUj3RWF5UHhsJD+xI7bigK8dSHSy8+Edaeg4z77Zqv+L8Q2
    eLWkKwkyNs3D6nBslh2ldJpYbAFWY1MwgPEsXYpSd3yUN31PD3bFGfpgY/Djz16At/OKPq
    TpmU44szCC4McvMfU10M/6I0aySbloUYtWvs2WWWTfoV5QYfUmidYJ8aw/Lt/DNrx1uKE2
    HHyjSxwJeEXAlyMNmZXLAguLWRGxNBfbSeCXQUOTfBnD+QlsqoGQsVyZX3TLYxmcAbF0Yb
    SnEbYuasFlTux/95xflHcHrpencdpG4Rv9pJb40sLexwtpjG7lKxLUsUVJqLEObq7hFoOb
    30tAYcDtpk9wVlooEddUOzKsWd7p7qMbAMj1+zy+bB5u6ppChbVGHPzo2rPw
X-ME-Proxy: <xmx:SCpXatuIBn2ZXOF2Vkt2XsAPX_DYH21gOlSpfQU8wd4maQcED87qYQ>
    <xmx:SCpXaqTbVXZCfY1ook6WHAhxHp0VemSLwBM89j0lNSyDT_s1ISpa5w>
    <xmx:SCpXap08YYtSFefyg3ip0YlFevphtNq84-FzTvB_XtvoS02vJQMEdw>
    <xmx:SCpXans4ci-QCChD42JL6GIRnPwphmeMIZngC6Ck70EL8a1AidBGxA>
    <xmx:SCpXajdN38-2sudhylz5P2k5NL1_kFS8zNcljPf2VrkNQETlol9HzLQO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:35:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17c152c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:35:49 +0000 (UTC)
Date: Wed, 15 Jul 2026 08:35:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, five231003@gmail.com, hariom18599@gmail.com,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v1] repository: move fetch_if_missing into struct
 repository
Message-ID: <alcqQp0lkwRIIE1t@pks.im>
References: <20260715011850.3181131-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715011850.3181131-1-cat@malon.dev>

On Wed, Jul 15, 2026 at 09:18:50AM +0800, Tian Yuchen wrote:
> The global variable 'fetch_if_missing' controls whether a missing
> object check should prompt a lazy fetch from a promisor remote.
> In order to continue the libification effort, move it into
> 'struct repository' and initialize it to 1 by default to keep the
> previous behavior.

Right. I was also thinking about moving this into a non-global scope
multiple times. I was approaching this a bit differently though: it's
ultimately a property of the object database whether or not we want to
accept missing objects, so I moved it in there instead.

I don't really think there's a downside with your version, though. Quite
on the contrary: we can really only perform the backfill fetches with a
whole repository at hand anyway. So conceptually your version might even
be more sensible.

> Subsystems that already pass around a repository pointer, are
> updated to read this flag directly from their respective 'repo'
> instances. For the rest, we access 'the_repository'.
> 
> Note that in builtin/fsck.c and builtin/index-pack.c, when running
> related commands with the '-h' parameter, the 'repo' pointer is not
> passed in. To prevent null pointer dereferences, we defer
> operations on the repo in until after parameter parsing is complete.

s/on the repo in/on the repo/

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 0793dc595c..721d576938 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1898,15 +1898,16 @@ int cmd_index_pack(int argc,
>  	int report_end_of_input = 0;
>  	int hash_algo = 0;
>  
> +	show_usage_if_asked(argc, argv, index_pack_usage);
> +
>  	/*
>  	 * index-pack never needs to fetch missing objects except when
>  	 * REF_DELTA bases are missing (which are explicitly handled). It only
>  	 * accesses the repo to do hash collision checks and to check which
>  	 * REF_DELTA bases need to be fetched.
>  	 */
> -	fetch_if_missing = 0;
> -
> -	show_usage_if_asked(argc, argv, index_pack_usage);
> +	if (repo)
> +		repo->fetch_if_missing = 0;
>  
>  	disable_replace_refs();
>  

Okay. This command can run without a repository, in which case we'll end
up just indexing the pack. My assumption is that we'll probably end up
using `the_repository` if so, as we still use `the_repository` in this
file. So could this here cause a change in behaviour?

If the answer is "maybe" I'd propose that we simply continue to use
`the_repository` here.

> diff --git a/revision.c b/revision.c
> index e91d7e1f11..bb645654c3 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2714,7 +2714,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->ignore_missing = 1;
>  	} else if (opt && opt->allow_exclude_promisor_objects &&
>  		   !strcmp(arg, "--exclude-promisor-objects")) {
> -		if (fetch_if_missing)
> +		if (revs->repo->fetch_if_missing)
>  			BUG("exclude_promisor_objects can only be used when fetch_if_missing is 0");
>  		revs->exclude_promisor_objects = 1;
>  	} else {

This one here also makes me wonder whether it could cause weird
interactions in case a caller passes a repository other than
`the_repository`. It ideally _shouldn't_, but it's hard to tell because
we still use `the_repository` in lots of places here.

Thanks!

Patrick
