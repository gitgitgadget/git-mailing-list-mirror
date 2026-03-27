Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2DD33509A
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637731; cv=none; b=D0g3KHpVBp3X8IBn/y2OdnIWYEORMLEizkX+S4/aebDaG4lxbRKOcWRwOGN550k4rxoH1SPV0hTPGULxzb5JPar+43L1OJUfsWcF4XgB9ZTYzsjjX3EIHsU3XMibZ4qw2AiJ2WP1+FyE3GYjUtfb7lSPlRoZ8VqCWytQnNhnQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637731; c=relaxed/simple;
	bh=Z4cCpF3+OBbmx8MTXXcYTYjAQnALe3z/xe5SpAoBZ/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MBZsf/AiqD2vUmf81A4tZELIvWNBz1Iae1xrkQdznfqsgmom08DSS/TU+Vxk8FYZm84zDeJgfuc7jMFK/GEjcpe0SBJHlF61hxo1ktPA9dwy7V1Q+j+Wj1VCnb6KQxod7BIK3uqqgWZGgZZVb9dAgZINNnIgfshAWP8vAqwz+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZwfzMgBW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OuAa5/rP; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZwfzMgBW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OuAa5/rP"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 12B571D00247;
	Fri, 27 Mar 2026 14:55:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 27 Mar 2026 14:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774637728; x=1774724128; bh=tRoaj1b6rI
	qyqTKq+7GVa2r+uUZSWJc83h0zsrGagsc=; b=ZwfzMgBWKE5rnJLl3AMJC2mtzS
	eyFwnok98H3DlEn2eZz2tJhO9XCG+pYgwtS0lWrfmwMTA/5BvjMBcD2M6lcZhCPs
	sBZUrePtwroO/IVIwvtSorG4IVl155F3pK7g8KgcZD+r7TPuzDpz89avs0tQwo4f
	B4kfqsBDxmedXWf6R9axACnilLxDoNu5j3e73hHcgpK1B159dcREa8Rwahgwds3v
	LqCvFJodyDWh64iWRxpgKblqTkczRCvCt+r1AggOMGu62hw+LRwuqhlRasWapgbD
	S3M6jLxsigj/jV+ebzkV1Cgou3Y4XCmWkjvvLOOroRVaG1A7Jtm0MqPWMUKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774637728; x=1774724128; bh=tRoaj1b6rIqyqTKq+7GVa2r+uUZSWJc83h0
	zsrGagsc=; b=OuAa5/rPUZR7dTa+E3lGBZMbxktlmSz/U0Qug1zasyi4Q4jB0PS
	Zdc1GCJ3AoX6YTqefsYa3F5zu4juFF+w21TULmsVLIW/9jApQv+r1aFEA7UygobI
	f9tFM+TQrDM9O12odJej4zaGy2wBq90Yu5XejjE4ycSVP99E4zKD2EOZqqENuqeS
	HPdXHgkkBtZDZV7/SifK+NcgZiT6MMtL757XbI3tlu4qsahV6gLFR/a0m2WN6aBU
	nmsy3J+AHJA5CJUylGcN8+L+tKE7B0NmCfXJqHWhvLTcxTfeKmkAGX8/LErJIxn2
	1EJmhRfitkODYjXFtGTvXKTSi5JelI2Lz6Q==
X-ME-Sender: <xms:oNLGabhPg8OnzjNeibABPBXXps_-z-sBQNgBT0w1kGQsffVyhBOmWQ>
    <xme:oNLGafc4-veL8BXckvokNazj79e3vfDQHh3aD7o0Yab6_MuIUp1OU4dtIO6B986wI
    R7YsqCTN0RrdXbWFCAx9V38YL87JMA8rQm5MHZ11yLj50Lf4UcyXQ>
X-ME-Received: <xmr:oNLGaYcz6k6dhB7LEEwXPJNZD2-WhjZxx2-nl2lKNUNjhxcgAvRsqfRGhiyvKYaZa4_YY5c7avtkjltSnS_Z9Eza2Wt-zwVxDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedutdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:oNLGaR--QX_qo3ncQyd9k6PBaDlaasw_SNwBQp5Nu4QJJVtbdljLCQ>
    <xmx:oNLGaclIw9Ah0r6djxffZ33nEmI07H1WwWAHyAbjcN_LSoIa1k9ZhQ>
    <xmx:oNLGab8UaMhIkQ4fUz5E1QoMO99XlfHYBKE9CZkwl7wq38qBe6ADHA>
    <xmx:oNLGaSl52wbwOvU6oq2n60A4bz59a7TwA7C9HXn-uc7HHb3oo-BYGg>
    <xmx:oNLGaXpkfv2XQ2FjSjxwUnW02YUvdq5ivDvbBvxAOu2tSczzAdLdnCEJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 14:55:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1] replay.c: support replaying root commits
In-Reply-To: <xmqqh5q1jfdg.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	27 Mar 2026 11:28:59 -0700")
References: <20260327180930.104563-1-cat@malon.dev>
	<xmqqh5q1jfdg.fsf@gitster.g>
Date: Fri, 27 Mar 2026 11:55:27 -0700
Message-ID: <xmqqcy0pje5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Tian Yuchen <cat@malon.dev> writes:
>
>> 'git replay' does not support replaying root commits, as indicated by
>> the FIXME comment. If a user attempts to replay a root commit, the 'die()'
>> in 'replay_revisions()' will be called.
>
> Please be aware of your surroundings.  I think there are multiple
> topics that work on this file and among them there is a topic to
> address the same issue, if I am not mistaken.
>
> The list archive is your friend, for example, you can try these:
>
>     https://lore.kernel.org/git/?q=replay+root
>     https://lore.kernel.org/git/?q=dfn%3Areplay.c+%22root+commit%22
>
> Thanks.

Oops, sent without completing what I needed to say.

After you find out that other people are working in the vicinity,
some of them even may be working on the same itch you had, instead
of silently letting them continue, join the conversation and help
them polish their work.  You can give reviews, you can supply test
cases, you can polish their documentation, etc.

Let's make this a team effort, not authors completing against each
other, or authors working on their own thing without paying any
attention to what others are doing.

Thanks.
