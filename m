Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443351DED53
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087160; cv=none; b=V4wTp2qYWWAY5JOC2MvrzKe/lTS7eFZa9IELqK9ePgfsvktz9gYPZzVFeSFxwUTa0J/h3P7ClMdt/POFZdj4JFRhdlXa2zBlaOGz5BDLt1FmjapjvPm4Le7UpUEx02ihNozTD10EpItU4M6ILI6nQUEbHsHsAnftYVX+8XlWzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087160; c=relaxed/simple;
	bh=I1YiJuAKNTH0WDZmZEdo9savKA0+mfav5bkpxeib0Y8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L1P4+WXHR7AkZQo+Rcda0JCP7xIIzGDS6kYALs/nimzdaft98euY95tVC00DYEW0gnaj2abEYxJAFQ2eJ4uNKuK6mRkuv9ueGmVEsNBIPYDHx9eEq4C1nHGFfLjsqg7ndP3kS31FYcfWR1c4VdN0sEZjFlZm3+1dm2pVrI1BQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B6R/QpcB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IqSwiPHh; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B6R/QpcB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqSwiPHh"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 349401140149;
	Tue, 28 Jan 2025 12:59:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jan 2025 12:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738087156; x=1738173556; bh=toIgEcv4P3
	FI5TGJnIG4NZDOqItUSSo4CtI8w59qMnI=; b=B6R/QpcBVQnPN8H4R8ARENbb3b
	WSdjo1SYyNsLaE1AIlBWiaDl88e+pzaCdT1wLaHWJk52ajq7hSnqu4jFaov6UZIa
	fUo1E4GuFDG/6x4eRR1R0okUBcCj8R9Tu+LDtwQyBd4sR0w/aguyajHjTR4H2Moa
	mYkS/tWRIx0b45JKr74JkOSpwKC4xGEWhT+u15Wv2hTDki9uMsxx0vlM2l4MEMRX
	rtZ+CJ9sIeG4yRHbEFTk+W/qWPOd+9B3oOz+d7f4oDsVUOcAtTOdWFCEZ5SKpUfv
	FSyvbRsPzwQe2HOKd5ZSgHmejXlGPeFhkDE2xLvhV6RV1UfRcBO+MYzzzY9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738087156; x=1738173556; bh=toIgEcv4P3FI5TGJnIG4NZDOqItUSSo4CtI
	8w59qMnI=; b=IqSwiPHhqllpij6vSTzJX1CBOdYuDzrqD+touwk4sDPzYTdkwfM
	2sMa/XMBX87DSWshvzNUrPSIkidF8SzFBogxyYFH4hZe8XQsxBAYfRVx0pC2IS2i
	OCtgJBvq3NZMj4+wU8E26pATpEL+wP5EkvDoOdh0y24fU+hyIsozcLOnFZC4ku90
	nmIR4emEps94LbE29tyBgd3wPxUHSgXDG0TtOuU2ebx0JoTTI9wOyQ9TMGqJamp2
	0oMzTLAyrvSTz+xtXSysaU5wuLh8Q2yWzSTbjhp9apZkhdv0cpjvyc2hoZnUPRKr
	XpSpgZCnIgOMIVbhGwMppCH4PDuvp28megw==
X-ME-Sender: <xms:8xqZZ-MRkx6TQmOka6a6Bk--8nuCSi28BeL5O9L-szPRAEG4b_tgqw>
    <xme:8xqZZ8-r6sWXdMWQbEZpcQ2Tx6ClRBak2W1ViOwDl2eky0xSk0ob3cGIR-kwXcq5a
    cihocrxS0-1UlxrAQ>
X-ME-Received: <xmr:8xqZZ1R5e_dh3DN7ZzLc12Z2vx0zPdOvLHaLvPaLVmgzhiaDt6JWHTc0JmvS8T7f_kIeUYRFErznk6IE0wH7LppnqePOawq2Z5kn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:8xqZZ-uM50RcX44b8AIGGEpTchLiNsPo8ujNkLCvwbzKzrul8zls6w>
    <xmx:8xqZZ2fmGU5L0ToU6pIvF5XPOA6GOtCFZ2YxwZ6AN0B2LKzUx6WYyg>
    <xmx:8xqZZy1A4r-Be4CTmk9K6HeB4GAd4QSewDRxNE0vIgdF_NUbwr2Dxg>
    <xmx:8xqZZ69SF5uVcVcLHnKUL2eCoLGU1ju7fF8R8czxW305hIc2K9cgAA>
    <xmx:9BqZZ17omHNZZXDGcsnN_xYwryGin9WboeDzP90SWm8yBTYuET2EQV71>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 12:59:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #07; Fri, 24)
In-Reply-To: <20250128164606.GA1688180@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 28 Jan 2025 11:46:06 -0500")
References: <xmqqwmekvubv.fsf@gitster.g>
	<20250128164606.GA1688180@coredump.intra.peff.net>
Date: Tue, 28 Jan 2025 09:59:14 -0800
Message-ID: <xmqq8qquom4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I noticed CI complaining about a missing include file:
>
>   2025-01-28T15:51:45.3979314Z asciidoc: WARNING: difftool.adoc: line 16: include file not found: /home/runner/work/git/git/Documentation/mergetools-diff.txt
>
> The problem is that the line was introduced by another concurrent
> branch, aj/difftool-config-doc-fix. So we can't fix it independently on
> either branch; the line does not exist yet in brian's adoc branch, and
> the file is still ".txt" in Adam's doc-fix branch.
>
> It has to be fixed in an evil merge of the two (or brian's rebased on
> Adam's, which has since graduated to master).

Thanks; I had this one on my radar and I thought there was a
merge-fix I made somewhere, but it is likely to have been lost
during shuffling the order of merges.  Will take a look again.

Thanks.
