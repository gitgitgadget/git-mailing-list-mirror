Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B7EECB
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261990; cv=none; b=cP4AskaArkHzF/XxlsOomxQEoGiYXrHTlXt6t36LyHjVtngdwHOusQ3b8fOb8J0kTVl/PxlAmFvYyY9fCSHxIMfVS+B+hjuNdcZA9HSiyoWsym4tZ2/thYzlxFwwrf7sYbVanu6zRn3DkR7CakCTEDZULOd3FyqbD1aU1RIFo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261990; c=relaxed/simple;
	bh=QGOltjyLHKyXdp6z8YxabQ5SKRNIfdK7qPoNmcOL5l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaTEfVe3cXe1BWeivm0wchXEjgTEUvLc/jlLcoR94HYq/spdTALFFxFeogh07esxJi9y1RsNk1gjkDvRlquM2OAcnAdUqsvenLWNfO2T74RlmpjTN4MUm9WSl2lse8fBKBLwP1rJrrZTel5w8AEJuwywi+sTYgJNj7zB3EDOeqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bDEUv/se; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GwXZVwj+; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bDEUv/se";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GwXZVwj+"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 77B42EC0218;
	Tue,  1 Sep 2026 07:26:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 01 Sep 2026 07:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788261988; x=1788348388; bh=bVlnCUxNUN
	2O1vYbwNMear5qAluR+z7sL3YlbOmFm78=; b=bDEUv/seeu2SXA06nFDjG0tApf
	hYHoaJeqAWkm+g6Ijw0LeZ8f0S4G/U4ijLdrV4Cjs4PiBbDzviQpRz+BvjE8cpyC
	M5ZKwmks1RliM0nxgTt9kYtS17iL7/UTHZmW9uxIXXK3affH2Wm5D46VLMaF3bJ2
	iMSPPeDgAgBFaKhjvrsz/2VbmhcjJoANH+wFCCJfiCDO5YVdpz+MIj9IkA39H114
	1fISwgmbc4g1P5TzxUJ+savfGR34Wj+Dh2Wu1Coz/+EoxF30MKCsNdKcXhyr0mTo
	QPfHuZyIzgRZEnj2xm5VG1kvWwECEqhb8NU//BIrijJ4qxnZfF1TQaFLI6CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788261988; x=1788348388; bh=bVlnCUxNUN2O1vYbwNMear5qAluR+z7sL3Y
	lbOmFm78=; b=GwXZVwj+Bry/7i3kGWAlDVJW7qxn+kxpKonzDS3+vu4p1cHr1kz
	Qetggq6tEa2gHTZ0tkY3i6acPnC0vO086lxEGjZHTaYYbZKecyJ+6rUcqZvRevY8
	1B0ICgSFSBVAI4/iGWUu77wm3PEQwFdoDWYAWKHRwS5nKqaNVasXpxtAi9WOQGld
	6XWVIvBw92b37jPV3wy4brF4ACqLKYzb0WrInX0aPihc74ak/DDrOux94pIJmgt9
	Ga6i8awbncv81SxX881G1FFslcxI5hm/nRqrWLXh8x/3IHU6ortADmDI9RMV1BWm
	OxfH64IaY4Vju0/sJnk6upN0htTREhdTfoQ==
X-ME-Sender: <xms:ZLaWam3VSm733fLq0rBYJc5DwYZGxxJOh289jC8fug7kLqp8it1Orw>
    <xme:ZLaWavFsrFAhMTJaVMsiH9RNRjgph40g_CMCqiuRapaH0YJIR9YbQve2uF0L0BabD
    R5Gyp_ZuNXx5i2yxwkmw46DKxm6iFWdAIi1QiWynxMceSBHzbDLhOw>
X-ME-Received: <xmr:ZLaWasjev-MmZJgn95KS4XunHoFtCgg3xRst6s8OG00JSjtMj91Z0Q>
X-ME-Proxy-Cause: dmFkZTEGUnJaAg3vh7xbCDuPYTzGd7oL8wzpj0eKZltnkAdInNNRYDrYpdOBJLIqXrpYKT
    lnQK35X8vXacOjgGxmqq8JeUm5LIsy9yhi90knQP5hmqZncFikuaswaVgJAYQdncZKqWVN
    3jAf0X1ixWAS5CS5AmfItb4LCQ0RjrtxtyBstaaNZhvrhQo5PEHTBc9JAik52ZY2M/ufT0
    tVUaFyfkT8xXFfJAB6YJWyME/6hHFtxXj8lXSVjYHMcEPh3BKfXzaJ84wsul7ycqgAa1iO
    eAL2JDvN2I0dm33gM35cDtVuyMt9s8x+Q2qAuWFIahNaauJ5l7k3eLgg9yU2Twbb/yaJrr
    njXPSbwqK6Mq7dus3Rb34cGN8hE+8AUDAawjwlXnMtHU3p+jf4Z9DcmyRbq9xh83laMLp2
    kT2RqEaI0ReAxz/0/ZdyRr0MniuYAC1onfPjSOxSrqq9yC7nkWB7qlQI7FxQEP/3a0CYR0
    Phbh7EILlSWo21aBjUzi93yYGcu7FL4/NnhOIMk1nFcuLVlMab3D+0YZxC7aFu7vTY4/Pi
    IJjxDJ293umtoD7a6dnWrxveWOt7Yz3fKfxWQvW3bj9TcuKpEiVm3srcbC5NZFx2EpIX8b
    vXCecaJlrGznfSpEVqPeQNkg1hRnJN3h4vph4dFyVHMbCgqbqJFlNWzWU1EQ
X-ME-Proxy: <xmx:ZLaWai_UE1MNF0EwMBJVEFbePXOzfWT_gzvjmULzUquJf7YhR2oUhQ>
    <xmx:ZLaWaroPLncqYJTkxybc4KX85r4bWsZXYmFni4aC7QGsQg8-bmb6Lg>
    <xmx:ZLaWap-5zYm2JX2woUkwQ3KQUtzncX6O-GrQUUBjIkxyO6fl5ThG_w>
    <xmx:ZLaWanWVhV1BO2ZSgRlaKsjOuP6G9j8WstMxCRCBLl4xiip-CbVcsg>
    <xmx:ZLaWaiMeoKrzAoGmjoSpcVYsRkwIFP6s_pJphQf7XwyPA0KgVQwwe0Aw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 07:26:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc004502 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Sep 2026 11:26:35 +0000 (UTC)
Date: Tue, 1 Sep 2026 13:26:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2026, #13)
Message-ID: <apa2XPxAFyUXveJY@pks.im>
References: <xmqq33vuw0ht.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33vuw0ht.fsf@gitster.g>

On Mon, Aug 31, 2026 at 12:31:10PM -0700, Junio C Hamano wrote:
> * ps/fetch-packfile-uris-parallel (2026-08-21) 2 commits
>  - fetch-pack: allow parallelizing packfile URI fetches
>  - fetch-pack: prepare for threaded fetching of packfile URIs
> 
>  The `git fetch` and `git clone` commands have been optimized to
>  download packfile URIs in parallel when the new
>  `fetch.packfileURIThreads` configuration is set, significantly
>  speeding up fetches from servers that advertise multiple packfiles.
> 
>  Expecting a reroll.
>  cf. <apUUiv4SD0-W8QS3@pks.im>
>  source: <20260821-pks-parallelize-fetching-packfile-uris-v1-0-0df52d9427ce@pks.im>

Please evict this topic for now -- it's creating lots of conflicts with
a series that Justin is about to send that converts git-fetch-pack(1) to
use object transactions. I'll then resend my series once Justin's series
got merged.

Thanks!

Patrick
