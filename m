Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575F4457A9
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137679; cv=none; b=S9tyfhO5CQLcd4sk3R8BXrCygyLCziIcjzNx0zBcKxGURBS8kVe4RFxf8zhcrnxMTOwU+XHYj61cXgKjrdKENFsB6AMT8wrT1gMUgtERDxdQ/+ZHS94trKE3soUJ4J0+qjwfhML8sFXgA5LWxvfQF5n33WHDtX4hl9VwfR7fObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137679; c=relaxed/simple;
	bh=4IVCuAUKHDCGPsI4tDQRF3FMOHSWBohgMGVlO+ZN+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kde2OVick7OkKhdBmd9VtYB867zzIi8axpehPBl0ma4xPSQJe1uMjyI2RbyCyUe1YmJpKyl/IoNiELt+ZdZLyfKIOKiGA0Yr45XgtEwnXPAxE4AowPl/N5xc3NTQ8tu4CH2v0q4fh5qXMULAiGU99VvUimQ0LxKtMeChy91iuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ui+yfotv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VnRzLAz7; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ui+yfotv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VnRzLAz7"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5DC39EC0179
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 04:01:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 16 Oct 2026 04:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792137677; x=1792224077; bh=Masr1ckc6S
	CuNs0SI3iR1EiWHVWOBW6F6fFDVuxW+nM=; b=ui+yfotvAEv414CtaI1su/XH7/
	VeDTedXnE1JBwo/+Gz304WePXdKK/mkTu/UM2Ca28R1jjE4tAa7a/DzMbtiBRh05
	k6fvvmc5ZnTvJ7HuTgjegPsiP/WzQ2Asz6THyY6F9FmdMTW8BWmcffQGI6D9mURq
	82LGhhiFcIhbZo6Y/hXbCUbsoJMaVkxcL+NmlD3DHUxqTlmwfdyCtqNkevadoxor
	+m9szGA0mHnZdvp7+8J2j1rFeg71FAzeYaWKgxBCMkQTfuo6NuAm4cOHkmgrofpa
	QEqLvh+Awf67QHsFTE/vpEGgjm2zsAIbE7ru6TKcvRmRI7ExCVExHgHOSokg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792137677; x=1792224077; bh=Masr1ckc6SCuNs0SI3iR1EiWHVWOBW6F6fF
	DVuxW+nM=; b=VnRzLAz7mWuwvNwtwuoDw9NueD7tHhNkbQ+dlmpbvrfSW/fnjj0
	JPZuUn795EFaZJn+Xrpfpnwqq5iLp927DTPbbsX7ntmbgNFQPrLpMUI7F5wqu9hp
	7df+Pnb0xSSfLZ6gXsuhtGaRV3UEngX8lxlEqDDCqDIfZ8WYuhukfXm6Ih+bjDH3
	/5hCBgUG5JLo2zkDp8Wdq2e1ZIW9gzghvra7DN81Vm3bOpiDj/CJhzXyYMj0uf5F
	ZsKkAOCgz9Z+3lpVvFmxiOnDQ6H3gqVhZFoMXYMDqWDsl5uVrIxzARIibSYzsdtw
	DKWdfabJFuzXhro4k+qVJkL00ngj4HluLZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792137677; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:orjLrUTYU8w0y11pKzPRvJUhtjjAsrV7JzKLqa3orEaTBBz
	sioK6PDlpw3b8lYo+HctaZvYcm0NfdoEnF9cF6RrZO6uGUiL+Oiamj9N3Kar72Mz
	tkrJR+bXbvQsDvJuWyZpaGEXxrqsbMJYt4LSNB/7+Kfh3pFJljNH6TN/x4IVGMdI
	+56hb1V33MTyQ/iRWfIjEcUDz+4U7szIjaZ9nIK3N//HgjLWYr6Mv85rRyQ8X5z3
	UnPMjSwFks7bBG0CK7PXViO8TrWRUwl4uDQcL6ASMSP52AqrZt6Sp6all7J/3Nx/
	B0cp1luR9NM5TjAd2TteUYugaIgO9VSlaCXB6mg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SShMgvvFACN2DQQx1dq+XWsv/dxrTefv/O8gqEA3Pnc=:4IVCuAUKHDCGPsI4tDQRF3FMOHSWBohgMGVlO+ZN+tI=;
X-ME-Sender: <xms:zdnRapDXZRRdzbldcXBr0v3ln3ypkJVkKKwGpNP4BdKM_5LWkYwJdA>
    <xme:zdnRarNpOb9OTh-VdaHODEmxlk2GmYesU320Aw2ekqm1xPCYWNGhWqajAeEb7rhYm
    j26bwPs-6z1ix5qDcCFfrcvOoqw_j-UJieb0AGdLszkTmH5rvCjSI8>
X-ME-Received: <xmr:zdnRauYtMPT1iY6kGczzF5L2XoqNd65bPcoDRR9jx-DtxhhCrZlydw>
X-ME-Proxy-Cause: dmFkZTFifJ1QVNrIyzQUpGROCoc6qaCzhfjgXwXZH/n2oRlyncETgM/D1kGfdehu8RYPoF
    mxdzY000JzmY65Uh6Ao2TKE/MI3vy0YKaSUw6+hkQt1wAjiIkYa5EVzjzUgNUCWIcfxRC0
    j2hsBoSt3U3q36gAPYjHgDJ+4N9r3EQZ3uBlg1upOOS2vNYr9djVVyRDDAhXx6E4oNGfsy
    4GVOgOty6NaZM0bC0C4/9VDHErGn3LkgIhB3Oe+pU2isFQbNV85Cu1BGG0WEifCtUlObkJ
    AUl/M2iPnkqTc0ulDelCdua83eAN3lmpt5RXJp7ZJtOskgOMd99H3t1myF7AlBidxDVSdC
    E856hzzLIxy76uosMCkE+b064bvSi9Bs24RKzg8la8QcpOZ8yzvRkGaf9mwuhED9mKAo1n
    JrOXxueqOE43VWM+5Q8PkgPuS/slPMEZkfQjsVwcWko9YLJtMDypoUGj7WdsLzVZwqvKo4
    3Ma5HJgz+mMPomo4kW5eyijWNORX+sYObte6FwXLfllHBn5OrwG5ncc4ypgbJN3nVAFB3Q
    0Bk7bfRqLzZsvIKtGOd2owb69EC0R1IF8xuuOZGuldC+Wyz6SRamLRf2RTtVzGkhepujxc
    yMLIUny4fKhJUpGOEWoEvxlfMbkQrht6Vnd4oJmXKml4ZxWKD2caV7/kKkjQ
X-ME-Proxy: <xmx:zdnRaqueteljvDh8CuHqxeoKgsPCszJ8ISm2Ku98CdZkZ_d16PH-ig>
    <xmx:zdnRagMA_KTqtAplXhf7u0XzN1ce7e1B1dJhggyHAzV3xZIZWZJDkw>
    <xmx:zdnRah7SQtPNPp5mo8b_Y-8WEdmtUXTAdw98Hs0RSTq5CvBn9ZNsag>
    <xmx:zdnRamTh6sGTgqWbI5fE6G7Oq_AlE44SFcFdMoTintwt6glHRKEJ5w>
    <xmx:zdnRaqWiawVXdNMA7lnUxi-fD2HAo_IJepxoXGadwTb5h4PmnlD5qFRh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 04:01:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 348cd2b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 08:01:15 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:01:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Quentin Bernet <quentin.bernet@bluewin.ch>
Subject: Re: [PATCH 4/5] doc: drop usage mentions of "git stash save"
Message-ID: <atHZyXcGzTQ5GkGm@pks.im>
References: <cover.1791827304.git.ben.knoble@gmail.com>
 <5a2ea087bf35a15760206e2c8ea1f8df5a43296a.1791827304.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2ea087bf35a15760206e2c8ea1f8df5a43296a.1791827304.git.ben.knoble@gmail.com>

On Mon, Oct 12, 2026 at 01:48:30PM -0400, D. Ben Knoble wrote:
> Even though we previously deprecated it in fd2ebf14db (stash: mark "git
> stash save" deprecated in the man page, 2017-10-22), the save subcommand
> clings to life. For example, 951ec747d4 (doc txt & -h consistency: make

Heh :)

> "stash" consistent, 2022-10-13) brought back "save" to the git-stash(1)
> synopsis, and 41a28eb6c1 (stash: implement '--staged' option for 'push'
> and 'save', 2021-10-18) gave it new options. But we really discourage
> its use in modern Git, so let's drop mention of it from -h usage and the
> synopsis.
> 
> It's still described in the manual, since some descriptions talk about
> the "save" command. As we haven't gone ahead with a full deprecation and
> removal, we can leave these pieces for folks whose fingers still type
> "save" and need a reference for its behavior.

I was wondering why we still have the command as part of our synopsis in
case it's deprecated, so good that you address this, too.

> Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> ---
> 
> Notes (benknoble/commits):
>     AFAICT there was no discussion of its deprecation when re-adding save to
>     the documentation, so I wonder if that was just an oversight.

I bet. In any case, I agree with removing it from our synopsis again.

Patrick
