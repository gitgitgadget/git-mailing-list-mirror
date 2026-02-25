Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E213ED131
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049082; cv=none; b=aMumD2Da5tcvQsrNxjbXHEyDS8cFC5szlDYPQkzIiFe6Fd4/qpFlSCsO92C+5ir7Ah8Vo/MC10x2cR9+gDDNgOFDALGM/g11X4F4wUcLqs7B8WrTZOCNarEUlLsI9LItPFXIJ2SLE7QvoqG7Jbco8odjGPOB2uVBOd6nWMazlDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049082; c=relaxed/simple;
	bh=eHTNVk3Viv5omAyGUx1r1Q98vHS42grEkhfw9mOX3XQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DhwT3HaE1XzzRIGqENHCS5td9yI0XLxeh1TNmID+j+/Rjuue5fz4pEMmpQ8DeXVnpr+NTpRO/6zacXAefcbewZEidgFEWLrtBdIV0siMHCrvscOHFHtKYy2UDk2xRAIZtesZI1Pazg7J0+n+ir0FAdI/nhNp4p6YhLZfW3ICrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZvsECOsw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SxMMwMQZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZvsECOsw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SxMMwMQZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72ADE1400190;
	Wed, 25 Feb 2026 14:51:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Feb 2026 14:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772049078; x=1772135478; bh=WHdmEQAO1+
	YIhpSkqM5vx1kqctS71tmppmLlc5E9pyc=; b=ZvsECOswj6GjDGnnvX5KGrS+A5
	TSPnedtdB34aHBYfzjsXxc7GK2mA/qADa35aR0Zgbet14vb+3gXNj9qTaO4i5yfL
	z68ESw9zS1DAkpN6zBmQYzVbbJwI4pzKzUUnm45LxofYXxeWAqz0gWP1VjQYELBV
	yv2HB8hFTno9AGUWkMtK2pXRH3sd0AEzxxggAnJbOBXZJlj8IHuNFMbKzjgkzBai
	1wBsg6JU5ZFXrAW0N8NZmnQ4kKH05Vs6y9p6y11Sorremq/UvPO9IuccjPjgK8Lb
	AtjQ/tzEbVx/DM5slHcQkmaqdFAeIJqgFSL/VZoVVtMJCyi7fi1XccrE7s5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772049078; x=1772135478; bh=WHdmEQAO1+YIhpSkqM5vx1kqctS71tmppmL
	lc5E9pyc=; b=SxMMwMQZYQOenJezsur3xNULi/sEjPX7RHbWlU1c5bv9sIpHkHf
	iNjTYBJF10n5UMk5gdlGdZza/mRE+yGMUmVK/RAIS8CvPO6EnSFbTJG6Wu60NbDR
	9EKTOexIK3RSVZsYALZsNlUg1pfqszFbgfs4CJYZoxwG0AXPoxgmKBvzAzV3dGtG
	cWgXtil6eIYDE0JYiGBvSYxOztE3BtWwmOkgSLnsTA++7bMZJYx49icrOqguyuMr
	rd+PNQqYxRoFfbpDkHqsMADGziiCTsBxBizb5kSW5n2amdyDzOHS6sIs71d6VtU4
	JPhe2Hf/0EjTEP7TPO8sE0kd/Q7uCPGTs+A==
X-ME-Sender: <xms:tlKfacA37_647AZYGlvlLpmZMWWADltrblIlRdrGNn8aoz_mwcZVVA>
    <xme:tlKfaQxBv1vO1t0JWoDh1W05g4vn0G_qjlRf6lhTvNyJjAe5y6lbMhgxvvf6othzC
    FmMWtWAXCe3Dc5snhDV__r51TNS4d5TpenRZ-UDUyU0Ed7LVanHY-w>
X-ME-Received: <xmr:tlKfaR1WMy8KiDqZCoVv76h_OSY_e7YtzCXWIjTW40Q-LEw86FrbvXP-YQh2JwavX5OrKk1AkgKf8PKECPeJZcsXVIzGZyYohw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrvhhilhgrrdhjnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tlKfaYwmpU8ESkVcMnr_3ZAtWpKeh4-ZuI7vZLZN8DU2y1kreN7giw>
    <xmx:tlKfaQEGuII7hHtl5sEXMV7dg9JJP3P4yNvjia0JjuSxhrUMD7cZaw>
    <xmx:tlKfaTbU-LbC0xH23gi4lMTmSMgc7PQv5x5B5rqcb-_95brEiNRZzQ>
    <xmx:tlKfaaA6PWBdPB0Kx0kL2sS9gqtHPV-8DqULNUS7PzmsI6m8iRwEoQ>
    <xmx:tlKfaccqjtoGSxy5hl-4j-sRZTcmXOryY-tuhQvT5iVa_QGvd9JbxcBo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 14:51:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  ps@pks.im,
  jltobler@gmail.com,  avila.jn@gmail.com
Subject: Re: [PATCH v2 0/8] repo: refactoring leftover nits
In-Reply-To: <20260225183559.79303-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Wed, 25 Feb 2026 13:32:09 -0300")
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
	<20260225183559.79303-1-lucasseikioshiro@gmail.com>
Date: Wed, 25 Feb 2026 11:51:16 -0800
Message-ID: <xmqqms0wa9fv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hi!
>
> There are only three changes in this version:
>
> 1. Applying Eric's suggestion of instructing to name array plural if we're
>    dealing with the values as a whole
> 2. Making it clear why we should replace the NUL characters in the files
>    consumed by tes_cmp
> 3. Replacing characters in just one tr call instead of two

All look great.  The first patch has still rooms to bikeshed, but
let's take this iteration and mark it for 'next'.

Thanks.
