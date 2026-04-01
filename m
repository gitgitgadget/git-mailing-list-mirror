Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1D47D921
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062609; cv=none; b=dTbIMQAiZsaDYsX3CkyF3sxBa9zEpplJwJp+LveIHfNC0YTt5Mz9QIKSTSmMHZ39qPMhGIVPQ0AKfTRazrhi72OTxP/AEJqZOXlQ4mg2Shl2Pnfj4vi8m0MXq87dsX8YBK7zyzfhvMuANR1AEj8aBIXYGsnA8kiatTRJ7hZHQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062609; c=relaxed/simple;
	bh=YU5CTEk868wKlxMKn4bFrl6k/BzrJYxpWVVujmKFUKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SbxpmT+ZRodnL1uo7tXRUfuqtVwb/1anv9HMumq2KsDrl4S3oDqvYt4WOcsLFkVvRjk9F6/672uJXlXhdyjVqeTPstIaYbdl/MFpwlQ7uBY9qiXBpuy9Q7D7eANWTVlrA24L/8PjjvQDolZAqDcJd7h7BDuVW2oQk7L97TMYwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mJdJiAia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dwb8pJG4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mJdJiAia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dwb8pJG4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id F12981D00225;
	Wed,  1 Apr 2026 12:56:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 01 Apr 2026 12:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775062605; x=1775149005; bh=CL2xP/j+3t
	rSLhgzemb+i5ppZ1vWtMuhfozKjYpG/gw=; b=mJdJiAiaFEd9m8YHRYkkG+K5n6
	tNdIW/SIbMPAheVRVALDCIgoySLCWv0lv4uF0F4at/Cne0FjT1YHMTwLt0m+Z136
	GFLc9VSjLZjVIDgvJpLMINdHim4aoXcG21sqFF1f0/BzN/UBp+z30D94N81KA36s
	Zyq0SUYFPOWC4TxQEjgf9rY0I5f178FdcexIkDXbN04stfdHBSZHOfP0qQsgW6Dh
	AJbnX1nTyxCs+XgZu1XgQmZxP6pKyt06WaFVSyiZPr+eAADFqRYFTFMryyEHnKmR
	dTea7b7gWqoTd+maQt58Kx+UAX01+WcGtRFthvMm8Myjq7CdNC/Ws68GiMgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775062605; x=1775149005; bh=CL2xP/j+3trSLhgzemb+i5ppZ1vWtMuhfoz
	KjYpG/gw=; b=Dwb8pJG4EWEnStEtnwRtHsyohH7jEW++CKLFMBH/TwyFPnnywS/
	BhyI5UFwcaMB03eGdpg6LKLUwD64gCM6g6J1oP+Mv7fmetovYMdqI/0S3iXGadyb
	lfqUe6Qf6SxDtg4EhU42Y26ATgr/4AcsGBcL0aLCbPzyFg8DvMhC4WZ2ZLSjDwm8
	aU9r5tw7itHBl/o2Yp0e1aP5THrVvwbhGGQM7p3vf2mVUD3neP48WcDiUZ/jDmYt
	bQtnZiLu9E4djElUJtEsWXu+Psyo0GTna0IN3BpW50Zw0UhrVD3Qwzz1TgevaDIl
	3CuqaT95kol4+X8FjWEeavThEeDcZ0m6BPQ==
X-ME-Sender: <xms:TU7NaQqVWqkuM_XgOI1mrokxnxQWS0wMvGLoBbWI4Jiu_OS2KV4c2Q>
    <xme:TU7NaY51fo1xScZb9k99Ma9bpZYb7IA3ugU9Wl1wCYFN-XUFu1I2prgsqdACfyGpA
    gSCdfWwcqDubXrp9Jzp0ys0nqRrj4hdaeo00udb1hj91_M88xSvsg>
X-ME-Received: <xmr:TU7NaXd9oUpXtDvcEwHfypzfS2CI0q7CckyOr3Sr77t2kDuhBleEbOg_f6mx-PNIUcGY4oLLd82aWUwZhMWnQ_cDJeAv_D7wrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TU7Nad7D3kfWOYbsD8TNz21KRNuXaDiKcgEQRo24wfjvMwIm7psiTA>
    <xmx:TU7NaeutLxrUtVpngowh1X4WHE5Qq2anP5zSstNTj-nAz4juN4_lqg>
    <xmx:TU7NadiOf20Zo-uefszypDvWfNkikMh-9HLEIjAS5-hyN-q6JCiEqw>
    <xmx:TU7NaZo9oKw9Gft-mNuodbNqLK_aGubWzPU1h9wAKkn6eKVPpu36Xg>
    <xmx:TU7NadgS03mdYgPvkhbXn6t7Kvn-XfFTfJi_gN925s2E0tXbiIEz54XZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 12:56:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH v3 2/2] push: support pushing to a remote group
In-Reply-To: <CAPSxiM8Nks16nJCB9N8_bi-ZmQFF71UQEzACrF+pFXKXNuVdKQ@mail.gmail.com>
	(Usman Akinyemi's message of "Wed, 1 Apr 2026 05:15:12 +0530")
References: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
	<20260325190906.1153080-1-usmanakinyemi202@gmail.com>
	<20260325190906.1153080-3-usmanakinyemi202@gmail.com>
	<xmqq7bqzu1xh.fsf@gitster.g>
	<CAPSxiM8Nks16nJCB9N8_bi-ZmQFF71UQEzACrF+pFXKXNuVdKQ@mail.gmail.com>
Date: Wed, 01 Apr 2026 09:56:43 -0700
Message-ID: <xmqqcy0iwrec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>>
>> I would personally have designed to mimic exactly like "git push r1;
>> git push r2; ..." would do (not concatenated with "&&" but with
>> ";"), which would mean that there is only one single failure mode
>> that would not affect interactions with any other remotes, but I
>> have no strong arguments to choose that design, other than that it
>> would be easy to explain when we later start supporting pushes to
>> multiple remotes in parallel, where a failure to talk to one remote
>> cannot easily affect interaction with other remotes without getting
>> affected by timing issues.
> If we want to have one failure mode i.e continue pushing when there is
> a failure,
> then, we have to use `run_command` to spawn a child process for each
> of the push.

Because you would want to avoid hitting a "die()" while pushing to
the (N-1)th remote, before you push to the Nth remote?

If there is a "now we have attempted to push to all N remotes, and
know the outcome from these N attempts, summarize them and present
the result" phase in the program, then you'd need to spawn sub push
for N times and then the primary process needs to do the summarizing.

If there isn't any such "post push clean-up" phase, we need N-1 sub
pushes and the last one can be done in the primary process.  If that
is possible, that would be ideal, because it makes N==1 case the same
as the traditional "push to a single remote" case.

