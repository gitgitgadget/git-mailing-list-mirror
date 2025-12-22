Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6B23F429
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766378563; cv=none; b=rGK0ZdzB2DnP9ReXC35cV0JVgl7JGDKZebUpu5DU6Lc/jHzI5VU4wlH9D4VohGHcHUHpMge71hWwWNrBSOspJTnKhZA4wMuYp4QhZkSYlxqR/zXBP88iYbrMo3nf7wJAZgX7P4s3o8cpX1W9mzoRKxUTsi5M5VZeHhyw+c/MKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766378563; c=relaxed/simple;
	bh=XvqNfBrSJC4iltsTmWUj/2kWspUBClfGi7Voske6ivk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UTfms/lgEHGR0MRm6jyW/Ee9YExeHZsjtnF53mFdmxejHhpEB80gOcSIA7cdjNe24xz866Hpiflq6MwxlKOFNI4WnZYA/mFgfSbR0Qn2VHu0rZNSp6Zyqr3JUeglzq2ILUCRTRsR3tbws5iNLpLzBkON+Ipg6pW8YXEx9FnPdAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TKfsbV+F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wZXOx+Nv; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TKfsbV+F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wZXOx+Nv"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 408167A005B;
	Sun, 21 Dec 2025 23:42:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sun, 21 Dec 2025 23:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766378560;
	 x=1766464960; bh=XvqNfBrSJC4iltsTmWUj/2kWspUBClfGi7Voske6ivk=; b=
	TKfsbV+FbjJwM7tETRkM4PflGAjkZ3TSynHE7Uca4Vsj49//8nNhndD5+qT6UWYw
	mVHSp460fwHY/sRpQ6LhJxMSuhQMp4hVjKqSwHNVxjVAHtnwHf0PekKbxcpjCstj
	TflaGXa/7lnlNzJ0RUBztqu1hUyoQ2w5aMsa+y/m1pKkFODEkPjnZTux89QOviC5
	KnKlcTZdXYLtGnxb57CqmW6TAtl8s28fa95l5tuoIY8ShQPkAQf+tzezT2AEhkre
	+VMc73UcHpsOx9hfUAQ7DRTl52KsVsjz+c09zAzrI5LRQeO2SvM9LJUHIG7/5Nak
	T8tOZALjAEHuCSnxiQHTZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766378560; x=
	1766464960; bh=XvqNfBrSJC4iltsTmWUj/2kWspUBClfGi7Voske6ivk=; b=w
	ZXOx+NvqjItrzNtLTPwHJyN6Xdn3o4TOXT1Kt5+yGx6blXMMZJOuuResz3C/ccHP
	Cv0+kgmB4qWsDy7R3OQKX8rVR1hmP2oGQcFrSz3AnOJ1XQDDfAibzH6R6fzray2J
	c50C1JXLM9KBgTmAF10ViXOYTSii8e968jAgK8yy/k3DsZ7/s0BamYm4oslkuwTr
	BbmUm2m8oC583OJJqf6Ay+OCKLWlcmphXagNZI73NVMhIDyx5jy53nFQWorYc7z/
	geXA1cfnya/qGQdBKtM7R9QfVLdcmA+sPoH9k+2FMN2l46bp/2FMo3GQVYb9ZIc5
	B+h5ZIjok5EPIiuVC3tDw==
X-ME-Sender: <xms:P8xIaUiGcnjWIRhejdgkUzV_IwAFdaxfS9ujfGwrp4g2CaF1S4XPFQ>
    <xme:P8xIaT7D9ILBYVlww99TnsPzkHWztn9iyDktosInzZYd2I_5HGFN_er01VmGiGizp
    sOX_-Qkk53NMGZm_zgMhIFLMg7S7RzOXiGj4G13GTkWzIqS4xwZvw>
X-ME-Received: <xmr:P8xIaUZo2w1brjbpBTwmVB3SVZVHh9K0sQjBSAqpJM3QPhXj1xlSLzsu24JT4BS0bAAxmppBrO_HlJ93Cn4EhZVw8DUBKP8D6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehiedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QMxIaQ50Q2A5TE5-Z1GOkodMYX36crMtXx5oS3Zeg2BnHrIiMs6uhw>
    <xmx:QMxIafC6-uxWuTXpjImIEOt81khhsYFi3TEJGgY_KkXDcYUUV7ZbLw>
    <xmx:QMxIaeeR8aM5SSLiHIa7OGYb5TcG-6RMH76uFEF7CJtgYqmhOO_oeQ>
    <xmx:QMxIaWLxHQDb305O5l6_3JcXTkt11rX_AKJkK-y_tgP9D3Vy9pru3A>
    <xmx:QMxIaSVYGGiiyclpBiORD8dtiP8nmZBR1pR-v5f0597kznybZdKpp6xe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Dec 2025 23:42:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  =?utf-8?Q?Jean-No=C3=ABl?=
 AVILA <jn.avila@free.fr>
Subject: Re: [PATCH v2 2/2] doc: correct minor wording issues
In-Reply-To: <80146290-bbe3-4da4-b951-04399bc2fd03@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sun, 21 Dec 2025 18:13:18 +0100")
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
	<pull.2016.v2.git.1766170456.gitgitgadget@gmail.com>
	<a3a76d448ac2871834576be6d79e4704aae11f35.1766170456.git.gitgitgadget@gmail.com>
	<80146290-bbe3-4da4-b951-04399bc2fd03@app.fastmail.com>
Date: Mon, 22 Dec 2025 13:42:38 +0900
Message-ID: <xmqqms3brutd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Fri, Dec 19, 2025, at 19:54, Jean-Noël Avila via GitGitGadget wrote:
>> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>>
>> * use imperative mood for consistency in options descriptions
>> * add missing parenthesis
>> * reword verbose phrase in git-repack.adoc
>>
>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>
> I have reviewed these changes in v1 since the changes are the same but
> split into two commits instead of one.
>
> Acked-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

Thanks for reviewing.

I've also reviewed the v2 hours ago and the patches are now already
in 'next'.
