Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9902D9ECD
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739382; cv=none; b=tR9Ykn52sXn9c1TtSJmeellPOwlwBXpQmYo+ScAFD+saxajCR57LoKEaaBKGt95mxSWNiLemZrHlK3Gy2LXTmAF5bOwny9xpxeASexZ/UQmk2UY1V7d9bCskhwNWM+gL4YtDDfD9IzYUN2uIbDImVKcUwwnXcNotaw7+sOvbKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739382; c=relaxed/simple;
	bh=QuzyvEmc7n4gDDLFqMgo8gRpJoiwVNuD5ELlkejkzLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBlIe3VD7ElqrWqFL5FfVvuUN6ijLcO97N1Qn5ibP4s7S6yezyr3WBt9GS1Nx9wABbkQuLjVZ3mLwlaSfS1sWffT/BIDC8qAror3KUKcRHoju1XX8cx6SrSU694KBi/7dhYnIrHXS7cci5BE5XEPqmFypRbnaL2t9ciSOp2HGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZIDZ/ArP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5XuEqE5N; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZIDZ/ArP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5XuEqE5N"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 4323FEC0640;
	Thu,  5 Mar 2026 14:36:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 05 Mar 2026 14:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772739380; x=1772825780; bh=AbLLWJWotT
	bB63dWj+P/ttbx2iid08JNhzmbEZZo0HQ=; b=ZIDZ/ArPIYAUA7jEvLEP2o9tQP
	stKYdY3RQhtuWQhcgzBBWyxoAHZNrfM8Da8wpnTKPqCWNWh5d0FFJKRGcgFt3T6N
	tSpnTvEgMuX48fG83fm3GHZIkhgVp1z891FiQw/IwWp+XHmJ6TIlmK2HXhXtMYcr
	IKSy3POQHHsdHfu6/XfcTViqDuNXz7MiSFTP4Me6UAOgtInX/NoDfMxu7JEScsTk
	Mci2ub/mJyRq/Zp7zDMg3MlluNoZfVbQa6YwdLuqO4u36sRLVBHlTa5MK6Ib/zS2
	EzlR2cOwyciL01vI/ErsCCUlUNqRtoD9Z73RIrFpj3/maryhBg+xntVgHIAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772739380; x=1772825780; bh=AbLLWJWotTbB63dWj+P/ttbx2iid08JNhzm
	bEZZo0HQ=; b=5XuEqE5Nz6r3DXJxsPi3h+4AxphtWhDwkCb2k8kpzgY3PsyCZVh
	zxTZIvBUz3VJ/H2Tz0UCxGXFQyiLgbwzqfQ7ppLqlXkWHN9+1JzpYr8Im7Uo151U
	oepSidKQfWpOP/419Kz+jXuDBdeBCt4T/xWOO8Pl8msuBfm6f2oVcyjEBnAYiKB5
	thMsusDK6RScTT+P3Q6efe5grGI4iaLvMRmUr/9XCzs54khqrth4jZ1B766/d7m8
	nDVsifeQmQvuHDjDfDVIde4C7r4N98Pq1+Ufi5BP1sm6UtSDNH+Lr+eW6jvRtw9v
	9BXH25Udqbq08L/Vb83DdROXZwhR7lr8TDA==
X-ME-Sender: <xms:NNupae9L9OdadHhR77bmsTxg-Z6LErLMr8igL-kopW2WOrU_zFdZtg>
    <xme:NNupaWIGYzPxT6wCKy_0iV3IADlDgb5uj7XeTtf3f7FwNZOPQluN22DJRdAYQ1DRY
    yk3m0XS6oJ1iuV95Vb2YpEiUsnKkIZtvARTmL4DJ8lC2tJnCKNN4A>
X-ME-Received: <xmr:NNupaRbMu-u3zexuo3obM44_LEBl7zZyGvlkAcM_1j_1wYmF2-h-tFN27U-lgpEyxSDObSEToKNDhR66YxVr8n5UTYQ7ZjTwiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtd
    dtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NNupaQItZDkn1eSTjA7XWysaWh6YHYn2Ndyha318o17to7R62VzyBQ>
    <xmx:NNupaXBxUBTT2slFLfdFxHWJVi7YgNU6NGpvJI9wMhQUmm33ZwjnPA>
    <xmx:NNupadpt_KlLBEAHFpUpxGTN76XPM4er4WdtplqxIlFvYE1NZHwHtw>
    <xmx:NNupaair9-mPsrwORKfj-VYpU8OLkG-o13TdmT8kM8qmwp9u6B2tjQ>
    <xmx:NNupaSK_kXWgMMKgo-K0hDgsDFaSpYI0ZLBBXmQMjg5NlCcSUumAtxZx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 14:36:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] clean up a few things
In-Reply-To: <20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Thu, 5 Mar 2026 18:23:29 +0530")
References: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
	<20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com>
Date: Thu, 05 Mar 2026 11:36:18 -0800
Message-ID: <xmqqms0m2hn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Changes since v2:
>  - Update commit message of patch 2.

Hmph, they look identical to me, and more importantly, the previous
round has already been merged to 'next'.

Thanks.
