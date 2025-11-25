Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29CD2441B8
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081163; cv=none; b=FrqqYHdXoJd9HBqxiPkpxYcwO1gBoD9ivYXh6yVFZ8MVRFhBUAzBSaXGSjLINSVW+sdCcYD6SyKE9OEW1tOnHHF7aSCoyAuE6/R4RFXckOKXV/HSq036R0f2eXZW0RHEZ8tZs3UnqcdznDDpESoHn5rZCzp4YXWsybvhU/0h7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081163; c=relaxed/simple;
	bh=WlKGgbIr+AlDVIKakVT5ljqF2nCERb24DMLbzgi888U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZIADPLwYJbBGEPwZ6G3/e1Ls3SdkvV+9UgbmxixffkFYTKHUjqegpbaWF19mHzojdDwgOkI4Af3IUe/5tv6AiOoN+HJ3moJjvxXa6nroPYO90qSbLdUCVB52AvEl2c4qSXiriSa7HScvLGRXIi9duTPseyCoPZEQDiEPY4df/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nZjbJnA4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LUvwhOBq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nZjbJnA4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LUvwhOBq"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D7F761D0002F;
	Tue, 25 Nov 2025 09:32:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 25 Nov 2025 09:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764081159;
	 x=1764167559; bh=AMSA+IS0koAJDjLemPC3lNVSzr6UGqyeEhLnGkhBsb8=; b=
	nZjbJnA4IUFz67SMi7PuOTxgC/rmy6BNg5wncRZnFpBucryu2TD9XJpDtMg3ZaAn
	s7Jj2u+FnPn2lgncR6vsKTpisR96c2Mou7buGPsBQgaQypkHH8tccuco1Zx6Hlo3
	CTSIUjyr5QTJLf1deexIewEYUnU2L7HKhGCbD6JRgR/zm7N1ZeYVgNxpnZ1rUg1T
	mTqGZCsMf7j4d/xDvmRjgbeR/wCVRXpQljTmmg9Itd3Jy6G+byHGdu0CO3t7NvOD
	5mgohP27FrxhmH0tdX+PYViILuvzoJYv/oh9p69/9Se84jQ9wnqewfzy7ud8XNu6
	LIiOU1GumdsRVQIpccH/KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764081159; x=
	1764167559; bh=AMSA+IS0koAJDjLemPC3lNVSzr6UGqyeEhLnGkhBsb8=; b=L
	UvwhOBqf6O+y6WZeaJpIEfOkOxx99Z2jhMzdUZbUgxrV606t+DXsktqz+a734ctG
	vs4G/8n7DoQLepBujqxhzmx82Yqp+njG/pLzWLLG3NFsbX6/lW2Up2xGpX/qx6Es
	RghzDJS+hM5mfEG45M/h94J4YloU69tTfBQfE4Us9TTVXqN4fJu9N3HzeEgSkgO2
	r5A/kR2wcEj7C8XQmEkirgwN7G8LbW6Ro06cCU+NrYZVM5alfvCgcVngDo7l7YuA
	sYr1pzcSjY1JkFLoPobcT8BQsB9qKOtdV4/ZqcEwBW76g/8zFDcB1uskicx+jcu+
	ThXfWmxnYom+BelvPsZww==
X-ME-Sender: <xms:B74laSW7ccFxJAoFzVhTiGD9JTAf41NXojqU9XNQ3OyOQV8uX7NguA>
    <xme:B74laVfT2EJtWmttZMkmutedCbNDLugN70K1zNgnF7va1_6wQUCJX2c2YDtVBj6uJ
    11LhXiFCCOKgXxMK2tjLuGMjcT97jM_I0ESREPHWPbftvRDyHSi6g>
X-ME-Received: <xmr:B74laeu4eC1EWqZXkWKvn6S1lATha1QMunmtlisCwc_g866-cFHtwlYD028CVuSW54x_i-VaoP7z9yYjnnl3Um61t-34piAnwQ0S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:B74laU8Iz5pudO1SajNzyOrpDIZLFK_4MKxZMS9P_inbrC8yl-w7lw>
    <xmx:B74laZ1Ah0u5RrnnHHqtcTkPievuxIfKUPMPzn_7-HdGhgd9HWvzbg>
    <xmx:B74laZDqW2dPZjPN-SamIgy4Kzt5Ypl4SWnNIKyJNtRq-37j9ToGaw>
    <xmx:B74laVeH2QksWBx3oyQWCYoyAyxlo2_golKJ-e1nV7gRPixZVLJILw>
    <xmx:B74laTUtpp_twPSIS2KS4lPO8e7OXV-CIC-qLN165_NVf1VrJTzKaAqK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 09:32:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(dockerized): do show the result of failing tests again
In-Reply-To: <CABPp-BErdhTjbqDem4Xvc-XbhgLUEpy9-eiaaR1F_diMca--6A@mail.gmail.com>
	(Elijah Newren's message of "Mon, 24 Nov 2025 22:15:07 -0800")
References: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>
	<CABPp-BErdhTjbqDem4Xvc-XbhgLUEpy9-eiaaR1F_diMca--6A@mail.gmail.com>
Date: Tue, 25 Nov 2025 06:32:37 -0800
Message-ID: <xmqqjyzetc6y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Mon, Nov 17, 2025 at 9:17 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> The quality of tests/test suites does not show as much when there are no
>> breakages as in the amount of time required after bugs trigger test
>> failures before the bugs can be identified, analyzed and resolved.
>
> I found this paragraph hard to parse.  After re-reading a couple
> times, does the following convey the same meaning?:
>
> The quality of tests and test suites is most apparent not when
> everything passes, but in how quickly bugs can be identified,
> analyzed, and resolved after test failures occur.

FWIW, I had the same "I cannot quite figure out how this paragraph
really wants to help readers by saying this" reaction to the
paragraph.  Your rewrite finally helped me understand the intention
(if that is what the originall wanted to say, that is).

Thanks.

