Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8EE318B85
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799978; cv=none; b=f3pjwaZy6pSRaSjdKCu78jzveVmIFnJ87WC3A/3OWX1k5JYKIrLEwwM8M3ETIWOW4Go+vHG5ZtfuCaGHkrB6pr4/a7yIn0C/qmBUBfEz5cjMkOtdNbqHTFivETcTHyWoVDEfzyZDoWZPtskFokgAZnbAqqesD45Y/eBOjpGGwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799978; c=relaxed/simple;
	bh=r3KvzmirWkUVvAyS16Kz0mTiPszxoL4QyPFlw/W+pw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jRMTNotYTRlH5udlNOthR4vMoBMmUvFgKRwd8+DO8f+cF2t9C01UN20TMuF4yvOjYFl0fo8e9XyPwMrON25AV9SAlLFcTXZoYuFejcUhRHqydzJQAtL8dXqJykgCJUDGYXbJJybihhGWrgMJEa/u/2W3myybT6A5QQOmbkqEkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DIWxgMaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cDBn+6SF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DIWxgMaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cDBn+6SF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E937EC029A;
	Thu, 18 Jun 2026 12:26:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 18 Jun 2026 12:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781799975;
	 x=1781886375; bh=0Y3FvVnNgYMoqFlYdfUdvFVYGJtKbESc1fcitrWpcr4=; b=
	DIWxgMaMEEztP8RgvYHeHfyFAlmAvU390oMRsVTkRerLmjv5gto9mSr3Hq0Klffh
	nbEMkWTBwyMUCs0l222CrH4j5xxAqhTXU1KwrxRLtCiYRdLdHnzATowlPL+1rfmc
	leAtFv/nEcWXT0bXJhYjL7OHzYVPv2QYPH9T70Fvqo8Axh817sS5ggDsDpbmXMGZ
	W5s+hp9H61TmunHf60AJKIgvjc0Av8GJmIl06+GE7xtuRVqN2KKEvDf6fNigZ1QE
	NhGffyPJqwgqBhuy95BIYDN+hlJUKE1/CUsP+PobuJgBEpOMqc2IT6KGpewgy9xq
	0iaKGwAL87VCe139RdsuXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781799975; x=
	1781886375; bh=0Y3FvVnNgYMoqFlYdfUdvFVYGJtKbESc1fcitrWpcr4=; b=c
	DBn+6SFd6q5B7kKOihcvWTR5Z+4bMGWRdrNFtpqqgIi1Q93S6NuIQw27YvUoArJc
	zVmMeXr/3AhaOfcRegOBspFi/ExcpS/mWYn50/TLmj4v8JEC6Rn0Q6JMzHwLZpIC
	H+99lJU09a2fMO4y35b4hpaKFt/9ITuWQkR8BTcjmdZSeXAX5atUYNS8IB/eZML0
	sFgCjuHRtyc7V79zQCGKnBpyPuUyoVDtopq7Xa59HwERN+lyojqLXt9eaoDSI/K2
	vDwolZodG9GIOhoVyjqqQhu+4hRqDz97LoIQqUomj/9cw7AR0lX6PKC8O7K5vSs/
	3b4+PAGM80f0qjymkBn0Q==
X-ME-Sender: <xms:Jxw0astJCCnLT2eKMiJBcN7Zy59HfGyaQ5pD-4uFxaI9M8EqVq-9Fw>
    <xme:Jxw0ag7Fya2xruDJHOWtm8rib8WxCGr6bBBVxDrsp6GssUxIuksXhQAGzzG9ZpCZp
    XSEzRIY3_UNjByv3LAHda0R62uGPWxJmU8BJb8MEher73V3J_noUQ>
X-ME-Received: <xmr:Jxw0alKDWUe9PvjimafCBQQvIBAHKT6YBw5OL5o6fSpE0iMu0ol6tJzF0Zey-Nk9kAv3BvqCqpwmTRyJx3bbyp_6UHZvzNDSPfbI>
X-ME-Proxy-Cause: dmFkZTE2emUgX3Aht1+9JZT53Nc7GYWA0brQyP/LrnsQ8OY5tqN42LLpnVZ5QITWMO8w3S
    jt9Cu88aF+255sUef3bqfh09AfjUVSofzHohZJoOM7U/pVbYz9q8POIps2RSQbxHQ6DM13
    Wm6ei18P5h2OIFeOK1iRMlylGhQ+7uVjhh7pTu7kWGhaqGwn2wWl8T41kx/ZIobrOtkFE8
    TyGYnapy1LmBrszSXqurwgh4mc6zVHOeCp8u5I2T/ndiwrg8EASCwbrSXCQtSuJ50yUDsS
    E1mrnec4i+NegpPy44hTU+hAb3YjvB6KhdIK2ttbUzA9n3H4TgM89mqJEqnhZQKGA7/zJL
    Dv5lvgohsceCKpuc/wVLeE8tR6zD2C/mViOgpT9eRYVfufrR0vt72KYFD8ft1oxtNx7C49
    be2OMQfncEjXbprzvD/uHLYBw/M0yV4OGaVlEyOZZWkrSnZ8+OpEJjPSzYOiAI6J1d19zL
    RvbT8pwJGi9yGEtDWSz+ih6U13/0rS9PWvju10QARvJllkQCStXsCqDiLtnMwfU6ugVQNq
    yRsZDg/5fcnUGm/AsEQt/YenlrYhxvpEOyqgQE1SR1o6uPq8b9ODnK17clPcP7nUqjKk7D
    va3Fv4itGbx9fK1INoejZDUN0cOPedFscl5VpuELxYUZIkD519E2geGWbP5g
X-ME-Proxy: <xmx:Jxw0ao4Ze-GugY1KfpcU0UJZ3QQUNQ5_uCoaUsvbuGQuG1lwwBPCsQ>
    <xmx:Jxw0agzxqLePog0n6ZB_TKyzoZ-OTyzgi_JFItS-g48OHAUi91esOw>
    <xmx:Jxw0akbrIKUiM0SumAtUpIpT8cqgfHprzusOSmX4yFs0SEgL74PUIw>
    <xmx:Jxw0aqQawOg0LZ-O9GZJKwQvaHYj14h-6qKUgR0O7_nvaL8Y0PDa8A>
    <xmx:Jxw0ahDSQnTIzg7fSYG-D4LyVb98Q8_CKD8i8kmyPmdUeHUldw28eiy2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 12:26:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] SubmittingPatches: address design critiques
In-Reply-To: <95cd81dc-baea-4318-9f01-6a795f8eb5bb@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 18 Jun 2026 16:43:32 +0200")
References: <xmqqv7bhxiby.fsf@gitster.g> <xmqqpl1oteoi.fsf@gitster.g>
	<95cd81dc-baea-4318-9f01-6a795f8eb5bb@app.fastmail.com>
Date: Thu, 18 Jun 2026 09:26:13 -0700
Message-ID: <xmqq4iizstlm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> You can imagine someone from group number 1 who is *not* in group number
> 3 use a weekend to implement something. But then when it is submitted it
> turns out that is a very “centralized CVS” idea which doesn’t fit into
> git(1) at all. That’s easily spotted by group number 3 by just looking
> at the proposed docs or design. Now that group number 1 individual might
> just have a bunch of code that is dead weight for any proper Git
> workflow.

That depends on how obviously wrong the idea is.  If your proposal
is to write another CVS into Git, that may be too obvious it may not
fly, but the thing is, "proposals" that get the canned response you
quoted are often vague enough that crucial details that divide
"iffy" and "obviously wrong" are missing.

One way to make these proposals sufficiently clear to allow
reviewers to tell the difference is with a code that builds.  There
may be other ways, but that is one obvious way to start a meaningful
discussion.
