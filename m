Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C26382
	for <git@vger.kernel.org>; Tue, 27 May 2025 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748385186; cv=none; b=EuCeET9dY/rieuCm22y93Oflx9d3YL+xo4lpk/hdCdjDRCzHNRRr6Dd9uv5hC8RsdN+S7q2GMDFmFugOl0q09tMLICN2TPqCCuXOpzimn0/qyK84bY6S83ZH0sP8GgTjkVp45uFP34ZKPmoCiCVLwSc7woRtcObm4P/kU0+yVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748385186; c=relaxed/simple;
	bh=+Nk+Qgz61HgYmoynQpXp8lasex3ksoxIMvOOsMcdv44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RYtdl5NqfC3i3y/Odh1zyqr1IetZWghgsBiNvlGhDq9C7ItyWNgbi052JHaDmSsKGNw8bwgbfrKvITep7zTmNQHufvc90TJH9xisoH5joI8piUMdiLpOZnl3UwqhUSS+3ylZ0YKOZlbplh9VrxTE0Uhz0jTpLnXv0xQc8lCEbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DId4zo6K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FkfHg8gV; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DId4zo6K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FkfHg8gV"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A1F913836D6;
	Tue, 27 May 2025 18:33:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 27 May 2025 18:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748385183; x=1748471583; bh=jOmWhAjDSA
	N/xKmjCjtTCTutDl4AlPN8oUc4NRFV5Ss=; b=DId4zo6KErJNj+ma4Vks9xwWKk
	P9YuwWC/qNB3kUh+kcGcL5OSoySgVgPXMwjFemCY0R4KH0Y+4wJWGNkh7I7IbHa9
	OIyvHmJpedyr754x7zVCo8q5uWM2GkOJgheWirR6AI7G5/FP1yic5Q/n8uqPwj0w
	Vua44J4drsRcVdYHQRUu81RsDnHW6FLtpphH8OGUu+bqER7w7l29N+L9b86FPcr4
	h1trVGnjNqLOrWC88yO4jFkr+0FjYHRPzl7w9qVaqNPnBsYIrJPnfcHg2TaAzgC7
	RkFFNrs6fubpIGbIucpeyVpZihUzP9lYaeITgWirAVJw7RRGYFZ13tHndd1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748385183; x=1748471583; bh=jOmWhAjDSAN/xKmjCjtTCTutDl4AlPN8oUc
	4NRFV5Ss=; b=FkfHg8gVmh+i36ou+WbaocnIu5eNm65+ZIQ7Pj8wc/ef94mKjBg
	mM1iJ+s+hf3l5rk5TrAj1rUfWvd3ZP4VemTQkty9otgHlg/cP4nZJ3MRYFN1VbgE
	ly/M/G9BzfomSEX0fYRFzRCTVZMu5KsHbYMr/uSIniBp/WgQ/wXcEblBGfIm/Qm7
	kyP3bGEZlqSBVS6YZD09FPYpAsNAv9002pnL5ucre285NlpHXLaiyk4ZP5R82C24
	rCVIvqwanyToY9GtH42GG3IyjnRcfC0gQ36XfydMmqlXewcT/st8CswoQ38Seo5+
	7ScSZRzvhLboq34/1H1RihdHX5McUY3qYIA==
X-ME-Sender: <xms:nj02aDrXHYq8qAM0Iu5urZYARXw4S0k5XEsBxZPCfb0sYjSaSE3ZWg>
    <xme:nj02aNrbgJtJ6Y2P1IbvO-zAnqHHR8H9vbyud__FZbB7kxRLW4oVJPo6VoYn9WkuA
    15uxfqsd59kPYZeqg>
X-ME-Received: <xmr:nj02aAPQu6tuOImcdX1W7ULvdqUeze6-20Jwo0uA7Tj-W4U8Uei1lxbj70AinNsOXMqWAuOypU5qosHj43J54H_SHCUs80mkEmkdv8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudehleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopeguhihrohhnvghtvghnghesghhmrghilhdrtghomh
    dprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nj02aG6vgX05gdBJJLwubxt4r9vs2S_lXaUkDTSzyRqDO9gA5aWwOQ>
    <xmx:nj02aC5KgE0nPMeX5Ph0kJEny-ctGsEYYEUmBOwPisSD0-3Kat4Vqg>
    <xmx:nj02aOiFkwnZ3DqZ5c2Hl4SBH13_9I2YUAhFaS051ql5Go95daIgoQ>
    <xmx:nj02aE4FnLJ8Ws5qFLixVpmY9fJtPRujOwSVZkfHjG8NzJyl3q6OFw>
    <xmx:nz02aPVsqRbAFZUVd3VDjECIqfEThy1tX6iRr9AgDVTvTUQtsMXQmBcx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 18:33:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>,  Teng Long <dyroneteng@gmail.com>,  "D . Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 0/9] doc: --stdin on notes and core.commentChar mentions
In-Reply-To: <cover.1748380390.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 27 May 2025
	23:19:29 +0200")
References: <cover.1748028010.git.code@khaugsbakk.name>
	<cover.1748380390.git.code@khaugsbakk.name>
Date: Tue, 27 May 2025 15:33:01 -0700
Message-ID: <xmqqr009u1k2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> I wanted to fix `--stdin` in the git-notes(1) documentation.  Then I
> found some other things on that doc as well as things to do with
> `core.commentChar`.

Looking really good.  Let me mark the topic for 'next'.

Thanks.

