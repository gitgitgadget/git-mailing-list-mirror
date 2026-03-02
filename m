Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73AE239E88
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469513; cv=none; b=ixKcTeg+prpQzgrhegjFPIMdK/ygaT5lOoIeBX3WLOPNrN4KAGrg700TBpnHJrqRFgCX2jKbw1TCkAX3BJ30kqFSKBQMDmrdBltGiPdmPdmWp5E/W3s9jMRrK/0AW1Lj3DHEiQ5D8T59+yGdx72uqDIHsFCLeGXwOCyTF27XuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469513; c=relaxed/simple;
	bh=FI3Ca+iFXgf0pZSw9iBYiapjMe4F3KcCI08LnxJn8Sg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iD0oT9KuAHJMt3hEwWnzG9HLXWntXpl9pYntTPbbQkrq8Oh+8YDsORf3R2rqIiWjIFSUC8koWGSH7Wi0Pd0ojKC1MHPnUtYas2oDK72D0HALmCciVaMGScrLqzm5FodcvxGYryi2EC7FvtN9egVu10/So34SWr41Fyl6HPWY0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NUs0ZYsP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qCfBMyne; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NUs0ZYsP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qCfBMyne"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A1951D0004E;
	Mon,  2 Mar 2026 11:38:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 11:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772469511; x=1772555911; bh=em7AhRzGpg
	TAhnuoe2axi4GAuV4O79vTAjuplGDn7jc=; b=NUs0ZYsP/b+qEVZJ5rV+xspo8A
	Q6qHTrcEatszhopB3ern+VzcgPWMYz9VdGJU/+ZN3GpFcRrtt7AmgN853KULbAkn
	HW2Vc2aVOVIDOWsAu69BRmnOe6jzvSBE4HPqxG75vIXGTVJxiokDPai6wjuSr/05
	sbqz2pyrC6ve6HywU/cSDFrF0RJAxLmuSBAaZPVI7WLiz2S4zKQP/Ikt5tnvUJO/
	w0qr0faLIgRQ5Nszw8qB9FmsJ3VXzmZhekLPw3gCP58MG4F1a8QU1eZiWlGauVNl
	nNHXm5KUELcGsTu6OwhF7R5IMoDkgaiLzUOLT5SNj8aYXV/dPzNTtrU+QIJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772469511; x=1772555911; bh=em7AhRzGpgTAhnuoe2axi4GAuV4O79vTAju
	plGDn7jc=; b=qCfBMynetgagGJCayXWtkKlUt5bkFk8Bq5BwSjLW3jfEVYciq/u
	oa/5Mnr6QaLKZWUivcWVLaQukeZvN7REz4/XEz7YHPkLtQtBRDOchrOQNqmpu6Gm
	d3Q2t9sVaG588bVUQ51Y9vimCdgfI8uBPcRFtt5yyLm3k+ZHkA9OhiAbA8xuw48A
	0WLF9gN3g0Lj4U2ljmhT1NI0X4mtjNg9pKiB0phXUw6wPUqiCMTZ075ZDVLAWWbH
	FHg6hNHQ7QW2BNWnwhH8lsQRAWGwCjwtFybVe5n1H0hEuZ36hiHL1sL7iQ5mwBM+
	/aEQ1khjd5J8faNY7y989A+M/2REUkKj12g==
X-ME-Sender: <xms:B72laXHVVi-oYm1_Y61j4luTpTPKBSSLsH4750RzNs9E6eiopgTLGg>
    <xme:B72laW5HnCCmRfrrET1FiCWFShi0mKGsLEkq39ARtSAxOu1WBtxQ_kYa06CpEskJj
    77Y10wiNZKYot944z7bdrTOXpYP-0cj413y3Zu2G2AaH5_1_-qHPA>
X-ME-Received: <xmr:B72lacwSPQ_rqCUeDLsHkUEMk6PEN3Jkrw_OU_GUGHwvwfQqepcWRib7hFsd8imUersYsE0IGTAGsbIzQvdn-5rT01d3kwLTpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkuhhmrghrrgihuhhshhhjhhgruddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopegrfedvtdehudehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    grhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgt
    phhtthhopehvrghluhhsohhuthhrihhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hushhhkhgrrhhkuhhmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:B72laVP-gKW-ZJv53oBvvGxwnGtoX3v140iY9S1BIZyxqPFCuDEWMw>
    <xmx:B72laSkLb0zo5fYDtcBA4gT_cy1CRCdgAc5hdq2UOrnh_9bZ928AuA>
    <xmx:B72laaRMvDguiTiLgJuVmElic6gV6SyrXYmDxJELNPLZeyg4SPbsug>
    <xmx:B72laRX2Pv1QTYfSG_wZlWCY5lkcG2FKZekF_YxHCtgUwqJASfUDMA>
    <xmx:B72laSeHxO-zJqshz8gBFxhtr0oFjxNZlepoBUuCy_fRo6zb62DFuSMR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 11:38:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  kumarayushjha123@gmail.com,  a3205153416@gmail.com,
  jayatheerthkulkarni2005@gmail.com,  valusoutrik@gmail.com,
  pushkarkumarsingh1970@gmail.com
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
In-Reply-To: <aaSusXil9nDHYGMR@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sun, 1 Mar 2026 21:25:05 +0000")
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
	<aaSusXil9nDHYGMR@fruit.crustytoothpaste.net>
Date: Mon, 02 Mar 2026 08:38:29 -0800
Message-ID: <xmqqbjh64262.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> With `git rev-parse`, you can change `--path-format` on the command line
> between options, so if you want both, you just request one thing, use
> `--path-format`, and then request the other.  However, that can't be
> done with `git repo` and `--path-format`.

Hmph, that is one advantage of that incremental option handling done
by "rev-parse", which often is a source of confusion and complaints,
though ;-)
