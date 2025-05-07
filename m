Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F828A709
	for <git@vger.kernel.org>; Wed,  7 May 2025 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631628; cv=none; b=BI5fH35df2GDxLf6FtdI07M+YeCUGnwLBHNlOiG1T9delOX/u5IWzG7MFZ/lF4HPAoYB/HxnoU+A2a36XZ5X5GxSuqmSobUKFdFsJphwhe50soHW5XjgaVse9WCZTiBRf+TNZubez/ZHiAtu10JheXrosCOyqZT+pMXOxGdfIJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631628; c=relaxed/simple;
	bh=PbfU3oiEWOw7x91LyNnV7HdDXh6yVC8qMFrJSGjI6b4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V51NElbQMKnlPZuq3kPjxMso54mT4bazKe2Fw2W2O3ahtvfUPapPxwrHgk/otxIXS/x7VAImS1tR2f24GEr79ZWKprHsXR/cmcA59dw1BRrVBdtfPmPaQHQ0IfNNumsCfXyNA/llCyTamHKlhIi03iGsEbPzpLLjW0kfq6avj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aGu34SjB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/kEDpR6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aGu34SjB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/kEDpR6"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21DC51140161;
	Wed,  7 May 2025 11:27:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 07 May 2025 11:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746631624; x=1746718024; bh=PbfU3oiEWO
	w7x91LyNnV7HdDXh6yVC8qMFrJSGjI6b4=; b=aGu34SjBJCODNslwzDn7DhDfVm
	QhdLwM8TmqEhRwTbiShwfylFn12Iprix/evzpNXaEmKf/pJ3aOSA9BSOshLaZN1L
	ZT+Q26+sDGhapCVhpnToo+mLBsKzSCLAtSwwoiFkQW7Rjz11hfCwMBNmjHGZtN6M
	j0R//k+aE94YfJcNtnEXshWSq54okAQnkpcJj3gBFi7LnwWx38UI58Euiy4iQmxl
	MnK8cMYdaJpUpXTLDOX0ULarBNtye5Vb23o7knASw4Y2ENtk/V0qHTssYD5cYLqG
	sXIfnQfkMm1HbDQKbe3wUDJFoRYL6G0IdF0DnWh6F+Mbg13NDQRXr1jdoQRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746631624; x=1746718024; bh=PbfU3oiEWOw7x91LyNnV7HdDXh6yVC8qMFr
	JSGjI6b4=; b=a/kEDpR62tkcPRAVfOB9KV6epCTLae6dhvEeMb8M311pbj+L43L
	QAccbF4D5U+WQzwUlSTXJhZ22PFgxdv3Yp6V16K3uUDn+otEJjlCjAM7+Hc7Efbb
	lCAIVKEKuB9LSVHjqU/x++VZ3WkN3vqVQUjR5vmxP3TCfBoo2NzaEVMKCdPNu4Z/
	SXCjsmUO8/t8N1W0aytdjJl4TcvAxC+ABDWjnQCmOVdT5WmmUB/cSwF90Jc8608e
	askzDoKtnsMavYXVyF2TrOaFFUkcDFk6C1GzU7s1r+1iwhvb3FcRNwFwitCs05Ea
	aUA2nUXm7d4CPiiTAo05OnvSq6Cg48fSRcw==
X-ME-Sender: <xms:x3sbaDT2cLbLCa0V6kHwrPsp__asjAD6LU2Wf76vQKbw_rRo08j-9Q>
    <xme:x3sbaEyoMYMq6Ff_ety8f0QnNzAbj79Ry2GFOP0cXYIvQDNGF1VGPuBvy7V5p3byO
    T4-1_hJU8WC4Ojmtg>
X-ME-Received: <xmr:x3sbaI1IyX7twt_xvvZoaSkzFUjmKRF-8NB3CAvVaWBRLpJ6g88PTIZ7DG6SI3tkArzwY3Dp4HO1UdE8a1OnozmWI11xXHbpk6OD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:x3sbaDD-wT9Ehn4LSPv8jrBH79koijG9vtfaw3-QyizrsY5zpP8q4w>
    <xmx:x3sbaMgefKC0hHAa_ZaJAkBlB_opTTNKiEI_84nJ1kBc-6eROnKjsw>
    <xmx:x3sbaHpnxylW2Kc33AqhLt_lKNprVsQ3vg42q-3CyuOr1Id0Vu96oA>
    <xmx:x3sbaHg89JODXF7W7g_GzL4Z7I0IF1w892F3AED8Z5Pkgu7_D40WFA>
    <xmx:yHsbaIv7MlotSdHkNz7mQ8IU1qnnrxE58LFWaqJaMDo5KuTdg8ubuBkG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 11:27:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 01/17] object-store: rename `raw_object_store` to
 `object_database`
In-Reply-To: <3317228e-e1c8-4b69-9f03-f344f5a6a0cb@gmail.com> (Derrick
	Stolee's message of "Tue, 6 May 2025 20:47:53 -0400")
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
	<20250506-pks-object-store-wo-the-repository-v1-1-c05b82e7b126@pks.im>
	<3317228e-e1c8-4b69-9f03-f344f5a6a0cb@gmail.com>
Date: Wed, 07 May 2025 08:27:02 -0700
Message-ID: <xmqqv7qce915.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
>
>> Instead, rename the structure to `object_database`. This term is already
>> used a lot throughout our codebase, and it cannot easily be mistaken for
>> "object directories", either. Furthermore, its acronym ODB is already
>> well-known and works well as part of a function's name, like for example
>> `odb_has_object()`.
>
> The patch is the kind where "it's correct if and only if it compiles,"
> which is good!

Yes, unless there are topics in flight that adds more uses
independently; I think there weren't any, though, which is good.
