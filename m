Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFCC3064B2
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663314; cv=none; b=rlY4ONyFzvnil0irjwnPAWXvUc+6uUSmVRVEpmkhKyMXTsGWoAQPc6Fx4Gg2dL5tmKVobGE2u86hr6WT22wYGVd2imtquQiR7FpfvfJZF+oPdpqn2zeWBc0PrxlW5icT22WWE5BdBjUIH8ADMvxH2CHagzzyxzN5/Vt4fVBnXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663314; c=relaxed/simple;
	bh=U04SS7iMGIp6xz6lDyJOu/2mxKOg+O525iV+Bta6EZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=coaN9Re2g57eT9qFaOyyiDP1C7ibZYe/NGZGFlFNPTi7XY2gbkb9mD/cVjqWy8bTmT7M14VtyuPngJoJZAfDzdfU4o6N/U9J1ND7xdy0hXO/wOTQ69vxisNjer8wQmSRfnJD16SFNc7zkSEZ6rmukt5HuCpCU97ks+ax+daulBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jzcdwQPN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vYY5cP+g; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jzcdwQPN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vYY5cP+g"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 438F7EC0402;
	Tue,  2 Dec 2025 03:15:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 02 Dec 2025 03:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764663311; x=1764749711; bh=JaZkER4Z9I
	B51jHjX5zEr7JjVcBHCYBTmyf960VP8Gs=; b=jzcdwQPNkxHjmWdFqg3vSkAuSb
	gqvnJKRhhwKtB1dZMB1KLrdmiUdmkKuKDI5VpPNkdeoYgZIP9geo38Cb7x9XUzd8
	i72d400qZ0Ap52McZhYSXz4p3TSDvKREI8yh8at6CTAmwvC1oYdMz/MCEgbRwK2H
	9BZPhhtGWBocos/LhLzF7D+ziq6MYJO3XNTKFZ9EdeSiMfdAz3BYlyG/1jNj3+13
	L37Q+f5LiJJmqz60WZniNIhlGFqyX0B3NMr8ck3SJjCUXb7nxiXY2ewq0kRODn0F
	xnw5jALNCn6FJCBzzZ+qzHZVOFlcUNDVcJQnwKmJu7ckfadX+NyNRM3cw+9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764663311; x=1764749711; bh=JaZkER4Z9IB51jHjX5zEr7JjVcBHCYBTmyf
	960VP8Gs=; b=vYY5cP+gP+MR5voDf6AV8CJuHshOnSqbtRb8AW9rZPO/+oq5rio
	K25p+D0ZypCK568ZijGqA0rmk1X0ofcQQykmffEt/JAxoTJRa6lcjamQGa/H1dZp
	Vrg1R+U0JDxeRXiO+onGrP+bPTm29i5FBH6X5HNjmuhwWDGQejgGn/KHhDS1HJo/
	cgIr4Y4aTLT9T/2ALsVnlEw+3ypl5nGE3JkhvxR6OQrmPU5qKzwhncZKcn9No2z+
	VCupOQNCuSOxu7hIWfaTbJ6LaV6UvhBB9Z+YwX918CJeORNgJhEwTrPb+hmcXtq1
	uN/N54Fp0ifJTan8KMEtmddOsVKEmP8XO/g==
X-ME-Sender: <xms:D6AuaR0qfcsCnfLL8jbib2A9w0iTzepYTdzlb3LxaRwbhO6x93e-aA>
    <xme:D6AuafG8C3Q0Tgst1LTOCn1YXZnrCe3WO5BQDeRnjEGUgdIuD2xzmHQYnVNtKlslk
    bP1LIJq1LPwJ1Okw3EwkE_5GzIoZ4wXHiPXngWIv1LQQrwPEzng>
X-ME-Received: <xmr:D6AuaW4G1o4sOtN15vjKmZYLll43KI0ksb_LTgJ740Ui2JV2YNDl-hPvOCIufER7WP0iM1NO3peiuqsA5dYpCU4PRV-1qo_kFqkD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:D6Auadueb0XuYmfoHZSe-zf4JzvUY8tj5z3SJoZ1lSpE_gUxSC814w>
    <xmx:D6Auaf6aZOJlfL7crG0dwx6JA5hllaqn_Y8jfLdR_WjtLb1rd2Iuxw>
    <xmx:D6AuaQWA1DxEjXOlrYtKotS3s4B5kANOch5UsqDH5e1N078-exh-6Q>
    <xmx:D6AuaZ8TBrRvtBdtjfnqa64O2mc8ESB2MyDAcSmYgQAR9AKTz9Y8gA>
    <xmx:D6AuaUSyv-tjmOZI4qr2PpOZckvYT7KzCu6CqihkiGJHwbSd0LWyI5R7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 03:15:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 04/10] t0001: handle `diff --no-index` gracefully
In-Reply-To: <07dd2e66-7cdc-7839-aaf7-274b116df51c@gmx.de> (Johannes
	Schindelin's message of "Mon, 1 Dec 2025 14:20:28 +0100 (CET)")
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<3be9594e80c37b2b393f5883a173694ab6793813.1764440906.git.gitgitgadget@gmail.com>
	<xmqqms44cb7p.fsf@gitster.g>
	<07dd2e66-7cdc-7839-aaf7-274b116df51c@gmx.de>
Date: Tue, 02 Dec 2025 00:15:09 -0800
Message-ID: <xmqqbjkh8fle.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	case "$GIT_TEST_CMP" in
>> > +	# git diff --no-index does not resolve symlinks
>> > +	*--no-index*) cmp expected newdir/.git ;;
>> > +	*) test_cmp expected newdir/.git ;;
>> > +	esac &&
>> 
>> perhaps?
>
> Sure. It's not like this adds much confidence, though, as the tested-for
> functionality isn't specific to Windows, so I'd expect this to fail on
> Linux, too, if it was broken, and running that comparison on Windows does
> not add much.

It sounds like you are saying running tests on Windows on most of
the platform neutral Git code is waste of resources, and looking at
the number of shareded tests used in CI, it might not be a bad idea
if we can cleanly separate the Git functionality into two categories
(i.e., those that must behave identically on all platforms and
others) and shuffle our tests around to let platforms that runs our
tests slower only the "other" tests, while the faster platform to
run all of them.  But I am not sure if that approach is a practical.

> Since you spent time on this, I will change it, though.

The time I spent does not matter as much as the time other folks
will spend scratching their heads reading the code left by this
patch.  I will be mostly offline this week, so please take your
time.

Thanks.

