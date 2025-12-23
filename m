Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43F1C84B8
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766523662; cv=none; b=DjOpR8LabjIQCeOaSiZM7IxdAREStZJWlh2tqMGif0CeThQ1hnlJBOy8upzIUQ/+QrO9x9SM8Y6law3x0XOOXINIMn2eUJWfG6E2cB91doOgSykWlnZ85HTk/y6UlbRGJyqrW1zwliZQ74feCpjL+IhbMendwdh2TaEFljKGnA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766523662; c=relaxed/simple;
	bh=tsnov6d5ot1dmcYLM/elzd2wUqt5r34XzFJ3PqgX3Z8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=nZlBNlxzarmQaCIIYg3TtE0+HvJt6kBqcyS0uEMh1FYMjP1HA18upO39dIauIlzVVE0dZ5eyKZr4qWzPAaIg8J9rKodGJN0FYrFJXjcl//Cd/dgMfTLa2q3dNUESm+yyNbqhHDLMya5GsZoMGzi9PpPT7jftS7QKugF4KdB3ni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=akOD05B7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZG2MYnGg; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="akOD05B7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZG2MYnGg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id ED35E1380272;
	Tue, 23 Dec 2025 16:00:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 23 Dec 2025 16:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1766523658; x=1766527258; bh=15lYGVZoCoX+OYwplLRNW
	NrYEwSP5gSJPaSauAixJWM=; b=akOD05B7vrXkxxc3TD59M8AO7z38I83FwNbh9
	daE3BGPfCVxwePLUrFXk9WPWft7bcSY3ESky5pzzDo4wyTyLwEynwpMqK6LX3vaX
	tPFZnAa75Nbk4QzcUYZ/s13Ir/38DqPFpnJQ/x+cX8F+GqlXrsrvCkT3gluhqx98
	K5oE/mGzphxnC7O1HgJIsIx4XhCbEAAzvnW1dbbrvekp2QIT7AfCmmP410tfHXd0
	61j1UNK/mdX3WrOeUuB6mnaKHvxQNfp9aR4UlvsZbhwG9uNV5+j9/bfW9uvCMYRF
	SzB8TiR5VVJoVZ9QStAttDKzAw7yaW4GW7B19Tgjpl95rCmsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766523658; x=1766527258; bh=15lYGVZoCoX+OYwplLRNWNrYEwSP5gSJPaS
	auAixJWM=; b=ZG2MYnGg2wcQINy/lG8gCRhFTb2Z5jo4x+bjXikdV3stf837/FG
	fI2p+y1umRd6hvpLfwbF0WAPIFu9Myr6W7GYdrKD6rjTFAQsN47xE8Ykse0Vmpqb
	xxTvOKlr/0zVrOw5+0WcnZ15jVOdP2tgytKQ759MOIX/5KVYRhJgxP71SoQ+6eoJ
	0PkXjv4WcAxBlntycGu4yJF8YPvDx9Qb7uGRAaDemgSic5yTL7+j7p21fcdNQU0x
	VNTBvzPLP8MTEEt2ygnji5VkYx05YmV1Mw3DMnBYZpPM9nnakfbS0nZw7T7qooyn
	TAp94WozUCkGVk/YgvjPA5mG7/soxUDE5Zw==
X-ME-Sender: <xms:CgNLabWY_vY0EEH9kkDIn20KvoUtyHSC7AfjuyDC3DWyUOoVXbbafg>
    <xme:CgNLaZlCCX3_ierRe_hih1099jntRxFoUDLhhR_PFha0ebEK2boGGzgFAHfeOSD21
    JMdeleyo6S36jFQPwmWC1Sj9gE0Uabmdu2-OQMBtMo-IqbFb1UxSWE>
X-ME-Received: <xmr:CgNLaVDHG9Ywklp0YM4ji36aMUdIj2KTFJxU6VwiQ45Zr-DaxXRkfu37SknBAJC7ir7qQjYZGPvSBcJimPuQoOaAPox1jJTv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeitdekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujgffkfggtgesthdtredttddttd
    enucfhrhhomheptehnughrvgifucevhhhithgvshhtvghruceorghnuggthhhisehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepkeeivdekheetudduudevteduge
    ffheehkeegvefhvdeigeduffduuddtfeffleeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghnuggthhhisehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhu
    iihujhhkrgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:CgNLaRcGgGT97KlT4u7Hk8UC2pSeW1KP51nj9eSfUmj21Z3x1ObnfA>
    <xmx:CgNLaYK_9UjMAVtKxsJ6FZC98pceQaRy_pKXhRtdTzr3MCpaWYQGiQ>
    <xmx:CgNLacdBIcDY1qA5ngEttVvUVesMLmStU42Tzd0zBV0Zq_sKm09iQw>
    <xmx:CgNLaX1-SsDXMo-JvQmXT5IjMr4c6aE6vqhVO65RX4owvQK6-PwVaA>
    <xmx:CgNLaWR-bsIeW_Nl4J4-3g3JPJ0QF6ZjTFSvCsojaTVlkEnQ9K-sIdnQ>
Feedback-ID: i4e2e486a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 16:00:58 -0500 (EST)
From: Andrew Chitester <andchi@fastmail.com>
To: juzujka@gmail.com
Cc: git@vger.kernel.org
Subject: Re: Error in the manual
In-Reply-To: <CABd08tVFKDoBtdBsPHaE=Zocoj6H8yuhk86Bg+99zB_H7+r2BA@mail.gmail.com>
Date: Tue, 23 Dec 2025 16:00:54 -0500
Message-ID: <87sed09am1.fsf@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I'm not seeing how this is an error. The manual page for git-remote
seems to address what `set-url` does and what `add` does.

> Hello, there is an error in the manual.

Hello.

> $git remote --help
> or im my case I enter incorrect command
> $git remote list
>
> The help message:
>
> usage: git remote [-v | --verbose]
> ...
>   or: git remote set-url --add <name> <newurl>
>
> If to type command according to help message, the error appears:
>
> $ git remote --add gitverse https://repository.domain/MyName/MyRepository
> error: unknown option `add' ...

You didn't use the command offered in the help message:

$ git remote set-url --add

Use it to add a url to a remote. As far as I can tell everything is
working and documented correctly here.
