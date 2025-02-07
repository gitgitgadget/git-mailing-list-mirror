Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980718DB0C
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948271; cv=none; b=cqAz1mzpbj3UxCKeSDIO2z+4aPxVQigfCrfwugSYldsKTrN32GZ/0PUMn8t8pTrw0960jl28DtJV566ET2ItZMcWyC38oGzLeB2RMilIo2nsA6goK3reK7W8Mb8868kR14yVJCE9D31n7GI3VdoTE/esoWPC63pXnXlWfnYPlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948271; c=relaxed/simple;
	bh=tEc18rtkKpVLkKzZ2aRS+arkO5ys56JTw63S/hUeYX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nFWXCDKnx17stpV14R8KYHZ3pR58yGn4im49q/EP2IlJ12bFSuYIw9CYGSGEkZ0roKla4AKgHLdt5NDN0vewPP8TDIJNgtRAhBfNrGTeiCfu2lICa9RgMPWHc9DdC1VZj1IDtZUmqYj06hOxeoQh3S/+xYwRMDH8aheV0hfq4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qeiyR3IB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wdEx7tOl; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qeiyR3IB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wdEx7tOl"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2831325401A3;
	Fri,  7 Feb 2025 12:11:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 07 Feb 2025 12:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738948267; x=1739034667; bh=q4krvrCN44
	tO6ytKljrFnwmiqQ9V0pr4UQNWuQRIgxo=; b=qeiyR3IBc+OcBO2lHZZP/IVmky
	VxIPxEhblhXhM31pTI99+GHOCfglcjuQjtivFl0ATTSNh5Qv50HzreOAA9DtDlmm
	KR6tKOFq47ngrd5OnddC0jSnDJFqalYhSfwUlXN2A2GAMXwfGcF9SLiPNgQ9wZD4
	r1MecPI6cfTtoynnlJUBQKbs9DOO7yt055VNgveCVoyj7weqTB80hPJX5KLYSr7G
	jJUy7A2XVPyqpyVUf5OTZkZcGb/rSYM9CkYgan39CcGcc8pwjnuihOuNW6AzUR1+
	6pYAO/5KqLV3u/sSgFYH6PWBwUmkq3kcLaBkvbirJxSh2WcPnM/MvCQ4F07g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738948267; x=1739034667; bh=q4krvrCN44tO6ytKljrFnwmiqQ9V0pr4UQN
	WuQRIgxo=; b=wdEx7tOlkwOH50580kR/5XxVIOPi7A7D62ejhFjIZfCQv3cdPyT
	dUNrKDEp1Hu+6uPh5pNxSueguxSuZbacsnx/5hXy4WXHJE9+k5VpTVMphw+3lEBS
	//sX7TpqKtL2wAZX0+FNKm4wVXnMTE1aWDsT5f/QtlboR+W7gzUTu52JH9IDJqOS
	bEt6Ls9WHSeQxJsodm/rE6OnrfWRDeP/+Dyb2A0iZkYmxt450O4vqy2OJ+o+sZJr
	sy3XVJU080pGHtV2gGtQSSXyQd5ks7HYakhsTBdfYbi401D4Bn2ewIe/C5xmLd0F
	Y9zJ35y7/OPQmzp+4sdg4hct71P/u8ey1Gg==
X-ME-Sender: <xms:qz6mZ_Z9iTw5kiEHmgx4NVgwhoQQ6KJg9_rKqfNv-7PNGJ5RWO5pmg>
    <xme:qz6mZ-bBcwgOaOc-pP7Jt1DDuR_xQESa2BNEVFvkwbH_xrxRjWPdmlladNfZL0YqZ
    mK6eVBbdgPblEI1PQ>
X-ME-Received: <xmr:qz6mZx-L5sSH1GTWdP9CLcDF059RMTFaHJK17pdnaZZ3FEVMoCHzUU0zikfgkrCXiXh1WnIsRUgIVR2Lcc6uW8BFMVBw4sYkmowL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qz6mZ1qCnl7CKiuC53YMsz2eTdQJUeR8wK5fFP6bKBx2OE7OsDhoxQ>
    <xmx:qz6mZ6og1iXsDK3NkopN5UdkrJHR4IT8fuJVc9mJorbNWydfl54sqg>
    <xmx:qz6mZ7RAI4dVnw1bTO7-ksvsA0T6KHLD7fyIXO_AwTgLNPieUurcjA>
    <xmx:qz6mZyrWsWYu8r4XxnUqn4-4mRlczUdnjwPOY4CDyYg-GEJ0RILMvg>
    <xmx:qz6mZ9WIZ1zFMafLSVEPg87zgSHgmiXHBeZSdkaY_5B0vLA-G3-eN6KA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 12:11:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2025, #01; Tue, 4)
In-Reply-To: <875xlm3vzt.fsf@iotcl.com> (Toon Claes's message of "Fri, 07 Feb
	2025 11:11:18 +0100")
References: <xmqqldulrvly.fsf@gitster.g> <875xlm3vzt.fsf@iotcl.com>
Date: Fri, 07 Feb 2025 09:11:05 -0800
Message-ID: <xmqq8qqhhe8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>> * ps/reftable-sans-compat-util (2025-02-03) 19 commits
>>  ...
>>  - reftable/basics: stop using `UNUSED` annotation
>>  ...
>>  Will merge to 'next'?
>>  source: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
>
> I gave v4 a round of review, and besides one question/possible
> suggestion these changes look good.

Yeah, I saw them.  Very much appreciated.

Patrick's latest (i.e., v5) addresses the UNUSED one, so assuming
that one looks reasonable to everybody, we are in very good shape.

Thanks.
