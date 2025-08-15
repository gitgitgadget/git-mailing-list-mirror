Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05D2C374E
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271673; cv=none; b=EAo9nFg51ZZmGCkzmd/0NvSdheTl5I8vTYzPrCfMjdgwG2QDtSms/M+Ypk+0s+tWAHOjL2gdmJ59rfaPtSO7NxYnQsnpaw8rCKMcAqoZDjHNyfPdGCVLVvUaFnfYmDVVVfyzAam25gtnMhgPmeZWACdeNc+qDxqFmg8eQLzKZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271673; c=relaxed/simple;
	bh=fFFRGw4vOofwjl/8JY8aJg57FJGBhQ5iDOeeGJsLuyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJRZWN4crM23LozlPFCI5o5zPiSrFxc24ZBpLSrQX44qxoOa9rXNH1FAxhIAJXtScyJ9lUBpM5hBhnCzY0jb9yeEhfSLljV08qjwMhxwExqwv2yU1ZpnI7kNk7aLW1NLiWsOG5e9V9LpNXl52BBHy6/oomkWlt/Mq5JvVuVCAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NcRlHrTW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNL0EsCM; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NcRlHrTW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNL0EsCM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 529327A00E5;
	Fri, 15 Aug 2025 11:27:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 15 Aug 2025 11:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755271669; x=1755358069; bh=urhi1yD1P3
	YYfS1JjT6bG6Ny66FGcQ+VaXaPhTlDvvo=; b=NcRlHrTWOn8GBa9FviFtWQxJEa
	lyaE2jcXBofDqRY8oKY6MoY1a+0sjip3lbzzdg4Qq8FW9RqclAbvOizNsWgY8NHe
	S8PwmLSSFnoEfPSLQvXR8FicWRAjBGSBrLtiOsXbFAbyDX+ao6bP2HVa3kzesWSV
	SMnmKjFNKKHrTeFBIMgK6cva4HQKZWvWQfRMuNB78oeb78HVNg0oUpf/EZf8riMM
	oBuG4EZgoUtWPwTAeXFf8hYDmewgzXuEt2f06Eent3k4xDPYlePBL4HBIsBjMbgi
	Ktt5WdE6nBc2bliXZocUBfaz4HwD6IA+lm3W8rTVeY1MMVeCNYFNQojsc8wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755271669; x=1755358069; bh=urhi1yD1P3YYfS1JjT6bG6Ny66FGcQ+VaXa
	PhTlDvvo=; b=ZNL0EsCMarUdBI10nINEpyAk0MqmQbjb5UiXdpwcI4Pjdz2hkMe
	1W1Cm3T5xZ9JNw9E0HUAHoBbiMhk4gboJNEW8PGjj7yBo4Lp5QC7ddAnuozynjEy
	LnJyyaPDYeeMwLK+u/7PjV1HTMdX8dgsZX/KnUvDTJSzK5Oro20kR+Wv8+17ATWT
	yZNg+0iO1yG87cTFynJnoYMdhgFHVttMHJwxn1yff01pGEY9BFLmEW2ehtYmwo27
	1Z9R78O4OBcPQTvw1dRopk+39Imu7czDb4sKvFNPlFPFdEom4yvuHWPw18a3Tbws
	0Kn/W3VsfzqfR8qj4zLjtA+2hOnAYR6WOJg==
X-ME-Sender: <xms:9FGfaA3gSEz8jHf5qaVNZHjyRff9gW_zTb-ga4X35NDJfRSYPB17Mw>
    <xme:9FGfaFohOTTH_gdcIXGrmPW1l4RVVEi4G5DkfvWnqOhIj9hBdsb-K4KW3Le8nor6B
    VF7LL7DKPt1h29JkQ>
X-ME-Received: <xmr:9FGfaFcdYjRJIxJl-9R98erlAjWCvPnXVfbWGrxS9M57erakT2bmUgPbvi6Jjv0vjdpFXQY5GRiDeJUOZDkyMT4hokmnYXvBOKaVwRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptggrlhgvshhthihosehstghivghnthhirgdrohhrghdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:9FGfaMrdl5-fQyn9pNlwW3MNUSwkPYKSJbidjmqfFgE2sIsaBqYh6g>
    <xmx:9FGfaOE4u1WB-Ed8PYFzuXyDdl4mihLvtoZ5_vyK5Kf0hUKfqN8Sjw>
    <xmx:9FGfaEtxKMt_raAu4VO63rLzfR8IUAqeaFXe_UN7r0m0wUK560ObBQ>
    <xmx:9FGfaIWFUmwL2Zd1TaKLjJTpEzOH3Pyvde1Wm2rdQlLWA6Kwve98Lg>
    <xmx:9VGfaKGlDgxKEdZSOjrjysT1vdXVY2QatCkzBdHSMeT0KCs7TF5BJirD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 11:27:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Christoph Anton Mitterer <calestyo@scientia.org>,  git@vger.kernel.org
Subject: Re: why can't one alias `git stash`?
In-Reply-To: <CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
	(Elijah Newren's message of "Thu, 14 Aug 2025 21:04:03 -0700")
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
	<xmqq7bz5v0mq.fsf@gitster.g>
	<16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org>
	<CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
Date: Fri, 15 Aug 2025 08:27:47 -0700
Message-ID: <xmqqjz34txjg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> The documentation you are responding to didn't talk about "other"
> commands, it talked about "existing" commands.  Your alias, meant to
> invoke `git stash` with different arguments, would hide the existing
> `git stash` command.

Correct.

> It might also be an infinite loop of sorts, since your `git stash`
> alias invokes `git stash ...` which is...itself.

True.  But we do not do a very good job preventing this to happen.

    $ git -c alias.loop='loop foo' loop foo
    fatal: recursive alias: loop
    $ git -c alias.loop='!git loop foo' alias foo ;# does not come back
    ^C

To be honest, I do not offhand see a foolproof way to "fix" the
latter.

> And it'd mean that other folks who use git commands in their scripts
> now can't rely on any git commands doing what their documentation
> claims.

It is true that it would break common expectations for script
writers (to help other Git users) and those who help other Git users
at their keyboards if we allowed to alias the basic command away and
to change its behaviour radically.  But with so many configuration
variable to alter behaviour for Porcelain commands, I am not sure
how much it is helping the latter helpers these days.  For the
former helpers, those who write their scripts with Porcelain
commands are beyond salvation X-<.

Thanks.
