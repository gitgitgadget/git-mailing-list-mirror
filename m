Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309F2C86D
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570512; cv=none; b=GyjmMHdDh0v4CdUomVW9jBYyiCZCrP5vRg3J3KLTRAftDEatGPBDPcVQ+BAS3OZ41F1BiGTOHZkqgZW1NFf95bcECcxlo9kc5gFf6+UN4mrgOsidR+7pjHOMbTjYHhFmkxh/xlHqDfWS22jAMvesGPLPHS+IvdyrIjqAG9rr72I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570512; c=relaxed/simple;
	bh=L5mdPW+b8b8rtqRpal2+q7M0uTxkcOVOXm0id5Nali4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=er/hcoBkYvfxx3HIu8QZxzez/5J6fC/Bima3xLaFaJk4kfhtTh9TfPJd1xVvT8NIeVk8g/vJolyTGVK71jMBOPtPs1IZWi2P58UBrnXRH8tsCihnmUIxwPwZJDMPfQEgOQHzKVkmogfNpEGPa+CLvgZgb/sgRcXZjXTBx5AYUG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FARRM4kO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3Td7elV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FARRM4kO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3Td7elV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D05B0EC0230;
	Fri, 16 Jan 2026 08:35:09 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 16 Jan 2026 08:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768570509;
	 x=1768656909; bh=2dy0Wnv2ecVSwMbjr5W/Z5RjpcyWlyl6xOmlv1WuT/0=; b=
	FARRM4kOYG+/4ttDQbZ7fplFqpB1qudaSbbB3XzUwHhsCqynSrwfIIqZ/vKsmodi
	rmQJsbcm12xoVUt6Lx0qNceScVvN1sh1AGPs3udJXJX/C9mcO4sHZajFlL8htDC5
	BJnMIsO7+J6uSuUdd+whlAX6X7T0wo1mdUZuV70DCHDeVXcZrKqEGx+y7GeF4f27
	JvQnXfaijAN4qaCIp1PxwJnXvr6lrMNcBxqSGLStxaGRzcyZOJzMLFtJSTZeIs3Q
	njhg0GEAMj5DDgDAelwVOTDinH7s837WDkqOrJpgIuxYey46XbsCejp29lne1Kfv
	gVbAeJ9OCqCB1lA0ernv5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768570509; x=
	1768656909; bh=2dy0Wnv2ecVSwMbjr5W/Z5RjpcyWlyl6xOmlv1WuT/0=; b=T
	3Td7elVkoDjCqRZBNKR3P0cUxMj79GzvZy49QCjPIAeMaJtm9OP7GgbInyQxvVju
	buskI4t9DWYMdjX0FBf8/dHIcsPEwTuRO68FJpKpe32PP65E+9D229SGsEAsj6UA
	W6hZCXCDbC+UPafcXnj8tq+4FMh0PcQLFmUDP3tdUqNKlqc/c/USNH74GcckG1FC
	vMpQSUSTjlUCx4xmKht2Dlm+e1inWEj5k4QRdVQC7hUgF/J9HQblUyBk02tlPqTL
	O6vXucsT/IhUO+SP5zE6jgAvLpxtYRn2mGuKyR6jdRYiGEkVLCIoujlWYq/IMucw
	RajYgy3FSpQXdXM1tLPsA==
X-ME-Sender: <xms:jT5qaR-Hb9fBlIXsuFVnegCzBsL3PK1Hl7T8YJ91nlvMWWgCqy2_nB4>
    <xme:jT5qaQg2BTxuuiuZXQ10aDE58qjUdEvXe5aEGWV3yW_vqXg9TTHml52onVqXjpCJH
    ZPv9y9mcmI_Jg6sX-XTjRAVZeV1PbFSoyny_DM75TUBU-Ys99IKsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeltdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdekgeeugeef
    gfefudelgfeifffgkeejhffgjedtfeevhfehjeetgfeftdefuefgnecuffhomhgrihhnpe
    hmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhushhtvggusegtohguvggsvghrghdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jT5qaT7rfLsXy7ys8yTAGx51fKmPKZ8Jl7Fbf81Vl3GttbBNCpiVtQ>
    <xmx:jT5qaQphfJkMGQc5ZIL3f6XX1cP2I6ntldq-8zUdcI2agDOrs3ZeUg>
    <xmx:jT5qadjIvaR0fdpAcO6i1ebpNMSWt4b3a2685CtSfsmSOaYBUuwXAg>
    <xmx:jT5qaSIV8ijNb2gIhBbywkhFc9m46WH0h81mBUafCe38wUC0jaqk-w>
    <xmx:jT5qadaA8zJGKndjargkc3WWqlwLE17Lf4KgN7gnOwvJnqD7NbKE-V8l>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A15641EA006B; Fri, 16 Jan 2026 08:35:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFt1yHiKfriF
Date: Fri, 16 Jan 2026 14:34:49 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>
Message-Id: <72aabd0f-bafa-4013-99b7-f065e8977f8c@app.fastmail.com>
In-Reply-To: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
 <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
Subject: Re: [PATCH v2 0/5] Change git-last-modified(1) default behavior and add
 documentation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jan 16, 2026, at 14:22, Toon Claes wrote:
> We have had several reports[1][2] from users that have been thoroughly
> confused by the default behaviour of git-last-modified(1). Most
> importantly, when using the command on trees other than the root tree
> the requests are seemingly ignoring that request and instead blame the
> top-level subtree. For example:
>
>     $ git last-modified t/lib-bash.sh
>     acdfea4394db8e8b42f48e36f7726d64a909a89d t
>
> This result is completely unexpected and feels buggy to anybody who is
> not deeply familiar with git-last-modified(1). Furthermore, users
> typically have a hard time to figure out the correct parameters.
>
> This series changes the behavior to something that intuitively makes
> more sense.
>
> The change of the default behavior is done in the last commit, in the
> lead-up commits changes in the documentation are made.
>
> [1]: <f0c508cc-5c6b-4c4b-a3f3-0cdd8d1071e5@app.fastmail.com>
> [2]: <03f96860-29fc-42a7-a220-c3ec65eb8516@codeberg.org>
>
> ---
> Changes in v2:
> - Change the default --max-depth.
> - Split up commits in smaller pieces.
> - Add more testss
> - Link to v1:
> https://patch.msgid.link/20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com
>
> Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
> Cc: Gusted <gusted@codeberg.org>

I think the Cc list got mixed up.

>
> ---
>[snip]
