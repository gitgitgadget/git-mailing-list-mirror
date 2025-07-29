Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4101F91C8
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 05:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753765332; cv=none; b=TErkptORxbrr1Ck0hDDKKGo+ogZIa4pP5T4u0d/tlv8fMXfwukDdQDga0HXp3pbyVcDrjxgEY+w5nORV+So882rjgZ+not3s0hvFJ0m72AGkljQoKq1FLPoDz0OFKwCl1AM3dwTumOJ8CPFErWcwFep68XY5f33TmCE8LFRHQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753765332; c=relaxed/simple;
	bh=cQLw+0SmLEBalnipzYkigMRCgDz6Ro4KihT49chibAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AlzJPENvWugLCoQSpTni8hTKnZ3maOyNwv1ILnJKcmsxr3o7Oo7/IqwK4tty8AXXZvFflm5rAW+I+B8qgGeYfvt9wofNLmDLFTjeh80lJvhkJzIeqMnxvzqqkj8SB1MRu8JQfr0locT04TmfL3AmwYaSe8n9Ohv56tL6XPHwgBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NUbiIp5e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OraxM93+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NUbiIp5e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OraxM93+"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 04D78EC01DE;
	Tue, 29 Jul 2025 01:02:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 29 Jul 2025 01:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753765329;
	 x=1753851729; bh=e+KlOtuyEx15mNaJiAIHz+KFWvFVxBej+BvBiWFnY3Y=; b=
	NUbiIp5e0UZCy9OGdVeedjdMav80owqPQSs8Q/cHMoIM/SdhKHVG5HnoukdQa+24
	ssJnS655Iibjot03xhUXHMd2QGr0fyPDw+F3T2n5Om8Skv8J686t31r1Vem0rZrE
	WWmtXFoP4Gwo4U7tWKgyC/tGEm0dKNXaOj8FxdqWUQ1tvkQdgJKGa9jgu4muW+jO
	G2ugrsawkGeCYFqYZJ3AnO3ORI8yjsDQL5xd0FGMDNCch9cCwkuOxb/UbktYNdP6
	b1X9w7xVrreK3RRuJsC5p0ksKdj+GenLb8X09WULJkF3XQjyUdqUh6iRi1F3TltA
	zzPhm1wIWlivCC3a20hzqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753765329; x=
	1753851729; bh=e+KlOtuyEx15mNaJiAIHz+KFWvFVxBej+BvBiWFnY3Y=; b=O
	raxM93+zuriZblYsSQVpf3Lxi38dDzJS938wqQpoVKUQJRdBmVzEUZV06zrcdPcr
	CCEj6YiF5TI8mqQQEdKQpm0ibAML4gnC2EKxE46jLf2ns8t/SioJvpLv6UWZaWj1
	Yj7WZyeuz/2a7qSVKsauyBI7HKZ7Viy+Frh2buS4Gpck2R4EhU11DwDS+aDSaKa8
	j1HBW6K3fB1oWZ8kZCJVefKmsez4Aq2ygijr4KWPgF/yLpKbk8/v1OYgt1WqBwaK
	eBSCCWlyMJ0JejHkf2Ujjx2LlQHK4gU5tvj3lbA62cUbGu90v+r9k9jg5Z1ZzC2Y
	Wr40+0oCcDmESkuzlHH4Q==
X-ME-Sender: <xms:0FWIaOd8s-2VZGmshlPVOPBDtSRPT-ll_Ly6MppgFzgPeQU5s5Z-tg>
    <xme:0FWIaCzGgVw2MqNi-MqPEc5JiViX8JCERI3TtHAYU0U8GI3x7PSZnwgC0IZFdkgsA
    t7LtqKvvB_fevTZCA>
X-ME-Received: <xmr:0FWIaMH2_KyWM8ioW6cvkH4t7bxthdI0_iyTEJIA3vm9vh967-JOZUsVaeJFshLKzRxTEad7TmXX7xOZ3vPVyFu9x5dpQUYqmCtHCh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrnhihrghnghdrthhonhihsegshihtvggurghntg
    gvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:0FWIaOyrk3L36DTwvGJ248tNvnCXpktgsSAYPli5Q9yyfc9l6D6Dhg>
    <xmx:0FWIaFuJfOnBfgYLXeLQxYuWMzo3DmjH1e4MLNAUtKW2WBlHp2Z_jw>
    <xmx:0FWIaD1RPV_xO-XuCSLK4WTqQEjGpY8OA0p-dnTVqvd8JsxDNBuz8Q>
    <xmx:0FWIaI9LgYlX0rH8rMz_dLS8PMbeD6PdEx85c33-8Q7ZSqkZu3M69w>
    <xmx:0FWIaJrqu5dUsI1rR4JhqBfhQ3l49kA32TNk0ovfVRoxEjLK0ZZhdy1_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 01:02:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [External] Re: [PATCH] blame: remove parameter detailed in
 get_commit_info()
In-Reply-To: <CAG1j3zHPU_moH51O4i97c7ofuGWiRKunZmtZe2OUAKqAXAKg0g@mail.gmail.com>
	(Han Young's message of "Tue, 29 Jul 2025 10:50:16 +0800")
References: <20250728035548.94277-1-hanyang.tony@bytedance.com>
	<aIcSYs7LxkJeRA-9@pks.im> <xmqq4iuwxr12.fsf@gitster.g>
	<CAG1j3zHPU_moH51O4i97c7ofuGWiRKunZmtZe2OUAKqAXAKg0g@mail.gmail.com>
Date: Mon, 28 Jul 2025 22:02:06 -0700
Message-ID: <xmqq1ppzsi7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Han Young <hanyang.tony@bytedance.com> writes:

> On Mon, Jul 28, 2025 at 11:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Is it negligible but measurable, or negligible and unmeasurable?
> On a 5000-line file with a fairly long history, running
> "git blame --porcelain FILE" for 100 times, the speedup is less
> than 1 second. Considering the total run time is 180 seconds,
> I think it could be system noise. So negligible and unmeasurable.

OK.  Sounds good.
