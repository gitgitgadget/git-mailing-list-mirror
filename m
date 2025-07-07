Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4F189906
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908356; cv=none; b=Nf+zrM1b0Lv0bXWZd+1Qp4dve9sqqI1yHdWsf1GznFfdEjwbDontdAFcKWmX8jk1VX2CDM/nRrd324LC1Je2Q2QF1i0yqU7yZuVvBC+hjv3zT1Vkul2dPCnLWszwxAzIZSt6H9VQKg8C1ML1G4ertmM5Y+afqsupXQHYZjrmUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908356; c=relaxed/simple;
	bh=0KaXYBX1Uk/PDN2JzzVstE+Bv5yAkQgWu7YfEMvpmtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O30klpbZlWR7Bhu4d9BI4sj4CcCt/tXQlKnmiTAIGikkpEpMLadPNWnxnhV+fWg9enKCQ54cHMK5m26SQNB5NC8tr256y0C57sOH1VobvuFhch2eBD1D1qgCH9grYs/GZcBJJ0qowxTsjBImVV6l1hAk4td0xdfHmeHD5LBHcNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MNdmh3W+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IzH8v/1i; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MNdmh3W+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IzH8v/1i"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B4BC61D00094;
	Mon,  7 Jul 2025 13:12:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 07 Jul 2025 13:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751908352; x=1751994752; bh=TKotJYqZzQ
	YBbP1drciDN5BWyxWlXM1rN83xGY3Za58=; b=MNdmh3W+Pj2VqBAN7POa16SdqW
	8l9VJaE4ZLsS4+QT3RL9Dm6SQCVanuLK0sNA08bvIro2UEaSom2OI4IKvkR/STN5
	/k02zPrS+Z0wUzAXUd3XWKLlyOINmREB/23VleofI/jRkq7VH/Pu8PCrXriJ+8yZ
	3uyErVyL2PZO744/Bxl9SDsBSG3Nf2DBgYSwLL+WYWkrTLUGQcTrfUM2FHjTAYlR
	zj/UE8vbfFM8KdMBOnteHAQX2n7VDIV9qLOa9mS2adM5l9aLFgcEHuZDQf/XmGGX
	PeDxl0Y4bpSl5gWr9nIb5BNTRyhtttS0WOs9kGc0YpGSlfmvRULH+DfQnaUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751908352; x=1751994752; bh=TKotJYqZzQYBbP1drciDN5BWyxWlXM1rN83
	xGY3Za58=; b=IzH8v/1iLb3nGmtbUbNp7hwOC9qA0lRlcK+qLO7gBRsWkGxgrz1
	Q+aYm8pRjKO8i5k4yT2krYiwooesmDgin53PKQsDO7cEfIgtSNHkB1Hk3bOAg7zH
	KKuaZARpnPLVdXcG202FAZU3+lTCOMCAK16OPjLCmtx++kpIBLD+7fOqNXa4H8sR
	ajgJ62hnNwqj33pMYPyDNfJRlc14kr/pVq/7GSSdAdw8w1qKC4qxlXJbjgsxMI+Y
	S6EC5H3qwyo1uLsraUmmU8VNo3KxYw4MgpaCMgrqY/F4vyFIWjmEkdOmYUeYUFqt
	vuM6mQNytHyr6W+52WnIZeEI2j7UucCeQsA==
X-ME-Sender: <xms:AABsaDpr3F4MArNt4nemKTl7oSrNcPUx3gBgpnC04S_n2oFpC1YE4w>
    <xme:AABsaBeYXNltSXRzlkgcdrMQ9vG-QCfGtg-1jzY30Yq3Kt0K-yrJU7XbOWUN9Yk0K
    xRRVTlHHzr3jBu1fA>
X-ME-Received: <xmr:AABsaJTLkjbWstSbwIG4_yAvjolfyug4_mCYh0oXsD-3YO7f16yWteOoeomcnupjN-Y6RsK45h5nSn9BVB5ytCKANd07rf5qZSbhpxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgrghrghgrsehfrhgvvggsshgurdhorhhg
    pdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AABsaKYBspfxEzD0xa8Z528x82M9zUOLlysxPuodWcvPqdZyUotkqg>
    <xmx:AABsaMfStovJRHcRNet6hJ1b1GTy7nQ7fzaPN5Be21eTbi9hXp7M3w>
    <xmx:AABsaLJGNzM7S4KHG0qbUxgNpABwr8JGQeyM4FimKkFT6b46b36pMA>
    <xmx:AABsaJIjDnW09NiGPYoExLEPC_tMQEI-N7t6zXWkmT7wZ7L5FtzV8A>
    <xmx:AABsaKsQ7sBkjzAxOI6011TK5s-Y3vhNUTWU5zZJOCXGmCudGqHifrx1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 13:12:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  GIT Mailing-list
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Renato Botelho
 <garga@freebsd.org>,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH] build: fix FreeBSD build when sysinfo compat library
 installed
In-Reply-To: <ba0a3469-3a4d-44f4-b1b8-d9c1a825cb94@ramsayjones.plus.com>
	(Ramsay Jones's message of "Mon, 7 Jul 2025 17:51:22 +0100")
References: <e6a80163-47ef-436b-98a6-2ac39c477080@ramsayjones.plus.com>
	<CAPig+cTybBgkwFEsMVNNu2o1w9T5qnhau4chvGU2opEPJO78zg@mail.gmail.com>
	<xmqqzfdg3t78.fsf@gitster.g>
	<ba0a3469-3a4d-44f4-b1b8-d9c1a825cb94@ramsayjones.plus.com>
Date: Mon, 07 Jul 2025 10:12:30 -0700
Message-ID: <xmqqh5zo3oxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Of course, practically zero is not zero, so we could do this in a
> follow-up patch if we wanted to take a more conservative approach.
> (Carlos has a series in progress which would conflict with such a
> patch - but the conflict resolution would be simple).
> ...
> Let me know if you would like that follow-up patch.

Nah, I think good enough is good enough.  Not worth spending more
braincycles on it.  Unless you absolutely do not have anything
better to do, that is ;-)

If somebody really finds the "practically zero" solution disturbing,
they can do a follow-up after the dust settles, of course.
