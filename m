Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6822D73AD
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870577; cv=none; b=YrHZ79oz5S8Ji4Hm5D6joe/JrYgO9IkL7zNSSwj0Ir6QY8GwTJ3MIWkwxOgGmsHh3fCPxQpQeia7wXHBCTRRBo9bWHnKKrZZ+VYDC7ULvYHO4bJzka9FzKK8mFXxQ9bF1aASTCbElttlskvM3uGsr7Z/TfLSG3xz+EhciTNPz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870577; c=relaxed/simple;
	bh=5KF7feBgJW4T4vpq4pD2PHkZp2++AKmA6XN8ZYA4o6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OE+1Da3AGfA9DJNpX3aJDnSzYwApT5gCrnDl2mTS381HeBaMV3eyUSO7PSfCrMJM1XiRbtWQZhcZ9QjnidC35wVKPxAjC9nCz+WmIXXdlnsh/828NsxNeNePaTVD7Nt0tVEJD+Ug+8S/k8S8HiEe3YPE/hCBf89ZPm/g+5+kI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W4WlGaRI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qV+cKpdg; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W4WlGaRI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qV+cKpdg"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id AD4501D0013B;
	Wed, 18 Mar 2026 17:49:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 18 Mar 2026 17:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773870575;
	 x=1773956975; bh=81mMp3wyyC+LG1n5rJEumnbpRMgADhroYa8EpxDJDdA=; b=
	W4WlGaRIxGlpqPxhTiRcTTi2p4NBW6OX1weB8CXuih4+ljM+QcvD6aPPj81+ctdY
	Q83BqdWQZJlUS+ZQ2VWhYm4Mk/NCotb3ox3XkOKk3uKKGqsXd+amwfTb/W/iys4u
	2ih5cM/TBNARjHWM7L5+xanYeDCbLM+qEEKkMvk1erqokXr12/Ij93tkoPNjDL3+
	KWiChFWMTRkzsg3yXx2OnC/3cM73QNTHL8DxVVhAoNmVx6T1R5ki5Dxdw6+TWM8C
	HMaszQnyZziScZGvufr+K5VSSJMH1FWst5OTtGQ2blaFtQ66Tg5m9Ph+tqKG82kP
	Z8fUeORV//lj2thC9+6tEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773870575; x=
	1773956975; bh=81mMp3wyyC+LG1n5rJEumnbpRMgADhroYa8EpxDJDdA=; b=q
	V+cKpdgVATZIVOqmRRrnxIRvj4+JoN30utasFVjvXr9WFW7q63J61HUnHvWoAVAI
	7ymXeEFLEaTeFuCscSUQEzfSLt1V4JhvpV/nn62pM4IysRZBhnuU9xno/q0QLU0A
	f1+2WwaftON30utb/Qb9X8fQSOw9YiW2XZxffloPGuFXTDTCloROvU2njtDkU7aq
	LVjW9bZG0/LUcXVtaNsezTi/CPIRzEL30lwpjz0S8+4Sjia4YmnO12wgkzbymQvP
	BeyC+0B00qo4C+VG7cSK6p7oZo6oWhmANYbaQT6Nj7nVu3aF2FPb2PyZXkSdxnty
	j3P/XGSuL2VK7PGEnBBog==
X-ME-Sender: <xms:7x27af-RVeR8Vpo_A5bY4IP_JmPSYw476jdrh0AvzqV4jTAIwTVJOA>
    <xme:7x27aTI7gISda4YqqzvUPjwrmFROb6LTIjc7xzSirW4uY6IGj4rSyOLj_p0877X0N
    VdzAAZX1f7WewT8SLOKyLMsIFZJE1IUC-fgbNQuxcbNq-Yo9MM-6A>
X-ME-Received: <xmr:7x27aaYoXsIYExpu7EFD1LN2TjER7spgimp0sfzO4fdjORsqTiAKcIUCWUZQ0Yv1964rDwDh7FtOeVj9gGuYw5tkVqy1dHO9AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgrggslhesghgrsghlrdhinhhkpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7x27aVL2brAtFmLZbElsYc_9ek6zBX6DePGH7JPq6Ik0s5OlygqIiA>
    <xmx:7x27aYAIhmrEKIuEZroEgVgprlQJ72STw0LcOiSdyxP55-reesXoag>
    <xmx:7x27aaofRqe9IN9u2L2Xo42T_n0Dqf5O3bQvulN6vuTV_9AqlXX_jA>
    <xmx:7x27aThB2UPjGj5awpTRdv8ssz8gi5yl93nDxBHe5u9RW5zScn3j2A>
    <xmx:7x27aUbIhm46Tj7-pdx2s00DS_QRkonhnpTfxBubzTRfxuMEd9wiuBKI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 17:49:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gabriel =?utf-8?B?4oCcZ2FibGRvdGlua+KAnQ==?= <gabl@gabl.ink>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: add missing space on git-config page
In-Reply-To: <20260318210020.759128-1-gabl@gabl.ink> ("Gabriel
	=?utf-8?Q?=E2=80=9Cgabldotink=E2=80=9D=22's?= message of "Wed, 18 Mar 2026
 15:00:19 -0600")
References: <20260318210020.759128-1-gabl@gabl.ink>
Date: Wed, 18 Mar 2026 14:49:34 -0700
Message-ID: <xmqqeclgq041.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Gabriel “gabldotink” <gabl@gabl.ink> writes:

> Signed-off-by: Gabriel “gabldotink” <gabl@gabl.ink>
> ---
>  Documentation/git-config.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
> index 5300dd4..00545b2 100644
> --- a/Documentation/git-config.adoc
> +++ b/Documentation/git-config.adoc
> @@ -221,7 +221,7 @@ Use `--no-value` to unset _<pattern>_.
>  +
>  Valid `<type>`'s include:
>  +
> -- 'bool': canonicalize values `true`, `yes`,`on`, and positive
> +- 'bool': canonicalize values `true`, `yes`, `on`, and positive
>    numbers as "true", and values `false`, `no`, `off` and `0` as
>    "false".
>  - 'int': canonicalize values as simple decimal numbers. An optional suffix of

Ah, thanks for carefully reading.  My bad.

Will apply.  Thanks.
