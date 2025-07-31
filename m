Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2233993
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754006246; cv=none; b=a1QAKaKqCzOaKc8lg/435Zxd35PxrKdLKwhQpXxBAltk/dh3mvyvpz3s/Vy2WU8O2YdgLQonbuXtK7CEJ1B8uGNjtA4/i4eMg6Biwa5ZxW3INGmoBZeaQQRuEqoTkfk/pMfk2iT6dH3vtWJOZ5gwu17tl/xYN0joQLtEffG8R0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754006246; c=relaxed/simple;
	bh=QbJ4ERJDuD6LrhR/dx28jUkOTcfE7w7/fRMDL+PQP7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T5MWeYZPkLznVAUyUcym6gTdhxLPzbYqDfBGnFkE92OqwgzV57SG+SmrPFBmTK4g3G9Mf1BQ9GPNE85VueGj4iedcPxv3UobtT/j8kYl0pOd8LAgJ7XzyV6ZCUCHPJTtp8AuLS1Ce0T86trBscgpIfnE+BG/aiNcFm0bZS1uzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DsGgaGiK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C3RNMPTt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DsGgaGiK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3RNMPTt"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B9F71EC1653;
	Thu, 31 Jul 2025 19:57:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 31 Jul 2025 19:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754006242; x=1754092642; bh=qZNtnIo1tg
	rkCkt0eNJasJoGIfbHTYp4ZlWZ+f5QjIw=; b=DsGgaGiKopBHWW9KvC5uEcpM1W
	RrzK2LxyJGEgvGIOgexXsIGADFWztJvh4C4ogUCvwhtwo2Iti6jaxRkaaZHu6K0j
	tQ/mNwuPdiBHXmxlEaoXS1a/0Exxp4gwWu0bqhgQVKEpqhsRnBBd/NQ7XMqUc0Dd
	aoCeUjECFu8QZeDBVKWtCpH9ukJYphWeCbpDEmZqYqPHMoYcHZ4Sg/lRUVy2NT1W
	DSaOBky6RIENWQt1+1SIpquGBrHftGGY+A+ucmtgTMA9PYaL85kuqOaQ4SwO9tq5
	NLP4bU43JVFIEYOjdvZ1L4D6Oj18lXrIZvnI3K9NrEJaXzKwOfdxQ2HA/vig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754006242; x=1754092642; bh=qZNtnIo1tgrkCkt0eNJasJoGIfbHTYp4ZlW
	Z+f5QjIw=; b=C3RNMPTt1Lf6/4rEQX58kiG0TlEnb4O+9EaeJXsIvJWbNs6j+ny
	4+KcxLet7HcFHiMHJnw8bMvB2TlbtNMxKbjP0xTevhn+gfRbrqNk304bfL/wf3kV
	vvmDFR310PUfllLvv8ILu1/ENEdHr1mML/zXteVoGTxzPhO1Y4mMn5k6r6lfRd5M
	3L3zI34zg+dmsx19jHS4fIjuJkMYyrPe2YCpRgWeCUMV1VAfnZc5ehGDvlDb6hNO
	c2NRvV7CMk2wocp7aLGQWAjVx5Rnecznop0ki/XMS3CCFU4cQ6pD/e7ihnsmi6ME
	A9wzS8BhuV654wdI0fHBjUVAdrXpjDJ1euw==
X-ME-Sender: <xms:4QKMaI7Cwhuea5IuDuPWHhBst-bJHwLiuby_-ExoVV6AZmz2tl4f2A>
    <xme:4QKMaG0oLd-K_jYLnn5-VuAFH_nsZC--6bwKg0VkteAA1KMxJ_ROz-60Blp70M3DP
    -AjzTSdMdCUUnmktg>
X-ME-Received: <xmr:4QKMaDFC8dfghABBTyslUJkporW9YSza_qa0zp1fZndote7XqyndCmVN4SmiYgkOmuxZgnP9oQP1MolgYnDSshbQiS3LncLtr-BqJP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepjeekueejgeetveejteegieelueejieejfeeugeeiteeitdelffdvffehieeh
    udefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4QKMaFjDm14fEhjkckjcM3yYVs8XUUvqrrDDRxS44mhMHcPlrQK3uQ>
    <xmx:4QKMaGA6q39oyVHWH1xtkXi1oXdQFL8LKSzFRlsk574E27F0fAtlOQ>
    <xmx:4QKMaHRrncV7Oj_SmD2MnKA9TlwaMMpIkNoS0pl75U4wnaBVZNB_Cg>
    <xmx:4QKMaLXYNGyODQIHI-me-YbaXYc1W5W2OCmtYxVdP6HD91b7EV3sPg>
    <xmx:4gKMaHnT2nq9eEI-lfliDWak0H6_IaY2rbbW5E2up8yymsp4DQQ7COpx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 19:57:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Derrick Stolee <stolee@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6 0/4] Introduce git-last-modified(1) command
In-Reply-To: <xmqq1ppwryoy.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	31 Jul 2025 11:40:29 -0700")
References: <20250716133206.1787549-1-toon@iotcl.com>
	<20250730175510.987383-1-toon@iotcl.com> <xmqq1ppwryoy.fsf@gitster.g>
Date: Thu, 31 Jul 2025 16:57:20 -0700
Message-ID: <xmqqpldfoqvz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> Changes in v6:
>> - Only the first 3 patches are kept. The last 3 patches worked toward adding an
>>   extra option `--format`. The way it was implemented was heavily debatable and
>>   in the end it is not required for a first iteration, so they are dropped.
>
> OK.
>
>> - Function prepare_commit_graph() is exported and used in
>>   generation_numbers_enabled().
>
> OK.
>
>> - Since the library layer was removed and all the code was moved into the
>>   builtin, there was still some leftovers from using a callback mechanism to
>>   display the results. This is removed (as far as possible) and instead
>>   last_modified_emit() always, this function was called show_entry() previously.
>
> OK.
>
>> - Code is rebased to use refactoring in the bloom filter API.
>
> Ah, bloom_key_fill() and bloom_key_clear(); sorry to see you become
> a victim of an unfortunate churn X-<, but hopefully it is for
> greater good in the longer term.
>
> Will queue.  Thanks.

CI runs without and with this topic in 'seen'

(without this topic)
https://github.com/git/git/actions/runs/16661801008

(with this topic)
https://github.com/git/git/actions/runs/16662408099

The difference in trees of these two runs match what is in this
topic and nothing else.

