Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563A22FE0E
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057979; cv=none; b=jUeXUfeNbwBusYOB3yJFtIkKpRrVr74MyE+LwzxwOpLWNVMqBdWTA6YUWTx9iRbzcBhBg8R4ISGWTgzx1pQCR7Kmc3lH3T6RWTiWH39qUwcvTjcXf25Os5XoUu5UL2znus9uQLuvd39OP/s/i8kb4OazZ6mdXb6rc3fiks/99tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057979; c=relaxed/simple;
	bh=oqDkMgnMJO0eFZ2xQvPFWyuVUlEHsoHqQsAT3iQPIoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfwV8GU87137sgNOW52GnBE1OPCttKN2Pt/w9aItSspiwChXf0A2rCgs11057f98ues+1/XdaB1qwjsuQwQv2bmyghGZzJnY7axE5vOpLPyf05Y212GyLtsPbpZ2HIjy+cNoKNHpX5U2abCTDIQjj+JalC0BRkKWD+tyKWjJrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YhT04TgZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r6v8v/SE; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YhT04TgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r6v8v/SE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C35097A0082;
	Tue, 21 Oct 2025 10:46:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 10:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761057975; x=1761144375; bh=Bpeb46L+zu
	c5zKAXEiXcuskC0L0sCwTxKzxWbEvow6Y=; b=YhT04TgZzGF53PD9KLfgPIvl3n
	dWsfjJipKkYYr/TOHXIecah99/878Kbv+ZBc1mU3C+VoU87yIBCEQcs80cE5oQK6
	+DFhF+2HgwcRKQQqzGDoE3rPIXQoNZFhAv1jEr5PiBpVVit4kPO25rks8NOU2BJD
	cJ+C6n4im2b0SGVdNsECOqObnoFZRGFWbIG18PWIGgcOjVvUm7XoKAihAhPHla1i
	sYZfB9WmOxJyQlQaBCDpJWeYAg86BN6fUwqvnKpnFXPTDw+dAjXuwWqTqrX5biJf
	dz9wPhZDjMJSKdpecLV3OHlGFP+X58IMT5LHCoVLmyYU1E0SEPR5O9s6DYvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761057975; x=1761144375; bh=Bpeb46L+zuc5zKAXEiXcuskC0L0sCwTxKzx
	WbEvow6Y=; b=r6v8v/SER8NLXvjSOpLvyFYm1GFQvf9h3uTkjmfOgo6su0ddPK/
	MlqJhk7f9j49s1HyAr9DqjwCdaVrH24Lwh66iJzNdvze5Q2ptY/lGmZV+i4dhJeM
	53uZ7s/eKgXDRi9Q2IQOxWPCvTVlE6jIl2W6abWBiMcco7CMLquS9VpNwp70dGTM
	0euMOoJ0JYQ6aec1ya2nKD7PUJ+4OB+FgZWsZviLzltCYWYXv34LAspJjXQUTf6w
	BUOSkw5ZozU8AOyflbRFhB05JWs5oSVLMkyq+XJbRGwzOfoRt/MHxfFnRqRlBy7C
	2tZg6Exb7xut/aa6J27pRDC1rgKaJqS/yZg==
X-ME-Sender: <xms:t5z3aNtBiPOhvvtOj5d-IoseGLwLGiMUKfCrns3M-Zmjw1oaOFsw4A>
    <xme:t5z3aNeMQR_txximaNq0kqMLXzUt5eHEJAQRmn3LRaz4GxmpgzXt27nqT8TcuxBL0
    rEsNnTfdBurUDDkuJCVRN3S9DxLjUr5yuCBXu5JixEoC0l2vWrOSg>
X-ME-Received: <xmr:t5z3aFwvkOnISlgDQLGe4YljuVk4qEkd1iM86xHc7xyZ2kjdfcnBj4kEdbJ65dbfMt8pcl6rKvkfVsAL7eYmjtjEiZAjw3PxsIKf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepughilhihrghnrdhprghlrghuiihovhesrggvgh
    gvvgdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:t5z3aDHg4EbPVeTszteSPOFBQRrmp2GmaE77hwgAt84xLijflCgC3Q>
    <xmx:t5z3aJywmA85tyct-RU33_cQyIIswaP3Ga5UGSTZg40DSY86xlwMbg>
    <xmx:t5z3aEuoFTn5nYqJBgEazB4IJOFrqUUln_l2pDAsel6A8a6C5iWfTA>
    <xmx:t5z3aG0de3ri9B9JOXNP3zt4gTBI-_aC73qeZu0TCeHZdySCNXWBgw>
    <xmx:t5z3aI52vyFWEsSWFldEKOfCWohFNB6LibdkK0RhwwpgxSSrfUsKNXxx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:46:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?=
 <dilyan.palauzov@aegee.org>,  git <git@vger.kernel.org>
Subject: Re: No config option for `git diff --stat` to always show the full
 file path and name (without .../ abbreviations)
In-Reply-To: <20251021081422.GE259661@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 21 Oct 2025 04:14:22 -0400")
References: <a6ce209d120ca6acf0f5dd04521cb96ac1337a54.camel@aegee.org>
	<20251021081422.GE259661@coredump.intra.peff.net>
Date: Tue, 21 Oct 2025 07:46:13 -0700
Message-ID: <xmqqtszswbwq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Anyway, one more possible hack: you can set COLUMNS if you want to
> pretend you have a really big terminal. I.e., "export COLUMNS=200" would
> probably do what you want without any new Git feature.

;-)

Isn't that the exact purpose of that environment variable?  It feels
a bit unfair to the variable to call it a hack.
