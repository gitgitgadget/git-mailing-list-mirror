Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876927587C
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773644; cv=none; b=iW5Qygb5gTcLw0ICZiUD0ByBmSs2DEjsEZ+AiSlYpsCs0H7j9Ml4xCY53TD2vNhZ9cHaEbeWmyeQToJBGW8yQaPsMwzhLeQOEvkHrmc/xVWFVE7gbukYwQ8P7S8zXDZDr2nqp4ntZgjZKb7fom3+DGwqCR7dHNM55Rpj6prNyik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773644; c=relaxed/simple;
	bh=FQ7tSfz+m6kdkspIdAWUOyptknE7bLbuPoIRClbl0AA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8AgGjxSGVxTZNydE89r2lysGYU85I+Xr11iDikZzcxRv2/UXOu8SzA8UvqPjrWfs00hFNPCLhI443/QFCGp6NMwbNQBtIIqwmvBUGemS+ngICAaLn4QG20bqdJ1z0SoejP+PPISzEuB1vM+OGdyT1/a48TKWENKY2DF4hS+ZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Op2WLZ5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oT87YNDX; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Op2WLZ5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oT87YNDX"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id EE758EC01A5;
	Mon,  6 Oct 2025 14:00:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 06 Oct 2025 14:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759773641;
	 x=1759860041; bh=8h+lijCMSVvWEDkRkiD6DcfFVjLHkgUbD4UMHGZ77Jk=; b=
	Op2WLZ5HZwt3+dsYtNblk55Nbc56hP3bYvskZo1OtC6A0qHbWh/h3Ro5UFzc1yFw
	Q040V+4UPLq7gF/rm8AV/+clILPFaa9fxCmVpbWqOpJkRXyshtuSJYWCxHfi2DrT
	yc+lI8iwvlo3EaSKaudbuh8QmkLCb1o3SqIVAH3Z2t2InRN8oKSuQcgrncDM332/
	NKolmIi4YaigelvxE4pv+OxvbnkBsEhUNkydvBAQLsTbBIuhcj4SbKeS67Dm0W+t
	Km68oWYQtZh/01mXc8q91DqUM2DrfwkHOE8/ZOedKf50vH8Bt2fYz9LRKvBiCNxP
	yWGEY23rLrcknrcDHzuQzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759773641; x=
	1759860041; bh=8h+lijCMSVvWEDkRkiD6DcfFVjLHkgUbD4UMHGZ77Jk=; b=o
	T87YNDXYwvDKA27uMp5HWggtoiYW4Q5ogUxWh8c5mOeC3Cei3ffabFx66F1+qd4G
	8LsVRvxUpYjB03fD/D3ldRPHbQ9BCrrnnTke7h8iRV7nD+2AmgOEHYsGeSg4O0Ci
	3zxyLhoVGQOFeMfC9Q+hdOZhlS/c31Br5JylmWg5e6MPMy+ZuRD4O8qMxVUHo150
	BUK0rqGIvFeiL4JPoHGrt32cX1c5QPQVW07/pG8reV8wGttpcCfNdwak5BdXQLj1
	+o3ZTlkbL5do0ZiAQ9YUD+0x50t4rN6lBcsbUhfli99RMU7yiYL4ao6HlRWQx4eM
	q+iKIK5D79gQP3WszlOPg==
X-ME-Sender: <xms:yQPkaG572ze8Bby1gt1YHO32JOgOFTvWxIrR2WMudGCjWOr-S3mr3Q>
    <xme:yQPkaBaMYazQoowTmOzlyR0bZbV-pZxWKuQ5t0COT7xC4ki5i9WY5dOln7JZfnlnE
    oWOJzTDqq-ZvGeyVeZucHDrjnaFIp0CVRHwSWrMZLZkrlYmNVuIhlI>
X-ME-Received: <xmr:yQPkaFgmwnZeYQSSf_F9rr5OqB7rJgSOmkYPIaOlH0MyOjFRo3ozZ8GeltmNbLyvj0LoOzb6Nl7YANK5ekqsqxvtZkV4sUIb1NxX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehurdifihhnughlsehu
    khhrrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yQPkaC-9OawWCx1fCS9RhGFrKnmntQmxSc2Cq7Uaya4P2UgMVDx1EA>
    <xmx:yQPkaAoPG7ReVRXOjDSvrNFmsTADDXlgCExElmJKj1u78EERsy_yyA>
    <xmx:yQPkaKWksX8ehCfS-2mTpceJMAk2oB7Xqa-oYKatN7_64aYklnDsZw>
    <xmx:yQPkaPCybh_SQl8quMAt40YCV98r2-AKHKxDpJNUkNO9Emi9ZumPEg>
    <xmx:yQPkaHw_u9CN50HtKQuknJA7aTnltuNcwBqkmu3Nd3QOQhm1aqKn8Efu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 14:00:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  "Windl, Ulrich"
 <u.windl@ukr.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/6] add-patch: roll over to next undecided hunk
In-Reply-To: <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 6 Oct 2025 19:18:10 +0200")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Date: Mon, 06 Oct 2025 11:00:40 -0700
Message-ID: <xmqq4isbq59z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Changes since v1:
> - added patch 5 for a and d
> - made error messages direction-neutral
> - removed stray "only" from commit message of patch 2
>
>   add-patch: improve help for options j, J, k, and K
>   add-patch: document that option J rolls over
>   add-patch: let options y, n, j, and e roll over to next undecided
>   add-patch: let options k and K roll over like j and J
>   add-patch: let options a and d roll over like y and n
>   add-patch: reset "permitted" at loop start

Will queue.  Should we mark it for 'next'?

Thanks.  
