Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA5224B13
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535538; cv=none; b=o6wLM5TeKgi85uvn5Zpq5NXUuCAbVXjwCoWjE+29YsFun0MHRvnMdo0cVjMHru4D8lcNLzmrQLBq1OgMuF0QclxURyn5TAeHKJ8w9oUmSl3z5+3Z82P9uCZbjDvd6sbYZS7lz0MpBdY035UMJ3TUtMGGftjdkZ3ekjnKwwV32BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535538; c=relaxed/simple;
	bh=AyDELlykiPsC2coQ12izOKatmsFjdV5cccy8b0NtnOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vg/DJ7iyJy5OLi+qdBDIGPwBWW3ORjUd0g86hQmSdPr0Ye37HmO7s9msXrAF7rsg5b7MAoagRAaYGQ10p213fp72/8OdLCOF/uiAPoph45gIGL9lXKxTyzJDjojn8dlIGDaelE4ZckJIvtcyD4J+aWrE6PPaAfwOZHyQ3MyPh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hASYzwhJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hTV0mM7u; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hASYzwhJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hTV0mM7u"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E2EE813801B0;
	Thu, 24 Apr 2025 18:58:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 24 Apr 2025 18:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745535533; x=1745621933; bh=UZxipyDDM2
	xmQ9vKg7xKDlkngoeBWKSfT+HujAT/oeQ=; b=hASYzwhJ0D8uU8TwYAGEEKfLVl
	zCSuwtTvK5NuQRf88IAAzONgQ5tNAZHsaFoiJy/l9C98N6DDhlDDAQ597kbhYg8e
	4BPExgIFw4DLPbvdYl8dMsVm0OG1rGYXkhMPZyY2KvA7nm0ykuWihaSRSyBVWjMd
	dheDcHpwHhQ1tgks2GG2GLhJ1eh3N+sEPgatafLGOS7MgHq4qQvl8R+1REOn607+
	DvjozDl0CU78YiHn7FAWsb/mC8UlQTcDsR8gow44qf9uyChlz2iQNSsZDxKHk3zT
	yu7D6WPjNILY5QzpZ6lvRp+LRirPNkgRneXhUdCzXTo0QEDHjtZokdOIF9oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745535533; x=1745621933; bh=UZxipyDDM2xmQ9vKg7xKDlkngoeBWKSfT+H
	ujAT/oeQ=; b=hTV0mM7ukQpsj8HOsMRlxCBebvTuJ9uWTaT/u9+g73v8RKcA+qn
	KFZfVa0fAtRSezrvNB+TYq8KIWhdL0U1mkRVjsuhtlM++cm3UyBpQ62qIeD+N4oW
	CDkMvH819MLh38pPoQqVI/M+ylqshHUkIWoEQ7pQvTOPxP0Gs6YpMARZoMutqKrw
	vQc1rY8b0TGNWGTPbYNt5AFC224vqC6NqxGX4Zn/qfFbghglTTceV+l4vGyI3D9I
	iW1gm+qjN5PTVK6LzSAbaon4V1oloIeTMsESyxNgPamwQSDgLJ3mF0qOFVJqsxHB
	JaSqMQVRATMasZpBatulsDHXbaOHkm8rIlw==
X-ME-Sender: <xms:LcIKaDFpN7qsKaE287KY4NFdiNst47ie_d2s-ttxH1ScUCL5QdsCVA>
    <xme:LcIKaAXsO9GBwi2EvTa6bO49h49wGnOsY1w5dGTQu_2gKUSX16Yne13iNgXw6kBgR
    PIo1ZkzmKo6bXbb1g>
X-ME-Received: <xmr:LcIKaFJUjM4nJ6KcUeKOKiYAZeypWzibd8IsWvPR4Dc5vYzKrlt1CGipatwyZF5CozVIvgEQt37bnt5npTGIcaAb73fszrUCLh6n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LcIKaBH__CGZKCmV_a1nADyF1ZHt601tGVOy3tJN4bwIlGY-0uZyzA>
    <xmx:LcIKaJWk0eOwjjzW_DyqrJ8CJa8sBV0b9KqobgGYDTIt0TrwAYxdvA>
    <xmx:LcIKaMONY8qUwp7SBzpQ1Djeh64iTvKF1V1Mtzr3_CSJ4wnB61YaYQ>
    <xmx:LcIKaI0fItoLt_WWpfnnUGMbejjJw5_i5JosHLRmZWXDlOtgr79hSw>
    <xmx:LcIKaAzI8hYX5kjFVGWju-i5pFtzjxhSV3ptziOE4YmIQTjPN43liePl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 18:58:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-(import|export): improve on the signature
 algorithm name
In-Reply-To: <CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
	(Elijah Newren's message of "Thu, 24 Apr 2025 14:59:01 -0700")
References: <20250424203904.909777-1-christian.couder@gmail.com>
	<xmqqselxtfyf.fsf@gitster.g>
	<CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
Date: Thu, 24 Apr 2025 15:58:51 -0700
Message-ID: <xmqq1pthtbdg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> The fast-export stream produced by the code with d9cb0e6f
>> (fast-export, fast-import: add support for signed-commits,
>> 2025-03-10) used to identify a signature algorithm "sha1", but this
>> new version of fast-import lost the support for it, and will barf
>> when seeing such an existing fast-export stream?  I am not sure what
>> is going on around this code.
>>
>> I am not so worried about the other case, where the stream produced
>> by fast-export contained in this version may or may not be readable
>> by an older version of fast-import.
>
> I certainly can't answer anything here as I know little about
> signatures, but your comment brought up a different question for me:
> Given that d9cb0e6ff8b3 (fast-export, fast-import: add support for
> signed-commits, 2025-03-10) isn't part of any release (not even a
> release candidate), do we need to have backward compatibility with
> that version?

I think we will lose all the credibility if we said "that's not in
an official release, so we are free to break early adopters", once
something is in 'master'.  As some corp environment are know to run
'next' and indeed we do encourage more folks to do so so that we can
catch breakages before they escape to 'master', I actually am equally
worried about things in 'next'.
