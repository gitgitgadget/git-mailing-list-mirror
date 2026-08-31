Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D5D39CD18
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173050; cv=none; b=fzVdMAx2TOF6ochX1PqLUDIQrrM9uDXcxSwf8X4MPHnKGga04hAHncBxedXCnAmSPHE5S4Jmie6sBinyVp2kB1GjWGFARhpdcY1bqoOUhDD1cwaFzCbuY6d1SOfXpiDmdw/NnU3LtG22F9BMBzinwlJ0t0ci2rOcRmBbn3LJBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173050; c=relaxed/simple;
	bh=kZhEW6JW4TKznTxgfAa5X9tf1ttmKIknCabiGL7htnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0LiYBvQPp31N9Sc1enQvRl+YhXHwev5P7v9XY9edY/BWjmNz9xz0ePJdSEdWor0MT5Dayus4xoGWpNatq8lGI33HEdLJW2Uit6hCuTr6gxErfrUjq3TrY/u6HsymDkkzZPmbXU0mZnjSkf0DWeOfzaFDedvC54o59H00wxLyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iCw4QoV3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/wvnhG4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iCw4QoV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/wvnhG4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6A557A015C;
	Mon, 31 Aug 2026 06:44:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 06:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788173047; x=1788259447; bh=xvT+yIpgMv
	NsEtl5AvCAFm1R4sigKGEsi7krCDqGPAk=; b=iCw4QoV3F1RzJMVPSAxWa37c7I
	u0LS1oDs1jSUx2BwHotK/zCNbb60tNiBQVN66NSg9BMrfTIiwoSsXIs8WkU8K56E
	lwr0HiZ6gt/UHPEigPyJIHflf2DFsNVUhQ1DRA2sg172l3yhNd0UfxdN9sYFA4Kj
	u6vSFCD6d3vtMlC+kz4aYoHC3JTTqgyMq8ttupMES58qlx9ibwWd1mmCOoxim708
	n2S0etb3yRuq3oSPRaF0O8+d1qeEx40mJejlrG8yk//3FLWIp6FubjLcUyaJ6XoK
	gFThIreLsqh1BX1fx7QLOfLXB+Rr8cqw/c+Fap2hW1+PL6V8SoXSCwWOM6gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788173047; x=1788259447; bh=xvT+yIpgMvNsEtl5AvCAFm1R4sigKGEsi7k
	rCDqGPAk=; b=J/wvnhG4ME33jNhjnKooa9Pru+/Bk35DfHzXCrc+jBP2iMZrq+z
	JVCMIPZGO/S4SGSRMKop5XX/7oHCSA9FnXhQgccfSz7aSPiblz7vB1nmAWJKfxE5
	BGTOPsMXtM7Rh3sZ4/d1krkdxh9y4QqqdoT3cd4bgy40X9XO7cvSXrpR8A+lhhyn
	ywykSNPb7ImwNnp8MZ8VPSTOYmPc3V7UT3YXyKmzcUDNKIB+yJ6qs/IpUyNBM60v
	t+cMQqvDKZ+7Aa0tZLYIV4BDMphxD1LTsEpgvhrnfPYmzG9OcCVXh1MfNSv8XrrI
	hd7tdZoC+4AztJYyk3o1GzpMqWn5bRxyRzw==
X-ME-Sender: <xms:91qVaigWcwyFvaJknA0cmKMBpYBxN7yGNiFLFoRHRhJgay2dYGqYnA>
    <xme:91qVamugOcclYDLHbf0werLZ3GDu085bEjrrzGdru6Yo1ZoPjq9-qsHZujMiGXjGB
    xtiWW0Tsetae9Y8hUMHt3w_jq1TEEYX2KETB4xCQwruTenty0Wm>
X-ME-Received: <xmr:91qVaj7KEI-NAKmr_XhSXwknZD6yS4F5Wv2V5QcqXyYBRHCemtZay6gWWMT1SxYJRmccGg>
X-ME-Proxy-Cause: dmFkZTEFwVoJgbvh2qmNt7FrJ4HDLqWK1/WbMxIb1VZ5W6MRk62wXb3irUt04dTMX7291X
    JVm2GjaXNE7nNo8DNKHal+OpgGMokqP5P8ajp8jBMd3kO24BDkgDKyUy1g4Bv/tsZ01Vc0
    HmyvJ2ZgalAxsoeMqFya9G17XJ8OnhXsHdT+FUMc3uWP3ZOU0fahwFhVNeE8UFqfteXg9X
    3H6B9FY4CfC/hBhlZilVI5nG5XuKal0LHnxwoJysuog7vI8TwUIlWByxB8WLQz7amCrFLj
    wVBpY2IXLuNJGTMD+BvOxK4nJ5NUEM2eG/DSZ9rjFtBrUV++lUqdKjJl8wuMNDasmZHnqp
    TszTZhOTh4jpdwBxCw7RMU5yfWDUDPPPcaE6ukkbAV9HIQgC5SknszA9DWWgDWEkyywkAR
    tBKJA13Q23FtgUBAmTWKJgvvuB8Wtb/7VobIO5DvfmX7m/zKAVq6ws6pWZWkgIZ1JbMkxb
    dvT6VnbgNBAL6cUr8LWbhUSu5UfnO46oJMgSRlNTWlId4KFasRQh02R7Y7jhR0bh8f5IKt
    f53CzvbuuWsniRu6u74P8Tzcvaz5miSDPnOLBn8XFDWhRFiVV6MDpQMcCTFUoDCh7aJ5qk
    yIvGx0ftPZhIwLaqQ0LbMghoWbK8qZlmle1vuL2TQ1enIsfrCNy4TAgR3sMA
X-ME-Proxy: <xmx:91qVaiNA7xiYuePjjM8hUaz5Df8FVSeMWVvDGxKHa_n8snHM66R04w>
    <xmx:91qVahuQN3JOn4sO2NP6eMyFDBlncGpVeEEM7W0nGuHLRC_dVFolfQ>
    <xmx:91qVala8NF_MRrA5woWxl224wNaopX60Yv-tvDdMwnt8U-_FGD09Hg>
    <xmx:91qVajzr-SuLiGQF5BdmahD-MYaZ6h7eAKcYn1zC84h9_qlbbI0pDg>
    <xmx:91qVaqS0kopNE1Z40yUj833yb218TvW0eLzBqwnvkb-pIfsb0YhK1_Zq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 06:44:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63d4f012 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 10:44:10 +0000 (UTC)
Date: Mon, 31 Aug 2026 12:43:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 4/4] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <apVa72AU-cD4IO46@pks.im>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
 <9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
 <20260829120721.GF40814@coredump.intra.peff.net>
 <xmqqjyp71g9s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyp71g9s.fsf@gitster.g>

On Sun, Aug 30, 2026 at 01:53:51PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > ...
> > Sorry, I know that was a lot of text to end up at "you have already
> > written it the best way", but it took me a while to reason through it.
> >
> > The patch looks good to me. ;)
> 
> Thanks for a very informative and well reasoned write-up in support
> of the series.
> 
> Shall we mark it for 'next' then?

Here's my a lot less well reasoned +1, for what it's worth. Thanks!

Patrick
