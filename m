Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2721228BAAE
	for <git@vger.kernel.org>; Wed,  7 May 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635937; cv=none; b=r9Z2XaWoq6De+pb9S6nrSTFt6e0roBfmMSrLUjKefLhKS5sS3S6nQMSuX3xXcv3agbzMar3rNLMw+YcpBr1lp3wv5fv7xnxZj5i1s8t1HPdoheY38V0mQEIukvqa5PEe4pqLHkMh68HspacBZBI8qKyGSH1jWk3CAFsWyGOUboo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635937; c=relaxed/simple;
	bh=EeMM64/KqW3kcrmTfPedmxRRlONG+htjElJZTbJrkHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=szMhzUGOypH9fihukWOFy0fq2XV8p4UCpkPPJViFximRBQydwJRAzp7sOrwvbnZssz5FURaJfJv0jBUd5cp5GWF3eIMFotZ6KvD1mFIrJgKbaGrdbSqWCLd2qYo7SPTKZlZ+SeOzN+r1WLov49n4L43TbPK89g5n5N3k1guq9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IlBroFw3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNcQkWp8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IlBroFw3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNcQkWp8"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CC4513801FF;
	Wed,  7 May 2025 12:38:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 07 May 2025 12:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746635934; x=1746722334; bh=9qJNvYB76w
	oNJTLMqhWgw/xbXUztaowytW1hYcE9evk=; b=IlBroFw33pahvAdwlTQskBYgig
	9wY1NMH1cYpDiel2CeDtGTxMJSkvN5YRsGMoXeZh46OPuKl0rwZbGcvQKKI3TXuJ
	Egoxceq54qyiTCWeLIPaJ6PdBleH1miH/u1nM2vlNTIxa6rAmL0av9VyoEnUXcBF
	Cy2rVsYi3e5qF8d55J6roWhc7nU42cI4t2M8YrqEGQNzt2eiXaTy7I9Kubg/bhgH
	2uWGPy2Jap3wa+EHBVi+sLu99xlslJzXpU2VQ/swLZX9CZz7S/EzBKlhk6nxhfgY
	JqQvhGQSW/U49qTCMgHByL1un3dqLNXTJu1TC2tpF+2a3OdQVS/+y3UuFpjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746635934; x=1746722334; bh=9qJNvYB76woNJTLMqhWgw/xbXUztaowytW1
	hYcE9evk=; b=LNcQkWp8cj0S5BQO/dOyVvrBhhs99hT+vcrLdMP+ALzu6/CfmGQ
	8N/ikrGrJiRI+LgdRbdyUa/F3WFiUDMLojb7gwZmy2EjfSXrVmf3LAKf/ZYjlMib
	wxUFCTnV6YzNh1c85lipNQ5e2nRIbf85iiZTu/uEeOAlTXVLL/iXvSnmtE8fbsXM
	10BVy9a3t7igV3bDR8rYhTjdAzXkD4sZIP+jKsGH10K/9uv6u1JXZvpSxX9UpgPW
	JYpG7+uOmkGMx0A3mQ1f/bOyMNEaPwAWwZgC9M/WoAb4mL58gacOBkjxs2ZHAIuk
	BjseOh8U1P+h1A5+4KkfOs+uibPSbI1Fd7g==
X-ME-Sender: <xms:nYwbaJ6YKogyvkVxtKc1cX_Ln3YrMHhagcwgvRzBMvC-0djDLZQ0tw>
    <xme:nYwbaG4L3zxQJYmYqt-CfUZWRCZYjh6D6rZAcpGOD8qfabC3cZ1K6sN1c5ISLC6_J
    MfaW9GlGqHlq4cIXQ>
X-ME-Received: <xmr:nYwbaAcKBTSRS2b73xhpmmpPOu6vlnjU1FWPXy7W-W7BIxQvza2N-nvFweZR2ThLQTUaTUeNSKiK4YLTnrLaKZQg4OkuCopJdds_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:nYwbaCL7fkK3XwG5-0m1XDadaklPeF_w6zLT4v8dYSj6cCcdVdQISg>
    <xmx:nYwbaNI9TaGhS4tZbp6q93uMGxuPzAcQ5nCP86UN_23M3m4eXqvoSQ>
    <xmx:nYwbaLya7K2zMNTCpLmdMsIQjeBYv_yTE-UwFQttByyc0-LvvzRCmw>
    <xmx:nYwbaJJbsMBQXEgiV7hu4iu6A6d9TN6chr2t9gh0-S637PDkOPNLow>
    <xmx:nowbaIWZZyXOmAi0XeVrlAYYLsXsKLpDj8yITAbQwO4OIcSWj4EsRWOP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 12:38:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 12/17] odb: trivial refactorings to get rid of
 `the_repository`
In-Reply-To: <728e13e3-b563-4d66-bc00-b3320b76ec9f@gmail.com> (Derrick
	Stolee's message of "Tue, 6 May 2025 21:25:47 -0400")
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
	<20250506-pks-object-store-wo-the-repository-v1-12-c05b82e7b126@pks.im>
	<728e13e3-b563-4d66-bc00-b3320b76ec9f@gmail.com>
Date: Wed, 07 May 2025 09:38:52 -0700
Message-ID: <xmqqecx0e5pf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
>> All of the external functions provided by the object database subsystem
>> don't depend on `the_repository` anymore, but some internal functions
>> still do. Refactor those cases by plumbing through the repository that
>> owns the object database.
>> This change allows us to get rid of the
>> `USE_THE_REPOSITORY_VARIABLE`
>> preprocessor define.
>
>> --- a/odb.c
>> +++ b/odb.c
>> @@ -1,5 +1,3 @@
>> -#define USE_THE_REPOSITORY_VARIABLE
>> -
>
> Very satisfying! Thanks,

Yes, nice outcome.  I looked at the resulting odb.c and was a bit
unhappy to see that we still need to pass "struct repository *"
(instead of "struct object_database *") around.  But that is not
because we assume we can get to an odb via repo, but primarily
because repo has many things like config access and hash-algo that
we rely on, so it is perfectly OK.

At some places, where we pass odb around, we can and do go from it
to its repository (e.g. odb->repo->hash_algo), which was what I am
expecting to see more of in the future.

Thanks.

