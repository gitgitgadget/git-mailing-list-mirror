Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF902571C7
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309651; cv=none; b=qCUzGzatfuXrcDIpx6kGASPxpbOP1WYirRO/eaegrvgILcv7F3PNRi3s97Bj3mfSbIVk+IdFkSlwFuHYtia6QPNWORnpKG00fqK+NB6VefZlUC+RZuaFV9v3vnvPcc5dn4R56qr42UI/ZyCJfDpFqJc96ilHrVoSqJLEq0fPgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309651; c=relaxed/simple;
	bh=mR+IF+gVe0fvFvQWfBDiGuSi2VrgQ3/xUMXzHfOod78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ub8M5sSdl3dGDlcBInLuViMWc/a0h3cdp6NN6f3pmIbhMGp9SH7NiKN7fKgi7Nvhp5jRDoPZhZfc/oN6+ekjk6PmmdJpGXihPuHo/6Tc3RwFj/zdzwtSgvBN5tb27E/Jv7Nzw6HY0KI2uvN4WJn1OTJsCQZb51qu++Ia/3sKZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PI+vbtt+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NcTaXqRF; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PI+vbtt+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NcTaXqRF"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA854140022F;
	Mon, 23 Mar 2026 19:47:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 23 Mar 2026 19:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774309649; x=1774396049; bh=Uq0P2xDzM5
	csKV6tXUYIKJQIisck25e9c3iWizrn+Kk=; b=PI+vbtt+MGtW1YEigijCOa6hvY
	hmpk1KrS6GD33XQ5IOwYHPWmY7Jsxg+ndUjAe2JSbyXvM9SDGGh2EFDenre8mwxI
	1ahBkHMJ0r4nC7+Sf9jA/iSNhFG4IPMBFQYNrYtFYyvr1J4vD+eYA869C1jPtCCZ
	YfPsjjY81BJSy6j4WVcYYR5H64gTLPP9Ig8Ter1WS5tI1AdUfkhW47btBygwIe63
	V5HLSKMpphy8nt6hNcz/mavWWM4rUjl4B3j3yka4ta5O1ycTPSKMUqLUBIHfw3N4
	pUUymidfdLVhc9Kmp0atuOcWr3IwSP2W5iJt9DfUQRqWpUDb3j3WpdOUscEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774309649; x=1774396049; bh=Uq0P2xDzM5csKV6tXUYIKJQIisck25e9c3i
	Wizrn+Kk=; b=NcTaXqRF392nuvTqkZw7A9mjp6TgNk4SStxdH5+3lRwhHNZatG9
	ZrVzMHcJexUaeeH2oPuoOm+wnhphshuQpA3qI9k5wmeSaEjhFtyuuxDF1p9J7y77
	EBqNbzap0/CtCPsfSE4foU+RuQBc4wx2Z/6xJREmPPVWDzdSjYGPkwURcCfHZcmB
	BSYm0S7SZVCU4B+GkXBODbNbETWSUHxHXCXg6U4myFDgisWVtJPfN3B63VNQZZ9k
	2BMzenvb6d93uchQw19MaBA5x0FRZp7F5/MqK8AJVvA4t9oQBm/lUmb2IyotwHrm
	kVH3+oUVZjLci4ATDSexLKC83bTilbaoYPA==
X-ME-Sender: <xms:EdHBaf-UgshlKKiLLLdXdj4-_Zzc3Bpp-ku0vmX65QcACk4zuemlEA>
    <xme:EdHBaayF87ykDSsbhMvj0sfDtQyKg64-_NDeodYrnlqVEBXfatif9jH1PlK87MeTH
    8CHTDFLIPOFZHN8pI65M5TSyx3ddq6zRbyYAgtjICoPHWyYVGVJ-pM>
X-ME-Received: <xmr:EdHBaTMw5TN7rKX058v2oCGpM0i7PQ92v0jt8MBYNmgnuH-N2tKcYYp17ly7iWTox1MIOF7n-eJ88445WLZDJCNtGG9s5fVqwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepudevtdekheetudeihefffeelgffhgefgveefudejlefftdeitefftdfftddu
    vefgnecuffhomhgrihhnpegvgigrmhhplhgvrdgtohhmpdgvvhhilhdqhhgrtghkvghrrd
    hnvghtpdhhrggtkhgvrhdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtph
    htthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghn
    rdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EdHBaX910B8LlwcT3jV-e0c65izDxW2SyjlhCXt4YFE_dmnE_3l-kA>
    <xmx:EdHBaY6vpHDV01LyHR-_cKrPzui9D0AFY83GnmfZnVwd9Rk-g4r24w>
    <xmx:EdHBaV5ReMcI8uEMiSnUa7FB-Hg-OAH1BOYRgb6BgoT5BCPWfG6bOQ>
    <xmx:EdHBaZppwBDO-NByTOYOhLbWaSGAApzgD8hZhYOz7mLryR7fUeI-SA>
    <xmx:EdHBaY8Ee8Z-vbTLkLY_Le8Dq8MOOcq2A2u2UHqAadx_m6WWsDVDFHBq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 19:47:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 14/16] promisor-remote: trust known remotes matching
 acceptFromServerUrl
In-Reply-To: <xmqqzf3y4bsg.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	23 Mar 2026 11:54:07 -0700")
References: <20260323080520.887550-1-christian.couder@gmail.com>
	<20260323080520.887550-15-christian.couder@gmail.com>
	<xmqqzf3y4bsg.fsf@gitster.g>
Date: Mon, 23 Mar 2026 16:47:27 -0700
Message-ID: <xmqqo6ke2jn4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Obviously.
>
>> +3. Don't use globs (`*`) in the domain name. For example
>> +   `https://cdn.example.com/*` is much safer than
>> +   `https://*.example.com/*`, because the latter matches
>> +   `https://evil-hacker.net/fake.example.com/repo`.
>
> Is there a practical use case where allowing '*' to match anything
> that contains a slash '/' is useful?
>
>> +4. Make sure to have a `/` at the end of the domain name (or the end
>> +   of specific directories). For example `https://cdn.example.com/*`
>> +   is much safer than `https://cdn.example.com*`, because the latter
>> +   matches `https://cdn.example.com.hacker.net/repo`.
>
> Ditto.  The above two points sound like excuses to keep sloppy
> asterisk matching logic.  Yes, retroactively tightening rules always
> have risk to break existing deployments, but if existing code paths
> of urlmatch do not have any good reason to allow '*' to match a
> string that contains a slash '/', perhaps there is no fallout.

I probably should caution the readers not to take the above too
literally.  Forbidding an asterisk '*' glob not to match '/'
anywhere in urlmatch will obviusly break existing deployments that
does this

    [http "https://example.com/*"]
	var = val

and expects it to catch any URL pointing into the site.

But I still do think the matcher should be more intelligent than the
current implementation to avoid pitfalls like #3 and #4 above.

Perhaps if an additional rule says that '*' after the scheme:// part
before the first '/' in the pattern, e.g.,

    https://*.example.com/
    https://*.example.com
    https://example.com*

unlike '*' that appear anywhere else, never matches a substring that
contains a slash '/' in it, it would cover plausible mistakes that
the above #3 and #4 are trying to catch, without hurting any real
world use case?



