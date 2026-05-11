Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662B3B9DAC
	for <git@vger.kernel.org>; Mon, 11 May 2026 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488152; cv=none; b=NeVaeixCGnRb2z/lwSo/OYEUvHYFo37qhCyR2/+ldrH553T10ePTi/jTPsfG/AIjYJCcgDBi0cOgTsZWX4f9a3Ua82Wfk0OdUXrTiHJWva4sUNjY21ASR0Ksr6EHHfmqqL1XHRLwadZZQrsZUJRoNDC0EYySNgHwu/w3BFHaeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488152; c=relaxed/simple;
	bh=LAOEkQ9l+mp/eeBXc2rwjxQXw/X26ZrVoEl0QGWH9TQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lrh8IctewxIMrh9spxw+E3awByQ+97GWxFT5idGp5upJoN3+b5s8W6Rab6LPF1OttlpN7Iu/511Bpm80ta+NQDssYVB7sq8lIYybu3h7SLa7UEU6uBlK0AuQpHw9VITb+6Fqne/mU4erpHmk/CuFI3/h3lQcY2uHYXA3OBzMwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CH9jJqZi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tWY4rK4N; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CH9jJqZi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tWY4rK4N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 571C41D00069;
	Mon, 11 May 2026 04:29:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 04:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778488142; x=1778574542; bh=LfQqjU5E7R
	jakK/0NOnYkoIlZZLFq3UgNDOcDg6r9Ig=; b=CH9jJqZiCglIG9nnq4ki7dDz6i
	nVz0FQetGLbJK9HcQVaUR6pPrKpPxUKVdbd6Y5n7ih9GiH2MINb4bv1PBpaI1yeS
	tOmoqQM8RA/nx//Uoz0ItEzjdLecOWIApL/AfvNv7sCEWRe9wEt+Pvehs9kRtVBR
	liE5+aD9Ouph0oGeIBFMwWiZQyzXouEVKwzotSR8gVAI0r12Om2JCuHvmoYxk/2F
	+PAi1B3hwvxF64NOkqUIuc1w6uexUzNb0E9WmW/GIiMyYmG8lenGOM8akNC210XQ
	+XRtluoRqbiCZ0/k7XbKIqiP7WsobKoWS4aELHNtNAk38MPvj2jQCmH5tQ9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778488142; x=1778574542; bh=LfQqjU5E7RjakK/0NOnYkoIlZZLFq3UgNDO
	cDg6r9Ig=; b=tWY4rK4NMxdiAuHmQY7NOO6edD00hm6B26I+YqBUA6iUH9LsQtU
	RVSBEGZehavLkyvp+DaRpZNmBotOLfBXSASkRdk7cB9tK96pLfYFvnxCb2/0iItk
	J1iYq2JhPlQtunyfr9FnDfjTmlsKe+D6CoWx1bfi0v2SiGWhCl04ana85D3rslkZ
	0gEhMgfSjfWSqoTa/+OBxvZH1bQbdaIfSZWNcmHjwpTFqg4FAhPl4ZizxUGrilL5
	YWwb13vTebf6UMNN3T7UgxW0qJZ+W/LS4f2lXVBFH/seuPZhZ9MVexupiRdHKzdf
	4sPzIrqBl0nemYS7vXBAUnBqxmkYyuQNWow==
X-ME-Sender: <xms:TpMBajhvM9KpIw1O54VAauFi0ymO5YbN1llVGOOWvEm2wcvRqsqA2g>
    <xme:TpMBavGl21sbC4IysivfTDk97dEmYnL8ZiTesiAsLbU0O7sDTmWhlKaNBIyxMv1tT
    yxPRw9J_X9lI8XSJyLRcd66dVN7p4Hmz6C1sRf_DEef1G3c7b2sag>
X-ME-Received: <xmr:TpMBapTrVP9PGZEkMRFcxZ3JXs3foFDyJFo9sLtRbfMdMtJIzfB96g_BJnc2HSduVjp5JtOfJnSCASNAI3RJb9zfCWVZrG7BLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TpMBasxjKPyaeWz-ppDFWErLwbtn06wJGVxpSvvu4rD6u0XnV0jJ0g>
    <xmx:TpMBaldUKrc4ZBIyI0ax3_3lBCO5hUge3a_GaZJD6butvQ-3k9R3yA>
    <xmx:TpMBavMQuBfEYaXrobiV53_GWJhNuEOe6ukJ1AYKMLdBqBT1VYn8VQ>
    <xmx:TpMBagvaYFXR3J4PF34KVxurMT7LH-K6fTzFrVju0mjkzWsyH_v0RQ>
    <xmx:TpMBas_XPrezq1roTWXNIFhjdZgXzAxbYqyyKBa74Ybro7ZRLaY0_gT7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 04:29:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Torsten
 =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Jeff King <peff@peff.net>,
  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: enable EXPENSIVE for contributor builds
In-Reply-To: <agF_0x0yq78J-RFk@pks.im> (Patrick Steinhardt's message of "Mon,
	11 May 2026 09:05:55 +0200")
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
	<2159f6a271b06d156134392ce3c44fe957c83378.1778228209.git.gitgitgadget@gmail.com>
	<xmqqjyta9630.fsf@gitster.g> <agF_0x0yq78J-RFk@pks.im>
Date: Mon, 11 May 2026 17:29:01 +0900
Message-ID: <xmqq33zys62a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So with this change we now run the tests for all "official" branches,
> and on pull requests. Which raises the question: are there any events
> that happen regularly that are excluded by this? Because if not I think
> it might be sensible to just enable this unconditionally, also because
> that would make jobs on GitLab CI run expensive tests, as well.

The simplicity certainly is tempting.

We could instead do the "let's enable only on linux-test-vars" kind
of "optimization", which is on the other side of the extreme, but
that is only valid if the kind of bugs that can be revealed only by
EXPENSIVE tests, which may not be caught by others, is expected to
be pretty much platform or configuration agnostic.  I somehow doubt
that it is the case.

In any case, I think spending on more machine cycles is certainly
cheaper than human resources for things like this.

Thanks.
