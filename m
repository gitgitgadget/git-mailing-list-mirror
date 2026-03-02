Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56D1F16B
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772478459; cv=none; b=HZByEE3nAfvYBJB9cyIDM2Bg8PbF1cp2Sl+XTRauY/fdeukAWHaVRtwGKjSk9XAlDYebqQA0E86qP4zLUz40ACn6IB/Il0y/vKZscDVNqZOwmyGfmNg7insFsXMW0FCay3NyK1teOzmGZ4ZgPZgKtqHw/EOepR6HKFtD8IMYv+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772478459; c=relaxed/simple;
	bh=k6M2UJLuPl9WbAmbuGScXpfbHIruNQD2UeaKYqZOuWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UBA8hf7iRgDQ6ppjBOxISXu1+cwCSFhkR4m3vAV/3Q/8Z8phOWle0mxxk9CqUF+plXSxrPrdJ+yhxJ7oe8i5XenUS7ca/FMoipKyuP6eJ2Tkw2ugOdFoGXrrtswDs4ain9muY2nKX+myzaFIXf0/Lx+/9CkRgsDD/w01pKS3KWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LNPT1KJW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HouDLHAy; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LNPT1KJW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HouDLHAy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 42ADFEC0579;
	Mon,  2 Mar 2026 14:07:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 14:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772478457; x=1772564857; bh=WDO3+lIeYV
	7uW4EsbPN+T93oeB6biRRJHXiWyAXNO18=; b=LNPT1KJW1R7Oj/iY2uRkVD6JsR
	EPpkpeDXM5OswB0KX0E7rHveOJSs6FUm/EDlUBsHl26PCi0snSW7F+J4x+2bACEy
	i2yR6/jZOkXor5M2STBo9Jl1Qd7t0gwJPgJmVjM1vdj6Si6Sy6d1BwW5TTSogcNU
	wHLrakvc8aSjHR/SIXbFr2BYeUp3o90HvDzkc8YP0iCGEtpQPCvDJx//0KxABm7t
	mZIqhxevQiVPzkqryV78+qDUrAD9c71RYttTNxHHAlj5qPzwsHZIbAiMFfMmnXa1
	hh04C1ECLB34FdrhJbCm9LFgqZ/WleA4+MLYEzoSKNmi2+3O53y9Nk4/Y21Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772478457; x=1772564857; bh=WDO3+lIeYV7uW4EsbPN+T93oeB6biRRJHXi
	WyAXNO18=; b=HouDLHAyCQSyTNFzz2FyVrcvFD3tKClYxVxGaG5+s3MJs6YXUfI
	wphJQpx9SomUrXaIdKzuTqysZQl2XRx8X8RMLtWh8V2a7hh5o550sK/VCAzZ5uIe
	i141CkuS9HwsD1+Q3+zgxxcyoqnN/JK0Ggk1nUvX+Z/doyqMGgmAlSdmagfiUbsV
	J+JjGiwTYkevuvMZiQrwXp7QM5Q51N5lNY+JeOzkwJef2hgGXmHOZA296GDoxcgt
	cRj4yXYCBt+n2U5/MQJ3qmJDXbHBWTMedvBbv3iIzLtkvVoG7/NRFAUEzBLnQLE2
	pxSZKo3Va1u3W5+d60QtOHjwXy0TwyMmF7w==
X-ME-Sender: <xms:-d-labRsF1C8PFVsElDqaDJcjYXV2TPkkrst-DpNdlxLaOvW3H6Akw>
    <xme:-d-laTzBwdaOLz7Diy-8TUmQlBqxEfg1HSSBTUPs_RWxQMP-2cUx1hH7r08yXNnQ2
    gmA59URhAGSRzkoFVBqGjMJU11Eq6FlDlc_KyMufdpzY-jO8m-JPw>
X-ME-Received: <xmr:-d-laV08VR0iDFAFOF3hXCvs59qVcHtewLzJUHAtVmMfB7BfnvhfBFG4SkzQmD1W35oTiRlxCSPnBoF0v5C-NqtHwNR89tjhkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggurhhirghnrdhrrghtihhu
    segtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:-d-laZ5PYjZET4vOhaADJZNOilgwwAuEI2psdQBQz2YdXG7acEhxwg>
    <xmx:-d-laQUQTZJ8h9FY0qDlReTjjNdGVOF4GOhltit6UG_FCX_Gn1ExaA>
    <xmx:-d-laQCeZvA3kzkqQnJ-g972rXKGxL5EdNNwNVnThR8CFWOAVwV79w>
    <xmx:-d-laX5ZkL2O9N8XGYWI4_UUl4AhoEYcD52ZwVr4AcikYLQLot8DeQ>
    <xmx:-d-laYlj3fXGlOu2fIkc5t1suxgSdGHCLdBlOYyuzWnQK9WtdVJFjQce>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 14:07:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: Re: What's cooking in git.git (Feb 2026, #11)
In-Reply-To: <aaVPY9b37zY8SLup@pks.im> (Patrick Steinhardt's message of "Mon,
	2 Mar 2026 09:50:43 +0100")
References: <xmqq8qcdof3f.fsf@gitster.g> <aaVPY9b37zY8SLup@pks.im>
Date: Mon, 02 Mar 2026 11:07:35 -0800
Message-ID: <xmqqtsuyyrrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Feb 27, 2026 at 05:02:12PM -0800, Junio C Hamano wrote:
>> * ar/run-command-hook-take-2 (2026-01-28) 12 commits
>>   (merged to 'next' on 2026-02-22 at 4aa543f115)
>>  + receive-pack: convert receive hooks to hook API
>>  + receive-pack: convert update hooks to new API
>>  + run-command: poll child input in addition to output
>>  + hook: add jobs option
>>  + reference-transaction: use hook API instead of run-command
>>  + transport: convert pre-push to hook API
>>  + hook: allow separate std[out|err] streams
>>  + hook: convert 'post-rewrite' hook in sequencer.c to hook API
>>  + hook: provide stdin via callback
>>  + run-command: add stdin callback for parallelization
>>  + run-command: add helper for pp child states
>>  + t1800: add hook output stream tests
>>  (this branch is used by ar/config-hooks and ar/parallel-hooks.)
>> 
>>  Use the hook API to replace ad-hoc invocation of hook scripts via
>>  the run_command() API.
>> 
>>  Will merge to 'master'.
>>  source: <20260128213927.3026875-1-adrian.ratiu@collabora.com>
>
> It would be great if you could hold off merging this patch series for
> now. There's a rather steep performance regression in the "update" hook
> caused by this series, see also [1].

Thanks.  I'll be expecting an incremental update for this.

