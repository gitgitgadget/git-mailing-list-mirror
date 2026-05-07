Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9C38D007
	for <git@vger.kernel.org>; Thu,  7 May 2026 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145651; cv=none; b=nr+SdIEDMMH2XJCnbFsfCXq+YHBwOYYZEVo7bTbZ0k6LS2HME7HCQ97ARFeoHGFdpxDMy1foyBX+yb0hHka/fCcf1z+XNcdfrOGP17Iq85GUV3jxgnQ5Blom4Z8+XTBNeXBUAy+/TpB6ef388ig+qJWXdA3tbmBd5312IENchE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145651; c=relaxed/simple;
	bh=fIKXgOPznpR+ovsUNAiA4f9llmQtGVoQaYA6m6zKYLo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XTtsAEaiIIJsM7/T5oW3sN6Hx/BogB17AhIojpRT15zxIvwAlzzOVFTLI42iIpxhg69stCGu9vr6kTz6yCX/x9HDeYaPp1WYbOUhyuwzGaAFLwC/5Pz8dm+GrWG1I8egTEjsuwy/KxozLf5LHnoHRULUy6FYV6yhP89nZ3w5hxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vvZCK+IC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bC9ZdDHg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vvZCK+IC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bC9ZdDHg"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A6CB14000A7;
	Thu,  7 May 2026 05:20:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 07 May 2026 05:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778145644; x=1778232044; bh=BUYlsndgus
	RNYMa4BD7BpOQJiu8fHApqq0x16YgSWrg=; b=vvZCK+ICEStD7Hty6FlcouvljR
	XI+rQ2WZYi6JH9Zmb3x8AjxFVBkkmCbUoe1kz1WHrSDebFqjl6qEw8Ek12zKoch3
	e6Debr91ymhFt6Z9fOqYc6eZdSJePjihYg2v9fA2v3hxo25uOY6mh0274wt28TDg
	+ktf7Kz5mJdy4fefGKl4koJ4RcpEX8t/WYYee1D9r2pINJMrERnxWH6FUEldgpcG
	oHxFh1cG4m75ExaiBoS3+kgInAJ3+3o6fZt6B52MIZpDtUlz38H61wy6L6uTF5jb
	5mQT181BgAF0dTptmznE/cPqZ4VbNr/llMoxA9sL85klGCXT477edzPn6Q8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778145644; x=1778232044; bh=BUYlsndgusRNYMa4BD7BpOQJiu8fHApqq0x
	16YgSWrg=; b=bC9ZdDHgKI2lg9YKeLR6jeWWMTl+nnd8rPj9L3VYRcOtQCVyywI
	e88ET5q0wlBHkVYcUjn8bfNwXmPViwyrRXLNzWbq9XZM/7vOQ0nlTXjIkY/ZRsPl
	L2CB/8/m5w62PhknLlu6KfgMfnUNIyXxtUycOdXiMB1ky7/MqnkldKAzDEUAdmVp
	77z6cXwryXQzrUJDeaBpBlj4dwYSvk2rWWLNpbK36W0yQdG+rHZcAnSoyzgPWUXD
	8rltwGnZjZx8j8plNc+WEfpOFvoNG5GqrdLA/s0WzSVSt1jrYx5KS/f+G00o1fi8
	Z9+EU0I1SMVsC6Al0XUVER1zdL+TgHF+3JQ==
X-ME-Sender: <xms:bFn8aVqHrnlBrdFx0SPtaTihQoc7kLIQlhesLgEGR_NzWt0s_8fR1Q>
    <xme:bFn8aUNkrud5Ea7xw3_T5ZrnNOTm-gKk2iY-C_V0t8wje9pnUrSQpKEtrPgeM34M5
    JRV0WLWrW7O2aAyAGcERCW_RoCAOEka0dR96lLJ_UAeQepybv1CnQ>
X-ME-Received: <xmr:bFn8aWobv06u552COVKp8LjzAAFrHQo-K7HwvcYpYzgd6Zo-GMJogp7kjpO8OBuGmX6kGog_nLxlTtHZKnHYiy9PoYKXWmRASmQkevLF-sle>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpd
    hrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegthh
    hrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bFn8aXvpLJxTw3_j3OMvyOnhUGr1a3_vX1qap8ykH51mmTuHDKqKAA>
    <xmx:bFn8aV3DZRyAuv42Xx6ynH1scnh9JHK6er1KmldxQaAhkhOJIQjycg>
    <xmx:bFn8aSE0mB2-EiIlT2goSyC_kRxbKCiW0GfbsPxQURsyCXW1QRKsvw>
    <xmx:bFn8aQtB0Jh77bwHMeTrRdB0rv-ojsAxhrghI4bCZ8aMbtETR4hqQA>
    <xmx:bFn8aVPb0OJ0otBcyy8DohBJB5CBPYFDdHpnOobB0V1qz2Gv9GsyyCVH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 05:20:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: Johannes Sixt <j6t@kdbg.org>,  Jeff King <peff@peff.net>,  =?utf-8?Q?J?=
 =?utf-8?Q?ean-No=C3=ABl?=
 Avila <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v6] revision.c: implement --max-count-oldest
References: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
	<ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
	<7250e6c1-633e-417b-aacb-94e35d240d3f@kdbg.org>
	<afs2QVHerGLALFcl@exploit>
Date: Thu, 07 May 2026 18:20:40 +0900
In-Reply-To: <afs2QVHerGLALFcl@exploit> (Mirko Faina's message of "Wed, 6 May
	2026 14:54:19 +0200")
Message-ID: <87o6ireftj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

>> BTW, this makes me think whether this kind of limiting could be
>> triggered by a negative argument to --max-count.
>
> Would be a good idea if it weren't for the fact that --max-count < 0 has
> for a long time acted like no max count. I'd imagine many could be
> asssuming this behaviour in their scripts.

Many?  I am not sure.  

What do these script try to achieve by having "--max-count=-1"?  It
would be to defeat --max-count=<n> coming from elsewhere, but where?
