Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65E2EDD72
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764280767; cv=none; b=CfUm2JCQO/pUUYpaW4476MEDd0RW4c+eYDVMImWrgL6DkZ7zL5izwR5xK1Hwg96dn9t1wOitumpTafoyRJf9iQ/UjWCFCD8qGcRNF43jOh/iL5RSABtlQQQ+Irpiidse3eNiEC/e8L13BI2lIDs9VXO6nQ7pxhvag8Lrao27n1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764280767; c=relaxed/simple;
	bh=Afh2LxKIeAinBhOAdVrOi4294nZW+VJegitLtUbAogM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ruRizRusjANI4MCRGuXXhPteyoFqeFCdujFAE57SRVR95LH0wyWaSHw0QRS9/j0POg89KtvzbV+chDe38kAvUC+lLTA3aoySNB4OxNcw73AUiNGP2Xx7ynWxtyE8ybVH1h2lsgEtTToo+xe7PYyJ0l9DoU29XcsoQuPYshU/8q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xy8QLH3w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XsaD6CWv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xy8QLH3w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XsaD6CWv"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E5727A07B0;
	Thu, 27 Nov 2025 16:59:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 27 Nov 2025 16:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764280764;
	 x=1764367164; bh=/LPvmAm3/dwAmZQ3+X6TPnYSfW9n370r2ytJiD+GiP0=; b=
	Xy8QLH3wIgbgriQj8qM6vzSdJnGnGXJb3lkqszhWqKg+NNalvYwtyIrr1IYD7dv7
	CQrPl1tFseOIs7krheY5pbuPCr5W3VI54NKr/y0TXuvHi7d73ad/9zD/LmKSfRgY
	B7yP5tj76hejQQdb5h260VRxJZTn2ZD27FvUr/+f183ElZxrW2TMiKqMGun+Xsf+
	HP9+FEc/2kjyBYXwfOZ9vgzGxERAPl5hlTpu9Z57ketKkeCiJ0OsrxRLdfxRIc99
	XIGoAt1eingFXMYCReHC1d0cseffQpQhkEwGb7aOySz4CLcG6slIkTWU7BlmIdYu
	qFqGX9Xtmq/VLJywVURRHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764280764; x=
	1764367164; bh=/LPvmAm3/dwAmZQ3+X6TPnYSfW9n370r2ytJiD+GiP0=; b=X
	saD6CWveD68ucY2wDHosYAe6WNa/RlTtvvF3pJKUV8hr3dmFXtpbGIWdQsIyvqIU
	BmYCvo8/oaDBp7faHYPm3MhxQUZjm79eMqxqcTEve3x/5rJs8kKkQVpFLocLybMF
	kaH0gTTLY6cO0iIOur1WwwyJfgB7bo8dHuStkr7fWtUZQ8OuELZThgWayV8M6IVA
	HUoSbZj1llhOpOY82L+dNgtkC2rvQRea6PrNC27+6Eub4LC1Wn/lAeQMcGFqBE6e
	aaqtOx2OvxO36XAys2iSLT2Z30ZFPWPzF3u2T1ADU5I03aDBymPBRvFxAA5gl7H4
	LMwhUVJjWl3ycIXncAUXQ==
X-ME-Sender: <xms:vMkoaSITlOmcA2Opl4di55CtCeZGfbxq1f5fJY9wVWQsEZSdhzD91Q>
    <xme:vMkoaRCYwbd19lYqMUwN_GQAOOVNG1G1bMXxXERSOKy1fIQHpM375HHI7ECorMabo
    Iow5YHBiur9nkQJ2u9XyYUN8CaBag4OOUK81jlXCi4oTq0DqMtNRzU>
X-ME-Received: <xmr:vMkoabCx3t0_rO56ZBeMyOhh5v2EXIBZ0LO9nEXhISiZC4sjQRJq-lDnwz26FKo2L_5MlGFN8W8nLAKFDRIIfrsMQ5sv_1firLok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeekfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    iivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmfihikhhtohhrtddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vMkoaTDyVn8MFw6yZLvhCrpiXdGIyZt5FMeKMuy8s5S2l1eYeigfeA>
    <xmx:vMkoaWr78W7T7Zp_Ca0jhkdNzptZaNb9jLOSnWq_1xkcx2Q7T9D2Qg>
    <xmx:vMkoadmhnVrQ3Dmh8hm1DyhxEjQkacHZd21DgrW-rA2f_C-0SWBM3g>
    <xmx:vMkoaWwnzOza5rPHoO4gn5MJ8umrYwcGWvvcv6srT0htyl0yCxMlhg>
    <xmx:vMkoaWTwl4GMAvSQ3AGCdVPZKn7R4G1gl1o109ixwes7F-YaSo3YXRmd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 16:59:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Wiktor Mis via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Wiktor Mis <mwiktor023@gmail.com>
Subject: Re: [PATCH v2] completion: complete "git -<TAB>" with short options
In-Reply-To: <aSf+yrfJo8dRIkSo@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Thu,
	27 Nov 2025 08:33:30 +0100")
References: <pull.2100.git.git.1764052739534.gitgitgadget@gmail.com>
	<pull.2100.v2.git.git.1764174391776.gitgitgadget@gmail.com>
	<xmqqh5ugmu8d.fsf@gitster.g> <aSf+yrfJo8dRIkSo@szeder.dev>
Date: Thu, 27 Nov 2025 13:59:22 -0800
Message-ID: <xmqqo6onjfwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> know what those short options are good for.  E.g. I just learned from
> this patch that the main git command accepts -p and -P options, but I
> have no idea what they are doing.)
>
> So overall I'm somewhat negative on this patch and in general on the
> direction it takes us, but if we do want to go in this direction, then
> it will definitely need more justification than this.

Ah, yes, I totally forgot earlier discussions we had long ago, e.g.,

  https://lore.kernel.org/git/20070205024704.GB12917@spearce.org/

Completing potential values for a single letter short option is one
thihng, but completing single letter short options themselves,
unless the completion script can offer a short-help somehow, e.g.,

    $ git -<TAB><TAB>
    -C (chdir there before running the command)
    -p (enable pager)
    ...

I agree that it would not be of much use.
