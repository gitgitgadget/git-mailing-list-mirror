Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72355347BCA
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969236; cv=none; b=hG/MdKWl91ekd9m+nxN0z+3c+vNfwpP6gnivJKZvXqv3eAeDAmkQnrfxBU1iAEMgpH1Py6mzoY+9k9Aa1hGs6JlzUKAkJheSeQNdRk9PS0HXBfY4mfP4i03le+76sbMBQIQNbD5FfgWYRbYrYskbxhB4Owj6265jVHgMpwY3IR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969236; c=relaxed/simple;
	bh=n4MqKGtPwPyte4/TIJNUKOSwh9ZGt1gLiGdxEoL3JuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PS0T+hzDpdj+egDZJTqy204zSRVFJ6NaR0xMyv7IaIYhLwMn8SQ2RTBU4y+aOj5YFN1YJDk7NxkqCRUqnmjkK9G2DkYBD14khLRg1XlVetvIvsnydHzdRdhV515f5o32aGguYM+8Dqt84/X6JKTL4B/6GFccDwM+NVR2bR79ANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MWr9IRVG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qrFiXYvT; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MWr9IRVG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qrFiXYvT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 879111D0018E;
	Wed, 12 Nov 2025 12:40:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 12:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762969233; x=1763055633; bh=PVhjDdgU/i
	pmudpHk4DbAx7mjB69CxFF5VMEmchF2xk=; b=MWr9IRVGf3r8OsgkPVKapRsez6
	LLR2fJQlC3L2P2p8sR3igNIsFy2BzbfD4pyx5X86Sdwivb9R7VqEI2AIa0ikGvlH
	9MkfMi+0QGqu671ZTLXfjBgy+CFQIKgmcbtm3OEaJ9lEmH0rFvgKRf3WPPGLuGv5
	I91nNk0BFbTQKSM/1b/HuqW7RM+SE6eN5dpFAUkzHXa6TBpMIsbUj4j6Vy+fYAr9
	V0wZWi3/JhecgvgHP+CxntA64VeiV0+zuwgzZ4iFdtxTjR+Mbj244Wth4qEN7BFm
	HZXuT8P93HNg1tIT27iJdn7sAmDlUh8EGtMlHOHg9lnxzCxyB992le+gqCYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762969233; x=1763055633; bh=PVhjDdgU/ipmudpHk4DbAx7mjB69CxFF5VM
	EmchF2xk=; b=qrFiXYvTqjWpWjBtwYV3oU2uk6jJVQeJJm5/uptuvEi8GtczyYb
	vpscG5/YxfzoiE4ZgYWjHRCplJZBQ3QV+zF/CXKLjPhA2CzEuve+aNs8PPYO6pRt
	h/RGncGZwwTLFXjiMt8hEjY4Ti4dLg3uVbgJnzLsysWrtrc2B5YkCvubXcAb07BZ
	rf3drEI+v+RmCp64UaKPbo/Q9/aKUTLtPRkdrrDOwdnJADxf1ZAl5G+AcOWpacpj
	zOk6uR5o/4MIVSA2x+Izc++qToJXhrzUd+EDaSsTR4XzLI6jPW0v0Om+WqFKN7Ei
	x+lu35RGhfy/D9NRP5Oh7i3Nbx9rgbuVgjQ==
X-ME-Sender: <xms:kMYUaZam79LAnAgdTPZ9EaEkJPqO2mKYLz3glwFA4wH1zFy6DByJQA>
    <xme:kMYUaXSYKeH6qd-C0eMpgt0KZkwG633ZhvEOJcv6WQVVOfq5x82sYVa2vz0XLeceK
    DejJuCOIH7Q8CDAyXMb8xmW6KkucX44DgUaBOFqY_B1jZ0bogy1mg>
X-ME-Received: <xmr:kMYUaUS0sAOOQ6x0n9oA_ck9SWYUfe3GvWqCZbvHBhYGo6DoO9Da1GVHd-oAGKKI43NY3AgCT65SYqBAk24R3QLDRoTieHFR2h6->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsvghnshhtrghvsehmihhgghhordhiohdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kMYUaTQDgwALe8dV4_9Z_GsESb3IkJl01UvSMLG3DVuhwBw6izqdXQ>
    <xmx:kMYUaR7Sri19dy7-SiFea6YgR9ENA1mAvJ9rsNFVeOiKBw_jQdTY9w>
    <xmx:kMYUaX3E2j-mh6PeMloRS0yOf7vDT5yOeWDJOY57U5TZ4zBh3Zw4rg>
    <xmx:kMYUaUA_I5zpsF3TpbNhqWgwuSH4MxbjZPwwT_4A0VkK3_tfCqh74Q>
    <xmx:kcYUabyYUUp3IG2gB27NSsOZYKibs97PIAXIpj1Y7UGV3D03DfIhNnc4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 12:40:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Ben Stav
 <benstav@miggo.io>
Subject: Re: [PATCH] attr: avoid recursion when expanding attribute macros
In-Reply-To: <aRQvyvMq61syGT7_@pks.im> (Patrick Steinhardt's message of "Wed,
	12 Nov 2025 07:57:14 +0100")
References: <20251111223647.GA4055973@coredump.intra.peff.net>
	<aRQvyvMq61syGT7_@pks.im>
Date: Wed, 12 Nov 2025 09:40:31 -0800
Message-ID: <xmqqjyzvqhdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> That's fair, and as you demonstrate it's easy enough to turn recursion
> into iteration. But it doesn't really solve the main problem: given
> malicious input we'd now still crash eventually, even though we
> ...
> So the evil garbage would continue to be a nuisance for users who want
> to clone such a repository, but now it's going to be more of a nuisance
> for hosting sites given that it could lead to out-of-memory situations.

That assumes there are users who want to clone such a repository
with evil garbage in it, doesn't it?  I am not sure how likely there
exist such people, and even less sure if we want to actively support
such users or discourage them.

I like the conversion from recursion to iteraiton as a general
principle, but somehow I do not think this particular one is an
issue that warrants more than minimum effort on it.

I also wonder how common the use of attribute macros (other than the
built-in ones) are.  Are folks working at hosting sites have easy
access to public data (i.e., super "git grep" that lets them sample
some random subset among many public repositories and work on them)?

Thanks.
