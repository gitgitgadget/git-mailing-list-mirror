Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459D31ED93
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186943; cv=none; b=s3snCExpjBlXDStpwtIP2/5izdLMTEeqNLhMLS7PUDNZxW17A8Cw/lH89dlPHiCit81rio6Yt4vwV6hVJUSHuH3cEhiHP32Gt+N5+9DMhk1uZkXKm6GJGCjwofKvbdYxmy2ML9BP+40Eo+x9fC8fm+1hCk5olwJwN45qPa9fkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186943; c=relaxed/simple;
	bh=zedui7LfpjeVjQ9jCGCAdO2zC6BePjJLfh+YfmghZhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iXBB8YlYj+wEvLGVSfHVQew5Wgt3XvS68nPns/tLs/sGxawIwDC5ELGouqVAagJymlNDr0NNVtKH7oAHSK+UQN58uQ3hDXx4BjI5zj2AmoYuSdQBbil+3zgC7jb00DQ/zFxNkuZCpaNtsZfDHwyqM96ooOAF8JpAKq+AdD3b7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yMhmv0s/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jxS7R23T; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yMhmv0s/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxS7R23T"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A446A7A0289;
	Tue, 14 Apr 2026 13:15:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 13:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776186941; x=1776273341; bh=my2yQtAynH
	2Kgp6X3iiJX1h8oAdcKTWdSrhAGFFqjiU=; b=yMhmv0s/ssZGJwQzkZvFSn1ck1
	EeWF6krS9pJfLBvsMZQFIFkpN6k30Edpl280fycdI1H9gt4sXcY2uCh0JJsOYGuS
	LrUpeJTG9iJpxXvEPKE3+DTl5DHc/m0lkonbj5Up9q/40Jzv8kouOwTZhCeAz1m+
	CHyCeYDQiCWtZ0W85f+ZKBmzzb9ksHHNYJIKATrmVbxFxyONHZ3VwsMjgcKVsUsa
	Y/tnG+SdLmVNB1RuZKDiD26r7C5c0z0GOOetpD08MHHlOXPfo+TtmhPq6mYbz+nd
	BfiA5+ahISVqRpjdgH4kZQ0bcxzfKtEQ9Ub/6X3nvRe0/n75IzrogeMVU6OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776186941; x=1776273341; bh=my2yQtAynH2Kgp6X3iiJX1h8oAdcKTWdSrh
	AGFFqjiU=; b=jxS7R23TuuAbYjV0zcKJhf6Iz+PKO5E36uRwtAS57dExk8xAWwN
	t9zdxsyLueKrTQCZWuoKnNWfe2qOAVJj45uOpDNmhVuRaVWoCZ/CL51rUDKKJkDz
	awbuOO2w8Vg3aExDkwo7WVwl2qokbCvTl4ixoCgAtF6YLGx02s7qhUYqSQ2khcN/
	kin4G+Mu5vleCH52SEMrOHYlKRrRqZfY5t098CTWgc45K6ms72UlkvLwYy0wmq2V
	E8p668arhgmSI/QxV+XwQ5KHAKiGOip2rLlyD/BQoXBWQbO4AY71wcTdjW3gik5E
	MHqN1hA1GS6n/BJTIzh2qI3Zj+YTDJCSF2w==
X-ME-Sender: <xms:PXbeaQ_3VKUwkUc2kqpeT_mMXMh0668MeLC9Fs4wOlY5JOI4xP0QNA>
    <xme:PXbeabSLrLGypFLu6PbIVi-c96eAYcb4pwmkAUnjSJzHEGii_FCLFwaS3zf55mVKq
    uXQixBkxSk7aAgwEn7qhjVP1LyTYugPY4p3Lt8TxK9sNKEvwsxj>
X-ME-Received: <xmr:PXbeaZoICRUbiUQcTA2SIIWoMhUOQrKjpToNnoVjIU5oSO5K78Rm8iz9NeVvDdAq6ZBBKVs37XW1wbgpNI6qP4N0pzR9jybE9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopegsvghlkhhiugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtgho
    uhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmih
    dvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgr
    rghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PXbeaQm7F5r32VXnevOQ_KUzU0sU7ThQwsu37LH6SEvNkMLP5nSNBQ>
    <xmx:PXbeaafo8KkZnkYNUiUup1HE-kbTGr7uk8hfGxmaD5csQDLL7I-qxQ>
    <xmx:PXbeaUrPLirGA8gS0tnClpYGhIVBsDxvJb9YdgCi3AN7qns9ow_N5g>
    <xmx:PXbeacO6aREY5JwMYVA-3CeSkl0MpJsb_T0C02ZPqBTqcd-KHEkXCw>
    <xmx:PXbeafNUQBdTZegExetcfD3FsEdmU1U-MZL-EuOi1rVGqvZtHLbq_yvF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 13:15:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>,  git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  kaartic.sivaraam@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 1/8] environment: move "trust_ctime" into `struct
 repo_config_values`
In-Reply-To: <53f43b85-b274-4352-938b-d40f942bfb2d@gmail.com> (Phillip Wood's
	message of "Tue, 14 Apr 2026 10:35:50 +0100")
References: <20260324123750.157143-1-belkid98@gmail.com>
	<20260324123750.157143-2-belkid98@gmail.com>
	<CAOLa=ZTD+qqgyB4Pn4bcOfP+Ks8Zch+AWZkzhrRRbk-eJvS-mg@mail.gmail.com>
	<53f43b85-b274-4352-938b-d40f942bfb2d@gmail.com>
Date: Tue, 14 Apr 2026 10:15:40 -0700
Message-ID: <xmqqa4v5bgzn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 14/04/2026 09:52, Karthik Nayak wrote:
> ...
>> Nit: I was hoping you'd also shed light on why this can go into
>> `repo_config_values()`. Does it need to be eagerly parsed? If so, why?
>
> If trust_ctime was lazily parsed where it is used we'd end up dying in 
> match_stat_data() which would be quite unexpected, make it very hard to 
> reason about the code, and hamper the libification efforts. I'd much 
> rather we put the onus on patch authors to justify any conversion from 
> eager parsing to lazy parsing rather than forcing them to justify 
> continuing to parse settings eagerly.
>
> Thanks
>
> Phillip

I too often get confused while looking at these "global static
variables holding parsed configuration values are bad, let's move it
elsewhere" patches between the on-demand and upfront parsing.

I agree that what has traditionally been parsed upfront are mostly
fundamental things (e.g., in core.* namespace) that is better parsed
upfront, and what has been parsed on-demand are often very operation
specific thing whose misspelt values do not matter when we are not
running that specific operation, so it is better parsed on-demand.
There may be exceptions and some variables that the current code
parses upfront might be better parsed on-demand and vice versa, but
the default for these rewrite effort ought to be to keep the
existing semantics unless there is a good justification for changing
it.

Thanks for injecting a dose of sanity so clearly.


