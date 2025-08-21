Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C542C11E7
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793370; cv=none; b=EbrJe4l78Gv3g0p6yoMwxsM7fOispBVdZFgpj9Sr93WL3mJak6EL0pvvoK+Cy3QL+NNUQ5nMcXmGPO9KV7au6mNaKgOo/322pSaGO6E56Zfstgv0IoQrWBQHy+9UAu8H+PeB+zX/H/HrnRZD4wZHDzOsMyONXTJ0Ta/OQG4jKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793370; c=relaxed/simple;
	bh=MYE/A63nHlbx6lkiK0kodWmxqVGPQlPwLazn4DnFWRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mehuPK135X7KPnIYzYfNCWsPaNg2jQhE9ThEEiZHJguFy0TURDRRTygcfkDstRXqgsMFN5oMqHkvXyTgltyKf5ZB2jIpOrQ3/iUGZDw1keaC7yLd6oJgO6aQdlBPUbcKBFqJE9YaQQ8Cj+xEvB7/2kPglrxJ7NRrm9X6bbX3rRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OXUGVQh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OHbgZKvO; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OXUGVQh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OHbgZKvO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8346F7A0197;
	Thu, 21 Aug 2025 12:22:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 12:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755793367; x=1755879767; bh=4eaoJggXwY
	nClAOTygCoxeRzldexJYyNq+kwoN9rnZU=; b=OXUGVQh4a39vNXmZEjOmsj3MT0
	wDIkmz+K4v14HbXrf9813/VdN1YchmkLXUjJwDBQ2rbMpkjOj5Q0sET4DW2+QXCN
	zNqAlfcmOTeKgcAfdvSAY0F92TQmAI8hVz/y1RjLVmw9hFmMZ9QpAGkOEI6ERDHt
	6WAr+iO4O6a6J40yA9xIzTlNjCie7TrYwey4Ds6PSs2lVJkDft9Optnmx9h+ONLy
	x3cvMnWii9wzNyQOR9zCF8elKS2HwsW/di4yl105DFLfX7kjsKlcBqsRKNujNlhh
	X1766tcqoJ2DWBg4WAqeqkz2SAGcyiT+7whpQT/b0mPYkO/uZZAe/OxeLaKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755793367; x=1755879767; bh=4eaoJggXwYnClAOTygCoxeRzldexJYyNq+k
	woN9rnZU=; b=OHbgZKvOkIdeSKwkb9FHWDcSYzEq7mheijO8vBUyhG1m5xIOSS9
	ItjNIDKTAKF6bZVNSlK0XoOReb/EMAHdZNNfVkiZzSy12j+Ux7QsBexCnRChl9YM
	Wv/Tch8CQ2MmMIvkyoWvsgRJkOOAkZfn4ubmGs3765GZCkwHhSpjGLxoM2eCo9jC
	wMXkPbLJWYYtrzpxCTkvoq2ncu8MpmftyPoRQDz+/tIhJ9ce+2jempHoCBoVmb30
	m3vVrCZy5nEWKdLzGGq7FV0Lo++MEjLhCGE+QUhNVOWPc2K5jL7NYKs5+z62ZrV/
	j7A94QlFy34dyfm1bmV6YdUI72d8dl+QTrQ==
X-ME-Sender: <xms:10enaAEHcqvNVe3HnPsYNFXCH37sK-hzrtEmzhXvBl4GUyQNOojNqw>
    <xme:10enaAkvO4wp5t7ntThyfnQlt2ILeft-VQ3fbvaeDcBqIkBA1d_UNBWsoi29BNg9Y
    iUgWDdAyETYD4wB6w>
X-ME-Received: <xmr:10enaFBkQTzTXadOS6nei5AWE4pexfAYa1cEOK5PvQpMgCZkENE2jd93wiagz3teB3S26QFxQ4BM_At9eEbFAhcXaoYGNLusKPPAZFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhho
    nhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:10enaCAeImHJOF12aXNuQ-Axyg88aPtaisYIghGfk6M1FsIsBsoNQA>
    <xmx:10enaMHSNSYf9r8Z9RxBIlOSIKf5VgdxLXzck7zvO6RTlL_iedAXRw>
    <xmx:10enaJ61qyo2Fp0ClgYh0plGiJvX4hKUCCUaYDoGHa7xu1KF4mBeqQ>
    <xmx:10enaDTI0CJxNcIbnCR3C1hYr6A172hOqNHUeMd_ghFbrbVQELSnzQ>
    <xmx:10enaMrd1cxXooxR5Ja2xKZxEooyH6GrH2Vj8Ea-o5bQeCKt5cTf8O6k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 12:22:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  johannes.schindelin@gmx.de,
  johncai86@gmail.com,  jonathantanmy@google.com,  karthik.188@gmail.com,
  kristofferhaugsbakk@fastmail.com,  me@ttaylorr.com,  newren@gmail.com,
  peff@peff.net
Subject: Re: [PATCH 1/3] t7700: add failing --path-walk test
In-Reply-To: <d9f69281-6aa3-4ef7-b52f-9660bc60a46d@gmail.com> (Derrick
	Stolee's message of "Thu, 21 Aug 2025 08:42:58 -0400")
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
	<5b19173c03da676b3e1effda7ba6d2ef5666cad6.1755715196.git.gitgitgadget@gmail.com>
	<aKbSObIzXwUtjAdE@pks.im>
	<d9f69281-6aa3-4ef7-b52f-9660bc60a46d@gmail.com>
Date: Thu, 21 Aug 2025 09:22:45 -0700
Message-ID: <xmqqfrdk3aqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 8/21/2025 4:00 AM, Patrick Steinhardt wrote:
>> On Wed, Aug 20, 2025 at 06:39:54PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
>>> index 611755cc139b..1998d9bf291c 100755
>>> --- a/t/t7700-repack.sh
>>> +++ b/t/t7700-repack.sh
>>> @@ -838,4 +838,47 @@ test_expect_success '-n overrides repack.updateServerInfo=true' '
>> 
>> Tiny nit: I would've probably squashed this patch into the second patch,
>> as we usually don't use the add-failing-test-and-then-fix-it-later
>> dance. On the other hand though it gives some nice context, so I
>> ultimately don't mind it all that much. So please feel free to ignore
>> this nit.
>
> I'm probably the person who is always asking folks to create a test
> that either fails or demonstrates the "before" behavior before making
> the actual change that updates the case. This allows the ability to
> "test the test" by checking it in place to confirm that it is indeed
> failing.
> Using test_expect_failure allows us to avoid breaking bisect. 

Yes, you can develop that way, but on the reviewing and receiving
end, the second patch that shows only the change from expect_failure
to expect_success pushes the more important "what behaviour was this
thing testing?" out of the hunk context, if you split them into two.

If we really wanted to verify the claim that without the fix this
was broken and we have a test to demonstrate a failure on the
receiving end, we can "checkout" paths touched by that commit
outside t/ from HEAD^ to build to see how the system behaved without
the code change just fine, so such a split does not buy us much.

Unless there is a strong reason not to, please always present such
test in the same patch as the code change to fix that breakage.

Thanks.
