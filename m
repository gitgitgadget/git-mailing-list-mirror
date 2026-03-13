Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BD331E853
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424485; cv=none; b=DonngrrrA6fSGqE7OF2pH7wVjUQTlbLhK7WLeKCwwYfBw5CQbDde0Qdklpvkw1tqcYHL5ktwKb3OHpMRMBfv++TJHmzBKWlOnH2I/IcK2kflunq/o7BihSS4QvJW2OUNcW2vHpSUuwxs2sKrF+20OTu6iva/SFi5WJFLgzCATJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424485; c=relaxed/simple;
	bh=zWRjjaPMgPSqjHygad8g+TAW0DtJn54qum+vdMpXRJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aiaCqq7+KdZE6GakQH3fNNg8Ml8go56lCZzOQJdqxEMWXE6pfeU1uywfxUoy+SGMC/apOXcOtMbaM2T/o7lBLgNeUbo7vteJ4G0/aiEmsK1pcrQD0lRm/uFTr7BV7JeZEFTA51jzbvLm2mvkTU1/nHKhC6rXK+E40s51p+Pgj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ND6IPNMc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fqwpALYC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ND6IPNMc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqwpALYC"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 91194EC0389;
	Fri, 13 Mar 2026 13:54:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 13 Mar 2026 13:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773424483;
	 x=1773510883; bh=wXYEYomYBj0jLdEGxf5OvPAMRzONAnOYobBnmIs7BaI=; b=
	ND6IPNMcXq/m1H6dNwqgkxhervIcOWyh7vHXEWIrhqs7fffMQ7JnqvzQBFN9hBiF
	yy87Mb/dlG3Qj+zn/tvU+Mo+OYcxnwFGZ85/XacknNJaKWgcZAzXwFMDZ8fF5egZ
	xLe7Uh0B4SfiopulWDbEp4L8TiG+5K1Pjf/8oKAT0Egre9MynyYtkbsc4bJB4N1T
	DYOao4pZEdNqhoGJUoc8nCIazbvAoDb/KsKgOdda3oBjzEUU6IyTHDa1zC/KdkUA
	flJ0ZwsJ4e9YZw/qKgb8pq2RbyDaOpmtrKyJ2tvJblAAa4Zu6H4CCZfL+m3L7vgG
	DXCwBj9dOkECTMuUJFa21g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773424483; x=
	1773510883; bh=wXYEYomYBj0jLdEGxf5OvPAMRzONAnOYobBnmIs7BaI=; b=f
	qwpALYCYw5TvoxcPSQmTS3lvHr3Y3eLfwi/fIF0Q/xUEGqo8XdvM2mOn+wSf+FuM
	lXMRN5ZMX8t7cxFm8rKFB0QBd5xT6QmvSvXtc1hrAk8SnrvCNH/0kXagtn43lq3J
	BTSzckzx4guzaz3BbIu4jQuae10EBxcaNi6y7C0H2Nh7xcUHn1dTSKIxtBc3bO2B
	zg0WBu3c4JG9gGS4Ji3VQ1xkNv6R2CBi6bydqgEbz/EqYfw8HGcGXAwfFUGxr2vV
	y7rcf3Zz2cWfhoNFSgMdyX/x94uz7GSDVH2ZrAVjAEEZETnC2IEHCDdIDZ1REpY+
	vbXTqEhJI6XvN8p4xhlTA==
X-ME-Sender: <xms:Yk-0aVa8hkyWxcvbZnfmJh7HBrjdIeQEu_KAfs7TIVBmpZFNslnQmA>
    <xme:Yk-0adHiimQAZrsjVI8Re1zmIzJ25kQeii0SiBy0Yf8g8C464LMWz3rvDlOauAsyk
    N97XVKozultvQXNjw_kz4VrvR4Z6PZFe_JSB-Y5OUa66CtC8W63m5Q>
X-ME-Received: <xmr:Yk-0aWItSzWVF9E57_4VYNt1DtGVX8Ba8rvjd6w6nQQhk3-k1e1WykSCF7Ko1BoKJRMspK7bNWDEdmpVWU7lgMFmp_tzNtaHmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Yk-0aYO-bWCzjvpz1qy23v4ZCCZc_FpjRWq4UXF1L5yHetpbn3m2iQ>
    <xmx:Yk-0aWkrglYskpIqgYqOHN-t1lAT_96nK_tclGVK7T-tD7QPJ6p9eQ>
    <xmx:Yk-0ac7MoWngfeZtwwQcgzeanrq2jYQmZPc8ztjIEtqDvZrMUdvdtw>
    <xmx:Yk-0aa0FWl2938c1j0bbdBSNVb8Wp8plt7s0X8AO_sX_0mbaExhZkA>
    <xmx:Y0-0abEuiLjG9bpd89hsHvUOZpf34XUplp5Zic-sb0qxjr4mfuQMrWYN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 13:54:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  karthik.188@gmail.com,  phillip.wood@dunelm.org.uk,  jltobler@gmail.com
Subject: Re: [PATCH v1] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <4fb9c915-7246-4c55-b7c6-b4ef7ca91230@malon.dev> (Tian Yuchen's
	message of "Sat, 14 Mar 2026 01:15:23 +0800")
References: <20260311181704.958509-1-cat@malon.dev> <abJjYNq_sxeH8yLQ@pks.im>
	<af2c4ae3-c273-40ba-bbca-cbbf687b1b91@malon.dev>
	<xmqqpl577m3y.fsf@gitster.g>
	<4fb9c915-7246-4c55-b7c6-b4ef7ca91230@malon.dev>
Date: Fri, 13 Mar 2026 10:54:41 -0700
Message-ID: <xmqqzf4b4ntq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tian Yuchen <cat@malon.dev> writes:

> On 3/14/26 00:03, Junio C Hamano wrote:
>
>> There is one corner case; upon "git foo -h", your cmd_foo() will get
>> repo==NULL when the command is run outside a repository.  As long as
>> your cmd_foo() asks parse_options() to react to "-h" (which gives
>> the help message and then exits) before it uses repo assuming it
>> cannot be NULL, you are safe.
>
> I was completely blown away Σ( ° △ °)
>
> Thanks for pointing that out. Otherwise, I wouldn’t have been able to 
> figure it out no matter how hard I try.
>
> I just took a quick look at the code:
>
>> 	const struct option option[] = {
>> 		OPT_BOOL('z', NULL, &nul_term_line, N_("input is NUL terminated")),
>> 		OPT_SET_INT( 0 , "missing", &allow_missing, N_("allow missing objects"), 1),
>> 		OPT_SET_INT( 0 , "batch", &is_batch_mode, N_("allow creation of more than one tree"), 1),
>> 		OPT_END()
>> 	};
>> 
>> 	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
>> 	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
>> 
>> 	while (!got_eof) {
>> 		while (1) { ...
>
> I think if there's a '-h' parameter, it gets intercepted in 
> parse_options() and the process exits before repo is called. So there’s 
> nothing to worry about, right?

Correct.  The function calls parse_options() before it looks at "repo".

> By the way, I find it a bit confusing that the'`-h' parameter — which is 
> solely used for documentation query — is parsed and intercepted within a 
> function that handles actual business logic.

I strongly disagree your idea that 'z' is more business logic than
'h' is.  Both are equally relevant.
