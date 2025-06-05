Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613DA274FC2
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143055; cv=none; b=TLec/IPG/WJkDrVmh+cypgxqLalckPzqLghcwYmF0Y2VwDkz1QD4nQjxnIJNPy9wBarYAohbOfNSCX4p5lMNbtGBuSbxUySmggGTTR5UkpjbXRCp0OBhkmVIFJKyx0dlnBw4bXNbm/IqxKsNdckYCF/qX96ev+qQ1cWVFSRSqpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143055; c=relaxed/simple;
	bh=OeGeLYWRThw8ITlXUatKX3RjUU2pDZ4ZQAWOtYnx0BY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BhB08sDQ992onlbVR1uIEimY3cM//sJQ9xv8Ye1v7M3mJyYeWtODhzjtmPydXLhesth2wBayQBX4mYxF1opHz91ENzmfue0+DLIuBt7tWyrixxSbheZPPz0wEL/JRxA+VVsIteCZVp6pEG+rQQOZCFvtDwGeuZt6nN1FYoPk/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oCyJFKRk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nNIp/zkC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oCyJFKRk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nNIp/zkC"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 61C981140157;
	Thu,  5 Jun 2025 13:04:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 05 Jun 2025 13:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749143052; x=1749229452; bh=Y3AGiPY+3x
	3PhlLBt6l/XoyWQTD0YDdG3p7HibGH0NU=; b=oCyJFKRki8eOab+bzODTayM3MT
	7RAznYnTFwesBtHa0kda4VkiH2hkflY9KXKE8mafhcp2XJaat5vTS7/ObYlycBh8
	YYPYUNwORmotPWLpYm+mJeuSyaKdBBnvcqpmOWvR4oHscmPgEj0Z6hAmS/ZHCJ2e
	sESFOoIWkb5dsa5oUcyjRUHyWc32tfD/JPgBLWPyQ3JHrS9NOX8IzNd8cbXma5W2
	1FIcm2q/Dhua4aqzuqHwyyk+hIsZLKhUGbZKNFW/xLVh9bF/C6iPpDlejVaAJI1e
	GBnSP8vMo9xWOed0NemlkNtAK2zIpDsFIyV3N6C3iqoi4BOrG/VsV/Am50Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749143052; x=1749229452; bh=Y3AGiPY+3x3PhlLBt6l/XoyWQTD0YDdG3p7
	HibGH0NU=; b=nNIp/zkCiW4XX8MiSODdV+WxiXkgRZE3AQwnVkGOsIbL4jesnHN
	me0yR2mpkhFPQ4IepaUpaElyCoW8STcQfAweegHOMS8TXIMtouiHoViHX4eT1zWd
	3uJDX0PR4H00ylf5cgkhYrTD8Jjlb043Griy5Gw5jRZGi/mMfgdy7U0PpKXB2CYr
	AEK9D8jdwUWuepWFsOqTrL6wOkqHG/B6D0RpDW/dHjCH1RV1jjmzjxfX9bSJEFl8
	1ItFiKBs7qr42TKgOU2yT4/h4QJKLMcKgcf0a5oGZj04CBkozJyWBIBE6tW4H9/P
	yQ7Ej+bhKLSAVKuwgxeHcUzBhaKT/gYtZ1Q==
X-ME-Sender: <xms:C85BaBPUlGWjgPmO2GfsiEa64JITe9zh09roWDqdVAvA3ljJfImTuw>
    <xme:C85BaD96YTpsDUpsktY2k7gStOKabzvVnVADahLMqTtGP85rhbXLNU0u0hCH6IwL5
    VftRmWTqHV8EbPbkQ>
X-ME-Received: <xmr:C85BaAT_ybr_i8wgQBSIV78bKcxyiBxrSmehu8n1zfxBzC0AnhemsWD2yp6rmzdYTTFGTHvuTXcOxlSbCjy1M3PrGDIDF6-3qSMZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhile
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:C85BaNuYstdpd0Fba5JamnfR_R9R9l03F8-62H9n44vNqyNlfdGtTA>
    <xmx:C85BaJebh1wMX_7aNqEpt0m5_6Enwz2WsYiZctgS0Lsdx6KMXjIhxg>
    <xmx:C85BaJ2FoR3alIJ8tuJ1PmusBloGpguuAhL5NbwHOFW8xpsN8kGEpg>
    <xmx:C85BaF-DKoFxv9MYqFO8unDCRoesWsfu-H7EcMMEHRrsSfjFPtX4HQ>
    <xmx:DM5BaBFch8eGvoyuxRhJutiXBviyCOGrWOaYxVSpVZe9UPqSv8yCvaZ1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 13:04:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 06/10] t/unit-tests: convert reftable table test to
 use clar
In-Reply-To: <20250605140644.239199-7-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Thu, 5 Jun 2025 15:06:40 +0100")
References: <20250605140644.239199-1-kuforiji98@gmail.com>
	<20250605140644.239199-7-kuforiji98@gmail.com>
Date: Thu, 05 Jun 2025 10:04:10 -0700
Message-ID: <xmqqikla86id.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 3cccc73073..0227fdb3e1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1368,6 +1368,7 @@ CLAR_TEST_SUITES += u-reftable-basics
> ...
> @@ -3972,4 +3972,4 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
>  	$(OBJCOPY) --localize-hidden $^ $@
>  
>  contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
> -	$(AR) $(ARFLAGS) $@ $^
> +	$(AR) $(ARFLAGS) $@ $^
> \ No newline at end of file

I am sure I pointed this breakage out, locally fixed it in my tree,
and told you about the consequences of such breakage.  Next time
please make sure you fetch back from what upstream has its 'seen'
and start your work from that state.

In addition, perhaps you should fix your editor settings to avoid
files with such an incomplete line at the end.  There may be other
incomplete lines in this seris.

And a possible #leftoverbits is probably to teach the whitespace
error checking code to optionally flag a new incomplete line as an
error (this is obviously way outside the topic of this series).

Thanks.
