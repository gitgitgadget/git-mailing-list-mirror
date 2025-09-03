Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1C368095
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924992; cv=none; b=j5DpC1TwMEWvjIbbu9Yyc264s+eYsXgMBWi4s3pMjCO/9EQ2gIyJ2tjdpfCnLdXpIzqUIFvZUaUG3qvS8fUmXqtSggZhOSudfQItABK6RTVmJwC53xNWVQXS61yW+f6be4m3p/Yocpi8FTBUiv92DNN3SeJC2T5RBkhP4F+1vCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924992; c=relaxed/simple;
	bh=4HJAa3tS8W3kIpz1IJg6cQ7gejfkwKy2/pGqU/ECFE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CbwSpfKaEw1YN97eCnHweSAH4hTuXP4OK0fDgM7vy93pzwBfENHjhpLVLRiGeTkGIUFLwPhBYIPMIQoCf8adNPFTreiR8swswRlQ4DFpC5e4UVPuHuPju1En/eFXQBKBihXK/I7BieaGQpdK2TbPryA/SMinkU6lDgKY22hBciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VB8j196P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VNr4w4xK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VB8j196P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VNr4w4xK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 258A6EC0331;
	Wed,  3 Sep 2025 14:43:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 14:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756924990; x=1757011390; bh=CKhlxwPRMC
	bG6ycCzJlbJ+FtZ6HHi3s2dobBYlI//Ok=; b=VB8j196P+6gJ1SopYZakk9I8eA
	nZrH59ovRx3VU3V2u58OjU9YVEvtvrTqamsLIm3NMZxy5rZpGWIAqUz+50U0wbIW
	GfUvwOmPFyRfDKmzdVOi5arOrvPQsat09EAUXJZfsOYcLjhtIsrKny4LMZtetNKW
	iRPnZAzGrz5Dd/bbSDQRYEkYo4fpYTV7YMKpaufP2duU66O4baUPie76US3II2XC
	u3J3RfND5FxeAp8ihY/Hj/2al5OeJmvTO2JZi/ty14tOmy7RlTQPkqfBK5oSDlMz
	aNbhHuM5ae2YdDvoSqoplh7m4C72BTVwIiU9v/Zy6qqM7eafGQpKYgPj6hPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756924990; x=1757011390; bh=CKhlxwPRMCbG6ycCzJlbJ+FtZ6HHi3s2dob
	BYlI//Ok=; b=VNr4w4xK3QVaZU89yqu5aqgRdMy14zVJYF5i1OwZalNpZ6SJLQs
	EwycIlAPULiuLKxwxPdycL1A7XjQaZz7dXwDfWTfFy89FQmKOLJk0DM7T0cG573W
	aZUjbAkXTJha2b5gp3jRpItF5fsSwzccJw3Xt9NW6F5SMSd0WXFPqEC76BjMXWkt
	AX+td0+j8t6EAM5xy37sSoYaZLrxU63y/LCELtEikcJ5w7ifsz8dKJi37mnwhrLr
	2C/4v9jFEqxF3PNvB/Nw+8kpwBTVt8DUUdmhqXpL4NtlRD5Lohxk3gwT/UEEbYJB
	LrCpjXlHk8gmgxYRaXDkhkj4MEnnkz5Olsw==
X-ME-Sender: <xms:PYy4aBzQt4-ok9s4RDYNMUI0s5awQ6UTk64xOFMGLV9FklDaY79CpQ>
    <xme:PYy4aJse0MCVC8CGQDdyyLQwAXEHfEVt4muxNXsrHBTnTivLSOlctGPTcVF6TJAXB
    hXLvNJqSNsDgR8tZg>
X-ME-Received: <xmr:PYy4aLy57ZjE7lTDqFvGIVehkp0pl6g4NnR33BjybvSdkFyxwdjeihRgdwDid9uh5Y1k-oCXIcb0pTeeFnoZ5QyBqxvWK1kXDs8q68s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PYy4aEDM3FmrC62GKx1oQ15WZjrWBlC1_2e6-ou1zZGzNgGIJJBEyA>
    <xmx:PYy4aBeWtPw-zFMyXUefoRcIxo1BX2qX5ATVPUUWzn4sik7gLRR_dw>
    <xmx:PYy4aGkI-TRIUXS8plcdpjVKsOdsLt1dkv45cHhIJ6jjOrQCSsURNw>
    <xmx:PYy4aAHvMBn65JCLLmb1K4dfq88aGnx-On15B1DPdcjvai20dfGvoQ>
    <xmx:Poy4aOUdQag5qodFslFmsi12sL05mtqYxJ7W1qB-4Tn87flqVyS_TlfM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 14:43:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  me@ttaylorr.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/6] midx-write: simplify error cases
In-Reply-To: <aLgVRMxNUrdScrjk@pks.im> (Patrick Steinhardt's message of "Wed,
	3 Sep 2025 12:15:32 +0200")
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
	<7be25cf5349c389cf2887ab5b852779fc364bd7e.1756589007.git.gitgitgadget@gmail.com>
	<aLgVRMxNUrdScrjk@pks.im>
Date: Wed, 03 Sep 2025 11:43:08 -0700
Message-ID: <xmqq8qivfkcj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> -	int result = 0;
>> +	int result = -1;
>>  	const char **keep_hashes = NULL;
>>  	struct chunkfile *cf;
>
> I personally prefer to keep the result uninitialized and then assign the
> result of `error()` to it. It's almost the same lines of code as we have
> right now, but it has the advantage that the compiler will complain
> about `result` being uninitialized if we ever forget to set it. So it's
> overall way more explicit, and the compiler protects us.
>
> But seeing that Junio previously recommended to go into the direction of
> setting it to `-1` I won't insist on such a refactoring. So please feel
> free to ignore this comment.

I am equally fine with uninitialized one, as long as compilers are
trustworthy in all cases.  But the code path I made a comment IIRC
did not necessarily have calls to error(), so the same number of
code argument does not apply.  And initializing it to zero is worse
than leaving it uninitialized.

Thanks.
