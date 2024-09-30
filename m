Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3F5466B
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722130; cv=none; b=eX4CRp7akAScvXWwlkw417rlW28HDMrLlLkE4pNOAC077ZHBqD2tg9hq/kCVAPFuHb+ac/NIrN/B2rkJputXzpm8c1syVOCTai3jfEAyyWW5a98vXl1KDVtJXnQlkncXBAASQotnLXbHy0jFazkc7gcan9pi7zJ3xC8507cmEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722130; c=relaxed/simple;
	bh=pIc70Abtr3r/jMT7jabKmKsWSH8UuXViLdJgYEQcsZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZmqWjsV91ehqYQqfhLHXbKRTGYki2tzTfVkma2bC4ajZEAb1IskXfaFAAI1yxoZT5dcSwUFgAErDrmcVDXKjnxM9YLVy1ZsCMAfrapBapnaOdYGcc26jaAkAlF2LMf6Re5hinfoH27gyHstLljHwwnYmjAVT6EvnK6NTTrVVSvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d8Mm1KQ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fHbzCyKR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d8Mm1KQ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fHbzCyKR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F11B11403B8;
	Mon, 30 Sep 2024 14:48:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 30 Sep 2024 14:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727722127; x=1727808527; bh=nBbNFzQz1D
	/4Jmm3cViFQhIheU9zC5qxw/jmY63aqkw=; b=d8Mm1KQ9dCHm6kKA0Jk7snbsK8
	Q2hT7xP8UT+ZYkpJkg5SF8HlugA5LDRMeuKuRK4e+DSoCDRzRzVjga9vXvCDQrxt
	U3WKrcXkyw5ryXCM1zL8zPxMw2wL7sx0XU7oUjVG3j5FG1Xe0PUUvkIGg8VE+c7b
	kwxCBFq2VlZGORcQOIgJC5IdW1aWK/lfSfrFk1ld0r33dXSIugUQ0cw6Ffx4m7CM
	GsBFA0639epB8kiwvGiFS7AmAlWfjRJWyTRHkRSsoNJ8snN6d6Pws7nQgqpS+lwd
	WqmM6Roq/gqElyscjcdc+a5Ik3LLq0fEWxPoQeycJD8n73Qx+RxPQaJqmcWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727722127; x=1727808527; bh=nBbNFzQz1D/4Jmm3cViFQhIheU9z
	C5qxw/jmY63aqkw=; b=fHbzCyKRkuQuzeN5sN+2UD5DTuHRQuL8nkqZbTd2vdyM
	9c4nqVFpatbKUWnaF3W6yvTCYGL6VBPdRDMZITCOBfKmmpiqFxd+9oafgF4OlP8c
	fmfaxVmU6tB17m5st5dDJFAv5jZ99wyLVsugUfpwoRpdxaahkOc+rSwcs926560C
	GPsc/coFJ12/Ou1l8hVuk8gRffCT+6HjO2/A5ME0iuUyMcmTUCwAMpUF0r+FS0mt
	KA8ZpbGmSyhJxPK7EQE6YgwQl20r3xyjtnWp/9XF3YLneLIQUT6S/8co23ur2SOI
	d1oJVvwL+u/QiwtbntJSCiPHVCLBnb9p7DNk9tYpZQ==
X-ME-Sender: <xms:jvL6ZsEZJZ2kooEQsQE_FCt_EQnVvFTG31ny1o4KM-UWiAe9ZwTC7Q>
    <xme:jvL6ZlV50aFyl2VMCyIgvPwZ41X5M4Z_YqK4KLFaP54MjULkD5bEt_fWIBKwG0vk_
    P7qt2q1mTTwjbJvGA>
X-ME-Received: <xmr:jvL6ZmJf76Ac8EOZXIwRuIZtHABbUmMa1rPchpMbl5zTv8TY7eB47OLyzDadvAgLuRRPUyWSusKyL2BIQXk7WM3-hpNhPdjdM4zylUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    rhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrggrrhhtih
    gtrdhsihhvrghrrggrmhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:jvL6ZuEU2cT2l6U4z69Bna4sV0OqW8SRJatToHuVGZJwz85ZEk_sMw>
    <xmx:jvL6ZiXO33IWeIY_51WhLtqpvbP7NB5IgaA5E8XDR6r6TegblHq4dQ>
    <xmx:jvL6ZhOggp3w6FiYy9dG8EQ6xAvBCQOoZNnzz7utt2Z4sxSSRIWbBA>
    <xmx:jvL6Zp3LkOoyvEkkSDJIf8IvuWmVyfbIMEwBv4HiI-dsyb8LYQABXg>
    <xmx:j_L6ZmrknOucoQrRkSRI6lkdqWDizbMGfhAy5ty9nDdr2ACToJKI8sKV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 14:48:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  Ghanshyam Thakkar
 <shyamthakkar001@gmail.com>,  git@vger.kernel.org,  Christian Couder
 <chriscool@tuxfamily.org>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [GSoC][PATCH] unit-tests: add tests for oidset.h
In-Reply-To: <ZveqArC9NNs44Fjc@pks.im> (Patrick Steinhardt's message of "Sat,
	28 Sep 2024 09:02:36 +0200")
References: <20240824172028.39419-1-shyamthakkar001@gmail.com>
	<CAP8UFD2yTMNmx0n1jhOu7dz_4XeOyTy1iLmRWYmuf9QJf75hsQ@mail.gmail.com>
	<xmqqy13ei819.fsf@gitster.g>
	<CAP8UFD3JzYCJf4+JLvfW_8m6kp=O0NMKi1dF1Fof9=DmvZ4u2w@mail.gmail.com>
	<xmqqcykpgchf.fsf@gitster.g> <ZveqArC9NNs44Fjc@pks.im>
Date: Mon, 30 Sep 2024 11:48:44 -0700
Message-ID: <xmqqmsjp6kqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Let me use this to give a quick status update regarding my upstream
> quest to address the feedback I got during reviews on the clar itself:
>
>   - There is a .editorconfig file now.
>
>   - All the cross-platform compatibility fixes have been merged.
>
>   - We have Win32 wired up in CI. Doing so via Makefiles was too much of
>     a hassle, so I converted the project to use CMake for easier cross
>     platform testability. The fact that the project uses CMake does not
>     impact us though, as we wire it up ourselves anyway.
>
>   - All memory allocation errors are now handled consistently.
>
> Currently in review is:
>
>   - Self-tests for the clar, where we use clar to assert that clar
>     works.
>
>   - A small memory leak fix, as well as wiring up leak sanitizers in CI.
>
> I've also got a patch series sitting locally that introduces type-safe
> wrappers for the assertions that I'll move into review once self-tests
> have landed. That would then address the last bit of feedback I got, if
> I remember correctly.
>
> Just to let you folks know that I didn't just do nothing after this has
> landed in Git.

;-)

Nice to see that the code is improved not just for us but for other
consumers.

Thanks.
