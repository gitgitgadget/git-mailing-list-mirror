Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5404C36A023
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351996; cv=none; b=AkE6HmkWXnkfKmNQxK+MvByH2eOiIp6cfbvs4uBEi9Me4uAupClTPXnkV0alvmlQJT/9aIlgWjKrGNVoR1KiLTAOjJeVFfL2b3BtWmkhcfBaOqmLVH4RCD4BnzCU++HxlFM3cVDB3j6xNYj3SnkqsOyCCFmFpkCdUXhmXNCq9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351996; c=relaxed/simple;
	bh=eABMjOikkykqce+XMjO2DAoi3tBneUrHq5AUYxYZGgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gsH+OJgMYuc50NlsPp0NYWXfc7is9016pStE2p7a+4Dhh8f/aQG+m90u/iNL6pm0Tl7wWlD9/wCwsd98roCif64SiESbSBu2HIFvaNFGASE4nj5uEU1qHvhCP2qIOJhl1pIdsDlNjPOKeiQK+czdepKFAq1iFUNgw8KkmYlY79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QaQQWM/K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VAExOkhE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QaQQWM/K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VAExOkhE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EE8ED1D000D0;
	Mon,  1 Jun 2026 18:13:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 18:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780351993; x=1780438393; bh=9nliETWsmV
	I7H5FyfNpVSP/J9/6c3FOLDjljWJZWODI=; b=QaQQWM/KLztBg1FI3ZEnDOCaw/
	8j8POKJIYLHPId+OAZmnOxrDOR6Qk3JDdfT+CVwqCePrkeGWPMYSFnMZAIW3wtKZ
	ejQjuTIG/ZHLcKQL3BmvGYATays1akj0Fp9a+3qh3cxPgLDZYg86m3b7GLuD1frV
	a6uCMDI+TAiPkdpgGnvVhaT7FG7haRQjyg5DLMCqaVVMWkFp23psWdgyxH8ZKuyB
	mFUJrUmTIrdrhgjiNQEoXNpGWTuKlpGcU2ygogVR0WIiMQFbUVCNi4bwhFnYOxOh
	nV2gVUXNqxgDa2kpdSWxog/g9YeFpAgyGq4G+bxpRIlBuSAkyWLflj86MN3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780351993; x=1780438393; bh=9nliETWsmVI7H5FyfNpVSP/J9/6c3FOLDjl
	jWJZWODI=; b=VAExOkhENGYivYdQoCb+N7ae3SElek3gty+LixpSbizupIo+jYZ
	yWtRW95IP5Js7M/I57l0nr82a5QIfScE/skmVzHg7JzbzOdxeqfJMVKvm2i7OwWx
	XtIZgtXomXdjoc3Z6E9FtyyUuU1G7uquG4GMsyUebiijb/qrdFqYpY5ZhLQbI8ZD
	pPLlK9UUXVlLR0j6GgOJmegXuNTBuz0mcug4iHkTcj/VCyscN1I7H7UlqMlxjHAe
	a5FSglYYwIXpLL0qm+oVQZnWVXCBy+xGbsiHkcNTASumLBoAElTOXxcCobPl8D85
	ckSbUuBovbIrZbXNHNkEdsI47u1lv5UC0ZA==
X-ME-Sender: <xms:-AMeaqMgHYLZHDrHyK74l8R2OQPsJATs0jiN3znFk0fBG5MZlGmnlQ>
    <xme:-AMeat4Mig9-Y-dmLKtusI8LvtXVzxnGiCVyrkno96kw8zfAZKQvrPY2PLFogQ8Bc
    O2M0-OHGI0jkO5Mv59V9S1YGqeBx5uyKKWBMr5Sl2OTdzkRGHXzOQ>
X-ME-Received: <xmr:-AMealgef4fG4hPrDeXlSlXXjM4k7sO0Uii9Fe4rWaYjHp8nLgEXD0FLfiLOAdorXk5C5EX5Yk8PqygUWU9U08Znh4gAKvaSdDpt>
X-ME-Proxy-Cause: dmFkZTFFFEpdpFsm4hDyd4z50odkEKWbfVGDmFam7Dp/MC1dtI3Wqa6t524wADOweGsi9A
    7oAkdauHKzRBnIYBINs/HdHLXTvJdrcckhedHtBxeSsLzmlmkxYpQiY7LwFXFpWhrFIvHw
    J0fgz0HR9G07jYnmIqApSnsNqx8t6gdaUpnoypUynCVbZ1xndeUoARMY4Sf1HlDU8Pr01Z
    bo4iuDUwY5qIcJVZwvbNKwH4yBkvdPv/L8ZMbnL6ekpTnxq3fOhtSdUdYWNvbm55VLebSI
    Q/3g0OCqtBucaQ9mRDnVSYf1BDxgUjhcMqHCsS2Z3SD4zjr3/J4QoYsT26Gm7Gxn5YcUNG
    AgToKFUVEGTZY+H8U2O/Ls4ZOTFT/FWFtduhJLRula/hfUosVcRQjxsGQDDxjDP3b//OE6
    Uk5CKMSdjj/wegQ73Tk3VNQ9M01RU6pacdp5q1zXtFkgOA5tMNepxkyCN3Ut/d+By2Ppot
    J4zhGfPGJ+IGxR/Q3b8trRvYjaPmikppS76oRwI28fIQFHgXLpdDN3tzlXdsFN2rYjz0/4
    BHmDmNnVr1Xbsia0bmTwaWX/l0AdYN+8+1+iK+OyMGoJSMyOz0JuRydZAyV3LW4Td5c7w4
    nkwJC4Mw9piMQi+vJ/Avu1WbEUIDtcD9pH1fig7CWMz8lkYxgM0rfkRFNA4g
X-ME-Proxy: <xmx:-AMeaqexJEHsvCARFxtmE2_-IDfiOUrTpofIKjKOb0rRFuG7DBh3fg>
    <xmx:-AMealyqNhXjzUNm_EWhvSRgKeFpJA2Vav2dkJeEVKW2Lf2Acs8CzA>
    <xmx:-AMeah0Y8XGqle0x9QuaD1WYYE7zPVveS2Z1vGwGk8ox5LqFhAepDg>
    <xmx:-AMeajyLs_OKGqMpZlUuEmM5RXFz9lxHpAQB-IODPV3B0fgnIviR-A>
    <xmx:-QMeaqCflajuOr8LLJRTiNw_gPgTdykqIl8GE0zFvUXcUFxl3JpaPIO1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 18:13:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Stagner <ask+git@howdoi.land>
Cc: Ian Jackson <ijackson@chiark.greenend.org.uk>,  git@vger.kernel.org,
  Christian Heusel <christian@heusel.eu>,  george@mail.dietrich.pub,
  Christian Hesse <list@eworm.de>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land> (Colin
	Stagner's message of "Thu, 16 Apr 2026 23:50:21 -0500")
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	<27104.58166.993109.63505@chiark.greenend.org.uk>
	<a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
Date: Tue, 02 Jun 2026 07:13:10 +0900
Message-ID: <xmqqv7c13o5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Stagner <ask+git@howdoi.land> writes:

> On 4/16/26 08:25, Ian Jackson wrote:
>
>> FTR Debian supports multiple options for /bin/sh.  The shell in
>> question, with the limit that's troubling us, is dash.
>
> Correct, I experience this behavior in dash.
>
>> Why not run the script under bash in non-POSIX mode instead?  I think
>> that would sidestep the problem. 
>
> Our coding guidelines favor POSIX constructs over non-POSIX constructs, 
> including for shell scripts [1]. POSIX helps us stay portable.
>
> I'm not convinced that adding more shell interpreters to the mix would 
> be a net win in terms of stability or consistency. This patch series 
> addresses issues that arise from different implementations of sh. Adding 
> bash vs sh to the mix will probably just make more bugs.
>
>
>> If it had been me I would probably have used Rust and libgit2.
>
> git-subtree has been around since 2009, so you would have first needed 
> to invent Rust. :-) That said, a native Rust version of 
> git-subtree-split would be much faster and easier to read.
>
>
> Thanks for looking at this,
>
> Colin
>
> [1]: https://git-scm.com/docs/CodingGuidelines

So after this message the thread went dark (except for a side
discussion about rewriting subtree in Rust, which I do think it is a
good direction to go in the longer term).  Are we still interested in
polishing the original patch further?

While I do agree that avoiding bash-isms in the main part of Git and
sticking to vanilla POSIX has merit, this particular one seems more
like an artificial limit imposed by dash than sticking to the POSIX
as the common denoninator, at least to me.

I am tempted to mark the topic as stalled, to be discarded for
inaction, but thought I should ask first before doing so.

Thanks.


