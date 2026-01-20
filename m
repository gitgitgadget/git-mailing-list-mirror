Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A2426693
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945336; cv=none; b=ZejeekfVUjFwnFghIq3krIO80uNasQ0NUnXjjoa8JMRLT3CQlBRCEpt2hKsbWBs49djXY1E5mvZlcNuxTbK1L1gNrTCJLUWOZmYASe9Uf7oqr5+mGHY9Hpi6cxL//d23MycW1/vDTXdC+ENDzVmImSm5IIO4b+M0VNH1b7qyyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945336; c=relaxed/simple;
	bh=3rS0FMlrzhnrSg+v5rn59VtoerSNWqlv4qCwKfqODcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D/0xn9B+OuECU5TMLsRuqz3e1q3DDTKQWZLx74HWG0ry0FsoDYQE65uQjm9impfV50o7ncxDgJkvrMcdxnU2NTtZ7alTgeVofs9ypphxKWRZiv9RmU33Lr9CFpKcAvubYzjtNL6SP9ZrpqSKb6iaDPQ+hQd3uPNkLNbZb1mH2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RLvr434b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ogTSyV7i; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RLvr434b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ogTSyV7i"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 144251D000DB;
	Tue, 20 Jan 2026 16:42:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 20 Jan 2026 16:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768945329; x=1769031729; bh=3hjaMYLypQ
	b/G08N0XyRIunNLls87bzZu92dyflErJI=; b=RLvr434bncEEVG/z55WmaW4L8E
	tI03xPV/Jq9Hcl9tZT1QdCj4haRnyNVNAUELoAQDh39nDsHZ76kG//CGoEPAjOk1
	i6CQYxJgdY9oUaV1j4gKF+Qb5+ho9miuCXtiJ28HuHfCrvp9qZ/QjBaQ/Pdqp1qF
	JrRA1bZPKCxgRtUzMa5yFnNU9N+Rr8EKIQfMR5DKX2DfOndt/q5jpawFQpZKUiz7
	BtDki9fLioPQUaN/sUve9q/lk80vh9LRmAYSKer748OEi5/AMw1VyQt+s6Z1Idzl
	vS+8m1i7GuKcEMU8C+8ULKnD4zxqgOYetLxOG1xnuieJizkLEP/aIfZBBTqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768945329; x=1769031729; bh=3hjaMYLypQb/G08N0XyRIunNLls87bzZu92
	dyflErJI=; b=ogTSyV7iTlql9IPoP5QVRPnze6GWR2yaaNdaq7kFphcNnerjf5R
	u1KOuT4rL2YfOem2ujfY2vvCQ1SpoU2kSqxSKOLa0sCaR3G+RW5X6dGPG1NizZg4
	RFlsglMPQzL2Rpj8XCDjLtPjigO8fLfUlOH8b81ZdvtsgHuhGuYWrQlk1bG59yR6
	ApIDZvL3WDPVm+hW50shzM4xrhuLu1CKYIKvEVHFulojamuLaSa/+r/Xx44DaiIY
	huP6TPmCTzvXBvaBcfXjxbhSqyw0f3PHVT7ZU91g/JRram4TA5yi73PVBTrfckKc
	/0ZKHeMImhs+J3sVEUQNTTNR/CMRK3isLxQ==
X-ME-Sender: <xms:sfZvaab3wCKAfQregzv4_XtOvGf7qeuKNHNiDpJg_gQj8YbkHLb3IQ>
    <xme:sfZvaUR83YaOynnupjX0blE8QJby_xIvOdXrN8hzzAz7uFEkBcyd9A_jV3r8mNj0X
    KX51PZxYP6NUNZdeZ63cELNOOi2XORGxxRlO2nXneRvgvHeSLQtkhU>
X-ME-Received: <xmr:sfZvadSTtZNZsQ5idbd_VRIlpRsEu-d6gfcDo68Nho13yqw0cwj9qurF_yVQt7z4CLKVX4G2ysiMFEe55_8k4KQj2kPC1M2eIxyl7pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:sfZvaYSTMaykx1npOQTSYaxvX4ad_2qyUZ6mIELi9lRALKBp4aPFCA>
    <xmx:sfZvaS4kaoaZiHJS5JqPwa0B4CkaitIu2hp1ccq-HtV5AUoeKPXA6A>
    <xmx:sfZvaU0VF9rn5dZiekG_005-QyHn9CqdBH1aShfX8X8Dz34tw27Suw>
    <xmx:sfZvadCHLFh0bSOYfHwkc2REIumMkTw5QIj9fPsxVrfCNA-KNTWO0Q>
    <xmx:sfZvaQznmQDK945xCNXMiIRj-911VrzV8TLv8EoczhX02BTgCLF8ZqhY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 16:42:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com,  peff@peff.net
Subject: Re: Memory leak
In-Reply-To: <20260120132202.1655-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Tue, 20 Jan 2026 14:22:02 +0100")
References: <20260120094957.28855-1-haraldnordgren@gmail.com>
	<20260120132202.1655-1-haraldnordgren@gmail.com>
Date: Tue, 20 Jan 2026 13:42:07 -0800
Message-ID: <xmqq7btcx8pc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> My bad, it does fix it! I think I applied your patch incorrectly the first
> time around.

I've queued your v26 on top of a merge of Peff's leakfix patches
into 'master'.  It hopefully will appear in today's pushout.

Thanks, both.
