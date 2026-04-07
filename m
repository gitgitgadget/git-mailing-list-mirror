Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580938AC84
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572174; cv=none; b=XB0xyqRKSTUZR7omqIvzbyOu/U59y4KbCVSib8oLlw0z4WTef5Ru2ey0D/Rq5hJwMLm5YBisZNEUmF5RvYuDHJQY+FJvGJEWcY7z2GWsnHjE9+/+mwkbEN/KQYtHJA3JA3M/KN4N8SqC+pfieZ+kL5JdTp8jsVnKAG3gFYsdBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572174; c=relaxed/simple;
	bh=gH7Uvkv4LqVU9u/MNW28CXT5VgV6S9A6r9JLYsffOd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OspOHFowCexWij5qYjBiM1B4B5Ltdq4YoMRyM4/adH65qsTzCh/S/zy24rRveIZOLzoULr0t+Xj/N/07u34Aa44bkaWWsrgd9b+84mYQZxEGdldR6KdqDRpEN/y3vuyoPPc5l5hgmzO8GkXEA9DGp2trltV30NMVPpSDmlPaXRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xEKYmRNP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MfMH3AMV; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xEKYmRNP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MfMH3AMV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6039D14001EC;
	Tue,  7 Apr 2026 10:29:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 07 Apr 2026 10:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775572172; x=1775658572; bh=4XX/B0CVS7
	b63EQvzsf7oAP3D+ePTftcjQOhoMK/36E=; b=xEKYmRNPVMtO5Bz7KgyzfUOb4m
	o84TqjXlq9E1cUoQXhMiCZ4a5Oq4xBW4uO+teDqCaFF98Oxu2C2vwN+cE28Dy7wo
	fkYYI4I933aKJOC5vOanS/wzWRqMlBfcdHVkpJ5WFxXwXvrqEHhhijKfx5F2g8SV
	VTpdcmRUrzJgAD1oGbGDc8IdSPvH06nu6BaxKaXQWipQppfRSROCve+2fIFGrrRQ
	BpO+ouqGhtqH66lcyXj1BdXvFeu0nN9DAYc4oOQrAebAzCBI/EbcU2wYj+27EFXl
	PvOMmcclsZV9VTzL/aVajuAVLC9NxmK+pWJHBWSViSKzaep2qpVS6MkqfDPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775572172; x=1775658572; bh=4XX/B0CVS7b63EQvzsf7oAP3D+ePTftcjQO
	hoMK/36E=; b=MfMH3AMVRw1WamQmpPSK1VhiOIGixGoSz7aE/1VMisF3oLMmB6h
	uWxwlgMElX6mBl0XMf4xTYvnbQG177x0GAn6/yALJ8hr9KQQf6YnAZKEF94UNQK5
	dKCJNXNHKXgnF/sMXSBbsMwLF6aPraFae74tH6vSnxgS+zdovTdHzz9ts5dHmffl
	LMvhHwgmImV9zoJbEaBItLaTZVHiu5nqZtFFg/KRLo6vw2Mnb6MmVRj9doHlG7Ru
	yfvAZf6sr8pPL30hDK/oohIoDv9pq+lVehpk8CAZ67ZcEF5INAdoUoETyW5D98hW
	pRY4TtuFVauATgdgdJPRd03I6e4jKfvmVIg==
X-ME-Sender: <xms:zBTVaTJ7_0qo5PmkqHVAI8eQufwhCBXflgTpmdK4zz6gyS3eyz6fgQ>
    <xme:zBTVaeBGu4BGeZaSnaGrB8gj3pMeN9zBk6UhV9Zjoy6HsvLI7dheKEbk0Wd8glfmL
    scMxwTnCNbA73-319IeiyaFDkOYpH6igntY3sNkTJJCJmCy36VhLA>
X-ME-Received: <xmr:zBTVaUAA_Up3I66tAjh1FD-6s3uW0iZRlEmSD5nZMDRntfmBkd9NFeCfuN9_ljLmEqSkhLkQKmv1Wgts_uLPJ0fffZgyLIgC5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeiirghkrghrihihrghhrghlihdutddtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrth
    esmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zBTVaYDFk3ycOy0yHGL1C0mfNE9CLKKsnmjCu9T8NtQRNQa6BFAi6A>
    <xmx:zBTVaXrUcRWVOcp6JJSd-TZoq6fI7W6YjEpNPFaEw60etAjbuCLXbg>
    <xmx:zBTVaalt0RYb7VdxuVwJbwx2CYTQKiBbunpB_zpSR2lf7eQ4YOQzWw>
    <xmx:zBTVafzOtttzJD_ep8NzjxxloZ4KIs5bKyvkvAbVpfVTF4873fVO2g>
    <xmx:zBTVaRQhb2uWQUH2kkCkcvRyB0M-na60p8M4BJoQ-ZtSUGAcvfoTeSWJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 10:29:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Zakariyah Ali <zakariyahali100@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v5] t2000: modernize overall structure and path checks
In-Reply-To: <20260407034446.409175-1-zakariyahali100@gmail.com> (Zakariyah
	Ali's message of "Tue, 7 Apr 2026 04:44:46 +0100")
References: <20260405011135.125912-1-zakariyahali100@gmail.com>
	<20260407034446.409175-1-zakariyahali100@gmail.com>
Date: Tue, 07 Apr 2026 07:29:30 -0700
Message-ID: <xmqqmrze7sj9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zakariyah Ali <zakariyahali100@gmail.com> writes:

> This test script that dates back to 2005 certainly shows its age and
> both its style and the way the tests are laid out do not match the
> modern standard. Modernize it to match the current testing standards:
> ...

How does this relate to d8e34f97 (t2000: modernise overall
structure, 2026-03-28) that was merged to 'next' at 279c41a3 (Merge
branch 'za/t2000-modernise' into next, 2026-03-31) and is now in
'master' at 0713d3b7 (Merge branch 'za/t2000-modernise', 2026-04-06)?

The topioc appeared first in the issue 2026/03 #12 of the "What's
cooking" report (Mar 30th), marked for 'next'.  Then the issue
2026/04 #01 of the report (Apr 1st) listed the topic in 'next'
slated for 'master'.  The issue 2026/03 #02 (Apr 6th) reports it is
now in 'master'.

The description of this v5 patch looks suspiciously similar, as its
patch text, so I suspect it won't apply to my tree.


