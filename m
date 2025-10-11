Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329127FD47
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760202859; cv=none; b=gkK4fV9G9D30KnISCjjAv3ktd8Bt1xo6hxX6J0T8O8bey56DQpKl/9fYFTOaUk6ObZs/TkiO2xfRZl/kGFMg4vT8eJK5tUeJqdLvjmM8Xr8RnAFk9Swy3jUx++0WXDT4AaS03PL0CmYc7sgn6BZeBQfhMKuE3sMUfO7kuBiZV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760202859; c=relaxed/simple;
	bh=w2ClLpVZeN4tlOa/euVcP8A3j3yHilj1ofOTb7LieuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t1d9ToGC0mLOZWFLGqM9k+2Jt+S9t2F6CVeKzPSndSX8JVuoBCzVsUGe9WAb0IBxuiXc3sk/AiwAxKNurKNRDuylg1pwEwOwWSHFAzznjAzVHz5YU7IvyiW7XPvV96BJ2EkuJnXvRmrY6U8FaeTjEYZBTpsE48QoMpg5wFtZ6K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XTAduQkK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JfZC0KZs; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XTAduQkK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JfZC0KZs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C100EC0087;
	Sat, 11 Oct 2025 13:14:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 11 Oct 2025 13:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760202856;
	 x=1760289256; bh=A3PwmSjhRpEkHuEx52kSCOUTYJGIA9RbWM4l0G6SAkg=; b=
	XTAduQkKcyoVWjhkw7ILDCJ9GQNhr3LSH6O08nSK9F529eTUsvIjj6IXWKCKPsNQ
	k9PqZVayZ0wGvVyaFoJ9yGTHJLBk6mFCKMJtADYw4hqtLv7w0us3LnBdwCyMXzFz
	gBaiYIUoVgB5fdVGwUo20r0eroin4fMBUE4vDS1lHL5a5o6BtWLP7ywoKMCNCcMs
	zAFLmC9DAqxdTPI3MiBbV02wJ1BiPFppP1OxFNQYJZhkYmsxSVDMuj2CtydPmYIM
	YnVJzJgjRzzXRh1S06KCw9h8IKOjfU24Cez75O0/kX5B/sLODa+56CLHm0OqS1EO
	81FDTHikLLniIfN8e6odNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760202856; x=
	1760289256; bh=A3PwmSjhRpEkHuEx52kSCOUTYJGIA9RbWM4l0G6SAkg=; b=J
	fZC0KZs7hcYsarslrZN/8flRCamWKAo8nkkgxSRf02QsEwPrCdVs7t8lV2LPt2XO
	yucLt2987biCKdt1rK+RlMPhojfVM6sfWJFvSsr5OFxmufX2YXJZLo7LR1YJ1iWp
	/VL1Tg9XvQWHL6sCUZAVVdmh3yLV+hAVpOSn8JWk2Ym67kK3ndHP7iC5KJQsb8nZ
	W1opmG8xEVdxgP4XKlepYhb3BMs62xoop5iPjaKnHrIrcu5Nq2aOw3IAw4c/GQt0
	+Asr+FJULAYQsmRbFnD07vQzMTYqVZNnqAzg9aK6JoNsKVK+4QjBN/laUMtZR1uQ
	C/2XwHObV5GPR5hSTHHow==
X-ME-Sender: <xms:aJDqaM45jYvztIsNICQR1sFsZOEXCsnPKy-WJWIT6ve3WQNJR5mZGQ>
    <xme:aJDqaEyXJVbZI_cXS8GQppspu3WJN5jRsOTQ-YO72FEHGG8xr8Y6q__eAE9r8l1mc
    eZUz4tMK8mfWILvO2Jp-4GPsqXNFgCJMV_kWtrVoC9Clg7TFfaB>
X-ME-Received: <xmr:aJDqaDxGEnldrYSg3WI7mej-50GiYsuVuopGQv2eyEruumV9zsv2hGVhEwIQIUr4Nw7Jr25xCZ7AwEtIs84w7_wc2TTwPkF-_3eo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddvgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aJDqaMz50kQqH3fTvhWAQVwMj_2k5UEZhIeQIb2N43n86eAiOQ5ZnA>
    <xmx:aJDqaNZgZz83eHJjM_URaeJ6s5pc19C18jvGKd_KDeKFQvI-au78FA>
    <xmx:aJDqaNXYSL3m_ZrZXvPD0m4Pc5bXemaWXueOWInyfA4w3mwGJwjOQA>
    <xmx:aJDqaLj4aPvx9rD7fM-VlwOFVJQcDTYmLivwoB2SKtCWbCnHGKfCiw>
    <xmx:aJDqaAATc_blbGPUpuEe8U9NfcLaZmioOvgD1W0Gyx2ki7aa5E7OtMcP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 13:14:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: What's cooking in git.git (Oct 2025, #04; Fri, 10)
In-Reply-To: <CALnO6CBEfzeSDRcVOR5chsHUSj1eM7RvTFJOVZ1h0X7Sqbaj=g@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 11 Oct 2025 10:35:09 -0400")
References: <xmqqecra71ec.fsf@gitster.g>
	<CALnO6CBEfzeSDRcVOR5chsHUSj1eM7RvTFJOVZ1h0X7Sqbaj=g@mail.gmail.com>
Date: Sat, 11 Oct 2025 10:14:14 -0700
Message-ID: <xmqqa51x7449.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Fri, Oct 10, 2025 at 8:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>> --------------------------------------------------
>> [New Topics]
>>
>> * dk/stash-apply-index (2025-10-06) 1 commit
>>  - doc: explain the impact of stash.index on --autostash options
>>
>>  Doc update.
>>
>>  Will merge to 'next'.
>>  source: <d4a277b6b0695d86636562f4c07efae17f9249f9.1759755379.git.ben.knoble+github@gmail.com>
>
> I think Kristoffer had some feedback about the message—if changes need
> made, my understanding is that happens prior to "next" ?
>
> I'll send a reply there shortly, at any rate.

OK, will wait (I am not sure what needs updated, though).


>> * jc/optional-path (2025-09-28) 4 commits
>>   (merged to 'next' on 2025-10-08 at a1e8af9952)
>>  + parseopt: values of pathname type can be prefixed with :(optional)
>>  + config: values of pathname type can be prefixed with :(optional)
>>  + t7500: fix GIT_EDITOR shell snippet
>>  + t7500: make each piece more independent
>>
>>  Configuration variables that take a pathname as a value
>>  (e.g. blame.ignorerevsfile) can be marked as optional by prefixing
>>  ":(optoinal)" before its value.
>>
>>  Will merge to 'master'.
>>  source: <cover.1759094936.git.ben.knoble+github@gmail.com>
>
> As I mentioned in <1D9EE7CD-800B-4B70-8D98-79B0C2FB8DBA@gmail.com>, I
> think we might want a slight reroll for some tests and to use the
> correct functions in a few places.

If you want to change anything, can you do it with incremental
patches on top?  Thanks.
