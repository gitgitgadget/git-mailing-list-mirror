Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784D1C32
	for <git@vger.kernel.org>; Wed, 21 May 2025 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861954; cv=none; b=Ntdw1rdTxtRnRUYAfmh4eJaRXoKNitPWOTJM8NqhgLP/LujKJJYNXudKxJzdEbF9JgLlu3/K5pMNNIaaEak/l+jY9jYygBnx6o7TZikFcAupYqUE4paSrW/m3wVEUCklGBgZbxbYdOzL+4QtHagLpiXmFUy7DYpuzlteV2PJrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861954; c=relaxed/simple;
	bh=3m5doBfUo7vJsc/xgtsOHfhCWHOk2Pf2MfWkF1xa978=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aQLd/YasdjXXZ17H/VBDISzu3TLV41wW1S/YUec6Ccucbj9BEZj84FqUW9aXgfO6YCCKjt12YrZ34xuFFBdA5XY9lOpsgtqJvEuqBegN4fVpRjATEKHepoSvyNEEuODgJA6bmbLKyPwPn2EKvKUMwGiVVs45vjaW4a+OWPSDTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CpUDM8C+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h7tkS0l9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CpUDM8C+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h7tkS0l9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25C71114005D;
	Wed, 21 May 2025 17:12:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 21 May 2025 17:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747861952; x=1747948352; bh=IXKIGPmMT6
	0JXtVbEhwA28Or+VcUOiBVhFyO7ZP2XjQ=; b=CpUDM8C+N5cBjHvLv5OV7cMfE5
	Q58uky5bSYoIKFh5i3YoQvThFEugaLLaM1/v6Cjqx/mO9gKjYF4dKEoLten14RXS
	T8I5OFvtaasismHV+arHJ85+J+XPwu8bMa77bDmlvWF0jyC49RXGX6km/Y13lpDH
	QBEKnlGtOUZpkpPaiuQPwAcqwMboj9vB2gHRaany4iTwEjeqbTrVg3Le4ZfhILf2
	KUS4oQUeYB1znXo9UELXU4EXZ3+ExiW31L+umQxSZMa7Ar4YIXR1W3jnQ5oZadgu
	2i/NPcaDGwvUtU7XyGulI1C7hYqvQyzpYpORSq+84H8QUF/bVf4Ukh2cWShQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747861952; x=1747948352; bh=IXKIGPmMT60JXtVbEhwA28Or+VcUOiBVhFy
	O7ZP2XjQ=; b=h7tkS0l9NhU1GhTlP0ozW6tohDZ4NF3EELaR43rNx7VxJ/3Bsqg
	DYE93eKUWbwKl9TWMFoULiq7buzqmfOKQ5YXiwWjnGy5Rw9fooeOzl/K4zEYkrdR
	sAnTCkFovrCxRATe70SW+rbluXFgeb/FibUtQoNElB/3F717xmexam6rK6waiDt5
	ak3oeS5e7RByRPrcsFkr6fU1/tijfdSTwQCGZTAxOJOn+gYjhQAeCkNY7VAOYn9Z
	JzjyvkMGhlVpNvVumELsHO7WuFOYMpL1nNnZ6nCNGhl89kJtHgPE/5J8oRHETPlk
	4OuK+B1SH8C2DKPQN3pQFPcv2COxU2JLUTg==
X-ME-Sender: <xms:v0EuaCoTu_iyHk9HYi91CPPxTxhcB3I55ppN8vxG4CGW_YWiZVQ4tg>
    <xme:v0EuaAoBjVm19s1DYzLX09kq1aLNwrOzcHtvand8WSSb4QUembuCu7AF5sWtdOuQ0
    QN8nbkTdepXyvarvQ>
X-ME-Received: <xmr:v0EuaHPFkGgk3oTHntyvZgfGj_AkwHA7zVSP5WfWsvvI4DBQHoNKw320Ps7doNcpkNxJNd6647AvpQQbp4q7IsyFlFGzZPq3Vf4qlVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeguddvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghlvgigrghnughrfhhogiesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v0EuaB7Q8JvmQaSFRmySVMfgKfzfB-2_GhmbJ5_FZGXMLvC6lh0R2Q>
    <xmx:wEEuaB5Vb9yXfE73nTfSnToRVKvKcWieJOpJpfPnurO7A3Z0iTyF3g>
    <xmx:wEEuaBjObt45mV5tijTFBNQYY3ze6QdoXfR8Uzripmb4LTNS3CMc0A>
    <xmx:wEEuaL7hFIMwKq6FjQMJxC8edlHGzEYztDe9aYQFIrJJUjja7gffMg>
    <xmx:wEEuaGZOQ_aNTGYFHX-XhZiRW5jb8rki4LEHv88aiZuOgvtnEjIZ5qei>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 17:12:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Alex Mironov <alexandrfox@gmail.com>
Cc: Alex Mironov via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] name-hash: don't add sparse directories in threaded
 lazy init
In-Reply-To: <CAC97EbxRpG1ecWcQ=yJHnqe7gXYG7BNo1sF9e9Kf-EOkDySfpw@mail.gmail.com>
	(Alex Mironov's message of "Wed, 21 May 2025 22:37:58 +0200")
References: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
	<pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com>
	<xmqqecwhaemu.fsf@gitster.g>
	<CAC97EbxRpG1ecWcQ=yJHnqe7gXYG7BNo1sF9e9Kf-EOkDySfpw@mail.gmail.com>
Date: Wed, 21 May 2025 14:12:30 -0700
Message-ID: <xmqqo6vl8y81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alex Mironov <alexandrfox@gmail.com> writes:

> Hey Junio,
>
> With respect to messaging I more or less copy-pasted Derricks message
> from the original commit for non-threaded init: please check the
> referenced commit. Let me know if another wording is needed/preferred.

I know what you did.  Copying and pasting others fuzzy words into
your commit log message does not make your commit log message clear.

I already said the given message is less clear than desired, so do I
still have to let you know???
