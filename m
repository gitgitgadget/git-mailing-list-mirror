Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9301D61BC
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 20:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771792550; cv=none; b=kqEC+fTWCUIZXDPRFdVbm3o3qdyBcLqyCoys4LV7dpZqWen6FCZKfSwjQ2N4W4Y0+XdzsvduysH6xSD0U/5HLanoGgNtB10xBRn6x2KzjniRwNJbr60/DvlSfTBJO9WCpxLVo0+uAPb3z1D+8ucLWBjpdBZuPE9X55B7rWNp+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771792550; c=relaxed/simple;
	bh=PfuxcBIdOoqkDHXmNb3wy6unD1NaimTq1s9MorCO3GI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m60HscDIQvnezBSuCGyrQe2dWdlh9cfO9v3JzVJmX8vZ9XWYlPq2Q5baK/Da+IdBUNW/OgunmHV71b3mPHXq3UfqouoToCq4Sug9viDrehwEe0mEdHhquoLDqBsg4/gw+ByczRooddwBlaIMjHqMO9v9XzoO9itoM8ogqdvcCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RQPgEezT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RHv9qs+0; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RQPgEezT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHv9qs+0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CA901D00177;
	Sun, 22 Feb 2026 15:35:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 22 Feb 2026 15:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771792548; x=1771878948; bh=S0S41KzprO
	pQY2z4kPUWOluYOsNBoeMoe0I+xVnfZv8=; b=RQPgEezTPIjPEPeucv8N66VUk6
	qXtJErXQuodpRyWSW1poCtfFDZ8E9EULHxCfJCjydDvTq9+atKK4yAm7nm7GGTZ3
	pRpwEEJXFYPdwGNMpBJWofUzafmxb6bvcKsL3PCBAfqcOVKGc1xPIfIit7kzaSkw
	0wE3KNy/lcuTlNTAsCr8uJkZxmX34FynFv++eQToWNNjiSmVYFmyNFwp3UzemNWo
	fsvSdxRIdrv2c8i52ORrImPMHt4mL5jQW4d9btAinMyDdX0LS4iDECZjsGtc04cd
	zj4BQ9qrKfToO5QM7Pl+LrI/L2AazkRjTW5k5dbIDFXX8FF+xAEiMs0n1nZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771792548; x=1771878948; bh=S0S41KzprOpQY2z4kPUWOluYOsNBoeMoe0I
	+xVnfZv8=; b=RHv9qs+0BNDGJHAWgl0PCIgWOmYGW95TTCgcun5F7hh/Ie5FXzN
	kKdsO2WqDCU18v1/2ldxt30YNfKDBnWOh/tBay+t+vPZ5xGIYaO+qY5JcnWOwmQY
	yeOIUwS5I8NrUXk9dzXNQ0pqdvbsSev/SeIfOK/HVSSlnChBngcZJaoo/qOCl4R8
	vEx5R5RCQXT9B6s9wXtxZT9OcF4L39j6Iiw2S7X1+6JfvkbB7EUIvaCI1playxfR
	pHT7svvEVzrVn5YEut2ZCfsdmrSoxP8TL3ahjIHiEtDWlmO9WEOAMVpb+CBaXJfL
	vAs/6pLDkIGE2EZ4OwvCQWOZqWshQqsEQCw==
X-ME-Sender: <xms:o2ibaQrLMSB35_YhdA7xvXcNXsYP24yVy147jEfEax3EftVMVP-FvA>
    <xme:o2ibadovBa7Tn1sf3nvfh2sSz4Q5Zvk_hyhqYiaQrAuZhG3stTWOSwxk-nS6fQToI
    pUCfp532P9GhcS_942Gec8DuyC73px8myPl94r-g1IcOs_4dKaSOdI>
X-ME-Received: <xmr:o2ibaaNJFViXJjCF43k0zwttGEM_tDPDub2n44Rzv_hc23R-HPWEMTPXxQt0pr12wneDpeckuJRVvBuWMzsQMEjFHUJYZY6rZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhrohgvlhhssehthhhomhhsvghnrdhiohdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:o2ibaWzanLb-ejefidrHkEy6lXLyVNJaMuMkgzors6C7tf8uPTgy2Q>
    <xmx:o2ibabs9112-0u810cPqsfFMUASHstqQSnONvmi5l8S6V4foM4Iyfg>
    <xmx:o2ibaX6YFbelJ7vLy3Px09WMXMNCDAR3ZHNQRBxJX-9tGFXcm32q0Q>
    <xmx:o2ibaSQ1RrvKMM_d6NH9EHknGcANnrQezrm_Rpg9T2RFaIAhHAONfQ>
    <xmx:pGibaZu5FPEPhB7b87rR7rocjoP0Vv9jDk0Zm2yDNYlMcSwkqPtMsH77>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 15:35:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Troels Thomsen" <troels@thomsen.io>
Cc: "Troels Thomsen via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] receive-pack: fix crash on out-of-namespace symref
In-Reply-To: <ead4041f-bbc3-41ea-8729-9534e69e5e83@app.fastmail.com> (Troels
	Thomsen's message of "Sun, 22 Feb 2026 08:56:55 +0100")
References: <pull.2144.git.git.1766850014289.gitgitgadget@gmail.com>
	<xmqqfr8uk61i.fsf@gitster.g>
	<a16bf8a6-2f57-4794-91b5-92615f184c4b@app.fastmail.com>
	<xmqqbjjgiz3a.fsf@gitster.g> <xmqq8qcmt4kq.fsf@gitster.g>
	<ead4041f-bbc3-41ea-8729-9534e69e5e83@app.fastmail.com>
Date: Sun, 22 Feb 2026 12:35:46 -0800
Message-ID: <xmqqcy1wqzx9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Troels Thomsen" <troels@thomsen.io> writes:

> Do you think your original concern could be addressed by adding a note
> to the security section of gitnamespaces?

Not really.  Nobody reads documentation, so it would be far more
preferrable to make the default strict, with a documented way to
optionally loosen, than the other way around.

