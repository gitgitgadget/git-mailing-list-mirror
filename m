Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7B280A5B
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802581; cv=none; b=h+M4U/aSFgOj11/kankf3lTB8m61zV4VKd8bQpKK5qT9LyFAN/V9qq8l3R8E8UgkmJ0mlYcYTXBGVhKWcbeSnGqmJqfXEUTflWm7YcQukTfMkbPpmLrktw+o+BhNEZ121uEuK7065DwaGF6OVRGt7lcyghRjNO0OCV8YNbetxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802581; c=relaxed/simple;
	bh=VWGedSSAp1i7DARp7dKo07vIALSguZuuTn8QYYwgDhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mug7d2zAaRP7MBo/M1ItTtdnk+c8ByZtzn3zo6nNMt6mkEQuy4Ma+pz3TIoEpHT4S3sT0swevCklzw2tnFRRsVBXS+02LvhJwsD8lWizdruTC/WmQXkBgiqOIJCUf6FDqIsdkxwF4D8aJpueLC2QNgauy2BwDbUKeWLYEHXOy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BmT2miAp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=naVFlbQr; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BmT2miAp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="naVFlbQr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 343321400199;
	Mon, 10 Nov 2025 14:22:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 14:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762802578; x=1762888978; bh=03nPt/byqU
	ecSypUGRAf1Ib/VMWllXe3PZj5sz+XWuA=; b=BmT2miApEziGe1eD2rMg2sBpRs
	TX3utc8VS7WzCxi8+9mZfZGKJi0FgM5JSppvs5wQsJ/OVcDsGtH4UnNgVldmraZf
	+oJN7uML0IcHoR9bsGyAsZDza0IL5eEu/iejQNf4V9E0S9eb0Ad2WK07m7TkE4ZP
	4K7Q51OSTr/JfgO9MhSGs8J756lOUR0zLhufbBZAGsgRhsXy4hKaU9Pr6zGWZuA3
	ojxgzJeyJeTw5vah9dj5X+aRaryqE3XpMF4ejSRFsznBxJOEp3xht+2K+53miLYt
	bW04tykCiUQC1lheP0SWpPqsNH0q60jLZO1WIt3LUPgyCH1B3iMasFtvfKjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762802578; x=1762888978; bh=03nPt/byqUecSypUGRAf1Ib/VMWllXe3PZj
	5sz+XWuA=; b=naVFlbQr3dNo/65OwxLFnNZpXJngRrpJaFz0530PnO650fnlNwz
	wH/DxyCcCs0FyViByGMl1AVJmykkocmnvIcsnpycZYoY9fTxvVWeYpLECkasiAxY
	10mBmDdazZUFtA1l3WQG70eNRFaQ4Vs4lAeRRfQGa6yca4WUZrfYbYFaNiD/fduW
	VASdHPDbJbyhokJwGWXSX1/14nXNL8esaAZPr15Rn6ZANrdwPI4EYJpDdaAenwcL
	wovMExdMiPn3+4V0cOiAfDpxRCKCwVmXws3U5KmIdyIJJc00dIF0idPUEOzVfio3
	cg9jRbKffjHbXbVtSJrbB0w6Yi1n39/KNVg==
X-ME-Sender: <xms:kTsSadIItNpNoDLj97xiMCd0xdgybi2MBUxq0hoF31OoX-ChTcblHw>
    <xme:kTsSabZx-hqJsMHqvHv-loZsyjH3yZPryT1Q3EC-iuTuWGWJV8xtRfW2yw7gQ_NwL
    mNA7zpRZYsStiQOfZIyiZr7g6ig2Ri9dU53ZyVWuaWLrTNFDP8c>
X-ME-Received: <xmr:kTsSaX_K1xEdQFLe8aS3-QXQupohL6ncX3FqmYmefe9MTxi5LyvHkBR7dYqi7W1GkP2Awn5YXNUcSOKCNUxmbvJ7aTg2LqCq3UP1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeludegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprggulhhtvghrnhgrthhivhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kTsSaUbAktbKo4SXGGl9SY_K_ZTSNIyveqAoS2x4eaRke8cxWLYK0w>
    <xmx:kTsSaTOWd3FqCHnTf0Kprju1RrQzKgCUQsdPFB2Cd3IxkuSInzr5FA>
    <xmx:kTsSaYAlLsTjQD6j3ECQ0Edr2TY7Qy7Ajg5cxwL3ikRbp30MLJarMw>
    <xmx:kTsSaSJTMQMk5DZYfcCVEWZyRdVQEr7sAlXLi3YSWVc53WuTDaSfMg>
    <xmx:kjsSafc3VGEjElcGw87jmhkTElaQg1Zr18hExdKyOkvTJzOrOTqfbZqP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 14:22:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>,  ZheNing Hu
 <adlternative@gmail.com>
Subject: Re: [PATCH v2] commit: add --committer option
In-Reply-To: <pull.1997.v2.git.1762793782815.gitgitgadget@gmail.com> (ZheNing
	Hu via GitGitGadget's message of "Mon, 10 Nov 2025 16:56:22 +0000")
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
	<pull.1997.v2.git.1762793782815.gitgitgadget@gmail.com>
Date: Mon, 10 Nov 2025 11:22:56 -0800
Message-ID: <xmqqo6p9zo8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> Co-authored-by: Aone-Agent <aone-agent@alibaba-inc.com>

What is this second author and how would its presence in the author
list interact with your DCO obligation?

How did you make sure that whatever is in this patch were not copied
by the "agent" from somewhere that we cannot copy the code from
before deciding to send this patch?  The "cannot copy from" may come
in different shapes, from "their code is proprietary" to "their
licensing terms are not compatible with GPLv2" to "they welcome us
borrowing but we must give credit to them", any of which we should
be careful to avoid.


