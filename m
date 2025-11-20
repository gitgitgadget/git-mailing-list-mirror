Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87713AD26
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678458; cv=none; b=X8jM5gRRaosc054RQoo43BTCuozqSgdaeZrW6DlwMbRQiKlWFxxK8/BX9gn/9XDdNbbv0g9V/V0i+XxIU6ciDO/U8P7yUEYpeCkAw8FNpSMHMkMe4jJfJQ0neciTsu1cjV2hDmicUytwrd0If/9W3tsCjYIB3vUcNkY8tl3cUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678458; c=relaxed/simple;
	bh=y63Ym7vyqgg0BjTQT3PpqEO3GOAagtTUt6vlZg0qrPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hdhX+W3aRy+XCE+PKdxWeQQs7gVNP2mF4R6mP195fZsAAYqNizZofkthx5DpTOWqoROO0UpaAZLGBx9lUWio85szVfMfnSlFC7ndSXJ8jGMFnp4p8mOADEoqpKYHneYE4nm5AxmwEUHYHekq0o+r7/ULTOMvB1HLYMrtVwKI8/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UdtHNkVb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WPu/0Q+r; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UdtHNkVb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WPu/0Q+r"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49FB0140035D;
	Thu, 20 Nov 2025 17:40:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 20 Nov 2025 17:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763678455; x=1763764855; bh=BxmVzNfgiN
	vu4lX8s5LX6gJ54LD9f/cbWSSZLUw9voU=; b=UdtHNkVbNAdPeLjc/l36KZTlRD
	3xnOKfNa3xorh8LoUUx/alzFfFTlguvF4L6dTJdp4AWwAZ9umPnXd7ANNVgj3Xup
	dJvZR6IW0IwXbx8WTGerWAN6dJJrWUZDASSKv7dYL3wxHTCd+XB7lEYxSo4T0bSh
	LIlLN7yC5h94+eWKAcBpsvnECPa/UNXSWaLTwxWnGW7v8byfvIYAhf7G9usafFb3
	RORxc/O1rHDDvoPtilwUuepLlqN4D8lqndarvLIq/75a84WePss9kYMvjUX93qzM
	bCUfaY+8x1PSIw3h/sicPJ+zY+Da5WnLB9xkTEQ1ff4JD4ImGPM/+ho1JNOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763678455; x=1763764855; bh=BxmVzNfgiNvu4lX8s5LX6gJ54LD9f/cbWSS
	ZLUw9voU=; b=WPu/0Q+ruiu6MKADmmEmARxBhJ9tSuecozHUgWJyMrcsaraF59H
	NfrphhwQT698iIcVmo2x9Ta62Kx8k8s5a3OM9q8eD7kuWSknz8/xyC2W6GxA8Mx0
	B6Kry+VO37YAptZZ9Qb7d1LBJcgBRFoLvNKl4ZvndUrvrMJp2HujiLH4xRWUq+4l
	dr9YGB/ZHiAjDah2wyuz7CuyVO4hmxRSmIJky1+6danoCvJlJnNe7JVA8ynzMxgt
	6E34dJ21BtvzHvPeydvjSFJzYlyVhOGCUtBE2MZeGb/dOH5ZyeCOdDxRO+QNpG5l
	YGFR3f+Th++uZr1asfAiXXc5ya0W2k+VwSw==
X-ME-Sender: <xms:9pgfae4ruuBgeSHaSt2h4S2pDwt5pSzqjBAuakLAAUnCyTS15PU-hA>
    <xme:9pgfaexuUfG6NazGpDFHH5anLnF7n4b-9KwyqYF6iU3GhH48ZuXMTbqNUvkqjRj0A
    DbXb9rRHQz9stjaRxSKMzX8w_8Gm5ZDV1u9Qj7sgoiDEkFyv5blHKM>
X-ME-Received: <xmr:9pgfaVzV9nWgFawYvmDG9m8z1IfMJTjYWulVPnDCV5oPH4xl_1mvsNBvTkoLxpoNvCdCgqpQAAmkQRUQxtkwXrZRYOikExeAAi48>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9pgfaWyqOvxGOCQsF-5d2Dig77u3UM8H1C0_Nga3vlo_McgZYmLQOg>
    <xmx:9pgfafZUvRJvsN5F3c_aZJKkp3ZDIbcLJlVr-R6hBpOyUf5MC7U32w>
    <xmx:9pgfaXWKtr9EpcfTxRAAbdYkqBXpLiH_-MmMIfuTBx4dPlovaqn1hQ>
    <xmx:9pgfadhZMxFrYR9MypGtfLehimowaIXUn3Pw_88SdHDTDPhKIyF7dg>
    <xmx:95gfafTkLoM4mgqF1q6fxPXIGsHY_YYOHxGDqwSa4cq1LcN-9CXGdrjl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 17:40:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Han Jiang
 <jhcarl0814@gmail.com>
Subject: Re: [PATCH] config: really pretend missing :(optional) value is not
 there
In-Reply-To: <CALnO6CC0HU60F47yoE45ei7_K2_MeLRS7fihMPn+f8top7Jr7w@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 20 Nov 2025 17:15:46 -0500")
References: <xmqqms4g7b1h.fsf@gitster.g>
	<CALnO6CC0HU60F47yoE45ei7_K2_MeLRS7fihMPn+f8top7Jr7w@mail.gmail.com>
Date: Thu, 20 Nov 2025 14:40:53 -0800
Message-ID: <xmqqy0o05nuy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>>  config.c                   |  1 +
>>  t/t1311-config-optional.sh | 36 ++++++++++++++++++++++++++++++
>>  3 files changed, 73 insertions(+), 9 deletions(-)
>
> This needs a tweak to Meson, probably in t/meson.build, for the new
> test script. Otherwise Meson-based packages (like Gentoo) won't build.

Yup.

diff --git a/t/meson.build b/t/meson.build
index bbeba1a8d5..137c0caea0 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -182,6 +182,7 @@ integration_tests = [
   't1308-config-set.sh',
   't1309-early-config.sh',
   't1310-config-default.sh',
+  't1311-config-optional.sh',
   't1350-config-hooks-path.sh',
   't1400-update-ref.sh',
   't1401-symbolic-ref.sh',
