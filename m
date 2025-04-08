Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ABF79CD
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744071426; cv=none; b=YLZM9Ut1gyx7A2+GVM6JeEDKoo0teEolFvHdV7D9ZeGz2/wP/cNmOr8mCw1Nm7+KMBLd7g4L97ytQHo8cmqtRmZl6cZwQig424bAeEk1AflJa2tpywsXAKB1ooW3hTxUWin9Q29ThaJgr7nUJ3MVNvHl0nwbuuKhqqoEeT/+d40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744071426; c=relaxed/simple;
	bh=NP+0law9b47TvuZon6rcFPLkwGg4bSTjOaVpl4edHro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ILRB27SpARWrSqSbwQ9sWqfLj47gmemEH0joqjCt7Umsl9x/r/lzU2XUF2MDQzQL/AI7JqD3O/hvkq650ojJkcZJCDLLN2Ti/YD9uv+VVtF/AVswluLVQDlvpcKBBQc4AZt8S0CrAr1ksmQCVe7kRcnpDHMtMovSgawYIbjkDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ozbcHFF/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EXafPZEV; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ozbcHFF/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EXafPZEV"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03DE2254024A;
	Mon,  7 Apr 2025 20:17:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 07 Apr 2025 20:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744071422; x=1744157822; bh=MpiucIpK3S
	T4R4lDtIPoHANin++YUuy6Rr7XhP6cQ3c=; b=ozbcHFF/0ZTv0DCxm4AuDHRxsQ
	PeqJQTnbiYXk1/vKcAh9e+SflftyB2Ek0pIJabJsBzh2GIoP5b1Y+dYnXmRJqI4Q
	ZOqBW2zKCB7avVl3GN8esGm4bMRWaNQnoxHdMftEoIztPV96Aq9kYZQVJuLWPlEg
	Xj7nnzWxz15jIcCkGXmQYSx89tc/BJ0F4Sq5UhgmsJAyWICUKpX5tjaB3AT3dI6R
	GOkAz+0KCiyqnlAaweDVozDuzVOFBBBa2Zs9KDQnj2ue7QUQhViB3Cnmq73mONrc
	OSwMkW6I5Q7FHiOlz5HDZPs1LsQeggPQo+U12ukZO64KAefY9ji/Lgjod6CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744071422; x=1744157822; bh=MpiucIpK3ST4R4lDtIPoHANin++YUuy6Rr7
	XhP6cQ3c=; b=EXafPZEVBEEQPQBhJJeBf+XWcM87J7uaK8LUvZXezzS7MZLzk1y
	LE3RGb1SuKVJp6OVpZprRobxB7ospqxyGrp9ZM2u+YezI8g3m967YiX9hRHWzi30
	GBoLsdsszXs7WaiAgaZpzKOq7Jk4+1h9RrA8J2mt79I8ahLtJgSlG2j9AHVQK8a9
	vxapLwScKH7AYIf+Dy9R58USiWpSaxYSCV2/GmjtEPM5LwSCu7tj2+UgMHzI+TxG
	ItNlyEsZu4srLNDE832sTUdCy7gHyCJcZajI8uyNBJWMDyb9ub4W33W/EoZLIcfx
	DCLj3dQ5Qt4md1msn4VI2d2MfR2Ea8LNWFA==
X-ME-Sender: <xms:_mr0Z35E2NIJ7Cm2rnpQAM38D06mcUuRKrnhJsenY_O58AEATJZdNA>
    <xme:_mr0Z855vMOvFXSP6ySeAsu1A5aRALWQyNbTsX1kchwsiWTRLi4NX06Q7EO7XubpE
    fkwFczATY5NJUtJFw>
X-ME-Received: <xmr:_mr0Z-dI95Hh3XTv1i6UHvV2OiSMe-YCrNnzwSaOKIpxSp4A0-87ktgvD5P77erQW5xFxAo3dfCGFftDS22Cxt-ADLD7wV7tBm5a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhhohhnhi
    ifrghnghehudefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnthhhohhnhiifrghn
    ghdtfeesihgtlhhouhgurdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouh
    guvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtddtudesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_mr0Z4IAoR044votv49ZjQT4TpGga7Hp4xRTmTB4qi12dzeVqnU9Iw>
    <xmx:_mr0Z7LHHbQq82DilQ7RyvaKgDw5HOBqR5L6TpL7_0xJQBltCCX2Xw>
    <xmx:_mr0ZxyPFmfjdgtN6gYq7_mzmEYvwoo78pSl3Mq7tMGF7qeeEOnoBQ>
    <xmx:_mr0Z3Kom9ETiYH8ruSn_681T0XirG7mZD2VhFsoNI3qH-PmMP2Pyw>
    <xmx:_mr0Z5iuQ_GZJOPpTdkfdcprQqxyHCKgUqHRwjrPPPYtsej3AuTMIl5l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 20:17:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Anthony Wang <anthonywang513@gmail.com>
Cc: anthonywang03@icloud.com,  christian.couder@gmail.com,
  git@vger.kernel.org,  karthik.188@gmail.com,  ps@pks.im,
  shejialuo@gmail.com,  shyamthakkar001@gmail.com
Subject: Re: [GSoC] [PATCH v2 1/3] t9811: avoid using pipes to expose exit
 codes
In-Reply-To: <20250407212834.53183-1-anthonywang03@icloud.com> (Anthony Wang's
	message of "Mon, 7 Apr 2025 23:28:34 +0200")
References: <xmqqo6x7nb2a.fsf@gitster.g>
	<20250407212834.53183-1-anthonywang03@icloud.com>
Date: Tue, 08 Apr 2025 00:17:01 +0000
Message-ID: <xmqqtt6zjyma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anthony Wang <anthonywang513@gmail.com> writes:

>> If so, instead of grepping around, we should be testing that in a
>> more direct way, perhaps with something like
>> 
>>         git show-ref --verify refs/tags/TAG_F1_1 &&
>>         git show-ref --verify refs/tags/TAG_F1_2 &&
>>         test_must_fail  git show-ref --verify refs/tags/TAG_F1_ONLY &&
>> 
>> no?
>> 
>
> Possibly, but I believe adding the test_must_fail check would be modifying
> the original intent of the test, as it would pass even with the existence of
> TAG_F1_ONLY. However, if we are only performing actions to cause TAG_F1_1 
> and TAG_F1_2 to exist, then it would be an issue if TAG_F1_ONLY existed.

I view it a bit differently.

Use of "grep" over the output of "git tag" is simply a sloppy
programming.  If the test wanted to verify "TAG_F1_1 exists", it
shouldn't have grepped for TAG_F1_1, because another tag T_TAG_F1_1
would produce a false positive hit if the earlier test gets updated.

Similarly, not verifying what should not exist is being sloppy.
People who come up with a new feature (in this case, "git p4 sync"
involving tags) tend to test positive effects to show how their
shiny new toy does things, and forgets to test lack of effects to
ensure that their shiny new toy does *not* do what they should not
do.

If the original test were written solidly and use of pipe hiding
exit code were the only problem it had, I would agree that making
minimum change should be preferrable, but the original test seems to
be so sloppy in this case.

Thanks.
