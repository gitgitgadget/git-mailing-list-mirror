Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACE38385
	for <git@vger.kernel.org>; Thu,  1 May 2025 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746141024; cv=none; b=pRCoTyUKyQHSEgfl37lAbzHAMcO3pa4cpb/rUaa4UOTP1V+ya1DPFgeeGHJIUfpFQaqP/3t/d67hqAyuc0fEtpfx0hEmSaPueOxqArqhK8bXko9kDz99PELUVbtTC8sU4Fca8U0FXmeWxb/Q+uarafSSuxRCMitV3PwREOHRA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746141024; c=relaxed/simple;
	bh=FPq5vg/11xt2vDd2qk0yHAm5u01FTRtKGx8goNzjjLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3YOnFxQy5JbEZK8/2GnUh0zGar90wDUaddcZIxLqId+SML5lUVTKac5Y4dN4azmgjjpHCfdOPD2Ooz4mv+Pf5hQQaAuvTBT1fdHYOzhIKxMoDxb1pbCmx2Cbwep5to9cMEsbTVokbQsUsVwZE30nbs07RskM1Cf0oAo2nDZfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=InDnPf09; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oXvr76Ud; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="InDnPf09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oXvr76Ud"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 368151380171;
	Thu,  1 May 2025 19:10:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 01 May 2025 19:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746141021; x=1746227421; bh=ukJSimZdZx
	i9YdL8kYl1cmZa0ToEJxmTRJbcnHFiYGY=; b=InDnPf09QNhqBvbv+tPGfVk7D+
	UtBDxk2P+eUcrQMsfoS4SUQOgAFj/QHGcKgZk6+3N+bRUDutGCXPDsMqFUouoTJK
	j+jCnZchgmFM87WdvJgXryXzgoLpMlTP9FPP/n9XNWlbK+fB83sqbCApFp44Z9bs
	0N8zX0jx2jgd7DSN9vhgNNznqZbFlwSophOnaZ/7befYLWh1jzF+Rc+ai+zLJEJG
	1l9XGlijgjGQwLaYJajHsXLfGS6jTvYkznh7wkuUfAXfJv+QpppYAub5o7tKqrQr
	8gYSkNXMilNzYUGf0DEQE5A7AxfW3Xy+8e/uBPzfSq8UVWwJCORi2XnPvvzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746141021; x=1746227421; bh=ukJSimZdZxi9YdL8kYl1cmZa0ToEJxmTRJb
	cnHFiYGY=; b=oXvr76UdBeS3rufXfxmktLNju8Y8AhGkDcyfZUXQTHtjk6ijYhW
	Zufj9g/qL7NICB0j81brs0euFpi0pdasbX1ZIDMXd2xI2/YzgM/3n1V49vZJX37A
	THiHLTOW8o7doU7sxnFgwDHdvTPXpI/Mh+eSh5zrrEOaz1cWVuVHcrYsbkB+xnPj
	eiwKuDtw4qYy28Y9Zuyc1QaYOrenk7hkGD5FUtWa80iEgVJOvLnbWY0h+tk0DUPP
	CuNF1k+/3T0SNHef+kvK/5L991EgH3LplDp6dkgr0E3jCl+LVERsKoXqpzcmnSFn
	lX/owWlWkTREMKBl9VyN86R2OFCVK8zQytA==
X-ME-Sender: <xms:XP8TaL_60kmrLNRhZ_J0W3HhaKkN1FWW9_RKADKmX6L5ue_43uTPJQ>
    <xme:XP8TaHt5Jg7p0V6fWwGKYFN6giUz88FVB7zZtABQ79TquxCcJA5F2btAsTjuWsCbU
    ryU0b5bqTkYcDe2Hw>
X-ME-Received: <xmr:XP8TaJCTSjZUM7Zxd_4Pdh0ZZBulrbGcEaJCVTpY6_CnyC4dK_PFMdAY125qvXIQ4dSMcRB-JVAglhU4ghxiaBYOX21d12VCu4Ga>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Xf8TaHeg90uArI2YSr9FGzpafRribiIGPTKZQxqYyEgLf4n9D_CT_Q>
    <xmx:Xf8TaAMBki7Y0dJiSz08IvNOphpjXRCFPvR43GMowY1rxQO346cSig>
    <xmx:Xf8TaJm8vQpnoj86-V82oyoThcBIo_ZUsnv4YRPzrjpplcfUOf3uFQ>
    <xmx:Xf8TaKtU5AdiqrlT5TmgDCKk-uymhxePmvOXzvmnTay3rzcgSwOCtg>
    <xmx:Xf8TaJD_mXRi5TR_WzGC5fVSiHqcAwGDwqqI2l8SCITa8g_02GHTEhbR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 19:10:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] git-verify-* doc: update mark-up of synopsis option
 descriptions
In-Reply-To: <CAPig+cR-mbtwvUZBdhVCKsimVCETKdWHNG14hXDO77qMWMwVkg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 1 May 2025 18:43:46 -0400")
References: <20250501213414.370514-1-gitster@pobox.com>
	<20250501213414.370514-2-gitster@pobox.com>
	<CAPig+cR-mbtwvUZBdhVCKsimVCETKdWHNG14hXDO77qMWMwVkg@mail.gmail.com>
Date: Thu, 01 May 2025 16:10:19 -0700
Message-ID: <xmqqecx8vsf8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> -'git pack-objects' command and verifies the idx file and the
>> -corresponding pack file.
>> +Read each idx file for packed Git archive given on the command line,
>> +and verify the idx file and the corresponding pack file.
>
> Okay, rewrite seems reasonable. Do we want to backtick "idx" and "pack"?

No.  I would understand if it is spelled '.idx', to refer to a
concrete file suffix that people would type verbatim.  In this
sentence, however, I think "idx file" and "pack file" are used as a
general noun.

>>  OUTPUT FORMAT
>>  -------------
>> -When specifying the -v option the format used is:
>> +When specifying the `-v` option the format used is:
>>
>> -       SHA-1 type size size-in-packfile offset-in-packfile
>> +       object-name type size size-in-packfile offset-in-packfile
>
> Do we not typically call this object-ID (OID) rather than object-name?

Given these entries in Documentation/glossary-content.adoc

        [[def_hash]]hash::
                In Git's context, synonym for <<def_object_name,object name>>.
        [[def_object_identifier]]object identifier (oid)::
                Synonym for <<def_object_name,object name>>.

I do not think so, and if we find somebody doing so, we should
correct them.

>> diff --git a/Documentation/git-verify-tag.adoc b/Documentation/git-verify-tag.adoc
>> @@ -7,26 +7,24 @@ git-verify-tag - Check the GPG signature of tags
>
> ...all uppercase GPG...
>
>> -Validates the gpg signature created by 'git tag'.
>> +Validates the gpg signature created by 'git tag' in the tag
>> +objects listed on the command line.
>
> ...since this is being rewritten anyhow, it probably would make sense
> to employ consistent casing of GPG.

Once the dust settles from this series, yes, but not in this series
that is about mark-up.

Thanks.
