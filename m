Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD5F46B8
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803056; cv=none; b=p86mKEnLA4YZqt22H+0bKR22LuWEFN2R1BL4nKWtaMlvUGd6TR780DXzXBxmla/xGG8aZp23KxV85NohIXDC1npW+Wbpd24K/HSN7JZxLnmm8OLjAU8DOG3dJAHsGDMVUh6cZdqRw4hDjacJV3FLwj4eId14N3YFfbpe1dotvKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803056; c=relaxed/simple;
	bh=j+gp26lP3ezgydW/39tm2tKGuyJC2Q/KhKxIh9uGoXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JFTThNdUxFKcHPogBWKtg8YyqvtqjUFpN7WyLFk9RJytkXc3Yg84VLBTCcNcEsCZpzk3HRpMWmpMfjCjTFe3TR5ud1sMwQWCvXgciUojX/ingWkNlTNEYDcEEFRzOUgCuWT4HUo45FeSpShUrwR1wron2HFAFhYBK292Ro++HVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ccr3upLj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVaQJwgL; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ccr3upLj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVaQJwgL"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9406A7A0195;
	Tue, 29 Jul 2025 11:30:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 29 Jul 2025 11:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753803053; x=1753889453; bh=v6tUnnlDpw
	0wD4YuPnsix8dNcb+leom2g0aOo7fAy+g=; b=ccr3upLjKLVLNl9C1zdpeTuD8D
	p3uYgADPtdFIGSr1oJxo42DAmMTn5QuTbeZ4THuEaybAgjjicAyfL/Lo0OegBemY
	UnnROXyERH7jMGf63t/qEmfVlDO/Q7aC7ee1hEUFDEgEh7LgneabDP3WINCUcXxG
	URiPdqd6j4lawoyF860sworlPKzoWrs7WlSjjSbUWDWUAlLsM62XwSYl4w2DBdBr
	rd2YW4YlcPAOmhvO7Wu5EnsktIXKNJbuVk9aRwKSTyr9O6vC4ylSS8emWF8Hn4U6
	c1ggrMnkgKjgBDYR5qv+95Kj3qFUcNi2TOkskCqgJ6U/LtDaO6eGyNH63Yrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753803053; x=1753889453; bh=v6tUnnlDpw0wD4YuPnsix8dNcb+leom2g0a
	Oo7fAy+g=; b=JVaQJwgLBpICPgXd+vc8DPrRMjVbZL04ojI54II3dfMIHgzwz5A
	u8JcXi6XS7EzpPQRH94Bva58fDCnCSvxolDIiMKZEb9i989tRRE7qZvyrJLe8tKC
	FAY/noIns9pjKujxURtFFbySG7eR7ZKrkGftDCbA2uxTMLjqatrYOMj0wRD26yua
	8nDNqaq6+XWl5MLgPfURsSWyUB2Aey36zay5ETYaOQyS+xoYM/ffwcz19+StWBP3
	oyI++PvWgD5c8DxFTI7ViWHIBVbxl1Kl24U0Kyy15ke207wPgRv/m16Z+UJKQCUm
	kvsdccJs6SR7Rrh24i4HoMjgN6pOcXZRFuQ==
X-ME-Sender: <xms:LemIaMoOuJ6BvdaMmxNI1aml49px0UvyDbM3cJyjKDjosVjsrNOyjQ>
    <xme:LemIaF7QXfSYY7JIGV3KA_euLBiMfMvcLDQC9ICqEUBSEvtF0kg8EJ0mxDwHFn0DK
    9-5w-qL4fWGabYrZg>
X-ME-Received: <xmr:LemIaKqvmNihROMAzWlx67w9HX82ELdHFO0HlAb8-y4XgdRzi6-kWChIN7szNaESERegSULyIDjiZGBWjiCS_17uh1a7XgyPJEdAqCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:LemIaPgC7y0UGRf-9HDBIhX9xVVKn6cXPOqveCAOq-s8uSAXHZ2n0w>
    <xmx:LemIaMKUoCIbgOs7MCuuVtfLFDru7N6wMyAFL9YH4qlxlzF_5M_v3Q>
    <xmx:LemIaHCssNB46710jUbQP7Ya7Zn9NxVyYYEWN4I2f1RVUZtnqzNewA>
    <xmx:LemIaEjMlBDfIW5LsAWGLlGpO69A2SNCVw3V922yrG1pDintF6iK5g>
    <xmx:LemIaDLTaJYtJSTYH60dTRcc8thOdIffETqpCJywspPokT79Kq69dbFt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 11:30:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #08; Mon, 28)
In-Reply-To: <87ms8na1mc.fsf@iotcl.com> (Toon Claes's message of "Tue, 29 Jul
	2025 09:37:47 +0200")
References: <xmqqo6t3sqrc.fsf@gitster.g> <87ms8na1mc.fsf@iotcl.com>
Date: Tue, 29 Jul 2025 08:30:51 -0700
Message-ID: <xmqq34afqaj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ps/object-file-wo-the-repository (2025-07-16) 17 commits
>>  - object-file: get rid of `the_repository` in index-related functions
>>  - object-file: get rid of `the_repository` in `force_object_loose()`
>>  - object-file: get rid of `the_repository` in `read_loose_object()`
>>  - object-file: get rid of `the_repository` in loose object iterators
>>  - object-file: remove declaration for `for_each_file_in_obj_subdir()`
>>  - object-file: inline `for_each_loose_file_in_objdir_buf()`
>>  - object-file: get rid of `the_repository` when writing objects
>>  - odb: introduce `odb_write_object()`
>>  - loose: write loose objects map via their source
>>  - object-file: get rid of `the_repository` in `finalize_object_file()`
>>  - object-file: get rid of `the_repository` in `loose_object_info()`
>>  - object-file: get rid of `the_repository` when freshening objects
>>  - object-file: inline `check_and_freshen()` functions
>>  - object-file: get rid of `the_repository` in `has_loose_object()`
>>  - object-file: stop using `the_hash_algo`
>>  - object-file: fix -Wsign-compare warnings
>>  - Merge branch 'ps/object-store' into ps/object-file-wo-the-repository
>>
>>  Reduce implicit assumption and dependence on the_repository in the
>>  object-file subsystem.
>>
>>  Comments?
>>  source: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
>
> I did do a thorough review on v1 in the past and did a little less
> thorough review on v2, but the range-diff is tiny anyway.
>
> Version two removes the controversial commits around global config. With
> this, this patch series is not able to drop USE_THE_REPOSITORY_VARIABLE
> from the object-file.c yet. Nevertheless, the whole series is still
> worthwhile to me.

Thanks, I do recall reading your earlier reviews and they looked
sensible.
