Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2728C5B1
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671728; cv=none; b=P057KnTZqm+SCosNzCcRehhG4b9CexH/7UxWcMJNP0fGYNOzGORGR3tA2oygLm+RAH2Bt7MchshGU8oQHOTWUS5HEYm5/SbbkNw9pPqoChbixrSU2pM1yAyjMJlUkIycQdrDyGHNd0uFd9K3L88PLy23ItUiMubSLTYqGGH2N9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671728; c=relaxed/simple;
	bh=IGDd+jmh1EFNk/HMQB64Q9d0EEcLbnSYm3m3lxoXC0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJLISjRpxEIbwWMhd+kwFWwqDVJwCHHuOwQyFYExaPfnk8/y5uLWNcHD76vx9yMKez2YV5RHZQDOZrGxv8/Asrwphhs5Oyv+c75Q+zknP6ZcHywP1IVTmMHPMPjWUFxLALZWAM48gItXxZEBNkP8sqSPV6Q44qGlLesHkzK92s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IsNI2BAY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IrC0XMpy; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IsNI2BAY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IrC0XMpy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8B717A0050;
	Tue, 28 Oct 2025 13:15:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 13:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761671725; x=1761758125; bh=WB0mLGKSpu
	WpVwCV0ztMLokUkFSH6V7DcobNjkxok/w=; b=IsNI2BAYLxlp7XQoyM6qrX8Ovv
	yyIIP2HKDaObd4dT2/6ZlaUioRT4jZxBcvPcqykFCSyRhyvW1Fx/y9dZMO5exwge
	9w72DuuFkSIql6RjFAdfEJorhbn8DHSks4+Qc82eFApWQqY3oIGvGQc26ObkEGZ+
	sjlvJlAJJmYNfJPsg3T2b/sxQrsdBnIqyW0qD8SPDdmsPr4gQANf0CCDsv7+Rktb
	COzc6jVj7V/PXzKSNT9sDNpOl4vPfaT1oUbg8tRE+wozAMV5rVmjcbU2LB1W9rZU
	2eDdhEsQE/FqUsyyQHkuaTjyEm+gP2pkoTUxAK0+ytlE44vEncKJpUX+Zalg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761671725; x=1761758125; bh=WB0mLGKSpuWpVwCV0ztMLokUkFSH6V7Dcob
	Njkxok/w=; b=IrC0XMpyN0XwpfpP9zSdpEuiQnmA9qudZgC2NQw8qztb1qtynfE
	GPLB5NdhFS7mK55rYs2RogPRtXCK/FQ1UXsSuyYEBlvhpUD9/YRreL67h2LR1L6d
	Ds6GUXrLOsu5/ZEURv8XSXmFDVg4uqHkZQjtN6sqWtyNLMQExOE3dyn7ezw9qY6H
	+ZFZAYd732+jyIGBoGKhKyIA8Ad11vEbMeGS7OALbujwmDHlOqR0+BXR9IvfJ2OV
	BovyIV/Qx3VkULZMHkH/XRvQBxvH8cOFl78IM5ZdhixdCXJNaPNWLmSNuSbVizMI
	FCuzjPTsKIahbh/35Xyegq51/ca9UcCu2MQ==
X-ME-Sender: <xms:LPoAac0UAnqQO-81Ml7zIJKNHBu8480Bp5iYCtadARLK9vMlllmjig>
    <xme:LPoAaaxKALws7_CDiFGcu_79yPULzJ_ML_IjYEKdhDtV6OHoDatAvtPg9hdZOdBo_
    yGnudBXuskmigoLJoYe05LEk8B8JNB8Ug_wJWubmg6Aclp0VAXatg>
X-ME-Received: <xmr:LPoAaeutiZYRMfVLzfF-LQPCarbfTDcIRhO1Zt4-nvKGzamJ4ANYHDg_6cs-HjLdnX_cmPk6kmjGsMGoSfod3ikUfqoFBWatKmCG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedugedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomh
    dprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfihhvvgdvfedutddtfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LfoAacyecc2ONkB8X5sGZk0vKkhwNYg30UuzpM3grwY9jP5scXUchg>
    <xmx:LfoAaRC0kUDpo7lPavdOG0SA1YPilRRYtNad0TfyTYLQWtPuP7BOlw>
    <xmx:LfoAaacpwNNGk0aiBAZwVv-jYMFond7D7gsdPXGfZZLX321wUppukw>
    <xmx:LfoAabk8OhShTVvo-4fY6bLBClz-MqbOKv5VoS1gwUt5acVteNryxQ>
    <xmx:LfoAad4nVxH9qnffYo5-TQSEIwIp6FcqQTNagbbCUL8d77WA7Scmj9x_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 13:15:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org,  Kousik
 Sanagavarapu <five231003@gmail.com>,  brian m. carlson
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t1016-compatObjectFormat: Really freeze time for
 reproduciblity
In-Reply-To: <87frb310d2.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 28 Oct 2025 11:01:45 -0500")
References: <20240703153738.916469-1-tmz@pobox.com>
	<ZoV8b2RvYxLOotSJ@teonanacatl.net> <Z8HVkqqD054QGPIE@teonanacatl.net>
	<xmqqbjlump3m.fsf@gitster.g>
	<87zf9c8glu.fsf@email.froward.int.ebiederm.org>
	<xmqqqzuoi6sg.fsf@gitster.g>
	<875xc02mmq.fsf@email.froward.int.ebiederm.org>
	<87o6ps16pj.fsf@email.froward.int.ebiederm.org>
	<xmqqms5chyr8.fsf@gitster.g>
	<87frb310d2.fsf_-_@email.froward.int.ebiederm.org>
Date: Tue, 28 Oct 2025 10:15:23 -0700
Message-ID: <xmqqv7jzc5hw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> By default gpg still allows time to move forward with --faked-system-time.
> So in those rare instances when the system is heavily loaded an gpg runs
> slower than other times, signatures over the exact same data differ
> due to timestamps with a minuscule difference.
>
> Reading through the gpg documentation with a close eye, time can be
> frozen by including an exclamation point at the end of the argument to
> --faked-system-time.
> ...
>  t/t1016-compatObjectFormat.sh | 6 ++++++
>  t/t1016/gpg                   | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Geez, how are we expected to find the need for '!' ourselves X-<.

Thanks for root causing the issue so quickly once it was raised.

And let me drop the "let's disable flakey ones" band-aid patch from
the queue.

