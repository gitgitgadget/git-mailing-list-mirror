Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4096364924
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775684604; cv=none; b=aJNaGlPKmR1QumXXeaImULvXrtZAmhuV35puO8Kr2LU99O8gViR3gUWk/0TE5JlPkJvUAvjXZTLNnfxPkXzuOR6EB1WiI/kvjXSqVErTVXivb4IflvygEbLe74FD2ebed+HlKNG3GCeEAK+WsfZVzjOCG0Sp1yqW3ZQXTs8llk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775684604; c=relaxed/simple;
	bh=mWzptvddt7aI2e7im3K0fnDlF/u2va3g+Cm2wtI73zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nVcCgFhoZsDvKlS6j/uCPpZ7sxZir4YNe0MTJjNG4YWNc8z3TOPFiKFJSXGVS4lVsRfWF5U9lqr7DEbLy6zTAg2jV9tvn65Syyn7przM5f2LLLA418v/BY4mONo0dw9siia2plnN6TaN3rd69uc3h49qVruWIdft2f/DOWoV8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iaLWuxhh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJqO9kWN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iaLWuxhh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJqO9kWN"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D2A4EC0180;
	Wed,  8 Apr 2026 17:43:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 08 Apr 2026 17:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775684602; x=1775771002; bh=f85GTRa1u9
	GI2cd+h57TXniHGZt4XwHNsgVEaKE73ac=; b=iaLWuxhhRAssCVp1n0GhvcnWmd
	FXSsFoAxkvVFC54IMpztRBZGRzGQIhzF8ScZDwaKrpSkxjEcsPWzcA4TzD1mS9XY
	T/f06NBjTKFTGq1DwENn5BKdLBa+HBKR4lBV8953Ow9ZrqqlOyUr8r2P5eKkzGqC
	1KAmXobOVOFg91a2jQRr5OM9RKjQ6znBwNnvsjDrcuc/32cHKxBwpFhH3P52vJ/A
	IFPG/kuHltvHQxdXnGhdAkKZ/yjIAqx6O30JO4APkgw+UMwcBbWt/Ls5GNSJKPhp
	SU5h9spHoAVOjGlw2MSFxoj024px9wjL6ACTwZKs1NDKpKQBy0+DlZUgOuXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775684602; x=1775771002; bh=f85GTRa1u9GI2cd+h57TXniHGZt4XwHNsgV
	EaKE73ac=; b=JJqO9kWNd9wfdkusc3iolprU5Dgnzs+fCPg1Hs2q4cxjgFD1Aks
	1TwSPlmpF8l5HOrDTHiTyMvKWzXLeHGlCoRx37HLfBGd5EoXELKS329By8E6klB+
	oA9k1Qiy2R8v/1YZebMjd4h7Cg9LqDi8LulN37uHlO82bqkbUFe+l0fx1rO9pHiS
	GGBoP5IDcHVG7z56NrWs+jBIHQ/Wmi9zjxkAtMyEw9uLxFD+5SqdLrjKe5wy0dgX
	F8Tfgh79N6FL2JqL6ZFmAVjCBSsFULJKTV7nfNLr/XTChR6Y5DI2+6BhLf2xkq9u
	knLJadermzhQ3VboJmS43EBpVkPgT46dVYw==
X-ME-Sender: <xms:-cvWactbZOqy8w9gP4StOS9J_0A5XzIAmHN06MOQhjLOxJOwvk2uvA>
    <xme:-cvWaQVehLsm34llfZEl3CR9uPkbkUzL-bfs6NJqLQMNnGVvcJyahPfd6VshUTMqP
    gMyu_t84vxzLfc-TzBrbzT9gk81OR5HbkFlkJWTxwfGL2GwvfCQJw>
X-ME-Received: <xmr:-cvWaQEZg2nicRK_oXkgxiiD3YQszdFVt52S-uFiF1YrVNYqg2da751iCyjhPOqpBAjaYkpomyk0uo1tUZAmhDqNOukP9gKAhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-cvWaa211SXxw0vudEFgg9fJhBXihlZXzZQSzyA7hRfRI-ecYUfDLA>
    <xmx:-cvWaaOFydPzdGjbu-c7Ubyj7LcDJvebkS_MKVphPA0O6ejZdCwAmw>
    <xmx:-cvWaR6yHssQudCLOLJccziaYbEkxFeH118lMts9p-mRNrGqvVd1Fg>
    <xmx:-cvWac0S-p2CVB4YP8wU8EziOZsGpYQMnq8mSqAEgAmeu5CC9Th7hA>
    <xmx:-svWadFlbqDNJrzwJKPJf01rT2rl-6dLUKNh4bQwxLTZKHVXy2YTUh71>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 17:43:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Jeff King'" <peff@peff.net>,  <git@vger.kernel.org>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
In-Reply-To: <016b01dcc79e$87472860$95d57920$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 8 Apr 2026 17:27:34 -0400")
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
	<20260408041716.GA1324339@coredump.intra.peff.net>
	<011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
	<013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
	<20260408173949.GB2850002@coredump.intra.peff.net>
	<xmqq4illz5g9.fsf@gitster.g>
	<014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
	<xmqqqzopxkxa.fsf@gitster.g>
	<016b01dcc79e$87472860$95d57920$@nexbridge.com>
Date: Wed, 08 Apr 2026 14:43:20 -0700
Message-ID: <xmqqcy09xh53.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On April 8, 2026 4:22 PM, Junio C Hamano wrote:
>><rsbecker@nexbridge.com> writes:
>>
>>> On my box, I have the following note:
>>>
>>> Specifying  the sum of the iov_len values in the iov array greater
>>> than the OSS I/O size limit for that open causes the  writev()
>>> function  to return  -1  and  set errno to [EINVAL].
>>
>>That is unexpected.
>>
>>writev() may fail if the sum of iov_len would not fit within ssize_t with
> EINVAL, but
>>unless your "the OSS I/O size limit" is the same as SSIZE_MAX, what you
> have above
>>is not quite the same.
>>
>>Does your build work with NO_WRITEV=Nope?  I think I saw it asked a few
> times
>>but I do not recall seeing it answered.  At least we know
>>xwrite() seems to work well enough on your system, which is what the
>>writev() emulation is written in terms of, so I suspect it would.
>
> Yes, NO_WRITEV=Nope does compile and execute. I am including it
> in our CI/CD job for now. Can we plan on a fix for this?

What I have heard so far indicate that the code that uses writev()
would need to loop over to prepare for short writes, but your
writev() that fails for "the OSS I/O size limit" (whatever it is)
does not sound like something we want to change the callers to chomp
the writev() calls into smaller chunks for.  Such a platform is far
better off using the compat/writev for the code path we recently
started using writev() in.

To be quite honest, I am not sure if it is even worth using writev()
if we need a loop that protects against shrot writes, so unless I am
grossly mistaken (e.g., perhaps there is some guarantee that there
won't be any short writes for writev() that sends data smaller than
64k that I missed in the docs), the best course of action might be
to revert the change to use writev() and use the two write(2)s as
before, *if* we actually observe that the current code is broken by
short writes.

