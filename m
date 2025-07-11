Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC38149C4A
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249691; cv=none; b=WtfPB6K9qbcXlIPz82oc3FD3gYatUWE35pywP+Zm1xMS3MSVCluAw8EnL58RGbvSH+ZiD/fEhXnALskziEvqIQBhB2jmTgNn8zYBI9Wm068bL4QRTAHX46JUe6LXO3vfV8MItm+e+Kjc0olatp3Eiog+sO8Gn5b0R4b2cnjGlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249691; c=relaxed/simple;
	bh=AENjz+meLmIyQUSmyZ6GpGVqdvtxw5xuLfKNlnhCHSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N3nRpi82j05cDcJHhX6UJCk5gDVuaQn0DJhROnCnRkQOJyYjCdlM9z+G2Lho64y9YfhZ4nbZllVO8LIbT03wEcgWC610Q8Wmb/3rjdJ+Cto6I1TtVTGxTOs5//4L4nzxWcWepDxLTfyqg6fI4yvBnKbbGxEZWXFK0XzoY3f6woA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AVPAgwhp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IYNU2k7F; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AVPAgwhp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IYNU2k7F"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72136140014F;
	Fri, 11 Jul 2025 12:01:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 12:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752249688;
	 x=1752336088; bh=fCyBKKfj7nPkX+r+MhML0lWpaWT/NQ+dGsi1/MnM1c4=; b=
	AVPAgwhpy/M6UsmiPX2fuaazv7gwK/A8EsXjhWKzdRX691Ebs51Ic0o83C5Qjnl+
	9r5PyYja5MajIKFB9L7OYqvVLoFyqB9QygboHxfPUtK/lzjvkH4+cO2iQBqtxz4n
	24a+JNl2/HHaTcO/W3Yd8jYgig8c33mJRbgWxmdFniDK90j/SUfOwfTdIFRvsXSv
	IyczCA09dCy4jccOTSfOeqzPXNfOUtKBFgYfi57xcBIrJ5HbsgkXq8eXQaoZKa10
	uENVhi2XHJEDUVyMuSdgmfkU2vg9eGyTBoEP8MT4lTbJbaZSqfVc2hacPsx8iPaG
	r05FIL5bQUtAhx0h8RCzxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752249688; x=
	1752336088; bh=fCyBKKfj7nPkX+r+MhML0lWpaWT/NQ+dGsi1/MnM1c4=; b=I
	YNU2k7F84ic7N6rBx3Ee390Pd1FS83XE0xz85TMM48/TSsBdzHpCl2Kfc/0boCQu
	LCYMJ0IGdNNl9hU/QedPvXwvDx83C5Vo+BWsetXqaEENqo6k5dZq8u+mcoRB+tKr
	ExPGaCmhJeBxrMAI6omkwVYyCj/x/30p/jnPAowPQz/hwg8qhPA/RE4l58TglTL/
	I4K+XCtmF84Zs7emeNr6cQmGbsU0UX3TYyNIFHIsNSsOmy36YBoTsJFa3yRavxwc
	YRfJ6HXUPx4OLCHi2AwifFiAxPRWOKJCVjLcYLhRElkbUDbKucoX9Ai+SIDURe+i
	MtJ97IQmp5pbMNolXY+Tw==
X-ME-Sender: <xms:WDVxaLSFgQZhuRzAXjdTklSE9vBxceGAZZzvUOUHbXIQ_BcU_ljuqw>
    <xme:WDVxaACus7G567TWONLFIT7r4btAbLs4FcMeJT77lx44wNejhORZBToLRHFyngffU
    VhLvi9bvIf2zIxX1g>
X-ME-Received: <xmr:WDVxaKSZn2g_Ms3IjkvccMdu2nqIEiJcyITSQ5sCZcTwIXMZ9WQOi7Zjn3-Zze69dGhXZbVBh1rpDHpUd1tfeJwSxLeRf5rb3PwkHQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WDVxaGo-jzUDlGwMLPaHXdzoQR6pxsnVA9_L_SwJFi61DueXJ_9MyQ>
    <xmx:WDVxaExQWgDysyimvch3lQLItyw1nbwph_tCJMtsyA84A1JJPGVISA>
    <xmx:WDVxaDKCe6anr1h0yM7HX85aUUtA03f5fFq5_rFCoS62gMXt3pBJwQ>
    <xmx:WDVxaOIb1p45WUBJR0UBd5Q1cbIFeSYKuJREfy1jkuoLaVVfezDGRQ>
    <xmx:WDVxaIqijRjGs_xg66am_cGp5AII6oO2rvyYCyJf6E7fyqqOafjYcvlA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 12:01:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #03; Wed, 9)
In-Reply-To: <CAE7as+Ze8EHda0wMfRKC4z9jE0OLsxxSgckBLisJuoxasgzTaQ@mail.gmail.com>
	(Ayush Chandekar's message of "Fri, 11 Jul 2025 07:35:35 +0530")
References: <xmqqv7o08ocn.fsf@gitster.g>
	<CAE7as+Ze8EHda0wMfRKC4z9jE0OLsxxSgckBLisJuoxasgzTaQ@mail.gmail.com>
Date: Fri, 11 Jul 2025 09:01:26 -0700
Message-ID: <xmqqple63eeh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> Hi Junio,
>
> On Thu, Jul 10, 2025 at 1:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> [snip]
>
>>
>> * ac/deglobal-sparse-variables (2025-06-30) 3 commits
>>  - environment: remove the global variable 'sparse_expect_files_outside_of_patterns'
>>  - environment: move access to "core.sparsecheckoutcone" into repo_settings
>>  - environment: move access to "core.sparsecheckout" into repo_settings
>>
>>  Two global variables related to sparse checkout have been moved to
>>  the repository settings structure.
>>
>>  Expecting a response.
>>  cf. <17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com>
>>  cf. <xmqqbjpuqkrj.fsf@gitster.g>
>>  source: <cover.1751309770.git.ayu.chandekar@gmail.com>
>>
>>
>
> I have responded to your message about keeping the topic in 'seen' or not: [1]

It is not an issue for which a response is being expected, though.
Has the issue Phillip pointed out been resolved in the discussion?
