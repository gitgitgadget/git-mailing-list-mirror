Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD37263F
	for <git@vger.kernel.org>; Thu, 15 May 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324605; cv=none; b=CrRbpxDBFW/3cGVj1Idc0xRnXQS/AVncCcWXLRYafUPpR51bN4uK4M3NGr4gPLW8pEb32Q10bojFN+Qv9RlsJ4sQkhXReT5H0SBC5m4IjeddUA2KcvedeDG6lwE4JvVqyd0ZoqX7BfUr6teCi482uDn/Qe5fvq2+1rZA4MxCeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324605; c=relaxed/simple;
	bh=WQLimCtSJs8f02OPPddw+7hqmwuYxUOofh/qjfLX0DI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ufgnzt0Rh9M4yhKzg6fPgJNQoqJJK5zsCNjGNeKn+WtfGLOyMjonMRW9W9upkDba+tQF1KjQHFZPwqgFiGovVowo0ih49IOROqxO4PDmzXTsKyriCV4dn83BLQ7Zoawm/op71UZoxMKYp25Wppujv9dRJYmR9ff9kLRLtB5GSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eadiwLI3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYpSopt4; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eadiwLI3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYpSopt4"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id A27D2114014D;
	Thu, 15 May 2025 11:56:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 15 May 2025 11:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747324600; x=1747411000; bh=8sjd2yu/td
	wnL1uKeceL1tzY+8ZnI/nwkVHsWCl92C8=; b=eadiwLI3nWUFg8GO4DS5DQGG5r
	Gc0h+ZygAFfu9IRFY61puAnuqDmZiqN6/mwdAEzDd3WxznRLfADsNfLLq/60fFC6
	Ytfr7Zzr2w7Uso9aelaJvLqKm0/4AeFZp5Qyg7UgcXiWWsB/7/w9yCM5fMBdBi78
	ccKQWT/jZxUJYfccvOewSp/D4WEKmqGeq4nYD4wJxSVnXy4l0ySJMUxmah7FxTaq
	x75oZJ+qCQr+4ZHtYljPX83MtNrImEFYZZ4yFoJQs2lJ2u+hHtVXD6y0vFgCX97z
	qgw73gk3vG6oBFv5gnQjvCjp2yCnfexeryhDlyTcXsCjMfiMQPhEUrO5q2Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747324600; x=1747411000; bh=8sjd2yu/tdwnL1uKeceL1tzY+8ZnI/nwkVH
	sWCl92C8=; b=JYpSopt45PQ7SL0SpxWiDk/m+E0LzsFmn/fbRExvM2WU1xXPw0U
	Yi/wyj2xtsrVtXIb0A6+BqHhC1i4lMCxAfLp/NUm1l1uBQ/2qcSBNrRkDFD1/pvV
	b1nidEv9Anu5hcrEW3ou7RScCe8w2N0Otaa3kNi7787/FE2ITgunJ5VLB1OWq8TH
	QKXC1Npp8P2qFUNJxFIxFwBwRBydqYiRnPw1Kr7p/iFySwxjkV5DQLq80Ba+kS6g
	T28Eio3apnGPYbQCkQRXC54jK1eEQcvd6d1TGqTOWL1W4NN5Bqhq60ZcwkHPyujQ
	0hmcuHAsQz4aycIpZPuVPqG8v+VTpMT+zyg==
X-ME-Sender: <xms:uA4maPwSaRteC-Zj0R0HiWaFdEqRcsvGw9-Nf2gGAJuGPvy970YGdA>
    <xme:uA4maHSZEWOHj84JgZmsuTC6Ug43vSdxxjMXFiwYGaZZ-T-siLYX_FJRQnnGk2acF
    q3cAw_ur2M5gU1_vQ>
X-ME-Received: <xmr:uA4maJXmrAR8UjDnYvXjZbiLQjfKbzyYF7LlRXX50ggadP84qYcY_yVVSdKfqZmrvcTMw6_l4E3bdw07fIyNMG2C6v4UHP8umk_hs9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uA4maJh3B2GnTfpkujleTT-kTv6-gibclR-N6g8OeolrJZx38nfoOA>
    <xmx:uA4maBBABFLC9iV2f5GIXeeUL61RkEkzj7-JseFSmVsZAbROMuDLZQ>
    <xmx:uA4maCJDBC08o_kusRco6c20yAtgpG7MdjBgwhDM93oUhPz2MKaBdg>
    <xmx:uA4maACzFtFaYTlXeOS4894lVDVrdVPHdwwr9NbSplliYXXQu3v7fw>
    <xmx:uA4maGBSrnM8EaHFSHe6mqTQQfJw4HzSf9KyVh1fjwY_9VjoB65LI-8T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 11:56:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: make it clearer that commit descriptions are
 just comments
In-Reply-To: <f1de4a91-2d64-457d-9272-3ccb56393825@gmail.com> (Phillip Wood's
	message of "Thu, 15 May 2025 14:02:59 +0100")
References: <pull.1923.git.1747275627422.gitgitgadget@gmail.com>
	<f1de4a91-2d64-457d-9272-3ccb56393825@gmail.com>
Date: Thu, 15 May 2025 08:56:38 -0700
Message-ID: <xmqqv7q13m15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> -		grep -v -e \# -e ^$ work >patches &&
>> +		sed -e s/#.*// work | grep -v ^$ >patches &&
>
> I think we could just use 'sed -n "!/^#/p work >patches &&" here

Or even "sed -e '/^#/d' -e '/^$/d'" ?
