Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7AD2F5312
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199121; cv=none; b=GBB2E5e8Iy71sMiPcM2SPKwbaEv2eGjQEql6zdxSNtF5ST1atrt440N1hGx4VmQ0XvaCcRteRJik8a7O8GVFfjMiaAGXgIsHSKMpZdEWV0V3FnpuJsr+EyN69z6KlUfDSyPorlHeQZ+BtpL2vzdYQF9b1ox3BJPEJ+0zq8Q+6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199121; c=relaxed/simple;
	bh=ygD/K5R3v6FDFPiC885fKJPFN2XFys9XkWIU/bNNEIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SCN8jClDvY/z7mn7XNvxyTkoVZCAYVIqElO/ciFxH/F/mxZt6XnIo5f8tzCOIjsP9h/7o0SQSXOzFDXwCqTHr3s2JR8Fa4L/8BMAgcyYdMdxJMcgbtJS0LF9zupTZvplBA6XGeHOOQ4V6ijBVJRK+qLo1F0gjihZiCOtP29SFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=y+9Q2s1d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=krDnlw5X; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="y+9Q2s1d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="krDnlw5X"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 942DC13804CC;
	Tue, 17 Jun 2025 18:25:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 17 Jun 2025 18:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750199116; x=1750285516; bh=+D6GWUcQm+
	OQE+Bs3lKYEwDOwoGAC8tYy+i8dQ5WmYE=; b=y+9Q2s1dZ0mq/DW5siBCs1waZT
	IKNmeLuXqAhQO54sTlqfeUIL0VJyYqyqFrpIEe2x+uKdEYd3Xp3IGCJNeG4idG6y
	IgvlfHOL919nAhW0KJA5kJDr8XEDoNfFW1EFA4am7TVtyZvIbBTcVJkJId763Qok
	rN9kxVhWOKH/NlQmbjh10rpnra85foPc3t42s0VifGXBXtAyRkpPEfbfs5lRJFdz
	BTWWF7Lp+/TExABNaCVRI4VDb3+8Jq8uMfVhGzyrkU1U2tII3MlBWPEQrQhmBuA7
	91NZhGbNOdXl4N39ovpWTRVEJgXMP/FI4p90abxkdVzZZx2fyZq5DiNj4tgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750199116; x=1750285516; bh=+D6GWUcQm+OQE+Bs3lKYEwDOwoGAC8tYy+i
	8dQ5WmYE=; b=krDnlw5XDOX/1coAKxHFUkRZFpG5+CUC5O3TpczQgQdf7b/NMWN
	8y0+HtwLe1Q9UcmwFwx7QGJ4qNcIz05Tnh1RyEszfqVmTHg9xvpyDHJFsHSvsf5k
	m+YqUPhCOOr3jDrw1//8ShUJddan88diIQc6adqFLNb5EAjJanircuzKyKT6blft
	4ggLIxZplxFIpy+6y/ovLtcZMJidPE0aluY+EDVEDMEX0XF+I8ba+r6SEGT48iXu
	LkDdbvhnznQxZj+zLJGQ3PEXQtP5OKgQ9itF7gk1XVgpfCPI7FYEIPBmdYM4t/rN
	LClZQQpcPvmXEU9xMijYPePok5C1vEIIcEg==
X-ME-Sender: <xms:TOtRaOKhNIn46gLv7waB7ZcxiBvuhdzF0znj7zgXHV9sNLSB7HQwMg>
    <xme:TOtRaGIVKDXopQh9B7KdO3phupvapcGSMTJaTQnW6ewNOB5xj3JP_ZADxKZFXBmB6
    -espv4l_bjeQz_awA>
X-ME-Received: <xmr:TOtRaOt-_05_HYE86szFfwregxHqMIM6G0L-hosLEyfGZ9V7A6FAAN04Fu3ipjYnYrQgKkaPwSrnq-hrQtdpzdgyM4v86q3f8YeB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkh
    gvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:TOtRaDaYVz51uLREXgdqF4dM_Gtg8dO4UYw6gHkaUGxmUAJSkxJjiw>
    <xmx:TOtRaFYXGKAdDAr3O2eSEyuAc3slQwOwxyxuLTrC0Dm-e2Kj5DLvJQ>
    <xmx:TOtRaPDPZ2esn6beOAE8zugfBsZGR0z37lMglgo1jWvgJvqB4DVHew>
    <xmx:TOtRaLa64o8_iAhxHNSzS29bnlSC3NL0p4aPP8Xn_lZqGinPJ9j7GA>
    <xmx:TOtRaD9UceApK3aMGcgXfh81JmDkSOhCRv18UP1UuThmK-QuEYwgC30y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 18:25:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Lidong Yan
 <yldhome2d2@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/6] remote: fix tear down of struct branch and
 struct remote
In-Reply-To: <20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com>
	(Jacob Keller's message of "Tue, 17 Jun 2025 14:30:41 -0700")
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
	<20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com>
Date: Tue, 17 Jun 2025 15:25:14 -0700
Message-ID: <xmqqcyb2uhth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The branch_release() and remote_clear() functions fail to completely
> release all of the memory they point to. This results in leaked memory
> if you read the configuration for an arbitrary repository and then
> release that repository.
>
> This should be caught by the leak sanitizer. However, for callers which
> use ``the_repository``, the values never go out of scope and the
> sanitizer won't complain.
>
> A future change is going to add a caller of read_config() for a
> submodule repository structure. Doing so reveals one immediate issue due
> to a bad NULL pointer access, as well as the mentioned leaks.
>
>  * The branch->merge array is accessed without checking if its NULL.
>    Since this array is only setup by calling set_merge, it may in fact
>    not be initialized even though merge_nr is non-zero.
>
>  * The remote->push and remote->fetch refspecs are never cleared.
>
>  * The branch->merge_name array is never cleared.
>
>  * The individual elements of branch->merge are not released.
>
> Add a check against branch->merge before accessing it and calling
> refspec_item_clear. Update remote_clear() with calls to refspec_clear()
> for both the push and fetch refspecs. Add a release of the merge_name
> items as well as a final release of the merge_name array.
>
> Freeing merge_name elements results in a warning because we discard the
> const qualifier on the parameter name. These values come from a call to
> add_merge() in handle_config(), which always copies the names with
> xstrdup. This makes ownership of the memory difficult to track in the
> code.
>
> Move the call to xstrdup inside add_merge() so that its clear that the
> memory is duplicated here and must be released when the merge_name array
> is released. Drop the const qualifier on the branch structure to allow
> calling free without an explicit cast.
>
> These changes make it safe to call read_config() on a submodule
> repository without crashing or leaking any of the memory when the
> submodule repository is released.
>
> There is still some confusion with the difference between branch->merge
> and branch->merge_name, and the confusion of using branch->merge_nr for
> both. That could probably use some future cleanup.


Nicely described.  One thing that puzzles me is this part:

> @@ -253,9 +256,16 @@ static void branch_release(struct branch *branch)
>  	free((char *)branch->refname);
>  	free(branch->remote_name);
>  	free(branch->pushremote_name);
> -	for (int i = 0; i < branch->merge_nr; i++)
> -		refspec_item_clear(branch->merge[i]);
> +	for (int i = 0; i < branch->merge_nr; i++) {
> +		if (branch->merge) {
> +			refspec_item_clear(branch->merge[i]);
> +			free(branch->merge[i]);
> +		}
> +		if (branch->merge_name)
> +			free(branch->merge_name[i]);
> +	}
>  	free(branch->merge);
> +	free(branch->merge_name);
>  }

where we iterate over branch->merge[] and branch->merge_name[]
for branch->nr times and each time we check the NULL-ness of these
two pointers.

merge_nr is only incremented inside add_merge() when merge_name[]
array is grown by the same amount.  Do we need to check for the
NULL-ness of branch->merge_name?

Near the beginning of set_merge() we allocate branch->merge[] 
only when branch->merge_nr is non-zero (the assumption seems to be
that we accumulate in the merge_names[] while reading the config,
so as long as branch->merge is initialized properly to NULL, it will
never be NULL if merge_nr is not 0, no?

Thanks.
