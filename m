Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6609A1FC3
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759959; cv=none; b=AYJgfjJZ5n2QETfKuDQAQhRSu1R0ZhFYLPuOqItavNC28QfjrwNXbxAw+b2EmdoWNFkFo/acWb0Y/g91FFVvfThECXYolNpQPiGl8zpSGCS0WR/hXrQxvexbqKIkg08zat4Ta+Yr7t9z6obtO0nM9pmvCAOTygpSgWwiGIJ+w1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759959; c=relaxed/simple;
	bh=4MGa2G/gyJ0voEYsydAL6me0c+CR5Uaz1iawSw7eoAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f0COM4wOgE6qtMm1OrLOJ0R9ZmrNJaOdx316LRA9J6zfskbZYlU/VmfiG+/te02yc9wk1Em1j5yMTmlMJblNEHaISc0cGciSloDqhkBZa1fzHCcrtSLCf7DZjbRL6/X6j9yv0WoxTwJdHg+6AJW7zWfmSj4D1YkI8hTOMwV84Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J37zwUdM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NQKeCdNd; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J37zwUdM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NQKeCdNd"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E5A32540187;
	Mon,  4 Nov 2024 17:39:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 04 Nov 2024 17:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730759956; x=1730846356; bh=TVGs+1uang
	yJuLmfFKze07g5VLkiViY6kDAPWYv3pTE=; b=J37zwUdMj5YN0yPcv2OfDvHQQi
	gJKGJxsS+zIw5y5jT1/d7NH3Q+lP2nyafcgBoED819gOVl5DxDF4sV0q3XwXYuEQ
	JgHy7yY+1ZCKTJaxxZ/BW1Tny8vfdmbvApfWYFWJb6mTMLZEANxEfMMp7SCWbqgG
	3Tk9MofwbYtnFvTIgiF6ZTXXE3G6FjGMGGd9GhiGUUbiBp1EBHDUuLOIc7n40Hgu
	Q1jIhfpQC/f8dWmCHfa9G37cbEjNUfon/oMYSZl1zkaMihLqyvAA0YHuueFiQutY
	IPQoNE6XRabrJ2/FCtE15IJLk10QhfF0WQjr8FUt/FiWAjTjLDJUHdXvsyqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730759956; x=1730846356; bh=TVGs+1uangyJuLmfFKze07g5VLkiViY6kDA
	PWYv3pTE=; b=NQKeCdNdE6tKEXf9YsqnrvQxf+WlqhnhIX+dlrkkaqq5/EeuoJE
	bIOKLxGOrUUZvvh4KNFZWohN0Wxu8CYAIrs2KTaURBL6zgZxRzmXa/rANnNQdzel
	lLIbU7KnXWzdbE3y/cxEVh/XRoSKHc/LP3xdT26lKJCYKtKGWpDes0q5Y8amLk3q
	fBS29rtOcqP2tiwh0epGC73z4D8azYpNjftGRsIUQZY2OJQkAYtPUckEUBvRKNIp
	VYUc50pGF55ahTlfz9U7afL5isr9780hH6J9fRIj0ksEPOFK/xLOEf79qJb+fR3K
	zrxvgNNDmZ49ptuiF2IQyLpP3dF5S6PX1tw==
X-ME-Sender: <xms:FE0pZ0qySPL_MjBGQVgFEgSEe7ORuVOaLnj6GqrkHGm2Kfz-zMUVUw>
    <xme:FE0pZ6qBUEnMmlHuim3G7YKNIuHm8w4I18WcOovNmn3RIS6xLXwAwis1ZfihWyStr
    sHnb0KPdsL1p9m65Q>
X-ME-Received: <xmr:FE0pZ5NJ3nemR-_VWQapVHlMdGAHZG1VzFpQffbgBzNvq1Lr2A8sCa4ZkwbD3RYZ4OZJKkl7uC1_DgxFa0FAwdiLaRn7N8tAyFBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:FE0pZ77RJlKolRM_w_hoZG7_868p79LluDcktg4pJyAuZekSL2-Ftg>
    <xmx:FE0pZz7GYzbXPZBL4_r-BqtVtvyh-N8q3Zt3lN-pz5E7y7C5jCusKw>
    <xmx:FE0pZ7i4pdIZD-AnQDM6-IpVYnNQl0r_NcBS7ThvqXRXbyiN_7FVeg>
    <xmx:FE0pZ96HwuDHmjh-coUCRtvpphCJ5AiVJ5vd4dqSia4GTA_HUfyNWw>
    <xmx:FE0pZ1l9V_Wb_tp8xYeYVbyv1SzgyrMaHM_Go1x4RKrg0ChMay7grGew>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 17:39:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #02; Fri, 1)
In-Reply-To: <ZyjoTVhP0xn/Qcvx@nand.local> (Taylor Blau's message of "Mon, 4
	Nov 2024 10:29:17 -0500")
References: <xmqqr07rwsmd.fsf@gitster.g> <ZyjoTVhP0xn/Qcvx@nand.local>
Date: Mon, 04 Nov 2024 14:39:14 -0800
Message-ID: <xmqqikt2wrn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>> [Graduated to 'master']
>>
>> * ds/path-walk-1 (2024-10-31) 6 commits
>> ...
> This is marked as "Graduated to 'master'", although I suspect it isn't.
> I thought that it would have been because the topic went away, although
> I still see this in 'jch' via your 3503a15e17 (Merge branch
> 'kh/bundle-docs' into jch, 2024-11-03).
>
> Perhaps this WC report was generated before moving the topic back into
> 'jch'? In either event, as noted by <ZyUqr/wb5K4Og9j9@nand.local>, this
> topic is still under discussion and is not ready to be merged (yet).

I am not sure how exactly it happened, but IIRC, the topic branch for
this one was missing for some time after I grabbed the broken-out
topics from you.  As I didn't rebuild 'seen' I managed to pull it
out of master..seen chain locally, but that was before I generated
the "What's cooking" report and I think that is how this entry was
mistakenly moved.

Thanks for spotting.

>> * tb/cross-pack-delta-reuse (2024-10-11) 11 commits
>> ...
>>  Needs review.
>>  source: <cover.1728505840.git.me@ttaylorr.com>
>
> This topic was ejected, which is fine since it hasn't seen any review in
> a few weeks. It's on my list of things to resend.
>
>> * tb/incremental-midx-part-2 (2024-10-04) 17 commits
>> ...
>>  Needs review.
>>  source: <cover.1723760847.git.me@ttaylorr.com>
>>  source: <ZwBsbW5jsFw0mxKk@nand.local>
>
> Ditto.

Thanks.  I'll eject them then.
