Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615431CDFCE
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743281210; cv=none; b=dVskVJ2By54iGjneYPmVm+sSGWnbqT4L8GicPpgT2IyMFilpdKnrU39ttfYjourhPDGjEr0iQI//3unOtoMoPcdJYWqWV25Jww8pqRbl2Iy1QeoTrvVQlZZ0h/BrWmHMASSu0+gcwWv+fyL9LJNqDGvre6RK3XF7SmTcOvwpftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743281210; c=relaxed/simple;
	bh=KZLAZmhKrlq2yNT47hQm85ZuQPG99BXqcFEqOg0nGV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O/z8Gl2mB9u0hti9XY69fLf0o5ITv4gZL8K8mCXJprL0n9CldWscc9qIMYdeP77Q7bXVgXbXmLsLn974wRZZNH5yWIZDoMbn8qGb2kIYvQbswMkwIcbjztfu7dP6uXqnIwqVU36o9X9+MgFblatpstItzrxFRAeXJ75Mwq6E+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FI0UNf+w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQMyI41i; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FI0UNf+w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQMyI41i"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 25E45254012D;
	Sat, 29 Mar 2025 16:46:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sat, 29 Mar 2025 16:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743281207; x=1743367607; bh=ndrQ6UN4aN
	RdrIYhvEFecmuO/5je16XB6LxPGz/zB1s=; b=FI0UNf+wkN0ogmF6jzN08gN3IX
	0W9DlwSrn4OYRr/Yp3xUFEwt4JXrfp5vbapcPP+Vkeim1QzvxXQHxnaB591iQ4zH
	pK33/xTqFHJIXv8pH5m3moYlwOIhEjhytvwYcN4GRiifWrM6g1/19uXskXYAZoSj
	4OG/oPV1WBGSaEgJkFjxK+ZDQIwgsLGkrOQPI8ARCboNoP/icoGW4bk27YS2TTap
	tnnn0pTWPqMGVwSz4Nl0ItD3mFhs18cl4YNKqoMmv4dp0ME40sWO5fu+YmhslMZK
	+UdHqPyKDsnqcvihhTXADnHcXJB4KELFRxj6hq30+aVZspL6+Z1dYedKBKjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743281207; x=1743367607; bh=ndrQ6UN4aNRdrIYhvEFecmuO/5je16XB6Lx
	PGz/zB1s=; b=MQMyI41iTohyHRrgNrzUdAHHE3BlVDrJOkTgJpb3GRSPm8kS0yg
	ITNWsbxGhG8a/ZJFwd4vMvm9QkMvdl8ckJWOG5lDlOkPF/pf3ifEg8xxB646IYPa
	DtR5Rrk700aZ/MmJzlwt8r/cRoeCuJaaiaS0H1YXTuOScRYdtvTN4Dsu93ldJ3kU
	Wd2G41CNtTSO21vsQ+1JcTDfVqjoIFFF38IjQGuLP1QhXEVeWXB+gpdUok4Ah/Wj
	/D+8SGDuSHkfSV4Bwjec8M3GAfQtmzUqM1MMd0vGySTR7stMbnmr0iJ6W9oN9+ob
	3ZO15/ioIVNewsq/NaAh2wOciuAwLjvnn6Q==
X-ME-Sender: <xms:NlzoZw-ax_Ku_J_32OZ84YahpQMBkAtliSR_uEiS766Wj87hjc07QA>
    <xme:NlzoZ4suMAO1lW_332G7CXZBFD0SS1tCvGnYMm7oQEuzi4GHiU-Gg90d9yhp6w40J
    Vo635a1XLAj-M8e1g>
X-ME-Received: <xmr:NlzoZ2AL2Q5gfFV5HbNeWt8LluMK7JBvmMZvJ9jR9M7c0B0sLqHjXLtw4RZUaIMc8Vp_MMcqLgY8wSULCoBg6VqsU5_MxgIoRCsuGsI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhrvggvnhhfohhosehuledvrdgvuhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrfigrrhhimhhiugholh
    hlodhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:NlzoZweEBVTi-jiaBmHXm-oaA3VV2fKVHFi4lN54e81mF0Nk-QwICw>
    <xmx:NlzoZ1NFr78-aCQNZdWAkXmKOAGAOIp3Y95sdR_uHjY7FAPRggKKAg>
    <xmx:NlzoZ6myU3m0sbumc36OqcmYD-0yBeTGbjRo7wHWlhhTtmTy6neYWw>
    <xmx:NlzoZ3t5kI9K8IG02vqv1yzvGqAXAcJKzvZUUH9_MLQdyiI1bich-g>
    <xmx:NlzoZ41mc_PWj_y3U7Z2Z8fxnRD8zFvIzb8q12U093mk5wU_1_lwU4eZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 16:46:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Fernando Ramos <greenfoo@u92.eu>,  git@vger.kernel.org,  kawarimidoll
 <kawarimidoll+git@gmail.com>
Subject: Re: [PATCH 1/2] mergetools: vimdiff: fix layout where REMOTE is the
 target
In-Reply-To: <CALnO6CC9M3nBoA-D7rLW_68VkKm9eZ_K7CZn1Z-BiPJWxgNYHQ@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 28 Mar 2025 20:23:37 -0400")
References: <20250325222311.400748-1-greenfoo@u92.eu>
	<20250325222311.400748-2-greenfoo@u92.eu>
	<CALnO6CC9M3nBoA-D7rLW_68VkKm9eZ_K7CZn1Z-BiPJWxgNYHQ@mail.gmail.com>
Date: Sat, 29 Mar 2025 13:46:45 -0700
Message-ID: <xmqqa593d0p6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

>> ...
>>                 FINAL_TARGET="BASE"
>> +       elif echo "$LAYOUT" | grep @REMOTE >/dev/null
>> +       then
>> +               FINAL_TARGET="REMOTE"
>>         else
>>                 FINAL_TARGET="MERGED"
>>         fi
>> --
>> 2.49.0
>>
>
> This looks pretty obviously correct to me, thanks!

Yeah, thanks, all.  Will queue.
