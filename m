Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D25381AFD
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443401; cv=none; b=mHxhm0KwfGmsKjXjmpwoEIWK2BkdOu6B7DHgJyi8ox7SyM7L31MAq0MEvT0jww9g0irb3ta0NakYhhMsck3ap5QGxcyd+G31h5JpLhUNeY9XihSaI4JPlaF4H6ah7YybWmIvUwDH23r1pWUu515H2Dc/qZ9L6EtAxv1vYeITbMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443401; c=relaxed/simple;
	bh=igyEzI/ShJImKOksnGuxwbCkh9RUTomUSHvifVQKses=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m3BO3g5ZoV8f9XjnPmSizJmHTmXBbqbyXrQAxCKRdQ1nRBqvzml0Ei+LXJ0oWcma+DtZD0eNJqhC/NIiLt/Ps66q6794UlGMHnMBLvo+11fkNDLJtMFZandzKC6jcOvfI1tBkYkVYHgs8SmUPNA9hW6+WZ3elON0jR8dgBfgPUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hY29tfc5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R0f9MM5U; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hY29tfc5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R0f9MM5U"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F6457A0176;
	Fri, 13 Mar 2026 19:09:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 19:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773443398; x=1773529798; bh=0jwEuADZLf
	51RX80v4RWzC8kOgvLDS7YbnUA1u+m+U8=; b=hY29tfc5LKmaE0IMj5ZM9/PIkQ
	GYvYlJB9nw4gZavlzNRjbBt8XuA8qN2iTYxuWEbCM2+eoQMfuXiEIziz8bVOfgZi
	JGFfGlmE4Ii6fBX38K84Zbb5J2qI3wdHnA3yxJRsc9Vdt1qv1XkPFJyQaariWtAu
	ZwNq/jPP9rj7p0+ElU0De6Vihy3YLsphct5aIRKVQ5aw9k4qpIopmMbJcpeRAMDm
	Zm7tIZ5xVj5L6UdJ1FsjAvJ9yh6Bhxj3XD54vf52TlVMf9Ywe06WOTdjILWyX/cT
	T4Y/amFuk8yNmDC0KKdcSZM32mgZY/0UKBSGlvF9DPCqftjvR9AEtimIfrTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773443398; x=1773529798; bh=0jwEuADZLf51RX80v4RWzC8kOgvLDS7YbnU
	A1u+m+U8=; b=R0f9MM5U19rmq20M7xKw90aDuhNTnY0EwEQJTPfFpoPhnue4pfk
	JJW19pQDxz9jsUUurPbtNhQQV5Z/bSIy20coAb2LH2+UIfZqdhCC9zto54j7NnGw
	kP9WwI5esHQCYCAdb//do0JAVAjs4YzqLSwrc0F31LcK6FH01gPGLaPUtlDmGz4K
	dScVmsZfYK3/x76TiEi+Cx5qAFJjCfTUJ3rP5v4dgI2qxXD4nM1gjCAJ9AoXeH9J
	m6gyAODn8XcHawmoRBsLj4tcbks4K+zXQbEwJ4eVNu1/Ri2aJJdp9QdGPHQ98T8n
	2LOfxw9y2Gz5APfePAnREQ5Q/RMdJ9/Vvew==
X-ME-Sender: <xms:Rpm0aU7oZLTDAVraMQokZmWDu8PRKRCpYWHTl5mnXRmMNWU-t75f4w>
    <xme:Rpm0aczjwV7KsldAsmZCnmXON2SsCdXmRyjDc0XV4BaUI8lAG1YmhsiWY9VuQf6Hr
    bmnVleg55vu1lA40H9s9vlIQNFtwtnNOkt1Q55HoabOhoHYCHnldg>
X-ME-Received: <xmr:Rpm0abzYWRaxzKzw9acMBk0zt54a57ewEcmehCeGg-wGuIB4u7t3cLgX3IK4rANYOfHKzORu0OqaMSJ2ZhSWfgiTYXurv6S6Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepvghrihgtrdhpvghijhhirghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Rpm0aUxa65dYaxcUSes3HgKVWnG7kkXlEOzwjKtRUkHjXVytQACsoQ>
    <xmx:Rpm0aVZ3e32XHHBBYV5aHz8_z9mI27VWPSyfYzbxZGiW2Va0ihfMZQ>
    <xmx:Rpm0aVVtDfa-NnAVdpRNMkz61slI7jFl2b7Uu7t1rh3NdTGxge3PPA>
    <xmx:Rpm0aTgzh6q-HkAdUztLDkRX3p2AE0QeaZ7ugX_5u0vWuxzbeoX7oQ>
    <xmx:Rpm0aYATGUd1D3NC-v7zYoystL0UUDuX7dqGLCrrt-z1ccLoYEjEsmvT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 19:09:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: eric.peijian@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 1/1] Add preparing state to reference-transaction hook
In-Reply-To: <abSWrcvm-smx92MY@denethor> (Justin Tobler's message of "Fri, 13
	Mar 2026 18:05:46 -0500")
References: <20260313193537.62827-1-eric.peijian@gmail.com>
	<20260313193537.62827-2-eric.peijian@gmail.com>
	<abSWrcvm-smx92MY@denethor>
Date: Fri, 13 Mar 2026 16:09:57 -0700
Message-ID: <xmqq7brf1g3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 26/03/13 03:35PM, eric.peijian@gmail.com wrote:
>> diff --git a/refs.c b/refs.c
>> index 6fb8f9d10c..f1439476d3 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2655,6 +2655,13 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>>  	if (ref_update_reject_duplicates(&transaction->refnames, err))
>>  		return REF_TRANSACTION_ERROR_GENERIC;
>>  
>> +	/* Preparing checks before locking references */
>> +	ret = run_transaction_hook(transaction, "preparing");
>> +	if (ret) {
>> +		ref_transaction_abort(transaction, err);
>> +		die(_("ref updates aborted by %s hook"), "preparing");
>
> Should "preparing" be marked for translation here?

It literally is one of the possible tokens reference-transaction
hook is given as its argument, so no, I do not think "preparing"
should be translated.

But the hook that interrupted the ref update is not "preparing"
hook.  It is the "reference-transaction" hook.  So the message
probably should say something like

    the reference-transaction hook rejected ref updates at its
    preparing phase

or something.

>> +	}
>> +
>>  	ret = refs->be->transaction_prepare(refs, transaction, err);
>>  	if (ret)
>>  		return ret;
>> @@ -2662,7 +2669,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>>  	ret = run_transaction_hook(transaction, "prepared");
>>  	if (ret) {
>>  		ref_transaction_abort(transaction, err);
>> -		die(_("ref updates aborted by hook"));
>> +		die(_("ref updates aborted by %s hook"), "prepared");
>
> Same question here for "prepared"?

Ditto.
