Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168324E4A6
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376257; cv=none; b=MdwYp1o/qIrSFVCglQCuaqIcb5Gg4LD0Y3tS+2N6hqPvwugwUOC68CzOoRlyqknC0RllvbIkKJPH1IVVS7flqcgWPWdmJKzqGAg833jg+zB99GL/s3FDaaEI7naFAhuWZCUafVJfWHfTCZO9f1ez/2YyD7oPD/+Ltt2Vvljkxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376257; c=relaxed/simple;
	bh=/LWEBEBe6NtnlOYdDE/N50t6Uu2rse4yLM0l5JL/+kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em5u1WR2GESjhnyu7oKHZ0gwi8B/QGS7FDfdc710qlqySt5vbb4fQVA0pTbjuRmZWPkGVBbLUb28i/86l2+lZl0DpB2/zulm769VNejL7siFyaMV550bMF1pGkQLu/xYkdmHa0qvoAB+wyOz9c5pfexQsnUNhZLDHxe3wmkUNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FAPmboj2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g2anENNm; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FAPmboj2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g2anENNm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6176411400C6;
	Wed, 19 Mar 2025 05:24:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Mar 2025 05:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742376253; x=1742462653; bh=lcPE89yVSc
	oKKkVK6PRS8GaSkAtgAQ2RiEYCJx7Hnhs=; b=FAPmboj2b1g4e1tKQQoDa8GmhV
	ZD8FoxT+c/KndcO0U3N9WpatbxojKnYbpWYT7JyVcNf4okdDLP2kIBJZOYGgqbm0
	QAqf5JJdzq6aH3EO40zVdMhkqRV32y5YfT+Iut2qIJVW1P+xL+yGpyO9tudxsyRP
	X/MLcIgx70EWCgeiq3PZ25ssYWRvCBGkQSlPAYCqhsDy54zC2V3K5VWE/2RsysZb
	p1WZDvbbHdXa46/mK0rOamesiB0HFSXaItCs0+AUSlmC+BjOgWur2DraWy6TdYvG
	LOSZcyFKWrw5fCxNRNOkl0V3xx9I0Um/7FoHz9H2b/DYq+pgboj+jvAOwavQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742376253; x=1742462653; bh=lcPE89yVScoKKkVK6PRS8GaSkAtgAQ2RiEY
	CJx7Hnhs=; b=g2anENNmZeUsHNz2jOzb3InJ35fPtGGll4RK7Rm02X2KUQe71EM
	qIkMlnDJegqZdaXa2G7aWBdc1m3bXuBijksKgNY/ZcFaDUEYuGhriKl3SM/i5K0k
	dywBW+eXWu9KrojvJXfThcsOrZUvqoBxCSZjhlCVsPOiikHM4FekzeQA5OVXHMx1
	H93JIym6RwRp3Hn5CIRSj6X6k/zpQq7JmGCCliE9a2bnthP0gsiT0QBCemkZml2s
	7GzTI7pLbnYMDC0jRK+hXEe79yqbsPX6M/wqf4sJuavODSVlLEe5ozyGCVsqb9YK
	JHTjYN3GZTalT+aIxXQlrkDitzg01vViMhg==
X-ME-Sender: <xms:PY3aZ8kdkw0mS6yInisD9XO8VvthhQpyzebbnLLrZSajersNae5HJA>
    <xme:PY3aZ71gqP-PR0yqHU2vpY4VgPcwsXOBdWS_dwmzkFaa9DpCec4iPG7FpaXl2h_Y5
    W2V02JJqLTD0Af_tg>
X-ME-Received: <xmr:PY3aZ6pWNy1tzSZi028ZaXk9UF53fy4q63LxSM3Zj1s1s-cKWYg5W91ecH3kilTYteZLgykZ7UPshK6yU7jikUpYewL0s0TfNAgkdF-o-woxRffBeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:PY3aZ4kOCI6XNciyva4MtZ8c3ZSu415v1jrTc1M108C5GOiYadLCuQ>
    <xmx:PY3aZ60KDSc9JfEbzGb9lspCAwkIEdroqWDuy7wZ3TPUc4530dVRCg>
    <xmx:PY3aZ_uVh7Zh7xWoK2VBx09kWK3UG-PPH7YPaEpBtceTfvGydtb-uQ>
    <xmx:PY3aZ2Xve-gvRr3b5o4aTV1I_8P3I27vcocgbD7YUEvwtb2LIFAk0g>
    <xmx:PY3aZ9QlNJsqIySu_wxBlRB45cJguYvbO9ATBDVlBoDuXYQckjQ_oEbv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 05:24:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0709feb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 09:24:10 +0000 (UTC)
Date: Wed, 19 Mar 2025 10:24:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] install meson for Documentation job
Message-ID: <Z9qNNq0p10YJCZYo@pks.im>
References: <xmqqv7sbfra0.fsf@gitster.g>
 <20250314184130.GA578421@coredump.intra.peff.net>
 <xmqqy0x7cg9h.fsf@gitster.g>
 <xmqqmsdi49h8.fsf_-_@gitster.g>
 <CAOLa=ZRODjYfDXQ8m+hDosV7RBGDWeehzSvsR-+-HCmbS+tAcQ@mail.gmail.com>
 <xmqqiko613a0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqiko613a0.fsf@gitster.g>

On Tue, Mar 18, 2025 at 01:40:07PM -0700, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > Weird. From the looks of
> > https://github.com/git/git/actions/runs/13867157977/job/38808418127, it
> > seems like the '$distro' variable in 'ci/install-dependencies.sh' is not
> > being correctly initialized. We can see this in the logs of the CI:
> >
> >   CI setup via install-dependencies.sh
> >     + set -e
> >     + export TERM=dumb
> >     + export MAKEFLAGS=
> >     + test true = true
> >     + CI_TYPE=github-actions
> >     + CI_BRANCH=refs/heads/seen
> >     + CI_COMMIT=d5389e37e21d864f40f4167280db799ffe8983c2
> >     + echo Linux
> >     + tr A-Z a-z
> >     + CI_OS_NAME=linux
> >     + test macos != linux
> >     + CI_REPO_SLUG=git/git
> >     + CI_JOB_ID=13867157977
> >     + CC=gcc
> >     + DONT_SKIP_TAGS=t
> >     + cache_dir=/home/runner/none
> >     + GIT_TEST_OPTS=--github-workflow-markup
> >     + JOBS=10
> >     + echo
> >     + tr : -
> >     + distro=
> >     ...
> 
> Nice digging.

Thanks all for discovering and debugging this, I somehow missed this
thread and haven't been able to keep up with the mailing list for the
last couple days.

I see 4451a164e5a (install meson for Documentation job, 2025-03-14) has
been merged, but as far as I understand we also have to take Karthik's
patch to fix installing dependencies? In case I'm correct, do you plan
to send this as a proper patch, Karthik?

Patrick
