Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304B221FB1
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137514; cv=none; b=Y+KoncPkIOEdvMtzkSmqAtN5yobwlEbxtQimcFCEM90Uc2/bIffSPCyPnSjz8AC4ND4NfJuHM+eukgKKTRix2RLCRAZS5Zw+ioM3v1CZoXRKdxn/O3tCCsm3cKY6tJt7I6RXW5/Y6538UdEeE5a71caBQ+6beK55ShZD/Ku0FUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137514; c=relaxed/simple;
	bh=hB/ait2oJjXXjkPbDtfZeQUCs6BHTGl0/NdNZSMX0mw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rlW2mr4OvnVR0r3t/UFrTc8K+i5SIPExydXEkW6dj+onGaCZ2L99rN7lraLCOeSzbFvlk3+FTYEHAPEBiPBu2pyyr+nEglSZlfDJ9t4ZFkpa2sE5hkcsHjGsx9zoGniDtWazOvmMWNNTvpNSawXvRAXz0BgWCXKpvEP4K5IN36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ni63klNR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TH7l37D+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ni63klNR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TH7l37D+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 968897A0193;
	Fri, 14 Nov 2025 11:25:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 14 Nov 2025 11:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763137511; x=1763223911; bh=v7qc71e7oI
	JMLEZf0WZnMec/52vgqpyivdxAEofkcjY=; b=Ni63klNRo5sgdbWC50mUwCkGiv
	Gx2TwxszP1GTT+L+ie54v9DYE4Ue6qbOmisLPsGnH1m4+9ammo2u0rUVoQ+Xqasx
	0Lc8MmyLbxTNcLkeBUFjwOgQGluejsaKUMVKhFEOPlSwCzHhfyzXBWEJ885uZ0Hu
	q2jIauanMws49x7ohqli/SfgNS/5yfMtZCKWMt4jtCV0/MAtTrtCyDImXv2Kzj3P
	+6/OSfHP8EjG2caDvEOhsGSnwHYplSPGyC7DNVvSl7VVda7aqRSWQv41AHZitVx2
	WMPWJRv3i22v+L3GYaPdfA1bgn3Kjp52rSV3sMLtOzzn4llTeBmBqUgLDPvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763137511; x=1763223911; bh=v7qc71e7oIJMLEZf0WZnMec/52vgqpyivdx
	AEofkcjY=; b=TH7l37D+p1rjsKRumg+xmiqsS9gg71np6weVy0JIh/++0AnAmpp
	/r2k3Nw0vqi3giYn+M4I2NIodKELPIxXI8Kqh0UNUbd1sHeJbm3ORZ514SJxDj0c
	EP9rvgTp1NirB+eRihCkQLbE6uR3LMV62ydLU47vmp7xcUhk2IOPTzk/l57CLnBi
	4TVOhAcgCOvGtA0y33V7aX+hjkvLdfy11Zulckk9o2GMy2gn0yvuxkzNJT+hvvRg
	IJ+piuTFyUnPjkKeaeCkv7j5MSbGnowSmr8d8NXMcm9/nJPsYqzgVa5MXk5GRvlF
	GnX8Bf0e41u4fCGaAVXj5WZQLe324xfT9DA==
X-ME-Sender: <xms:51cXaRA9bLr3t9TnWsY88QQ4evuCWNSh_0WhE99Z9yBiuP2J6FAwVw>
    <xme:51cXaW9XhHs9GYTMOC_AHPWXHSFTq1sBmxgfOVkSvxY3rYqm8gofkl5RfzhvmeU2h
    EVU9UQMIaykNNX_Qfb5LJQCieLY-1jXkCgbMrb2gXFs42gsa4Uh>
X-ME-Received: <xmr:51cXaZ_8uI42DuF3Bwj8VKyzRwJm3mtRexrSwGCBmiO8JmMurxKN2SeZwWSS_4m3TpZaOAReFWnS_is4Fj-xwxmc22t8LiBicFUi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:51cXaVftGKXQ5dmOnPJHtTHJ7YesBR4Y1A7FJZnJ-roZt-f_1-yk6g>
    <xmx:51cXaaGzblkq7Uqd3cM-OuhEaJJdiyv1YcB32E0OzxKguwlNZfk70A>
    <xmx:51cXabeigsruU56WDL73qY-kF0audNLAcBI7RoMILuCaUT3YA6BUjw>
    <xmx:51cXacG7Vrizmod-IDP4UQTAL39ozi287ob6jv0qZVuHPUPifzY6mA>
    <xmx:51cXaW8C8cKmXCSTPBIQHQNObq7hBuP2ypZJ3JqDjIoYlaQTpJFSkQtX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 11:25:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 00/12] Incomplete lines
In-Reply-To: <dfdbfb71-2d3f-450e-bbcf-95ecbead3292@gmail.com> (Phillip Wood's
	message of "Fri, 14 Nov 2025 10:24:21 +0000")
References: <20251111000451.2243195-1-gitster@pobox.com>
	<20251112220258.1009253-1-gitster@pobox.com>
	<dfdbfb71-2d3f-450e-bbcf-95ecbead3292@gmail.com>
Date: Fri, 14 Nov 2025 08:25:09 -0800
Message-ID: <xmqqikfck2e2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 12/11/2025 22:02, Junio C Hamano wrote:
>> Changes in v4:
>> 
>>   - The preliminary clean-up for "git diff" in [04/12] no longer
>>     "corrects" the code that updates the line number upon seeing
>>     "\ No newline" marker, and leaves it for later series to clean
>>     it up as #leftoverbits.
>
> I agree it makes sense to leave the existing increment alone as it's not 
> really related to this series.
>>   - Our house rule updates in [12/12] now forbids the documentation
>>     sources *.adoc to end in an incomplete line.
>> 12:  068229790d ! 12:  cb86d9b45f attr: enable incomplete-line whitespace error for this project
>>      +-/Documentation/**/*.adoc text eol=lf
>>      ++/Documentation/**/*.adoc text eol=lf whitespace=!indent,trail,space,incomplete
>
> Should that be "-indent" c.f. 358e94dc705 (.gitattributes: remove 
> misspelled no-op whitespace attribute, 2025-11-11)

Oops.  Thanks for spotting.
