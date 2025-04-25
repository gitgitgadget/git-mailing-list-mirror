Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72715B543
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598439; cv=none; b=QJjhMYw2NrVoiOk4bQPlJsZ4BMPqB5Uq3CF240R3QrH/TahRhOYFjhqBRoPKyeV5t80qJMYNW8ZhIFvZ4YCcxoaNRMpojtnAPcIRgOLDM+mPGlJViT3Kv+8rja/sLYrLC4rPk5vT5qJkVe3xCeclM0Q2WKHbneC/14spqFk7FiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598439; c=relaxed/simple;
	bh=w5eZpav5L+T2+qiXykG2TJuyS9qObkgdjIzYVfFISp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ILqBuzdAwmj70orQt+9DFqOYHqphEJvebDDmKyq9oCNRauws4YY9QkeX7Vacn4elu5tcoiWHL5H6j15Hkoi5InHy909o9FBqE4Tt0kSi7XGJftvvYUMm8srBzUpRsMJWZqZx8Uskx2txZmpL6PXxQW69HDMTXvsBBcPIV7WAGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bGy2zu5i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YX6rjVNG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bGy2zu5i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YX6rjVNG"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 29B2E114019C;
	Fri, 25 Apr 2025 12:27:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 25 Apr 2025 12:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745598433; x=1745684833; bh=13wua+ERA0
	tRQfwxoBDQkKKL0PO6wGu15xnbS4ptrvA=; b=bGy2zu5iE74xRxBFh53XifPL7C
	BymAmiwzv3UqFNCAsTg+K4rhpZFupSo9UxBMhUdVN4w39W4gBpnmhVbPYjV86mxr
	6iB1nuTKZT1QJyho+TJbfUgi85+eMPITJGcQ6jozevL6CJbv4x6x5pIe4tNDuMno
	f9r5j1oGrv64LUM91ilvb+8uR/1vcWFH0ifW3zjZgeItyvfrM5quUjwASk027OQe
	afrBoLqo+GE9qkiBZsPP+vcC1Kyb74uGcfYX92kemaIeQZ133SJxuaW2ICN/0SvA
	INLLsKo2hIuqIA7c7+3zfJO+6g8n8fFoNtNay2Xro1UjSGOU6eE4ZRlxFCCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745598433; x=1745684833; bh=13wua+ERA0tRQfwxoBDQkKKL0PO6wGu15xn
	bS4ptrvA=; b=YX6rjVNG4n1Ts+L8SUR2LETb7iSG+kQPIGgcY4ikjab5x0aC214
	wVQFyFzM4fxLmkTBKdR3p0h67PQSktBmqAXNAeIVsCyVi7jCakTR7zw6P5oj+SEl
	y0vCh91frdNU28Nt3vPbMLGxVejEb9h1yU38Wc+RY9iRHRMvAldCUHtBZGFYhIgB
	K/Wu3cuWBBgqsGRvqotVu/HecOFvnHnS3tVkHK889ZSh8y4J41TGLkGG1S/EjTKd
	kN/KZBeW7WqRnAFo6wiGm3qOZ3CsDOrqL/Du0lKHwlpgqTAIml3eKBEIsHyLvd2B
	/2yGOIgVgnQa2flWAQmxMv2VzdyVrsbrTPw==
X-ME-Sender: <xms:4LcLaCjOyERK3czqwwf3KLxDl4W7Rf1ZLLUwlUE3sszVelNM5UXffw>
    <xme:4LcLaDDTjbd6227BiKcdzbA4QOUnhpiqFWY4-vmnoeHgwnyOQizCzlBeGnkwqSChF
    pkEzlGYu_eRXi7kDQ>
X-ME-Received: <xmr:4LcLaKFjwNoyyIxzBi-niGvLSODOfcf2NRVITjaV3ye3O7PF0RfeVF-CT3jorzJo-FblzTWq4lm65zNw3vzV2NU26o1yxyuoWIhd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4LcLaLR9vLgqEKmxmafT3Y37ujzmT0kqlzle688yKeH0I-5xZjaN_w>
    <xmx:4LcLaPwBZTdBIfDm3NspLAaQ5S3eSL8n7PFd9Fk17RdoAMTE2XFHKw>
    <xmx:4LcLaJ7cADNU6PJiaawETPvTg6g2hJM4sRmp6jx1Fv8cXJpFRQWccQ>
    <xmx:4LcLaMx02VWB8qgJIdQdTDteJhec2XANlSQujMvQQG14IGGSJ_e2mQ>
    <xmx:4LcLaJdTBbqchUIpnmQWlnxW0oQ0IyrDFApU8-NqdYm0FaH0jSW58xRU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 12:27:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Derrick Stolee via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  peff@peff.net,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
In-Reply-To: <aAtZuU6Qqfag6OHj@pks.im> (Patrick Steinhardt's message of "Fri,
	25 Apr 2025 11:45:29 +0200")
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
	<aAsQwSfr-YvS2Mvh@pks.im>
	<090ef16f-42a7-8de6-a79e-5a1958e2c103@gmx.de>
	<aAtZuU6Qqfag6OHj@pks.im>
Date: Fri, 25 Apr 2025 09:27:10 -0700
Message-ID: <xmqqbjskurz5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > Is there a reason why we don't use `parse_options()` here? It might make
>> > this tool easier to use and extend going forward, and we wouldn't have
>> > to care about invalid arguments. Right now, we silently accept a
>> > non-integer argument and do the wrong thing.
>> 
>> I think that `parse_options()` would be overkill here because:
>> 
>> - This is a _mandatory_ argument, not an optional one.
>> 
>> - The required data type is `uint32_t`, and `parse_options()` has no
>>   support for that.
>
> Support for that has been merged just this week via 2bc5414c411 (Merge
> branch 'ps/parse-options-integers', 2025-04-24).
>
>> But you do have a good point in that we may want to validate the data type
>> (even if technically, this is not a user-facing program, it's a test
>> helper that is used under tight control by Git's own test suite).
>> 
>> Consequently, I would suggest this fixup instead:
>
> But in any case, I'd be equally fine with your suggestion.

Yeah, I think we clearly showed our "it's just test helper, whose
callers are supposed to know what they are doing" attitude, but with
proper helpers, it is not too much additional effort to do the right
thing.

Thanks, both.
