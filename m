Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD5A1EA65
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759348846; cv=none; b=Ndf7JZTUxp3nrqbdoOBr8U8Bpu9rb6M3uDy21DyA5VUpZyqN/OWBhuV7XeK1iI2SJAQNxhU0P/29O9mFzMt8vBIRYihobJw9zMxTsJh8wRbXBbduTOmT8dIhkJpXM/nPbmlo/HyE/udSg/uhzOGnrKGxHCND3TuqhO4Btb2V1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759348846; c=relaxed/simple;
	bh=qT/y37cqZi8tfAqxROfaapo5QdiE0ILud2sNl9TiPBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kvd2cGQBbXZSG36xSz9+Bf+o6zXasOkPbGNLTKI0IdWFgcaFyhVsslJ7892MKXvjJl0rrXYpt1ZWO0cBqfKkwW2igIVNQ2Vf1nK9vqJVA/UokBidc/54w15JXglSK6/G0HxBcBupWwRrk2HpC47Dn7zyxAWmpzzxcGAbW4jh8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FZMLgteZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g3AHziwB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FZMLgteZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g3AHziwB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CE7071D0082B;
	Wed,  1 Oct 2025 16:00:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 16:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759348842; x=1759435242; bh=6zM+wOsPMz
	bAzmrzoewa1Rf0LVquf4I7GafJMhmGDtI=; b=FZMLgteZbMtzc2PDw7XX2spHYq
	5DPG4urCxznaZt1u4AvPVyCRtwHhEF6hoHXQPGaOWdL2nwgjxivN1Y+YXYQPkVMm
	cGNu5imkCUslIiMFzDftPrfTmN6koPOv+n2MJSlP6/V3nsTvUjSLIDscJwQmddH8
	59Ezu4GyUIPbxLtwb7TVkcWaVMSMlnHtlvT7AcwfGgfTbz8qp3+Yt4/RY4ODXAms
	AdguYaX74jC6BtTpaD6qsoLj05HwHvb5kK04LKqh0qO57npX1dByzU1fpDflehzz
	nnDuQkoig1W9dQN/G5mepncxiMtnWtG1OnV4BX7LYNJzUNcZX++7Laepzufg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759348842; x=1759435242; bh=6zM+wOsPMzbAzmrzoewa1Rf0LVquf4I7Gaf
	JMhmGDtI=; b=g3AHziwBOCCyP91/kM0QG0yBHWo4XtPwO3TR1cb9de2nR8HrFh3
	iyWhqq+2IZI9qjJ+eTHVmIMXZM/N2YzF8r2BfNBEnKRlm+D/7Ma6f3lPcZRdwZ2P
	jBTBxDUITkcRoqhjukSmnoAtt80FaUGAeW+gmoOlstB48RyVuFBU7YvJdotg+kt9
	lVQqh3SVGkdGZH1IWhrX0oCX3aVBzMS1Ujq3pOmXrBa9mW9/utaep63IjhztP9A8
	eG/30qcrFrZQj9v/FTgNJrK6GmYjUeoS7EEP/sKN8WFxSYn+vhwFH09Vi0tKGEYc
	vY3W8hJQC/N8+i2vNh2d5wuDBZyzaL5LkLA==
X-ME-Sender: <xms:aojdaNGtq_j30Sj2nEa_BixjbFQDpLhJJhnFa34jqlWVmWjW9JYTXQ>
    <xme:aojdaJWIHf2V76fV23JjZ4cOchqXoDY6DtwGTmWCCGt9KDA70iWg0q21krAM47s_6
    6xfehMHItECa5Xu0e2F9ZwRU31JHFjYv1r9IQkNSNGDaX_7-eHBeA>
X-ME-Received: <xmr:aojdaEITj9uaPSpKw7ujLrU5WwuyWkngFlHCaQObRs7qoIBIWE6ky8QSp8qmYJSxj2luDcquVuwVgGwqS9w6um2LVOJRZC3t__Ed>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aojdaB-NMN0ugLZnFCtTTRnntP9pLoKJPzLqDsTCSHNW5FvtrbCKSw>
    <xmx:aojdaPIlS3Q04emvM8sd63U-LRME-LJ0k-mSKs9JNM9NR57YWcHVRw>
    <xmx:aojdaOnhxC2pq98f4qZRzjrKGO63GVS78hHQ2BPlD-qr6KzL49eiWA>
    <xmx:aojdaLOZgjhk18EQ024oR_pHt4YEi-W1ykBDsb5x_vyo3jbPXLfg6A>
    <xmx:aojdaNbPTQRPA3r30q3Djx_78ne4mcqrdiPxqTrNRfUnksxKVbiidh6c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 16:00:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
In-Reply-To: <aNsVT_OWOCAB3fzO@pks.im> (Patrick Steinhardt's message of "Tue,
	30 Sep 2025 01:25:03 +0200")
References: <xmqqldm0am4b.fsf@gitster.g> <aNhX9AJ/zq4IYhmW@nand.local>
	<xmqqseg777k8.fsf@gitster.g> <aNsG5Jd_YLgrwarI@pks.im>
	<xmqqqzvo6fmw.fsf@gitster.g> <aNsVT_OWOCAB3fzO@pks.im>
Date: Wed, 01 Oct 2025 13:00:40 -0700
Message-ID: <xmqqjz1e1jfb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 29, 2025 at 03:46:47PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > Despite the potential awkwardness I have to wonder whether this would
>> > even help us with the goal to speed up the overall process. To me it
>> > rather feels like there's another step now that a patch series has to go
>> > through, so my naive expectation is that it will rather slow the process
>> > down even more.
>> >
>> > Am I missing something?
>> 
>> The above is an effort to reduce the chance/risk that the maintainer
>> is *not* made aware of the fact that a topic has already been well
>> reviewed, or the latest reroll has addressed all the issues
>> previously have pointed out and the reviewers are happy with its
>> shape, and ready to be merged to 'next', just left in 'seen' labeled
>> with "Will merge to 'next'?", etc.
>
> Ah, okay, that makes more sense then. So basically, reviewers should
> more explicitly state their overall opinion on a patch series so that it
> becomes easier for you to figure out the current state at a glance?

If they did so, it may reduce the time a topic wastes in limbo,
waiting for me to notice that it is ready.  What I do not know is if
such an additional burden on reviewers would slow us down overall.

Thanks.
