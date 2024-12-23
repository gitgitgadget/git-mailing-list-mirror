Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AE1B87D7
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971847; cv=none; b=TilSD/Vb3W1R/VwjnVm6wWhKwFGIkWxsW0226RKKcYYUfgdH8PmkImSnSVdO3RMvQZyZb3oZ94N/3NmodnilcEsW0QU/AMdl+3DGTMG1A9+/tNhqx8RL7xqyd1zMGIEpJr0uUtF5pGnxYGDIXz62zrbUP5M70nNAovA+n8NH8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971847; c=relaxed/simple;
	bh=eB6o0aMc86MHCYoMJfbW6lM95XEXSPbat32BtT4ubT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pevsh/PW/26AGFbTyurtKOM2TCoWl8Qt4hptY11b1Q0CnXxouxw89nZQnnmAN7Lzzi+8GakgCFUbBQ2w/iA2sTTECxs8mAEdJ1f4C20S2Ue/0ReAJsOadzvAA6ScnCzRJLqAG8e9V3xoKsFD6OwLWCjUMEiPc8UrkDyCUeC6sR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=20edzXhx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K+9/UO6+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="20edzXhx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K+9/UO6+"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C96411400B2;
	Mon, 23 Dec 2024 11:37:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 23 Dec 2024 11:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734971844;
	 x=1735058244; bh=yi0Xz74QhOyJ+wgVF0CGUxXR1TDwvymIwqlpwwwK6kQ=; b=
	20edzXhxpwA0fqXDkSMu/MkGGSStJbhlxMGZgVLlMPtbz8Fp2UQIrTYTRElHi/OY
	Ohjbfvri9VG6culODwj0sneoXBgUFXaX8rQ0wNh7/Nl20c/FmrX/RWQKuQF2NHAS
	5sGwSFIkYDQsK2QMAxynKsaOQb8uLXB2mD/4eMCvaSRbCuOSCGS+zSvyrnj3tmJV
	cDH0fzFXf5eb6KetMi6NaVRBotnhh+ApLZo/vGtXAAX+6Glccl9/aPUyMLkDglv2
	PgK1d5iRYznHLajwEJBWN3ddk5QAjFyKLu4K5tvYA9AEAaShC6YiQtVlb2n2wSu3
	3KmfI7NBl9sZj97jQf4s2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734971844; x=
	1735058244; bh=yi0Xz74QhOyJ+wgVF0CGUxXR1TDwvymIwqlpwwwK6kQ=; b=K
	+9/UO6+5SiKr6cR8Emk0DxgT8MiIHR11Yz6e3iw+NGZyOkkrMia1Dssnv8T0fTD0
	E29lALsrPB14yhhVFtCSTWIzpqVRceJlrhVc+cA3qwcYWc/evWOykZqGWlY1f1z1
	Hb/NspsgcHH4uImXOPEoYcRdXhj8RsgWCJ2/7MhYx7ghtk3ogaIV3XdyJl7X77iH
	XUU+Riqljt2gQX5ENS72rHgvg4txebMCsf0RJgfZoik7ciMRJGOhCmfol+ep8oGt
	lpc9eLCSfTRtemk68EsE1EyJnT1/ZcgFcbC0TKcVUDmOG4ok4rjtY4XzwFoBuyHG
	Ky74lFFeXqrzlLn2030fQ==
X-ME-Sender: <xms:w5FpZ6wqrKAOsW_IdEJc4I_pKAF7zQgWsDCPjwZMNTwun4J32ehtFQ>
    <xme:w5FpZ2TPKt49FzSlrr4aDBDp6UCnvxx-t1B1XYW1fAkDxd9exwJIB3gKcqhRIUD4-
    apCXzOD_Pu9aoEXKg>
X-ME-Received: <xmr:w5FpZ8V9Hu6KlmyZQmsU-1SB2eihjhzSYP3OeyS2dH64lYVtA_BYedLpss2gJe3wrXS8BF6U2k66fToOuHBOdsfmGQqyFXTZLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduvddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptd
    ffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhovghkkhhlvgesfhhrvggvnhgvthdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:w5FpZwj3edRUyxt6pxYafhzmKzKNVNHtyHiJcio1G8h5MiDdxvf8SA>
    <xmx:w5FpZ8Aig_N9jVaekggPwlZvbfwxj3vGgdw2OP6kCiBAvLHqAtGnJw>
    <xmx:w5FpZxLo9Im_WBFjWx3JO7c4IBvcO5eNJ0_x8u9gxhiPzWhhg7STHw>
    <xmx:w5FpZzCN_MSdUhI7HREWd_Zc7DyY1JL-mLmKUS_QJkvWMIi0iujvuQ>
    <xmx:xJFpZ_N994ITl2e3oj1B460Mxv22XdqamOlEY-5M5GHXa0brtP-ek5z1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Dec 2024 11:37:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Fixes typemissmatch warinigs from msvc
In-Reply-To: <20241223110407.3308-1-soekkle@freenet.de> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6ren?= Krecker"'s
	message of "Mon, 23 Dec 2024 12:04:03 +0100")
References: <20241223110407.3308-1-soekkle@freenet.de>
Date: Mon, 23 Dec 2024 08:37:21 -0800
Message-ID: <xmqqmsgm1hku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sören Krecker <soekkle@freenet.de> writes:

> A smale series of patches to fix some typemissmatch warings from msvc 14.30.
> Most of the missmatches a 64 to 32 bit conversion on a 64 bit Windows platform.

Thanks for the patches.

I'll welcome other people to take a look, if they are inclined, but
it is not something I'd want to look at during a pre-release freeze.
Nobody sane would be running "git add -p" on a patch that exceeds
2GB, for example, so the only practical thing they fix are compiler
warnings.  They are worth fixing eventually, but not all that
urgent.

Thanks, again.
