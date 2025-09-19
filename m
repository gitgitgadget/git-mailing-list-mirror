Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED63164D0
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302030; cv=none; b=cc0F7VK8YOYGNsrCv7bs3YWNNOutlEq52YqwoJqbEzTApv1XqZHFsMYB5ww99AOGVJbOnosJGs0QLU5iEHJkBS8ouoc3jV994QZwdiT8CbXbbBGCzxCclfZpqotUZ1ulfUP4FxaetniCQEbnDRUShb+0NZzfOiPXcemS4mzaSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302030; c=relaxed/simple;
	bh=XWtgdZkonw0zCjLvtMf7XDZoBVbvUEgAcfJQEWvnxuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tlKwi4Ud3aW+7EoEsOtLgUcfb3ypuRme6XLHILtzodmOs26butrQJlmA0xbSYyq85KYHXjbIvy0Orhdj6mcQaTAKeX5n1i7f5B6Osourr7L6wsdryiO8z0Ra/bDkPSlp2ZUl6ZI0j28Px9RhPdJIMahr68G0oF4j/UbD81wjITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fh0e4cTD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJd1CTFN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fh0e4cTD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJd1CTFN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F445EC01DE;
	Fri, 19 Sep 2025 13:13:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 19 Sep 2025 13:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758302027; x=1758388427; bh=T86Wa8qIbA
	SY5M3B8BYFSnAoYC34GXhDZGt9ec6kW0k=; b=Fh0e4cTDK5zdSUKTBgKPsJSipS
	lTwGT5Gs/vkilQBgx+EQ2XqeKK4e/d7Y2V2ruxF/E9K0+hHBz+YBuECZBC931Oee
	4kp9QCl+udiSMTtOp0Sxxpw/adp+t37puaXAAq7qybFijPgM/dZr1v8CKep2SHLS
	jix/Cv/fq+JDUv36ZWhwLghtfksTX98APlfKIaJznptYTwuPl45gBuu1sC19q5yT
	f3xOlL+hhRClQO5I2kTJWmH7H1OW+YJ3BmX2y2TkQsJz7VF9QZIFgSO4QuawLNNP
	CaWQXeVyUqwtiQ0invAfDy1M92niiz7uMxIIbDw76rjiiKxmOMcyXAY4xR3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758302027; x=1758388427; bh=T86Wa8qIbASY5M3B8BYFSnAoYC34GXhDZGt
	9ec6kW0k=; b=GJd1CTFNyjk/snykgJ5qGIPRfk8iEBTcEYdIcOpBGZRCA92ttQt
	N2NCWTGVrBrpsYTT7nKDSwNifh0WGZdGKXKEnMNHAdn9aZ0EjD6GvzFVm2NCr9Ch
	G5eQV8/YX+z9dKEOr8//dMVWzPx+Q27f5gmqC/Jc7QzqGd9HV0bBWdX8oyHYR/xE
	/O1mU7ha4ciTfMTRrlP7ncZgcBExi7oZqK1/AjpKwZyONtPdj7/hRw2CHOSoUvKb
	PQUXOLqHZF+PUfgaJ1RLkxI/fdTMzVVJqFaaFuOSqazwGUZNh9SOCO9C6taUPOfD
	VHoFk6/9axthO+GDmqvvM0Jz54r+x4cRNkw==
X-ME-Sender: <xms:S4_NaHbRcJBQUOg09QGu--XWyMNCiTCUvAZNkTx6BcW9ERG0TPQT6Q>
    <xme:S4_NaO2NxJFRmSyoH3xO9QZsyhela86UTlR_cqY7jWCMmhe9pEtQmYeFoQE1Kb3U6
    6HZNriba6BvENWO1A>
X-ME-Received: <xmr:S4_NaKbLnOi7v7JDT8IF2gXzv_YNuClq0XBHFdF_YhcVjTwQ0hR1B7BeAbyM4QCJ9U0W43vgUw4JWaYFCHZFM64Dq7dDJEmFP0F7UOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegleejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtoheprghpvgesrghpvgeftddttddrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:S4_NaOKoNwEtlSnvkEHEP72zK9CBiA1GJu6OuZNpL6SD6cJJmb5ohw>
    <xmx:S4_NaBET9sG83VLrrJ7g8MQ24U0bBBbUe0vbkoLJyPiGNGNEwLNGoA>
    <xmx:S4_NaNvamwozXWNUriNynpAWIcxpqysVtW0dSp-L1sg_oFdXEKZrsg>
    <xmx:S4_NaIv1rjX43lz2OYmOwefX75B8FQFCjpIqR29DLou3kJ-TnatNQA>
    <xmx:S4_NaPj1fls41L2IuAp5eEzlvczoEVexfd95SJ6Y4PeTRFKHqGjZJtcU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 13:13:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Lauri Niskanen
 <ape@ape3000.com>,  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [BUG] git stash show -p with invalid option aborts with
 double-free in show_stash() (strvec_clear)
In-Reply-To: <20250919164820.GA24939@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 19 Sep 2025 12:48:20 -0400")
References: <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
	<1321ff39-6f09-426a-aa75-939ef4e1ad93@app.fastmail.com>
	<xmqq4isy77qr.fsf@gitster.g>
	<20250919164820.GA24939@coredump.intra.peff.net>
Date: Fri, 19 Sep 2025 10:13:45 -0700
Message-ID: <xmqqfrci5prq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think we'll have leaked the string holding "-p" in this instance,
> though. We probably need to pass in a setup_revision_opt struct with its
> free_removed_argv_elements flag set.
>
> That's true even without your patch, too, of course.

Yeah, while I was preparing the "alternative", I noticed that option
being paid attention to by the code, but you are right.  Anybody who
passes strvec (which owns its contents, unlike the traditional "we
got this argv[] from the operating system" callers) needs to flip
that bit set, or they would leak.

> I'm mildly
> surprised that the test suite doesn't hit this in leak-checking mode,
> since it is a problem any time we rearrange argv. E.g., I think:
>
>   git stash show -p --
>
> leaks (I was surprised that "stash show -p --stat" didn't leak, but it
> doesn't seem to rearrange?).

Yeah.

> I wonder if the best solution is a setup_revisions() wrapper for strvecs
> that will:
>
>   - turn on the free_removed_argv_elements option automatically
>
>   - collect the return value of setup_revisions() and use it to fix
>     the .nr field of the strvec
>
>   - restore the NULL invariant at the end of the array (though I would
>     also be happy if setup_revisions() just did this itself)

That would be nice.  I only did the third one in my "alternative"
patch I sent earlier.
