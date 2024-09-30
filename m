Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD9192598
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714104; cv=none; b=EObRhpZ+o/mqUZkN8wSsqUl9I7d1IJc8+drx+7JRKrC+5gtHAP8XFaswK0tzxrLPJg7qbMsu/FZ33jw6UddEcpWR+qoW71XmAvD8VmkjTP7ZqKjsbPMSC/0ZOgqI5z4hBHcsV25mRD8r8iw6/WWmUnv8pHXepZSL07mRiKV/598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714104; c=relaxed/simple;
	bh=hoM4BOtOwfCPe/5WzSet7IPP5D5iFn3mx04m2yFTuv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=byCLQqTSWIb2F0sGUI1L5M89mAbiROLeeGAkHLdE1nYN2lYxG2n9S98GYNJpLzzstryUW584iV3XW48IuSoSO5buOJFwAieYU34/3ujNRzx4njAxyFDipue/QT/3bgyo/UfhbTWABDE06QXc3zxRm2MCSmd8NzTpioqY2HcYsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u6Rzuaym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TqXZe6oq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u6Rzuaym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TqXZe6oq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A09E114032A;
	Mon, 30 Sep 2024 12:35:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 30 Sep 2024 12:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727714101; x=1727800501; bh=hoM4BOtOwf
	CPe/5WzSet7IPP5D5iFn3mx04m2yFTuv8=; b=u6RzuaymzbK4h/qRZMkp+sJ+A6
	oksaPH2pDXKY5hxsx/Jrt46S2EatKI1xyzLvRFipabjTyxM51mnsn0wjA7meEEMp
	RuyXyU19XTR0bzYuKslOuZ0gL8tW6rQIYA/iuU6OqU5C+PumH9asb/SJHhxCwJEw
	sQknIfkCcyKvI1DXsG59Sv4PswNgIYE170Mv3L5nUqQyjrAbnsZcXjGXoH+g7G8E
	0YaL9B1YjzuWeYTdR4jlKHOn4Xu84lFlosMwgcWQ2yWG8Mfnl9mLpaOg/8GKb7ZU
	44I1ygyNPTDsahyAdpIplC934jPLeFWaTSdji9PUHKZraZX8NcqKqSB1PTFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727714101; x=1727800501; bh=hoM4BOtOwfCPe/5WzSet7IPP5D5i
	Fn3mx04m2yFTuv8=; b=TqXZe6oq75Fq763jFR70MAXT9G0Ti1CO+L+H2GVRW8AD
	l8TAdlWiCxJoXSIx+M/U28Rig30kq2rQzjP+w0PKNXuhaI211gHHoI6tcsT8yfLv
	nZs8xhjWMlpL7EM9oYlmfcFM691pBN21ZVdZiOZEEcmZZ6WLbo59QNu6Q1LhT8j2
	AGTOiHn+qjPG7Mmll4U96aNLJBa50urYNfWSwTuH54MWf5CoFkqr7TI0ObHW5Z4D
	hzxNIQacbg+Rkq+02T/bvxysBYogKpGXAAt4Vx6I+86Pniw7vdJdxdgOjE9Wt+36
	zmdc+jd0n7jfzkLn+Oyh4DAJ1bGKDQ712606ebrOhQ==
X-ME-Sender: <xms:NdP6ZtoT-JyNSr4c6QsK8veNyw2dkuKd8i_yCu9HhqT1N3PuW2EMeQ>
    <xme:NdP6ZvprZFhYO43kmBYtyEGF7WERgG_E7SeXZFhx2-A3-WHMoSmDY3XpSUIKi_zNB
    AXLuYvRHdS3Gfg8zg>
X-ME-Received: <xmr:NdP6ZqPtnCm6m0m3uJ-gdoABQkqeHHEEu2Ubt74MiH0X6MWcz6-SGCzMGBNViXySlDo6A2T6IsKRKM8v-yl-6fyUI4l2-5esS71BvnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghp
    thhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NdP6Zo4MeWbcN_LKkFXsZ_txUXK5T9x-m5W2h7tLLjhf7ir1ULQhrg>
    <xmx:NdP6Zs6w_VXDoDOrcfJsBvZkXhcGzEnX_D4S_Rk327Kf0xOaXSWHVw>
    <xmx:NdP6Zgj4q6x1R0E7GrUeHk9jhzjP9D_umTZp0th6TxY5mmBvCK12NA>
    <xmx:NdP6Zu5cDRC_6a6pgTX8LtjHYq6bpx1Syr-vhOQvzZU-0LezUZU1gw>
    <xmx:NdP6ZtFsQgTZfZsARWLMwlBri96HRoSeE_Ujn1mPKWXQcmNeDa9nphLM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 12:35:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  John Cai <johncai86@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Michael Haggerty
 <mhagger@alum.mit.edu>,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
In-Reply-To: <ZvpZv_fed_su4w2-@pks.im> (Patrick Steinhardt's message of "Mon,
	30 Sep 2024 09:57:17 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240910163000.1985723-1-christian.couder@gmail.com>
	<xmqqikuijni0.fsf@gitster.g>
	<CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
	<xmqq34lkg1ck.fsf@gitster.g> <ZvpZv_fed_su4w2-@pks.im>
Date: Mon, 30 Sep 2024 09:34:59 -0700
Message-ID: <xmqqmsjp9k24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I guess it helps to address part of the problem. I'm not sure whether my
> understanding is aligned with Chris' intention, but I could certainly
> see that at some point in time we start to advertise promisor remote
> URLs that use different transport helpers to fetch objects. This would
> allow hosting providers to offload objects to e.g. blob storage or
> somesuch thing and the client would know how to fetch them.
>
> But there are still a couple of pieces missing in the bigger puzzle:
> ...
> I think chipping away the problems one by one is fine. But it would be
> nice to draw something like a "big picture" of where we eventually want
> to end up at and how all the parts connect with each other to form a
> viable native replacement for Git LFS.

Yes, thanks for stating this a lot more clearly than I said in the
reviews so far.

> Also Cc'ing brian, who likely has a thing or two to say about this :)
