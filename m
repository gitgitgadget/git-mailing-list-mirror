Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF41D8A0D
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043341; cv=none; b=gvIncsxSY2q6whJKHIJizfp6dXEuXc414bHqA3j0fyx/N6rIEqhflvSYRt25wzd+GUhzMLMZKUQo9EgnLSdnBSeCBvyEv+N6IMrrupeW1NuPdnT5Sgd4ykKcrC0g8dyXNRgEMhG3w7MKD/7GTJQs9JFe3xrTHjqLIeDxyglbtqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043341; c=relaxed/simple;
	bh=cBUKdf5PPx+fM2D5z3b3bsbt/41C2NhAlVe/R6Elh8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sxk6UD2uYLhu6yIgYgD8y713x4z420myITYAZp4+B6ahsd6Jz60vIwQkAK3Thksq8fRX30Yr8NeLXwASwi8k0eQpTTpZJSpRnQ98enSbItV+97FJh1pdONJ6AsSAkwJJOwxZRsTbOJhyD1HVfL2RhCKrBvUEI87jHZW/SjTMn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OdSAFlV/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZSUuJ/1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OdSAFlV/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZSUuJ/1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2721114018A;
	Thu, 16 Jan 2025 10:57:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 10:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737043047; x=1737129447; bh=GcMRaCNUVM
	ItGNPRpRByEBnM/SXeDigJW9B0cLjZlS4=; b=OdSAFlV/j4mSZEsU558l6wMe1J
	rkbeYDiOVIejjs8/COaAIZaiqRTHCTNJC23rcyXClj3xMbsXfdLCNRtrXfMu+PB3
	5pRDW6S50Gv3n3m6X1daYri2rVc4FvjyQWhWNeqfNi8+qqSeQzArIfOOL+EgZe5H
	ZXRb1jSfFDMaOXYOtLGf5h3WykTKH/JqfkIech/ZmAVEnoRab4JcBXDz3mlPYqJa
	ElecJXVsSLK/mJGRDoYIHjJ2G5u2dvVfYGMXMz5GV35tQICb/2xGb8wwRzdv29jh
	zlfvK78BgZHDf3zOyWZvGNKgf9vzN70idG4zGU1jVkwUrgYUcwYX1cL4bs2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737043047; x=1737129447; bh=GcMRaCNUVMItGNPRpRByEBnM/SXeDigJW9B
	0cLjZlS4=; b=lZSUuJ/1a561gcJ4pCG6UTb0P+PhoNZZVYLTnFCZbxHHoS6pqEz
	qld9LlZz9orYO2l9jfIaa4tg6CPan7BLn9cBkvLH8GuvMzM9ySQzZJULfxxa18AO
	DsHnMvHlOA3R9vjeOuR3OlfcEdfPNDqvbeq7uVuQ6g+/yrJHvq44ueraF1zOj+CD
	y7Ob1LZfrV9t1UMjzEQs2O3PQJ3xwKmfKLyGW04aLozEEzcJB0QWDZTNFpUf017R
	eeVBuuJCk+iBdd6wGQ5ibkb/U6DC9aX6yxNvkhNpnOperlYtLTuZeXi5YihLkz+X
	pSD0T51eL/6rYrGDgkPjHrFxDAwjfsB4yIg==
X-ME-Sender: <xms:ZiyJZ7Uxm_haADZZCxQeIPG9YHiMvwEor5mjRgYZj5U_RP0u2iQLuA>
    <xme:ZiyJZznkjlkl17ODJU2-Sv9Jzel0mIZlqeLSeZyirPt55MOW1u7DP2Z3kGlyzxlzn
    KHetQ3C9rSVqWVGAw>
X-ME-Received: <xmr:ZiyJZ3a6zkwi5RpHM1FnQXrchE4TFTfgToCZdX0trdLuv4lQXWDutvgkYi-3lQIehb9nRW4lhsgm8Hn2lSkW3fJJsj5SEiGK69wG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:ZiyJZ2XUNu0x13OHXd-Oeq-g7CmNtcF-H55bm7e86cnIul7Wvf7mMg>
    <xmx:ZiyJZ1nxiuL4RvkZ9RY2A6S1P4m397h0uf4fTs4hKtF_Y5sGKDYq1Q>
    <xmx:ZiyJZzdV8Xaap8BLqNR6tMhhljPEUyro2devBnO37upON-yPu_7s1w>
    <xmx:ZiyJZ_FDoipSf71E3corF3frMMWGU5znN_riELUxqT9M7L47L0r9Hw>
    <xmx:ZyyJZ-D_4xwDFJ70ceUxYWenivthqM0lcAMsL9XebOCH0a9CNXd1m0IP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 10:57:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] meson: ensure correct version-def.h is used
In-Reply-To: <Z4jUsd77AFih24OW@pks.im> (Patrick Steinhardt's message of "Thu,
	16 Jan 2025 10:43:20 +0100")
References: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>
	<20250114-toon-fix-meson-version-v2-1-66ddb1a82c28@iotcl.com>
	<Z4jUsd77AFih24OW@pks.im>
Date: Thu, 16 Jan 2025 07:57:24 -0800
Message-ID: <xmqqsepiu4yj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> diff --git a/version.c b/version.c
>> index 4d763ab48dd76c0445e5ea390ff4c1f35c1a4b12..4786c4e0a54093ca947da27f8b712bd1ea351203 100644
>> --- a/version.c
>> +++ b/version.c
>> @@ -1,8 +1,13 @@
>>  #include "git-compat-util.h"
>>  #include "version.h"
>> -#include "version-def.h"
>>  #include "strbuf.h"
>>  
>> +#ifndef GIT_VERSION_H
>> +# include "version-def.h"
>> +#else
>> +# include GIT_VERSION_H
>> +#endif
>> +
>>  const char git_version_string[] = GIT_VERSION;
>>  const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
>
> Yup, this looks as expected. I'm fine with the solution (well,
> obviously, I proposed it), so this looks good to me.

Excellent.  Thanks, both of you.
