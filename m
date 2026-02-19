Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85A2E6116
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527555; cv=none; b=Fr/1zFxXmeJ9LutEw0e2jYKgZd2jqJHis4pAy0le95HcqnShtqHVHV3FZG8bWq71F59btgc5IwUpYJ92cGduBZ2cXIHWt8/wSMDqHloUOoIWpr6YLnAd6WT5CGYuXSrn836RfmjWUTxHLIiwQ2d+afhhbEWZA11ruOU/za9vW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527555; c=relaxed/simple;
	bh=LOZC7YgL2LLvRga+wNvWPtiXHexng0bebvcebsJYbGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uv/159pZAw0vSqM+x2JdHwWLzfOirzcCHPskB3+fg3QvZrfXpftOH8QI2D+4/n3aC4rCWfyvDIZ5rhmnNixu5GVNmB91RjGlW7kriTodYBW9GRItci0/TW0YWWe1KKhxU7ZXJduS8QU9RKGo20sCpWkk+RNMFNSrsMuFnvCgebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PNiuyMTD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=txmVTj3k; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PNiuyMTD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="txmVTj3k"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DADBA1400167;
	Thu, 19 Feb 2026 13:59:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 19 Feb 2026 13:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771527552; x=1771613952; bh=6w9aF3mA0D
	IAiAEfq+ZaXksLdKOq6HnVACDDowkuKiU=; b=PNiuyMTD5H9tYBRearaY+L5Z5H
	PDmceZOPYtTJBLpg9MLFXQWL8qgsFL1H7ZZRfzKOHP+lw8NkGAh4NU2bqTB/KhJX
	52dJYAbajfqGx1rjw2zl7OS+JUBipOyJpZfmT1E8JKELgIv8hzOjY5pSTeaxHHO6
	534zyQTV2wzLBL71MKGcqo+jLWjg9lCqGNpb9T13b/r2QjmLuXwZEDBXBnZ1deoW
	RLe0TdI4fWmRTD2gs2uG0x2G3VZExlDmm1hOqalBDattvpmJx84fLVkxInn6f2bT
	kbipdS3/eXcy6JvrZH3aMiP+2P2dWFPfiLfSVgk/wQfxAYm25bm4zl4AxPnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771527552; x=1771613952; bh=6w9aF3mA0DIAiAEfq+ZaXksLdKOq6HnVACD
	DowkuKiU=; b=txmVTj3kmf74wDmR0u+C0irYGPSjfVn+judxjymQ05amYQjG5Kz
	QwjBnm2n/z1oiNQvcFbOuqf6kbzr2GM26hKkiRenK3pA3DiZZUgxU+iJq/rx5K4Z
	jgVqsG2XtmXmv604sd+P5LiSI9QWOEFAljVII9K5FHtU3dAVsIzw2Kd2w4zShXK6
	7fzzzq7MPVl0MBUl7KCHuWcrFKGqZ68B/i8UusuJdiObHkrP0GIUitICOJNwCD+v
	eNr7CPmTIKZhzuWknQEQcrhnNrPVLqwIGs2jENmwiUSDTQWdLCM8T7l0/mOwXdxN
	G/iVUCwTG7av29sK5R4twkvJXkJxrKo5rTg==
X-ME-Sender: <xms:gF2XaZ73J0t2DnD4H0PoQbwe56Rutf-YZtCFZiZZZndbHq6tywQ5KQ>
    <xme:gF2XaamjlSktIqRdv5PlKDhHkOQJu7IufW699J76tYHrxPxRelVBBmuoAv9tITyYp
    HngCCvBy06LI0u4woSMaCH3_IUQz-KHL9s1ddGuHGRs7xrEoaS5jA>
X-ME-Received: <xmr:gF2XaaTfT9zNYQijukR7AB5PRT9e2j9KOvqO1Wl__nZvpCQp_n6TCzziWB_1EDdpk2UMhcmXBd-NXVXMuaaVnIePF3sFtltxZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeifeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepuggrnhhivghlseguuggsvggtkhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gF2XaZEADdghnAWs5nL1_0PsZIurjERGbseQH2Hxr7ufpm_Xt1mN5g>
    <xmx:gF2XafFSLVbo6GZduRyEBD35yDFsCphXrcPIYm3EyfPuEhnODFbkvg>
    <xmx:gF2XaXT1LG3_xO5N5JguqRLkk2hgoP81XtnDSLIybs4IEIFdqd5kog>
    <xmx:gF2XaQIxo81D3TZ4cZ8xcx0yJwzO-Hk6ykihfezzJ-8fGSY-LTYH4Q>
    <xmx:gF2XaSulGI26u0sNXpTQECRoYS4uXkmfMAkyZqbk4Gty3AOit6L8GzSG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 13:59:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "Daniel D. Beck via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
  "Daniel D.
 Beck" <daniel@ddbeck.com>
Subject: Re: [PATCH] doc: fetch: document `--jobs=0` behavior
In-Reply-To: <aZb2acEvAtNmt-4j@pks.im> (Patrick Steinhardt's message of "Thu,
	19 Feb 2026 12:39:27 +0100")
References: <pull.2047.git.1771443159369.gitgitgadget@gmail.com>
	<aZb2acEvAtNmt-4j@pks.im>
Date: Thu, 19 Feb 2026 10:59:10 -0800
Message-ID: <xmqq4inc5zlt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Feb 18, 2026 at 07:32:39PM +0000, Daniel D. Beck via GitGitGadget wrote:
>> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
>> index fcba46ee9e..e15cbc51f2 100644
>> --- a/Documentation/fetch-options.adoc
>> +++ b/Documentation/fetch-options.adoc
>> @@ -234,6 +234,8 @@ endif::git-pull[]
>>  `--jobs=<n>`::
>>  	Parallelize all forms of fetching up to _<n>_ jobs at a time.
>>  +
>> +A value of 0 will use some reasonable default.
>
> Can't we do better though than saying "some reasonable default"? As a
> user I would wonder what this is even supposed to mean. True, we don't
> do so either in the documentation of "fetch.parallel". But arguably, we
> should update both sites to reflect the status quo.
>
> Going into the code we seem to fall back to `online_cpus()`. So should
> we document this accordingly?

I do not have time to dig this out myself from ancient discussion
threads, but we probably had the same discussion when "git config
--help" described the fetch.parallel with exactly the same phrasing
and decided to leave the exact implementation detail out of the
end-user facing documentation.

Thanks.
