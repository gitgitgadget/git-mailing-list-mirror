Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E7E2EDD70
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428943; cv=none; b=Fc4eT3vkz/BfMVnfCXNoreCQTk0/niC3nnMjcv1GKAxjAJE6WX+bAP6ilLh+5D5/tpRu20Z0xrXFHkA8v+uMPZnGXK4g3xc2PMVp2oISzXeAc7elt9PnDfb6TMTaquvX9X3outs4FBvRbhbF4d2Ac6AhjagsXFj9Ku25nbEyi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428943; c=relaxed/simple;
	bh=f999w1GKKrhnInfQblFWNJX9FwkDumsf0xUxMeLlFN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K9b5MSaJUyTHA16g/ensxT+yXAuzyqsBh/VgdG+RjMdPVvlKuQ8wqUqDR5jERc2Itm4rrniCYma7qL1mQpZeZuPWGTP8f8HS/m1JUXZgMYSMpx96BPu57W93ad4g1RjtmkZ6Fii2ZEYdvR7exq7FfYT96W6bFa0JVA9ZUQinR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TpExBJCz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nUaaq/EH; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TpExBJCz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUaaq/EH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 365041D0016F;
	Fri, 13 Mar 2026 15:09:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 13 Mar 2026 15:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773428940; x=1773515340; bh=pjoFI44bMl
	isV20xG7Ukmz2MQS6PRXcw08e/gq56EMo=; b=TpExBJCzVmJnDR1IbkHguOelUb
	Lpfc17WToeoGyCiepkihpiWGgOKlyIujHyY6gPLA7AHIQFGifovR2j6MhmYGUl28
	2Yl4FeadhJrC/q/s/ZtjYG0h1HWZqQt6P1B5i/E+J5qk6P0CYnv/Y9RUzMewOIEh
	rxqIKJuZG+dnzEHdrz1t450Jev5r+lZG7kP3FU0jnue+4MqtMqoFkQd0Ibxpdev1
	gRPk11JiTUViTWCq1cDIrwdy1D5QvRRtn7/N20n+O7dALhnCC25F0zZJOzNOOJpu
	PHlU3jkyOFmq01TyB7302VeW9clOqHG53qv5PDb2d/ceYghYv0o8KFA6AFzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773428940; x=1773515340; bh=pjoFI44bMlisV20xG7Ukmz2MQS6PRXcw08e
	/gq56EMo=; b=nUaaq/EHSMlXmtWRbsIBlD5URVfhi2EjTdM27F0InGqmcEDaxRJ
	/ihn6ZYHe/LaHQXCf2xUUidseXjN/V6NX8HG1bq3DrgEtVVoYdS8dcSnzZ7c/lnR
	1sp4BiO6twhbtxQZNvMv5YPbrlR9bprH76uZSpP3GFUxLpOEIkdD+PyFgD1zFjQc
	4ybDrcg/vm7beajCX/o1mAqqCTMZ9LfeNfBBdu4aVH57ax2sJbVmFsFPerwZRITf
	a034p6uGP48FhvURC0P5yTvZX1ealS3GUlZzytlOhn0L5FRuCBjv52FQA0sPJgQS
	9umBju/qwqacQDuwk3cUcVl0ly5w3CdEkjg==
X-ME-Sender: <xms:y2C0aaxpsGz8wGR8eCXPswPIiItJcXcgb9Hx_OCK5PJBetesvtO0mw>
    <xme:y2C0adRGzLsiKhshEea_ntbHibgBlfN61Q40pz04LZTcmmlOcxYLP5eBAyCZGEh8o
    zuaO0cdKXGSfaNlWugAFn3B6Bydj_ZZ-e-yrJfHu72xSfZLziyVew>
X-ME-Received: <xmr:y2C0aRWu9g4fr15wxxoaK716chJdwZsZrZ3kEfuh_1Sm2Nr3Cba2a1mZxQ24msr4tst2onL9kb94D1uVQkY2VoqMXn6k_b8WCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrg
    hmuhgvlhdrthhhihgsrghulhhtsegvnhhsqdhlhihonhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:y2C0afYK64lYkO_FrhzpibPczKFDEZPOjeLtMDt1-nCwcEr7cjiwLA>
    <xmx:y2C0aX3k9QCSPi9Kp5FimxDnAtz124rJSzDkJUsnNSHlwZlqWBxfSQ>
    <xmx:y2C0aRjlzKuxQ8FhOk8KtbKsRe44zoWTwddYFXkF0HDBy6kx3nhn9w>
    <xmx:y2C0abYuHMbF6F88urgO1kiyll4h7rM7jD96VfjQCPeaUlr0Ow4oxg>
    <xmx:zGC0ae6JozOZXS8AhHtvE2ZUgV170tTdx6Bk4brn_fWpggvNFlxhUe4c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 15:08:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] Fix GNU/Hurd build
In-Reply-To: <abRIXE2es5A-4VLv@end> (Samuel Thibault's message of "Fri, 13 Mar
	2026 18:24:44 +0100")
References: <20260312191901.174808-1-samuel.thibault@ens-lyon.org>
	<xmqqbjgsdbr6.fsf@gitster.g> <abOxLFNGgZjo1dyi@pks.im>
	<abRIXE2es5A-4VLv@end>
Date: Fri, 13 Mar 2026 12:08:57 -0700
Message-ID: <xmqqsea34kdy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Thibault <samuel.thibault@ens-lyon.org> writes:

>> Agreed, something like this would read better indeed.
>
> Ah, actually Pino already contributed a fix in december:)

Good to know.

> It would be useful to put this github url in the README, I have
> submitted
> https://github.com/clar-test/clar/pull/135
> so it'll eventually end up in the git source for people to find out
> where to send clar patches.

Wonderful.  Thanks.
