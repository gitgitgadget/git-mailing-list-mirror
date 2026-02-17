Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5289E3EBF10
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352961; cv=none; b=UnTdtqRyR9H4x1XEpkP1Eps94D09gt6Lcl5ga+bQS0W4uS8aE0rJ5dpGLBp1I8T2AoxLidnk73wnxpIPfEVXbAlNXmkAGMbCkdIvplr2tAvJBq65gtTbvg51+OwFrbZLiFZDcBwKKx1c3NBrs2X442XVIkMd4sABxFG4OIRHGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352961; c=relaxed/simple;
	bh=7cnUB8ODE66naoVvuSbqw44Z1+DR0nM4GP8kgxQKSCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CF86axTE1HVUcQpVgfxe6PTIuD/FR02YZBwlexMaL7gYkOdUeUtm9Xs+/9uaYQadr6QC3l/POlVL5ug/ZMvJi93h6DMoL+Qdw1BEnUa5V4VDcQQoe4+BPy/aROfJEVyY4xgBVwLwhv2IED/PygXkXvkF9qF8mMmqgxp+YtFYiwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cx023tbf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+QzMMYW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cx023tbf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+QzMMYW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C8207A00E9;
	Tue, 17 Feb 2026 13:29:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 17 Feb 2026 13:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771352958; x=1771439358; bh=iXDIlSJ6v2
	3LS6Hp/ZRWayV3fYrxplI0W6B1+SeAaVU=; b=cx023tbfZd9+xEG6fHxQnkZaUC
	I73/7CiEckZdtus3JIX1vUWulFPuRgOfB3CTwe4sZoDe0p6LkpzyAvI4uAJXrnvE
	C4yyqDXG8BPY6OuFHF1q/IoR42e+1QU9Wttqc0mQYI8GOlk48duG0CqxbXeKraCU
	OsXW1UGvw+YYD1f/yypS1Aq2lNL/ekXyQte+WV6XuY9Tk4nOxraoaxX1xmGRSs9t
	WnWwkWqLN3kbJJb90PFgxYzZ4xmB1wpcP5QYQMfCnlX17jKc+17c05e/kXRuQbHi
	eyT3JztZJ03NuKKrPh0SjpB2Nj/HE1Su/pcZoBYde1L7VkoGmZ/dZRbE75QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771352958; x=1771439358; bh=iXDIlSJ6v23LS6Hp/ZRWayV3fYrxplI0W6B
	1+SeAaVU=; b=m+QzMMYWPkg8OYRtYKxloaJEAr4tRu9xL+WCEVTa55BDTGLEJJs
	X4Mfo3g7EQB1WZeJsAdL60VEgirSG3pzJ4lON3FgU8zPyW/Hnr4b1v3H9yzNhQME
	NhOQJCRBJ1CG2lkPeF+ioOkdRZG3vCj1lxGej0sQc1czRTWP/1Y43Dsg8Mt9vx0V
	zqB8dwz/Y1uUX3qNhalysqZZmoHKvhzgYwkDD5jbAHrWwNobfEE6uFFrw+8VFtvi
	xoo4bPkjZqPkVftrspfd4iGT3i9WQsHjJzHU3V1VcfsJjeLBAIf90nf1DPcTKSvi
	FQFcMiQ93dmzcFvzfc2kby4O6V+YwbLEAew==
X-ME-Sender: <xms:frOUaWEdCrns2ppJQr0TMu7YKuU95irkoYxyhjee0rx6Z02Zf08n3A>
    <xme:frOUaYAWz6HhvLKUW8XBp7RrrUN6KFbXDDosXLsCLhd6RmKzt0uE3rWqTnDqMtixs
    O90GbyftB48iaSMbPo0tGBlXFTizxtwGL-XAhoZZWhs6NklJfC-DQ>
X-ME-Received: <xmr:frOUaeVoGPlhl_LfqJYoQ5lf5GGPXa717eTDe3PniEodGMG32yQ2xYxfXtd1luxEna7fmO9CS0G1gObQaA7i-gRbr7oJUfZtSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:frOUaUrHC5mz06-VYiAEi6KQhYZuIZ-vURenKK221BLAIzwhv1LMzQ>
    <xmx:frOUaSSyIhc0zBroXC7TtUHR8FERKmhnCf5OpQi9gNpISxyGpduihw>
    <xmx:frOUaW0sawWGafyPgN7rx9_9UgAm2TQlhbEwvsYMbYSwYlH_Lwn8AA>
    <xmx:frOUaWCWlKaq5kjrWoMzz7Py5f5OK916IUJ_68NN4273Y7OcuX2ErQ>
    <xmx:frOUaUhTEmocTTh5qgNIiTsgbSQCh3Vw9YOoaXxymRYwr1DiKkmbZxmA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 13:29:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,
  Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/2] wt-status: avoid passing NULL worktree
In-Reply-To: <89c78ce2-1783-416d-9ae5-ef51f6bde58d@gmail.com> (Phillip Wood's
	message of "Tue, 17 Feb 2026 09:23:04 +0000")
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
	<cover.1771258688.git.phillip.wood@dunelm.org.uk>
	<409871a7d521b76c9eb811d3c49747e04de8defc.1771258688.git.phillip.wood@dunelm.org.uk>
	<89c78ce2-1783-416d-9ae5-ef51f6bde58d@gmail.com>
Date: Tue, 17 Feb 2026 10:29:17 -0800
Message-ID: <xmqqikbvcjgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Oops s/commondir/gitdir/ - I'll wait to see if there are any other 
> comments before re-rolling (perhaps with a test that runs git status on 
> a rebase in a linked worktree)

Such a test that exposes behaviour difference would be very much
appreciated.

Thanks.
