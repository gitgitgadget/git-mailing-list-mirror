Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F6221F20
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751983; cv=none; b=gNz8kBTBvvplQ/H4y8dcw9t8uf6/WE37ZvAi1I7VGZQMiVLjlcc1lPw19mHwhCUcyGmMJ5BgAgZ9xLdjmEFBMiw334UzS1twXnXa5zpVfuDmWC54YDCNA8suylcQxwr9cU7RI9XSHHOOcr/Ln2h8oJ31FGgeaWMMw7HgmbwxDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751983; c=relaxed/simple;
	bh=2E9SPnjGZjmOVoWWt9sVX5z2ufi/A9nwQLrvpwVu1c8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KhBE8ZTwpxJXA492eJ2ZkPbVsEwg3D0ggwguzin1mYA2GoI25kqlNeyrMg2Jag0eJlCpQ3UEQiS2BCBF50HyP5mg93ToJ5m/7pxtlIlulthg7XQehqUQeL4KnpMie6ao/KkBLEvMl1fozygsSn6ZDDQfAbqy/Gru+P2lszoPGlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BIg6heay; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nyFu2RJu; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BIg6heay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nyFu2RJu"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 40F5AEC022F;
	Thu,  5 Mar 2026 18:06:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 05 Mar 2026 18:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772751981; x=1772838381; bh=SnMAj5DPUc
	V5Sf0tZhwN3pvTHONS6wJdULeMKp5Ombk=; b=BIg6heay1BHKgSdxq6/TV8wToj
	WiLXsq+MPwhouFxfb+2UPRuxQhpIXTMpoSxmMNl7qWQw3Uv447YhZKsIF693Ug00
	N6yg7tbV9o1MC7a868fZVTI3OSwWTbtrrZZWy29BklbVqYwC6hShYPzaglVOTcXb
	PjM8FT8Q+EtYZLnYd+E5mOk70R7zYuWQ7QXVlb0vHeauBmx/M9/p2LNz3JfP8Xvk
	IN3QBF0+uaoVP8fw5QzbGRZRv53DGoeAgtT/OqzuDO1z2TkIpE2a0Shd9O56QjGR
	xP/5wxw9UKMj+x/0I/fSYQRyh49E4ZuzZ9686+n1/cqSi1lSGsM3ztODlAHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772751981; x=1772838381; bh=SnMAj5DPUcV5Sf0tZhwN3pvTHONS6wJdULe
	MKp5Ombk=; b=nyFu2RJutIl9SyYEBoXbv1YQiT3wip+rI2QIWZtCxo7PijQ2KFQ
	zGw84lfTTVvbw5SVAQvtS0oTFhKmiRO8TxAm4/qkQVjyrpC83bM3JmtrPNYGDPHR
	irGG7SbvWJuQMoeBY5ipzuJxQGZxlykDyPgbYeTdd8VGHEaplCwYxhk250XYqSIs
	zUAhyOFETuIpBFwM4/iz+ck13eu699y0lJdvh0bWQgpJ6HBswbmoDl5s5xaGFAJY
	10jrgN83JaKAD1A3enauayqzYUXUM6h4uWfhCJ7Z/dO0MNCH8wnEcwWdM5RChoPO
	sOrPxQ9ihJyfazXjtlkbmvfTGdKqSM06djA==
X-ME-Sender: <xms:bQyqac4KndPGdpraekDTdepJJs59VZ4yPTvA0JEWGSWqM7IbDw1hVw>
    <xme:bQyqaU5uqS7F6VKvdqo6pJkeEHqmMVFG2M4wJeXSs0Cf-xeqziFHqbjgy2MDMOOzQ
    7jc4S_UPXa4QNqwWhpsnGYNOhrOhD_3Tm-TUfcQkizEsDzGKNX1qtw>
X-ME-Received: <xmr:bQyqaQcZENkciSh6I0wdxHXzq-HhuAoe-n4banLLWoOVYo-ucZiEzMPHJelXEmnPH4rdj0ylWGzZGzFoA5VbOMyjQnnE5VYd3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehfrhgrnhgtvghstghophgrphgrrhgrthhtohesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bQyqaQAA69-qGzlVGHI-cKnR7j0klZTxsl10cNzc0Hs74YKk7V02MA>
    <xmx:bQyqab81UCakvVeOtfBjmCyVzqA-rzdPzRh3NpkwOl0AH7zLiyIDDw>
    <xmx:bQyqaTLKGt1jrCVbD3FX6mzYTAivn833IxO0Oddf7LwjaMCc4158Cw>
    <xmx:bQyqacgWFIDEbfXwMZ2ZINjiz6lbUC9auAro1V_oltEGCsKfax-CrQ>
    <xmx:bQyqaUJ-c7gEpfZKmWpb8EF2334RTxqD6cEm9NxwblMLiXJMOLjT0byq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:06:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Francesco Paparatto <francescopaparatto@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] t3310: avoid hiding failures from rev-parse in
 command substitutions
In-Reply-To: <CAPig+cTsYWVg0nrU7kMakOKQaqFSo=i_nZ=_YuCJK_hq5gdZPQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 5 Mar 2026 17:34:21 -0500")
References: <CAPig+cTHyB2sbBOELPb2=B5sU69OzSPU0JVn0p=2qMp=0=8vEg@mail.gmail.com>
	<20260305090602.22436-1-francescopaparatto@gmail.com>
	<xmqq5x7a3x9w.fsf@gitster.g>
	<CAPig+cTsYWVg0nrU7kMakOKQaqFSo=i_nZ=_YuCJK_hq5gdZPQ@mail.gmail.com>
Date: Thu, 05 Mar 2026 15:06:19 -0800
Message-ID: <xmqqv7f927x0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> > diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
>> > index 92a5951331..64c0a753ff 100755
>>
>> On top of what commit is this patch designed to apply?
>
> What Junio probably means is that you appear to have based v2 atop v1,
> but instead you should squash v1 and v2 into a single patch, and send
> that as v3 so that when the patch is finally accepted into his tree,
> it will appear to have been perfect from the start (because v1 and v2
> will only exist in the mailing list archive, not in the Git project
> history).

No.  The v1 and this one touch separate areas and can go
independently.  The thing I had trouble with was that this did not
apply to either on top of v1 (which by the way is already in 'next')
nor on top of 'master'.
