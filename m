Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933082C0F81
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889024; cv=none; b=JNCuh8Hwz0SKE09/oiIgDROSflJcOKOOv8pOTrRUMCpOuo6+V59ycJGUv+WpNriSL86gM8Y8PcnOpl3PQlibugUxT23Y7Z+9XRqM6oBCWVFkFGiXGuJqrvHtp9pmCJt5lx+Nj2otjgZGZKLbnU8QqyAuT8pPyNh+FcWg1IwY08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889024; c=relaxed/simple;
	bh=RUFpHLuzctzmrmwzFOqJoku4Tk+4dEK31zAFInhAnqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X4NovKFZ7OhRCWZcnkBKe7j+RtrHW6UF7/I3+BRQEFh/M+Gm+QoqMqMzeCMclA35gVSghcgdqYVnveuVc88YwUffQb4uBQ0aFXSO1WChUWAGBpg5ISjnJMF4x9fK1Dvjm/SPykOABHIkEKxFFYTo1/ZcU/OzskQcLoZYNkRs5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MXAME/5x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BdjLi9Zn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MXAME/5x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BdjLi9Zn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E0FA7A0044;
	Sat, 31 Jan 2026 14:50:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 31 Jan 2026 14:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769889022; x=1769975422; bh=TV0GEkgvF2
	f3Kwl6M8CO0ds1jmUD6k2HwD8oOjC6hXY=; b=MXAME/5x7/kwJv6a5Hqfj8vwbD
	UjmQL3qOpaAE4LyIdEPwnqpfQwPxgLyZFN6m9iQfw+cjW5uSQMJrOThzI6oXWIuz
	WCaGoWIH8G5QmfKkWo6D/+wE4wItDgAm/6PZkKkjTsAdHURd91o6BHB+QU4+M+BM
	MV75Eg65VQHvsKRl0z8iAlMrALUFK0zu7kdg+fGhr+FKDX4ZSVD/aKmVvyZrgo4/
	JnvljZ+CgBv55lOS7Yc5dWK3/UfoiKDUqEi+QriZCFLIGUkXmO5lK65uFIYI1tF/
	/5dph0FPqqVsw6LFvhlhs7usTdlxy6mMKZBZvePSDFFntVWF/hRGQhqy9Ohg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769889022; x=1769975422; bh=TV0GEkgvF2f3Kwl6M8CO0ds1jmUD6k2HwD8
	oOjC6hXY=; b=BdjLi9ZnOlfslqt01qgZqb4JXT54BM6WUBFbqlTBVaeUQthvVE8
	NeeROeq9N8axR6kWPWjsM2JHEJLQFCnV8Thpt2EVisVZVgGbcLzDE4qFzuXN1/cq
	SuhkzWGj3E9EMYB26eaA7eetP6BsWQdC6wom6CSBpy+ImJgu3+xmATTXJE2sEmZM
	mPsZWNPLIPMysbp9UrD4XoetY46GkDP5TGIL+aq6JcAvAL72iCkLmfFMatK5Tzb/
	/qDhsxLZvkxKsbzQin/F4npVIjcjqn5u8xrAi4vHJnmrwwUbtC8Niw0qPvGZ2Q0r
	TpQbn60fwy0TR8SGawF74r1hOpVKjtZ80+Q==
X-ME-Sender: <xms:_lx-adqG1drbuJ1Xt-E0NRjR83O1uBKGSMrOEnl7YLto2y7WhTfeAA>
    <xme:_lx-aXE-3BLw5mAt28YFKjSExuroK3VUNyI0NPcOUYq6MLb_sLoUQmH9stIWddTj7
    hQT2PYgXfK-sogwZ-7b-pRKkIpLC5CXYesi5QT_uIcQ9ufYL6rmPXY>
X-ME-Received: <xmr:_lx-aXkkiqq_s5q9mESVEo1ieZ8KKJyedbFl8qDN7p5LRU7XNjThnUf9Z2h4b-VDqTHEcSg7LD5R5AtZSwf5Xt_7qnTKDdrRNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedvkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfevvdefjeehtedtgffffefhtdfgheettdekheejieekgefgteejgfekieef
    keffnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithhhuhgsrdhiohenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopegvnhhgrdgrsggurghlrhhhmhgrnhdrrggsuggrlhhmohhnvghmsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_lx-aSnB7C-8nZs3UZ5H5S0mAnmEziMmW9d0J4TBNS4R-83PNlYrgg>
    <xmx:_lx-aQuQhieXqvtpWOz7UUDJUOJ3MKm64uy-9E3AwhAKacHbCKCDEQ>
    <xmx:_lx-adm3ahj9iu2gbO75mytBbnYPoSPln9pZrIol6wEl5CtceEJwzA>
    <xmx:_lx-aTtHfF4Ep3EDg1rr4K_C3dbYSjPnAkC9_H_QXCjXK-xAfYnKng>
    <xmx:_lx-afH_TPTddEZBs6i36UBiIGLQgpBQ9H0vhyaENCfW8in0uFvyfyjv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Jan 2026 14:50:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abdalrhman Mohamed <eng.abdalrhman.abdalmonem@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] .github/CONTRIBUTING.md: fix broken link to
 SubmittingPatches
In-Reply-To: <20260131161401.48693-1-Eng.Abdalrhman.Abdalmonem@gmail.com>
	(Abdalrhman Mohamed's message of "Sat, 31 Jan 2026 18:14:01 +0200")
References: <20260131161401.48693-1-Eng.Abdalrhman.Abdalmonem@gmail.com>
Date: Sat, 31 Jan 2026 11:50:20 -0800
Message-ID: <xmqqms1t4l4z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abdalrhman Mohamed <eng.abdalrhman.abdalmonem@gmail.com> writes:

> -In addition, we highly recommend you to read [our submission guidelines](../Documentation/SubmittingPatches).
> +In addition, we highly recommend you to read [our submission guidelines](https://github.com/git/git/blob/master/Documentation/SubmittingPatches).

The line is overly long already in the original; can we make it a
bit more readable?

As to the contents, referring to our preformatted docs, like

    https://git.github.io/htmldocs/SubmittingPatches

would probably be more appropriate, no?
