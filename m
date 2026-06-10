Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569DE2DAFBD
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111291; cv=none; b=m6rYATJGHq0XyO9O2flig3U0Xurfk0ReWE7b/+0fHOLBb5LtABBBzw7AcY8JRkQBEfg1vuS27m8E70oDstUOb1u9IWbggG2nOt5xk7vT/amg6hBr56Imj9532otrjoBp2r2FP8H1XcKCruH5wpIDUazcavZf46MVPe78eiMBLw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111291; c=relaxed/simple;
	bh=vLwXWKGNp9Hc3U93kGm4TSZ5F+++c1ncadkvjfTli9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JuYpedRQ573Toqs/iLSV2nMzT1qo/YL00C4Ahpo5JoccDdrGgLtNebKck6i6jkbrZ7ToOIRU8ZsFDNY2tFj5/WntYTaPKgCLBhhi4Sb7wlhBbPffD3L4sg69sxBby6veU1eTrYofj7JuwscMHQ2NF8WQoJcZZZYnaNXyC/PPlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NryFSvA4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WcTpDtfn; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NryFSvA4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WcTpDtfn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 74114EC019D;
	Wed, 10 Jun 2026 13:08:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 13:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781111289; x=1781197689; bh=ymwaPL+UiF
	1WskDx2Byd54USY/3sRhaM3W4p+a4xgUU=; b=NryFSvA43WHKAdfuxwaqlZaIK/
	BlOgaKfJl7aNDWC4nxUkAIqvbdcAobrgwFMBiYIZ+kkfAAyNhiMSL9JkzeU1c+2h
	t5AaQLr4OPvis7V6Wk5jVHXlDP+NZqlij3SaWKxx0D1WXCdDnuLc6Qna+WFoJuif
	j4iNQXgTTQdpMdfZB9HdWiquyhmEsUTtHUCRfnLtxhg6EmLXojbyiDqx/eYQLKYf
	PWslGVdLpQyxZLYRLOTbmINaazCRYw3qgULeFtnQXhArQ3V8W/iccizdmZP47se3
	suocYUpF+zGzE0vrrJhJr59c7xCU+DgugCqzh2XeFFXmNnJIeS12+b5yS2Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781111289; x=1781197689; bh=ymwaPL+UiF1WskDx2Byd54USY/3sRhaM3W4
	p+a4xgUU=; b=WcTpDtfnYHEOY0datS5KgbOA4yw8ELxkQnwP3raOIHA5KBd2Ghk
	/xTh78vPxvpWF/YhDp6+5GPDSKaUUkm9xC0NkJoI9cEdTck99cRQguaxLrF/WHGs
	0T02ggwqjC+bHj99sgC1CjhpvoinW36SVpHbY5LOITkVPIpoDgF4OiPawV66U34B
	ufYfOi8AmYyoc47GsLBofpkdm/YcT8+YSncvu9SuZjZhUIp4L+Jw94dULfJ23DF0
	4x779H1/J6WtPK8w5m0ExaukyDeBuFhe+jS35X7CFD5F/CdHLNQW1FFhQh3hOHkM
	1iE13z5U5dyIhnduV/brMDMyk8+epHb/kDg==
X-ME-Sender: <xms:-Zkpanuev6bjJjDy-7NobCyywjV9bApA7GnvvDItBaEUnOrwyvUm_A>
    <xme:-Zkpav7zLp229pBTNPXg-yD4zJLLkyEw8vK-P1E1sMd6SlFfoKfjF97Z3rZOiub38
    8uS8qYx62XtD_7VUeMsemIIRaBGXhptd31FP4iONydjOR4fDFvpdA>
X-ME-Received: <xmr:-ZkpaoIf2oInb-uAqW5gr2vTsbBFxdUo32tgEWRE0p6hB94x-wQ4uaea6ocZdPC7a-TfJxW8ZDdIpsZzRYkuEK8c8V9NTnY-4qvE>
X-ME-Proxy-Cause: dmFkZTGI0p5XHOiOb+DEwreVyNm+G153wxiQ/AWRy+S8Zl9DTJbiNOA0C4CNf2WNH3BGhF
    h6bukNYfD+GZ7AJH8U17u3kkcTqXV6tJq+9JhzhxSw2HOU2r8JAsG5zwjoYeXHlHAFHglx
    H8aUFeiLlwI72+JEyJHPMM7TKiJlP7eL1tYWqXnSLtj92U5yeBuLN5RWu16aKKmfgw9MFi
    DzG7YcpOhk/WuKMPq6lJYwbur/ZSoXlARtBaMacjawUaxCHGf41dEQpAgLQlKXrCnyN0X/
    jYKJo5VENMbfV0Nu7p8nAySQWXOqXSdq4gLE47mtKIOYXTvUCxaUyp+5b4zwvZfiEN7dFg
    Tr0QrrDEqv7la2ERuwII0Hd/QIngnCQ+zWu3m6G6hjaXrcEsGIrOyDlUeqTqdgE5j3w9CS
    h3O4bqpU+8JlGb0IxE5OTD1BwryYd/5eueBIh2t/wC2NQtuckmufZbC93w4fGaKlTiF6pY
    7z4VlibPLue6NZdMScvyATDN7sazJeJYjtJzL3YcNTdNe0BRxaOKtUVDbYBC1PlLy4JpIG
    uBun7R2aYmrR8tQeyyKTYLmuHES9ws1FXNljlul4gE82tlZe7/bnmK5GRGoLnXhFnc/IQf
    dvwrpxwIfV9lWyHxi23QqQtcQxr/smMA3f7XnbIE+q41agF5Vf9K3cfZxKcw
X-ME-Proxy: <xmx:-Zkpav650F9pgkFYv_UlO2x_rDtq62pwN6p84MRFPGCCPquaFH-doA>
    <xmx:-ZkparzggneHAQlfBcesjP2vALpjJYTKLqGOIxV_ZECXqVJYSiHGQw>
    <xmx:-ZkpajYZhLikbliZXAU5RomqeYR-XkAUj5Ey6AyOqa94ePN_QWuWhQ>
    <xmx:-ZkpatRJgL6BR_q6tHchx-OAX5JppRHsvEZjpUaL66XPSLETZNXwxA>
    <xmx:-ZkpaslyQeg3ah7HjExvv7HWkND_M0-_fepsD1azyzulKvUoTHZxbVc8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 13:08:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bash-completions: add --max-count-oldest
In-Reply-To: <a804828a046d8f12ef0d03eaf014807b079bb707.1781102091.git.mroik@delayed.space>
	(Mirko Faina's message of "Wed, 10 Jun 2026 16:38:17 +0200")
References: <a804828a046d8f12ef0d03eaf014807b079bb707.1781102091.git.mroik@delayed.space>
Date: Wed, 10 Jun 2026 10:08:07 -0700
Message-ID: <xmqqfr2uwcg8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Add missing completion for log --max-count-oldest
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  Unfortunately I forgot to add bash completions.

That's fine.  I think it is OK to add a new patch on top of that
series.
