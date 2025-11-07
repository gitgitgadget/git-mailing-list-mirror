Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B17326D67
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524491; cv=none; b=nSuUxn2Axj+7B1Uv44TgcEdHrtsAXcD/ZHDcPkAc2tdSQJvLEhXMmXXUfmpZ0awX9yqapkwpRVbKbz5jG97+knD1eOE417IJYFXdjNza60ob2TEqUvkYNBcRxD6jGvtEVkh6mI+R7gJGz9AYk4Juh/1vfPwNOQrblPtqt/nPQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524491; c=relaxed/simple;
	bh=+cTkqJxwgmhf/W4Hto5j5TY7P3gEN+6xF83iyDk1IKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsY4GbZBQrQHXczVYO+ncUV7Umxaq2rC9h6DR7dC83j6UCVu7zvRqARaKP0qtE1Q608UGnDQAC3kGfST0SFdh91UZrgIi3u1pc7rkylya3G52IAMrvKPOmFPV7M6wjHZLkfqNSb4cmLeBCSkDvPAFTsiOyM3xeqVGtlDQn0LNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uxr4k0uC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5W1TvS/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uxr4k0uC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5W1TvS/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A707FEC0292;
	Fri,  7 Nov 2025 09:08:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 07 Nov 2025 09:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762524486; x=1762610886; bh=peEWxHP62l
	RLJ3SGLmIF36Gx+vFX/MpC4EHg6jMlVSI=; b=Uxr4k0uCN4GlrIskvXBWYwc5wn
	Kh4WuP/16bDcBLJ4y4I+YUjiNi/ecewZn5D1CjSZx3eryQrBKBB8OVlY8JZUHEn6
	oBuKiWdM5mjtHH/abCqE2ruJOV2uFdULUhT5GMcdhFyqkLL9TpbiIzfBp+hYz2dH
	6VJHMmvyJthzUksCoXbLOqVp8iq4Zg7TtrY11sxh5+u5TY66zmFr6f9sqlHYN2o1
	UUzORFW+kfeXq05l5ozehSeyr78AHh46mwCN2KVuxPyTick4+i2V3EkpoQciDYQy
	lXXnSa92dYn+tJ77qw2o5s0pG8OWgJk/viFSASC/pgH7vuZGsvsdvxzqNpFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762524486; x=1762610886; bh=peEWxHP62lRLJ3SGLmIF36Gx+vFX/MpC4EH
	g6jMlVSI=; b=k5W1TvS/Lvqws2JK0S69h3BRk/B0nhDQj4tVO/DweFI8V9RU3XE
	GAHsPpQA7LhxgnvPvyXHl+v4jxoCqn0uZcRd3xE1JJRPdOGhGRwv4e6+ITRiUmGU
	jO1XiQ2205gjVxp9LCB9vv0dyJZgBiwZRWcby+GHd0ovea2DDFDol4drVTWxDMf9
	3BgvlE1jF5pLKolGMFq69acf+KEAMnEdcCxPLMjgrs5qNjc1COujpdPJQ0/m2MzH
	Funk3VnNfv5t4P1HD2ccNIHKUggf/ayh7CUjKl3FJOIBm8mMXsBTzQsTuOmY+NX7
	BeXC/nkbE6xnt45DI18Xgesz3breetSNNNw==
X-ME-Sender: <xms:Rv0NaQGdTjpE7b448AmqIFmNOlY_El1e0ppABVMpkTG_d2pCdN5Nrg>
    <xme:Rv0NaQOmoCpEwBE_7G-l-E-IiaAe1UxjMd5AYL2qzxImCwx5e2MmEWUBiWAHK2EPL
    Y2UQnVKiaZgEHnWn-WaUKYMsVnNqs5Eo6RwwTD76-f88OV5KzFtDg>
X-ME-Received: <xmr:Rv0NaSf0Y8PaMpTVfybxues8u1EyQZ3gTo-pB7fEq1eRYJCfXP2LjvlyquwMbNvynCI1_KpPvms5Cj5sEZj0nMmaFtbivLucuA3goxbJDWnsuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggvsghohhhmrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Rv0Nadsof2rGjl5ezfMRb6I7eoKfaJ4QnGDNKOlp-A-9cU-o99Rs1w>
    <xmx:Rv0NaTnk0l_xTihUdmtTztyZVzT-AYOB0BWvxefZ0qSrwxu9a0MKgA>
    <xmx:Rv0Nafy7XhyprW1_lGgd32uOQks20qV8uFlaEYSRZwEuhSFkGzF26Q>
    <xmx:Rv0NaVO6w1vLmrpgNhDBHUOxYkVIEr3qZo4Co2JfULeuVryt41GAUQ>
    <xmx:Rv0Nac8KHAUczZVLSWQFNzTwmDWsLzkoQXGEUFGzPojzxoYllqICMGtM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 09:08:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 840e6188 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 7 Nov 2025 14:08:03 +0000 (UTC)
Date: Fri, 7 Nov 2025 15:07:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, sunshine@sunshineco.com,
	David Bohman <debohman@gmail.com>
Subject: Re: [PATCH v2] fetch: fix non-conflicting tags not being committed
Message-ID: <aQ39P0mAFqDGPYxS@pks.im>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
 <20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com>
 <aQyLfD_zx0ndCLvU@pks.im>
 <CAOLa=ZQpTqnCQs4=wcUwJOWy5mXiG4y_eTiFtPkS2uOk4U66Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQpTqnCQs4=wcUwJOWy5mXiG4y_eTiFtPkS2uOk4U66Tw@mail.gmail.com>

On Fri, Nov 07, 2025 at 05:15:32AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Thu, Nov 06, 2025 at 09:39:25AM +0100, Karthik Nayak wrote:
> > The following test demonstrates this behaviour:
> >
> > 	test_expect_success "fetch single branch without explicit tag option" '
> > 		git init source &&
> > 		git -C source commit --allow-empty --message common &&
> > 		git clone file://"$(pwd)"/source target &&
> > 		(
> > 			cd source &&
> > 			git commit --allow-empty --message discard-me &&
> > 			git tag discard-me &&
> > 			git commit --amend --allow-empty --message fetch-me &&
> > 			git tag fetch-me
> > 		) &&
> >
> > 		# The "discard-me" tag does not point into the history that we are
> > 		# about to fetch, so it should not have been created.
> > 		git -C target fetch origin &&
> > 		git -C target tag -l >actual &&
> > 		echo "fetch-me" >expect &&
> >
> > 		# But with "--tags" we instruct git-fetch(1) to fetch all tags, so we
> > 		# should now see it.
> > 		git -C target fetch origin --tags &&
> 
> Here, we don't really backfill, but rather we request all tags from the
> remote, hence we end up with the 'discard-me' tag. Not because of the
> diverged history. I also confirmed this by adding a breakpoint into the
> `backfill_tags()` function, while running this test.

Oh, exactly. But there's two fetches here: the first one only fetches
"fetch-me" because we don't pass "--tags". The second one was simply as
a demonstration that we would also fetch the other tag that doesn't
point into our fetched history with "--tags".

I notice though that the first fetch forgot to `test_cmp`.

> > 		git -C target tag -l >actual &&
> > 		cat >expect <<-\EOF &&
> > 		discard-me
> > 		fetch-me
> > 		EOF
> > 		test_cmp expect actual
> > 	'
> 
> But I was able to slightly modify the test to get the required affect:
> 
>   test_expect_success "backfill tags when providing a refspec" '
>   	git init source &&
>   	git -C source commit --allow-empty --message common &&
>   	git clone file://"$(pwd)"/source target &&
>   	(
>   	    cd source &&
>   	    git commit --allow-empty --message history &&
>   	    git tag history &&
>   	    git commit --allow-empty --message fetch-me &&
>   	    git tag fetch-me
>   	) &&
> 
>   	# The "history" tag is backfilled eventhough we requested
>   	# to only fetch the master
>   	git -C target fetch origin master:branch &&
>   	git -C target tag -l >actual &&
>   	cat >expect <<-\EOF &&
>   	fetch-me
>   	history
>   	EOF
>   	test_cmp expect actual
>   '
> 
> I will add this in. Thanks for the explanation, it really helped
> consolidate my understanding here.

Yup, that should work, as well.

> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
> >> index c7ff3480fb..d5aee5af10 100644
> >> --- a/builtin/fetch.c
> >> +++ b/builtin/fetch.c
> >> @@ -1686,6 +1686,42 @@ static void ref_transaction_rejection_handler(const char *refname,
[snip]
> >> +	if (*transaction && !is_atomic) {
> >> +		struct ref_rejection_data data = {
> >> +			.conflict_msg_shown = 0,
> >> +			.remote_name = remote_name,
> >> +			.retcode = &retcode,
> >> +		};
> >> +
> >> +		ref_transaction_for_each_rejected_update(*transaction,
> >> +							 ref_transaction_rejection_handler,
> >> +							 &data);
> >> +
> >> +		ref_transaction_free(*transaction);
> >> +		*transaction = NULL;
> >> +	}
> >
> > Okay. Do we need to discern cases where this is called and we haven't
> > managed to even queue a single reference update?
> >
> 
> I don't see a reason. This is anyways a post-commit action, if there are
> no updates, there will be no rejections. So this will be a no-op.

I guess the question was rather whether we fear a negative consequence
by trying to commit an empty transaction. The commit doesn't know to
short-circuit empty transactions, so we'd still end up locking data even
though we eventually end up doing nothing.

Thanks!

Patrick
