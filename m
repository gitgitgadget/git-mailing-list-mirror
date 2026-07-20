Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E84302E7
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784585669; cv=none; b=JqEObeKV3iEZVeiyHajXcM3ZOHrMuLAqHHJibK6eVFf0yCdl14bV5uooYsSErU3nUy/AaLGxBAVYHOYAj/wSs75nTKmPRGuuXNS13HdTcywPtZbM8enbDDvCb2xQs8jDNqwVz9bUu7VXy10br4ORy2abEtXcJsQCtFnHGmrvhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784585669; c=relaxed/simple;
	bh=vymIz1TvfSuLc74nmoCGEsSsTpuCQODVL/fQxdf52wI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EqRjZrkSl3EsXEUAb/6jvOIt0ZoxmP2qB0qrHi+lKHms5uqV24UQeHL0zPZicVN14Qmds7HHJdQJtTxC1KAd8bz2TrGyJbuSO69jH59nRCJ5h3H6v6rbMlDZr9Ujerrs9BBanFcDKTOUhsgU2xC4GjeWy8S8fToyduJ1+3Ppl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qS7kfHL9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qkd4SDph; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qS7kfHL9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qkd4SDph"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 083AC7A00FF;
	Mon, 20 Jul 2026 18:14:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 20 Jul 2026 18:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784585666;
	 x=1784672066; bh=YSGIZLRxwBqAE6LVqMW41hH6LzLzqxU71ebCHku0N+c=; b=
	qS7kfHL9tdskoD4+zUhL+LwK2j1RsO3bUQHIzfMGIpl8wHNVx3V6SIvZXUbVRmcn
	CKY1uI5fz+e8+yOtTgsZf+ObnoGASRtHMe0Zh7s0OuvX6OYuyJxjPbZm34IT18fW
	zg7w5miqXC9imRobDO3K3N7sJzxTrvrJSxrkD/NsvJNi4pdY7JOu1qR5A8GOKK66
	5+P12lA/TyFOyP5J55MBmW5jatULiDgYr81/z++VajewzhCDeY8uatLhdBOxAlM2
	anRsOyW+WZTT4ZgHR8ZG3/+TFGsYy8hwrIeRauIQJqTTtwXdPydrk+xFlv7putYf
	wjVByV7Pk/EvzTOmYqshQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784585666; x=
	1784672066; bh=YSGIZLRxwBqAE6LVqMW41hH6LzLzqxU71ebCHku0N+c=; b=q
	kd4SDphEN4wnhWlY21Udwo9OSIjIjTOXnovpOxfD7fC6Nxd/6dkqndOZ+gFYCZpS
	t7/WaOM0YGJObaHYYzHMA6YetgzxUjXlMdzDIQMxeQ+/PYKoVh0RA/Vd3bxC6HN4
	vLCdzBUV/yTvWglBQb0ht2B6sAfkng9eJY0guMEJpZRPK4BAcNcfbRmMipfUFxbg
	wl1KdgSA0QUWXCDiVo2ikElO4jdjoQXzMaw716Zfd+eC4fVo6YNLpluor4kasKwe
	jGx+aLLnL2BKqLfIjJvKYPegqFNm+GCoqiqoOHDsvdaXkoMiyz3M/fKGVjDwjvh7
	cGtFtwvZ1y3DQF5e/B0bw==
X-ME-Sender: <xms:wp1eajcSelZXku6CQj3cVGvzzMWl-dtwVvda1zHAhM5p754g8CW8qg>
    <xme:wp1eauLglwgx-QoxFz4xr1mQ-mGc0qJ12MLvFHQQU8AKeIxTpF2dG-MJu39a-x3qd
    wOwWtkcU1PoUu9nEBAapugasq4v-50P3l2Rq-AQjjaDq-pQ-X8y>
X-ME-Received: <xmr:wp1eagz8jep4PK6UbFFJ4QNkd7U6VMeFfqIKKauFqCciT8SmoRZsY5pRyZ-qBBZKsmSaiAlH8vk6ysYpB5j_jayDnrHTn0ooyg>
X-ME-Proxy-Cause: dmFkZTGNJRN1MAJIOh4VC547Thn+TNVrohJWo//tDUGTKIOsnAfZQKRpIh1SiOqgMdLj+t
    gKEwCIsECmxKXaPh3CXdGJyQfeXQE+t0RT+or5s1MnLQpe5vmF/C86fKiyhwmXdGuXPSVZ
    3Ne320GNDZS7M1HSnVkktnOVEI1WUZU/klGQqP0kitqYMrM6JwVL4TkQLUfEU4RpKMNodT
    D5qoBGKirtxLiUBHTVqXG7H3jeEIAr2K3Uc9Y72K63NBZu3gKiuG2/xldmSUnqx/r4eWAx
    hhD1qWaEONiwN79ml0t3Pp+zjVvOR2atznVKNvNIYjScbZcSqkX1B2EBdEhp3ALJQY4rac
    BjpZ9rXbPOkAsdJV6/u1yF/JiaiojcAu6p+u8huIDhWVjL5Lrwzw4LGjiakzXLcDYrJnDO
    nAJHGh8KZsfzOg9rKyR2zypxoVMp55dIOLCIozGxZ+tKuuKw//WEKRSP/UKxPCbUg1Dr/Z
    BdPUgjjmJyYZnV13g6oc9yrG3koPl4Nd/a25UKjvn837LQ9nl+uuHcnGlkRIxTuRDxrcny
    bAhjPhEIP0z0Gjfxpzra8nD1I6iDkQ7sOCdkyeicvwPKDUkCN9FJHhx3qbQf6peGumDLP2
    dO4STerQo2uMWtjGUUWGeXXUuMsDu6KIKBEPnqJrjG7wUW5SWGJ/lN5xHEGQ
X-ME-Proxy: <xmx:wp1eakvPmEPzblcAcafr0KDBPGd489ovfxhn9wb2z_sClhW9rFJQiw>
    <xmx:wp1eajCheP73o4Zlz-eozxomV4pQmckeGkfbm8dUbWSzkejCul19_g>
    <xmx:wp1eamGoOWp83v6jKSyJUlSbY56408112anyt253PJYFejkVGr1x5w>
    <xmx:wp1eajAQ5tJOkvZzFxjSCwDM1JTsV5W55v4xHV4zK5M40PGmyTiR5A>
    <xmx:wp1eavrjORjIMEa3KKgykS1U1Hjoh7koVWmxJgCvesPzFxvzmqxQ68UF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 18:14:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Elijah Newren <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de> (Johannes
	Schindelin's message of "Mon, 20 Jul 2026 16:24:00 +0200 (CEST)")
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
	<20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
	<alR9GDNTbdjWB4dq@szeder.dev>
	<2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de>
Date: Mon, 20 Jul 2026 15:14:24 -0700
Message-ID: <xmqqjyqpb96n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > My own (obviously subjective and biased) take is that the tradeoff is
>> > worth it, as these issues are a one-time cost while the benefits to
>> > discoverability will be permanent.
>> 
>> It is not a one-time cost, but will be an ongoing burden.
>
> It is maybe drawn-out, but it is a one-time cost. It's not like we're
> going to mass-rename source files to move them to `lib/` every two weeks
> from now on.

Since the topic was posted, I have dealt with the fallout from it at
least twice a day (which, when we are lucky, is not a huge time
sink, as I have mostly automated it by now), and again every time a
new topic is posted that touches the moved files in substantial ways
or adds new files that ought to be moved.  The latter is the most
time-consuming to handle.  This will continue until all contemporary
topics, as well as the topic in question, graduate.

If that is not an ongoing burden, I do not know what is.

> And this statement neglects to acknowledge that the lack of clean
> organization of source code files is an ongoing burden _right now_, and
> would be at least partially addressed by the move.

At least, Gábor does not seem to think that the lack of clean
organization is so severe as to warrant a massive code churn like
this.

I value stability much more than prettiness.  If we had started out
with almost nothing at the root level and almost everything in
either 'lib' or 'builtin', I would have strongly preferred to keep
that structure.  But since we have been using a layout that has all
built-in commands in 'builtin', with subsystems like 'refs' and
'odb' in their own directories, and everything else at the root
level, I would prefer to keep that organization until a substantial
subsystem update wants to carve out a new location for itself, just
as past updates to create 'builtin', 'refs', and 'odb' did.

Compared to those past moves, the proposed change looks more like
churn for the sake of moving things around, without achieving any
real organizational improvement.

I must say that I, too, remain skeptical.
