Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E59027466D
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439754; cv=none; b=TtNMxBE9oD3P5j1MtP7+/ef/T4CU2ZESVjml2/KEON8Y223vr0oShZshS1cbfMjrFc5DPspoAumHdxLm+pacbJBFIwtfG9ORrJSoqdYHSiI3jgX+eFn7N8ZKuhdgj8VXiD5o3M2hIpKDXLALUUMLTBPZF39YmoH1+Hh80nFL6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439754; c=relaxed/simple;
	bh=IuwAyT6aaqkLFLQrjnetHvdKC1gyGoet1gr8WmyoTUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGx4G+Kmy+949BaYDCKfXSqxipsBppxuKEAW4xOiT/YgXQWGC/0kGu13srOGiX4GYWxuhXNVg4XqLFdiP0OCxz7o+P118aIVDNz/GA0ilbIAmphtyTwBiMtGEoCelhIRn9ByRNILgDZDn6WBCSjPeAmbGe3lrjYCoOW/ZSXNX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I21xhDPN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dE1ew530; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I21xhDPN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dE1ew530"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CE3B13801B0;
	Wed, 23 Apr 2025 16:22:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 23 Apr 2025 16:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745439750; x=1745526150; bh=JiZM+yAl9F
	udBtqTq3Yoc12d+Mljt+PX2VX9WCHM+tE=; b=I21xhDPNzqaNetD3zDugXvNbvF
	g5BqwItM9P6pyPAJW3RqHXsbtbMA+g28Tlb/9bC/OBXQGJZr8fNBRlhbHcFNuc62
	9gfaguoPqRnAqmI4e90IpFZsfOsSX4pR0TVZqdGrWpiS89VGqktqt/cyLf0AHEHA
	XTCehCfCRChclLs6TH8qdvS58I0Y9V/PoIlAcrNal3cIi3Z/u7OYR8A8wy/0kbU3
	nmhfdcY5PQt62dPejWkk8QygvjnDRW/znnuwL0E7pTuX/9gFuL/NXpxe+KPJvaGw
	ANWUebxnN7/nt44sCi/ZwtUXZdFcdeke20kxBc8O10nSI/7UVCvR4omVtYzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745439750; x=1745526150; bh=JiZM+yAl9FudBtqTq3Yoc12d+Mljt+PX2VX
	9WCHM+tE=; b=dE1ew530qKfkG6aRfuwP3Bb+LoS+tsUWdw1BIF15x0XTtiXQUBp
	bvXhgda20K7h+PhKgpI+3G0o6UrOPo9X53D9de49e1Fby045QcopoCZ3zrSIHIT1
	SL1V1M2/v+7CaMOyjM+1JKGCHX13Y+jkg0WisqyRcWgPhLBtrtSyE5EzIf5oRpiv
	nNl/A4MdMiVCnwrUdA+cUz9yCRb+Hs9SFowpZ4BjIPv9bGtKwoEHSAnXt08PHm+6
	sR2JlMxbixJJr7WIKu5GBJtc3oMiLRRQlS0sWl58B49QIQPU4b18YaOLngJCadEn
	9r5FMj6WPwUcS3RdHmlUI7yrJvRbUb7wVcw==
X-ME-Sender: <xms:BkwJaB6VusGkiv7yV-wfhr87bfWfYRJiAe3urAw8oH4PiVqvFGdBlQ>
    <xme:BkwJaO6NCOLCon6BSUq3i3KMtVBCiaDjJwQam8MnIaRe3fbdof5OgRZUh8QkLOjSz
    48NzEntGtRVWBsc4w>
X-ME-Received: <xmr:BkwJaIea8B9E4ougvx_0oX8PqYnpfPUzIaQUBUrPbQ8PPfCSs3P3shoFDY45fOyJUKTpwne199aETXdkTuOOOmZJVartWHxvMMAm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhn
    sehiohhttghlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BkwJaKKBno_IKm3jrd9mu0uKfGLUeRk3X5O5RlhsQVdSuBnEZ1qqJQ>
    <xmx:BkwJaFKCkMg9_5VfF74MxFujwzgNyqEZiYohW48AiHRJARW4fJYndw>
    <xmx:BkwJaDzFG_sr1-714sWF_T9bm7FGvbSAzuFO76nR0cJE6oXA5VZM_w>
    <xmx:BkwJaBJ09CtXmsElx5q7vkiSiku4eDwnJXsHFcXljMjSvKJ7GfQu8Q>
    <xmx:BkwJaDss7OWBd5YpEAaNDk9-1Dl2WwhOE6NqRbBlRdIbo8cZHVcMODGq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 16:22:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH v5 0/6] meson: add corresponding target for Makefile's
 hdr-check
In-Reply-To: <xmqqv7quwsob.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	23 Apr 2025 13:04:36 -0700")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
	<8a907622-a975-4f9c-86b3-54b8f5447709@gmail.com>
	<xmqqtt6ezshm.fsf@gitster.g> <xmqqv7quwsob.fsf@gitster.g>
Date: Wed, 23 Apr 2025 13:22:28 -0700
Message-ID: <xmqqr01iwruj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> As it takes quite a lot of time to do full integration of the day,
> during which time GitHub CI is idle, I pushed this branch alone as
> if it were the tip of 'seen', and it seems that quite a lot of CI
> jobs are now broken,
>
> https://github.com/git/git/actions/runs/14624509129/
>
> with "Process completed with exit code 8." at the end of
> ci/install-dependencies.sh step.

Yuck.  It's JGit download that is failing.
