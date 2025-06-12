Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C02153BD9
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772168; cv=none; b=mK1k4JXvmujIwGgxmXKaCy1KaTcOYz82404iMjx47eygRQ6l19GxVMFkPzOlKnm3LzO8lNty1N2TsXnzAAHu0+6kYoU8pHoyad0rUiQFUnt1gwA/j83ZkdtLdw655EFCf3tGlMnh9whQOkoG9V513yFskOovOLxYf0CGzLvAFl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772168; c=relaxed/simple;
	bh=HCpu9kNR9GcODP84mKbtzpY0jYd+8PXLmFmRnFjSo9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sqmrRVKEwE68+bP4/K2wttWr2ixkXARUUd8Cf41oTxMTVTTs6F1MccCTT2JITsrQrAk6Yk7ZBLPZHnueXkmjPjjWacv6kizMZRUg1JDLCRjmyGv4VyZkKmCdB9urFGztGUZAvp99zLtVKG+hZlRhlnh00nZVWPCJNtfHw0+YPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ImDck0Sd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aSxEm0Wn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ImDck0Sd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSxEm0Wn"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0506425402A3;
	Thu, 12 Jun 2025 19:49:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 12 Jun 2025 19:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749772164;
	 x=1749858564; bh=iCTxgj6piyxnM2qK6oH4IbNO71A9EJU9yM6u1T/Ut3E=; b=
	ImDck0SdyBdN1OchJtThON4RiZ7HwoEza8zXJCMQSJ1zu4EsNIO2yHcZk8zt3ksf
	dwRkJPT/HOT5BFblZCsMOgmVjYTxCwaNAMWxGDqfJrJOJwDDJRAAaSc53+a9qa39
	woydZLg05TjSCXDoT1LRvt9uULZWz5vIZII2XubuhymCrtIp7w9ZaPXgYPhwkUXY
	H9yHJHw22YnrL7j7Sr71wByZV26pT2spNbceQ9AXRzGZCzLlDF/08y4BnJqnAFO6
	lODUEx/VihtKIi7yszmA32dC7+FgcX4txoS00+bGrHkftSBEiRgioQHjiAZhLzXR
	xqmfnENN9IHJDN6DgMFqwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749772164; x=
	1749858564; bh=iCTxgj6piyxnM2qK6oH4IbNO71A9EJU9yM6u1T/Ut3E=; b=a
	SxEm0Wn3tAiq1JivcjHRu11fH8XWPjhrUUELTdNrupbHWeBOXiMGDbgF69Y4lWoB
	U0itYEZjoXQ2mKOcpu9SSC+w+ykOPcm9w8rjg7pKE9gfnR1mBbzbR3qrn/WXZ0JZ
	dvp/WLymSjXzaYhhloawk6J6MR7okwq/UFwoih0/++m+oV659iMgTzqNPWwIgFRn
	eYMK4CqgfrWk5E5sCYc4Hekp5isSiBRqOD3uFOmUT3pEhdo2/TCbZ6oAnN8unUXt
	xyyN3XgYTseUGSeTd/0/v4pEVCkVc/0/SpF5KYorc1yPG33vdiujNNrLBl2YkKqu
	Di/OReoENwQKaOj3NbqSQ==
X-ME-Sender: <xms:hGdLaJCqI_annQht9mwo4TClpkcoUjVRj4LgUBD3QxvO19tyqqGpnw>
    <xme:hGdLaHgbIz3yWS6UMb4It3UCl_8GHnXjmfZ7ypoeq2CKAoD-bWRMBRTAq8H2fIOeE
    oi9hec9j7FEcaXmfw>
X-ME-Received: <xmr:hGdLaEnaoOz4v6morJooq4ulW0GqNFFJYYiZH6JSQy1pfe_gP99h7dfYEvyWqA2NUD9lAv8q2oVFOnX8NvevqzNCuMEBfxnebUqH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduieegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdej
    hffgkefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhht
    hhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihgrkhhlihhushhhihhnsehgihht
    lhgrsgdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hGdLaDzzyRKSO-82uxZ9T5uO4qIaIsAD7cQpoJWjk5YHQa3BSqCLfQ>
    <xmx:hGdLaOQ8GPDm7V8Q9RHyjOHK10Y4p36oNVpkL7ma4K-liLEUqME1lw>
    <xmx:hGdLaGZhHVx120wynOnZEQ2dFUuTXH0HIeb2ny4IMX_7COoQN2raCg>
    <xmx:hGdLaPStqU7cFlxQCkOXlqVaRsgTl0fUYpI8bk09_tptYJUso0YMkQ>
    <xmx:hGdLaCaNqtuCHSqgttUvoFHEMQ4Whk8Pa7AVuWTxnt6yGjljxm1NgcgQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 19:49:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: siddharthasthana31@gmail.com,  git@vger.kernel.org,
  viakliushin@gitlab.com,  johncai86@gmail.com
Subject: Re: [PATCH] cat-file: fix mailmap application for different author
 and committer
In-Reply-To: <CAP8UFD1hBo_ZH1nyGBOoQOwx=44CfnkhEOHYu3_XMwSzXQAHdg@mail.gmail.com>
	(Christian Couder's message of "Wed, 11 Jun 2025 11:38:02 +0200")
References: <20250611062643.8639-1-siddharthasthana31@gmail.com>
	<CAP8UFD1hBo_ZH1nyGBOoQOwx=44CfnkhEOHYu3_XMwSzXQAHdg@mail.gmail.com>
Date: Thu, 12 Jun 2025 16:49:23 -0700
Message-ID: <xmqqecvobjwc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Jun 11, 2025 at 8:27 AM <siddharthasthana31@gmail.com> wrote:
>
>> Reported-by: Vasilii Iakliushin <viakliushin@gitlab.com>
>> Reviewed-by: Christian Couder <christian.couder@gmail.com>
>
> Nit: I reviewed it when you suggested it on a GitLab MR (Merge
> Request), but I am not sure it counts unless I also review it here. I
> think the "Reviewed-by: ..." trailer is for patches reviewed on the
> regular Git mailing list (or maybe on the private Git security list).
> So maybe "Helped-by: ..." would have been better in this case.

If somebody (including me) sees your reviewed-by on a patch and do
not remember they saw your review here, they might ask, but as long
as you are OK to have your name on the reviewed-by trailer, meaning
you have carefully inspected exactly the same version of the patch
and are willing to stand behind the change, it is perfectly fine.

On the other hand, if you see somebody attach your reviewed-by to a
patch that you didn't review, or is substantially different from the
one you reviewed, please raise a stink about it.  I do not think
this case is such a case.

> Anyway I have now reviewed it again and I found it great.
>
> Thanks for working on this!
>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---

Thanks.
