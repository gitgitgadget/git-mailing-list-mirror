Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461E1FF61E
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800998; cv=none; b=NDR2UsbF33QSgkaoeoiL2+Q9kAYeC9mKsGrlbXztSfSCpEqw3QcuOhMrNem5MVjpz8PlBSOELoon1//Q6VFI4ljOpHz7m87UyLYH1QhekiehVj4lmWRGPFwK5E4c+JA15PflBBqBLEtabpuKZlacvCx/TnDE8rpevkcIVRB68Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800998; c=relaxed/simple;
	bh=/T+D13kvz/taJX3TJqdiai5bQTJrXD8oXj35GJeGdWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dqfUP3l+m/c6IKWhuvzS/P9rJ5VWunF+Wm7Hssg/EMvCaTp+amH+W2wgg1QVqvMjDexH0Io7oIYQA+LMFF51iO5DMz11yKDp0LS1PPyWMpdkf3iXoJyA6k3dHWkuepDPdu+yfyfVhQFgI1hEgVjNM/bh3onlI84s1K2QOx90NUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DD1h5bHx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rwCmq896; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DD1h5bHx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rwCmq896"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7774F1D000CC;
	Sat, 18 Oct 2025 11:23:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 18 Oct 2025 11:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760800995; x=1760887395; bh=eFuW/EXnLT
	Y6B4EgckYcEOF/tSb+YvfBhTy5FBMZN+w=; b=DD1h5bHxtz7JUkvuAlOTqmBTKt
	o9HMCqvwtRejUmiujXwE8L7prlo7mq0K+y+1bIHrZj4NJk1mt/J9ehY7iC1BEcYy
	H9mYXJCwWayx+ppOMY4PeREHWTdp9jABv0n/GBjd4wPo3VAP095k31EIep+xCmuI
	w7zY2TkdTo8YPlo0KDoQaWLb07o/JNrIV5LPiyJw03KIRwaaPxpkt+9tNu3j/N1Q
	2A2wZ23PtA9bXx97ZpIfcozCztGSr8NVtUlOovDljcWtfbRfxSLHJ6f3Ye7IaAW2
	xWKPIcDtjUJO479aa1B5gYEDWpX1db4vm8UcHZ/st35amYCaj3vLXPkTWHbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760800995; x=1760887395; bh=eFuW/EXnLTY6B4EgckYcEOF/tSb+YvfBhTy
	5FBMZN+w=; b=rwCmq896pkn+pt/+pvGjlx+i3rv3LXlk/jJUhjiFSb9/S7WevL+
	OmlgwhpYyo+nfOv4VKv7N2YBnsyPWkxQtFSqAxBh26ikcFj3WuJopivUDkUaATPT
	la6AV5si89cMQMk0gdeIvdMJ0clufdJJtqxVvJwmtlFTSzwwtb7RfbZS7xGD7i8c
	px/e6qJERxtDtEH94pE/4MARaD/TN3VgtPlp9j3MNK2euWIFBvy2exta0qp9Q1r8
	uM/qpijrSZN+8k8I3b4XIx/DB53EoW4EzLZcFS0W4u8T+UMMHx1WKvInW8IqQMNX
	51EexmydFT6abMm97gCaTlPHX249dHkx4bw==
X-ME-Sender: <xms:4rDzaCgtsmAIOdJ_oDGfMQi0xsbI-3JPlhBmCcXBAY-TNTG5lFCc0A>
    <xme:4rDzaOi8YTQ9MQewRExv1wXJ8SK2rQGHUJDU69-BnS8HYhzBAS4wRzENWRYn1NCqJ
    FcpwoHtGmemaEkCZiY_JT0mVBzU1iPJg71MQW_1mlSzjFQPRoU6ew>
X-ME-Received: <xmr:4rDzaAgJ1_h37yGR_2QHUJyDF3XFmRfo1nEP3sVg7EI4t_eJIjOs_Nfk6yzawVm5gS6bbcHHuypJcfqgee05yxtt9sK4UPgtwAK->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedvgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hjrghkvgesiihimhhmvghrmhgrnhdrihhopdhrtghpthhtohephihlughhohhmvgdvugdv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4rDzaGLFIZ5gSIzHGmlQaLbhMz5stCv7wFeubH4X98nomG9NO0LDgQ>
    <xmx:4rDzaHFwC6L9I4rCjMczkoCR4rBgQNTrLM-MIxsCfvnjWGFkiKG4lQ>
    <xmx:4rDzaCSuSUIfVFNOfHA3MTksDeWSQXe9e4wLNoYZP8Ad_nRAPpl1iQ>
    <xmx:4rDzaLe-dCT_jufdpHKfnFn9y5ahpehMl8EE6RT6KpNmZxLA5r8k_Q>
    <xmx:47DzaA6zoV30QudFg7wN7zXp6ytfFIFs7h3254woQVIqQeJ1ZsoMMlq8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 11:23:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jake Zimmerman <jake@zimmerman.io>,  Lidong Yan <yldhome2d2@gmail.com>,
  git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
In-Reply-To: <20251018094037.GA1060824@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 18 Oct 2025 05:40:37 -0400")
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
	<20251017075153.GA4078773@coredump.intra.peff.net>
	<xmqq7bwt1kyf.fsf@gitster.g>
	<20251018094037.GA1060824@coredump.intra.peff.net>
Date: Sat, 18 Oct 2025 08:23:13 -0700
Message-ID: <xmqqh5vww7xa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I'm not sure which of these you mean:
>
>   - Do we still need to call diff_flush_patch_quietly() directly below
>     the hunk above, in diff_flush()?
>
>   - Do we still need the dry-run code at all?

Both.  We do not have to call flush_quietly() and can call the real
thing with output disabled.  The dry-run bit was only added to
implement the flush_quietly() variant.  If we lose the only caller
to flush_quietly(), all of the supporting infrastructure can go.

It concentrates only on the regression-fix aspect of the changes.
Going forward, my preference is:

 * Apply your patch.  This is the base of the fix for 'maint' and
   all branches.

 * As Lidong updates dry-run code by adding more "ah we are in
   dry-run, so we should stop at the first change and se should be
   silent" fixes, we can queue them on the 'master' front for the
   preparation for a better future.  Note that the 'master' front
   would contain your "In from_contents modes, run flush_quietly()
   with output redirected to /dev/null".

 * Once we regain enough confidence for dry-run with the above
   effort, we mark your "why not redirect to /dev/null for extra
   protection?" code with NEEDSWORK comment to be removed after a
   thorough code audit to ensure that dry-run is now sound.

And I do not mind if the NEEDSWORK comment stay there for extended
period of time.

Thanks.
