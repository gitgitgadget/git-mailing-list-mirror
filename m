Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720D8F4A
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334925; cv=none; b=Oem0ThjIx1m6cAQSAkwH5ZlYr5/KVz6kQtnqaXIIUCDt2y/lbcIgDE911cE68vqNS46KjKi7X6MYyNAgQaRlxPn+fJK6mxzxR082YHQ4IM1G5hsTh0JSbPREnuil2+LIGgKPuHFhl9sgss9vgscaFvfDSbIAbU6RAXXMPGSrLjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334925; c=relaxed/simple;
	bh=lcYaw9L2eQ2dCC74MkgwNNEH0MuWMgyXdEicmFZLQDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eakJgeLwrYG5xRnYyAikPgH3Fa0+t/Z6fqRjyjtJ2r6/RFfwLV6F1km+fQryoGjHOrADyQRKK4rIHtNPuvD/iY9fDwMzl/8UiPnfv40xShmsae4ROGX+1HO4XMky6fwYtOo4Y7XV02Xxt0PtB7Nt8vRLm1/zYyQOnbeRe+Hf+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v2Qorbe4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QHNOsXIM; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v2Qorbe4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QHNOsXIM"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 790DC7A0E3C;
	Thu, 24 Jul 2025 01:28:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 24 Jul 2025 01:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753334921;
	 x=1753421321; bh=H4c5VPGMBA68P5QJZWZhXk6RGhpovJEt0duvFikhx1o=; b=
	v2Qorbe4he1zNqPSM5rY+bbjG/1CjKdhUgtecbG6sVzreKK3WPuS2ow7kgjzxWai
	lNmkBJ6pfJx8ygKJYJXqWxnJXCRod2I3v/p4l9roNVqXIagSpLBauqudcqZRxzE7
	I7ULiwjVjNN6fA914sMJhNi2TnCCDe+SMo5InOwGTOpdNhwfi7ZCcAg5rYvvtDx/
	0PojAyYGsO8z+vmU3r19VrmjiUxMpPdJbaM5TUx9G67dLne/3j/7coUMY13Tj52F
	mCud9LqLVGap0GxYqNeeqd+6DOIry7/Rl7vKNkyVt5tpNuBciTr18+EOf+rL6E2U
	URTSTXLtZ4KniIxYeZd9uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753334921; x=
	1753421321; bh=H4c5VPGMBA68P5QJZWZhXk6RGhpovJEt0duvFikhx1o=; b=Q
	HNOsXIM8RfSm4LoDxkMYhL9ClMd2Yj3svbUti37ad5hQaovb5cPPWAp+qAqnuwqN
	4UovPtqJYknQl2iDvmuYprDY7KBl7OHSAYMm9moB+WAnl+AMONubiVG5iLS9Sdti
	/lZxwu7ETBNIF42nsUcDhrV8DHdDgMNaY/RVlmIaD5hXf/DY+C4UyQxtTiGwaZzD
	xg6X8FKYmV9jbSUbwuK9sAdOVc7nhS5kcqxiVb9YigEWaRu+ZC2CQKEmWHQWoHxW
	66tqqC18thWHNz2FUOavkb2vCzWNrPrbDuYvq/oS5AMgt8ZgSIYh8/kOcimYqpfl
	L4QTF6Rqeqo6KJwfNpzYQ==
X-ME-Sender: <xms:iMSBaPFGCQAfNxb7EZMEX-oInnfqSSiNV--Nm7vQzy9e4c7n73EFCQ>
    <xme:iMSBaEwVnwZ52D52VeLpcXVl-OaHx_4xjWpvJIL2yHJLOHqWEVDIVUSU6zXcKW0Z7
    AKizpfPUlX1TWgqSg>
X-ME-Received: <xmr:iMSBaBnJ2yzSvjvVETaoTpIQe6h3Qievf3M6Gj0141VrrfJ_RLnVNv7ZTpeo8mApdVF4-I5m9VsvFqJDhq5iD5-kSfFRXLPkFfMLFRaXglU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejleekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghr
    thiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iMSBaNnkwgc2GE2a31I7rMxvrxJbcDjdMo6PFRVeWgtciW1OjQiTnQ>
    <xmx:iMSBaDyF0hwEltrIg2mKJmxqmq3cYfCpgeTNV9PLCQ_dVXhPJLcbug>
    <xmx:iMSBaCoZr1KD-u2v0tEB2xYO2Lm74gBHXPEGXx-iLCFqySVOaw3u1A>
    <xmx:iMSBaC53ryKQMMFPtMhNc2tNhhy3gd-ezqMmt3qCxbID_PcvqtX1NA>
    <xmx:icSBaGks76rhDry1bVPze96Gly7lqqycgsC7HE640fr-CWuVB-Gf2RJj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 01:28:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ad1da0c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 05:28:37 +0000 (UTC)
Date: Thu, 24 Jul 2025 07:28:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org, sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH v6] meson: work around broken system PCRE2 dependency in
 macOS
Message-ID: <aIHENdrLu7vtShov@pks.im>
References: <20250716193000.44673-1-carenas@gmail.com>
 <20250718170225.6063-1-carenas@gmail.com>
 <xmqq8qkelfgo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8qkelfgo.fsf@gitster.g>

On Wed, Jul 23, 2025 at 03:17:27PM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > macOS provides a PCRE2 library in base that is not usable and not
> > configured properly, as it installs a pkgconf module that
> > points to a non-existent pcre2.h header in /usr/local/include.
> >
> > Detect that case and if the feature is enabled, try to fallback
> > to a wrapped subproject through an anonymous dependency, aborting
> > with an error if that is not possible.
> >
> > Change the feature to "auto" and print a warning and disable it
> > if a broken dependency was detected, but to keep consistency
> > with the cmake build system used on Windows, add a special rule
> > to re-enable the pcre2 feature by default there.
> >
> > Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> > Suggested-by: Eli Schwartz <eschwartz@gentoo.org>
> > Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> > ---
> >  meson.build       | 28 +++++++++++++++++++++++++++-
> >  meson_options.txt |  2 +-
> >  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> The thread went silent after this iteration.
> 
> I _think_ it incorporates all the good suggestions offered during
> the discussion on the previous iterations, but is everybody happy
> with this version?  If so, let me mark the topic for 'next'.
> 
> Thanks, all.

I think this version is fine. Thanks!

Patrick
