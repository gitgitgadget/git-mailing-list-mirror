Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467BC27702E
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861010; cv=none; b=R1gNVH3GpVhe0uRXyqktz4ww98ddhDsRl09md7bIEQi3bA7/YDnBvYK20MZl3B9hcrnSrzFknX18jx1Tis9UWOMhfWhRRxbbUWQ0LyPS1k0D+uswHKNbt+Ql2/p3WtWlFN9LDbO8ye7MnS+Pd85B1DR1gAkvNpCN2lko/Cn5/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861010; c=relaxed/simple;
	bh=m9R4o5XX0ebUkNQ8rKzF5PCYliY88dPl1ESJ7gOK4t0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LtQV4v4T9SFOS47utl/BK44H1kXLnkUa1k/XuslBnhJ7z3GCGsxKZCkUi4ET0YqBGyk9UaWzjpYz/fUY3X11U8KvGYR/LRdgv1dGUFE+GburCslyxuPxqn/6dItk+fPV4aGjpyDOC8qaK4V+YnY08uOSj+d2/tzSoVIMv9k+7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DXr8pYPZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2RAADCVo; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DXr8pYPZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2RAADCVo"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E7F71D00132;
	Thu, 30 Oct 2025 17:50:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 30 Oct 2025 17:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761861007; x=1761947407; bh=tVJmFGU1GA
	9vNVSNp/6bGXTeAevY1BvX8CWbLWDJi3Y=; b=DXr8pYPZspeaA1R6M7rOs/4nip
	L3eWw0XypGGvrTYQnWPSCdZ142Hy5/v7oL/cpsOkWFareCHDwkhuoehzgWS03gbc
	mjSd6XonbMA4Mn+Iq3EvLsrwHqhHgTTdDo6QKp4wrr3oMLaMhaqio6QTA8cIQ3qy
	jSTOUT7LYctXICOlVcCLc/7eVKJhzBa7b0pfHKvLRPyRZmMgmQis7uDFAqkZjbuF
	WQ/OIexqArabFTOZfV7H6Y5g9He1mUk+4EAAbJtBUmSw/ozV/PhYxM1IpbhjzN6y
	qBknBL95KiBYpQxuws9dhojHXgLnFOx3EpR9LsbPY65zCj0xw7e7kj8fkG7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761861007; x=1761947407; bh=tVJmFGU1GA9vNVSNp/6bGXTeAevY1BvX8CW
	bLWDJi3Y=; b=2RAADCVoCCNA4GxOV+TYZAzRKxq3rOVN7PYPV5chC4s5J++CNt6
	xCjJYeL+KO7xIh5mwlCpvoWfAsGIAKX6ZmNhLXtI2z0KxKf+42iawGUp+VCpl/2k
	tMYJqHry5x2ppthzUuiG5QqWk9x0Osdk3agNI70/Ow0yMtBc0o3VW5Dmd5U0o5K9
	ecu+wAYdlnXpMwxCZTUbOzgHYj1kCneKMB8s9Q2qZk9BSfvJUcF8R2GIpBhKy8Le
	sqpfheImYhRrzAr8TwgwcNq1OGZj8rSDYvh/wBba2g9kUdKxrgi6xoRgm53n7KoV
	1kjP4A2uLJ2hxjRwqSQB6Qv96ZXtklCl8MQ==
X-ME-Sender: <xms:jt0DacG3CEO4VbjBUMQ0DWtab9bSREthYMrfyjUh7tQHjSymwK42Ig>
    <xme:jt0DacOJ5j6PzCvY9-WKFdb3XsEznKnM8Z2ZMFlvx0Z3tlwFFRCpf6D_vXfrEYMs8
    HMMIo_31pz66Jda3X8P_qZDwCiYJGR5e5R4vbPtzpUPQ7MpjNoucg>
X-ME-Received: <xmr:jt0DaedsxKTZWZsE_eew2xq6h8QKktj3visEviOU8S8lUhAVXVh1_5hQa1PWEAOlbGq9GMm3kt1YJIZGBGht3CgjNNjlGut9m2dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegviigv
    khhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:jt0DaZsSD94CZVcxUvxq2xjKidnjq8IN_ToYqSLexr3yyDuHN_QoZA>
    <xmx:jt0DafnqG92I-3oOq-9n1HsL8eCgKWqwfNiKVWzMM9bFGQqTlXVhKg>
    <xmx:jt0Dabwbh8mYcV1L7QdHbW_Cu0ZpMqsC7iqRbXWQZ9Zp45kxJ52Kdg>
    <xmx:jt0DaRP_-iB8UZjj7jkd6q3ZwWv8ZZ2kNDJab7FNguD8Hd7FS5Jopw>
    <xmx:j90DaRePvh9Fw0FcZWZMXBHRuDnQoVOVXOJn6E4a5gu1p5373_9MQYRA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 17:50:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
In-Reply-To: <aQPbMZpYZJQH_Fd6@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 30 Oct 2025 21:40:01 +0000")
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
	<20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
	<CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
	<aPsepOtUf92fqDL-@pks.im>
	<CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
	<aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net>
	<xmqq8qgvfyq0.fsf@gitster.g> <aQM07BQrGJocPKea@pks.im>
	<aQPbMZpYZJQH_Fd6@fruit.crustytoothpaste.net>
Date: Thu, 30 Oct 2025 14:50:05 -0700
Message-ID: <xmqqldks3vqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> with my proposal.  I can send a patch to that effect later on.

Presumably 1.63 is older than 1.77 so we would need the single-colon
syntax in the output from build.rs in your series?

