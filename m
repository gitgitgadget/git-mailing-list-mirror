Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83C341679
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736986; cv=none; b=IFD+6TR7Z3svOWiribjLnho8Xpv7GLiEns8kA+ltXklqPbN0nS1/w6Vr37yfUWcQJJKrcfhKeSuhPhynu34j4hLyCd//vPODFXVsjjWt5Z6P1Aope1MYH5hukp6DfBI3xwfc/sLeaLJPTDynVP37O3UPfGvL3VNOlD7GTkNy4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736986; c=relaxed/simple;
	bh=qM+ak9Yc/V+uh6Awpx4jloeX1iSo9105Y7sz94Vdk0g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UFGfBSz/LPaSQINH2XdQzoarG0whqhKXgz4QoK5V2cvHb0d7nTo4zKkotI/faWXNtW1TerCQSavuiBXcyam1pzHQKk+pUrvbdKS6G1FkROhpcqLaa6zzuzBxf0aBF2DhIdd0gZKV/b3pdvnO7DLzYeQ8jEKG859nkc+VDVgNQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=rq1aWpRk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L+pSpiL0; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="rq1aWpRk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L+pSpiL0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 54E711D00269;
	Mon,  1 Sep 2025 10:29:43 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 01 Sep 2025 10:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756736983;
	 x=1756823383; bh=N2ymu19mh7fEBqZN/DaKhOxFvjNxv01ivcDRaHtshaQ=; b=
	rq1aWpRkRRshB69k69nSGzjsCgrCIFoENVUvoO2FUlIvyjvRquIhKdF57V0+/LIh
	qFJmULKS6vu+KKx7xV+IMGfcYQRrOBjoMmPo2gdkMB5Gf4VKLQH3/E87z1mV3vy9
	AOIdy7JFfyJluBBKOrzw0tyGW4OenTdDsmrCOodv29oQp4nJ8TWa7RDTdVllUL47
	1ZXhaZfTRv2mQgCW8ml6/hJrLwNnazy40RCPgIa0vJMu4M/SkB19oR6LDtiVp4lq
	4kDLwJvQITm+6IiSwxNBf1cFHTnfqNmobXq3FYLPnEfRYefNkLzq5bAn5Nco5/7n
	/cgiSMA6sSH1d6lu4cgyWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756736983; x=
	1756823383; bh=N2ymu19mh7fEBqZN/DaKhOxFvjNxv01ivcDRaHtshaQ=; b=L
	+pSpiL0tdcPPr9+8FUhcvm6Txbv+T076VIlIwZDZmNkhVNVIwbNmd6K4WzIXgbRM
	ukFUg7Q9Buyqa5WaZPEoIhagVYp6kT0dRh3JR9jjqrPSTS/GM9qxQjDAb25lLCOd
	efzYwEiCvCHrWEfXwMb10Bw+zrD0Xt8m2xWmCM/Fod2RHlQNDmNNZ2sA04zLLlxQ
	KLrXw8D7u0XTEfnfLr2rd4syYqEXbh/VS5D6t1JpktwZLI45AyO7HkVTlPmmIxjc
	5joHQkdFiwJHvSzN0IdKm47A8ntO5JtqqdMKrEpN1I3zGmK90Qa76ECdutfFIHUF
	sYhkDLX+X8bFHPxwDoo+g==
X-ME-Sender: <xms:1q21aP3uVC2ef-zGvFPv3LqeDAlxAYG3mzqS_9tTQDmbL5oE7mfyqQ>
    <xme:1q21aOErE5uprnCZn904KGkF_zFaajLJQuGt0aCe-aGq909F5OU89nwDZks_dJ2GD
    HIVX7DlMW9cEn9oB30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:1621aA9wnioxquycoqNaABOUf1gUML_d7wvEj9u0k3Ifzh6OMU5A4g>
    <xmx:1621aCJmOHuEW5XXV4sE7ja2QkIeC-pANZ7fcuJTIopMlPms0cKgiA>
    <xmx:1621aFlWtBTl3EhmvPQaUQ4uQ-Tv5yjt_qDoMunw_m1_H2weV7hqyg>
    <xmx:1621aGPNUyayYSnvBjUukb_EsGihJkkG_KeZIf6OQL8bBom4QhYX6w>
    <xmx:1621aKo0BuNqoYffpeFRcbfxNtm1Rxia6M51fyY5LXv5-ApDMKdB5JBd>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E505A7840CD; Mon,  1 Sep 2025 10:29:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABiMobVYJg4V
Date: Mon, 01 Sep 2025 10:28:44 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <9d708558-df36-4bdd-a914-522228b27215@app.fastmail.com>
In-Reply-To: <xmqqh5xqnlmo.fsf@gitster.g>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
 <360051d2a656727ca42d489de81ffec9b23a6386.1756467934.git.gitgitgadget@gmail.com>
 <xmqqh5xqnlmo.fsf@gitster.g>
Subject: Re: [PATCH v2 3/5] doc: git-checkout: don't use "reset"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> I think the source of the problem is not that they "don't know what
> the term means" at all.  Isn't the real problem that the use of the
> verb in the original sentence you are correcting in this patch is
> vague and does not say what the branch is reset *to*?

I agree this is a reasonable approach here, will try that.

>> Many Git users don't know what the term "reset" means. Resolve this by:
>
> Even though it is the name of one of the most often used commands?
> And yet a separate step in this series made the claim that everybody
> knows what "switch" means because it is the name of another command?

I'm surprised to hear you say that "reset" is one of the most often
used Git commands -- what I frequently hear from Git users is that they
use `git reset` only in "emergencies" where something has gone wrong
and that they're afraid of using it.

I'm curious about whether there are any datasets about which Git
commands are the most frequently used, or if it would be worth me
trying to build one.

>> ... This is the
>> +transactional equivalent of
>>  +
>>  ------------
>>  $ git branch -f <branch> [<start-point>]
>>  $ git checkout <branch>
>>  ------------
>>  +
>> -that is to say, the branch is not reset/created unless "git checkout" is
>> -successful (e.g., when the branch is in use in another worktree, not
>> -just the current branch stays the same, but the branch is not reset to
>> -the start-point, either).
>> +that is, the branch will not be created or modified unless
>> +`git checkout` is successful.
>>  
>>  `git checkout --detach [<branch>]`::
>>  `git checkout [--detach] <commit>`::
>
> This is in response to "transactional equivalent".  I've always felt
> that there is no need to say "transactional" in this at all.  IOW, I
> wouldn't have minded if we rewrote this more heavily.

"Transactional equivalent" was bothering me too and I like the
idea of rewriting it, will give it a shot.
