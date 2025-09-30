Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFB438F9C
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262734; cv=none; b=Xk6CArAliwrCZxV8uxSrHRywITBrjaW/KNtYlTF5XZJ6P10oE0CHGKvRssZPgnMYo0nJycdMCq3oXN/e1CltHSlgyg2Q35n4aPrDysnqVu8ouvlzlPBMedRpAgm7vuDm2kNgh7ThUjVahM6QQVsL1WIDacLV1/0oE4Zl+foIgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262734; c=relaxed/simple;
	bh=391+Qv0SXMvLzdJxmgnc+68B364TagFIOChiIt9tyDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I4qdepuLcDP9tBRs6VV6uVHLWNkXzxItrYk9AYeLNhgWbWVXuTD1wSlGL5Iim3Ud7Lv1ACstz1ifWeR5Z8F267QsE6F8b03W11Fct225wB4YRjkTIUfBhmCiGiaTri2a9sz3PFfY91JrT7HfMsSLbFc8KDHI1k6Nhjo8F+Rj7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PHik6URY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7amzHc6; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PHik6URY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7amzHc6"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5E6D140004B;
	Tue, 30 Sep 2025 16:05:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 30 Sep 2025 16:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759262731;
	 x=1759349131; bh=391+Qv0SXMvLzdJxmgnc+68B364TagFIOChiIt9tyDA=; b=
	PHik6URY+P9w+uOsieSAkTXISwfM5bUE8r7kcoQY91cJDC9viz3b0ouFDwJBAguK
	4WfBtyyXyZ5TrC2dLaRQKZEXrHwCsAYlYQUMGMGRImWOkeihg5bjGY5uvNjU+ewO
	n5zao5fGxgCyVvDJjsHJExsd+Da9x0OQN2cDPubhlPZxtlLzyZjoN9xXQpQvHEwP
	OLPApzjft+c/PRYcQovBAFgwy+1VcmXcB0Zg+r/CznLp2HYwb0uWIW0OeVkrVCiD
	1PJwQWTlk9h7tQEPh1+m7nBeXChEz8DY8/GWhPSuavbCoY+PvrB6WOB2tLkmfsjK
	LMTrSTijvhACGHBV2UDddg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759262731; x=
	1759349131; bh=391+Qv0SXMvLzdJxmgnc+68B364TagFIOChiIt9tyDA=; b=j
	7amzHc6sJAqn63he8j1wdcdiZQE+s+VOKuhGuc2JCiU4rvirSLHG7TFnbTJp1zIe
	qMmtWlqHgsQv5ZrlcfsX1I1ZssyUF2AACZZIGw1hwDW+1Hp++sAMqTDOakssvUBk
	4pa69Xfg2Op/vTNkzC5KDXpZ53TqGqVXkALJy0OUe8Mh79DR1YTg0jEScJv08ZlH
	MIgGAzwQC6oaNYt0YQCn1EvqlICVbUKHD3O9Rjr0BY+HtFLvvQAyKMtD/+F/eqtD
	Dj63ZWyaMtOyga4jwpQG0Ax7mPy0jLoZM+Ed+XokN8rsv1xa6+EJc+M7CKm8/NmU
	V8LZM16CLpSDtl0wD6Tyw==
X-ME-Sender: <xms:CzjcaPQjKr2urDusG0ysTevuIs7Pl2um-teHnA7KB9Kot3sXaOjS6g>
    <xme:CzjcaDVn4lZPopWWMhJCQd20jMvb6eXcw67q1g-2QOT5r8Cn2OQ4XL63AaGVPvFUC
    s0HOSJ1M-P7Ip1gPeQzmuoyJ10FnCoBWcVttfkZh0IGFJtIhWr6YCg>
X-ME-Received: <xmr:CzjcaIdkGQng0QqX5zl33BHwM49BwHZ_csFUPuLflVWQAZc4Joii4EoerD5DjeU9iC1Sj_wifLnhxcatiZxm7KO5CdVw3uZwxE9e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CzjcaPLMIXx8JS85M2Xib2LhRgsCrAc5W_hhYVFkqiC6Ww6J11tfDA>
    <xmx:CzjcaNzeHYXlHJ_6empJJX1nPd5e0vWSgrKdskUoQ-K4Mv1rVjjHrg>
    <xmx:CzjcaNtBY9CuKFzXyXPDQ3ICDNA-mtc11UnZuCZJYHdOF1Ec2YSgBg>
    <xmx:CzjcaIDIWFCuDRtC4nMGt5JDkNEYiDkaYz2DiGuEdzbV3mbofeXQnA>
    <xmx:CzjcaFVkt87jNNCfZQ1lZScWFy5Pq-90-D74teFUzWDx70bl8eYC4LyY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 16:05:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 04/13] xdiff: delete superfluous function
 xdl_get_rec() in xemit
In-Reply-To: <CAH=ZcbDjFh0wtWyU_1x-GCgzt3a0xUye+RU-LY-9rMBtVoSnTA@mail.gmail.com>
	(Ezekiel Newren's message of "Tue, 30 Sep 2025 13:35:37 -0600")
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<7d3a7e617c68cba19e6ea1195bd6d753a5795a4d.1758662670.git.gitgitgadget@gmail.com>
	<db85429d-2c89-43ec-a92e-96ad8d0049ce@app.fastmail.com>
	<CAH=ZcbDjFh0wtWyU_1x-GCgzt3a0xUye+RU-LY-9rMBtVoSnTA@mail.gmail.com>
Date: Tue, 30 Sep 2025 13:05:29 -0700
Message-ID: <xmqqh5wj4sfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Tue, Sep 30, 2025 at 7:31 AM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
>> > When xrecord_t was a linked list, and recs didn't exist, I assume this
>> > function walked the list until it found the right record. Accessing
>> > a contiguous array is so trival that this function is now superfluous.
>>
>> s/trival/trivial/
>
> I think that other than this typo this patch series is ready to be
> merged in. I would prefer that Junio fix this typo, so I don't spam
> the mailing list with such a small change.

If it is only this instance, I can "rebase -i" it away, sure.

Thanks.

