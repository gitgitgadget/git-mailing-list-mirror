Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF11A255C
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658784; cv=none; b=M5SzhSBj3IhlzOJwp7Bz2hw9K6bhL1WmX9p6qKQ2RDE8SiIbsvbFjkrqJZ5w/zriksABSs98kqv7pWKxU381I1O2ssTmv/MiLagoMtz9JEtCEoPyQOxwXX/yldxyo7WZ9dH/FW9Z10ZwCUFmRiUAC+ZAtuMJF+GET8JiVi43rhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658784; c=relaxed/simple;
	bh=EgHE31TPNhQ5yYXBiHWAxdcSVYmfODEI5Z7IzzeXOIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fzGam7axqKI+95co7A6ICNC70gSgPoXV/N1H6SHW6jJYHOLxmfeBm6GIJLgc9Tw1LbYFAXNhZA+VyxbMppncKFZJi/7XMYttJPIdR66kqDLuyM/FGkRa4mVgUpJAivakuMQYDU5bixOliu7ZztLa9E/XJo5VmRlCqBBv8pulhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E++gMdIs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qp6uniEO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E++gMdIs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qp6uniEO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 14C65EC039D;
	Tue, 28 Oct 2025 09:39:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 28 Oct 2025 09:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761658781; x=1761745181; bh=6YOy9FjaL4
	PbKJwiaF5EAoIeRBc2LnqYF3a2ClPkHjc=; b=E++gMdIsEEFJ7vgWKLruY/3gk7
	WSAEhdyAxSS8/p9E8Zzx1vNShek4bsnJfkAWkC6pYqHkU1+/jus3hFiF3wrfoyr+
	palIVcYqL//3g4dySPR+roSbcPKySzjpH5KclN6FjMIA6q+cm44YpAaH/2viT8Ua
	4uGFpp7SQRK9qI1I26+5YiJUZrEM4sJIqoLvoy9qeEbVf38ny7KCCe/ueLIyeTT4
	09D5ydWWJD3x0DvR6iHcrnEu4R1kAvY+t5wEqQwF+Ljmu2kiR2Gb5Zh39heXPMFY
	PicfwXTm6Opv2CM9ViJyknuqsHdtKTv0wCWItf9xz5AchAvsKRSd1yoSXhWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761658781; x=1761745181; bh=6YOy9FjaL4PbKJwiaF5EAoIeRBc2LnqYF3a
	2ClPkHjc=; b=qp6uniEOcaKTo69rTDXL9YiLTJs7DVd9lje7JXnbjz5gBYls6Tm
	BSQu8QeZwxm3Fdyunkc/n4OZM2fE0mh51SzDpgoRGuN5iLnoHiJVEY0VbB8wTYlI
	htNRUmHwn8UehpZJKSMLqgGmK0UVFMdK75hVkVqMMyF9bwPyUukGp4nBNau3A7dB
	WEaOqVnRkPDduZckZUIFtQF+23wpk3JqL6BSSk+ixNWkMcWf54f6BSmtFd3BLkve
	3cJ7gBcuQwXcQ+KM5Q+7SXaPKqaBNiMKzWirleBOyW5rWMDj0ae2PnfHFDgiwR2q
	jWgZmBU2D7MT/KK/92JOLYvnzxO77GMeEQA==
X-ME-Sender: <xms:nMcAaQq4wwNMnuRS_WroZwsl-al2wbRAxrC92UZmH4UyGWgVtWmoDw>
    <xme:nMcAaeFPuHjTDMhs4zbkxUURE-LaYOeDkzP3iZi8I-suup1Jnjcyg7-r22JnXf45j
    rjRdmQEqnfycyin109cc8ukG_ZtMHVpIy5U-U4MJOjR2VohKQNNxg>
X-ME-Received: <xmr:nMcAaSkxKPTki6mnThuk3qCFDuD01QPiYw8xHygW7l4g2ChwmIxXx1QxWRduuOxcWC-4e68__GE_KziFevrJ43vITv6b1E4EsKAm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtleelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:nMcAaRlI3tmsRon7l3OpWC4fed8qZA7QqW65HBE5sk9al58w82ugog>
    <xmx:nMcAaTuk2Af8Iw9qTYW9cEEaAh2Jev18bYsq9erbQ7j1ucxl8DyAxg>
    <xmx:nMcAaUlwwJXE1PnC6Bf9q-tX5syME6mdl0JClzR0I0sOw-NBAQJLOQ>
    <xmx:nMcAaetu8Oanl-g2fp9FOJmIe_eH3SaYKsNkK2h7NFKrewGolUqI2g>
    <xmx:nccAaU_tDx9CLOmu8s3Gr_xkb3-xCChRiNLTJRl8BC2b-2StuUYv8iBE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 09:39:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] whitespace: correct bit assignment comments
In-Reply-To: <aQBlCCDWMhLX_aBa@pks.im> (Patrick Steinhardt's message of "Tue,
	28 Oct 2025 07:39:04 +0100")
References: <xmqqfrb4hyjl.fsf@gitster.g> <aQBlCCDWMhLX_aBa@pks.im>
Date: Tue, 28 Oct 2025 06:39:39 -0700
Message-ID: <xmqq4irjf8mc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 27, 2025 at 01:36:46PM -0700, Junio C Hamano wrote:
>> diff --git a/diff.h b/diff.h
>> index 2fa256c3ef..60749154e7 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -331,9 +331,9 @@ struct diff_options {
>>  
>>  	int ita_invisible_in_index;
>>  /* white-space error highlighting */
>> -#define WSEH_NEW (1<<12)
>> -#define WSEH_CONTEXT (1<<13)
>> -#define WSEH_OLD (1<<14)
>> +#define WSEH_NEW	(1<<12)
>> +#define WSEH_CONTEXT	(1<<13)
>> +#define WSEH_OLD	(1<<14)
>>  	unsigned ws_error_highlight;
>>  	const char *prefix;
>>  	int prefix_length;
>
> Here you're using tabs for indentation, whereas below you use spaces. We
> should probably be consistent.

Thanks for sharp eyes.

>> +#define WS_TAB_IN_INDENT        (1<<11)
>> +#define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
>>  #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
>
> The "8" here is a bit curious, but this matches what the comment says:
> the last two digits are the tab width, and there of course is no macro
> for that.

Yeah, we may need to do something about it later if we further touch
the code around here.

> All of these conversion look correct to me, and I agree that this is
> easier to read.

Thanks.
