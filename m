Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B12D8DC4
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525472; cv=none; b=OR2lKWsC4UNEKReyHKxb9O6G9AxUlNAv+6toQknqdqGmkhk2364dGIALzyyOPBBoiXy8t0+f+IwoGFjsF+NE3cLGn4obnJvISl/bgtgAU1uLd7yGEOCzjtTZJ7vfhJy5NjJO2eGJ9KFt81D66Cel++O32pVF8iTidiFV4/VAGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525472; c=relaxed/simple;
	bh=XwmbzWlKJeibMkb4ae4n2QtYkNqAT9/gqJx7bmVeWWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AtCZrwAx1DRkatdgOXuAOxp6qfhizav+HHdPKtJCcbH2TnQAFsEhL+YoR7r1ip8aWEHbBBDkp+ohSB0bl3sSHARRdRvC2TB/p5X/uzn7v+M60v48OHRzgZT0AOLI0FE2gHPxNnpzyoPJLg1u3Km6M92Hbv3iXr0NJRdNwXnuM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mJY8mlOy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wMvZAvTA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mJY8mlOy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wMvZAvTA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6326F140008A;
	Thu, 19 Feb 2026 13:24:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 19 Feb 2026 13:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771525469; x=1771611869; bh=yrjFhwqLFH
	zdHVirHTp844PaYXEbgnXkpU0YN5LBO5s=; b=mJY8mlOye9MKLlHSd6zdVEPEBk
	bmhdQ7LwlEA4dnCni7QTF8Gvxm+f2EZFKL/R5VgtVNPemLRhXIWziPp3+BCCh8Jz
	nQgy7No5vRvXmKtJ90wWY74fUkJAxhphpRDEV8dnEwVDsUn4z3ZBKlhHprejHk9l
	+53F61nal3wv2pZc723tgvGi8hXQH63CGoAZYHrpPbCMV+GSswf43M15057vgC1g
	PJWe+gC3vkgOcPdjEz26r4NavLXlaW1QQyME3GfZYsrFKC1bwpzchkeh91OK23aF
	TMxqa+eb8M30OLO8GcXNTqiaHOlSqObKY4hIAPqWM09UblEIYNgrQ1v+/SsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771525469; x=1771611869; bh=yrjFhwqLFHzdHVirHTp844PaYXEbgnXkpU0
	YN5LBO5s=; b=wMvZAvTA2GM2XPPKW+hh5aGk8JqUxtNB3sNlTGfekQnAFkxyTw3
	GGJPeJORvOKAwQqHM/adv7asu/aU/Lprqsr9ijZbwWdQTUCcnWZcL0lpCF67ARjA
	nIuo9WBrvuWsOePaqmss/zcUTGf96191o+QoAFpef/VUuASP6rBREpUwmHqDF9W2
	GJwpwzc4OGrxxA2IbXdCqkDyXQ12Ckn5xvT2TypTcUQ4V+uBvJUckzK57R1HcClr
	LQjj2qZO0mBzzDH12AugWj7lPZufLXqAWsXYORP8g7lSzA8TlA82EKsXDiArzRDO
	Hke55IdR7/chuNklJ2zKyXKOuD3HKhDWmsw==
X-ME-Sender: <xms:XVWXaZdWpZb1Jo9VnEiHr3FjgZ5OXzTzU9OIpTee83nlL3PPiJl2og>
    <xme:XVWXaa7J1mx33mIU-S_c-2Te7QhpBVQj1dnwZypUziQTkLbOsdu733ifZs0SLaUx2
    TEfII6pHeQYuvOTMIwoW60epmTRI2dg0OuLPglYPPNnC2BFPL0eJg>
X-ME-Received: <xmr:XVWXacWN0Wncq5fg1cQA7N6cvku76D-Ip98z-TMlwzztxs8NYU8pnohtZgomRkYZ6s5JYYIYFHd5XPWHhGYygZJ1xqLcl08AFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggv
    lhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XVWXaZ7KIb-8Z3pUVhTdU0h_VjVCj64YvmPGIdbShVEQ-XfN5ed3SA>
    <xmx:XVWXaXoIi_EXyZ5gc1D6MVxGwMm1lwIFvmbpjCs-agLDurRzfyvo9w>
    <xmx:XVWXaclWeO0dM7htABzByFkXzh4JkuySplfBhafYZCkSKKuI7RlxSA>
    <xmx:XVWXaTMAipezMak7mOLnvJxBrspsYn-bkzZi2816rd_xhOlQTrX0iQ>
    <xmx:XVWXael6tNEuEAYZYxyuHSdOKhDUdtVVhN35_j8Uow0aMeUd-1k9r1BO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 13:24:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
  Justin Tobler <jltobler@gmail.com>,
  Jeff King <peff@peff.net>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/7] Some assorted fixes for GitLab CI
In-Reply-To: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
	(Patrick Steinhardt's message of "Thu, 19 Feb 2026 07:25:26 +0100")
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
	<20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
Date: Thu, 19 Feb 2026 10:24:27 -0800
Message-ID: <xmqqldgo617o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v3:
>   - Correct a second invocation of "ci/run-test-slice.sh". I missed this
>     invocation, and because this job doesn't run by default I didn't
>     spot that it broke.
>   - Link to v1: https://lore.kernel.org/r/20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im

Thanks, all.  Let's mark the topic for 'next'.

