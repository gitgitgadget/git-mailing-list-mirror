Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661C426D08
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061438; cv=none; b=b3j6Hwf6+tzdN5i9KUo3zLWvhIcn8Oy1BK82AKv7kX7sjf+O9ChU2h8krnbaY+rMWusKIwwXVm6KM4S+3H76bcwgQFiF3cA8TiqVpoAh/aRNTQ6sDkwYk4AWhdxb7JR/nz7CPDe5HplV7KO42REtsbwXhS85liLGPezby2m8GFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061438; c=relaxed/simple;
	bh=sSbw9eg1Xa6DuSjUt5mLSANQqV8p499l7ba7Rgirhjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZH4BTmTTBg1tpVw7SIOcBfA+qpgK80kdQVka6bHQP73k57Gu6c6CpQxM++ea8UNjBs0eNjODgTfDc0fqZ1QJAJR3tjCozJwYWu0t2HMYLXyji5ogn0e7mfgus14hUjX1SmnP7KmfGoNWCszakoosJ5gyKIzvs4MA8H84uRTV4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x/M/Oe/G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VSaqBEPk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x/M/Oe/G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VSaqBEPk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F2EE7A0160;
	Wed,  1 Apr 2026 12:37:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 01 Apr 2026 12:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775061433; x=1775147833; bh=X1EKzOw/lF
	1ME/VmozDqe/RyBxa2Yj2yqpepr5cv/bY=; b=x/M/Oe/GdQp1IhRyY7XMOEvmA+
	j5t7AP7NAEkQXm+Aica9+j1yFeKTLfz8Ugu5P/ntI4unOFCWn5CLe6/R1zYZUt8e
	fHrHMjP7X2PBlF+Qn+gRAiEzuAt+mzhxUxX8y0DUC1pe5ThBO9APVII76zbJmZiN
	h/eJ9YaJTHsOREicGkhLNb+yctCNxdpFyAQ2KU8frSre6UR3DC/EysoFTtAzxpb2
	Fqz2JZtxRlHE9Qgd6aWKHDAz1eqfEY0CDWBUrzQYJ4iusDRDf0vFG+gzPkE43aZg
	ahXf1zfQtOGzeEHhSPHWzTJzzW/xu8C+dZSQOyrzrLdazrodkGL0N7ZucMPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775061433; x=1775147833; bh=X1EKzOw/lF1ME/VmozDqe/RyBxa2Yj2yqpe
	pr5cv/bY=; b=VSaqBEPku9K2moTMkiAnUMauv2I5o6Mn0WPvUpuXEiU9w2ARtkt
	Un/OoBKfbtkjD+o40n57FDfcQ/0s5TrbTgYltnUM/TRardchqOSFTxZh6SmJ8H+m
	i9SvOZQLaAJj/7boLchXXv3VXYR615pLcy/mWIRANhMXqMpCNuEZCfS3gXpiQlB+
	QBkTzhZpd0MPs9D08axxmXQyk2k99pqS00+aWIPQr0T6Uk8dHIcRf1PKeH69L3p8
	X79I9QOElS64rG5peT2LP/5LLVrSQMbtAE2OdJ91QXTGoL91HWtqvuCanjKXqttO
	U9vX0JCKejh2r9Nh5otdkvjAO/wwsBnRmOA==
X-ME-Sender: <xms:uUnNadvG6GgUR0iF6ukvwsys9SiC8fYEx5hocIB9Irn6VQZQwqv4QA>
    <xme:uUnNad5ke7sNO3TB3w5SRZEh1YccdM6sT4itEMabc1wbIvJOwS999Ca6OHEWt4caG
    64wbYbUSfVv-01xzTbZwvVmZZfVGyNGuY51VOzGIkohfiuQODb9mw>
X-ME-Received: <xmr:uUnNaeJuT2XrRYyINKDSoijnfgGUCppSFMg0Jonkfv8AsBWrIlJEAHFMGPqtMDusekCB3ya_6Pz5c3Mc6kAqW8t1ifndSlge4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:uUnNad7Fk52Znlc1aO28n6G4Rj46oI0UyNOpsHsedRnTzVfzS2-9GA>
    <xmx:uUnNaRwvujJUwpRq5lftXHghBvFgGAaufPZ-ml_lE6MKLevX8f_swA>
    <xmx:uUnNaRa4-p_12HCLHZ_GAku1tme4NsxBO8XTMOQ8k08iK1UGdgvC_w>
    <xmx:uUnNaTQvP5WfNefJDnmmYezhQfNQgMLP6WB7tjZE1GHZuM23Y6n2jQ>
    <xmx:uUnNaeCZ0E6AznF2IPYuJuyo-DuBV2OI4pdVy9vJDuq2EHQoSe_K629j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 12:37:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] reftable: introduce "reftable-system.h" header
In-Reply-To: <ac0MDTQR484_yxuv@pks.im> (Patrick Steinhardt's message of "Wed,
	1 Apr 2026 14:14:05 +0200")
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
	<20260331-pks-reftable-portability-fixes-v1-6-46bfae55c68c@pks.im>
	<xmqqwlyrzwh0.fsf@gitster.g> <ac0MDTQR484_yxuv@pks.im>
Date: Wed, 01 Apr 2026 09:37:11 -0700
Message-ID: <xmqqse9ewsaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> It overall is a tiny bit confusing, agreed. The reftable interfaces are
> split into two parts:
>
>   - "reftable/foo.h" contains the library-internal API surface.
>
>   - "reftable/reftable-foo.h" contains the external API surface as it
>     should be consumed by the project that embeds the reftable library.
>
> Now for most of the part, headers in the "reftable/reftable-*.h"
> namespace are self-contained. But naturally, we also use some types
> there that require us to include headers, like `uint32_t` et al.
> The requirements that we have here are significantly smaller though than
> what we expose via "reftable/system.h".
>
> So ultimately, the idea was to have "reftable/reftable-system.h" expose
> the POSIX-like environment that is project-specific to make the other
> public headers compile as standalone units. And then have the
> implementeation sit in "reftable/system.c". But I agree that
> "reftable/system.h" itself still sits somewhere in between of being
> platform specific and containing project-specific stuff, which isn't
> great.
>
> I'm overall not a 100% happy myself with the split and agree that it's
> somewhat confusing. An alternative would be to say that it's the
> caller's responsibility to ensure that our public-facing headers have
> all dependencies satisfied, which I think is in practice only <stdint.h>.
>
> I'm very open to alternative suggestions though.

So your assessment starts as "tiny bit" and in the end ends ujp with
"somewhat" confusing ;-)?

I am OK with two level:

 - A C source file that will be customized for platform and the
   project that embeds the library to implement a neutral interface.

 - A C header file that defines what that neutral interface looks
   like, without having any platform/project specific implementation
   details.

But that header file, in order to define an interface in a neutral
way, would need to be able to see common types and things like
"inline", so it is inevitable to have the third thing that is a
header file that will be customzed for platform and the project that
embeds the library.

And in that context making reftable/system.c in this series the C
source that implements the neutral API for the platform and the
project, reftable/system.h the C header that declares the neutral
API, and reftable-system.h the platform specific shim to show a
common definition to reftable/system.h, may be a good division of
labor.  So, while I found the _naming_ confusing initially, at least
between reftable/system.[ch], I no longer see the naming of the
files a problem.

The division of labor is not quite honored in the current
implementation, though, as I pointed out that just like MINGW
specific things that are moved out of reftable/system.h and to the
reftable-system.h, other things like inline and compat/zlib-compat.h
are quite specific to our project and belong to reftable-system.h at
the layer that exposes a certain system services to reftable/system.h
and other "more common" parts of the library.

