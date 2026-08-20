Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CD44BC92
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787232055; cv=none; b=SIgaKM8HrPJVJKjMsUSbpdrHY5HGoMauV1ieopZWt979+3VpyuLzsb4OAfa2DcLQ2qLs1qbGxclA+CEqU4O5dMZEVNuThwgPcbMfWuipmpgxTDrSr03KqV9HYGX89lGTwo/0Wud7cYe5cWUhlU6FI2mIjoH/oRu4u6N3kLEBiBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787232055; c=relaxed/simple;
	bh=WZOhshuhew88taT+hp9oj4ri6sP71O/AtUoDeG0Fw/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lomej1EPC89Zz/b7gGxQQyYl5Uk+YqMEH0luXRuAAtBx7kUoPuzDdfXdxixhkIkzVGnraPlZ+6P3ND3f3HqeIVuQWn6mix/wTGllNBJSbHIScnEyfBMpHk0HRKoqiezqACNGpu/NQTxCZtO7lVoyY7z937TKlof7A2VrKxkv4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YLJ/RdxG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNndIpwU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YLJ/RdxG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNndIpwU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9B2714000FC;
	Thu, 20 Aug 2026 09:20:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 20 Aug 2026 09:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787232052; x=1787318452; bh=zGU0VxVn5C
	k/a8XTZfaeDwWYmJff+zWmmoEh++MsrCs=; b=YLJ/RdxGRqawrX2dNY4TVPssDr
	B2YhyswxCIKGuNVXIbnvDiIroBLwGOis0sr0PtJA4PCfaxIJFLbV89C/qHSn7M0k
	wz47hnzc7UKblKM+ABO20iA9DOhwoYsA2u82sfj8RVvJOrsHZbSQ8cqCQgVi7R6E
	d0SKGGWWVF1YQrrr3UG77KHsKm5J3w/cUm6DPrUwU+AvPm2tTxYWkUTyZ1KVYgJD
	x6cFKSptDMHsAHmQIpZ8Dzyc3hzBsh/Tmj7Ru/L9PkG7P6sNkLz4ZYaK0H+wEuUO
	8nLOv3u3EXt1wX8i70tfBsHhxZiO3EkKjNmfd1a48mAWqn/7v9HtwN1Zts5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787232052; x=1787318452; bh=zGU0VxVn5Ck/a8XTZfaeDwWYmJff+zWmmoE
	h++MsrCs=; b=jNndIpwUTw/sfZY7sPdjbItnMWoXV2hwpLadA92Sjnwldu7oCVl
	9hZnGh5R+mc15/fe4e4Fc0IdKtKcYnYNQVAHrivnBjItBTmhvbtSjUlGYGm76QYU
	1E+2z7hRI2csnvgWUjXhQSAsTu5Xrw2qcrzADJ+0WwRta9V4fai8oV8mftYTT50W
	IezX1WEqrMChBkyMTLnDLPvs5vZCgYJQfnegx1NXaE0nQ33/mc+5u4bdU35QrI+C
	g124NTtoLGCCdl7P4clfBxw45hW0Osa1lZJ4Gf2nPqboyBR/Tx438ibmff18weLf
	3xOYUSS509EkLRmHAtVCMssUi27z5Jfc6GA==
X-ME-Sender: <xms:M_-GakZ5fjm4sWLMZ8EKULRNFpxA2THPU5cFgAzJduZw1iLHBMi1hg>
    <xme:M_-GanIKIYXIZkA9NdoTjNyq0jSrPJGsi-Nrtk5faWzaj-Pe1waQccy_arSyTAp79
    ZKQaH6hhkb0Ig_JDiexaPhuQ651MP0m98IWxl299nplHd4EmHpY2Q>
X-ME-Received: <xmr:M_-GaiBa7UU0ugV9AlxGMl15vDJMNCdx04zfS1bBDYbUFKd5e-2ZXEfVMPSmvAXz9eCWuF_VxwyCPOOoLxxJL5HIw7VbIePEziSwLAS0Ag>
X-ME-Proxy-Cause: dmFkZTE/s0b2hla62Mj7YmrYDzu6WFu+E2SVifb8at2iNdeYTneTgsdeWWUN+llFYwLQyU
    nbpQouaXmHy985KbUp+TGY3ncMJbIMiKMZYQqChCoe8afK1NVhXMOeEE2eCdxy7EAxBdin
    ictl/fkYgTqEAjfRNL7KcBT7OFzsuMPv/nVK3+nj+Ly/faot34KZCPSkrdpla1qk3qbghu
    qHsKEFbqeud4KfurzLtXDkCN9kbFWB+rwCgFbeJLZoOxJjzF/aRpqUEnKdJ0DoMtqjJp3Z
    4e3R7j0U8xJEf5/XV9XfPsgupTSTlCx1vZKVSSdMlv548kjVvd2CN4q1JbD3rFOZVfbxbV
    Jy67ZcbtFsfy+ppZpMqNpHci+z75RDo02HYGXhU3ZxcQWE8QgxCkgCni7B6rlZ9NIRE8qe
    skiwdN69t7RySpCkwkGhsVblXZESmNmFk8NywvEVjJLkPCtS+pvi1pwotyoy/XNdRGKYcs
    5p4Ib5fQWXFj9gSgddME7QfIgE9U9eqJVrqDvxRcJC4p7kBfLGJN2lvEoXPmg00lKVGdJ/
    m5N2Ov9UYfpuJIgjrVIG8vfJ/Xxh9o4DfM+k4HT+rWlzQXFdt2/3+rtvcgROy185HyBT2K
    /cyCG6XQ+40CjxvBi7VyK07vuqZxswNDrjSrIGqU79+A37FtzNyY/HBT9Qtw
X-ME-Proxy: <xmx:NP-GasqgGeWA8pbD1NQwp7I2LuyoRCDdOuiv99GQ3jLfLpaPfyUJUg>
    <xmx:NP-Gatj7aWaxpJ2S9AYJIhWICUeqpwB0I987dKXAWR7ue494dHarCA>
    <xmx:NP-GapALs7FRuh4b2JJh5cYDU98xKIp0cMWfTBHhX57bkPVT_c42Wg>
    <xmx:NP-GaiFaSXz4IJx829ysaJwTZ29rPlNj8Zy_ojCryo_wX_zd4_WHMA>
    <xmx:NP-GalqtK8UU-gNH6ir26z72zDZm69BTF1Wt4KFvwHXco7V2-ixSBtf4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 09:20:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4db47a9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 13:20:48 +0000 (UTC)
Date: Thu, 20 Aug 2026 15:20:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: git-history(1) fixup broken with worktrees?
Message-ID: <aob_LsfI9cO3PewF@pks.im>
References: <87jyqt1m6g.fsf@emacs.iotcl.com>
 <e7dbcede-4486-459c-aa64-e44690e01fe0@gmail.com>
 <87y0evcjpp.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0evcjpp.fsf@emacs.iotcl.com>

On Tue, Jul 28, 2026 at 03:44:18PM +0200, Toon Claes wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > I think what's happening is that the branch "feature" is updated because 
> > the commit it points to is rewritten, but the index and working copy in 
> > the work tree "feature" are not.
> 
> Yeah, it's relatively easy to understand what goes wrong, the fix would
> be a bit more involved.
> 
> > Rebase's --update-refs option refuses to update branches that are
> > checked out in other workers by default to avoid exactly this
> > problem[1].
> 
> Ah, thanks for finding this existing discussion, interesting.
> 
> > As you can see in that thread there was some discussion about updating
> > the index and working copy when the work tree is clean instead. I
> > think that is a friendlier approach as it preserves the relationships
> > between branches and avoids materializing changes in other worktrees.
> 
> Yeah, I agree it would be nice if git-history(1) would give it their
> "best-effort".

Sorry, I missed this thread for quite a while. In any case, I agree that
we should probably do the same for git-history(1) as well and refuse
updating any branches that are currently checked out in another
worktree.

I've created an issue [1] for this scheduled for the next release cycle.
Happy if anybody else beats us to it though. Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/work_items/772
