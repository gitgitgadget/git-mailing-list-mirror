Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3D30567D
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788893843; cv=none; b=gsPTJzXjZaWHRJqe+EL2hRk8JfW7T28X9JfwUwnK/QW1KFbGyNWdISnQX2fl6A9rfTabLYDhwvam3maF/zuRG7VeTUbdcws3VKcUMNCZeCE02GkTR70skL6rNVrXWnmsBvdg/Zh+LAIUhKx+3kBQ6SbhlGAqOwWXbuQlN5z+ICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788893843; c=relaxed/simple;
	bh=w0X4QktNsvh6+07dXBnIozJUj6fnVwHjTkYMBW+oCZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bubyXg9+HCA16MTBAOx4rR8bnELLRVCyJS+e5BeN0GUvdpvtNq3U3xP1cURwXFbSrD7crXRsaEVHj3z3ig1YDSem1163Tc2I8+vgvYtubk+7Um6Uud0az6teZfQI0+dcqP63rw9U189eKfIFWScFOUArnt+msogjqI7GLh/Jqeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lVZZdO0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B3PxyRIc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lVZZdO0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B3PxyRIc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A46F2EC0195;
	Tue,  8 Sep 2026 14:57:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 08 Sep 2026 14:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788893840; x=1788980240; bh=Yo7RM4omls
	MH2I8ifZI5GdFINX+n4GQB/HsZyA6Isjk=; b=lVZZdO0efYtoYRP8GLFLs8CPMK
	fLA9b5vQUIBuw1alrrmvoVqVRQGngDXDCmCgxAle7UjO2LCJ4mE4iMgzNRnKUDQL
	Jm23rYTjXV9XO3gBE+izw4xCTACpR4af6nYFblFmFja/h4DA+ZEb2lmY5Fqe2fgX
	zRCwk2OHBqysptIK0B2Qzr9aZKSOGiQ46F77abfF4ntMK0BkAuuJdF4ppMqsFUof
	vOGtm+GfpoW/Ttdd1PPsu6PvNbXLGCqnRpbVvKxx3Aj8q4I0Qu0J03PmDrIQ8HsH
	zWSIMWppBN5H+vV/ocTiSDWTtetWSqUyQD4IxfmBUPIvdcNrOIUwq88LIC0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788893840; x=1788980240; bh=Yo7RM4omlsMH2I8ifZI5GdFINX+n4GQB/Hs
	ZyA6Isjk=; b=B3PxyRIc3yoi/67HhzyLkubHa/pN4vdsfymn3LiQZ7EbNw4xPUb
	rqBWENc0lfOaBAUwk2YjAM0oV/cVonrZWNibDYmX4klwfyS8uCb7iVwbP5C6xKqL
	v9kFkSkFC3f3dB8n5RsX/e30ujnVWiaP62pkM8dcIg8vhsheQx5ylav7i/ZvxQ09
	YP8Z9usE6ajrIFSY9LQZPpUcPSJz1RiKgD+A/Q+45btWN2A1O+XQQUP5qve75llz
	jUzQzAcaafpsvPfmOyM52FeUX9kfR8EteHFQaAXyRzV97N2bUQS4UMv+4R8klJwv
	gjFc3Nqv3PoVCg5+behuS3iVyfCFGC3bYJA==
X-ME-Sender: <xms:kFqgavv7YgEA3OeXg4VX7NbQnIgArcEsarP30_C3WdxY5JMJqeH5lA>
    <xme:kFqganeMG964QWCV-UntYS14Dzzwct7dR92-r3Nl0fxwnlzaC6eNnzAynDrbs7Iy9
    OOJtaeFu7Hb6zfUk6RVP032pr4hTWqH0ypf6YSA6QS1yQWUcf2ooQ>
X-ME-Received: <xmr:kFqganzGi2-ZXsbTCZqCUNmqnlJktrzkp0AH1QLd4djPvjzZKz0Nd6jiRTT4n4IzXiXMQSwq6I4nxYjQhaRxvCjVoVLJKQ4TBWbI>
X-ME-Proxy-Cause: dmFkZTFC32erBOu54l3wjgVONHoyVSi8UMPnii2FecA/eZNAjujtXjZdjqVF9F6uFJJPZb
    1lCbSSz4oRvTiIuiYggceBrb55yGMCgrirdVNCw2cyd+GITVL4oc2fPCadOOmrBUxvtxCu
    2lECrHgoFeXgegGp+AlGxVYrJ1QxQu6+v2v1kN8u+X4dUPU19qePX42xJZW5yJjTRzFhWD
    rGCedsJYqUpqgMDSZoLweb9qtQRY7QJHUn5ICIG124wdtJBehaH/0F+n8aRKRGocW6KWRl
    O/9IJ1kiMwm4j1ixcbJLINvW7JJMPTjXG8x/p+8Y/RDDum5KXBnRI4Bkf1gj/EpgyPR3Ka
    skDN7R8koJq2Bm4XnPhK9/ixLEomXnPzNC+194Nb5aLJwazSwSf8A5tsYfTLhTWhR1E+Ay
    4KjUcqWt9Kiq3yldJXwm2AkGmSCS47Q9WHMdX+xLjDsuaooqNVy0E3t+wFfvJzUllpy3QC
    EBigjWE5Ts7cl8FsJWzb/3tiaJAvAjQuapgec6vqiC4vdabs19GDhlOg1cHxXHVuo9XXsF
    Dor/uu8HQc08X4dv0EOXWHEkLCxiVxXmfha6xkycOBnDS++xV3/WWE6rokAgPC8iRv4QUM
    gESjoCfYvjtNSOGx/X8on7mK3yKCu3c2aWHWtAInKNoAzD/BNo0Cg34m0bxA
X-ME-Proxy: <xmx:kFqgatH4Rm5UqYL4s8azgQvA9cXAi98UuRkOmEBFkUEn4y4NbD6r8A>
    <xmx:kFqgarzssAPkFYp5L1PM3502eNmNLPte2jxtr8Q-OSHR9wEwlT8ZmA>
    <xmx:kFqgausB7Bo1rg_PAfNDZ6OY9s1eAkGjnqeRZ9TXC2g0_qzlx0ETbQ>
    <xmx:kFqgao0GxZZFzfBuzOeZsW-kFxVWY3RVii9jsblThShDoQfwlqy8nQ>
    <xmx:kFqgatjtEmRqkZISabHYoFuNtMzueNi7OLyiK1fgLUO4sWckEtVpCS1z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 14:57:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: ben.knoble@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH] advice: use global config for default branch name
In-Reply-To: <20260908213840.37833-1-ub4nal@mail.ru> (Vsevolod Myalitsin's
	message of "Wed, 9 Sep 2026 00:38:39 +0300")
References: <xmqqik4fyaav.fsf@gitster.g>
	<20260908213840.37833-1-ub4nal@mail.ru>
Date: Tue, 08 Sep 2026 11:57:18 -0700
Message-ID: <xmqqik4fwoz5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vsevolod Myalitsin <ub4nal@mail.ru> writes:

> Yes, I agree that passing the "advice_setting" itself is cleaner and
> more future-proof. I will change "vadvise()" to take a pointer to the
> corresponding "advice_setting" instead.

One minor glitch is that there is an ad-hoc vadvise() call in
advise() that is not tied to any particular entry in the
advise_setting[] table.  I think we'd need to give a name to the
advice_setting struct type, instanciate an ad-hoc instance on stack,
and pass it down the callchain, perhaps like so:

	void advise(const char *advice, ...)
	{
		struct advice_setting ad_hoc = {
			.key = "",
			.scope = CONFIG_SCOPE_UNKNOWN,
			.level = 0,
		};
		va_list params;

		va_start(params, advise);
		vadvise(advise, &ad_hoc, params);
		va_end(params);
	}


