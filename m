Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3492A200112
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147838; cv=none; b=nok6USq7DdsYjiaL5CfOYDq8C0PGfuEFnoSWrVwf9qt82DCiVFhVTQlp401vDz+2eHWO+FFILPOS5eX5VJM0sQTOx0fuZSZGDCto9ZO2HEXCOaMQRIG/zPqN9HYH5/sqBDU0SOE3tb0VdM/2tFbHKCFmpHc1FjrEVvR9uhfoxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147838; c=relaxed/simple;
	bh=b2OoLT4Zz5g8FilhtFkvBeb3yAtG9DrLfLIWgZIeQLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZ3DLx4+U2rfCuTcbhaxRJsTQ5N4AvV3IUT8DukRqKFKQrtYFNcGRG/+uHPsKokzww/BqObBYw7GkytBpQSpd/86/UXeXZMoBDSEibdD01FuPEUYrI6AKElJkA/5stxNZt5bu31v1OBCK9KTrOHRduJiBrPZdLkmhFQsWaogmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=enc+DYEL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CcAX0KT8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="enc+DYEL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CcAX0KT8"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E16FEC0390;
	Mon, 25 Aug 2025 14:50:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 25 Aug 2025 14:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756147834;
	 x=1756234234; bh=XAsz9KHwtHvYfV2Oqt6xwHkZm3yZNYIf2emvTtoVaIE=; b=
	enc+DYEL6WlhjRr/8csY7nhsYePGPVb0pxBGBtNcixP3/lcLY/sb5NJ/Syx9irsU
	CCPH9328oTXnvRTRB1IF2KaVHWB3vI4uUg2BksUoDg51B7CnyKd63/Nc+aqXp4eK
	9zo/wmlzxO2gYQ2xTLgduDRRx76cFucFPtQvb4rz7UQj6bLcdk7lZhjOfYJBzRMv
	uNyg2C3b+SjnqNrt6I1C7ugT0Bp2QbevX3w+m73Va7qjmb0oElbv4eXtzMt8+rHq
	d2W108k4qgNpKtcuLnVGAuQeTNlpHTtPYNyvk83EMJwHnRfho+2uuqkvsmccb8/S
	ZNCZQIIA2LeCb581aBsZ3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756147834; x=
	1756234234; bh=XAsz9KHwtHvYfV2Oqt6xwHkZm3yZNYIf2emvTtoVaIE=; b=C
	cAX0KT8eIXDLdK/+UVaez+Ul4dlA4S2UNinqJWH2M798D+6kuZAlrwjQ5HeRe4Lu
	p+j5daIptMxacqU7V/cPC8+/2+rQ1h4/cQl53FcZ+m3FUHne++eYcevAMlls/1ee
	1fmlKIpt6HQKKUW5RXy1mLgUiPb+ejZUCLSLQsqGKip+hBE9AXQkmONRz1T9E7ay
	fZLQFTlsehkluxH3X0blHgRAkgxQ+OkJ70Uh8En/4aHnsoeYMxL/IqEv0dSetWRV
	tt14pb4u5icOHZkZrV91aAV9l8DI836X8//DAFyc+8p3jPC5lHXLJVhUtYwuw7mG
	vo2LRAUpzumgapOajrCcA==
X-ME-Sender: <xms:ebCsaOxkXiO71xfodpCBFRj-pzYDXcIKFCfJ9CvXficgU79icqm7ZQ>
    <xme:ebCsaCtbMNg9G7alaWYdY7VKQ8LIZAjd9nbyG9WbtNZ4Md8aVWyD9Y14rWUZ3Cs7G
    cnfPHbuJJqwtMpHnA>
X-ME-Received: <xmr:ebCsaAzjELhWq9-i55z7lrN1uT7Xl-RxL-2W_SbHKF7sowdpE6wFIUlK_0N_ntmLIRrTp0kxnHzlQ9OZ5dD5j07afPoHClBEjbNUJKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepnhhitghosehflhhugihn
    ihgtrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ebCsaFBDs6iO9PIFcuE4YBYW0_bXQOymYc6v2FVD0X4io64QBWs3Ng>
    <xmx:ebCsaOenvd_AqniVsuM6WFVGcGnIb7Ohww76CvswHzvsQ5Yoqx98jw>
    <xmx:ebCsaPl9ltF4fAQb6PWGYXZHpKwTL8zAHXB_C7S3j4sDzh1xV2uL4g>
    <xmx:ebCsaFFdm4BQsPnwX1JAakQHnW0_yOcbAG4rGhbrdgc_dvlPGVFVmA>
    <xmx:erCsaM6PJfCHbjweqPibw7W_3kbVaqUaxA5wpXmi--dCTtST0G0c8PPN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 14:50:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  Nicolas Pitre <nico@fluxnic.net>,  Carlo
 Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] progress: pay attention to (customized) delay time
In-Reply-To: <jq5ul4zwdex6peuub3upwzxz3d5zcnuh7adseyg6wa6dpiu4ci@fuwe2t2vbguo>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 25 Aug
 2025 11:11:21
	-0700")
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
	<86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>
	<xmqq4itxvi3z.fsf@gitster.g>
	<08f405a6-fd2e-40d7-850a-574356b4009e@kdbg.org>
	<2d56de10-f829-4bc8-9c76-76eab6b137ae@kdbg.org>
	<xmqq349fs5ee.fsf@gitster.g>
	<jq5ul4zwdex6peuub3upwzxz3d5zcnuh7adseyg6wa6dpiu4ci@fuwe2t2vbguo>
Date: Mon, 25 Aug 2025 11:50:32 -0700
Message-ID: <xmqq8qj7qlqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> On Mon, Aug 25, 2025 at 10:00:25AM -0800, Junio C Hamano wrote:
>> 
>> >  	struct strbuf *counters_sb = &progress->counters_sb;
>> >  	int show_update = 0;
>> > +	sig_atomic_t update = progress_update;
>> 
>> It is somewhat misleading to use sig_atomic_t for "update", which is
>> never updated via the signal handler.  It confused me a bit during
>> my initial reading.  If it were
>> 
>> 	int update = !!progress_update;
>> 
>> it would have made it more obvious what is going on, at least to me.
>
> In that case, I would suggest doing instead:
>
>   bool update = !!progress_update;

Any conventional type we would use for "is it set or not?" that is
not sig_atomic_t is good enough in this context.

The fact that we started adopting "bool" in new code is orthogonal
and a bit off the point.
