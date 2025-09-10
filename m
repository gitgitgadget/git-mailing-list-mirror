Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77494322A
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467950; cv=none; b=N59QxsDxyPsTMFis8Pxrfy8qRpgMmoUkQPxOeAm2P02/3lxkFYHq6Ut6LbpZyKMJYz6675Uda5OVHSHc9JpMGJw1UzrstxgEmBZvesFPtRGNPY94VR2JdJ38QgaA44ABGOFZ3a7GYMgvztmsGE9P3/VvkkJ4+/QtMBmc+/DxlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467950; c=relaxed/simple;
	bh=KzDEMTJ2TVx0rR1j9ZLehHf/oQ5aQuyDknD/49tiygI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iMwokIzYcBndEDSTTudaet+p8LP6Q9uoq8YKqRceJxHyT3M2Uim8/BiUwWc6n8NZhbd2R7Da6t1UjwHPTe9j90mH0VOrX1JAf0A2HMdBFEL1JCHS8CdqL4TxQM2Vo7q/V8AeGwqdBjSKjbFXyt2EtLBhzdto8XmUO1UhcoQemiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iompSpMo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gqlf2EMQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iompSpMo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gqlf2EMQ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E534A1D00213;
	Tue,  9 Sep 2025 21:32:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 21:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757467946;
	 x=1757554346; bh=1RsxZdrE/+Xvyl3vhitqxuB4lsi9OjW433xTrSO+66M=; b=
	iompSpMoJgkxpaEgHstQ39OYrZ8JXnYBauuyLqdmgds6088Ybj6hmJvKBN6PwIVB
	qfd1y1PUqBwtuKrnXHM316YKXHKmTp3m8OgWkb+po0TaoumzxGt9BdufWjfFF9/F
	kJvsc5eXqihNqwxt55gZGdv0uF7Rjk/vcKLta7gtPw7ud+BshCWytZ06ZcwiG7lG
	Q42DIpL3HHuCznuF2Q4V+R3cj3fwGKbUNs9UQLaOHlFYhQNZan6nsW05+6tntm+m
	0vqx9GIOg+b8PJWhnnGvyIKMQFMFgGKsm7P1oUUeCskz5qISp0r7tQk+qjJDj2GP
	8L+vDHwSiamxbEaZKjOKxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757467946; x=
	1757554346; bh=1RsxZdrE/+Xvyl3vhitqxuB4lsi9OjW433xTrSO+66M=; b=G
	qlf2EMQmFpotAKqVjsdW8TTgzQz3FMVLP4ytzYeUE66NoQAslzkiLW+vrx8mVJXD
	xdLAZXRrMP+hovsuj7Kih8fOVx3e/RBIH7cYuOvKlrwpaSSiRLNCY9Y9+qFECkB7
	WXNuetM6LuM5WyMM0f0Ja5XlDE7Wij2HSmF0BlWkaCxm4djtzjYN7nmsaHMXXmVv
	1wDzF1ZI2wVGtQB7AxUB5krzFxLyL6lEx8Xl39sNNUyCRdL6NlPRBI/SYmiu6hd5
	fIOkPBrTc84/1bbw1uU61+AYRQalynJ26F1WeFRkeVnrmseZJMgw5gm+rHubUjXE
	nfkqJjYGnpQjbMvKyGP9w==
X-ME-Sender: <xms:KtXAaPGSql2QiEf4AJe-bPz1qzhbyNpthSaumzW8XQic39Q_Pl5JRA>
    <xme:KtXAaG4kuwP3QIVoazO9X87EugIzWec_ZO0b66OdNUaSy9gzWdXqsQsnIApNNMKVI
    BIySMHUJp3N8Shpyw>
X-ME-Received: <xmr:KtXAaNtk8Yuz1B5Bfd538hCL8Rmfl6GZPaWjEtMrvuT_iizFd_8JcXvFu1-MJT4M7I4t6r8zHJ83Pf-JSObJu2UbJWOiyMpPT0nfv0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:KtXAaP7oiQecsdNxZ6qEpp2GTqiTPMBYTCErQ6Ld_Tg2EG2TCxYW1w>
    <xmx:KtXAaAW2ynmwx4rfRT1AFTGn-7-igo-RldmOVP6LCB5rtabUUe0PYA>
    <xmx:KtXAaJ8RX6UHI1-QrWAum8ZBJN12IfpV5jvfiYF9PuCr50ASVJAudg>
    <xmx:KtXAaElBEA8vam_uzVWuaP8-fsKWdSWQzIhr1YZbmBfjkZfVbc7UHw>
    <xmx:KtXAaGUSYpDeRXXayJZnZzn5Iqn-K08qsOV9VOjVD5H47NMyz2inZibQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 21:32:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] string-list: allow passing NULL for `get_entry_index`
In-Reply-To: <4D8F4C73-5447-4588-AA8A-7DC0646892B6@gmail.com> (Ben Knoble's
	message of "Tue, 9 Sep 2025 20:09:52 -0400")
References: <xmqq5xdsyjoz.fsf@gitster.g>
	<4D8F4C73-5447-4588-AA8A-7DC0646892B6@gmail.com>
Date: Tue, 09 Sep 2025 18:32:24 -0700
Message-ID: <xmqqfrcvt7mf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 8 sept. 2025 à 12:48, Junio C Hamano <gitster@pobox.com> a écrit :
>> 
>> ﻿shejialuo <shejialuo@gmail.com> writes:
>> 
>>> Callers of `get_entry_index()` are required to pass a non-NULL
>>> `exact_match` parameter to receive information about whether an exact
>>> match is found. However, in some cases, callers only need the index
>>> position.
>>> 
>>> Let's allow callers to pass NULL for the `exact_match` parameter
>>> when they don't need this information, reducing unnecessary variable
>>> declarations in calling code.
>>> 
>>> Signed-off-by: shejialuo <shejialuo@gmail.com>
>>> ---
>>> string-list.c | 6 ++++--
>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> I do not quite see the point of adding these conditional assignments
>> to clutter the control flow.  What benefit do these callers gain by
>> not having to have a throw-away int variable on the stack and
>> passing its address to the call chain?
>
> Wouldn’t the point be that (at the cost of slightly more interesting library code) callers don’t need to introduce extra ceremony for results they don’t use? In other words, take the boilerplate and push it down rather than up?

Yeah, but the point is in what situation does a caller *not* need to
be able to tell between "we found an existing one and this is its
index" vs "there is no such thing, but here is where it *would* fit
if it were placed in the array"?  I do not think of any, so I
doubted if it makes much sense to complicate the interface to make
it optional.

