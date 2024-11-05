Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B161D9359
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789476; cv=none; b=j3lqoNDvwJGyh58vtJWD0Dr+awGGtt9L+38i9T591LEbT5/UO+qlqosYoT01uCvh5AmjT0WP1L9SYTUDi0La+Kvo2JbjQL0eQDddgaoAIck5o1xdZrxyLdQGt/w3qMeiHNvP18MwUC3OR32upxqW44mN+NiwDgWFwkWEEArGgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789476; c=relaxed/simple;
	bh=+gedjCmcO0LvbujtIFbmfGii0Zw9H/imLNUsIrHPYdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B4RMgzetwWFBIuy5u7ZDrMwtcjuIzg3ye7LNYIb/udEoBgvafljyy3JwWnmhjPgyyh+f9Yc7FU9wzTB1+XSCjW2s5YctYICVelUtqxQD3l35rqCrFaJoen5nwclltguhJv5453BSn7w1Wqr8E48J3bIyEVEnKk7sugkK8sJf8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iz8ZIJk9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gJR7AEC5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iz8ZIJk9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gJR7AEC5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A78EA254009E;
	Tue,  5 Nov 2024 01:51:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 05 Nov 2024 01:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730789472; x=1730875872; bh=3nhHWuC1Og
	vzasUKJBpZfyTIt5NpDq7Lp2CweWEk0NA=; b=iz8ZIJk91HxK91Vjwxgn+rllWM
	imE6tiMtOMANsAT65ZKBTACDSniilDNRaJGVEiiJc4PMuLvO1qj5x37kX7PNqGW8
	pILx9EUbqRDyMV2tNYkeJolQAu7YBnNMjl+QHyVXolIr27KoqR7A9f16b6AaGdDE
	g0FlAhEAgzP+2utUBKwZv0SzfEZYFEHf0+TMgcW63MZvIZ0Ugzm/Jl3W8cuyVRYI
	vMgV3iEwLmY0mrrRan9ydtbSzkqaotZ1XG/8Y5UDc/Dszcv0wZZZtlMHG30y+D1P
	RCZFfG56U03zNnhQAVCb2sC0VU4mspUfMeUXfaFviq1UxkFC6G1FuIMnfgHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730789472; x=1730875872; bh=3nhHWuC1OgvzasUKJBpZfyTIt5NpDq7Lp2C
	weWEk0NA=; b=gJR7AEC5S5+hASvnB53LLFszpeA8Wa9TwlD1rlS68Zb2urzn+Fp
	yU06Ag19gaUweB51EfWGdMqgDNxBkhpUebVGEeELDiqBKb3kLPHfc9jPNIRhYhuM
	OjCviMtn+oaa70CvBwxTOA8tznPjVccxYrVmtVKtVd2CnTIIIM+Kt8UT6Z4pTMpi
	IiEUT7bkebuTw46H3wHof7GLsDdA2dXnpBHbVG9FwQHsJKvUpPmjFQZLG462S2J2
	Q7fSMYJt65rMLuHhtFIsLWWmzR+lq/eo1JhbIcPKLBN1xietEhehe6lyFZGbyu8I
	ngeOH/+e5L8yFUYILKeDQUIS4MqiLMFwH4w==
X-ME-Sender: <xms:YMApZz1D9_5z-iP44rCSuHApxACgNN_5zJnzy2lYATxsxvKsvmBE3g>
    <xme:YMApZyGL4t87PQk_HZlrjB0e0l1SjHnmb5eW3YnXZYA404axSKZIXXIZEU-zVP2zW
    94hGuK57szMo0-iOA>
X-ME-Received: <xmr:YMApZz47QbTAlBTKLMGfajm8oYA2hmqHanPpa0cAzyAm9dETKPf5HJVqK9epbBZcDdMt3W1sdRknT1INwZMgbjQ7xUOFFQF-hbkS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YMApZ41ZCwElRUAEpkLE4njN0ntWqrmrp1MnGc9G9fIolgFEsuquMw>
    <xmx:YMApZ2GTibTvAEwXV88JRy3UANjEb5lmoFwnonOr0LcLkraIlMMoPQ>
    <xmx:YMApZ5-CT_W_QZzvPtBcQP3s8GcD-tCpwlFK8ScxZZnBQbKSssx_ew>
    <xmx:YMApZzkJZ6GtCtxMXA1_jaOEeBgAoPzBl4zk1U3Eg6pY63BVQUKmnw>
    <xmx:YMApZ50f-fpFOBl4YwZOH_Ys92oK-TKU2yaQXiQ9VYDjKJI9UsvwbJaN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:51:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Toon Claes
 <toon@iotcl.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 00/22] Memory leak fixes (pt.9)
In-Reply-To: <cover.1730786195.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 5 Nov 2024 07:16:40 +0100")
References: <cover.1728624670.git.ps@pks.im> <cover.1730786195.git.ps@pks.im>
Date: Mon, 04 Nov 2024 22:51:10 -0800
Message-ID: <xmqq7c9itbq9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes compared to v2:
>
>   - Remove an unnecessary cast.
>
>   - Fix a duplicate newline.
>
>   - Polish a couple of commit messages.
>
> Thanks!

I spot checked the ones that did not change from v2 and the ones I
checked at all looked sensible.  Perhaps this is now ready for
'next'?

Thanks.
