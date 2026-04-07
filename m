Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FFF2B9A4
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523016; cv=none; b=hch2tNnOsyZwUn+7Hvg6rYgaMuKOQSddxVR2i1G7G+lKLZPGDuaGOy/AlIQrnH5yO/9WQe+ifdLCbXBx4E6Ns0tyZTRizUzoQY3QEVCQ7wQ170bqUcBUWE1r7vfLQ8Wgk5rsCpsoNmNoN3XwdeYgVbZFe4nGZKf1A28VZDySYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523016; c=relaxed/simple;
	bh=XWH2+b/yUN+N7fwgwQHlL0dGP2fodUFZZsA2TsLA+3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ewNyCNNJFslT1WZx8Llg6rnlIsNV8dKpQneXezMH5NX+iPaU3jQLTM4OpLgb8hCc9w0vhxwbPWHL8Z3da7yEWQWBC6dqE20jZHUQRMpoHHny4lhq0ttVaJuMDA0u5DCgshk9InN+ta4trEE+x8rxKCuXbXZw8oXQv+CWSKOsoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AYpM+4EX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v1/Ph4Sy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AYpM+4EX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v1/Ph4Sy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABC7214001BE;
	Mon,  6 Apr 2026 20:50:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 06 Apr 2026 20:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775523013;
	 x=1775609413; bh=ope3uPKIyFFhRKoEX/F6kggd/o0BEloSxXKFn6Hnnck=; b=
	AYpM+4EX3As2tZrFalVg223dFcAXZtcxNJw7AmzkuczhuuRRKLRj1x34MpJ4UnBV
	Xs8uRwKetsKPkJDC1eK6GqZj2Uy3QlDSVZtjkJ40GPTZG+FuxWuQeBBYG/GHXtGp
	fO6hjTae97k5J58yxiux9Xqljk7It5MB/mFOvaIiRzaJL0y/rON2oS1PVJ3fPZAX
	dB5Ro5uTSHdjpSCVuDHrxcPabg7FrItXP/VH9nUhDBw/GtprQyjjLYDoliucf4NC
	m5yySpP4773VAuqtmdW0WpVKpOvzRQOYChnSZ8fiPW+mhgFm9SROxe70u5NG1BM9
	Qvt2b3IAfZkmeyMGVp9GGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775523013; x=
	1775609413; bh=ope3uPKIyFFhRKoEX/F6kggd/o0BEloSxXKFn6Hnnck=; b=v
	1/Ph4SyPKBkSbH7njQsbliQB3NIXUIxQDmf9wprSKmBWWvXtVQT+lprFVQ2ELDUW
	R8v6bjwMQqAwm3qTtwilozBiuLNfF+MvAR0bjwt5GsjoQM7SQiB+FA6ypb+T3mTU
	SXHZASZfy8HrsJ+h0FfZC4idtbC6Zx4TeuLOEpWsV//g+oumWY4pVeb/HH26ZUTU
	ykmrr1o7N6DqHCLbY5JkN2dBaQY3+FqXEhihZuKjJRhuEm83sLoShSthvdcSDFNx
	oMo1Z7WP23+oT6Zha5LGHwkpSt8joig8G2ncQbCunVFK7JvbmkR05sJnhiV9QwhA
	js3GdCu+wgXuFZGHuPAfw==
X-ME-Sender: <xms:xVTUafsV8jixU62xZz3FKtSxiDLgIpYmbRfh5vNWCRfgnnSqiL1O2A>
    <xme:xVTUaXeeZQ-T9GhAUguoLyBrGmQ2TiaVKWI-2iA-PVczCEOqMiPVomcOFeWHlSwii
    haOkvdEiNt2LoRTbEYzgJtEmZdMcRo2R2qTD2IlD1V24jpRgynizg>
X-ME-Received: <xmr:xVTUaXxwQZCn9rYYDHzsvYOGVviR7mNr5FN0HnKx1BUhmCu-MqbDAHyjXqnN7NJUpqRucPMYLWJk-Nzgd2vkQTC9c84m8wtLDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduledvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhhihgtrghnsehthhhitggrnhdrnhgv
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xVTUadFaXEpxEqzQf349T97GoXmVX7xOyiL71YRs771fSz3KylMsyg>
    <xmx:xVTUabym10bGmVcry-RMo1AlF-20lkSoA9O-eYH78_f-eiq1L5O4PQ>
    <xmx:xVTUaeszhfVfz5FiXBzLypUCcgIZHbnE7ds76Qu1i2zAL0H4URw8qQ>
    <xmx:xVTUaY1Q62TS_zKdsusNl1RFE0veyon7I6y1p9ncugnuFYDKPT69pQ>
    <xmx:xVTUaZ0UQcwsLuGNxx25HTZ9kjM26XBAAQnNSYFnZmENitRwHgcO27pe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 20:50:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Thibaud CANALE" <thican@thican.net>,  git@vger.kernel.org
Subject: Re: [RFC PATCH] switch: provide configurable detach
In-Reply-To: <f0276575-9c75-45fb-8fcc-b465619d1b97@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 06 Apr 2026 19:48:49 +0200")
References: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
	<xmqq7bqkcah8.fsf@gitster.g>
	<f0276575-9c75-45fb-8fcc-b465619d1b97@app.fastmail.com>
Date: Mon, 06 Apr 2026 17:50:11 -0700
Message-ID: <xmqqh5pn8ugs.fsf@gitster.g>
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

> On the other hand, the BreakingChanges document does call
> git-checkout(1) “superseded”.  And in that light I do understand why
> people want to actively avoid git-checkout(1), including implementing
> replacements for all relevant checkout-use cases in git-switch(1).
>
>     Superseded features that will not be deprecated
>
>     [...]
>
>     • The features git-checkout(1) offers are covered by the pair of
>       commands git-restore(1) and git-switch(1). Because the use of
>       git-checkout(1) is still widespread, and it is not expected that
>       this will change anytime soon, all three commands will stay.

Perhaps a good first step would be to stop calling checkout
"superseded".  As they stand, all three are equally viable.  In
other words, I would not exactly call "switch/restore" a failed
experiment, but it wasn't a clear success story, either.

I think "still" and "anytime soon" in the above paragraph are doing
disservice by implying that somehow we want to remove checkout but
we cannot yet, when the reality is that we wanted to be able to
replace checkout with switch/restore in the distant past, but that
was a misguided attempt and did not work very well.

It is not like switch/restore pair did not work well or anything,
and in that sense switch/restore themselves are by no means
failures, but it was a failed experiment to introduce these two as a
way to replace and kill checkout.  For those users to whom both
"checking out files" and "checkout out a branch" appear as clear
concepts, there is no reason to abandon checkout.
