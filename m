Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936C33439A
	for <git@vger.kernel.org>; Thu, 28 May 2026 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000931; cv=none; b=lAZ/qi1YBKZdyXfm/ANgp4StgDdh08nnmpxFfcI7vMxtWDJUzoGvHH2giKqbN0b8qwG2NauHJMkJXQUIAgHM1HjL6C3mFnC8DvU5d+SKAcnbnw4HWT2cowobTx/2f1Q9pLcVQIWqTevYUvalHo74JRL5ZegBc0qF6sjiaD3LUN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000931; c=relaxed/simple;
	bh=VKYnciLTHTFX7UROFRiJF+kQhld58E+SqGypWQWDg1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jvyEpXY5TXCxc/5OY4PEEvkPGVC5XVYvArOur3MxGcsAnECIX7GThnPlaNuYT4Dn1k7Pe6WwzEnFNC1h4bQODlyMUPDu2d2tlixonbRfVbi0bJWzRrc2ENQmYF/mE3VcypyEqycSXbNnpdVrINKoCO8dbW91s5ImI752nWGnB+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h0OkWfsW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iqCeB8C/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h0OkWfsW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iqCeB8C/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E433140012D;
	Thu, 28 May 2026 16:42:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 28 May 2026 16:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780000929; x=1780087329; bh=UIeAIw11wx
	b6fr5caomvIgQztptRvq0fnbi4/P2fA4A=; b=h0OkWfsWpsnVp+EokYljCOPYzY
	RB4KouW6Nj1SdL0RD0qEeJfZv7xYoq3V73CFe5tba80EKnU7/wZMjNOlj74my5EN
	PNeuCfWWFfuWHil7ZGWN8EzzJCuJqdltVSF6uzETLzdggVn+d1XnhDd5lMhyuaXf
	/wIuUygZTXYaXVyoY4Fv65l1JOFcJ8TmtIDPkxWqoJefpGfCJeNX+BcNTgs7w4Uq
	WFCg+6y0QpSNxDY7M4NQE8MTQ7pJpG067YGv5oSWf+gfdRArR9vZQQe2cpliuHqt
	O8rnqgk5rx11vKdo+jOmDm8mia0z8ebJm7zIxkk8RhLyL+SVhN3iYftk5mvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780000929; x=1780087329; bh=UIeAIw11wxb6fr5caomvIgQztptRvq0fnbi
	4/P2fA4A=; b=iqCeB8C/st5IvHzm7F6ATrFKNr3ZQphYEaIY6C3+m4tR6H9AzVd
	R9naYxvb9HVtqex2bBQ5q6SlDdiiYfAsb7aUqVAVeToHoPS1CMGuxVuW155sDTfW
	Acryyn3O7zi+tFZB6xx86MZP2y6pAb1tTEGZZbYht8UsoWaFAR8jItW+LKdh004L
	qZte4dYxCO3TIm3WTy7gtVH534eJ8sTsLj91Eur/nxlt7FJwQoR3Qvr2xLRJ0b1E
	1mDnCbJyayMu2nIYVer8u523lesOUvEe2wELK392oKmdPGSsmAFzi7OwYQfTqypi
	Ferbgw8Ldn4rt2zyGC11cjbfSEVq/cjq1QA==
X-ME-Sender: <xms:oagYanf9R9h4dpIOcA2IATCM8XHLStqTusHS6EPKDkF02wBi05fXrw>
    <xme:oagYakOWQgOk-XEa8eUmJ08dJABtGi-i1i_AoRabxq5S7tKj93sCFXJwrLjHp8sYi
    _LSdDqP950p2RnUj6DAR2GP5B1_PyrGtXVdpoG7YeDVbfLzWrFN>
X-ME-Received: <xmr:oagYalg6CEQAoRN5pLRMcEXnEu88K0vAfzj7k16JWOINyv1-hJ-rFHC_RtWSFdGJrPJPipjP_qejWYMuwYpYqBcHzeyJSlsMGqSe>
X-ME-Proxy-Cause: dmFkZTGa9jodFkWDb3w0Td8rB6zXs7kQHnWQj8anv2YNqc96PUF55AKr/eSxcw8D0vkFg2
    hUn4I0fD5+fv0wUUOZxN3AdCKcIF3k74BkuIfw+X4uPuAex2yelv3QtHqK7wrVNnICV+ZC
    lp2/PwJsJqpDSVCeHYddh3G+xffeoqz3cSr6y49jTWTIMosKjeEYx3HIxJPlK9xyUSBcmg
    MNS9XwmFo2wFuayOas+T5QaSOuKnRVKM8ea3DtsCzedXe+t2fjFCJg9oZVcOv5Ja6THAQt
    rLpePEw725kSqGbB82IA0NCdN71XKiU6b3oHu1hjvOH81Xy3w4Qq072oooUrLLlrduoKQ9
    d3VHAR4LhvlfixokxeOj7I6tUCA/C8UhZTXRPTqSmWLetI/nDsCUCMzOADHXClmbfNMCNE
    5v7CNm1mSGrtxcuPSgjxh05j8WuffAvp5J/+bhEq1M2GEUuaBfzAaA27l2Q+6CPvYfM5Ht
    ZBxbCKVlo42KUgV/Ckq5yE7OWEowQp6PGk0sxr7Z0g6cpoZ3Y966ey2OmpQO29ThSwPohL
    sWJy3kLgDhEqWiGdVhJVh17CdBPEG8ol7uOWcK07kApp+a9q484JaNAuodAYcjg5q92Xl/
    9lZ2O6sKiJjwUBIjo4FUJlbXFQhGEuCtWnBtaiyCfcVdRY1EVzYwwqIumf9w
X-ME-Proxy: <xmx:oagYan31K06naZlJCrUxh6Ztp4o2IEU7i5XMjTd9sW6NvxEeaInR2w>
    <xmx:oagYavgJwyky7oQHRG2fpsz3XCljDLWTLUZmv56aLhLNGdB14oTKVA>
    <xmx:oagYandcNpJmJ-YXgwkjI48fmzOAN4P3m6lcUxXaCoEd1ypqLhyjNQ>
    <xmx:oagYailc1w-jNyUw6lxsK2s5FXQRQ7pywssjWCToaIF5bI8fGeEpWA>
    <xmx:oagYapC-AoRzW0MMXhSljvSpBGrmn9vGUNPkYFZmAB0Zxs2pWBAIYUak>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 16:42:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH 0/2] rebase: handle --update-refs branch symrefs
In-Reply-To: <pull.2126.git.1779946921.gitgitgadget@gmail.com> (Son Luong Ngoc
	via GitGitGadget's message of "Thu, 28 May 2026 05:41:59 +0000")
References: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 05:42:07 +0900
Message-ID: <xmqqwlwni7vk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com> writes:

> git rebase --update-refs can fail after the normal rebase path has
> successfully updated the current branch when another local branch is a
> symbolic ref to it.
>
> One practical way to arrive at that setup is a default branch rename from
> master to main. While the migration is in progress, a user may keep
> refs/heads/main as a symbolic ref to refs/heads/master so that both names
> continue to work locally.
>
> If pull.rebase is enabled, a plain git pull can then finish the rebase of
> master and still fail while trying to update the main alias. The reported
> failure looked like this, with line breaks adjusted for the cover letter:
>
> Successfully rebased and updated refs/heads/master.
> error: update_ref failed for ref 'refs/heads/main':
> cannot lock ref 'refs/heads/main':
> is at fc2c7bd5f17abec7861ef759edcd33a1e16662a1
> but expected 531cabdfb49098d6ffa502ed4bf91d1b35edfcfa
> Updated the following refs with --update-refs:
> Failed to update the following refs with --update-refs:
>         refs/heads/main

I vaguely recall we saw a different topic that dealt with a
situation somewhat similar to this topic (I think it was about
'describe' giving a name that is not a branch).  How would this mesh
with what the other topic wanted to do?  Instead of filtering out
non-branch names (which the other topic did), here we want to filter
out names that are not concrete branches but pointers to something
else.  Would it mean that the logic here is more broad (i.e., both
wants to filter out names of non-branches), making the other topic
unnecessary?

