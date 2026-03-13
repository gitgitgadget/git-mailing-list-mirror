Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503433876C1
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441341; cv=none; b=LjvvpXZMzlzKplEghtimQBUpwhNunlQzYHhI5CoUxfcMHHFHYx7b6Vp/AG5wSCwLBJ1gHVyCKhUDhA7UuLpLaCXP84JMb7VshUEqBjUfprbfUf6ePqOIrZsYKML/82lcJvQWNxVSxft1JYW6TMXv7ljfQH0JxawUGrH32iHDdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441341; c=relaxed/simple;
	bh=YOHDlgJcIba/xtYKuJOsHnJRfRXrXEozfMnVYCsscgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HP4L25TXfvorFdFu13Ea9K9mQ8iXsC/rRC8P8mjmiepYDCxlT1MwtrfVslRqzbOo4PjMckqT3Se6WM9bofIYCf4flbaqlLluM1E9OnpsGwF1hpwyIioSbNjxzyGDoBCh0Z6U2mEx7KbKomGURz0sgtLcqpYH4/RbBFYDPTVeGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aCve6FFv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0gSj/W9P; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aCve6FFv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0gSj/W9P"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1FA6E1D001F1;
	Fri, 13 Mar 2026 18:35:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 18:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773441333; x=1773527733; bh=YOHDlgJcIb
	a/xtYKuJOsHnJRfRXrXEozfMnVYCsscgY=; b=aCve6FFvVqf9ZwhUM9Hpr2X8Hw
	Tw4xxqnDDJZKQGQNhCNhiRoCuQGNXI3IS6m5uAiKB9ek442mL7nDHodxlPCyECHL
	e4kibmxxYzexKgEPKDzB+EKqmP6X0J63QYUAP7/lCUH/1rs0HKer/iue8NBjXiZO
	uyiG8uTKQoeyeS4J2Jrm+n5KRdx2tJSIVFhk5UqC3T94mwJ5c8AS0ci10B2bTuQz
	3fyf2O9Rif0HTPMZy/KC3/bqa6tIWlCikBp45+jCstnE3fmxev9tuzdC2A/wyZZd
	K1pyui/XxueDhln0kKkomqIGt8YgGO94+zr7Bdgm0EmFqg75n0C642GfjP4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773441333; x=1773527733; bh=YOHDlgJcIba/xtYKuJOsHnJRfRXrXEozfMn
	VYCsscgY=; b=0gSj/W9PSMdCUV+OH570ol/frvkrWUzJ9W9ntLt3ptFyjbhirxb
	k5UzKTpGtEfYUS6w/ddYoWSGgmalKHOYXEJV0isFLiAnMwujx8y/NM6vyGs99UB3
	qwmUl6nnEmEoBgfqGpquAuh/BTaLVLUeyygPRq7wsaNh4owZreyc0Tywn8gwmUNi
	fDLs42LJi/CZidYghrmT0MFVUG3HBkuGDucYLcj2MAyA5DEVHmVRuAqeu1/gEwV+
	OOQoW3eaAPIDtLew5aBQIPpDbJrpaUQoiYQFEh6sEnQ4HKI8Bx4fZvK9PFPKuIG1
	/Y6Mp6ALkG6iQJ8lcnQtO5H2ap87ACa/tYw==
X-ME-Sender: <xms:NZG0aTsZCexkiX5FJpl_GshFvTAz-LemqSyEwf3PsUKQ0ff7ab_trw>
    <xme:NZG0abWmGzSRuh232JJZnbwPTBcITa2zFwy4MothkR5PoDymoR9g4gSKGGco0orKJ
    gk8CcjC17HLZwyzTGbCBMCkQ5N6lwhN6pbMJULkkwGuFfmPWsoREg>
X-ME-Received: <xmr:NZG0afEre08OqBqd3qw0C3XTcO2GxRI_m72QQTSx2-2WbwUjruBwfzFChfWUa5hN2hIWCAFaWxKsQmmwQtce_9YUGj8_xKD6ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NZG0ad1luYYMYIFSR7W81JYtt20Cq1mBMochgs5N47wc1vJLWfjSlg>
    <xmx:NZG0aROqRrHdlJ9I71FI_lroHWVnxErGe8VbrSA_3kICm8Fa3sQhPA>
    <xmx:NZG0ac7VYz-YIlp0pr0u25z3NkQhhNrIQQBw5p4JE-QxSSXQ7LMf9g>
    <xmx:NZG0ab1kusOBSmTZM_rhq7YdK8SUcOa6ZwFos_I2f1Tq6B1-6mWWwQ>
    <xmx:NZG0aVHeYbcCbwlLdHkR8xgmKSws7FKeGGhatddjZt2mWmKtLk14K6dB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 18:35:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
    git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/8] history: introduce "split" subcommand
In-Reply-To: <20260302-pks-history-split-v1-0-444fc987a324@pks.im> (Patrick
	Steinhardt's message of "Mon, 02 Mar 2026 13:13:04 +0100")
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
Date: Fri, 13 Mar 2026 15:35:32 -0700
Message-ID: <xmqqy0jv1hor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this patch series introduces `git history split` as an easy way to split
> up one commit into multiple commits. This subcommand has already been
> introduced in earlier versions of my git-history(1) patch series, but I
> eventually decided to evict them from this series so that we can rather
> focus more on basic decisions.

We saw a few exchanges and comments but didn't see an blocker.
Everybody happy with the series?

THanks.
