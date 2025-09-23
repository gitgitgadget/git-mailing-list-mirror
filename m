Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2814A09C
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638081; cv=none; b=ihPPOXDGTCTPSOsE/pugIngRDDoGnXprgNODlpsUf6UcSSdn44SPL88VfEXlJ5t8ERp9IW8yTKLCSUY5rSArEHqzT9/KndElJKSorHpLReJwhDASFEAVURjdkw5OhVNe6EDMBBuhzoiJ8rdKPzaJVKJzmXQmfyUhiKQivscKpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638081; c=relaxed/simple;
	bh=gdAWMP56+nH9L7ptGl+1D6nGZcbUydRlCe0A1ct4I38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Afy5sOS+62dGJd8HzE9nggZ8V3GBimk9tbCQoRgdaHf3UOBywbjenXJYTCVQGNfXh6yTriZhrc3fRu9WWKVsq2v+S3J3U92ZJ7tldVCRYJr9otBgFoefZD0FzK2DM1oSqFLOdjuLjXJH+R013aLiy5qQt4tnlahfFAIH20fyqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YiI/H5U9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WeTW2X/D; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YiI/H5U9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WeTW2X/D"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D7AFA1D00152;
	Tue, 23 Sep 2025 10:34:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 23 Sep 2025 10:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758638078; x=1758724478; bh=Vmkp7GWOl1
	ajtrzOMyK/67XixHdv+bx7+nG/HxyY2bg=; b=YiI/H5U9hWfbFv4BDje1RLBACX
	gBAw5vbzphCFY61MIx2YR2VfUj6+BRO7JUm5KI3PO+O4hw3xgQFvXCkzaDnMezqC
	CIkET7nkcsYQRi+U0Nqff6zrtdiDLnMslvUxZF+XsTAZebXhKdsHliU3ooIV5TXo
	Bc8gnGCeJNpFLueX8Jmom8b2JdRta/MC/Cx/eeHhrDYa/iavaoixUWHSDZdPcYLc
	Fez4BPyMA2J0xlWfteoYMqhQ91igptfVlTRTRznAxRSVtzmdGsd0sS2fHPb3sX7L
	EMlfVoYGtolkOYi9rHzU5oTFb2VYWpCoVSkJdWBsrdPHlRgn89EyklRjJnkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758638078; x=1758724478; bh=Vmkp7GWOl1ajtrzOMyK/67XixHdv+bx7+nG
	/HxyY2bg=; b=WeTW2X/DiQeqGtELxg7DCpZXnkDn7B5592FqG3mCiSgpTr6LHMv
	sLk9sIZ3R5uGC7BqtaNBtD0qnCYzdyWsAKCtmxrhjNexHbUFQDZXDFIvvLlqXgg6
	I57itena3+d1WfWiUTrW2X5cPr6inW3xy5FpZBPS/yIPOmIiLLZYWd7kVUgGb+cv
	TPudMKrlfTY7YKKcjmNW5C3uDHS/OzH5pJDkrdVkVWQJlrMnIf9HZ3htUjucpLAm
	Xjfx6xV0sZfOtvhK3YxkWb4YZj0XGUjG6cx37dEgh/8UUxMOLHW/IKipsJmvWKY9
	jydWT7JkNJ7thHPnRnyXpj8hP9gI9PmDq1Q==
X-ME-Sender: <xms:_q_SaG3UVJpoFfUg4a7EPFp1cL-fu94hpAY6fNml4qN_cx78XDa2yQ>
    <xme:_q_SaAhYRvksXxtm8FbtbmLNA-jIHEoD4_g2E0c0cJ_QusOpx-3O3elZHblAh2iv6
    f5fDbYO_ONXAFmFSDRoW4IGQU-PDk3jKPJFXjfp9w8Ea5bVXRV_tw>
X-ME-Received: <xmr:_q_SaMSz6KGVYbKpbIxB2vFPhzfKKd5n6YPXVXCoCUnJEC5Oqw4zhEOCpGejJMhhnSM9PWlGyTz1-X-tWINuCHQ5qhThaFY5uYJj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:_q_SaBgmEZvSaYh6JaIvcW0qaCrtNe2ibySU47cEBqY3W8ZaF5Kz1Q>
    <xmx:_q_SaM5DCMdo8TaJIzxTmoi9HsF5JDQBdO0DBZrG-jteTNRqs_PL5w>
    <xmx:_q_SaOBz6Vusw8KRT-0Tr5BTbYUNIe0EQVO7AIgHOMvI010QE4i71A>
    <xmx:_q_SaDag1GCSW0IBB_mlKrhluUSBTZPYSHho8g4ZDNlnNACnc7GiMA>
    <xmx:_q_SaApq9o4h46X6meR8zXMXRgm8e9pZmn_JMd3MdEpfGtUr7K2t735A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 10:34:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #09; Mon, 22)
In-Reply-To: <aNJPTrPHA-xd12p6@pks.im> (Patrick Steinhardt's message of "Tue,
	23 Sep 2025 09:42:06 +0200")
References: <xmqqldm6qehe.fsf@gitster.g> <aNJPTrPHA-xd12p6@pks.im>
Date: Tue, 23 Sep 2025 07:34:36 -0700
Message-ID: <xmqqms6lp79f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 22, 2025 at 04:01:01PM -0700, Junio C Hamano wrote:
>> * ps/odb-clean-stale-wrappers (2025-09-10) 1 commit
>>  - odb: drop deprecated wrapper functions
>> 
>>  Code clean-up.
>> 
>>  Breaks build when merged to 'seen'.
>>  cf. <20250910153759.GA562601@coredump.intra.peff.net>
>>  source: <20250910-b4-pks-odb-drop-wrappers-v1-1-6ed660cb1eec@pks.im>
>
> With the evil merge this that adds the missing "repository.h" header
> this status is now out-of-date, right? Is there anything else I can do
> to get the topic rolling again?

Yeah, my mistake.  Let's mark it for 'next'.

Thanks.
