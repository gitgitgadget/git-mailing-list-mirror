Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7E3368A2
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906831; cv=none; b=Za06ja8EYPiZGmGpL4qVd4OZZw83asnbGdJnI/wzcyGtvtkqiSeajwXwqEI84pbaPVDAHzixrTCV1v2NWF+M5PUgWsiNmEHQ4O/LX9ak/v12KKjKsMqqeyzVRLYglPyxqYYnjmP7UMCVQB8YHbBMmfI9C70RAmZNbGYaYrKe/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906831; c=relaxed/simple;
	bh=zvjZf+cqVS6E1OLfyGbs/6ut1/Ylg9qmn6UkClieNb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFx7ccjvj2Y0R4mheQ313qIwJc+0ePO8lfXvMgbghJK1sk43cPVdTIPwA+IYG8Odj+q7qs6F5pl08fiXfF6N0xN82vwbisYy1M1lei7Dx9OrKJiOAhYWNrAuMMJvn1kMsUnL3aJMvH3B4vZ0VPjURFFSOsRxF9GB/CQfh6pRr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QlUs8Y4f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjXznuMe; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QlUs8Y4f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjXznuMe"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E6C711D0007D;
	Fri, 24 Jul 2026 11:27:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 24 Jul 2026 11:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784906828; x=1784993228; bh=Ct5/shxcDs
	HOvOy4nYKFT1drG/eMJjvNCWMkOZ/5TTA=; b=QlUs8Y4fAT/iDclbCfivLHBaW5
	TMZZqTO6o79YW/6T5++f8DGTbrcwEmw1gohABV9tKan2q196yX269fiDc8pD/gPx
	MhPZIEqfCYAsVe4PSpUuvcjf8BLMWG1wASu94GE1fmO5RR9xiUc0v/ZxlYdtME2G
	wE1fDD48lZx3qyghEhu4vtWBCYcGWTEg4kjnHPL51gWa61mFf/ZgArlIFc4B2p+z
	qf9UhzzEJ+BOth01DXTR7uzBKkxiCOL+C4QrMYKK19kIkVIFhlQ5Hb/9umGc1d4r
	DmJ/hwYliOw4DRiHWkXjEtgcQy0z3jqX1SDTPamLutri2bbnrJ0KhwaiH0Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784906828; x=1784993228; bh=Ct5/shxcDsHOvOy4nYKFT1drG/eMJjvNCWM
	kOZ/5TTA=; b=BjXznuMeJZWgHnlea18uTAnUNIo23uoEPc5Sv6ymC8zX24c/aL9
	DIbu7pGHEdvilnJ3F9u2o4x59hDEIG5+XLuaDdC7dnP8fqbRn4mecCjW2XKj+owy
	WC4l3aIoVKIWmHA/BWzaX0YMWedkU+yO8/AYRZJcjxhkKVkWeOOrnFDGSQwrWj3v
	yCqSBrBC2aWHG8FzrwHJVY+ZRAKklhCgXv+nxpFn7G96tiocGZQnUaEuqL9gdWVY
	Zm9sNVRYVUo3DLzOD24S5CjgSSdKxp1rmXTsU+B5murROSl0IL4oExqxM08z7fUR
	MOHBRKrsFhuQC7IlLJxV4eFs2r6vw97cYyQ==
X-ME-Sender: <xms:TIRjal6ol3pWLxQD4ghXNbT7RRVb-2uprR76BI9axODvgp7dyvo06g>
    <xme:TIRjap7krZGKUGO3psNW0UpNAzZvTv4BLn8k2J4RbN-NFFdmt2tQWsfAlhYLGT435
    -WOTgMMdZbg5hRGQ0Mu3Fc0HzcUbkkUhnJ1Zmf5m4_P41P9aCCxiA>
X-ME-Received: <xmr:TIRjahdZAnb3LYNAYivDjMpm5ujDKC4JXJJdHv6v3_mYoG4ZL-jTYNA_sXGh2auOuAMZ8GpYuBXwyu0IYn8ZSQFgGSzQ616RvA>
X-ME-Proxy-Cause: dmFkZTFcxXaEZ4XRuWvU0Vho9XQbb7jLNzT7q/cpM1A/Y4VFtXo1xNsFewb4H+rZwpbOaR
    ETnrH1bqEvdxGFcPF6J+11GUFBIbs/fxcqmIJMTmdO1fAXyz/tHzi11+PGAvJy2sFZct2O
    FUZIKVq4BxIBSUfSL08WX/xAhGTXLtYNALAwUltO0FSu/oSO8E9Y/cSbcoQ97Ao+w/d8Nq
    Z4b8FiDPbvswhpczECrtQxU6i4aRv4f6YcZgOUO9kpv4FK3KpogvnwEisHBUUe/n5PMnAo
    aEJw58d9mkhQdFNtYsU0g73fdvO3fwNlSBl0jGZB6oC4PBuNXhx7r6ZiUE5hmU/PNU5rcx
    y9Fvn2xugwUPgNlLLG48hbTpcMChf6CzTRc5WkXHbMt9mVecfSkDxiWZrspbO81y2sxJ8k
    mQRpFX10OhV+amg2+uQ6Y1K6TOH/zxV3L2qQk3Lrce4o4cjuhyKSVD/SKDN1EOmm2HEBz9
    rTyhH8trrcHY55xI6FtDKB5Z4hxTzp1ktHfiMot1ukFB6AIjZ4COHnEI12o0BWWX53Z6Gb
    1XHpinLsZpsEqbzVrG50xlI7yBljgT6xYIQi6qo5ARcF7Ab9njZzAbKhGQJgIncFr2D+pY
    o8Cbw+SfCmDfB1mK0cnH4sQ5bK4LIAXtRL+xQRThWvWKPTS9r373kXA78g4w
X-ME-Proxy: <xmx:TIRjatCmXkeFeWf2ybzag8iq008MLne50Dl9wY61AJyMGxeqc-0c5A>
    <xmx:TIRjak8cLUKDIvQosq7gyqA495kA5yWyiocbL9iBGq3kHMq8QNyGtA>
    <xmx:TIRjaoJVDp5eZWAFkIbYgr69f0wlRTeouLZER_RvxAajNVYRPz-9Pg>
    <xmx:TIRjathHsET7M9JhaBPZpn4BDjg-AVXHL6A65wtdlp2RPloOL_Z4Bw>
    <xmx:TIRjar85XOl4RCee4xBv4B78ocCELiVLKVqbsssJQoyJ2XdtRN3CYMBb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 11:27:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: tnyman@openai.com
Cc: git@vger.kernel.org,  haraldnordgren@gmail.com
Subject: Re: [PATCH] branch: avoid slow strvec Coccinelle matching
In-Reply-To: <20260724091152.27794-2-tnyman@openai.com> (tnyman@openai.com's
	message of "Fri, 24 Jul 2026 02:11:53 -0700")
References: <20260724091152.27794-2-tnyman@openai.com>
Date: Fri, 24 Jul 2026 08:27:06 -0700
Message-ID: <xmqq33x89zn9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

tnyman@openai.com writes:

> From: Ted Nyman <tnyman@openai.com>
>
> The --delete-merged implementation declares a loop index at function
> scope and reuses it to walk its strvec of upstreams and its list of
> candidate branches. Coccinelle 1.1.1 spends hours matching this against
> the separate_loop_index rule in tools/coccinelle/strvec.cocci, causing
> the static-analysis job on 'seen' to reach its six-hour timeout.
> ...
> The CI failure reproduces locally with Coccinelle 1.1.1: applying
> strvec.cocci to the original builtin/branch.c still times out with
> "spatch --timeout 120". With this change, the same check completes in
> 0.06 seconds.

Impressive.  Nicely analyzed.

Even though this is very much like bending the code only to appease
the checker, the resulting code is arguably better in this
particular case, so I do not feel as bad as I have on other
occasions when we had to work around deficiencies in our tools [*].

I see Harald already took this in the latest update.  Thanks for
working well together.

[*]

 * Here, I do not blame Coccinelle alone.  The performance bug is
   caused by a combination of Coccinelle and the 'strvec' check that
   makes it so inefficient.  I wonder if there are ways to make the
   checks in 'strvec.cocci' more efficient?


> diff --git a/builtin/branch.c b/builtin/branch.c
> index 42f2221547..2415a275ea 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -797,10 +797,9 @@ static int delete_merged_branches(const struct strvec *upstreams,
>  	struct strbuf key = STRBUF_INIT;
>  	struct hashmap_iter iter;
>  	struct strmap_entry *entry;
> -	size_t i;
>  	int ret = 0;
>  
> -	for (i = 0; i < upstreams->nr; i++)
> +	for (size_t i = 0; i < upstreams->nr; i++)
>  		if (ref_filter_forked_add(&filter, upstreams->v[i]) < 0)
>  			die(_("'%s' is not a valid branch or pattern"),
>  			    upstreams->v[i]);
> @@ -809,7 +808,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
>  	filter.name_patterns = argv;
>  	filter_refs(&candidates, &filter, filter.kind);
>  
> -	for (i = 0; i < (size_t)candidates.nr; i++) {
> +	for (size_t i = 0; i < (size_t)candidates.nr; i++) {
>  		const char *branch_refname = candidates.items[i]->refname;
>  		const char *branch_name;
>  		struct branch *branch;
