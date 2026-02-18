Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA632471B
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771436822; cv=none; b=onCx3btjDPQkrSKV6M+qraCoOgGpp+UzFrFgSDBAxPEeqc8IPYrpc3IioQYL40uuWECp8HXBJH3LTu5pU3AOyNFG3LOW9JmGQdN1PZW0EgA6xmxcs5sx75dKKR6pShOkz+UnKTWMNDMGpLVSpsGsY93uZhjH8JizbU/lQm+bl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771436822; c=relaxed/simple;
	bh=55GEDdmSHbbW3qizD4hAMljTfYlBewoPc7vcYplrfoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TB09MQ693nxxedo8CwKM1qCCtBQwovuT/RqFyz4m267MqV/BAu4p6WEifLbOw7ClkqxI1krBVA415yOgq9G8IKRXGYHDAGz8J56FS5VYJ8h+UZT+qnZOGK4HFK3i8NEVr33fwUgbHjyz8nAgD8UrRvTPewlINKAUvxZz4AQkLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OhizI05X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQcGUBYP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OhizI05X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQcGUBYP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 536887A0076;
	Wed, 18 Feb 2026 12:47:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 18 Feb 2026 12:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771436820; x=1771523220; bh=fqrQKFZIkQ
	BYJjG7Efy7wn8VNab81AhuWpf7wqFg1bU=; b=OhizI05XJS2C3tIp7NIo1t/Ckx
	UlPW6wXSjJneESfVS6rGaMXo8nBhOC6mDi9izJqwDr4g7zHvx7vVJ3Iu9nhB3pTH
	l3EhBiI0e3YDcr9p/zvCcmmlDdzXx1iYnMO5I3QN7MqphRd03r7tRU4yn0AAwg2m
	wZ2T1M5YsiMS7ild5kLQ88dPnEzcGk0aNYh5CO9dMGU7Ffw/hGeuAoEMDGpwQPXJ
	kXPSx3QCWQ6MgqfGDpcR7f7Rp/WnUkfha3zghCanc04gn3sQeUZd2zL0f/BysCxE
	LWPpY/LMn2SaE4AhsVlw0yfNI9Nad9UtpjWtuo6+xfLJgTp9vWOKHCeDLR1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771436820; x=1771523220; bh=fqrQKFZIkQBYJjG7Efy7wn8VNab81AhuWpf
	7wqFg1bU=; b=aQcGUBYPrdpWSW2nD6O8So5YZyCW6One0DS+j2mLs2gcDEO2Li8
	XKmptqW/dF12Wm0KWZbZzMmJPoykQZ9z+dXZTxwd/mbH7XbuDciLBr9EvzKtbVEX
	bt97PESR+fqA7zEVc2IWXnENuMADsG0S9jlff3EIWJF4/LzX67T3E7+hw77KMFJp
	kKba7v98y4LC63CJ3pEIM1aVBP58w8O5Dgi0+cEUj8K3ybtDSYRYJ2Y7QVR3Rptr
	1qz2JvG/5pgBmBHp/2jvT6WekI2jXw59OE0nu2MTi2YZpSx37nprcbY+qNwo/NA0
	p5/RRHAV75aduzyx7xDcOYvsbK+i8hQg9/w==
X-ME-Sender: <xms:FPuVaSaXa3f8_j_BtPcdVcPpCZqdsmg5ToEyN8GWU4FXxh1NkDXVag>
    <xme:FPuVac12dX-9bzNNKxuWz-CmYZ8wqUg-vj2lES6_YKdqUruv0lWmpvqm62E_b9f3U
    OqSN3F1wCjJPU3rc5nYD-fcTey4X0T20b1Lb9d0UaSpzM-PC_Bi>
X-ME-Received: <xmr:FPuVaaXLOU1_jStCW5OeYUCxc43N50xsFc6ONfXbBT-grIcsWHhwDHtn4hfKjdZBwrE61-MhuX4OvQW9mLOCOn9x6GqNF0ayEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefvdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:FPuVaeV2eIm4nhoFe8hFZB0wdVPMSDyieB9sqAeBjehcg-8RlFPCnQ>
    <xmx:FPuVaRfZmV4ZZ5fUfRUPEMriBC2NmBbg4t4qk8NrXz9NY6Pb3Bzurg>
    <xmx:FPuVafWZUZ5SSSwlHGcUaSHYwN94UQFc3sXtd7SDEHgBimZpitIivg>
    <xmx:FPuVaSe1v4pbvTmkzpaBQiV_iIrjSvUj2ph5SqfvpX9KZrnZDssK8w>
    <xmx:FPuVaU9PfclaYh9FRVXSPQWuXL8AYtwhrWljSenUNRa3i24r3iAdv8wv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 12:46:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: ps/tests-wo-iconv-fixes
In-Reply-To: <aZVA4i8DeFRYf4a-@pks.im> (Patrick Steinhardt's message of "Wed,
	18 Feb 2026 05:32:34 +0100")
References: <xmqqseay98oj.fsf@gitster.g> <aZVA4i8DeFRYf4a-@pks.im>
Date: Wed, 18 Feb 2026 09:46:58 -0800
Message-ID: <xmqqbjhm7xm5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 17, 2026 at 04:50:20PM -0800, Junio C Hamano wrote:
>> * ps/tests-wo-iconv-fixes (2026-02-17) 4 commits
>>  - t6006: don't use iconv(1) without ICONV prereq
>>  - t5550: add ICONV prereq to tests that use "$HTTPD_URL/error"
>>  - t4205: improve handling of ICONV prerequisite
>>  - t4xxx: don't use iconv(1) without ICONV prereq
>> 
>>  Some tests assumed "iconv" is available without honoring ICONV
>>  prerequisite, which has been corrected.
>> 
>>  Will merge to 'next'?
>>  source: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
>
> I'll send one more version today that splits up the first commit into
> two after Chris' feedback.
>
> Thanks!
>
> Patrick

Will queue.  
