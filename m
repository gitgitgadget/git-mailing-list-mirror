Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E7B189F43
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004482; cv=none; b=JWFVAjFMdHi4xAhnxWq2e0UgORo3qRgYpvOQZsCTYjgqMp1fLlhpBJhZFDJJrPHE4DnnveRaF6+Hpihl+KBX92z1iSOKWbyFZ2kwzUGrjcASUoBOWqKimkjrQh3ITb3kd34O9cbyNkdDQikOPARxyyoeMfqNv6R/JKKijHjDegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004482; c=relaxed/simple;
	bh=rS/KYlzYvAG7BlW0dFbbcK243lkpV4XlWR/HRqIt6aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WviPwLjoOCW7Oe0gEiJb1snKCZ5BtCRwPtjY5aOM08tGGGIPGzAb3KT5uScqGhOrw/XR+AWyds9GpLcikr9wnl+dSYXvzchFozzGEB2938u4u68dnC6JkJ9OfH1SKROp20ubSLFBQKCUhvV3Z5peFwDGNLD9RLJA/XHXNdHDEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y3YVyrPK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QuBTTgDg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y3YVyrPK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuBTTgDg"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 34F5AEC02DA;
	Thu,  4 Sep 2025 12:47:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 04 Sep 2025 12:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757004479; x=1757090879; bh=AFHsQ4q159
	D+Amr63cDrrXg5eaPNShnfjbvyFDSiLKU=; b=Y3YVyrPK5A3MwFJ4ib0Z+bGeyx
	rPDKoAgQimMYDcMJWS8R/GlEEKVAeUSfF7kRrQzNr2p6ae6BO/DCaKsBKLQ5lT3K
	oUUjToMIxDkV3YunOo8lvptG9ZzYseyETyscws+ywSz8eXM9C9ykGJ3h3aHzeeD3
	A7NyET0RdMxvyGuewxGg1sLNW0JatXaygKNsxLuUrrSlVVVhX4l5MznLyVPu2JHk
	XFDtNKxadm4M4Mn+Iohd0zQY9zOuvIg1xlrZtJmL+xO8hCmO6PVvvuyQ9C3JBmFl
	oSe/UH08w8DFqKzJ+Fp10Xu+HW4XM8at5wcYmjbj1ikY1ArY7Xm4TEchO5Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757004479; x=1757090879; bh=AFHsQ4q159D+Amr63cDrrXg5eaPNShnfjbv
	yFDSiLKU=; b=QuBTTgDgWHJ0a2gIingmzHRE4iHJU6DWC4JuGQYjNJPbip+cQpV
	zONKTLjOUx4xTCwFSmpVKH2qvB129pYvQUegZVMivsked956WsW6jrNjODs/1xc2
	PXDxVH/9hhzUXIHZCirZ3J0aNR+9qpHgsWxuglmLBZR4YqVOe0pYb3rtvAFbKbnG
	U6UFbC7rfLaWKXfO1Dlcp10nf/cB3HfpVShAU2fVhy1Hq8kJAwOLJ5qfiuqz6f5S
	Awd+ljyD6z0t9VPc5GsYyvfFDa9Ofe/QXwqpuA/kvn5Q3CcF4Z/JMqXt2vedvRtU
	Mc7TawGAtr/TU3EP2yv9bY2Re3Amdw9079A==
X-ME-Sender: <xms:vsK5aOf8koalp3vsz5i8YiywELKtkYNs636qOU1I4wAa4PxN8Wo_Hg>
    <xme:vsK5aDvL03W7sDg-vG5B9SaAztrIuJTMrJiHqRxCnT-BUiq9IKK0hlg95rvnqeerg
    ft-GmA3Ldct-M2svQ>
X-ME-Received: <xmr:vsK5aF-0yX3NF1wXzgOg6_apuTtQMEetZJUgSj_6NzdOvmVjt2L1IbMUwbapXZUBlRqdY-MHhSQiFtl2sLJcenslZis48yBJOuljUUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeihedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepughilhihrghnrdhprghlrghuiihovhesrggvghgvvgdrohhrghdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vsK5aG3jmKW4Mr2X2hQpG3cgL7PTYfPjYTE0FPvpOvhgT5Z-kZ5cJQ>
    <xmx:vsK5aCAd5RA8VgqQVhhosv8Dacti9MuMlrF7aBNV9S1MUySBMue9QQ>
    <xmx:vsK5aKducfkZxNl7Rt7cbfqfA3a2Mb81MKWR-iKoWCdP578jj0X3QQ>
    <xmx:vsK5aH5oG-qjuAwzn0I6B6tsy3no6mOVN5-PT33-107hklU7GQQjzw>
    <xmx:v8K5aLjg7QCf5sOAroMGG8Rc-S6dChBcPlWF6j9ZK6GoTMg4nIIj14Xa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 12:47:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?=
 <dilyan.palauzov@aegee.org>,  git <git@vger.kernel.org>
Subject: Re: Doing blobless clone by default; switching between blobless,
 treeless and full clones by a command
In-Reply-To: <7713256d-e258-4356-b303-128fdb417972@gmail.com> (Derrick
	Stolee's message of "Thu, 4 Sep 2025 08:19:59 -0400")
References: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
	<2ebdff4d-8adf-45d9-8cb5-6d7ee39f218d@app.fastmail.com>
	<7713256d-e258-4356-b303-128fdb417972@gmail.com>
Date: Thu, 04 Sep 2025 09:47:57 -0700
Message-ID: <xmqqikhy9nb6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> But there was always the possibility that the feedback from having
> 'scalar clone' available could lead to a future builtin of the form
> 'git big-clone' that adds similar optimizations for large repos. (My
> opinion is that 'scalar clone' _is_ this 'git big-clone' but maybe it
> is not discoverable enough.)

A separate command like "bit-clone" would not be discoverable
enough, either.  When a new feature matures in the playground, it
would be a welcome change for "git clone" to borrow it as a new
option, or even better yet, automatically enable it depending on the
size of the thing, with end-user consent.

Thanks.
