Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C92BD58A
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769362151; cv=none; b=CZ07wmCjKf6iIpqJq8HpHVcwLMDAUbtv4MVfbyIIWIcqePMVUWQQ5mzKBaUEnbMJIm4eaLqdGBSkVmuU8C2gZCckLVHZCjqTSAXqh1rYYBbPvY2gXyMAzM6sv6jAEFRdf/fVzMkxc1vGkeDu1wLqr7tEWwZqUquszGQd1ERRO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769362151; c=relaxed/simple;
	bh=NX5DMkodmkBG52KrCbz8KCMKb0PuMa0OAkJasuuV9P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XX5O4AZkEXF36kudsdYnPeKDqXLOPu5n5gWYn9YuaYcQXEphxeZS4SHszq9t4ZwfviBDf2Pk4lfd+sVVX668tNGnQ5jpTncMuBYO9wSnkmj/pMLboTgbIMv8SHfJp7d/+pDUiFOE5P1BRHwjSxM03C+eRnNRRJewv1GDB6WxytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BCIwDOLT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q5h8WRmC; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BCIwDOLT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q5h8WRmC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E3B601D00046;
	Sun, 25 Jan 2026 12:29:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 25 Jan 2026 12:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769362148; x=1769448548; bh=v4alD22+v+
	4UktAPGv+RMEpIfWm7nrA3XWTBc4SxuQg=; b=BCIwDOLTvDDKW13PMaVsNfjjqF
	L+zuO8uArFpydsxrG7JcL07nvJHhLM9mQ57ZOPTx2O4AiQ1nObEOK4SiT8vs3Fv0
	BZcsM02kTpPVxPhHmZJAogwVVwy8Mjb3Ei4ejCuowA40Cjews1nJ8S/S9rB6TbKd
	ohGmpLBxgBgfDDt19O9ns34fxZsC03FDH2vWFOf1yHXwjKnNw1m+OEZtiQ93XDGa
	CUIj8Byv+GBKyLTUgVhTbjjIv0KGzNh2s4JCCxEp7ANBg728GVt6pjYdouNc/n2I
	F2hJar58z26y2dVquI9vHJGtQ5PNTko/lcprvn0VJ18YSD5/ThDGb3VvMeUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769362148; x=1769448548; bh=v4alD22+v+4UktAPGv+RMEpIfWm7nrA3XWT
	Bc4SxuQg=; b=q5h8WRmCGpJxeFen5xu86TZqcxej3nifgT+ByyHOyra7OfnRTrZ
	xaFl5rD2TNj/WRtWG0GWuWsckkoLgchYxBmmDcKF7+qKwMLSDbrxj1MWz5GO4MMn
	GY0PYwKsH3DN/I8FkUD7OoNdIJWKjdmoWrK3jtT5ZIgqyhxnVf311F2ADOvG6IVa
	qm+0twUvI3Ty7aVHnIa/WMit7oVmI6KhlV2nndMRLkGuL9aTpn245wuX9ZdeW4eE
	Ne6C58s5juaZ4pDgBp4034qDKZkuiksy6G/iDMOalyysm6Yi2tYGidUNwWOcfJhX
	U4t00AhjLixFhY5nC3X+jWyvCBnUfBphzeg==
X-ME-Sender: <xms:5FJ2aV_guaYytyJASQ2R6fNMCYkKIAI3T_XNl4XWgfqQpdeTKVnN3g>
    <xme:5FJ2aQnJelFRCE4c5iZbce7O6dVq9DLXj591CROmKIS0plpU8G5y0Gip5FC9hhIhI
    0UX-aHkLgd_ARc28HqaG38vM3UYS9MTkB_WUx9zViJexaKC1f2k7Q>
X-ME-Received: <xmr:5FJ2abVBRMd0G0ZHeMIk-QX1w49N01_I__wY7oJ5OZqczTunBGSoi-aUIxwm9qZqhv76vhKSHSQlKqx-gg6B7uRFLlSXyJcymYnFFKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvg
    htsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:5FJ2aVHClTkOJahVni1TvbLlAa0wampPuE6PbPjL-7_18IAlkaYecw>
    <xmx:5FJ2aXc_GqdrMSs0vkTig5wz5SveKfd-S61TbKFoyqC7r-R-aGnYDw>
    <xmx:5FJ2aWJJ4nIafK6jhdVzOA9KuzTLEKez1yO6P93tSEUi4Kufk94XOg>
    <xmx:5FJ2acGS2DA25mNoUs0FdprKJC4g0ZX98tG_CfcGpN5E3oRRYEKU7w>
    <xmx:5FJ2abnsZM2vkctNThdS0ZbsrzePCwQJAuIyDoGFA8MQfBlxI8IDZi0v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Jan 2026 12:29:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: peff@peff.net,  git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260124085034.8730-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Sat, 24 Jan 2026 09:50:34 +0100")
References: <20260122230656.GA2125611@coredump.intra.peff.net>
	<20260124085034.8730-1-haraldnordgren@gmail.com>
Date: Sun, 25 Jan 2026 09:29:07 -0800
Message-ID: <xmqq4io9lhy4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> I can apply the changes from these three messages, but I don't really
> know the side-effects of it. Should I do it and submit a patch?

Please do not send code you cannot answer to questions on it,
whether it is written by somebody else,  genAI, or your cat rolling
on your keyboard ;-).

I think we are getting close but will need more polish before we can
allow users to reuse their already acquired knowledge of how refname
DWIMmery can be used to spell various refs they mean.

If we support only @{push} and @{upstream} and error out when we see
anything else (like "origin" or "origin/main") in the initial
version we ship to the end-users, that would probably be a good
stopping point.  On top of it, we can later add the DWIMmery Peff
has shown (with necessary tweaks, as you found out, like supporting
tags, perhaps), and that will be purely new feature that does not
change any behaviour of what used to work for our users in the
initial version.

Going that way is much safer and does not break end-user
experiences, like shipping the first version with "we always prefix
hardcoded refs/remotes/ unless it is @{something}", which will have
to change the behaviour once the proper DWIMmery gets implemented.

In any case, that will have to happen all after the current cycle is
over, it is way too late even for "@{push} and @{upstream} only"
version for this cycle.
