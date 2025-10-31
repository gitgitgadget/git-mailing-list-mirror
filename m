Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55C27E040
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925920; cv=none; b=ma9jF70UZSVztGvKEWirMW5YwvKKhy2b4LZNcfyHUs/K/9vuEzLyEBePRLHp7OEfDI6l/WXtCe8+RIfOx0PNdCjHqC2IRJak7+CT5KR/HMBAtNCjUc6rMyipTz2/5iVKB4VA9npdr1ZTdqtROunxcCA+RzvEpZFP+GbrHg5XfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925920; c=relaxed/simple;
	bh=FwzuhjiYpTqYQs71pKcbXacymI7t2eNbsBWTS7/WlMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kV3yglnqVsfgnGFrmV9csD9jKjRkxI6bPN9Fw/bxjyOQT8WGwRO5k+/crUl5gcl5SLNEP87zRXIO7vYvn3yWDZ81DQ9KDnDSo32zNGftHpswL7uyq6WZjxVO+lhM6jwRySqM7h2aIiq+T/OgN9c6wdYVJDFt0+HUUyN3+JEpOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WIxCpSiM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENxTujD8; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WIxCpSiM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENxTujD8"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 6FC681D000F7;
	Fri, 31 Oct 2025 11:51:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 31 Oct 2025 11:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761925917; x=1762012317; bh=6pva7raNvR
	LIi2FWq1Rpfi0uqDlt9qektoX5xrYYTno=; b=WIxCpSiMKFKjMWAhYqVR7t3Kp8
	0/RXrvyEpjme7iXKqufBQc+Wm6AzJ7yR3AOAqsfn6Hodq6rSBwlCzsqN8XcVewrg
	hYshzLc9JblPmbpUlVgkZ7/iIcjyi6R6po6vppgCCgM1zqWPIgsd0V/b69cPBWeD
	QydGFo2kxv/3UCio0dXcSApBjpN0oF/JkELps1jEqjW84FjYjejaZfduQg6do69t
	HvtKG5u+TufXN2SdUxTNv0vAhcs/mYsrKdnW99QX8sIQ4czvmm2LLpRMl6hkGDqX
	KrAq+Y4dRz24jDBKCZ/hVWdETAzF4JRe7NwVn/cXfcbm8PgvRviWKHW9ZOZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761925917; x=1762012317; bh=6pva7raNvRLIi2FWq1Rpfi0uqDlt9qektoX
	5xrYYTno=; b=ENxTujD8N0cWQ/qG5DhBgoL2mq9rsZMdgdTqzhtRmlxcg0xWPDy
	1BCUIBcC6yWGnS5wTCdUoRGcLLNKlrDJ5RExc6+ptyKYdBwIxPym+Im93Pq4bhtJ
	HdfvyqbGxKbpWZnhCLRX4MS4xLewsE9Vb/W6wUKEjY1RVyUMPdZD5coqU9C20Pyv
	Uy15PapHR05RNVjmcQ29SwR4SAUZPyFxcxve219+8q1N+Mto4wKfDDXrdo0xteYn
	XUlYM7rp1fO7+MF3Xe2Pa8LI0OMoRsbCmEnO0p4UPriTit5rBNkENp1f7cz/SkJh
	+cIYiz26w0W201j4QsW/fLP69Za7phVyQXw==
X-ME-Sender: <xms:HNsEaR3vkf5aCPzMo44-q-AtE0FzEcnJAKq25jC7rQiL1w8rzDiycA>
    <xme:HNsEafjUhMdxf3nkQoIY8FoSJVtlQfZMk33EKHbX4sSVJwlNCk77rLSYP5cBP37Vs
    6IYpq1KnoqKXT_S19vbuCXbaMSb9G_ykrejMCr3MttXqaRxeaW9>
X-ME-Received: <xmr:HNsEafSFA-TbEI7X6TYwk7iyGOhAWGoC04uZWvclKuR6bhqksXf2fpfus6LaK923biU-pyWHjgpIKcdTzq2Mgcq_yA_ZZhS_an34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieelledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:HdsEaYjEkz3PyIfX2wmBwXvF9FHhDDNEjjkiZpiHUSuTV3ktUi_BKw>
    <xmx:HdsEaX5ZPoLaotGUL_-6BgiEoW3fMnJSLCPncncpBMLrwtOM9yDcVg>
    <xmx:HdsEadDPrEeLHLbrf4SXVT1GBXuMC6LSyuuM53EXcPiSy9ZoJAX4hw>
    <xmx:HdsEaWZl3CjW8d-8-4Ncsott0PhaQgrQyfhGsGmISBZuNpJ9200Rug>
    <xmx:HdsEafoeZmi83CLYOcA9k1Y0q2pE8Y_5eZcB8vrelGEQbpZzKb2EcTrD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 11:51:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #12; Thu, 30)
In-Reply-To: <aQRaRuBtt_r7SamL@pks.im> (Patrick Steinhardt's message of "Fri,
	31 Oct 2025 07:42:14 +0100")
References: <xmqqpla43wcp.fsf@gitster.g> <aQRaRuBtt_r7SamL@pks.im>
Date: Fri, 31 Oct 2025 08:51:55 -0700
Message-ID: <xmqqa5172hno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * je/doc-data-model (2025-10-27) 1 commit
>>  - doc: add an explanation of Git's data model
>> 
>>  Add a new manual that describes the data model.
>> 
>>  Comments?
>>  source: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
>
> Will have another look at v5 of this series. I think it's nearing a
> state where it's good enough to be merged down.

I share that assessment.

Thanks.
