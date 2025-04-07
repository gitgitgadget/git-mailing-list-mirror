Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319620E71D
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744063877; cv=none; b=K5vf3PyxUZVGqjYEzW6a3OzabBODvkwDqwWeJrhCbIquTaCAZLhddFZ+LXq+QuipKPQjq7WtpOEN4S44Yuf6P7QZeX6by/9ouepMMxLl5oIzHOt7IQxQ31ZurSj049W0fjyeMNa5T/Mm0hYsP8GX0JCdWNvlmCpnvbd0c8AVTPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744063877; c=relaxed/simple;
	bh=wOWjXxO1IdsjRBq8aVoISTRY6RT9Rhtluo7SiwBvtxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AewwSL7qJRz1BoEmuDmamkP7cMcsyKDCh6JUz68y2LTd9SNBIH80QpktZhdClOmNeUstEnR3+meNfvOJKV8IdKys2UF/Q6TpvAy6VjEXnqwcPZlInViPRRvs/Jlh596ryYTpV5scd29H30Eo9HnHfopJZD/jJzFpTvv5MAoxNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mpqRTGqN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UU7z5oWE; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mpqRTGqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UU7z5oWE"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id CC66E11400CB;
	Mon,  7 Apr 2025 18:11:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 07 Apr 2025 18:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744063874; x=1744150274; bh=wOWjXxO1Id
	sjRBq8aVoISTRY6RT9Rhtluo7SiwBvtxY=; b=mpqRTGqNqk++xwe50HFhUqI63/
	oGb+zFX+F3DUTlpPExBx6TDJ/TneG2S7qjkg87UoQPZtTIxQb8t5GJ4rcFbH/t9g
	gFy53Jbvtde4ubxi2VyZqxS+qyMZCWgOp+oeiXrU/TtMoZBlMpLRtbgj9yvpRWYw
	H+9hTCq5gfILarRylAXhJZMhXkuOPAJBa/gq7OZbbVAsC9p04bpA2VbAjY7n2iCw
	OVlkucMiGkVyomMSvS5d+ONh+4PwHELvqfTC1yqfzOd0i1766gTkUDqzDCpudxyb
	BWC+soo3wp3sHkY4RclgdGpHXKKDaZNVeJA5bdeCQyR564GJLPQW77fPJemQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744063874; x=1744150274; bh=wOWjXxO1IdsjRBq8aVoISTRY6RT9Rhtluo7
	SiwBvtxY=; b=UU7z5oWExkWRYHFSiYBhmlmmUZzKjMm8qyahpUjvnqnAfpbI2Of
	a3FBPftpEwYYGvcTXwqMbqDTAMIRT77EpzEXRRa4+EolU5pzkQ3PjWnuLx3YBvR2
	7+p4TLu4cZyK9YB0Yus6w2cfFDZCjhdPk9KDBCuIBp8LRPtHVH1iDVD6PKaIn8cL
	f3itgcTwYbZJzrxs0yv7nJm/GCW7MkCAJMjhHKM+UGgUFZjtcTtCCGvHaPDUit59
	SEdncaegY8GpoCD6691ZdJhfh4F+qXpGWHbzBdRNF934gtiIgtGnT/H3aGwRMQO7
	jUVcnQ6NaGPLa0aizzhB909GOuuzNWBopbQ==
X-ME-Sender: <xms:gk30ZxTxLuHWLSMrHDtyyOSsqs80dYCg9uBLjPlQpcvQPj7N2L7VpQ>
    <xme:gk30Z6y5-usLRSWQ5D689UvbUOfnM3rKoQjqnANkvA6o1mjYXkfMPl-SQ4-kh_BXa
    PiGUr2xcrFnGAs7og>
X-ME-Received: <xmr:gk30Z23ugQaZNL94UOUZmevX8VseYDae0855jcip0-r7uUeAqJHKYU4PMJ4ZEKdM_M-FSQZzHUYeNwgNB-n3KREXsU8Td7YD4CJS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheprghnthhhohhnhiifrghn
    ghehudefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhose
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtddtudesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrnhhthhhonhihfigrnhhgtdefsehitghlohhuugdr
    tghomh
X-ME-Proxy: <xmx:gk30Z5De5xgpyBQf1_0d-7cy6li3kJ2pqNVQzgMMz_tr0OzVpsFvjA>
    <xmx:gk30Z6jnsjV1jRdEEkmaGbNu_aUiycy_EwXSc8tnIVgFJAzijRsQow>
    <xmx:gk30Z9ouFFlmezqzmEuS_Olvd7pkW1XykAbrGudvArX-PEkeubsa0w>
    <xmx:gk30Z1hgRb_KM8W64iHP-VZMnqDxDw2B9kfRU0FLElOgkJPfHw_5jQ>
    <xmx:gk30ZxiwYOHdkACWDLuFqxYt7tPwv7nY1lpA-KSlnvHUd-Upg0C51AR1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 18:11:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Anthony Wang <anthonywang513@gmail.com>,  ps@pks.im,
  git@vger.kernel.org,  karthik.188@gmail.com,  shejialuo@gmail.com,
  christian.couder@gmail.com,  shyamthakkar001@gmail.com,  Anthony Wang
 <anthonywang03@icloud.com>
Subject: Re: [GSoC] [PATCH v2 2/3] t9811: Remove the -q quiet mode from some
 instances of grep
In-Reply-To: <CAPig+cQbMUQAHsx92QNLAvfkUKRFoVoWznhPQok0PN6HW3wxzQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 7 Apr 2025 12:26:23 -0400")
References: <Z_OEAxJENE_mGkVa@pks.im>
	<20250407111824.46518-1-anthonywang03@icloud.com>
	<20250407111824.46518-3-anthonywang03@icloud.com>
	<CAPig+cQbMUQAHsx92QNLAvfkUKRFoVoWznhPQok0PN6HW3wxzQ@mail.gmail.com>
Date: Mon, 07 Apr 2025 22:11:12 +0000
Message-ID: <xmqqecy3lj0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> For such a simple change, it probably would be more common on this
> project to combine patches [2/3] (which drops `-q`) and [3/3] (which
> replaces `grep` with `test_grep`), and to simply explain as a
> side-note in the commit message of the combined patch why `-q` is
> being dropped.

True, and in this case, I'd say this is better done as a single
patch to go directly to "show-ref --verify" that loses an extra
external command per tag to kill three birds with a single patch.
(1) lose the problem of pipe hiding the status, (2) clearly say
what is expected to exist and not to exist, and (3) futureproof
the test so that new tags with similar names (e.g. earlier steps
may be updated to start creating tag T_TAG_F1_1, and grep would
happily report a partial match with TAG_F1_1) will not make the
verification invalid.

Thanks.



