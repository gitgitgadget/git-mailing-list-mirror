Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00751238C0D
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774202799; cv=none; b=mG6GgEsJvUvGMwkwhEi2AUDgksXTvkWQnSe2QCA5gWqr285FdGXxajdfrfmeY6R4e4wlXizUd7HizCjqSiUNWcOb0I84GH2LGj5CGXiphLldZaYa+TwYyalF0dXxqlQ++A7S6heGYhJDaCmt0552PkHPdVorZW6G2xGwSz5uMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774202799; c=relaxed/simple;
	bh=8YGSn68+grCXEVhp7ZRfZyQf2ni2/C2+SeFlQxfX/Ok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OGIYEVpE/vl7KENKPz0HDI+5Se6mL/elAKqsbTAVakU1MvVDg39pMOhF7sfxsX/l5MFLQnxZJIzq1nIhVp712zB0uUJs+tpvqkbNWv3mB0WRIaZPLfKcohqdye+6pg0XjEdP0HeLB/iueoBP1pBxvN4jFA8kw8IvCdc5upYVUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aAxPB6Ex; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=myEqC1MO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aAxPB6Ex";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="myEqC1MO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2828CEC0108;
	Sun, 22 Mar 2026 14:06:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 22 Mar 2026 14:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774202797; x=1774289197; bh=+h+TVvybxC
	iyrSpbBrvao6L+v/U2+kqtJADQeQkpaeo=; b=aAxPB6ExCqIIiZrCnAp2+85OfF
	5WomXDVYVZvSf/e4LCG1v1SbRmHJTQt35IbUj86I/taDfKK7C+baUIur2ExUPI1X
	Cy0ZNY1oFtphIJE2+fkzg70r2frTj3mL8ZqbKrB5zNZ14fjb1PqhVGKwd75NEjwI
	clYPi7lb5XRl71qZ8Y4RQqTTuBnZ0GmKB3C5AILJEmyJqnnV35be15jLV9dDmFSi
	JFrRvJ/1grpdJII02TDAbD0h7k76sVH0c+is8FoDLr2n6/FOOS7pAcanzaXgbxQ4
	C7YBkd+qe5Le9FCTjOSYMsjUW0ueGInSYNd00YPts0+DGsdd+rT062idpBcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774202797; x=1774289197; bh=+h+TVvybxCiyrSpbBrvao6L+v/U2+kqtJAD
	QeQkpaeo=; b=myEqC1MOq6S3QtvMbPNyohCqTyMBX1eZBC8qQ312CCNEyFNE4iL
	Fns0IsyipmRU0orN6wrXeBNbhcoQmgxZFqSVZ7+N3qdXeaS6we8gdpsBPKtoOBQB
	ZzmGr9dfzaEduDaTRTzK9LQa7q1g86xXRUQDb6BpSEkv2pzBotuykYbB9412VXn6
	Cow6PsztKCBNsWNwMI1dcV7+aLtoglldVji87TrkVgsnHnSCSxQU0x7wb+/tFaH+
	G/CzMZ72VmitJRi35sAWEYz2axEqrztM9I6/fFkgQP35JUWaA2gdpkCGAnewzIx3
	zwNORaOuf+Ao9E1k4HZGrIoHP+mR1S9AOxg==
X-ME-Sender: <xms:rC_AaZfVtIKyNzSQWhBst7C8Yt5YulqO3fMu0HLgzS4GzzDcqD8Vqg>
    <xme:rC_Aaa7cie-4hm6NbiAB4nEz1QBlgJLrxI85g0ErcpdalHWakA_t5mh_oST_En0Dk
    3WjXCxTHS2uLTrZ0saS3B4FFF-7bFUVOlUrl7NN0k4iYrbqq7EP5Q>
X-ME-Received: <xmr:rC_AacWkInf4EXEfejtmxrnJMjRZhjebPfYEEFHtvTihOhdRfJjVqbyLbSOwZtHIqFagf6vpo4atqJWtbrrG8sJZWZCyqN0P9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeigeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehrrdhsihguughhrghrthhhrdhshhhrihhmrghlihesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rC_AaZ6VUnlcz70GpjppC1yIa7NPQqEzNdaiQmTUV9GMNMyXTJuTWA>
    <xmx:rC_AaXp3szKLoT1LEk59QOxzWpn-UC0ax-ybTkNaud8OsyQBDO1pIw>
    <xmx:rC_AacmZaVNk8fxcdveYe6t-wjkulrPiK9ibnrdvZpmolQk-ZUOwNg>
    <xmx:rC_AaTOHdYVbyVFfb1B6rDhxejOOmmoAYTwHl8tqU696VTFFEujGIg>
    <xmx:rS_AaSB49SUVB3i2ATXTxRKWD66KfnOuHjGfrSh9um8r_tileqco8w9i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 14:06:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
  git@vger.kernel.org,  ps@pks.im,  stolee@gmail.com
Subject: Re: [PATCH v3] backfill: handle unexpected arguments
In-Reply-To: <45a949f3-8b90-4046-995f-da1df265abfe@gmail.com> (Phillip Wood's
	message of "Sun, 22 Mar 2026 16:38:03 +0000")
References: <xmqqfr5sacps.fsf@gitster.g>
	<20260322053207.60992-1-r.siddharth.shrimali@gmail.com>
	<45a949f3-8b90-4046-995f-da1df265abfe@gmail.com>
Date: Sun, 22 Mar 2026 11:06:35 -0700
Message-ID: <xmqqa4vz91sk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +test_expect_success 'backfill rejects unexpected arguments' '
>> +	test_must_fail git -C backfill1 backfill unexpected-arg >err 2>&1 &&
>> +	grep "unknown argument .*unexpected-arg" err &&
>> +	! grep "Minimum number of objects" err
>
> Using test_grep would make test failures easier to debug as it prints a 
> diagnostic message if it fails. Note that "! grep" should become 
> "test_grep !" to ensure the diagnostic message is printed when the 
> expression matches.
>
> Thanks

Great suggestion.  Thanks.
