Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69319243969
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493163; cv=none; b=EyxnY/TC++Eky+lQrU2KZqj1QVc9Jl/BK+meyUAMyRQLrQ5+3/NeIOgaU037zfTU96BnVPdjMBrw3GL4PxGDbFwbWrT7xXIIWq1BhdplG6KNotDbSsJhkrqwe+Otl4m/i7jwtvAkgbPCOFkN5nlEm3cL8BK9I19l3tm/j548nGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493163; c=relaxed/simple;
	bh=S/a1pfdBPRvMEU+pMflXCYiUV3+x3BGHcS3y5my9VA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lXwMUxQn5yM/6yUhmFQEjwhXiESTJRXd2WmOjsAqdHw8XgcpplZmNYx2/KdolyCMmLGqqu+CkgTQ+/I0L5Bnuv0cKARmt1n3+c+O7xwzNd3T8ND0SfUk/UnhDrDdGJHDpeo7ZIwyecx6tfpAJ1Fe+xyUcLd0uam/dtlyBlFr58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CGhbhC71; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JLc0Nw8k; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CGhbhC71";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JLc0Nw8k"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 590E27A00D5;
	Sat,  3 Jan 2026 21:19:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 03 Jan 2026 21:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767493160;
	 x=1767579560; bh=S/a1pfdBPRvMEU+pMflXCYiUV3+x3BGHcS3y5my9VA4=; b=
	CGhbhC71fZmvzUJiHDFMdVQMk4xSRxghMfT5euryzV9fql5u9H6as3czV6fqD6XH
	Uzdn/9K7hQ6zmwtV5YyhruLa0o8yM1O/qSlJz7gYzH4mhVm2lgBA/pQg2mJ8UmTj
	WtvFg/ZU+2yb7GjbTef2nMo9fE3bI277ljfWGT/qnHodIELu0BUhEZj37q/YLTwU
	cMtq+mAvYNBYgw0PnCiuxhJhVrP0iJ4m5CdfJM3y6uauoZPWlcyr+3L+MNT+aY0p
	vLN4FhI2/2ktGzFDqgLrBz/qSfoQh9/vvydZjFvLsxAfCCv9oUC31NjsHlcnh7+P
	UW7KEh5GRC7XP1HU4nM/wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767493160; x=
	1767579560; bh=S/a1pfdBPRvMEU+pMflXCYiUV3+x3BGHcS3y5my9VA4=; b=J
	Lc0Nw8k09IAEl9i2QSUnR9kVQd9/Ov7+3qLwERXKnxTR+JXEv+iPqKS3oKIKztOZ
	ClUEyjM87wHZDISPU+ys85I3e7kLG7b96D2aabtfmVKtwJP/Oy/ceD4t41SOvd6h
	UO1JLZnZCCBH6AGj54BlsNttx7a1HKahammu6WK2lb4ZwQA5IY/ROhGmjBrVFYP6
	TQc3ayQIc9LaNwk8feHhdB6l7qV0wSGKIcaRF8rAh51vLSBVH4gPSCtGNhcv+YcK
	W99X4u5rHh8U79BAjVvkafG+0dtjRdRrWl278SWfTouCL65K/1dgpzjXMO7kPCAN
	QVlFtFTF5/5YO8uR07GiA==
X-ME-Sender: <xms:KM5ZaaVCcD2qQokAticBIHEHUUzAF5XPYvG7eFCVKQ6byPrRtYQMEw>
    <xme:KM5ZaaTfOYKv5rpvui8HIYMQlh0f_9vjUxsJML3e-lqp2hKTPVUeSjQx6AnxV4UFY
    Ob0LfJmk9bwXfuWJRaeu2xcNVWEjtO47a-Zlozm8QvXOBYpKH-eHw>
X-ME-Received: <xmr:KM5ZaYPrhB0YjIycoQC0h7JNIgq2hMoVzM0lvF2KFJYB-6bywQl8DFADGCRtjqPr3tK46kP_ofPAX1Ds1irTkrJWOl2d69QGFBkewxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfi
    gvsgdruggvpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvghkrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KM5ZaYRo4ZdibVcmwvi7F2bgFjJRpMsffeY7rMaroGcAyjUFIAw9VQ>
    <xmx:KM5ZaWjnBWc6wF_CVKHwMhiAZh10mJXTbcqq5Z-F5CWig_b3JLdeGQ>
    <xmx:KM5ZaR8Wez7-LJwTjCudm1mq2lv8EaZqnNFgQ2rer_sqw0DI_H5Oxg>
    <xmx:KM5ZadG75IQ6uJ1zhAHHg9Slkp9csstIX8byqMu4JvfSvGmSiZOV-w>
    <xmx:KM5ZaU7M4CceROXt3C36-6lhhy47WtinDRQZ-0yeHwn7i4j--ghEVW4l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 21:19:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Tarjan <paul@paultarjan.com>
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Paul
 Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v2] fsmonitor: fix khash memory leak in do_handle_client
In-Reply-To: <CALvWuB6MW8g3Vd1-gKkZa_r86o0-t3gGazLSvsoBO4m6jjubeQ@mail.gmail.com>
	(Paul Tarjan's message of "Thu, 1 Jan 2026 15:24:27 -1000")
References: <pull.2148.git.git.1767098576384.gitgitgadget@gmail.com>
	<pull.2148.v2.git.git.1767191943962.gitgitgadget@gmail.com>
	<xmqqbjjdc4d0.fsf@gitster.g>
	<CALvWuB6MW8g3Vd1-gKkZa_r86o0-t3gGazLSvsoBO4m6jjubeQ@mail.gmail.com>
Date: Sun, 04 Jan 2026 11:19:18 +0900
Message-ID: <xmqq344mqfvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Paul Tarjan <paul@paultarjan.com> writes:

> On Thu, Jan 1, 2026 at 1:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Paul Tarjan <github@paulisageek.com>
>> >
>> > The do_handle_client() function allocates a khash table to de-duplicate
>> > pathnames when responding to client requests. However, kh_release_str()
>> > was used instead of kh_destroy_str(). The release function only frees
>> > internal arrays (flags, keys, vals) but not the struct itself, which is
>> > allocated by kh_init_str() via xcalloc. This caused a 40-byte leak per
>> > client request.
>> >
>> > Fix by using kh_destroy_str() which properly frees both internal arrays
>> > and the struct itself. Also move the cleanup to the cleanup section and
>> > initialize shown to NULL so that kh_destroy_str() is safe to call on all
>> > exit paths.
>> >
>> > Signed-off-by: Paul Tarjan <github@paulisageek.com>
>> > ---
>>
>> This is already in v4 of the other larger fsmonitor-linux patch,
>> right?
>
> Correct. I sent it separately since it is currently a bug in existing
> code and you might want to merge it sooner.

Thanks.
