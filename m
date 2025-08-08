Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AFA1B423B
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669370; cv=none; b=Pw1Jd8pVx32BQ/3gYs5FB4pWBa9UApaPI9pCJfeqTaXn9G0HK/EwiIxO5WYgIACPw63FMhjfMiTgW+KK41zg5ve4ynJWdIKjZsmejioS8fLrrzkjBaXHPyzyekz3WCl7dccdlf4YAO34CJfptVH/uC8MYLmGyxAlSWMTANdXOxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669370; c=relaxed/simple;
	bh=hI2QThS3k5erMD3rnQW7z81qFI6kiwYFTag/2SpJyNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VRrnx4cE6JL/gLk7hLmxvApPO5hrhdptGJaQC9RnBVSgmzPKDbxFqux9I9OPCtzySYqBiLGnb2OOoPMhwr7hEpkNK6H2l6aHLsToxd49r5nCv1LBe1ynX0xh8hkgWngAaqBMkR1i+LPoJQ9DGBshHkB+qkzcxWD3Y1p3bv+4S5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OgjYOn63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HSk3fMxo; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OgjYOn63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HSk3fMxo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40EFB7A00DD;
	Fri,  8 Aug 2025 12:09:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 08 Aug 2025 12:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754669367; x=1754755767; bh=hI2QThS3k5
	erMD3rnQW7z81qFI6kiwYFTag/2SpJyNM=; b=OgjYOn63tIHgr0aWXAN5KYRxPh
	lV0n/IWokq8gpEQXzFgKmsbNtlj7jqV7DmTEWeM16Xm/opaCYhgR/OfM8vfn8gaG
	I4NjVsNF4WZtZUrEXkW5boc18AoQZN54YzGdS1oscYa09rxOulYw5PbPSwyITCHh
	SpojzmcFK/XaenYRO6Unsb2X+rJiV6DMwHzTSzpis4eO5BcLnT7Y9E+r5R70d9LB
	NePa+CkopM61IM4Ya55AjdHwUTZZf4TS9Zmdk5yTJHjXsi0wn50ybukA72a6/PvA
	BAmlcoFlS+O01OXN3EqAeLShZyxwwApnLKoaN5IhVYx6r0zpvga3oKjXddOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754669367; x=1754755767; bh=hI2QThS3k5erMD3rnQW7z81qFI6kiwYFTag
	/2SpJyNM=; b=HSk3fMxopXguyCCghvO4ny0JYzbn3HQ+19l0Fqcy+rVj7ZqnzQK
	eDlrXdY8b4zN75e+V+R3Py3oGMNso89B9s7kWZAiXvDCiGWoUoAmYFDOi1/TmZN3
	FzzJ8M+JK56zZqT08TLhykV+LRTH4A/cyQ7Eb3OkVBMFm61Au1UtuXis2kjMXCOO
	Hxy73jnjk2iAkP/Oo81qjB5gopCYCPXzeVEcF6zA3SsT2VtiBkKgCdFLhVdt+8dx
	qRyCNQiqNAWFl3rzFJAkLFIggpEaWfkUKoPpBpKohwl9btT4/7eomlT6qP7JrI4m
	3AefHdyoIhBd+LhIEYY9HVYknAgXu/gGcjA==
X-ME-Sender: <xms:NiGWaJf1nribwvJeRiOzeyFmLtcgYalQ3Bia2LfrUKM4G0Dm3z5M5g>
    <xme:NiGWaKdDBvrxCQN7gIV46r2KgMmcvUXh5V5H8n5UVZw6hv0gOpPdEzcCJTqO-8TMH
    ObGbZ1aoWK8hfrWxw>
X-ME-Received: <xmr:NiGWaL9bMS4c2bI561MEbED-pUO2kVLHuelJEPM2kKYGK66gYUzyr5zuHyg9P9jgo4m5P3tJ1uo5rSbM9q7D2NHa2zKPlHAo58aPPt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehophgvnhhs
    ohhurhgtvgesghhrvghgohhirhgvghgvrdhishdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:NiGWaOkl56PsDkVOrH7FLCqJpaVWY_oqYoScUE3Df4cgH5qguxF-fw>
    <xmx:NiGWaF_714DHE_5H3BhnoZg2Q1DOFCWtG4vTEs83V4UCk2TRRdBuJQ>
    <xmx:NiGWaElrNHOyRkpMtPp3LLiXhPzKIRkXrCtE27_4wM29xY33n8YGAg>
    <xmx:NiGWaK0EML4leQO-MLnkjsTRcxIJ9vDV4Vm534MRjllLHbac9tJgQw>
    <xmx:NyGWaKMAxj2b4vY31KKiZ1qmDtu4YV-wjm7L3mLctbnkj4YKDje810aW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 12:09:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: opensource@gregoirege.is
Cc: git@vger.kernel.org
Subject: Re: [PATCH] diff-no-index: fix stdin path in subdirectory
In-Reply-To: <CCF4B0E0-980D-472A-8689-7615FFFE0198@gregoirege.is>
	(opensource@gregoirege.is's message of "Fri, 8 Aug 2025 20:25:36
	+0900")
References: <20250807150613.32177-1-opensource@gregoirege.is>
	<xmqqtt2jm118.fsf@gitster.g>
	<CCF4B0E0-980D-472A-8689-7615FFFE0198@gregoirege.is>
Date: Fri, 08 Aug 2025 09:09:25 -0700
Message-ID: <xmqqjz3diymi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

opensource@gregoirege.is writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> ... there fundamentally is something wrong here.
>
> Thank you for the thorough response and for explaining the
> reasoning / implementation of the more correct patch.
>
>> Would something more direct like the attached patch work?
>
> I am not familiar with the inner workings of Git at all, but I
> cannot think of any problem with this approach. This works for me!

Ah, what I meant was that I did not test the patch, so I did not
know if it solves the problem you observed in your environment and
with your development tools, hence I was asking you to apply it and
test, like you did when you originally noticed the problem ;-)

Thanks.
