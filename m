Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4E80038
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734972779; cv=none; b=R6EhaatPcN3T1XOikJX4d9z+sSSEdseHweBRqwbRtrcW2oyVlaLtTsdc63b9QOuDHBBRhLGkKUNyHfbzAZx4+PZHc5L+hv46oW/TUU/xJq/7b5IPHTK6wWBFVMIEIdHZxJ3HZ8ZYoZtFBVJwLT6GMB2EpT/cGH4RLH4SpmJ6k90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734972779; c=relaxed/simple;
	bh=mctslE/TSQzhiqEUOoudxUWJXurgDoX3C0c7AqJQmuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hqPPTSGpmCZ1OiI8o6MqF3yLyuo+d+xwZ2eASSmdIPSGNr0/w6BFjFJAXLPd0Af39X56EhktfA5NUHpHXlNkeo2pA3zp2hcRA2yVUvC6jX5iU1Nd1ulqoXypHPcYuexzkmolaz8tS+i9qJ/UXy600UhaMMM6HDV142G0QA6Xx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pO6d/cPb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TkH07Lzo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pO6d/cPb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TkH07Lzo"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CF1B13801E6;
	Mon, 23 Dec 2024 11:52:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 23 Dec 2024 11:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734972776;
	 x=1735059176; bh=EdU+qFAsoqKg9FGiJ5o2Obz/fOry2hf3sWArEShQsRQ=; b=
	pO6d/cPb2TyE7FC3PHCnZ3AnBy/QbYbRCoqmFbQT3xXCTdUTCYffCJw5B6pl8AET
	wYGzjIYoJm/in0vLruT23EJ0+IQa73PBN43oIWIYSmsbnP1GhtEEDrv5Ej4QY3oA
	LMU+zs1d3uoHyKWZNL0PV/5bm++pam14d6wVD46vgcWUV26rQBR3xqpsPcPAojOg
	ZUomxJ0WOKTUlWEw9q+HycdMopdVhjLw1/5xu5dmHiVGbUbgvwLTPJxE90AIx4UK
	h8cqBNtxpx4nAkxDJIvluR9skUNQCpdwrnzZ2u1/QD9syTr+mxPCjENQLvX+HFIy
	32pWS1KSVeu3OOFqFiAR8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734972776; x=
	1735059176; bh=EdU+qFAsoqKg9FGiJ5o2Obz/fOry2hf3sWArEShQsRQ=; b=T
	kH07LzoxhEjssnAnet9hTIbIJ2Gitz7MZHvgSF0s7w2DzmzG/MqUOavFt2R3807a
	Kvsjiafb0NQYg8+kcHrnpHKNMe4HTUobh20QICmDCZ1BBspTp6ymFxgillqb62Cy
	sz+bpqQC3CqX4GG2+f+wuUo6eT6cJ8medfQp8ho0rldXR4KTeiM406L0IqoUzluc
	MYefD2J9Z5AGlO/R2LgPOhG274WnIYoQ2eHoAwqFke3bytoGHB2KuTH31EndCNRB
	a6huqnb762gvpXoj42Cg2fmEGD0FxbtTkRnW8C2n9PG6InCPk93cSSHlon5G6ACR
	5mkLAj/VIff9YP3t/HE5Q==
X-ME-Sender: <xms:aJVpZ49v-Q40omleyUHDFlx6AnZ8QWaT7Ul4EvBenGY1DhTQWBDZGA>
    <xme:aJVpZwsWOZzIM67aNCOUIvUdA0Rzj2pZ6oHSQxisrY0iG2h6jm7DVLyRdOZG-7GRo
    jSyXYGoiVGAZRbqdA>
X-ME-Received: <xmr:aJVpZ-CcoKF6-7rVsRB26lkmChfucDixsfoP-GxLNCNI_bMMTlsLSZUB5z4x0XjkuchvvhwkEto9da9W0Q9mf0uOvw8jqFS2Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduvddgfedtucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:aJVpZ4d3t0GVOLJiUDAuLSxJs-iJ8D8X3H9a9FXrvutiThc5dh7v3A>
    <xmx:aJVpZ9PyOE-6r8-379TyZ7GJyywIFp0kjaa66NdrB_22vU0PgMF--Q>
    <xmx:aJVpZymS0zoW_WspF1lNNraiV1SjFWDmaqb1e5b8Y4XMAMgTcEBxEw>
    <xmx:aJVpZ_uiz98RGsKpc1iV-XLmDiS8WxD55QBP_5bC_Uhzr3c2sonjBA>
    <xmx:aJVpZ-qzonmjeELM0srYSEariGAl15xe8JjqtdI30q76UpiFXpDbrhUn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Dec 2024 11:52:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Fixes typemissmatch warinigs from msvc
In-Reply-To: <xmqqmsgm1hku.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	23 Dec 2024 08:37:21 -0800")
References: <20241223110407.3308-1-soekkle@freenet.de>
	<xmqqmsgm1hku.fsf@gitster.g>
Date: Mon, 23 Dec 2024 08:52:54 -0800
Message-ID: <xmqqikra1gux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Sören Krecker <soekkle@freenet.de> writes:
>
>> A smale series of patches to fix some typemissmatch warings from msvc 14.30.
>> Most of the missmatches a 64 to 32 bit conversion on a 64 bit Windows platform.
>
> Thanks for the patches.
>
> I'll welcome other people to take a look, if they are inclined, but
> it is not something I'd want to look at during a pre-release freeze.
> Nobody sane would be running "git add -p" on a patch that exceeds
> 2GB, for example, so the only practical thing they fix are compiler
> warnings.  They are worth fixing eventually, but not all that
> urgent.
>
> Thanks, again.

Oops, sorry, this didn't come out quite right.  I didn't mean to say
that this contribution is unwelcome.  I'll get to it eventually
(like, after the upcoming release), but please do not expect them to
be merged before the upcoming release.

