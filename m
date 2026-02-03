Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E552FF14C
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160204; cv=none; b=F06cAeXCNUUdg50TiahOulwVft2QHvnpCdlVP++Y1N9e9CK0Y9C/SetqJJdW0aSloW2CNyhzpvLe9YSHt5LQgy6WPy/F3cedkELAIaRXG2HYKsN1iJOnKOsJMQU5HYtnuY7EZDinfWPyT2vbhdcZ1U0G5xGxHacsCiPldMYeFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160204; c=relaxed/simple;
	bh=2e1kKilxrokwLsPC2aWeY5+iuwFiTU4YDTdmbhfpe2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gCOikAj6iu35Js+owgTKqtIoDOaXOSGkOqdrXSXPYzWA7XvqF+N+2Sn/R9r/spBh6Kyk/ACwuVuAsJaKEJspsXYvUU0AW5i0b40nZjKJb+Ldaq0fgvt7GH+00FrWXOrbijNfrPaAKTt7VYij4YR91kyu7Xv8rMwvl0Bo+IC2xwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NQfJ0wcV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcxMjpEE; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NQfJ0wcV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcxMjpEE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 596997A014E;
	Tue,  3 Feb 2026 18:10:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 03 Feb 2026 18:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770160202; x=1770246602; bh=5MEfuGk6YQ
	6wrw6rJm3oGyb/jKjkHGq0pvPC91vn71w=; b=NQfJ0wcVeV7DHmmecRsNrgTsE/
	Nq1NoNaADgzi4+uK0EY6h4QGaGNCOnpgiM/n4Uk4jwtriGpGgJtiiHHzUe0qtF+8
	VH4PZoNR4+fWZDaszDP47eQLfHTFyZeDyReMcseyw3tW5shYhSQE/UF1fyKA0RsY
	i4RwVbjUwbEf1k5BHGnco5ULa0ISeN3IawGH5COoDJ0uWK7T7rRouS1OFkjIat67
	oEgb38JnPM4NN2X6CVkRkiqwunpQ3bk2mDowMPByVwwIPQif43Wn28Y47ME0WTFh
	aGcTfP3ALGLcRyOdK9nNgOpejFr06aEh/R0C/evQPDcTsdI7R2DywbDckiDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770160202; x=1770246602; bh=5MEfuGk6YQ6wrw6rJm3oGyb/jKjkHGq0pvP
	C91vn71w=; b=UcxMjpEEuZYZjh/vT8l17LIKkuYIXQ/OAmtngjswv3ueiy/L92Y
	/Jo6pMrCO8Cz6Vf8gpoiH5/VAHvWbuxwSyZcfyho5BLxNvXS2IlmfRM0GAixhD44
	EpIk+bNtkNYLB/C5PLTsbNEhtnHHIcfhV2C1kyyDhzspWHfSdSx+UpnFfYM4yIZm
	Q4Cft95becGPo2Yg+DKNVThPLemmeqUV7pDMynensnLxyxbe99ct6Hv9ArooR7bM
	lCuP6Q5d/bp0wtlBjdQA0qo16/74GJqi7JWQ+vT5tH2+NKv5fEFqDq7Tqt6zsLSf
	9sd6BFxLRY/ZlqCd81pkKFDCoyJrd9kg+jQ==
X-ME-Sender: <xms:SYCCafk3jJTRfPJrDW9VALXGgf2cQffQRmCaCv_E_HgnLzQDkzON_Q>
    <xme:SYCCaVGPV8DhIPwj-8-RS7dI9CoG0NDdduCrXAHaAZisHXJrfKBatkRcFRnFuLNOv
    N2wVI-5SO2l9S1HutPK0Fzc5Cr47i91yq2b8MLuHYAjvx5IUFDFxQ>
X-ME-Received: <xmr:SYCCaX6n-tcfoKc0W-Ea1Jw_I8IACiHD-qHRAZ4i6t3zxon20a1vWhxKU6-vQwH3SZGPox_nvwZZhwkPTjNYD_fyLgwFwCLt-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhushhhkhgrrhhkuhhm
    rghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtoheprghskhdoghhitheshhhofiguohhirdhlrghnugdprhgtphht
    thhopehprghtrhhikhesphhsphgufhhkihhtrdgtohhmpdhrtghpthhtoheprggurghmse
    guihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:SYCCadnyC2NLk_NoabpKwP6PN-HW7MPEPZMLI8CHdItE0hIuRofORg>
    <xmx:SYCCacowBj51btTDKzRcr1lG1-J6pWgN1JyaDgFDGHQEZV3rsmL2fQ>
    <xmx:SYCCacuh_XD5RlO2zkN8FkFoZFDUhNNN0mOy4CTNMuhjqF8sSl6x-w>
    <xmx:SYCCaRGhWKAH5J46LKguJeUkk-qSmnG7A8-_WemYXcM6jaCLZQxrSQ>
    <xmx:SoCCaRkfEKhSkJsv2qobbrtj-C8pO_gpytJoJ_Il__8tcz8KVujBA-7S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 18:10:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Stagner <ask+git@howdoi.land>,
    Patrik Weiskircher <patrik@pspdfkit.com>,
    Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: Re* [RFH] adding test coverage for contrib/ in CI jobs
In-Reply-To: <xmqqjywtu58j.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Tue, 03 Feb 2026 09:06:04 -0800")
References: <xmqqh5smdejc.fsf@gitster.g>
	<20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
	<7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
	<xmqqjywuyhu9.fsf@gitster.g> <xmqqsebhu9nn.fsf_-_@gitster.g>
	<xmqqjywtu58j.fsf_-_@gitster.g>
Date: Tue, 03 Feb 2026 15:09:59 -0800
Message-ID: <xmqqa4xpqv94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Unfortunately, this seems to reveal existing other problems with
>> subtree tests (t7900), in addition to diff-highlight tests (t9400)
>> in various configurations.
>>
>>   https://github.com/git/git/actions/runs/21617099884
>>
>> This Ci run is near the tip of 'seen', so there may be breakages
>> attributable to new topics in flight, but I suspect that many of
>> them are already in 'master', noticed by nobody because nobody ran
>> these tests in these configurations (like "breaking changes",
>> "sha256", "leaks", "reftable", "asan").
>>
>> I didn't look into the details of any of these (yet).
>
> I didn't look into CI failures but spotted an easy one by
> eyeballing.  As we seem to be lacking a dedicated subsystem
> maintainer for this tool, I am CCing those who have touched this
> test file during the past 24 months, plus our resident reftable
> expert.

The subtree tests seems to be badly broken, so for now I've enabled
the contrib tests at CI to only linux-TEST-vars job (which seems to
be passing) and *-breaking-changes jobs.

Help by those who are more familiar with subtree is very much
appreciated.  Start by looking at failures in

    https://github.com/git/git/actions/runs/21649279837/job/62409376111

Thanks.
