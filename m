Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FFA332901
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884406; cv=none; b=BHZo7MHbQQRIP62jZmQAY7ugiY84pg9aTkyP34GxRdgUtBueJnb7Q147e55ncWSGmpXDggR4dCaATGF24CqfOrPBODZD1pdPgvUizYbwFXbsrYQICKF1fvaPtzf0KU81JdrSfXLOmjWrZyUclNjfDg+gc5riDmZ04a0Fh9BPcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884406; c=relaxed/simple;
	bh=KT/M3VVyNJa2MfIDvAtuViZmgjwLtyIeZ8kodhvGF3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jTsQNLspV/EQMGAiGQtLByBRo290RYsN8CSNvMt+XEyaxc92xynDj6wDOuDPK5rNZYetBHa+pey2hSPf6vQhCA2apNOyI07KL01KE/8w6SokoM3qY92xEbUEFsa+qstglO3o9CZW1Iy7T1c2SI//pOJR5yh5ypBeMmAZKaF5odA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CKSJwzpY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5YpZZBqL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CKSJwzpY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5YpZZBqL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1EB07A01D6;
	Mon, 30 Mar 2026 11:26:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 30 Mar 2026 11:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774884404; x=1774970804; bh=jWFQXoUXpF
	QQ3iOfkWKOe0are1oYfMbWsGUchiAJ06Y=; b=CKSJwzpYwpQdUNE3gy4O00nkjy
	r0dK1mLxSGUrMuu8Gf53Mmn3Zr3gNEbRYWpnaeAPOkOsxxhzXscUHSCAR8zZ4kFP
	0A/lC7JhQburM5MHCDzRlZiA+vB6yt3se0Y6aIw+cWFj9pu0IiPwc9rAMuITSlA1
	5gueQ9b4slo/koysbFOknR+22vbdYMOiiwXuXRX3hqmHhAX1SdJl4x62UX+OslTH
	GoSV2rzA8fxqupQ8Hqknp79otWeche9wB9aDuAChUo36jZPcXgsvxAXSltimh2RZ
	5Kvgs+XispY53UgCFEEl6R61cEGYb4qiLB3VkiyOmgIdK7sy8ujcrsiwjmiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774884404; x=1774970804; bh=jWFQXoUXpFQQ3iOfkWKOe0are1oYfMbWsGU
	chiAJ06Y=; b=5YpZZBqLlRABnofZqAIPU2SFTiuraqiqO/n8qb+tQ5U/Sb01X2I
	XafVPkhN+D/4auhXrZCTwFd14v8av86ryrjpd1iQBdiWzVmCpBROqlEvCI8NEN10
	18a/HIsbrxPqdzABZ/xMekL5/L8xX8l696hiLJ98QrKKt6+vAgq4iqcx8peI79ri
	kia14LLbA+pKFFyYTcJ3D5xHdlaCLj7+yFVotNYVsfy8br7QFWwBwvVB3WMIKOfK
	8zXAS1joqHP+1fal7AF4jKIBYeLBy2Dw26NX3EFR2j5kjd5xUAaw5VM8KJSZ67gE
	oQpUpOm6pgN85/BzYOxr63uRogIW7mrz2cg==
X-ME-Sender: <xms:NJbKaTTFe3vbQY8oMRXD_LVEHC0NJWypfEAVzmeLrPh6DLogYQsQxg>
    <xme:NJbKaRWWmyLZoEEwDuZYpgIssjd7NT--Ov-hfqWDDaUvGjbpOXgl13WyWf6Kgb3Hs
    9zuZASwwGqIs2Hto8_ovN7zeOJs0lwlOItiUTB4agjof7uGgKKhyQ>
X-ME-Received: <xmr:NJbKadT9F4o2lliVdiY0gaEuXXnEzh4iwdSK0vz6m8CuaGvAqz2BD-OtJWoA1HJWhVBDTKTJub4gxLqZeGTr9PlraJXmqfY0ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehprggslhhoohhsrggsrghtvghrrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhgvsehruhhngihihihurdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NJbKaZ2MKGKLmtxK5MCSRSSw05TP2Ou6eld4Agr5Uy2-NI3Ljfm9EA>
    <xmx:NJbKadfEclzvlmx9KWZnD2GF2iIXvHwpNQ5JKzkOf7uj7FYWcPrGwQ>
    <xmx:NJbKaRNx7TqDlM3TBs73BakILjw4PeofykwrNPDnuaTg_kxiUlNhVg>
    <xmx:NJbKaRWg9LXk0AM3rOkqpnVpKveRdQGdpQNtohYHx3igyJ_obr0B5g>
    <xmx:NJbKaa4WoRnEWbNSj8wodzK7A4iQyv0HJNssQfCsZg58PxbzC5AksmI6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 11:26:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  me@runxiyu.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com
Subject: Re: [GSoC PATCH 0/3] receive-pack: fix HEAD check for updateInstead
In-Reply-To: <20260330111822.165188-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Mon, 30 Mar 2026 13:18:19 +0200")
References: <20260223141236.22476-1-me@runxiyu.org>
	<20260330111822.165188-1-pabloosabaterr@gmail.com>
Date: Mon, 30 Mar 2026 08:26:42 -0700
Message-ID: <xmqqy0j9e3t9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> When a bare repo has linked worktrees, and its HEAD points to an unborn branch,
> pushing to a wt branch with updateInstead fails and rejects the push, even if
> the wt is clean.
>
> This happens because HEAD is checked only for the bare repo context, instead
> of the wt.
>
> This series includes Runxi's test, a cleanup of a test that messes with Runxi's
> test and the fix for the issue.

It would have made a perfect cover letter if you said in a very
early paragraph what Runxi is and how it related to this issue.  I
am guessing (from the fact that the same word appears in the patch
list below with family name) that is a name of a person who first
reported the issue?  If so, the missing sentence would have said
something like "At https/lore.kernel.org/git/$MessageId, Runxi Yu
reported ...".

I have to leave the keyboard now, so will take a look at the patches
later today.  Thanks.


> Pablo Sabater (2):
>   t5516: clean up cloned and new-wt in denyCurrentBranch and worktrees
>     test
>   receive-pack: use worktree HEAD for updateInstead
>
> Runxi Yu (1):
>   t5516: test updateInstead with worktree and unborn bare HEAD
>
>  builtin/receive-pack.c | 39 +++++++++++++++------------------------
>  t/t5516-fetch-push.sh  | 15 +++++++++++++++
>  2 files changed, 30 insertions(+), 24 deletions(-)
>
>
> base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
