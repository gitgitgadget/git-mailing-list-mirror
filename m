Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84C23ABA8
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 04:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202834; cv=none; b=olfkUUJZ1+iQ4ZMS0rJ32QRLu5ShzlOPms510fWfAVREaS4TdS2BSlZK0BEZRblRxGbbP0sgbPgo+I8ViEtOU6g3Tgr7EFTKIkE6wPz8cgco1BgTHgmGQTpbFw1dvukZUdY5Mj/kjSEyhyhE98fF4HIAGnUWW7QhApw0VB5jGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202834; c=relaxed/simple;
	bh=l6x8lWwqCpb5ReT72r5c4NkMFb0v6S73OD3OvQUkMbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z7kP59vbLGJ4sT7WKjdbgi/RpwPjY+iPWkO432z2tMjCn4CL3ny8fZ7a80KKx23NmR/yySmV/d26F/Wbr+FJk0sxaTkN1UjXv0t7ogzuYvTXH4ioHgLijxGRVLFdVk73qrU9ZBjSTC40WqAWbGiLr5eoY1rIR45HebUuv1rYWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aJSepUTv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FwRaIsi8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aJSepUTv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FwRaIsi8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EFF17A01C2;
	Wed, 11 Mar 2026 00:20:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 11 Mar 2026 00:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773202832; x=1773289232; bh=JgAmYDktvo
	LowV7PrjUiYU26KRkaM4BeF+YedzvX0Zs=; b=aJSepUTvIaxPeeZwWCSf1/Yc1q
	esGRyBCfoWDjfeO2AOqkEe7LvD4SxEMmr2YDEcwAbDuwNnUc7Xa3eU8Pt4NoNSMe
	hc2NrVUPcJzz6zFrUZlQIfBr9c7lbcYu21Y2UIQVsYV0ar5fIANLRFaHRYiWUOft
	sEZLHVgEy1NvDxqiEIIzWcwsVVDmq0+1McOeilMQcbfMnqn55VnyZOoWRoaJiAOi
	NIAxdJeRPGa4nG/UCubZBJS8LctuOtYhJkKxIa1dKUKgoPCL7P7oHuDTsTR6oF9Y
	U4tASvLNpyFqz7XfEV6krKJoGe6eLafcYwby/vDtjj2IaMbrnaGvPJj0pnOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773202832; x=1773289232; bh=JgAmYDktvoLowV7PrjUiYU26KRkaM4BeF+Y
	edzvX0Zs=; b=FwRaIsi8Jxj316aoZ5vK4PkIYEZ46yliXMUe/HXIn4rE1RQwRPU
	krhfZR/dT0Xo1g3WN9mKzAHzXlaHdTxPF6iFo2EpSLbWARVX/AM6epARMjIdT432
	ghcZ1E098cegSnXZ3w/2sm7U7JX3VhkFy8cg2hDCD/YMVCX2kUYNBcLmn4rUXUD/
	kmKUt62a1hL1Kua4mz8uV3Krh0PHCwAg/eBnLi6RZcVgD0YAr6te8duL/Mu2ODtt
	PForHmjnUY6VQzgsRTmjBAXA3yQit1nsNffmDoFKBmbMtojftaqKNsP5RcLHcw9c
	+hrrnpRYytz0fk0kCYfwerWLRHlCh4wzqHw==
X-ME-Sender: <xms:kO2waTqMNq2wHS4A6IhmBcbhsnumhRwQaXvAjgWoP_3vLaTGXeGogQ>
    <xme:kO2waUqR3Lbiu4c2B8S_0e4N1Svh7Q_f2fr7gQbarMZ5LEIgdF8pS_ci4vaSXgnM6
    XZfFwmZ3e1cQ3gg4PmH7pLYo95E_7Y8DHZv4pJMS8OzCAujaPkyf3U>
X-ME-Received: <xmr:kO2waVNmlJDPmOL5rF-xk4BeTUbtizvafHnvZnH-Y_JVssuju3v0Q9wnQQY55Ov6LS7MJdN5gmFw-uLUSt5DsD0BwLLUU9fy0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteeijefgieduheffhfetgeeggedtvdefieeiuddvudetkeetgeefteejjefg
    hfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfeelsegsrghrrhhoihhtrdhshhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:kO2waVwxwgrj4RT2FodiuL9o23zUoE-QxX4ZEkjKtXeVkYT5TmnYlg>
    <xmx:kO2waevhGAOMJAZueI6A5Nue6It3ZByxs8Ms-zU0lVXU8IfPQojuIA>
    <xmx:kO2wae6gywkK0dOaD2lIwxIL6oVNanmKIN8unT_P36hj4pcq_U8nsA>
    <xmx:kO2wadRsnGXePM2y086KHB_f6Aa0Tb8sST85dfTXG87ag_e46oNmeg>
    <xmx:kO2wabNG0qLhUYJJ9dYlTFKYEP5TynyQIfIqUx1zjs85yR-1kqC1DKA3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 00:20:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 1/8] parseopt: extract subcommand handling from
 parse_options_step()
In-Reply-To: <SY0P300MB0801AE08F2AE4C0EAA274A68CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Wed, 11 Mar 2026 10:49:40 +0900")
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB080114A7548292AB4B60D817CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<CAOLa=ZQ3eCky2rH_D-6=vwQ26TKW_dSO84+Z-WL2LFJ2rGVmqQ@mail.gmail.com>
	<SY0P300MB0801AE08F2AE4C0EAA274A68CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 10 Mar 2026 21:20:30 -0700
Message-ID: <xmqq3427ro8h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> On Tue, Mar 10, 2026 at 05:46:12AM -0700, Karthik Nayak wrote:
>> > +			if (ctx->has_subcommands) {
>> > +				return handle_subcommand(ctx, arg, options,
>> > +							 usagestr);
>> >  			}
>> > +
>> 
>> Nit: we try to avoid braces around single statement blocks.
>
> I'm not sure if we should drop the braces in this case.

You should.

You can tell that it is a single statement immediately after seeing
the beginning of the line, which says "return".  It does not matter
how many lines the function call that follows "return" spans.

