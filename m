Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1229D0E
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929415; cv=none; b=IAFNzhS6+aWsKMs+2w5txmczwzHgzXTwzP07T041lS6h8nmAp2Lio+p/zpUzfP0M6oNAfL1rP7W1HwdvwNfQAy2MbqRJf9ObczhIvIH/TzVLpv6UaHgF5u+GKUzZZ7yXt1VqveoF0So/1rvFE+buXkmdQ7NYVpxpqtqJcYkeg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929415; c=relaxed/simple;
	bh=mvRu/jxi0LXPA/jXkjPfjs8BpP0tGCOYVkfEDfvbzCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UD3xl75wAo/ie3WR8HMm3LHJngoQ1hbOZY7X2qiN7pDA8m49ERK/dgyqq+Snpbi30wEiilYUAIKsAcApyZlaO2VdfO+8s0pqHTSKcFP5yst0d8bvhNkC0QCBl7Sv9yhiRnha2DoeJbl+ItK5aeJBB9XOrpFJL1TACLD0ugF1RC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nO+1qw91; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZoMRcNV; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nO+1qw91";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZoMRcNV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE2501400277;
	Wed,  3 Sep 2025 15:56:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 03 Sep 2025 15:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756929411; x=1757015811; bh=e1BSjYLg6a
	ppg7tS37OiaekT9Z+BY62YMPaC/6cHXiU=; b=nO+1qw91mCCbeejDv5fAFiCAWl
	qsCNe8W8dbmtBsNss9YFxZOx6P7pqzn88B1ENqoIWtr9gak7TNbsnS72fddxZXI+
	FUoTjCUDMHUBDcvhbU14tJ8zDR8lyrpEJ1wthg86pQDS1T6A46I57/0tLoNIn6HC
	733x/7Ku6qXexfLs5IF48CcJMRVDpDWH5GQxp325kwt8Nmcig5XAbkXmgAKhYW97
	4b+2iLRq2U5HoAt216B27UeNHD5UF8Yf1gQ3D+GZo79yMm//7mRhhqBv9NOdrtW+
	jh0h+iKNN83o77VQYJFOvr56H9tisopaUgFISXTscApY/S5XdEX9AvRPhyyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756929411; x=1757015811; bh=e1BSjYLg6appg7tS37OiaekT9Z+BY62YMPa
	C/6cHXiU=; b=EZoMRcNVEJF1sv8TIxIvX5UB9JdeXl8FGvtCT/MCrg8pxv8mBE3
	kGxeTtzK5EY8pV6ok9gXFkmGINtS9MMups/MVdcs5GDEskoob9u0RKUipQtR/mqE
	QIk7qhEQ0qyZUqT9X4FDZuyH9lw5AY5181xXuwuhKHGQrZgqQTN5dVAIbd8KDo85
	XNo2s44PlJwgMsKlD5W+ccE2sscmq7qYUVf2u+So5PFFdmM6T7WUbwGLDacxoAir
	77oD/JmuuHazVkKZOo3YwdwcT7miCBWVx7L5psZvGvl3nJ3tCPQFGEcky0ea177A
	WyTqyajTzEAu/f21V9qccvNVo4Sfd9eG0mQ==
X-ME-Sender: <xms:g524aMSLLUcEb6C0_XwOxwL0tFlDLWNXmU3WZwD7yFTwE-HL3NUVhg>
    <xme:g524aNCiJD-ue84agVmMDfgjAYicD7LNOb2_Txh-ynFnfo64f2SNKvbJk1Nm0r1gW
    0e_Oz-5Eh8hTKhwDA>
X-ME-Received: <xmr:g524aDS2ai1xnRe5HIvgQCI9x0Y_xVpRHNVIqtj2CxxLwbdCZ6R6Q4kurp2eGXMMOstfRdPNSrk71eUF4Q_6A6j7uaWJ2iqNJr0qVuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepjhgvshhsvgesmhgsuhhkihdqmhhvuhhkihdrohhrghdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:g524aLrHc7DVp_BXBZqDtHgjokDFPC9vUmfTyKEVzroeN9DWAWqbbA>
    <xmx:g524aFynxpxxibVWD1_OJqh2k2bH3ZmLo4NpgQiWlytc7fDMJHOWeQ>
    <xmx:g524aAL0lLmlm-Lm6esqoFwT5bDn2z3JJ5XVCjcjN8QlVxL2z9gw6A>
    <xmx:g524aHJxrOi238dXsuJz-ugxbWMcw1jMTbw7gfsL69CkvSNEkhw6PQ>
    <xmx:g524aFq7IurUBwgibm98IYokWYc9eQQPx-oB9QhZQWbIpr2hqOHpCqnK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 15:56:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jesse Hathaway <jesse@mbuki-mvuki.org>
Cc: git@vger.kernel.org
Subject: Re: git whatchanged
In-Reply-To: <CANSNSoWZNx3j3eLAayW64iC+bvC9XfetV+wZAkK6Zy8Zm0DWSw@mail.gmail.com>
	(Jesse Hathaway's message of "Wed, 3 Sep 2025 10:34:59 -0500")
References: <CANSNSoWZNx3j3eLAayW64iC+bvC9XfetV+wZAkK6Zy8Zm0DWSw@mail.gmail.com>
Date: Wed, 03 Sep 2025 12:56:50 -0700
Message-ID: <xmqqwm6fe2d9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesse Hathaway <jesse@mbuki-mvuki.org> writes:

> Git developers,
>
> Thanks for the wonderful tool. I still use `git whatchanged` I realize
> that `git log --raw` is the same output, but it doesn't have the same
> mnemonic resonance as `git whatchanged`.

The "raw" output spews meaningless hexadecimal strings.  Why not
learn to use a more meaningful option, now you are switching out of
the command that is going away anyway, perhaps like "--status",
which lets you see the extent of damage to each path, for example?
