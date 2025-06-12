Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462622D7B1
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722137; cv=none; b=QlYNd6WDmc3rdVBgrkSb9T1tub24dlOe/ImY/MzlxhDWCjkDHhWgI1rVzJ+5bk2oEwPS791WHdjfeS4sWI40TQj9dk+X2BOkQrbtZfv49NQ0eMMJRrxc/mA1RPL38QxIH7VukT3Z7L/tPwH0SAAoH5E60ACMQbq0M3Bzx2ShPuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722137; c=relaxed/simple;
	bh=kCYvlHJUoNNzwtVrLGUt6LNjpfNwF2itsV5S84SNVno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=stU9LsIggZ7OmB4dqReGuFzzeg3AQViWkr/WvF8Q/rQXfGc9L/2kVcXnqiaN1SJn9PAJHvMKGEQe9/x0FzaM9kJHHhd7ftt5FGIsnYCt9GIfui5oanD9aguwdJiJFG4xcvyq1+VrGMdMimaqY/chLkg3FKby4sEJ/JnHEX4CG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rkCSxJhi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UX9+p8X+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rkCSxJhi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UX9+p8X+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97C7911401A7;
	Thu, 12 Jun 2025 05:55:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 12 Jun 2025 05:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749722133; x=1749808533; bh=lvUujZQSDK
	C18oYcE/bBnsNQ5BI5ahs6r8zeWf5qvXE=; b=rkCSxJhiAdesKzfxDbp7Qtfl8N
	4N0XboIk4QDcgapqioJM1BZ61644ceMJuYNO+3nVGmHcAPD4JjHJioCBiB41buYl
	hnNu2hjRmRiaTR6w7hg05IWsLfSRBXd+3mk+vCBVVhEPaDnU8Ko+C4XNZDcOysVi
	5bCKzsArPHjrLKotiLDRQ8rnd1MMNBQxYx5c6jEwhfkRr7d9cVt4qaonApgcuNFP
	SYJYNRTwOfq4nrL4s2ig8dqPHGKFBSWYjHu5VPHVcrw2NlXm56CcfwrrPd30M+Hp
	S4etK6hLtgp/azk7ktKgp7q1thJ0m1Y8oeTsG7boNx0qqVCwQWCOA7I0Tm5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749722133; x=1749808533; bh=lvUujZQSDKC18oYcE/bBnsNQ5BI5ahs6r8z
	eWf5qvXE=; b=UX9+p8X+iRErwePdMjDT/xanXW0lm2SshEiAPyLWFDHVYD8Eo9B
	PvG4xSLq1EJyQlPgpAjZVsVqywz5tuVLMXiP1v0v+7mAVWew/s9Wd7szoAP7uWMd
	24Y2EwJAEbncrfIroJ6krfocaqpdXhyU3qehMkjBEBgpNnnPpfXCXEZUpTk7wtJT
	pxUCAK5oxNWewRO9t+u0dZJoDxqircxBmOReUacf8IyQAw8p+k01AkiR9mLb8M2I
	3pAaX7eKGqk083JtBHYtWQLtZmktdTQQgZ+x7pmcKfpwPSi50MDxcxxJ7Z/Gdmrq
	j+VUYEK/AbUKZiY1ShhoyfjSNatFmacszkg==
X-ME-Sender: <xms:FaRKaLXBPOttvPNzErqj-AtU1Y4qW9q94xQXdWDXd0cDmZJF7ijTsg>
    <xme:FaRKaDk0uY8W0LMSbNqiJCilv1YlldSU7ODGv6-YvfiS20BSzVEsuGv3-veezXEwd
    -p24bRkSkfTyS0EvQ>
X-ME-Received: <xmr:FaRKaHbKsiARkCke0dF31606NSWocV9Sxbzc2rKjsc-q2Vz-lTmMGpCL4q7JCn6QYln7Scu_HWoxFSELTwh7bxbKN7yKRtc2y7PU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddugeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvrghsth
    grtggthhhiohhtthhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FaRKaGWkscvl3oiZwEN6ANdPWKnAV5q5XmZ3aWjPoKoo4Lj8qg0Fmw>
    <xmx:FaRKaFmBtbNVgW89cjGq-L1FWbYDMHToV0Fe1hxz945xm0FQp441oA>
    <xmx:FaRKaDelcIPiLXrMw7DtDzrBWUyimrc3qzNk2rw6HXxUyCCAFgywPQ>
    <xmx:FaRKaPFTt56NfnMd3Cw3_KxYqOPEac2HMTHKBiZfY_j9buNOkTNVYA>
    <xmx:FaRKaLSa0QgfMIsoNJAhViucrKO_kv3cNs74NOFTCFDZcY3Y6uCDAGWT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 05:55:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Cc: Andrea Stacchiotti via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] branch: move multiple branches in a single --force
In-Reply-To: <CAEgWtF9MRbRASg1Jb3n6Ggvh8viZOpyev+OyX5DSpWQ7bMF8dg@mail.gmail.com>
	(Andrea Stacchiotti's message of "Thu, 12 Jun 2025 02:19:18 +0200")
References: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com>
	<xmqq7c1jmgpq.fsf@gitster.g>
	<CAEgWtF-fNXaC88FWw5K_3ZpbvQSxAfeuCFy8kkrh_z16vD77=g@mail.gmail.com>
	<xmqq4iwnktyv.fsf@gitster.g>
	<CAEgWtF_0JzZ24L+H-WoKFGaK6Hho-YYbutxSXRud4SK3HwOYXg@mail.gmail.com>
	<xmqqecvqjo46.fsf@gitster.g>
	<CAEgWtF9MRbRASg1Jb3n6Ggvh8viZOpyev+OyX5DSpWQ7bMF8dg@mail.gmail.com>
Date: Thu, 12 Jun 2025 02:55:31 -0700
Message-ID: <xmqqjz5hffn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrea Stacchiotti <andreastacchiotti@gmail.com> writes:

> So, if I may ask, is the proposed patch as written (branch -f A B C X)
> acceptable and you just need me to rewrite the commit message
> or are you not interested in it at all?

As I said, I personally am not interested in such a mode, but you
may be able to interest other people in it, and with wider support
I may change my mind.  But I do not think the feature should not be
tied to "--force" option at all.  "git branch A B C X" should be
able to create three new branches A B C that all tracks X if none of
them exist without "--force".



