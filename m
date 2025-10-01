Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C1130276F
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352363; cv=none; b=oI/k6ml/MdwlDfZPit4dkC/4Um04LKRYInZeTNxW0yPo+yAxdheg/9r4IGweH+dcN3LfflGTqdHcYwq6Bd+1Ty7nPM9R7Zjk7cBiTHqWgMBTAQxiY2yrvzNGdRgapwZZAV1lkjdGYvUtHOJkQX8nwVCsjDFQzk2gwG1TqsaocGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352363; c=relaxed/simple;
	bh=B5RnTBy4xa0B05GlW6UYUcJ4UvUUswhk8SDf+R9Scu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jvmkWO0CZjlEkUQVijECfVDPzIcBf/NqZsjSL4AzePcHTTSCDv4RBaUMyO4pm3kJW+zOhp5Hm0/mfzmVdGKkZJIR1nVJ7gcoEL/ygGxMlcBPNNluCLHI6Mi24Oc1CdesD0+u7Xju4W0WzOr5QsAN2NHpbW4i5ko3IwxTdrFnNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HTb4evUA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QL2JMSwP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HTb4evUA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QL2JMSwP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 611147A00B1;
	Wed,  1 Oct 2025 16:59:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 01 Oct 2025 16:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759352360;
	 x=1759438760; bh=75B5gpZVmgqjuaak7oIgsZnePE79SPOZ1wmsN1TcIQ8=; b=
	HTb4evUAPB+/49A63JCHEXpWYlKQJYv74Ps+cSPNxkbyPqeFTo+2zz4ZEoicN75+
	mPKK3WETHshkbwad4rlrSd+txnOBITkkSnM1GDXCezR/khSqGeN2u4fsbLccQZvA
	G4gHOEKhwXL4e21wNhZdmilmfo3HsRHhiMDu1SlKRfImiBsorl7fU5t2PQ7gmlWC
	92L7X23Mta8AVkPbYnUYfKaJb3hP6YeQUVgOdStvSQcpJGHYbUhSrbSnRKpFxwOi
	MQxmzFkui4khLTWEAdo7VE0vbFfDNxuqrjsRdIfNZcD+AvUFsv+X9W3J89zEdBs6
	IozU3sG+DtQyZd0UJWoJMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759352360; x=
	1759438760; bh=75B5gpZVmgqjuaak7oIgsZnePE79SPOZ1wmsN1TcIQ8=; b=Q
	L2JMSwPgAMJpBEMYlajK4flT4tcstwA+lC9yGSPzWqUg6vIV/2fyMhzT7rI9sAey
	AAY7wDEay2RDRxRxKXXYxfBEZTVX4vPTeB9Ah5Q2mAX1alezJFBw0++GPr8pAnwK
	QUAyMx/uS5nCPIvGjGgw4rdythP/lPDpRbjpdUxxfyyap9K8k10TbRJBiGlmCuz6
	gNvhaQy2vCQSC6/sAyLHlMw8OK7KODzynUl2NLhDOcoDIb3FWFUSP2yJeHOzVX8a
	ILgWUYHnPNhstSjKSQ01fczXON3XkPm+TMdJoLnCWr37o1M8MVBUYXEUYP45Oo22
	8K2bs+E8FnHJJwWRIyNzQ==
X-ME-Sender: <xms:J5bdaPAZ0ixNep8COcbxAxxvGHYlmzNTilSyvVrhKpSa_tU4rREhQg>
    <xme:J5bdaIGLthRVD2U1USyJM3aMhouJTN8NjXZQcNl9uUWbTj9vn5uEAXbWnZySDORbp
    311DAjyCcDGcfgTYy2m-h_vMjrK-43OwHmcAZRghB-UQ6OnXqlq>
X-ME-Received: <xmr:J5bdaOMgGdO01I1_IgyeKTmsZroaLQdGDTkeMA9a5TMAaZEIB5BYIBwle2oB7U9eBAMQq_OC-po4eiqecNPUjYsgkfSGzTPUOYKz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheprhhitghksehsfh
    gtohhnshgvrhhvrghntgihrdhorhhgpdhrtghpthhtohepghhithesshhftghonhhsvghr
    vhgrnhgthidrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghh
    rhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:J5bdaB6oD66tGuqq11m2dPuIaMnHiYmSHnlw2eD3ylBPrPq5B22EQA>
    <xmx:J5bdaJi43a76w7SGv0inyrzuHYyiC0OiKHPYFoO3K1ZnuglC2KzdSg>
    <xmx:J5bdaOfeAbbUNwLGxTpLbvQZxYlkaNOcPk0ogMDq8mr5aYKa-ILLcw>
    <xmx:J5bdaJxuCsWkWLoSaJXRDoMBTx5JiTPMAXVxdalFdQzTqUo32k1zYw>
    <xmx:KJbdaIm7AIXr48G45zH-CYrNW4_TI6nvRD8KnDum0vyYTBM_As6PYVL0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 16:59:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Rick Sanders
 <rick@sfconservancy.org>,  Git at SFC <git@sfconservancy.org>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
In-Reply-To: <20251001140310.527097-1-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 1 Oct 2025 16:02:50 +0200")
References: <xmqqcyalm0mh.fsf@gitster.g>
	<20251001140310.527097-1-christian.couder@gmail.com>
Date: Wed, 01 Oct 2025 13:59:17 -0700
Message-ID: <xmqq4isi1gpm.fsf@gitster.g>
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

> As more and more developer tools use AI, we are facing two main risks
> related to AI generated content:
>
>   - its situation regarding copyright and license is not clear,
>     and:
>
>   - more and more bad quality content could be submitted for review to
>     the mailing list.
>
> To mitigate both risks, let's add an "Use of Artificial Intelligence"
> section to "Documentation/SubmittingPatches" with the goal of
> discouraging its blind use to generate content that is submitted to
> the project, while still allowing us to benefit from its help in some
> innovative, useful and less risky ways.
>
> Helped-by: Rick Sanders <rick@sfconservancy.org>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> ---
> This is inspired by the "AI guidelines" section we already have for

A more important thing to mention is that Rick is a lawyer at SFC
helped us to draft the wording used in this one.

> +[[ai]]
> +=== Use of Artificial Intelligence (AI)
> +
> +The Developer's Certificate of Origin requires contributors to certify
> +that they know the origin of their contributions to the project and
> +that they have the right to submit it under the project's license.
> +It's not yet clear that this can be legally satisfied when submitting
> +significant amount of content that has been generated by AI tools.
> +
> +Another issue with AI generated content is that AIs still often
> +hallucinate or just produce bad code, commit messages, documentation
> +or output, even when you point out their mistakes.
> +
> +To avoid these issues, we will reject anything that looks AI
> +generated, that sounds overly formal or bloated, that looks like AI
> +slop, that looks good on the surface but makes no sense, or that
> +senders don’t understand or cannot explain.

A milder way to phrase this would be to jump directly to "we reject
what the sender cannot explain when asked about it".  "How does this
work?"  "Why is this a good thing to do?"  "Where did it come from?"
instead of saying "looks AI generated".

It would sidestep the "who decides if it looks AI generated?" question.

> +We strongly recommend using AI tools carefully and responsibly.
> +
> +Contributors would often benefit more from AI by using it to guide and
> +help them step by step towards producing a solution by themselves
> +rather than by asking for a full solution that they would then mostly
> +copy-paste. They can also use AI to help with debugging, or with
> +checking for obvious mistakes, things that can be improved, things
> +that don’t match our style, guidelines or our feedback, before sending
> +it to us.
> +
>  [[git-tools]]
>  === Generate your patch using Git tools out of your commits.


Thanks.
