Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E262FCC0E
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979357; cv=none; b=kpWfQaWpwOEwUhjgRjPiIUqJDzpTF6FMqTXw9mGAV3zWcO8QE7JuNGpWDMD85MS1snObIACiYqKUg3iUjWidAQ4g6d7mHDOB5fzyL8u0HBB14Na71VwTbbMm+DkN/ZfcX/pjcDRXpyQgggzO8ydxVS0B4YYdH8d+ky/t5W9sOP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979357; c=relaxed/simple;
	bh=MhgV+URU1bzEa4ve7A+fYIFONtuTJdC9Y247OY9yt34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TcdX0g/lRH41lKlPIBCwl59vUrex/fy+5Twf5o8/6ay/tv21ntX1J1Z4u5lJL4fFgH/FhwhQ5BCPAuzbzw7Jnf346Vd/defGzjz79TIAQvCce+HN2twGcu4YLxCHhO/gV+mzFs45AQSJ/bNrzXloXQEOOYY6kC8mttSBZeG60cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WGIQkoVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jOEPUwAT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WGIQkoVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jOEPUwAT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BDCD814001E9;
	Tue, 31 Mar 2026 13:49:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 13:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774979354;
	 x=1775065754; bh=uWRYpDDn0f1H+RWiXEdzfpdkGWb/8HzcbUeCTUpWMG4=; b=
	WGIQkoVK6T5hgyS0xtfA7pIB15HTNGne36yhlBM9sCpvljNgi6m8JT8mSa1C7+jI
	28mnapYMah+EEnQssAKrV47leOAeTuBkAMLD5YK5kLsR9WPL4SGge3/pbzRB8Zls
	jfXCvBc/YQg70p1XlO1i6BB85kOSAximCjL6+wH0s+lH16mWML+Xfb/CvoY6a146
	AYndixxxGCzMy76wzvFPn9K5XkNFWvMeUIh7QRzjo+pU695YvXKfLWVRn7XNB1jD
	3kZ56vYg3XhaeocYojDrCEAsGNJMUHPs6J9hKRySvC0gjAM1D9Wj9O5yi41f9lhP
	n1sUx7m6RWRvc7poDl40Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774979354; x=
	1775065754; bh=uWRYpDDn0f1H+RWiXEdzfpdkGWb/8HzcbUeCTUpWMG4=; b=j
	OEPUwAT2GXzN9IKKWa3VtGlESrXiXnnzPNfbkEP4KSkqpx+mC2a46xaAWP/IoLPv
	dErvlA0OPYBgBMhKmuVeBOzQ2U95xVfaSt3p8JnG33MXW0TFyusL+yDvNRxK3min
	hU0UvpDb1IX08u+I0uEXeTKccWuBb/4sgg0jFK4bXgoWhjUGVBj/2n/R7GWzrSwg
	65i2ssdtS90MiQ44c6Jccu7ZXRBRWhbX6uEJFtfbxRm60p2+Ng/3sRJBIlX2VzoM
	YO6BD21JAhiB/fpiDEh05gBf5Mqd5aD1aP6L9IzjvK3AZ7EWBTP8mIMXcdr5wsQ+
	EXcKQA5Hxd9ZVYzu/u+Hg==
X-ME-Sender: <xms:GgnMaTDGW6x6E_s7wQiUkI3Q38Wc6e83L-T3puvN0M_Cx0_MqrMoqw>
    <xme:GgnMaYl9y7nZQC88vGkAfanrYzTUTc3JV5IGGBALQRAGjdL1VFHrfdnmmpViiIcST
    n9oWc1tPkvqlST2MkJxILu9gSmW2gYQ9RXmUUzxU5q5uASTzHPQ>
X-ME-Received: <xmr:GgnMaUxHRgry1hTfRtV2A2I_ps_g01p4b7Niqrk4zNiz6g8WbJr0ekQRfK9NiO8qGC66Tk9hMLgdqPAL2By_6pHJcj1OktaeCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepieejtdetffduvdeiveekkeekfeeiieehveekhefhuddvieejudegteehveefhedu
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrg
    hvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GgnMaSTB85rg7NiTZCrajEMimBaFw3KZQc5-6LEeH9GT1g5rsCOZ8g>
    <xmx:GgnMac8ivmYKvcOLNc8VHofxkPyCa-GDz8THrZjAoEW531eCtQkA4w>
    <xmx:GgnMaQvKxgsf0LLlNRuFqWOhpvlxO-6rMTAfvVu4-fhjnKTXjPTUnw>
    <xmx:GgnMaUM5Eew9PRx5QwR8MQF5OiljndDimtToUoOcaUxXl-avXcV4rA>
    <xmx:GgnMaSPHzpCw3o8VJ-VlJMcEuVNvnAWkyyAEI8yrAab965X28n_QzpCW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 13:49:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org,  Siddharth Asthana <siddharthasthana31@gmail.com>,
  karthik.188@gmail.com,  christian.couder@gmail.com,  ps@pks.im,
  toon@iotcl.com
Subject: Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to --batch-command
In-Reply-To: <2060629.PYKUYFuaPT@piment-oiseau> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message
	of "Tue, 31 Mar 2026 19:11:13 +0200")
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
	<20260329082808.12609-1-siddharthasthana31@gmail.com>
	<20260329082808.12609-2-siddharthasthana31@gmail.com>
	<2060629.PYKUYFuaPT@piment-oiseau>
Date: Tue, 31 Mar 2026 10:49:12 -0700
Message-ID: <xmqqjyur28kn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> On Sunday, 29 March 2026 10:28:08 CEST Siddharth Asthana wrote:
>> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
>> but this option needs to be set when the process is created. This means
>> we cannot change this option mid-operation.
>> 
>> At GitLab, Gitaly caches git-cat-file processes and it would be useful
>> if --batch-command supported toggling mailmap dynamically with existing
>> processes.
>> 
>> Add a `mailmap` subcommand to --batch-command that takes a single
>> argument: `yes` to enable mailmap and `no` to disable it. When enabled,
>> mailmap data is loaded from disk on first use and kept in memory so that
>> toggling back on does not require reloading.
>> 
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
>> CI: https://gitlab.com/gitlab-org/git/-/pipelines/2416081861
>> 
>>  Documentation/git-cat-file.adoc |  7 +++++
>>  builtin/cat-file.c              | 30 ++++++++++++++++++---
>>  t/t4203-mailmap.sh              | 48 +++++++++++++++++++++++++++++++++
>>  3 files changed, 81 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-
> file.adoc
>> index c139f55a16..af32e929a8 100644
>> --- a/Documentation/git-cat-file.adoc
>> +++ b/Documentation/git-cat-file.adoc
>> @@ -174,6 +174,13 @@ flush::
>>  	since the beginning or since the last flush was issued. When `--
> buffer`
>>  	is used, no output will come until a `flush` is issued. When `--
> buffer`
>>  	is not used, commands are flushed each time without issuing `flush`.
>> +
>> +mailmap <yes|no>::
>
> `yes` and `no` are keywords, and you want to express an alternative, do it 
> like this: `mailmap (yes|no)::`.

Not 

    `mailmap (yes|no)`::

IOW, shouldn't the closing quote come before the double-colon?

>> +	Enable or disable mailmap for subsequent `contents` and `info`
>> +	commands. When `yes` is given, mailmap data is loaded from disk on
>> +	first use and kept in memory; passing `yes` again does not reload 
> it.
>> +	When `no` is given, mailmap is disabled but the data stays in memory
>> +	so that a later `mailmap yes` does not need to reload it from disk.
>>  --
>>  +
>> 
>
> Instead of detailing the alternatives in the same chapter, you could break it 
> into a sub-list:
>
> Enable or disalbe mailmap for subsequent `contents` and `info` commands. 
> Possible values are:
> `yes`;;
> mailmap data is loaded from disk on first use and kept in memory; passing 
> `yes` again does not reload it.
> `no`;;
> mailmap is disabled but the data stays in memory so that a later `mailmap yes` 
> does not need to reload it from disk.

Great.
