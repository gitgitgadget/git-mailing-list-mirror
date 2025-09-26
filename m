Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC78834
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920906; cv=none; b=aowlVmSRJ8mBgd2ZX4hcoKPC5lA1VYOGzt9PLBEmGzY6j7OzcMdDaM7eE3fRnkh3DCuVqZqXoe4PY7iEpiSyMd76Zu3fExXrj5eKcN0rgJYNzDPYiffXvaHBD6kIDmubfqiqylDwC/A/eQyr9koprid6MGwp2qrfgj+8yL0zX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920906; c=relaxed/simple;
	bh=sJ12SxdSNVvBWFWHyoTTJ6Xm0R2648IIA+ZiHnokQ1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Odj31bvZdBMa4U8S3tbonUkCCAD33bRAH+tTrw9lX0wzbOBlkgLiwdHPejWSJ0Fw9BQTE+x/hMLgMrabGcFKn8VP/TzqUtuW3pApgi7kiGScZJbzugoajWcCnSX8Z5MY51+9qfZjsr8TVwp9lhdP+NLP7r6lzauJb/ASpGTSYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ik2azgS8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wU1F1rAf; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ik2azgS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wU1F1rAf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9ECB47A0185;
	Fri, 26 Sep 2025 17:08:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 26 Sep 2025 17:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758920903; x=1759007303; bh=HCgc3wNvxe
	1XRZmR5foxEvxFJyqhkFAAdbvLyCafuoE=; b=Ik2azgS8T3BamJYLe8Ytl0/XIl
	F0TLlWw94nPNUtzl+H02kEAgjPEvEyXzTjKYrWW4SioTDdo/QelDWBltsT37Znn+
	pWyI098Q2Y1xNlzbwpfMmu4MalUe1Npn0q7KUoDDaSDfXdyuxfxUL+9yLYfzKWb0
	fx2/VCVfbTe8FhqlbuDJYJt3hfVMQKO+gNYdRkqlfSNQAdOOQug1o7uhWSBYCmon
	3nFQIERR9zV4gJzExb3esC+YbQvB8OmVkix63KTue8xQrdC/YzsGV1uPWxEN2Vrk
	RpfNWdmDyzK2yiX2y1bmbDpOs+YM5B7UPy7KgC/lC5Xqr8/d50sFsK/1iF0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758920903; x=1759007303; bh=HCgc3wNvxe1XRZmR5foxEvxFJyqhkFAAdbv
	LyCafuoE=; b=wU1F1rAfBu8h0fZDk48iDWycTyP/NS/SbbhW1gMypgBEyNgKEGk
	74srAkrbV0cFpcOMJQhV7IiH9OY1DXObxdfzDeVQ2/ucOYMATVI9eEEdk7UjsiVN
	q/q6Bsh7ZuULdjFS1Wscs0iGHJIU0BhRTf3YmRWd/kJNzL4cKwCBeI5pW0FhacSD
	mB3iE86WofFynPpJmrhIaRmlYvxJUk7e9Pn1Q54Y0sC8yUf8cjfL+n/SeBXC5AbG
	dRNnNOfm5GVpkmApLaZyoYeU2H1Ityq4OgHsQ9kRrGfJHqdCgTNOtDodY7SgJu34
	zM7+707isekBi3qxnWRvM2o0zTjG5DM1n6A==
X-ME-Sender: <xms:xwDXaCF5DXLqbL3lbfu1E8ev5nOEMGtb6Rxz0AT30t4qAnVqeYxmMw>
    <xme:xwDXaKMfKQ5U1G0YjUKaKnzoNqtJsX47vREavDcxcVphtGS1q5bVN4-TCJ7Nbw2JI
    fszSrzYyFaQoRSzbbv-okr9qs7itIVDAIMgP1OSqlDrROTIaSuM>
X-ME-Received: <xmr:xwDXaEd9RSEiI-HB-iFgkjnRYRMWlnuQkcSvd4X-rGbboyA5j_SGkwVjtbfv1mdBdniHoRNRElW346twdNEh75NRi2WtGSD8MQBo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtdegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xwDXaHtLOS4Jvdxn5ovA-XkKJ0KR9QVgSGd4LlGpfjrOrSTCgtH-9w>
    <xmx:xwDXaFlir5ykGAccQbEANsMYxHcD13zS3PlewntN5ZMx_gU9m-lF6Q>
    <xmx:xwDXaJwvESXhPVs0ZtmhbzNa4otnfyimdD4KSzNn6ae_KVPOcXzxDQ>
    <xmx:xwDXaHO1ILtQJvZZbdpensxPXPU2DYF18BI1VKmXuVb-fWvIocce-Q>
    <xmx:xwDXaG-1P-MxqNNThOB_ZuvfFanbjVG-fEKDQZ53YW-lAbk07XBrxkmc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 17:08:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [PATCH v4 0/7] refs/reftable: add consistency checks
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
	(Karthik Nayak's message of "Fri, 26 Sep 2025 09:25:43 +0200")
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
	<20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
Date: Fri, 26 Sep 2025 14:08:21 -0700
Message-ID: <xmqq1pnsc46y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes in v4:
> - The biggest change is to iterate over the tables in a reftable stack
>   for consistency checks instead of all files inside the REFTABLE_DIR.
>   This avoids all race conditions. Also, since we only check the tables
>   in a stack, it no longer makes sense to check file type.

Nice.

> - The discussion about update indices was concluded that tables indices
>   in a stack must be strictly monotonically increasing. While modifying
>   the code to do the same. I realized that we already have this check in
>   'reftable_addition_add()' where we check while adding a new table to
>   the stack: `wr->min_update_index < add->next_update_index`. So I've
>   dropped this patch from the series.

Great.  Reading over patches and noticing that it is not needed is
the best kind of proofreading ;-)

> - Change parse_names() to accept the output string array as an argument
>   and return an error instead. This makes the flow a little easier to
>   understand.

Wonderful.

Will queue.  Thanks.
