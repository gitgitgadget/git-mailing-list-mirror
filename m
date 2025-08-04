Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3E19755B
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754342353; cv=none; b=M+Hf1m15alT7uKzTS5hThV4c1zsAZl9lSsB6LZsq/GjzGDAkcIEyKDZXfeefLZz1pzh+I1pT+8Sv0MGeDvBACG+xRDP+EVjJxDl5khJtt6190flig/7TeE7akFaUSCePZuCWeCCmnccgqenRm/cv+b3RuMspPna2nOVPsBk8a1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754342353; c=relaxed/simple;
	bh=xMkZgseAe5Zzwfo8GEOoIy7/kiZ3KOXjjD5NIkuYrhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KWukBhDkGwivJwqvtga23imIUguM7jPsK6+IgCc6RIFwN2nWQZpasE3fgLejAHCSIXWXL/cDLA42reEz5P+gDfKumvX19rfnWXkJboZ+lhDuZoormlCQkXDuNzZ4hbmP36mCQc5Xh4uFCC5oZiNt4e8QSNiyADn90U7Z147S/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F6zIhcOr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+JT9QyJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F6zIhcOr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+JT9QyJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 34AE11D001E9;
	Mon,  4 Aug 2025 17:19:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 04 Aug 2025 17:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754342350; x=1754428750; bh=/iclf67mUF
	eL+Z0uiFK9Ei5BBDF1FSCsLeYxtv4YgVg=; b=F6zIhcOr0KuUnw4ipbjm1kQWJu
	sqUuK+7TF8DCvr/2XqdEnjv/P//p4x32ob1HviTkYX6QgsGltS6mOiyHzzqAYWEB
	fC9I3wlYEI1Vao4xmlU2qNvwHWjAKvUnIChlos8UfDdTh4BycHQ3x8Fn7Ioy3+3n
	bFcF2bHEILNWuzdKIOerLf1o1KMZkEee/CL0R+lUdvmAit8IU9qyS836Su9KiLjT
	ZnHaXisGn9XnE1C5QjdhUCI+dW0nK2SAPZelr/+v8x2G8Gsn8oZjk7R4YTuRZyh4
	IA+AMgfFrgM7B65XumQJziA4B5RNO7AFF2GIyd5KFYmb2MdyfxV+rJdWb6wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754342350; x=1754428750; bh=/iclf67mUFeL+Z0uiFK9Ei5BBDF1FSCsLeY
	xtv4YgVg=; b=H+JT9QyJZhPPLWrqh2NpcMXyy5Pq7Ref0FVrNcRXGEugc98TxiN
	GbWtzEV+jCuR5W03B+gM/SrwqqICs3R3pdlJ6eK/1H/eA70YWXfRXu+uGVd4xBHz
	B52iG/1RqQAyB1mTWkJCWL3YfWf8xBRyPQ7MlnfyzVvZlPIyGCY2/eQ2pXrfr3YS
	RcWbb/VK3USJvJlIUmYik5Y+0H6qW9meYjvLJzMHimvPJyQaqu2bpY45yPwFxxUu
	xPHkNvPeci1fuQ3xK2KkCfeuQbUSBdYSoJPZarLDu8FnB/c+bBNAMyDSrQJrFRPv
	k44wlwbYChMueNMBoV3F9gwL03FURDPwPHg==
X-ME-Sender: <xms:zSORaJGLZsh90Ga_M61B_7Bx5eKVQuDOJ_ORBqWRnhCXCSl6AxkZNQ>
    <xme:zSORaGwNfSUp4xLoWgfveb4nUKM6njMEWdfR2BrJctNaSLbDmQlAXsNrEIYaiwiZi
    -pcd1oJ_fA9Cj8pnA>
X-ME-Received: <xmr:zSORaLkuyzsQPQQneVOBiC1USepufpu0IzRG43Ry5CyruJTjsY0r-CgizxvVM54L7HRtFfswAXj_1n8o0nK5qyTs6HnjZyhe0PuJVnI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeffeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepiihirhhosgihsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepuggvmhgvrhhphhhqsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprghllhhrvg
    gurdhsvggrnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zSORaPnpfujCjTAvtXugpvf4G8Y4MFb4MTCEErRoogrPavPt6gtejA>
    <xmx:zSORaNxz-zJ8b2KWauCrsRxqdQo2qi9di4cQXIEBU176-8pV2R7Vnw>
    <xmx:zSORaEpzAEQEsVd8yVhdHB5pvqSI9MA7wrhGwmf0YJrSHeZYdJntNA>
    <xmx:zSORaM6Wy85mvHtcCUaUNhwcd6yhVtuEbixI_eTEIjsrRR6ItJdA3A>
    <xmx:ziORaFtGravHBz82B-zJ32lcEAJfE6rAOGELH63RtsooRUROTFRXEY4k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 17:19:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ron Ziroby Romero <ziroby@gmail.com>
Cc: demerphq <demerphq@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Sean Allred <allred.sean@gmail.com>,
  git@vger.kernel.org
Subject: Re: Pretty output in JSON format
In-Reply-To: <CAGW8g7kMVqsi6+JkdjDS-czKJQ=01ULUz36sZrGom+QPVtRF3A@mail.gmail.com>
	(Ron Ziroby Romero's message of "Mon, 4 Aug 2025 21:39:02 +0100")
References: <CAGW8g7=21pPAgCixjpayEvmw_ns-hcB4e59NP476TKtCRXHPXQ@mail.gmail.com>
	<ZvM39VNFptcfwMGk@tapette.crustytoothpaste.net>
	<m0r097mv19.fsf@epic96565.epic.com>
	<ZvXMSKaUWWA-MG9J@tapette.crustytoothpaste.net>
	<CANgJU+Xs-sQgAOCPL-5skaZGq7eHmhg0MaFGDr8N57=CK67iog@mail.gmail.com>
	<CAGW8g7kMVqsi6+JkdjDS-czKJQ=01ULUz36sZrGom+QPVtRF3A@mail.gmail.com>
Date: Mon, 04 Aug 2025 14:19:08 -0700
Message-ID: <xmqqldny4wfn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ron Ziroby Romero <ziroby@gmail.com> writes:

> First, I'm questioning my approach of hacking pretty.c with a series
> of 'if json' blocks. Would it be better to make a new file,
> json-log.c, and divorce myself from the pretty flow entirely?

The same question to the other thread applies: why json?

If the objective is to give a parseable output for machines to
robustly read, then I do not think you want to use any of the
infrastructure laid by and for the pretty_print_commit() function,
whose purpose is quite the opposite, like squeezing inter paragraph
spaces, trimming trailing whitespaces, indenting even an empty line
by 4 spaces, etc., etc.

> Second, I see that someone is adding a --json flag to git status[1]. I
> figure that argues for git log to use the --json flag. I don't think
> that affects me other than making the case for this JSON output.

Please don't.

That other thread is getting discouraged from introducing a new
option just for a single new format.  Unfortunately "status" does
not have the --format={short,long,...} so we need to add one new
option to allow new formats to be added in a more generic way, but
once that is done, the next new format would not have to add a new
option.  Compared to it, "log" already has --pretty={...}, so we do
not have to add --json just for this single format, which makes us
luckier than the other thread.
