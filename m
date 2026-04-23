Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD864
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776902925; cv=none; b=oaRy/WmvfZVC4x6tIVzhaOSfrH/kbotnmQ93QVRNxNV057qHp2prKFNepfc+MveQTpEhjLcodfn6Pyq12mBsp/G9UXibfKqensB6Ix/kZILnA2CVxMp2HXuctwjxaHbMzjWej1eb/LZscs4v5V4CMU/Z8Up36fogReT9IlKX1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776902925; c=relaxed/simple;
	bh=bGpQpS7G2hlyIPT6oCGB0Z45RDFu+vn6E+rR4ZgLiWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EKYoGjvHUVMJgoWfcn4uZ6BbrtNfWwvi8+19e0Xb2C5AOCUcv/+krhm3wJPWcnLaTaC8O9/Lel3MELWvqDepP6EbSuKlOxEC4w94uekjhgfJgeM+KhN3KmhRiOU6DdKZeX+4RXkoUgyQpBVhqwFX4LaOPMHTcfN/DGybQUZ9DyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U5w6J4UV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbkYV3MA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U5w6J4UV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbkYV3MA"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id CDA29EC054F;
	Wed, 22 Apr 2026 20:08:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 22 Apr 2026 20:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776902922; x=1776989322; bh=KQuZHy5B8k
	b+93agFN5KPIYd98W5CO7h1amuFPvzSQA=; b=U5w6J4UVF0IGELBNFWJcdIf1B7
	8gAm2YhU2ANC4/nBMzpUiIaxEBBizQ+eiIdCHU2mHL916wx73JhfAdwjkg83DQ34
	lq6mt4KstkTK33QWLJc22b1ETrhC3uvomPSJX7WPje6CRtmdxX+DrU1s6mABiG2I
	YqlkT3rdYrKjbt0CQjGoPNDkkr8wgq3mskcI8J3Iba53ZTQsIFuILi9CR0YCArL7
	6ovuhpbQ3TDrbmYtAe1mrSph9wgWNb1Q4f+Q57gfgGSKwNniwSyGyEDUVBBXk5hV
	4eLODTH1AdJD2HWxfUuaMe0kPh2sB9UnNJhiJGlGYkyEX1e2oZi0ohHEXFHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776902922; x=1776989322; bh=KQuZHy5B8kb+93agFN5KPIYd98W5CO7h1am
	uFPvzSQA=; b=gbkYV3MAHzxJB4eeEJsZzUBHXFV8k76lEoW3iLwFBcYwkn2Y1oR
	bLHYkRVfOmIqneqtbCGLfv91bUfC/srmUktEZu4B6F8c+7O7hlHr4ezdHIgnf7mg
	OBPVuqZviCk6rJ9KmcA/yolGAT5+/4lo2Hac4Oq1Tt7/PPD15E+xenrzjFbsvA9X
	Lvp8RO7hcaESoT2uCg2AOkSTdBHRM0dPeWyTSs73EfpiXY4IWO2PT1Sjs5IwJ013
	+bYr8NdMDDiCBrMxvz2sWyo9yq4ej4WNgMUE9IKglfMzev29WQF9zRv0VwTrQ+10
	AT2blDAHLV6CekOeERaTjs0ZtsYbKly3M2w==
X-ME-Sender: <xms:CmPpadgt7AuVekvLYICU5ht5tn1jFno_JRAZC_MUzF-MU0b55IogZg>
    <xme:CmPpaY57DPNnUAAxjzCuYejD3oAxBVXdXHMeY4NhAA5RdZXq1fFauh1XK7icVThRs
    WMDXEdQJTaFfMq2ee_a9W2qEh1yFUedBXkGPdtURRvXgkaTWYwq7g>
X-ME-Received: <xmr:CmPpaVbCTGF_TelZ-o0SdbXLd3g6nSSYhNaLyb8LwwdVX3fKPFw6fBVMu4X-HVV7oRpGTuXdTdD_0yhQj3QInHgWdrvE2lw8sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfeelsegsrghr
    rhhoihhtrdhshhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CmPpad4sMaVafalbANyeopKSXakPXPUMYpRW2X87YZn0A7ZPNWSS4g>
    <xmx:CmPpaYBL_ZlxwYky8qb4pcnPQWrpnkTJDdDHx3Kxrumyhoed5GRWqg>
    <xmx:CmPpaTd_qsDQJ9Wv3bu-ErQ54jn6c_mM-pQlgaqqacemk9SrRGXXxg>
    <xmx:CmPpaXLc0IX0vhhu1mPGhRNOc6148WSYdplJXoa-bLp0rQz5PFrjnA>
    <xmx:CmPpaR-zhCqrajAi0iJsbakTd2OmO6IXK9yaby1jRuAB0rSyw4fJoM8n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 20:08:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org,  aplattner@nvidia.com,  karthik.188@gmail.com
Subject: Re: [PATCH v5 00/10] parseopt: add subcommand autocorrection
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Wed, 22 Apr 2026 21:18:00 +0900")
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Wed, 22 Apr 2026 17:08:41 -0700
Message-ID: <xmqqwlxyo7w6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> Git currently provides auto-correction for builtins and aliases, but
> lacks this functionality for subcommands parsed via the parse-options
> API. Subcommands are also commands, and typos will occur, too. Like:
>
> 	git remote add-rul
>
> So, this series introduces subcommand auto-correction.
> ...
> base-commit: f65aba1e87db64413b6d1ed5ae5a45b5a84a0997

When the series is applied on top of Git 2.54, or on top of f65aba1e
(codeql: bump actions/cache from 4 to 5, 2026-04-13), the result
does not pass its self test, at least for me.

It seems that the exit status of some error path (subcommand parse
failure, presumably) has changed unexpectedly?  As I am mostly
offline for this and next week, I didn't dig any further.

Thanks.


Test Summary Report
-------------------
t0040-parse-options.sh (Wstat: 256 (exited 1) Tests: 94 Failed: 1)
  Failed test:  73
  Non-zero exit status: 1
t7900-maintenance.sh  (Wstat: 256 (exited 1) Tests: 72 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1

