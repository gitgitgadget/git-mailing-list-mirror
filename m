Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413D3F9C5
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696131; cv=none; b=llipcT4KQDqZPU5gKKwakR+QuY1LULyDomzAW2wkgjs+HwUHamw5RQFJYKOpaYGgPzgyIg1lEvBqvyNJ5EMaRX9gZnHsWEbT4o6hsiEDWqNVMZ1IY8rn9hNuRnalpWRWl3FQqvt7V+77HiQkawT9lo3oc2l00lfEM35RzFnGve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696131; c=relaxed/simple;
	bh=bVixkEq6XS894hBr3qlSY4rq8ZBL/E0fujew5I1niF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aNUKqTe1Xz9acQccwb1VCyD4oN51Y1VKqA18WoBf9yRUHXK+usgUS9VHXNKusowyHOo89ZIGWQMm4F5d/xPaAos6JYAAn7Cl2Eza2QQkq9teZ2LYANAgTYaQmtcqNMHM5HjsHcwCSpeoVUKwNV+Cv9eFPA7ymiSjBXpn7eC1HpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WqEVJHC4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XcoMdMc9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WqEVJHC4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XcoMdMc9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 00B377A0049;
	Wed, 16 Jul 2025 16:02:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 16 Jul 2025 16:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752696127; x=1752782527; bh=fNqWcDhPku
	riHv43HXl6mgVlNjM+DrbeflnowcpKXd8=; b=WqEVJHC4mH3XIYDoaFVlQ3x7KQ
	/+DDrF/94UUGJgDsBR2N4bk8FYzj/9DnJMz/nF7kVkVShND9wmsf2e305gn7NojA
	7SMgFvh59YZ/aaT44EC8bxYOpJ0lUxzYlZtYeA9FpilXkWgQFOHGsYax1ZHFnMWE
	ofLYdxyKa1Sz9o5RLRf6oItbSFAPDLQzCguL7Pnt0K7P6RMugfrG8xV7tDBHLyzH
	TzFsRsDybwQc0U1911ABuPrQ/66V99/MvaXM2y3G7GJiIE7LIoYkWRPIej2G5rWh
	yxZ9Nx+rCEzTU7AaYGaht6aQznXTS+ffwtV0G4Ld+dspgTChaEykR56jOdaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752696127; x=1752782527; bh=fNqWcDhPkuriHv43HXl6mgVlNjM+Drbefln
	owcpKXd8=; b=XcoMdMc9w17g3KhPT0aSjurdoBdAmIgCwY3l4/Xvfq8gXtSwZr4
	+78IYdvAn4iimLngnm6GCe8iEbpkcXDCdpoR/i9l76ggWULMQ5wIKI8zGnsYF56P
	C0jRaCE/Ufqdx9rl7wxnTnh75asS2fnZ6/dK812h0lkq/Y8Y+IlVxt2+BtZImYXe
	2S1Ok+VfrfGqkgw4v52jc38obgkVuWLKPNC+8JGkiu9mXNjEERSPKYgEnPwKL9Ox
	bCIJUEUUcLvNvjvtCzlj1firyhn7CetTYlblOsdVQq2VAuLPp2U2PYt4BFCenvbA
	r3yGOQUe1ZE0IRcjnVESskNW49DAD9VtUZA==
X-ME-Sender: <xms:PwV4aKB8ZaSVQ3pZKAq5HykPsy6SNl1GgmrR4TT628r0c8r-wW1Lcw>
    <xme:PwV4aM8qcRkYx98wHWh3KsO3KaXUVLrU35GgBZOIMIFKugULhNBE2F-kDfiZHmuKb
    WPsU_oxgalxwOsemQ>
X-ME-Received: <xmr:PwV4aOCjZl5O4RrV7yGqyM9RUNvYSTsOwmDDvX5jKwV9eiD5gs9Ui74xe9AN4AFVEAVqOEb2oMwcarx1kCJ3-z15f-RRfpwjXktLjIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PwV4aJTV5CE6rcME_h5_UAsq0G7EmBlpGFZ2AX57ElWxDC6SBpyo4A>
    <xmx:PwV4aNsG8tEwvJzwGjyeq6UOQfJnZVPRpI-OlmWq4vU7FZK3QsVocw>
    <xmx:PwV4aN0jIiCrGb5BVOZhSpAHo51PnMc7T7ummAsb8a-aJ_F1STjqhg>
    <xmx:PwV4aGXXSw8itjOY5y72-zW0mWH85ysRDr7hkw_V9mlwyPicNbPD1A>
    <xmx:PwV4aNBeGCPz6xqVPu39SFXqh5zCDPneFcDIAgzjxzUTHEhsUJIAe9XZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 16:02:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  schwab@linux-m68k.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
In-Reply-To: <CAOLa=ZTc2_g3+8MM8whW+eZAj-+36HNsnUFDoLgnN42ytFLwAw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 16 Jul 2025 07:40:30 -0700")
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
	<20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>
	<aG9hMP9gEFLhVgJL@pks.im> <xmqq8qkqvjnu.fsf@gitster.g>
	<CAOLa=ZS6ASf1+nbUnCTeeH1Di=kgmhQUEQ5UXPZu051rfqx9Pw@mail.gmail.com>
	<xmqqms95if8e.fsf@gitster.g>
	<CAOLa=ZTc2_g3+8MM8whW+eZAj-+36HNsnUFDoLgnN42ytFLwAw@mail.gmail.com>
Date: Wed, 16 Jul 2025 13:02:05 -0700
Message-ID: <xmqqfrevc3b6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Let's say a user is iterating with a prefix set to 'refs/heads/', this
> would iterate over all the refs with that prefix. But mid-way the user
> realizes that they only care about 'refs/heads/feature/' prefix and they
> ask the iterator to set that as the prefix.
>
> In such a situation, the iterator seeks to 'refs/heads/feature/' and
> will only yield references with that prefix. In short, the previous
> prefix state was reset.

Yes, even though I wouldn't call such an operation "seek", "Ah, I do
not need the entire refs/heads/ walked, only refs/heads/feature/ is
enough" is an operation mode that makes sense.

But not for paging, though.

If your web application is showing all branches, one pageful at a
time, and the first page ended at refs/heads/feature/something and
you ended up "seeking" to refs/heads/feature/ to start the second
page, you do not want your second page to end when the iteration
goes out of refs/heads/feature/ hierarchy, no?

It seems to me that the root cause of the confusion is because
prefix, which is to let iteration finish way before the data runs
out (instead finish when the iteration steps out of a given
subhierarchy denoted by the prefix), is somehow abused as the
current position of the cursor.  Shouldn't they be two separate
concepts?  The cursor needs to fall within the prefix while the
iterator is active, so they are not two totally independent things,
but prefix is pretty much static while the cursor position is very
dynamic.

> This series did start out that way around, so ease of implementation
> isn't it. It was more of a side-effect of not clearing state.

I am even more worried about usability and correctness aspect of
what was described here now.  After seeking to refs/heads/feature/,
do we continue to iterate and step out of refs/heads/feature/
hierarchy or can we cut off a particular page that started with a
ref within refs/heads/feature/ subhierarchy when we exhaust refs in
refs/heads/feature/ and have to wait for getting asked for the next
page before we show refs/heads/gsomething that is outside
refs/heads/feature/ and sorts after?  The "I reset to iterate over
refs/heads/feature/ because the entire refs/heads/ is not what I
care about" example makes me worried about this.

Thanks.

