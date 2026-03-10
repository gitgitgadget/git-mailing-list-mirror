Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405A13B6349
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163641; cv=none; b=tWIuW428Rm0WWdKbh1JoEzCGjuIOnXfdhbYh+uCIz1j84eue/EzEQyZP1ZqhQobZrtqlizshxev7zkA93bLjyb5ym1RqRdgRsLr7VsW01cKSkNOisX3uujMydxpiEYILOzbP4s1iXxUm2rJnWsqRcIo1f5XaxefCabo8VB4DpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163641; c=relaxed/simple;
	bh=LZJ6roA5uW8KHN+80HeLEPccBi2D0+r7sH6zE5Nn2Mk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ml03ShXBLQDUdTNRJ18BffH5Olsaoms8iNxZXtBLHBR5Cv8JaQynBv0DatlHjgTVMncc41UVK+97TZhwhVWEpEgAHIMtUFWDo2WbDY9GUHnWHIA6GViRz9SnKnoDEqnkmu5dog9rVjZ4EuSDKLbN2yYwCFc/kEtC4T/Pg9LxYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=goqkWJdS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CeK1q+7n; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="goqkWJdS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CeK1q+7n"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 70ACEEC0FC3;
	Tue, 10 Mar 2026 13:27:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 10 Mar 2026 13:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773163639; x=1773250039; bh=RBTxwUHT5G
	/z68KTu6XzpwLlzH6gjq9YIJFN2jva0ac=; b=goqkWJdSfX9quyDliBxuBETuuu
	8fna2p4TCd+TSvygyhqSz8P1jK5S43Z1WeflLD1+j7OCVvRV+gzHnW31TsE+ODw6
	4/wRlsJCcAcezsfCFN6cqJpprrHJdrcei2bEoZq4h6T+wIAxG9sshPszgiUtutaQ
	hncb+6ZO9M/SZIW7NarL3PrVVMxM6L8KoItNvvXe7i797h50sFOjnP591h8bGRpq
	UFju1sVQKsTCh2D0ymYz65GcsKpCJKR4lwPLO5uwzXLR1pk61SGGHBKLv/4GY5H6
	9IIbz6Ejx6Yu9bCdiGaH8ebg8x6QdSV0MmRZp6NZL/XbYm2gv0dt4yrhDtrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773163639; x=1773250039; bh=RBTxwUHT5G/z68KTu6XzpwLlzH6gjq9YIJF
	N2jva0ac=; b=CeK1q+7n8oR16zv4GDuKobHmZcS6FKsxaJCIo6palO1J7s80PLq
	/F2Y15s2XWZDBSmb2rsiiQXPCelfdXCjohnY/HaXQ2AZmowM8SUfRsWy6wAkXSJ4
	q+xjj+AbQQEE9GfBFLBnwJHwE3Nt6PdMxg/vp8vS/1bZCLAFNR8Vij7NdiL+kIEx
	6ZahWNY3YhzvTj9wT8svENe5+IEbPMZh7HiJ6EcSBET0JdWK7J2S+IG2WmBbsUtm
	GfY59Fa6N4QvdmKMimAOz12n5ioXCmrw/R0peP3Z8zppdHuG9f6vuGRCLowcSf+E
	fgyytNrYPCx7cWeDnBr036LZMc13IA+K8JQ==
X-ME-Sender: <xms:d1Swaf6flk3D5vtPlLhq6H48owpKCmxYmJEff9eeeYJW2vMTVP7ceg>
    <xme:d1SwacVK2tCmGZUEXV8yxOy3If-f8v5UJAiL2nCXLt-uUysNoTCYj3Z22T2ULO0nm
    A5VOzaDklkbJynIFWsLU4dkYPnCH69CcQxhtdrNrGHaHb4YivGAr8M>
X-ME-Received: <xmr:d1SwaT3cOATd4GC2630oNc8y3gXj5GCZ0qjsoPEYp3Czbk1YtFd3fjc1j8TWKNNWXZBPzDTI5poG4d3pG8HYh7B2OBctp9N4LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfedtheeuhfeludetveeluefgleeugeeltdfgvdevjeffteeikeejuedvvddu
    gfdvnecuffhomhgrihhnpehgihhthhhusgdrihhopdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehmohhhrghmvggurgihmhgrnhifohhrkhhsphgrtggvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:d1SwaZ0XG7lcZwGupP97P6LfseeHd9CBtePSEzW5LryXvhBV_h-x5w>
    <xmx:d1SwaW-X3XxZHc-z_HQyE140B4NRso7Uwlh4uID5nMIQZ4U_9sd1cA>
    <xmx:d1SwaW21TCc79UWDpY4__zjfzKQ5lRAEpkXxsqE5c8OjBZRGsMMl3g>
    <xmx:d1SwaT83-NqVCdTswa4PI4gnEA9Z0sUfSbxs_qHDkHv441mP6Y4pQg>
    <xmx:d1SwaUU94u4vHswB6t_Jj81bEmE_ZFVaPEv_2s4WafxXoIhi7fnrf4Cw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 13:27:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: MOHAMED AYMAN <mohamedaymanworkspace@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Question about microprojects for GSoC
In-Reply-To: <CABWZVhraW4zD132R0iv1uhBwS=uuQZduksCCYN_+4+OcBKBodQ@mail.gmail.com>
	(MOHAMED AYMAN's message of "Tue, 10 Mar 2026 08:11:05 +0200")
References: <CABWZVhraW4zD132R0iv1uhBwS=uuQZduksCCYN_+4+OcBKBodQ@mail.gmail.com>
Date: Tue, 10 Mar 2026 10:27:17 -0700
Message-ID: <xmqqtsunvbm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

MOHAMED AYMAN <mohamedaymanworkspace@gmail.com> writes:

> Hello,
>
> My name is Mohamed Ayman and I am an engineering student specializing
> in embedded systems. I am interested in applying to Google Summer of
> Code with the Git project.
>
> I am currently setting up my development environment and reviewing the
> recommended microprojects to become familiar with the Git workflow and
> contribution process.
>
> If anyone has advice on a good starting microproject or areas where new
> contributors could help, I would greatly appreciate the guidance.
>
> Best regards,
> Mohamed Ayman

Where did you hear about the need for GSoC applicant to finish one
microproject as a requirement for application?  That place should
have links to microprojects ideas.

https://git.github.io/General-Microproject-Information/ is one of
the canonical starting point.

No microprojects done by new contributors "could help" us, as a
microproject by definition is a trivial "Hello world" project that
is to help new contributors dip their toes in the water, getting
introduced to the development process.  Look at the list archive
https://lore.kernel.org/git and see what other aspiring GSoC
applicants are already working on.

Have fun.
