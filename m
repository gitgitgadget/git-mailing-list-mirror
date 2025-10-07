Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CF2E0920
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849902; cv=none; b=TL0bMsAsYUCY8sWGyqx8qsJ4fAlEZAsvyOWcxIWanev8kQtGffixCUyS5AVt8iG7c/2YkA+ePAGcYQauQCWYyYTrrBQa9SxYFSMEPRaQ4mn+dn8c2mM0cfx7nc573AlvD0vvRGUnxVUWulsm8ZL02aA7zLuZX9aodldaJGkZSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849902; c=relaxed/simple;
	bh=gFDusSZbRCB5aojNucafEZGBFyu1hPZDbAF8bDVUSJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W1bm08/7VsTsvkdLvCF0TIR4DEiNobTa0EESlb2nk2CJQDzkw09IyG5vm13Td9NRp9zJeO7SokbG19Zis9vkuouWdTnJ0UuG+0+377a8twMXvMvbum2z4KpPdfLIrFJQgAKUahkCMXZTWFP+IR99kLM8slxWl+GswDvRIWCpjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aW/aoXl5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PtXDAuEI; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aW/aoXl5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PtXDAuEI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DBD2B7A01CE;
	Tue,  7 Oct 2025 11:11:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 07 Oct 2025 11:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759849899; x=1759936299; bh=VfWj1mHoD6
	rjFaOQ65KH0lxcdl2qQaxVKTE9sk2Mdhc=; b=aW/aoXl5fVV019cEk8phsXjDtQ
	UWnccxmjc/euDfio5/BorznjPbqiuyfqGEyXdCYC+Vf3TEOo/Dg3q0VGH6zMs4q3
	uUKSdAVrbJ00JQAO2gB1RQIZGyc14lrS4q0Jlmn/bc07xVpJqbbMJsPYwvb/Y2dQ
	F8BDTZMJDwuU4Gt/o02drg51df4lWvJL2ccr8cFTiNNNqCoyxITVQPJQs48RxPoo
	daYhBJsgSjKHxp2dN4TMJBn4z3P0AMRAeRsrTXsd4IWSWWnxpokJukRz8Gvz5+c5
	fTCGWG8r19OVIdrxdx8hk2hba7DF/v08Yfgrqr+rswBAMDfH1S/EYn9F32Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759849899; x=1759936299; bh=VfWj1mHoD6rjFaOQ65KH0lxcdl2qQaxVKTE
	9sk2Mdhc=; b=PtXDAuEIHjwFrlJAZtNAVD+tBHN5uv9kFNBY9oS51T0SniBxh8r
	w9I8J5DNXOLJsOz3d7xh5GNF8eZyK2R7Aqudp189suTNl6Q44QWnX/gx6ckyJvp6
	/23q6uvDy156otCnbJcqgVG05MOvYQKCyTFQLN2lfbgZPCcSOULwqz96tMyHiQiT
	ONgVchmh7KTq3MU1aGea9kcBPUroEIdYIU++be8X3hWkOmH0dlYmIfXTEs+mvLsq
	e1pgCsnP3E46qhr3w5CssWEqahEkhznw2xNLhoQeEra04iBupqcVEhGcfNI3XC8v
	e7k4iXIpdLjLGNZ2JxKE0KGwEAE4bWgM2Mg==
X-ME-Sender: <xms:qy3laKDXVGAcYKNGVBeqAa4AqRigljnb4kcxLl5zAdiJN5QZO2EfdQ>
    <xme:qy3laLhPiCiJceGpfwT9PohMzFcqjJVmk_9EJsv6tE2zxSh6TbfAETN-l3j1zA0WC
    PnK-x0L0tQfY5IzsRD6VjOZpsmqaNaDSgPmXIlNKTsP3Z-XVvnl>
X-ME-Received: <xmr:qy3laClPMzXicS2ofcHuUSQlJn_PAkjj4H0eF3nkonmAuVraHWed8-qUvrGyy-oQzSYNwref-mjY8LWESH_ax_VA2Idi0VgBkZ2S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qy3laHqY4yBn2sbwvUrXK1ApWPu4PFSn8RCkfwZrQF6LXNnUzdEMlQ>
    <xmx:qy3laLG9noXXhTCT7djoyQoI92QSSMhUCy8ZNfMN1cJI5LxrUpuXCQ>
    <xmx:qy3laDwYxi7FxDE0U2UFWlqKiXwyjjMG9cDbFVCaz-W9lrWCWFWgiw>
    <xmx:qy3laApNWcuNHo6aWcLDQUbXQXopjtLnaKeyINy_YbaahsoGEeZQfw>
    <xmx:qy3laMRivqG5FjAIE4bWNw78lJeUAqQsWW18QwThsrxNDh09StYbzLWM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 11:11:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 0/7] refs/reftable: add consistency checks
In-Reply-To: <CAOLa=ZRToJOUd_Devs54NfLCJuMZSBEwNcM8J0sbvy7x5Rb=PA@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 7 Oct 2025 01:47:14 -0700")
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
	<20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
	<xmqq5xcrof92.fsf@gitster.g>
	<CAOLa=ZRToJOUd_Devs54NfLCJuMZSBEwNcM8J0sbvy7x5Rb=PA@mail.gmail.com>
Date: Tue, 07 Oct 2025 08:11:37 -0700
Message-ID: <xmqqecren3va.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Peff pointed out a mistake in my test, where I create root refs instead
> of branches. This works without issues as we don't yet have reference
> level checks on reftables. While it is good as is, I do think it is
> confusing, so will send in a new version with a fix. Let's hold out for
> that and we can merge that to 'next'.

Yup, I saw that exchange on the "oops you missed refs/heads/!",
which I also missed.  Thanks, let me mark it to expect an update.
