Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF0A1114
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505248; cv=none; b=Ily4S57fbm3lgdwLkeyS/bmlSqwu/X2I9/lPPVuxRb+Jk6Uv0/X32IKLOJqJ3Vwe9T5eLCE6HTgBRuqX5J6pjZU5jSfcLsQawpcOZczP7I338t2tSvizYX8dBUR3e42HdCF715gbhmsTn9XMPJ6rA4ZXBCcZQqp913dq3XH19OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505248; c=relaxed/simple;
	bh=QAJuSOzWCI9UO0BhtON1CLgnVWc82SdujKwqqXpu7m8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fZ8xMx5+00Cxra4RogV0xw5+xTc6skcmNOQqsO68sQjz9T85ZMoZQbNrjaqVkamagETt615J3Dj78bQ1+U5MrmacFRMhkCvnOZlmWK839O3rlA6yzz3NU5IMOj5ScNQRodoG46ac2+MGTarflKZDy90t5Tzudi5jkUAgsGV/rrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cJbeBCxr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3C4E25l; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cJbeBCxr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3C4E25l"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 79F8C1D00145;
	Wed,  6 Aug 2025 14:34:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 06 Aug 2025 14:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754505245; x=1754591645; bh=GjNuk65nGY
	fbzKR6imTMubJFZhIoDbbyBgklXWiKyrA=; b=cJbeBCxrIKqFE+gs70AfAJLGAK
	4OGITlxVo9OQDszA6Hbq84EpLtpAIdqpj6C7TRZpgSZfdpAhpffBRROX8wI1+EsC
	/MjozeW7eJzH4phS80U9V58v8cLNNA9vkYdsfp8BD5XXUT+34suWp4UxRNZUpCMc
	QgPq8M8gqKpj5rxAdjR2672EvsKNbgy9KqSnvnPizV4zAbTuRzeUntB7fffcFp0y
	W45ZRlEl1qFLGFKFBpfc2O2kRcNPU/8+OglJ/cGCBX74/LN5q4uQXWDzYwfG7kFw
	Azu7yjtVFIhvXVhY/Oo9wROpUC2eocEbhUwL1n0gjUQxW7V3mfyvGTiwJjww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754505245; x=1754591645; bh=GjNuk65nGYfbzKR6imTMubJFZhIoDbbyBgk
	lXWiKyrA=; b=l3C4E25l0CjGo+ESNp+8/HU40o3J87O89+R3phd4hGQobKEDP8A
	jX9jICc0/+7kCAxMSgUZJGYXJl5OGH6u6H2ze1AdDaliDkYKh9A4mWu2d0/rYO7O
	4KLCWVcQTLFkz2QOXspAHQj05pkj+mm/Rxtw3Bgdxwnyo5HJvHqyIWNzRxOKnTec
	M8hs/mjv3SNlTX72EyLF1MpzoHBKk+dIvH9zXNVnFGCdA6Wedb4xiLM7ROH2C0PT
	cjDegWHOY3VJZwZrp2uboXReqxdjS9K9xMvB8CSK2YE9WbCpp4yNdjSzHpOlwnGl
	fiOHPWI/QPAV85Px6JRTAzeTnZld7ZwmFxw==
X-ME-Sender: <xms:HaCTaJxmDcwnL_IOv-ZjstIcwK-3u0T11BjNxNeBeCSnbHF5Ivz99Q>
    <xme:HaCTaD3mnjkfajcK6-gBVTgOrExpddICoOGgbeQjB9TBA70syqtEgQ4blxMEm-KiI
    mAe5ZA8WSOabIB6FQ>
X-ME-Received: <xmr:HaCTaP7j3kqTpvZBmKPVNczgCsdEkIHN4Y6y1GOHi5DOnqR1K-S22jRL0xCft6h3To41APKhGtrqAQAApvL03i-7UKalgd90AN-08Is>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HaCTaOV8JkHrTfnZUrF81PzncD2-NFC3Pi2p2iLX3-HKvewsyppnKQ>
    <xmx:HaCTaGA5S1nJPtALMfwPCpeEn9iKIXivmjwSNqM2G3SLdNuV99FQKg>
    <xmx:HaCTaF7B_kY7TFgFGvnBI_gMGmGr0wL32aE5okC2bxLWeZbIjDXJOQ>
    <xmx:HaCTaJyvB_7-JHs5SGC2MhMNo7i_VlfGtMoWMFoi8_WiDBCRWnbakQ>
    <xmx:HaCTaEi7ddSN8pXtIPuRrTEj2VxAIMzJfHXVGK1XG9AR6foSDQc_wdlt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 14:34:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
In-Reply-To: <DB375D08-5178-4A7C-9538-DE4A7CDD1346@gmail.com> (Lucas Seiki
	Oshiro's message of "Wed, 6 Aug 2025 14:28:14 -0300")
References: <xmqqms8fbilv.fsf@gitster.g>
	<CALnO6CDm5n0oZsXzvKz89jVg7E_h=1gqPFs2x7-UojdcY_Di_w@mail.gmail.com>
	<xmqq4ium3w2x.fsf@gitster.g>
	<CALnO6CBLF2Zxhy=mvz61U7M3X3UNA-V8R4tkzOvVjKWpEwi8Mg@mail.gmail.com>
	<CALnO6CASXHv_wwmAfn9tZ4D1qdJBgVKfLEQ9+LTEF9FJPiS0qQ@mail.gmail.com>
	<xmqqectpziz9.fsf@gitster.g>
	<DB375D08-5178-4A7C-9538-DE4A7CDD1346@gmail.com>
Date: Wed, 06 Aug 2025 11:34:03 -0700
Message-ID: <xmqqectouwo4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> 
>> When I report a public CI failure, I'd try to give an exact URL, but
>> otherwise the failure would have been seen in my local environment,
>> and because I tend to refrain from pushing out a know-to-be-broken
>> tree, it is unsurprising if 371c45b569 did not fail.
>> 
>> That commit does not have lo/repo-info, I suspect.  I didn't know
>> exactly which topic was causing
>
> Yeah, I forgot to check the CI before I sent the last version. My bad,
> I'm sorry for this. I'll be more careful next time.
>
>> but the error was observed when
>> "repo --help-all" was given, so perhaps some interactions between
>> these two topics.
>
> However, after merging my local repo-info-v7 onto 371c45b569 in my local
> environment, I can execute `git repo --help-all` without any errors.

The breakage reported was about some leaks, and not about "does the
end-user observe any error when the command runs?".

> I
> also pushed this merge to GitHub [1], the only fails were directly related
> to my branch (some tests that I wrote and some leaks).

And it is not surprising, when these two were merged to 'seen',
leaks in your topic were triggering failures.



