Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679EE2BE032
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118677; cv=none; b=mGkhBCZb13nIDau6GiI0TBocC4zuc274WPCXXgOOSkp9wGpSRKssVHTnN1fRCS2xQO8sy3VPLadZ3rVxBQA4DdpiKfqnJ9pCfY7x2AkEgRne5gF7f9OaS2yq/LYlugVKjZ1FWcEcKM9Srq25872lGh5XE8xBmXVdWCJoPVZqBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118677; c=relaxed/simple;
	bh=o9MGIDgQ2yjB0yZPGeS0bxKkvky3LnUXERWdP9q9r7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YLp0pKWY/rURyZwb4d8VsVc0f7yHcYwY3714Zm+oVy1sQ9IaHTtad5nVC+pOfSMpqmjGE1wP+UobhHpzmQMfsM0BkL1ddQain+lsGjL3w9P0aIwNPrc6oujIKkR7FaUn0aASj7GRNddaDs3amfwAHMR6kOjaDoX3Bz3x3/B8wvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L/e2tONS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z68GLmTw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L/e2tONS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z68GLmTw"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6DD011400123;
	Wed, 17 Sep 2025 10:17:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 17 Sep 2025 10:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758118674; x=1758205074; bh=Hn4Aw3QwOH
	2r+EBr86HRfpvztPjVCm9O0BJsNyfwAkI=; b=L/e2tONST+iDu2Arhnylg+g04Q
	uPvc9fPgaGLSHYSucVyNQBVMnMN7wBL6glX+hUe07cVO/wlS98AU3KjWZ5f2h/Yf
	1txCRzzWwH0zWdkTwYjCh9yZvvCOSGn2NXznvpnjLDhBAxJx3h0+JflkPbygaHm+
	068lYuKPotCnmT018P0pmoSq3i/uq649INzyv/nJTTy6s7fYcS//JRo0MKFAjWdD
	4O/1WZPGnaD0brkVU6NYSUzvuu8GLmx9SWiFOPTZee9dKQc9Yxzy6trG/Tf14EvB
	ecyQncRb9kf6EKLDXEq9fWBSQeEufYn89tZKNns+L+yqntR+HWfHfIzDFb8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758118674; x=1758205074; bh=Hn4Aw3QwOH2r+EBr86HRfpvztPjVCm9O0BJ
	sNyfwAkI=; b=Z68GLmTwTkGWOw4DpBArc9G3i604YMA28zYJUt3c5Yix6DpkVZg
	CKYD9BI8unwy+Vc2RGtCl1wkn9pV6lxSj0tOQzqKW730ej/cX9OeUn0kFDfQmI9Z
	BGJJHc09An764z1lUiteJ6yysXhjokM90XoR8lnMeoSQdwCpEbxbZ8wUIBoe8RJ1
	wZ5wrjXoY4TsQCo0a6z4MswgG0CtmaVqokSBkLQvUOLKj5HZUZ3wd4iNJxnMZdPz
	Jnn2T/rMKR5B3/kKl7q5Nvu8vF7PQX1fzhZtGUYoPcvjHKPo0foxXggK/bU3POcV
	SiLIkRECuePEtgZ226Dzk8EttixUjSSBQOA==
X-ME-Sender: <xms:EsPKaKryw9V5XDlbqp0v-Ryl-DdYvuKNwwau82z2KaYrBQ63YkFmIw>
    <xme:EsPKaJbdoJd-goUaj3hOr113vmC1XyPmEPchJO9-Oi0Ndml3C5WOLBeVhZNyu3kjw
    EBovoTH_rt2THmPXg>
X-ME-Received: <xmr:EsPKaLU7CwBHZEBs1OKX18fNA2d6nPElTB5Pqdr0iYCS0_iwNdnbEV0EzPwTNBDpSJ7nduNr66x75msurm6IgF73UXRvyAzi5fHSMos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgrggsrhhivghlrdhstghhvghrvghrsehinhhrihgrrd
    hfrhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EsPKaK-AUSvJi12gSwZB4phzwUOXLuzV-qoIHisx9jAOVgpAhpGcWw>
    <xmx:EsPKaM8Icw10PJoPWf15iY6HVHouSRNuoC46n6h886GMw83WafSVJg>
    <xmx:EsPKaCSW_J-xzHUn5Xhd_FrO1aCRM5w4DIXQ990phlz1TxcdKcdQSg>
    <xmx:EsPKaIezTz2gNEArMB2vktBi9E8KMEuteSLUsbaOM6hX5FH5OnYagQ>
    <xmx:EsPKaI2PzNzFC3P5wZvHqbLBVIAoWSNHhTZC9hTXxd3FzO_czlNm_XaW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 10:17:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gabriel Scherer <gabriel.scherer@inria.fr>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/3] checkout: provide hint when failing due to another
 worktree
In-Reply-To: <0dfe3e31-5486-446e-8af5-20669c06ea64@inria.fr> (Gabriel
	Scherer's message of "Mon, 15 Sep 2025 21:52:19 +0200")
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
	<20250913141327.2775228-2-gabriel.scherer@inria.fr>
	<be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
	<d44109a1-0ff5-49f8-885b-9aae195ec492@inria.fr>
	<xmqqikhkhzbm.fsf@gitster.g>
	<0dfe3e31-5486-446e-8af5-20669c06ea64@inria.fr>
Date: Wed, 17 Sep 2025 07:17:52 -0700
Message-ID: <xmqqms6tgo33.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriel Scherer <gabriel.scherer@inria.fr> writes:

> To my defense, this is the hint wording that is already in the git codebase:
>
>   $ git switch HEAD~3
>   fatal: a branch is expected, got commit 'HEAD~3'
>   hint: If you want to detach HEAD at the commit, try again with the
>   --detach option.
>
> I am happy to improve this wording as well if we can converge to
> concrete recommendations.

This looks like a typical apples-and-oranges comparison to me.

I do not see any need to improve the above.  In this case, it is
clear that the user did want to detach but they just forgot that the
"switch" comand wants an explicit "--detach" [*] when switching into
a detached HEAD state.  There is nothing inherently risky in the act
of detaching HEAD that makes it something to be discouraged.

    Side note: This was deliberately made to behave differently from
    the "checkout" command, which intelligently did the right thing
    without being told, i.e. HEAD~3 cannot be a branch name, hence
    it took the command line "git checkout HEAD~3" as an obvious
    request to detach HEAD at that commit.  So if the user came from
    knowing "checkout", it is an easy mistake to make when they
    switch to "switch".  No pun intended.

This is vastly different from trying to checkout a branch and then
it turns out that the branch is already in use in somewhere else.
We strongly and actively discourage a branch from being used in two
different places, in order to avoid an update to it from one place
breaking the other place.  Unlike detaching HEAD, this one is
something the user needs to think twice before doing so.

And in such a request, there is no indication that the user even
knew that the branch was already in use elsewhere.  It is plausible
that the user may not even have tried to check it out if they knew
it is checked out elsewhere beforehand (if simply because such a
request would be rejected by the safety mechanism); if they only
wanted to peek, and if they knew there is already a checkout, they
may have just cd'ed there to peek, for example.

Depending on what they wanted to do by having a checkout of that
branch, a suitable and safe course of action would be different, and
hints would want to help them make right decisions among various
possibilities.

>> I think the message should help the readers eventually realize the
>> following things to make intelligent decisions.  Making them short
>> to fit in the "hint:" messages is left as an exercise ;-)
>
> Hints make advanced features self-discoverable -- otherwise we find
> them out by reading the entire doc of a command when we are stuck
>
> After reading the hint, users can read the documentation in a more
> targeted way to understand the implications.

Sure.  I phrased the above paragraph is somewhat awkwardly, but the
point I wanted to convey was that the message would never be able to
teach everything they need to know---rather it should give a good
starting point and pointers to lead them in the right directions to
find out what the best course of action for their situation.

> Would referring the user to the documentation be acceptable?

So, yes.  I think risks need to be told in the message to make them
realize that blindly proceeding with a hammer without understanding
consequence is not a good idea, but we do not need to be exhausive
in listing what tools other than the hammer are available, and the
hint message would not have enough room to be a manual.  So a loud
warning of risks, and a couple of pointers into the documentation,
would be very much appropriate, I would think.

Thanks.
