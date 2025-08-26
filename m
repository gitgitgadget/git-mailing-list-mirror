Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64731F872D
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220322; cv=none; b=k+hXHZ36gQptrZZ42RkvLJ5daeWt7ouw20VtZvsmhE5Dg8Ircuzit6FyiDKJ5tqWwUamF4o4PCGQwkokY1UReVaQi/23cnCCebF4fBWzB/LLH3u+UnctwUZRkK7JirebiRNzSJRPz2AkLDPILL6oPc/3EyOJr6000M0k6kReOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220322; c=relaxed/simple;
	bh=GV+68MKD2dDzr5Mx62nbwcDH7iZAYhK3eKbdA7vMesY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GtiHh6btgNvMSKWcez7J8AL+0Nxu2yS65u0dWsQOIYJGUtA6fFAGVH3k0Ic2t2UiSsUunK9wf0Qpnooc7dd3zsHSKBZbWt0hHwRTC/Yclae2MwIzJqgKAA9EHn7Nv3qzMEVf0f80fd/QsabgrsLT21chIxQmQXUoLTI7gDbgOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q8cbcxLb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fXYbvmDA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q8cbcxLb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fXYbvmDA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 95FCBEC0418;
	Tue, 26 Aug 2025 10:58:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 26 Aug 2025 10:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756220317; x=1756306717; bh=A/+Dk4lb4M
	AASnfOPUkDpjG6pFJCGrob97Yia3ug8So=; b=Q8cbcxLbUMB2wXAv346yAw2sjN
	G5t2L7JFN2IKPSJXJ0B15TVZiTphbHcVs5rjfs9Mw1QMlx1s9Tu9Gl8d1vPOvjnM
	cesdOnUKe307m2wOMVrNhXtXx70LSi0GHrsxKjaaDTUXIClpKKbXmefjMdeCXRK+
	IyppZpPVkujpwVxDCAQmxqxyaa3+59I6DV5LSoW4+g9cNziIgDE1G/8D55irxeKt
	3zHKz4edylA/Mp3IWZIz5WgaaVBjzqoDDOma7YhPO95/1VEQU9REAns/lllMuArJ
	5RHzDl4zEu66TiCT7a7jVHneAfUZsB2FaZ/Sny/n2WAhSuQVH0uuPDe5UZ4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756220317; x=1756306717; bh=A/+Dk4lb4MAASnfOPUkDpjG6pFJCGrob97Y
	ia3ug8So=; b=fXYbvmDAJa1phT/TTPVhxVFqK6OZ0VbR6BtqlNKkkC5zg6bQNRE
	b1VXhD7OohShnMe4ToxEuj62Cdb0aPjGPWsT1UXsNu0KiwpSY3ggQN7Wkb6viLRD
	wP293SIljplNsONG4x1p9CwegitB29i5UaUS5rwE+31QJQhkhZBObXhNRfKiWYYC
	CaqMV/CvzgSGTOIFBuN+8V/cPhxOCL0RCK5f9oZiqyAf8Xad+09QS1Q7L7tgep3w
	K/oeAZALZq8qSQVedvi8tg3p8RPoBuacMNymHCDXwssUj8Bndai2gp9P9/OTA1rw
	Ak8jC/9QcuWLKUlo7I+dBMelYZLj/zx1DCQ==
X-ME-Sender: <xms:ncutaD8ErcdfsFKDo3TCMB6IZiAETlV9YGdBm0PNTrIe9ZBHnkx4ZQ>
    <xme:ncutaLP7oaVQbD3judxGOuTn0KdUfXABmUjTu1wQ9jQYQPXusyu5PS7qpu7KONkwD
    DZDI1h5jWHdVC54pg>
X-ME-Received: <xmr:ncutaHcnwNZJFgfDYxCSuYbCKOlegrOFgGC6w6qWyfGFczlY1hlpw8MYOata1NlfPYzT6MrYNOMkj4MnBSnxX2sqvyg-8-iojuLwiZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ncutaKV0D9wjdh9NVssKCUb46S0qqPubHh3MtMmkN99CBeR8Xj9WKQ>
    <xmx:ncutaPhBeTeAav9Pn01hptNDLytIAnH_HNAwZ40l38rrQoapI2w5bw>
    <xmx:ncutaJ8uv8ZygRNja_v_oF3BP4UM-YnCC6xG_g6pwaB0rldJEKdD1g>
    <xmx:ncutaBb1TjefAGeJjzC_0TTGNTfPUYdCe1jaiUNh7hbIz-aneAV54A>
    <xmx:ncutaHL17S8gq7hDAh0A56hcv1xpLGiBSxsl98gicFh3ogeGXFfjNMTf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 10:58:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/4] t5510: prefer "git -C" to subshell for
 followRemoteHEAD tests
In-Reply-To: <20250826034434.GB388997@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 25 Aug 2025 23:44:34 -0400")
References: <20250819192004.GA1058857@coredump.intra.peff.net>
	<20250819192716.GC1059295@coredump.intra.peff.net>
	<aKtq47vmCrUZCUCF@szeder.dev> <xmqqfrdftnet.fsf@gitster.g>
	<20250826034434.GB388997@coredump.intra.peff.net>
Date: Tue, 26 Aug 2025 07:58:35 -0700
Message-ID: <xmqq7byqm8o4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Unfortunately I tend to agree.  A few downsides I find a bit
>> problematic in the subshell solution are
>> [...]
>
> OK, I am happy to drop that patch (3/4). The resulting change to the
> final patch to match style would be:
> ...
> But both patches are already in 'next'. How do you want to proceed? I
> can prepare a patch on top converting back to sub-shells. Or if we are
> going to do the post-release rewind of next, that is an opportunity to
> fix things cleanly. Or we could leave it as-is if it is not worth the
> bother at this point.

The last one ;-).  This is the kind of preference that falls into
"once the code is written in one way, it is not worth the patch
noise to rewrite it in the other way" category.
