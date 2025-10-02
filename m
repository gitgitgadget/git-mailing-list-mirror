Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE096148830
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431668; cv=none; b=shmt+AOBc3t1gISYnYOpIG7ekU9IBmma/r2mPMkEinx6Quoobr64L8plcYVIye9l7Sj4+JWGViU2GzlIVi75e/nRwebxEPIKUISAUNqpcWKOGFligNAcnF6f/YHdSAySxdowaU9/BSL6b0xAkIYVisiN740KQ2O6VpjQqHg2ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431668; c=relaxed/simple;
	bh=FTWt+AMSmLbl2/bEzFIuUBcQ3ZvI2MTQisHN7F5ethA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ob7JxltMU+d+TBAqFbAZTR2adamx3XAne9z6MTy1EiwIJJCGWvFEmz+hmtYgMJT5wHyAsRxTQrNICN146owAMKLwmbZ0jtK9KJ0N4F91aTNmI4S26Q6JRQMzuoG6/HbCMB/YxQXz6nTkzPhUYpURAz6JKTV2Jp/pzE7caMkbb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gJqTNPSs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LM8VEESA; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gJqTNPSs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LM8VEESA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B19D17A0163;
	Thu,  2 Oct 2025 15:01:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 02 Oct 2025 15:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759431663; x=1759518063; bh=FTWt+AMSmL
	bl2/bEzFIuUBcQ3ZvI2MTQisHN7F5ethA=; b=gJqTNPSsPtmZNwWicP80ppDi+L
	0ROikdeqTP/4YLab3DD9a4II7i6Wq6L+BTruc6oJf6UwaNKCSv7wCcP4XE3F3s7p
	w3fXg6CZnrxDgK05bVDPvdL77zgY75fFyD5mn8qlDM8C/EfucPdOOKYDm6nekV6B
	Vky9ox68bX7LJC5Bag6mR1egThxwg6veNLfnZZNIQPEkxvAnWW4w2SYxuA4ubhWx
	zuozggXuwplbGtl4C0InalBjhaWNhyhnLwGwUhoYtkRVewnFYhIX9dUEkJbdnrHG
	09ZihrehCXKlNcLgeS0mDwFKb7IwfOm3gIraQqsk2m/DA03INqLtb+v7zjFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759431663; x=1759518063; bh=FTWt+AMSmLbl2/bEzFIuUBcQ3ZvI2MTQisH
	N7F5ethA=; b=LM8VEESAEb9Imy6QE++iJiyjwEACi07NxGo0c9tJgMKNAHVArpH
	ks1wONXu69VESE3hIvPKmnY4xAEKWJchqMvn0jU9pTBjkOaV4qLr3QGHOcyHmJws
	k85g/FmdXUTnTienchwaAXyB6SMXUGKbIP0IU3r6sA/z0vEDzpwblp/qezrcz2ik
	XhqCIgmeAv7qg/VYBo/yQGZas3wj6J4qAms/DM0+eOxBs4eWK40ZB/3McnxtXjGO
	YQKHFe5ciUQS5uoo43/OzMzs9r/VT7WqvsHnaCp5BHyQecYWhF9N5rqtsgTaeqC2
	tbpeHZW666qOKMeSGGKtgimNLYEApAHEYtg==
X-ME-Sender: <xms:78veaMorpieDKyr-0sAX8kWZUFnymtVSvs9AJU9SUJR3dTQ21bRs9A>
    <xme:78veaJgHfdIQpAld2xkdQcJyJZ6J94P4_jTGAYgfEVYRTKLYJ_jTOJ1QgY1GhvRPH
    mMdgwukD3AAu4Nk-wmWaMEtyiqMcjPqOVWNnDTx7LF3767P74_IkQ>
X-ME-Received: <xmr:78veaJheQWcfjKEL26g43yAYl-kZyMoIPNbXv-HMOQ8YngzsbvQh26MfXzaJsSY5VUySzgIyTCPQjP6UC7hFM9xPnEQkr6Y2wOBv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:78veaPgAkzshr0NLc8tSd0L5I0Vkz7g6pRd07wos0Q7dk1yboQPlVw>
    <xmx:78veaJL2K5oPqQzemV7RyMyswM_C8ZgNiS1RySBYsHsq3aNZU8NKBw>
    <xmx:78veaOGB0xLs57rrm60O8wVlAvIVSQjz7c-acFCWXiXZ1g0AVMXh0w>
    <xmx:78veaNS6YzqNVkUqf-CR6qg6A4J0uYcCMNOSdp7IoV8_jd_yRK6LPg>
    <xmx:78veaCxJJ4CytvX6mBA1fA0NkkxwfErexa2kaeT807L86ve-xzl9cNRa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 15:01:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] make: delete XDIFF_LIB, add xdiff to LIB_OBJS
In-Reply-To: <CAH=ZcbBQ2abBS5n=_OZ=qY_K=on9sBa_sK2HbbBzbwa41gWFQg@mail.gmail.com>
	(Ezekiel Newren's message of "Thu, 2 Oct 2025 12:50:33 -0600")
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
	<28e7fd27b632eeb681e7b9af4de2d18cd327be2a.1759341748.git.gitgitgadget@gmail.com>
	<aN4R51_j2ieF-sjy@pks.im> <xmqq1pnlzayy.fsf@gitster.g>
	<aN6bL07N8Qz6USTf@pks.im>
	<CAH=ZcbBQ2abBS5n=_OZ=qY_K=on9sBa_sK2HbbBzbwa41gWFQg@mail.gmail.com>
Date: Thu, 02 Oct 2025 12:01:01 -0700
Message-ID: <xmqqy0ptuo0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> I will go with your preference Junio. Do you prefer your way or Patrick's way?

With step [1/3] shuffling lines around, the advantage of keeping
XDIFF_OBJS and REFTABLE_OBJS to make the result merge-friendly
disappeared, so I am perfectly fine to throw everything into
LIB_OBJS.

Thanks.

