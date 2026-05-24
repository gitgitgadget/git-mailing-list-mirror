Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F35222580
	for <git@vger.kernel.org>; Sun, 24 May 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612612; cv=none; b=XvjS+C+7p+Qm6w3/i8VK1KuAShWYkMCn3SlJ7YWrcficqbKJqzimLXxq7UaxP4vvlLf0BMfC4qXJcVWnfgn/lItzQAlwDmI37feMY/r6DSHkJkZEUQd4SugTBH0meb0g7ZVS0Gf6Smi1T1WIcD/ynN8a1g0aOmDZ0NyP7AvVbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612612; c=relaxed/simple;
	bh=cO84m8PdtsrgAKJbDmTUCEH6xmMLLrMAQV5F4HOBrqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=metPzTpM2qvGM0iAm5uz8szHHcLKj4iHj28aEZyU0Zw+HNMAd5dyZWHJo1ElXOobz003Uy+yqWCvKETTBPmFN4V18l4hKgUg/fCTb1pll3fzsyiIDJ6806UMvzA42Gfsh4/zw9D2jdPK8B5OhUQUkl7tqWGsVzl0//aRzhhvTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CcJbRQez; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XSP/Jb0T; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CcJbRQez";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XSP/Jb0T"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A56FEC0128;
	Sun, 24 May 2026 04:50:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 24 May 2026 04:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779612610; x=1779699010; bh=smkvBg9Fch
	ZeUh7S+IzSGz1V6JDo2bPyBxHuFTg9/44=; b=CcJbRQezSE9ri5VieNMmPVjpd1
	nHaXlmg6h8bvoG8jbH88IEWxWPMrwiSAf8ZhmM18dHzfitqWe4Tprlm+9z1pl5cD
	6cOHCZf2w6UGo6sKjkXoTH3QgvMu562EUNz/mLWlpc9dJQW7xUP5pDQyeXw2zrfn
	PoLdEETpy179FPmSGLbxHI+Ln1+4MZrjjVpCC2vKkrF9tKys6bVmthFzPAvct46W
	oKIZiki0SoTstL731/7jT85O1WxkzF8xZy+Tv4lCJ2Cr4zxJYf2VQT+4xMXHDbw/
	rPFNXMiu4geJgKCxeKPwx58ZEJNhy9et0kVvPLvTnMG2hHu8NO+ZJpljBq6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779612610; x=1779699010; bh=smkvBg9FchZeUh7S+IzSGz1V6JDo2bPyBxH
	uFTg9/44=; b=XSP/Jb0Ty07G2i6y4oq04AgejbFOeEFh4mcjO3w+u3xVAAJhz8K
	3ZxeFH+sWJmKQETqpSZoNswkjFAFeskEWucUp1x+HoZyE2jEomjT8pmq20SAziLN
	rGGdzaIw0g0kyMd6G9/ecIHcOtO3gm1HMeIqPNl0E7c0VAeC4kqbB7YZmHiTO5MB
	ATsZdof94gCWV0B0ECUH1E0UkS4Dn0t7L6CE1MfNCj1PCGg4CKTiG1FbQwsbfMUh
	wMLTRvsmtlsWg486ASIFzPd7lRyC6eRuUkbQ8ct/vqm+o4wP2QT1q5xFX/6Y0x/3
	t2Ndkxy/fDPiznDaPW7yy7PMIEaewIa9V7g==
X-ME-Sender: <xms:wrsSaiUb-vsawo0SdNj9ZIZ4nWajiPQSASr_spVIA1YRxhRbN-4hsw>
    <xme:wrsSalmNK330HqzbtPiNdxj_gsB3n60hxSq4snQ3oE1sPyI7gvLxrlPu50bSS9Afd
    WmBNWDo57VKtsaZhjNb4_k2RpNml3GHLYVyD7Q7Rtf38EQOtndJGg>
X-ME-Received: <xmr:wrsSarYyf1ZLytuQQLOd1-eTZg3UOn2uDAnoWsQ3l_EzrYb0hiUgHWceYkLy0RMOr8XhWfBwV3xuubpec9_Pi6iWKXuChVh7NOoj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheehgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhmohhnthgrlhgsohesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:wrsSaoMpoIjk_9nceVjesSz4ExsYHb8_7pf4c4k2H_nTxd5fUt3leQ>
    <xmx:wrsSaoaUgp282bj0YVHl6cu_Z3Lfq8EuTPvyhIFd75uC_peuD8KwCg>
    <xmx:wrsSau3uJ9CkmYt2ysPGZW-oX1jvfKqxJ7Uhck0TLmUkdlnW6eC9MQ>
    <xmx:wrsSame8ENIEsxsLKHIKPUZNdl8vO50G91dx0oH8lc-MqzUKv81LSA>
    <xmx:wrsSam6YooQolFb8Qp9_4UNNmZDhdmcYZYimfbJP9Ku5gjiSo6wNCfiZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 04:50:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/5] xdiff: support external hunks via xpparam_t
In-Reply-To: <CAC2QwmKkwnr+TvLDnDuLEvGJeoraB=_YWC6idA57dxUqQ_5Fcg@mail.gmail.com>
	(Michael Montalbo's message of "Fri, 22 May 2026 12:06:37 -0700")
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
	<8c0ea0bc0742651e634db7a3002e8cbe1240acf9.1779415884.git.gitgitgadget@gmail.com>
	<xmqq33zkui4q.fsf@gitster.g>
	<CAC2QwmKkwnr+TvLDnDuLEvGJeoraB=_YWC6idA57dxUqQ_5Fcg@mail.gmail.com>
Date: Sun, 24 May 2026 17:50:08 +0900
Message-ID: <xmqqtsrxi43j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

>> > +      * Clear changed[] arrays.  xdl_prepare_env() may have dirtied
>> > +      * them via xdl_cleanup_records().  The allocation is nrec + 2
>> > +      * elements; changed points one past the start (see xprepare.c).
>> > +      */
>> > +     memset(xe->xdf1.changed - 1, 0,
>> > +            (xe->xdf1.nrec + 2) * sizeof(bool));
>> > +     memset(xe->xdf2.changed - 1, 0,
>> > +            (xe->xdf2.nrec + 2) * sizeof(bool));
>>
>> This, especially the starting offset of -1, looks horrible.  The
>> internal layout of xdfenv_t might happen to match the way the above
>> code expects, which is how xdl_prepare_ctx() may have give you, but
>> it somehow feels brittle.  I guess the assumption that changed[]
>> does not point at the beginning of the allocated area (e.g., it is a
>> no-no to free(xe->xdf1.changed) or realloc() it) is so pervasive that
>> it cannot be helped.  Sigh.
>>
>
> Agreed it is ugly. I wanted to make sure the entire changed[] including
> sentinels were clear as a defensive measure for downstream callers
> (xdl_change_compact). I agree this results in something that is ugly
> and brittle, but in the end I thought it was superior to relying on the
> fact that upstream zeroes the entire changed[] array. Maybe if the
> comment was more explicit about why this is happening it would be
> helpful?

Perhaps make these memset() into calls to a helper function that is
defined in xdiff/xprepare.c with a descriptive name and placed near
where xdl_prepare_ctx() is.  That way, the patch in question does
not even have to expose the strangeness of changed[] (i.e., it has 2
more elements than it would normally contain to make the memory
region for changed[-1] and changed[N] valid, and freeing it requires
free(changed-1)) to the code path.  It only needs to say "Hey, I am
clearing changed[] arrays because of XXX" without having to say "by
the way, the memory layout of changed[] is strange this way", the
latter of which is not exactly of interest for readers of this code.

>     /*
>      * Clear changed[] arrays including sentinels.
>      * xdl_prepare_env() may have dirtied them via
>      * xdl_cleanup_records(), and xdl_change_compact() reads
>      * the sentinel at changed[-1] during backward scans.
>      */

And this belongs in xdiff/xprepare.c near that new helper function.
