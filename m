Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B04C3101B2
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539727; cv=none; b=Iyp2eo9wLYRYRlXkIvQ1n6pW1QkQlwdL3SBHChWD53zF5FiJs6ffonkGcUCSPKKvq3oMGAn837ZIN6Ngu/LVzVBjyZ8vT25BrL4MY/7VU7ijHArQWD67RKz9DYxmHCESwx3vyfgdvmuKjmvnEAaE/LjZAShK4Rl7pKXgk/haPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539727; c=relaxed/simple;
	bh=xwUOW+d6cfotgeMLS87v/FMGIllrh7/Qbij9ckgmDzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AznIURZeX/rM0Nx/UzTz241Oe3cbbfLwHRyWhwPSN2gH8jXM5A+ZzGTJLjHIMZ5uy8Lo8r196cEUCAKl3TFpjosAyyck3c8Z/EV6QlAYnNRLwDZkxGwG/wiJLMOpxbsuFW1Dec+HcP1BXlCleD/BlW1LJZ2buoWR7MnnbkPa7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ScOfvzdt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dyp+Jjva; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ScOfvzdt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyp+Jjva"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CD2EEC00FF;
	Wed, 10 Sep 2025 17:28:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 10 Sep 2025 17:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757539725; x=1757626125; bh=pI+pE2kTbS
	8Ci25kCym2ZQlXMI8Kg3JaWxG4CDvS8Po=; b=ScOfvzdtxu7wS/mSW86LRcvRhr
	kaD8dubZCctXQqgRI6gO3TCwITl21JcvDkk7eDKZ+EHt0t0rNaskZpK0FHZh9CSv
	aVxgipPTLN12skyqNRv9/Osx8C/S0+VYxf4cNOS1y4AYLeKTt/8OmJ1OMcOp0AHv
	YCguxYKkgGLmlm8fxMyBkwkSNi/3Hsj6X0/Uh/q8ddqmizwOsd7ZP/bSjvsEjU5z
	mTCQdOj9ZBX3aDHHs4a0WorrBTJikTDnzXo/CQasFcTZLA+Wlk2uWI77G0hlAsy+
	8R2Whguu4EE+0znY64MNtSgxx0T2BGmP+ZyPwln2jdthqqVeAftfgXk9tzMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757539725; x=1757626125; bh=pI+pE2kTbS8Ci25kCym2ZQlXMI8Kg3JaWxG
	4CDvS8Po=; b=dyp+JjvacDjDk+E9yAcFNYTcdN1JY6iX9m259rM7fqbrZcndoUH
	jSiqVmSN3NVXfbeAxULwj80E+6t3LbH9p80YgrU0pCMMIuJU7j7q0akQm+YhICXP
	/dxahlU1Ndch/+Glc/yWsVX2YCEtWvdODs1EyIOSJtUfkuM/s7brYbazxuRQKSkq
	pCS8p/g89CYOt/iI+yRIwne4PZoPnxAsYVaHQk/fW80FYO+DoFwskndyAtpseE4B
	yoZSILB43wi76uxazMwIYtgt2KY4xJWEbmcnqnoTvZJv4e41cDDUXm1xGvpA6JrQ
	XQnKC/E815wS07hwetGfePeE29phiu2rb1g==
X-ME-Sender: <xms:jO3BaEKd3Iq8XVrHF1AnJM6pVOgNHSjzhSe4Bmj4FhcbxSVXtMY9yQ>
    <xme:jO3BaHZJjr7HCr2zZ0ZwNCMjddqoAz7IRqApj_TyF07ZKHx5vvNyxsQbn_s124n6B
    ZmF9Rgef8CsFtXFQA>
X-ME-Received: <xmr:jO3BaOLOJ-7ye8OniMeM3vrifi4iXlFHK9Qcjhr6Qvmv3rthTJ5vq2DMkYustr0xaUsp9J_Gv-EStJ6PlvAiFUUpT0LK4pJZUZxKpBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeije
    egfefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:jO3BaNCdi0lfYwAz7EfmoMe4oWWBiH1hOxEQWiriB09mksDITw-VVg>
    <xmx:jO3BaLqSjKbCOE8eVg1bSyeOnIyLzK_fRYJyVs5M-FnxR3nOCJs7LQ>
    <xmx:jO3BaAif-DJpvBIRNykykQTCbYkeudtQzr561cqzLuBwCG3x0GmwUg>
    <xmx:jO3BaACnSwFAcH49Ekel3P6SFpkvb223NtDRoio7VImq2JeWPjzmpQ>
    <xmx:je3BaLtZyRhZpTeQXy5xAU7OXymJqfydmWNVJ7b42401lwAhaYK79I5f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 17:28:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] gitk: macOS fixes, README
In-Reply-To: <a2482504-b372-490b-866f-75d8b07566fd@kdbg.org> (Johannes Sixt's
	message of "Wed, 10 Sep 2025 19:13:49 +0200")
References: <a2482504-b372-490b-866f-75d8b07566fd@kdbg.org>
Date: Wed, 10 Sep 2025 14:28:43 -0700
Message-ID: <xmqqh5xaq9o4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit 93ff79ed417e8d1afa770b31721ad3640ed2d0ad:
>
>   Merge branch 'docglobs' of github.com:ilyagr/gitk (2025-08-04 18:20:32 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/gitk.git master
>
> for you to fetch changes up to ac8fec7d8de265e56441713faaf4e08f11c31469:
>
>   gitk: add README with usage, build, and contribution details (2025-08-28 19:51:31 +0200)
>
> ----------------------------------------------------------------
> Johannes Sixt (2):
>       Merge branch 'aqua-ctxbut' of github.com:ZhongRuoyu/gitk
>       Merge branch 'tk87-touchpad-scroll' of github.com:ZhongRuoyu/gitk
>
> Michael Rappazzo (1):
>       gitk: add README with usage, build, and contribution details
>
> Ruoyu Zhong (2):
>       gitk: use <Button-3> for ctx menus on macOS with Tcl 8.7+
>       gitk: fix trackpad scrolling for Tcl/Tk 8.7+
>
>  README.md | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  gitk      | 26 +++++++++++++++++-
>  2 files changed, 118 insertions(+), 1 deletion(-)
>  create mode 100644 README.md

Thanks.  Pulled.
