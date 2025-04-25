Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E421A42F
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607069; cv=none; b=u5Dk/c6dXeIbvv5aLu8EAqopYQXfGtYuDQ/TNizGZOA4gXfskm7yVqAI33l/BBC3EvRFcaL1ddLOW6f8W37O4dCFMHyUWekzondUbx/TuarmBxbIyj/ik6N9fAd9MXrkZcFGLQA1pJQAUPPZwTXwzrYovl3LBjjJc2+0rrSI6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607069; c=relaxed/simple;
	bh=NeG18v4nFinYoUdzgbIHEQ4FIDuwrg6iXtw4mlGpLl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWbGyiqo38uY7eF7Bdkxm0BnliuI3NvHkifcP2/9u0b7cAX+gIyedMeM8BaO4RnRTDQ80AdZRlMd8wMrKuT8+l26jbirQKOlBETuBHD9GX9y8qKfVNFe7r63GbSyCOVJuRCfdYo8ult2h2Tiv0Rqo7sXK6/s63ImJQp77qHomtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fBQISbvo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K563GSjt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fBQISbvo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K563GSjt"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C41811401C4;
	Fri, 25 Apr 2025 14:51:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 25 Apr 2025 14:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745607065; x=1745693465; bh=Xv3JsY8Sip
	3njTkvVhVpiixgGVFXit0YpuABL9/UraM=; b=fBQISbvoY4x69+abHbOWCJkRQt
	QJDa4FL42JXA8TjtAe3+WXKd2eylal5ar8MXxvWc0dvxtcDsWEq9lZfgLw6xVPfy
	44MH/MppxvQw1Xcrj0LDCUt8AHWvXs1jL7kjR/90embHsLY2+LOxpb2KeA5w+I+D
	FT6M7R9+RVTaAMyyeqJFHrAuu0Qsvm6bts1pH6l9dDZP/lXAUTc7KfXi45gW5Tp8
	DP5K7psfvmOYjR1ZfQrfQhDZ7cf4lwgY625DEIty/ck8wjF3IJXyW7lWbtTNktlu
	95M5AclsK9H4W3RVTxDqc94bsn3BJ25BV+7Z3nwGPnzWETtBckvWOEDajitQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745607065; x=1745693465; bh=Xv3JsY8Sip3njTkvVhVpiixgGVFXit0YpuA
	BL9/UraM=; b=K563GSjtqRBPAEalTGsS/TnNHY7bKA0KyUmWJpu2Pgy7oqdJNfH
	7RUXkbzvT1vG8A3z8OwzqRM8UNCZQw5qpIHLhLuRnd4ps2D/KVR0uVw5OIQyfWVJ
	RcO5aDPvJxOKU9jU9ujrsT+INvNrPAS2dZFl5NNRd4f1ujn0/QCsvqBZGb5igoei
	ey9KaVp9nYaWP013YW8tIgRMkPapw5XRr9WjKd/0Wdo+G3KjZzLPOooD9KWLml9b
	+d8+KWuSrrYNfwiPYwjSogbyfdTGHdOeMljXHntRc+XrqTXVgbpu7VFVjXUN0/8R
	G92JWsJ4a5FJ5BSisT+qLTY/a937PX/OYOw==
X-ME-Sender: <xms:mNkLaHAovdgj5zZOqVa8rJQ67we-dbjwAviivwDO6kj4cEQlAqYd2g>
    <xme:mNkLaNjzFOolGB5CoOyyBUliaPDqWADu5MO8QqQSzFEhQJ_P9BqbGH_R2L2O25QvB
    QRDbQusdPA5zLMlxQ>
X-ME-Received: <xmr:mNkLaCk7gJDxd6HgrrENE-cEAn8ICd4C_pgjbXEqT9O4eSwjeovl3hX4i3gbtK6yrQ1MOHHcMHdrdBaslioRzt5y5wwsmkyv7ekh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsrdhrvg
    hpohhrthesghhmgidrnhgvthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mNkLaJxybxh5mBl5r_jSvY1tbXhjbBU2npVMzj4_i0O7JEsqP2THMw>
    <xmx:mNkLaMS4f7RaxAqzcm0I_hLkHhVuVa1HglQ1wDciza_Nt_40V6ZEmA>
    <xmx:mNkLaMZf-GdwZjYruiJ0-G5CeanOIb906zHG7LyD8HG3yRrQMpqrFA>
    <xmx:mNkLaNQ88ts24fWp1WqNoRTJv84uZm-vMjwuSKlhXq8J0dZc4CZlVw>
    <xmx:mdkLaLbpXxtGsj1V_tO4r67Xfjp3WI5ScZAVTVffisFdmJavxJ0Fd8Ff>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 14:51:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Peter Seiderer
 <ps.report@gmx.net>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
In-Reply-To: <06e57780-9f59-4166-81d3-9cd0c1c66b7e@gentoo.org> (Eli Schwartz's
	message of "Fri, 25 Apr 2025 14:07:18 -0400")
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
	<20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
	<xmqqy0votbns.fsf@gitster.g>
	<06e57780-9f59-4166-81d3-9cd0c1c66b7e@gentoo.org>
Date: Fri, 25 Apr 2025 11:51:02 -0700
Message-ID: <xmqqcyd0t6qx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eli Schwartz <eschwartz@gentoo.org> writes:

> On 4/25/25 1:04 PM, Junio C Hamano wrote:
>> Now I am showing my ignorance, but does this support folks whose
>> shell are not spelled "sh" (like "/usr/local/bin/dash"), and more
>> importantly, if it does not, shouldn't we be using a mechanism that
>> does?  I think -Dsane_tool_path=/usr/local/bin would help with the
>> leading directory path, but I suspect that find_program() does not
>> help specifying "dash" to be used as our target_shell (or host
>> shell), or "perl5" as our perl.
>> 
>> Of course, this "my sh is called dash" can be left totally outside
>> of the topic of these two patches.
>
>
> POSIX does not require a specific absolute file path for "sh", but it
> does mandate that you have a shell and its name is "sh", whichever
> directory it may be found in.
> ...
> There is (most of the time) not actually a program called "sh". Various
> different programs may provide a symlink "sh", pointing to their own shell:

Exactly.  And with many systems being personal these days, /bin/sh
may point at a shell that is better for interactive use (like
"bash"), while the user may prefer another (like "dash") scripted
use that is not pointed by that single /bin/sh symbolic link.

In any case, we live in real world where things are not strictly
POSIX.  Our Makefile does support with SHELL_PATH "sh", "dash", and
"bash" just fine.  Why shouldn't I wish for feature parity in a new
build framework that aims to at least compete and become an
alternative?

