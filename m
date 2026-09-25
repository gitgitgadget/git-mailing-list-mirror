Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8C3B27F3
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375923; cv=none; b=YnJ782T7UohnKbneApHN0CO7wIHpmaZ7m4qYb4xpBbwzNLVtqt+Tcabc74G/Ohbb9zJeD1FwNdeDi2J5Z0RyGQHN6H580z6OoUiUzrJjCtKl0ZEI6QDX40a5nWtujPsXRZNRDmJidazAOa0DoXK98giLaK1kc+lfcVaEzrMCZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375923; c=relaxed/simple;
	bh=BUKjNTSkVp4X6sERPh9Q95cE1BPLazkh7jmx/CJjUXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lPfGa5OLURp6kr1u6IKOK8MAkMk5pR09wBT3AO167Bdpu/nOi72kmBGM7sC4v31brnJXaQwlqv9Ut780+JoJsWIcjgQBD1zwHU2lZfp9xZloTBtod9kgfCt1gQF3NeIHETqxgPaA5I9f1tN46zGHzdBzMuLqiUZPMYCirAGP1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SfulH1FT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JX+a7HfZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SfulH1FT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JX+a7HfZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 18BF11400104;
	Fri, 25 Sep 2026 18:38:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 25 Sep 2026 18:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790375921; x=1790462321; bh=i7TkpzPJHv
	ic774KU6WsVqDHK1ArchzQqAYb/TVotSw=; b=SfulH1FTu/jwjKS7n4YVleWUtC
	WapmtSeNKO0spZrHga7Xx1dlg6qlBP4tantEIhS7Y97ya10UCd34xTbqmJBPdElj
	E5QABqGAJflX9xvT1NLt42I+BovQ2rUmAbGS65G1AosrYB066AY/VLECAaY/qd9m
	L+IEaFzw6TEBk8bOeSLYE9TMIe1QMxbGQtHAYbSnJDmHBOMofb+MKG3agRCzCXaI
	uEdydSZ7Ijr3ny9WTn76QeJRMAG457F4iGmeElITCBMDKmSEXYAlhkYWIYChLWVB
	MsAr4GlXXEZlzvLIiLA+wG6vgQR8bBOzPl/8m173RM+RQF4t4UUDGaXuBS/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790375921; x=1790462321; bh=i7TkpzPJHvic774KU6WsVqDHK1ArchzQqAY
	b/TVotSw=; b=JX+a7HfZHgF029I7ITrFi8DWi1fPt33CbdfuVt+kRW2aSxtO5C9
	nju3cH3OH9krQn5B1hWTK1Np1p3YEuU+oiwbXmo/ob9RAl+UQP/wQthJLnSQXN+S
	gpJ7Xs2L6FYdlmZkmH/86P0LYH6SWOYNHPJM1BWBnzXxXg7+ikjk1lTTrkPzC1X7
	NU88f4zGMFHeTYwOGugQxC8Y2baKV/3RnLCiDJkA/OyLZ+he9bBr8vPnNavLoKp/
	gQqGBx3TegPdlnfsirJudKYq1HqpM0UW4dAUGObdgMoLGR4BLnOsTuk5PlTe+4Te
	EpeinPhc69jDa3Uryusr/jbvK1j0dmxymzQ==
X-ME-Sender: <xms:8Pe2ao03GfVOY3lQnKHJ95fKoV1fzoYyaFT1QsDDH22VWFc3tHQ8Nw>
    <xme:8Pe2amyWEncGtI5IxYZaG6lWTd7SNXRhOCQ5g2S6rzx6ymEg4Gh7a8avwD0XAY0Xr
    iIwOathYH9Nnx4pY-688hBt1mKOv1oV6soGgalanOmspaWJn66CBw>
X-ME-Received: <xmr:8Pe2aqtuYgJ09Up3ix4ticB0Z765XZLhD7y6Dc_S-WzBqwrraPkh59vm2wh2rCa-bMvLBg-12uRk7rjJ-WsxVtamTlFrqbNjA_TN>
X-ME-Proxy-Cause: dmFkZTEX5jib8ib2M7V2sKzHl4SQugszZYICxp12nimEJCCisHn+tnb2ozTKCFzQ2P7Bol
    S2oCXaM/iKDYQsD1y9/pKd301YIrN+OyGfa6ewAra05PHB7eLFYfObWuxpUj0/lWzWa3Fu
    r33JBT0J/eWBjp+hzY87fRqG19S6PaH2fZ0d1gN34e4pTH/gs8ELzwvMR3BM8umTeZ0BVJ
    Z4Fnowl1+8d1qRenTpSKdumica+IrpyUx5Rz5sImdeCjsawel2jWWxzRXSqYyrM0xMPzrm
    uy3ry5a8jwcHrGa3dmjPo2kOVSE/eW3hrw/vyiQAZjqSxcOurejkqUDSXpST3viGKNo5L5
    ooGBIwgna9bQgl75G3gRbb65+Lwk6Mm3dPbrzz48Voq5O/aY+h2sdUT+zW68m4+Nv87kml
    LRiy+Vr5dryMZFrgPWGG0YZRgfJqCqqq9OQydJTku1Oow73A6YwjDKDgVnh5tyjKj3zEBj
    Ufyf871vTlmKu5X6+jZL01y7xs3k+B10ugLt6N4TfEksGaIqHumhvkljs2Xkfqjuwl8E9q
    gDTkljuhqIgk3BlFxl/12vKlbnZGgujGigKHfxFKqUbxUoui0TNK+6oU381doYZkyQJsPL
    rC/p1cSBy11DeFHwc4ODk4yAVHBWo6k2DBL++HvI66NRpf+SLrlOt8mBXBJQ
X-ME-Proxy: <xmx:8Pe2aoww6KaZnVotCJBqkmlknud5O0OshbhmBnbPrlKJAxu5m_1gcA>
    <xmx:8Pe2atBCADz-kf2q0AoCtiYgRDFLWx_nxYP5GCLPnv1oAwQCWh7q5Q>
    <xmx:8Pe2amdxE0_V8mpsW-hTPvnUdSEFwbINAGUSZwj_SqfdVri4bNpI2g>
    <xmx:8Pe2anlJJg4d6-FWYhSFJmIvuZ0B519_yVKmsJR_SdcgrplHXfI0Ew>
    <xmx:8fe2avaK2zU9MvLznZvmg9sV94SSFvE-yHV21w7x3Qy80n7HJ4FE80a0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 18:38:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 1/4] fetch: add remote.<name>.refmap
In-Reply-To: <b04c00b974ce488ea1eb82556040fb54c05dad5a.1790333402.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 25 Sep 2026
	10:49:59 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
	<b04c00b974ce488ea1eb82556040fb54c05dad5a.1790333402.git.gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 15:38:39 -0700
Message-ID: <xmqq5wztt0r4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add a per-remote config variable, remote.<name>.refmap, that provides
> the default value for --refmap the same way remote.<name>.fetch
> already provides the default refspecs to fetch. It only takes effect
> when there is something explicit to fetch, on the command line or via

This ...

> remote.<name>.fetch, matching how --refmap itself already behaves.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>

> +remote.<name>.refmap::
> +	The default value of the `--refmap` option for linkgit:git-fetch[1].
> +	Only takes effect when the fetch names what to fetch explicitly,
> +	either on the command line or via `remote.<name>.fetch`. See the
> +	`--refmap` entry in linkgit:git-fetch[1].

... and this made me a bit puzzled.  It may be a philosophical
difference, but I've always viewed --refmap=<src>:<dst> to "take
effect" whenever they are given, regardless of 0, 1, or more
explicit things to fetch.  It is just when you have zero explicit
things to fetch, 0 things are mapped via the refmap mechanism and 0
things are fetched.

In other words, what does not "take effect" when 0 things are given
explicitly to fetch is not the effect of refmap alone, but the
entire 'git fetch' operation itself.

    The default value of the `--refmap` option for linkgit:git-fetch[1].
    Used to map remote refs being fetched to remote-tracking refs to
    store.  See the `--refmap` entry in linkgit:git-fetch[1].

> @@ -244,6 +244,9 @@ endif::git-pull[]
>  	refspecs and rely entirely on the refspecs supplied as
>  	command-line arguments. See section on "Configured Remote-tracking
>  	Branches" for details.
> ++
> +`remote.<name>.refmap` provides the default value for this option, the
> +same way `remote.<name>.fetch` provides the default refspecs to fetch.

This is perfect.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 533fdfe7d8..7651b41139 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -509,6 +509,8 @@ static struct ref *get_ref_map(struct remote *remote,
>  	struct ref *rm;
>  	struct ref *ref_map = NULL;
>  	struct ref **tail = &ref_map;
> +	struct refspec *effective_refmap =
> +		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
>  
>  	/* opportunistically-updated references: */
>  	struct ref *orefs = NULL, **oref_tail = &orefs;
> @@ -552,14 +554,14 @@ static struct ref *get_ref_map(struct remote *remote,
>  		 * by ref_remove_duplicates() in favor of one of these
>  		 * opportunistic entries with FETCH_HEAD_IGNORE.
>  		 */
> -		if (refmap.nr)
> -			fetch_refspec = &refmap;
> +		if (effective_refmap && effective_refmap->nr)
> +			fetch_refspec = effective_refmap;
>  		else
>  			fetch_refspec = &remote->fetch;
>  
>  		for (i = 0; i < fetch_refspec->nr; i++)
>  			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
> -	} else if (refmap.nr) {
> +	} else if (effective_refmap && effective_refmap->nr) {
>  		die("--refmap option is only meaningful with command-line refspec(s)");
>  	} else {
>  		/* Use the defaults */

Looking good.  One of these days, we probably should reduce our
reliance on the file-scope static "global variables" but that is
clearly outside the scope of this topic.  Perhaps once the dust
settles after this topic stabilizes.  I wonder if most of them can
be added as members to "struct fetch_config" and then we can pass
one instance of such struct around in the call chain, or if it
needs a lot more involved changes.
