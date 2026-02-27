Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1115C45107D
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221323; cv=none; b=AHcmZyyBNAfKjX0PQ9CZuTKITBr7NZ4n86SJPna48mOvazxzT/RNw3OH1+Jll9HjQciVqJH8jH2nLDjdo8KqUmkzdlGvw3du3NCShTLl/YDu0U64DBAaj33nl3JhF/2cixMPu/Y8sggvY+ACkiVCB6gTtH/IH35mHRJZ5WswAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221323; c=relaxed/simple;
	bh=cs4lF7r6W6cIpBI6drMlpqaM93ckeAvtDUbvvhU/P8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=keTZ0vuI1Xh33dqrfX34FkemHNnPFzcH2xf+abvbOle7z8Bke1fG7XwFoIxTXOPAuYrZ1BZ9OHAd2MstjFkp0rx7xVH9gxpqnrIfgzL91dF5ws+1TufuU9bzYooZUJoSih1JfyC62+rS+dqwa7sW1y/oBaqxEESBz2zuVRlIHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m4a3FxZD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XTTzIRQM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m4a3FxZD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XTTzIRQM"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A35117A025A;
	Fri, 27 Feb 2026 14:41:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 27 Feb 2026 14:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772221318; x=1772307718; bh=6Mw4bdGQwG
	Bh1jEV92+GdHCOjzmJb5XkIgqdscPVKao=; b=m4a3FxZDcdO9IuYdN7AcEbsnLZ
	eGE29f7MO1BQmQtfJqEr+5dn2+VkDdZL0G6jBuyFP3KlvqCCvfJBZK+jS5dM9/uQ
	WpBSIyQTFeYSPPhGKdV5oiC1yBJWQSAzDe85eOoLcxMAS04FkcbspQ2iNKWVEVLX
	TD0627qCEqaNR1rUBxRx2nRp4jB87dg0+L7EDpjFV3XBjPgIbJhfscRkAschii5c
	pYqAtZz7TnyLuEqA0Les4gaUvXB5mHXTtRJX1dUvNXKhVhRANKpLCaFX3hm3L9jJ
	+7psq+hMrTDiZSLqHGtrAmEnWTVaZJ51lEdP3Uqr/L/DARKgCokF0b9UCGaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772221318; x=1772307718; bh=6Mw4bdGQwGBh1jEV92+GdHCOjzmJb5XkIgq
	dscPVKao=; b=XTTzIRQMeJPBaM+LqxAV2OEuLwNT8pAH53mI5Mjl3q2aeqFyxI7
	vZaifR0XeGyAwp9B2NZkgza6eGhwCcGcvs0V9IR/PSAZemwsS1y7ql2GLgkkt814
	U1NJNI5KZKsOzbFK2xOISG+8MCeNK7X74oUjSMJYQw/xDfQacwbxX8EevYQ/iW2V
	rrhPujKjq4NBTaIeg8HwHqMvRbFUULdBHGrJnn/6VnWabZ2jEx4MKHaWd0b5/b4f
	lGlEtxWCDUNOU0LLkViUPZeE7z//pQN/TFpJe0/Mz1xy+iY8nb6NYhUZ72xb+C6w
	SInrHNqqVB3PcoZHcS0d2otcppYOTRJeAJA==
X-ME-Sender: <xms:hvOhaVe6z1U42CwSkrDvZuQJ-KWkLeHqNsvatIWGyOUWsrzNRDFrRA>
    <xme:hvOhaVxhxJd6MroNJ71xw00-xQ4s8oKsnxM0I7B3s4IAjL-5Env8nObGkDlHIHaaH
    4OTN25xjiOKRXHIPgvWnt0FpLtDgApoemO5QOV1ZBUEiAT8f7ih9g>
X-ME-Received: <xmr:hvOhaSLxAx7vaxb1e0lrKwIxrdvPu4f8rAHHyKuxd-ABN6w9iQw-E3uBVBhXoH9itvSWJ1cWPKy7t6J9oBRXXqI98moDE6bNVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehfrghsthgtrghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hvOhafHsNicJmdlBEGGD8BxBIIuViN4eyk_vNTkSjmH76aThQ-TSBw>
    <xmx:hvOhaW-Y7_gyhCubUJoHDd3JUBtqT-NNX1bkxpCOAyUlKWHzVf9w2Q>
    <xmx:hvOhaXJX7RrLw9GL-admGLrpCdx_rPRHgtNFmrBCw8rD8-F5arKNGw>
    <xmx:hvOhacujvfVfIwcaooYgW1MWF5BQNS5po_dX9d2UwEc9iBr_6l2BZg>
    <xmx:hvOhaQilEsOZvaG5TcT_8fV0kDdZ0UzZeJ_-sSMk5Dwh7GRKI7RN8xmR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 14:41:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>,  Derrick
 Stolee via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  fastcat@gmail.com,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
In-Reply-To: <1ee5927a-c90d-4a4b-a468-5be3644481bc@gmail.com> (Phillip Wood's
	message of "Thu, 26 Feb 2026 18:14:28 +0000")
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
	<pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
	<4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
	<xmqqv7flervq.fsf@gitster.g>
	<eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
	<20260225131344.GA2139176@coredump.intra.peff.net>
	<08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com>
	<xmqqsean4gsc.fsf@gitster.g>
	<1ee5927a-c90d-4a4b-a468-5be3644481bc@gmail.com>
Date: Fri, 27 Feb 2026 11:41:56 -0800
Message-ID: <xmqqqzq6otx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> 		 * Note that the following options are not in local_repo_env:
>>> 		 * - EXEC_PATH_ENVIRONMENT persists --exec-path option.
>>> 		 */
>>> 		if (strncmp(local_repo_env[i], "CONFIG_", 7) &&
>> 
>> Minor nit: !starts_with() lets you avoid counting bytes yourself and
>> hardcoding "7" here.
>
> More seriously it should be looking for strings starting with 
> "GIT_CONFIG_", not the name of the preprocessor definitions.

Thanks.  I missed that completely.
