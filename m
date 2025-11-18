Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE526ED37
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425720; cv=none; b=eGE8vAK+CPkgajaU88dOjfcbAsyoWblVMQ7Mx1qnQf18V1FCuLnogPaZlEIy20t1oD+2+c2zCvrJnGp9WDaVCYUsZCTF0Qh9PwoLNnPe7+U1391s6dAtYQY9ngAcF1hBfb7g34pcra6PQjnUDKyZX5qDkFF+/DXEYX+vfonltXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425720; c=relaxed/simple;
	bh=LpVkxaWWK7N5iPzV96ToOiocnEHVUy9QPFr/9em2KKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bvdXxm1c73z2maXN6ouWNY+m0VfLnPTx94XSrBA+nnUTn2/cXgDpWBWJJHYOYURENMKlP+xZjOj+IvP7/6mXQ4h9/5JNqM/BJfNK82uZvhYQJVsTS67wHVxXYeybxRv1BZNpJV52caK6TzDbQcG48NrhSBMFOdatndqEby1OXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ctpIYqDm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWvNbxVL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ctpIYqDm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWvNbxVL"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 972647A01E2;
	Mon, 17 Nov 2025 19:28:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 17 Nov 2025 19:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763425716; x=1763512116; bh=ki7HL3xweo
	nlM8UcR42R2WwhjM0TEl048dJE4oh8K4U=; b=ctpIYqDmVv99SSL+U7PNnvt5jj
	KB8uOGY2Y+r7897ltV3QfLUA6ElG/g9M4ABpa/J/KFoFbtmS1oZW5/GE/o7RxmZj
	TvHTOhNJkkC3HKUDekT/6SzMEbFx2ZRb4WGOJFXwZjDVvZLlpw/akzl9NSnAxkHy
	sVWFdBGaW6kNIQtPWCf9vAgX1ODczKgxPwK4afy6E1vohzE9HYId2cBg0Z2Ruz/G
	Xs9mHBOPOtJ+JkwGJCgWIpH4+fAwk5LwdXj+OAVst4u+ISiNpgJOFAwLj13lNqIC
	k0U9hmoYwj5ewo31VCGGnJ0IFEJsTy9nYCkK6OLLLeHm/WbEC7NfKurNrw9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763425716; x=1763512116; bh=ki7HL3xweonlM8UcR42R2WwhjM0TEl048dJ
	E4oh8K4U=; b=JWvNbxVLeMs+hug3OxbTzbrgkchdF+TJBNRISkJVrI1T6KO9F7s
	uZeh7aiLKdu+K1GeLBH6B8/yr6jZX00vRky80fDnfbQKeCzRGD1K1cl62Q1Bu2sX
	hCxvyAAhxC/QI4KLaI1TySOjGq/ongxlYovNgYww9ItoDC1ZsWMYezjee2mB/5E8
	JzS0ILacf9DPXpRctKBpIcoPhDTDqkL54rSCgsNRnPwuILlCyr+KBAmuOmlf92yw
	845wU+lFZBkjLtXAzDvWQMb7fwOIUcTL8ZAQ/uQiGQHVgZ1PnMMjHtabKd7HN7oP
	9DCwo+Wi7DhWxlSR74qeBobzM4PwXPsXJXQ==
X-ME-Sender: <xms:tL0baYfSivfA6rLStRms_ejlqFQ0ADodFFeYt4Z6AIdn2n68zesxuA>
    <xme:tL0baUMLnrqmQLTth7jBB0h287piXWdPRTz8vEwmYH4jFt-KngGOGX25lCg2AjOg4
    0d-pNoZnMeOxJdgGEocDlbKhuWFOx_bEOUt7M_C3_D6NUPbHTxa0N4>
X-ME-Received: <xmr:tL0baQKMaxeG6ruCa_DGxCq0VG5W3WUTzf-qgmo-r0MAVqYOlw1WTADrlcTNSoPOqgjSFV4u0TUKyg24DptDgarGsI21TMftLn0z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudelledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    guvghlihhlrghhfihusehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepshhtohhl
    vggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopeguvghlihhlrghhfihusehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tL0bacJmJEerDwhup5sCfaom9NNYJ8jFw3MplwlZJjGdUnOrcaPVFw>
    <xmx:tL0baS5dbXgbJajW1sbyf3HBLNJdnM5OX5BTZ6pfO9QF6M7UHs12og>
    <xmx:tL0baefgY4WnCiyTMyTwAVQ_oLg9OBAb80u6Du-rckr8DcVwPwLDJA>
    <xmx:tL0baVEhqLUpwjtCPooSzadthd_AoB5TOB1lW_9FtT4Bz8RokPd2Sg>
    <xmx:tL0baRYyC8OVNI5JJk-BjslfKBUoHcasU2RGWBIKqfB7vJDV8vlac3xO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 19:28:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Delilah Ashley Wu via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Delilah Ashley Wu <delilahwu@microsoft.com>,
  Derrick Stolee <stolee@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Subject: Re: [PATCH/RFC 0/4] config: read both home and xdg files for --global
In-Reply-To: <8e2b868d-8753-bbcd-840c-8eaefaa7cbd1@gmx.de> (Johannes
	Schindelin's message of "Mon, 17 Nov 2025 14:29:33 +0100 (CET)")
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
	<8e2b868d-8753-bbcd-840c-8eaefaa7cbd1@gmx.de>
Date: Mon, 17 Nov 2025 16:28:34 -0800
Message-ID: <xmqqtsysfakt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For the record, my "Reviewed-by:" still stands, if lack of reviews should
> be the reason why this patch series has not even entered the `seen`
> branch.

Thanks for pinging.

"Why is it not in 'next'" is a legitimate question.  I think that is
because the topic has no discussion on the list in the thread.

"Why is it in 'seen'" is a question with no answer.  As I often say,
'seen' is merely what I happened to have seen and found it promising
but is not ready for 'next', and people should not read anything
more into it.

I didn't look at it primarily because nobody, not even one on a
handful of experienced contributors whose opinions are well regarded
in the community on the CC: list, responded to the thread at all.
Before the message I am responding to, that is ;-)

I wanted to see how well people receive the motivation behind the
proposed change, as I vaguely recalled that not using both at the
same time was deliberate to help those who migrate from historical
location to XDG layout, but did not have time and energy to do the
digging myself to become knowledgeable again to give any comment
worth reading.
