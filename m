Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88162101DE
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485080; cv=none; b=i3D4udXlBr5SfTNzL9A7rFkmyBa0m7rnWXvYYVXFklqWYZh68OdNxJOzhZ8raYrEIvmGelJvPzxl1TX9hHAKP6szFSqd7yV6BNwq05VxmT7iq7G3uFDGcSzP7bK//6Pc3PqiyzkzNWojns7Ofo2V/CKtMBt8kVZtfVLoqh6ubCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485080; c=relaxed/simple;
	bh=Rj1mMjrgr277CT9As6baEQ/mCm+6VAChEwCPx4YgtW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZXCPGV4qwn1SSlEQwHcWYPhIlEVpkWXJJU8QGFMPJxcl/5wqbnIvxsZZBtl8IiscPVEymGheqcNPAbTunHoZSgkLXCsFsDDqTfXImoH+cJT6awnvSJbaGgsRauCafbG4d8I1XZMAH3KQHLkGRz0fm7+aSHrNUQb567w1bQ0PELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DmjOmj1V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QhYteuPh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DmjOmj1V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QhYteuPh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CBA61D0007F;
	Fri, 29 Aug 2025 12:31:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 29 Aug 2025 12:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756485076; x=1756571476; bh=+dPwIZKxsk
	DmV3P+imT8nh1m/fGex49KmNUL9T0SlOw=; b=DmjOmj1VtDkzkqCXdYorKtD33H
	hCwrifz/f3Yt/f7lQijPOe2snZEBYu78Q7/1HK1xjwohXF2IfrN412mT7QtxGHIg
	DstBbkUn8jVeRwhnXhhEtarxtbRGE7msQ/7nWNyQuBXgXchr73/7a8GFC8faRzKv
	16Mfl6H2IMSTqpn6KkMfJxCh7ZdebZrmO1jweYe52/rgYUttihyAX1aqQmDN3Llp
	JuFmwiLsS0Wa1K8aPZ3xfokbC4FmKzdEGjlCUmVlWKu8OpPL2Alc+/lAze+6qrcS
	zuA4uYRysKkuFegEhzUKPYeS0KLeBePO0N025ou3nJ70KNZ/yjPfLlhCNZEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756485076; x=1756571476; bh=+dPwIZKxskDmV3P+imT8nh1m/fGex49KmNU
	L9T0SlOw=; b=QhYteuPham+D9wGmNJJRjc01QkJG+AVPecpKte1RcScNlj8K2TY
	i3wxYwUDYTEjtm9VZxLHStwcZd+ldYxSuKgqmQdxvt63G3j47sWH/FOkeZNiD7OD
	a2t1mpQukDbYS+IGJxjmDfHpCGECQT2TZuPCWMrA+Y/Seb5DVBQRxqvfikTZPV3n
	PavFJO3KJ3MudofwgrI2fAf7Pe52TaeyFnsk8U+1MuJfrdky+BOorF0R3p+E8JMz
	LpHw90fjgg8sfG/b2dvJNtRol8p+hq2nkWENV8QXk/jWn9DLLddDHd+tD+5pe1Ul
	RMPHXL7sWtfT/qDDNAPLOy+aXoIjIz4Q7UA==
X-ME-Sender: <xms:09WxaMvGu1U_8M3Nnse_c1h73_K--krcWIwYQK9GfMSZL18kcFcilQ>
    <xme:09WxaG3ez97ndi7lxZ_gkwyiWcQTCqqELdotlz7hxX-GnS1nz-VEFf7AsgSQMRhWB
    MpDh-l8RTTJn1WGsg>
X-ME-Received: <xmr:09WxaPEZ1gvRwanqLGjkaNG3B8NXpDIPn4O3Ub79FhLYCsOkVy5TLXibhANgpQ2CbwEbXunvnwb_zmAXaqemFoOWSD-2J4HBcMolo9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrih
    hstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgr
    nhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:09WxaJv6Y-FgrF3zKllUtKomwuTcYMdYE6qfSRgeGjhthfxAoai5PQ>
    <xmx:09WxaKoGD_64X-TeX9cO5UOlEkzI6mwo0h31EVOfFcRq-uaYhH_fqQ>
    <xmx:09WxaIVUlcb8w63oNvHGjPPs19BXn-yWuVODy87Tmp3R17mF4azjfg>
    <xmx:09WxaK0AmVpifT0smJMKyNZcSo2VOWTWrTTEWOze7B7zsbA3DeGNJQ>
    <xmx:1NWxaJZZnAz7CxqUI3v_Smr1bmrlqHps_aDx98rBfWuoEGtUvrPodg-B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 12:31:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  phillip.wood@dunelm.org.uk,
  Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  ps@pks.im
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside
 a repository
In-Reply-To: <0548f4b2-6c36-4958-8725-5c9ac91e31e8@crinan.ddns.net> (Phillip
	Wood's message of "Fri, 29 Aug 2025 14:05:58 +0100")
References: <xmqqcya63cqx.fsf@gitster.g>
	<20250721115519.140361-1-usmanakinyemi202@gmail.com>
	<20250721115519.140361-2-usmanakinyemi202@gmail.com>
	<370f11e1-b335-4111-912c-94429c5018d6@gmail.com>
	<CALnO6CBbEB=94YsZn8vtjcwYENuMhMdg_wb2RbQunVCxnf53jQ@mail.gmail.com>
	<0548f4b2-6c36-4958-8725-5c9ac91e31e8@crinan.ddns.net>
Date: Fri, 29 Aug 2025 09:31:13 -0700
Message-ID: <xmqqa53inl7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> That should only happen if you set GIT_TEST_INSTALLED or something,
>> right? Or maybe some even more exotic setup: even with my
>> distro-installed Git, the command doesn't list my git-* scripts in
>> $PATH or installed extensions (like git-when-merged).
>
> Sorry for the confusion, I've just had another look and it turns out I
> had some rubbish laying around in the root of my repository which was
> causing the problem.

I do not think this is something you should feel sorry about.

If you checked out and built 'seen' that invents new commands,
and then checked out 'next' that lacks these new commands without
first running "make clean" (relying on the mtime of the source will
cause rebuilding of necessary things), your build on 'next' will 
see "some rubbish laying around" that may cause the same issue, no?

As "test" is primarily to help developers, I think we should find a
way for this test not to be confused by "some rubbish laying around"
if possible.

Thanks.
