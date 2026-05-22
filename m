Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFF3A901C
	for <git@vger.kernel.org>; Fri, 22 May 2026 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439771; cv=none; b=tF5bH2Ep2yKGDbIsHUGosvrmrZOavxURmDFM3CH+/0Sc1sAdqmXhvwx7iOlvvoNwvbcVMK3P15+W3fUc4yBlbZat364qiKavDXx0itpD9LCDrMWEEIC4TJMYxLd2IgNSlrutPW+Y8Lvr755T01KwRTRq3EXTi6gsNDZ1/6YQDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439771; c=relaxed/simple;
	bh=c9V4AbCySQzBAina8cqTsuVfGccGNSuYKf7amefW1zA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jh6ZImdWVt4GR00k3KwT12JAWNDJlcSeN6tEc+w4XI8o1477Ikf+xp79KdYiaufwJKK28jfONwwySqrOlkhpsBXvH2BxJ2olae6pVErthOmhkfJnHcC071aRKwdxy0xm65WFd+OHVKCdFT0xZJSFbsA0arfbxISuTveEzDtSNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BPfIA8hP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iftwoTd2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BPfIA8hP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iftwoTd2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 422DCEC011A;
	Fri, 22 May 2026 04:49:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 22 May 2026 04:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779439766; x=1779526166; bh=hf4eWEfB5/
	JOujwLvP450f4shaLItpYDrDh4BUJGq/U=; b=BPfIA8hPoCso/x32qAhAninuZ3
	gIfopd+KhyaurQzZ0036QN9tcR+fwW8pZCO8MUju0C1EsH2zFbGS0p3Lj+XSfYCR
	oEeCc6EIJegwBb2jarGvWXKW/JHk+ko0RZcD4NNJEHgtFRI366+CCo6q7jMSSwdX
	o94u+zcRLck4nKZH4gtO7bsmvUO5cO8oohAFQ4U/Q8Hs8TyHYEq4+DpzwTeGWD5+
	bJcAPJX7Iy6Dm+7Qj8ID7KZ/tNItKDVNhBQLtDBHikyprS0pdAS9AmUjXtutcLl/
	wKTYkNuns26nkLYeYsVlc65nE0mz73/IMxalUEY6sIlCx8SiaypG9+Ek4e0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779439766; x=1779526166; bh=hf4eWEfB5/JOujwLvP450f4shaLItpYDrDh
	4BUJGq/U=; b=iftwoTd29LG80WB/Gdrk7EUg0uKiTQjMFsTpq+n2VvTZQ3W2wYC
	vLLmIF3tRWl50xIvPX746bEMR5H9SnUJmaIkVC3/c7RvQ2jWyIr6f66CklQwAq+J
	WeNgKMaEQvqY9krlRSuOlyy9m/+PkaVQdYJmz6MNHEV6Inl9RG1h65IzQGu+amWi
	Am6+VDdIq5NJbNlA3atVy5EBbdQLVwCxjcShapjosy+egNDE4yjma7NE89V6OBj6
	mA5g4mRMHNDnLBcopFzEQ3BqX01puIy1ucIUDLUdCy7fEPH6Key+NAEEXw8FNAvU
	ggr5pkrapdq30e9w5pQerY30fwXS46zhEqg==
X-ME-Sender: <xms:lhgQar1TtR7AZkFoLJr45gcEY-DcRsCDnhXYJ7ybEeO-QEjshA5aYg>
    <xme:lhgQahE223fy7CWP9ZpXISm0eq74FdmS3M4YpYEdRiWqXcpg1aFJbSHdhYek6xBMX
    x92XUFeFEdLohNjxPAEKTdeFlJlXIA9L-j-fvymP2VeLwNTqZ_J>
X-ME-Received: <xmr:lhgQag5Zf_7FE_2PKLixla5MPJrOsW07_qF6-c-0QZyRetvZ6s1yFW9fHqfioqfrF3mG1fIaUG-Dv1PGeR1HSvZ4_Lzg4areqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehivhgrnhgsrghluhhtrgdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lhgQavuMQ9w4BlMq9RwoRN-xu_CsfPDJmHvXwj9cpKSwik7DHsH-pA>
    <xmx:lhgQap6-EciQEzvsEbHg3ODll2MevCKi6lO_jThnZsbikM0MdE0bCg>
    <xmx:lhgQaiVrDi3cDpUoG_7DKMhLEUYyygYyCA_9Odr8okXe8Ftul1_3bw>
    <xmx:lhgQaj_wbYeK0SEZhhIOsXuHvkdcEDRt_-ZtjXpgJaRXs3Xl45GDFw>
    <xmx:lhgQasYcmVK3IIjfu5pYXBHY4G6E9mT5y4CoB2_kNYmiAJ-5wAkPBgaN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 04:49:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ivan Baluta via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ivan Baluta <ivanbaluta.dev@gmail.com>
Subject: Re: [PATCH] doc: clarify push.default=simple in triangular workflows
In-Reply-To: <pull.2115.git.1779433093971.gitgitgadget@gmail.com> (Ivan Baluta
	via GitGitGadget's message of "Fri, 22 May 2026 06:58:13 +0000")
References: <pull.2115.git.1779433093971.gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 17:49:24 +0900
Message-ID: <xmqq8q9bu8vf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ivan Baluta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ivanbaluta <ivanbaluta.dev@gmail.com>

Just noticing, but don't you want to spell your name just like you
spell it in your e-mails?  I.e., 

    From: Ivan Baluta <ivanbaluta.dev@gmail.com>

Use the same name for your sign-off below.

> The documentation for 'simple' push mode currently focuses on the
> centralized workflow. However, the implementation in builtin/push.c
> falls back to 'current' behavior when pushing to a remote different
> from the upstream (a triangular workflow).

It is not just implementation, but that is how it was designed to
do.

Whether centralized or triangular, "simple" works as a restricted
form as "current", with the same restriction.  That is, both
"current" and "simple" push out only the current branch to a single
destination that is configured, and "simple" insists that the
destination has the same name as the local branch.

So I am not sure if this three-line patch adds much value.

I agree that it _is_ confusing that the current text singles out the
centralized workflow when describing "simple".  But the remedy may
not be to add "what happens in triangular, then?", but it may be to
clarify that the need to configure the push destination whether your
push destination is the same as or different from your upstream, no?

Something along this line, perhaps?

    `simple`;;
    push the current branch with the same name on the remote.
    +
    This mode requires that the remote repository to be pushed to is
    known.  When pushing back to the same remote you pull from, the
    current branch must also have an upstream tracking branch with the
    same name.
    +
    This mode is the default since Git 2.0, and is the safest option
    suited for beginners.

That way, the description would be more self standing and the
readers hopefully do not have to refer to another mode (`current`)
to understand what happens, no?
