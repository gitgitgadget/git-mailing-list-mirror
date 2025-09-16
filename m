Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0B2EAE3
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 05:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000740; cv=none; b=QOW+0W8On+Q4TnR7ZSbj4Tyh9qAriIFhKWfaKs0FDhkwLWQ0FCg37j/ir4+H3pPvdyv8AE3zWX9k6abwQDfr1g/n1qprvCDkxEQoTpvSat1MG+bzj/8N0FHosLJaZnX137C4svr2YbJnZhnrN/+zMilPB6LjaoOJZ8NKeDk6Njc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000740; c=relaxed/simple;
	bh=Ma7GAQ9wQYrRy/Hd11UgFzMyLim0EWt08Uo3MJOY274=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2RPTAKIzdnvwtWZWfAwVyHVzsUk69+NaSaOv2Grvegocr6sJoRbR9OHEUYPtc5ZTPIkcplyIkq3Mn8dlzsg4dgOOUlzk8q324+JQdzgCt2QhDGg38tTHqz1btxViRYqFAW2+MAqJvjMeo9hAY+LR514nXc4fkqvlhkApMJDcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cFpJBnQN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YwjaoAwR; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cFpJBnQN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YwjaoAwR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02B477A019A;
	Tue, 16 Sep 2025 01:32:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 16 Sep 2025 01:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758000736; x=1758087136; bh=AbgnUR832w
	i5wC2vcqiX1mxZT4SeDJ27tHRmZXs1XMM=; b=cFpJBnQNTpXp5YQAa0QV20fjQH
	SFnB9cPH2QtBZ0XibfIjscQQmQtFa/vyvetvjjD3tpB217ttYVWqCt5YmTefMZyz
	U3JwFTjl+0M6RC6XFJrj4TwBWbC4EMWePsijoggpPFuQoPAjOJhMkndzdkGXaZTA
	T42Q4o7TgqukSnv1jSfiQh1R7F+Pc00Z2oCx8NeQbaYtdIAKNdnH4EY19srv0xne
	yUSgbfDKMptr05l8Q8fjjKof5lrjWvqwoHAk9v/HVRv/+pGNUfoaaJb9Du2+7Zks
	hvyP9UpcuK6S1Yt7gmVMiuq5nRXBdG2JBU7lB7Acz5cnnnHJVVmGetpxtJAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758000736; x=1758087136; bh=AbgnUR832wi5wC2vcqiX1mxZT4SeDJ27tHR
	mZXs1XMM=; b=YwjaoAwRN4hNtFXFUfj6kZF4gUx4BCz8mkZ9/1LdljErk8HF/QP
	IURS1zbNREgdb9XXQVzSkBj3BEUCBHrf2GpIiD7G1MypjKwymHsvKFOoquVTXFzG
	o6rtLROQ0lY2ZgdrqBTUFlF1khiVofPQDqrYBBHJyemH2Noczmtg/gPt5/eMFtpH
	CZbjh1y2Q6CJW3oUPXsS808IAkNM78Yj63ezlqo/VzO/BQFCyqrb7H5V9Mzoe7vk
	izfqaLyCoCNCbnDPL1C6krYmt6DBeJ3kfvZjO7Mn9va0Kp5sMo89GOC4Gfb6Pkje
	YMuzNSqn1MGfK1EGaLSDe46YFr+Tgn/5cEA==
X-ME-Sender: <xms:YPbIaMOiF6JBBQWLEzbhCxCOJO6ixOEv0sHOZu5X2wHt-FShCuenyQ>
    <xme:YPbIaDtOhcy1Xzulm-J1u5xadfe3yjobYBkNz-qyWPJPN-mQ9h-8VOGYBfW48p6OV
    hkDZIFVPN7wY-RP3w>
X-ME-Received: <xmr:YPbIaPZvn7CamX0XDRULCiSSFpNTBT-mXEfhpUApT17a3VxIE3nqKsJ8ZQ7NPdqu4KB14VSDrh3SoZak0L4H9r1ADD6_wLiIDTGRbmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefleejfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:YPbIaFwmSgunvUGn6hu2ljGxKXzkkXb6cxXthClC1sTVHJ3qpY5ZMw>
    <xmx:YPbIaHgBp5Ab2jElcCtJhD8KZ_3tV56jA_TlKZs6lW-vq7fiiFqJLg>
    <xmx:YPbIaBlMUfgaTjTgh81XV17vNXwVb-_VnI4i3VgBFf2j1Ukb0RC7Jw>
    <xmx:YPbIaNhKtyilxuHT-4ads8ZEzLcTs1PA-mTukELJDf84yChUIeDEeA>
    <xmx:YPbIaIabi57xWhaJwCPN2eHyQgXbwisWIbOOU87QhbL6u1YAYYFYvDzx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 01:32:16 -0400 (EDT)
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
Date: Mon, 15 Sep 2025 22:32:15 -0700
Message-ID: <xmqqv7ljarog.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriel Scherer <gabriel.scherer@inria.fr> writes:

> On the other hand for --ignore-other-worktrees there is no
> user-friendly documentation of these questions currently (I looked at
> the 'worktree' documentation, in particular for the --force option,
> and at the --ignore-other-worktrees documentation for 'checkout').

Oh, that's bad and we should improve them, regardless of what we say
in the hints.

> restriction, what happens if we ignore this restriction, and what is
> the recommended way to respect it.

Sounds good.

>>   - 'foo' is already in use and in which worktree.  Your message
>>     "fatal:" is very clear and is good.
>>   - if you checkout 'foo' here and start growing or otherwise
>>     updating the history of 'foo' in this worktree, the index and the
>>     working tree files of other worktree(s) will go out of sync with
>>     the tip of 'foo'.  if they 'git commit' from that state, for
>>     example, it is very likely that they will record a change that
>>     reverts your changes from the history of 'foo', and you do not
>>     want that.
>
> (This gets me to wonder if a desirable behavior could be to 'detach'
> the other worktrees that had the same branch checked out, instead of
> failing on checkout. Users starting to use the other worktree again
> would possibly notice more quickly that something is amiss.)

I generally advise against pulling the rug under somebody else's
feet.  You do not know what that other worktree is used for, or if
somebody is using it right now making changes and whatnot.  What
happens in the worktree that the end-user has just issued the
command you are executing is much more controllable.

> For me this situation is not a big deal: if they commit the removal of
> 'foo', presumably they will notice that the diff/changes in their
> commit is not what they expect, and they can come back to the previous
> state.
>
> I agree that this is surprising and I understand why the project
> decided to discourage this by default ('fatal error' is plenty
> discouraging), but there is no data loss or anything of the sort, only
> recoverable surprises.

The question is how would they, the person who worked on the other
working tree that first checked out 'foo' and perhaps worked for
some time with local modifications, and then left the worktree so
long ago that they forgot that they have a checkout of it (and that
is why they just got told by "git checkout" that there _is_ another
worktree that checks out 'foo' already exists), _find_ where the
previous state is in the first place, once they go back to the other
worktree.  You may be nice and have advanced the branch by only one
or two commits, and they may be able to find where they were by
going back a few entries in "git log" output.  But you may rebase
the branch and the place where they started from in the other
worktree may no longer exist.  Then what?  It does not sounds like a
recoverable surprise to me at all.

>>   - if you want to grow history of 'foo' in potentially different
>>     direction from what the other worktree with 'foo' is working on,
>>     you are better off creating a separte branch 'foo2', with
>>     anticipation that you'll eventually merge them together.
>
> Use-case examples:
>
> 1. my colleague has a long-lived feature branch called 'super-feature'
> 2. last year I did a lot of review work on their branch in a separate
> worktree which is still somewhere on my filesystem, but which I am not
> actively working on anymore (and maybe never will)
> 3. I am in the middle of a bugfix session in another worktree, and
> suddenly I want to check if the bug also occurs in 'super-feature'; I
> stash my current stuff, checkout 'super-feature', and run 'git pull'
> to update it to match my colleague's remote to get the most recent
> version and test it against this bug.
>
> In this scenario, I don't want my current work in (3) to be
> interrupted by the fact that an old worktree (2) exists that also
> tracks super-feature, and in fact I do want to update my local
> 'super-feature' branch to the most recent version.
> Maybe later on I will come back to my old super-feature worktree (but
> maybe in another year), and I will start with a 'git pull' or some
> other command, and I will quickly realize that its index is out of
> date and fix it.

If #3 involved only "checkout" of super-feature to build and test,
then detached HEAD is the perfect tool that was designed to be used
in such a situation.  But if the goal is you want to have _his_ latest
super-feature expanded in your filesystem so that you can build and
debug, you do not want to checkout super-feature and pull, which WILL
move your super-feature branch and make #1 worktree useless.  They
may have made quite a lot of changes, and your previous state, the
state you were reviewing (and perhaps you had a few of your own
fixup patches there) may not even be reachable from their updated
tip of the super-feature branch.

If I were in that situation in step #3, I'll probably do

 $ git stash save -m 'in the middle of a bugfix session'
 $ git fetch his super-feature
 $ git checkout --detach his/super-feature

