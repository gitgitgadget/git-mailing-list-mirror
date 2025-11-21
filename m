Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E12BE7A1
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755127; cv=none; b=tFF9M/KVrTHPeEBAz2QC3qxlZQN+RKM6K2/4RZYxgFfZ5FHe6kgCHZajy9n5SWGKBzU/w0diuNXbdCiu66ixxCMnBTLwCxwH7AZD/P3hE74f4bV2eWwBrqde8fW34uTfPlwZRqzc0YSqJsp71NqyJ9vOUIXQvcO9zmyBkc+kmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755127; c=relaxed/simple;
	bh=JN1m3gqj4TyRWP2a0dX46/BWZ2ehhgo+URN+nf530y4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p0HCNsKAsmYF4pFcNMRMlmnkfHDAFfsI61pLAHNiG4KU+rZMMgwtZxYS61jk3lc9UBQGQMFmiH53iHtR/3ADUjYcYpjSTEtOaR0bSnh7FMashA7I6Pt2YNz/t1xTQ5XQkcmrqLF8uKkyyXbm8CywLP+WpGT+PChcqrgdq0LNEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cVuTjjXO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n8ut0sbh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cVuTjjXO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n8ut0sbh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B7477A0199;
	Fri, 21 Nov 2025 14:58:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 21 Nov 2025 14:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763755124; x=1763841524; bh=kWYnMwuF5j
	xwAuTnbVze1Nl1GeJjifDoVT566F+ejRA=; b=cVuTjjXOOdvPFKmvkHcxH7sz/2
	LXnsF4/rBC3ohhrcxtscl8gq/6jOP754OGpG3DktY+LwOeDfoZE4LrdS5lTyVM1o
	z3IaAXmY4V5XNTJwAvRg9jwgNeuK6p/0aD1D0B5TIhB7q1i0coAr7LMF3zWgNmwq
	jBubhYOkIMkgyt4fGSiF/WZ+FaCcJDoWJdWVYRaNyu7/YD0Lp2BHZLfcL1afQ+aZ
	C3eFSthmEbz/k7/y0bjTnvevC7SG39nsrdGLkYVbyqrVjfTpNdZMRC2Yh87BZtSf
	tDFO6E+Tbh6uLK4jSIC0C68L2aH5NyUrUZEeYez/5ha2iCFtmI+dnjz+fN4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763755124; x=1763841524; bh=kWYnMwuF5jxwAuTnbVze1Nl1GeJjifDoVT5
	66F+ejRA=; b=n8ut0sbh8nXZ5BR2/7qNWAWYKcaYJic6eXS5+tOFCYmL/cJwkGZ
	Z3yHx3miJCNZ5NYDeh9KDas/NU8sueI3sHKAlUiY7PSBHs1zhtJ8P43KuqYMkTwc
	PHQG2U7z8mZ4C6gKNThEUnA+UiKeWYnXUYrZ4MwQ1OMEYBaYc/pPTuz3yc/ZzP5H
	EI8Qzr9c/oDPxX7KS0khQszn4IHCYZXx76AO81T8sXbAF7tvvplCe9D9KsYFmqIh
	xIWsdEz4KVDpU88sZp8UvP70nS1HLJpsPs6rRs63uqZitjEBKBR9zMQf4erCRzu5
	9OQzYZ0Mn71hEMamSbs4JrIOrfDKNTJm3NA==
X-ME-Sender: <xms:c8QgaS5spgNzGav-MAfBP5OTpKhUXlua1Z6r6_-GtBa-HbJZMvalng>
    <xme:c8QgaeJnQ7Ccb5Ubfx-lrBYt-4SqxYEwSk2I2mnASEjKjF73K8PB29r4XN54zqwTx
    YkEr6mlE59DqIBqX3wTVKLWJ2j_kjiIYGSEtknJ3UQyj5OJWM3R4dA>
X-ME-Received: <xmr:c8QgaTsjpEfY8C-KenAQ6qsC6pC6qQEmWn8_NZmReq2-aLHy7eqzCKzBl2M9f6FVQJezIMUCSafRiqQYbmr1-bBcpeQghiC59P66>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepuggvsghohhhmrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:c8QgaVJwnSskHhurt88MWEPP1hmU31wE3j4_BKvnsPPsHk3ZEQYNPg>
    <xmx:c8QgaU9TP_Qmxcu_Yt8R_juWGmTlIAOLAcvstontH2u-xBxny3J_nA>
    <xmx:c8QgaWzS8IQLdPPxqYWqMWv9BoWhBRGAc5GcKCt_ztPigVLSfrkGNQ>
    <xmx:c8QgaZ77AA_SkCsl8C8G9wmMg-HiWiCdWUVYJyFsV84TFgWofspfiA>
    <xmx:dMQgabxdThZ7OSc4pWScaVqwgJaZEURXkW0aRikA60nQY3xLRfULVih9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 14:58:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im,
  sunshine@sunshineco.com,  David Bohman <debohman@gmail.com>
Subject: Re: [PATCH v8 0/3] fetch: fix non-conflicting tags not being committed
In-Reply-To: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
	(Karthik Nayak's message of "Fri, 21 Nov 2025 12:13:44 +0100")
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
	<20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
Date: Fri, 21 Nov 2025 11:58:42 -0800
Message-ID: <xmqqa50f40p9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>  builtin/fetch.c  |  71 ++++++++++++++++----------
>  t/t5510-fetch.sh | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 195 insertions(+), 26 deletions(-)
>
> Karthik Nayak (3):
>       fetch: extract out reference committing logic
>       fetch: fix non-conflicting tags not being committed
>       fetch: fix failed batched updates skipping operations

Looking good.  Will replace.

Thanks.
