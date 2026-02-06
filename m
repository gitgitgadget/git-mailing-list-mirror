Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B036337692
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770402955; cv=none; b=SE7eFobGYj4gVgsER19Q/Eq0HPIpc2jAc3lS6/VLgB0FcqagVdIj87LLL+voBuuqH0QLJ8DKH1pzfMrzTvjtkw9eHxPzI8TSK+RHVa7DFlwR1H2qU2foUXpv/bG0Ka95VUgdgyjfll/gbQQG8z6MFCUrGS5KHBmOVc6bgbr4x8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770402955; c=relaxed/simple;
	bh=/9m6sqsnGnA6KJxm2X6PpZKBr7m/FWCpanw9atl/1Pc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6i7AKOlZj5hsiclux5Or3H+8lSdVUnD41mp8jqxUaGa7Iws7Oi7MfC98Rclx7uDegATNMEBiCBb1VOhIoUWPacFxC8LuOnq751NyIKHYz/gaFl+P5OIEGuoI8XZ+MZcr3LpuxxyAX9ZeRfQBai9Ux8irZTwMtml4+gJxj4Lwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ow6ABAj8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dluz1v0n; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ow6ABAj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dluz1v0n"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C0763EC0554;
	Fri,  6 Feb 2026 13:35:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 13:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770402954; x=1770489354; bh=p4Akzmjcu3
	PHSvaBIh0TZt1vBOWIkZIubYhclNR5AC4=; b=Ow6ABAj8/VxdF7dY3tRP5GkN+B
	8eGZxWdfFKCjyS6LlVt5Oo49CRXaInf1OgxZGM10ypbwcgOYVirPMTctJp4lVY/r
	a6UYEuwbpCEl59CA3YwMap8l/nM0tUok5LN++fjwkO3bThzYVeybZrRFexU52/Kd
	b32Etb7a8kGZwL6VmuBJnvfDW0iAjUKMKigyPSvnrQqphhmVx/nFYEw8CEJqlQSS
	Hg1LMd3fhxDsSxKN8Y8Ci7x6SaWWDZ1DiFaV/wvftqnsCEMOS1PV4+hLHSk5Zvwh
	2FmVWLlOoS3fRywpqxXSH7NjVwETwnScgsMk+7oLPzxmisUicxsFxkHNZAeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770402954; x=1770489354; bh=p4Akzmjcu3PHSvaBIh0TZt1vBOWIkZIubYh
	clNR5AC4=; b=dluz1v0nIKoqj5F4zG4gOB3z59a7/5pqn+k4cRWN4E6MDKprA1A
	wEfBRv/5M6O5xOzUUj4GPXqDk+AH+G0QJ5xgKoukQBMJ3AQzbrMXTvz8MCIhapmh
	itm74oM2LOQwWOrAeMvU5FXbv91fWk8pN0CxBXEEE95S1fSE+qjqd4kBT5IuFbPZ
	fnvzbksDSs23U6rA2annCGglJQ9QFzZy0ItJgb6EKIaBtWn16Xwb2EeIRerWN1ML
	0yMXNN1pYI8Gpjm4A1CcznsZWKE9Pnc9qcRWDBeMHnLrvQlDmNOG8p+38idUO+DY
	cq4VkdCnQikA/IJladbqpF2uArWZM5SneEw==
X-ME-Sender: <xms:ijSGab_2gZydRusEiDWIviiJeHh_mRQ3NBG7ddKSv_8w7Nbb3scbVw>
    <xme:ijSGaUSQ5fgFe6acRLL6ry0eCDK6ePH0pzeTMwaZqFBc3FL7hCvbkCFnuZKdKeQ3S
    rNS2DyIYdY9dDmWGkdMO6KvpgPKVU8PZWG5fkCpMR1fXCie1sD65DE>
X-ME-Received: <xmr:ijSGade9saOlMMVJAqhxDzf5jFiopiZtaNy7mZ0QpCiHRF9KLHnLkOr76Lob7AfVeq1YHgE3GTZikylhwxLpcYM_bkPjLPql_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ijSGaeT_5QdhatimOePVhRAlmSUFcAkVJc6StTTncMY2vlkxqhSe_w>
    <xmx:ijSGaRKkIvtbsRg8gb8ByiwhQXPeaEquUwCCXPaYgQgaMKYWSzQEIQ>
    <xmx:ijSGaTJ_wsI4lzZWXSGzKCfRtI7kTGeiwZnmm4O153ee2h70lcqXJQ>
    <xmx:ijSGaUh979zVSLDFFrxJsend9_zPiIbYIGTL9Wkv8TGH0Ve74HuH1g>
    <xmx:ijSGadmaRcQQX9DevMMOSCHMx6VWc5Z_T_wY9_6m9wnOQH53fdRQnanq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 13:35:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
In-Reply-To: <24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
	(Abraham Samuel Adekunle's message of "Fri, 6 Feb 2026 16:56:14
	+0100")
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
	<24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
Date: Fri, 06 Feb 2026 10:35:52 -0800
Message-ID: <xmqq4intg1o7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> -		} else if (s->answer.buf[0] == 'K') {
> +		} else if (s->s.no_auto_advance && s->answer.buf[0] == '>') {
> +			if (permitted & ALLOW_GOTO_NEXT_FILE) {
> +				ret = NEXT_FILE;
> +...
> +				continue;
> +			}
> +		}
> +		else if (s->answer.buf[0] == 'K') {

This funny-looking diff is a sign that the coding guideline was
followed in the preimage but not in the postimage, by splitting
the "} else if (condition) {" into two lines for 'K'.
