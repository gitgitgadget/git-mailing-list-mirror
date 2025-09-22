Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7A1E502
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578491; cv=none; b=SeXc46KwYPyp1X1YoDgFVBfdYXEBPXpGn3gtNk+etoUPC8/ORa5tbq7mMC+2rE5ZgoYnZ7THvHWdRUioeBAYeIkAgqao7qANCKYp0+l9N30Qqg0Gm6X0urD0Bkc5z3G1Z6f9Or6oi9RF5uq3nbnw41XanbdwvXEwTsI1GFPb0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578491; c=relaxed/simple;
	bh=Rz6N/3JmE1QDti2Tro74/tijk3kd/b3v+/dyVEleKKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CvvfDh1nlH8JMlCZFuE5iq6CmUoN/RouDhprX8qwg2qIB8ahI218a32CxSh5u6G01e1DFQ5S4DYUoOD2ybAEY2rwqwaZtpEeVlud4eChN0SgfyO54zmqHZHrK895nsJHgXV0AnvTS1LEprT6NOsAnQAPRW7I5zmX+IvLobxhwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o7rr87bU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obbYkl+7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o7rr87bU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obbYkl+7"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id C538D1D0020E;
	Mon, 22 Sep 2025 18:01:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 22 Sep 2025 18:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758578486; x=1758664886; bh=6kMPlBqLYq
	Puuebc0rpCmcLeTxeu1Bl2AcubQwKqxU4=; b=o7rr87bUxT9e9oi80ArEXsxItz
	V87pyYALgImZlRHYpamgjH0/iWr6k8BThlYikkhzNGn/ewTCFEJlIV7MRFPvyeJ6
	IJ+Mno15eUSjPo2JQAxKwiIpb1P5bvTeASoEqD5bMGpBOA8Qh6Xs0BOjNQaAF8RP
	cGMrCq6rtgSUgh0TBCZusy8DqfXl7P8ajjAFgCGj+MK/w2fa0D3dJfduDaqMZtjH
	uUEYJTAcGCDt1452qIqT4frElRwGMcUQItb+5RjLKq27GULQHHN8zNJEpWTkyLx9
	OJtLaNcLsCRU/7pygmdWxpnHwKA6tpvv1Ea2RtqVBnZpcoxiX1k7z3RRbh7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758578486; x=1758664886; bh=6kMPlBqLYqPuuebc0rpCmcLeTxeu1Bl2Acu
	bQwKqxU4=; b=obbYkl+7zl1c8KDIYV51/l6Yzu1EnbABkB9QA/x+Fm9ubI89lAS
	+k183TaXhNf9A2Q5QCZETM2f5wzQOn4VKYh5wUuOz0HtvX+WCxInlhIjZAOq0de0
	06Wh0EE1vzzL/KULJJ94QnMRJ09Xc0ylikOfUYlk3+kP/lfAaJHFx6tdzgbBuu1C
	RqQ1S9+FEY7VuHDNjKSZVtaPGOk8Ldd/SJnhJceD1wTTzUHkbd+A24M3YVv6VXve
	RcIyjovZ6Ao5xTlSjdV0rXXwsElxlEuZapjSyHzKpPXwaAyDgHSmIwUBP2K7e1cL
	rYU3KE9gYDTsOkiJa73hvwomIDLpftfHznw==
X-ME-Sender: <xms:NsfRaAffZwStEWpACDBUs0utBg9038UdkbE5i4cCRBQhwwK4j54z3Q>
    <xme:NsfRaJMAPUJb35BlSwo-qD6QsiiAtidl1ngycUdBREdP-62u_yyP2cvGn-gYBpg2T
    eJ3aAd91cQVgBoaBYyaEqdgSQU3AafDEf9tNfNlLeyssO5fYi8OPA>
X-ME-Received: <xmr:NsfRaGhe63HjE8SdNIBOGNHK-C4m-fEivztLKUp4N4WHrlp_EIksoocoY4KAhCdRUpvLW-gJLwasogIx9FqvScizPntvl3KFV1cB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghu
    ghhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:NsfRaE2wCAkW18QM3qGKsXrDWW99Bx0dN19evd9GH92PSzTxNLbU0A>
    <xmx:NsfRaIh0VaFvgdUN-a_ttMd6FjX_2lRvDqE2M3eUVg-SfrKMPSGzkw>
    <xmx:NsfRaMcbCyTX5SlWr8a1uLEIEpYBmfOQ-sFNnlMRUSrhYIRNkPjRbw>
    <xmx:NsfRaDmxDgnNmhpqTApA0cF5M4Hbduf9i_jEKOYumroOAacc_kKL-w>
    <xmx:NsfRaNImIN9LBwVHoi-nLmsicySp-xJtS9nH9xPKMt5GaQL2fIudIRNt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 18:01:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 2/2] format-patch: handle range-diff on notes correctly
 for single patches
In-Reply-To: <7f2487af433.1758574974.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 22 Sep 2025
	23:10:23 +0200")
References: <cover.1758574974.git.code@khaugsbakk.name>
	<7f2487af433.1758574974.git.code@khaugsbakk.name>
Date: Mon, 22 Sep 2025 15:01:25 -0700
Message-ID: <xmqqecryrvt6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> No `--[no-]notes` options are sent to the range-diff subprocess in
> `range-diff.c` when making a single patch.  This means that you can get
> different Git notes below the commit message and in the range-diff
> part.  (See the previous commit for elaboration.)

Would this also mean "range-diff --no-notes" would not have any
effect in squelching the note output in such a mode?  If so, perhaps
we should say not just "can get different Git notes" but "can get
notes even when you asked not to"?

> @@ -718,7 +718,8 @@ static void show_diff_of_diff(struct rev_info *opt)
>  			.creation_factor = opt->creation_factor,
>  			.dual_color = 1,
>  			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
> -			.diffopt = &opts
> +			.diffopt = &opts,
> +			.other_arg = &opt->rdiff_other_arg
>  		};
>  
>  		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index e091df6d01d..1e812df806b 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -707,7 +707,7 @@ test_expect_success 'format-patch --range-diff does not compare notes by default
>  	! grep "note" 0000-*
>  '
>  
> -test_expect_success 'format-patch --notes=custom --range-diff only compares custom notes' '
> +test_expect_success 'format-patch --notes=custom --range-diff --cover-letter only compares custom notes' '
>  	test_when_finished "git notes remove topic unmodified || :" &&
>  	git notes add -m "topic note" topic &&
>  	git notes add -m "unmodified note" unmodified &&
> @@ -721,6 +721,20 @@ test_expect_success 'format-patch --notes=custom --range-diff only compares cust
>  	! grep "## Notes ##" 0000-*
>  '
>  
> +# --range-diff on a single commit requires --no-cover-letter
> +test_expect_success 'format-patch --notes=custom --range-diff on single commit only compares custom notes' '
> +	test_when_finished "git notes remove HEAD unmodified || :" &&
> +	git notes add -m "topic note" HEAD &&
> +	test_when_finished "git notes --ref=custom remove HEAD unmodified || :" &&
> +	git notes add -m "unmodified note" unmodified &&
> +	git notes --ref=custom add -m "topic note (custom)" HEAD &&
> +	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
> +	git format-patch --notes=custom --range-diff=$prev \
> +		-1 --stdout >actual &&
> +	test_grep "## Notes (custom) ##" actual &&
> +	test_grep ! "## Notes ##" actual
> +'

Sounds sensible.

>  test_expect_success 'format-patch --range-diff with --no-notes' '
>  	test_when_finished "git notes remove topic unmodified || :" &&
>  	git notes add -m "topic note" topic &&
