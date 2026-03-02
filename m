Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACA335081
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476316; cv=none; b=TdSehNZh458ZNqJ0sbBJi5EiTlI2fsarA253LRYWK280Gw9XGRj3xVMNN7FRvgLmghekPlQ+YePvz1iW/akq9eILJEDxjfXjx1z7fAfdtlOK+O61aIr3ALZI0E2YM9Z+/TfkZqDB3sdRsnVK4PgcgKh/R8luRpaIZk1P4Yquswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476316; c=relaxed/simple;
	bh=a8kDc65KjM5q4vOO/NiIfN2k8Xu2nzdG+5aVrYth6jg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NADv0S1IGpyoNgFdrDIiht8C+vfdnU56yEHjwLXZsSjPQRjKaAGQ9izYrMW0jidIJpCNjtJ+btqcOn7V2kLQlZQo2de1IyHkHMJX1umXlRaQ/XIdR4E1aSu7DzSnyxxpFA32/Ja++br3Tcq6eLAjeVQLlaHD2D8HXHCqt4xZCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pfsz+VdP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zWpMhyMR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pfsz+VdP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zWpMhyMR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B2BDFEC00A6;
	Mon,  2 Mar 2026 13:31:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 02 Mar 2026 13:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772476314; x=1772562714; bh=shhjC1RuW+
	Q8HNXCFn/YmZv6Xe1mMHtpKr29UBAhL80=; b=Pfsz+VdPvdGARfy36WAu46JiwW
	2rIyL4VkSEZFPO1YwgB69XNLEeVvgUiA+k0dzKHs+1UjQBY/dhMxE4CSTCk2aE/O
	vpMrfYlXU1yGILDVSgTHc5a7Sxdiqozl/jLfZ0JiP90RMs2pPnk7XBpzKHj5yzer
	1okPlRQ/YpT1d3Mq+k0Z7lnVqKAxPMy8CF1W0u7uvsE2a0PMF5BP7sVHpgw7wSIH
	D+bqcnoSNGYJztXSKeg/G/TeUrUK3In1cZe2YksJItMxpJk4lqrduNpH33D8q343
	5NvOYOK8je6Rp+3wir86mfYCIpcFS7aI4ILTIL2omWEhstGr3GACol5qNGqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772476314; x=1772562714; bh=shhjC1RuW+Q8HNXCFn/YmZv6Xe1mMHtpKr2
	9UBAhL80=; b=zWpMhyMRhEC4HRjZ/T1Apkdqe8u7MJQ2noZgZB0Ema5g5GubevT
	FpGWJ+t69TYowqc1K1Ol8cVFjfXyGoYuBmDJzBOmsTvXv+tEDe2ifDlLgI27NNt0
	EziatJzBWEA4cpBHHH8WSd1mSYJTkmI61e3no6OpTVVew6a/8rIlpCtnreOyAMH2
	sAsT8y1yuNzH/WYlfpynpyvtxMFCiSvmHhmtJXo/dw+BClZGJ2VBdD48wfir3PtD
	byn7Hb/PXd7S/FwXpqbZIe+ksCdNt+o2qNQBZYKjBTCDe7mvUfIlvVh6LfWtdgDI
	vmdQBI59oQuUOuUeraQECEyuz3X6Yr6Z4eQ==
X-ME-Sender: <xms:mtelabcdM8ywMnPasfN69NLMtifTJv1rxkUPqy0sIMX3dumSU9PkKg>
    <xme:mtelaTzx3SeCX0iwZV1b2Pl7obMyUR28cd0Ab7EMoa8RN7ucEKZH4Mmfl633Cz3U1
    TpEzFtbmeUUaZCoaiJmHdCzx-MM3c0DwTo2AzZ2C6Z1xiJdCB880A>
X-ME-Received: <xmr:mtelaYJzqVLjvrZN3oOiG7Oyc9ju4Uqq79j2DGi_hcHvpHhSULJhQ5zMpectoteu9W7wL3MnVTSWhbQ_p1cJUFSZzHd2K0KZsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhgrshhttggrthesghhmrghilh
    drtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mteladGvUbVts5XoH03_FPekyp-cx6vAJPCWw5jEmW1cyowD1-URqA>
    <xmx:mtelac_R6Ws7xdVAZAr7GR423tDzSBNNonlU6gTc7kf6lbTIHhsHww>
    <xmx:mtelaVIFhAOA92WwkqpkSRUt2repWJYo_QQf-nr4CqTAbSG9Gc-n5w>
    <xmx:mtelaSvsnOjyqwsJ7K9y_jcOflEnuZXPdb_zlcYKQcK3CjJ2Q8odUA>
    <xmx:mtelaeiidtBOG3FmxkhoGovB94PJV5FMaMf49MtDhTFIb7cVnAXyM40K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:31:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  fastcat@gmail.com,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 1/4] for-each-repo: test outside of repo context
In-Reply-To: <20260302175606.GB28275@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 2 Mar 2026 12:56:06 -0500")
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
	<pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
	<6e9d4f3029daa2c0068bb16939b943e7ac924222.1772465805.git.gitgitgadget@gmail.com>
	<20260302175606.GB28275@coredump.intra.peff.net>
Date: Mon, 02 Mar 2026 10:31:52 -0800
Message-ID: <xmqqpl5m13s7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Mar 02, 2026 at 03:36:42PM +0000, Derrick Stolee via GitGitGadget wrote:
>
>>  test_description='git for-each-repo builtin'
>>  
>> +# We need to test running 'git for-each-repo' outside of a repo context.
>> +TEST_NO_CREATE_REPO=1
>> +
>>  . ./test-lib.sh
>
> Interesting. I was going to point out that this won't do what you want
> by itself, because Git will keep walking out of the trash directory and
> may find the containing repository.
>
> But it looks like this should be enough due to 614c3d8f2e (test-lib: set
> GIT_CEILING_DIRECTORIES to protect the surrounding repository,
> 2021-08-29). Supporting this case wasn't the intent of that patch, but I
> don't see any reason why it should not work reliably.

I am surprised that use of GIT_CEILING_DIRECTORIES was not done
until 2021, actually.  The reason the configuration variable was
invented for is exactly to avoid discovery processes going upward
and ending up in a repository different from what we mean to work
with.

