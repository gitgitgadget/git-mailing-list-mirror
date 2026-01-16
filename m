Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75A3112BA
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582106; cv=none; b=gP+RLFiX8p6yLPSqaUR1K2ju8Z0bhUfqCXxqOg4JyTBonPZp7AYL0uNiqM1vPWgrnZQQ0U1g+BHRJ0sIAg6CcprBuIm99aVNh5AObYfMTLpPKgbc1IQeFAprJUeRgpsxh8PUhMU/zqM3jOWM5N5aihRKTwZFT01K5Eji0sW+TJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582106; c=relaxed/simple;
	bh=Oj+hU+g0TcGZmUcnRf0vi2SlRQvsTzvHHC8tgYsHyf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qhc+TY7FB10Hbfpjv8/KxEtXKYv00vo247N4pCKWmhz83DtCNeCdzul47e0E8tWvMo6w41P1RWXI65xIg12TexIpVmu2Si3OXCJr+Qv2Ew7OxPcJarQcaJaQRMGGwHAl2OzsUQODZdeWD7+XyRkJ609lj4L5rkxlsmIHhSSWiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IYqp3Jzr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NnKUu7KT; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IYqp3Jzr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NnKUu7KT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4226D1D000C4;
	Fri, 16 Jan 2026 11:48:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 16 Jan 2026 11:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768582104; x=1768668504; bh=HD/OzP2oes
	4lPjUFKjd17We3Jcp0JtA8F1av+vtdCb0=; b=IYqp3JzraoZuoisOJ2AMosXicH
	Z53USgkh0Ah2ccaSd+/bpx7V3XHqwjt0HeviqVZiWY6XlafyCwggIvxQwQHYjo26
	SvhWtFyQmIzTj6X8tK0utNzCqpvYADG4EHdYvXbg62mcb2cnyxi1V+Z5NG3veUSP
	ym5XEjmAt3ddPkmCYpzTxbTblMzSYmpeWWkDRenJuvbijs9cUiM5EjAxZsu6GJGH
	m02plQAZNzmYU+iA59bFahaXXjtROs6aCJIGyIqY9rQn9rSMUK16r7cjrX1QMxHZ
	oQr7tXxIHvRE1FgmWFPTecvkmOq5TET6Ctt4ZBg8i+O5QyUQ69pFpo1ZV6Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768582104; x=1768668504; bh=HD/OzP2oes4lPjUFKjd17We3Jcp0JtA8F1a
	v+vtdCb0=; b=NnKUu7KTR/OtSVBprG0FCqVDjpsMSLlxgYCpZG3zfzvlGN7BuLK
	cmMvtBwHFFAWjHSg3JraqTVMF5HAdMLIK0Lf9h9wy3uizNxqa5AbQwUc8NnxPNxl
	TydfPUg212qdB1j7+Xw3BKaWizhLBlJQEIm2DwE3GXP//Kua4tEnGEqrpxAWB4C1
	/zTlrXlGbPc7oTx/l9TXwgSQ2YuGC0M/aPjwYvRdp7YXKVLnYaXdmTwOSGf9YNFz
	YBrDnA5JB2vjOSk8pMWun9mi9VrujfH7ya3EPhxojeQEQnSYI3asp6t9DjbpShB3
	eWyMeBZUvCsxuMBAhYmRqvAGiA7kPqDlraw==
X-ME-Sender: <xms:2GtqaY4R0qKGTrawgDV9x8gmBh6dRFkUoiNcRTMvq2k10ahcwhiMjA>
    <xme:2GtqaRUF8RMD9UWuj361LFbxWVLnU9M8vOBPRE8QMoMU18Sxk2pmK36-A7u-JKZ2s
    hwEZAmx8bJC0DzCqLZgCfJ-RyiOTzDQlqQj6OFj22z56kuLvJ_ioA>
X-ME-Received: <xmr:2GtqaU0QCiKVKWT05GoSQd3uZM6A51IzcMa6octXOmoobrphI1WAEcYSsmYcs9QfkKuPu95s63GX3a9mcfyFRo-cRVUFgbjKvc5qA7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:2GtqaW2itD4KhK4iCvO4rnouxSSkx499ZYO0IxPa8TDEYM4W6B8Gwg>
    <xmx:2Gtqaf-RtKlzvqgzADWZkVcQ7KS2CwSSJny1eEcvfLBPxg2xgvSTYQ>
    <xmx:2Gtqab3EskC-TrPTbKQJ01I9vjF74g1Nqf37mrC7clD-nuxwLL4dGQ>
    <xmx:2GtqaU-c7tpi1GW4y-y1kmrCbBKFmOQxODogsGqNdgK3A4Q4e3cIKQ>
    <xmx:2GtqaZehhcsExAQ3nGfDpkHibZej0FeJwZVpkOonbWjVclAvMFexuZXK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 11:48:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] Rename commit list functions to conform to coding
 guidelines
In-Reply-To: <aWngu0AZx5Akd_m0@pks.im> (Patrick Steinhardt's message of "Fri,
	16 Jan 2026 07:54:51 +0100")
References: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
	<xmqqa4yfdmsp.fsf@gitster.g> <aWngu0AZx5Akd_m0@pks.im>
Date: Fri, 16 Jan 2026 08:48:22 -0800
Message-ID: <xmqqikd1a4h5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I dunno. I myself prefer converging towards a consistent coding style,
> and part of that is to also adapt existing callers over time. One should
> for sure be careful in this context and not go on a holy crusade against
> all violations of our coding guidelines, but I still think there's a
> point to be made that a slow trickle of changes of sleeping code is
> fine.

I do not think there is any disagreement here.

> If it's considered to be too invasive that's fine, then I'll drop it. I
> think there's value though (well, obviously, otherwise I wouldn't have
> sent the series :) ).

Sure, if there were not other activities in the codebase, we can aim
for perfection, but unfortunately we do not live in such an
idealized world.  Among the three patches, the first two that
weighed only around 100 lines in fewer than 10 hunks are not bad at
all, but the other one was a bit too much.

The linked list of commits is handy but not particularly performant
data structure; instead of renaming component functions in the API,
rewriting its users to use a better data structure might be a more
productive way to achieve the same goal.  There was a topic that
gained quite a nice performance boost by rewriting code based on
commit_list to use prio_queue, for example, in the recent past.
