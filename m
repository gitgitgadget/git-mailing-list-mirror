Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF11DFF0
	for <git@vger.kernel.org>; Mon, 11 May 2026 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778458198; cv=none; b=tLs9wNsrFAEnNnAc/koW7yPVogCW8/rt/hKwGEShCAPbFdSxIaKXsEsqxwEdl4U7rdvP0gASpmUKs6PMfEloLjlJsJq2+VkSBpeg5yXgGqrfDf7Ar5dJ11p1JPe6ywEui5NauMFE8j6ITEI3VQdp/hJCIzzt0KDf1sMWMdhFzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778458198; c=relaxed/simple;
	bh=eDLxinQpCm4ZEwcQbr3W4EH01s1ZzIByTMCxK4y5p/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CY2QUKKL4Z/Y9ASSkZCXYr25MMrylcOw1QH9Wbph0CUkm3ghC5aek4duINMNjjQ+nk8nweSQGgy0xihKhpF9P4ieoE1invKrHks6GJzUl/qxoCwWe+6HOm10Pq+JnFfOZ3BBwB6/ToDpkIlvWWWaZlqY/gvVYH5rSHD0USHidbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ICmC/PZj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vEcMKiUY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ICmC/PZj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vEcMKiUY"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 312091D000D5;
	Sun, 10 May 2026 20:09:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sun, 10 May 2026 20:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778458195;
	 x=1778544595; bh=eDLxinQpCm4ZEwcQbr3W4EH01s1ZzIByTMCxK4y5p/U=; b=
	ICmC/PZjuUbxUX8A2KTKjyTcMhxa7s/imVXM4GOs3oj9HL35JdjFi7mSn5LhpjTy
	vlxYPQEEOTy380orgdQ0XqhnG1lupj6BT+IutDhfYhPBLSgiJ9NgGuEq+NXYumtu
	MagZGPRH/XU6o2/T1WcsQ+IoUPYnNwvB2Fnbu+ME0lYa6Ng+JmgDcRACBYRbyhnO
	lccyMTkjEK9VwLdoKvAXjC7miqTFb4RwF82lNu5+v0qCkYIRWy87kCcZQ6g6zIpz
	Nj84xrRxja1jRGFfo27eJ2FkZ1cheKLt++pcOSsFW+tUoiYJro15OizS/9XHVOg0
	7NZ6iLS/FCtAIr5rh6WdNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778458195; x=
	1778544595; bh=eDLxinQpCm4ZEwcQbr3W4EH01s1ZzIByTMCxK4y5p/U=; b=v
	EcMKiUYqeXIwQ5nXF/bUK5The4JalwkJfOhUBDQdAHqhvyUdbpGAD215srqcjR0w
	iaXqfASkVEPOI9fTbBSu9oyLSIElqB7CSCtSsZOddxNdk/RTFMLnx1leS13lnAuG
	AqP0DcDTBMys4H/dDGI/LlceCfdn4lrIIZJel1plEhXNlTLyVE3wnrDzD8rhW3/5
	yqwDooTdtYrzRei2oPdYizZhG+wPnpvtLke2eg0fVlD+BP072xBwZnBYu/qk87CR
	a8XwiDdBgFn3NEEa09RBUR5lJcIg2u9y5WMmiUjdf9zrTGdXgSMrVmCOKP/gCjWI
	P4pIGo8zhriGVMOLr1M5A==
X-ME-Sender: <xms:Ux4BanVZ0vcmxU00guGoN-oLhM0T9IJdCmfGkwjZDFIds1o02qDGWQ>
    <xme:Ux4BahFfbPQ80AjBGIuYFMvGNZIomcswRh4XzxqR0zd0MDaymfwqk_5UvLh7jQLta
    U7_wEzy_2KYM-mUQEhZ93GUqnjd33fux1M5qU-5H3H_AouqCOQ7vg>
X-ME-Received: <xmr:Ux4Bajd9Twbv0OiZfadOzwLWoWHpk87tCosvC-zpmzEqc_rRSu2PJXTM-VBq5Sh8DBaCa475_vFMGojCsNDvUkcGoHZisV2GDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghmohgpphhoghgrtghnihhksehtqddvrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehofigvnhesohifvghnshhtvghphh
    gvnhhsrdgtohdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ux4BaiIUCD9DisVFcbwqQZwxb77gkqByWPXWZuKB_E_d-fO8phk2Ug>
    <xmx:Ux4BaoFmGHq-ee0pmBb-q32C8rfMDqjK8hKjWktHmuDQQq5CAqdW3A>
    <xmx:Ux4BalDM2DzkG5jMaMiUlo3FoNQjbt-Hdk8Q1qouShX0s0Y8GZN8bg>
    <xmx:Ux4Bar84YrK2PpkogW17hA8ZbQxRR2C0NelJSKJYmittPrSLvnRcoQ>
    <xmx:Ux4Bal1bmzoWtA3LEOdg6FdQLgzK9tq8AYto1ghwSiAVM7egmNNwa4hT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 20:09:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Samo =?utf-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
Cc: git@vger.kernel.org,  l.s.r@web.de,  owen@owenstephens.co.uk
Subject: Re: [PATCH 1/1] shallow: fix relative deepen on non-shallow
 repositories
In-Reply-To: <20260506215647.3011769-1-samo_pogacnik@t-2.net> ("Samo
	=?utf-8?Q?Poga=C4=8Dnik=22's?= message of "Wed, 6 May 2026 23:56:45 +0200")
References: <e8257951-4ea7-40ba-8043-f4f2a080b70b@web.de>
	<20260506215647.3011769-1-samo_pogacnik@t-2.net>
Date: Mon, 11 May 2026 09:09:53 +0900
Message-ID: <xmqqzf26x0vi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Samo Pogačnik <samo_pogacnik@t-2.net> writes:

> The previous patch "shallow: handling fetch relative-deepen"

Whose "previous patch" are we talking about in [PATCH 1/1]?

Please refer to the commit with "git show -s --format=reference", if
you are talking about a public commit etched in the history.

> introduced a bug where using --deepen=<n> on a non-shallow
> repository incorrectly treated the value as an absolute depth,
> resulting in a shallow fetch and truncated history.

That's unfortunate.

We obviously should not truncate when asked to "deepen" (i.e., the
user asked to get more history, not reset the number of commits we
have to a specific depth), and making the operation in this
situation a no-op may be a good first step, but should we just do so
silently, instead of giving a warning/diagnosis?

> This patch prevents any modification when a relative deepen is
> requested on a non-shallow repository.
>
> A test is added to ensure that history is not changed when
> --deepen is used on a non-shallow repository.
>
> Reported-by: Owen Stephens <owen@owenstephens.co.uk>
> Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
