Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF438A2B5
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114327; cv=none; b=HXPD7ZkPA/nGRNFQ15lDrQ/ph6FCgAzm3eiBZVM0WoHFaeFOokiun1L/Dsgw3MmgcmH/GltRSCjLvYoeSiUGb8QQh5cVb7FDGj51gq7+kZLhrBIOa/NKmHXCt9KYU5zCIoUCirwOxBhF5+G8t2MZOpneEPNEJ0n2Rfk10GGU9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114327; c=relaxed/simple;
	bh=nGMO2txvp564FwmyUMnwwpoKAutumEkLD0I8CjBVYvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eOEf9f5QkXkDlT3vwFJR2+qCDMJfZfm/EsHBhLZJ8e4tsCfg81agcO8BDU+5I6/73YN5qovHjOxTCvj49wsJqPd2VUFB6hRVhGJXhvdVnRQbZlK/wKm5UocW9NbGSyB0Sc1BnpUUJFh0awVW+CR9P/2jA4abh2bYGgir95q4YIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AwUWpWjF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k57zSOjq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AwUWpWjF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k57zSOjq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B32DBEC0B9C;
	Thu, 22 Jan 2026 15:38:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 22 Jan 2026 15:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769114316; x=1769200716; bh=CpUKV5j8YW
	x/fNWoee7UNLWmjzVgvOQLw9DKG5f5QVo=; b=AwUWpWjFteW6ebVeWCX6Sf3L7l
	8PxWg61bYwFmVwOO2f5NOzjrBbRGCvaJq3uaupZb5Sr3DU8eEGaakW9L0xtKlm+m
	3mPik4hMXr8+fdhwz1yNcEhNQLNvYh8spPcMb7FzVw2V7ODsm7Kj6nLhdoHsbLLY
	VwEmI2rKrDvqaxGsw0+7k+KRaUTE0znB34jElOXMe8n6MoG8dtpctTbyUdaDN2Cg
	xz5C6Q7A9wFIdPhwqvViMDZhc1CCPsTk2GGNwFwmLUOmluBX+19wCX9vTcYwu7CH
	wX2Jt+c9CQGQifdxI5wfvHuqY/6AbvOXLMz7awuDdQWUeAQ8QIHhVLWFNE5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769114316; x=1769200716; bh=CpUKV5j8YWx/fNWoee7UNLWmjzVgvOQLw9D
	KG5f5QVo=; b=k57zSOjqvwoQWLlf+H2rIvrwW66bIdbq0YeDvKu2q1PxvFqGrfW
	r2V4PnhiQjQ51/egAjfa4b7e4EPrIWiA3f/gF1AsHJL0K0tJt5AF60YWUrYecx+b
	EcZ2vr4BSB5dpPHnuqL1WhZc4fIDe7mzyTpmck6vgsVGh8TsFBVTv5IK4glKpZpe
	1xCXRxWUx/8NYQWKx9d4D/LjzPsPhOj8HT17xj6hItmqTgx0SDQBRxXggggMfmgj
	aR9qtj5CyIXGf+XRGu25BIpYY3SYkDflT83bUw3oUCeqTdk6dOFAMxNwx10vhoUJ
	SCwr2rH0kt66maKxWtZrQjMP7TgUiyW87wQ==
X-ME-Sender: <xms:zIpyaaBwxIKHn_mfxeDf7qciu8SgE0Ms_4zMeagRH1inkjBZlPkPBw>
    <xme:zIpyad0jQaKXSh4H0fG3ldTQPrh2EUGKlu44-Nab9EU4FHpa0ZX5sAzIqilGgowbC
    zPUDGMDtPS1ZXpR3KIkSx3UwzMJQbXHnCORVPfVcHjGFn8XHMs7xg>
X-ME-Received: <xmr:zIpyaU2iJrinDAYF1hIUNLEgFO1RqaEbkBJA5RP2ERwOdaZbY3vfI61cHbV5qLqsAw7SJIY3o_sCwAJO4Qy2g0JTTmgNmzenoXeGfwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepnhgrshhsvghrrdhgrhgrihhnrgifihesohhsshdrqhhurghltgho
    mhhmrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zIpyaaBncBKkfgv6hKKrhss-_b0453lYOvi-Kw1ZIdswU1kPMrfi4Q>
    <xmx:zIpyab5VfiwzwiBm4d6F3f0oZJNYaAdhU25jNFXmX0oJQvtqdtr6-g>
    <xmx:zIpyaTI6yUDHvl7Geaws43kJs-nNsYfFysnwLsO86b9nX3QX5fGDfA>
    <xmx:zIpyaUuPUk3hxGs62ATm7afRP6kPqzwF4yIaR1gBfSXeoJ0JLh2zzQ>
    <xmx:zIpyaTHeS-IWjvMCAaeB0z3O9KYMxzWwz549zkdpzTLwhW4_6_eF4_xC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 15:38:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
In-Reply-To: <CA+P7+xoYA6zhwVeCV6d5yW4ZxOKNLam3r-ayEDHpYpFqWyLduw@mail.gmail.com>
	(Jacob Keller's message of "Thu, 22 Jan 2026 12:16:53 -0800")
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
	<20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
	<xmqq5x8to53y.fsf@gitster.g>
	<CA+P7+xoYA6zhwVeCV6d5yW4ZxOKNLam3r-ayEDHpYpFqWyLduw@mail.gmail.com>
Date: Thu, 22 Jan 2026 12:38:35 -0800
Message-ID: <xmqq1pjhmlh0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.keller@gmail.com> writes:

>> Thanks.  Jacob, this v3 is not exactly the same as v1 that you
>> reviewed (and range-diff relative to v2 does not capture what got
>> changed between the version you saw and this version), but I just
>> checked that they are "essentially identical" except for the
>> proposed log message.  Are you happy with having your Reviewed-by on
>> this version?
>>
>
> I re-reviewed the patch and everything looks fine to me:
>
> Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

Thanks.  Queued.
