Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CAB3D6694
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247350; cv=none; b=B6UOnlE2QGevQV0Ili06V7q+TfjzBBQuNbJeOnbTwfjT+IxxqdYtTnC99s6hD+fmGRBWTGqv8FZx5f9izMZqPWjFiYQ1jf79IuacT29pYxRbn4xXXxHyI9kj9eTURd1qKX+x1/VCL5p7RO46oNJ9ciEPJYDNCNTrfvyfSa6Ut4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247350; c=relaxed/simple;
	bh=Db2K4C4/KcgAveYwQOFIkwm6eZnDqjArHjmi1/296Mo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V4DB5vkPb37oBcA/BPNCh9LrQPnsBS+Ewqf8V47ilv9O4U7C7D7o0RFTJwUz4UQ838odHf3jew0VoN1MdI25Fpp23aD4voSGUbSbtssoyVz7G6sl6ltTDxPR+T9lP4AIP+yh6pj7Q+TkxDSaYXnrAh4fmzkyJTolNoKFpJToDjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ga8OswBN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dFBGWj/o; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ga8OswBN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dFBGWj/o"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5106F14002AB;
	Fri,  3 Apr 2026 16:15:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 03 Apr 2026 16:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775247347;
	 x=1775333747; bh=Zg7nYpxpdIeobs3RRiP8n1/B2fa2q7qN3t5hUK97p3o=; b=
	Ga8OswBNWuw40KCFGcYA4hqEkjQYtgcdb/duRPjeFykuohOAeMBUs+6kpkT+QLCd
	cCM4+IKtDoXplpkTe1Te/9+vF+qnyI4ibZOjipz3r3tqnBMKxoTHWQzn7KKYqxpR
	YJS/Fei6frjplbvfYhssu8FjDBjK5a7U/jFuZEV9qwmbEHcmHw8N1GQtSzNn1rba
	IA88I/uBrPES/N9fgPDBKHDAiZDkyKUW1LR8jmDYozaFXdTechjMCz4Zq94CN/DS
	pAGAXTz2Z2CpVJMxSribLnWBXMAglO6sKDkyR+uzybHh/iOsIcbCLg2iaf0UfDJ/
	noEocbfan1Z4MgXIuk8j0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775247347; x=
	1775333747; bh=Zg7nYpxpdIeobs3RRiP8n1/B2fa2q7qN3t5hUK97p3o=; b=d
	FBGWj/oFf5bsLYqaOBfUWwr6HYalDka6KWx2zyocQDKrzJAVNEkbj7FSR6twnrRy
	sER/nHiZTb2H813Sw5E0C4XblStF9UA3oQ9hAh19PmS2X5QeS9pnYlsVbsOvtIYv
	THBA7SnzU2UPjS+j0kMH9JBdACxNuk3IQsD0Aln6wwQB7j/ZqyoH2u+r36gzbLkZ
	EEvqeb2lfklZNy53VaJyeBcEWildgBVpfoYZZKL/WNl//ImTL/SsSkOI+94aq52H
	auihQablXqj9Sh4w3BKT30hSQitreb16YLhVcDFzuB/wMvPo/E/bqdCk5Hl5PkQr
	hta98S9D2q2ERrnwCiQJw==
X-ME-Sender: <xms:8x_QaS3toOgjdZF8kJXc_Esk3wAuFYEZ37yUcYqeO4wsK5lra1Xybw>
    <xme:8x_QaQ7VSAqdYmVJggroyDfUs5KePjT2lcrd4oMVQyt7Y46rHvHe-Vw_-gwy4SuCp
    58kNABeN3Sk4AYk9NP2JsOZZTtQQt1wdYquVpS7s1W3DQUCddMS>
X-ME-Received: <xmr:8x_QaWSEpiX4bLvlgfWmSjXdF0uZ0rpLt5CABNhBqB5PeKmJlJ37rwxd-5NBrt6cHysDR60Q6Du0V9NSCNQH6uc0VWzNl6-bxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttd
    erjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgf
    ekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgrsghlohhoshgrsggrth
    gvrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhr
    tghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvg
    hkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgr
    nhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrghnughrrghprhgrthgrph
    efheduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8x_QadVztpmTzBa90WzHQMraMlHCpkw4dX-RpCBNVMwgTRcjsHtgbg>
    <xmx:8x_QaTFGpyP288hOJBFDPdMTpP1oF5l8NgunSOyZ2PSQ4bx53eEsew>
    <xmx:8x_QaYe6c9VOKy2UOpLaWtE37H_pvD-Fnx-NHGbu0_bvI3z5uGgeXA>
    <xmx:8x_QaUrD6KtWDsL4jOzspsbUkuyVBXwoVh1R7N7BkAVcE9oL634tzw>
    <xmx:8x_Qaec0CN8nYNkE2vVSACOryqVPQfPZDTh5iPidH4CMl4kaVkzmUgZL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 16:15:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Pablo <pabloosabaterr@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  christian.couder@gmail.com,  karthik.188@gmail.com,  jltobler@gmail.com,
  ayu.chandekar@gmail.com,  siddharthasthana31@gmail.com,
  chandrapratap3519@gmail.com,  szeder.dev@gmail.com,  git@vger.kernel.org
Subject: Re: [GSoC PATCH v6 0/3] graph: add --graph-lane-limit option
In-Reply-To: <dc134cdb-cdc3-4c54-a97e-993a26900d0d@gmail.com> (Tian Yuchen's
	message of "Sat, 4 Apr 2026 02:56:28 +0800")
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
	<20260328001113.1275291-1-pabloosabaterr@gmail.com>
	<bdff0a5d-b738-4053-9b72-08eba88156de@kdbg.org>
	<CAN5EUNR_yfkv_hC4wg-nHNg=3FnkYdvFm6FcOUNG2A=MdGs7ZQ@mail.gmail.com>
	<xmqqikaawrpx.fsf@gitster.g>
	<dc134cdb-cdc3-4c54-a97e-993a26900d0d@gmail.com>
Date: Fri, 03 Apr 2026 13:15:45 -0700
Message-ID: <xmqqbjfzn6ku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tian Yuchen <a3205153416@gmail.com> writes:

> I don’t know about you, but I find this rather difficult to grasp. At 
> the very least, I can’t tell at a glance where the actual merges and 
> branches are. I don’t think a good solution should involve shifting left 
> or right. Perhaps it would be better to use a special symbol in the root 
> commit (such as the ■ symbol, which resembles a full stop? People would 
> instinctively recognise it as a terminator):

Not only just a symbol for "root", but you'd need to a set of
alternative "root" symbols, so that you can also show roots that
play special roles in --left-right and --boundary output.

Different charactrers were ruled out years ago and had to be shot
down at least twice in the past mostly due to this problem.

Also there will be another question, should the bottom end of a
range and a root commit be shown the same way or differently?
