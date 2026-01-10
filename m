Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367F27E1C5
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028573; cv=none; b=nXlzWQ0kI+rmGPGWkYzRx/maAq7Cmq5kgbwFjIlaB9NX/VWsMqMl/rEYz9DAwV15s9OjpOOJgWHX7P7jAmMcVjyqC8UxlWF3DIM+zz55ttmi2BTD74q8Tu99fAMYOJBKNZ5kyNv+KzP+XUsZyKTmCUw5t+ZE0SrfGuR1n5TZ5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028573; c=relaxed/simple;
	bh=e0h208az7NAoU214ml8y3bh6+CK//g2pi5Vy11s41KI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1LJKsFm+ldi5JY5P2wpTfBBc+hoL6AXihvUbOsPnVmCp+cZ0AJkBs76FvGpKAzExDuKAj0/dhv6Mha44AinSZSZv9Tu8TUiktSXrvE+4CZw8/75HXKhGTBuqwkXui9ZWRnXkn04j2dD9Quh4GdIL6SpEIKFuIzbzAnHBKRlC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jSy4LbHu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TyLbjHGJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jSy4LbHu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TyLbjHGJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30DDF1400052;
	Sat, 10 Jan 2026 02:02:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 10 Jan 2026 02:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768028570; x=1768114970; bh=B+cCrChILE
	BFQed3rTvGpF9jZpm0DFHs6FI+xzCXE8A=; b=jSy4LbHukzI9Lkj45JY9wFwG0T
	WTPoHrikF924/GZOAVYcTXldZBZJDOBIHsgAWBOcVR+uKhg7FDupqDLLBg1JhiLy
	mjJmYF46TeJlzf8lrh+KoKrjgxJCtdS1eA9Kvn0U6QE7eBD+OGwOtcC49fzdALBk
	oRJi8ZPC0Tn5viCy5BVjfRmn4zZ3AtddxUx4gASDswburbC0cvnxPaVjqmHmVgjz
	DRAIha1VkGQ2DJvMseNSaD5JswAYSgN7Pma+rXD8nkH1OW5IuRAKan6KwSkCpQTN
	ziiA0PimibuswxUZyshkOmPnlvaxDbBPzlbxTPf+WH2VkgMvc6vCqLLW42gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768028570; x=1768114970; bh=B+cCrChILEBFQed3rTvGpF9jZpm0DFHs6FI
	+xzCXE8A=; b=TyLbjHGJfu1Y9urptMoLKa1u7zOHBE1zQtXjLV4vqvInfFw9Nyr
	8Y26gDGT6JBNUgRtTx6+n8D0by7ZksEeOlrCGf/1Ofa/b6hZqwEAldYUt64Ng3GS
	pZtcVNp+rMDg9zR7H+Qfmz5qOd+Q25U5UOI6TgIKz9oNRZs/0JOuOlYE8HwMw7vQ
	BHV4sb9/9nFcD3C32pX6TzKr6db51uEFTAF9Biod2wDr7XRBiUX0aq2LbWOqG7Dc
	FJfiTmv3Cp0Hi7sfjPZeMffKCMTlqFXT+FUuPAbXcKPn7dO+BOC7YiFf+Lf2eLYe
	AcoUa+q6KoHe01/DVMa2/9LCMgtEUyHlG6A==
X-ME-Sender: <xms:mvlhaS9FwZLznNMaXIJ6AzxzNq5y3BiyDYupAtGCg_pcoPu9v1dwfw>
    <xme:mvlhaZmV88SSSSUfO6Erq8Oec9mT2FFbr_WXhxqEfsb1wKXW-JMI1DyvKp-TyfaRY
    ByC9OTk9emrFT1ZYRst7RLgs2-A39Ra-aJto5zhLTqsvnxztaqxGQ>
X-ME-Received: <xmr:mvlhaQW7PO7XDyIbbzDNE7aTCd0NCySMyS9kVGgtnT1qSuivt14SvIT0R31_CTNQ9-aAQGxnquNjMHnFNP8P6yqqjXQ_WlNQPSszV_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mvlhaWFJH0SEP36LcOjrqmXQ0ntfNqQNRvqomMtrgxFEzu2Kio72Qw>
    <xmx:mvlhaUchwRUgcOq_DmLrFgHlhzTQd_fFt7tf6JAApdL-P5GddnMQHA>
    <xmx:mvlhafJOkQoNiBxBmve8n0owY3gfNH3gl9c1Uj51KElbxvBE6OheaQ>
    <xmx:mvlhaRFRHQZiEWP_vwTIPMlhsIP1TcuK6iyXEg05OVmf8nsC51BJPQ>
    <xmx:mvlhadXOsVtz9NxBflOoWg-75B2q6TG0GFnvqOfQvWrMXI6760fKH1WR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 02:02:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v3 0/2] repo: add --format=default and --keys
In-Reply-To: <xmqqo6n2rmij.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	09 Jan 2026 22:48:36 -0800")
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
	<20260109211554.90828-2-lucasseikioshiro@gmail.com>
	<xmqqo6n2rmij.fsf@gitster.g>
Date: Fri, 09 Jan 2026 23:02:48 -0800
Message-ID: <xmqqjyxqrluv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> Lucas Seiki Oshiro (2):
>>   repo: add a default output format to enum output_format
>>   repo: add new flag --keys to git-repo-info
>
> How does the bottommost commit relate to what has been queued on
> lo/repo-info-keys topic as ac3e74d2 (repo: add new flag --keys to
> git-repo-info, 2025-12-09)?

Ah, nevermind.  These two are designed to replace the two patches on
lo/repo-info-keys topic, so I'll discard the old ones and replace.
