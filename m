Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128E1BFE00
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773537; cv=none; b=leX8tHlsay2cnNxp/ZQB7Qa3HZUMz7Tz6hCQEZmba065AJ3nzq+4Oq5PuO8QStIHFdFdyxC+A8Pc8CHJaasbayHoyyQLe+EBRAUuz3pms4Hs1+N6iP7cSdKQD7tfEvEWS0BogP7Pl2FadyWeQR9ppE7HmvA2ma3TbtftCp9zNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773537; c=relaxed/simple;
	bh=BijsvE9xcR9oRkFPc0N1vzljduNG9shA5wrzkQ0Kp1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvfkqoW9by2WD3BedyvISOj/xbuIAknNlzchhlB1Z6Q8USxUWpjop7GUKCdZXiJKQB9y8yjGpwPIgVcOOkP9XoHs4/85M9k76fL+ZgCy0ZM1JholEeL6Ai3so2bsRHKigMe39FFihTkbcRSQ6G5o1ztYZn1hzwy4htZLR/vBtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kl0eVQOd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOm7ZhZN; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kl0eVQOd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOm7ZhZN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 064387A00EF;
	Mon,  6 Oct 2025 13:58:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 06 Oct 2025 13:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759773534;
	 x=1759859934; bh=bdHQ8bjILcybq/cXP/k0GyKlSGK47cTd3ntjgEwBNkI=; b=
	Kl0eVQOdqaDDewW3U6iE0NxEzo5kWJJiPClopdRetfsd635yzMgFrZqriucwEbI4
	YWEPpPLuYUteDo+iKEwvvfuieLx5WHSqZtftQxZNnuQeRPWhJLjYljinJZH/jRIs
	85ewQ2GpJjL0oYIi2nA6xnBMqC/wF6MQNddou1uvjIU5uRXw5Zj1lsCfoBux/s92
	6ZdYM5RmzPtLhRAmwpiDcCPskDhltiZExoU6ycLnCRxTy1xskUeDQLpt+zwxRNsV
	LQRL7X6jNO8VI/pYV3eCcXXDhKDsx5eR0LPnoTJpqNWgxWGmaszJga8xc5uJY6VK
	nIst+eF5KV1F33OhuVV9hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759773534; x=
	1759859934; bh=bdHQ8bjILcybq/cXP/k0GyKlSGK47cTd3ntjgEwBNkI=; b=L
	Om7ZhZNQvdHgJ4SULYBtiUBVOXkDJs7mMP5JZRIiM0gbxGE9RP72EObecD+hE46N
	OdbsJrMjJgPPIIcmL+8jJdIZ1FFBauWQn/AWMccfkjimEWkI656SevOeabZIoxzq
	EdYxDoDH21CJbfDKAa+vCvY9LA2InKuQUGpMYzzs9rK4fpZGisixGP+sTBjnDNtm
	fgwlUR/znD/iLc3Qjyp2ao2ALbzZbTa0LZ6z4Tv/0u6hlbio5IkObwjZWrykRuod
	tEpdSJGjNBFGhLoS+n5hjcacdU7WuN3XJ9Qu5ygPbcBSZ0rB201N3pDqekOpC5uL
	9pLzPP04AoITTANTsTDFQ==
X-ME-Sender: <xms:XQPkaBTkJpWJi8GqfhH4s-dP7f71CDc8iFnLGK7LwYqS7pEsFvhPjg>
    <xme:XQPkaMQ-ipIr28CMJnZMS_4KkJhrg6u7nmszlX_jaB0BknJ2C3QktZiZmqa44RZ9d
    x0sLfC2126CtTmeOEz4w3rqyT0br80YgRli4cyyOfT3-3uhKydFgJ0>
X-ME-Received: <xmr:XQPkaG6OBqNa92YIpHnpLYWJJNHKgjJ1XEWIsr-HZ_eO12qfoZqLuo3xY0y5--FempYK7LtrSG9kKGF6OA1kn9uE_monjIb2-g0m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehurdifihhnughlsehu
    khhrrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XQPkaI3SJQPy3bm_W_62U1KdpJNRkRcH5aKz_YEjFX-wvDEZ7326dw>
    <xmx:XQPkaBCceggNYwgHJpzUI54dt7KfJCaz82gkks0GscLdciF03f93xQ>
    <xmx:XQPkaDMUnHpdCvKjgYH47U_KYzocFRH8L9Qnp9DK_WSPubek4-2oHw>
    <xmx:XQPkaGbGYZC37jSoVlQLSydrBlJpIElUwZruEMZyLd8vRPcnZOPzPA>
    <xmx:XgPkaOVZ9wkwnXmFs_LlUiFRSy2tuKZNL--FyY9yngC57idPVzhygRcf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 13:58:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  "Windl, Ulrich"
 <u.windl@ukr.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/5] add-patch: improve help for options j, J, k, and K
In-Reply-To: <16d5908b-bed6-4ad2-bb27-9c6523f904d0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 6 Oct 2025 19:17:53 +0200")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
	<75b08ed6-4f0f-4ede-b84a-c2f1c3d15734@web.de>
	<xmqqbjmlrq8g.fsf@gitster.g>
	<16d5908b-bed6-4ad2-bb27-9c6523f904d0@web.de>
Date: Mon, 06 Oct 2025 10:58:52 -0700
Message-ID: <xmqq8qhnq5cz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> I see it more narrowly: This patch removes unnecessary references to the
> hunk's status, while a y/n doc patch would add missing pieces.

Good.

> Hmm, would the help text need to adapt to whether the current hunk is
> the last undecided one?  E.g., "stage this hunk, implies 'j'" if j is an
> allowed option and "stage this hunk and quit" otherwise?  Stuff for a
> separate series, I think.

Sounds good.
