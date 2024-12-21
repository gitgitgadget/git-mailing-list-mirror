Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0B13B288
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734800292; cv=none; b=iVp3plUXiV4Tbknz8ZV8EL2m2q84KPmAHWZx8kSablajVsuMp8d2vPJyn+CG+LaQh0U1K88t4xyQ5xjozHHymluVx378//+IxzXP3ChrFySDxAJ9u4ReJ7EQWRKk2O+JcRKSv5iIr1Z02t9SUGEz+Xw3wkGYLrlRcg+iCoFK3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734800292; c=relaxed/simple;
	bh=KgJiW1KzvJJ+rofANxa91jwhv9BaNl4l5M+s0Xu/DuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZfNRkI1qc2Ok0ovheYZ0VkXgLHVLf4n6gpjjnncM/NedoziIXtQCMyr79vLu549CgSXptXmX7N8vIXMMadvl5Z13+ZtY4osN/aAKQaHhTr2X7SOhvwxu8O1mw9dZSJNQgkr1YuMhthoFOG0ZJjduSEcFjv1FEfAIhwdEnfr0FBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rXpD6Buh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQ6Lv/72; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rXpD6Buh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQ6Lv/72"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AF7B51380206;
	Sat, 21 Dec 2024 11:58:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 21 Dec 2024 11:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734800289; x=1734886689; bh=xmtId/APON
	9jilvkgLb1QT9eijziX8mDjixLNUlhli4=; b=rXpD6BuhJoqLyVFNsG+ScknU1z
	iEodrF9rOrpvwF0Qcp5KqD8jdCgAfjhIPM8rtHBMmDG2GWFjdl3tNjqMNib/9bMH
	niwau1rMiPjGWh9kcQlKaU2dLqPV82pjqa2pK92aL3TNGZdksqOul8PcKJOMYcBA
	xnLv8LUcZZgEvsdnWUsBeIwANBVzEiqTfBdqIUaruy3JTkqFh6GleQq8t97fAPhk
	+2SeBq2hT46ArpfGQHMa7EGuLLGhVWlPMhPq+7hBJpoC3kj8dl6PLhG8m3C3t2VG
	M4c6p/0xeMNuJUP8xO7oy8q7i09QZ0cYn3ElM1gxogSIgbePlm5VqliR3dLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734800289; x=1734886689; bh=xmtId/APON9jilvkgLb1QT9eijziX8mDjix
	LNUlhli4=; b=MQ6Lv/728FA3kNvT/osX6KJJh3/8AKVfDM8SpQJngypm2VOi7x/
	75FYdhu7HmebQsiA/g2AtLLfSaKl97THcITXsSFLFH6WMYzt6dxwnY7mMSLXKseg
	nMnT5CQrl6sIEnnbQ7iSlvmyXmR8YWvlHEF+5awjoggPS4osRorjpqmgBfunDxlC
	4BkpOMNwAu8BAlVWOztk8CWhgz/yTW/9gIFKwGSX/BubnWn2QfLaJzpjupr+GUuJ
	xA31lBQtCujN7l8Ufdd944fPfHyxFw7rhBhi9P/tRmg5crGyJJAsTg+wGrqIm2Ip
	zeLyVqetmCf2HcsSXC1+w7urwmxdI/Llspw==
X-ME-Sender: <xms:ofNmZ0X9VPWmbqpmKLR7vfjf-Ttowex-qxQcfb6Fcc2Ogd21W-t4jQ>
    <xme:ofNmZ4nwTWpD1XWLEckuGhufcLTNQP9_RmFv4XIRGxPxq4WMbuWESTarxFsEF4eta
    La1ghPkfa95y-92Bw>
X-ME-Received: <xmr:ofNmZ4bY9sz3Zp0y6BmFaXEnRo3ZL7tHzbl8KBaqeyH025XQmuqWo2jCRsmgBwFZveE-ECOAls6UicK0Z0yR7XH_JB0YLaLkuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehmrghrthhinhdrrghgrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ofNmZzUBDiAgLqn10JoVzc40Q99sxBoImWzphF_TkLG0C0l_xkWNlw>
    <xmx:ofNmZ-nlK4rxwupr0FLZltEHURCHtbyFsqJuEegyCdpm-Xmb9jOM8w>
    <xmx:ofNmZ4fW8sbrTpH8eNwjCerBAlgFviKe3b_A4MTSXFhSqOQPSCKp3g>
    <xmx:ofNmZwEzNCuiEznCmnrzCu3wNJUduUxaCRcAZIv_YdBIll8PXDO4_w>
    <xmx:ofNmZ_DAflC4KgQncHeavUgTochDPs7HkYGYuPjjnaW1FtINYh7KPvQZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 11:58:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/3] Asciidoctor fixes for 2.48.0
In-Reply-To: <Z2abxaGVzA5Kce-s@pks.im> (Patrick Steinhardt's message of "Sat,
	21 Dec 2024 11:43:17 +0100")
References: <cover.1734734612.git.martin.agren@gmail.com>
	<xmqqzfkpdaeq.fsf@gitster.g> <Z2abxaGVzA5Kce-s@pks.im>
Date: Sat, 21 Dec 2024 08:58:07 -0800
Message-ID: <xmqqr061c6sg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Thanks.  [2][3] are something we have to have before we can tag 2.48
>> to have a healthy build with the usual Makefile; so is a working
>> Asciidoctor based documentation generation, so building your doc
>> toolchain fixes on top of the fixes for 'GIT-VERSION-GEN' does not
>> give us any practical problem.
>> 
>> Thanks for a fix.  Will queue.
>
> Thanks indeed, the changes look good to me.
>
> I guess my key learning is to do largish patch series like the build
> refactorings in smaller increments next time. I considered doing it
> several times while implementing the series, but shied away from it. I
> guess it would have been easier for everyone involved and would have led
> to fewer issues though if I did split it up.

FWIW, from the project maintainer's point of view, the trickling
rate of all of your series was not overly too fast.  As long as the
reactions to problems discovered can keep up with the same rate, I
do not share the "smaller increments as we did too much too fast"
sentiment myself.

If you are referring to the fact that you have to scramble and fix
the reported breakages on multiple fronts quickly near the end of
year holiday season to keep the release candidate healthy, and
regretting that we went a little too fast, then yeah, I can
understand it and we may want to pace ourselves the next time to
lessen the stress on all of us a bit ;-)

> So thanks to all the people that are helping out in this context!

Yes, big thanks to everybody.
