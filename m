Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52CD29B78B
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737999; cv=none; b=rxChEoKaTd93/9stD95E8gr00ZcmmDCqOrBxJ5hBVQBMmJnmNaqlNTLgNioq0JxEplDTrkhlT5LnFDoay9tCc9/0I7ebKpXzhm6fsCMxArX6PfXA9sfL5TwD6isf/UFuTEea4sWfS+VFpZhA6GnCcS5qoTYN4twjCI1j8OKfkkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737999; c=relaxed/simple;
	bh=DD2soJAVuKDF+jYx3YcO1rrqzix2etuYgPY+aHgZ4Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NEfSFxODX35PnrrAKvp7WRML+czcRQllNu1+p9fA6FR4rYu2ez9AId5sSnPUIbmz6s0FBn5PlVzjLKuOxllwMyqSOkR2Fg8Qdc2YMMaovmKUQlApnpf+mgVskJRvX2q7KmzjNYIH6kSg9UPlmTKwJNdtqCb5YkOVYJTR3oCP8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TRN1oATY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VpMJ4wAP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TRN1oATY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VpMJ4wAP"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 324891400195;
	Thu,  5 Mar 2026 14:13:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 05 Mar 2026 14:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772737997; x=1772824397; bh=c+cB4jDPTy
	rO5IU3fk3dSrJt8+eE21xz1kT1Dd7VBWw=; b=TRN1oATYnYnbmTqQsxq2sQnjfw
	nx5Mq4rfnBH9WwncohU9rMpi8OoomuAnTRmEZ/xCjWbqhyp1XMTQvP++IKDpUQWM
	f3EtD2Z0gZ8njaKwO6NFcmaW3YLzuIvlDFdY4bOnwZctoQrPWuqMEpqWx5WKCz02
	cnYdekQw0CkqRMx4C3IBG7vAoPcOXQGXKHki4i89CrQxrB8MwJDu5RLJDYnMtKfL
	voQApR6OkA0w5EZkRhYVXMkHo6dTlkQ0TiBligLXbHUcDQMPXjcZCqHhttQweBYZ
	RIIa23bcomppJV3cW70FJLA/kWdUCAEGexvIkfahw6ZSD7wGCNhQYhJmjUDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772737997; x=1772824397; bh=c+cB4jDPTyrO5IU3fk3dSrJt8+eE21xz1kT
	1Dd7VBWw=; b=VpMJ4wAP08yrHl0ZGg9YOfXRze79+T70r9wRwsnGGNgxOP+V5in
	IMnVvlBhnJXdWF7MARA1vFHkprXTQNd49wuTZSC0y7XNrlMSKCGSwBu3WF8imWbf
	RTOVm23z0L3J98ZVXK+Jy9sQ0nPfMi7sOetBuD63f7SaQNg14u7REN5mRhfeEqjp
	kfa7XcTE6W91Zxi8mJPWjGp0aPpb5B5CJH4mlzUrPaMhuzUvmBz8YqzGjbQoXFDa
	APNx2LsABExhcdQU60rO8RHEJOJrNYKuUbuXFUrPayY/nFdBnyrCdEoWbBnPxbGz
	WYS5o/ONeizocG2H8MfJeZrUfsrtfoyCyZQ==
X-ME-Sender: <xms:zNWpaSfPvnBI30uRBn7RQMevUhtxytTY9T7a1hw5bqy9ctMjc3SsNg>
    <xme:zNWpaTP-fZxeTnr0cfEk3DaDvDFfrUczpq3cjutVrzMTo0LF0DvxTq3EoWux0bWgf
    3cR0-6wZ8k0hT_574JDJhyaN4prW6W6t-cJXnHSC6fYwILG_-k4mSg>
X-ME-Received: <xmr:zNWpaYgb9dL7w01wi7B9_dpI0tUy8gRprh_VNuLTQT1fEr7E-Xeh2FHNsfYWrDjy1lM0n6Z_clo2Xr7We5Kp-_MrLndvZmshDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfhhrrghntggvshgtohhprghprghrrghtthhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zdWpae32mDOfXNRCRjdvuwAn_cPdCT5YBn3rr1ihLQkMat059gHnyQ>
    <xmx:zdWpaahGtzuMD6S4y-H1SlsEYPSEWaz5ZPcIbAcCtWMzUvsthlYAfQ>
    <xmx:zdWpaWdT-jebaemKZ5VKjfiCCvqS6zTZXesdbHPfLRBwW-_VaEbWjQ>
    <xmx:zdWpaVkgY3nEAjZSLYLSVu4EspZBqCi0PTe8pt6nqm-X3vfDZ7dm7A>
    <xmx:zdWpaYSJL1YIE07_D98ZshT-tCvVzsNP26WWxVZmhjlGAKRELc6w1KgZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 14:13:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Francesco Paparatto <francescopaparatto@gmail.com>
Cc: sunshine@sunshineco.com,  git@vger.kernel.org
Subject: Re: [PATCH v2] t3310: avoid hiding failures from rev-parse in
 command substitutions
In-Reply-To: <20260305090602.22436-1-francescopaparatto@gmail.com> (Francesco
	Paparatto's message of "Thu, 5 Mar 2026 10:06:02 +0100")
References: <CAPig+cTHyB2sbBOELPb2=B5sU69OzSPU0JVn0p=2qMp=0=8vEg@mail.gmail.com>
	<20260305090602.22436-1-francescopaparatto@gmail.com>
Date: Thu, 05 Mar 2026 11:13:15 -0800
Message-ID: <xmqq5x7a3x9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Francesco Paparatto <francescopaparatto@gmail.com> writes:

> Running `git` commands inside command substitutions like
>
> 	test "$(git rev-parse A)" = "$(git rev-parse B)"
>
> can hide failures from the `git` invocations and provide little
> diagnostic information when `test` fails.
>
> Use `test_cmp` when comparing against a stored expected value so
> mismatches show both expected and actual output. Use `test_cmp_rev`
> when comparing two revisions. These helpers produce clearer failure
> output, making it easier to understand what went wrong.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>

Hmph, did I suggest this?  I know Eric had comments on a previous
round, and the improvements in this patch seems to be influenced a
lot stronger by his input than whatever I may have said.

> Signed-off-by: Francesco Paparatto <francescopaparatto@gmail.com>
> ---
>  t/t3310-notes-merge-manual-resolve.sh | 60 ++++++++++++---------------
>  1 file changed, 27 insertions(+), 33 deletions(-)
>
> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
> index 92a5951331..64c0a753ff 100755

On top of what commit is this patch designed to apply?

Thanks.
