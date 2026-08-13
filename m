Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A4404BFF
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786631245; cv=none; b=eW53JurufM0wH4RWL4FuQHSdoyFWvdUl4Bp+T9lChsJZ37o9ilqs+szUWeuT3Ix5AqKpxXQNP5OX10T/OdZ13hshbL7aHot26Sa05JGtGiPcrctokUcYlPAgSab+MAx8TQxcuwEOTfm29vpS62TJ6o0waF8LGA0+z0zS+6S+Y8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786631245; c=relaxed/simple;
	bh=My1suMmkXnfUI06EDtSh36EyUcb9z4HDB4OuKyk2VJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rMkaTFtep9uOd5gtLPpqC9enLXMtc1vQUQXdfMXassY4xm45xPHbbC5u3pZfNW8euOrWQOgL2pxF3KhiKUCUpL2CYYCiXOTT0g4uH+rUZVQCpTwGuGvgEYF8gHwCRUYP7yzSJzQIaB1a1j6hUDAFxJmcQs9D81TmvDKv2+MfzVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ezVF6948; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kuK0MY2W; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ezVF6948";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kuK0MY2W"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CF880EC0280;
	Thu, 13 Aug 2026 10:27:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 13 Aug 2026 10:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786631243; x=1786717643; bh=JpIl0T5hcd
	aSch6NmOCFsiE6fCErHnzgvpx8V5mkGNI=; b=ezVF69483zHRYUEIYlvm7QVxi/
	lxpaz5+EElN+3dWjgTEC/UZFQRc5qfP9dEMtVxw5TtLNUg4MvZAi/+ynsim2RdfO
	hKs5mX+vyBGSqhhvnFFUf/kwsvTKqDf84oByRByjkPpVZxo3wNCTnQXmIDl5hzPU
	fvPY3qk2QTMeZV3P8cirhdNSmZpp3/JXLEZzMtjd0xMDeUVrFiLv6BqdAJi2y1jN
	Vu8kGux8eSZkBPsTSsTehonkJ8xF+ywfgOfen6xNbsUankaZF4TymjxEPTtR+2sb
	j+zUiwL33Wka0YS74LtmYc3Tk0NVsu2aoGmtkvJ+vLCU1z+z4Pw9Fpmd1/fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786631243; x=1786717643; bh=JpIl0T5hcdaSch6NmOCFsiE6fCErHnzgvpx
	8V5mkGNI=; b=kuK0MY2WOLCeSQyFPn90yxDNJ7udqQngDPzH1y6a0H3fzIfl03I
	1stEEGZ4hoM63nk1shiAmBm7uzmFI6IcJNY47NlDNVRRbV8A7oEzQnHQS+QCFG3f
	u9HlukXRICTbhghcEEVgJLmbIFA6mGp9WeUDu0uP3+68iRpObR5SLaTt38oiTIvR
	dF6cupterKw+cMgUxREMUz5sOsWykuiaEztidSrrA/SB4jU92umGBsH/W2yjujfL
	h+lU24RwWLgwWs1QtOAs3LtkX/TXzEz1hwmiaWdsfdaJVWwPvSFYTkFIDSSPc3Nw
	OwYXeRohk0dRh5VpSFjInXMGg/AKpeRPTmQ==
X-ME-Sender: <xms:S9R9ar9JJlAggYeR8mTwcMm49YRrme3XhMXGFKq1H0piduj4oP6GTQ>
    <xme:S9R9asq1LzJwPIEhXglk8LiLgUZ0l10xkwf6YzStu_-PfZuyvwG6BLYgnHjwJ6Zbd
    _aXFC2C5U_bUoSs_LGpN-lp4UjBDfNX3mHiYyJsb0QA92K-tyKpsw>
X-ME-Received: <xmr:S9R9atQSXH9rTIn0Nc4mQDaNaipqvZF5kEnPYxfkCYtTYfgrX2lqtXb2Uf8Xt5YHuuyW2j4OC-c8BxU1c83nuZd_LL35WfVOjg>
X-ME-Proxy-Cause: dmFkZTGPkRJnZ0qhJH/zZIV24up61BVAhYG9wf/GPGSwEVKJakW9tMn77qyqyWfxy9y37+
    HFirJumZpSDp1pGRb143Q5edBrQ46qk1jCiaa7UVyDWuQ1LY3Rei6j14wE7JTqMvMy7mAC
    mpMowCvLsoPiLF0+jfnE3bsOSKyELdsEti/kJLE3U1h7JHjuxONvhsZtRlf7fEMQLpIVF0
    lKDQ4M7tMKSN8lkV0Xx3iiWLVY51POwB3+l4JlQKUonehV6ZrRDw/zUjJE+ZFscc2GBnqj
    cF4Ohv6TfhUNVDHC7ZH/Rjz0+KMZHXllm5Sl5Dkfnwl+92RNLkW8nsanNFb5eXcP455Tq7
    Fx+TnuMFQDSqfbgfVY1bCTWP0pD1B7NZZzWyJiU8ZB0EmYGwThgjSW/CBgE8XVzrZig+hy
    4901GPWMXdsqyI7IyAL1QoSROcR9aDmsuWVULMBWGLRFdJzXgtsdfBJjwvpWIWg31PmYWg
    Q3T/LUs5+57y3xeUWBix+gURpkejpcTY4xKhHwHwLTxprQ7GM/flNbTnwEzBewX1/Pcyc7
    n9aC4l2qdHeirsB/+VAWJMqKhe+B1QZwlBrRIGfl3KgB5V1S3RiRS9LtC/PmY8Jx0AJNGQ
    23rH8zymJ/4bK7Zm4e4oLwOh8SpWvjD0Pnvtnh1wQFpNMrbV4fuDhG0fpNDQ
X-ME-Proxy: <xmx:S9R9anMyMDhtZFriDRPyiUBQzZ23BmbDLb3iylSE5u95JPkqmEW1sA>
    <xmx:S9R9ajjJ4z5zrzbyAKiyTXhrkvTHfkDBdN_R2aMJw_k8A8ASL0-80w>
    <xmx:S9R9asnjMPV9acDujh56kT_bhBwR9o3G0LE9os5S-3NeMpL5Dgc8SA>
    <xmx:S9R9anjLaREZabgoEELqBWlwwNlRtgaYU9yBzeEke5YqJVYpRF6VRQ>
    <xmx:S9R9auIIQJ64HKZJJxhFzrpZSSsgLxoGL_t_ml5sVBHoOL65xA-G6lD9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 10:27:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Elijah Newren <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <693a61b6-e762-d864-d25b-348485ec039e@gmx.de> (Johannes
	Schindelin's message of "Thu, 13 Aug 2026 11:34:18 +0200 (CEST)")
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
	<20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
	<alR9GDNTbdjWB4dq@szeder.dev>
	<2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de>
	<xmqqjyqpb96n.fsf@gitster.g> <ansSg4qsPwh5FcR9@pks.im>
	<xmqqpkzo39d2.fsf@gitster.g> <antWRHPHHES4a1KT@pks.im>
	<693a61b6-e762-d864-d25b-348485ec039e@gmx.de>
Date: Thu, 13 Aug 2026 07:27:21 -0700
Message-ID: <xmqqqzk2t7sm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course, it would be even nicer if `lib/` was split up further, but
> then:
>
> 1) You've got to start _somewhere_. As we saw with so many things on this
>    list, they never materialized because reviewers asked for too much and
>    weren't happy to get incremental improvements first.

That is why moving everything to 'lib/' and thinking about the rest
later will not work.  Instead, moving a specific component to a
specific subdirectory (not 'lib/') would be a reasonably
self-contained first step.  Consider 'builtin/' as an example:  it
is focused, and anyone can easily tell what the criterion is.  If
it is the top-level cmd_foo() implementation, it goes there;
otherwise, it does not.  Then, you can proceed to the second step,
and then the third.  Iterate enough times, and the top level will
become thin enough that you can either make your final step a
no-op and leave the remaining files there, or create one last
group to house the hodgepodge of leftover bits and move them there.

> 2) Naming is hard. As we saw with _many_ refactorings (I am thinking about
>    the low-level merge stuff as well as the ODB stuff, for example), it is
>    unlikely to get the origanization right the first time. So I'd think
>    that first moving the bulk of the library code to lib/ is a good start,
>    and worth merging, leaving later contributions to chop off further
>    parts into subdirectories of lib/.

Again, this is because you are trying to do everything at once.
Instead, come up with one clear concept, name it well, move the
related files there, and then iterate.
