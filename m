Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487825A64C
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751942; cv=none; b=htbKfK0lE/h31/9uV7AWqq6Y/TgH88ZPfcZjs2wSUJhi0Mc8Nl4kyXR+hf/J0FA6lEGIFLjEe6DMZeyL8wxa/Zyp18Mh/Dm07cWgEh/qHi3+TKsqlHTke60KOZ2u7re9bYL0CFSKDQy7+EH63CEnolJXqTVVCDfS/2tC74AaXmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751942; c=relaxed/simple;
	bh=Lj3FsvP1wINQYOTHye1ob13uxKTKU55GjZeZpZEFU4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TB2Dc/d3+eyf1rma6igp7POoifprknF1IyJzH5CgtTYOTUmGp5l/HjSmjWod+LCnAEmdP6B0XGzoIqEYVkgk+nguziL63xJZYhDnWgqw2/ZI5n+xYgpqUaOqTq85EIGNefCJeLMcTb6t8qfdJ3qeZaxijwvXaD2S+HPezIPMizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FLthGsAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovHrdtxQ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FLthGsAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovHrdtxQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E30017A00F5;
	Tue,  6 Jan 2026 21:12:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 06 Jan 2026 21:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767751938; x=1767838338; bh=miULAd6GwL
	XpyLztf3DVV0G5FHxRbpcjZcfiop3MlM8=; b=FLthGsAmHQxFmz6JST5KsF3b+o
	D15wqRUFYS7FA1C0z3Lq52sr2rmyw+cWv+EeAle/IU0qZWez6P73j/xERFZaeaxj
	1FGTNky3MRCpP7kuIPidIXCEVTq0aUBja+qYjVadXM/YffeNlUdg7Uc3PeD8jLEH
	ZnJnJVxpBnldtjFvExb1SKrDNWYmZV7K/FPE4RS9KiBYl0SC0bQyrrHSD8yFPoJm
	WWJFoaadjfhfKyYv1Zf0E08Mvq/gNZEX58zEtF+YSNuuq/bn9kVnS/ugk2t18pLy
	1qCMWpGATCeSnZfSArPJRk6mA0JnSs6lZx+KKm39dyXJIpk430ZX6Ut9/uxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767751938; x=1767838338; bh=miULAd6GwLXpyLztf3DVV0G5FHxRbpcjZcf
	iop3MlM8=; b=ovHrdtxQTgf8JdcChpmof5BF4eAju4nWeSmkuegTPPQeIH89Wu9
	iw3bWrhxyUV6R4soFjQ2JFRCxcFUzxXZdTodMdKhFRXupb3Me65ycABJIaSLm3pX
	MZM9nYKWo1KAdxn68tgkmO2nm46Q+0UKFo7NoKC16zyJNMzF4+mNPT78VJtidF20
	vFc0XPx2qZREmIkLtK5et2hU+KNzQ58TDkAp4tUsAZsa67Fn3XgBJRImShqHlQ5j
	vbE5n2xcOBc/BV8UH0uhHrmzcbgu05hXNYXQ0QK8ZC8xWdXo+9mpA7MvVid2IMHG
	/1M8dKl00WPUK6GMjWLtlr4L0T3WDboyHYQ==
X-ME-Sender: <xms:AsFdadrWN380uRTm0UMHNIZL5bNkbBm0WL3nE2VEsbmmz0QP-tAQYA>
    <xme:AsFdaWg98425jAQTyA6EjZcJ_wyF6s-dZhIO79plDdreqwWfsm9VyaX0ZJFPYGXWO
    hdrlTbb8t0UA3VkmJpHvrRnaA_-Z4yVYuOuQ6XYjIGei-nzUp_A>
X-ME-Received: <xmr:AsFdaSgor2jcH7bWbWxsfbz7LDLvrEiOa2PVBXT6Qk0T38I5r3zb7olHH1bYLsOhYRN2FwePmIpul1N8bmpLZiQgRSWgRQMfrcaufi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddukeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AsFdaUgzKSuEXuHsSFNf2nDc1BieGo5YKhV3lRUs3cWL2aM5Ob5s-w>
    <xmx:AsFdaaJCE1CLClosCfgqIVk46ZghRhck-XJA886DGRIS4jrnvSNFHQ>
    <xmx:AsFdabFEZVNuU-7rSSo5ZWRss3gasdHsqTnbIYbFfaAsGKrBOSU9LA>
    <xmx:AsFdaWSNOqW_HV6o_HlDMh0hV5VG2EahNawRV2mKZYB-TdLZ_oAacw>
    <xmx:AsFdaQo9By2dDpdr_6RzuKSrrpPV1NmaZaK0Ns9mEr3Chqszm4uZHqot>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 21:12:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer
 <emilyshaffer@google.com>
Subject: Re: [PATCH v2] ws: add new tab-between-non-ws check
In-Reply-To: <20260107013051.312291-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 7 Jan 2026 03:30:51 +0200")
References: <20260107013051.312291-1-adrian.ratiu@collabora.com>
Date: Wed, 07 Jan 2026 11:12:16 +0900
Message-ID: <xmqqsecii327.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> The check is a bit complex because we want to detect places where
> a SP was intended (HT can expand to more than one display column),
> so we need to count both the display columns (col) and the string
> character columns (i) to determine if a HT looks identical to a SP
> or can cause confusion.
>
> +/....adoc text eol=lf whitespace=trail,space,incomplete,tab-between-non-ws

The name of the whitespace rule does not quite match what we want to
catch.  Can somebody find a phrasing than "between non-ws" that
conveys our intent better?  We want to catch a tab that is used by
mistsake when the writer would have used a space, and "between
non-ws" is one of the heuristics (another is "it is at the 7th
column to make it indistinguishable from a space") the code uses to
tell if a tab is such a mistaken tab.   "tab-instead-of-space"?
"tab-in-place-of-space"?  "tab-that-should-have-been-a-space"?

The last one is horrible and not a serious suggestion, of course.

> +test_expect_success 'check tab between non-whitespace (tab-between-non-ws: off)' '
> +	git config core.whitespace "-tab-between-non-ws" &&
> +
> +	printf "1234567\tb" >x &&

I notice all these printf create incomplete lines.  It is true that
the detection of a tab that is used when it should have been a space
should work even on an incomplete line, but using an incomplete
line, which is of course rather unusual, for these tests gives a
false impression that somehow this requires an incomplete line to
trigger, which is not what we want to give.

	printf "1234567\tb\n" > x &&

or something, perhaps?  I dunno.
