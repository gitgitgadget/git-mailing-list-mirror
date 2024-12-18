Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C294A3C
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734481111; cv=none; b=ogb1FskdyacvxweDdof1TXPHuoD4kEmh09QNuCHDHk43h5Tqz5F+AG0GfW/3RqeKpXuv0fYTDkvGCEfArisqh0APqrCiqaXxLKw0RipiHPOi3y2yEhkqGbyqtCizh6nXRY/Jdl+avR4i+WiZb7u/BDS7M+n9E5geiGVotFJoYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734481111; c=relaxed/simple;
	bh=cwUXoYlbOfcb5BzF7oiuO2feMFwFn1YJkJvu9iLrpQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b9jZ1+sR9RiwA1A5UhjZdLMCFoIxtEN94NCKXtuVSg3T0ZozLq1q1SdNkoM645gArZwg7LfTO+dWXpssw2rtDiaaq8JZKW20CJTZG7uigfcC2/f6rsj3X9K8dIKT+cmL0jxZXnZfD8EbqkU077jsYdT+h7qoAHJD8MZzAbQpHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KBeWPJlU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTau/Aiq; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KBeWPJlU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTau/Aiq"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 449DC1380238;
	Tue, 17 Dec 2024 19:18:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 17 Dec 2024 19:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734481106; x=1734567506; bh=D8SOC5ye/o
	yCzzBoufgg+v/GcAEb8j4HsX+qh1jpn6c=; b=KBeWPJlURMfm292QioVMnu057p
	PZUE5JfJniuKAzsq4MO7rY+TIS7LYJcoL2xhfG/uZXQzI823PY5q5fRNq3CZL6Zr
	akU1rbIdYngca3jQv8EFrnZ0DB0qcRCGONcXxtAgeD3OQD5YnUcznao2KmZ4DdNB
	ik40AeE8iAiKrTTwSPrdN2d+9/byzbiA14jNxK+ucYpVUspczhVgghOxXgmg+BPJ
	w6dKiMW9RVdHWxcFpoBzQgcBH5yhft5a3S6KHonBXg3iifm/KF5ivZm4DpRJld4n
	nPByXUwAEEefX8nKSy3FSw2QBfWIbV6eVoSz31wsYZ64nsNhH+Uk+kAj6VlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734481106; x=1734567506; bh=D8SOC5ye/oyCzzBoufgg+v/GcAEb8j4HsX+
	qh1jpn6c=; b=lTau/AiqwhS/1eOz/kaV8Su9M2ozrowCOj40w0ahcs3vFo5jr1v
	kVpUfIomMN4jwmc+EoITWWurz7jFGRv0Z6pJg8AoppZHGyGm4YXRiLKnVn8DeROk
	+1aRVuxxIGY2/8XHJvKYp8umSwhi6gkj2Mt43wxpAbZTuuVGjP2V3JE8Ld8gsCMo
	Chzf+02V/3AS6+v9AGhz/wLbIWQZDMdKQQ7U6HGvbqw4P9XKeBi1dLCpVRquvIUN
	fM8fd5944zYcw+aesEYJr14JDcHnqB7b6KCiEPYE65RwrpROvt/aNXSic302FM7W
	sYg+Pq+RZO7sBY+wYGAoSnmcXftKGIRmZuw==
X-ME-Sender: <xms:0hRiZySZyGUtt2tHP2YyTEtPDjvW8bkdoR39nkj5K-xXy_A_WYFxfw>
    <xme:0hRiZ3yoJT2M_KS6CaQz2k5QiteI4aevfOiz1xN9qEMSZa7p_S91kYDcRqYc9TVM2
    iGoBykdYdySV7cLgg>
X-ME-Received: <xmr:0hRiZ_18GLAtTrJVpHnJK5348IvbN3OXL4HlxQEtesIenOEURbJdi2Q7cxFyBXSE1sF9EE5RQIALgYGFscgEZDEXo6w_c6GoXIBUu84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeigddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepffeite
    eujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0hRiZ-Dx194nqLQaNwjBMxwtP6cChwFLjSsYLarF1b3pNaf1PNeH_g>
    <xmx:0hRiZ7gABVxF88DmnmMzejUsjLHMFH-vJQ4Y9ZMGZdBpl9lha_oDOw>
    <xmx:0hRiZ6o6TWfnpC7nrg5cmEg7MXCWKU5a-JLZrakwgGHj5r0D4J4K3A>
    <xmx:0hRiZ-hH7FGo6k1HFgqsqYUhbYBzESzPzlApO6LoHICgUR0mBMl5lQ>
    <xmx:0hRiZ4uLnj4C_qIiv68kH_zqJsYbLA8eBqK6wv9dDaiBqhHYI-vXYq5S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 19:18:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] gitk: macOS startup, commit ID to clipboard, text
 wrapping
In-Reply-To: <ce2827ab-7827-42d6-8fd9-77be18bcda4c@kdbg.org> (Johannes Sixt's
	message of "Tue, 17 Dec 2024 22:25:47 +0100")
References: <ce2827ab-7827-42d6-8fd9-77be18bcda4c@kdbg.org>
Date: Tue, 17 Dec 2024 16:18:24 -0800
Message-ID: <xmqqo719yhbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit c18400c6bb04f4e8875c1930db72ddd9b94649ca:
>
>   Makefile(s): avoid recipe prefix in conditional statements (2024-11-24 13:45:49 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/gitk.git master
>
> for you to fetch changes up to 661734e6c8c38d2cd2000481ffb22cca6e2b0e5e:
> ...
>  gitk     |  86 +++++---
>  po/sv.po | 734 ++++++++++++++++++++++++++++++++-------------------------------
>  2 files changed, 439 insertions(+), 381 deletions(-)

Thanks.  Pulled.
