Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165118A6DB
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739921897; cv=none; b=MB0BkBsTCZLPclBS5k5A6kOjehCBCSBOZMmCvwzEGgM88zB79x3hV1pQtbTa41cMv2LZ3kc4FLPnNTLUmSggXHgjK6rwSxnhpFlDZRs0KrcLfCYt7tQuELlhwP3a8ugpEuZsdz+cwRAvCw5vOr8C1r25yhg/6uuY4e7Wc1zBPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739921897; c=relaxed/simple;
	bh=h4VPJ1EHbpz4t8CCY1mNybGPP1xRw8vHWdheCept6DE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NlilAImlMVKN/W+R8owXcgZVKMTDp3wv9CRK4qCVeXQy7KSpW0jc7svy9U8StzlBcH6Y1n8/hz9DM0hTEyWXhE0guOd3DdiFrgKle2yztpmWLOxoX8irKSU1yEHYscGl75Ro8aiHR7i+Lw3+FmfTcUruXSwA5DLzVtFWj+wIMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rrtjUUv1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kvk8eu8F; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rrtjUUv1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kvk8eu8F"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C413114016C;
	Tue, 18 Feb 2025 18:38:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 18 Feb 2025 18:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739921894; x=1740008294; bh=+Js6tdeFKg
	RI/+7aGthHejVG244L1cuuVuStiaUuNLw=; b=rrtjUUv1pl+i1/oPi317BZDkIv
	v27B+wHYz5KIGWCwoKllsKsWfP0bhiIAcDV5pXkP/eIH1VKqPKWpEDacD3xDzllS
	ctx+VEBKEyDS11lLyhdd1PkAF8rt7wIs3pwHx15wru2bFUtHqwEzVmJRZZqm+vk2
	kCXfqS/AwkxSG3CdoS1mZNNTsFDoQh6nHYiHxaAbkowg1F6uG6p/PRL0CuhFS+SJ
	/sNesVTllRs/YfZhVNKX7f0VO7mwH/NzdSLl8169hnx3BUtbJa0EvvE0K8hJeQ6d
	tWoIF13FEYRrD/4ofr4B3OF+qXA3yAHiHVa/kq2hw9fgtlaXjL/zSQG41D7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739921894; x=1740008294; bh=+Js6tdeFKgRI/+7aGthHejVG244L1cuuVuS
	tiaUuNLw=; b=kvk8eu8F77RrlSFrkR8CnI34cP06ggvyHax50VZ+DjeFh+H5MjA
	1chU4mGvBQd3nFiaQCh834hvPE8QG9ppkFYDBJC/7KC+lES+un7f5p32o++YOy85
	eL1L6N2EGgqY1pA4TE7xdg0/+bHPzV+RBEZYfHtaJM07xtiUbXdEFwWgvIaFt+31
	okbX1I7jQibMGlTbyQ8OCV6R2TBakrLEvE0dW7zucrBKnNrt7aaMppFTyEUgdG7v
	XEPeMqrm4QL/3IAAmLA78qvwWZlDnufm/HId6YpUuotNDlipQm5KGmyf6g/AUrg0
	1+gbFQJkzgycLtfPwvRCZrdUNOteOxMzr9Q==
X-ME-Sender: <xms:5Rm1ZwZDutSaBBlwPBnooggmujJ6J0u_0js98sRFoF7cuodTW2IbDw>
    <xme:5Rm1Z7YJBDGB_btN_F481yMnFviTRVZWYE2sCvakmulszE-gy9-2OMzJfCr_6MdfF
    Cmcyfj5otbuOZTmYQ>
X-ME-Received: <xmr:5Rm1Z6_-mT4x6fo3mZ2BAAuCmdF4TKZJTTr5NHifGtN6L8RfmKtA4WH68U0TOYrAY9RMKQ4ZIsoS72bbR_iHQ1o7y_g1NQFQUiHReQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepughhrghrieduheelheesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:5Rm1Z6oWmtK81Wr0jnj6EEcicGtUwwlo-2EkOiqK3GiiNtn-Tf9s7Q>
    <xmx:5Rm1Z7om9KiGn69kgcBKCZnHulQsGsMgYIjYuCIh8P817sCXJwrezw>
    <xmx:5Rm1Z4Q1Hsurc50xazJDX1LsmlbeBUR3VCogmaFK3n9xNSuHAFXZpA>
    <xmx:5Rm1Z7ryPuCb3qhfnX43i7VXoep6G9iF7EpZfB34oQ4bKDhi-NbX_Q>
    <xmx:5hm1Z6VH3o9G4UfJyhlFmytbauknCuhtm-Of4PSLE1nPY19cx70Sgt8k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 18:38:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Moumita <dhar61595@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userdiff: extend Bash pattern to cover more
 shell function forms
In-Reply-To: <20250218153537.16320-2-dhar61595@gmail.com> (Moumita's message
	of "Tue, 18 Feb 2025 21:05:27 +0530")
References: <20250211114611.9334-1-dhar61595@gmail.com>
	<20250218153537.16320-1-dhar61595@gmail.com>
	<20250218153537.16320-2-dhar61595@gmail.com>
Date: Tue, 18 Feb 2025 15:38:12 -0800
Message-ID: <xmqq34gaj02j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Moumita <dhar61595@gmail.com> writes:

> From: Moumita Dhar <dhar61595@gmail.com>
>
> The existing Bash userdiff pattern misses some shell function forms, such as
> `function foo()`, multi-line definitions, and extra whitespace.
>
> Extend the pattern to:
> - Support `function foo()` syntax.
> - Allow spaces in `foo ( )` definitions.
> - Recognize multi-line definitions with backslashes.
> - Broaden function body detection.
>
> Signed-off-by: Moumita Dhar <dhar61595@gmail.com>

Applied to any one of the recent tips of 'master', this seemed break
tests and the reproduction seems to be quite easy.

    $ make 
    $ cd t && sh t4018-*.sh -i -v
    ...
    test_expect_code: command exited with 128, we wanted 1 ...
    not ok 6 - builtin bash pattern compiles
    #...
    #			test_grep ! fatal msg &&
    #			test_grep ! error msg
    #		
    $ cat t/trash*.t4018*/msg
    fatal: Invalid regexp to look for hunk header: ^[ 	]*(([a-z...

Please make it a habit to run tests after you modified the code
before sending out patches with the modifications.

Thanks.

