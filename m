Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02E9EEBB
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335070; cv=none; b=dxtIIrdIoQ3ZQGOeKMYn/2s6Poupkg3FMVoKQz05fKjebk95fGSZRPMJJugFYMxoRCnihT2HlVFJWikD1Ip30ZBn5o8KhorH4LMRjzopguvbTPBVFQiE1kaF+6DU3iGGAg0mA3fYgp6EpWEZPp/j7SSSMh/vSM2cY/R5yXn9SPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335070; c=relaxed/simple;
	bh=JFYxlPKQDyWNgwDInOxSt4V/Gx3OVFdfnMUkmv7k0oU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cIuSNbhO3JV4ujHg7fSkcBG/7UlKkRN+t9hSyy31nG1kTR4ShEH44ssdWV3M+DqGioGZOR8dkmGVLCQOdoPBeUanrRlr0Gwev3wKZvHBhJyyM4rDxXcj6fJFxUs1YBsMD3jUh5qxkYHe6Wt7LHBssOkm6aA8ZDnATA3CDCAg8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fR+aF8zR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uOAAqmz0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fR+aF8zR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uOAAqmz0"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9E2B114026B;
	Tue, 22 Apr 2025 11:17:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 22 Apr 2025 11:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745335066; x=1745421466; bh=J4aDa95sbf
	eNgGT1DUx53B49N87cvURRyugauoOk4ts=; b=fR+aF8zR9m0wWBma9HZznjti6g
	QpKWzk+/qXQwU55QcMJpdufmRDOOLx1NAY0t+6Zk6B/YEORCUQFUXUUdHpLNsBYg
	YkqT0Joly5Epp9apwc0HGHarZ9oQ2YGSrDvn2poP268zpH1EA/lTt7wATduINlpD
	us83QvozhfZiMQdMoawlKB6VsIuoVjbsMi7xex+fxQeMTJ7sfV+AnOFmWrhzC+et
	MY0g7PrH057VH3pTvdrvYn0T5wFpi5gLpj+AE/TxYibxqJ6t2JB3s3hnkuAt+tYz
	BcGxBZ8amdaYmCSAKv9lP61yiZenwaWlyZVAyiLuTPJzJMwj7NQez4cy3f8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745335066; x=1745421466; bh=J4aDa95sbfeNgGT1DUx53B49N87cvURRyug
	auoOk4ts=; b=uOAAqmz0+7KjvVIccfrHCcWSn+u9xc9cLoOzf9DLyJdVtJV26KO
	3cB7ip6vqQewnCvFPkZIVo4IXUOChdKCcd0TBQ25szD3gKg+2QwQMWP2ovV36Sb1
	o36VF9LvRlEa/B2tYavg95escuVrXUo5XVnN1PtABQKb4Iyrf9rQOoXRDy/ndurl
	ji80PWTI7V3p/uThojhXHrxb8PMbeP7xywtRY1esfq2mJapkgqzlFh3yRA7/sOlk
	/NFI8kTWVRmAcvM+iIiFncFP0tHSchvlqJaJ02m0iZnOl+eRzvGSwQcEHZLWC8QV
	6k27/KhOoSq6f8+U7OPJ76XmNJydT6B/+lQ==
X-ME-Sender: <xms:GrMHaEaWwXnVq3E_upiD6YYqhiisjd7voPXBwUCNPEXbo2DEkF_9dw>
    <xme:GrMHaPb77UiMFZ659U96-Cp1ybkza1D0ARGvVX0KnSMHuXrfgc0r-u67SiOR_hUfL
    8QLzcFCWyFoSMAJYQ>
X-ME-Received: <xmr:GrMHaO-j228GqUAT2ykZxs3Eut2kiWDiNH8uZ3TUToX4Xn8FUAHLIL05qUE0KGkF0mIqMlnQkt5FSLQ0eMxIthDLormA0j7uWMeF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmhesgh
    gvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GrMHaOryBJ3VVBAJ7hy_QjZp1iLbrCqALNJK0E-3CqwT323AML259A>
    <xmx:GrMHaPptVWWysybAy_O_EspB2JVfpBf6NyjBntNWxXrjtQ2bg7grqQ>
    <xmx:GrMHaMQLjZWVooqbHARzJ_pjgVOwdo7K0WL5xSOKwetieeWrQ7ShjQ>
    <xmx:GrMHaPqr7aiZlLdwqyTivcxB9LMqaJfrtQHZGwc3xraEynoeG5k81Q>
    <xmx:GrMHaJ2INi9yaOyNng7hCbryVo-SauFF6DVaDk0f2_r9GUlGaZiUHf5->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 11:17:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eli Schwartz <eschwartz@gentoo.org>,  git@vger.kernel.org,  Sam James
 <sam@gentoo.org>
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
In-Reply-To: <aAdFysi-n_5Aa4Au@pks.im> (Patrick Steinhardt's message of "Tue,
	22 Apr 2025 09:31:22 +0200")
References: <20250421175247.240971-1-eschwartz@gentoo.org>
	<aAdFysi-n_5Aa4Au@pks.im>
Date: Tue, 22 Apr 2025 08:17:45 -0700
Message-ID: <xmqq4iyg5ip2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yeah, this is somewhat unfortunate indeed. I think in the long term we
> might want to unify our approach so that we consistently use e.g.
> `HAVE_SOME_FUNCTION` or `NO_SOME_FUNCTION`.

Yes and no, because the intention, at least in the original form,
was that HAVE_FOO is not necessarily !NO_FOO.  You cannot claim to
HAVE_FOO on a system that does not have FOO, and expect the result
to build and/or function, but you should be able to build with
NO_FOO on a system that supports FOO and use an alternative
implementation that does not rely on system-supplied FOO.  NO_MMAP
and NO_REGEX comes to mind (I often have to build NO_REGEX locally
when doing "make sparse", for example, to avoid warnings triggering
on system headers, for example).

I suspect that majority of these feature symbols do not fall into
the same category as NO_REGEX, i.e. the user/builder may choose to
decline using the system-supplied one.  So for them this is a total
overkill, but conceptually, building with feature FOO enabled should
be done iff (HAVE_FOO && !NO_FOO).

I do not mind changing the stance Makefile takes on HAVE/!NO
division, and see us declare that from now on, even when
auto-detection flips HAVE_FOO on, the way for the builder to decline
use of FOO is to flip HAVE_FOO off manually.  I and others may need
to tweak some scripts and figure out to pass !HAVE_REGEX instead of
NO_REGEX when that happens, but that is a one-time cost to make
things more consistent.
