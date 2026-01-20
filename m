Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB0354AC3
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941721; cv=none; b=D4GXM06Zn1tzjb0lqwFvcyTJ5NZkXDCPfzU0uzwyUn6wHUvrgeJrUvVtuF8dMR9+2uhGIp/QyEmpnBRa4g93RG1Q4Nfpaa7A/xwVvbqLh5pDcc0831OQSIBcxnYqFeQpNSWwcyIXl17M46FTLZJ6QJcQVGqjFvMIPuKF+/xuW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941721; c=relaxed/simple;
	bh=o0/4z642Ca+eeewBG+eJpbzONekHXC8bfmjMZR1IdtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q5VLbSWJ9c+QMsxLFBUXHfzpIDYxe07+9DI8YI5D8kBnNwyqVvb6Kyq/8bVSYeNjKsXrv+Pw+8273Nrosc326ozN9KkKJndw2rNL7lcSppzlanhsU1qaQHaIm3tIZ2X0qrwwTzhX5vS9eOoN7jCgQ5xIVHHPOvBADcN28JetQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XOFEThgz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AnZtWItW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XOFEThgz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AnZtWItW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E3B041D00063;
	Tue, 20 Jan 2026 15:41:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 15:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768941717; x=1769028117; bh=kbs8CbbnZL
	V7714BtThMDTZq0b6go7jW9aOE4QDtz5k=; b=XOFEThgzZsmGgBYDbNeG72VUeM
	BhupOTYKDmzWyEwsZpNI0/gYRTfRB3hPjbo/OOhwgZq70nzGRKNbC6XExbIGIWYD
	Dwpa2McawFkQq46qkEyOgamwC4Rk7+ELsgjJ1qPFxkaYBP8s4/aZkJnoIDYGP4Ax
	X2+54JxrNLMOaL+BGKn9VuzhyDRyg6cGVQJh01HaNxtdr5/P3FjGkPLYrDjTxosJ
	4MB0H92iz9ladidvmXEMOLxfMcJy+9slApVRrcpuY+m7PHk47oBE10sVPDpRjIRV
	bOinSjO1LJGzANE2RbBv1Pwf1fbGwMxklE1WlLLIQmPnh+A9MLeinnhG0v9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768941717; x=1769028117; bh=kbs8CbbnZLV7714BtThMDTZq0b6go7jW9aO
	E4QDtz5k=; b=AnZtWItWhEos2LAExJ4oG5X6ufXzYQQcOxtKOJ43vmFt2TDIzlA
	0NfVAQlj+VXNe7AqF7s3u2WGJxp9KJPwr0oyooV3B6jYugfl958TmLiy/r1iveFk
	Qw4Rc5y6MX5tvrflfSHQrTjvcxczRflk6oA6lEGuQQmgSp0Ifm10kArkxuvMoLsT
	Y9g2azI+MkNvWdS5JENPZwAWUxtvnRMKeH8bjH0gSSvMRrd3SjLQDUdDF1QvJ350
	RP7OEwkJ/dv4NM6z92Wjwkg3zdIEaaQHEJknpGXGpGK+VITH+CKVkn8JzbOrz4ce
	H8UHzpUoIS6TVSuJNjzBV9f3Cwyb+CRsR1w==
X-ME-Sender: <xms:lehvadtb4yJKkrnR7ZJPOzu6gwwBdsr9Fp0i7WqvwOK_-s1v1n_BWQ>
    <xme:lehvaQf8ISz41xljUt3ZBKgw1uPdRWuSVh-yzPeSR7LzMiQlbYikDW0xZ07NHlpVp
    T_tV4pdsznGReOS_Dh8_jS3955TChsB2fcwB1GY02DOw8udL99AeOo>
X-ME-Received: <xmr:lehvaXYnmeOE82dK1a5WU8i7EI-WyallzoMNGCYC3W-N0cM8nTqGbfX-uirm3viF6yRDtVL3Txd5raZ4K7dbSArb88cFnwjpq7DHVXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvg
    hlihhlrghhfihusehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghl
    ihhlrghhfihusehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhi
    nhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lehvaSbPKRe1yUpW4lRv9cZkI7h_oLesgWTmgFQkpe9NuOR3sxE3Gg>
    <xmx:lehvacKntNqws2uMXBw3ERv92F-kC-7R758FhAtIWnnLeazvaxuN-w>
    <xmx:lehvaeuZL4MenaTrbyMdXQqUv8TtlvdnBRK5Yvz73YMj51J2K8HCPg>
    <xmx:lehvaQWAT9XVhKktweMgvHXUoJayM4KRBXMQ_uJDvL9XLME_oVVEWA>
    <xmx:lehvacpjxhIvB3rh7XDa_HifECJvM49TELjOqMwrNjVkb1e8AKTc3Jsn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 15:41:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  Delilah Ashley Wu <delilahwu@microsoft.com>,
  Derrick Stolee <stolee@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH/RFC 0/4] config: read both home and xdg files for --global
In-Reply-To: <20251122013659.GA3947@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	(Delilah Ashley Wu's message of "Fri, 21 Nov 2025 17:36:59 -0800")
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
	<46aa7034-b186-4adc-ad0f-8c7a4d799687@app.fastmail.com>
	<20251122013659.GA3947@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date: Tue, 20 Jan 2026 12:41:54 -0800
Message-ID: <xmqq1pjkyq25.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Delilah Ashley Wu <delilahwu@linux.microsoft.com> writes:

> On Fri, Oct 10, 2025 at 03:27:24AM +0200, Kristoffer Haugsbakk wrote:
>> On Fri, Oct 10, 2025, at 03:14, Delilah Ashley Wu via GitGitGadget wrote:
>> > As reported in [1]: `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config` are
>> > both valid global config locations, but `git config list --global` only
>> > includes the former in its output.
>> 
>> Note only if both files exist.
>
> Thanks for the clarification, I'll be sure to note this in my v2 cover
> letter and commit messages.

After this and [*] the discussion stopped and the topic has been
dormant since then for full two months.  I'd drop the topic from
'seen' soonish but that does not mean an improved version of this
patch is unwelcome.

Thanks.


[References]
 * https://lore.kernel.org/git/20251122020047.GB3947@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/
