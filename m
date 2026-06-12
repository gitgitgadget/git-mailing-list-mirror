Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688DC35E1BA
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276758; cv=none; b=WxZJ3FXm8kRFmu0gMfdyRicicl98DedcUxfZR99xqp7NzQHMXRuuhPv8OPKP/ZlZrWgCo+kbmd6NszpQB9yMsC0BrawXkOKMFAB+aKdEV0sBYNjZr6priKPpGfp9/kCrnocTuAvF01FspYNdAD/vLIdqji0dwnwerncXPsWmDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276758; c=relaxed/simple;
	bh=t9JqVfEPgBS+NknnEFy7RPjWLNRd1XIr9y/rU15LP18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qpxPXE8B4W1xtpbcHaoaMk+yTZHl/NFQJBrJOJy4JuUjwGhRgcHNoVu3JmmTZMPTx+tSM2qiNsqMW94cTwYwVQd8zOFI3Rd0rxMv6p9QMs2UQJD4cB8v0Pe1am1WMqk1CvOD5vvQRdTJlDrsA5enWfW40D4oSO3yxJ/oVG/DIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N07++sAM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qu3eadlk; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N07++sAM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qu3eadlk"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C645D1D00143;
	Fri, 12 Jun 2026 11:05:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 11:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781276756; x=1781363156; bh=LgOmjCPwfw
	HUEktoiPPlj1tPVPIQQqm1mHCODRgXWG0=; b=N07++sAMGCziyDSK3FIg0PJV3X
	y6MZv8vxnnYz5IQXRR1vMZYG7Dr1J0Im/xtnjdbYO9krBErVNjgBkIh+N1Fna+TP
	K5IyxrmIqYxSpZHG1hGkkVGIs87WEOiaYmlHEdW/SPAwy5WBiHCWtJenmUA9aPDG
	UTQSODoeZsRiyIoOMwaCx3Ef51dofegaFAo5m6YyTDHxoYMH7kYSkz5sS1quay5+
	1rI1KCYz73tlVQRhdLlGLq/ioWVhbaJ10TxeQ9+GRv+fPH1Yq4ifszv+41R9kozF
	GyBbTC5pdvMK6Set5ixC6Y3jmbGKTRcYyRQXOpzybCm3xIcRsowhqsIcJHjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781276756; x=1781363156; bh=LgOmjCPwfwHUEktoiPPlj1tPVPIQQqm1mHC
	ODRgXWG0=; b=Qu3eadlkfJrrI9e9PBG6pTlDcsQ1Priz4je1JaUcmYWQL08mBZV
	MyP1gg48W1GSyUuWwIa582eMeQo/1OXmcCC3Tt+Ua0hZj7NC9dNO7uKieZn/B1Yt
	XyxrtXisLEvEGbSD4nuqup483JXvzS+X5B2Nx37Kic8kjzp7boSQINEAZEeA2LJM
	vvwRL1QxWa11PNBrPmQSlEZOjH2Af84talNptOMJMbPA0ERIikGCzApiiq2KvQcI
	TTdbz20gUk6wK4RlySrn7MkXPruNZWPSRtvf6XQ+SxkZnYYA4JVOdYIwkRheWeyQ
	al3T+ZGilaBmPbUexJqLK5n62cZOw68H0Tg==
X-ME-Sender: <xms:VCAsaioeJt4PlGCm9EkSM2pWyW8zZsyK4RAikNH--Ib4z0svgGfk4g>
    <xme:VCAsakXVfQfG5mMGMckdLPtnu2_Vz06_jlMRg5GO9bVZa4_j9ivMtPjqqjcpxBzJH
    g9fuf-5Sd2DmA3wZxW-Up22b0yXm9ouJwaNEhE6f18zuFAc0jWZ1Q>
X-ME-Received: <xmr:VCAsahAnj_im0wPG_XOjvxHf622Q-1oCmPcIWKPGiBN11Q7Ff0M5VpqrS70KeBDwkWkCBmXVCgeB7QyzP_Eu1OEt2tK_xAvZzttT>
X-ME-Proxy-Cause: dmFkZTFx198mpAGfHRAU/0PzaJCSOEVT2KVT0qO6InRG2a78OV53mhSFjGsxqT9F47jufT
    YlQEGdapQ67GcQTNYRUsHqavqfdPVgJ6dovGJTYSIa/dEcdDV6qszJ9O8na4OGyvQ1HFZN
    nBbi84Te9sOZHRXcWCWJCol7n1azgPlyI5y90gxQWL4Cu3Jau4bU4BiWigr2CvOtg0w9P0
    hSdQFrjZXfSetPqr/LAy08MBMcaT4/i2ex65de5dyvR6wCsEMSMhDd6pnuyzJ5XkvWVipc
    Q56Rl3rlewNQuYzSB51CsMykQAZo6+XP2cuf1bsvo4nnEh0smNxQSO4JGmvElIzBOuaUb7
    Aubs+YsBb1z2HtunOL3D/DiAW7h7Lp8FeO945wy1jnq9rLNiv7ALd0Q0U5XuOeACmrHQSZ
    fcLZSNbPSQtxaL6jDGDl7SWsaPSfNyLKplGHWdPuUxWxmQwXYoizxzFzHi1d3fcVRjX+r4
    OAnxtx2Snt+/OwATNj3UuSlnd9Wl91EJdWW/tUGLwsIk2hqal6M9wrxLNbJyRgiKDgDlsL
    K4GGyH3VnMjTXwQY/xUxPI3iZ++jl1vDdTZIGIgdZMBScMu70qG6tg6kQtItZ2QxLeM2tg
    J5MrZ3O3sedn4D+BVhLGibLtyp0MYx/BFPWGLD95skbgy65QNc9zSY6Ai1oA
X-ME-Proxy: <xmx:VCAsao1xuTiIsFilVjhywsU1Prt5trd5Kl7dtlpfHQBYZseCyEhEsA>
    <xmx:VCAsaj3Wax32O7F8heyrppb2IgjmXUklgo_t1eI_cXczzq-j2Ptr9g>
    <xmx:VCAsatAk0V7bjBXecOgBFCpHEEbzL0iHJsmGp3qwYuXKYhlw8gbnJA>
    <xmx:VCAsai4D6KNFL9ZorKsXdZEH-1YWinLhzwcOb14FNdGAtoYoVJPeZQ>
    <xmx:VCAsakNjm6roJe9vO4daAGNBIJnuIr5EDBMZW1GXG3nl2z-BGHWl_pCx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 11:05:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Tuomas Ahola <taahol@utu.fi>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v3 0/3] doc: config: fix AsciiDoc glitches
In-Reply-To: <20260612045329.GA593075@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 12 Jun 2026 00:53:29 -0400")
References: <20260610185148.23920-1-taahol@utu.fi>
	<20260611161946.12166-1-taahol@utu.fi>
	<20260612045329.GA593075@coredump.intra.peff.net>
Date: Fri, 12 Jun 2026 08:05:54 -0700
Message-ID: <xmqq4ij7iyst.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Jun 11, 2026 at 07:19:43PM +0300, Tuomas Ahola wrote:
>
>> Tuomas Ahola (3):
>>   doc: config: terminate runaway lists
>>   doc: config/sideband: fix description list delimiter
>>   doc: git-config: escape erroneous highlight markup
>
> Thanks, this v3 looks good to me.

Yup this one nicely sidesteps the yucky \# thing, which is very
good.

Thanks.
