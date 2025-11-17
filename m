Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F451BDCF
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763341282; cv=none; b=R7VCoBMNPdbNgMJvRLA53J55YVRyWfPJhDyu4zX77Uo93LI8zcf7TntcMeVqPafmwPjfhNME2GoWNd3MuvJJysLfNjqcecHJB+JSvp6jR4ScSe9jG6Sae5DsTtT12EeVQU9isQrZy10p9PaSiqUDtev+RySfm/4BeoQnp8lsY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763341282; c=relaxed/simple;
	bh=CUR9aDSBryH6rYFmkRNAjKSUTHc2SLLwiyRJinLvOhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V54hTvrufCE5/7Ak76FftTnHCgy/LwMKp5h2fcG6Di3OiT9YyNjaDA/jod6GFhTLblvWlZyAwjHHjf6iOx8NkSSaPrYmoYzQr22TycRPFS6z1qNNs5ShnJhUen67S4WUgTu0RF8qrTEY/oqHtCpkips0IwzNeR+RfvkcrSjb+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DHI9LdLQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SRcDoh/x; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DHI9LdLQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SRcDoh/x"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D569A7A010D;
	Sun, 16 Nov 2025 20:01:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 16 Nov 2025 20:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763341279; x=1763427679; bh=nWhpGWlduv
	8YKdbxtSSMRUY6ut+4CmLCtyZh5QGXFpk=; b=DHI9LdLQFnftoV7Qiu6KqbfAtU
	9Ou0FdYXF4Xm5yiieVa68oC031FWzloi5xkSFOzcLecSsM7dGiPTuwJ0fMLVVUGI
	bPvsF5DddmC5L6DrM0mq2P9xXJ1QIVgerUD425RkzT2LNii+5L1BucUy17zjvZPV
	KvBU3lrvXAzYjdYF9FS3bTruTwJZ+UIkk9xXq99jN5bmuLsnkwB5U2h8bMW2R/SZ
	yw4rqPp3laNussaMS+SrlJIxXHkpKsxY1G7I30G1ZiFWchKN1Pv9/JIncDKLEaIg
	Kdkg16b5PiWEuiCJeRIdxS5Hpgqd5G0RRot/i3U5ixnSj6JKs1+xUSo5ByqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763341279; x=1763427679; bh=nWhpGWlduv8YKdbxtSSMRUY6ut+4CmLCtyZ
	h5QGXFpk=; b=SRcDoh/xwp0ljPmCArXDb5JPFp2LkqSdWkC3WlAd4l/g3H9mR/0
	EAh+bwPfnxmZj3VO10Xkf6/UE0VPl38gKsr3cgHJkjs8iXhHhY8w7lqWFdd7muhc
	p1Ys8wr2JJhmESWykMpy1ZkBjXk8z7XivcqWIYnG9cSfiIkPKCnzCfimBuwbykcs
	7lsbvWZjdIArO0cBJmMXLPpWnFmZL7N+sj6Gd+IcSXTnlkHqc2QuGIIh3nMoXEAp
	LMNhJh0XTcS0L1J+88bPXRZGyabQ9wNmX2SFgyCP+EDpf0H6Lq+GcUyrr5uCLsgo
	J7QdtKhZgZFglEZK27teilV71ia2+6SOr4g==
X-ME-Sender: <xms:33MaaYgpG3Jo5nf0KiKKHT47xVGP6BqGusogYGrPTdRzi2L4TPdq8g>
    <xme:33MaaX7FbVHWCeFdrA0f9hHdd8-Uqhnuw8EzY0AEz1To8Dfr7A2LzLyaJkKJK-p2O
    2hJZ1QISWARQCKQ4R1WkywY2s0pF9L6dj8XMNmiwsSoPNavDizEKQ>
X-ME-Received: <xmr:33MaaYbdZkIlmPCriibBRUBzjbXgCYxumEqTA6K-oVzQT2QPFGTESxJtQ4MlGywc6WijnqJ-19p66eCQ-BmePYkw8-YKKiRsrYDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:33MaaU7g-6Ey6xoNXbIV-Wnco6khLaNlBmBka1YjWCUI5xgsDFlpsg>
    <xmx:33MaaTBSwuSCBiISVz9p7oBpBhqHONBT71yGNSBM1N66edB77Vsdow>
    <xmx:33MaaSd40GRb_go4Qg0jvl2ISoKNLuhGUFPAERVmt4uaCi1Ro_bJTA>
    <xmx:33MaaaJ64yT_bZlGsIwp0HUTY92qZEE5mxlNmozzmm8uKYSG8GXSKQ>
    <xmx:33MaaQJwik0vd8YjW-P-2uyVZE3TbxJGxdyW4kHLkoUCSxh27t2tmE9c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 20:01:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] t6429: update comment to mention correct tool
In-Reply-To: <CABPp-BGchyC6BB2p7p-6qHvwcu5AV+VCAdTeR247F0VamsJkbQ@mail.gmail.com>
	(Elijah Newren's message of "Fri, 7 Nov 2025 14:40:28 -0800")
References: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
	<950236f0f812197e260159a688fc6f6fa61046c7.1762192908.git.gitgitgadget@gmail.com>
	<2983385e-daeb-40c0-a8bc-fb8bd3b744a6@app.fastmail.com>
	<CABPp-BGchyC6BB2p7p-6qHvwcu5AV+VCAdTeR247F0VamsJkbQ@mail.gmail.com>
Date: Sun, 16 Nov 2025 17:01:17 -0800
Message-ID: <xmqqfradbhgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> > We could potentially just strike this second comment, since git replay
>> > is a bonified built-in, but perhaps the explanation about why it focuses
>>
>> s/bonified/bona fide/ ?
>
> Yep, good catch.  Got it fixed locally; will wait to see if any other
> feedback comes in.

And nothing seems to have happened since then.  I can amend the typo
away if you want after the release before starting to merge topics
down to 'next' again.

