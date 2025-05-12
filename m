Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA82522A5
	for <git@vger.kernel.org>; Mon, 12 May 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747089728; cv=none; b=hBUMoVjAHWVdeEP4WZVwSkoVj8z1wwr8Va2bT1ziLamFtJ9s/gT/smGH6j//1rGLotPHddNR/deF9OHDfq8fHspzojt8lx13Jt4W65P/DGu+d5n5Bhsp/DQMO5LTheunEQCipoC8JsTjEiEAPBP4eItru+8F5RnE7LEkmLJdH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747089728; c=relaxed/simple;
	bh=VmFRgtL1IIr3IDkpv9TmPYUeMmQBrEmJsMFH//uWuEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bzMpwk6N2+LBITuoaI2ATBplsB34sl0DChKgHIUNEpnrQURadkPg/j/WxHisv+35PYiw2F66UC8FCIwGu0fNe9U7WOQlg1EGgy0E6tUrvPkAERQh+DC0L3FnefNKL2PUjUuRiPcHCZRJeCwMbTbaXnv/O++W2+T3b98kYSWFGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d/D1p0yt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JAf3H2OH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d/D1p0yt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAf3H2OH"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A276C11400DF;
	Mon, 12 May 2025 18:42:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 12 May 2025 18:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747089724; x=1747176124; bh=zpGUREuze6
	n/nQHI6TKfAgIGFNTwM9sQWopYI61Fsnk=; b=d/D1p0ytH+wYpG14e1pogMpr5E
	ZbhFcShcTp9lIbRSYbq5WX8b6/T1kWmfdHTOTuFtt6RqrJ+XAv+/uRplsJgzXld3
	sp75o24XWnU+fUw2zRZY+fYm+l0EFWQHVQHSLY81744t8FQejYOUPmvG75IfMhNE
	8MreQhwkpAE8yd4ta3F4S+YmU8ibL+KQ0p2kP5g2vhMPW4cOQBbVQ2YgXF0/RaQw
	Rnw7VMmr/fOjJVLTHsPTYbgOm5aEM3hzyYuzaJpJX4o7Ue4vU/gar2chwDzhFIZz
	JlQloaUA1qHRoAFtlFG/OzF9tuyudBQ+cbGAd7C05cAFmrBLg+2WDp1ZaFow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747089724; x=1747176124; bh=zpGUREuze6n/nQHI6TKfAgIGFNTwM9sQWop
	YI61Fsnk=; b=JAf3H2OHBsAyTBtFdmvJaHlYoo3oxl3Lc89QOY0UO4fO6/SZd8e
	74Ww++gCVVhZ0/Ug1o4HWKA3E1dN7r3bCm8iCopipLvojUSeTkyaAO+M7IcC+bn8
	eepAVMDueZZ5dQaQ6MvfNNYY+IQCR9cCE6EYJGHJWdchYp/F7E5UHvR+sXsi3IYJ
	KCiNQeYCHcV/EW3Oyx4dteRVSdQoTGWvXHHFePMhTaWJomR5qrK8tDB1WB6USRI4
	QWPc4EcFy+u9ez2gd/wpTofyA1GWpkg3ds3MOWDdpC2LF5zEqdUS50o6NmWack55
	tEGnRY+32NqPjTX4SNYtnuEdBrlrFMm7Y6w==
X-ME-Sender: <xms:PHkiaJa2YuP7pR7yyxaT8R69r_O0IGqKRwxE-BCcOWf7xwEI9ZAv0A>
    <xme:PHkiaAaeUC_PVUlTW5cJxArJnNNOukRxbJ2tOrUpAxFvMNb0NiCqawPjPnZpPUEKW
    xwbjw6MIIV-ZWkNIg>
X-ME-Received: <xmr:PHkiaL8ENWyodFfnse97CRTbYEVL6HTUbRhjfzvutGGohuAbQn0m5hiQ1UVNlZ2ibTmm0N4vpLoIji2bsR2LabV6sXfSKhG4hJTWEEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PHkiaHoLzvuif5vAaF2TWVuUmOtoJOTOMgr4tRgnzyOvXA6FX1bGtg>
    <xmx:PHkiaEpDxvETkTDu8OpzmX8lLVN7bRTqgO8Mo8b6gfU50K78dGZaqw>
    <xmx:PHkiaNS-_cYOW4xc0hfW01tAJ3RIYpNjKRGM-U1dgAGVRKmycNshmQ>
    <xmx:PHkiaMpJium06G_r3cDkF6a7euJ_I0FOV11XqTZCuz8V2NUAuy1AWg>
    <xmx:PHkiaEGNBQ_C-e8PeyfuCxfjO0d6jX-vWSid5zKSaUxnqQKfcvyzxk9d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 18:42:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Nominating "whatchanged" for removal
In-Reply-To: <CABPp-BGUAyRWsnRc+rrsBfPg4hzAoKPMBiD0aH4jxwdO4mEk0w@mail.gmail.com>
	(Elijah Newren's message of "Mon, 12 May 2025 14:21:33 -0700")
References: <20250503005814.3030099-1-gitster@pobox.com>
	<20250512190311.1451556-1-gitster@pobox.com>
	<CABPp-BGUAyRWsnRc+rrsBfPg4hzAoKPMBiD0aH4jxwdO4mEk0w@mail.gmail.com>
Date: Mon, 12 May 2025 15:42:02 -0700
Message-ID: <xmqqbjrxjvt1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> The updates to patches 1-3 and patch 6 all look good, but...
>
>> 4:  2775f628c3 = 4:  01d4ed9acd whatchanged: require --i-still-use-this
>> 5:  b3d4d1f46a = 5:  a7aca55d5d whatchanged: remove when built with WITH_BREAKING_CHANGES
>
> ...I was surprised to see no changes to either patches 4 or 5.  While
> I didn't comment on those patches myself, Patrick did (and since he
> already called out the missing word I also noticed, I just didn't call
> it out again).

The meson stuff did not exist in the codebase the topic was based
on, so it won't be squashed into any of these individual patches,
but if you take a look at

    $ git show seen^{/^Merge.branch..jc/you-still}

using any of the recent tip of 'seen', you'll see these changes
applied as an evil merge to adjust the topic to an updated meson
machinery in the more recent codebase.

For other changes, "developped" was already fixed, but "the command
was retained" was missed, so I'll locally amend.

Thanks.


