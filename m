Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E622F0C46
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098859; cv=none; b=jRvARxIt4v8v/8W9HIw67+nF79U24oAijeRgBZPpwzdNcU6N8LkSdvtHHqv+XqanwYnw15M0cLeBcTnFttrgTaS99LtqvHulN/8eS4mrSPOOmocBSr93+xlThvAjauOF00zOfedVotc1gVCvXFX9STRiHg4fbW6qoNe7V2+wQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098859; c=relaxed/simple;
	bh=cmg4vjvaf0PVIG6i1FQ+6ZGy4LZGyXbl/vIIA9Oc+XA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m6ot0QAXguRYLASrUR8UaxcGNIoyct6J3Uvs+CkQ4SN/dzGp3OcFiZ/qz0WNOHDjHUs3nfp1igFi/dP442Pwsjq5W0StRQ9H1XF5cbOFMuPus2NvRspWvYEAXN5ng9n9i3w0j/3Z0VCqJAKje+8FU8rKxKT5HtEwYfwXpBYyVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U/p/12w6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rR1nWK0M; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U/p/12w6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rR1nWK0M"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 474641400138;
	Tue, 25 Nov 2025 14:27:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 25 Nov 2025 14:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764098856;
	 x=1764185256; bh=pfFkoo7nQkI1puK3nH3lQcxKW2H/raHcD1kiLkWHB+c=; b=
	U/p/12w6IkN2VK3tdlT8mvN92dRmG0L8+8LHMfVDZJWIeK5/U7tZdL1kXMWgaFYJ
	/LKfllLpnF02VbyZOiVl5BDqviPNhW+GHJFy2cjGg2IYTou/cE5E7XBVUbbGzcVp
	VSDO8SGwUns3pH40hzk4zes6U8ae17juKX/Jp4H/4/QHRBnbgH2z9jpDjBRV5/cx
	qqXn+PULjS9TmT/cPC8SXNazqcehmo2MZcX1QZQOd0mbi3ap2quc9KFD8fGWYv6t
	3ofSW3y9V1MBd3cyxhgAeZKPlGsncutdRjoCsNhdquugpwGGSiFzPtWAziqKyPni
	RkQg/kLPPxr50meXujrICw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764098856; x=
	1764185256; bh=pfFkoo7nQkI1puK3nH3lQcxKW2H/raHcD1kiLkWHB+c=; b=r
	R1nWK0MfoVaiuP2MdyYv5i7fzr+bjAOOakrLr4lqDShkxGWYxeu8Far/lDNaKaj/
	rtyYbxi8OEQlIh2+0bSSkdC6K0Qa/Tbh0wxc9bwkyyN2axwb1GsUHcW++xhBuUbH
	nBFiS/piYOpztmFYYlcguOXMYSsAdPJkroRnHyVQpw9cTFxg5vXvztZonmS+XpIZ
	RFHIcsRmPqIoahBobPg1Xxl1pKpjowwGNESlW39cYZBiji9ODGErA+KLv/uc509s
	Ryqb9i6dKvAI0nFeynWsw5rHbOFOYxFOo4RkDelXZznsi25iKL0QNVhbqpzZaqvS
	bKduhtdsnn2MfgoPyUVpQ==
X-ME-Sender: <xms:JwMmaROMpKQ8in3xHe5iFxfQ9X26UGAA5kAIQlr9iB_3GtduS8INGw>
    <xme:JwMmaa2cmabXb1YrUR_x990-ngBsigbquyTtqsHGcey58gDscFpNqfHQ5ISDn9jJH
    Tb1adD5xpniPREPWOx-fbjIqRshZtg47v85nYtHWMQW8LzF-6criQ>
X-ME-Received: <xmr:JwMmaYm2uQpoPSibznRZM0-Mdw22cMi9t9aNzUifgaXaZvsw39ZE8SvSaFae6lpEKa4Ojx5e_eVUvKGKglDEZam11bHyQTtt1Gqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:JwMmaZX4_gTc4NtDsiyyu_4i3or8-XTTedH8ZkeVI38Nvo3M4bE8eQ>
    <xmx:KAMmaWtyV8imVmibvkFJRKOwc-giedq3EgKCrf9Sc1nN6fS_1ZFNnQ>
    <xmx:KAMmaUYzqCbasuUb7u9IYQ4LDouo8MoaJWiN5BhwjwI6dt3LcGrIhA>
    <xmx:KAMmadUAcOIKN7_oH-NcPmNJdsnfFdaBrOrJEeHzYBPxgNXWsUXqew>
    <xmx:KAMmaWJFkrGFFnY4Q9h0Jzk4C59-6NaOdyIBlo7VZCzlJK-slLp_quKe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 14:27:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Elijah Newren <newren@gmail.com>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] ci(dockerized): do show the result of failing tests again
In-Reply-To: <d8054499-aacc-f697-c117-116729432c3a@gmx.de> (Johannes
	Schindelin's message of "Tue, 25 Nov 2025 18:40:39 +0100 (CET)")
References: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>
	<CABPp-BErdhTjbqDem4Xvc-XbhgLUEpy9-eiaaR1F_diMca--6A@mail.gmail.com>
	<d8054499-aacc-f697-c117-116729432c3a@gmx.de>
Date: Tue, 25 Nov 2025 11:27:34 -0800
Message-ID: <xmqqsee1rjyx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Elijah,
>
> On Mon, 24 Nov 2025, Elijah Newren wrote:
>
>> On Mon, Nov 17, 2025 at 9:17 AM Johannes Schindelin via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>> >
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > The quality of tests/test suites does not show as much when there are no
>> > breakages as in the amount of time required after bugs trigger test
>> > failures before the bugs can be identified, analyzed and resolved.
>> 
>> I found this paragraph hard to parse.  After re-reading a couple
>> times, does the following convey the same meaning?:
>> 
>> The quality of tests and test suites is most apparent not when
>> everything passes, but in how quickly bugs can be identified,
>> analyzed, and resolved after test failures occur.
>
> Yes, this reflects what I tried to say.

So, do you mind if I locally amended the log message, or should we
expect an updated patch sent to the list?  For a small thing like
this, either is fine by me.

Thanks.

