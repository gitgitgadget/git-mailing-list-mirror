Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654DA4E2F15
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400433; cv=none; b=bEXa5sNdxgRVXWRmJ+rHRxpuGXv27HsR3mo7u7kwLO2sXB8Egugq67s5mxxVJVf6Td3620pIusGYmwMGjx5lGpVoUsnqfLMXO0Mon9xp2Qewqo18s4mXy2Lzyg85m3MlP8WliujiLQEs4j0o2Il2gh/K5TLltIq2IzkogzfKyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400433; c=relaxed/simple;
	bh=8kXvIKpbxX7uRzov8oc4TgJmvULG2zOEnk3dpacso9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFFjFvD+3d5kjpzlXQLGeenm860NQ0L0zQ5//S2V0uja6UHfEkjtAfPj2Z3h1gHagtfi6zR29unjpt7H+wWn2/SWM7orEkwFyJD5ogCSQW5dIHyeVdlftx2yjuevBdLx8vyOC2IBVprZhK/KPbMGV40SkXFqspmpZeiE9ohFnjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UBEhBpYk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HKQ+MfBv; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UBEhBpYk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKQ+MfBv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B095F1D00173
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 15:13:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 15:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791400430; x=1791486830; bh=68z0EW5pjz
	ayPpwi6WlMbYN2bQyIvbGvQLgRXoo9Hp0=; b=UBEhBpYk/VGyehWqMWoSrDVZDJ
	NquaEbJeVcfGN4/etcOTNZa24ChEOlVOER2lgnQnSU7t2ladfRzbxH6wm1w7kTlL
	wk2v55L73DHrwpDQ8MQzaQEdPhHbP7d18fJaKCserbTtAAO8mDPGgpaWeP+ss2yB
	H2CVvD6tBUiHXpbfaRSUsTIe64YFgOONwgMv1rd100zrSKYC+70B4Rr88l/7NEY8
	p78GpRV6BO4tkcokvWnvjvTP1Wnhkp/Jps15ZQ6QPfRt8eCH5YD0d3OKwDbqfHFa
	r+0f0Xr1qu3whyNQyg7TLL7qrzN6bl//neFLwYAwOtbb4C4LEr2lOjrFI1wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791400430; x=1791486830; bh=68z0EW5pjzayPpwi6WlMbYN2bQyIvbGvQLg
	RXoo9Hp0=; b=HKQ+MfBvYU02TqIqLohe+AGGXsn9ptBp6+d9mlxNJvTE/6SvDxX
	PNebVtQ13+pAnUatLfFhaq7ON9I9eYQmlBev5EohtF3pNj6nzzQac16+x5jgmLpV
	s4szTTiNkqyF8eOpE1m+4Pm9eXCVh497R2O0eMIE5LENuIluFk4HJ1TqdmdxjGBa
	cfG+SeuLmgGXGjQRZzIQ09FWlcFMV+C1M/YmlbVdfvn1aQLKwKu66peN/B2RlQkA
	HvQ42Uj4JGwAsFSKgYmQ1Z8X9dj9lh07yOUhE/6w7ZorplJoIljOVnZK03m7jQa6
	zsOC3b/pwYrhYqcVZ7JCCZl9o9TEt/BPwww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791400430; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:mG8Gytebh/gbfIpSGQ9y6y6D0A6Od8opfUYQBJdggmS2H8A
	/iWkRZyj7jDW6hJwNahYY7c3JNpa7Z0ky8J61Pr3RB9JKIUiPndiMXFO3siMBt77
	YDwALWpBJrV5zok6cQIuIEhoPU4FaoLzHk+caUCx/WREtSE7KdxwKnf143NRypTr
	EsLmQQuAQxiEHkLVChCdw4Msq+y53+0W3J6n2qAPgrcjIUnMUdWZDUNzUFcaK/QD
	uQjQx9omDxvZLsQ90KFBFPzIce6V+7HhT3hVlIg/T/UTbu9u2v9jctpzJmck6O5Q
	irlqrUHvs/pgze/GWWoUSah2BnajGhNwG0s9Oew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZjKy6rNor0X28okVUkkBVytAjn8UG7KBwH8+u4EAJ6I=:8kXvIKpbxX7uRzov8oc4TgJmvULG2zOEnk3dpacso9c=;
X-ME-Sender: <xms:7pnGao1O8KBg8OUvRi4vtvcjuz8iUP1mSxWnFkH1oK9LHok6tA5-7A>
    <xme:7pnGamxhURTLtLZI6CtJ2EmZL-Ko7_26Ev4UGYXv1uvoR8yyxrLL1s0pZLp21oQZN
    d3pxCvK9e83B6sn670TvQ6PWsec34XkoqAZyVlfKjVrcMG7uAtrEQ8->
X-ME-Received: <xmr:7pnGaqvdgIRFyd7gHjTSSMtmDRREzdIXzd9UxJHKNE8WPXeE2UhjLk7L0iLJUXpFG0tECYtBCmevx1YYCkNwuq23cRXl1EqMB5fK>
X-ME-Proxy-Cause: dmFkZTE/C3zQSb9G10hRrxybfM00w60abLq2d7HoC6S748GnPsPGwoTKYl9CfiCSiXLLJ/
    elLLsFUH1xxMc/U4sZIX4KriCMCXF/EeDN3pXk6bcxXbHPl5Emmd33Z13GEVd7DiSfhI2J
    STjhBsaTWiZZcwEzIH0W1NgHBMgFXVaiwvab2wJusOfSYZ09GsTo8MbtPCeRu3EVpRHdKh
    8CYKI0j8SABMjlpzNRi3bSYFAmJaamzenvs/I/vcCXWGd8zYSAtm/6r85s2FlyjmAgcmgn
    lwpM9IwRA5HpnDJw0LAEhWDCOcihAKKq9zd85Kcw1A26wfCwj3LPklfLZIEw0srqOegrNW
    2Gmfjo61Ms3RmqHKdPMUvIIFs+IEFhlD7tAYUU2g4jTaSoX4dtZ6jBkzs+vrjnrwjhp3Dj
    hf4vOz28078RMbLmK2p64o0kSKg/4S2qw5SJydjaSp27J4kUZZ+483W9Km+pUWxL5WlCuO
    ZrVcv3iSQj16uKQKHKCjZQEIvocTPMaPNwsorC/WBVl1X+uE/bX0JXXKhK0MUPvQ968mpE
    5ruNemiDVqQ7AJSh7xZ/rZUnc52RmJ9u2QB+MyhzN8Gx4oAAhFFYk5x/D1xdpXoTi4w62I
    s8rGzHMyywuuzFO2YTYeplJroNnljiNFu3s3hlFi0jISCjzjYIM7WiUMtasg
X-ME-Proxy: <xmx:7pnGaoxzl7kOJ5H8iZirGSK-Ng3tibA6uMsgFq78zdQEOc3s45FYfA>
    <xmx:7pnGatDJ0WpUcKRobjXMvVZaBqlrFAnhkxmdA_3B71wZM5SuYLO_Eg>
    <xmx:7pnGamfsk_F3W4VQxACfLBH5mPn-dd99hOrD2JcaPN-rIdRQhgI62w>
    <xmx:7pnGanmoXBGOlZmOEHuMb67c2lB_UMYWFEbosuqsz8ACABX7KlQ1lA>
    <xmx:7pnGavbRO6Cnn7iwg678eRbhI496TdaHAQqJBMoHBualeY7Cr0LZCnIv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 15:13:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: use `man git` to teach users how to navigate
 the docs
In-Reply-To: <pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Tue, 06 Oct 2026 20:06:03 +0000")
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
	<pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 12:13:48 -0700
Message-ID: <xmqqfqyh728j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Many existing users of Git don't know how Git's documentation is
> structured, and a lot of folks have expressed frustration that `man git`
> doesn't make it easy to find out how to get help with using Git.
>
> Explain how Git's help system works in `man git`
> (`git push -h` gives a short help, `git push --help` is the full docs),
> since it's a slightly unusual approach.
>
> Remove the references to gittutorial and giteveryday since they're
> unlikely to help new users learn Git. Currently they feel very
> aspirational (it would be nice to have a tutorial and a guide to
> everyday Git commands!), but we should give users a realistic view of
> what the documentation actually provides.

The text mentions removing 'tutorial' and 'everyday', but does
not explain why we no longer reference 'user-manual', 'datamodel',
and 'cli'.  The third iteration should justify this.  At least,
I recall that adding a reference to 'cli' early in the document was
a deliberate decision, and we should explain why it is no longer
relevant.  It would not be surprising if it has become obsolete
over the last decade, but we still need to spell out why it is no
longer appropriate to reference here.

I wholeheartedly agree with dropping 'everyday', which was written
before Git 1.0 back when we did not have much introductory material.
It was not aspirational, and while its choice of twenty commands
suited the workflows of the time, it outlived its usefulness long
ago.

Thanks.
