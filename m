Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868222820D3
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658908; cv=none; b=hheg66zQVO5EDfskZ6DttgsCzwZUPkjmCQ6xqw031k07AOWVvNSJVXVexPrFPirXOPCZuLZ/N4GGEktkaKuSAFtRN8OVDOnkZUOcZpXqisDUiydD3FegBF28T/6egjdxUCCgypMQK6aAbLGFocqXNxQTO8g2pW1m/aeAhVBmbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658908; c=relaxed/simple;
	bh=CVWWge5gWmUU1JW8E8VZUDf47Pqzz+YG01zHGo5mjCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KU6FHTHL8GqxiJErcaVSrhxW5MHDyotC6inIaPOS1LdMPHSEm/reGuqrj0cJnk146som7R6wOxqZQxbllQcMMy3hKT2HnKT9OqLU0+nUhXd/gZtXw+g1ou4eZwnDeBYPBdubjUTw1hlwyfE7GXIaE56NKeXgW/dyt97RL4La9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GL7ZRBUr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SVgxAnIP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GL7ZRBUr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVgxAnIP"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B9DC1380131;
	Mon, 14 Apr 2025 15:28:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 14 Apr 2025 15:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744658905;
	 x=1744745305; bh=CVWWge5gWmUU1JW8E8VZUDf47Pqzz+YG01zHGo5mjCY=; b=
	GL7ZRBUroPbvLGN9fhJVvMVP3sFMPhd2ZfNdoPCKLLaAoKfFVwLcppibsa19pR0p
	5ZhPqyERxnLKdLSo4MUAlYb6vwll5r01lYQelqjkkTOD8+35vxfkFGdrnB6eDH1Z
	N/EpOxSVkZgeqFItSrkwXIc/zwNo1JL2tlkFZTkd4lmZ+TOzIIy+bQqxQsxFD2x+
	b1aTreCEZGSR6WZjro7Lr92EqhBsCrd2G+z8qfD0ivOTX/k+PLD7YwcpggLj25h3
	sdDx5+IToEoi7n/lxBNBYjg1nRts+dJfekLsqRvduwE0zP4SZhBsZAqLsNI4BL0s
	4lX6ait3rkGaObRnz6qS9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744658905; x=
	1744745305; bh=CVWWge5gWmUU1JW8E8VZUDf47Pqzz+YG01zHGo5mjCY=; b=S
	VgxAnIP5wWttW5UNGxE8UIFimFzXGOCTWHwFLwNLfPevIoeL3LUrNwPVnoj9REBm
	eZq2aIiOxVmeMzpnlxNOV/UWjm0l0LfBg9y2FliLkjCX26b2BzwUqL+Xi55KUUgF
	J5kLvukSbehXmou7YHnjArpBeWN0Gva6GPVzYPbRmw3yrHptWlfZafs43mu+8p05
	3NunSAcLFuUIl9qmb6VsFLZ6MUa4jSWt0a265nzBpPWq7jKfg9Zp9qOqB5e6w+b4
	LQ6jZcSV4shrogmol7kNXGh3DQ0ZwcfSelO0+9AtqajCKDyyw1xmWLzU2cBgbjqF
	/7pTbaC2o6GYvqFIVseLw==
X-ME-Sender: <xms:2WH9ZzEl4sbhU21WMtP4eAT7AMmXAwRuHcTFrCi4dyGV88hnopo3JA>
    <xme:2WH9ZwX41eoIcG9euA1HtOe0zE-gxKj_pV6mDbqthNWbZsenVuOvPgmyx9diHz9L5
    Tdnaf0q12BAHoflnQ>
X-ME-Received: <xmr:2WH9Z1Jw6yt5gwkWCKPNtPBi3wtea1hnwL5KvqAx1fi_8J62qilPOPQ-3yALFKnpuuZNAlAyMyPuAH3_h8jObfJrSlCxesDr2y70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtsghovghgih
    esfigvsgdruggvpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghnohhtshhomhgrrhhksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2WH9ZxHroyYE5Pr2luf7sC1A4ZuCE0tx-HVnR2ThcOb4Xwmn3ZLr3Q>
    <xmx:2WH9Z5Ug7Gas_sp8qb7Vo39TqzvnW14vR3qc6NejUTkO2zLrPkCygA>
    <xmx:2WH9Z8NZErg4_KagmFARR_bdwytcSdcw1ETBjIdsXsSJXXejq1ji0w>
    <xmx:2WH9Z4371ihwBLj1TpD1j_oPr1O3Sr3Bx7CPAxEkNI31nWmiluc3zQ>
    <xmx:2WH9ZwtKM3NdV7eWrz1rBm9MYtJP8z5y0fQg-8m8pzpeTYWBRX_v6JHa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 15:28:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  messester
 <cnotsomark@gmail.com>,  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Potential bug: Git instantly converts utf-8-bom to utf-8
In-Reply-To: <20250414180338.GA2398@tb-raspi4> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
	message of "Mon, 14 Apr 2025 20:03:38 +0200")
References: <DM6PR12MB386578E1F28B532600ADF575F7B32@DM6PR12MB3865.namprd12.prod.outlook.com>
	<A743D2B5-0397-4AF3-899B-FC3D3AD2B5CB@gmail.com>
	<20250414180338.GA2398@tb-raspi4>
Date: Mon, 14 Apr 2025 12:28:23 -0700
Message-ID: <xmqq1ptur19k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> I think that this is already done :-)
> However, the repo must be normalized:
>
> git add --renormalize .
>
> will do that.

Thanks ;-).

