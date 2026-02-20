Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F91F7541
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613141; cv=none; b=dQ1K9fj1nOd/oqUh9SLgqqBKi5ST0Q7mSX8NFvg59HIe2Pi5XQlUiqzt1eo7IY5ZwmCHc8EVMJm/v7hpb0SChD87HN+xbI3YGYiTNwboz4V1J+nOw5RWX+r6dwM1KgFykIY+OWDjEmtY+cFLnd+C+3t6KUpxtNPs/Mc5jAOv4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613141; c=relaxed/simple;
	bh=cEIoSDq+aH+AYNlK15WZbthm6f/EeXz/WPDQcuQKrHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fYJeWSmPiPQvfeRMmUaW66IJHnrWQ6QxNZ5LdMo9MvJ+UFBX/jyDuShjr4qsIjyfCC2nTJlLo4iaxxsus+vDjd+1GavQhsK37yusVvgSuhW4/8N56eZfaKO+6n+nRYX0fnqnn4ChsGNbnX6OgCNPPS7DPgEMHUvnTQjnlNC21Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iMSUkBIq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GjSHGnrB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iMSUkBIq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GjSHGnrB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E22F57A0185;
	Fri, 20 Feb 2026 13:45:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 13:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771613138; x=1771699538; bh=kp7rTmPjrQ
	QM9wrGCDcY3DCKbfx8KOSpbsK3Mx6dMyY=; b=iMSUkBIqqaUSlXATekRiy9GlWZ
	zSk6BZddH71SnpWBkK+DnJPj8qh8TMmeV1b7AYLPTg6KKTuV89sIM2M8yRMJnwn8
	xUKzKIrvZXZBM6HfrYydZh7hijVIAV/te6rXlDSSLc3cUQbVmiaBv3dAY3PUJnyu
	9bMahihJV5Xk6lMypStqLIQiJE/szyAkZhJ0mHj0NzZ/ws22Xvs3JhEeHIoBKbcW
	jgpncvK56PTnUjMIji2wRX71h+bPxcDXWkEFGtELndzsltozxLANyiXfDgF2Z6wu
	gUMe1wkuZ6DG6DEv7iqQ1/DIGzGUPpotLA5uM69ac5VtxxZyQVv2fUXWkcdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771613138; x=1771699538; bh=kp7rTmPjrQQM9wrGCDcY3DCKbfx8KOSpbsK
	3Mx6dMyY=; b=GjSHGnrBsjgRDMhgNglC1w4EMpkuUER5vQJg1YyjXtDa6VKtGwj
	gieKEtu8qHGbEEspIwSKWTIjf8fpjC0TZ/JWlHQQ6LlT103AFSmcffHSw1FsuTVd
	ux3wf4vEL4qX+z4s/yB5HexpCEoE0X0I4IUizwnsvoBjCDOC0OLoDDNxwHY3f5eA
	U+1UyMi95tqjWYA9bScNSi3X+wDkf2bVIRPlHhUnXvm0MqaLLGpDYusZetNQdzaf
	tVOmr1lKf+N4ODjMv8XghjZu8lorpb+IB2M0rc3sNuax3xKKJ/Pg+D9vGl8CnIGC
	PHjfV26r19f2+/z6OSVv+s87PU7qTILVjUg==
X-ME-Sender: <xms:0quYaTT85h4XB1tU77PE1iggmbKpcPCLLryoavOevvmiT92PlwiinA>
    <xme:0quYaT0VSdWgdX0pNgfYCE56WwIHegLuGmOCHcBRh5OSYYJ3hCxetwWDy3zOy_4Kl
    xv7NtaJZjVyEQusEXJy_Y7Ax6nwRYO7wVXRUXI4_k_YYP26X4MZQUE>
X-ME-Received: <xmr:0quYafCW-4Y9hjmbufmo_YWwqt-UAp8ndspmpAzc94ojU3CjXddb-r6DMRKFT5a39GAinmjBv1wJ2bm_avhY1EswoDqUZaFrfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeludelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrughrih
    grnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0quYafgB5DzHE9jT5Eg9ibdrOXa4Drax7rlxGM6kVXz1YIsAlkrOgg>
    <xmx:0quYaRM1uM-L8ZYirpzfJoRGK6RJnUrqwKiaLkerCmgvG2UgR6qCUA>
    <xmx:0quYaf-oWTlF8BCO3ScgDMUrFbrhjiauiQf3AxWMSJWHXaT6hjAsag>
    <xmx:0quYaSdf2WgASxEoClHOCxrJdpOvl-PjJyHJ6JVnml9n2Zw3ygxgNg>
    <xmx:0quYaUX2LQfJMGAIG167RifxTH66rd4bl7fYutLfw9-OpSPNk00CWpJp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 13:45:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Jeff
 King <peff@peff.net>,  Emily Shaffer <emilyshaffer@google.com>,  Josh
 Steadmon <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 5/8] hook: allow disabling config hooks
In-Reply-To: <aZiqkB61YXCAKEWE@pks.im> (Patrick Steinhardt's message of "Fri,
	20 Feb 2026 19:40:16 +0100")
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
	<20260218222352.55393-1-adrian.ratiu@collabora.com>
	<20260218222352.55393-6-adrian.ratiu@collabora.com>
	<aZhXom2cD8juWYs4@pks.im> <87qzqfwjym.fsf@collabora.com>
	<aZiqkB61YXCAKEWE@pks.im>
Date: Fri, 20 Feb 2026 10:45:36 -0800
Message-ID: <xmqq7bs7xnhr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Note that the "--disabled" flag was just a way to explain why I think
> it's useful to track the disabled state explicitly. I didn't mean to say
> that it needs to be added :)

Yup.

If "hook list" (possibly with --verbose but there may not be any
need for multiple verbosity levels) shows which ones are available
but which ones are disabled, that would also be useful.  It would be
harder to arrange with the approach to filter early.

Thanks.


