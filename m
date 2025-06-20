Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645728AAFB
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431808; cv=none; b=TklI29mQ4WiiRKRSu70Qnng5t9pVQPxVA9kLowQhyIODu1Kvx+V3+AGSTngvNeUV/ESIzun36brSaAmCXoXX/t6jK1VuvAwR0IAGr3JYw6ChGtzDuauBf1m5Dq26qh570ICQWilZLpx3rr6Ak9+5A16OYKZVFHKVNeaGn2osv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431808; c=relaxed/simple;
	bh=+6XTjutLxBnvGD8PyIsLWGZONQFooVuaH4LetkYILZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AinsEa7KsXT160/wHVzvXjUryVV+Zbg9z5FwbSHxbi2tUse5RZ49GCKnFl2/SoHmjJJXphha1d/te0lFevU8JBR0jeFiIAkBHrVJjRI/tNJuOX5hgNA5qDRvyFqG4akPwjGWBFQPXbaN895bu/zprTo/aS7YRTDgLa6A9CyYjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SrM2fFvq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmoB+6A6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SrM2fFvq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmoB+6A6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DDE3138048F;
	Fri, 20 Jun 2025 11:03:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 20 Jun 2025 11:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750431805; x=1750518205; bh=qLSyFwFTkG
	8XiNNr9SvDiUD6PsaL8eXxrJa621yGV74=; b=SrM2fFvqKFRLJ4em77xyLo2tOl
	bUGfbVWsdtVSGsDh6G/Sy4JaJVDGOUQi7LZeUaxCAR59FJ0NkH4+0BtJjPY0JRvf
	+rLAT8CRL4upM8BQnRQux8av8KmNFAabOI5ye/WcdH83EsJH/Bdjc2Ax5aatAnCX
	RRCJkRcT0hkBQ7hWnmlW3jQxgdM1tHMlIs35Szz4H6tQUunZWWs4FuBaVi/bwOqk
	/lpkfNcQsUTwtLX2inrRg/a9a+4JLLM07DQ83dy8xadCUqFfirlgBpN9L24e5tPH
	CAxRiMYbz4pF6GhHdHyqzGnEzwDdULlQ0d+J+CGZmkI3ZqhgEI3/+p5VDZUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750431805; x=1750518205; bh=qLSyFwFTkG8XiNNr9SvDiUD6PsaL8eXxrJa
	621yGV74=; b=HmoB+6A6wmAHZ6Lfa0gDYZcYhu/KNvyhvcLg+1dJknqnF/tUHMQ
	dJ/o2g4Wsh4N0N7wtMj/FEdUU3N1ZL+YszFOwDuTuJnctfvDNIlmf+yCRP5bEP6+
	WG7NHhYYI/Pt2EKHCahPkZzPTWoWiX7AxIdzeBDfU9VeQgJlW0L8o6uKmx5YSD29
	X4uvj8QUgoLLvV8diXU8vh7DVnQ3p46CAntQ2iZdiwPt3MvFNjuwrZHMOqDvBYjE
	3VahcDUXu2E4BaQ795cMUrPWEpdCUfJ3ElRMZ2iPBSoYJ3Js3/xdK9UbIfQstPh3
	uZmNoKK+7cjVnKRsYpIaKkZL5VNGUHW7RBg==
X-ME-Sender: <xms:PXhVaE8g83g_-IyGFXsbkC6cndmqgbJhZ52c2OA8gR9WdQdP1unv9Q>
    <xme:PXhVaMvXVYHPxdlcmZe7EhsiRYtIOP-KsSiMS3i4jYR0wvjuFKGyhvwxeKBk6ytsi
    cu_8RRVn8y0J0fpbw>
X-ME-Received: <xmr:PXhVaKCb8SElaGwZqI6QvUluOIggvKHLBv-Oz7aTmRkiv_YLpUdis6rqyh_FuxK3WXef_HsnLsXSt6bykMBZ_vQV0BB7gDU72GMX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:PXhVaEdvFAIfVI00cUiNeWSlxbR0WoE676oyyZ_LNGOaQwo96zQoCQ>
    <xmx:PXhVaJPvZKJESNjVKc2RFQcUexAzB9-CxsSOEnNoludKDrITCIzQoQ>
    <xmx:PXhVaOmvoqoY4_US0P7cdHXl__frUPoGR-c2F6OGkwEArEM5uxZUOg>
    <xmx:PXhVaLvNuXwQ26qcRWhYLBVl5ZXTR9uxADQOJl-rfP2QqZf92ooHbg>
    <xmx:PXhVaBacy-JrHNeYBotQSofLEuIf1TK8QIOFw_yfOmEFuRvwJbxoPtTC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 11:03:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 10/10] Enable SHA-256 by default in breaking changes mode
In-Reply-To: <20250620011943.586596-11-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 20 Jun 2025 01:19:42 +0000")
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
	<20250620011943.586596-11-sandals@crustytoothpaste.net>
Date: Fri, 20 Jun 2025 08:03:23 -0700
Message-ID: <xmqqfrfu5ubo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our document on breaking changes indicates that we intend to default to
> SHA-256 in Git 3.0.  Since most people choose the default option, this
> is an important security upgrade to our defaults.
>
> To allow people to test this case, when WITH_BREAKING_CHANGES is set in
> the configuration, build Git with SHA-256 as the default hash.  Update
> the testsuite to reflect this configuration so that the tests pass.

Another thing that I suspect nobody wrote tests for, but we must be
absolutely certain, is that the post-3.0 Git can still interoperate
well with historical SHA-1 repositories (I am not talking about
"fetch from SHA-1 into SHA-256", but "the binary does not lose
ability to work in SHA-1 repositories or fetch/push between SHA-1
repositories, only because the default is set to SHA-256"), even in
old repositories people have been using for ages without the
core.repositoryformatversion defined.

Thanks.
