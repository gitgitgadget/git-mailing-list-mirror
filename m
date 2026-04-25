Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5D314B96
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777085686; cv=none; b=q7Y9vkhhh0pbsk/HzR6hJlfmvCGKkpDeMhtq93QccI96tk8j8dc4a93vymqGVnvl2KrHlymqiFFOJs1KGw16l4qf1obbsDeg/g/XePukGS9MyR2seIM4+ncR0fIua4Rm4AIrBHEQv+aAFeiwicNR5+2ARqv+u0Iy0Hr6IGpJdv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777085686; c=relaxed/simple;
	bh=rpVJVtj88XMaKaUir6JbmWnfv2kaPPLon5odiAZoVjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hcBvrmgMkhr8RlFLg5bx4GxN9j+x1lmIxXMienwFn+V7VpX7he9Rb6aAe99+AjZjUgYGi5rxnch+vd4udURg5cl5pwMM7h1vvLWsidLppDHSVBfg1u2S3B6i5fpOKr0UEvmj5I8BqtBNG+VO416uwKvQ/CY4NFSB02TANN9A/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XyBEGHWK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QheF6ZTs; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XyBEGHWK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QheF6ZTs"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F4BC1D000B5;
	Fri, 24 Apr 2026 22:54:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 24 Apr 2026 22:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777085683; x=1777172083; bh=U6uwhFGG2J
	zevtTUPA1MOYgmiMMz3sfh64la4QLHFGA=; b=XyBEGHWKAVvb2pM2QGWbZcHOk0
	A2vAGar4Dk47X/eKo3r+EewyCiURhCduFAMb+PHr+Tdno3sHwTgWl37l3YZZJe6t
	+jLLy+8uGQJfvZZ0S2fvNJiE/jSPQxZcHY37XvvZ6FwtwKdBlriB7p0NlFHkXB4h
	0lKlLSu/8hBBss6qYS/8SwIL4c7jtYYX+uousH54C/8kzrThxFLLW72GY+92/UcG
	rJ1Th1vrkqYsDXAFv+lzAgEVgG7n3WS5HktTPav2MIM3wTKNqaYvZORvyp5dJE6/
	oNKm+Gwfhp2l3AyAbTGQ1yBnRvl/MyT/MAaw9geu5m7py+RbMnp89xKpOWbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777085683; x=1777172083; bh=U6uwhFGG2JzevtTUPA1MOYgmiMMz3sfh64l
	a4QLHFGA=; b=QheF6ZTsSjLusuYPsE8UBqpMGfAlpMxMBNXsHskiXZwjeCn8TKz
	VK92Uzxmdh872CECDRaD7rXSfqS0ca3p2zEz4q3O8LiAtV8v/SVMXMBv059bagIs
	xmag1D6wAXIkLdZMju3JRZyHU3QYtMpK2/9k769ttll2lBlwHLfSHESzEe5ek+1/
	mjx3gagfR7UfSQNyqh8zVXIKWJyVgUsuFrCS3AJqHz+SLoPDvs8mHkXj3SZh9j02
	pcT3/l/AKsOj/MNNEO5YpsfaCVNlXkan5TM7/lqVxyYAS6LkLjg1HVCoab2Oyp7b
	vNfZ4hFbMsvGGeFhbNafzNhqcm2MoWgPVXA==
X-ME-Sender: <xms:8izsaRxRILGzEBBfvCso4bewZNP-9GO-7ozOmf-PtjaVrUue5ld_Eg>
    <xme:8izsaYRxoOTYxXp4sinUqpp2USv765JER45LoBGecph5i-SgMDF4xQgnNOcoSVFYz
    78znFK57zDsQjRc_YW4AJeM-8cOTIs2Hu3qQgRKRdPCp0XnyDEMvjc>
X-ME-Received: <xmr:8izsaQX75gnSUfm0thhkb4DuGQBdJ1KfRSkoJHVClhi4OZjEo2oewmz4YIg4MOETZrgYKdorkzAU4S2wSTnQmrKRSQCRT-gFjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejudejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8izsaSZtm1QjnSm8qmfgqb_EOk37xyx3pmTMh9IZe_8p45eHaqvvIQ>
    <xmx:8izsae3ShuredpHR14y2XQCvCK6Q6xGAUc1Xku-Stfpf_AYyY2-rdA>
    <xmx:8izsacgK-0MfM8DIpYGGUydf14G0s1_nu4iz0SkajWuQ1bXhDrhFLw>
    <xmx:8izsaaZa3mW7uA-QLSvx19TmGSX-8inWRcYas74MWIO9b30QU5l2Vw>
    <xmx:8yzsaX05y2T4A4xE7YskwhJniVpZXPFeuVUHU1LT2XXqb_4JacPKwFQJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 22:54:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] checkout: add --fetch to fetch remote before resolving
 start-point
In-Reply-To: <xmqqeck4xan3.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	25 Apr 2026 07:21:20 +0900")
References: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
	<xmqqeck4xan3.fsf@gitster.g>
Date: Sat, 25 Apr 2026 11:54:41 +0900
Message-ID: <xmqqfr4jwxzi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>
>> Add a --fetch option to git checkout and git switch, plus a
>> checkout.autoFetch config to enable it by default. When set and the
>> start-point argument names a configured remote (either bare, like
>> "origin", or prefixed, like "origin/foo"), fetch that remote before
>> resolving the ref. Aborts the checkout if the fetch fails.
>>
>> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>> ---
>
> It is true that "checkout" does funny things to special case the
> remote-tracking branches, like setting up the branch.<name>.merge
> configuration or even inferring the name of the local branch to be
> created.  
> ...
> ...  Should the configuration cause a fetch to happen before any
> of these uses of remote-tracking branches for consistency?

The last one was a rhetorical question.  I do not want to see such a
configuration variable to implicitly trigger fetching at all.

I am somewhat sympathetic to the desire "I want to be sure that I
start the new branch in a state as fresh as possible".  It is tied
to the "--track" option of "git checkout -b topic --track
origin/main".  If you are merely starting at a single arbitrary
commit, instead of anticipating to having to repeatedly sync with
the remote-tracking branch that will subsequently move, there is no
point jumping to a "freshest" commit that you haven't even seen let
alone inspected (i.e., you do not even know if it is a good base to
build on).

So instead of introducing a totally new option that can only be used
only when "--track" is given, it might make more sense to introduce
this as a variant of "--track", perhaps "--track=fetch,[in]direct"
or something like that.  And extend branch.autosetup{Merge,Rebase}
that controls what happens when a branch is created with "checkout
-t -b" or "branch --track" so that the remote-tracking branch gets
updated, perhaps.

As to "git checkout origin/main" (nothing else on the command line),
it has "magic" compared to "git checkout origin/main~0" already by
treating the parameter not just as a SHA-1 expression that names a
commit object but as a remote-tracking branch (this is necessary for
"-t").  So I am not fundamentally opposed to the idea to give an
option to treat that form specifically.

Having said all that, quite honestly, I prefer not to see any of the
above changes, including the original patch.  It leaves too many
usability questions unaddressed.  For a starter, if you interact
with a repository with two or more branches, should

   $ git checkout --track=fetch -b topic origin/main

update an unrelated remote-tracking branch origin/maint from the
same remote?  As I already said, most Git tools _depend_ on the
stability of remote-tracking branches---the desire to update the
origin/main when a new branch that builds on origin/main is created
may be a valid one, but it is unclear if that warrants updating
other remote-tracking branches only because they come from the same
remote repository.  There may be a dozen other UI/usability issues
that will be introduced if we start to "fetch from remote"
automatically, but I won't even try to be exhaustive while I am
still on a leave ;-)

