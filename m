Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715A2857C7
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500470; cv=none; b=myrd12xYE6g11rLWradhzUmaePEOQ9976D5zpgAAoWZWSjcACi+a7NpEKpfnpONAw9LbZ9V9qBw11GRhzzVPTbBKH9e2Qm2bGjIw/2bpDNfLGwWM7ZRuDMQL3/Nj1+eItbpxVbup13IOHNeB1wEUITYFEfB5qDNwBEiZsCJopHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500470; c=relaxed/simple;
	bh=3D2GCPyFEkJOZ3KQF/irS6cv2q7ryj2+YmpsQtpR04A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D06LuIa4LBq86JEQo0xdpzoMjlJvWjWmXleTL0RdV2NFEyvQZf+wRkzTeuUmPnitGs7UQ04iqBNma79rIZReC7ZfQg+32/cLDNaHPYr7BdobYScKpC95fCg1v7VpYlCG2BFSQ/erktw2ae3MvMR15Dp7PeL70cvvVcdw06rSers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UVTNABk5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LCUMgKhN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UVTNABk5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LCUMgKhN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E4DE1400035;
	Sat,  7 Feb 2026 16:41:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 07 Feb 2026 16:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770500469; x=1770586869; bh=NwpZoOILUE
	+tOO9PhNOscFa79promNAbLS9CRc7Ks/w=; b=UVTNABk5I/WQ9K8n+CrxXntRFw
	9Wtal669f7nxzZ45gRZP6+tr35nYYSVa3TSam1RRg4ahBGvtCNxN85Ty1qTMIG1r
	29ppunq/0gHNSa0uC+ZFsdTOvOjYvf9S9BK7ECIi3EmRPV+h5BDlxt2vhSdUeKJj
	ZUEdIi4zcILOzMPv/hbfCCVro9GsZsS2L5hQaOGV53HbXJk1kyxsKX3Oo6Raw+xK
	+Iso1zp71XMwjWOLvWwHA0RyPUDRypLvVL/6Iodt9t7ByHCqfxUgmXAb9jg050wH
	b2SEk/gk9G5ilF6r2wRSR2monZlm4bB9GWNnpkHnL5EYwOCYHY3RF+fhTPLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770500469; x=1770586869; bh=NwpZoOILUE+tOO9PhNOscFa79promNAbLS9
	CRc7Ks/w=; b=LCUMgKhNIDtD39zShCtfkgyVffZVGXMeULcwJmcb5Anky2/IoED
	L6IvyIgN+f0XBMWUtFS8K/kwGggD6ic0GJs7hdpta2O5LXFJtey+IGF6VrZlXGzp
	1x1Oo4QGj0o7c5Vk6wh5T27jq20xbls80P/hqgkj4w5Wblz/t7zkOXrX4/uM089Q
	2QPzXVmTvuAPjCQtyyc66EXsCs39R7SRv0nsOPllkb2sAFi/rszv388KGvFzqDV3
	8cQY41WIaRhsTPBJnXIYSNdRzWAfDCReF6ayz4s4taqjL4lFSEoOom7AmqcVeHUV
	wGRpeB+oDePya2IgvuZlAdR1PXq4o3++xeQ==
X-ME-Sender: <xms:dbGHaf-xciP9_7RXGLPVRWk3VGiuK5oTUpHA5R5AyAHWlNttiMrTFQ>
    <xme:dbGHaeTDiI8y0KVTehFvuZcw5uIyl-OaVdyF0oOxjpLEzDOUttz8XbHlNBgyJLigF
    iRJEIrT3YHIvhC27YJWr4Nu8UMewaBZDCmGggRG7a9BPSchdzly>
X-ME-Received: <xmr:dbGHaQoViNInmh8yoBIIxfZRJ4iki2rpVeuIxomBpid_7k7fhxNhUHEgY31ezUl3wqGnMyroWuapAkLxlRAoYCfJNslsAfZsLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhumhgrrhgrhihushhhjhhhrgduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgr
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrg
    efudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:dbGHabmmnAWZByuPY5-d8rYK6xjzKa9OIuefpwh9lSHV2bPHQfxeVQ>
    <xmx:dbGHaZdiicPxV_et4ikGEvoAy2tNA7RQZO079o2IFIH8tT20a7OynA>
    <xmx:dbGHaXpa6JY9Tv9XOIJRE-JTm8phGh5uWO1JWIrrkS04bNO9EZQ_Hg>
    <xmx:dbGHaTMet_-mhQT86MPAFi_HYG_sGY309f4-2y2URat28cJWUkKP5w>
    <xmx:dbGHaUBSM0yltjmmWxREcwgQE0isBsT6iKURWMn2bhpCrS1fMuZwRz3j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 16:41:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Ayush Jha <kumarayushjha123@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <christian.couder@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>
Subject: Re: [PATCH] [RFC][GSoC][PATCH] attr: use local repository state in
 read_attr
In-Reply-To: <E605A7F6-AF4D-463F-8316-6BE69AFE0369@gmail.com> (Lucas Seiki
	Oshiro's message of "Sat, 7 Feb 2026 18:02:46 -0300")
References: <20260207114007.40-1-kumarayushjha123@gmail.com>
	<E605A7F6-AF4D-463F-8316-6BE69AFE0369@gmail.com>
Date: Sat, 07 Feb 2026 13:41:07 -0800
Message-ID: <xmqqbji0b5ak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> read_attr() currently relies on is_bare_repository(), which
>> implicitly depends on the global the_repository.
>
> So, wouldn't it be better to make is_bare_repository depend
> on a `struct repository *repo` instead of `the_repository`?

The codepath read_attr() is in is usually not that hot but it is not
cheap.

The repository object should have a boolean that says "I am bare",
perhaps initialized lazily, and your version of is_bare_repository
that takes a repository object would be a good entry point to it.

Also, IIRC, there is another releated effort to allow attribute data
source to become per repository.  This change may want to coordinate
with it.

Thanks.
