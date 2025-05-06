Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75B21767B
	for <git@vger.kernel.org>; Tue,  6 May 2025 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569884; cv=none; b=BFECmsq+rPJ2VHYmi3njE/nLSfLkkP5uO+YDiHYjlCKFH1WR6DbzigTWiTfkOcUDgDaJ32lczkNIpTmszz4bHT7f0qL3umxV++BzVbsrkEI3crNJrFKdt95SgI9E2jxvsaaTBQ2e+l8Js50aL+brLVBjZDN1+gnA0M+nZMxmumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569884; c=relaxed/simple;
	bh=GfWrZVRy+zX+UWP9K9lJIDk51Mrx6aXC8DveqsZAYMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NK32MDAm+B3BkVslhlL2E8Ii14lJzSmG/9PHaMUGuHWAtc/NDlpFfza2bxhA0RbI+Jo0p7zZBSl+ZGxX8JgOk3yL6q4GC/wmxUWUHbg7iN+NcGHa9KliXPwPDalp8a0CBkxW2PMvcR7W6nd9mVGT7W0GE1PAC4eE2VsIj6JWfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k+wr4AUS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8V2bt5M; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k+wr4AUS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8V2bt5M"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 647802540199;
	Tue,  6 May 2025 18:18:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 06 May 2025 18:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746569881; x=1746656281; bh=Km+TB6j4uo
	22/1rKdteowZrmjsf9GiFHRmXWUrM0dXU=; b=k+wr4AUSnoERJ9byUh8lzn3HrG
	Py76sc0v7cStb9o7DWTBQqkJgEOaYqAxg/rnlMgvRn4eMjT3eWGC31ernrije6t3
	GEMT0eVUdksFXiDSNVVEBaENgox4fFxzUNwNe+uSnDgi0YlsM31EGFp+2k3TARE+
	SgAZbqKgyzGqI0/VoZtAdTh1bSEG/s5kO5+Rx4HasX9Ti6/THgnGXMGwvF+28KjC
	H5YpAw7Vw7rnD8a7QK7eKkArzZAXH//PrukJ8Pscko/Es+idSSwnV2cZknOgH0sB
	hDJjuC5frvuCUT/INDUFYjdpagDjk9EvTfD5Z1UZxbit4MVyXXLsPKkZS10w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746569881; x=1746656281; bh=Km+TB6j4uo22/1rKdteowZrmjsf9GiFHRmX
	WUrM0dXU=; b=O8V2bt5MvSp2/5XtqpuwnLIIsINeJjhNgDduxF/bWXjb32lBMD1
	gqKQtRBg3MfEaT//sF51cgjpeQFalzomagQwGQSPSaB942nBpB4NoaWp3Tx5BGQL
	S7uwtZU+Ar7ufZq5tkz4MaxZW66JVCgmlL9ZbdHDk9rpQdi+0YES1AB0G6dVScgI
	CmU063BLiRkvNPCviPd1m7XSx7U9Ufz/yPuEJnMYz02Re22aItSnz8bH1Pe88jtk
	2ODmvPoHQRBE9qhtwIWBdC2nAZnp4yiXiYdMN/cKXK0KByRLaI9pyc6BjsEiN+1E
	gtEFVnbgcgOK5YmN29RuYmxxfoSFkejHB5w==
X-ME-Sender: <xms:mYoaaAkIRXhp19OXhFtcde_mHBe-wPrxk5CF_urv22MyCci69Xvo0Q>
    <xme:mYoaaP2d3rip7hbKaCcqcGMILZ5AfR-u6Of5KF8bk1ZkgB9pV2ZfgPyUGyJ4nBOTI
    70jWvXabDKsyCt4TA>
X-ME-Received: <xmr:mYoaaOrqVru6rUzel6O-1MyY_Vr3EmHno6bq4MjhCnFeSqCafX8SzCKgdhvO7onFg08A8d0pMrV8G4X6XY0MDsXjJfDKuv51jw_W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mYoaaMmtq5uLypPaDYBdsAIU3ugDQYZlivZSgTNA9RrxFraB0Qpavw>
    <xmx:mYoaaO1Yy0WS-KXuOkAOJlVl2GXsaPIrPb82AYgaOZ-kgJXxJmebrg>
    <xmx:mYoaaDtn3GquIkSdPv2u_vZzjqngxj62BherWtx1XAA7MHDXhjOfeQ>
    <xmx:mYoaaKWHmEvBSTQ_Sq49f_EPayYJLCqzegzkh52n4kqUthxebX26ng>
    <xmx:mYoaaKhp2kDKITufmn2IcdZS5q6K_sj7UV94vBqLBrK-13idN2W905qB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 18:18:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 3/4] packed-backend: extract munmap operation for
 `MMAP_TEMPORARY`
In-Reply-To: <xmqqldr9k1wt.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	06 May 2025 11:52:02 -0700")
References: <aBo7OiCKHTyT4DzH@ArchLinux> <aBo7rXx46_jQhTGA@ArchLinux>
	<xmqqldr9k1wt.fsf@gitster.g>
Date: Tue, 06 May 2025 15:17:59 -0700
Message-ID: <xmqqo6w5fko8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> shejialuo <shejialuo@gmail.com> writes:
>
>> +static void munmap_snapshot_if_temporary(struct snapshot *snapshot)
>> +{
>> +	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
>
> In general, a refactoring tomove conditionals like this to the
> callee and make the callers unconditionally call the helper is an
> antipattern from maintainability's point of view.
>
> Imagine what would happen when we acquire a different mmap_strategy
> in the future, and by that time, there are callers in the codebase
> other than what we currently have (which is just one below after
> this patch).  Do you have to verify if all existing callers that
> trusted "if_temporary" really meant MMAP_TEMPORARY, as the name of
> the helper function suggested, or do some of the callers meant "any
> strategy other than MMAP_OK"?  What if some callers want the former
> and others want the latter semantics?
>
> Without even talking about longer term maintainability, at the
> callsite, _if_temporary in the name is a much weaker sign than an
> explicit if() condition that says what is going on.
>
> I'd prefer the caller to be more like
>
> 	if (mmap_strategy == MMAP_TEMPORARY)
> 		munmap_temporary_stapshot(snapshot)
>
> and make the caller to return immediately when !snapshot, i.e.

Oops.  I obviously meant "the callee" here.

> 	static void munmap_temporary_stapshot(struct snapshot *snapshot
> 	{
> 		if (!snapshot)
> 			return;
> 		... the rest of the helper function ...
> 	}
>
> Thanks.
