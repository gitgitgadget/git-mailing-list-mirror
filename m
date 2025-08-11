Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D02E3AFD
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947715; cv=none; b=GB47c6EYh6SCE35UEsDKZfwTxXnyajtngFIySI33Lw4Ul/bEp8Wg7Md0PpL4+Ysy5uIpCx8+KRg9DtC3tx6HQBvW2y6oKsJ3VVnExM3iFFePcGY4XZqugW/Sx8QQKSEPQ/xOOzqdsjk1zDPwA42T4WPoaOeN2KrcMR/WRfwOm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947715; c=relaxed/simple;
	bh=jgIwa4RXUUDl6yEikmSTRUSbm//dOWvLtAbh/rJB3Yw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=blHdmkfEFBv4FvpIZLvdTQYUGJ7z7bAMe56OcrK3U6Y15k3AmmkxWgnD85HzCuyXshrFHnth2+RE+jgN+Qhp66bLBMSmTqhlgjORZofbrxyGxefdbYlMTTy1zR5c7e0LZdIU2+bCrJFvVfF4G+HSF2Lslm+qYtI9L1/L7Spwfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iY8LUOmA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ev7ZXRso; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iY8LUOmA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ev7ZXRso"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 837291400028;
	Mon, 11 Aug 2025 17:28:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 11 Aug 2025 17:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754947712; x=1755034112; bh=yOH5HTceZJ
	HhYONuGJN7qz7Hnm9rB8siJHagbuHFaOc=; b=iY8LUOmAO0GMlXP177L9ivzkvU
	RwAs0JtecIYzvFKrecllqZbOzJHE7srd0FNAcphy+Zy5PD6dt7CTRZe1xKR2glvo
	sz9a6arpIhFCyZV1mYSORxaKnoqh6gmliuigYGOQ16/4RQ++UxkZIQSF2zU2hTtH
	KulBZByeJEizgxYwo13ckxEfc6ojNc5g9Y5Frb+qy4DZffjWFQ5ieoKQlbz5+6xZ
	uUhyfQv2GnsSO7a2qYaywSZX+DVj8eQB2lcL7bjnqIke9tFVtiROwnEtpJo+zjHG
	olJPWWXKMk4NzgIxc7SXFE9hAc+aeHlbjt3fh3zPqu/UeIgVAl5Xip2VQfuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754947712; x=1755034112; bh=yOH5HTceZJHhYONuGJN7qz7Hnm9rB8siJHa
	gbuHFaOc=; b=Ev7ZXRsosHRNKh5dJ3gwVT6NSPy7lOHXLXOFHHoMg8hTxmKU4b6
	UM6zsBkjj2BI2qJegXxUz7+tvvzyGNTxB3LrA1AvcLcqCTLArL0QyW/XF46+NvWo
	ZspCTMqw5jPceZ4kq775zZ4+1MWOzTj/Km67YAQNmV1Dib+acHJk6w5H+unwdoB/
	PzIucVb5C0q5i4HqaGvjf8QEhF3YOYvUelPWBFShxDxeMW7ziVLZ9JV6WaXuM4Gd
	eDl50bDI1PIyVUElP+oMgz69vC3Oc3+H16sp8Ol2Oxt120ZI4F9ZmvSlcz8wRQyU
	p6KlnnJzkcoWoe32Je/sIblFzoxlwvGKpzQ==
X-ME-Sender: <xms:gGCaaFNKK_Y3xKQkiJ5DJK8LZl2zsRONtIaLj_KVJlKmiRMbYNkSXQ>
    <xme:gGCaaDfKy9ZYZu1vnwNzQbdSQ7FBZZKQFNg6lOPmzcjPNBG53CitIr6QKwweHdW7G
    TwiO9xM7-8kpjbVHQ>
X-ME-Received: <xmr:gGCaaKutxy5uHGG857BhSHLO6u3FwYK0QYAEtcMPPNXzF6o5_RB5pLyPaqGQ0xR128rQkvc4Z-Yiu0AdMZ0gG4-uvjOh8TEdRexlZjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehnohgsohiiohesghhmrghilhdrtghomhdprhgtphhtthhopehsthholh
    gvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:gGCaaMlQxunXOpKAWB64bhLAcoQdz0Lr7RKE6LI9-GQgDUcZs1XehQ>
    <xmx:gGCaaExVTYHlApkczskADTu3A6OXmZ7gcxwpC0KT1-PUZVu0y4o6aQ>
    <xmx:gGCaaGPh2Gj8gADOkVBsY_tf_biQXsj3r3McK7GKwIJa9hAvXplbvA>
    <xmx:gGCaaIoqjBdlod1Nv8S9EJBhQXTy7dqCWBC7REaDU7vfPx7wrrjZlQ>
    <xmx:gGCaaKybw9CSY5Rp_TOB2F-UyzyQfB7QsxRMMbz1vMyJ5IWIoBy17Jg3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 17:28:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Jon Forrest <nobozo@gmail.com>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH] abbrev: allow extending beyond 20 chars to disambiguate
In-Reply-To: <xmqq4iud1rfm.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	11 Aug 2025 14:25:49 -0700")
References: <xmqqfrdx517b.fsf@gitster.g>
	<aJpd2MYMWgEoxQWi@fruit.crustytoothpaste.net>
	<xmqq4iud1rfm.fsf@gitster.g>
Date: Mon, 11 Aug 2025 14:28:30 -0700
Message-ID: <xmqqzfc5zgxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On 2025-08-11 at 15:26:32, Junio C Hamano wrote:
>>> When you have two or more objects with object names that share more
>>> than half the length of the hash algorithm in use (e.g. 10 bytes for
>>> SHA-1 that produces 20-byte/160-bit hash), find_unique_abbrev()
>>> fails to show disambiguation.
>>
>> Is this really the case?  
>
> What I wrote in the above is correct.

Sorry, I meant "incorrect".  And using GIT_MAX_HEXSZ will break the
abbreviation system rather badly.  It has to be the length of the
hash that is being used.

>
>> If the restriction is due to using
>> GIT_MAX_RAWSZ instead of GIT_MAX_HEXSZ, then that's 32 vs. 64 in our
>> modern codebase.
>
> The above numbers are correct but irrelevant ;-).
>
> The thing is, the offending commit changed from 40-bytes
> (GIT_SHA1_HEXSZ) to 32-bytes (GIT_MAX_RAWSZ).  Plase see v2 patch.
>
> Thanks.
