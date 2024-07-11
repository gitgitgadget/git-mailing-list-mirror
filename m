Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7491642B
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712074; cv=none; b=j1tgbaD3DA4llwegEWvky7um0nc1PdWHLapUVl4ukAY8upiHG9yHKWcmBwqeZOhIvoNXcJrru8/y8wvPnYOYCjPcc1Fz0TDRwoJcQ6FWOlahoOl46WpkXGaXiRr9E7geticOmAqlbuQ97hnOphl9MaKFFdO3sdc2GSl7ZX9R7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712074; c=relaxed/simple;
	bh=OE7lE1vrj0eXEtPt4e4Xpoc3mZuc6sqGajLfYMu8sik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WxB7v2y/YQXTuC8mqXArbCIeeqoaWKWH1oSbaiCPtEySc2r/H87hFvzszXpUhg+RIstxJvVvogOqmSGzEzwNSRjY+7kR62MFf58X9bF4efrlMbXZLHZIKl34U6JCAX3IUz6Vz0HKrZMqQQ0wjvhG9fnaX/EdGu7bx6MpKVcvORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=r3L/Jtgx; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r3L/Jtgx"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BB6E33D7F1;
	Thu, 11 Jul 2024 11:34:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OE7lE1vrj0eXEtPt4e4Xpoc3mZuc6sqGajLfYM
	u8sik=; b=r3L/JtgxazKo0OI4PuzBUw4kh+YIS1HofJalYZ8aNBms6NcVXFUhai
	z2XMbF+PBigJLZQpQtV00Qd/8DQSn5vka3vloASnJIXHYm4Zxy55w6SpPm25La8d
	y5FponTkEN+l+CM8I4ZLmuwIUMvYu3KC0rYvOB6IPCu/9Zqo8M/4U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B33443D7F0;
	Thu, 11 Jul 2024 11:34:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 23BC13D7EF;
	Thu, 11 Jul 2024 11:34:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  phillip.wood@dunelm.org.uk,  Git List
 <git@vger.kernel.org>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
In-Reply-To: <xmqq8qyblwpn.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	08 Jul 2024 08:39:16 -0700")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
	<51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
	<97390954-49bc-48c4-bab1-95be10717aca@web.de>
	<8802b3ab-9986-47bd-be80-51ac599b2892@gmail.com>
	<6c83357a-825f-49d9-8cc2-e81415e8010d@web.de>
	<62d221cc-532a-4a6d-8e96-b5a246ddeb1b@web.de>
	<69ec31f8-2cac-48c3-a513-0f7f21607c88@gmail.com>
	<xmqq8qyblwpn.fsf@gitster.g>
Date: Thu, 11 Jul 2024 08:34:23 -0700
Message-ID: <xmqqa5iot01s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0D8D786C-3F9B-11EF-83B3-965B910A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> I'd automatically assumed we'd want an uppercase name to signal that
>> it was a pre-processor macro but I've not really spent any time
>> thinking about it.
>>
>>> 	#define test(...) if (TEST_RUN(__VA_ARGS__))
>>> 	        test ("passing test")
>>> 	                check(1);
> ...
> Isn't this introducing a new control structure to the language?
>
> A macro that is a conditional switch (aka "if"-like statement),
> having "if" in the name somewhere, and a macro that wrapts a loop
> around a block (aka "for/while" like statement), having "for" in the
> name somewhere, might be less confusing for the uninitiated.

So, perhaps test_if_XXXXXX() but it is not quite clear to me when
TEST_RUN() wants to return true, so I cannot come up with an
appropriate value to fill the XXXXXX part.  If this is about
honoring GIT_SKIP_TESTS or something similar, then I may suggest
test_if_enabled(), but that does not seem like it.  So...

