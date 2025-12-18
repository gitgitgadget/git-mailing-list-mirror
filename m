Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B81EF36E
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766021617; cv=none; b=Cl5JhFvWZJgZ5ZInk1HpPIfeYjB2kPIRmy8Ru4OPH+rH0SGvpAd4o2kJd2k6oeWcTyzr9dyvFc2KB6F2ZMBZATZrG4TtdvNFCQo33jX05INAZzd77R2xbiG916289+YRvyzszAtNu+KEtX7CoznyDElIv+TkhvPwX/XphW0a/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766021617; c=relaxed/simple;
	bh=wyL+PwBpuCP9LbnAy6Zx3ZwVp9M+wJqlNBgx/bSr7XU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I2VHv9a6fqTNej9ir4Usixad+8Xa3G1Pl/fXJnBy12KSRMQp6R4sWt6kHWQ6LBJIxEKv7Rtt8F+2DizXtewb8N0Z9lQ9rojOV9WdyITecpXYPpTjdXmRRiAa3SeiMZYMfyfUX7/lJGBMNeFrWW1A3jEYuh5xNJ89878mVeuFwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kOWvkze/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ihgx7g9q; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kOWvkze/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ihgx7g9q"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0216DEC011C;
	Wed, 17 Dec 2025 20:33:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 17 Dec 2025 20:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766021613; x=1766108013; bh=jn+6cITbpj
	oC4BzEKuLDaq3o4IzQHMOvVnNZKvoA3TE=; b=kOWvkze/+fkGYHlgps84XC30eT
	WDfIdA3kDLa5OHIC6A+XMddYrLOiaiO8MdPBcn2SASl5ECHqjYRATpz2G6wYya1B
	I29iosmcx35bPn1feVWvM57GXADRw844/bAifAbi5ccl+/eiKuAsRLuBAA/sf5Vh
	MukkxJgHQ/15jl+5nbfLBjlV0r/xxFvSsG8Pl3FJBGc6wAZftkn9Mtw0OPucG+Tw
	5PMHv+7A4zjF+cONrQ0X1XfL0NYT4QCFuP/gSx1xCDnQIzN3brMYCvQXW27qjdug
	55MlItJORVELfayPFhZBkjdZ7vUrGwAKtkt+NPIEBVaerJoaDfZqqZUVf1YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766021613; x=1766108013; bh=jn+6cITbpjoC4BzEKuLDaq3o4IzQHMOvVnN
	ZKvoA3TE=; b=Ihgx7g9qtuh62SQMBS7dIj6LXNt1I33ZkGveiHdPxS6GCTyjs/b
	YtKIylXMb/JMFNYetXyUya6ibof7OehzGmPZ1JJIFMhDjq8UCH7JoiRbeSkZTp+R
	RfwMEuQOlHTEl5BxQS7+nmUw3i11MmI2DgWiFLlzt7bbonenDFLLTVLvFjb9fdaO
	t1e01NV6rouSaDliDa4/bOIPlOQRxSrFclkp0gx53LyzrIhsTq2ja+axeKzbNAYF
	mRqiTH6kWMBWqkX7WA1IBY3WV+sWUc4QEQhxbw9a1nndhIsKrElnMEj7CjXGeRRa
	hremOhbfWULCkPvVY6CSnawIE8jgG8Ra5hA==
X-ME-Sender: <xms:7VlDaZZqojLBmBcGss9pFszT8WHZbS4Sa7eEkJf2buFRsEhckYNC4w>
    <xme:7VlDaS8G5gN23LPgpTghk1jdZdYhD4fLSaBq9cDas5B0Fo5EMjdchx5AOFWgPiLpc
    ZM1CFl26dGmss976fB5ST04G5ztEVd2buXyMhdZO4Lf5XyDNFSiWQ>
X-ME-Received: <xmr:7VlDafmw8E6Mpx63pJ5auCGg6_F1bEIxKsuRJTh73VH6ynWNGNmQFQMaXHBCgwPfnzo0MZm5UpZTbDkZFhpdXD62Q_0AtBI_IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehprghulhhordgtrghsrghrvg
    htthhosehshhhophhifhihrdgtohhmpdhrtghpthhtohepphgtrghsrghrvghtthhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7VlDaXzFk_xFOzM9wyohWJMrAS8mn_-V9x9vwIJyL9_s55HbDTkaoA>
    <xmx:7VlDaZ6tKGZ_8_9P0iRjL7rzQ4vSBHG4oqLkVRebGiId151JAcsGJw>
    <xmx:7VlDaXWWly6HxkWmLN5fCBzbXsihDCBrhvT5lPlJTujmOrMG-xFqWA>
    <xmx:7VlDaRIqm_r6eD26rG5f4jlWQYECR5ZDSmRUtgGIdYgFCy33q76mtw>
    <xmx:7VlDaU3oJB_F0H6a1TTJnkFi5pgaaRa38-pmAxsDNkj7R48AwP-pCZiG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 20:33:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King
 <peff@peff.net>,  "Paulo Casaretto (Shopify)"
 <paulo.casaretto@shopify.com>,  Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v2] lockfile: add PID file for debugging stale locks
In-Reply-To: <xmqqbjjwzkd4.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	18 Dec 2025 09:47:35 +0900")
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
	<pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>
	<xmqqbjjwzkd4.fsf@gitster.g>
Date: Thu, 18 Dec 2025 10:33:32 +0900
Message-ID: <xmqq7bukzi8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> As this is about lockfile, you need to decide what should happen
> when an older version of Git, which is unaware of this new world
> order where .git/index.pid.lock declares ".git/index is being
> updated; you should not touch it!", comes to the repository.  You,
> as a user of the updated Git, do want them to stop interferring with
> the operation on the repository your new Git is making, and it means
> you should have some way to telling them "do not touch---you do not
> even understand what is in this repository!".

Ah, sorry, I take this back.  We are not replacing index.lock with
something else; we are adding index.pid.lock in addition; older
versions of Git would simply ignore the new file, still notice
index.lock and stop.  So no need for extensions, either.

