Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2929AB15
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763141120; cv=none; b=K43HXQJUAQJK59R27oTEd8BP8Ur82Z704hpormDqKga8VnFLqmTZ+YV9y23cKJgwacSGA8anl1mRkGAaVgAeasi+WxxcFBD8F4sZ+Kk92kHPjDoPrSuzTh/plufRW1vhPOeqzM6AucKxTs+SNYvszWggWiu+Y4DJPlCJtI7WdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763141120; c=relaxed/simple;
	bh=n2h/K6eRHX4ZpPdemRVr5+JBoRoqKf3Qlr6j4gt0YY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=slnlaTx2q3NYgGuI/iWQ+Ncua/cs9h/KYqwBlWW4WFvti+mORG17r4eJlyXZ7o+34N4sw0mXU1widIhrGmasDY5jfmQoV1LZJUELBVGx/vgeGZf4Wfvj1Az+TC2UX6gdsq9xD0o0vfUIOchZhywFvxFoCbi2nGQR35i3FI+19wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WopmGcbE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUCTC+kv; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WopmGcbE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUCTC+kv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D2191D00163;
	Fri, 14 Nov 2025 12:25:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 14 Nov 2025 12:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763141116; x=1763227516; bh=/gZk8dYeQJ
	NeaW1g0CFUFnxzvzhPrbLtgzczz9DyPEc=; b=WopmGcbEDumW2MitpmztfQW23v
	Hb5Y3C7/tYBKQx/56WzfpfbUzBtkSZkQdgEPq+aDbHUZGKtcWWmXW1O6mG/xM7wK
	aAXOQfTglEWUBc/XIShikYoDVs5fHjzN9hd1//rhCsq9v/RI+LzfUXmAq1/sPcKA
	LE0Ywuvm7jLWAra6MjJy2f71edSkPbFA8ba6sPitDBpL0sKUnQrav9PlmeblZg4r
	c1AJ9pP+RBY6OyeX0MBd8C2iwKSREl8mg94eSi7mC2rcM+WVTS/fnB3EgbOTRQf4
	+O1q/2KjfHaJJZDvLO+jz4nfaKM8QeW7FXj3/TpjeJRJZTFGPK4Aob2KRsrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763141116; x=1763227516; bh=/gZk8dYeQJNeaW1g0CFUFnxzvzhPrbLtgzc
	zz9DyPEc=; b=WUCTC+kvfOKnqaCEiNsWTlBndkZAa6uWrY+bLek++67hGhnNCcc
	z5WG1KwSNHoyNK8XuL/x0NjP2tiOTzNf0/48tm53CQDqOaE3Gt+xaabOaHk6WY7Y
	CBZq9IGvItBKNK9DqKvfGRJJv3+2Qo6Y7NrXOTij2Bn8M67LPElD7F9JUYYTkrYk
	EEqOmvGw+bEwNvM37qh+7WRB29jqAjlOVhYSmnz9O1dkNUUdtSiMkLcSbmdDrcqY
	+ICjMH11WuZy+CMcB2sxg9E/yvahf8dSE3ekOz/8dk1Xi/hfPY9jxBpybJLzar+Q
	baLSVn+yzfRYZOTxB3KdIqhoB3sGWLDHMFw==
X-ME-Sender: <xms:_GUXaYC0falSlhwz9JjT2Gi64DpqPrpoa25iie8iGcAtOY9KwOhs5g>
    <xme:_GUXaRbB3Zt3R9TaWUjDHZwIg-wjWhWWfxkVGeefwrB71Z2fNmId4GKU5Fu7ZwgiH
    UhO89Paa9LiSXhgQWYjfDzV9NJVIG862iqEse8T8PMwKuIVsQp8aA>
X-ME-Received: <xmr:_GUXaT6NP1CMOPmEBf0k73-xwMYCCk-NhZOJxXo9kvYBIwwTm3yRa3LMSw8UMPt7hirdDRZg5Z2xCBNxx2SQXNAri924MORLnEW_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfkgffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhieeflefgfeeuudejleegtdfhieeivdffteevfeeivdevhffghefhhedt
    hfejvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_GUXaaYBvsKsgRqPntFabe5iuxp-nHavPOym2mPcXUK1Ac4zko77yQ>
    <xmx:_GUXaaiUf05PkwmUNLSrXJCWRR6WNAQ26kkxgxBKaoXkbgR77DscEw>
    <xmx:_GUXaT-VvcqkVLDK9rtj0Ix1o41Vo5RIdy4ZzNicNts0tfcOpqoqRg>
    <xmx:_GUXadptHDX_V4nYzTsZhmwakzC624WUFRjYJJYVisoIPGnGN1hWXw>
    <xmx:_GUXaYp7z3VAFFbmdzZ5UUGq-wEVQ3NjtWgP9U8KuaQHwa1lZTBIvmiR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 12:25:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
In-Reply-To: <20251027004404.2152927-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 27 Oct 2025 00:43:50 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
Importance: high
Date: Fri, 14 Nov 2025 09:25:14 -0800
Message-ID: <xmqq7bvsjzlx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The new Rust files have adopted an approach that is slightly different
> from some of our other files and placed a license notice at the top.
> This is required because of DCO part (a): "I have the right to submit it
> under the open source license indicated in the file".  It also avoids
> ambiguity if the file is copied into a separate location (such as an LLM
> training corpus).

You may be aware of them already, but just in case, I was looking at
CI breakages and noticed that "cargo clippy" warnings added in
4b44c464 (ci: check for common Rust mistakes via Clippy, 2025-10-15)

   https://github.com/git/git/actions/runs/19346329259/job/55347554528#step:5:73

mostly seem to come from steps 12 and 13 of this series.

Thanks.
