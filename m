Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794E347C7
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560009; cv=none; b=TlaHlk1Rfqo4GeWKLiX+bWQkgs0HjeHlxVPe6BmNfy87dLCR5IHQAQwpMkMtGbsm44tn/FSteIu7xGyr9Qtn21H6zrRWzWYDJsC52R8dcZJRri/xBgPGqZWZPl8XgKRR6Wi43OfAcAvslTizZG9F9AmAnOz/lTIrNseUsmtn9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560009; c=relaxed/simple;
	bh=50UnJ1p4kYTlHeQRdKTsmVn9QxIrgryq5fp6n9BS8n8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9TcTp2sifOBZaMBTOnWyDoyDc3UrGeb6MiSp49pnUdWYWrIMnZMn1+NfzE9z5ea3ahRnMfx5Tb/pYfV38rfcRaQnb53CeNjm8TozLN773U2jGbtr2JGKFDf8JYWLwABz56kmhG3B3lBw0HZvnLPb3VFygKd5yV5eeL5bKvepMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ldy8IQLn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lK2EtI24; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ldy8IQLn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lK2EtI24"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A61B140015D;
	Thu, 26 Mar 2026 17:20:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774560006; x=1774646406; bh=wIEb/Aclyx
	J0PIpWcB10lS+YLdhaHOgkfN+lfMlbM9k=; b=ldy8IQLnO0ypciZpnXAAthHC3i
	hQDMoXe4/Hfzd/RSgRyx5kgRZF/y3E2YwJtvP5agNRx7NL3o9BZLeaJ7LLQOAgU0
	jmKv2Hm6ihwnUv5Vu7y9952z+B+Gm6LxIzNd6k2LC+SAws44oE6qHdh2gmEbhp0m
	1l3BXZU7NqKbQrsFS59FBzlsTgBof+Lt8jyS8fozPgBSB5AtQVL3LQdfiLDNnUqo
	1CUg7nrvI3dbJ2Wa1NyyHvpF28J8cX80aKWjTcXbvEC4MuAORZOIYpoVKypf8T4B
	1OhU+v7Uzhhb6r9iAkuw7HZnUEZEyHP4C4rV5i+XusmwNSUWS3Slr6oyQBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774560006; x=1774646406; bh=wIEb/AclyxJ0PIpWcB10lS+YLdhaHOgkfN+
	lfMlbM9k=; b=lK2EtI24vVXWZMEEGl68UfyH16iWxjvbfp29wDVUSpAXqC8/pzk
	H7jMNAc5yCfLSPbagYfVe98Ea3bFRRf2jfG5ugQEDv26h0dTh/u4HC9Y3tLfSZG7
	l9qaKnTEd4g45Nzrf7l3PN867S3F1xGx5hzEof4P+SCoyEHU0KYYFiaPxxY8izSS
	gfpJ9N0kV8AnZNqtJi5CnUrFDJLqfpfXqynzOkXbgLB8Q5N7vdq/BrG1snzyGRz/
	dh+988pjP7lO4B+RC9KZDGTLgNoL2U/S49F+IWIsDaq9kCCP9y1t0PwGi2qSIXrh
	9VIgP8yHvRf4in4p+6Frlfi780MPUvBz+NA==
X-ME-Sender: <xms:BaPFaTpgt0qaK3gaaZW9TNMr81RYJEqA4YuE8m9Jugh67hNjiZZIaw>
    <xme:BaPFaRVWcYmvw3kg-c44-3wM2o0-0y_7iuEVREJOhPd--jQvucyygsgVsPxUMmwAn
    -SMm7TGIfFsm2JGbaUpDQ3eF381PETDWH_Jha-OJfk9kR1AGsnDGQ>
X-ME-Received: <xmr:BaPFaaDftzJOYTfrQGnKCE1VG-VjbRdRoJzxKWNPR4tXtt80ghbRrz2rYr2dpexx44m6WnmFObTyvFkWZnliVMHttnl_-oPSkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrg
    efudesghhmrghilhdrtghomhdprhgtphhtthhopeihvggvtghhvghnghdrtghhihhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BaPFad1moZZln_SeMcJPwP2jVF2NAGXVEQE1P3FDMZKw11XgY11r4Q>
    <xmx:BaPFaU0pVQWdCUGKN1mu3VV7A5DxN57FzUIQS3vcNV5bYw1aVn7oQw>
    <xmx:BaPFaaDiiTBoBcCNy8dTShJa1mLnhcg9u9lLVL366LR324lftHdBQQ>
    <xmx:BaPFab602UWrnjIoPJl4AerUKPMC6dPOounTIQV4NhW5NWAp0gG-7A>
    <xmx:BqPFacviE2LqQ6F1XP9VlT7hitqgSl8BrhGDQZab6MwIM4rH2-rfY-QD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 17:20:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Siddharth
 Asthana <siddharthasthana31@gmail.com>,  Yee Cheng Chin
 <yeecheng.chin@gmail.com>
Subject: Re: [PATCH v2 0/3] Add option --ref to git-replay(1)
In-Reply-To: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
	(Toon Claes's message of "Wed, 25 Mar 2026 16:59:28 +0100")
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
	<20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
Date: Thu, 26 Mar 2026 14:20:02 -0700
Message-ID: <xmqqjyuynv99.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> This series is based on Siddharth's series[3] to add '--revert' to
> git-replay(1) (sa/replay-revert @ ba5c0d03d3).

As sa/replay-revert has been updated, I rebased these three patches
on top of the updated version of that other topic and merged it to
'seen', which broke CI with t3650.

I naturally suspected that I made some stupid mistakes while
rebasing, so I applied these three patches directly on top of that
old sa/replay-revert.  Unfortunately, the same test t3650 fails
exactly the same way with merge-ort aborting.

The failing test run fails like so:

ok 45 - --ref with nonexistent fully-qualified ref

expecting success of 3650.46 '--ref must be a valid refname':
        test_must_fail git replay --onto=main --ref="refs/heads/bad..ref" topic1..topic2 2>err &&
        test_grep "is not a valid refname" err

/home/gitster/w/git.git/t/test-lib-functions.sh: line 1180: 2840466 Aborted                    (core dumped) "$@" 2>&7
test_must_fail: died by signal 6: git replay --onto=main --ref=refs/heads/bad..ref topic1..topic2
not ok 46 - --ref must be a valid refname
#
#               test_must_fail git replay --onto=main --ref="refs/heads/bad..ref" topic1..topic2 2>err &&
#               test_grep "is not a valid refname" err
#
1
