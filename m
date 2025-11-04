Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E31448D5
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762235656; cv=none; b=XHwnTu+ixQohiQX54QPvcE1EvWblfUuP/YdyaCp/bQDEfQPeeKt2DS1+4nX01AyCY9lXNX+NHo4VREOwacSUN3wTY2AQLqMsZQV+8/yZYHGmS1FE0Fk9mDDApME1GfpSekyjzuhpFFlNcERtabrD9fBKNKNWq4KioswHUc/um1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762235656; c=relaxed/simple;
	bh=BFj9dkmjDEuECLVz2JZdacnB2HUmKcq7DMrmlvutGgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=op/FWCvEHMYm+5bmjSBvKEW9ekBueFe4NyO+GrSBDkETMdkeCKcFIbFjCMrTIsAtBjxQuDiYqZkpiBBahbKfBk1cj4tvhE4RVl+fAeIzjUG6T27Cmc3V6TM5Uhf4/zxZEVvjbxpqLpioWf8Srh7XKkvln0tp/5BnqsZEJ5uzr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OsSVyE2S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vhdMxOat; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OsSVyE2S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vhdMxOat"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EE98E7A011F;
	Tue,  4 Nov 2025 00:54:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Nov 2025 00:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762235652; x=1762322052; bh=Z6mnVWoL4E
	2B7Zj7uMqETORMxzcEg7rBmsEVdGvf4mA=; b=OsSVyE2SYoZVvWhZc29rdQ0UEZ
	SIfvy6wrlSPJVMRT36sDsEqW5InFuOT/eKB/pr3SY2c4uFS7ACAdJXlF7BGbLe3D
	rcofvF2fenyAUKYTI9OsEvsdXue8eaTK9YcEoNafwNQ2zxkbGXUZCYGEtR1Z1Lu/
	isiDZyuzQm7kG7OFDyeDs6iOiitTML/psc/yZHUsohZfseENrShP2c7t1h8UHB7x
	Pv0seUmGJGE7YqUSF7WHetB0WibPjygoLhB0WslvQJOERH7MTrBWfvWtCEjf6+V5
	+NpNT2Gw0Qsumi77FuqpTfkCS98UAuxlfC72oWgIIgAQhN8+Zq7ZXwiaPjTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762235652; x=1762322052; bh=Z6mnVWoL4E2B7Zj7uMqETORMxzcEg7rBmsE
	VdGvf4mA=; b=vhdMxOatdYtWr4712oujiblS9oA7JcG8bhHFe/XpSCtCNYDP7r2
	a+0RXRhIHrT1IzLrJpW34k/iQOhUUU7ZpwIaMAR6G/aIC1nYwuMMo4OXIF4DylKW
	ceFB+hvoRZewLnyTMnQ2EBQulh8P0uyYa9hRYQ64Lljvlm/Fx1BcUt/8A6OcypHu
	OoUvvFiNxWbCPk4KX33QIz4rBoT8M+kSZm/HkwP8l/Pq4PtTxudZb0soNcDHIi3X
	mCPlwnB+XsxuO7lvGImXsdUjY6t9LQ86kKmenWkO5rFkd0lCy7xlgzFjk1hWcOnK
	PVx0wS0YGMCKiVhBUykSr89e//jiosRb+uQ==
X-ME-Sender: <xms:BJUJaQG3Xn_MXwrrt3BsK-C_bKN24xp3EhBq3IhHHss1wVYBywJ2_g>
    <xme:BJUJafVwPr_RjsNegbuE5HhODusr7u_NDHReehi53SFk16S2Xx92Wi0C6Sp8tq3Ik
    Q9s98lq-aBgKYbfCUX6Ude767WG9535rlnkIVNuWvVVQ95he563_w>
X-ME-Received: <xmr:BJUJaXwsN1PVOXFd5EKppMhAjl0GpDpOq1QOS-6SgL3K_4P55Wjum3IlSORnc5RZuVVaCfzZ6sICKBcDI6O17uExNfsGtlyWv6cisQSefA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BJUJadOhn7Iw4PbF3QnaYG-GAG5QWgGihrXyGUTR1a4EKaSFp7WghA>
    <xmx:BJUJaY72pYuyBzC-QnUgkhgNf4ZsI8-ttczBgxAeAi6w34Dw8WPYug>
    <xmx:BJUJaeN5rZ1sWhMSwfo_jJg7OKuhm1XA1u5RxyGzpL_sCcUFgmV9-w>
    <xmx:BJUJaWmKNxEqFKTRLzRS9k6iA90w5QwMiNs_wLQbGBrBdbBGIgbQmQ>
    <xmx:BJUJaQ160QdDXD-RPIwP8K8fSy-vLkelWcvzLDA64tnEMGhpbgjJxqrS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 00:54:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c237683 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 4 Nov 2025 05:54:09 +0000 (UTC)
Date: Tue, 4 Nov 2025 06:54:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] maintenance: add 'is-needed' subcommand
Message-ID: <aQmU_hOPO55_ojw2@pks.im>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-5-a03d53e28d0e@gmail.com>
 <aQi1g9TX7FoDgo9n@pks.im>
 <CAOLa=ZSsEygvz1_aj4KomfF0Jo0vJi3yVLtJbhLX=RLgW6_GzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSsEygvz1_aj4KomfF0Jo0vJi3yVLtJbhLX=RLgW6_GzQ@mail.gmail.com>

On Mon, Nov 03, 2025 at 09:18:35AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Fri, Oct 31, 2025 at 03:22:25PM +0100, Karthik Nayak wrote:
> >> diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
> >> index 540b5cf68b..edcc88f4d0 100644
> >> --- a/Documentation/git-maintenance.adoc
> >> +++ b/Documentation/git-maintenance.adoc
> >> @@ -84,6 +85,11 @@ The `unregister` subcommand will report an error if the current repository
> >>  is not already registered. Use the `--force` option to return success even
> >>  when the current repository is not registered.
> >>
> >> +is-needed::
> >> +    Check whether maintenance needs to be run without actually running it.
> >> +    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
> >> +    Can be used along with `--task`. Ideally should be used with '--auto'.
> >
> > Okay. I assume when `--task` is not given we'll check all tasks
> > specified by the configured strategy? Might make sense to document if
> > so.
> >
> 
> Actually no. It's similar to the 'run' command, if nothing is specified,
> we check `maintenance.<task>.enabled`. By default it is only enabled for
> 'gc'. This is important information, I will add it in.

But we use `initialize_task_config()`, and that function knows to use
the configured strategy unless it's given an explicit list of tasks. So
we do use the maintenance strategy.

> >> diff --git a/builtin/gc.c b/builtin/gc.c
> >> index 72177305ff..4d20487ed6 100644
> >> --- a/builtin/gc.c
> >> +++ b/builtin/gc.c
[snip]
> >> +	} else {
> >> +		/* When not using --auto, we should always require maintenance. */
> >> +		is_needed = true;
> >> +	}
> >
> > I guess for now this is good enough, but it's not quite true. Some tasks
> > won't require maintenance even without `--auto`, like for example when
> > the reftable stack only has a single table.
> >
> > Patrick
> 
> Good point. Thought I'm not sure how we'd go about it. Initially I
> wanted to not have an `--auto` flag and simply make it the default
> behavior. But that would restrict us from introducing the `schedule`
> flag in the future. Which I think might be a worthwhile addition.

Yeah, agreed.

I guess eventually we could extend `auto_condition()` to honor the
"--auto" flag:

  - If it's set the task verifies that it needs to trigger housekeeping
    tasks with heuristics.

  - Otherwise it checks whether there even is anything that could be
    cleaned up.

But that's certainly out of scope of this patch series, I think it's
good enough to bail on that specific part for now.

Patrick
