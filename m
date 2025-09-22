Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8130147D
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555941; cv=none; b=C3cfvHp+SRrhAqiuQIBT4YDXr+eeWw4k13cqHwqZSfJYdcDTm6TptMPVduLflN14Q5+NRhPPxJdDKmevQ/rOw3+9db2NrQlGN/lB15RmTS3nFJqXRaP0gSXnat3AJdH56plfWAVqrppgzjptID2Mgjywji3wVM0eR+T4zCK5Ok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555941; c=relaxed/simple;
	bh=xNMEPnhBAugAqINXgRuaaz0ReDaNJIuIfKNaDA5IVSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d5n5onZ1q98nDrtMXAz65zqxBaAVDqwboCy6D3zfbHdv0GeSfzbGjkJXCnm0iJKAuPQ2RrF1VNSwHQiydcO69Ph3YP31IaGANk4aCNm8Z/waxkll15nALutRWHgMYBmvDR/wo+DAkbKnKyGMMKOZq/Xqvoek5s6QrDAm1kFadS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QO5UkSzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZ4BH5i+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QO5UkSzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZ4BH5i+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F7C0EC0305;
	Mon, 22 Sep 2025 11:45:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 22 Sep 2025 11:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758555938; x=1758642338; bh=oeJMUcmhIF
	ee8o2X5lqdyNV4rTG1xtoAHw/Tp7J2mdg=; b=QO5UkSzct0s7HhVqRslXS5JQm8
	6gBw6UMibx8ajdWNXHwCSTMyWV0LCvwbYHwdsUIDvw7zDGM+Z0HRP3KY+uBX27Zh
	vwvHt3bRc+YnR2LnwWzg+UL4sJZRbj2Cfyg6wfMv5h7xit4z9VzY1DlIHY95L9YU
	X0+a7rDg/Xv/m5qoLyVdoaylNYYmBl34DtWvNWymEKWhvpdsFd9h6vTA+ACjjfdy
	FmprsUH9GzjoQMDk/DiwwyCediEYPygqy9pXp0c+rxZ1U10IO321zCKrKEitc9/K
	Us1vGgj7FtOx6ASOSxUt1a8Dguc/LinrNGYnf0cXaewrWFRA6wbicPGwa+nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758555938; x=1758642338; bh=oeJMUcmhIFee8o2X5lqdyNV4rTG1xtoAHw/
	Tp7J2mdg=; b=WZ4BH5i+iUwtCmx/JDs0bya49Egc/hriIbGpv+FtM61ZvoIneZa
	VkhcERFbOd5NwOTOcXlJQHLGuCD8LrZ5jzNTL7q2q4Mp/fBwoG0KVHRzCDXsMZuG
	O29ISaB0S2y9fMtB6RVN7bRTVztCcrFc3S8L+81k9EUE4UIbzYEaxEMn/59nLfpA
	D4XttlPPHXe8gCC9bNEIMy1QEbdtD40MxZKjwDdKls2XDytclG3KYGbrxgNN4OIb
	erYRf4vZEOE/0otvLK8OIVifp/ZN/PMxxJxeiwwVE6NUJDz3MRaQuLBvIBWSXJnX
	QaY60ybGyXv1nBJ8HffRiMvWw50iG7XEC0Q==
X-ME-Sender: <xms:Im_RaK9oO1KsSlrWhgyoSSt9H_6GSbvjf4EDamNdSLnKnk2ZNKCozg>
    <xme:Im_RaOYNHp5fkRWBn_xhsw_s1gAHIIJTeA8OBn5jgSNw4238lzJcU2h2uplvWZqKN
    jPIJNQKyWQOrJ5Ox2ZUJhN73xE_8mv18j5XLRGQQwIr5Jyp7FZX-dE>
X-ME-Received: <xmr:Im_RaJ3pE-Di22Z1UOtOYOy4lvkwW-nBaomh4RCne_GI9ann1QuNwHe0eqKt9ziSQM29680vuZlWd60EodUEyTx0-J5KIirTW4UG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkedvgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Im_RaJb1BrNdz6HixWm-OKOzN9-IxzT-U8LDAu3kJu8F9MnPqONWlQ>
    <xmx:Im_RaBIkWVtA13VmlTx6rZufZnv3D1vzAJqpOOo-PPf1KCJ6rZDakw>
    <xmx:Im_RaIGmJGdUgUiafMKwjf7bshZAmIFxY7c6Is8r5gZFcT47wZ3nYg>
    <xmx:Im_RaItBJ0MIjAG8-q2jyrD2MFmRJv7pjGOb7ARvgEgegOUTY9jD7A>
    <xmx:Im_RaGVOl3LZjpcWltFKHIyzX8T0BFDMM4YsO9w27Rr_8x05uhqO2afe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 11:45:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Lauri Niskanen
 <ape@ape3000.com>,  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/6] stash: tell setup_revisions() to free our allocated
 strings
In-Reply-To: <20250919224027.GA594545@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 19 Sep 2025 18:40:27 -0400")
References: <20250919223351.GA3906184@coredump.intra.peff.net>
	<20250919224027.GA594545@coredump.intra.peff.net>
Date: Mon, 22 Sep 2025 08:45:36 -0700
Message-ID: <xmqq1pnywkwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> In "git stash show", we do a first pass of parsing our command line
> options by splitting them into revision args and stash args. These are
> stored in strvecs, and we pass the revision args to setup_revisions().
>
> But setup_revisions() may modify the argv we pass it, causing us to leak
> some of the entries. In particular, if it sees a "--" string, that will
> be dropped from argv. This is the same as other cases addressed by
> f92dbdbc6a (revisions API: don't leak memory on argv elements that need
> free()-ing, 2022-08-02), and we should fix it the same way: by passing
> the free_removed_argv_elements option to setup_revisions().
>
> I've added a test here which fails when built with SANITIZE=leak because
> it calls "git stash show --". This by itself is not a very
> interesting invocation, because there is nothing after the "--", and
> thus the "--" is not really doing anything.
>
> But I think the current parsing in show_stash() is a little
> questionable. It splits the arguments into revision options and stash
> options solely based on the presence of a leading dash, with no regard
> to "--" at all. So:
>
>   git stash show -- foo
>
> will take "foo" as a stash option before we even pass anything to
> setup_revisions(). And something like:
>
>   git stash show -- 1
>
> will show stash@{1}. But I would expect anything after the "--" to be a
> pathspec. So in this example it would show only the part of the diff
> that touched "foo". And something like:
>
>   git stash show -p 1 -- foo
>
> would treat "1" as a stash and "foo" as a pathspec.
>
> That may be something we want to fix, but I want to focus here on the
> leak-fixing without changing behavior. So this test is a little odd, but
> does what we want without locking us in to any particular behavior (we
> only care that "--" by itself does not change the output nor leak).

"git stash show" gives a "git diff --stat stash~ stash" (i.e. the
worktree relative to then-current-HEAD in diffstat format), and "git
stash show --" (no other arguments) gives us "git diff -p" for the
same, it seems; this is with or without your patch.

We may care "--" by itself does not change the output, but it has
already been giving different output without your patch.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 0bb4648e36..1c9e589bbe 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1741,4 +1741,10 @@ test_expect_success 'submodules does not affect the branch recorded in stash mes
>  	)
>  '
>  
> +test_expect_success 'stash show handles --' '
> +	git stash show >expect &&
> +	git stash show -- >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

In other words, this test should not pass if the stash stores
something reasonable.  The only case is when both "git stash show"
and "git stash show -p" would have been silent.

The commit object pointed at by refs/stash before this test runs has
this curious thing.

    tree c5f56db0c5c4e40b68ffda4bee76b301c9cc3406
    parent a2a54b9cb0873c567fbab134c4b95020b9419f6c
    parent 182836fa1adbc25d81a137d4e7489cbd0bec744a
    parent f93620bcecd8173d3bd3ad4dff4e69e32ba6f278
    author A U Thor <author@example.com> 1112912473 -0700
    committer C O Mitter <committer@example.com> 1112912473 -0700

    WIP on orphan2: a2a54b9 A

The trees of these three parents reveal why this test passes.

    c5f56db0c5c4e40b68ffda4bee76b301c9cc3406
    c5f56db0c5c4e40b68ffda4bee76b301c9cc3406
    adc18b651de078499a4acf1454fadb65352ed961

In other words, "git diff refs/stash~$n refs/stash" for n == 1 & n
== 2 are empty and this stash entry exists only to record the
untracked cruft.  Even "git show -c refs/stash" would stay silent
for a "merge" like this, and both "git stash show" and "git stash
show -p" would of course be empty.

I do not think we want to drop this test (we do want the "handles
without leaking" part of the test), but we should not expect the
output from these commands match.

Unless we are aspiring to introduce a breaking change, that is [*].

Perhaps create a new stash entry that does not show anything in this
test and drop that entry with test_when_finished before leaving it?
Or just run "git stash show --" without any check on its output,
possibly with a prereq that we are running under leak checker?

I dunno.

I only discovered this while merging this and another topic that
happen to touch the same t3903 into 'seen'.

Thanks.


[Footnote]

* I personally find the traditional behaviour nonsense and it may be
coming from the crappy command line parsing we have had forever, but
I am sure people who wrote

    git stash show --
    git stash show --end-of-options

out of "principle" in their scripts, and assumed that the patch
output is the norm for the command even though it should have been
giving diffstat, would be unhappy if we suddenly made them behave
exactly like "git stash show" (nothing else on the command line).

