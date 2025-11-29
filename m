Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00936D51E
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764457797; cv=none; b=ZdzeKEore5qn5SakO67EEFd/Ijm49h5hwZosfz+DIUZe/5fhPd2WsO2PLU7dbQlwS3PsTA1yENnhv0fWUJOVF1wZ4J4Y8BbMGBOSaoOcxHKvqBjJ0q9RNU3ycAl80v8ohSD6bVUoSUAIZUp88kkRNHtq1G/oYolzIWgGgEd94Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764457797; c=relaxed/simple;
	bh=jGyovQgBhlSLUgxJiq02rGXIbC5HbiaEuECcNl0hIKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fAgPK8/k353GfRAZqMaj1tvKFwHMFvuFi0+ftHmbWygdZTAbytD9dd58jKkdADvHj6D4zuc8UVWH4U+YdCy0+crcclp7vooy/oiHX5yBaR5qxTsmczk/l7gGm5op0FdlXxixDbsvC4k6JyIY0DEkExuOhHkyWfphFpNyF5QMKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gtn3X93/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VimCl+ja; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gtn3X93/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VimCl+ja"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 978C07A00A1;
	Sat, 29 Nov 2025 18:09:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 29 Nov 2025 18:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764457794;
	 x=1764544194; bh=vwQ5wKsh5tzNUucyPMGoEzyJAi/ErVa386MCqjFSq1I=; b=
	Gtn3X93/O/5BSoQDNOnH4XCNMdWXVzYucNuqf82VaquFgOHSQr0vdMgc9nzTXxwx
	K6qcBMyDOsV+EnBFOmpX75WRV+34ZaPYKNbJk4IJnUcjdXajXR0WwFr8e5cKH4g0
	hw2inAFJ9WsuM/IwM91+yVv24LHs2QJ2nkQxNkGUVdYDaF8D+6dVLI+q3JC5xvWA
	e91b8lprrZM1g1bhtcEi7o3gm18DljvCLqKOZzN9FlsefSJhR12U/jbU2vDFwjJg
	fiZ+/zLKeGUg/kkSzF6w0hmZVDPiZLKIfkEQ4H1QaZBzT+UlxMBjlTL/8FSBr0UF
	VWf5EqjbsoPuPk0DrGjaqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764457794; x=
	1764544194; bh=vwQ5wKsh5tzNUucyPMGoEzyJAi/ErVa386MCqjFSq1I=; b=V
	imCl+jaqxJOtQHqDm6Ih8hZbFZwL4uRKW2TMO0RZOAQg92WPrniEdKhjNN40Nenu
	MG+adlaPLFSVRsP1YRZrcQwL2Vu8iGGNSPAsvAhT+bk0EwAvh/fRDi0Mv6fcH6NZ
	DRRnCwLURPSpQD0BPmxD8undlcnYSZQm0utJZIXkI/h4NAMWL2iOxnaGnNlREkaG
	Wvyoct63QiE0qwAzD3z4OqUCoY8szrhVGj2OHvCMkMcZAKwRTiFOwIiocak3gnyE
	+4XqeM5n5gzkCtm5BMFGN8WbwLStyeSLyXtpvHpB//RXJDVypoRkiBUTg00Vn5M8
	q9HdF8w2e+57Ap7Uo6x9A==
X-ME-Sender: <xms:Qn0raUMybN5ChbDbRURRqqorLKtIz6S8uZfC_BWWWDHx3SAszbXL1A>
    <xme:Qn0raR9ZLLxxwUTotqKZimD1uU51GkJ3lZvZGGTL4HzV1S0VCiweWaGhKYIZ58km-
    SvNfYn7Ovn0N01Op_17UzjyPX3l-h50FFfqo9JVt638W2HEYBF1>
X-ME-Received: <xmr:Qn0raQTacW-V4pUmrQ_4zBWmMLNLw7tBeXUBrB7VcjuWnQtP-hlRz5hXPtgW1SzW2zNrA2ag3t7RueF806HiTTEIGGU2743n3HXN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthhthhgvfihh
    uhhghhgvshelfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Qn0rabl5KQpWlJCVnlGg7yoMsKB5E_OR80Ap2zW5qObvW-tUkRCVDw>
    <xmx:Qn0raYQ_0uhSqUDu_xaoBtuxEOvmh7WaVp1QoE9hl_s22CzOiRa_JQ>
    <xmx:Qn0raRPx21qrzfKvm6jPhv7zWFIPXq0HBe5IxzxwUkR6hui7E9e4PQ>
    <xmx:Qn0raZXKq4m57q8wnrl4PBLqQlrQma7R6bZnjtHl8vvh454Mj5qRTQ>
    <xmx:Qn0racOoE-JZhY2A74ReA5VykHlmiL9geHOViwwD-1-8BH3Gj7UOaXaL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 18:09:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Matthew Hughes <matthewhughes934@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Update documentation/discoverability around
 `scalar`
In-Reply-To: <FD92D0BF-E2C0-485E-A121-4C92BD20F7F9@gmail.com> (Ben Knoble's
	message of "Sat, 29 Nov 2025 14:55:10 -0500")
References: <20251129183236.52760-1-matthewhughes934@gmail.com>
	<FD92D0BF-E2C0-485E-A121-4C92BD20F7F9@gmail.com>
Date: Sat, 29 Nov 2025 15:09:52 -0800
Message-ID: <xmqqqztgcu67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 29 nov. 2025 à 13:33, Matthew Hughes <matthewhughes934@gmail.com> a écrit :
>> 
>> ﻿A couple of changes following on from a discussion around the
>> discoverability of `scalar` config changes[1].
>> 
>> Following that thread, I was additionally working on a patch that would
>> involve commenting each of the changes and why they're set. But that was
>> taking me longer than expected so I figured I get these smaller changes
>> up rather than waiting to complete everything.
>
> I think Stolee implemented a few similar things in GitGitGadget PR 2010

Also known as

    https://lore.kernel.org/git/pull.2010.git.1764195516.gitgitgadget@gmail.com/

queued on 'ds/doc-scalar-config' topic that ends at c483f0a5
(scalar: document config settings, 2025-11-26).
