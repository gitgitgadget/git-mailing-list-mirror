Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3F28466A
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724216; cv=none; b=ids/mJIBStLR1Q92vBjkMW975N4JQawOZcJMgKy+GVtmeRvHyaHqamvWwfGJNfhHpfywu0yasifZJlnkineO3juAv4fiqYF2T/dJBBUUm9pjHGhQVqUMwmscS0D+V1ZFkyl7aLDjPycWWoZ3f7gCR+vGmGrnsrfeBxZGdKd8ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724216; c=relaxed/simple;
	bh=G/o3lvdwtDqvSlp+8ImHiaXCZHjeCJT6navwUfhxzO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DXqGb1W74+CwjkvK4l/WauJJB+YeYN/ygb+PRfxmdq9H7rXJ6FU5m6Hu4XE2OaZYBtRDM0RrKkwywsCisIaM+GH9ckE91+NNxKpdhKf6x+DywESRmjXV6BcL0opH+ZiBxSgpDPEl8fuQ7VSp0kPii0iPGla+0U4xBjVEj/05Btk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ISY29zkE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EMgkgLxa; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ISY29zkE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMgkgLxa"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A25601D001A7;
	Wed, 20 Aug 2025 17:10:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 20 Aug 2025 17:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755724213;
	 x=1755810613; bh=ttajMYLwe1miBD1wGFQi0a0k6QfLVoJ8GsqvPM+MKhg=; b=
	ISY29zkEN9us54FBDXr65zW12NTK4LSlEdiUvujTevZuoxzBpQS0AKWlDSfSL58Y
	8w8v9MpPzMDi5xFc02Ola/ZovJMEocukuOXmd2kMvAGkg42A/VUxz3gCN9M1vPOG
	KCdPTMMz6qknxGblIXXcIwnsH8r398tTQ/Ga2ohw7ZATqfmch7Iv3Q35GUYnmVCC
	j96bqs5IJQaUNJTtGxfE9bWzazD9IKnrONHt2MYzzHONgGUTpcXUAeIqv3PXZwhi
	dodLNfi+Cpf1IKVlvE727nivxGqpQ/xEUvWxoHsSHuUaUYw+DOYxKRHYHcxyIzW+
	fWIn8KWCrxO5PPrzg/KN7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755724213; x=
	1755810613; bh=ttajMYLwe1miBD1wGFQi0a0k6QfLVoJ8GsqvPM+MKhg=; b=E
	MgkgLxaWIcQmHye1nf2deGXDKcry+6KS9Y1OqFLb5VrEQQ8UX6ACQnM4ry+vQIH9
	IVLtRWEMykeeErI4vE0oewxRdNPC7yqLlctKFKlhe4fHtj0orpRF+On1lJoMV76H
	tuXk8bt7pjVFMLGH/Abrs2qa51h8LoweYXkZrBDo0oXNbqfilP85BB9klPVXoPZB
	KAWw5Xo8GUs7xYGM9hDqxG1KpKAoh/YHKR0ryC0g/dEBgOubvn3hztvccaKUupwM
	PGNtRSGiI+ouhbiCI5t2ZeKBfxwYb2adzsRVdQSaYpiRU/5eI2cvdb/2fVfNjspe
	whOlWJYSSLEl16IP7q+2w==
X-ME-Sender: <xms:tTmmaH_wCdmYI0mZ0ufsHXXb0ZLEB5xIbQPx3Aq8NbYnGsDrKpCVhQ>
    <xme:tTmmaPMSdNEkUICJpWUcsY-a0M1LChTXTJZU1As_suHVlJVJU62dxbPL6PxJG84tx
    cB4aE1qJ6_2__L1_Q>
X-ME-Received: <xmr:tTmmaLeNFy-fKzXcGS78KDG0xEI5fJpUafeWB1sMuOOtE4IEK64wXE6AXeg60IZUccF4qmNCxGLFiwpAmtVzsTwRN9k9B3ebJ4f5EUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhi
    ughgvgdrtghomhdprhgtphhtthhopegthhhrihhsrdhjuhgukhhinhhsqdhfihhshhgvrh
    esughonhhorhhstghhohhoshgvrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tTmmaOV9I8Lz5Cnuli8TcmwJFnqVg1WXhDQFPD0b50cqLOi_clutvw>
    <xmx:tTmmaDiyUDVl2fypLXw6z2fVvBU1eBIqG2wjH469HSq1K9GSvT5noA>
    <xmx:tTmmaN95U2XopVf_2Wnhnr26hFJg5z4XARnXyZShrBlxub1b7XCEJQ>
    <xmx:tTmmaFZ_DtcsA1JnyUoOg1n9LUeJEuhD2exx8A3JIyBHlTlHAVwLQg>
    <xmx:tTmmaOjiks9F-u61CXB_-BW7BMCtm6WuPSIRNN-aBzAfGXhWUHVy8jJL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 17:10:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: rsbecker <rsbecker@nexbridge.com>,  "'Chris Judkins-Fisher'"
 <chris.judkins-fisher@donorschoose.org>,  git@vger.kernel.org
Subject: Re: git whatchanged
In-Reply-To: <790a24b0-a799-44dd-b97d-c4c24e5d23a8@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 20 Aug 2025 22:58:18 +0200")
References: <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
	<011801dc114b$f38bb130$daa31390$@nexbridge.com>
	<37da14fb-fead-448b-b6a0-853c9fbea653@app.fastmail.com>
	<xmqqfrdmaqg4.fsf@gitster.g>
	<790a24b0-a799-44dd-b97d-c4c24e5d23a8@app.fastmail.com>
Date: Wed, 20 Aug 2025 14:10:11 -0700
Message-ID: <xmqqsehl8zt8.fsf@gitster.g>
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

> The message itself reads like it could be read like: tell us and we
> might put the brakes on removing it (and that’s it).

Yeah, that is a wrong interpretation we did not want to trigger.

"If you are a developer of a script that uses whatchanged, then
rewrite it with 'log --raw --no-merges' and be happy.  If the script
is very widely used, dropping us a note would be nice, as we can
redirect end-user inquiries of your script towards you.  If you are
an end-user of such a script, bug your supplier of such a script.
Thanks."

perhaps?

