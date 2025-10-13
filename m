Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC424EAB1
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385249; cv=none; b=QUUr6IwcEVTWh66VVDYFz54Pkhwh+hBH6Ax4AdBWVEQSXWbMIwvKGMwvSLpSLEwxqUtAS3XawiQHpWwPtyzcJc7zkNQdkwKV78ETIEElvHxddwgdNXdHEdWgeWF6JatVJGN0ZHKj7h/8Fo3xxeK7X5kklLotCbV/qWonCcywv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385249; c=relaxed/simple;
	bh=Valt6gdboQwUrzoflYFM5SeXxf9zVg16zLAvmzaq2KM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CISZbiBMeBDU4i+EQQ9uqHCZLLXEvF10yR4C0H8XfwCb/I7sPrqXYhA+Cf4PQfp8S5zdVaoplFLg4lwhdhd1GIA25EkcpKbj/uBgXs9sKri9dOcd0d5Fiyysnze3FV5nV14S70cEvARBFM7yQGZSiGZ6Tb1Mmfi7Qv5hsYN9on4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Eual16ww; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTelT/V0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eual16ww";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTelT/V0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 575327A0491;
	Mon, 13 Oct 2025 15:54:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 13 Oct 2025 15:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760385246; x=1760471646; bh=8nT6Xl3gyc
	ORnbHP21wUpONtePjaQl//YEhdAuyAFFE=; b=Eual16wwPBCHfZWvqV12Dl/gw+
	qknJ4pIjkj8tGemIrECWTQnNSbeq/wWF7MfWR7bXm/h3pKOnVGIb+upkyMtzz/RD
	I2I52O84RBNo5f/6jTWwo+LTvVPU7pkm8oFimHV81rPsOgEm2KLVAXiswYgEpRdo
	0ry8WxxPHBFQgjVshb3rF3XnHKdghwgPHmcmaPlwMlLAuWd6LkqXySxgYw3FNlaL
	y3SdxuN9YeNka4sjEBZ2Oup5QAuE0ZlN1wgczsmw2tSDhq54l1+MKB4m+1212zB2
	AJ8D8We3PZ5j2OvAT1cQiZjzlrFlHQxQEZNtnZUqwDR4rG3JjIHtIHoD8Upg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760385246; x=1760471646; bh=8nT6Xl3gycORnbHP21wUpONtePjaQl//YEh
	dAuyAFFE=; b=HTelT/V0nMdhUKQzGcEpFiCsrh2y2h+TIDN6z1IWy07VQ2mSINr
	/V7pqH6mYhi6pNPXKqYrTJ24yiRM18krK4Pjw7ATgd+860lvZ0TurjlP333dEeEq
	PyKBSJtM4gesOicO8RLkXoskIdzn1/C3VV2koAv0urijZhZkTxh0/lO7xyl/SG9u
	uuMzQvfQorHI+V/qR6CPTWvV9IGwLjj258tZ99RnvZh8QmgZKRUeEi9rktiVAErF
	vAKJdT4mVQI1xPuwp8XWqrMu5yp7K1WmTzbYl4YO9ETdPnwOMVQrK8tUAyJMbIsD
	LnndD0oszNYvlwFNk0QjkGDSblCiOLW3eDw==
X-ME-Sender: <xms:3VjtaBUuos9nDeGKl7j7vPKTeOaNuKG0c6WrkzkG8lFy89K_XJDqGg>
    <xme:3VjtaL-RBVal-u3VqQrqKb1jPxXP9BiHQFLN0kKtRGyKFiKzeIvWPFlLtdDpfgjMk
    kcf7jvIg1NYUEcbfTBFngOtwGzQlO8M_S9EpIHJx3E82SwDujmj2Q>
X-ME-Received: <xmr:3VjtaDhIK0z3XEyxv4tsCGFjcPaGDsnZTQ8vWYykv_3GmpKnqv1kemf_pYspaC6pRXHHJ6P8g9S7uffsdX0b2RrQRqQYFcwznm1_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:3VjtaPczV5CxjQt2zuPGL3weYrycVg8YYiCKc_7GPsoGwfwUTG0VzQ>
    <xmx:3VjtaEIPsHsjCm3UXKxG0ShSQ5fIr_Nfoyrk5bR0BxMXoYFFauympA>
    <xmx:3VjtaEk-LlhKDA5H0-LjJZXOnQ7sG7YHwODuOONmjC88WQygDDSazQ>
    <xmx:3VjtaEeL1THn5A2hAl421NjQ8vAlfGT9QH2WO8ZaiD_cZH2z93Miqg>
    <xmx:3ljtaEB_kOIHOTMgHlhhmVlGCllqDN0FYep53mRYr6xOekWcpxzTlHg2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 15:54:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 1/3] replay: use die_for_incompatible_opt2() for
 option validation
In-Reply-To: <20251013182530.33041-2-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Mon, 13 Oct 2025 23:55:28 +0530")
References: <20251013182530.33041-1-siddharthasthana31@gmail.com>
	<20251013182530.33041-2-siddharthasthana31@gmail.com>
Date: Mon, 13 Oct 2025 12:54:03 -0700
Message-ID: <xmqq347m1stg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> -	if (advance_name_opt && contained)
> -		die(_("options '%s' and '%s' cannot be used together"),
> -		    "--advance", "--contained");
> +	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
> +				  contained, "--contained");

OK.  die_for_incompatible_optN() takes "int" for values of
individual options, so "turn this into Boolean" operator "!!" is
used for advance_name_opt that is a character pointer, but contained
is already an integer, so you do not use it there.

Makes sense.  Even though the resulting code may look slightly
strange, there is nothing wrong here.

>  	advance_name = xstrdup_or_null(advance_name_opt);
>  
>  	repo_init_revisions(repo, &revs, prefix);
