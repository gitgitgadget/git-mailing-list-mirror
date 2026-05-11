Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB91A682F
	for <git@vger.kernel.org>; Mon, 11 May 2026 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778467873; cv=none; b=dqhk8cMMEmmOHprYLjo7P5HpXUjKDT+TfA6uwvzwUeGhxzqnEK4+KvEvHAQMT1vfuS5yASaJqTWF5OJxZpBM78hVa1uze7Wv32jYKvK92yctdMBd1yQR1n/LpLCPVOAoEI5E+k65miGwBZ7goRHj9+LVWjE0Ju9hnEcu82WU+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778467873; c=relaxed/simple;
	bh=xrpckbLFqdwkqHxRu1VK3+KmffVvOAZiN6VgrK72aqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AedxJYLWgCgvlbM9+yyRs1unQ+6UbQvAF/oGaWht18lp4CNgjbqZlrZ69ded/Ewb54plqhtZXuYfEOvDc+i38N2BiL6EqiAHdkPPzSXziD398FTnEAdUp/b2u+Dxm1ZuCT75BWX4TV+Ml/MZGCQHHrI8YnvJcq22kmME2SkToyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xDlkQmW2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mGB7lFaG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xDlkQmW2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mGB7lFaG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C1D3D7A007D;
	Sun, 10 May 2026 22:51:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 10 May 2026 22:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778467871; x=1778554271; bh=INl1jrtcm+
	e7BB9wu6y/TEqJUZViDenAkrCE8/9k2fw=; b=xDlkQmW2BXVM8+9kyMrhxf1z7Q
	w0d8tXP0mdcJBEKdj+Bfysrh5l1shj2umuq6IUCWMyv1RjwkKE8vvKGTyhF0zdfT
	/+20v1Va+3U3ycJgVdEfC4kyw9uhMX22ez5+Rk8UbZJO62zOpyfjGwIaK9z2OBmg
	EBrqrfeDnycU4B+1FdPqfzWsEehfONhV4tC4dBJh8d5bQb3MumTqlYdtKLZ3IwIH
	wNEJ6QFnsA3qVgZyjS5b5evrncgfsQWlhmH+ZlE64asHIlhGVbHZOnLL56yls6g3
	2PkWrBex8ss0ftXLTp0nZub1tBoj9RMSZ5Jpi9gCiEMxBmvLiECMcXOVEINw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778467871; x=1778554271; bh=INl1jrtcm+e7BB9wu6y/TEqJUZViDenAkrC
	E8/9k2fw=; b=mGB7lFaG9SSEH37IWvtcR6mIR4KBE4SnxNquXAb1Zy5JmII9ewu
	hIuA78LqyPx0CuF29EkxSmvygQY8y/KIh9c3z6VsL1gcTIO56SV4jBA/77A4+q9F
	iUj1B8UBmuLZ9uzltao+RJtBPHJ9CefZkn1IdbsdIbLQQoWtdZ84Trz6K9H9io64
	LEuSTI9emAravLWj9NfbdVnUxnJwAyn8AO+TB01v3so4oFb6EyXHP2X6MBFQ3mpb
	ZaiAI1SV1KPpJS9KPbOHLvfYIDh/7rLReOP52joqGSwmpPpqnCY30LuNWKPQRU+2
	t+9QVOglPLhAPdDY+eORmXCaYJtgAnsOxVg==
X-ME-Sender: <xms:H0QBamTmrwgkNB5HEF3O30HbJ--GYlzW7bGZzmubTiICBophN-ws-w>
    <xme:H0QBairXP_NubdZkZRVFmqfckcWdnhA47aTxnuGYPn-loNAgpHvwKP6HTXOjqh1Ka
    FcZZi78BA-J0VZXBcMKrrpYk0P8R0voAmZSn9_nhDiBMzxfiKfYPA>
X-ME-Received: <xmr:H0QBasLrSFdRvusm8bmzMIazfhXdM_mi8-POMWMLq8bTuREc2KvA0aNPaniC5AWQ3Tp5fCRCaDhBG0jnXr5t70ElzJGQkWOEDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:H0QBatrXVcYlGWt47xKAaYcLs7q7O0SwjTAXHr49xQpiS9TNshOHGg>
    <xmx:H0QBasyAiNB1upWr1AOKaQJZ6E-EP9fmTOJ85Wk3zSKdpTt8csIX9Q>
    <xmx:H0QBapN44hXAtgflvE-p8vJuZYSPk-gOjoKsopIUO9oScdCDMrw37A>
    <xmx:H0QBap6wfsFxBxLCHje_9AUcnKWuF-LsiVk3eeoQh7YuVGAKluFsXg>
    <xmx:H0QBao7OJGKcl0dGQLdRF3a6AHF-USKi0e9iL6htoUnFgGR_zyZXS8sA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 22:51:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/3] builtin/log: prefetch necessary blobs for `git
 cherry`
In-Reply-To: <a2fbb23d-0809-4a9d-8bf9-8ac0dc8ee054@gmail.com> (Derrick
	Stolee's message of "Mon, 27 Apr 2026 09:16:59 -0400")
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
	<pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
	<a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
	<a2fbb23d-0809-4a9d-8bf9-8ac0dc8ee054@gmail.com>
Date: Mon, 11 May 2026 11:51:10 +0900
Message-ID: <xmqqtsseu09t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> Ultimately, _this_ patch cares about a diff. Could we compute a
> "diff prep" computation using the core diff library instead of
> inventing a second queue of results for diffing?
>
> Patch 3 cares about a "scan prep" which cares about loading all
> blobs for a given tree with respect to a pathspec. This is very
> similar to what a checkout would do, though it ultimately uses
> a form of diff to find out what change should be applied to the
> working directory. Perhaps 'git archive' is a better matching
> example.
>
> I don't mean to make your series more complicated. I value what
> you're doing and can see how your current attention can be used
> to make further improvements later. By implementing things in a
> common location, then we can have later integrations add to the
> confidence in the feature through tests covering each user-facing
> use.
>
> I'm not sure if it makes sense to attempt to create a universal
> library method that would be used by builtin/log.c _and_ diff.c,
> at least not right now. I'm most interested in having this logic
> be more reusable in the future without needing to move code
> across files.

The points raised in the message I am responding here, together with
the ones in <31763514-2602-4d8e-ac25-70590f090947@gmail.com>, remain
unanswered.

Should I still keep these patches in my tree, hoping that responses
may come some day?  I will mark the topic as "Expeting review
responses" in the draft "What's cooking" report I work from for now,
but it has been quite a while since we looked at the patches, so...?

Thanks.
