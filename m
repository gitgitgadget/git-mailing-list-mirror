Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002B33C1AD
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088079; cv=none; b=bnIKR8U8f/xsnnE72PScCg1T9d7xxnCXXOFlwvpKeB6vS1RiLBgKTeUCUMOmNoLjq3zLHf4v2YaEaGvAeN6JjeLWc/0fa84ipE2ZtzpVME5Oc7TChxuaz3JQswyYNQZOSWsoFmc6woDSpVeRx6d4BiCjZko7AXm4W1hcYOf9NPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088079; c=relaxed/simple;
	bh=aTdL+hElhCaCn5ebecBDoBRdmaiPdoxSg+c47C5CMJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z2pyQsbkMIv4+TTXs8fpgkT51HUaOrX/j1UCyXpnN/flagHVJf6girJoVfHXaNZ1E3lYuN7CNobGo7+hvZ4o/YI6Hu16U+S3s1aDxcZyNWGI7hz6aAObyuPoruPQo5JE0xJG001+3L1e/+cj1W2v6fp18qvrqksrnyCKg9nTtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KsuiHYHs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRWiFqUh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KsuiHYHs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRWiFqUh"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C84C7EC0ADA;
	Mon,  9 Mar 2026 16:27:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 09 Mar 2026 16:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773088076; x=1773174476; bh=aTdL+hElhC
	aCn5ebecBDoBRdmaiPdoxSg+c47C5CMJI=; b=KsuiHYHs/OrLTe6TAAVX8kMko5
	LaGuN4NNlm96S72am8jwvHJNSFkxuy/74uHALR/1+74h7OsML9oAkDL1WZ6gqeGq
	0m2VFHVJCi7DGkLwN2hCDPTqJMNZjea3e6UlgWXlOUE/VxEEOMY5R65vWUYR5qPZ
	H3uNvHwoHoBHIrBQfQebE6AvU1UGjvlMCsz4sCVSm/cTl10ufOrIxpyi4hSLcpNC
	A7ydQgBCHK2HpzuGnZu5Sg4QL3f0AstC+i5O3Wj9xvQMOnfd0mBEhsJT3NZfJYsv
	LYaKQsp78BiBRIW5IABybZvUsUxZjfChIfSbpjyMcIevyvW34/vRokfVLD8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773088076; x=1773174476; bh=aTdL+hElhCaCn5ebecBDoBRdmaiPdoxSg+c
	47C5CMJI=; b=VRWiFqUhBiuS7Pse0ByFQxJrpzVhkQFWG0TkXOA/NUGEn9bFWzI
	rUIRla+WSo/K36bDYVvLVz8pdM3et0O5MO1Ir6a22E9JAJgHz/+vaF9fV7tgAKwj
	QsVcl3pjZKAzh77bHD7wGrLjHfbN1rPvn2WrFCTYqDdQ0qyR3CGzCHluIaiMJ6Lg
	A7gyTD35RYWnnyImIIxbYj7CsVY5uv/xbPje272BOhQwNozdDbsyp3qqZDGHp/dY
	PPwvklFbEAdUyP48UK1R1H/x/egA7Lv2xGT1MN7RM6WnqLRsK0som6rqaD6YnMIV
	b+raxEKRwv7ZT1DBjPjPNrWugeyQIyveqFw==
X-ME-Sender: <xms:TC2vaSID3eGe0e9a1PhAn7Y5M5ulLmeRLJjIXHQE44A9WCU-3MkHlg>
    <xme:TC2vad0itBI-JHpcLVQtZCNQXqogoNFyaSY4BFkdbF22pb1zcwvjt9qjO2zDkxN67
    DkDTJ5nNJ78lENh_J17FCcDLi_iX_OEZAuHUB1KuZ33Vmfy11fybg>
X-ME-Received: <xmr:TC2vacjAhOANR2pV0r29NX9Wkh9q14GhDJh0d_58t0FC-j5a8fbqN0JJwXYXdSNCrTLKQWuKhNPJvS-t79XStHxBKSTOkfRxRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeltdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:TC2vaeU0B-ov7gtOl2s5eGVYnzFraMxWE7KGiMy00JidZHgSCgwPPw>
    <xmx:TC2vabUSKd711hhCcITXYyxwhx5Z87rj15Jo-nlUXEq3Si0zPkFM8w>
    <xmx:TC2vaeizV0JyGRk7YiA4kpXszbPdTaejt6XWJ1pCFNQmmtFctSwxww>
    <xmx:TC2vaWaA4iJ3ZtnDqa9Q9uZUUVvAc0lydr1y2_JE7QM1pWggOWaRrw>
    <xmx:TC2vaeiI0-0XZe9wcJ_57YDgIrcbc1FXrn2EHVCKFw62aP5ttRPqcR28>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 16:27:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Patrick
 Steinhardt <ps@pks.im>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 00/10] config-hook cleanups and two small 'git hook
 list' features
In-Reply-To: <20260309005416.2760030-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 02:54:06 +0200")
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
Date: Mon, 09 Mar 2026 13:27:54 -0700
Message-ID: <xmqqsea84uk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Hello everyone,
>
> As promised I've spun-off v3 of the config series [1] into its own standalone
> patch series after v2 landed in next.
>
> This is mostly minor cleanups and refactorings + two minor feature additions
> to `git hook list`, which resulted from the previous review discussions:
>
> 1. The ability to show the config scope (--show-scope).
> 2. The ability to show which hooks are disabled.

This is a very pleasant series to read. Thank you for spinning these
cleanups and new features off into their own series. It makes the
evolution of the hook-config work much easier to follow.

The overall progression from general cleanups to the more involved
cache refactoring and finally the new features is logical and well-
executed.

I may have a few comments on the later patches, but the early parts
look already very promising.

[PATCH 1/10] to [PATCH 4/10]
These look solid and correctly address the style and naming nits
raised in previous rounds. Moving unsorted_string_list_remove() to
string-list.[ch] is a good call as it's a generally useful utility.

[PATCH 5/10] hook: replace hook_list_clear() -> string_list_clear_func()
Appreciative of this change; using the standard string_list API
makes the code more idiomatic. Stashing the data_free pointer in
struct hook is a clean way to handle the internal callback data.

Thanks.
