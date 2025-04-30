Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21765204F9B
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745996900; cv=none; b=Fp18x7A7bhWYKeHGWNiQ3D5Hc9nbDuBxscFRWbPUqWauHItu4XcqOtLdtvgQMKAlql9LObTGO9R5svbk+CfkPtmj9ycBYwwgCv9jKUmkx13i4dMHLx3BWaBQGAO3ipVfMP3UBR3A0RsJp+NIJW2JjRePKEKjGXK1pNffeitOFn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745996900; c=relaxed/simple;
	bh=gLRnnfdzB33tlq2KMnR+82dQJIvQTPK3XiwTVNM1A8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7PVxur7jMomsP6CUBkwU9ydEO/EFPuqv/Ku8REJ9iNamDhmSn2E+InQC5gZiEW59ylrr601M44kxyGjCaYu7E5R8FNDkllgW6LRg8NWuELQjn5ujv/sPSN7UPBDQUxocpGoMb37W3MOAsvp49R3nTeYS0CDjw4E5+DbP14+ZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j9nPKqhP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dF8dI3YQ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j9nPKqhP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dF8dI3YQ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 09269114023C;
	Wed, 30 Apr 2025 03:08:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 30 Apr 2025 03:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745996894; x=1746083294; bh=x9Yj+I3gh+
	7EYzSCgPX6sfJCtVgu78cCN6ZVOACOKUk=; b=j9nPKqhPzOtb/weGo9UKBZddZa
	id9JuAXIxstzLoYXVaNWGa3L3mXVPG2K/SGDcC2uZfPvgWFrZL+5wPf6cXfLN5fw
	tJv0FGhwVifa5VETONEXynVcoqeStmdqXnc+ENnWkvqsICm1JdleU02pgfjW+7gN
	+6D7BUUJOXR3h0t2iOj043OzKYhgEzXbnG9294NX9ZSXNBnjswaAXhsH/tv1SCA8
	FCy0m7+CfsvgnWtz4LLe9B70iOwsYPtKdAfSanFlMQMEwV29ltoE4oF7OWcuzQot
	TuTYU5nuIaePDiyo2HZboeRvjnmr+g1645UD2Iid0QCONSxJGT+sje5n7k6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745996894; x=1746083294; bh=x9Yj+I3gh+7EYzSCgPX6sfJCtVgu78cCN6Z
	VOACOKUk=; b=dF8dI3YQf05un7mftQtxHbNIlJjcgWeQjJC/UehEGAWQM9k0aPc
	j44/qxzL+wMr/dzXuQT9i/RrP7TQHHg11w192PrF8ljXH4bC+ToxuhgS/246cRZd
	lNvhbO2O7sWMCnzh5s1aEm0RiiR487ROmlUslZIMgsrLCn5prZ9kl0Y+4LY0o2f2
	iPirCj3p9TeRI0PEM57tAXxbWFojelz6si7eoihu8ZvZz90i6fybUfdm6WwV9lJW
	M9Fgcq92dHRAGmRjnAERWRGMIovanIsTH5wPX4/mU5gH7fH4g3C5bMo+8dDjzc9b
	JNNGmZ+C9YoY/gtXla2MliAF9czboMod6ug==
X-ME-Sender: <xms:XswRaLKWedtJCPf8QVeNTt9pQR41yxAgSRHw7uKB_n7klPNt7YA86g>
    <xme:XswRaPIxN0Cknfm4GlVgRpSEjiz5wDRgm41YmHh6Louh1tgGuoYAZ73EXhez1DWqs
    PZF2geim2H_DgbRNw>
X-ME-Received: <xmr:XswRaDsI2MxlK4ODl-Hi-9v2AQ2nBzK32LW-2IGkAMrSvqhnROYKcaTkvSNVG2E-GVtI1e-Sc7A-gSJ0B0ySwi9MvgfhfYqIJM6TDpRvyP-r7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeitdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephedujefhhfekheegfffhtdeuvddtveejtdeiteeg
    feffgeelhfeutdefheejueegnecuffhomhgrihhnpeifohhrkhhtrhgvvgdqphhruhhnvg
    drrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XswRaEbvp1TlMIJSj0crsXfhwhcV9Ex9H2QpgQ--OegoGUqAvSXcVg>
    <xmx:XswRaCaJRXG6wqQ29ItZ73DJqNOhZMq75KtmeNijKri_eYO4UpAigg>
    <xmx:XswRaIAlwpd2SuF3dWY3i6N2E3BpJ2bNRPRl0nJyHA-CF_2egLdXoQ>
    <xmx:XswRaAaJ-A839wxJRCJ1CwdxG_qIeh0vD7sv8vGSiBQsqtf14dp5JA>
    <xmx:XswRaJ0HkqylhHaP5PgmW53Nq8l8Cc1cGcYiM02g5sLowFs7q6c-5uY9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 03:08:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9e1f5af (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 07:08:13 +0000 (UTC)
Date: Wed, 30 Apr 2025 09:08:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/7] builtin/maintenance: introduce "worktree-prune" task
Message-ID: <aBHMXGNfDZQ-JVT1@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
 <20250425-pks-maintenance-missing-tasks-v1-5-972ed6ab2c0d@pks.im>
 <c629f845-180f-4ecb-949f-a99f184f812d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c629f845-180f-4ecb-949f-a99f184f812d@gmail.com>

On Tue, Apr 29, 2025 at 04:02:03PM -0400, Derrick Stolee wrote:
> On 4/25/2025 3:29 AM, Patrick Steinhardt wrote:
> > While git-gc(1) knows to prune stale worktrees, git-maintenance(1) does
> > not yet have a task for this cleanup. Introduce a new "worktree-prune"
> > task to plug this gap.
> 
> I initially thought that this could merge down into patch 3 (move pruning
> of worktrees into a separate function), but...
> 
> > +static int worktree_prune_condition(struct gc_config *cfg)
> > +{
> > +	struct strvec worktrees = STRVEC_INIT;
> > +	struct strbuf reason = STRBUF_INIT;
> > +	timestamp_t expiry_date;
> > +	int should_prune = 0;
> > +
> > +	if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date) ||
> > +	    get_worktree_names(the_repository, &worktrees) < 0)
> > +		goto out;
> > +
> > +	for (size_t i = 0; i < worktrees.nr; i++) {
> > +		char *wtpath;
> > +
> > +		strbuf_reset(&reason);
> > +		if (should_prune_worktree(worktrees.v[i], &reason, &wtpath, expiry_date)) {
> > +			should_prune = 1;
> > +			goto out;
> > +		}
> > +		free(wtpath);
> > +	}
> > +
> > +out:
> > +	strvec_clear(&worktrees);
> > +	strbuf_release(&reason);
> > +	return should_prune;
> > +}
> > +
> 
> ...this implementation is new and nice to have in a separate patch. I
> initially wondered if this condition needed to exist in the maintenance
> builtin or could be relied upon by the 'git worktree prune' command that
> is called by this implementation.
> 
> If we are trying to match the behavior of 'git gc --auto', then it was
> running 'git worktree prune --expire...' every time that the generic
> --auto condition was satisfied. But when 'git maintenance run --auto' is
> executed, each task is checked to see if it should run. If we can avoid a
> child process startup, then that is very valuable (especially on Windows
> where process creation is expensive).

Yup, exactly. In theory, we could even make the condition configurable
via "maintenance.worktree-prune.auto" so that we treat it as a limit of
how many worktrees need to be prunable before we execute `git worktree
prune`. Maybe I'll do just that in the next iteration.

> So I think this is a good approach. Similar thoughts apply to patch 7. No
> code change is needed.
> 
> > +test_expect_success 'worktree-prune task' '
> > +	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" \
> > +		git maintenance run --task=worktree-prune &&
> > +	test_subcommand git worktree prune --expire 3.months.ago <worktree-prune.txt
> > +'
> > +
> > +test_expect_success 'worktree-prune task --auto only prunes with prunable worktree' '
> > +	GIT_TRACE2_EVENT="$(pwd)/worktree-prune-auto.txt" \
> > +		git maintenance run --auto --task=worktree-prune &&
> > +	test_subcommand ! git worktree prune --expire 3.months.ago <worktree-prune-auto.txt &&
> > +	mkdir .git/worktrees &&
> > +	: >.git/worktrees/abc &&
> > +	GIT_TRACE2_EVENT="$(pwd)/worktree-prune-auto.txt" \
> > +		git maintenance run --auto --task=worktree-prune &&
> > +	test_subcommand git worktree prune --expire 3.months.ago <worktree-prune-auto.txt
> > +'
> > +
> >  test_expect_success '--auto and --schedule incompatible' '
> >  	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
> >  	test_grep "at most one" err
> 
> It may be good to double-check that the gc.worktreePruneExpire config value
> is being used here, especially since the prune condition is operating on
> that value.

Fair, will do.

Patrick
