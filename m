Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45913101DC
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404096; cv=none; b=dBwWXPQg/L4jZI13DwhEUToo1uAslinw9P1ZpbgyG23MIDT4BEF/NRzjycpV71dsgPe4eWIFToSW5xcFrxzL/sp9nFkcqztCVNGsuYVSwwnuj4UfSFTdyGtZuXUk0VWl+wGTLXYgxwYd5cml7zmwzRD2uMutm8K8YtUU3RTNjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404096; c=relaxed/simple;
	bh=mKiZOQuTmUN/skbMBwAouIhTKzUaM0/Kj4gKJrfwYEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M+9YBAF/H7AhaG14eJRE71KjCxJDP82Mp4u/jpfZ+L+XBS8gD/q3tEJr4OT8bhlK83jtT9ktM4RBuXQ9/26uz+BMq/I35pc3O+odU6k5Wbqq0CpfMlk5mCH71BktAT47hHB3OMlGnjjtOMBAfAYBawrKxGZnonBje7tNFoy9RSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vMy0AtRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNa3sp6B; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vMy0AtRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UNa3sp6B"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 051641400094;
	Fri,  6 Feb 2026 13:54:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 06 Feb 2026 13:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770404095; x=1770490495; bh=X+kofe+wKt
	n5cfrtgGqVqwrUv1Q+3g+GO1T3uE72N6E=; b=vMy0AtROud6QDvIk+DHZTA0dc0
	Z3kEiMFdFC/Dyk4oZDqwrgCzckbXZNJrJ+gmTGPSkT2vT5SN9zOvoKH7quluVHzd
	FOKAkjgMAsjhTUFcyPNchWmUlCMLWAqiJBe+Ek2MioEVYDVDAQDu8R7FneRPKG4y
	7tE4AOKHLvglUJpdtK3OiXAGPn0gg1nfzj5plUMPjC6swgz1/o/ofGKdNc/AWIgM
	Gc3/ilMCxwoZU1maarfkxdcNxQmFG+hErmKC6MLAFWIXy+ZAMKvc7zHqeXKZcv8G
	g4gPntGpgCJzsVnnyYnGrffks5mKJC+lsBVlAq/42/0ELOC6k+TfZsU7xHfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770404095; x=1770490495; bh=X+kofe+wKtn5cfrtgGqVqwrUv1Q+3g+GO1T
	3uE72N6E=; b=UNa3sp6BWkJl0G0j6MROGGwv0+u6QOy1XWmJq6/Wcen21N1iift
	80JGoPphSLAZWeCyTnW8qgQbMzB0EjJ4RSob1BSrOj3HFoZflWb+dGkS4Mi2pzDt
	wKqBJA18rN5HyOGcor/FYhCD/ZkDB6bD4cSYkS8sI5qmbstqAIFHGkGkJUmKobgC
	53hV0QDBvE93I3otOq1MVvwtEsMRmU2umod5nIN16F5CQtm2cNEQEeRe4Jp9zC3M
	Hg19UwxlF2P13ho94AeEHjftNnnfJ/JnDmsVKLbyOkIw+d/v7QWHPNB1WPGJPbd4
	FsuWNDzMSLpaRAGDnV67kHF4zGHMb3oSD8A==
X-ME-Sender: <xms:_jiGaanfKDx3NH96wKNpHgdH6AWF0FNTCT4s4qjTnk3uYJKvHW82EA>
    <xme:_jiGaeb38IuOiKxEtUHRl_0b77rV64F0p1hKEtp4ijbez4cVoMxX5cX72Y2DRtRrw
    9LoqGEq43N0Y3ufIZB6JAEjHkI7Ze2FCm9JQaxu0ljG5gVaZjJgOw>
X-ME-Received: <xmr:_jiGadFpAIRHfQxi9D0B9eb2sz6KMImZXk85rl5-K4kq1Gqx4jgVeymhpYtfoM-Wt7vsblkyOXNIgCL83w6RwL8bTPhmf66HAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_jiGaVbVX44inqbN_VtDgcwtMOknAG5bMiTh4dPW2HLmNksIcRLzkQ>
    <xmx:_jiGaZzx3lMU7sF5efTXHP_Edp-Fd6fzEgZLpsaJChDEIJrgYrUFWw>
    <xmx:_jiGafR-0d9yoG7JvTPkKVWwUEgE9-xanyt2UelFDYjdVOoLUefQFg>
    <xmx:_jiGaeKu8rgE3zBr6z6kYTGkwvOSRCDpYTuTCY8dxJGiKEx7hVwXng>
    <xmx:_ziGaYMPGO8yNRCwixJX54qaODUfgVrJ5hdmP2dp4FEjw45onaLVvjyR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 13:54:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
In-Reply-To: <24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
	(Abraham Samuel Adekunle's message of "Fri, 6 Feb 2026 16:56:14
	+0100")
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
	<24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
Date: Fri, 06 Feb 2026 10:54:52 -0800
Message-ID: <xmqqwm0pem83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> +	for (i = 0; i < s.file_diff_nr;) {
> +		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr) {
>  			binary_count++;
> +			i++;
> +			continue;
> +		}

This "continue" is a commonly seen good trick to avoid having the
nesting go too deep.  As we know the case where the condition holds
have already been dealt with and moved to the next iteration at this
point, we can ...

> +		else {

... omit this extra "else" block and write what is inside for
everybody (not just "those who did not pass the if condition above",
which is what "else" tells us).

> +			ret = patch_update_file(&s, s.file_diff + i);
> +			if (ret == NEXT_FILE) {
> +				if (s.s.no_auto_advance && i == s.file_diff_nr - 1)
> +					i = 0;
> +				else
> +					i++;
> +				continue;
> +			}
> +			if (ret == QUIT)
> +				break;
> +			if (s.s.no_auto_advance && ret == PREVIOUS_FILE) {
> +				if (i == 0)
> +					i = s.file_diff_nr - 1;
> +				else
> +					i--;
> +				continue;
> +			}

The asymmetry between next/quit and prev feels curious.

The patch_update_file() helper returns QUIT when the user tells us
to (regardless of auto-advance setting), PREVIOUS when '<' is given
but that is only possible with auto-advance disabled, and NEXT in
all other cases.  The check inside the NEXT case for auto-advance is
to decide if we want to overflow 'i' beyond file_diff_nr to complete
the session, or we want to wrap-around back to the first file.

But ret can be PREV only under auto-advance disabled, so the check
there feels totally redundant.

And we want to treat the list of files as a ring buffer only when
auto-advance is set to false.  This may work in practice but the
logic feels convoluted.  

The patch_update_file() knows how many files there are to decide if
we want to offer '<' and '>'.  It also knows the file index within
the file_diff_nr for the file it is handling.  I wonder if it should
do a bit more with its return value to help the caller?  E.g.,
perhaps it can return the next 'i' if it wants the caller to advance
(and decide to do the ring-buffer if needed), or if it wants to tell
the caller that everything is done by returning some sentinel value
(e.g., -1)?  Then this part of the caller can just be

	if ((i = patch_update_file(&s, i)) < 0)
		break; /* all done */

perhaps?

By the way, I just noticed that the new local variable you added to
patch_update_file() is called "ret" but that is hiding a different
variable "int ret" that is used to handle the '/' command.  It
should be renamed to avoid the name collision.

