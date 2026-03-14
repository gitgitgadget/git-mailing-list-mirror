Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5902347DD
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508684; cv=none; b=us4jQRZ8MefTp6fM3AFw6vg9SFP15nE/eE24j5if2XQl++p2fFhQ7Nav28n8Gr7nkEvamOHNuw+m7tytmmty1CCRY15PPuOjJCB8GgmDeFg36ETtn54XLX1xCr11hU8UR7E0xSvBpg/RhFokjbR8uEFHN+ma8d6BA2pMWm5LvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508684; c=relaxed/simple;
	bh=chicTamwm4SSI0Y5Zpv8Seam7Eax90FwCK6N2mD6jA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ABI4oykFITVsn8/ZqKgFXR6Li2ZU6/bbWrcgHcv2S0QVbSHChufTfKwcccd0E4C6UAWNuJstG5T/XdCD2ebbQvS1vSU9eXnxjWej9dMl332MSrcw7wj1Pc7zaKUnlkEa/FMod75pTu8271jRvRO2DkPiwddLnAK19p5PGNxn6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kz35aDs/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dhyZIuuu; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kz35aDs/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dhyZIuuu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B46641D0009F;
	Sat, 14 Mar 2026 13:18:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 14 Mar 2026 13:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773508682; x=1773595082; bh=PCbzQuQMzr
	W6zn8E4QpRWtRk33ffPWf8Veo5X2hmTcc=; b=Kz35aDs/PeDlrpyNfPiqXJZ9iC
	WuOjMdxakUjaSjYTbrANi+DtXTa7suJG5wcU7k/MWyB+iCEp+K1htaaFGxhcYYdF
	vciNgCiGnWeKFhiuwxqU7M2G3fAmG+zf1woewd74rJdBPa3uVKhzpmNHw06HVXVU
	lkfsT6PC4qVWyNvP/7eff2ArCgtaqKPn2xz+4rurSozTTa8TDxKOWyyJkoSWhCsd
	jDWmyiKzsSfr4rvODylNJiRC28DhuWko8oinMTK8LvdfSbaQG1UnTzrVr7e5qLcv
	XkXWCqXL7YyDf6TnSuBfRPsX7Ir2o0ig0mqFJtQF0gY4Q92xF8eVSJ9EhQVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773508682; x=1773595082; bh=PCbzQuQMzrW6zn8E4QpRWtRk33ffPWf8Veo
	5X2hmTcc=; b=dhyZIuuuBflqFvacfhOF/oADDalQG4/av2AwKj5xdpQwQ4OfRQU
	bGzxUhoxJG06LeVEax5ETFoGGYfDKyJGY+mJ0HMKWBTHEsCH5NYVd3nspoZM8PbL
	5If5WX+AKTwegKToEm/94c8DGlLl9CGRyTiDQIJMn7Me2AJAbsaE0JaQC6SsdhHR
	9GQjDYqOPN8IbwN4o+/xgYUPbWWmQmN5qEugzUVCQVaBqfbYGfvbwtTnryqW9VGj
	qWasgQHCjmZUxFA06oe+xkcslcx8PzVFmC74rwevk3KD/9v90QkK/oEX8MzpnxSL
	1mGCqwPd5XhdiTWa+J2hVYLZY+pSRcJbn/A==
X-ME-Sender: <xms:Spi1aR39MXXHP0vbCrm17cL7iUaI8moD9CbwUkpaAnsmq6GEXEWGQA>
    <xme:Spi1ae-5mWeNfIJqVk9YpAuPOeelDoRpnwy1c5cRQWE1CSi-EaSLhle_YpNXEUoHB
    LM_Se-z_5EZZoK5wtNSRm8AoEzz894mBcN9uvgKda5u0V_C9Wbz>
X-ME-Received: <xmr:Spi1aaN354bI1arhXPF3sSeI2Fpoag7G2FnAiJSYi-MV5poj9zYrhRorFfZwiKbaoTrjS-c5NIJ8W_ujdahUeRb-B64slFSwPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephh
    grrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Spi1aaeM749duhz4aOVm423BE84NOz1cisO2pGW-UASMlL7MjtHaeA>
    <xmx:Spi1aRWqZjIUO-rf2UgPDPdZ2g3M7j4UoaarilNGbvfRvz25ACDXgw>
    <xmx:Spi1aaii3bdD4lm5X7gkhkr7KMOKXqf2ROZxGG46J5SmxQVvFBfOGA>
    <xmx:Spi1aY95mmKxOvVJ9Lcal0SXB9R8_oob8o-_F3Xcp5QDcDnPJgZBBg>
    <xmx:Spi1aZulNloSZCCi_qF9NrWcw03jca0cdHRdL9v1NJpiftbEx9khxOjr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 13:18:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <953b5842-a4ae-40f6-8cae-c4f81239c903@gmail.com> (Phillip Wood's
	message of "Fri, 13 Mar 2026 14:29:45 +0000")
References: <pull.2234.git.git.1773321998854.gitgitgadget@gmail.com>
	<xmqqeclpi00y.fsf@gitster.g>
	<953b5842-a4ae-40f6-8cae-c4f81239c903@gmail.com>
Date: Sat, 14 Mar 2026 10:17:59 -0700
Message-ID: <xmqqms0awcs8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 12/03/2026 14:40, Junio C Hamano wrote:
>> 
>> Perhaps doing it this way would make it more worth doing?
>> 
>>   - At the beginning of branch switching, ask a new helper function
>>     that takes the branch we are switching to as an argument this
>>     question:
>> 
>>     Do any paths that are different between the current branch and
>>     the branch we are switching to have local (i.e., either in the
>>     index or in the working tree) change [Yes/No]?
>> 
>>   - When the answer is "yes", save the local changes to a new stash
>>     entry, and clear the local changes from the index and from the
>>     working tree.  If not, do not bother with stash at all.
>
> Can we avoid the extra check and stash if the user passed "--autostash" 
> and unpack_trees() fails because it would overwrite local changes in 
> merge_working_tree()?

Sorry, but I couldn't quite figure out what you are saying here.

My guess on one part of what it says is that an explicit
"--autostash", we should stash without second guessing the user
(i.e., avoid chedk and stash).  But then the latter part of the
sentence "and unpack_trees() fails ..." do not quite parse.

If the user gave "--autostash" and we check with unpack_trees()
dry-run and find out that a normal branch switch will be interfered
by the local changes, then we would stash, but that check made by a
dry-run unpack_trees() is not an "extra" check, so, that does not
work as a guess of what you are saying, either.

>> If we can sell it as an improved implementation of "-m", we probably
>> can lose some code that the current "-m" implementation uses to do
>> its merge; we'd be instead using the "unstash" code paths.
>
> That would be nice but I think "git checkout --recurse-submodules -m 
> <branch>" currently updates submodules whereas "git stash" does not know 
> how to recurse submodules.

Hmph, I do not do submodules outside what we already have, and I
certainly do not do "checkout --recurse-submodules" with or without
"-m" with local changes in our submodule.

But does "git stash" even need to know about recursing into
submodules for this?  When checkout recurses into a submodule, that
checkout that is working in the repository of the submodule can
handle "-m" itself, which may stash the local changes made in the
submodule, no?

> It would be nice to teach "git stash" to recurse submodules but I don't 
> think it is completly straight forward as we'd need to store the object 
> id of the submodule's stash commit in the parent stash.

No, let's not add more commands that take "--recurse-submodules", if
we do not have to.

Thanks.

