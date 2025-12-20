Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B723741
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766215878; cv=none; b=WSd/Px1/e4tgCovEpsXwkyony9knQwl3ldbJbDGkUHNTR6McjSt0Eqqyknwgns5QtFuRp91esZAziTFMfA7EBXK8asyytc4yS9G48xMCejDc4T5OEdJR4IUj60D4KumLz8p+lVt5ukknW9CDsFuKj+29opGJ/d4b5ZZNamvoEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766215878; c=relaxed/simple;
	bh=VcgeQfPPx1tY+W0KZ5ltS2me/a6MegOGCfQyU8DViV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NoV89D/Yob6eLt50iCOA4nR94+d3LBbRIZ7Q0KPBARc8Bna/bUoj38vyC72L5zFRFjIHbRLYyJwHsMXKfCYRfKXQ/Ik0am2VvsH3R7KgU3JX2Rwa+swTxype6WsfRRlk9/xeHqP+l3IoczxgjWXGAQpqoBjEIxc3Gvmyed1cus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kTmvUYgp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iLbYS3sI; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kTmvUYgp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iLbYS3sI"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C89A14000AE;
	Sat, 20 Dec 2025 02:31:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 20 Dec 2025 02:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766215874;
	 x=1766302274; bh=S4ufRwAm25Zi+0GvU73K6oVdBn2Q8S2rdWEUl5QK/dM=; b=
	kTmvUYgpLCRC889hVuCIkbNTLTOjCWXToTg5UhG9qEiSPfDp5gZXUB0W+WBYH1WO
	x3jFppBXYBJH8EMi178x5sN1bLCVOR/oyr1PTi50l+vLj1Gh3vTxKtB3iWfiW1Wf
	D0OCkm+iKnzj9NH6Ok1Q82l5qiAaP0prtu6rILsQCHOR4th9DJ2zn7cf4BQuVJ2V
	tgaEb9AlT7vvRbdHcXHkzUwaX40mFnObMGu+igIXC3jJjuDWJiywXC/cNYU5zrnP
	p/mCrFNnMTgzDLqwm0cXQXaoJ1qguZb+uSIyDf4q7XLloeekLeSUKp3O0xKwC450
	pTAPdBStZG8MmDcjxUNKxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766215874; x=
	1766302274; bh=S4ufRwAm25Zi+0GvU73K6oVdBn2Q8S2rdWEUl5QK/dM=; b=i
	LbYS3sIPAGFan5DeqB2YkGntp5A1kRsWJcEKpqtgBTUXNNfGv+DuredUMVEgMw0D
	GsKP49gqpOmaY1gTHwaNA0EayYwnyak6Q7UTZNG+vnDucNNVc3ll+rIcKaCuDNHI
	whKYigq2FB5rQb/aVzhwIl03HAsG422SFvVSVmPO5slQP8L8WdhYy/GmPr7pZn8K
	QBXV8O1qwJyK5tLJSO7eD4RpCkUqTn1le8wa4wiqccyk9APN1gtzoKkNY0mF6SJS
	FaOGuRp+Dx+2bbgZyeTDlEwCWxiKXc64B8hJFGXiCM+tnr33mdsWbNGF941fehPQ
	HTemfxSc4Or2wlr7Qk/wg==
X-ME-Sender: <xms:wlBGaSrH42NHYGTqQA53KGJEEyCDL-v9Ccly8Zc87zrdRwPAhUERog>
    <xme:wlBGaXhv0E56pDig8xjXl2JiykLlquTeSYt8CBl1dkU4e0q37knGTbP6zWbfMXjqY
    HfMLCY4B-7t6ZCDoa_b9RS4roF8AshrLxyke-bj5rvLByu0azBx8g>
X-ME-Received: <xmr:wlBGafjYl0hkrbU4F4O9d0LeCyUymCVMHUbfBSkSek3YosO9_p4Cq7Y7TrxokFZ3-qsccZnVa19IKiPRjSj0MZbI5ra2466iKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehtdehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmh
    drsghoshhtohgtkhesshhhohhpihhfhidrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wlBGadhb1-_oeafhnsVQOlDRHGb55ySFHJq-FU-j1SVl-hF_paapnw>
    <xmx:wlBGafLna8tRegn50jpeqer6GODGHLCcYXVkbJTZYr3eFveawfq3WQ>
    <xmx:wlBGacGHaUIyEKWqiF2LLxviTdzM7i7LlG4hKdIbUd47umxcqckw2w>
    <xmx:wlBGaTR7C_HRWHdgEZ622LTh9gVmerb0ke3J52v0CnowsjVjwUsWLA>
    <xmx:wlBGaXLcB-iGYQKxpNO6CsAJqdXHJwaM0L2jaqn_-4dTusbfovWzWweY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Dec 2025 02:31:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sam Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH] worktree: clarify --expire applies to missing worktrees
In-Reply-To: <CAPig+cTsKgzLvz_BJxTLqRfc5A7CK_FNo_L6TDOGPVGG9eXDCw@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 20 Dec 2025 02:14:15 -0500")
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
	<CAPig+cTC8ROsf-cOhUcxovUOcQ47As496SAm7FcEFnzGChhLww@mail.gmail.com>
	<xmqq4iplvhao.fsf@gitster.g>
	<CAPig+cTsKgzLvz_BJxTLqRfc5A7CK_FNo_L6TDOGPVGG9eXDCw@mail.gmail.com>
Date: Sat, 20 Dec 2025 16:31:12 +0900
Message-ID: <xmqqfr95txrz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Dec 20, 2025 at 12:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>> I wonder if this would work better.
>>
>>         `prune`::
>>                 Remove worktree information in `$GIT_DIR/worktrees`
>>                 only, without touching the working tree.  This is
>>                 often needed when the working tree is lost (e.g.,
>>                 the user manually removed it) and the worktree
>>                 information has become dangling.
>
> Yes, this is a useful improvement, although one part confuses me (and
> I would omit it). In particular, if the working tree is lost, thus the
> `$GIT_DIR/worktrees` is dangling ought to be removed, then I'm not
> sure why you would say "without touching the working tree" (which is
> already lost).

Ahh, I somehow thought you can say "git worktree prune <worktree>"
to remove only the control information while the working tree is
still there, sort of "orphaning" the working tree from the main
repository.  But things do not work that way.

You're right that "without touching the working tree" part is
misleading and redundant.  And it is not "this is often needed"; it
is the _only_ scenario the operation makes sense.

	`prune`::
		Remove worktree information in `$GIT_DIR/worktrees`
		for worktrees whose working trees are missing.
		Useful after manually removing a working tree that
		is no longer needed (but use "git worktree remove"
		next time you want to do so).  Also if you _moved_ a
		working tree elsewhere to cause the worktree
		information dangling, see "git worktree repair" to
		reconnect the worktree to the new working tree
		location.

perhaps?

