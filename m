Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5A315D32
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576888; cv=none; b=t/ryBZI5LU01ycUPmyFbR3XD2eO188rXl38tdjRzDRQQpZux89fqVMpOyAFCb41Zxz6UmHSXqbhNiL9Sirw5HStVjwN6AO1KwikwM+zH39X9vlVMs42Ms9oDyRRuOVS5qjKrTMMQTz5ZmSbFpeQcElVDXMOBzxHwaUw8Ss8XKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576888; c=relaxed/simple;
	bh=y439CFbRpMKAHori8aPdjLG84NGcRmv/obUxHPzWUWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=epNnUOzrFvcKhw+o3bmKjV+6rPOCluL0psLO5GD4+TJsuCYinA8nStBuCUqm5CufS88gFpvpgRrvtOg+81FjV51CGfp1fzB5iAPg9Dr+AXeqB4KcX76rDYLRpPtG2uo+d+y5XubdVm4WLu1Y2Pw7HXwOtsr2Nnh31O69adzVodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CnYOn8C2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBNH9pTT; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CnYOn8C2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBNH9pTT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AF7F1D00099;
	Fri, 16 Jan 2026 10:21:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 16 Jan 2026 10:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768576883;
	 x=1768663283; bh=TqppEVvRQcl6LUhEpJfsQIjuxrYYybfjfylNnL+CGsc=; b=
	CnYOn8C2hsalf91vZbIOFvtraw0Erm0yjEOci/j8te0awUxw6xQzGIEb0VgIjLdH
	9Cn8tF2lgZednHsOhQ906SdiNCOD1npMvT5lhN9YUeQo32qkER1GvWj5BEcdr46d
	sQNPR1njBUl96DGVgdE+OIYbkGbe1m1wTMTsBYJlAF5whWVSorJaFWHyA6qWTKiW
	FItrKwLPvczdTCH1xwF2GUa6N1DtSefxo7ZO6KPyT3k/+EPf9KyM0BexCvRsWUwK
	d7XqMKD3mCrKsh/nH2wSyWpIRU5cXkOb0xeVk12N8Wa6xL0fBEn1LAGxO6Copkqr
	G+RzPXTay6XIN0h+jiafSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768576883; x=
	1768663283; bh=TqppEVvRQcl6LUhEpJfsQIjuxrYYybfjfylNnL+CGsc=; b=T
	BNH9pTT4hzneLzcjp9a28CkSH6NAtZu7Zm8W7pXlSGsmoBQbN2Uqr8pt8peNmix5
	HDWI+88r8SKaeNyuKCZ9HGX7+asgPdWtr324h3D8EZl/1i+gKlNbzLMNzB/kA8Mq
	Wj14lBuly9qsIZQXhE87XnUX7ZKjaiVIqxPPOczf6uohELMJ3AHJBtye+cgQ03Jp
	gRpqRNYaHzvI5iD2/nKh8jdApZ+bQZgC5b6ta3erJO3JM0Xdf8euuYJBcinGIWjn
	XaJwtiYPs7iSvTcxkoGZz1GcVhpxWyZDAW2Oc9xhN1nS8CG3eyucxCOOJOGb79g7
	MdQuXlJVZIdub+oFSGdTQ==
X-ME-Sender: <xms:cldqadWfM03XDln-_g7dg1AkqDfeBlxS2ozTtXpWWkahSrOR7LcjGQ>
    <xme:cldqaT_qWqEZfGIpIybC9GH1FiVxhPRYmWDiJk7jPpkEeZYv4UfGDF3xxhR88js5R
    8jqLbN6o3YKHNnotEJLnEBuM1dKuWOzw7kJLb5eUzo6R5bveofplA>
X-ME-Received: <xmr:cldqaVp4LnOjmm6NGtv1rQQzjUvXjVlzQHZQA9vlsuUzbwLIdgixT_T411h3qV9Ry9XPPG_McjbNYg2ts3LR1pK_MOM9iKyhvP5Z0J0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprh
    gtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cldqaeK5Ty_ghy-k8BcvwOmKKkNEJjkvHQHj2IkeNUBzAQASYzOGqA>
    <xmx:cldqaQM8NbeA84gb2Zd17DYMTLC5XpePl8hqeBDOY-Kxkq3DGw-MTQ>
    <xmx:cldqaTqLA9DSDUQgidaebrZToNw711VwnJ0vF3sw-gg9qZXizW8Bbg>
    <xmx:cldqabJG_t8dt9NCdufxyKozKl-wtO-erRcjU9MpgFNBuz7WJctnhg>
    <xmx:c1dqaU_iRJwB1UbUMjeTc65K0kYw5d9oOmUA1RSdC95doZqnRQbek_Dg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 10:21:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Sergey Organov <sorganov@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?=
 AVILA <jn.avila@free.fr>,  Martin von Zweigbergk <martinvonz@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Matthias Beyer
 <mail@beyermatthias.de>
Subject: Re: [PATCH v11 0/8] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <CABPp-BFbUEGqNAeUtUghLd3oKcZiD88P04AYuTtY4T01F1rzdQ@mail.gmail.com>
	(Elijah Newren's message of "Thu, 15 Jan 2026 22:43:04 -0800")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
	<CABPp-BFbUEGqNAeUtUghLd3oKcZiD88P04AYuTtY4T01F1rzdQ@mail.gmail.com>
Date: Fri, 16 Jan 2026 07:21:21 -0800
Message-ID: <xmqqy0lxa8i6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jan 13, 2026 at 1:54 AM Patrick Steinhardt <ps@pks.im> wrote:
> [...]
>> Changes in v11:
>>   - Fix overly clever `BUG()` condition.
>>   - Drop the `struct replay_result::merge_conflict` field.
>>   - Return a positive value from `replay_revisions()` in case there was
>>     a conflict.
>>   - Improve a commit message.
>>   - Fix check for whether `setup_revisions_from_strvec()` was
>>     successful.
>>   - Link to v10: https://lore.kernel.org/r/20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im
>
> This version looks good to merge down.

Thanks.
