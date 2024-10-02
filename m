Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C319D07D
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866713; cv=none; b=SKVTE2vI+9GLKomjOCs08vkCyS4z0XqINF50c/nUZMzcohqReNSOW29BVpv2GKxddbUyNwCRidUyX7GIpCVxDogmu2t+5BkGD7VSheMJtGagA9DmN2L3dAgI4YLKqH6rs0Z96qUd6RauyNoiAakPRUNu4BCkJ4hZhDvjd86xt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866713; c=relaxed/simple;
	bh=xm0WKV5dEJ8ssgEeHkcS9Ks4NR71LLsvbW/sR1EMau8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTQDQk0ZMLuR7kv5IEJ7+NUriaukCrQIvyt0Mz49K63m8OCTz+MVv18sDrR+q9FJn/sYMQTg9ovB/v8cGqZJDluxuO4h33gfbFnMUT3ZXpfFJStMzYPGG5pIMC23uQLZg7431CvZmB4LmwOs09nxUvKKmT20Rvnb6E+igU6Mpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kTt4rlUV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hpzAnv6E; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kTt4rlUV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hpzAnv6E"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4458E13802BC;
	Wed,  2 Oct 2024 06:58:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Oct 2024 06:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866711; x=1727953111; bh=0IRLjQWpKT
	eUeciu1ieursrWe+KI45z47kUu9PotWjE=; b=kTt4rlUVtk+NjIqG5qahCGG7n9
	00aAFPRbgk1A8Wl1WKUYyn1rTqFTUEUGTqeuE9evJaZZz1DD1+PB85dA2nJMRwYS
	7WOF/ZyHb+nrah58oDxJUEpantRgzFt+3jaZd3LYofFrJrsOqd6kwtOnpEMS0sPc
	CGGa1hlsGm2iEQAomgs50TwURDhDS4syukZ7o1gjXJU+4+86wmBt0PipFzZgSU0T
	qFO06+N7jopunMazQHvqpb77wYVGdID0BPP9b3tHmFwBMbbmaxLtPSSOJo9gStCa
	BgPGrnu3hiQAMObNHEWAi480PCkamum+slfWmGp45832enJx8Y6YXUcDS1MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866711; x=1727953111; bh=0IRLjQWpKTeUeciu1ieursrWe+KI
	45z47kUu9PotWjE=; b=hpzAnv6ETU10YooEBx62HVo1s6p/Nt8XYZgOGx9dnJnr
	gdqPp5XHy4bZ3bpII6f/Is5lLkisPRHd00aXb0CL+YTZkj+OzVMPHnRDTooh18K7
	0xKsEoDjIvBjeo4fYj68Y4o3PScUgwT4LkXyKwjafU5TAXq9x1obS/KM9ojlZ8dA
	d50a3jxCE5ruIAO8IWYLiKao28khJ/+BGFEfn5zXErLqmSXQeeN78b89PhpxENP5
	1znV2GS2t0bzltk437zMQFb2nmuy5HTuP3zJocEvqdrvuzKaCgc90RgdUY2NM9cE
	yJFvkHYpEjRHxts0qwAPoKk9+J+hTvfItYWyck0bAw==
X-ME-Sender: <xms:Vif9ZkQsLQJw12wYKqf1tApc6JYYi4gwItrVeys3oPNBmmEYg92VzA>
    <xme:Vif9ZhwNp5FNAyCU43NQS-udBeIslN4_d8UHQPn3o_2rO0mjCS0F4tG0O2aEkQ5nI
    GfTV0FewAgflgOJ7A>
X-ME-Received: <xmr:Vif9Zh0VGG-ipYyTd25S9JVKdFK3ONPh6qn6_U5sHEaEbxo98kSK793q48bcNcCcEfyyEOtp7p6WSZIGhKN-f09IWW7BgAJkvH1PwiHLwD9ZUjyH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    grmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:Vif9ZoB32NEvfM96YMJamhJf2i50CRuoopcrT6wO3NopwdSB7uRNxg>
    <xmx:Vif9ZtilyzpaeKAJsdxowGQPtWxy60HyZqC0_jetjVbqP6YCn46SFQ>
    <xmx:Vif9ZkpJvLNc_co5CxFIx2ac4b1N661mK5oHQLWjBCaa8EvQP3YCxg>
    <xmx:Vif9ZghC2d9MO-ATuqd0R3Bt7WqCMsLTricu24oZkzrgUWiiftIEXQ>
    <xmx:Vyf9ZlgWnqzcsX2cHxiw4n_vloNs1ieZ-wUOwCrw2wq2EU3Fa7FEwMwe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:58:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85adfd0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:57:39 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:58:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Josh Steadmon <steadmon@google.com>,
	git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>
Subject: Re: [PATCH v4 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <Zv0nTA2fAzy6FTY7@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1727155858.git.ps@pks.im>
 <9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
 <20240927040752.GA567671@coredump.intra.peff.net>
 <c4lz3begoplgde5iimvk4k7cufiyryntccqo46u3fy5qvqauv3@tta5wfg2ik5t>
 <Zvt6LxWm8gtJGw9S@pks.im>
 <20241001225425.GB2317071@coredump.intra.peff.net>
 <xmqqttdvqud9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttdvqud9.fsf@gitster.g>

On Tue, Oct 01, 2024 at 04:24:50PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Oct 01, 2024 at 06:27:33AM +0200, Patrick Steinhardt wrote:
> >
> >> If this is causing problems for folks I'd say we can do the below change
> >> for now. It's of course only a stop-gap solution until I find the time
> >> to debug this, which should be later this week or early next week.
> >> 
> >> Patrick
> >> 
> >> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> >> index 2d951c8ceb..ad7bb39b79 100755
> >> --- a/t/t0610-reftable-basics.sh
> >> +++ b/t/t0610-reftable-basics.sh
> >> @@ -450,7 +450,7 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
> >>  	)
> >>  '
> >>  
> >> -test_expect_success 'ref transaction: many concurrent writers' '
> >> +test_expect_success !WINDOWS 'ref transaction: many concurrent writers' '
> >>  	test_when_finished "rm -rf repo" &&
> >>  	git init repo &&
> >>  	(
> >
> > IMHO we can live with a flaky test for a little while. It's not like
> > it's the only one. ;) And hopefully your digging turns up a real
> > solution.
> >
> > It also sounds from subsequent discussion that Josh's issue was on
> > Linux, so it wouldn't help there.
> 
> That's true.  WINDOWS prereq would not help there, even though it
> would hide the breakage from CI.

Okay, fair enough, thanks. I should finally get to this issue either on
Friday or early next week.

Patrick
