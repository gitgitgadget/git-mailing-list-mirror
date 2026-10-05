Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3B54707B
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178052; cv=none; b=nPAUwxTG+n0U3NFBkhjjdCXcP3jTgFJnS6aAvTvhTkIAGiRnDILpysxUV88NckUh9IK3VVrSrlMG0mysVjjPpi1p+qFLy2nLDzsFPy9zf9+GTrqJz5+O+KWAA/mDknywjGttv7Edj8QKl0O1Iv0W3RraCkFx2dhgC6Rkcq5X/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178052; c=relaxed/simple;
	bh=fbkEk2p4IblheaO5MaTq6VeG2nuemMlD/PKsyGXFFcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jyYQ/S+exT5l4W6jZCq8d5ZzRKnWwRG/aZTrEYYvo+ZIYxWjZKJTlZS/KELVNfzk6l7hcOmo7fslFmKRIWO1e1+sb+FX814Ay2HGQerEkOa5NIrqYzB25Z6BaaYIUuwfxF4hOAJEkQNWQZf5YRTJcP6DS7ptb+UWceB4nrb4wMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HuZAm9eB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mtI5H95z; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HuZAm9eB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mtI5H95z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6DB9414000F9
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 01:27:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 05 Oct 2026 01:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791178049; x=1791264449; bh=wZ81tKAyPv
	/JHAWcKKgTZubokl/p3G7bONiReZ+SJMQ=; b=HuZAm9eBBIJZSTHg2p6l/qf4P7
	Je369R1jSfvyygN2Me/ntaO0zNHXsFDDqMc58os7DDO6MBXlIz42OqVhlXzJw+PN
	EfLPXhH3b+flP1hK9tIV+NegMIRaRvD/KKq4u6X8Jb10z+J8qZsG4gNgtSQQbcie
	X+bGBOoIkW4gexO2YYU7+vDZO0TNNdtug8Hz6SQn+fh9lqRcpsG1KR/5PJNSi6nh
	fWoeadpDl4Ka8mdS9F8MCXImIpRRyjKyyla6OKBxGpHTwymyIy0G7If9BqDsFM4y
	SSVuyG2BE9KBh6ENxxkjqAoE5E0YG1aFA5RsdgsMKKy35dU5QkqXL7UsPA/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791178049; x=1791264449; bh=wZ81tKAyPv/JHAWcKKgTZubokl/p3G7bONi
	ReZ+SJMQ=; b=mtI5H95zs9/C6czMSKYj2lV7F3CDyVBc7gxN1XgQCApl/iEBPdI
	QLdxcL7DRy7Yu8mah4qdKa8yYId6g6Ref8ik4QI03MuEsCHMvwiB2oOPQ7YuCf7l
	wnJHy1vllI01ZPSd9aSm2SsTUVTRUdkbLFBrOqDvsxnIsfyJ3e2geOXheoDmVmeQ
	BzBR0pusSXRvAF6RS62SQk0vun748tJDK1OkLfDmp6RWRYgyxflBMLzqgW06VDIA
	EnxJ6hU/rL577FX7JJyXl81sWI4eAIHFa95ixIIH0NKLqwZ50BlPNPGPhA2L/l5S
	kJ6J53N4PytmIb8jcoN+xkojdr6voSPweFw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791178049; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HFCCc1tNA++c/bChzeXkbYRIF+SUPylRTSV3e/D9+nTC078
	QRyex4bQWjMcTunGpYTjSRcPcRMd2eSiDrAVFggW+bRcyBavqa/Fej7OZAa3+csO
	2TxI32u94uNT3VuVumz8T1NbpcSd9LKokqA9gBRq/u066QQys+Ey1Fo2EpzV+XVI
	c6M8v3LyYxsbhZonqz4WPO2LggLA/9EPhhHW6RDkQ1unnKR4HA+GERtOig2GUL5M
	a+Q8/GYvQf23NRrveALRBv/rv/Z4A2CpKBEFZAYKTCWd+HqUHoZ3ymbEERjsW7oZ
	iqFFDYQh9QVJjurr/4EEW/nR8/wn82em3r1986Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lnEiAM+imjM93qY+oAOQNdat+XPXh0XfFclypj4yAvY=:fbkEk2p4IblheaO5MaTq6VeG2nuemMlD/PKsyGXFFcI=;
X-ME-Sender: <xms:QTXDan0ndHNuhWQvbgrlC11YP9Rya3xCNb1dCuoSKyEbFHFjVLKVfw>
    <xme:QTXDatgV_QIjvz0EqNepIJp02kwIl1SLBawSFTG-sHN8SUtSonvZ09D2fN5pWnmez
    bh6Cb3IYHHd6bg5bxp69O6JMjLjN_uHPTcxNV0qrTSxK1_t6lcO>
X-ME-Received: <xmr:QTXDalRlAE_li__J6HKMeufiroR77ucnvwtOYhuP9WjDhyjBkELl5vz6atdGghwY-g9f3mFbImygEGegXDkmPsS6p3roUOvB8oNX>
X-ME-Proxy-Cause: dmFkZTE3MVLSYXmnbY8EeXSIF4jdr4WkE+DFG5fp6w2B9bGtETRRjThGYrP6/L3tcuYvmm
    VsyN1qYh9jDM235iQp69ku3659+S7XxtcyWrdZ0nPQPKWpgua7kvbmLU4uzYoQrhlVjZSf
    tgwbEUSirYQJgiejHhqlzjZXvBH2jvEKPFyEq0oa6lQKZu6D8+HWWyQ8SFii7qMPjcgQww
    YHIagsjuH43HoK2WArhIpd+AqtQlYbuAmP85A0jWJ31lFd44sP0UrN7X8TdGMpiO74dj/T
    JyC5sXCdZxGHNxxI5WwYHmvjfx2kZ56s3tvGDvu72eM9XhRiKxiVQdjOa7CR/OU2bjenmh
    6IFQXTA92fUZIyoX8bRKrTJd6QNmJiQZVSUZQLet/9wxr7HlLi8DAuFVTaoxZoEdBWlqvi
    A/cdDc6C1WkQC8B5xPJdZWqG9FKsNNZFhGfVllvVlfN/72mmfV9B9jBZn4VGwst1K+j2Dc
    1TyLFUDXC9w879WwTX8tuV86FILq8T4wjskuD9WHnmzHFH9V+xOOzwIhjsLPkSpdC749PH
    NxuTnUdGLEQ84p3uNY7JDqIsggMJW9OnM8ZZCy1Bv0biGx3BvMaxpjeyBdOdc7cJWiRfrh
    fI2pd40LIQAa6B4uJj4sLvkSXIBkallR3nlZK3cgBw5zVFA+j4y1mpL669UA
X-ME-Proxy: <xmx:QTXDamggbygmqzdmmgzEP4oJekiqqnd59Xkcu7E1DctZRFhR16KbkQ>
    <xmx:QTXDat63r4hvSoVsNgb8QuvyIgzpWf5_EDShJ6lMhECAq6VupNRenA>
    <xmx:QTXDarA-PCHa6R3WEL9m-tht__eMifD1DHTdzpUEYlXt0vl3sq3l-A>
    <xmx:QTXDasbaCx9ezDvSYHftjYLp9B1N2jyrM5NEBH14WXkJrcEe_M2gdw>
    <xmx:QTXDahh-Vx-VUa_ckVgHdsm5S5wwAhBlInhH9q7j8PMj9dyOzhyLSNNk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 01:27:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] stash: use named constant when parsing "--all"
In-Reply-To: <06b58ae0a1d81f4d1518eadecc3385072a72155a.1791108351.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Sun, 4 Oct 2026 11:05:52 +0100")
References: <06b58ae0a1d81f4d1518eadecc3385072a72155a.1791108351.git.phillip.wood@dunelm.org.uk>
Date: Sun, 04 Oct 2026 22:27:27 -0700
Message-ID: <xmqqzewsogxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The code that stashes all untracked files compares the value of the
> "include_untracked" variable to the constant "INCLUDE_ALL_FILES",
> however the option parsing code for "--all" uses a hard coded integer
> instead. Replace the integer with the named constant.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> -			    N_("include ignore files"), 2),
> +			    N_("include ignore files"), INCLUDE_ALL_FILES),
> -			    N_("include ignore files"), 2),
> +			    N_("include ignore files"), INCLUDE_ALL_FILES),

So obviously right.  I wish all patches were like this ;-).
