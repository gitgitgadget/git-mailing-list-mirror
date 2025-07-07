Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62597261595
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926451; cv=none; b=QgfcNda7Pnvp3LTgTPNipqNaaEcKIjvMTps/ZW8sNUAOsWdE+8B4VET1q91uwW3HLF1A24xtdihD/Tbs09VRi9FylirWnH0EmlhpX4JD+8SoxuGJjN6zfjPZAAJJnbsdf8wO9Fefcoh5tCj9Vvyq9a3hCqyjodcOBy/iYE2lCb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926451; c=relaxed/simple;
	bh=fNoBxZ4ZtfCy3maxwRVZEPwIktmD5O/Rc+na05+GQYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLMAbPQdAW17Q312njnj1wZvPyxE1XzC2N0/N42D5Jmk5d1E0XDymYeW7jwAbsincAgXeWrY6K7DkQmf+cSNdTgzxHo3f3KetyCwqYn+KFEgtNKH9dOMl/rLe/3kBsG5ZoBcOfuodxdwaxJEParUP1z9yo4PqPKv4SC27f7hajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kOTHlLeS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oEQYli95; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kOTHlLeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oEQYli95"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 83AD11400A20;
	Mon,  7 Jul 2025 18:14:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 07 Jul 2025 18:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751926447; x=1752012847; bh=fNoBxZ4Ztf
	Cy3maxwRVZEPwIktmD5O/Rc+na05+GQYQ=; b=kOTHlLeSoXEcUVAKx+0sba+Uo7
	ULSBz4yGg7gytNTh/2oExmqoXiJcpN6p9i4PJXzdHxL2lOAjYumM2psKB2SdPAx5
	z9sTDtfDL98Nr7QD/crx7b4KkVgZo/6hU1ncW1yM1/usJslQLbVQBZr7lmq853p/
	l5REcx925QTursdoI56OjVomTRBYnYoP+66y6wavU64lASQBap+CKAnfoPeadFmf
	xpRrhPmWuW4MNwr+Kzxk3POF3iem64x4ZUPo0WREog0X42yHx4wpAlhK3j52039y
	475rgBNXM1YGGznjNL9OPMgo83YHwG0yMzwtxpIER6lECSztlUwn3Rl1AnVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751926447; x=1752012847; bh=fNoBxZ4ZtfCy3maxwRVZEPwIktmD5O/Rc+n
	a05+GQYQ=; b=oEQYli95N0cqhwkBjmC4uhc9+OrZfJGhCUfyyp61+CvBud8NWab
	WFh/6VsUZk1zOvxhoMgItkYR7u69u6jmCXP8PuYEaf0RJ9phzbND+wrlPE02aoM8
	sPY9IHAIcSxoRHK7Vulv5u4nMbYhd2pDifNUF5Mgd/ReTL1Xtfi8lb6V/GpEOqd8
	KbbH1kyvumOcuUkcbK0YRKbAoB3puYPS/mWPUBPT7X4GmhIGYdbAR86NdPQL1qJX
	5o+ah5bC2C+nW4eEiCsNVP6miMRdDLfgZrC4R+ajjr+SRBJI8qJlLakjHPayB+Wh
	amYqUNTM9z0OYJ/5C9+VgfRRBQLD3CWr6dQ==
X-ME-Sender: <xms:r0ZsaBXd5I4rSOqFCV5TFD14iGVhB8kJ85_vNIb7FKPrmmCYqqAnGg>
    <xme:r0ZsaCXP5OEdlnFllMe97fhKRIjw2QiSb60iO4Z4zLaKp2CZEn6bpqZWWmU6Z3SyU
    JMm_i1GerbHrx73kw>
X-ME-Received: <xmr:r0ZsaJiP01teYOa0AF4Pab7XpV9sJVB8_gll1mn1iSJwmzJrcEyEZwKiA34fk1wfnlxtPxng5eG5-IoF8bMZB9zj7ziVrHpkh0rYWzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishdrthhorhgvkhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:r0ZsaFYqP2oCWH8FOZ2TnuwKwWxcsXCq7kbKHYW13nlaED-RmLzDlA>
    <xmx:r0ZsaOpOBJd2F-VYuA8Y-V5IhLoUtNkJvXvyfYqHJqUdeJG5tt02fw>
    <xmx:r0ZsaKOxt8JOFL3hyWUOVAIGfzgbBJtyoP4q4Xv8CPz7VyZkNvO_sg>
    <xmx:r0ZsaJqCwpwRLWExcBQpm-cdYX-CgPmOY5heu1hdFBv95VRsGw2Cig>
    <xmx:r0ZsaCW9R_2b3RoomnauxblJBGg0Bv_Y9iRfUY99ls3kUEVsEHYnZLwm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 18:14:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  Carlo
 Marcelo Arenas
 =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 3/4] daemon: use sigaction() to install child_handler()
In-Reply-To: <087d437f-3163-4c63-b6f5-e5d726016359@gmail.com> (Phillip Wood's
	message of "Thu, 26 Jun 2025 19:04:30 +0100")
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
	<c66bda461f45791d278779fb0021f1e0369fe889.1750927989.git.gitgitgadget@gmail.com>
	<d7c86948-e0b0-4864-88f8-fd1222e0dffe@gmail.com>
	<xmqqy0teplfa.fsf@gitster.g>
	<wanrtwacxrjmmpfnjwxhgdfhlo4uvnktijnc2rxdzlnkpe5r4a@3b2e2onpqakp>
	<087d437f-3163-4c63-b6f5-e5d726016359@gmail.com>
Date: Mon, 07 Jul 2025 15:14:05 -0700
Message-ID: <xmqqpleb3az6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> The counter argument to this is that it is masking bugs that happen on
> platforms without SA_RESTART.

As long as we can make the thing work correctly without SA_RESTART
even on platforms that do support SA_RESTART, I tend to agree with
that position.

Thanks.
