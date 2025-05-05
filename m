Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59226F452
	for <git@vger.kernel.org>; Mon,  5 May 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478031; cv=none; b=qEl2xOghop5L52/4b2w7xPco0HyIY3ea0TF0+YOHv7eHaDqPwF6vg6IhyUNU1wQxASj2J3Amy4A0Dfo2sT07Ry7oS936mBJgxa0Osq34+vUGJo50BBFQzdD33Uois/P4iQtxrGp46Jf3KqHFCTsgb2uu/pcc9UZh7hpi9k56M+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478031; c=relaxed/simple;
	bh=XadlfUWw4GyDJrwuDzEfFG3ahDH9ojFYH+mpZh2Bds8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DQ0xQwlx2F2WKRYKVzs1xuJ8G+8y5ONbW1e++2OUKQrZxgzC+zrXgAMj9KFn0hgyKrthLX2qLSwbP5OIEum+pTQ7+BbFPzzPxKPpf+h1Gok4qNQxXy0OzH1nDSqWRBcnGC0nF0XU1Iwx9nsCDcT9GWgHoRnmQhtTvKjfnBBupFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p2b1FST8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMXux/Er; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p2b1FST8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMXux/Er"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 320932540284;
	Mon,  5 May 2025 16:47:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 05 May 2025 16:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746478028;
	 x=1746564428; bh=mRJIYkG1nGDK5mWRZnFe873kemPCOR2NkCy4HUQA+NQ=; b=
	p2b1FST8tN3NPJDkoTsDa+wQsUHakMCecXGO7K0YMcjqEjNnpaVHPQqYse7vgAV0
	LKTo/fZnMOI2nOwrpndpYSJx/TXEjelH5cI+SE1jQqz2DL7Fx3hYgBaY4n34pkU5
	ySBPvHqAw3TK23qrhlnHVB0qC4GzJvYqH5L4TBIknNCtY037mXUU/LRXAYBTp/jc
	CYa+PxvgSkVVOGsbOdZpkPk1IcXo+mN9BhOQmZAfiDqkW6wmNPpeUXq0COHIU7bM
	bIOKRWfEV2KeciYB+5zYkAotbWWXEuuS9gsZzDjaxSVckZaA9nKt0W9jKAHx10/f
	0AuGfnUMMiqQXXXNk/1djQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746478028; x=
	1746564428; bh=mRJIYkG1nGDK5mWRZnFe873kemPCOR2NkCy4HUQA+NQ=; b=O
	MXux/ErXhECFXe3ZQYxv1zAtQ6cAYyyw0J72mMNKjv8n5CpPhQfxksTbg/oD/TSk
	bgWJ9aRS2HDjIt6xalx7XVtlMAk/0X4u781Hs5lYHF8WFsewBdjWm6B/33XHOr0S
	zapDV0pvt3pxoWE0PHqY1/YnKmJm+CgzPulaC0jRWJPXiW8uhFPq/04xjL9+8Tlp
	FP5mNL1mUYbbEQ2FGRVnqRSq0Hxr7dKGD53u2+gBymWoYru6jT5ZwYAdQMtlJUn5
	z3iayQizSiKof2P0ShJcTLPxmX5jLD82Km14zfKr/EdaAvcVmYe7NQIRAMccy+wU
	mVKHnD3AnVzuvYUpUZCuA==
X-ME-Sender: <xms:yyMZaHvuk67cYJZhQWTUerB5E6YasyODt7VJ_lYYF7I3WxE2zij2AQ>
    <xme:yyMZaIcomQhZew0BsUbqMX8vdqkba3F7MxoKCmPL-Zd1n8fkDBMOcm-yoM_rExRjv
    bjOSRx-KY5XRS8TxQ>
X-ME-Received: <xmr:yyMZaKzjc6mTr1W2YHIbWGIa_kWYM6Gy2ythhNgFYXhVYxmDtACU9tYJMSFks-ZgeYWaHwI9QeBQt-JkQcvKTxA4UY5Jqqazokmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    eptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:yyMZaGPkV5RiXxAYo70Y-yeadmKpLfREPJykG2i_TJBdtRnztT_lGA>
    <xmx:yyMZaH_0JMJxW2C6N0Cthadr3viFW5Uuc0mxwUWt9veLbLXX8WWViQ>
    <xmx:yyMZaGXQYOVjZJIyiPDWWEcoin-bpB0twz-64bJESyliPK3QnZZLZw>
    <xmx:yyMZaIcKLcsmkTAxVhnJlkDrTd9bYKwPbR388SjT1s-9fXkIYxThxg>
    <xmx:zCMZaNzWfVg9uYwZJJALtDX_yTHb2IX-6tbjDg5XS6phQLSNJ0TE852m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 16:47:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org
Subject: Re: Problems with 82e79c63642c, NOT_CONSTANT with sigfillset()
In-Reply-To: <7efc9c9c-8187-4e10-bf9d-1cbb6aeac124@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sun, 4 May 2025 21:04:57
 +0200")
References: <7efc9c9c-8187-4e10-bf9d-1cbb6aeac124@web.de>
Date: Mon, 05 May 2025 13:47:06 -0700
Message-ID: <xmqqjz6uokdx.fsf@gitster.g>
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

> There is a problem with the somewhat new
> commit 82e79c63642c introducing NOT_CONSTANT with sigfillset():
>
> Compiling on older (?) MacOs machine leads to this:
>     Undefined symbols for architecture x86_64:
>       "_false_but_the_compiler_does_not_know_it_", referenced from:
>           _start_command in libgit.a(run-command.o)
>
> What is the best thing to avoid this ?
>
> The introduced "false_but_the_compiler_does_not_know_it" triggers here
> because there is a proper prototype in signal.h and then a
> #define sigfillset() ...
> further down in the file, which can never fail.
>
> a) Define a sigfillset_or_die_if_needed macro,
>   which does what we have today, and is simply defined
>   as sigfillset() without any error checking for MacOs(some version)
> b) Revert the commit (and fix the conflicts)
> c) Anything better ?
>
> I have a raw patch for b), not fully cooked, as the commit message
> is the hardest part. Before sending that out:
> Are the thoughts about a better solution ?

How about figuring out why it does not work on your system?  

Namely, compiling compiler-tricks/not-constant.c should yield
compiler-tricks/not-constant.o and that should be "ar"ed into
libgit.a, just like config.o, connect.o, etc., so I cannot see how
your ld fails to find false_but_the_compiler_does_not_know_it when
it has no problem with say git_config or other global symbols.


