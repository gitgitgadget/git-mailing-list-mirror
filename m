Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949374BE1
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763341983; cv=none; b=jKrFSUI0XZ62c/9AriTYQovgyiPt0D56onnWx7D3eOU8qx18pZrd7Za1aYHE/AINa9mIlS8fehu9jHAfnIYkRY9PVX4FIQe2f/KSCpcjX/pyzkOx1gyLO3VyUrbsOi1+4Tis19Y9d1t/2V5+enarLDzpfvX5r8fFTBBmcehM0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763341983; c=relaxed/simple;
	bh=aY0mRR0RlQ0gAVkplKzoWBqRGLnelVZl8/Sv4jkzCIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SkM64X1Ml32xSeeQDONAxEtaQiA/1UySPhG0n6icY/pOoJJzgBbAauSsMNyUKDzQLKH2/SV+aRxXpDZs9emDN6EYVgrdsOAH5gV31mtvwUUxdrnNQsJMpEOJxb1X+ntf77c37rIH7lQW4fNNzr1ww/W7bCCYsQpkbvrF5092SpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ITI1mk1p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q9xPWYbM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ITI1mk1p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q9xPWYbM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B5107A009A;
	Sun, 16 Nov 2025 20:12:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 16 Nov 2025 20:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763341979; x=1763428379; bh=SyKZQ/iWSl
	oVrsXAWfi6lHryjPxBtUonVHqeNqMpIC8=; b=ITI1mk1pBfRj+PMRx1thRx1aAF
	NKBz8ll0Dw/IG+3/z8l9gHbugIw4hi8uSXklWvVHOwY7+BWI/WSIgyKPB4LCfUVH
	ZeO7KjlOOqkP0oSeategm3wAgAbxgQ7If/71usT2vFKU24prTQ2oNaXY1YcZL06Z
	f7hRRqrCSGUt/+YpTy/wIiY99SKrxr4eHVNSnDP3WvW9liIGnTLB9/t2WoGVEyDH
	tEp8rd6dfT+CGdBaYtGS+y016kh7i/EeCSvPtv0CQvnDxsQ0i/G+9CgD9Z6c0/hW
	CzJnx/QUCYqKg0A8IZN8/n0v0VVKIM6cTxVxcBExByST3XRSposv9yDFmYaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763341979; x=1763428379; bh=SyKZQ/iWSloVrsXAWfi6lHryjPxBtUonVHq
	eNqMpIC8=; b=Q9xPWYbMT9QuFDyTtMZDHF/8ggqlULlTDxaFcs720EIacS5Ss/m
	fn+cRqSHyioa5SDF6RDsE5epd6tEDc+hzCSpw7mvwPVR+d5mRUfyjMITfpwsQFzr
	4HlYYrlDjlWBLq3P0PyVH5bPThCQU79l/k9/fL1gdfbud2fbmfPEeVBLlR5bl4Vo
	i76tOddabjFqA50iNdlyD4qjIoDUM0cuYWQV/zw8YJEOlQ7SjjaYLmaB552E8tgP
	U1vN1thlrykSskX61BQOXcL1qGgEOE0SKfLjDcsHmF2IXX3Q4T8pA62zgeenlLhp
	JZblhmNtTxKV+OQIxYT9A09tnaBTwt3ALyg==
X-ME-Sender: <xms:m3YaaTiSC0o1kkZpNVJE1C1iezypT8QeWir6OAtJPKK9epyRuKA_Rg>
    <xme:m3YaaTvTXD_vo3wMHxYRsdUZvPLw11u_1Y-MuVg5MShbEPUUsakb227xr_1GmnRpv
    v-j2Z0niovH8rvVJ2HyxAyG5Fr8X38dTm_hLdR1JUCKfhbPnXwreA>
X-ME-Received: <xmr:m3Yaac5MdI0H7wTFDVVnb31wznmxnKkzvqpOPjIM_4GMgSZjiUZ48ejvsFpL7YchFBbwhd8w1v9we0so9Fl0W781kK1E7YTUgQfN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudejudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegrnhhtohhnihhnseguvghlphgvuhgthhdrvghupdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:m3YaaXM3Ww23s_miDZxNkh_9d4GYSomYoiJF_QWGobqcXNnG-7LALA>
    <xmx:m3YaaSu9IeJS2K37ijI-fS_u4KzcWiq-VFmtuTkoWlBZm3iYWA75Vg>
    <xmx:m3YaaSZMJtXynEfhw_t9wGaE1VdpqD-Vt31zkBg8_pRVJ8YzavfLDw>
    <xmx:m3YaacwGyV53EGXIbAqUWeRwhfaWSyjIKiL6GZIP7amFJJs_XE5-4g>
    <xmx:m3YaackZQx9ToH55ZdBaxuZYMafwcOcOypVuOr4bv3h32fSzIqLG71IA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 20:12:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>,  Antonin Delpeuch
 <antonin@delpeuch.eu>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 0/2] blame: make diff algorithm configurable
In-Reply-To: <08a6c461-e162-4eee-a42d-1da8f05a0606@gmail.com> (Phillip Wood's
	message of "Fri, 7 Nov 2025 15:49:56 +0000")
References: <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
	<pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
	<08a6c461-e162-4eee-a42d-1da8f05a0606@gmail.com>
Date: Sun, 16 Nov 2025 17:12:57 -0800
Message-ID: <xmqq5xb9bgx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Excellent, the range-diff below looks good. Thanks for working on this
>
> Phillip
>
>> Antonin Delpeuch (2):
>>    xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
>>    blame: make diff algorithm configurable
>> 
>>   Documentation/diff-algorithm-option.adoc |  20 +++
>>   Documentation/diff-options.adoc          |  21 +--
>>   Documentation/git-blame.adoc             |   2 +
>>   builtin/blame.c                          |  52 +++++-
>>   diff.c                                   |   2 -
>>   merge-ort.c                              |   2 -
>>   t/meson.build                            |   1 +
>>   t/t8015-blame-diff-algorithm.sh          | 203 +++++++++++++++++++++++
>>   xdiff/xdiff.h                            |   2 +-
>>   9 files changed, 279 insertions(+), 26 deletions(-)
>>   create mode 100644 Documentation/diff-algorithm-option.adoc
>>   create mode 100755 t/t8015-blame-diff-algorithm.sh

OK, we haven't seen any activities since we saw this comment.  Are
we ready to mark the topic for 'next', or are you waiting for the
end of feature freeze to make a (hopefully small and fanal) reroll?

Thanks.
