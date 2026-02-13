Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194D2BDC04
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002996; cv=none; b=G+befEA26dRyuXcoOiGoyP8mP+v8qbo6LsosmN5crlMZbBEHWhluqnk6y7ehukI1AEYs6MBh/7PjiJ+fFwK0H3QRV2MR1T/ZySYghktgP+IeJhXOm8h6amNcGScFcqYDPT4SpPWbLzeuOyeoB2G4aqDVtl5OmsnvubpTLSM/K5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002996; c=relaxed/simple;
	bh=fRkXCN58psJ79/fnSTyeAc5rdUY34Xot4zhH6u+neUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q0vrTIoJYWP7i19y6qRj1W0/tWhUTIJrVxN5bRkz8MYbJvfh9X9qNdgtX/kt6g7EzwbyUplQspeNb5paCjvCcx6kyYNrH/FDskgpSC3wqeBe9c3utixH4bC7z2C6NDcHytx5wTgiEv44se6Yq4FWDf4kPEm0rCe4FDuOnkv8KBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c8cDBEJq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ofSyQPPU; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c8cDBEJq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ofSyQPPU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 21C817A018E;
	Fri, 13 Feb 2026 12:16:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 13 Feb 2026 12:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771002993; x=1771089393; bh=gWfh6PgnH7
	2csxNGkNAKJnOsAiPmKDdY++7ee4vznXM=; b=c8cDBEJqBzX4pA/BuG7Iz0IbWc
	nU0qUDxQJsZ5GSnLR8Du+mqlSII0hqyCH2jQM/3IJ9XH5JKxIaCYMzoHs7hxOJ6D
	vvvUdD3m4TZENtl+9J6U/s9ItLdlUziPIyCmoqtMibChGXuz5Dju6gxe52qCTAI5
	zAqoWbNIcAbBTegW+oxlThI/53srWvjTsNMv6NBUGdtfSsuOBoPvM2g/uKDbbLTe
	kyaSPdnePU8C1hURK9BlTzvj8gHvPy4pDEGiVIhXMnmXUlYad9TaJAKtGydC2OaO
	bpDaaxOk40IJvmNPt1C/nSe8eFJ+8tkJrqZNgWJ0UwieZJYxS1q9jXA6dYTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771002993; x=1771089393; bh=gWfh6PgnH72csxNGkNAKJnOsAiPmKDdY++7
	ee4vznXM=; b=ofSyQPPUnS1zAa1nTHJZqT9OKuwtkEapIMukHLJdSl7THUzkMbE
	oGn3qekQa6TTn7llKo0AuolkFdQd3xHRcfq5mkQfaj2+QaOO/cLtrGxxckmQkyip
	S5DrtyMlNfaWz4exsJ1IhLVkvO/1ScZVBzpzLNFOGCZ46PcbTLqXBD1wWhtfeXke
	+DgekTmE/V0GKH4lq7lsg+lDGeGq0FXeS7v7Qq4VKWZc4oF3E7siFD7BlcBiyHGw
	LdHYNk7peLIa121SWWQmaShI6d5TcZf2KIhVN3obAxJtFIiqoaMYYbLfa8R4WmF+
	G/fX4cib2oJDK0BFgseKtuHkC1E8CldBDDA==
X-ME-Sender: <xms:cVyPaZzGwrOz7ygGJ1irecmh6hAQCVy3nJkvl9wR61eAH0Uj37U4cQ>
    <xme:cVyPaQuwAJphXFEkUZrN4GqT1Z5sg_BhtaKQDGYlfGXlOCe03DxzZWkaTicX0ojqA
    fE4ZBb3ReqnbEwu_NzUCwdS_mqwCOVJy3PB6mnjmYncDFld3yryQw>
X-ME-Received: <xmr:cVyPaQvfFjmoNudntGH38hn31BtFIyvrHgfgFfjA-Kaj-A_WTjLyIANUsLeNpaHUNFQd6HkgUFBaNIfLvXGbsrEcK3CtrMvaLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghnhigr
    nhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:cVyPaVNdD-y4DTARF24HlbTzNzZJVtcA-gYmNnmPYWbIVYgz0pHsZA>
    <xmx:cVyPae3JSL2roQI5WRjC31i1BazcDrxFUJ40JsGNg_8cNBx82BhUrw>
    <xmx:cVyPaRNpdrR8RFOEkbsLfF15xDMpkY0mdDFAHVHdPukuq1JzmRQ64Q>
    <xmx:cVyPae3YKP44sMIKdnOsjRDXbZt0rDpqPNLsRwByQaO6db6y-inauQ>
    <xmx:cVyPaQem_Ytg6WTU99MEdzJK1Y-t7V0sNIxZinS7CAKk7hOJJR7LogF0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 12:16:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2 1/1] diffcore-break: prevent dangling
 pointer
In-Reply-To: <CAG1j3zH0C0DA+V35A1e73wi41gmk9Xry6gmtZM3w3LT09etntQ@mail.gmail.com>
	(Han Young's message of "Fri, 13 Feb 2026 15:14:03 +0800")
References: <20260211041128.48412-1-hanyang.tony@bytedance.com>
	<20260212072002.2347-1-hanyang.tony@bytedance.com>
	<20260212072002.2347-2-hanyang.tony@bytedance.com>
	<xmqqseb5okl5.fsf@gitster.g>
	<CAG1j3zH0C0DA+V35A1e73wi41gmk9Xry6gmtZM3w3LT09etntQ@mail.gmail.com>
Date: Fri, 13 Feb 2026 09:16:32 -0800
Message-ID: <xmqqwm0gmumn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

>> Your "do not leave q->queue[] dangling, as other people may still
>> look at them" fix certainly is a good hygiene, but I have to wonder
>> why we are doing break detection in this case in the first place.
>> For the internal "Let's figure out which path have changed, so that
>> we re-read only those changed paths" invocation of diff machinery,
>> we should not be doing so.  A break detection is to see if the
>> change in the contents of a single path is a total rewrite, and
>> regardless of the answer, the fact that the path was modified does
>> not change, update_index_from_diff() would work on the path anyway.
>> I also suspect that, if we are doing rename detection in this call
>> to do_diff_cache(), it is a totally wasted effort.  We may want to
>> take a deeper look at it, possibly outside the theme of this more
>> focused fix.
>
> I'm not familiar with reset and diff machinery; I encountered this bug
> during a real world mixed reset. The segmentfault calling stack is
> cmd_reset -> read_from_tree -> diffcore_std -> diffcore_break
> It looks like rename detection is indeed pointless.
>
>> By the way, I find it highly curious that with the following patch
>> to revert the fix with a bit of extra output sprinkled to your
>> tests, the problem does not reproduce reliably, which may indicate
>> that your test may be flaky (i.e., timing dependent).  Am I doing
>> something bogus in the patch?
>
> It seems the problem does not reproduce reliably with or without your
> patch. I suspect that could be due to the freed memory on some
> occasions isn't reused by system, thus the access later on doesn't
> trigger a segment fault. On my macOS system, the test passes around
> 5% of the time. However, if I set q->queue[i] to a bogus memory
> location like 0x1 causes a Git segment fault every time.
> Is there a better way to write tests for this kind of situation?

If it is flaky because it depends on the way the system allocator
happens to reuse or not reuse a piece of memory, as long as we do
not get hit by false positives, it would be OK to leave it as-is if
we do not find a good solution, because running tests under asan
would catch such problems, I think.

Thanks.
