Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABF1C68F
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754260238; cv=none; b=F6/rqKusi86bWF7dc9G/lIU9Zv6yyZ8GI6+RO6A1pvx6Xy7RTgXN7mrRu5rWPignt5hKTVn+2xQ6b0pcSYytqI8lFAu4G3ZBZ1m7Ai32SbJDwpydvjQe6D/6vb1TJ7YgYhV3OVtLDPzoWHQ2YI6a0utfskle8Hr4itGRbCQhS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754260238; c=relaxed/simple;
	bh=/VGlE+GtQRReuKWl62O4x2mv0bZb3JujncafVycQjMM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fGhdzjByXGaYaS/KdruUhJxS4qHSbET0I94LQsiXhQ04ILPGelRsrnG1WxcQBieqFMi8Va1fjXllxKvIOJWsgWTYstFBxTXfHSICZHbVsAFmRlYn4wQYq0WhFN3f6p/LxWVTZhvbFCJFHy0olitHz/SNWB2bOiNVjk8L6+4aGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aJSojW04; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K0vWNZZa; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aJSojW04";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K0vWNZZa"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 49E2AEC00B5;
	Sun,  3 Aug 2025 18:30:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 03 Aug 2025 18:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754260235;
	 x=1754346635; bh=J9kokC+RmodwH/e8zhEJfwmGZuNFoq2kpRv0c7eR/HE=; b=
	aJSojW04HdkuC/0HmWMYJLGOJV9cazOCmCKaJ2ADZPhKxVoAWVmWUW0qail8TCe8
	l9ePKOGC48loYVIll4UukqXcLUWyHZtjE+rtBtLj5NW0Fy5xOllcM0oNLcx7bIvA
	34VgyFcbTvMuTincUSPMcGjqn4kmrfRWvlUcGoFjLsBBhtrOiw4pO+eRebQ9axWF
	kJItr+Qo2Gs49ncff2iQhdUY0E4BS4eE/klnkEnWIlGHQXCbrEijPg6r2zlj6B2L
	DxzYnoI7wUzfbHr7qR7/lgcuwY/qef3tiX7rsiUummLZ9jrikQUQlYneiZEvX45P
	2vdZeq8g6hjaFB5pgFND5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754260235; x=
	1754346635; bh=J9kokC+RmodwH/e8zhEJfwmGZuNFoq2kpRv0c7eR/HE=; b=K
	0vWNZZaDgFksc9dxWz/PyMxL0xMbOovQjdFgKn3AqgfAlUFHwAVkq654uZfMXLon
	2pfv4HHGcfAx7COmefgnv+Qk18qrmyhSNPyKpl79vXVwH+GRx2ye7Naz1fxrr1x7
	ouknrpJIRYSltaOY5j2KwtU6AXDh//ceTl1tXG9SLFcVXJRq2P2qgdg8GUY974+T
	Mfj8Wg/NMJy1IhqF7v3Qh/C82DjoWW1FX6sXEv971XCVSQuNxmWQ4NbKLIS8jQC2
	CB6pBO5RZpTj2dvoV0FSJe6OeG8ChIcxJ/WNMGnUAQtZOTPuBKSFzuX6nVsI3Prr
	zQjCrzn3/nGv8VrhUmXmg==
X-ME-Sender: <xms:CuOPaPyotpDSW0--x6GRd6fJ9zUq4nonZxQKkEM_C04ftO3RaaDc9g>
    <xme:CuOPaC-Ujn2WiRfazHcgWXk9SX0dp9Gw1O9Yuo4qFZbkHUEVQCXldPwWMxqZeBhVR
    1jka_1INPNtZxK0FQ>
X-ME-Received: <xmr:CuOPaFxToBwCEBpnG9REHjqg4TAlg7sdjMS3EKHKOaY3PnazPjQaYHk1NiII_uLK6tCENFmmp_MPuOvh9yORWR9Jq1yJ3zvkj4xFd1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunh
    hshhhinhgvtghordgtohhmpdhrtghpthhtohepughsihhmihgtsehmrghnjhgrrhhordho
    rhhgpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:CuOPaCr-FTg1dYsMXSvvnyw0GE2LFpPj3BexhdpHvNHPoHTq_NBD3g>
    <xmx:CuOPaGprcTc9bOSxGfWQUlAbWsuoaecQJSP4Vo-a-1KY_K7CxLMnlQ>
    <xmx:CuOPaCBhRAc_AqlCl6ybCjnzmPpjKiCxyexcqwQbxUml3JU8W7oLWw>
    <xmx:CuOPaEsrUpN6u_I93I0I16tgWiTxCwvJH-dPLfoPpJt3q2EDCtk4vA>
    <xmx:C-OPaPtWW9cTyjartAzf7krUoM2jzuTOy3U-gNcQswdmYGNODlbWR_Nz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 18:30:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Taylor Blau <me@ttaylorr.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Dragan Simic <dsimic@manjaro.org>,
  rsbecker@nexbridge.com
Subject: Re: [PATCH v5 08/14] builtin/config: introduce "get" subcommand
In-Reply-To: <aI+oQvQgnNtC6DVw@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Sun,
	3 Aug 2025 20:19:46 +0200")
References: <cover.1709724089.git.ps@pks.im> <cover.1714982328.git.ps@pks.im>
	<29676b81e0151e2982326663f8b64e2a70bec0f8.1714982328.git.ps@pks.im>
	<aI+oQvQgnNtC6DVw@szeder.dev>
Date: Sun, 03 Aug 2025 15:30:32 -0700
Message-ID: <xmqqjz3kdomv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>>  #!/bin/sh
>> -WS=$(git config --get-color color.diff.whitespace "blue reverse")
>> -RESET=$(git config --get-color "" "reset")
>> +WS=$(git config get --type=color --default="blue reverse" color.diff.whitespace)
>> +RESET=$(git config get --type=color --default="reset" "")
>>  echo "${WS}your whitespace color or blue reverse${RESET}"
>
> In this example the second command in the postimage doesn't work:
>
>   $ RESET=$(git config get --type=color --default="reset" "")
>   error: key does not contain a section: 
>
> Consequently, the last command doesn't work as expected anymore,
> because the color is not reset at the end of the output.
>
> Luckily, the commands in the preimage still work.

Instead of an empty string as a configuration variable, using
something like no.such.variable that does not exist would also be
a workaround.  I.e.,

  RESET=$(git config get --type=color --default=reset no.such.variable)

What is bad about this is that there is no generic variable that is
guaranteed to be unset.

