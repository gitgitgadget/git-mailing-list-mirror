Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18B23ABA8
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202824; cv=none; b=QfWFCXM0QsIX9TUmFbTzBfYyHtQYsgaXMvRkn1i36rpQaUfHn+hSgUvPXEr8SRp8Q4nIy/clQtLJTO10EWMir4a+5k2UiwIRYzuMP+A5TVlTj2auzrR3WL9R4U1CTllLkEf1jYG0iQyCof2PyW+I+qCkkNStQfx3edD1QuvPsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202824; c=relaxed/simple;
	bh=l6x8lWwqCpb5ReT72r5c4NkMFb0v6S73OD3OvQUkMbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tjFJPYzyjgJq9ImL01pQ11xRQDRWULeny6lGnfB+8kdGSoplNg65w0m1fjeX3OuWWab8qVzIrBsrvEZOFHsCsArSiCkj018cvAIBYkaESHAtlteUYGYJsmRSnWYNboh+CRmKe4ALpa1ssSn9SGP/SRG4HbhDX+X8ksKsshXp6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j4PHZZyN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLBjvGTS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j4PHZZyN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLBjvGTS"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 013271D00140;
	Wed, 11 Mar 2026 00:20:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 11 Mar 2026 00:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773202821; x=1773289221; bh=JgAmYDktvo
	LowV7PrjUiYU26KRkaM4BeF+YedzvX0Zs=; b=j4PHZZyN7oSrmjdIUwpCYvAyX6
	BbT/b81z8dgJXjrmO33TzeFIVoUMSaqLb2nBpBC9XyEBgAGbvcBk+WMDWVg/lugT
	4b76C+qMx6Yh+XP255mg8O7Kr1eacYCmBqaAyH3HpwwBRd/zPQ9sx2PSE+5pGoRU
	nsJQP8DsT19ZV8kU3+nz5f70dYWRtYXXGjyw8XjHNuo7c40wFsSXnDJF9QIzBjzo
	miqbBELivrhESkfep+yRpMWtiC67XjYh39feQxM/qYfQRn3+I3PJ22wU007V06R5
	RzfvK/V9BvlqDUY5z3lK9SC0nz/lUy5ZdseolWCtSBae+GruHKzq57wK4EdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773202821; x=1773289221; bh=JgAmYDktvoLowV7PrjUiYU26KRkaM4BeF+Y
	edzvX0Zs=; b=gLBjvGTSrl5fKYwiuJuANBL5TMDrkDytM6IRemMyYcIu8e4eHMs
	u0F4M1QoKLHAYNMjDxUC+2kZhyYBNRUBfV7BAlnIYPaD1YaV52tA7XCu6Wr66V7u
	Py6/mVmAJi0K7rCb7dpRYWtjbAMuv0H4WAr46QVEG2GBrUcVdNrmj6tvCt8VPISC
	wE2ozrpDQvbmcYkx3K3LkC5vM8KGOJTeqsvX0p0QVITEtW7N3A5CGcRRrAnBUL+1
	pgQG2SfftaDKrgUBvVcTwmam83twYUwtV2hEhLbOaNCP2okOWKNzcTat3o6FV/Ta
	4JNDU0cn9/cSOzTNDuFz/7fLy79uPAP0NSQ==
X-ME-Sender: <xms:he2wadgaSB3DMKHXLxFnZ8pFxnXDMfg0HayWOVdckEAe0QFg3M6wlg>
    <xme:he2wacmL27wkDPlPJR9xE-XOdbODNoLuMlyuU3pZtPiUsY8FEBd2SyZ1qjJ6Hkh3j
    zWowaDOKAFLLiX3kCAdQgQV5Kxt6KYcBCdnuPBw1WgAHejIDw4E5A>
X-ME-Received: <xmr:he2waZoofa1E3JRv4iMoQZpl3iafhOddlVBfis8CE6d5h20EWiUUyjZm-_IyPD9AgEJV50Slsv69NgbALgxxALYeKWK2Zev02w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfeelsegsrghrrhhoihhtrdhshhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:he2waVHb_feLSvUiUYb6qeX-CpLAlckEqk4CWsl3jESByj9DGXZPmw>
    <xmx:he2waVx1Y2Wz8N6UZRy7ENBvBICbKwYJkx7MgETEhiF4BROVbYXELQ>
    <xmx:he2waaqzhAfG57pqsq2vVqe0lAoAaqiedwHsbWTQmDg4MyX0se6sZg>
    <xmx:he2wafgh0JRVs3mPRDR-wj1vfa-EiQFxK2L4AyO_8iXAwKZro5LNtw>
    <xmx:he2wac5o8au-uk33vsNHWYXD2Da18CNyX_7LUhBQYboA5ih50-Y9aB9K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 00:20:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 1/8] parseopt: extract subcommand handling from
 parse_options_step()
In-Reply-To: <SY0P300MB0801AE08F2AE4C0EAA274A68CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Wed, 11 Mar 2026 10:49:40 +0900")
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB080114A7548292AB4B60D817CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<CAOLa=ZQ3eCky2rH_D-6=vwQ26TKW_dSO84+Z-WL2LFJ2rGVmqQ@mail.gmail.com>
	<SY0P300MB0801AE08F2AE4C0EAA274A68CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Tue, 10 Mar 2026 21:20:19 -0700
Message-ID: <xmqq4imnro8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> On Tue, Mar 10, 2026 at 05:46:12AM -0700, Karthik Nayak wrote:
>> > +			if (ctx->has_subcommands) {
>> > +				return handle_subcommand(ctx, arg, options,
>> > +							 usagestr);
>> >  			}
>> > +
>> 
>> Nit: we try to avoid braces around single statement blocks.
>
> I'm not sure if we should drop the braces in this case.

You should.

You can tell that it is a single statement immediately after seeing
the beginning of the line, which says "return".  It does not matter
how many lines the function call that follows "return" spans.

