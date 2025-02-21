Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE51EF090
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160079; cv=none; b=Yw4P4UOg5F0wxWeVgyvWtPx9JAu6764l3m/ADxPR7/Pbjm/KG0O5GCLCCw4T7B0jFEoBGi2znwmbsD2ziicrCfU65DVfG0GciPvu7Voq57Vriwi6PSycngun1d/htjMT9dLq0CtxXQbzXo6wPKxGIcWl72KwK4SuDALGy9LnWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160079; c=relaxed/simple;
	bh=x5+vgaZgj42JF9Iz89NIlAiNdMCrF97nNkUORG7MOno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ix62d98iM0u4klaEXs2gBZBp1G4NJRVRycbkHg1segZ0XBpvyoh5NC7uAZ7dG6JAFa4IKot4iJs7+0PdM/+rnO7LvEm9qaQBWxnzsfkFG+vvHk7cL3WTW34Ip7/xsI+VPtncXvnTu5mvSFudLWBsrYpuInc7t2QaWoaMXKHJWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rJSinrqf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNp1SGG2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rJSinrqf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNp1SGG2"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3CCE2254013A;
	Fri, 21 Feb 2025 12:47:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 21 Feb 2025 12:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740160076; x=1740246476; bh=TFOpSKLH0L
	qLkBIw6EY01xey0TQsuJFq1MCzCSPLpAI=; b=rJSinrqflr5NTjX51UeqW3DQ4N
	woO3gGG/zoSW3A22Zot8V8xnF33zlHOi6ZIauIGyNLFnYAaANoV64fdcbsFFNfli
	oB198ybCJTatLmO7JtcFZ3SQvZIQe4W0LaNQ8iwEF5UXr46+d9MH0a6H6UDWojtW
	+m8m/G93VZvMOMquxKhY30jjBb1w9f5ujfYvmJXvmvLYd4lPBa6qt9CQo560s5oY
	PRTDQc8prrVJuNKboQi0AnTZpLo/qylYU5jTd2Rxhzx9PHC+F2YIUMPcsh47Bt9+
	w9IHpAY5LrRvHB6r5v0NKs+ZInIEiZNOYLz3nLfmWQY5XMk/QJLKGMsYa+4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740160076; x=1740246476; bh=TFOpSKLH0LqLkBIw6EY01xey0TQsuJFq1MC
	zCSPLpAI=; b=eNp1SGG2IpLb5ux3hPxcyHMR+QN2Dk5UGAZ1ncYOy3V721bkFGm
	vvf+yqckHV/nWCiKoULBo2KOVfNuLXIVI9bOAZUjZAaevucmcAzDZLV09NaY4lFp
	EUeoWLZ4wHJwPDbtO5O4w32OkYWGdo014bgSMl5SIPHHZkwk0c7Gpu9szmD+IAk3
	6aiPO57W5pNN8AmEzhy3wnK31uAEu7Z7XWCLmDCd+bKClUhUnn9jJc2kOtmQhlSZ
	KjCqjlfWya9X0N6pyWK3YvkR0UJCP+KwtKyp2XIURB79kXpCq5AhkCPtaH8Kk5TX
	v5OYse6QHYhg/2llBEwOxMIassnRYfof/0g==
X-ME-Sender: <xms:S7y4Z9xACPWK9T8Zrl226aov0DzdNkmTDV6GWCZiEhH2goRwyh0GWA>
    <xme:S7y4Z9Rhj5nt6FwnkUCOAzFs0eyoGWaJ8MATj1oJeozbiEHaWh854Se6RTckYjImr
    b07hsepCmPjsSL6pg>
X-ME-Received: <xmr:S7y4Z3V3wTL3jtNvbSy2QhbHUGL-hMHFE_W7szgQ5zpM67Lmy4csAVf3kgD81MTZrwK5WuOL_O3stEMxF5r0TXWPHtsdtNxGmxYJrMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehurdhk
    lhgvihhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:S7y4Z_hmckgPeXYMd13XM3XaUxHThxFVW95OYQ1IPovpmVGAtb15MA>
    <xmx:S7y4Z_BrHNpwdK3PJSVfcxfgshgjJaiQtaIqrx2bTt70G85D8WrDYw>
    <xmx:S7y4Z4IxOokzGwnA_VBefog6WgDP3Z7bbxYCkBfQMCgNsyD9mw4a2Q>
    <xmx:S7y4Z-Bxt4gu4i8dsfKdo3_w-WAuKh0J04m0CWSiX3wSja7pm7BfIw>
    <xmx:TLy4Zx2Vt9agcsUAgxNg_ig2Tr2bO_CbT2BCaoBPt7xIszL1pcEHyb4R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 12:47:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: first bisection step takes quite a while
In-Reply-To: <CAP8UFD3XVgJCc2Qa3wWZA54fg38jcpyiDtQOPNc8UQT9uL3vWg@mail.gmail.com>
	(Christian Couder's message of "Fri, 21 Feb 2025 10:15:09 +0100")
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
	<CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
	<xmqqikp4ctoh.fsf@gitster.g> <xmqqa5agcbx6.fsf@gitster.g>
	<CAP8UFD3XVgJCc2Qa3wWZA54fg38jcpyiDtQOPNc8UQT9uL3vWg@mail.gmail.com>
Date: Fri, 21 Feb 2025 09:47:54 -0800
Message-ID: <xmqqcyfbb35h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Yeah, it seems to me that in practice this is a bit like bisecting on
> the first parents first. It would be nice if we had added an option to
> bisect on the first parents first, so that we could compare your
> improvement and that option.

Unless you are talking about something entirely different, I am
afraid you are confused.  We added first-parent bisection in mid
2020.

And the first-parent bisection does make things easy, by making it
totally unnecessary to call the "truly stupid" count_distance() at
all.  We can pretend as if we have a single-strand-of-pearls, give
the "good" end of the history "1" as its weight, its direct
descendant (and there is only one direct descendant when we are
doing first-parent bisection, since there always is only one active
"bad" end of the range in our bisection session) "2" as its weight,
and so on.  The commit that gets N/2 weight is the midway and we
need O(N) computation.

Unfortunatly Uwe's original problem description was not about
first-parent bisection being slow.

>>  * The "this is good enough" logic currently allows us to be within
>>    0.1% of the real halfway point.  Until the candidate set becomes
>>    small enough, we could loosen the criteria to allow larger, say
>>    3%, slack.  This code is written but not enabled (with "0 &&").
>
> If we want to do this, I think we could loosen the criteria even if
> the candidate set is small. Weights are integers so when the number of
> candidates is around 33 or less, a 3% criteria will mean an exact
> match. Then the last 5 steps or so (as 2^5 = 32) would still be
> performed in the same way (with an exact match).

The above follows the same reasoning why we chose "division by 1024"
in the first place.  The illustration patch postulates that we could
be way more aggressive than 0.1% while the set is large by dividing
64, without wanting to loosen the criteria near the end of the
bisection session when the remaining set is reasonably small like
1000 commits.  So we cannot rely on integer division truncating.

>>  * After computing the weight for a merge in "honest and stupid"
>>    way, we know what other commits in the set it can reach.  If the
>>    weight we computed is way smaller than the half the number of
>>    commits in the set, that means these commits we can reach from
>>    the merge we are looking at would score even lower.  We could
>>    mark them as not-viable before clearing the list to check next
>>    merge with "honest and stupid" way.  Again, this code is written
>>    but not enabled.
>> ...

> About #2, I think it could be worth implementing as an option if it is
> effective in some cases, but the criteria should be loosened even if
> the candidate set is small. The amount of code to implement it is very
> small and it's possible that, for some users, having to sometimes
> perform one more step of testing is not a big deal, compared to
> bisecting speed.

The reason why I think #2 would not be effective is quite different,
but I'd not go into that, as your conclusion is the same ;-)

> About #3, I think that implementing an option to bisect on the first
> parents first is likely more useful than implementing it.

Sorry, but is very much orthogonal to the issue at hand.  We already
have the first-parent bisection.

The last optimization is all about how to reduce needless calls to
count_distance() by rejecting merge commits that can never be an
ancestor that a single-strand-of-pearls history from a non-merge
commit with the best "score" could reach.  And it is relevant only
if we want to improve performance of non-first-parent bisection.

Thanks.

