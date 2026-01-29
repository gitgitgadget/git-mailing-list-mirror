Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0D30BF79
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714763; cv=none; b=HZDK4BqnYB5QP8Y4lA1RvXnD7eMJ/uAD/7v+ugC56dI1HQ8+LZoX6VqMspMaLrNMXaElfhwUZAxZ/l/eNRQc+cHFloK6CmyswQEYdbN3ldAkUl8LwEZyAFcXIY/hdm6aJ0uZOG7bduU2KnUro38659ae4MfRn9JXKwakMc6tf5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714763; c=relaxed/simple;
	bh=03zxGaBu7fp5r5boXeLpU/6MiyjGndNKVRYt38F/D74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WW2nCmFFrbAZNUf/xRWvag834dmMp/kD8y/x+m/d6feISoo+6hTROISK4qVcGlYr+Nc7X9hrn0aaHKYfcwVEgG5CChcK5Y54v2JAJOY6o6UAuHSz8XT7icxaygAnwkP6U+IGE02NfCMw2p8c8D3hrt4foGEFJNtPwjfrRD2lJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SUjb8moC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O51DfGBM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SUjb8moC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O51DfGBM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EF29EC06A7;
	Thu, 29 Jan 2026 14:25:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 29 Jan 2026 14:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769714750; x=1769801150; bh=4lKYqOM3yn
	xaQqQRZAIPqCrbZhylkLoaR4TGqv4Yx6A=; b=SUjb8moCUdNWxNq8UXixPXggvo
	EmM6MmaUyeOHdbeYmPBRamIvIuM7rPuKfok7/Mie5ANEgluTgzC89UTFVAkE8pZY
	/R0BdFanBHzOySJ2IK8EI1Jgag4ar1mKi5GKb9+K0o1bCFKc9Yt7Er2mQRGTtl4G
	x6dGwDozcE3AE57KX9nSxx73/SkuW6enhkKbb6ABlr9ctQ+aJWKyiLn5HAEo+N2h
	MQpktlt3/tg4XZNp3xt1M2FKyxnYhekIKlSfuNO3eDVN+0aXj1ETYy5FRdhfz/Mw
	B6yaSAgiBJHnckNf1KXu+X9idnhbgCpMrhQ/80gwWykufQDFw+eDJhG8qlvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769714750; x=1769801150; bh=4lKYqOM3ynxaQqQRZAIPqCrbZhylkLoaR4T
	Gqv4Yx6A=; b=O51DfGBMutwIpQqIkYXmpmoImafoer287WW9kGo9GoPqHQD4TR6
	Y5TCPMFkTcACUMh4g9PddbcjJfBQdURXKAFW2/o73beQ1acdKxhCdysCanAfJTuN
	j1iXqhD+pLCJzUrHnXy9EIznVzRVfJedIux+BX7nMRxSOKBXnZkCD+dhXAvQ8b+A
	74AkrDVwy0vH0LghF9V6C6k1TfhPMinAKsQIgGOGekWh1U6hz9iHXc2fn1OTionu
	CXA/hIR9KXXhpGTw21Uxwzfa4lLgKq/iF5jlXWWkhSOUe7GqaoNO1yZpt99gZglv
	BTcxem99EdBqJZGBN+5A41r3Z4GhcHvQpAQ==
X-ME-Sender: <xms:PbR7aVajJKD1wwkisO2g5sd4ZdXr6A6u_RvxyaxjVzEXrm0OT5zfjg>
    <xme:PbR7aTaQz6SSz81Gj1cmtJb3foLr1TkmK3elwPH7x3fuUHmAvM0tvdTQKa3uwgthJ
    eCbb9myIds41qiTpCo9V84Eu65LEPScNkIh0kwsgJ834P-9L5CNKg>
X-ME-Received: <xmr:PbR7ac_4otv0Ytp0SsaozYbuZVknleAtQVTC8Gc3PKKmNh97Aw-k7G2bNV6srVcRQBB2bP_YxScedv4I-ZmwgqD-y_Chr0l0IHRXIBo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PbR7aSj44alEMiyd68X8KxUaQy37AoSxKgufDzSgS6QxK-b_Bqagcg>
    <xmx:PbR7acfOS3w8s491dNvCRqaCGQ5IVSMbihxK9erseC-OYKzrEfSHAA>
    <xmx:PbR7aZoiGIgZcU9NR3yjJ1Ih0KVHaq-Bi4QnWyZjTnTKqbSHrY3M7A>
    <xmx:PbR7aRArQJv3pinjFGMTsL31AEa3ou4mDojVlrSR7O3vLDGBi72mSg>
    <xmx:PrR7afLnISwrVJOOSKvr--992dTc7RZ1Ibu1ZosoYO4Ag0YZo2bcc6Dx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 14:25:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] odb: store ODB source in `struct odb_transaction`
In-Reply-To: <aXtDYY0Ao24Mpgyb@pks.im> (Patrick Steinhardt's message of "Thu,
	29 Jan 2026 12:24:17 +0100")
References: <20260128234519.2721179-1-jltobler@gmail.com>
	<20260128234519.2721179-2-jltobler@gmail.com>
	<aXtDYY0Ao24Mpgyb@pks.im>
Date: Thu, 29 Jan 2026 11:25:48 -0800
Message-ID: <xmqqcy2sb4qr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jan 28, 2026 at 05:45:16PM -0600, Justin Tobler wrote:
>> Each `struct odb_transaction` currently stores a reference to the
>> `struct object_database`. Since transactions are handled per object
>> source, instead store a reference to the source.
>
> Makes sense.
>
>> diff --git a/object-file.c b/object-file.c
>> index e7e4c3348f..196509b252 100644
>> --- a/object-file.c
>> +++ b/object-file.c
>> @@ -728,7 +728,7 @@ static void prepare_loose_object_transaction(struct odb_transaction *transaction
>>  	if (!transaction || transaction->objdir)
>>  		return;
>>  
>> -	transaction->objdir = tmp_objdir_create(transaction->odb->repo, "bulk-fsync");
>> +	transaction->objdir = tmp_objdir_create(transaction->source->odb->repo, "bulk-fsync");
>>  	if (transaction->objdir)
>>  		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
>>  }
>
> This makes me wonder whether we should first refactor the `tmp_objdir`
> subsystem to receive a source instead of a repository as input.
> Otherwise we "pretend" that the transaction is on the source level, but
> we ultimately still end up creating the temporary directory in the
> repository's object directory unconditionally.
>
> It wouldn't really change anything right now as we only ever write
> objects via the primary object source anyway, so the end result would be
> the same. But it just feels like a good first step to me to fix this
> conceptual inconsistency, and it shouldn't be too involved either as
> `tmp_objdir_create()` only has three callsites.

I agree with your "not really change anything right now" comment,
but a new odb source that will be invented in the future may not
even be file based, and a generic-sounding tmp_objdir_create() that
creates a temporary directory on the filesystem may not even be an
appropriate abstraction.

If we have two or more odb sources both are filesystem based, on the
other hand, I do not think it is particulary bad if these two odb
sources belonging to the same repository took a temporary directory
out of that repository.  As long as one temporary object directory
taken by one odb source is not used to commit the transaction into
the other odb source, it would be fine, no?

Thanks.


