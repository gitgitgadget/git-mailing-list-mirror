Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041E311187
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411307; cv=none; b=Cj6HVh+QxMDn+MySha/YXMG1DPrkHedIYd3WAJLAMSIb0RAmlWBQNrBkKis/ixexJuvYYn7ujTZPs/Ji4n9XHCD1lcKB8O994VolyjehZEwAaWm+iJ0lhL65wdcb3KelVbejRhFmQbzJhKEiTrpx06WdPcBgynm+HOzenxBLCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411307; c=relaxed/simple;
	bh=0IsNYe6suDgDf+usJjy4AWrhgCk8AxdHMkRUj5hAVFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HsXaq8jkmjWH+n4uEJWpY44htMvUqQuH5T2VyQRa3vZI5myxnHD+iYfsLj5iK1qrHqVlzWxMJY+sBZPk7duGOvmp8v6iQfzJ5wX1h3sq01kvC378f9ePtNc7rDz7/6w/rftzJW8W9WUT/jo2MKLAgqS+mzUvQyjq4UVEyDIed4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NJ25S1Vh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jLqZ2VEx; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NJ25S1Vh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jLqZ2VEx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E3FED1D0014C;
	Thu, 28 Aug 2025 16:01:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 28 Aug 2025 16:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756411303;
	 x=1756497703; bh=WBBlYfsL1BgLYgVEBFn4tu+MUnqntrkyHqwjp37Tosk=; b=
	NJ25S1VhZU8bnMeyesieOZ3Kj8EsIx+fvhMkPoFHb0cWA35XbJNkPj8j2ywF0R2b
	GetVlgThKedb37eVo6uIyJwOIGWGaA7lYgUL6x5n+8fV2goBHu0hqlEvtsLaIQ1q
	d6h5O+4yJxc+ccNyzKXA+6uiVcYB2URlnUhpaGJR2LhdyhxUaRfqRNTpAUgXeWaQ
	WTv8ePkIXJNX0h1o/8P9xDJ82j4XEK0hncVJrHW0iYifvjTMmlC7A4Zu6vH5QvJK
	YhspXEG7NE+ON6utBq+DgxaVrAifHp05z7JesCo+urmGGo6gZu5Xo7OfUJqulbW0
	rJQHidWINnipb8WjJa29yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756411303; x=
	1756497703; bh=WBBlYfsL1BgLYgVEBFn4tu+MUnqntrkyHqwjp37Tosk=; b=j
	LqZ2VEx79/RcvoQ7GvhnLxAO5nnXpVCgKGmkBB5PtEYr6lnwRijJKYuMZCoYgpWL
	yAFjZbf8vGY+JobbvWrTk91ZQLHtw7KDEJ7uzNmyy4e6vqg0zeeJ+eUKj5TU5cRv
	+PCj+yKQrBQaHexvErsUr9/reCIoSpv2SXeFZq8LDlkH5Ss0tY2SwPryPOcVXvJ9
	TtQzMrvrDKYSxSod4+Iwpl3v9scnfYGm0CmnHjhQHjS4e4mIelXqxlDuxyC3PBin
	OArrtYTnJfgfv0olHdSoZPmJF8LGh47vQ85/2DoktmghEkD7bibRQFHgcp1cLU2L
	OxhXFVD0Omz9eVg/miq+w==
X-ME-Sender: <xms:p7WwaLDmYzbXZcV78s36lixmikbYaSHR58OMFxtqQHsVxjESrXG-jQ>
    <xme:p7WwaNDrHdfgXzsqh0xZPcUknR6KjjpysxGpPDCSusLSn1DOsZW6tZoVpiqOz9fAB
    OnCO9SBUKILMvgTkQ>
X-ME-Received: <xmr:p7WwaNBx-8IjkIWWQ4X7JDLKbNl5EJK9vuL3yozvYE9jxaY2F1b_HXzEf26oewy_tKb8FZwGkTCGHGxoJj-F1eE38gZ94lTbDz6Antk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnohhurhgrvghllhhmsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:p7WwaIoSJm4wXPWzsh9Gt30jBD25Gu1tO6Xx8DoNvK9HkxtBcdXZww>
    <xmx:p7WwaHk6EuK2Fj816FkCPKFh2LnhZ-MuC26MVSkIIDdyRaL1ewPm7Q>
    <xmx:p7WwaIzjEM7X-EzntmCBfhDVVAypg7OKImX6tKF_EUW6lYV3ZjKbbg>
    <xmx:p7WwaP_rIQ4JWb3qmMn6gZtdi66InucIUj9Hg4QouS47ByuG8yjwpQ>
    <xmx:p7WwaD-PwhgSrBJGJD-C3EMLIgDSpscn3EVSc9lzlpFNDJA6AJD7NzZY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 16:01:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: =?utf-8?B?44OO44Km44Op?= | Flare via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?B?44OO44Km44Op?= | Flare
 <nouraellm@gmail.com>
Subject: Re: [PATCH v2] alloc: fix dangling pointer in alloc_state cleanup
In-Reply-To: <xmqqtt1rut1w.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	28 Aug 2025 12:47:55 -0700")
References: <pull.2040.git.git.1756238268790.gitgitgadget@gmail.com>
	<pull.2040.v2.git.git.1756337312918.gitgitgadget@gmail.com>
	<20250828192949.GA18641@tb-raspi4> <xmqqtt1rut1w.fsf@gitster.g>
Date: Thu, 28 Aug 2025 13:01:42 -0700
Message-ID: <xmqqo6rzusex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

>> Style nit, we tend to use the "imperative form" here in Git,
>> like this:
>>
>> - Rename allocate_alloc_state() → alloc_state_alloc().
>> - Replace ...
>> - Update ...
>
> Thanks.  We also tend to avoid bulleted list.

Perhaps it needs a bit of clarification.  

If you truly require a bulleted list to enumerate what you did in
the patch, then you may be doing too many things in a single patch.

But in this case, the changes do not even have to be broken down
into bullets.  If you change a called function, it goes without
saying that you have to adjust existing callers.  Perhaps something
like

    All callers of clear_alloc_state() immediately free what they
    cleared, so currently it does not hurt anybody that the
    alloc_state is left in an unreusable state, but it is an
    error-prone API.  Replace it with a new function that clears but
    in addition frees the structure, as well as NULLing the pointer
    that points at it and adjust existing callers.

    While at it, rename allocate_alloc_state() and name the new
    function alloc_state_free_and_null(), to follow more closely the
    function naming convention specified in the CodingGuidelines
    (namely, functions about S are named with S_ prefix and then
    verb).

should be more in line with what we usually do.

Thanks.
