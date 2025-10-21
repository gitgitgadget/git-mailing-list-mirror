Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358C81720
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761023456; cv=none; b=C2S8RwjVf+YVgFLl+Pw4WUBMGjTqpl5k03j3dtxBhK840hGy7jUVyZN3pC7d0yYNqDVeDkfV6SmYqWSzfGGaknNIVVXkyKvY8M47/QKotOLXlwaeFXPjzJEWS89rHEzbzIQSYZmQXXudLqo/vk/NawdcBeJCvmz54cz39Xt7r0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761023456; c=relaxed/simple;
	bh=eHjsI2RCOaHzk7zXol71q7K6tBpOK/T/w8/P8/Ypsv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oCGEgvAAFeaBKGJ0o42sGdlyJYyrEBzWuu/dQ1IPXqapA/zNZQguCN/04WYJjbZZc/1UaCdJ4d4ctZBQJeHPY4Cd3n09m+3yxsk+mDddrpUzwUKIXeldZ+TQKZlXGkKIIR1QresrdEAaFflXwBlh9S9CWyr8MBWFtHInaaCGmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OhGAQ1a3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e10ULkfL; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OhGAQ1a3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e10ULkfL"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A011A1D001BC;
	Tue, 21 Oct 2025 01:10:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 01:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761023452; x=1761109852; bh=eHjsI2RCOa
	Hzk7zXol71q7K6tBpOK/T/w8/P8/Ypsv0=; b=OhGAQ1a3r5DxbYazA3fkxqNQ0a
	2JnrQEjXL0e/1XTW2/itS44KF7uVKppRIrNpb73b1inzuiS0VW2nQD+vqd1wF8Vb
	i/dFGrQ5PnjackAXoaUFRe4ZLqxD/qLbVoIdKBEryNq+ehqwR0P2SjMYmDNTIKJi
	IqrGTnqQaF2jCHGAm+1Wq0prtEvcY0z2mpsnvc+Nf4/VjfRcrrBQJIhimYrKeO1N
	lZPnTsDR2FsQ7l93sdwm86Fo1h1QRRjD0jeVOD7dg79cZekVcTTjaLlVlDNwLuX/
	HnnoefmqFK8RiA6+2IdmRVNBOWxq+tlWXvuwXf8AVMjpwytU4Z/6BEOaw/xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761023452; x=1761109852; bh=eHjsI2RCOaHzk7zXol71q7K6tBpOK/T/w8/
	P8/Ypsv0=; b=e10ULkfLahQF2gqCrHrrY/Z/TKbGYenCL37tXAwLTeRQ7jJNRGs
	8NIzeLG9Qqh82OTajPeFfitvyDK95gt2iLId6JTpQbT0pN3xUhF5KWBN27lIveYA
	LBUFcSSsG1VEamXwEq0iDy+HS+Ud8dBCS69VTHN60Om4L8XlfnC7+7H8M7BzINQT
	fQP/ZxqpR8qlZlbxtLCNSPRX2KlHiuHgCK7XKWjj/osTOub9vFfXO+GYOZeI8utM
	Oyz3yFZU13fgk25bcPYlrxF/FzSZs+Fi5rIJC2myZUU9yNNAnaXFuB55CdDnBlMo
	awBJvc2BLfKKHJ7fgZOQ8bJbTNpkCxgO+Eg==
X-ME-Sender: <xms:3BX3aFp0VOtNCV6h7rfACwLI0lZR0eyd8NS3_eD0NWEaoLa-Uj17Fg>
    <xme:3BX3aOompcUJXH6lnYdag777Y_X_Qw7ANrTceOELK1CKSioLw98iSZkT6KRagjbbF
    siTwQQmxW55-rbQNy4891WnuTlH5vEfBpp7EWXP0RF_Qu5fcuLW>
X-ME-Received: <xmr:3BX3aHPb6cHTzfEXqoGPeTl6qns6mYJ3WjW4uhtACxNsns2XnemoiUL3C9mRoT7LGE_5Wg0KzCuklh5iLHO4lnjLA837FAIvfFqP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3BX3aPzP34wrb1m12FnUaA_YVqZznjOQ9sdcsd4XtyKwOakam9u-vA>
    <xmx:3BX3aAssuQGsipfoEm-ctNlwHIdY3Rxrm9FOMCEqfr4bXFNWuicb9w>
    <xmx:3BX3aI7wI4w19hw3sgBdy8iv897g3yHat1gflh8arXnRTt_OURGfNg>
    <xmx:3BX3aPQTQGT0k-VDcEPnqNamz77cKFmwQRAGrmrzV0gAX4tyw6l0CQ>
    <xmx:3BX3aGuv0-ftU7ovQbz172rmEhe2dYNHwEo8Fr-Fem71ob5BoyYUYUgq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 01:10:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 5/9] xdiff: split xrecord_t.ha into line_hash and
 minimal_perfect_hash
In-Reply-To: <CAH=ZcbAjX=V_VvJsRzvQEA+CMM7dWQx6E5=d4FL5CD3s+ozjBg@mail.gmail.com>
	(Ezekiel Newren's message of "Mon, 20 Oct 2025 17:29:25 -0600")
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<a3e706ecdae51434fd5ee112c13f8cf374faf6ed.1760563101.git.gitgitgadget@gmail.com>
	<CAH=ZcbAjX=V_VvJsRzvQEA+CMM7dWQx6E5=d4FL5CD3s+ozjBg@mail.gmail.com>
Date: Mon, 20 Oct 2025 22:10:50 -0700
Message-ID: <xmqqv7k8yh45.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> I'm a bit surprised that nobody has commented on this patch. I thought
> that someone would have criticized the length of the name
> "minimal_perfect_hash" or asked me why I was splitting one field into
> two.

Sometimes there aren't enough round tuits to go around, and when
people have been too busy to review it, we see no comment, either
positive ones or negative ones.

> I don't see any reason why this patch series shouldn't move forward.

A patch series needs a positive reason to move forward;
unfortunately we cannot tell much from lack of negative comments.

