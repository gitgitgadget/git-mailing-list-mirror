Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BF190674
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608991; cv=none; b=k7RmMggzcXefpR0wi1FBIgwJDBvKHGDz1lorB0/UAHeufMj6wx6MRHmSQ22vTuWdVqdp6YKBs0x7qG1wbif0azi8O5oIuyLSZHWSbbsYtMue/gGC/Fn84sz5anvVjUro6AIYPkYAtMRxYjvqd/QGag2RsMf/Dmem4N/IE4e7Bmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608991; c=relaxed/simple;
	bh=yOZNynp7UOokDD63J+POa+zmx9ffjBNo1Sg+dVJVc38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KCr5BkZdtu8GEdxLOGZvAqkjuYGGl94xR66/XnxLQBnYXhp/jysh7yN/1orzO958kOmmsVGp3HXeyRgLvLIi8g0Ge64d5HsQoxVv/YS71j6c+FeA5g8w/KbCp8vlfzn77LanHgc+H/DJOjusRLjMjRdk3MRaPr/6uwoqlib2YlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=57tQmeh9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="57tQmeh9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2693813806F0;
	Tue, 26 Nov 2024 03:16:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 26 Nov 2024 03:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732608988; x=1732695388; bh=mEg9l0xuAle7M1fHKxA3NuYMC8VK8YGeeta
	DXS8HPn8=; b=57tQmeh9TXrQskMSJDGkx60ozJPadp6Ic3El97GoQMIXeAGwMNu
	Liz2pW86Xm4KLCjeQ1NijxdWVZRv9TJ2orN+Vo1wOf0M+oZPpvrfaBJLEhaYwSEa
	o5czC+OcRXIhLJJtvfZAQl8YSRds7Ws3CKu2dqIv+FrNwktgyBaKxnp2XoFwfAWJ
	l3YFpCGEwbukCFcPff5A8+0YLcFq7s1sN1RaZQ/r3Py+u0cKYpWzixotbFXCsimN
	5qCLYFHLafSkzq2aXK2wdlEhMePn6wR7B8L7EzlXNVtSIlmwJlo+NXMQkdxB2n/9
	U+8YbWyhjW+XUH/MF55ksgGfXodz/Yuo/wQ==
X-ME-Sender: <xms:24NFZytyvRZtv2_rlx9MFLIfBsa1Wb-NOh5IEKnQU_qjYd-l2d1sIA>
    <xme:24NFZ3da1rQHqFYoVj5m8wnlKz7BDYJzQa3gTQFMn6VxNf6PUrfzMo11USg4gK6mf
    SMZ3p1HmMRjCwavRQ>
X-ME-Received: <xmr:24NFZ9zGnyNYcps6ETdD-V2yuw14ypfHe4iiay_obKdTSiiPShI5uocmkUcdYN6CkMqFf6ncuAedCbFZPlPJO5wP32_rIZTSylWXgTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggv
    lhhinhesghhmgidruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:24NFZ9O_ZBfzxiEhzHnYxXqXJxoDaQBDoYctPl2jmjXHwIHFgrlFVA>
    <xmx:24NFZy8DBYdZEe3gff74UVKqocbaALOdrbWOkZjB0jWaJp_LUB1ikg>
    <xmx:24NFZ1UxOTDCg-3OYaM3PHPcJDGmcHTPHXGjEecx-5cMy9uMcn2iXg>
    <xmx:24NFZ7fwpY08xGbsZtmT49LMcYQ7EkQengd7J8Xm4j9Ws-Jbgtu8aQ>
    <xmx:3INFZ2X5kNDZk7jvW2HCofOsTQDvmmLb7rns8ifJo1VxI624FEsobJE9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 03:16:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  peff@peff.net,  johncai86@gmail.com,
  newren@gmail.com,  christian.couder@gmail.com,
  kristofferhaugsbakk@fastmail.com,  jonathantanmy@google.com,  karthik
 nayak <karthik.188@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/6] PATH WALK I: The path-walk API
In-Reply-To: <Z0V8D4r5YbxjNvPs@pks.im> (Patrick Steinhardt's message of "Tue,
	26 Nov 2024 08:43:11 +0100")
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
	<pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
	<Zz+61fat+vGgb+xL@nand.local> <Z0Q7oGF6Q5U-f4VX@pks.im>
	<xmqqa5dmzboa.fsf@gitster.g> <Z0V8D4r5YbxjNvPs@pks.im>
Date: Tue, 26 Nov 2024 17:16:26 +0900
Message-ID: <xmqqr06yxvdx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > then I'd be all for having the path-walk API, even if it doesn't help us
>> > with repo size reductions as we initially thought.
>> 
>> Is the implied statement that we didn't quite see sufficient rationale
>> to convince ourselves that a new path-walk machinery is needed?
>
> No, it's rather that I didn't find the time yet to have a deeper look at
> the patch series to figure out for myself whether the path-walk API is
> needed for them. So I was trying to prompt Derrick with the above to
> find out whether he thinks that it is needed for both of these features
> and if so why the existing APIs are insufficient.
>
> I'm already sold on the idea of git-survey(1) and git-backfill(1), so if
> there are two use cases where the API makes sense I'm happy to have the
> additional complexity even if it's not needed anymore for the repo size
> reduction.

Ah, I misspoke and failed to add "in order to implement these new
features" after "is needed".  I like the idea of "backfill" thing,
too (as code paths to deal with promisor remotes irritates me ;-).

Thanks.
