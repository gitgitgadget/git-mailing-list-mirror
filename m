Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB34BE5E
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972074; cv=none; b=ta6XrA98k4UbQaMyAaksTPvCmpp1oX5NzyTprbr+U0vdFHrDwaICfOVD5kyAkOE6ooKSk4Qf1+wCwSxsGY0XnsDA6rvxlqj85ENa5kI2xtXAu+0nnZRDMiOC7ZGH/iQg7XpBuCfePUcu8/WGJZaiyXHoaSW+DmjaQZewrD/KosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972074; c=relaxed/simple;
	bh=cYfaF/xiAYZYVHzqHnXixccHiFu+qXwGKZZmxphjaCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Asx5MpH+ASETxwNXIJ7kWBsputurhpBjjn71kF87PVdg8NNtLKk+TdzISryVocKla7JNhpTs6vnniIpFRUruktQom9q+eJQDMoxLZ9/NsyuQQR7qMHzKRFl3VpRO0Igau5BkOR5cxCQE6Q0BNbC63pV8oC8aQR3fd/wihxC24Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UO2uTGR3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h8uXsBo3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UO2uTGR3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h8uXsBo3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A6307A03DC;
	Thu,  4 Sep 2025 03:47:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 04 Sep 2025 03:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756972071;
	 x=1757058471; bh=LYdJO6Wrmm6YI5dhnGj5LIiwuTwmIPSFAZWXp3S2GQg=; b=
	UO2uTGR3mPBLSGrfCiGPi7aSYqv0SU51fY2hFPc+kTdbRBvREDmIeFRh8lSp/I4Y
	yqfUGjjR98dwG6a+1hb0px1pMdlgZSqnMj1aU1Adu6zMm+TlT9ZMpoldap9M0pbX
	Oa/ixMCnR3MGYqsdrHYXzq3FU0x6yBdu8zyxekMyD79UhPa92BQyEjF03tBNS/6c
	vtfRD7MDd88LrrGmiGcG62PJHs8GCU7H+m4oHIBiFET6BOHC+aCTmSTIK6sBr/B/
	n86Zwjvj1AuC34jaXvx+AbnnHo/atZlu1Zjv5NBM0mNPOqNBLvWJEKdAohts6B5w
	rXJG0RK5Yrm1/OtxH0LvFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756972071; x=
	1757058471; bh=LYdJO6Wrmm6YI5dhnGj5LIiwuTwmIPSFAZWXp3S2GQg=; b=h
	8uXsBo3OnpI4IWqU5ay3RC6rTp9LS7RW+qGUk7BmH6G0gA/Ik3qSfjQl+HTpC/Ji
	JB443NePtgAvmO6g6Emr8u/U3qfTKoPLRd8mLXSD+ObLZjeXFcDzp1rQRiyosFrb
	BZbFvTYITSsJw7kaOpRoLX84h3RVLWyl2Ap+vm5JpqTV4snaNRkTV4l06oy4ZurM
	y9B0rbyyxlFg/K2iA8jwrxKZN3g4+GNYyUbqS3Xc+ZEiJp+ZI+lBS3om7k9EAhxV
	l6XcsAA0qG9aKjUOUc8cS24lX2dl1oVhxm3x6v/XaEmdK/jMwfHGWCDJZBEWQlGh
	A9hK0o0iDFNNQs3ALWLKg==
X-ME-Sender: <xms:J0S5aNCBtCJNTEYrYYQKSiV-SKpKuj9_JLFrzpI3Go-2q3PFP6fY6Q>
    <xme:J0S5aGEzJm2n1oPXuHJh6apzAPiTKo4mm-HLNd6dGHMx3uU88Bh6dwh7Cp-4V94zU
    ISjD5tCFYWH1X38bA>
X-ME-Received: <xmr:J0S5aFIU-R93Qa-cpnky72t8yV33rq0xPIRHrCb5q28zryB1vPcO9_oD37pCato7jawTuARrOVE8_fo23muGZuDJhw4TgVAjBg3W9Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehgeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhhouhhrrggvlhhlmhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:J0S5aKmIKOrMatP_tHFVSX8b9PAtOGqcdam7TZEDHNah3wmoNMm-Iw>
    <xmx:J0S5aNRTbPZJtzC-zKaGaHR5brB6lD1Ad3egLQ_nL1V0SkofNrRYiA>
    <xmx:J0S5aMI8y-ZByLcLY-Gr6Zq-APfvV2SuuAB87md87tsEeOpWuGUKcQ>
    <xmx:J0S5aDARJDevPTa2IFARIyeHp4gmwTVNtACla8iliX-_CI0JmaN1Cw>
    <xmx:J0S5aJwcPLGbhHxiFUNa6JXxd3xyjD6OawtqFfEg1n1CKb3G958_TNnM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 03:47:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9_|_Flare_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?44OO44Km44Op?= | Flare
 <nouraellm@gmail.com>
Subject: Re: [PATCH v4] alloc: fix dangling pointer in alloc_state cleanup
In-Reply-To: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 (=?utf-8?B?IuODjgnjgqbjg6k=?= | Flare via GitGitGadget"'s message of "Wed,
 03 Sep 2025 23:17:07
	+0000")
References: <pull.2040.v3.git.git.1756472406487.gitgitgadget@gmail.com>
	<pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
Date: Thu, 04 Sep 2025 00:47:49 -0700
Message-ID: <xmqqh5xibqvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"ノウラ | Flare via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +void alloc_state_free_and_null(struct alloc_state **s_)
>  {
> +	struct alloc_state *s;
> +
> +	if (!s_ || !*s_) return;

I still do not see the point of this check.  If the caller passes a
NULL pointer, when they are expected to pass the address of a
pointer variable so that the struct the pointer points at is cleared
and freed, and the pointer variable is NULLed, it is called a
programmer error and they deserve a segfault.  Why would it be
better to sweep such an error under the rug by returning without
anything?  It would delay discovery of such a bug, but for what
gain?

