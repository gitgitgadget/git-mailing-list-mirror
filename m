Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7767322A
	for <git@vger.kernel.org>; Sat, 10 May 2025 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746835242; cv=none; b=NgD2d8rJyJ/ucxooqq/qQU2lN0SBAPG+M/xYlyLPncAzSOLIcetDL0DmspHP7HwYzpiEpKAfhpMNxHscipP8LqRgcIdPPriz9dnldHfRR7uGWquEJ+7HzbMFqmi3qW/T5uJI7Gm9LDI2w5C9ywee5MScOw+TNsbkdAKknv0q6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746835242; c=relaxed/simple;
	bh=TR6xTYYftYZl5AxJR6ZDadfbM0nVEbuSRUEX95uxlwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mSYXDQzdC3eACU2BWekt43Jo/RF55dM4D6fYPLhWswIG7vD+yEYhFQyQ9SS9LwHVWm6HiND+A6tI4aBaDR5vVwh3diw/BK+7bTJN9dnwRYSL5iu6tIswFfzVR/Js6Q2JXNmFEsY8C4QbZMPPPT7XlXDt0YM0gk84URsTV1FXykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JuuIfJ4V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IIUK6CkF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JuuIfJ4V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IIUK6CkF"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB1E211400C2;
	Fri,  9 May 2025 20:00:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 09 May 2025 20:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746835237;
	 x=1746921637; bh=CULpoOZAYk5kz03a4WdfunV8POOD69Wjr85YrghRjNI=; b=
	JuuIfJ4VelhKUquCkSw3lJCm+Mzk/agIm27ZbGfCHwVZS5NazkBvvPe02oxMgTeL
	aBaFOulCWqixsCiI36n8w5bzm9lS/H9euMvKMeX9vz8dsOll349j+ZhUYlqoBgzc
	8+ISTOzdM1QCiLSJBmXF7/jaHwfitOwxxQ9JGQy3U+lubPskKPzA13bvOsmkibvz
	kc4jGSt7GYW0SoCQIzfk/CdOyoNUgoenw2edrjnDbwgTSYIkBFmrd/75PTXT5F/t
	nQUg5+AYKTLz4N/MPbTYbyg7J9/vLGV3g5zWxeCd2t7rWRAEffzBQ/XZ/lpx1U18
	JKmMr30abbdCbjzsF6GytQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746835237; x=
	1746921637; bh=CULpoOZAYk5kz03a4WdfunV8POOD69Wjr85YrghRjNI=; b=I
	IUK6CkFWSTPtWQW5ZiDUsBrnDpKgqMyC2yDMdRKMebWYyUTQZsfdhs4tCjNNzDOH
	C0cI54YSSadQENuXFymfY7MF0boZGRZH20KbJapY/jJ9B+lrMrY9ClcYxkkBXqjV
	sNvcQeoUWRbmtRikPjud5ufwzPRh/578GonQ88Xp2AfTTpAv/rQ42tXCEyfkH3X8
	fAgknI2e20vU7OtFzOc3xxizQTdL6Ae1V+QGGyeQ2z0doZHNdGs6WhwWEY9bn296
	WB+j7ZWwOKBrQ486u/rRuk5AhWAX3DUCbKuouG4MyokRgP4gTwEOaXNFQVB3XJJ4
	agbeqWMUenYPXyrTsTXAg==
X-ME-Sender: <xms:JJceaI-tNfTOkyHDvRP3r4wHqkwdRkwXg9x3xklmF3ZNFvqH1p5Dew>
    <xme:JJceaAt8k37qQXIrDRgMEsouBXbK-dXFDNAMNI4xfUey3QPMqSODst9fX7GxMOp-W
    2xQpHaTViJRDx8ZFw>
X-ME-Received: <xmr:JJceaOAKwkEvY9O1QQR7vIvzXVC5HWH9r3TDIEl-Yb6L2UZLspg15dcwBtBt9v3-8tmQe51Gj5Id4HOqdbDLB9HTMAPmAv93n2u->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleegtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkefotddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdt
    jefhgfekhffhteeiffetheelhedtgfehtdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JJceaIdNx-CS2Ld35cSX6n_ZH-qvYc4OuPw01Q05RXEV-zlN-TjbRw>
    <xmx:JJceaNMQO4vQsL08d8jy34uX4Mbb6v-hQ1anYXkFhXi3a698fBSBeQ>
    <xmx:JJceaClYrlbEd4ilTGLL_D1ZNd-m0u2OVkNxRLDPy1V_sHu2J0LlIQ>
    <xmx:JJceaPvw2dHaarNsv_3n0rwm0n1ZKnF3ntYIS9SWfFJj5SWuDUpd1g>
    <xmx:JZceaEcfC_tI36dPLdMXxml14wmFMf_NVfAWClpDKyRMpsR2KJC8ft-H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 20:00:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Eric Sunshine <sunshine@sunshineco.com>,  Todd
 Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 00/11] Spring cleanup of "contrib/"
In-Reply-To: <CABPp-BFYuYnbHG9uUOig8gpqrLywESf6fs62e_CMi2uCtNXYYw@mail.gmail.com>
	(Elijah Newren's message of "Fri, 9 May 2025 16:53:54 -0700")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	<20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
	<CABPp-BFYuYnbHG9uUOig8gpqrLywESf6fs62e_CMi2uCtNXYYw@mail.gmail.com>
Date: Fri, 09 May 2025 17:00:35 -0700
Message-ID: <xmqqzfflxrks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Fri, May 9, 2025 at 2:20 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Hi,
>>
>> as I have lamented multiple times multiple times already (e.g. [1]), the
>> "contrib/" directory is a bit of a mess containing many bits and pieces
>> that just sit there gathering dust, without getting any maintenance and
>> sometimes even in a clearly-broken state. So I decided to finally bite
>> the bullet and do a spring cleanup of "contrib/", which resulted in this
>> patch series here.
>>
>> I have used the following reasons for removal:
>>
>>   - The tool is clearly broken, e.g. it doesn't even compile.
>>
>>   - The tool hasn't received any updates for at least the last 5 years.
>>
>>   - The tool has a clear alternative or just isn't useful anymore.
>
> Do we still want to use your second reason listed as a reason to
> remove?  Junio brought that up on v1, and it bothers me a bit too.

FWIW, I would drop the second one and not mention, even if one
personally used as an initial filter to find candidates for removal.
It alone is not a valid justification.  Not mentioning it would
close the door for complaints like "It may not have needed updates
since it works perfectly well for me".
