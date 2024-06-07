Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514132F37
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717721948; cv=none; b=Vkn3krmKAg5d8foTfxzmvgA83Jr5F3yydZwzigH6nwEm4/hE/Idp2WhFuUEJJmtsgExkZLBzZpk/fuazAFkoPXdk+j7Kp71qqXdbi1S79c4I/MVdFWple52pzwIc5XWJ0revrH2zPTswkCizZbW6gDFV6UzC8huqvShIyhc5CSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717721948; c=relaxed/simple;
	bh=MHBUa6ZvL3YF9O3mBL019lZI9S/wj6kX/BDER4AcrLU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hKrIO5PUgqaNzyc2O7C/6bL2xhlpTEYyTL2/OSmVm4usqexqlFHoVGszwel4pmmpDRYmpdv5SLUMvC0tTcyO862F2hAOuF5V/fVTfxQqbmrPmCF3VTUkUHOnzBertgMDoA3vcp/IGKqM5LadHoBvhpYyVyXIkWoU7PmVAYW2hWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=oH4xejPl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HiqB9OCd; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="oH4xejPl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HiqB9OCd"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 36AED1C00072;
	Thu,  6 Jun 2024 20:59:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 20:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717721944;
	 x=1717808344; bh=OFnBUSjCEQ9ysexyF6GD+weSe6fcnVoF27Rvbf/citI=; b=
	oH4xejPl756qX1vH00Iszwy4Q0umo66d8vscGfuccoFRAiuVSJhISFs1LjextIPA
	XKLvHV1q+My+NKv8uRLMpopgf4wDaSLe/i/arrZN2YJbuGcboG+AoyRSU+UV7j+X
	VjykkzoWpDLd7o6lyYrNJgWZ6PGoFnNyJcCAQLBdOVN2IhwH+4QWkReE/lHsyJ4G
	aSk06Lx1DFKBPoEUt4RH4WjaDsv0guKaECJGYxW6QGV5VqaCkdaFc86kWjiBwZeW
	4Bu3imk7prMu1b7HdfMDwXfHDtrtQHpiv4wpXxs0YTOk6WnMM+nQ5u/iWvBucMxa
	FjqyafvG9ViO8+RSeU8EsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717721944; x=
	1717808344; bh=OFnBUSjCEQ9ysexyF6GD+weSe6fcnVoF27Rvbf/citI=; b=H
	iqB9OCdRNXpoCAK9Cb0r6Uk7tTL9FmDkNgFwJ5EbCO/VW1Pu6xlybrqOagM/hZsv
	QwrHze6eWHHcnhmvR60HfUeCwSECxFss+SB5hRxBcRjB1UpxvpluepyjTtjESols
	hrBqzXchIQlshG3ppPr84HwVbJmNnltmOJbxUANoYaFAwO3mAatpw37rR5DhiyKt
	RZR/Q/uo6n5lHMM0lfgLJ922eHmTwzgf4SjQ8+oQx3f7AL+gWqu7YzqGtKJNbU2X
	8QQf/fKm2B9vAQGPpr53EbhfQbxdjlRfWKRVBPOj5VgeZAnw7BcyLQ3F28DVAt89
	lT7U7kJUrLD6xTq64pPvg==
X-ME-Sender: <xms:WFtiZqK7RwZm1bEQwxhY2wx2xw-2ETx7bgxkhOh16bOC-ZPaIhlEKw>
    <xme:WFtiZiKMbNxUEKD_jY3CuRzVmnwKKMmvrlGmAeR9aIEXyX56amnDAuSkvkJQwr449
    ie5466Blxj-qQvVOw>
X-ME-Received: <xmr:WFtiZquO1gKn4kthsvenWaC3QUkymBPPjUYecEV5la5s5_-rN77UiAh2slSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffvvefuhffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgr
    mhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrth
    htvghrnhephfetteetheetkeduiedtudehtdeijeehfeefheejhedufeffhfffjeffvdeg
    ledunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjh
    grmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:WFtiZvbMDw5ktkVR_c7G6K5QS6cERQzu1b842tx8OU61A1yc8lToYg>
    <xmx:WFtiZhYN67F_0hp-EO5tXYA1-gHhLpmQLKn3kEvKbN3aPiWAGeYfsQ>
    <xmx:WFtiZrDyBJRsou0Xj3iZWI7K5Q16UmrcO4fmCfxTnfLyzLqOKJBwhA>
    <xmx:WFtiZnYGA0Uc3_5TxaTZ_6x47KbC1VJw9AAGce0b9sfbjSymBe7VtQ>
    <xmx:WFtiZlH-dnBItzQRKDwzQldJqQnyeEKRPVRsmbhGYGa20ptwcjDKEB5e>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 20:59:03 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Jun 2024 10:59:01 +1000
Message-Id: <D1TDLY0U13M8.34988PP0ORBD9@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Cc: "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Documentation: improve linting for manpage
 existence
From: "James Liu" <james@jamesliu.io>
X-Mailer: aerc 0.17.0
References: <cover.1717564310.git.ps@pks.im>
 <cover.1717660597.git.ps@pks.im>
In-Reply-To: <cover.1717660597.git.ps@pks.im>

On Thu Jun 6, 2024 at 6:00 PM AEST, Patrick Steinhardt wrote:
> Hi,
>
> this is the second version of my patch series that improves linting for
> the existence and/or absence of manpages.
>
> Changes compared to v1:
>
>   - Converted the extracted script to be compatible with POSIX shells.
>
>   - Fix an empty line being printed when there are no findings.
>
>   - Silence the patched-in Makefile recipe, which otherwise leads to one
>     value existing twice in the converted output.
>
>   - Fix `check_missing_docs()` to use `ALL_COMMANDS`, not `BUILT_INS`.
>
> Thanks!
>
> Patrick

Thanks Patrick, this looks good to me! Learnt a few shell tricks too.

Cheers,
James
