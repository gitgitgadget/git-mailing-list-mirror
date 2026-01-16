Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB9337119
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577031; cv=none; b=ubzXyCKps/UeL/Uob64Ko66W49H2steXuhdeAJAly8WJ71dpPJ8tD9Mo1HCnOD8TKKoKfgK8Dh67bo4PsDUmeGVnfCOsocMnC2hT5xvQSFQ9dRdU5ZrJ3aOqnkdDmpWJxSHW6bpdCX0sts/ve80UnBTx2qeEGXh/0IkSZ5ZKVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577031; c=relaxed/simple;
	bh=b7/iD80tcM2sFPwZ04w+o8RDU13ySWgjKoNmmilXr1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K3cADanBtkICPmWpIu193fnoZ5843uM4GvSqi/hfuXZEDBaMkyDelA+hq4b6xl6RN+Nw098IsZsMEsqG7wvOl4x3Av7Ow9UdGPis2M7ZDkAv9GBFB+qZ39yRnuJA3ggdxfKVTKG2GNrHOpzRPtG0slUYx1xYOKvVVuS6rvLBGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IbyP+yA0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGHNOXm4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IbyP+yA0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGHNOXm4"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 219441D000E8;
	Fri, 16 Jan 2026 10:23:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 16 Jan 2026 10:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768577028;
	 x=1768663428; bh=7aXFg41QVCGt4XF1V0PyIyR+gaooOfWbJ+bJWURuIl0=; b=
	IbyP+yA0QrA8ry3hX2WQ5NHQSmfYwKizlLn7XIasmn/fjM/v9WkLBguOUl+pg6h9
	nDfgILLHl71adWFc6j0dgvHfL6prr5NQxoD9yYffoxYd2svqHwCrqOWV8eeXaaaR
	v8sUSS/kbI15C8ZrwKxZSs0kPGZvmhB9sfkkqBwliVv3/UYAkAIN9w3UxEz1bu/Y
	B7DMrXjbRsjaMcv2XiKB3LS4YzfXA2JF6gWy49fTuKBg8YrF7YFCedKfcY3MrHdh
	XGorQAyBibQ0kipDxofL3pyN/nZdGSMg5JUUC0Fc22d4Z3J2a6nQqRNDAY+SKXjI
	FaqRi6TLRWB+qQA+qJVGJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768577028; x=
	1768663428; bh=7aXFg41QVCGt4XF1V0PyIyR+gaooOfWbJ+bJWURuIl0=; b=G
	GHNOXm4Fq+hG/3fNXiRf33iX9eeKha9iO/5XDuyQR7mmOvn+kijuh4LT0G/UEg4K
	6kLKougFG64lmDrYF0tpVlZcEThMPAIGOCZMfmO10y9vGXVAftmcSK8GhWBYIPWY
	xfy5npvJEpey3QOBlo13SsQUo2PAOQcScB+vR62Y5O8awK07rK89apNq3p90poUR
	3abb0jSY06eb7k1p9ASKQtf1Es2lbbk8dnK0DMuNL1f2tXUyEJe3Fn6UHnxhXLYe
	UTpo87EAZeivig0NCgy/xP1BAz1tB0up8psNRWeuCnTg+VLmyWjtxbnGJlvbSoL0
	QYjH58fUlw4eTWw9lvCRw==
X-ME-Sender: <xms:BFhqaZ9gjIFhLO2WQ_IqElJg9IsZVtlLRLOpQNUM4wenXvEmQglQcA>
    <xme:BFhqaVL1-e3psiNHDzwabTs6cXiEHSSxqYU_t0P67LZy0Fz_p8WQx3OjdkRPb5jfc
    XHnUt8RqgbO1VkFTi6h-Pg0_esijkBvI1bAgfFFurzBLhWLbApBYA>
X-ME-Received: <xmr:BFhqaUYo6113UV8PDlYLZhKG1djNdTar_qolxdpJaNxQz4Ahojo1f7ivGxXkdhwQQsB38-XOm-gR8U7FPYGfBOwW2jcy5d90oQnswWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeuffehheekudeujeeuveehheeihfdtvefhvdefudfhieelvdetvdejhffg
    feehgfenucffohhmrghinheptghonhhfihhrmhhinhhgrdhpfidptgihtghlvgdrphhsne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BFhqaXKNoQBP1b8_1BhcEm8BDsbMVT8wloQWsrzBqLZkYrsmhIyINA>
    <xmx:BFhqaSAhVxWf3U44_XqteAHjnKfp3hyMc5E-8l8wD-5N5mIGNX-Phw>
    <xmx:BFhqacpb7bFJbU1XoydJa8T_9mhZWOGra3m2dhG3QByOdOCEWaUdQA>
    <xmx:BFhqadiakjqVxFxIQ-31wnPcFnCXoxaGEo-8H4rHGAlEB6ZlbKKmFw>
    <xmx:BFhqaRK6npNFCeCWa9i-SSezprunfQ_eIb76o2DfIYPn6qGNFrehjEM1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 10:23:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #05)
In-Reply-To: <CABPp-BFGPs1ziDFZhbrk25fj5froGPCi92yxGOr9dpgMujKU1Q@mail.gmail.com>
	(Elijah Newren's message of "Thu, 15 Jan 2026 23:00:59 -0800")
References: <xmqqldhybtqs.fsf@gitster.g>
	<CABPp-BFGPs1ziDFZhbrk25fj5froGPCi92yxGOr9dpgMujKU1Q@mail.gmail.com>
Date: Fri, 16 Jan 2026 07:23:47 -0800
Message-ID: <xmqqsec5a8e4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Thu, Jan 15, 2026 at 10:59 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> * ac/sparse-checkout-string-list-cleanup (2026-01-15) 1 commit
>>  - sparse-checkout: optimize string_list construction
>>
>>  Code clean-up.
>>
>>  Will merge to 'next'.
>> ...
>
> Shouldn't it restore the string_list_remove_duplicates() calls first?
> (See 20260115200903.GB1053259@coredump.intra.peff.net and
> fc14e0e5-93bc-4805-a20d-d2aa4eb87ddb@web.de )

Yes, my mistake.  The draft for the next issue of "What's cooking"
report has it corrected, almost immediately after I sent out the one
you are responding to.  Thanks for confirming.

>> * pw/replay-drop-empty (2025-12-18) 2 commits
>>  - replay: drop commits that become empty
>>  - Merge branch 'ps/history' into pw/replay-drop-empty
>>  (this branch uses ps/history.)
>>
>>  "git replay" is taught to drop commits that become empty (not the
>>  ones that are empty in the original).
>>
>>  On hold, until the base topic gains consensus and stabilizes.
>>  source: <375adc4e941f3bb22a2b12ee26a083951ed724dd.1766076625.git.phillip.wood@dunelm.org.uk>
>
> I think the base topic has done so now (as I'll note below), so this
> should be ready to advance.

THis has been blocked by ps/history for way too long.  I think we
can finally move them now, which means they are good topics for the
next cycle.

>> * ps/history (2026-01-13) 9 commits
>>  - builtin/history: implement "reword" subcommand
>>  - builtin: add new "history" command
>>  - wt-status: provide function to expose status for trees
>>  - replay: support updating detached HEAD
>>  - replay: support empty commit ranges
>>  - replay: small set of cleanups
>>  - builtin/replay: move core logic into "libgit.a"
>>  - builtin/replay: extract core logic to replay revisions
>>  - Merge branch 'kh/replay-invalid-onto-advance' into ps/history
>>  (this branch is used by pw/replay-drop-empty.)
>>
>>  "git history" history rewriting UI.
>>
>>  Will merge to 'next'?
>>  source: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
>
> Yes, I think it's ready.

Thanks.
