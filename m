Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464F420867
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455241; cv=none; b=gmHy7ZC6mdpv4eG8Yp+1bDMDhmJoLq+hmDq6F+YmHC4PbPzTDar6OMPO4q6YH+8E0iArEFxaFhsAoZDaBZ1Dx0Z45wNDzJz+fxnQz0SGhn5b790HHvDbZbZ1cTd+8dLhU2Ja+lY4T8NILX8QVygD1Bfn+K856XH8TB4DuLsHxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455241; c=relaxed/simple;
	bh=uO+nJGoo4AzVQK/UEkt0pyV+YabyhM92x20xo3gaBiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lpIo3UN3M/jTiQvTjdh9zhbbLdiUixfNDkpIqdJDLzZl3+lbG7ad5FlQ3PNbsctMfyMPg4qSelF+mmwQGk0q86idfz1YDszxTdW5ofZazOP5N4M0jzOZz27S7WV3b/m95Tu6yjghL53SGEJT444llt6ihSFFg0L7JszfbgDdKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A/41hHMY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qwx/sxIr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A/41hHMY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qwx/sxIr"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B10BAEC0110;
	Tue,  7 Jul 2026 16:13:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jul 2026 16:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783455239; x=1783541639; bh=oPoS+2R+Fl
	Co9bfIGR8l86kcY4hDyNyZfikAWzn5QsQ=; b=A/41hHMYDskbt/3UhAV0GuDp71
	AOv7feAGvHW/0ypo+z6YzVTSsGxiQe/sT+HjyOLZ0VmOBLTB5MJSWYlgTaIK2RlQ
	D/wNaR0Zm4twncnf/08wj54FKRcyPgRP/rj8AHknnBFKY/ARW01rc/0stFsPpqIx
	zTKVO1kaQIKxGb7aoL3lbjGZFUnh4EHGt0Oa+IkJJoTSH6AwPwCtIEZmR/pxBoHs
	+Uj+XsfOEuO83qjJB2k+RpGpjgXgLT42naLvOKppGn9U9B3pDWzZyZq8XAHyszF2
	kMqFbUz59nZsVtxkPxJJ/xMX28dsdR6i/SDULpDgIy1r7fYjbMd0oJ3Biyyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783455239; x=1783541639; bh=oPoS+2R+FlCo9bfIGR8l86kcY4hDyNyZfik
	AWzn5QsQ=; b=qwx/sxIrdNlXzGPR15fYqgAL7kZAjxBK0zjjdGRFqL+1g5xC6JI
	KukAve3ow02RvWOpGSHEZrXdIjylhrTOSf3p1kQfH93YWUL5Cct21aLByXn3PKZX
	QxrfNVs4832ad7DbLnCsrgYwp477QDAmUWb7ct/wMZVWw/B3ff5i86SyHqEaczUi
	vZa7S0JdW5hXSqu5Z2AeO9K4RCgyOA9BLE3513BVl1PPXHxP/nxkDZNbzxk7r2iY
	1eQz/FjyuyV9hHQkL0yB7GFCTikAUybbEu9aJRY0zYmHH4pnlWTSQZ/39yBY172w
	sXBLGBf80hTJreGynb2k1o2p8Qh862xbjdQ==
X-ME-Sender: <xms:B15Nak25ZGarlvUNHa5dpTjpQy4jq_udOkPS08bralsPkxlygP0Mdg>
    <xme:B15NamHUiBPlzV6UMipC9B87CVLqxD4l9SkUVe-VDnFm3mjk2OHFN9CgQrLAHuvYC
    ZeFZp52Sw1DpSvAN8PwzrVBBQHW0ZepRXMH9UjALD3NoWTPIdcGZA>
X-ME-Received: <xmr:B15Nah6hZ5XeV6M6JmK9fwXbBDRj1ipBp7kbvqN-ZisT6EYoE90PU0RerDQVgSnaSN2umVVuZKi7MvvfXLzoRIzHqLmzgwUckoA2CIE>
X-ME-Proxy-Cause: dmFkZTEVsEmkil4mG3MQoiBXe2Poj06jUP7lFioTRFD01bvnmoMr4i0VsqJLYPM2eBn9cw
    GEwEQ9zY4zIKyyayVD3WOOJsfwjQh36cE5v2pQL+jGIMLjl+O3HD70aGIHX5n2pi3vTzZH
    zA8pBHPFjnvLUnRIPaMKvgL7tpF/T2bLr91CezTK/WZGX9Tm2cvV1z3w0bTOTq2q6+LxRa
    pAyohuwy2gs9vdVle8TOMWjKl0we/K9pt5BePY08eIPndjj1idpzI1ykdJId2L1ugRDl9B
    wsCFHY+UI2JC8z86/2EYb+9NqR21KWrO+PPERZJ/+LSvCNLnNzk9o6YUmMkV7ZLpips4JE
    TSzNJZBkBIPe+RSn3g/NZQu/LlEDlfDZLJam6wRQTQh0t68Z30zC5J1zd9QAv///9O8gg1
    5KMtQGQtjl+C8wfQymPqsjEDVIpCZS02KtP7CHzxlobbi9DUKaxWQalHZ4zMTA37aLHrnJ
    Hv4PkFJr4SkbFMz7LzS/+EyYGK9QUR2gta8Dj7maGgQfEVb+2PUS0dxmdbRCIpYQbZEbqf
    2VrLjKt7OFUqaE2AgnBCHpyOuZ6OKmWEIEOpmW5dloJex/9/g85Vp5oqURh1qAKZ7PPV9Y
    bFrL4otThCsW+0cayY9DQIkk7oM6b7q8guoCD1Xa8dtEustTJ8Kkl8ebfO9A
X-ME-Proxy: <xmx:B15NasubqBxoAfemwmGEU9Bi75nD4ddgm2916t01t0Hn69b61bXAGA>
    <xmx:B15Nai7tJwbVks_t5hhcFoyzwSwNtzX3eWQoC2EKp0T4EwyOlGy9Lg>
    <xmx:B15NanWeFVdg5nHFgf8vhAxUiccD2TOKcYXdLI3w38ot206WgW5lWQ>
    <xmx:B15Nak-pWJK5KlaQnk5YSQuNPxZ2wMIyLKCo89KOQ9VXu5EDIwjwXQ>
    <xmx:B15NauAqFLg37DtOUj2d1qoTKtgnaCRioI1aMpBWNJ8Ao7fGM2I4eOSF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 16:13:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit-graph: propagate topo_levels slab to all
 chain layers
In-Reply-To: <CAL71e4NXPAitqQtCnwLCyXvigD5KjOCSj5em+3v4WSUaYQKHRg@mail.gmail.com>
	(Kristofer Karlsson's message of "Tue, 7 Jul 2026 19:42:52 +0200")
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
	<f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
	<xmqqo6gi68go.fsf@gitster.g>
	<CAL71e4NXPAitqQtCnwLCyXvigD5KjOCSj5em+3v4WSUaYQKHRg@mail.gmail.com>
Date: Tue, 07 Jul 2026 13:13:57 -0700
Message-ID: <xmqqjyr61rsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> On Tue, 7 Jul 2026 at 19:00, Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > Fix a regression introduced in 199d452758 (commit-graph: fix
>> > "filling in" topological levels, 2025-04-07) where the loop
>>
>> I guess the same comment from [1/2] applies.  We might be chasing
>> ghosts here.  Is that elusive commit a total hallucination?
>
> Oops! The commit exists but the date there is indeed wrong.
> Will fix (or just remove it, I am starting to regret trying to make
> the commit reference too detailed in the first place).

Heh, "git show -s --pretty=reference" would give the right amount of
information without giving leeway to users to decide what level of
detail they want ;-)

Thanks.  Will mark the topic as "Expecting a reroll.".

