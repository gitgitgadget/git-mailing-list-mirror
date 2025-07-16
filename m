Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D802AE8E
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700682; cv=none; b=nbM2+ybKcqUG6W8f2b/Zh+xrPpduC0PmfBi4NoneGk2117vUPHvDzITYfOtoUVnTm6CVZTGXAIGkUCL5Rr3xY/KCqLw9z6P8yX5pUKmH9wAgSanBQ7do1rrbZl6qOK7A/qViPPliyaFwgPr0ICYL2fMv4klyPVmEn400mSiHXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700682; c=relaxed/simple;
	bh=5VjihgAfAgRK69LkHPLE1mQbhIEiYOlnBW+/UuN4mZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wmms+83YvxDl38DmNs5TSp3pCmPQVp/BHFIAfdpNajMaTVD27wavUO30rvf8ynZu4NfBpqGGgnq0m8n0dzlMJsX86BcZBuKmWAAKEzWDdzzXXM2r7znb1qPOTvZFJrg/hPiL6Bg8e3pZuzDXdqFKOZzMl93viSnClQmBtkjkQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uc1qXNJ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FRRXIdCJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uc1qXNJ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FRRXIdCJ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97ABE7A0108;
	Wed, 16 Jul 2025 17:17:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 16 Jul 2025 17:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752700679;
	 x=1752787079; bh=GszasGk/vXrdfwC+yGpvf25lKykCC3HiXYWeGKHRuLc=; b=
	Uc1qXNJ3j/tvrOSE4jjJFElkGzaif57hvo8Zn/2D6rkMwK3LFJJlHDVLnCfpBS9L
	IYE8UEgvKOV1DBlygNvHRmktbZ++b/O8ae8533f4fuHQEyVXnZL5bQTmtbQD7atV
	EbJBiU5Axhpb6rs3fwdciI0uGF20K+GzwRIH+hVTv47A4nSjSAZXXolOvCcqKQxO
	51OJ3Zv8rp4aNXSCfqU8iXnLUXwHONnW9ko5oNikgj0SnC/wW+6eeo0ODLk+j1CQ
	DQc8oOvzfjHWmAf2VK0Eh6978nFkBfz/OWJBVDbWG5WjVbN9sBiK5fYkmE7twfHO
	Eir8psG3EYPR7Jeetn3gdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752700679; x=
	1752787079; bh=GszasGk/vXrdfwC+yGpvf25lKykCC3HiXYWeGKHRuLc=; b=F
	RRXIdCJHk4Bzwf/aMFW+DHMUNdL/zkfsveMltGqJffu9j3JQ/uCEsNpilEkvGeog
	ZlBN+q9HNrujpGnqGaWAQ2OqvDtc/5VQOHCepH85xI8BRVb1qRRT1lyJsJ+aIT1a
	+BwFycEryK956OH/0LfrDpM0ZuV3sA0BH+RnV8KznyYwDS7u+XIuadHBCAknYJpW
	A8UcXxMaeswHsIXa6/noH5JPMjvm6uJRqgvEKjy8tV7hFro4OgmOXWcSMHojOFJs
	xa12pCGB3z9o4zPWXWDOb7Nq0LHjiI2dx9ADBsMtHLSo7rDIf3cc36+BjAuUiePu
	BGroL+vxzeilSgxqRLqLQ==
X-ME-Sender: <xms:Bhd4aEghbS-x01hTGGOVMnbxPPAcbZ8CkQpJ5c_fMfGhZUu_KMFvgA>
    <xme:Bhd4aKm3AUeIBjbyzz_LL-L8kogIop2APL7DejqCj_21XK-7p22DUN7V1GObxA7t5
    565sBIJsSZCMMZJSQ>
X-ME-Received: <xmr:Bhd4aCh3ODOxyAu2KhoMQmo2ol7MmvgNKNPveEhCNEFo-gxvhlrQ_ZcXQldCa-NudE0jvBfjXV7qY5Jb5zcGoKKbFDVrNN-NF3bP2BU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Bhd4aG2ArVq4G2lLW9Vsva6jDTm3PhonL0i8iqWU0wXo2mOEcxuIpw>
    <xmx:Bhd4aDL8CrpTR3nzfK-I0uL8bKaUM0ObxYjqonoslcJMFYIdjX8Njw>
    <xmx:Bhd4aOyoNGMzMhH9pVz1hT42xljURRQQKQ2WthF6f0_EIYN7qiSlHQ>
    <xmx:Bhd4aJXvKH04iAKRYkpe0dywDs3ne6mwLv35gmOziLLF8aJqwQB78w>
    <xmx:Bxd4aLLs8cNPfNyGTqhlom23R5NlTaWozEJJiRp_fWjwYJyMySC_EcDn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 17:17:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net,  Eric
 Sunshine <sunshine@sunshineco.com>,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH v5] meson: work around broken system PCRE2 dependency in
 macOS
In-Reply-To: <xmqq34avalfz.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	16 Jul 2025 14:13:20 -0700")
References: <20250715114407.37955-1-carenas@gmail.com>
	<20250716193000.44673-1-carenas@gmail.com>
	<xmqq34avalfz.fsf@gitster.g>
Date: Wed, 16 Jul 2025 14:17:57 -0700
Message-ID: <xmqqy0sn96nu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
>
>> macOS provides a PCRE2 library in base that is not usable and not
>> configured properly, as it installs a pkgconf module that
>> points to a non-existent pcre2.h header in /usr/local/include.
>
> Thanks but unfortunately this came a bit too late after the previous
> round was merged to 'next' already.  If needed, could you make it
> incremental update on top?

Oops, sorry, please disregard.
