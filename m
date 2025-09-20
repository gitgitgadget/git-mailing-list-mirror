Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185551FF7B3
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758408766; cv=none; b=LGe0nohN63+q9q+ngGuWHkwaDvJdElx2RM6N81N2Sp6/9iaXKT6B7utpTF4eJx5qblBgx3twZ0b0HZm8qrzhnMPoylVgeQmNZ8Wn/kgvye2vDByhXikG5DmdzplmfMo6QMjfKjgYHpzbo7hhSdtxuBzlJkpXfgDdW1nri4tQCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758408766; c=relaxed/simple;
	bh=puAWqEBvVriOpI+EmpI38K+t7Qk6SyGCLWooBhtPs4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hhkrdK/OGsCYQCCv4L+O9Uvp13bclKUkY107sNYn2JyTV+UB0eFHQSbminq2z0OSVbB3361g0F4VyHU+wLOmATTRt9HpDxjCphyL/xLSqvxdNbtDHtNMGAMAm6yoBOCaJuj+TBh8yq0vmfX7Jge3fSkz2ocu3DKBwqX92A2gKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DUJqagpX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RDz7vKI+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DUJqagpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDz7vKI+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DAE2F1D00091;
	Sat, 20 Sep 2025 18:52:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 20 Sep 2025 18:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758408762; x=1758495162; bh=jnTydxWuya
	5YQeyR1Xi4U336k37HqfLS/t46SIJzepY=; b=DUJqagpXPFwu2H1jfhP8NKfnrm
	fyo4FfgIOi5XZ1HrhEIHI2JsGnl2vGj+rESOZlH/JusaoYXNkEWa194E2ykdFuh4
	vhxJD45P0CY2uiH7HkiEJIS+oY/xL3E+kYttqPh1fWX8i632T2cdH9/3LwRNAfX3
	Q7LROUiK1D+q43hvuMQTdfTtTclH+7ZRsRMW2ApvV6MbaNc5ZfVHeyZgtA9Q2WfZ
	RYllf6z5yj5USVeYoM1Vuhx2derSy+sQ6jBaJe0EU4OvSqAcsDIaoeYKq3U6lDyq
	EMIyWbiW0XF0RmeA73k1HzlVosff8YAH5fSc88oUDBpZOdJJVOzT6W2UreYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758408762; x=1758495162; bh=jnTydxWuya5YQeyR1Xi4U336k37HqfLS/t4
	6SIJzepY=; b=RDz7vKI+lSvhbZCzkrXHK3U1TXUcVYv2cV5yyn/7yomHsOd7nOF
	v2at9qK7FS7BkEbEx+BLUxyL+rdB0g5UW73h7wnvEzw+rn9H9uy1Iff73XuuSKPD
	ePARTrmYGUFadZhaQwmIUya6AaRKmndpLlYGnAo02KU0UF7Kno1+vXugcT90uR+n
	2zYIUg1DcY53DmXSdIdsK3x5hnJ+zTDirPQ+IEiPmeToGvdhMNMRBMvMn0U66j2j
	bEyWdAHvb/564scX8VmmWoPmxfj9s9rIm0JsU5AX+L6c3/mioSVoLsEr393M/TM8
	h1eLm0thM/40B2rbJedPs/4mAHKAywtzAeQ==
X-ME-Sender: <xms:OjDPaAV7rd0MoI1bBGD0Mn3VhEMwbuE-KMfLFriC0y5RoSjTGGkRDA>
    <xme:OjDPaBidjJHWitdgtNSalvoSH6bh3spkx_5FQif183AjCHDVUvRE7kRrJZWMkySW_
    QU2fUl7j7b3sNutqg>
X-ME-Received: <xmr:OjDPaACRC2We_Iy5sUl6qP1aQ5jVDxDt2RfI-NTj77fJOfFJ9Eqwd960B69Tso6WbSXeSie2jMVPQaJcO_fqZuz_w8XJLZuL7AnB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehfeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OjDPaHtLcT4U5Wia7DNxjSFjIicE_COCG10C2VIfKxWYJZVNm1mQqw>
    <xmx:OjDPaEejKYDeMN0_n-Q0l6A7CwaftpumcIJTbH8W3iF6x7s_bjIuYg>
    <xmx:OjDPaM-fo5Qd4Hy37jiTwpXw8kvhLZ-Tz8yITvV6PRxxr_gIyLnb9w>
    <xmx:OjDPaHTlxlJUlyhNroA3zGnyhlqNOJ-GH1vu6G6EIa3bOJsmHnvt5g>
    <xmx:OjDPaBJkZRwlp84Lk6CfK9qXCYHdUUVhqxB1_4fKj91j4h0cZ5uYiYWf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 18:52:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ben Knoble <ben.knoble@gmail.com>,  Ezekiel Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Ezekiel
 Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 01/10] xdiff: delete static forward declarations in
 xprepare
In-Reply-To: <20250920184638.GA1010995@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 20 Sep 2025 14:46:38 -0400")
References: <xmqqh5wxxcwq.fsf@gitster.g>
	<83F61517-06DB-402E-911A-E33EE07D54AE@gmail.com>
	<20250920184638.GA1010995@coredump.intra.peff.net>
Date: Sat, 20 Sep 2025 15:52:41 -0700
Message-ID: <xmqqy0q8wxc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I don't think I've ever used a trailer like that, but I do sometimes
> mention it in prose. I'll sometimes put it in comments below the "---"
> line, though.

Yeah, I am on the fence between in prose and below the three-dash
line, as unlike other comments that often help only those during
review (e.g., what is different relative to the previous round),
this hint is helpful to those who read "git log -p".

> PS I sometimes find:
>
>      git log --format='%(trailers:only,keyonly)' |
>      sort | uniq -c | sort -rn
>
>    amusing to look through for this sort of thing.

The top entries are as expecte (this is with --since=5.years)

  24336 Signed-off-by
  17501 
    740 Helped-by
    703 Reviewed-by
    495 Acked-by
    485 Reported-by
    420 Mentored-by
    186 Co-authored-by
    164 Suggested-by

but I have to wonder what the empty one is.
