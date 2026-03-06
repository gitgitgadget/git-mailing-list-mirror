Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC882ED870
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831245; cv=none; b=KTRGUwAt6nKUXqC6259ghcuLbxv+bFMBaF0rJ/DLnU1JoQOVkOzlTy6bCEUjnoSWDZfn+UrKzrB4/R49TJou5iJ09aQRicVOAgjpMuhRbFBoDE+XGoM1yL4S3F+xRlHwJ6jXjr5LUuWGTzFLjdxCLHKHal2wyfU+pe4zgN2AS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831245; c=relaxed/simple;
	bh=OH0+3CUE8JatGSWgo0UdBINAcU5s52a1meqDFLDwR/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cfi/l2moizbvehMLt92M0qEoB1bakGj13jKsm7vj12wdKdtHko5LiFbMC9ZAyrYH0Xch0AgQJuySs6+BzPOyT3qthBQNlnh/5dS9+gYQDJGe5hN6lIowU84z9KBE/pxoQQ1Tgsa52tG1cvPNIUcdv871+j6wEb2ii7epsbKnniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EIM28LH0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2+jxpmq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EIM28LH0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2+jxpmq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DA72EC053B;
	Fri,  6 Mar 2026 16:07:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 16:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772831243; x=1772917643; bh=rQ5ohroSl6
	/PXQGtdfuT+3T5SClx2N9iwNp4d+h1ASg=; b=EIM28LH0d3vPqRtnyLwFZfCUnK
	pwvjnpQ8Oc4eNwupjrJjxq/OcNljWJ9UylKDylN+scKCNKZgiVSbl0RqsbNTGV0n
	Rm+E3LC+laiWP3Iz7aLqdcKh5TH/J4IkrccQxg981Y+2/ojQqzu1dkY4YQQGTJmP
	ZX/MKfeEMqG6BnpRTx0B8/vzsz599stbUTcQn0+UzQ9UjAnf8uGFXdgHOiU9CyEG
	jLWPoa+EgywgCpVjGGTKzwYf/fIwMxfJQVAFU2i+BHx4GIrH+XAKh7FOj0zlc6tb
	4DuDQWak2DmsOeBkrHX8en6n83WznGiuSqgvCvhQ4rIFctxiHceupSD64eZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772831243; x=1772917643; bh=rQ5ohroSl6/PXQGtdfuT+3T5SClx2N9iwNp
	4d+h1ASg=; b=a2+jxpmqdF4J9otXg65YSpa5tWxi7FRpvPUkpkL4/DBfAHdS2oB
	N88Jxfwkd94ikiaQbKhQj/19apLpl/hY/c8GvEQTXEGhYNVW87znUnTxf8EdI7Wm
	CC9ApVyJ0CR/0/nDJ7+oDNTnvwGyM9bZzzw3NzdXWDetz3W7yAAnia3fnC/c13mx
	hu0rjb8VloJPKbHsI+LrT4IDoxpb+BydNYl5I3sewZIA2RMuHgB9py0BM/E1dLQl
	XujkXD4zYLdAsgJrP3NKQc86qfrHX+srKT13qEjdAoRI5SXlekJwJypm1l6cB+Ov
	QlTb31tlVzrl4uxxZzp5minRwk32bzxfnuw==
X-ME-Sender: <xms:C0KraRs-Sh8hxRP_ntYBsfrDOia68JYwMEVXugCxelJGgSumEoTfvw>
    <xme:C0KraRd0exTHG16BvK8b1vHow_CG7fkwH96pOuX5DdpkupXsO-UWdr9h07a41lEQ9
    v2RugzN0xgeOEcfrZdmTTlRGaH8x28y6eEnpEecp9U9o1u7rYy3E5A>
X-ME-Received: <xmr:C0KraZwl-wev2TmcUMyycAgFOocGv14gjgleUKZOYSg8qTadlSHnw6fTD0eUmac98-Fu_SjgHLcYwOpkiLuGiMNiMOXH6TbUAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhilhgrshesugihrghlohhgrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:C0KraXE5qdZVmvM5uvbQzzdQmDttHsJ0hfWH1kNCJPvzMncYMVS_bg>
    <xmx:C0KradwwFg-o6EYMcQbnnav6h7fBLdAV0F0ittq8aCnzq_NS07THuA>
    <xmx:C0KraYvDvn3N8KV0n9BXNTLZlyq1gOZG-SkSxggn8lEnk6aukEaifw>
    <xmx:C0Kraa0390P_zGZTG0yRKbPQ2-k530nLPdNuXQZq1y_dTZQI720wKQ>
    <xmx:C0Krafg75b7fjGBL9QvDSipeydPAtB8Ivmd1WeoTORBqxlztVATeJtgd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 16:07:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Silas Poulson <silas@dyalog.com>
Cc: gitgitgadget@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH] Fix typo in MaintNotes regarding versioning scheme
In-Reply-To: <882432fe-30f5-46c5-9efa-5b8a047283b6@dyalog.com> (Silas
	Poulson's message of "Fri, 6 Mar 2026 15:14:14 +0000")
References: <pull.2209.git.git.1771774770368.gitgitgadget@gmail.com>
	<882432fe-30f5-46c5-9efa-5b8a047283b6@dyalog.com>
Date: Fri, 06 Mar 2026 13:07:21 -0800
Message-ID: <xmqqfr6czmye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Silas Poulson <silas@dyalog.com> writes:

> I'm aware this is a very minor change, but it would be good to not let 
> this fall through the cracks.

Thanks for noticing a typo.

Will update before the next issue is sent to the mailing list.  No
point in changing it before that.
