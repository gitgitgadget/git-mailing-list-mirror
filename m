Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF928FD
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735777508; cv=none; b=hG5D8q4r5XlOxmcOAZ4FcEu4+2wStMnOmZZDj7xeCyx9g1PhmMMSZMgSNOjZ93F9XGTixjFRQm9UTc8CgAyy9LjYUfa90Vuy34Nx7rr68pKJ7uQ7E8yje4iQhfimYMB8PZsqaLNEwVwN7CL7bITQN9jy3O2U4pTyt8iCc7OGB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735777508; c=relaxed/simple;
	bh=XL5pM/7NaWRxY4Vh7gSBfq0AUgQjmkw2naZrVZ+1Tmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TTfZ3AH+wBNgxjtYsGTI+TeAX30VFmHGZyQtyLSborf27g4VulpOfQcu6gurBZ8IfIMcsHrrO6bl8wr+Ex5lUL45C6vYMVUZPOQNVjvcKRAbk94gSZP+ScBcQwCmE6bcFblPpA6JdsqUMDsbX122+hSFnas7JEemlMy5q/fzvgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mM8qjML/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhhzZTxh; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mM8qjML/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhhzZTxh"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A52402540143;
	Wed,  1 Jan 2025 19:25:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 01 Jan 2025 19:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735777504; x=1735863904; bh=zWK+YqmVqS
	Yx0WCXUT8QQOlv7VYR4HKlrnhb3NXq1l0=; b=mM8qjML/JJkQpybNGEBt4JmZJQ
	/A+ikgRyuAuXj7fwiOZ06mTMK1ea/gBmw9VAcg1K0k7aoj3VebTGl9eVWO/R+M7F
	tFGNmSjui6ikW87OEpC+CmdDlg8N4rBw8D2eXoTT+x9+oaMKtPFxJ0XpXpDChe8I
	9ZT6/a6eqrZ8ZNewhVk7aRKvSx8Hy8VO1cmR0KWp2mhnr0nHO7xiJojJb9sI46YI
	vPZS16pPyvGtaY0REoaKsJ/kgCL+4fFLyThUodAnqey3usFpKo6s3YxqWXcKUfLH
	cE3dRhmScyLjnylnBGXwocNcnJ10UfSKZ3BUih57WErANzDWUhC+B+z86rfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735777504; x=1735863904; bh=zWK+YqmVqSYx0WCXUT8QQOlv7VYR4HKlrnh
	b3NXq1l0=; b=YhhzZTxhgbXg65wmPse/SmYeee5D1cr8XNKWYmXHquzz8NIMZkI
	QQFbNs9B5pg2EElSByqhXoD8ISP0eHtNDXN26SKogSC5fZqnOVnTF6wjnD1ee5A7
	6aCMFiTIcOdv/df84Sux7nvkgo1M5AAH/mtyxo23HvAf9O/xCwdt6367G0X4R40n
	g76+6ZsVAVN6C47iCLlzJjp6ajr+u0igcFQOE/7jeXMS5enENT5UhTkrfSLwM+Yc
	TQgQvpNZ78njOUA3caNMR5MLQFIgEIPrAJ/z6fuW7g1wLtHGrXJptgFwNpYSHC10
	SZXgY0SV+Tm8NEjEMJ9pMG1iuicq7QEEwpw==
X-ME-Sender: <xms:4Nx1ZzsoWv_GRtvb3o9hveFFodOfc-dDHAehUhaBuv4lXlm-97o2ZQ>
    <xme:4Nx1Z0c_4kFaPlQPkSw34q155wNHYRW4iLXLQHriADV4EmSnUhS0KTOTvMv-U_6NB
    Y_r5k4704CtetZMzw>
X-ME-Received: <xmr:4Nx1Z2wTAzFNqOLwesmvCtrdTfvqdYqYDefKVdVG7kb-cqX7Hwy6pUMKKe-lnQ5YP2VyK2WeSXSFkclnuerhtE0ygZRRceyYRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:4Nx1ZyO5NXYfTBw9dKCl6al0J6hzOxbTJiFlBv3rSMUdx6n5EduIBA>
    <xmx:4Nx1Zz8Kvdun5z9Dx6f6fVsPNad5xhMjyBPbYQ58zhHtg5dUT3TSOA>
    <xmx:4Nx1ZyWTrPsNpJJjbMRIf2BSvGrRCPncCFE04vd8jaSOV2IjU3kS9Q>
    <xmx:4Nx1Z0d2Z2PoqZ_zOqIubQRS4BD51fVI7YJYN8cTYd0rLG5cOqASCg>
    <xmx:4Nx1Z_bmAJnI3C4CNuhFW-K2ViYJkdT0-N0LEw7P4Pa0xGLakmL_wEvy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jan 2025 19:25:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: a less-invasive racy-leak fix, was Re: What's cooking in
 git.git (Dec 2024, #11; Mon, 30)
In-Reply-To: <20250101191422.GC1391912@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 1 Jan 2025 14:14:22 -0500")
References: <xmqqpll9xehr.fsf@gitster.g>
	<20250101191422.GC1391912@coredump.intra.peff.net>
Date: Wed, 01 Jan 2025 16:25:02 -0800
Message-ID: <xmqqa5cavz8h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Dec 30, 2024 at 09:33:20AM -0800, Junio C Hamano wrote:
>
>> * jk/lsan-race-with-barrier (2024-12-30) 5 commits
> ...
> This graduated faster than I expected. :)

Heh, it is before -rc2 and the change is only about tests, so ...

> ...
> So that line is doing something useful. But it may not be worth the racy
> pain it's causing. So some alternatives are:
>
>   - we drop that line by default, and then when people are investigating
>     a specific leak, they can override LSAN_OPTIONS themselves to get
>     better output (though of course knowing that you can even do is
>     tricky)
>
>   - we keep that line by default, but override LSAN_OPTIONS for CI to
>     avoid the race. That makes all local leak-checking traces
>     informative by default. But CI ones may be truncated. I'm not sure
>     if people use the CI ones directly, or investigate further
>     themselves.
>
>   - we could annotate individual scripts or even tests to disable the
>     option (since it's really just threaded programs). This is more
>     hassle, but would limit the blast radius.
>
> I don't love any of those, but they may be less bad than all of the
> barrier trickery. And it may be that this is even something we could get
> fixed in LSan upstream, and it would just be a temporary workaround. I'm
> still going to pursue that.
>
> And finally, one other option (that I'm not sure why I didn't consider
> before): can we just ignore the false positives, similar to what we did
> in 370ef7e40d (test-lib: ignore uninteresting LSan output, 2023-08-28).

Good point.

> I think we'd have to stop doing abort_on_error for the leak checker and
> just rely on the logs, but that's OK (we always check the logs these
> days).
> ...
> A little hacky, but it lets us have our cake and eat it, too. No changes
> to the code, and no bad stack traces.
>
> What do you think?

I like the small hack.  "This is ultimately LSan's racy-ness and not
ours, so let's avoid changing our code to work it around when we can
do the workaround somewhere else" is an attitude that I would endorse
fully.

Thanks.




