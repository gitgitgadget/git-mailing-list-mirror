Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B627A112
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163174; cv=none; b=Jk9wnuf90efQF4kdD0kEcKL4p6vZrcLzMl8RcSUtsvY+tZQX+6mmYztzwlTGl8pHFNiOBRt9x0sjK8NmFrxvkbv7FsIaEkx1l1B9atP1dLMlWekkntIHMw9jL3oZSlcqHgOtFaaEE4PhSq3lgOHBQ3MNpm5LqKXsCqk6VtcYOIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163174; c=relaxed/simple;
	bh=4ZKqU1H6+iujw2TsE9Ir7R/AyQEwJUuBlIdGOHXKYNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OYLsaPm4/MT41TNkAn4f4wcArjlPK+2y8QjE/+pVvBZtxuBCVOsV1qz22B2wMGvhRGQK6CFuIRiVbVhgTGdlJ6F/v8PM9ZpAnAmz0SFXg1OvRqdPt5vnuD3H+n+ClODVHlcbMwjtqQNUWtHnVCQm0L0DrdxRpmm7xWtDKM/r1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hkKJ6Tnh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fDYizZLN; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hkKJ6Tnh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fDYizZLN"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BED07A01C5;
	Thu, 10 Jul 2025 11:59:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 10 Jul 2025 11:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752163172;
	 x=1752249572; bh=FP+zTjaVU1BjjsTUImjDNWiCM1HWf1PJfgLgKA5yWGI=; b=
	hkKJ6TnhE58SgyYmMNbru3aZ1OLBjeb7hHiKQwk4//HiyZTYCHWZ76A3ls1pq00b
	wHRkwu3ZnoNfviV3L0z9sjuU+vraO0eyNlkvToxfbO51liLiOcXC2A3bOCH7uRiX
	jEreQ4IXXE2l94xRsGSZiBTQHr6gheVKn3qPRrZblYFr1j/eS822zKpz2ZM/CT+W
	hdkixsRsaLgv6NzCLbpMfy6Itxlf0R3QZSqxjRIGd3A0c8ek4SK+BqfoDwutq8k1
	NqZUQM5m8ZYo10FW9tRZM6mMkJ3W7BnOYIIG5pqxsBox8oVp/wlpvmHa1gQOz6IH
	txfKEBjbVEvHdDqjctPpvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752163172; x=
	1752249572; bh=FP+zTjaVU1BjjsTUImjDNWiCM1HWf1PJfgLgKA5yWGI=; b=f
	DYizZLNYO6vQ4HVdQr+NKbLFtaGu3pTao+gehIywGjyf8fx6L6dZrBcdGWJb3rIQ
	XT4ROb2X75EmhhLXLoh9+O+j+DAsPbQELJzTqWYREp2MZJoPQJ9AMdyg+ECj0h0w
	0iSDz0HF1CUa+YAx5Bf1Dqcee9c8RO6xjVmvje7MKXVdKwQTazR9xtXuhWgbScwC
	v8wFA2rZXxBsK0qf+3aBxjZDJuYeC8HWU+JdVT140pTT1A0ZeG8GvGGlzXCjhuz3
	2zKew23ftx9ilpNLGSLMk8y4StXzHicTxV1Ja81mrCVbyjY0x3SIgLIU8ZbHKWLn
	mfonRUpfwlGKZhJC5q7VQ==
X-ME-Sender: <xms:Y-NvaBLPxITn3WCqbwyoe4QW6mqVB4fYQ9R7dLfKpgKa8pfyctQJZg>
    <xme:Y-NvaHtkWEhLB17DhIgGkf6FpliftNJ_GR-0aANQwiktQSWd0e_PPbFoXnwwPCgQh
    C95o_Tv3-7YVEouFg>
X-ME-Received: <xmr:Y-NvaGRYbVwUnIRCH95svEI2WV76Omy73rSiT3_VvmdFRZR3R88mYXHlR-OpwCTxOpTExZSFmY7_IX7Ypdyn0VLLMPvfcs817N1G3Ao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptddtheffgeehudeuvdehjeevudektdefvdfhtddugedvteegjedvhfduvedt
    keevnecuffhomhgrihhnpehlrghunhgthhhprggurdhnvghtnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidr
    tghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrrhgrthhivghr
    sehfvghmthhoqdhsthdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Y-NvaFOwaXls3BwzBF6EXKXwR8WR3w0w2HziyIrMX3wE9x97-EVFuw>
    <xmx:Y-NvaDbzhHuPhGL3e6gJRmY3js8vjomaGn4leKppcpEAEQU1Rf7dtQ>
    <xmx:Y-NvaHwl0ZsSEQoOZUTo1zaD08IDUgvPZKPAUMZnIj64DsCPaPennQ>
    <xmx:Y-NvaGJEN3G0gkcI7X8HJxSn4bjRKbiKot8rlKI9tXK-4mzpXqTgrg>
    <xmx:ZONvaNGFuKELjeumw2SGwNZ5jmOZRHZR0TBuTXeZW57Elb8du0QBOYyM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 11:59:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Nicolas Ratier <nicolas.ratier@femto-st.fr>,  git@vger.kernel.org
Subject: Re: Problem with gitk
In-Reply-To: <a6c5d181-5cdb-4070-96a6-cf88c3a5c838@kdbg.org> (Johannes Sixt's
	message of "Wed, 9 Jul 2025 17:08:20 +0200")
References: <d3ab5bcc-6f71-455c-933a-a63a9b39e8b9@femto-st.fr>
	<a6c5d181-5cdb-4070-96a6-cf88c3a5c838@kdbg.org>
Date: Thu, 10 Jul 2025 08:59:29 -0700
Message-ID: <xmqq1pqo82am.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Sixt <j6t@kdbg.org> writes:

> Am 09.07.25 um 12:23 schrieb Nicolas Ratier:
>> I have this error with gitk :
>> 
>> $ gitk
>> 
>> and inside the window of gitk :
>> 
>> Erreur à l'exécution de git log :
>> 
>> wrong # args: should be
>> 
>> "safe_open_command_redirect cmd redir"
>
> You are suffering from an incorrect backport of the recent security
> fixes to a Git version before 2.43.7. Tell your maintainer to look into
> this. I can help if necessary.
>
> For example, see here:
> https://bugs.launchpad.net/ubuntu/+source/git/+bug/2116253
>
> -- Hannes

Whew.

I first misread the above report and response and was afraid that we
started from an in-between version and botched our backport down to
older maintenance tracks, but after double checking that what we
shipped (Git 2.43.7 and upwards) recently does not have this issue,
I realized that there are distro packagers that backport even further
into the past, where some mistakes happened.

Thanks for a quick response.



