Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391884ACC8F
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176511; cv=none; b=VeZCP+aM1rUnGZFZoofOYX0zr0DoPQtYmSxinjJz9jar4j19Kd4hjClwCnlsyj9oxPTggRCRcRBneTKXodE2BVtfqFIXtHnaPnF5vApKnbm5wOnGWhtHKSLKgv733lwKU42MLbkky5nlEIXxNDomAqNV9gFklauuHQ2+uZn5lWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176511; c=relaxed/simple;
	bh=u05srLstHwPoqIGmLCXAwHXHzzqDUon9K+7WzrB1/Q4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YLT8dLJtQIqLf/uiwlg555mbxiY1FWGr4Hra7SS2qX8fPSukJFoqL6U5uz7pyNhI4+Rcc57SPdsTEdjJkjhqaoZuboWvD+sZ2orvPcvTvDnEbZNREyQnumhqcfWpEqtTr2QnKP1VDxIDQBmQ5O3HdElul3rL//xBX+L3vSSYxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Su0hyxUA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnTq/mu2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Su0hyxUA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GnTq/mu2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EFB1B1D000C6;
	Wed, 23 Sep 2026 11:15:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 23 Sep 2026 11:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790176505; x=1790262905; bh=9L10vEiljK
	W6H5cfeOR5mDNFK4azgoglx6Zoc5xEYO0=; b=Su0hyxUARXsBEd8J/zrnjIyiz4
	eo0st6/BjlDbo41Tn02p3B4rx0cW/G5O3oR5gT2YuHZOJUpz+wRp1I/0fIUQZOfF
	qW0wZEhQxx9VAs3YPAVoLGLzpjOfU/8DEI/EqIfDNgeClwXUTNekWoa5YL2vapaI
	uuJVsfi4xHm/xRxrJp7guF5iSzdmf2KqbCtiCGRsxeAyIesXIK8J8xLUY/uHSXmq
	SvnSF4d96h1lUoWPzSvi89D3h96ExXoxw1RimmjIc34x8sALGWCUaYsLTPjL3ycL
	tdxabeD0EI1Tmjp2BfVMxdiV16p69upzHTi2NQS+V4Ffx37YrRAlbYorKn9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790176505; x=1790262905; bh=9L10vEiljKW6H5cfeOR5mDNFK4azgoglx6Z
	oc5xEYO0=; b=GnTq/mu2rHfDVHksvAs6S9YS/sBguWwutGv539WwFV8prwSzslj
	LqrYZx8jaexxbfU3iCF6metKkMmAz6zjqQ+RBfDT/c0MLRWLN0gTvqeDD+tLtuGx
	BUNAy0MFU3Ji/RqxvJDczqXxHpaUP8jPAZou1PZjU8K2GrMb4nc84jygOK8W/Vw4
	BKYuLbA0Gpi0VKr8F3+t0TCTBOcGYM4CRyG/9WR53K8+TgcGekJFA40cqMBNc/gU
	IKdrNXDg26+md3a0vu8c+Fjuc9oxmm5noLNbGnXWag9RrzEOA8b1MdjETlC/3YGA
	0Wqek9bTUxayFNW4UVNs3X7Si1isSny+1XQ==
X-ME-Sender: <xms:-eyzahvj1WpT6BDZNJPUwZj3xDx2V9g7uAV0rPyFdzEjRcxJLHBdGQ>
    <xme:-eyzahe1LtEy7rD6p-4PXW6-eAQfYs_0smEpl-fM068YRjEd-6cpKJyB-WKj3jV74
    WIvgjRj8EyTO8EHmeKHjV-9ejknCXN540GfdhKVSFZsRjieEbmUwA>
X-ME-Received: <xmr:-eyzapzSs1j2gRa7WvDRnRM5to6A0MjCCAKKS5AK1NdYCB_UfDSby-tXWG1GwcjJ2LNtq6tFgqZb7tKeNR-8ulWeyzQ6BuwLspcT>
X-ME-Proxy-Cause: dmFkZTGCWDEBEfw1uAuCc12YTY4lIjjlCgDh2y8ND/5TfO2rtgy8TQokTRNkB0y0O6oxBq
    DOY3A/xjRcEqb8amd8r7VruFgF7LRuhCqYs8hJAd4k/PRIXDumUm68STQ62nWQW5Y1pI3U
    Jtg/eg5IsG8zwr35HvhuB4CjbcIZsBFaYIbgt6x+odIZqu1GrlU2W39p4FtIkrSxu6G/Ql
    A2y412stQDDooW7d/zmU7K60frM4Jd7V3Qm1w6eD3kuEaXStD5mkp1Qiak0Dq4nxp6nM6k
    tdBD50fNX1oJ0j8Xbo9OnDr1Sg9D5stiN+zF7l7hIXNIOwXyQf2WTo6ag9qMBvUl01h4e0
    RT7EVF3CEnYDMb8b4iYFTUxuzindLiJP1mRd+9fbJZIc0VaURvoAND7ibQeF314GCUekqe
    i51wif7bc0PvgxqyxpBQKfLPCrlZUvtxq4vTbQdX6wASRz8B8fYPk1fglpR+Rd2hxlgLsC
    FGWhOyWHaGlAgPfZp5xacXrUPxPwSHucCwKZDHkwuEdz+yzTEbud/YB6k9YzZEXnZp16oy
    EZUUKZrO53UIwIMiFBM3+taUosQcAKhISXhC6vCvVIirYx/D0GVmusQttHupUo91uaR61f
    8IRAtxZQ1pLvDe6EEhuOXY5KIStquNAWTXf8W8B7s17eT6+k+gCTXcYGr3QQ
X-ME-Proxy: <xmx:-eyzanHiuJy8oVXUuLoL5Sf3efi8gfpUb9XpJhxU6fh1IZm_MgGdOA>
    <xmx:-eyzatwll0HqJYQsZwrhVggQ8_KGjPDgT1wcy2WE98llgLoNASoZdg>
    <xmx:-eyzaosUxbaKCtxe_QE6rDVDtLyNXCorf4BT_sLOpz2PJuqj8esrtA>
    <xmx:-eyzaq20beRGMP-nq26nlxB6_Cw7N9FRwp9LILCqJ42uaPQVX81JWA>
    <xmx:-eyzakE8VYU0xUZPCtd9QiQAk7ZgKd5_4Jsa2KFxSRWkGMfie6Gq5g1j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 11:15:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: Git Contributor' summit: Documentation,
In-Reply-To: <871pak1151.fsf@emacs.iotcl.com> (Toon Claes's message of "Wed,
	23 Sep 2026 16:40:58 +0200")
References: <xmqqwlsei1pv.fsf@gitster.g>
	<76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
	<xmqq4ifhgzvx.fsf@gitster.g>
	<5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
	<871pak1151.fsf@emacs.iotcl.com>
Date: Wed, 23 Sep 2026 08:15:02 -0700
Message-ID: <xmqqbj9oc83t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> I've expressed myself multiple times as well how excited I am to have
> Julia working on this, but it cannot be expressed enough.

;-)

>> list, ever. I just hope that old-timers who really do not need the
>> documentation nor understand the need of those who do need it show
>> enough appreciation for the fresh views and for Julia's understanding
>> of the target audience.)
>
> I think the old-timers do, but it takes skills to have a very deep
> understanding and still being able to explain things to newbies.

Not just these two skills, but you need to know what are the points
new people find hard to get when they are starting, and that is the
weakest spot for our old-timers.

>> There was support for replacing outdated material and for merging useful
>> improvements, then iterating, rather than trying to perfect everything
>> before it lands. Bringing user feedback to the list without flooding it
>> remains a challenge.
>
> Iteration will be key here, and I would say some steps have been taken
> already. Very tiny steps though.

IIRC, the view in the room was in favor of keeping and incrementally
improving the manual pages and reference material while rewriting
tutorials and material on concepts from scratch.  I very much agree
with the "rewrite from scratch" part, because the concepts have
evolved and the world view have been updated even if the concepts at
the very core of the system may have not changed.
