Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5134F49D
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635835; cv=none; b=FTkc1TCuKURv0WlTCBbHlIPURJOShxNVm8fJZ34VVXWfzcZL3Hb8nvf7rWP4GtZ0VMuzjxvqJcGPlYs3xSIyXFOclT6De5r4111wPBRm0DhEd6VZrsMBsHOQWcyU+OWLZbz5bWbSQEp+umRk0rvUzNwWI/8+rFA3vt+vB1xxmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635835; c=relaxed/simple;
	bh=FqPGC07JKwQXKSY4yzT0FdTE29QLkJhmBRSD+EBToxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ap68acGFE2sIxn+EVgUhrVgWTQ0tqsvYq8JJijaegg2pfTlMz0gqnTLNhluMITF282DQDgZeQJemp7scYExej90kYoIGqhVNoKquRGUhFvDe5wx6d9q67OKOGD0gtFAg/ieZRswOgkairxevyXcOOcFBuyWPtCJtvaD0JUDzz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ePm1BKny; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H02+7RgN; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ePm1BKny";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H02+7RgN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B6D57A00E2;
	Thu, 16 Oct 2025 13:30:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 16 Oct 2025 13:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760635832; x=1760722232; bh=6bOt0spuPU
	YuVHcmSMPcrnAYtkP1GhbFMpj4Cao6ff0=; b=ePm1BKnyOAKemGDVmV6Z8ljXT/
	ZmzydlHygXNmyx/8y8AWD9OV1FOfZsPbBgjZEdNrJYQs0E8XPOYE7xZcMwbcx5YH
	FIhVSqTt5Ni5gyJZEFu/bXx9K7CUcEQIlZAiiA2lxu1yXgU3juB0EClpZ9Ig2KbE
	8punUVd+MeL0SCD+yKTR9fV+bFRoBRIMY6R+CpwRJD9Qu/EAeodMpUUbmHmD2QiE
	SEQ0UJKOQok6Ct1WqhSG8MISIIOsbDlLIvwQ6+EKBHBegBZ53s+hzwaMPx4f12Zr
	+z/XaY/257+az3JqBXBCJra4t5IvG6UbXgXIm3nScrQoFvYTQLOZqJIJfjWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760635832; x=1760722232; bh=6bOt0spuPUYuVHcmSMPcrnAYtkP1GhbFMpj
	4Cao6ff0=; b=H02+7RgNCSi5mfdFcoBT1z9v+uDidCWqIGbetswCyHsSl5/ZJdx
	xCrR9ODKd6U/5mvdQMZ73FInXuU/ys/DKFFXw5Hi++3jy32GPDVhLPpZkSlvHhng
	I2DcC2NqtIRn15KXTatMGflZvjIJxqmgbKzHDJY3D98pJXRfwy0ojQ8OFZ+2Smbr
	E6u1XIHgbS54QgCj51iLK5L8ENm8+iq+CkMgu4wydrj8mnn/sXPOJ87/SBG11wr2
	Ud9h9qpLMgYPpN9akNjjGZIOEi68WYiqwnISoBMrCYJsdBKLVaP9OL5u8P9bfet+
	FTq7s+ax92pbQMxrLoRJG+9WylJNlUtAFzA==
X-ME-Sender: <xms:uCvxaOoHZ0UtJxExjexUil3iCdOy5TFd9H_SnSEZS_x9CLpZU1_x1w>
    <xme:uCvxaDpb4biWQB2UB1oXuggXh-vnnMo_hpbAOiycA0sU7VuiPUl3PPfEdS4KI1s4A
    -Z7yY9LIq0H8_v4EkqKaCdbP2UQlqw0NLq1ScGlp5KDOtGcKufBFw>
X-ME-Received: <xmr:uCvxaIMBTAPzulqJAUELU7wEN6ojKjiA7uZ44Pn_Oy5VBvd7WqcUgj09bHLiHUfe1c_Vi2c9-0Hoj6bn_OSuYf1gZr6TUzWy14Z9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeikeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhjvghsshgrieeivdesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uCvxaMxknIjTqTbZfySp_UbcRkhHuL-FQGGmTfvbnWEcHVuZYU47UA>
    <xmx:uCvxaJtody6KmWjAzSIWibnsU2oBBf5h7Jvekmtc9nAhAy0T5LfU5w>
    <xmx:uCvxaN4ZTThNWqqvRNhzEJlzEx3wKSQYt6KW6zaeeDkQ_Itl4uGyLQ>
    <xmx:uCvxaASLpCKlW-zi6lylwgH4LR9ZSR6Gjq76N97l3h-0PopvccQ7dQ>
    <xmx:uCvxaHsJDNt4UiYYAVWHlTw9AaWhMQAd2OR9XIYB_sw3mccK0IF-xy3->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 13:30:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Queen Ediri Jessa via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Queen Ediri Jessa <qjessa662@gmail.com>
Subject: Re: [PATCH] docs: fix minor grammar issue in MyFirstContribution.adoc
In-Reply-To: <pull.1988.git.1760600313093.gitgitgadget@gmail.com> (Queen Ediri
	Jessa via GitGitGadget's message of "Thu, 16 Oct 2025 07:38:33 +0000")
References: <pull.1988.git.1760600313093.gitgitgadget@gmail.com>
Date: Thu, 16 Oct 2025 10:30:30 -0700
Message-ID: <xmqqikge4uvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Queen Ediri Jessa via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: QueenJcloud <qjessa662@gmail.com>
>
> This commit corrects a small grammatical error in the MyFirstContribution
> document to improve clarity and readability for new contributors.
>
> Signed-off-by: QueenJcloud <qjessa662@gmail.com>
> ---
>     doc: fix minor grammar issue in MyFirstContribution.adoc
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1988%2FQueenJcloud%2Fdoc-typo-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1988/QueenJcloud/doc-typo-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1988
>
>  Documentation/MyFirstContribution.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 02ba8ba5f6..91c6296ffe 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -26,7 +26,7 @@ useful additional context:
>  [[getting-help]]
>  === Getting Help
>  
> -If you get stuck, you can seek help in the following places.
> +If you get stuck, you can ask for help on the mailing list or Git community channels listed below.

Please avoid overly long lines.


>  ==== git@vger.kernel.org
>  
>
> base-commit: b660e2dcb98ed4eafe2781b7ba31b70d2fcbad80
