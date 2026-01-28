Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C511531C1
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643740; cv=none; b=rjWi+lepDXF+8ZKEajxBeOR4dKSG29gfJsoHy5oQulwNiNX5KgDmsq39MfAJuSSr8LWoDkyzA6InYNFkSQXzXKMT3dk19xN0UFtcWyjG3wb87490VY9itCFx5LaVN65rU/jQMSWxPdTreLpekCrkp6WILrHMJx212t9EsOqZ/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643740; c=relaxed/simple;
	bh=NOmUhGkK11J2jAavhHOrYAcxhoJG8TBvtFwrsJMo7uI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTve7OXYhJJvoL774cDwgkkEiA9SCspv/fS/rECeXQNChgTUskpGPB3WNedI2Jseys2Zjq2iSRiBVaZujS9ESu8GN0hbbUP/U5+HqMdbbh5CwaLjDW7L0BT0uO0PdNMAxYi0OHOux8Tkll86Lp5EpQ9n7O/R9vV1pdG6F/spLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2x8HueOT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L7XGG5T7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2x8HueOT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L7XGG5T7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 67BDB1D00078;
	Wed, 28 Jan 2026 18:42:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 28 Jan 2026 18:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769643737; x=1769730137; bh=NOmUhGkK11
	J2jAavhHOrYAcxhoJG8TBvtFwrsJMo7uI=; b=2x8HueOTx+LgomDnXNbUkbnNJS
	V6czpeswYZYFohXcgNLYEkYkYHNufytszOeLXNZ0tnzh/WBGpA09h/6+6f0XwKIe
	4cuXUlyVFZka7W5Pi7ypOUeM2t//ufpwbsGMpD7IcZ20A6djsjXO+UQzPeEvVnbg
	D29L3CTwbdUDsxPGW1iJlsf8C3ukWG9KOt01mCuQ0PE1F3Z9QqFbgZwOMX3Nj+Qa
	uaHLFqNRWTUKiU71dLpPEmIXZFidAxjjs7CebJuou9MHIRkrbLFj/Rn2gPp5P6p8
	xSoULM9tcVua0LjLp10Fk4F1lP/PLcXNGK4CIZNWW7lLV0nGTr1LNiSZBGYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769643737; x=1769730137; bh=NOmUhGkK11J2jAavhHOrYAcxhoJG8TBvtFw
	rsJMo7uI=; b=L7XGG5T7quRkKggraNk/mN58bNLFtfP6UICnoFiOUm0u84u23CV
	f7ux/8JMR3BoqsO3vyrQIHpk1oGhrqZS4jpU+hh27ZAUV14OK+jLc7uzANoFD6pi
	lHZR+a1l1XogANMluyNsCbsSRngtv4/NOC/HBjvMn5CwTLDGpywIHwlgwhXguI8Y
	GvhIda/9lXpv4uyQDuQ+yW9k0gwCNo1Z4KD6miJJ2hoFzv4ZUuah6UuQE4D6ruCM
	FBBdpqTyhdrzuJGIiuvCEtAd3N7iZPpML/h3qN52hoj+u0bcscvzPXpZ/+65qxbn
	UskdAjry7KUtZmpUGC4O7NjcYZv3w+xgGcg==
X-ME-Sender: <xms:2J56aVXrHE2fNLsWNuAx2wqaMp8ZP_HN6vge_9nc9u79QZUiAcV0xQ>
    <xme:2J56aWT_yQeO77fznc5MIA8ApKeZMEWz9J5UADOSgAZYFWfVae2faoyZ81KiVP8mJ
    oOuTjc2XisRMq-Df02uBaS5Zr8zx1U3O4W2wY-3XxN3dxXNLLsg>
X-ME-Received: <xmr:2J56aflpWjymCK9AHT2_8SplWInOjwFlln6ZINzzpphSK-vC3lCGjL4lOLMu5jQwEP-VuMQVtynHAKtq1FOBdQ2smUQe3TZZ9FKz-44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepgh
    hithhhuhgspggthhhrihhspghiuggvmhgrsehprhhothhonhdrmhgvpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhhisehitg
    hoshgrhhgvughrohhnrdguvgdprhgtphhtthhopehprghtthhhohihthhssehushgvrhhs
    rdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvg
    htsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:2J56ac40jt-QRhyVFbny6ZAfmcqIYPL2arzYiTlVjDV0Kg23yuylpg>
    <xmx:2J56aVjrv7gqLWyV1xkVobGGxQwf45nQ4q7_T7lHRyX7qya6MGBi3g>
    <xmx:2J56aZE_serTQ14XDLzXBEqbRjU2LnP1e7BMuYy8UY3ybEDTaVbpYg>
    <xmx:2J56abQUzRecRMbk0JvePv8LlrjgSZXxsAc_gSVwH8ySXtcWmzc7iA>
    <xmx:2Z56afJFRFrtBanrV5wCUm4YYn6Ie5hwezK5RJ3y4w3SWoFCOuvs-sUR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 18:42:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: GitHub Chris Idema <github_chris_idema@proton.me>,  git@vger.kernel.org,
  Michael Lutz <michi@icosahedron.de>,  Pat Thoyts
 <patthoyts@users.sourceforge.net>,  Chris Idema via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix
 alignment instead of spaces.
In-Reply-To: <bf8e6231-e1c0-4c0c-b4d5-20f8d0044211@kdbg.org> (Johannes Sixt's
	message of "Wed, 28 Jan 2026 16:59:55 +0100")
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
	<pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
	<e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com>
	<xmqqsebqem1n.fsf@gitster.g> <xmqqfr7qeixq.fsf@gitster.g>
	<71494127-c17d-4fd9-a69d-1f547205ac8f@kdbg.org>
	<Rrnh0ugGQ5ef_s-3W0Tive8HA9R0_9Cq6yK7K6SS6Jr3kPigHai3jzxvphTRNXXNhCnor2TMV8UjKEi5U27VOLBf-R4g6VbJBLq8PQH9kCI=@proton.me>
	<bf8e6231-e1c0-4c0c-b4d5-20f8d0044211@kdbg.org>
Date: Wed, 28 Jan 2026 15:42:14 -0800
Message-ID: <xmqq4io5e23t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

>> For us this bug is a show stopper that makes the diff in the
>> git-gui window by default unreadable.

> Earlier, I said that I'm not fond of such a change. But I changed my
> mind. I hadn't noticed so far that Gitk applies customized tabstops. Git
> GUI and Gitk need not emulate the behavor of terminal windows faithfully
> and can be more clever as far as tabstops are concerned.

I just peeked what gitk does, and it does use "settabs 0" (the
equivalent of "apply_tab_size 0" in gitk world) for plain files,
"settabs 1" for one parent regular commits, and "settabs $np" for
n-parent merges, so what Chris is doing here makes git-gui match
what gitk has been doing since 32f1b3e4 (gitk: Fix the tab setting
in the diff display window, 2007-09-28) for close to 20 years ;-).

Having said that, the fact that they have been allowed to be
different for so long tells me that the way characters immediately
after tabs have been displayed in git-gui bothered nobody for a long
time, and calling it a "show stopper" and "unreadable" is a great
exaggeration, I must say.

Thanks.
