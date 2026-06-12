Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30437396560
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280999; cv=none; b=NTr88CzN2jaWl8ckFTetraAP1G9RMxS3AVArJlfEGB2bwAdjC0Ur8/M68hxq6mVFocDvXhxqq6EhDdS5oncOkkyJpaEsOK7ePXmj03wH/OYDvPUoR4QwuyMYIwC41443jt01zgl7bed1+tjlKxQBH7gOZv5SK5dc4NOfgH3bfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280999; c=relaxed/simple;
	bh=pMA3GUUBy1zjKf1PHxSeSD9g0JVq2aPpuGzFuGbuoWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDZKbzxhjBCBUXW5BrSkJZ0+5ShNvBk/7L05tzFsLLCnXDwQPTi6GZhhyJlm+H8UebA8FCkEWr3JksN5rRwlvx3usCXBUSovDKv8F3J/eJCqXEIMDEU6QfDBti0M5nP+oD2D1rlvkjoPTJ1wnNP7aLlH/Ly4ulWrbelxGQfAL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=sixxK44z; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="sixxK44z"
Date: Sat, 13 Jun 2026 00:16:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781280994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4i5P1LFywl/p1HG0yG59/868Amvoui5uaazvBZLFoM=;
	b=sixxK44zwo4alUIulNc6bmyLyWQwapZRRRTiaPcx3xQojSuNvks/vON5mOymFQogNbjzh2
	UAL3S6cetAV68qxnOalbqDePHfwkZ3j7i6thX/EM3PvO/exBYguM2bg/Bhsqos9PA5SdAB
	mjXqhhtdugpPkLZ9ku3aL2zRNTdEChEaSi4rrxMKRGmnNYvkks5JWXJBKaTU8nQq32zKmx
	Ob5x11mgUk+l2o91oJC/vVDBf82VzXvodd1xbCjwsUp4lRiSPZko/ChUnoEEYzRbGMzBT2
	oKnb6lLXlu9+GQxA/OCKawbtyQZt2or7yoXtFhAZgwrRh3J3xMvTSDFgY9Ehbg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] commit-reach: remove get_reachable_subset()
Message-ID: <aiww2oXXDQXk0dgu@wyuan.org>
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
 <pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com>
 <ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com>
 <xmqq7bo5nf31.fsf@gitster.g>
 <aivQv5FkTEWDn22i@wyuan.org>
 <xmqqecibizwz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecibizwz.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 12, 2026 at 07:41:48AM -0700, Junio C Hamano wrote:
> Weijie Yuan <wy@wyuan.org> writes:
> 
> > On Thu, Jun 11, 2026 at 10:48:18AM -0700, Junio C Hamano wrote:
> >> I wonder if we should talk about it in the SubmittingPatches and/or
> >> MyFirstContribution document?
> >
> > Hi, I think it might be a good idea to cover these details in
> > MyFirstContribution, then cross-reference them from the part of
> > SubmittingPatches that discusses sending a new version.
> 
> Sorry to be nitpicky, but the above is omitting too much from your
> quote.  "it" in "talk about it" is totally unclear to a reader who
> haven't seen the message you are replying to.

Oops, so sorry! You are not nitpicky at all, this is totally my
carelessness and fault. Sorry readers!

Thank you for catching this! It shows that I still need to really
understand the previous patch I wrote, and put it into real practice:

> It is usually helpful to trim away unrelated context, such as large
> portions of the patch that are not being discussed, while _keeping
> enough quoted text_ for readers to understand *what* you are
> responding to.

Thank you! I'll immediately set a solid "pre-reply" hook in my .git
folder ;-)
