Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57741F4181
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758937001; cv=none; b=ALNGapu74tHo9bMKfgSUQOjzqbqmqQS3iL7h30np4vR1TEowtPSj2e+maz4LrTD29iH1n4TiKzz8hgyoscEgIviGT94XCkN53x6fGCVgFSrDJR6/Bl681Nba0nS/lhuUtnWUA2Qd8bTaLaIPPWNrQpL9JbnbXJJVzpmrfyLIACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758937001; c=relaxed/simple;
	bh=GcchYoma76hJGuSfrAoMJuYy0GF/BPnjc7rFZ/jKlQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hbb8vz19RdsoKygPLlEj4EPtKm6YppJRGTtdkeylkD+4JAf8KQSG1ffdl386518fxCOw6u6kYjzDFKnpFxJLkW0u2dG7n7brjb3Smtty14z5ljwroVvw+1yU5PXTjDR6HzSYFwDe77iMqUPpp2nw06koDfB7Li60tK1HDA9rL1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bs3mwbUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t46WoJ70; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bs3mwbUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t46WoJ70"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C594DEC01A2;
	Fri, 26 Sep 2025 21:36:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 26 Sep 2025 21:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758936998; x=1759023398; bh=s1Bpspd605
	touwdmARd06zcx4ds/LU36x/62aZiM8w0=; b=Bs3mwbUC+ZtHm6nM/zamulXXHW
	fXXGDvnWbvn58Dl+lQW6WORTiFwSyoAPgoTIEj+dq49adLxqPpu5lQP7xQ/+OOWk
	bT9G43BoJCuPiydVQKXJafaJyeUm9u4CMpkM40ZGVcocR/F/AXN52Fnonyic1s67
	u/rMEgbTtLf+m6bSWROdBV+wbJGYz/M5awiih4yCXMb5rhohzu+OHTieOK7nebrD
	UfaryEfhOY9kbPFzyW1GXcSjDHd0eNWDXyt/Vix/1Td/SO3S50HosN7njYuuMjAK
	8TUw32Y4luulyOu9s/gtjw3SlAh4at7UQDkLqJjwpyVDX3TtYxfCzDY1nHzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758936998; x=1759023398; bh=s1Bpspd605touwdmARd06zcx4ds/LU36x/6
	2aZiM8w0=; b=t46WoJ70RUsBahU3CGSrKttPXaxKcvNgtAGe8Ui6OfTowVzcGQL
	//+t6aSaTr7/FdoCovgUvvhjnJ2UDjaWuhSE+E/gaK3IAwsOzRw6SYS0ehzmdCgg
	7VvBtu68KrUXU6qTiB3AmRUy4dO7J7vZ/1BI+xOp23NCuXW9kYUs+nyHE27DyJt1
	+TzSnlM3fyxYJ6jiRg047O8+w9x2uihXe3HNFDczuvnhv9wh1hje+lIgiR7rGtAi
	CbhyE4iLqFhIaWadnrW+fln/bYNcCRI03gthpan3kL2Qg0nh2za21DlpBlhZ/f4z
	55l6rT76bcja61OIGV3qeJz6XjMEIyaSRqA==
X-ME-Sender: <xms:pj_XaLdlzbazDTTzhXqOxDv2defj2f7WGCi2kOIQYeeSNSAdJCMX8w>
    <xme:pj_XaCvjK1vRbgSTuyZRVPfHN-zEK03Gh_j9jk3IgryqcHgdtNgsQwZcw_OQApjMH
    _fRrMeWOHl0Emt6aGKRoUKMDqjN0bOmzqeTZCNtr4UxRRrFttqfIw>
X-ME-Received: <xmr:pj_XaEkYgipK0ec3ZTw6kKpdds5W7t0eGUx9dED4wZvr-U7j66Gh8YhjIdrE7lvWyGk54mZ7eCQEHqxYIZJtCDZHWXDZtxunQehV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pj_XaMxGfrASypl7wevgfKrtFcErDYWAojAKUMxbW3HU5qRc52fxGA>
    <xmx:pj_XaOO0qBsSpe5tLp89PQcRQ81SYUzDzVGiM-7eQnhrmfZ8rEyB7A>
    <xmx:pj_XaAo4DuwqkPif6wEXXb3zd8fA1OvsVaIVfcB6E7e599ToeQq6aw>
    <xmx:pj_XaPEyYuYBy8p4WL3p2S0zY7UhZWm2-giR0-dhRHp97YX6MhsJVQ>
    <xmx:pj_XaOxHvJoCcSsNgQzCg_5uazE1pQ2GL4rA0bdEl4mPeaH1Sw2gLiVd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 21:36:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 4/4] doc: commit-graph.adoc: fix up some formatting
In-Reply-To: <3323ebff-f6ac-4065-8507-efd5a9e4a16d@ramsayjones.plus.com>
	(Ramsay Jones's message of "Sat, 27 Sep 2025 00:30:31 +0100")
References: <875fb7a0-6dd9-412b-a34a-21758c339871@ramsayjones.plus.com>
	<xmqqfrc9citl.fsf@gitster.g>
	<c8e40336-0a16-4da9-b251-d166f80ffeb3@ramsayjones.plus.com>
	<xmqqwm5kap0r.fsf@gitster.g>
	<3323ebff-f6ac-4065-8507-efd5a9e4a16d@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 18:36:36 -0700
Message-ID: <xmqqa52gad7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> That is, which one of these do AsciiDoc and Asciidoctor want?
>> 
>>     Deleting graph-\{hash\} files
>>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This is what I did and, with asciidoc anyway, looked fine.
>
>>     Deleting graph-\{hash\} files
>>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> I just tried this, and it was fine also! :)
>
> Hmm, let me just try asciidoctor ...
>
> Well, with asciidoctor it requires the underlining to be exactly
> the same size as the text (ie the second example above), otherwise
> it mangles the heading (well it doesn't seem to recognize it as a
> heading at all. It looks like:
>
> Deleting graph-{hash} files ~~~~~~~~~
>
> So, not the first time asciidoc and asciidoctor differ in the rendered
> output. (yes, the number of ~ chars is not the same as the input).

Yeah, so the latter one (i.e. count escapes and mark-up letters when
computing how long your underline need to be) is required to please
both.  I knew AsciiDoc allowed a bit of slop and that is how your
experiment (the first one above) was fine.  I didn't know how large
a slop AsciiDoc allowed, but it seems at least we can be missing two
and the tool is still happy.

> So, I need to change the diff to extend the underlining on that
> heading, so both asciidoc and asciidoctor both render it correctly.

So it seems.

Thanks.
