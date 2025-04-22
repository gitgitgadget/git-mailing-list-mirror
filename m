Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D236124
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745282034; cv=none; b=iFpijfgio4g4B+ZC5U7KAKZ+efhR2i6zpVD8cEGB1c+CRan7WAhEyBzF88jDRk8T3pO1yKH3KxLAZf8qe6cdlTXnCQVexfhXIn2jvjWBmn/BF3NtEPNteghZ8RomIt6pjSDGsc5LisJD4Zzk80F5sKyLNCk5ntsjNFZzEVJp1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745282034; c=relaxed/simple;
	bh=sYGl0+Zd8KL9kxL6j3Mps+IGMzQLBmhqVlnSqqe+Ts0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UBgY85SpCHRbPfDb8JpwPsT/S5/06W+AnAsI67RhzT+U2rs0Zu5tazworBSUf7kRcXkhkAb+ST4d+eL1cOhKEp04va73RT8RMPyQpnzRa7ysRzKIdc+66RMn+YX302VUhT+jLqT0z/U2g0fBWhoPi3jFxHmeO1tW6btJ3S3pTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ldoniznl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIgbRPOJ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ldoniznl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIgbRPOJ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A931B25401EB;
	Mon, 21 Apr 2025 20:33:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 21 Apr 2025 20:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745282030; x=1745368430; bh=Nq6DLi8VP7
	zSBmd/dlmuoYm+2+nca7xgC0nhuaYuuMI=; b=ldoniznlZ5s5bxiqRbdjYZIKBd
	Ve1E4BG1N1HziY9TIntAijs2cTP0KohBslg2bdEdf+eJVfhpWtERDFYcgORr+S8o
	mwvtnAQTAb4qwn2xmJ1OLrMdHwwuZUaG8qmX+PcGOa7h4Qz5I5gy06rAJEXyWXlm
	4FzynInn03uyRoixK3+untrCSWxpySpHF3bTOdVddo7ap7dg5EZdxrwHaII7jg8O
	KBLQZlouRaYzZNrbVktAwdIinTQYtH1HkkT3NTdDjchh0fnJPFzKPJmq3B3Lpa1u
	9RJ6rQYLcIUtBTCMc7JxfhcfjfWVXi5r/41jB4vKSocyimgQFgnYkMLnfsMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745282030; x=1745368430; bh=Nq6DLi8VP7zSBmd/dlmuoYm+2+nca7xgC0n
	huaYuuMI=; b=kIgbRPOJKFKDwseDNZ6AW3Ims8ZU/3srS2PZls5tc5h2ge6+03I
	r3DeoDs5cRscgKUn0piL4CBBsilhRDg4y0CdTcI7xFw9U8VPCg+a+gOyAvHwdh2V
	CjfN4CXiTLeRpGNzqOJHnJcAISRCfWPPSKyrug/lrvaHp8xP2I7ww00TLj1a3cVr
	edx8a3PUCfAIkHH9IohNt5SLahkvfQAnqPscu3+njFx6M/AOCeTiU1w2z2UpUHpP
	T/6/vqQyUqb/EcdEh76IwQK1BdX7SjwJ1fLqqSv0tKv468jeRLsLwe5Xe1cxaL8/
	+Xz29M2FFK0ekdY8PGTsfiONf4E6E/Ju9QA==
X-ME-Sender: <xms:7uMGaEsCGQlS3-KT2CLVmANwXP6-3eEN4Z8cWtp_lWf4cNHTHf7ANQ>
    <xme:7uMGaBd4z8Z22JAnfoJqZYLfHvoPISIhw-DgHzV2cKua1iYcO9Rt0riJF1gSdxtjy
    dknL7DRKfF-9iWYuA>
X-ME-Received: <xmr:7uMGaPwjz6qYonxf5FP-kwuVGyJOIxVMNFXxGs2AGExcFomVMpI3OMABcCx-jseyTM1bWk3quVoHYfvWYFepOscKi_rbxGSV4bj->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedvfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7uMGaHMmus2YsS1EXJyJV-oPt3vBjdd9h3vx0cfsat_zxDBQFYJlGw>
    <xmx:7uMGaE91FT8RD28PsVKx07ChE2vngu1EDlwYLXKZudOPd6DDllwlmg>
    <xmx:7uMGaPWIQkuO4coLS0ELFEOUaeGEFDSlGDn4tqaHQD9TQOsiluXMkA>
    <xmx:7uMGaNf_2fwlkZZ4cFVJcXBpP0yz4GDWtGNYrnB6hMtf9i2C9its-Q>
    <xmx:7uMGaF68gpeV7-I4Z4OU356a98Jx9XFlFiGa-V0aMOhE7KfJjJfOEtX2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 20:33:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org,  Sam James <sam@gentoo.org>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
In-Reply-To: <83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org> (Eli Schwartz's
	message of "Mon, 21 Apr 2025 16:04:30 -0400")
References: <20250421175247.240971-1-eschwartz@gentoo.org>
	<83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org>
Date: Mon, 21 Apr 2025 17:33:48 -0700
Message-ID: <xmqqh62h591v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eli Schwartz <eschwartz@gentoo.org> writes:

> On 4/21/25 1:51 PM, Eli Schwartz wrote:
>> This is repetitive logic. We either want to use some -lc function, or if
>> it is not available we define it as -DNO_XXX and usually (but not
>> always) provide some custom compatibility impl instead.
>> 
>> Checking the intent of each block when reading through the file is slow
>> and not very DRY. Switch to taking an array of checkable functions
>> instead.
>> 
>> Not all functions are straightforward to move, since different macro
>> prefixes are used.
>
>
> By the way, when reviewing this I was having a slightly hard time
> figuring out which stuff belonged here... specifically, because of the
> differences in macro prefixes lead me to believe it's not always so
> simple as "does it exist".


As there are non-zero number of meson related topics in flight, I'd
like to know where this new series is meant to apply, if you need
some of them before we can apply it, and what is the overall goal
this series has ("there is no theme, they are just random set of
changes to do such and such things" is perfectly acceptable answer).

And the best place to describe these things is in the cover letter
[PATCH 0/6] of the series.

Thanks.
