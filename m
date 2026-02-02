Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FAA2C0281
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770067545; cv=none; b=jRhFkoH+F5Zwp9wvZT/kkkl7jqJiNyshwr4SieOAULbcWtl/MM3WRzuXpYKtFQnzaaAybEfEgUuN/r9fUfdvfct0rQiV9kZiPtREQsfZYpvgu8KihpBUmCLgmNiziE4LaSm9K7l1sgDrm8Hu/yGV7OUjmq0i6BU3BAeKj01342M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770067545; c=relaxed/simple;
	bh=9/hDpxNaBoknE9ir+WPh5PkaQ9xm/9Bq30R8yo9fnfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqOMzj3ZwX/2PLSGMluwNDtuFhk8R7QW8vgM1hvLc3/VP5mNTShSqWLQXCEDkQ77CreCqZwHGjK3hdhj/KRal8MOZ2o4jlFvS0Xn2f7EBNhnb8X4wJsbQ9spjymDYzLCvjpfa1mtQqMgU5c6ueH17/ismJatg7FueYUWywCdUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ysXZQL2b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mtAVI/AY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ysXZQL2b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mtAVI/AY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C1CBF1D0004E;
	Mon,  2 Feb 2026 16:25:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 02 Feb 2026 16:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770067542;
	 x=1770153942; bh=xsiqOFjJqmX63rbn44zPQdurY8IrgTnxipGoIWwNHxc=; b=
	ysXZQL2bUugDRhaYknrYyF+7vGVS9jbetDuOdiQn06rdEwRorYOoyXLD9iUJt535
	DfKZkxSt7G6vD1Mfxbi2/RWlj0ENSLS2im71RsGQJaSM0YAp1XNpVSL/+VB7yd2y
	24Ixb3gIT6hLxN4ubXhMXFemkcRSOHh5enb5Cms5ZosmnV0BxIAXzg1r2FLsBUr1
	JNIFfArtDkZlm9GSVy1tAV+K+bfoTyO26kbOW/X8rEEuS4mdI/S416Ruf4Jdq7j1
	+7k+JOgjFQbEE8HDsjmsHwUQIzdIfcpiCVTM0mi5+wSPxcSV7tRMWb7d8KlWBK+C
	/qZkFykGMsd/W5I7sVPE9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770067542; x=
	1770153942; bh=xsiqOFjJqmX63rbn44zPQdurY8IrgTnxipGoIWwNHxc=; b=m
	tAVI/AYFDVx/UzVMQYxIYYGMwmsjSjxOg2CpWB17s4flY2rr1gyvZgSZ6NZsVSw5
	u6qDJxmuCdnMM9Sc+9Am6s7f9JSW3ILhevJcp51JbIqRKZE/+NM26rZGVYx43HoB
	30zwS3AYfpoe/DCHYxnIP7eq/YL0shUcR5fvJKL70sfV7nqQcuUlFLkRUoW+bsS4
	ER5PP4wIbmcWU61BNeLj44b4Q8idOUY41rAll+qHdAmLgY/Jp7csg/cLG3zWJ/pr
	97LbJLtFrSNc01uLq5BYdxJ/aQBQtPl/X/Xt2aL7abeyAhg+o6qVgZ+j/KA4szKt
	ojKOfIP6SjMh055lDJjyA==
X-ME-Sender: <xms:VhaBaQSVuEVdWMgJNV1S5wEnveDghuNiyQR_YjHRpMdQSJ2ovM02zg>
    <xme:VhaBaRdMmlTYaRX1oyaKclTyV_cg8kN66qBRMGDALZIyyo69w_FtAv1gcwL6ZpNT-
    3WUiO5NuloAtEaqre8savXyvhOTXtUjKdNKFRlyzRguQQRpYkrC0w>
X-ME-Received: <xmr:VhaBaXpqBgaMOUJkyySOTjdFM9V4wFOLvmSUhaejOzlNZMYwKRI8cUUzZttwBw3EeYSv0_uQ89GXYsrn3zgMNcKhGPbVuFyJHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihhrght
    fhhivghlugdrghhithesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhlvghntggsiiesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VhaBaa9hyixjv_fyInUPpPCzIo9dtkr0hLO5--TRq0bug9M-bT2uLw>
    <xmx:VhaBabeguBvtUprt-pXKGV2BlvpTnbT8hH0yXiGJuhSIz6c5VHUt4A>
    <xmx:VhaBacL25BcvWkN5DRUYnAtwEmU45LDNiAt1xQgZos_hh6JBEUX3RQ>
    <xmx:VhaBaTjTD6eIqQ68tZ-T5c5NlnJ03HEjb6hg_cI7uzzaVug5q8lrzQ>
    <xmx:VhaBaZ2vNlBtLkZgeFmCCRuyvmY6xSDC1p2cBnJlykgKtTnpydaidEuY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 16:25:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: William Hatfield <whatfield.git@gmail.com>
Cc: git@vger.kernel.org,  glencbz@gmail.com,  avarab@gmail.com,  ps@pks.im
Subject: Re: [PATCH 0/5] submodule: add 'reversive' traversal options to
 foreach
In-Reply-To: <1F5D3AAF-3E5E-4AD0-A48B-90B9D545FB21@gmail.com> (William
	Hatfield's message of "Mon, 2 Feb 2026 16:02:16 -0500")
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
	<xmqqbji7yo3x.fsf@gitster.g>
	<1F5D3AAF-3E5E-4AD0-A48B-90B9D545FB21@gmail.com>
Date: Mon, 02 Feb 2026 13:25:40 -0800
Message-ID: <xmqqecn2yh0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

William Hatfield <whatfield.git@gmail.com> writes:

> Do you have any recommendation regarding names of these flags?

Not really.  To be honest, I didn't even check to make sure what the
behaviour was that your "--reverse" was implementing ;-).

> Do you have a preference for: —postorder-traversal or —bottom-up-traversal?

If all three kinds of *order makes sense to the submodule traversal,
then --{pre,in,post}order would make sense.  In other words, does
there exist a good answer to this question: 

    What does "--inorder-traversal" would do and when would it be
    useful, as opposed to --preorder and --postorder?

Otherwise, the distinction between --bottom-up vs --top-down may be
sufficient to explain, and may explain the concept using more
familiar terms to us non-mathematics types.

> What about: —include-superpoject or —execute-in-superproject-last?

Depends on what you are trying to tell the command to do with these
options.

The former sounds as if you are saying "we usually do these things
only in submodules and never in superproject. But with this option I
am telling you to do the same in superproject after you are done
doing them in all the submoudles".

On the other hand, the latter sounds more like "do these things in
each and every repository (both submodules and the superproject),
but make sure the repository for superproject is handled after all
others."

Thanks.

