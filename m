Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC93115A2
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626154; cv=none; b=D7aSR7bT8ZIKol7bQ2Xv6MaUEIhiCNB6DQ5k6I8YPzL1zZAkEUJxMOR1kANS1yp66RyZJlBr5YR9acW/cn5cV2uIf83amLrE9F7Blk8u1fsQulzV6+XY1hFqbMpZjnsOQF5nnUYMU3mrp5pRPYR039H5zZ2ijJiVczFiYwqZmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626154; c=relaxed/simple;
	bh=8oA+hEoubDlMQJ9vPgqcYbmNGwK8QIvtOwXFj1HYtfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8JEjGRZxJDxKvMccSPIeIG5rEIIqAgtmUaAmKsFxz4JVdZ1XcZEQOVK1VYrscUc1KlKIQ+Ry+qsXQVdrgqHtcrdRtG1I4Hyt/Mn5h8AFgQ4g0vkJB1JydKOXk8xgzxVjgovBnj0P0ntz6LynQBkJ317aQetzuRcU7AaBkkyl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bZ7t/dzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tZMwx4H2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bZ7t/dzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZMwx4H2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AF1D7A0158;
	Mon,  9 Feb 2026 03:35:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 03:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770626153;
	 x=1770712553; bh=Ne8lu/CB+uJBPneJSwpavj7zBOpr96uhTFZUq6YESgQ=; b=
	bZ7t/dzc+vMJYvOMIdajHTBeH9aPy/HfR7w6Fd5WCdEaojfkhURQovyMHr+yPHto
	CzRyl2FgmmwgZEVQEZWYhjFC1Me/CiB9LYHm4sv3A1V/w25WiLL8NQyZUuYBZSkO
	ZtXVtw7gEMtAyBcna/dIyw8MgE6jRufRKULP8b+V7bt99SUSEqygPjFk9xHjEING
	dSMkdW5ULXrB5pkzJsAi2OXYt2rCfG/eQB/45HcjoM1yn8IVLl9YwWDF900ZDEjf
	40QEOevsKws6FGFRmU8AyFnEfcNLrXrzE6ohqQKEauoNIT0YCpIBCuIEdKoen8Nj
	ZCjimvBtNcYF9pvWrpfuQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770626153; x=
	1770712553; bh=Ne8lu/CB+uJBPneJSwpavj7zBOpr96uhTFZUq6YESgQ=; b=t
	ZMwx4H23W2BvmrocYRuCQ6lhDkgGwwefi6q3mUy4HRbiQnpdf7uDeDM+H648+tX+
	UyuSv/roUcN7NQlXAcuebGYzicAi+acRpzi1PSZUl+S/xEBM3atsUGr0cm7FOhG5
	FF+o2ic74+tWvifBgo1Thk2tbjQjdZXcsWEuRmTuOhMLsuxQpp5wJqXCsTFhHJ0F
	k70AoWjyPOraLYs1K1tEqcawrQcrsMbOvXVdhiXM1y0q21esLQQs5FGq+o4mnsJN
	c3EWDRs5RQTMqioRTHh8i5P0xTgJ+6FNInsG/g5hre4U/KQq+Dt4k8gZYcVebIgS
	ofx4Ia5Jm8OE8HsGK/iJg==
X-ME-Sender: <xms:aZyJaa36WmUS3YXJjV_jPJ1b-toLuVNTY40xzLTlP2E2UxThgnDLIg>
    <xme:aZyJaUHqnmWRh4jB26MzZaJaL1YA3MFY-_3UT_VYf1asogTARGNNb5dgAKuTqAcj1
    W0LOkYevE-rrQfBom_cU5ta8ijffAoFsFigayPborM0uda1V4xYJQ>
X-ME-Received: <xmr:aZyJaX4x9soUUGHN_odSzom-rAkwtvIfSuu4eIo4kVwsr2sjaIANHX73UjbLiZV5RP_jOoBDmPzC9n8iPH-MXjmEUkczqd6DwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegskhhkrghrrggtrgihsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aZyJaatUkljKw9p6JEx9hA58xEg6cnWGtTXgiwXIXGnDepGh0YoipQ>
    <xmx:aZyJaY7kRDNnw75Pm9PiAHzvaTWvoKw9jFKEolPTqTXINKx0-K8Xwg>
    <xmx:aZyJaVUyK99Ztlc9L_x3P9A7YRnR_yerYGEMIdRSbhRIm2feIX42PA>
    <xmx:aZyJaa_f43hs5uCe1HS1pHNWyCuXOeAuThq37Ha-dYZtzu7l_lo5OQ>
    <xmx:aZyJaTbheMgJ_5O8JFTWr9RXe25ILF6MtkXeeizSCKbrJOq0yhHbsMz4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 03:35:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [GSOC PATCH] t2003: modernize test path helpers
In-Reply-To: <20260208202809.270523-1-bkkaracay@gmail.com> ("Burak Kaan
	=?utf-8?Q?Kara=C3=A7ay=22's?= message of "Sun, 8 Feb 2026 23:28:09 +0300")
References: <20260208202809.270523-1-bkkaracay@gmail.com>
Date: Mon, 09 Feb 2026 00:35:51 -0800
Message-ID: <xmqqqzqu71qw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Burak Kaan Karaçay <bkkaracay@gmail.com> writes:

> Subject: Re: [GSOC PATCH] t2003: modernize test path helpers

What we see in the patch are more uses of test path helpers, and
nothing in these path helpers are changed at all.

    Subject: t2003: modernize path existence checks using test helpers

or something like that, perhaps.

> -	test ! -h path1 && test -d path1 &&
> -	test -f path1/file1 && test ! -f path2/file1
> +	test_path_is_dir_not_symlink path1 &&
> +	test_path_is_file path1/file1 && test_path_is_missing path2/file1

The above is a faithful rewrite, but as a separate patch to
follow-up this file, the last line should be split into two, having
one command on each line.

All changes in this patch looked good.  Will queue.

Thanks.
