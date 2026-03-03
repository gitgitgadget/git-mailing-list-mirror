Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E637C933
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568142; cv=none; b=NLEfclp4O1D5x4RzHhhrNaL+oKRwgl0IfhgN6W1RosBLUBw3oYBV1WuWPVCjKFug0u3zwxxBVMkn/OC2smpkLgFI9d1NfPhjMTh4fpxsDkt7rLzh9vz0XsPEZjd4vh15dkWokPRL+ZgwNitu1DY9unDJYMX/uMjySiTbyXyESDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568142; c=relaxed/simple;
	bh=6P5JFp0a9W1RZXnlgjlO6YOI7D+TLXTuMoAg+VQxnAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c2HcF8pEeGrmDFymdYW3JI5tkBI7pwNDIFY7Mjy46Vkl/n1MTXX6h/AI/1a7tSZVXL4yUADSRlMcgZJwMzb+jhJgrOAbVA9HiJSzk25xJ3dAMJSm25SS0oIk/beZXJuy9viW15yHUeG93vrtiJPR3oaXGqJq3paPNBAQhgN/lzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UA/04ia0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RN/1Tqda; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UA/04ia0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RN/1Tqda"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE44B1400151;
	Tue,  3 Mar 2026 15:02:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 03 Mar 2026 15:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772568139;
	 x=1772654539; bh=6P5JFp0a9W1RZXnlgjlO6YOI7D+TLXTuMoAg+VQxnAA=; b=
	UA/04ia0LHoeUX8tIGAJXvvE4c5P6F0TIrVzRFHPcpjX+IapFiDZQIG01WtWkIyv
	hLsEhIYGASi0bZpIa439YDrpLBSsSbtOnGHPCpYaXkjnEPsNeFcdXAEYpGekQ3F5
	vS9yivZUyqkB8EVqXSj8D0uHVXe8bJ8BC+7m0G5ES6AkGqtsG6t7Xr3wzC2fKuR3
	fDcGPNmmzYgSxN6jI3uEwaPMAnVRuMgHQW0TxlMeaQc9uCMIPRuDlmLIVMbewVG5
	Hgg4YpJyUgBqRcqWy45Sq/AfA1LDKNo74B5P2xxlK9i/4GXdTwp4FuLdeUJPRLXc
	QUvZoulWCytwIzNfEOblmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772568139; x=
	1772654539; bh=6P5JFp0a9W1RZXnlgjlO6YOI7D+TLXTuMoAg+VQxnAA=; b=R
	N/1TqdaGxuVYuBlAdb2Uj1cquj2Dtk6p4sXKjXtpsQ0Ch3GPSx2dWt0vzlQU1NXT
	EsTbKaUPQSAClPfAYGhcNIcvitPQZiB+JojJwwXdoKU/qwaTi7qPR/JMC9z3pANz
	704aRz57jmiZo31NuJ2J4lheoTTvPYpDFH26Uq16SAzgpMaBwMpjWxOzEPtqhBXg
	uzV7gnUjdhJZsT3QqISA5EkD+7P7pqSYN28Tp6lIqn7ummawez8QzfzeVWBl8v/z
	Fc7zzHj9dsgtbl5fs25TNwhfiaT+Tz/zVdkQJgqGbz/sKm1azAuIGPSs0prmw3jE
	46ajJiTaMDm4UCy905A9Q==
X-ME-Sender: <xms:Sz6naZx9OZyI7dbNU56QBQz-GOXrbs2ro4-utMDVsHD_mv5LRrwMNw>
    <xme:Sz6naSkTEiOeqs8zGPaP_9q61vABVnw01OigkPjVcIP2BdSww7zQUuEbfuHjfWwFS
    q8SE0Xdg4JZDqK1MF6-TZzODkradlQAotE8bWr0qU1BTDZQSfiBsg>
X-ME-Received: <xmr:Sz6naanNKsoC-H66Hw9gzju5C_JOW0rVz9RmRJcRo-arLHvVk4pAPtwC0FFy_oHiS-Qf18zB6ag6soMlH4ecFD6wf22fb2afzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnrghsshgvrhdrghhrrghinhgrfihisehoshhsrd
    hquhgrlhgtohhmmhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Sz6nacyF-z0ofVgYuR9nxu4LxoL0G3K2wOzb4BhB1ihpt_w47fDMZw>
    <xmx:Sz6naXq2ZaxUko7lxAos2PzMDBCImt--vHJ2P8zWnI2yF5NIIQmxhA>
    <xmx:Sz6naT5ShsxVDeWn1FfJtvPCKNJhdeydoNpFwlOHx94Y1naHCF4pTw>
    <xmx:Sz6naWeUgENj15lcJhA_UQYiKHzokezFQDMWVV8-cqIipAeZrRwYLw>
    <xmx:Sz6nae1ocU_OByS9k10TDQUIK7yxtGbtXqoHUNE6u_IVAZh1yBQ6j8nP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 15:02:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4] submodule: fetch missing objects from default remote
In-Reply-To: <CAFcKa=-EH7YD0bjeUyC6EVijTStuFZYOzQHbAnoXRUtY694Khw@mail.gmail.com>
	(Nasser Grainawi's message of "Tue, 3 Mar 2026 12:26:39 -0700")
References: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
	<20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
	<xmqqfr6hfyqq.fsf@gitster.g>
	<CAFcKa=-ei+93P_Rp+2eKWW+43aSyg_hxHb9K6X5KmXEcS1VGvg@mail.gmail.com>
	<CAFcKa=-EH7YD0bjeUyC6EVijTStuFZYOzQHbAnoXRUtY694Khw@mail.gmail.com>
Date: Tue, 03 Mar 2026 12:02:17 -0800
Message-ID: <xmqq5x7cd6ly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:

> On Tue, Mar 3, 2026 at 12:00 PM Nasser Grainawi
> <nasser.grainawi@oss.qualcomm.com> wrote:
>>
>> Also, I just noticed I have $pwd in a couple places and need that to be
>> $(pwd), so I will send both those fixes.
>
> Sorry, ignore this. L11 in this script has `pwd=$(pwd)`, so the $pwd
> usage was intentional and not problematic.

Oh, then it would make it easier to fix, actually, since $pwd is
some fixed directory established long before the control flow went
into the subshell so the fix for test_when_finished that are used to
remove things under $pwd/ (not $(pwd)/) would just be the matter of
moving them out of the subshell, setting the finished handlers up
before we go into the subshells.

