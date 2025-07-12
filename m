Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915832F5E
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329181; cv=none; b=tD9hbgUTbzmh4Bgrt10kn3zV0Aq7TtOtC5SjAzISt3T1RQnVJNeMbTpelqOysZHJpvi0n5pn232qKBVh13cTV31dVVjVBMLuiVtsKaN7Uu6jIJGNyCLU/V0gUu3Lh5zxxOgm7tkhZI1yhwzs0zV7/Pq5L2UifHVpL0eiDA1/NrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329181; c=relaxed/simple;
	bh=hCQQTuMs7BBc3BT0RsVsdmKOUDo9VKx7pBtNTR+6tp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dfi5Vv0wJZAjBlVtzsKt8UNFiG7xBpzWutQZkrKVbWFy89e8z17NeqVnpxPsA9+u3DHUw3YS8Z/tM1fD9tARZWaFXczd+YaBWT8G7kikiibJwX+LMV0V52C8VD2F/8fWGr7m9HIiFT5b7Tuqide9Q1DgmuN/X1KaUruewCbPrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kyNOgyO1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lh8kepCY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kyNOgyO1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lh8kepCY"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F582EC010C;
	Sat, 12 Jul 2025 10:06:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 12 Jul 2025 10:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752329177; x=1752415577; bh=3ZtR23w90K
	qwb7ORI8ZQb/Wfz+3z9jPe8bND0kN2lgY=; b=kyNOgyO1qzVYce+MGo15B/MmUe
	P5d4nnColbOJj1dv8pGpE7yCE8WQWjnh9qEMhHSkGuKdOYjsgX8e+nQ7Lua2UruW
	YVk1shx+Y3Yr2RbeBqH9xHqw9GMTjPRs17EY86E1sPFGPErgpGoSIGO9jRxQEL+W
	DHluewxQmBHZXaV8tp/+LQ4RzygwcfKZZmKbZphOwX5igzZArVXOMX8cecj5xWh4
	RPrYXvBmoBswhCiQKUdbYDinvfowGi3Y2NkRxSXTVqeEO0ybSYx8CoBRBLQeEOsv
	1HJ5siBkzvXQvP8iLhSu/rubIJhsTNx0H9chT7w/2BCWrTeNbKQ5X4aGR3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752329177; x=1752415577; bh=3ZtR23w90Kqwb7ORI8ZQb/Wfz+3z9jPe8bN
	D0kN2lgY=; b=Lh8kepCYs3W0TpoFGX21NGvo0dt9rxd2A7uoA2ofL2SK2iUGIZF
	IcgpLiyDW1QSHASmPksjvSTnLK7GmDl1LJJ1sMB3anr6XSY479d64zm105z4PE95
	yvtsnvzwrKBv5K/c5MVruX5BOaG3Imoqz/VwE7YGr+AEnDxUWYFdNPssya/xMW1g
	MnQWeBJIccm3AermEZipX/44Oa4KiuprEBT2GLvFWFkaueZY4d+eEwlgH9iiIoEw
	W+pWDjWxoh45Y877XAR5Fu/D+PbPoEmgCXqah8V4THWhN2w9mF4FR85FWr01fpBk
	u1SrB8Ok3Ijj+sshNd4Qf33Sw1jgLgNp16Q==
X-ME-Sender: <xms:2WtyaNP5gzK657LRWxHJZZGrN9XQe3sPIbQl9VjU9kuazKlimItkbA>
    <xme:2WtyaNjMbEh005BPBiuNBqizxVV0Fz-E_5GzN7SI6V1Aru-Eo3IJJ-qzlK57qKJp9
    01hZcUhjTtD4SeNdQ>
X-ME-Received: <xmr:2WtyaCu2LEwviMBnM9KKwyHZSCZlGo8OPU8Kq1Rnvv1n4v5U77IwZZ3utvj2UybQ96B_xsLG7anbu93MggMSE_usytsslZYQML-lhYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegieegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgi
    druggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:2WtyaLQGDRzLnYTkE514mA8AiU_q3LOtXjd9lylNPHOdXoffqVShqw>
    <xmx:2WtyaG3yzj3KMzrbJmSVd-zXNlwNxsztrBbKIh9jWUzTxoot4SzrmA>
    <xmx:2WtyaAuCQbWuOTdzzEeOD1KnfBF-kNqW-6EqpwolP1hriRPwLltHaw>
    <xmx:2WtyaMg7RwIF1Q79rd02-jp9Gc670Aw8hkfh965PjAUWQjn6UeC5ug>
    <xmx:2WtyaDpU9cRx5Ptnyx5drm8PGANMs-aFd_dzIDctByidwY_IOePgvRoj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Jul 2025 10:06:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
In-Reply-To: <aHIWaQUC_wQbMw-V@ugly> (Oswald Buddenhagen's message of "Sat, 12
	Jul 2025 10:01:45 +0200")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<xmqqjz4iv7mt.fsf@gitster.g>
	<f679151a-c843-44d4-9e28-27112d26f30c@gmail.com>
	<xmqqfrf5nxnq.fsf@gitster.g>
	<b811a0dc-fb49-4f66-a9ae-89a45d7ff104@gmail.com>
	<xmqqsej21wsq.fsf@gitster.g> <aHIWaQUC_wQbMw-V@ugly>
Date: Sat, 12 Jul 2025 07:06:15 -0700
Message-ID: <xmqq34b1y04o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Fri, Jul 11, 2025 at 10:07:01AM -0700, Junio C Hamano wrote:
>>Isn't it last-one-wins?  How about just telling them to do without
>>any "git config unset" [...]
>>
> i wouldn't bother suggesting specific fixes, and just suggest using
> `git config list --show-scope` to figure out where the config comes
> from.  waaaay simpler, and avoids the pesky policy questions.

Yes, making it explicitly a responsibility of the end-users to
figure out what is the best approach to take would always work.

The approach taken by the patch gives series of commands that can be
copied and pasted without thinking, which is, even though it does
imply that we make a policy decision for those who do not want to
think for themselves, easy to use, though.

> i'm also in favor of just refusing to operate when the 'auto' setting
> is encountered, as that also is the simplest and fail-safe approach.

Yes, I agree that it is a very sensible thing to do.
