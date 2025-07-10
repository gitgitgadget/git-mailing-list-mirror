Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379582F3E
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121460; cv=none; b=EI/0p7/kztuz0wmEMKoMGQqQOXUZlBaI2YsRtLpEtCZem0zmazsNh4ytELbxhwpEslq+fVVnzXhIej2FB8uuLoWqgzOdVy9VO0tCznbgr0heDsBtDN9gvnfT3PLYwLVjQCdrGFq04XtDQfc0a6/N8gX1XBqmigg+DWzmJW1rSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121460; c=relaxed/simple;
	bh=V+sFPJM/QqyFqQkeiUamwgSSEjD85oj8bTZEFAbIT8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EPHAN5lGRhUYfyE0IDLycLtQ3KNZCBJJSg38wYOtWyhtlEbjySR8X6pUQ2YiDJS6pqiTI3qEdeWwKLTRQCWJT73tLgmM0IyxTII5Q7sgEk5AsSX+jwmYjQdEMNaEvCzyHgH69OrxWPkP67MekBTDcKhaBli7Ee4GWg74WRMrVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s9V5gA5g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eEA2xa0C; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s9V5gA5g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEA2xa0C"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 31F0B7A0182;
	Thu, 10 Jul 2025 00:24:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 00:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752121456; x=1752207856; bh=4qSSJ9lXQG
	gPzjqOKznkNhXVosM4+qvl7i0ur+T11uQ=; b=s9V5gA5g5AaQ7furyrMevR6WiO
	5u2IOG1bpCb3OUU/gSZKnhQaya7N8JnLlhQTc+VvZujfyzHjA+N2kGmjv9OzgwN+
	oxom4TOIu951f1CTh9VeORYRvZluKUHB66/4oScwi0zWogFfKKhl5Dtn/ipHpjcd
	vAHdMaozLEezAFcvKCtfwUr1os1xeO6nzzeieCZKXzvWAsS7fmJUgHyu6j83Ns7Q
	is+DZxkag/+vq/aWbFD6iNkGTzWRRMH6q/jK6KzQI+fwFttGGMVWekvMRPuVTKUw
	G0UngzykefO7SwNXZ+9Wwa6Sg0+b0q1IV4lNplZUEV2iOtqQPSMgIKPr7OQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752121456; x=1752207856; bh=4qSSJ9lXQGgPzjqOKznkNhXVosM4+qvl7i0
	ur+T11uQ=; b=eEA2xa0CEmFNw8EFmsnvReYIoZHPTHdlx4/FDUwpJ9Ha1m8yRFq
	WDufbaWnTSP6OysTapx70BbidA4lpVxTmVJnMeR/1NfXudrh3UpSwnSWmFoSK5tP
	DN/2MHnTndcg2L7qlDxg97SaEKMq+RYEQme7m1rwyv9NW8gj37+T10JF1TSR9yeK
	iF+K5t5+GlfE4AGoDBPnuUJJ/vjdxceschXpnlbIZmD48R+Q3MdIjbXOxPxlpRuS
	JHBDvdvV3Y0W1oA+ewQ+chaOSB52Q3X37XMFRzuB/B2edwlTlED80os8Ye/IG6TO
	jiwMrZ7aC/wJxQ0pz8iqrU08I4aH1hSoCGQ==
X-ME-Sender: <xms:b0BvaBxG8pqfVK28IfhP3dyzvNs-fl_s1w_pW8t7xaFRxqormbefnQ>
    <xme:b0BvaEgKc8Kb7Aok4LP1-lGI4SxnD6z02VAnHKcoOAOuk61J9NJO90moJR19fgH2i
    GbpzjOGaHtj1SvS6g>
X-ME-Received: <xmr:b0BvaEyUYvmq4uHQ0ZMeojZJDAMohCwtm0sq2217LqKWo1LamBuljMkl-Ok_wZ1wMstlpRhFhA7FLWFaLBHeuROUz4SUJvSdnUxjkOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:b0BvaPLnpsj-e_CtULB2rKmUDvKY_3-xdbTQDxrTvHreZXHwnsxyzQ>
    <xmx:b0BvaDSvHR0GLYuu1-5yHO7b2xL5TG7pN0CuCTtjU1pqbEetVJ64Dw>
    <xmx:b0BvaPpazxqzjwQX62ylVXavJayEhwXXgbfpi2rzyN_ONwsvomDhdw>
    <xmx:b0BvaAoZrcMczafemK1Kur1Zxc--yhIQbKOpxbv7Om1BOl9gyccOuQ>
    <xmx:cEBvaP0sIDFcUJ5yOJtn1fqCLsmu0OugQOip3nlbnQl87XcbzC3HKswu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 00:24:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
In-Reply-To: <aG732RLqENitRwlv@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Wed, 9 Jul 2025 23:14:33 +0000")
References: <xmqqplebzgm7.fsf@gitster.g>
	<aG732RLqENitRwlv@fruit.crustytoothpaste.net>
Date: Wed, 09 Jul 2025 21:24:14 -0700
Message-ID: <xmqq8qkwad1t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-07-08 at 00:11:12, Junio C Hamano wrote:
>> * bc/use-sha256-by-default-in-3.0 (2025-07-01) 11 commits
>>  - Enable SHA-256 by default in breaking changes mode
>>  - help: add a build option for default hash
>>  - t5300: choose the built-in hash outside of a repo
>>  - t4042: choose the built-in hash outside of a repo
>>  - t1007: choose the built-in hash outside of a repo
>>  - t: default to compile-time default hash if not set
>>  - setup: use the default algorithm to initialize repo format
>>  - Use legacy hash for legacy formats
>>  - builtin: use default hash when outside a repository
>>  - hash: add a constant for the legacy hash algorithm
>>  - hash: add a constant for the default hash algorithm
>> 
>>  Prepare to flip the default hash function to SHA-256.
>> 
>>  Will merge to 'next'?
>>  source: <20250701212237.766774-1-sandals@crustytoothpaste.net>
>
> Patrick Steinhardt thought this looked fine and I didn't have any
> intentions for another round, so I suspect it's ready.

No worries.  During today's integration cycle, I read them over once
again, moved it up in the merge order in preparation for marking it
for 'next' [*].

> Of course, if people disagree and would like more changes, please say
> so.

Surely.

Thanks.


[Footnote]

 * The range master..seen is separated into two parts by a merge
   commit called 'jch', which is usually the version I use for my
   daily work, and I do not merge anything down to 'next' until the
   topic has spent at least half a day in 'jch'.
