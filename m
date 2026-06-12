Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6683CFF56
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281292; cv=none; b=iKAhB4gU6tYQhRMSUZAKke4hesFT7hMQcQOgX5Kw6+1ajCzKxQQ5xC+yXlOUYohH/VFUaqVON8iGGUi8UB7ZVA4lHhp0jRyZI8VjqzcXfEkRvBycsSxEiOd3Ct2eF4AgEtKVa4XVGLKO3fA/HwhxWBE4FUf1uJRvxdW3aGnZsWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281292; c=relaxed/simple;
	bh=hDXXj3REqe5/+kyQzQPnInNxIjNbf9eB0QtLQJWh/Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szsm1LRS654G765KY23eW4y0RGXUc04OPxdrcHWAfTrP46a26oA4wz2xYpW17rf0PBCXrGgeSjEmmE0w7y/decj2XZ+mDA5YAgs17TFlSb3rQfmQSnzYnKlq5jCeQB5QFcWjExyRL/JxcvHb9BC54NHXX342s3RnBB47vkQohCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=Jh426Snr; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="Jh426Snr"
Date: Sat, 13 Jun 2026 00:21:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781281286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSL3uZXYldcV7k/TLK+9ZnVUfA7x6qghC5xqg3J/UPA=;
	b=Jh426SnrMJs0CIz+TCJRK4+Pj7eSMHX+ePCcjcF0mwcOI1wygyYJiWK/ZfQ1sb3Jft7VgH
	lfH1O7g/oOoVPv/HXUaGVy4ETyXDIkqRk38uXcetRTKXXjHookCCUFqhK4qdvfMM7K5sCl
	HnAzEn2f5utRBDaJENMmmsue4D1pGW+1Nn9j+AptC/nW6Q6qexToT75L7iMkuQxy0/FQ/x
	ZaDH4XKmVhHUBZUd8ChV2ONPZ78TRzgbKtw5fPidv9APr+T7SlVCap79bSVnVokdFQjOiv
	Hl7HK99WWtdPi6/DAoRWoaUr7+awTSLERfMZBazwBA2V7BfW4EzVSbTcNWHnzw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] commit-reach: remove get_reachable_subset()
Message-ID: <aiwx8MnnI2qSRvtF@wyuan.org>
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
 <pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com>
 <ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com>
 <xmqq7bo5nf31.fsf@gitster.g>
 <aivQv5FkTEWDn22i@wyuan.org>
 <xmqqecibizwz.fsf@gitster.g>
 <aiww2oXXDQXk0dgu@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiww2oXXDQXk0dgu@wyuan.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 13, 2026 at 12:16:34AM +0800, Weijie Yuan wrote:
> On Fri, Jun 12, 2026 at 07:41:48AM -0700, Junio C Hamano wrote:
> > Weijie Yuan <wy@wyuan.org> writes:
> > 
> > > On Thu, Jun 11, 2026 at 10:48:18AM -0700, Junio C Hamano wrote:
> > >> I wonder if we should talk about it in the SubmittingPatches and/or
> > >> MyFirstContribution document?
> > >
> > > Hi, I think it might be a good idea to cover these details in
> > > MyFirstContribution, then cross-reference them from the part of
> > > SubmittingPatches that discusses sending a new version.
> > 
> > Sorry to be nitpicky, but the above is omitting too much from your
> > quote.  "it" in "talk about it" is totally unclear to a reader who
> > haven't seen the message you are replying to.
> 
> Oops, so sorry! You are not nitpicky at all, this is totally my
> carelessness and fault. Sorry readers!
> 
> Thank you for catching this! It shows that I still need to really
> understand the previous patch I wrote, and put it into real practice:
> 
> > It is usually helpful to trim away unrelated context, such as large
> > portions of the patch that are not being discussed, while _keeping
> > enough quoted text_ for readers to understand *what* you are
> > responding to.
> 
> Thank you! I'll immediately set a solid "pre-reply" hook in my .git
> folder ;-)

Sorry, here I mean setting a pre-reply hook to remind me how to do a
good quote when writting a reply mail :-)

Sorry for the unnecessary noise, and thank you.
