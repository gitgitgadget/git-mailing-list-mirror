Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749E2F3E
	for <git@vger.kernel.org>; Fri, 23 May 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747994616; cv=none; b=pq6lKO9HpKvw7oyAUtgkbkrRwVVFzxG3wjjJZZUwC2hPVUngPu6LPA3TxZJ8DYtfhmH2bpbDlYAkViLFG7hPF14mwjwJJVdhdf0y110sWuktbksCQWBqt3KRzozYBfjfccVXsJH6W83+gv3i5MO1jO0trRx5S2UgNp8kU6riDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747994616; c=relaxed/simple;
	bh=dVYiA3e6rnW15XCXEND7Or+F10XVk9JSKMqSSyAoY1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgrsvJMZQ+u4UvYvE1ZOrUF0udfKTzWemS+RGldwErT7PXling7yazOr5wSsso5djJHv6RRpNoiUL4o4QQz4YoFNOIeyN3fhq2EbfM7hZp2ICuZxNkbPt9f2oE7Lcfv9G0nLAC5qdDJsc5LQ+8D9pXm+XG7dd25EdMzd/AQSlYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sR5vJEIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lkK7RhwB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sR5vJEIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lkK7RhwB"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C24782540120;
	Fri, 23 May 2025 06:03:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 May 2025 06:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747994612; x=1748081012; bh=zB6vOyUGdG
	/dowDRmFEJ5trCE56PaMga3mcstU9zF/w=; b=sR5vJEIFAdVF0JulkSsFZwFPQv
	E46McUiIHJWB4D8H3hZcX+fhYKlb2KkWtfvP5Q12AWlqJsFtx+4sPHp+RkO15pw6
	af+Osr6W1QFIEs5XeJ8oGeaqFsqneW9DQfUDya+QCE/APpkT1izz1vF/vFtys4V1
	LN7AWyI/YB+UovbI7ADw7kxsgypu/aokHK0yBnYcXlGBNLQ4MqlWeT2kb0gjUovA
	iuJtxeAYFRBDUSB4CkAYeMx+wevg5xBbZ7/C6sVcdWBf3K/Xd4tb948aN2Xhqd+f
	cOcvPVOwJ3Obgps8pEZkB6gciPJnZdQDHVXmYzxuKmk8IjZRqQACVqkZQSAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747994612; x=1748081012; bh=zB6vOyUGdG/dowDRmFEJ5trCE56PaMga3mc
	stU9zF/w=; b=lkK7RhwBtJOrB8BqPlDL1DlQJzm1JlG9CpxmOdP9+KTw1Rja0WQ
	sZ1ZN/YOVClrdftg5HZUFfjAMCEXYUFDmzpUMWJWwKnos8UT/30HSxGMywOTfniq
	fOdE9YP7dQBHjJKPheppT3r1PcM3mlZSfXYhS23Oq6mFImgQjHLNfFpy3Jax/zFb
	32XezIuSNK9qIuynvkDC67urCT4FEl2ilUjMcAqi7u1B/jELM4J8WIfFloaYzF1S
	1D+zy5nUwiI0WsW7hhJYlMzh8HKKEK62eHyqDS1DeGAKdNsxv74faQwSlfffREdP
	Wc4AHtoZ/wUGyyLiROhaiBEiRMMb/t99Z5g==
X-ME-Sender: <xms:9EcwaGDZRe9RbIg-bbYoVq-_6Dvzwf5uy5QZtv2QKYQsNups2HPA2w>
    <xme:9EcwaAjqf45pALEF14-c1iVlW0JxGZJl5NLp4LpNmHzPPI08mTtEAJQitIfzSL3Wq
    mCSUiR2AcWMh-tSPA>
X-ME-Received: <xmr:9EcwaJktej9whToQd-i118Oh_gL55Q6D-wnQFs2zLwqvQNz3goqjx0pUuC2v3S33v5Zwk6JvfZUPYSZLub1RU-MjGm5mMaUF9UC-NaLvkh99Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekheeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfgheetgfevlefhueeu
    veeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9EcwaExM7McF6gS5YdBYcVxxpKGHGcpzpoYW1wlkj901d2rSu6V8gA>
    <xmx:9EcwaLSIfOYSakB0CLVZqCQxN5mIAsSd17l3Zwv_oriqirTMBZhEvw>
    <xmx:9EcwaPaIrqSYC3sRsOZZEfcAGgtI_Btt-C355QetP88-VxYsbEjwkA>
    <xmx:9EcwaETmwvbxDmznbXBPs8wDlhpITU-Q-3oBbBSO41y2-FNVrywIpw>
    <xmx:9EcwaKAjA5Hi_2OR-_bpHXelhTObWZPP7N_1rPrRcTginDRclTny_wF9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 06:03:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ccaf2cf8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 23 May 2025 10:03:30 +0000 (UTC)
Date: Fri, 23 May 2025 12:03:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
Message-ID: <aDBH7G-oKKxAXWBp@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
 <aC2xp4Cdb0j6OX-G@pks.im>
 <xmqqcyc2aqy7.fsf@gitster.g>
 <xmqqfrgx8xkw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrgx8xkw.fsf@gitster.g>

On Wed, May 21, 2025 at 02:26:23PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >>> This new feature is only enabled with Meson 1.8 and newer, which
> >>> contains a bugfix that we have upstreamed [1] to make the TAP parser
> >>> work in `meson test --interactive` mode.
> >>> 
> >>> Despite the changes to Meson itself, this patch series also contains a
> >>> couple of fixes for our test suite that caused us to not generate proper
> >>> TAP output.
> >>> 
> >>> Thanks!
> >>> 
> >>> Patrick
> >>> 
> >>> [1]: https://github.com/mesonbuild/meson/pull/13980
> >>
> >> Junio, I noticed that this series isn't yet part of the "What's cooking"
> >> report. Is that intentional or an oversight?
> >
> > Neither.  I saw a lively discussion on the patches and was expecting
> > to see a finalized updated version, which I would apply.
> > 
> > The "Please hold off" message in the middle did not help X-<.

There wasn't any discussion that led to something actionable as far as
I'm concerned, which is why there wasn't a newer revision yet.

> So the four patches are now sitting somewhere in 'seen'.  Is it the
> one that causes this failure, I have to wonder?
> 
> 
> https://github.com/git/git/actions/runs/15169816296/job/42656836511#step:4:2113
> 
> It is curious that only osx-meson is affected.

Ah, interesting. Seems like macOS has since updated to a newer version
of Meson, so it now uses the TAP parser. And there are some tests that
only execute on macOS and that cause us to emit output to stdout/stderr,
which will thus break the TAP format.

I'll have a look and will send a newer version soonish.

Patrick
