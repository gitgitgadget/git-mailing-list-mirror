Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136C24E4C0
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158113; cv=none; b=to3k1myXB2siNokox1auYkjrkmgSH19hX9+nB0SA2VLj8WKNuvRkdTlk5sakCHGfooWI8zfwGFffx5UE/hlj3hP3arzJTENC2FsHsrWjMx5RJoh/qFsR2hn9WK6Uxr438RccBR+aVDWMedrIFH0W7I+Q274E2Mk0TofmsGRFxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158113; c=relaxed/simple;
	bh=6mJgmr3mbugpLsQvol9tXcfETGi6WoXj5/PPiZXFioI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a3QH9pMw5FAOC2YbQ30RGhzXWG79N0OW1HCHnNvX2j9ZYNGpsXsvQnDEKd5ceXnojh5EjXXaIukJymslwTCQMXmfUgKERZhgmaprRqpM04m0Kjnu9YOafCEAD4vGKGCadbc8f+rWp3ldVoEka+49XaerdsguwZIWKXrKXQz8Wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EQe1JxSQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3a1PH420; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EQe1JxSQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3a1PH420"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E29CC1140143;
	Fri, 21 Feb 2025 12:15:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 21 Feb 2025 12:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740158109; x=1740244509; bh=6mJgmr3mbu
	gpLsQvol9tXcfETGi6WoXj5/PPiZXFioI=; b=EQe1JxSQKg/e+Y1fKpgJhO4ohs
	bBQGosq6brJprEApnGGR5Q6aGw6ol8hNSRRCWevWSKYBBHi1ySEr3FUuprPmgDdX
	dux0cWsfnwuKVo3twkCIJSxwN6b+QW0pe4FlEF/cRxopPOCdk1BrTKwiE9Q9iVCS
	7vD07/JwEvXNoggqe9DIq1icYuD2Ws6PQaTw9BRnoaV9fA1XgbQT9nDPU7nOYuii
	jOEAPd38ZKOve8zZCgxhbNMe0GOYg/1tXmVoxaM9brYCT/baePtzRG8bBzbMYz92
	0jNs4RraWjSRZRJAgFnBLQJ2aZb3xaRySGF2EDZ3FOH12kaKQpJNWhbK57EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740158109; x=1740244509; bh=6mJgmr3mbugpLsQvol9tXcfETGi6WoXj5/P
	PiZXFioI=; b=3a1PH420J9hnbkWh2+EPIHtmYo8SWLx94K5AE6lhKLUs9SRysog
	CPUSQxz3O2fnf/waFr6Tn6avaoTz9P4JFBo0KZNs/WnaEgEQE3Se05NDFKUhSrDd
	LkAG0S3k49FvYrPG/d35I59MCwbjAhS6twJkfLfXcB0GRmpwJRIy9avPYR2DeL3B
	fy3pj23e0ZKRkvSeYRuJdnSxdm9m0QOoA2wj86Y2o9acQbDg5AZ4KvFszkX2ahag
	8mHqqXcfCQiX7xQ5y6AHj42QcFKheTBUAaA++lhOZaVGFIelynTG03gGPYJjnRfa
	PdKs915923NkMWHTqQXW1T4mB/q8bJ6VD/w==
X-ME-Sender: <xms:nbS4Z_Mxd7iwg8FCpbaJ6E9ikcTUOO_XPhkN-JNPxwoq0924ed2N6Q>
    <xme:nbS4Z5-ymq_ut1WfVPs7CyM1n0zJB7RISxOaJ6oSrlShb_-5SlZs1wlOPDvNLAL41
    6owVOmpw6W92QY2wQ>
X-ME-Received: <xmr:nbS4Z-Q_TUVFskrXXeOszcR-gflxe7ig4ARgKBCgdKzgKspko-524AZsMSYoFVIrJK2Q9fkigv0kV_ykgP61oNsiXi0nAIqcZsrjcrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:nbS4Zzt4XszOFcBwrx5Qf01ml5k1iXkaMWDQc4Vsyz8fYbpTvbvnLA>
    <xmx:nbS4Z3f35SCEcVj3YUEmeq_gUB0mPjeUFYIz6Yp6tgdmk_vqt2wkOw>
    <xmx:nbS4Z_3j2XKzuhzJZQaCWAOm8duwTboAADO7DX4zrZ3pWtOI9MiGzA>
    <xmx:nbS4Zz_ydK_vfH8C4C4gN0FhmkIiXMcI-IjqXtVqy-FAwS_vJo2WXA>
    <xmx:nbS4Z2zpG946JqK0XEqdfsrzqIYdskBKMXmOjwr4sNkgwNT-Z2oIdik6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 12:15:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Calvin Wan
 <calvinwan@google.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][RFC PATCH] show-branch: use commit-slab for flag storage
In-Reply-To: <20250221063257.GA568823@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 21 Feb 2025 01:32:57 -0500")
References: <20250217055049.9217-1-meetsoni3017@gmail.com>
	<xmqqseobksfe.fsf@gitster.g>
	<20250221063257.GA568823@coredump.intra.peff.net>
Date: Fri, 21 Feb 2025 09:15:07 -0800
Message-ID: <xmqqy0xzb4o4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Yeah. I did not see the word "stride" anywhere in your email, so I
> wanted to provide a further hint: the commit-slab "_with_stride()"
> variant is meant to handle this kind of arbitrary-sized data. This was
> part of the original commit-slab implementation in a84b794ad0
> (commit-slab: introduce a macro to define a slab for new type,
> 2013-04-13), but AFAIK we've never actually used it in practice. See
> that commit for some examples.

Wow, after reading the log message of that commit, I realize that we
already were considering that one-bit-per-ref needs dynamic scaling
and folks must have been thinking hard about it (I do not think the
author of the commit alone thought it---it must have been a group
effort on the list, which the log message merely explains the motivation
behind the design).

Thanks for a pointer ;-)
