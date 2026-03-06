Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA943563C2
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772836592; cv=none; b=tDGiqZvjed/wcA4C74xgZERe9D3W7sLtxgZc09JSjpdkvVhyO62qQxPKNM0NbBj3Ix1tsVUs/F2WFCFkuUe2hGxo5gETeVUYWek6rQaKCKfOozvJvtmxyL/ERDP27ZMH/daHQ5m2MYOlxA8N4Jxn0o0cvxLlGdVrwdK2WJkQ3I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772836592; c=relaxed/simple;
	bh=jXtyTR3YTqgRTnGITPSjj3nWkPFQr/eUW1vKuPgjs34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KA+WqsZXQvhm+RI+lGMMKjzpHGGgDxYyTm1ork5AkAEr1AkhmC4KthCNs8x3fcqbDBU8Y/PYye8b062z471Smp51+dx0l7SMnMrkeYwlIEscPDeHWMD6xasewUa44JEZNEprrmBUP0SmwGkZYgSfcdHtucm2UBPvqz6zDiSGjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jrueiejo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6EjUpCHc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jrueiejo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6EjUpCHc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4272140013E;
	Fri,  6 Mar 2026 17:36:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 06 Mar 2026 17:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772836590; x=1772922990; bh=YqW0/WGnUP
	dMYrdd8cQXgAcm9nJHg4il8Y10qRYsPlk=; b=Jrueiejoh5QLmjlddyYyODdyje
	4hskxC4Respl4ugly/A7IL277H2NdVusbs8+HH086uM3x446AjjkIvOf8bBu28dJ
	FHNrYExmI0g4CTbiySBCcuLNtcbljtilTYobJZbDGYVf4yjo4sXGk+m6gDHgowOb
	TQJHjrtdBZYD6WoKsmyxC2EIGB4RMFe4Do19eCnPdQWG3w2L8GxAg1rirflSjzfV
	YiZ9a4yMSmpMyfqtMxa3WjNO9ozbv8d36XfKAes9rGQkjBc3mKblEG7aEyOH3gxU
	/wdgnKwcVeDYv6ThTKh83amljJNpGzrnCB8PTD8+vklpr12+7+cXt/l7suHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772836590; x=1772922990; bh=YqW0/WGnUPdMYrdd8cQXgAcm9nJHg4il8Y1
	0qRYsPlk=; b=6EjUpCHcadaRl1RYxGD2ErRxsn/LEpeoBonP/t6/LvYp81fewOZ
	855xGb3XK73Ch3YHa8m90WszWGTsw2S55zlMxuhXIvXiftZ1+bN3SgO2Fh/dRe8r
	JsivcWQrNSZTPGfTnxviPbD7MWn0cTh3tsgqdCkXsE9SfMlZP432M+MJh/BD9i++
	2t3wshfZuWdgrW+poAq0m7yMyz2dY4jxiUkgJgKfvyASVc5+TKauXe1tk0Oh3BNj
	oGnphx1bN3kekR3mAVe2cSg9HE63WnxdHpbLj3ju6edA2Mh6VP8l+7tgxe+nrjmZ
	qw3+5JxtoYdGn4lJtDF9ph0ORxFhdxhsc/Q==
X-ME-Sender: <xms:7laraV-1JIB3pk8MoC9MWw4i2SmtwE75SG9iz4nsAawRpatdBjI8TQ>
    <xme:7laradbUmRf6A66OBG1QWgbexJ60rhh7NEp-GGbPt-Ri462WF62N1-F7iaDt2beSw
    Yv6Gmt-iGK3DkGQVMMdLF9suR2Skn7zR5eIK2eGqG_qXSD464pSkg>
X-ME-Received: <xmr:7larac09w1O3sXpg_nSz7u6j0Ldh-E9MceDNlYt3ZISNzWJCsTGZOK6c9abJv63i-S1IN64Df0EsmAKWy1CpD07_XE7KVfOxOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedthedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7laraQbukLYCDOONB5tVqcjbh40Exu-p-uiaBM3BI5FqJU5ndunEQQ>
    <xmx:7laracKLjPncFAARHdgovJ4zuBcGWJvlMTTzzuVJVEcseXBnRWpe5g>
    <xmx:7laraXHsbygAKvL-T2NhhVeY8nLwzERoeqfYj-j6BpELiI5noZVB4A>
    <xmx:7larabuoScox6XAxiqwVTi009Dle7ZVhP6_ZbP1SNzt1NVAutM-wgQ>
    <xmx:7laraWi2Dz7mDBGoTf8ZhT4UnMBKeFIq61D5MHCnu0rKWuiWe4yCRs_E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 17:36:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  kristofferhaugsbakk@fastmail.com,
  lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 0/6] builtin/repo: include largest object information
In-Reply-To: <xmqqqzq1yjcl.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	02 Mar 2026 14:09:14 -0800")
References: <20260223174120.2356504-1-jltobler@gmail.com>
	<20260302214526.2034279-1-jltobler@gmail.com>
	<xmqqqzq1yjcl.fsf@gitster.g>
Date: Fri, 06 Mar 2026 14:36:29 -0800
Message-ID: <xmqq342cy49e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Justin Tobler <jltobler@gmail.com> writes:
>
>> Changes from V2:
>> - When checking for largest objects, zero valued objects were not
>>   recorded even if they were the "largest" object. In this version, if
>>   an object ID has not been recorded yet, it is always added even if its
>>   value is zero.
>> - Added some helper functions for printing keyvalue info to cut down on
>>   duplicate code and hopefully make it a bit easier on the eyes.
>> - Moved the for-each loop that printed table OID annoations inside the
>>   preceding if-block making it a bit easier to reason about.
>
> The changes I see in the diff relative to the previous iteration all
> look sane to me.  Will replace.  Thanks.

It seems that no further review comments are coming and new
iterations are not happening on this topic, so shall we declare
victory and mark the topic for 'next' now?

Thanks.
