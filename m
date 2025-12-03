Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F02DECBF
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800476; cv=none; b=Rpmf874ZYGeSBvmiqq891ki4hteLba95GOSNd8TelXKtVST/6e2aSmKp3ulqcTnn8oQmFUT1uz1uCWVGhQ5IfhPPvah2+on3vFdcZM7JHTREudgbZQqltCgmkweYaDGINr3TsCB6Lfxu1CqbtZlmRrkQ3vowLP5qXfCqGASZbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800476; c=relaxed/simple;
	bh=dcbMJrQ4du6C+E0k9R+Q4Be8N6jVnKc7D2DB1CMUAoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGZ29myxU0EtoNV227ZZINLGE5emJi8yQMqQHDrhFmWIRbw3OEYbpfoKrRi7OMA/htDwbB/bcfq5yySs21Af5eaXtCEu+bLLfMfx9zyfBgZMag4mpOgn170SIOnlr+coyBfRlY+F3ye5UpIKy77yce6zzopXQ2UdCfDxEzf9SkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k4+Ut1TN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RpqJm9Xd; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k4+Ut1TN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RpqJm9Xd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C2F4EC010B;
	Wed,  3 Dec 2025 17:21:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 03 Dec 2025 17:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764800473; x=1764886873; bh=FfNncgXOHz
	s8+Es09hH0P8sBhPOJbLzgE2ZhBtnqrQU=; b=k4+Ut1TNJ77Q45NhKEHNNxSYpt
	MiaW6A8iFouX7GY02FdwUacr6sfm1T7WQZqLaVc/bFeCdgTljFH60sBEYYGb6aDM
	hf2Ot1kULhk8nvpV8133uCUrQzxHmkvLrHWUx9uZyFN8eFlw/ImMxZqvRdWFN90v
	cTJM15bwDmoVn43tZVGn6yDri2eCQpTzi4sPTDVGryxsszSdqjBaFo79Jf4Mpre7
	7YV33iurdyw09F3S5f9HOH+PdvKbEzyFj89X+SpZb2zYJpRrkyy6ep/69ebKFOCp
	Ucgc+uHzT2R8GCx9RzlCWCf05PXm8KUgx4rarJToLlXT58pAjpZIPRY/GvjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764800473; x=1764886873; bh=FfNncgXOHzs8+Es09hH0P8sBhPOJbLzgE2Z
	hBtnqrQU=; b=RpqJm9XdQyu2nueLzEr2CZciLmsT/+/VlEKPXmFQBJLD9y8rMQj
	IAYQQdMezky7LeHW+FPr3PUsjcoD/MxbZqdyT0RE8DQxc84kRidsiZIcAjfoYk1m
	JbqdF8y27ZIdfpTrDD2a0y2KPiBEWxs/PLlD/XOvhTHgNbay9a5pdBHMvLYTNNhH
	GIFrI00vrJjbOJU01FFc8OMz/MFx3KM+ts0FgD4HRuSfRlFcGb7NFUJcjD7tIu6e
	x3cg9cLvWhNMoF5DMypLbsnlrgvxr+BSRsNr7BpXBvukim2CfF1OqtQK1qCKfL6s
	vQaI/+IAGH0SBzQ9loOSpwOqEI140NFdIuA==
X-ME-Sender: <xms:2LcwaVI-fwVKyfZs5JV-m8WNOEqGhvAHeZu2hzzYrXEEtMLBQ8ZIfw>
    <xme:2LcwaU12NDDP8LimkpdfHBmMSJegViuKAw5gcbZEEd0xxRBmY9XhF5CN2caMIB0VK
    c6zwZlykD0p5zUonummOQBjHA3obSHULUKmVglL0WnETaVrmiF4_hw>
X-ME-Received: <xmr:2LcwaXjnXsbfPmpPIrVvsMb317icVO4gJ7zJtAqsSbeHjWA-7db1-frUQTLCn60RBu5KcPpSPDMpgsqe9DR80JBrUX6UoNDc_zGn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehptggrshgrrhgvthhtohesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2LcwadXN6xDo09w57WEft5wR7jD17B5o8J4zxGXiN8jmFPRA3RGbew>
    <xmx:2LcwaeXQJezJtU1BrMvQnwMwMkCeBIMBVo5frmjLy7NUkTiJ1tUXfQ>
    <xmx:2LcwaVjOEz49ci9lme9hmlM15k-6_iaze62PT4u-EJpSsOUGv9bYYA>
    <xmx:2LcwaRZi-tCQEFv8f_qVDxJcVEMY8Sx73r2dsfQO4RXiVQNcyRV_9A>
    <xmx:2bcwacl0g7GnBthYxqnsrsqcCv8nODjpzbWQqabYYFUwkZZW_qXa9vL9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 17:21:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Paulo Casaretto
 <pcasaretto@gmail.com>
Subject: Re: [PATCH] lockfile: add PID file for debugging stale locks
In-Reply-To: <20251203211610.GA64204@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 3 Dec 2025 16:16:10 -0500")
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
	<20251203211610.GA64204@coredump.intra.peff.net>
Date: Wed, 03 Dec 2025 14:21:11 -0800
Message-ID: <xmqqsedr5hrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So I dunno what that means for your patch. I notice that the user has to
> enable the feature manually. But it feels more like it should be
> selective based on which subsystem is using the lockfile (so refs would
> never want it, but other lockfiles/tempfiles might).

Or perhaps the way to opt into the feature is to create an empty
file $GIT_DIR/lockfile-audit, and the lockfile subsystem will append
to it every time a lock is taken?  We need to ensure that a PID and
pathname formatted into a single record is small enough and O_APPEND
would relieve us from worrying about multi writer races, which may
introduce different kind of complications, though.


