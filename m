Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46E3987D
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738276809; cv=none; b=VMtiPleQTPe1A5Xe6TvUkVwIYn4NpQFbGmeG9Z6GgWTCoT0m4BcrUN6sqzjRQwHMiDtCjXZfw2zBitwz4JChWEAEuY1CupFWlKzOOXuG5bzo6BCfze1nOJJJtufti6GxLud2U70GGARD3efuCPUnIDLwJGanON0ZQOe88ltBukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738276809; c=relaxed/simple;
	bh=IJJOKCXYXjqc7BFDDS/bGUkeB0HpdcKdNHLBCH7BSZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qbZjbU615Ht3f+PT7yHRKkXPyp3px8WSUCMgEYEswbGK1Z4j8xx/eGno4lFfuPyY9Jb/5IoORUfs/c/4mbWJRQgPoLjcftoVK4TgKxjR5ow1ayQrKy/MHGF1KFk9rnTvmK+ycSr5aIS5HrjiD/DksPpSFD9/irX5RHVm1a1Idpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q8svN/TA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CdWgcsUu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q8svN/TA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CdWgcsUu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1AA4113801FF;
	Thu, 30 Jan 2025 17:40:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jan 2025 17:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738276806; x=1738363206; bh=jTi+txMhgz
	iDsEA19KIk5ObWz5hyfrvNNo2wb+YUjMU=; b=q8svN/TAo7qlpo7lxoCCK04Tk8
	YNUNtNVm3kuw5goOoCyBoDxXdmetjiujHmIUFq33I/j/n2Icb5zUuC1geDx0eyD4
	yOFwnvFIWc7uZIAbU1py67HQ0opFGvwmgexMgjUGF3+OS8hZBzmdVa6IgtUpzF5c
	DpxGSzcHpgKDe878Uy922wXqZDX2UvQtq5V0EWSzlBPqutV5X5m9NYfPnNyeQeEr
	4bFEAHowv8gog6JExm028yWgE2h3SNQvLaLm3w8TD0bBL64CLPiyR2Rx51YqUxNJ
	n0fzOrJKkju6xd2EWq1zu0wt5KaAHp67rJbHKJ1hHrgRdCK7sJ1ugf6pyDNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738276806; x=1738363206; bh=jTi+txMhgziDsEA19KIk5ObWz5hyfrvNNo2
	wb+YUjMU=; b=CdWgcsUuM/z7bCcYPNh1reOi7STBpz+0NlniDswfl/Bm80pk7wm
	92ybS1YNF+7qdbQ2uvPes2xwpa/pVVwc1MYqNdGKZ1KRsBNEJnO/7kjKV6ggdt6K
	p/nFuCkW9dY9SBOgIFEIuHDUUA/q2ultWA+kkkIFff1I9lwHiT4hUZczUhX2xOYX
	5JooJ/6yci96Awm3cES9k1diIMbVPtdZEgSZuQPhfHrA+yEUId0+apB7PafN2D/+
	z/8wBX/s9jP/9YM3k6Sh45hsi8vrvoZmVM/KZVlBaAQ93dA8DQYXIxPi7gUfMtgh
	ISqgASrAWf8d16JMu3GrIH8G62Gpbb35X2Q==
X-ME-Sender: <xms:xf-bZ0bvzzb6uqamSy1LL13ctA1ISxYaquLcH7gOZHH6glsnhZ0kIg>
    <xme:xf-bZ_bg_7dB6K04hGLC-8LFDwKXrNJUy8yj7kmT35Ra60an8_O1flUM_SJPMXZR0
    IIJCe6qpt-8TyjwFA>
X-ME-Received: <xmr:xf-bZ-8kOOpNGwAswhcHhbhPk8cfT7rugWvLdM4PAgXxSgUF8uzJyDLL4H3SFqR3pXqkp7TBC41-6ZTome9CkLQdKy9WzOmMqk7y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xf-bZ-rfTb7j4G_tgTqeNIEhZV315nUDZDryNCQiXoxEqzZwvv3W6A>
    <xmx:xf-bZ_pWUJK1Z4dLa9Np4O6JGRN9U1O9JQBrRRtiNbyqBdVXpnSmtA>
    <xmx:xf-bZ8RAuPVA1Ze3TzIxodnp4xko-DtLfUwAE77Nk3fFPi9wtuMBDA>
    <xmx:xf-bZ_o88UiaZN9VmG8aEVSjj_peK0Zu2OVk3rlfJOc49Vyv5BXp2A>
    <xmx:xv-bZ-V69hr6tDPbtD3cpJcl-jArGd-KsVqpEkBxGV2JXedFWRR40ZaK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 17:40:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] setup: fix reinit of repos with incompatible
 GIT_DEFAULT_REF_FORMAT
In-Reply-To: <20250130-b4-pks-reinit-default-ref-format-v1-2-d2769ca01207@pks.im>
	(Patrick Steinhardt's message of "Thu, 30 Jan 2025 17:24:18 +0100")
References: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
	<20250130-b4-pks-reinit-default-ref-format-v1-2-d2769ca01207@pks.im>
Date: Thu, 30 Jan 2025 14:40:04 -0800
Message-ID: <xmqqy0ys9b97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The GIT_DEFAULT_REF_FORMAT environment variable can be set to influence
> the default ref format that new repostiories shall be initialized with.
> While this is the expected behaviour when creating a new repository, it
> is not when reinitializing a repository: we should retain the ref format
> currently used by it in that case.
>
> This doesn't work correctly right now:
>
>     $ git init --ref-format=files repo
>     Initialized empty Git repository in /tmp/repo/.git/
>     $ GIT_DEFAULT_REF_FORMAT=reftable git init repo
>     fatal: could not open '/tmp/repo/.git/refs/heads' for writing: Is a directory
>
> Instead of retaining the current ref format, the reinitialization tries
> to reinitialize the repository with the different format. This action
> fails when git-init(1) tries to write the ".git/refs/heads" stub, which
> in the context of the reftable backend is always written as a file so
> that we can detect clients which inadvertently try to access the repo
> with the wrong ref format. Seems like the protection mechanism works for
> this case, as well.

Good finding.  A plausible alternative behaviour could be to do the
backend migration when this is asked, and we might gain consensus to
do so in the (far) future, but I agree that it is a good direction
to go in the short term to match the behaviour of the code to the
documented expectation.

