Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04512E9EAE
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797523; cv=none; b=TyB9OBRCqdKteGOa2GfDOEEvMMHBu7wUd6POm++ssfUsqEkViOtLJfu/lBupV1Ko/CSbCjESEOc35j1adnkJIFoslXloaHZY6O3m2t5WmPUqYih1YodDpe3o7uQQgAzkHvClayQMTuiNiBmwwIH8WOAPTUwBmN6b5OXh3tylmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797523; c=relaxed/simple;
	bh=0cbOMADlJVtjFikNPIYv9uUr7VWzlXIETQKfWTnpVeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LmmsSMviLBQtwiuxNPklbyFqTlLbU897sQ8cOtLLhsdYBq2xvH85u/ptONLxqXg35vLikBxNFvcCh/GtXH1jKEqzqe+WsOYaC/c3Zrrz22Fenp1/oVSY50X4H7zMFwQCJW/UvbfP5UzeSMd/m1+kc44T74QDeY+V0G/PllYVymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fW0URCjF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rdoFF1PW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fW0URCjF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rdoFF1PW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F1C80EC2008;
	Mon, 10 Nov 2025 12:58:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 10 Nov 2025 12:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762797520; x=1762883920; bh=4y348hewyw
	2G/uc9ZU+HxEYOO/mwUFg6MA+NUOOxjs0=; b=fW0URCjFVtsxI89NP7GWVZO2Og
	hlgIN4eigvnPru66xrRGAby6jr1cq247bgpJ5phQcwE9Nh4ni+6SU8meUSairK+0
	DDcObwKOpwnp9LrJHS/EFPf7LAIyHjv5GFKLgaB0HSLSo3j2q7SX4y1vE/pui7iz
	e0RpwBGxnPMft/RNvEiCOwq/oFausz1EP4SOTLDQRhFuio5FOpuii8DCc59yrBFi
	kgt/wzhHhF2qQ1PMsYK9gIhdz5z6vmkcFRDp+be7m8JE8hVSEN2B1Vz4KU8jmLJL
	FVWtwAdrUpRe3MdPhHuY7vsF95U8h42oycRGKxl/fZeqezheGkReEhdsmYuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762797520; x=1762883920; bh=4y348hewyw2G/uc9ZU+HxEYOO/mwUFg6MA+
	NUOOxjs0=; b=rdoFF1PWn2hFuiYYuCV2gNRV6JtcIvG+PSxqWEM3/3G5DJ5yV0X
	FXvZrqHD8ARyAWWTgeQGm6g4CaFrFIU+0HKYQZTF/us+rPfclX3hlwdw0r5OTFrK
	ognMIiBTROa91Eacb6qHxDGcCR2d/C0wghRhAPdwv+hUT6GKG8QYQrlCpfa+Sa7G
	gkyzJvIzOpOs1f3aDziuozTb9EEBv5q5pOn5piZiE0VRGRvfTeyIcGP6Ji5f2m/G
	0vj4R6poxaZfEqsen3ZIuMl2pgOYyWEJLpBrLQitntj6gByDrkyDuknomKJ8ok/Z
	V6YkO5hieaR5QijxT9fZUq9BLjUSYwrvYMg==
X-ME-Sender: <xms:0CcSaX8QnmQHO1L04ErGi2PZZFl6OyGdkhszh_MZ6G8QI4ZMOBvvag>
    <xme:0CcSabIXBeP4f8rw8j-s8UEFq2jeTOEe30MnTd43BJIEGLH4-UZ2lXX_9lYwXmPQx
    Ul4YVClq5Bwcqn6UWaeWHjUoybqHofbg4wWP2JVN1gtIyZHuiEXvw>
X-ME-Received: <xmr:0CcSaSYLC6Wlcorgu73WNiSvtgcrCYmHQGgYn2QublLCdvRu2SyzY2phgYj0yc47UYlVmFPg7L4BDMTnsOZwqd5SMj-WUQL9JTjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:0CcSadJmilWY_GsaaJPLQRUYPbAzzHmycCFiI3emawQZiFn1Uj8J-g>
    <xmx:0CcSaQDvRxTxtp2KI5IV-8mhA8kzb0Ah8kYeRZfNq_wRTFJHL8dnXA>
    <xmx:0CcSaSpE7KFsY28gODyVgo0i2djJSwNlNl6adMeChB-5oNfiq6ue-Q>
    <xmx:0CcSabjLYeeaC3LJYvEfXYa0N4tvUqTyV1H9fCC0oJvk2AEbRgJdSA>
    <xmx:0CcSabRGcNNlFryqYw6s2UvwCLWz_ro93SJWrFHOBSsBqxv6cK244sEG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 12:58:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 05/12] diff: refactor output of incomplete line
In-Reply-To: <aRG5KeoZg1Q1y8DE@pks.im> (Patrick Steinhardt's message of "Mon,
	10 Nov 2025 11:06:33 +0100")
References: <20251104020928.582199-1-gitster@pobox.com>
	<20251105213052.1499224-1-gitster@pobox.com>
	<20251105213052.1499224-6-gitster@pobox.com> <aRG5KeoZg1Q1y8DE@pks.im>
Date: Mon, 10 Nov 2025 09:58:39 -0800
Message-ID: <xmqqtsz122i8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>>  	case DIFF_SYMBOL_CONTEXT_INCOMPLETE:
>> +		set = diff_get_color_opt(o, DIFF_CONTEXT);
>> +		reset = diff_get_color_opt(o, DIFF_RESET);
>> +		emit_line(o, set, reset, line, len);
>> +		break;
>>  	case DIFF_SYMBOL_CONTEXT_MARKER:
>>  		context = diff_get_color_opt(o, DIFF_CONTEXT);
>>  		reset = diff_get_color_opt(o, DIFF_RESET);
>
> I found it a bit confusing that we use `set`/`reset` here instead of
> `context`/`reset` as before. It doesn't make any difference as these are
> local variables anyway, but it might make sense to explain why you chose
> to use different variables.

Yup, when DIFF_SYMBOL_* stuff was introduced to this codebase, it
made the code much harder to reason about X-<, and set/reset/context
are used in this switch() statement in apparently "random" ways; no
case arm in this switch statement use all three, so there is no need
to use these three in the first place.

> Honestly, this whole hunk is somewhat confusing in the first place. It
> doesn't seem to connect with the description in any way, as it's a no-op
> change and we don't even use the newly introduced function.

The hunk in fn_out_consume() is about reacting to "\ No newline",
and it calls a new helper function created just for it in the middle
hunk.  The way that new helper function affects the output will be
updated in later steps, but for now, this hunk simply makes sure
that the two DIFF_SYMBOL_*s can be treated differently.

Perhaps it would become easier to read if this hunk is removed from
this step and a later step that gives a different behaviour for
CONTEXT_INCOMPLETE introduce an entirely different code afresh
(instead of showing how it updates what we copy here from the
context code the original is abusing)?
