Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE66413258
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972273; cv=none; b=CGZz0ofiEzFhaNbhd/8JtGpRASZ+036ycCod2SFASHExfv2Z3OMbaAutCCGg7tTuVIn6Iqo87ToRGAIVwJ5R3t4GnDiJnYxuYcYLrLAdkTfqHtGUuw0QGzoyaruAzZVAYQRRh7XCY3nZASMJtj/1L6zfGsdoe9OIGs/LQmu37Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972273; c=relaxed/simple;
	bh=TJHKLMqRrykH6Pve32fb+SOG/PjYHVZCpt4DKYV8248=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RTtADP9wccXf+NMCtRPVeLvbb7zMjeHLF3cg507+kuxv+2ZU1J8sG30IINp6WHjkTgDbIGFCdsXJ/7QVMJuk1XUXuXu8FakhPvd2vYwFWR5DgJoPmLLLxBUw+Igftpdc1Oxd43OntAcJInG3G3f1TytSlLmKxZoGOEf5Bci+e68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tKu+nhaz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AipvP9X4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tKu+nhaz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AipvP9X4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61B311400213;
	Tue, 31 Mar 2026 11:51:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 11:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774972268; x=1775058668; bh=ItU37qGFlU
	0ieiRnGO9aApv0jas86f+LcxeHLXsBBzc=; b=tKu+nhaz2OEXOVHSVFVYhEF8Mi
	MuPGVYo0FLHU4yJisKYd6mxIvEwFFNFgV5MgZZUQ1h05zl1iOch87P3cJA7Pin8m
	UzYg5d9r2PUj3EN5fSN+MB16bXWpVLXGDli6yfWISabrNwGsbmazzeRwEcW/SZfq
	9MDMUMnJFjoZ0dBTHMe82xftsFdpMyVMuHB0R6XmnMjj7g8xnVz4cjnP4N4foF4x
	eQ4LK/SVNkqHIOlci6B6PQ30nw58/CmWDL0xBhX+F2A6rVzqZntQaTSqf79lw8pX
	tzSTQzN4axidsHHXUAZHZLPsPc8VsbEUrVt46OanOqItgAxQpFVvF0k3Ktpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774972268; x=1775058668; bh=ItU37qGFlU0ieiRnGO9aApv0jas86f+Lcxe
	HLXsBBzc=; b=AipvP9X4Le6LKqV6SZhthPcu1XNWl7wuRsyugmT+VwEpVjFgH8F
	bvCfjK5B1hAiH0GGdcw6IbPzzl5Jkw4XnBvO/MIjEWAG0IlFXpozjT1Qlk2EhqZM
	dLmVF5UBJirGsjGdO6zot4MA9jwcZFRALzU+D6ccGupnrkAjZV1oLHQlwDWt97Is
	6zlZgjRR+Rf+PtQbW2izqYcmQiuUTOgZQI/UZMgGph1fVd7gpM1xzvztjgvfaa+g
	U//y8ppqGnitxlOumd1FrFLLI6mRqPxwGgi+dqBoKBohgcmYo5/Pgt4ii2O1Utft
	nE66YUQccjrNsP2zXBfTshr7w4VvC0fdFiA==
X-ME-Sender: <xms:bO3LaWN3BBKJhMGiNJ18i65m5h6whbaZ2v12vHhFEfQNh0rWcY_C5g>
    <xme:bO3LadLX31pNU9Sl_Jn47gUzFDCDPJ3JIjPUMhBMEEKCCesbZCzuDzIDWgeTeJsrI
    ymYOmgk3pM5oz4xvYvPo4hnVOPq3MH0zmr7TUSulqTnmjIaQU9RDA>
X-ME-Received: <xmr:bO3LaY1SSGjPj2GrD-TaOd3s7ueOCGqDUWz-Yh1lW0f7CmRVy81ogx23wsJRC9GpQmHPml3u51RQuwIcH2_mp-2Ccwhtf5b8ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhgkfffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepteelveffgefgleevueejieeigfeihfevleegfeduleekteetvdelffdugefftdef
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheprggsrhgrhh
    grmhgruggvkhhunhhlvgehtdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouh
    guvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bO3LaRVaaiNtZr1sJJadMpuMiRRvdstvgKD6tnfkXjedfu9XpcSrvg>
    <xmx:bO3LaaN84dlho1ltjndvnGUlmkFJlqX5_I988uaA4HVL9oUIf3XtRQ>
    <xmx:bO3LaU1WJZL2-o5SNYZEypUO81LOq40Pu-kZAUIhlYUXtoX9FB241g>
    <xmx:bO3LaeQHNup-5_hHGjl4WpJeMu_NssEHay5dBttJtFb8FbaqlPPFiA>
    <xmx:bO3LaWvuwhOjcyscnRqVhw0cvd7nQYlOqXWpr7_7xZ90zweEpmFj6d_3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 11:51:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>,
  git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Siddharth Asthana <siddharthasthana31@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] repack-promisor: add fake paths to oids when repacking
 promisor objects
In-Reply-To: <actjaxIkDEXHJbyi@pks.im> (Patrick Steinhardt's message of "Tue,
	31 Mar 2026 08:02:19 +0200")
References: <acasFS_UXC8NybtE@Adekunles-MacBook-Air.local>
	<actjaxIkDEXHJbyi@pks.im>
Importance: high
Date: Tue, 31 Mar 2026 08:51:06 -0700
Message-ID: <xmqqqzp02e1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> This will ensure they can be grouped by the type and existing pack
>> order which will make them end up close together in the sort, improving
>> delta compression.
>
> I think the general idea may be sound, but ideally we would have some
> benchmarks that demonstrate it actually is. Like, can you come up with
> scenarios where it will indeed improve the packfile size and show the
> advantage of this change? Are there scenarios that are likely to have a
> disadvantage because of this new ordering? Which of these scenarios do
> we expect to be more likely?
>
> Before answering these questions we basically just claim it's going to
> be an improvement without actually verifying.

While it is a very good point that a change that claims to improve
performance must come with verifyable data, because the packfile
size alone is not what you want to optimize for in the first place,
it is quite hard to come up with a useful benchmark in this area.

Back when I was working on packfile generation, we needed to
optimize for two things (luckily they are not competing goals).  One
is to choose a good delta-base, which will contribute to an overall
pack size that is smaller.  The ordering of the objects in a pack,
on the other hand, does not directly contribute to the size, but has
impact on runtime performance, by keeping related things closer
together to reduce the need to "seek" in the pack stream.

Generally, two objects that appear next to each other in a well
optimized packstream are not expected to be similar with each other.
They are more likely to be two unrelated files that appear in the
same tree object (i.e., they do not delta with each other well, but
at runtime, they are often needed together).  So it may even be
detrimental to use the offset in packfile as a clue to choose among
potential delta bases.

Do we have name-hash data for the original pack somewhere available
so that the repacker can take advantage of?  If so, it may be more
relevant thing to reuse.

I agree with your other points in your review, too.  Thanks for
helping this topic.
