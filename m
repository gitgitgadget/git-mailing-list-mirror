Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE71DE3D2
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741647886; cv=none; b=FmIGm5g2xgJUiD+Jo1GuWME7U3Yvq+clfit+Qdqv23Nzhp3729sFcIJKmjQ6AmbX/KP0ixxrn5CZ1fRiVNuAmbYpKtZUhkEQ25/EAah7U6vXQaBkWILgz8Hsbm2N27V3H3DrwKvjNyiJYqcstXfB8VqcB4DccNN7S6UJ/YQ/RLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741647886; c=relaxed/simple;
	bh=437d41kvtJcYMYxHqZK35/3HuOBi3X3cn+QQjYh8hdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcYUWyCJX51CuPMpjNHiCciSbF9AbCNDTwgSS74votXYCIDHTJOKIMiD6Dron7QmImtyh1oUxO2O0JaX8+ErEQhlYhQlStsEzZzPcR7S8o6gBI3rnBHLUVs3mTImh0rzSCZ1peYsyXygKTVkdMS4xr9OLMEeJlv/X28/T0fwSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vt2WL+aJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3DJyN6j; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vt2WL+aJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3DJyN6j"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84BAE25401EA;
	Mon, 10 Mar 2025 19:04:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 10 Mar 2025 19:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741647883; x=1741734283; bh=KBIdq+VJxc
	xdCmGd/RINAIy/DkOmYeRIeO1/2/3uLS4=; b=vt2WL+aJ2H5RZvQyXnK8DbdgFM
	AtbzdLnc8pk/tSAFWZUkPeFreG4XpuDyxjAcJocYPP/ouk9BaJJMSOaOWKZUaTcZ
	6IlgH9FvsXIqSOmV1mS/XUjUjLxNfQwsdvQ2/7srtR/wFaC6UslfVqJeMUweJuGx
	UFvgRzUo9FbRzP8aNJ+kUKTk9hI7L+CK/hPbh2YXnIDXkjrTvrgQgEuXYBIoVMw+
	V/94uFnL0AqqLHfqwU4EFjb/WxvcYAAzZbjAFhS7oZvopxuRk9XAGzNIZxb4Dm2a
	bBkhZLat4vZNeDz+z/J0cInTkIQHyedJFFgv96t5toOM9rZr6V2KSM2/uzbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741647883; x=1741734283; bh=KBIdq+VJxcxdCmGd/RINAIy/DkOmYeRIeO1
	/2/3uLS4=; b=o3DJyN6jywcLTFVjkbLbgwMeePAfbmQF969z+LvbukQMxCwCT0+
	1WbD7kMhOtKSE5k3ei9b5uoYTLcU/UBwHX2L7YoOhwqeHakGgOl7mLA8ePICnNEB
	2S0br3alcGMc/J1FvqhZzqa34njSnDWy3QqFZWlFsWscDn9MVY5BBHIaY8zRRNN+
	bJuhltmm3oOE4Mppbq5YNgcP16v3/ZAWW3ocGkBwPcwc174N87iWFygv24TmoCc2
	FVklex1C+9fAMTlyq26PyV8cc/JJqqsVRRvwzWUg9Kqt3KeRRvEGmxiHJ+5nklBK
	fpKKduDCoMhaoQLfzkEoyvX1zJNmIQraoqg==
X-ME-Sender: <xms:C3DPZ1i2wS1W8R6kO2lxSXBrRv-R0zxnv8IThVEp0i2Se7w-tvjjgQ>
    <xme:C3DPZ6DPYzZQss6oHY1coVjilAFcMjKdhwLWGrvf9UHfvjHBrVyEkVlnIHWGt3Pra
    PGeN08rr-nd3jI2lg>
X-ME-Received: <xmr:C3DPZ1F_6fO-c7CzIQD7CdiefjJiAgrAeJpPe7vW_K8lxT5uxNtICFdvghxVgZGOymSyCP-1U225nHWFJUBvsvwAjFmm9bneCaq->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhhuhgsse
    gsvghnjhgrmhdrihhnfhhopdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:C3DPZ6RnXYRlX13G0YJF21GBEFdvUG5JWDHVzMbxb6jH0TJCahabNw>
    <xmx:C3DPZyw9VkYeZrZChbRRhcvwzW85fMVV-QzFEve898c57A1ybHe5YA>
    <xmx:C3DPZw4wJHu1pQKCFmRS00yo9bvT-p5Zl7eDGL-q7P68047EoYS_rw>
    <xmx:C3DPZ3ybGtXXRnxy3oBt4PJ-P3aLLxNHKpFqs3pu80jw9jlZl42itg>
    <xmx:C3DPZ5qHjb_DQ552BuVzM2FCg8CBxGn8ahosw3AWtEbm2dUH9V--KE1k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 19:04:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Benjamin Woodruff" <github@benjam.info>
Cc: "Jeff King" <peff@peff.net>,  "Benjamin Woodruff via GitGitGadget"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] describe and diff: implement --no-optional-locks
In-Reply-To: <bbc8a0ef-737c-44ba-9786-f5456f5ce71b@app.fastmail.com> (Benjamin
	Woodruff's message of "Mon, 10 Mar 2025 13:50:36 -0700")
References: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
	<xmqqo6yejg0y.fsf@gitster.g>
	<20250309033908.GA2361799@coredump.intra.peff.net>
	<xmqqwmcx9io3.fsf@gitster.g>
	<20250310160837.GA26308@coredump.intra.peff.net>
	<xmqqo6y87m4d.fsf@gitster.g>
	<bbc8a0ef-737c-44ba-9786-f5456f5ce71b@app.fastmail.com>
Date: Mon, 10 Mar 2025 16:04:40 -0700
Message-ID: <xmqq34fk5vxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benjamin Woodruff" <github@benjam.info> writes:

>>> The commands at the Porcelain level, like "status" and "diff",
>>> refresh the index for the CORRECTNESS purposes.
>>
>> Right, but "status" supports --no-optional-locks already.
>
> Does this mean the documentation in `git-status` is incorrect? It
> implies that the background refresh is only for performance reasons.

It has to do, and it does, refresh the in-core index for correctness
reasons.  Writing the result out to the on-disk file for _other_
processes that will use the index later is a performance hack, and
may or may not happen (it is up to what repo_update_index_if_able()
does).

If we do not care about redundant refreshing these other processes
need to do before they start, we do not have to write the resulting
in-core index out to the disk.

Writing the in-core index out for other processes has one downside,
which is that for correctness it has to be done under lock.  We
cannot say "we tried to be nice to others by writing the index file
out, but we just found out that there is a competing process trying
to open/write the index so let's skip writing it and let them do
their thing---they are responsible for refreshing the index for
their own use".  There needs some coordination, i.e. when we start
writing the result of our refreshing the index for others, if other
processes need to pay attention to that fact and wait for a while
before reading the index, then they benefit because they do not have
to refresh the index themselves.  Even though our programs, by
calling hold_lock_file_for_update(), know how to wait for a bit when
this happens, not everybody cooperates.
