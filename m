Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD73169397
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517082; cv=none; b=i6vnk4n9FXMUYt3r4XZIYPyocU7LRGWJSzM3N9JcGcdsfDmJwOY03dqfgRfHu04DIMOSLP1/lGyv0Sn4aXsmGTwLURUj8y0hcLyBhOj5E7UULjDt2GUxgZ2GbhL5FmYYkRvN6/QTp4Ukile4ZKyLrqhXM21YQmuS0RHrqBV2WLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517082; c=relaxed/simple;
	bh=BPSUI/18e66GjeCcaLAPDXpqyUre0W91kB2rLaDDUtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hrA8D/rrTMdgRCSCd+ktcLiFmEde4Am5/pT9A+w97bfT577DhXM+tg0/5lqxXsVCffdX4jqpxfM7fCnT5CA0evk3MSck2odevbe3+ftokz25TWy1AqXtCFroqU86vRl4KeHoPk8mrEQYlaYmfgHOvYQy7ADGIotx+fZJq01KOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PKKTKIlo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CPwL9ZXu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PKKTKIlo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CPwL9ZXu"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 03A6113801D3;
	Wed,  9 Oct 2024 19:38:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 09 Oct 2024 19:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728517080; x=1728603480; bh=6eZPb+HSuF
	UqC5IBrlCDAzmidl4BPvR9OdFEALppAsQ=; b=PKKTKIloWPBjhm7gBPzKVgDX5k
	a574nbT1g+cCQ90LnXWYZPkhbKbKFeBfufWAGxoAt9D7zsVbZpqno7v3bxcoS8WA
	RRWwCKZK7ylqYAoEq1K6YxuN42675eMuE/ACaEoMKN9ges46JgyeDRzHpmBYA0XG
	wbaSCWrHpIChew+5NTqz7Oh/nxelO2uXRuJKifKk0fm6qvY+AYvFMbm7hAmdFbz6
	mHb6yStHaQmOd21/e4baLVwej3+9vWvCjftgcKPshIzqe5F54AihkKkJGlZeJf5K
	/zq+iAfeMH5TguPwEoapg012M88Y5EcvYnquswGIXHb4F2NQEoByasXxzKJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728517080; x=1728603480; bh=6eZPb+HSuFUqC5IBrlCDAzmidl4B
	PvR9OdFEALppAsQ=; b=CPwL9ZXuY0/WrMpovIFG2cEGapVBrvJUWn5ei2b+6cuz
	mAupzIkL40sBY2dvlJAz6Rif2PmSZ0nMsTBIZfko7isuyXDiVzurubWYvM41dgvc
	0kthu2gGIgGlIZET6+wOUB35eAxDKFcAZTdb8ExUN6jvdoyFbed3d+SmYCaxdyGp
	brQIcmT3POo4v1gfNDAFQeRtRyptN3t+XL5266gekovez5Wv/CXtHdnMspMDO/Ng
	15weZ3HCCdvcMi7CSNEvukTRnJznyBA5MwTOX8mlR6WcctZhtbYSiU/2oLqYZtTl
	YH8gs3jDrFQ6pHFGvMA/nyKrn4ceOnwtr4ZtBmzXOA==
X-ME-Sender: <xms:1xMHZ56Pwu6RvPdOw0eWOrwDSFwru7tfUvGfbvEv_X6zDthj7V6Ngg>
    <xme:1xMHZ242fSeu5GcQCxNrLs5Y2enNYndN-VawMRlVOZZq-hXQ8tnnKZ5LgHtO-60jR
    EuagQ5Xf1eAXRc8Fw>
X-ME-Received: <xmr:1xMHZwdZ_9dZEUvylM7rv_9J2Ie973xGNpMLNVDqGEoqxpVhjERJZ3F0MKGpH7XcVrfu3XjVNItwVpd71XGNRW0R04-c8mUTjmPn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggufihhihhtvgefse
    hpmhdrmhgvpdhrtghpthhtohepuggvvhhnuhhllhdotggufihhihhtvgefrdhpmhdrmhgv
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1xMHZyKeDMuun7LiwiofRbUZ4TM2ozY7_I94_GbhFsM9p-Y5_5r0MA>
    <xmx:1xMHZ9KkDUoBwaTHd8IIXtB220aEqVNI5L_Q927HjXsPULtZNTB2kA>
    <xmx:1xMHZ7x1YljRsO1qpXCud5eU3ygvNb2vDaBuvdFyNvtpox3fUsMUuw>
    <xmx:1xMHZ5KaoBuZYv3aXKzHRA8NIm7OrQV3DpE9vKPqXROIKbOTGsZhEg>
    <xmx:1xMHZ6EpwKlBGdJZk7FPOPAQj2q_qco5v1KsT5rprmWyDol7qxPwvki3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 19:37:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] worktree: link worktrees with relative paths
In-Reply-To: <oUBKv4JI3Bf1nqAFU_C-HDl5vkZC6mg8mb5F0HB7akXC6n0T1ddV0LiOCqY_AGHCyr9_W7gs2EyTGqIihz89ciBbL61UFwznnHcYRNzfGLI=@pm.me>
	(Caleb White's message of "Wed, 09 Oct 2024 19:19:40 +0000")
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
	<20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me>
	<xmqqmsjexkcg.fsf@gitster.g>
	<k3X5W4US76LBJ_IUq-quVRha2jd-4iWJ9yX6Ukh6-ifZdWC3iajoUJ8VUyTDfkJHSqiD1RJlqIuVlDGIsReR_SDREVWyHGIqsXhazvJu1ek=@pm.me>
	<xmqqy12xqehd.fsf@gitster.g>
	<oUBKv4JI3Bf1nqAFU_C-HDl5vkZC6mg8mb5F0HB7akXC6n0T1ddV0LiOCqY_AGHCyr9_W7gs2EyTGqIihz89ciBbL61UFwznnHcYRNzfGLI=@pm.me>
Date: Wed, 09 Oct 2024 16:37:58 -0700
Message-ID: <xmqqfrp4onjd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

>> existing repository", and another test that creates with the option
>> to use relative and uses the worktree/repository without the option
>> would simulate "how well existing versions of Git works when seeing
>> a worktree made with the newer git with the relative option".
>
> I can already tell you that this particular case is not going to work
> because existing versions of git expect the path to be absolute. Most
> of the changes in this patch revolve around properly reading/handling
> the relative paths, not writing the relative paths.

If we are talking about making irreversible change to an existing
repository, we may need to grab one extensions bit (cf.
Documentation/technical/repository-version.txt and then refer also
to Documentation/config/extensions.txt [*]) and flip it when we
wrote a relative link to refer to an worktree and repository.

[Footnote]

 * The repository-version document claims that any extensions
   invented must be registered there, but config/extensions.txt that
   came later ignored it and seems to have acquired a few more than
   the "master list".  We should clean up the mess.


