Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5233D4E9
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750946; cv=none; b=kG9h2+OLzE5O/L5JhCsw4l8EKXUi8Mw33dHjuHwE2dwCqU6mHWYrOKNJSD1QId6A3aeXv6fjG42MfXMc/OCzn3p90KhN4HWAbdOcGLOAusj2vYw3Mi1n7CHkd6TlzHvcUG9db1dyrcMxPOhxmFyEtqfY0nr2txCkje/YB/7+uTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750946; c=relaxed/simple;
	bh=KMKW7cCYOn/6nX1wjMVLzg1qur1mf06SLBIOPVntFnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLKSF/j1YNsFnIA4hzA/x6dFuuwHYGdpfkSdFaefImQLDJ3ta9XutNKV1JvUehTyl3JMiF+vIo7Soy9eWxf3qcjWm2Ph2dXZZXVo0GZYO7lThQc9sOLLX7HA4QB1tWd4BzNql8KJx+eh+fgvVEa5bbRVbLsMZ4oxwaQNffrbqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kCDqpS6f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=deL2vc/r; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kCDqpS6f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="deL2vc/r"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F038B140011F;
	Tue, 21 Apr 2026 01:55:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Apr 2026 01:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776750943; x=1776837343; bh=rt7lBk4KjT
	2oxc8uhb878kGAzlSdT6UVSp8M2BxTbQM=; b=kCDqpS6fLXaZM2UjHrqN8/0u43
	BDAJTmkxGH7afP9OlGO+PfVZH/DtvBZyyUlBKRTU2eB+zNBNEWuHOxCQsroxVMZE
	sVjCuz7ZRz3911hLgqmyzSfPlSu1ZZlSMUd9T0su8w6QOcqtyHXzAEppAMkNlmhJ
	OzM7vkkIMrlmBSsbsKJ1/JUjYUQbk9Mt0MiALRo0w6kjrs0bUY7Bpn9b7LoR18Oy
	qGBY/+LYbSTezR/VKRyo0n26QDnSMEVnPHAc1hHgzKNQUT5jDfTS1lu70yF2um/6
	iFWpC8WCdWbWVRB/HYdLn4DkcApBy/MOehUWckh3nH1BjYvnIgX1xgFdQZEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776750943; x=1776837343; bh=rt7lBk4KjT2oxc8uhb878kGAzlSdT6UVSp8
	M2BxTbQM=; b=deL2vc/rdsam4/QKjSjMQwV/MJ5wrtjSq8kj1MDskjMmstle3vf
	kl3dua8D3Z0cIo85dwGFWr7RQfV0aFAfY6dTemH8bo87pcOthGz5QKu2CvFQDAGb
	T/1yg8A0PCUecJ+ntbF/Vo59KZWm04d92W1CgrFsMo2vITsBj9NO9/0AH6vGu7UW
	DUPw8LtDNRY9aB6XXMnXMsazcfyXsRaOlFNbE9zLlICXmkSbRv4G+EeGgS2rojQx
	05G3LT4uGNJ99pPYMCdYQBju8RiMEbBrxC1wVFtgOtsmasIKj3u+OEJVxgGzqGFj
	GpLc6ZN6BMoq3dca+dQ3Sxj93HD9qjDLsrw==
X-ME-Sender: <xms:XxHnadEKDIK3ck3_xwF5MU8ePyAseosDK4uTaUiNmQL0u86G-UDfDQ>
    <xme:XxHnaYUAGEBw2No7KJ1LHhair5qfjUtsp7X4Lc4u8mMDC-SdFT8ZFCz0Kil3KiqL-
    MxePA8x48g05XyuLHjS41QdHnBKDVf76w7TCFNltfkLU2TGonNuKA>
X-ME-Received: <xmr:XxHnacyslN8skjcuNdVY3ozCGuslrFoqNKwNtGPQgcUxxdLRFWUAFWPLK4GMzMRhxZf5SdxcH1pf299fOX-Op2sd_GmjhK0Pc_izHY8gWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eujeetveetgeetgeetffetuefgfeetffffhefgudevfffhgfeffefhvdeuheeigeenucff
    ohhmrghinhepghhithhhuhgsrdgslhhoghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XxHnaeMjdyG3sC7WBBcTwbHDe721PqIZjbjK5kqBsu4CbqhgwFcWZA>
    <xmx:XxHnaV63AiOjhmZvt8jXS0puVMchK63ttIoV_clw8phylEkTajlYTQ>
    <xmx:XxHnaXNyJoW6AmJWK0qpqGi8SUMgmOLSH4q1Vh9zWUnwxpZNfAcHeg>
    <xmx:XxHnabm_ylP_YF5YuHdHkCWMiKsShzKi0vkeuZUZx8gZlKgEYWNUWw>
    <xmx:XxHnad2Ko1D5BmH0VSoNr5DMIPJlTldMObB-ljnTJ2U_UirPQ3YuNafG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 01:55:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7c991cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 05:55:41 +0000 (UTC)
Date: Tue, 21 Apr 2026 07:55:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <aecRW_nwBVM21CPF@pks.im>
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
 <55bde257-ee25-4a7c-a17d-c902aa4f0324@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55bde257-ee25-4a7c-a17d-c902aa4f0324@gmail.com>

On Mon, Apr 20, 2026 at 08:03:44AM -0400, Derrick Stolee wrote:
> On 4/16/2026 9:24 AM, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this small patch series follows up on a discussion we had two years ago
> > during the Git Contributor's Summit in Berlin.
> 
> Yes. "small". ;)
>  
> > I'm fully aware that this will likely result in some discussion, which
> > is why I have labelled this as RFC. I'd be fine with a result of "let's
> > not do it" if we cannot agree on this step, but I think that the current
> > layout hurts discoverability quite a bit. Not only for newcomers, but
> > I'm also struggling with it quite frequently.
> 
> I agree that the flat layout can be hard to navigate. While we are not
> at a scale that needs something like sparse-checkout, but this wide root
> directory cannot be reduced by cone-mode patterns. This is meaningful
> only for niche cases like "I only care about Documentation/" or someone
> testing sparse-checkout performance on a copy of this repo. It's something
> that I do think worth mentioning whenever such a large refactor will be
> undertaken.
>  
> > I also intentionally decided to send this close to the upcoming release
> > so that the series can be merged early in the next release cycle if we
> > were to agree on it.
> 
> There are two really big disruptions that this will introduce. I bring
> them up only so that we can discuss them and make sure we handle the
> communication to the community and appropriately time the merge of this
> series:
> 
> 1. It will conflict with most patch series in flight. How can we
>    communicate which topics will be caught up in the rename before it
>    merges, which will be modified at merge time by Junio, and which
>    will need to be sent anew on top of this rename?

Yeah, this is an open question. In any case, I'd be happy to help out
with the exercise, if there's anything I can do to make this less
painful.

> 2. It will conflict with forks that have long-lived history that is
>    merged with or replayed on the core project. The examples I know
>    well are github/git, git-for-windows/git, and microsoft/git as
>    discussed in [1].
> 
>    Something that I think would help for these cases is for the rename
>    to be done as a solo topic merged into 'master' on top of a major
>    release, such as immediately after v2.54.0 (or similar). This would
>    allow a merge or rebase from the previous checkpoint to update to
>    the rename without any other upstream edits causing further conflicts.
> 
>    Fork maintainers could then decide if they want to update their forks
>    onto the rename early in the release cycle or as part of the next
>    release cycle. My preference would be to update as part of the current
>    release cycle so any changes during the release cycle automatically
>    incorporate the change similar to working with the core project. (I
>    am not a maintainer of any of these, so it's not actually my decision.)
> 
> [1] https://github.blog/developer-skills/github/friend-zone-strategies-friendly-fork-management/

Agreed. I've been chatting with Dscho last week to assess a bit how much
pain this would cause, and he basically said "go for it". But Git for
Windows is of course not the only fork we have.

> Finally, I looked at what's left after your renames and I see that the
> root directory has these categories of files remaining at root:
> 
> * Dotfiles that must be at root.
> * Documentation that must be at root (README, code of conduct, etc.)
> * Root build logic.
> * .c and .sh files for root-level commands (git, git-*, scalar, etc.)
> 
> Of these, I'd be interested to see if there was value in moving this
> final category of file into another directory, say 'cmd', 'commands',
> or similar. It's the only remaining knob that I think is technically
> possible to further trim this list of files.
> 
> Did you consider moving these files, too?

My initial version was moving around remaining ".c", ".sh" and ".perl"
files, as well. These are (almost) all related to top-level commands
commands, so I was handling those by introducing a new "bin/" directory
and moving them in there.

I think the remaining files would mostly stay as-is though. At least I
couldn't come up with any obvious additional renames.

> _If_ we were considering moving these files, then I'd rather make
> one big rename change instead of repeating this exercise multiple
> times.

I eventually decided to not change too many things at once, as the
"lib/" changes are by far the biggest change, and also result in the
biggest improvement, if you ask me. These changes would also
significantly increase the size of this patch series.

So I still lean into the direction of doing things one step at a time,
because it focusses the discussion, and every subsequent step is
significantly smaller. But if it helps I wouldn't mind also going the
extra mile.

Thanks!

Patrick
