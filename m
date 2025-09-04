Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBC821E0BA
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002897; cv=none; b=MCryjtSl0PCXNXOmRFD9zVTk8SbYUlosIGSypDm2aqmY5pYIadOdPkwq9ZxUFomnD9dMZjJqvyvMBPtR53ukbKLw4bwKfwbrZsJIJ0xPjLV442gpMQy0qt36T9GIYw02RDHHYh4y4NeORXX8SZdNwpnN0p5wCOP5l4j0iLPR5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002897; c=relaxed/simple;
	bh=7JcApL6hS9cex9IOwctIWXrIhNjPVkExkO+y6asmDZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UQABD/qmvdGNJNtHJHhEJ8Zhpx1F9e1HbsZ0cmV9E5ecGrdJz+0R2GKK87U4LKSwNRQGY7PCTgkq21Gr1zHRddaQWldaSxyXI/waDNMfo4CjdReUpQlwL8W7x1GVPsbu1GClb7YrU2Mq+SDvmamslJet4PVEouPkkj82xJQi0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xBYacrZz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACSy57bE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xBYacrZz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACSy57bE"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E365EC0206;
	Thu,  4 Sep 2025 12:21:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 04 Sep 2025 12:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757002895; x=1757089295; bh=WZFmREXetf
	6jPe3ag+VWZaCx06qPBiP/JvULJSDmTGM=; b=xBYacrZz8ADRVEvMYKQv4vFUdF
	MC3LeGltzfewXT4m1Y1S1fcZNxJmIHzI8w1uXDyWkY44hTxuoqc9bKV5f5kORnvB
	i31r2giy2Amaq/7QEsPlhT0fkO0ImsdrY7dm7E2TMm1M4kIpGcyOPg8A7bLkzYxz
	kThuFHSrFwTvyCcNsm55NCkw3+jbiibjaoz+rJNKwO2B5RuKPuEfhkFKrhMZsYK3
	9Qtr48V+qAZhh3vN6owGTRVkUG4TBMF8iDtLSRHrtG25gb1DfsOeIND/AzGTSWmD
	NoQaMljqjGzdnScC8LnSCTu2oerL/UmwRHbfv9JhuW0VDvAtZxhvxV1u4LBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757002895; x=1757089295; bh=WZFmREXetf6jPe3ag+VWZaCx06qPBiP/JvU
	LJSDmTGM=; b=ACSy57bEz2j4/rJA+b7Wi/kPTnW6Kr0U/iKAmpGXelCtHqLHMzd
	mLhDxtk//wY3SoUSypK/zc52vVYWxPkpYuJWkVJ9Uyaku67gIUKqBhYS6ZUi/Wr8
	NQWzFRhgTGGAYT4wFrPmOneG9fLg7rs/sDkzh0EBjk65j5oSuj1pJdbPDdenrvQU
	b9RNQUfTMimCmHzG+ItWsnAZ8LqxgCapRfEDyFEbpMjMp5X8BuBWvYqvbpZy/lu2
	tHgqbH7dKMU0CSxhPQaaPpSQgepPeh/d6DKK+iEHP2M3o8nQKUv2jomqr/6mQtm9
	oo6+njsWBZch1kQebDiWpsqSCd+NE4HXDoA==
X-ME-Sender: <xms:jry5aGFjS1Z8pukSI1e4dF9HlyQzl8lgZZp1in68PjlFgSOgLzbZwA>
    <xme:jry5aKl-TGnen0BEFi0Qk50x8zKBxed9LTjJj89ZgBN0pjql2t-bErzdf7pd1hIZD
    h1-aG6cftt7ylT5sQ>
X-ME-Received: <xmr:jry5aJlH9Mkgcq61mFlLtuhKCieWoO-YV_Yj49qZFzWcZ9BuCXYN2O3j4rwoQ0_hbTsMSY-r8q8391OVEMDfp59T_3PYUrDqPKORhhY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jry5aLttw447kIElvK4_HIEP2SGy0KLPdQ7tLofZrfFg8EU2LasyAw>
    <xmx:jry5aMk7wbp_7x7lmvNat52Mm3D6tmDquMKM8VRgHhpIUa5Inl3wPg>
    <xmx:jry5aGsUHPksH1K1AspV5vfgPAyuw5tx30Kcs_ELAzFrZqZDA9ugcA>
    <xmx:jry5aCeUH0sgKzTOCBbTIbOb0GmbEzI-0QdpnpRPqdJveBKbvfTSeg>
    <xmx:j7y5aHOAyQwWIQTkJkPpdN1YT8LQ-3KFhY98DPYaQfBk8hNT2hQf4jSz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 12:21:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #02; Wed, 3)
In-Reply-To: <66233596-6A16-4299-B00C-ED86BA4B2DA4@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 4 Sep 2025 10:24:27 -0300")
References: <xmqqplc6byai.fsf@gitster.g>
	<66233596-6A16-4299-B00C-ED86BA4B2DA4@gmail.com>
Date: Thu, 04 Sep 2025 09:21:33 -0700
Message-ID: <xmqq3492b33m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> * lo/repo-info-step-2 (2025-09-01) 3 commits
>> - repo: add the field objects.format
>> - repo: add the flag -z as an alias for --format=nul
>> - Merge branch 'lo/repo-info' into lo/repo-info-step-2
>> 
>> "repo info" learns a short-hand option "-z" that is the same as
>> "--format=nul", and learns to report the objects format used in the
>> repository.
>> 
>> Will merge to 'next'?
>> source: <20250901172732.98845-1-lucasseikioshiro@gmail.com>
>
> I found a codestyle problem in it, I'll send an v3 fixing that.

OK.  Will mark it as expecting an update.

Thanks.
