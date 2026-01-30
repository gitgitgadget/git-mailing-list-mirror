Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4E7260A
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791613; cv=none; b=h2IK2RzuT8DIT+KCkAkIKMWpUfcGpHbx6GFtj7lwrxPk4JNkbsiVhSe9BgtaPy2iV1w5oxKJnBiMgeNmCVQcx0rXpZK0zqdgQGMHcip8yZ6DvIsDASkSymm0O6vWhaaJYb7p9/+Y3FPDM5kVOj11EH8MGTuiNTfCcDn4waUuvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791613; c=relaxed/simple;
	bh=5oR3PJ/AlgDr4xM7ysIUVhoau2ok513Ak9MtNiAiAzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LIPL0b68o3ziW7LHaCR8xt1wACTiyC0hRrgsS5WFjB1AIk9Ktbc/+rpRah93YnsPYyjcOx4y1rai3v4zqzoRS2Ok6LGWtMnXEmYRlq1SNSvgQ3V8650KvbbzkcSNH08eFyZwWEQq9eFkcKWNVtQIGTmOtHq2A9UwHwwTtc417wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ICO4mrtq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aII0vgYa; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ICO4mrtq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aII0vgYa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84CC77A0133;
	Fri, 30 Jan 2026 11:46:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 30 Jan 2026 11:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769791611; x=1769878011; bh=uZ+4CiYE9A
	YJwKL7Gmz77Qg8akcSYNsgKs8cgZ8dEyk=; b=ICO4mrtqTT+RF9ewrEdI7yfYxX
	cKHkrG8hhRSiVps5gMUcDgEBLWXtm0XN5elvdFr58VCv99AK3VJikSBYn6aKUTsc
	6kvZj3o065eGy0Unu8wc1wZvKjJ+InTaDAoof03YIlEht279RxcV6N0FjkFb6An4
	Cw23E4N1/4hvnfEdymHLQPZPHHCBWqXpGYVlidT+jvGJNxQn166JEzkTpMJMSFQ7
	wk+G14gYozAz/WHKVJtofW0RZnRXEfunBhFvl6viQlP+LrFG78gTqflXFE9OkNSV
	mx4y3/C1C/dkg3pW2MrFZFrsJiaJvZvTwXu0vSC7eyizsR1aFCdmxMTAZybg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769791611; x=1769878011; bh=uZ+4CiYE9AYJwKL7Gmz77Qg8akcSYNsgKs8
	cgZ8dEyk=; b=aII0vgYa8H58lIJZhk3o7EE7ETXuShTB1ShxnDBuBI/QcogJsTg
	xU+cO9COdzO898wgyAFR8tyvXnca8khr57IRzCqgVEgo/rJMHES5YbPBORXshNaO
	982IMv+0Lp2eovWmiOG+gmwN2gezHkNAFiNezWyL3IHOSYCPS+qD8UPQHpU5IaQ6
	CEOjLPf2nJ8faS/bgB8KWQcC12n8yH178R1nilaP4Ch5i9F8C69hMV8whysY54JN
	16JjQ2Bowm2mCrLcRzQ9vfhv9FXSoG4JrctruQkOmvP6OEba9Zp2plDbtSkK8su2
	vW7aKDvvqqPda8zFAKGwHwVNcDs4EJITVkA==
X-ME-Sender: <xms:e-B8abDMCq5zkti_FMYhDr_SPs19d-G_AQs_lyXImYt5w2aff1x4sA>
    <xme:e-B8aYgH7oMyC-sk9-OT57b4qYROfILA-3UZTLU_JBOgpekJXTzl3pidLY-AriajL
    L9iKEUEUZ0erMCNkUe0y1tvKoSDJu_NAySA38wKsxjfLRkepKCXfA>
X-ME-Received: <xmr:e-B8ablyZ1Y16X_nWQjwnB3iUtJjFkhvcJ9F1nWbyorBo7_xQ6GGDhcncH_SJRL8F6TWSLxGtZc5fxnzL1snRRIEp9Wro_EX1CT5m-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:e-B8acocysRrnfSDWL_ouVdrl9dmzNMsGM4wrp9H_Jw64M-VlJtWsg>
    <xmx:e-B8acHzZMM8RDCjBiJyJX9fEhmziWWncYTp1j2A0I6N5jEkcmguRg>
    <xmx:e-B8aQx9fUfO7okOkZogaafj7acYkyPi414_Y0fBu0Uc8Ba1a7T3YA>
    <xmx:e-B8aZoZwmVt9Tu6NNN2SYnDBwcs8qnzy13rJ-Sf0BUttZTZ6XsKcA>
    <xmx:e-B8aWlpDwzmn_WIqGTaKRJnVa_5Pv-4XuBeokMfjMyLYPy6dsQTqoAI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 11:46:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.53.0-rc2
In-Reply-To: <87qzr7qmm7.fsf@iotcl.com> (Toon Claes's message of "Fri, 30 Jan
	2026 14:02:56 +0100")
References: <xmqqpl6vezt3.fsf@gitster.g> <87qzr7qmm7.fsf@iotcl.com>
Date: Fri, 30 Jan 2026 08:46:49 -0800
Message-ID: <xmqqzf5v6oau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  * "git fast-import" learns "--strip-if-invalid" option to drop
>>    invalid cryptographic signature from objects.
>
> This is not entirely correct, the option is
> "--signed-commits=strip-if-invalid".

Thanks for sharp eyes.
