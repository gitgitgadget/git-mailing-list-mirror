Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C41F80DC
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068172; cv=none; b=khyOOKbj3AWWCGz1ShxQc61q0ns+PfcFOIJ4ErSxxs9bKdy2EeK+J1Xw1aF3V7DmJJ30DStZu2Q/wUUMESW6WcjagISTBz5mD/YDSi1xSl222Pa19PBgfNgJeK1eVgpJGjoOXGyd6aYEndMM1HIhiNCW8mC9GJV6Y0TfYYcFp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068172; c=relaxed/simple;
	bh=y/dmwPsNTb/CZTx4bweiYZlIyjHU1tw77MGlXjet/Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM21DwGsmmjUZH+X7Ql/Bx5X1cTmiq+QbZa8qbyEZ3SxUauB9YPwi/r6NVtDlhEjnMtl7n/FndJHbKhinFTidtPjGQ8F1tdtRG63pkSm5ZR0p8p1rCXoidCYgIbS3SvIwLy3UIpBL+K+of9Q5+YQsOhVLuTZAqfz7t8/atuyrx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qwllpa3g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E9yxow5o; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qwllpa3g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E9yxow5o"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47E241140088;
	Wed, 16 Oct 2024 04:42:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Oct 2024 04:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729068169;
	 x=1729154569; bh=JEZoq+XHl77UTBMj3ssrVl7n2/sciHfhNP5GD48mt5A=; b=
	Qwllpa3geTVRY62d8A24eAZ2QI01DHZgGSWWN342jf+DToxqNQPvB9bf4VBA+wW2
	UkRBc23Mv8xKLQTjemOJuniQl5OSDYxhD1gPY8kxZgZdDDVRtA6U70GQsubGwpFY
	5GoEUeLXVSWD4lLKqvO1igedam5mny9uts3G2+td0Gf9uWJiOpkxdZhD8sZqJIr6
	fU7yAQCxaNPnEe3m0WUAMN+9PigeBTagfLHJhZ5FC8HS+rzl8mVKhvuPxU8kYbFT
	PQS/5MYLZ7FD1OtGfRIiiDDV8pfWRKnfUV0m8gc7JcyT272TT2wIyUYJiJv1Jmzo
	/q56uiws73QjGSe206l9QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729068169; x=
	1729154569; bh=JEZoq+XHl77UTBMj3ssrVl7n2/sciHfhNP5GD48mt5A=; b=E
	9yxow5o514qebRTfSAg7ZVZJgkmcb2koZHXMMVdP/twikDd/CYaXHLQ1wbnLUj0Z
	Lro0S9dsHCRg464Qgn/P30yx2lgnKv5cED3rOESoRMrB24YdhlagX7bRG5qKvt9D
	4HYemzrb63y3JG87JfucGhelWQznjV0zzKX8qPf3s+XrqNesPnkFmGOrxNTRzot3
	Ri08i0Ls2PcmKy0as6TSYb11KJQHVvjv7SZL2eovrnq7bItk96TMlaAHBvdjWS6B
	e3DCK97S62HLBjA+BzRNk/Ja/vM83ewzWerSbeay35RPqD+/vOJ6EjM7DzG1tkba
	ZYLIOm50tvznvTjLQuS1Q==
X-ME-Sender: <xms:iXwPZxSh67AY1VOC6nFIT2Z_lLinXSeg-oA65Kfcq_JSxqw83RYH0A>
    <xme:iXwPZ6ypcSX1dz8U5Xq6Aie6bbA-VJiayWEpjBCAAaFMld69eVIBTVrn9MxPadLjF
    HqV7OljH9P30gR-SQ>
X-ME-Received: <xmr:iXwPZ20expmsu5zEDpOXA6ywIv_12ymLqDy87EaJ4yTM6Doh9A-OzCfHt1_izt2fmYl_gDoqytVW36UmIwVYfMKJj5GWNlGO1bGLII0DZ336Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:iXwPZ5BOEFCYLj8zsaxdBO8Yn7oBk_nFnp8TsqrKfpNF8QXf_K4bsA>
    <xmx:iXwPZ6iXika__F26ZSdkgZRY-bfbtlp2WcrsEyeYOOvNyuYfGSgu5g>
    <xmx:iXwPZ9oeCo0PXhIaWzGtLY9h0RWLwyoIBGLHcNz-eV8uiMCgCMJ2ww>
    <xmx:iXwPZ1iQnBQKYtlJ0VHI3ho8nAOZR1uOwg69et6KKDsntbe3lZmTGw>
    <xmx:iXwPZ8Z6Czx1aWoFx3M9BFvwhgc0IX8M_-48c2cZlQSR6WGXkZ6gG_zA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:42:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2363c12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:41:30 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:42:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/10] reftable/basics: provide new `reftable_buf`
 interface
Message-ID: <Zw98hKZc1pjBGGcU@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <0ddc8c0c896a006e4cc094390125efcec0b3cdff.1728910727.git.ps@pks.im>
 <Zw2cjxpDf6MowCP+@nand.local>
 <Zw3xhwLFlznU_JvK@pks.im>
 <CAPig+cSXJaETg4Sq3Zw8=37M15CdLEUkdMb2U2X4NPSOAFwmyw@mail.gmail.com>
 <Zw7CIRoXrLr5pd5A@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw7CIRoXrLr5pd5A@nand.local>

On Tue, Oct 15, 2024 at 03:27:29PM -0400, Taylor Blau wrote:
> On Tue, Oct 15, 2024 at 01:10:59AM -0400, Eric Sunshine wrote:
> > On Tue, Oct 15, 2024 at 12:38 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > On Mon, Oct 14, 2024 at 06:34:55PM -0400, Taylor Blau wrote:
> > > > On Mon, Oct 14, 2024 at 03:02:24PM +0200, Patrick Steinhardt wrote:
> > > > > +/*
> > > > > + * Add the given bytes to the buffer. Returns 0 on success,
> > > > > + * REFTABLE_OUT_OF_MEMORY_ERROR on allocation failure.
> > > > > + */
> > > > > +int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
> > > >
> > > > Is there a reason that data is a void-pointer here and not a const char
> > > > *?
> > >
> > > Only that it emulates `strbuf_add()`, which also uses a void pointer.
> >
> > The reason for that is because strbuf is a generic byte-array which
> > may contain embedded NULs, and the `const void *` plus `len`
> > emphasizes this property, whereas `const char *` would imply a
> > C-string with no embedded NULs.
> 
> Thanks, that was the explanation I was missing. Perhaps it is worth
> re-stating in the commit message here to avoid confusing readers like I
> was when I first read Patrick's patch ;-).

Does it make sense to explicitly state how the interfaces look like
though? I don't do that for the other functions either, and for most of
the part I just reuse the exact same function arguments as we had with
the strbuf interface.

Patrick
