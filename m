Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C037E302
	for <git@vger.kernel.org>; Thu,  7 May 2026 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145526; cv=none; b=aFa2vyjM04ipn7rHAm98EAip6iBH+OiKjg+NY1XygpjSc+zyquRGdIUm/566EmdvTYMXEOcSfiIDsvEhKfa+05Bh5YD8FmKzclMCFyz8nq4qHCE5I+COyQrCOJD9g2j1LfGBm4QqT6qLRbcEjNHxhqgBz0JLXCSCjD3cUX4hy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145526; c=relaxed/simple;
	bh=LIuc09VxS0ESYFn8M6QytopUGlrLgWL/VpniY5M980s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JNQz+/bNLTTo/kIsvD1vvXcimd0r/OQubzTAwLnGgkhozjJl5eVpWLRABIcgHeNDnpi1J3ELGwzuy2DwpHGibYGFXkj6zOK/FTgh7Fd15PyF3w0oHPitr7SAqSbk78xthDOa1+XkOlcBPcM0wZy+e0n3LImLwMbHgiTx29wmzPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DqkF5lQj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSrsrKWQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DqkF5lQj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSrsrKWQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C12BC14000B1;
	Thu,  7 May 2026 05:18:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 07 May 2026 05:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778145518; x=1778231918; bh=4f3Qt5InwS
	ywHHIVwgjgCgKJCRfpXEnfMhY7qS3vSOk=; b=DqkF5lQjJKFFV+6gUOJSJn7X52
	jqBFCHq9r88lyYfkfEUGAiFVWipLCsirJskAXD1Q2Ix2tdVXN64B16kXm5rjhcCY
	pjEw3AO6VzGpb8+hAJuDrO/Jf65V5acy6/ohtmJaOczdV7KABAJC+q2LSRcHQEVX
	OcbWxZtFdEranhfdMIbm7y5C555GFF4aBRspvz6uA4Fp9hvd3lS6JOWARG/+ONhb
	WtEsLhzXRcCRpzeJdwHzqXFS8mSVPvZMJJJBGFe85DP5ufge3Hb2gSWs9344pKUo
	yOul4txiv0yL7pulLARebXzyS9B5Bz8kN0l6cD7cbd11rNjJr4i/w/dHpkBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778145518; x=1778231918; bh=4f3Qt5InwSywHHIVwgjgCgKJCRfpXEnfMhY
	7qS3vSOk=; b=SSrsrKWQtgr1oeaQYFKOBT30JfKIiGOS5BRBK+q/u3NnVR5DJJH
	C8OCEWS5ve+4rEFRLMyRclPqSRXazBcK/PhACWDXVnJgn8hHiiCmrllZOzTdWmhP
	MDsfWWjbHnkoabkEpAD/ZuzyvTsia9IGyPl/BhO0mQR9PKnvkWWc3iIDqDS4Jn30
	aOb/8of7scu0GkV6R5Z2F/pCc3ODMQBFpzNuHAGH5Av7tJOBuNmC04zDHtOs+UNo
	HAjBQ25xMhBPU3TMVksnGPZYsl5V0RlETuUpLDDNUn4jfmbwarZBf0+HjEJdijp1
	YSm+IJ8O3X0bAvisiO8JnlHWC/3CWRczsUg==
X-ME-Sender: <xms:7lj8aWoxtuImGMyMglPmLw25yzYuCX86uC5yosB7EZXBYN8890H8fg>
    <xme:7lj8aTtBGUCvkYbj6UznxzlBkKT47gTpBy_DLjpX3a5CcI1fr68vHfUtmV1sWT4lL
    Q5qmh2MHvOnMPnE0tniVPUddAqDRTLF2rUuOsMmq_d9CVZHZbgiXzs>
X-ME-Received: <xmr:7lj8aRaGTNtw_P1vyud-3vSU2LZTr-Z_X1-XYUdKumbJ7aTS8YAxsJsWoeDiOOBT1mLhMPfvKPDcjCAGfn_OfU9xq6ec-MYlEg7jC9TB5oKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgedvveevgfegjeetgeffvdffheevheffvdduuedtffffgfdvgfdvleelkeet
    ieefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7lj8aSb5PUWwR7D37-PZrZ0CMcA-Zb2wOAObZviKuY6GDcY4I9qdxw>
    <xmx:7lj8aanHgfTwNTEU9-Gz9wN-AWxDqolYeQjlHYLZVBnNpV4zDD1eVw>
    <xmx:7lj8ad3WJzN8Z4SayquuPc-AL8pPhRI6PQ3KlPQ_s4F1m263ZW5TDw>
    <xmx:7lj8aa1agM9qBvhwc6y0QM805mQT0qIGFy4LYT5IOmAsmCLweGOfZA>
    <xmx:7lj8aREQTXJ_yZwg2IsJ92_FLghfjiy_OLrlohjtH-5VwxT-xO5B3f_J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 05:18:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Derrick Stolee <stolee@gmail.com>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 11/11] ci: run expensive tests on push builds to
 integration branches
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<1eaaa7fad7a1432dd97ffdd7c45e8162f61bc302.1777914508.git.gitgitgadget@gmail.com>
	<42f96e54-7b94-4075-91b1-1c2447b93322@gmail.com>
	<xmqq5x52nhg6.fsf@gitster.g>
	<CAPc5daUzr+mn6ojzsqpW6mCXzc2yVqpevVk8njefx4j09G_OgA@mail.gmail.com>
	<e00dbf04-5866-008f-12e9-efdaacc3f2e0@gmx.de>
Date: Thu, 07 May 2026 18:18:34 +0900
In-Reply-To: <e00dbf04-5866-008f-12e9-efdaacc3f2e0@gmx.de> (Johannes
	Schindelin's message of "Wed, 6 May 2026 10:33:56 +0200 (CEST)")
Message-ID: <87se83efx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I thought we updated the codebase to avoid stripping away constness
>> with strchr() and friends, but the error seems to be more like one
>> hand in the system passing -Wc11-extensions to stick to older version
>> of C and the other hand in the system that uses _Generic to implement
>> the const/non-const variants of strchr() in the system header not
>> knowing that the other tells C11 const-preserving strchr() should not
>> be used?
>
> This was diagnosed (with a proposed fix) by Patrick over in
> https://lore.kernel.org/git/20260505-b4-pks-ci-tolerate-glibc-generic-v1-1-5786386fe512@pks.im/.

Indeed.

> tl;dr It's not about `const`-ness at all, but about glibc using a C11
> construct which clang's strict c99 checker now refuses, thanks to the
> upgrade to Ubuntu 26.04 in the `ubuntu:rolling` runners.

Yes, that is exactly what I meant by one hand knowing that it was
told not to use c11 extensions while the other hand ignoring and
always using c11 extensions in the header.  I recall that in the
past gnu library headers were a bit more careful to make the life
more pleasant when we use (or decline to use) various features by
using conditional compilation, but apparently not this case.
