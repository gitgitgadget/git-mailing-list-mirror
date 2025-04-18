Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3051A2E401
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939492; cv=none; b=t7OHLNRmMYR4PUULSZVsjwmlIo8ihyARKohMWsp6w5VSBcN+73I/d7BvQPrUm+sffcHFo0EdPR5g9Ww19Q19hx19xh+gHGCzFQ47+1HpiqRh0mpgMplh5tvWgTnlO6RoVh2mIwEs6iU/Lfzp3ifpzDtTy7ojzhNlbiozH9p0G2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939492; c=relaxed/simple;
	bh=Vtl33zWVsUJc7esbMLgVoUklfWgQaFArGOt5EHfJWds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FH1vFuD0lCawe+N/7+zl4FmPjUOd2rJhnnuMwsLap5fthzTuLguC1gfUNHQ49iqeNGOi7W4ta1aIJRBw5Fw5AVp2vuQNxNcbXl+kv+Zp4DIBRlWH1pScJ2ORx9KeVhVgZaY5K65uwM4IBLRXWITuIu+AvO9z+lolITR3MOUmCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kjorjw3T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQ8B54ij; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kjorjw3T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQ8B54ij"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 161961380211;
	Thu, 17 Apr 2025 21:24:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 17 Apr 2025 21:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744939488; x=1745025888; bh=rplPjvbiAR
	+FkVVvV80IbLv8z7WioCVXV/SRKYzTpmg=; b=Kjorjw3TbcDInwAiNegapTBdjC
	zi8YAeMHBpS3zGlHUQOmAuVlVV8pSBx05MXeZyL4CvQO2GqzfZprZroBVgaJvUS1
	CkdpH1UF6MmoQiBsp2LD6P4JZ5Wj7MnzjXxfwd71dAQQFvnXXKQ2IW2JDMuQ+Nes
	3Pdjsx4mlCRNM//tX5CIaNHbxBoAZoSCR3xfTBZJQuZfqp3xwdKUCRPuaRBU5je5
	dTUFKgDCGHFGsdPwPWtOHRLPTrpqYomYNZv1drZBhnJ2ESrnXDNY8Q418gQyBX7U
	CfpaALucOeH9hgfEOrPXsGpjjdsAgG3TaQ8sGsI53zlLtV0qN2F+ipU49wwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744939488; x=1745025888; bh=rplPjvbiAR+FkVVvV80IbLv8z7WioCVXV/S
	RKYzTpmg=; b=aQ8B54ij4WH90PvcTZZsf3gSlwh9Vj4ODW8DyKSf93rQKq/JbFR
	KS9A4i15wQlThkIdZOPkYF3ckvcGTdJL/gHweZ+Gh6ObG+A8EgRrWL85vTSc2RIc
	Vnn9phlieFh3QBy1jP1IxQOwAxVFXOgWlCI4fIYI+XZSjZp8O+6oK4B0W9nLskDQ
	MK8ZYWJ9ltv0iut7HOl1kEF81xTdeiGImWoLqgeteTk1hXb4Vtvi2EGoOQZQrXSQ
	ggyopGEjfQuKnicg5RpvkACj4f1LV9N9WaCxrXWoNhv+htrEHsBLXGnXwOIbXW/C
	bcT0mys/Mk2wprWV6JXMt3ffjdlc6f74HGg==
X-ME-Sender: <xms:36kBaKkPKdiwV7x5b6Ds0Stz9l-7X2L7EWLuo_ifWqhRUME6lKVKtA>
    <xme:36kBaB2dTzOUn8yDyVR_t3MXp5mg7FpQu9WovlztvOxBAZDfubOe8ws3jYhTr97SL
    W2GucgopClg_cT2cA>
X-ME-Received: <xmr:36kBaIpLKlTCFdb7f-69tfXN_qIqBdae-QKxllwAVhOUpWrRx_fN-WVJNWoOdAmWWUdsnDxmjkARweMc1uKDY0bLMTifXkEu_Hri>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvihhthhdrsh
    drthhhohhmphhsohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:36kBaOmR-2lMq9ATD-gNdTVEBpI0M_94tjKjusQHalF_FdV2adO7Ng>
    <xmx:36kBaI06RPI2Aa5KtST092JWtOa33BrhltnVxzuo6t2jsaG0FeTW7g>
    <xmx:36kBaFs4ijRhtGBeiuiwQGj4bpBwvTAq-y1vieYQZn76rJQGO_BYDw>
    <xmx:36kBaEVS_d2vVjXKFk8BtljLDZau3mQ-h_Zh_sK2S-k5ExC-3Xjv_Q>
    <xmx:4KkBaBivmixPqlGhNxW-doPeaRw-evgAjAjrHgyxs1FXWG8hr8XGK3Xn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 21:24:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Keith Thompson <Keith.S.Thompson@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug report: Minor glitch in "git help" error message
In-Reply-To: <CAAHpriMkqapiJuUGimn-i8SqcZmvmc=Wpk6oUr844uAkCYgMxA@mail.gmail.com>
	(Keith Thompson's message of "Thu, 17 Apr 2025 15:56:37 -0700")
References: <CAAHpriMkqapiJuUGimn-i8SqcZmvmc=Wpk6oUr844uAkCYgMxA@mail.gmail.com>
Date: Thu, 17 Apr 2025 18:24:46 -0700
Message-ID: <xmqq5xj2clcx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Keith Thompson <Keith.S.Thompson@gmail.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
> git help nosuchcommand
>
> What did you expect to happen? (Expected behavior)
> An error message: "No manual entry for git-nosuchcommand"
>
> What happened instead? (Actual behavior)
> An error message: "No manual entry for gitnosuchcommand"

I am of two minds.  When "git help" is asked for commands, your
suggestion does make sense, i.e.

    $ git help dog-file
    No manual entry for gitdog-file

And these two are moral equivalents.

    $ git help cat-file
    $ man git-cat-file

But "git help" can ask for things other than subcommands.
For example, these two are equivalents.

    $ git help glossary
    $ man gitglossary

Notice the lack of "-" there?

> If "nosuchcommand" were a git command, the man page would be
> readable by typing "man git-nosuchcommand".  The error message
> should reflect that.  (The error message is actually produced
> by the "man" command.)

In other words, if "nosuchguide" were a concept with guide, the man
page is readable by "man gitnosuchguide", and the error message does
reflect it.

Unlike "git foo --help", where it is clear that the user expected a
subommand "foo", when the user says "git help foo", we cannot tell
whether the user asked for documentation for a command or a concept
guide, so adding "-" there is a bit like robbing Peter to pay Paul.

Thanks for a report.


