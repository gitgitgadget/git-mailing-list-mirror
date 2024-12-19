Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F828B67F
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571000; cv=none; b=stGvPtPi9eEcOELnB7TEPP9rxJnKc9sRl35Hx8yScftL3BOfOaNGlIBmgHbUYXwXhFSNqLfxWKaYR6gGzbes8gvUThqOuFa7rtx23kGixrEqrnmL0N3vlvaKVwH1PmGKNgykGnpqlD5yq22Ucfoa22opaIN8aUq092USAnWk0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571000; c=relaxed/simple;
	bh=WtBYcE8MTxvxJW7mVFL9b5JtxT+8K1P0W9uRrthYjec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YtGoERykghoYAra1eYccFgl+52htp7s0AYiARKNaL8vocKEGmqd+1HpseloevLJ2DEFxKuSq8g3phpIB2J9rDdsTK46PyehY4xYHudH22LtW/ugxljYI/APst6nb2IgfkEGIy7inxE7LB2yI8yT02L+W04CYF15Ae5Beb/C4d9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k/84/Y8j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vdQovphr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k/84/Y8j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vdQovphr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A072C11401A4;
	Wed, 18 Dec 2024 20:16:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 18 Dec 2024 20:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734570997; x=1734657397; bh=uQ5UHrfsVb
	X3xCPxVuOHrIT3A8k/TO9eXyxQloYQzvk=; b=k/84/Y8jLrw37cSiCTfZhAiG6Z
	ZVQ4bG7CZOJ1kDhIaTnbF4lzwohwN2ESIRBfz3AdOQQIe213oNHpY4rqShi7Z6Jv
	t4SdeVvos/zPZYyMFLkAHC8Z1sBKvoQHUrzLeibxhYZBGLPp0No31MrLBs/DLQC4
	ZEk/SHtoYYZphh48FbtO2T1Cjn/DbHHeibEeY9BolR/P5CXyCaoyrIUEh6Fgq+vD
	7NLvdhGQ5lgD0nKHqvMDjJEIxcLlnLGh8tBCVowLqQQEbcP+6kjjhveEtJlXvqRg
	fkV9WY4X6jKfC7zYL+wapprnMZuM4CScLCo2RWR+6Gme+bEGUznu2/I0GOJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734570997; x=1734657397; bh=uQ5UHrfsVbX3xCPxVuOHrIT3A8k/TO9eXyx
	QloYQzvk=; b=vdQovphrFVCbl/5tPqx2mx+u11kFCVaCB7Ws+tYDaX2Mq9AVHwh
	F9KkfbaRBgo48XNOAmTwatmRqnPh4lop1xwRjZykLr0odkmLA4bIIchXiwZhMDEo
	Td4hR7tPAP+igc72s/er7Bkj298z4XzYaLqBiP1BzIX4A+nxq5jUqbkuVeSqGBf9
	vI2H+cV5fXkey2OCWQRKkI3BgT4WQTEM8pHjK8atcsEwgjK+oMqhc+8w2l/7/mX0
	vKn0C7+81nJzlSlZKoVOrJobdU6ScO9gTJCUr0QeZGb5RmqJClgyUbW0Nsu6P0Cx
	BZsACAYNoDW9o8i5ql3q92+Ogi+6Y5Tu1Jw==
X-ME-Sender: <xms:9XNjZ2aotn0jr3nV5UMsJrSbgvAJUhDaZXKIhUK7isZvMHvEJJqLsw>
    <xme:9XNjZ5ZzD5web2z0R1-BsWyKkYkvkXHqyvslJWrQbwX-taTbewAaIrC3BYMS6Ay5p
    6uYD2I4ZvLwKS5oag>
X-ME-Received: <xmr:9XNjZw9TFe4ylwi0-JTSiAnL1anoCg2JyFIvXOvr-fISGK3pOOdQwnQnPiB0L1-IpNQr8F7TStikJGEizc01ow3Mh142-YgUNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleelgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9XNjZ4pDa2CDgg_9fckPtuEdfRkRWdFX_G-oASJr_mZ7iGQF_BxNvw>
    <xmx:9XNjZxqC1ZeOBeLtcqnbaVQ1zsWD3HO84FlY-gja99oCUny6NtgtZQ>
    <xmx:9XNjZ2RdqnUk1wTPFA8uxaDA1cblpm2V50Na4yr257vv2y4TTGo0xw>
    <xmx:9XNjZxotP2zjMXQpszoFFDhYk1jH2JhOlRmz8lHaV9RuKJrV4ZL0ag>
    <xmx:9XNjZyfzVpKg3Mreky5HxCynj4LM7x17_9hS7-pUL9bCq_j7KMguPGlO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 20:16:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] pack-bitmap.c: ensure pack validity for all reuse packs
In-Reply-To: <Z2NfhDOJOOUdK2Xk@nand.local> (Taylor Blau's message of "Wed, 18
	Dec 2024 18:49:24 -0500")
References: <7fdbfadc04926efc094633b238a55168c92e3d58.1734117577.git.me@ttaylorr.com>
	<xmqqa5cspym9.fsf@gitster.g> <Z2NfhDOJOOUdK2Xk@nand.local>
Date: Wed, 18 Dec 2024 17:16:35 -0800
Message-ID: <xmqqplloo4jw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> IOW, we no longer need to check the validity of the preferred pack in
> either case. But in an incremental MIDX bitmaps world, we do need to
> keep calling prepare_midx_bitmap_git() along the MIDX's ->base pointer,
> if non-NULL.

Thanks.

>> I wonder what we can do better to make sure the work a contributor has
>> already done (in this case, resolve interaction between two topics) is
>> not wasted and recreated (possibly incorrectly) by the maintainer.
>
> I am not sure. During the interim maintainer period, Patrick sent a
> couple of rounds of ps/build with a final patch to the effect of
> "unbreak everything in seen", which could be dropped.
>
> But I think an easier thing to do would have been for myself to indicate
> that you'd run into a non-trivial conflict here and provide the
> resolution proactively.

A trick used by recent series from Patrick say things like "this is
based on X, with Y and Z merged".  This patch could have done the
same way.  It of course makes two topics entangled and one takes the
other hostage, so we need to carefully judge if such a dependency is
worth it.  So far, I found Patrick's judgement on the choice of
dependencies quite solid (essentially, Y and Z must be cooked enough
at least for 'next', and can reasonably be expected to graduate while
we iterate on the new topic that is being built).

Thanks.

