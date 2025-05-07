Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2D224898
	for <git@vger.kernel.org>; Wed,  7 May 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604828; cv=none; b=c531AxiqfowPJCMsN8DneB/xM7hk5/Oe/kZViHjmCo0mj32iHIGwSVmTEEWbfwexqzoMcswwmN0iO2hWOC3mKqg7waDHCgk0lGLDPzqTKUJwGTRmAQYXaUmkIwUh5GlCZX7Erhh6aZnCWguKYCxhgNz2OeUWpfKoQdF2P18ole0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604828; c=relaxed/simple;
	bh=GpwPgLmb8tSw6Y74a7EVfNw92hvtE/1xHoYWDJ8QvKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BixgxWaj/Sb5F3XhLE5qO05cp2jdc4UydUZMhowtNJ9nV9zFVTYtHEvYyVs4UMi1W8XamQrcdz9ce6cT3+7jkgfugb2p5jxNVh/ffOS88PpFiR4O11hM/4u3dPF3mqLdt39mVn8FYdDZZs347/Ry4NlNZ8j8rHmBblXxm/4Pjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j5h3UkbR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjjYg7rl; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j5h3UkbR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjjYg7rl"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F457254013E;
	Wed,  7 May 2025 04:00:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 04:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746604824;
	 x=1746691224; bh=qO1XJOxZkj7RTpF5BkXI/qFyFdyIz2abGMlT02XenQ4=; b=
	j5h3UkbRwPjM+gTs4bmY1NW3BBVrLTQwM8aQ4kvq2y3tyuqoniM5ajoJwx6JbL2M
	NQmi9r8J4sJyL3tH+/R48w77zfNS/PFYgblLOxbrqGLjJN40lfhKewTl0s1hMHPy
	JxmhqOcKE4M2hTkPxt3F61u5vWrqZUo7HLcn2LoQFLkMOywIK04Fgr2njYNwW7vO
	ykz5SNDE5X7WrXfYtKP9fUhILTI7W5ldgJpdGLXfSYhEkkpT0NWIWKi6u2/z2a+S
	kaoPt3gaXKAROMhx02yh4xHxHZPFecI4PCq/baeFcBbZ5uP5XtN1TdiJ3wBLxggJ
	flvCzTOs4WCBFkIV9WIaxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746604824; x=
	1746691224; bh=qO1XJOxZkj7RTpF5BkXI/qFyFdyIz2abGMlT02XenQ4=; b=B
	jjYg7rlfoLgE6qZ3GEe/S+fN9FzUnuyo0bOwmLYXNXnr5sYJcOWY8oLDjlcJpKL5
	bxmuj4iMS87WO0TAEOPZPotUg0D6KQUBUlyNGCOKlXsiMYbOXDSMkZnx5pxD8NaG
	feFneuV+QvgnzUN6lXouevJUmuXM9ZQfvoyxKiYVAu29q6/hQ3enkYRnXz7fLkS/
	HcX/X5+cGH3WeEp7YeaY03z5SP0QK2J2A/GSiZ57mRlOdHmZwNYnA9El7PjZzIF3
	2GF7fhfZmxCONa1KGFkAm7z9LlyZ8VR0kE1LBs+4KfavLeL5nB5okJ1eJvgw3rWx
	BON+/LDMP83fVwWpyepxw==
X-ME-Sender: <xms:GBMbaID34QNiJHwcYoNnGasdAJ8U2ceRCuSJuNsQBGjzdRUUmy2Z1w>
    <xme:GBMbaKh9iR2yBTRXc5joxx1sgVyrKSUMNVgPHFKG4CrZ8FQkOLoizmm69G2pkOnTQ
    F3c1GTXtirsksCZiw>
X-ME-Received: <xmr:GBMbaLnIr5jdtx2HiUfc0sHpI5nsJbVPS1td00N7riK33RP_M-cJ4MjRE0vlYWAeenX8twTxTjUkz7EX8na9kiTAYuHzl7END8mMP2pydglu0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeifedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:GBMbaOwYnq4NuxVKXl-5lBMQY8X0fByuU_DTL2dBivO1CBJb-fbmiA>
    <xmx:GBMbaNRoiEHp97NB6Zheq9RMMdDVzBDHGxecy7MCYrzPMFmvxyaLEg>
    <xmx:GBMbaJa2mXFbOgRzfn29CpgEbpAp0mO0IFFmeAipLPHyFGB8A5rBbg>
    <xmx:GBMbaGQTY1H47LdfN7dyt8Dqhs50IRNWOCX-2pBv09wNVdKjs4Hs_A>
    <xmx:GBMbaHW57hugZmhWXdVbV6f1_YRd6H5EXJRJOpfvy6D5TO0Ui8zUojkK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 04:00:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97598b91 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 08:00:19 +0000 (UTC)
Date: Wed, 7 May 2025 10:00:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2025, #02; Mon, 5)
Message-ID: <aBsTFdAX4pqJU6Nn@pks.im>
References: <xmqqcycmlelr.fsf@gitster.g>
 <CAP8UFD3=SJp29+QaUZvqWhjx_53P9tOE05j9TgP-sEvNRZW-oA@mail.gmail.com>
 <CAPig+cTnxJ+ff2jygfsuigQbSa9QMdA1dWN+Wp4xXJQRXOvwOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTnxJ+ff2jygfsuigQbSa9QMdA1dWN+Wp4xXJQRXOvwOA@mail.gmail.com>

On Tue, May 06, 2025 at 01:50:09PM -0400, Eric Sunshine wrote:
> On Tue, May 6, 2025 at 4:35 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Tue, May 6, 2025 at 9:04 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > * ps/maintenance-missing-tasks (2025-05-05) 7 commits
> > >  - builtin/maintenance: introduce "rerere-gc" task
> > >  - builtin/gc: move rerere garbage collection into separate function
> > >  - builtin/maintenance: introduce "worktree-prune" task
> > >  - worktree: expose function to retrieve worktree names
> > >  - builtin/gc: move pruning of worktrees into a separate function
> > >  - builtin/gc: remove global variables where it trivial to do
> > >  - builtin/gc: fix indentation of `cmd_gc()` parameters
> > >
> > >  Make repository clean-up tasks "gc" can do available to "git
> > >  maintenance" front-end.
> > >
> > >  Will merge to 'next'.
> > >  source: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
> >
> > I am reviewing this series and it seems to me that it's possibly
> > missing a fix for a leak that Eric Sunshine had found in a previous
> > review round.
> 
> In addition to the leak[1], I also have reservations[2] about the
> "worktree: expose function to retrieve worktree names" patch.

I've addressed both of these now in v5 of this patch series. Thanks!

Patrick
